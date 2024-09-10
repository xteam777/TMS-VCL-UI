{***************************************************************************}
{ TAdvOpenGLControl component                                               }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 2013                                               }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of the author.                                      }
{***************************************************************************}

unit AdvOpenGLControl;

interface

uses
  Windows, Messages, Graphics, Controls, AdvChartGdip, Forms, ExtCtrls,
  Types, SysUtils, Classes, AdvOpenGLx, AdvOpenGLUtil, OpenGL;

const
  MaxBufferWidth = 2560;
  MaxBufferHeight = 2560;

type
  TTextureOptions = set of (toMipmaps, toRGBA, toCompress, toTransparent);
  TRCOptions = set of (roDepth, roStencil, roAccum, roAlpha);

  TAdvOpenGLControl = class(TCustomControl)
  private
    FCurrentScale: single;
    FTextures: array [0 .. 2000] of GLUINT;
    FTexturesCount: integer;
    FBufferGraphics: TGPGraphics;
    FRC: THandle;
    FOnRender: TNotifyEvent;
    FOnRender2D: TNotifyEvent;
    FOptions: TRCOptions;
    FFDC: THandle;
    FOldDIBS,FDIBS: HBitmap;
    FZBufferBitmap: TBitmap;
    FAntiAlias: Boolean;

    procedure SetFDC(const Value: THandle);
    property FDC: THandle read FFDC write SetFDC;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
  protected
    FBufferBitmap: TBitmap;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DoResize(AClientWidth: integer = -1; AClientHeight: integer = -1);
    procedure DoRecalculate; virtual;
    procedure Resize; override;
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    procedure DoRender(bufferBitmap: TBitmap; AClientWidth: integer; AClientHeight: integer);
    procedure RenderControl; virtual;
    procedure RenderControl2D(GPGraphics: TGPGraphics); virtual;
    property RC: THandle read FRC;
    function CreateRC(dc: HDC; opt: TRCOptions): THandle;
    procedure MakeCurrent(dc, RC: THandle);
    procedure DestroyRC(RC: THandle);
  public
    TopRenderArea: integer;
    FAWidth, FAHeight: integer;
    FUpdateCnt: integer;
    FRenderWidth, FRenderHeight: integer;
    property CurrentScale: Single read FCurrentScale write FCurrentScale;
    procedure BeginUpdate; virtual;
    procedure EndUpdate; virtual;
    function Scale: single;
    procedure AddTexture(textureid: GLUINT);
    procedure RemoveTextures;
    procedure Paint; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure InitGL;
    procedure DoneGL;
    procedure ScreenProjection;
    procedure PerspectiveProjection(fov, znear, zfar: double);
    function GetPreview(Width: integer = MaxBufferWidth;
      Height: integer = MaxBufferHeight): TBitmap;
    property Options: TRCOptions read FOptions write FOptions;
    property OnRender: TNotifyEvent read FOnRender write FOnRender;
    property OnRender2D: TNotifyEvent read FOnRender2D write FOnRender2D;
    property AntiAlias: Boolean read FAntiAlias write FAntiAlias default True;
  published
    property Align;
    property Anchors;
    property Constraints;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
  end;

  TBitmapFont = class
  private
    FFont: TFont;
    FListBase: Cardinal;
    FCount: integer;
    FCanvas: TCanvas;
  public
    constructor Create(Canvas: TCanvas);
    destructor Destroy; override;
    procedure WriteText(X, Y: single; const t: string;
      Align: TAlignment = taLeftJustify);
  end;

var
  HighQuality: boolean = true;

procedure MygluProject(objx, objy, objz: TGLdouble; modelMatrix: TMatrix4d;
  projMatrix: TMatrix4d; viewport: TVector4i; var winx, winy, winz: GLdouble);

procedure HighQualityScene;

procedure TexImage2D(width, height, Format: integer; pData: pointer;
  opt: TTextureOptions = []);

procedure BuildTexture(b: TBitmap; var texture: Cardinal;
  opt: TTextureOptions = []);

function RoundUpToPowerOf2(v: integer): integer;
function RoundDownToPowerOf2(v: integer): integer;
function IsPowerOf2(v: integer): boolean;

implementation

var
  max_texture_max_anistropic: single = 2.0;

procedure Error(const m: string);
begin
  raise Exception.Create(m);
end;


function TAdvOpenGLControl.CreateRC(dc: HDC; opt: TRCOptions): THandle;
var
  PFDescriptor: TPixelFormatDescriptor;
  PixelFormat: integer;
  anhdc:THandle;
begin
  FillChar(PFDescriptor, SizeOf(PFDescriptor), 0);

  with PFDescriptor do
  begin
    nSize := SizeOf(PFDescriptor);
    nVersion := 1;
    dwFlags := PFD_SUPPORT_OPENGL or PFD_SUPPORT_OPENGL or
      PFD_GENERIC_ACCELERATED or PFD_SUPPORT_GDI or PFD_Draw_TO_BITMAP;
    // PFD_DRAW_TO_WINDOW or PFD_DOUBLEBUFFER;
    iPixelType := PFD_TYPE_RGBA;
    cColorBits := GetDeviceCaps(dc, BITSPIXEL) * GetDeviceCaps(dc, PLANES);
    anhdc:=GetDC(GetDesktopWindow);
    cDepthBits := GetDeviceCaps(anhdc, BITSPIXEL);
    ReleaseDc(GetDesktopWindow,anhdc);

    PFDescriptor.cRedShift := 0;
    PFDescriptor.cRedBits := 0;
    PFDescriptor.cGreenShift := 0;
    PFDescriptor.cGreenBits := 0;
    PFDescriptor.cBlueBits := 0;
    PFDescriptor.cBlueShift := 0;
    PFDescriptor.cAlphaBits := 0;
    PFDescriptor.cAlphaShift := 0;
    PFDescriptor.cAlphaBits := 0;

    PFDescriptor.cStencilBits := 0;
    PFDescriptor.dwLayerMask := 0;
    PFDescriptor.dwVisibleMask := 0;
    PFDescriptor.dwDamageMask := 0;
    PFDescriptor.cAuxBuffers := 0;
    PFDescriptor.bReserved := 0;
    { if roDepth in opt then cDepthBits := 24;
      if roStencil in opt then cStencilBits := 8;
      if roAccum in opt then cAccumBits := 64; }
    iLayerType := PFD_MAIN_PLANE;
  end;

  PixelFormat := ChoosePixelFormat(dc, @PFDescriptor);

  {$WARNINGS OFF}
  Win32Check(PixelFormat <> 0);
  Win32Check(SetPixelFormat(dc, PixelFormat, @PFDescriptor));

  { // check the properties just set
    DescribePixelFormat(DC, PixelFormat, SizeOf(PFDescriptor), PFDescriptor);
    // }

  Result := wglCreateContext(dc);

  Win32Check(Result <> 0);

  {$WARNINGS ON}

  wglMakeCurrent(dc, Result);

  LoadGLExtensions;
end;

procedure TAdvOpenGLControl.MakeCurrent(DC, RC: THandle);
begin
  wglMakeCurrent(DC, RC);
end;

procedure TAdvOpenGLControl.DestroyRC(RC: THandle);
begin
  if FRC = 0 then
    Exit;
  wglMakeCurrent(0, 0);
  wglDeleteContext(FRC);
  FRC := 0;
end;

procedure HighQualityScene;
begin
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);
  // if GL_EXT_separate_specular_color then
  // glLightModeli(GL_LIGHT_MODEL_COLOR_CONTROL_EXT, GL_SEPARATE_SPECULAR_COLOR);
  if GL_EXT_texture_filter_anisotropic then
    glGetFloatv(GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT, @max_texture_max_anistropic);
end;

function RoundUpToPowerOf2(v: integer): integer;
begin
  Result := 1;
  while v > Result do
    Result := Result shl 1;
end;

function RoundDownToPowerOf2(v: integer): integer;
begin
  Result := 1;
  while v > Result do
    Result := Result shl 1;
  if v <> Result then
    Result := Result shr 1;
end;

function IsPowerOf2(v: integer): boolean;
begin
  Result := RoundUpToPowerOf2(v) = v;
end;

procedure __gluMultMatrixVecf(matrix: TMatrix4d; ain: array of GLfloat;
  var aout: array of GLfloat);
var
  i: integer;
begin
  for i := 0 to 4 do
  begin
    aout[i] := ain[0] * matrix[0][i] + ain[1] * matrix[1][i] + ain[2] *
      matrix[2][i] + ain[3] * matrix[3][i];
  end;
end;

procedure MygluProject(objx, objy, objz: TGLdouble; modelMatrix: TMatrix4d;
  projMatrix: TMatrix4d; viewport: TVector4i; var winx, winy, winz: GLdouble);
var
  ain: array [0 .. 4] of single;
  aout: array [0 .. 4] of single;
begin
  ain[0] := objx;
  ain[1] := objy;
  ain[2] := objz;
  ain[3] := 1.0;
  __gluMultMatrixVecf(modelMatrix, ain, aout);
  __gluMultMatrixVecf(projMatrix, aout, ain);
  if (ain[3] = 0.0) then
  begin
    // result:=gl_false;
    Exit;
  end;
  ain[0] := ain[0] / ain[3];
  ain[1] := ain[1] / ain[3];
  ain[2] := ain[2] / ain[3];
  ain[0] := ain[0] * 0.5 + 0.5;
  ain[1] := ain[1] * 0.5 + 0.5;
  ain[2] := ain[2] * 0.5 + 0.5;

  ain[0] := ain[0] * viewport[2] + viewport[0];
  ain[1] := ain[1] * viewport[3] + viewport[1];

  winx := ain[0];
  winy := ain[1];
  winz := ain[2];
  // return(GL_TRUE);
end;

procedure TexImage2D(width, height, Format: integer; pData: pointer;
  opt: TTextureOptions);
var
  iformat: Cardinal;
  mem: pointer;
  newWidth, newHeight, stride: integer;
begin
  if toMipmaps in opt then
  begin
    if HighQuality then
    begin
      glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
      glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER,
        GL_LINEAR_MIPMAP_LINEAR);
      if GL_EXT_texture_filter_anisotropic then
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAX_ANISOTROPY_EXT,
          max_texture_max_anistropic);
    end
    else
    begin
      glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
      glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER,
        GL_NEAREST_MIPMAP_NEAREST);
    end;
  end
  else
  begin
    if HighQuality then
    begin
      glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
      glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    end
    else
    begin
      glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
      glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    end;
  end;
  { if GL_EXT_texture_edge_clamp then
    begin
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE_EXT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE_EXT);
    end;
  }
  if GL_ARB_texture_compression and (toCompress in opt) then
  begin
    if (toRGBA in opt) and ((Format = GL_RGBA) or (Format = GL_BGRA_EXT_2) or
      (Format = 4)) then
      iformat := GL_COMPRESSED_RGBA_ARB
    else
      iformat := GL_COMPRESSED_RGB_ARB;
  end
  else
  begin
    if (toRGBA in opt) and ((Format = GL_RGBA) or (Format = GL_BGRA_EXT_2) or
      (Format = 4)) then
      iformat := GL_RGBA
    else
      iformat := GL_RGB;
  end;

  if toMipmaps in opt then
    gluBuild2DMipmaps(GL_TEXTURE_2D, iformat, width, height, Format,
      GL_UNSIGNED_BYTE, pData)
  else if IsPowerOf2(width) and IsPowerOf2(height) then
    glTexImage2D(GL_TEXTURE_2D, 0, iformat, width, height, 0, Format,
      GL_UNSIGNED_BYTE, pData)
  else
  begin
    newWidth := RoundUpToPowerOf2(width);
    newHeight := RoundUpToPowerOf2(height);
    case Format of
      GL_RGBA, GL_BGRA_EXT_2, 4:
        stride := 4;
    else
      stride := 3;
    end;
    GetMem(mem, newWidth * newHeight * stride);
    gluScaleImage(Format, width, height, GL_UNSIGNED_BYTE, pData, newWidth,
      newHeight, GL_UNSIGNED_BYTE, mem);
    glTexImage2D(GL_TEXTURE_2D, 0, iformat, newWidth, newHeight, 0, Format,
      GL_UNSIGNED_BYTE, mem);
    FreeMem(mem);
  end;
end;

procedure BuildTexture(b: TBitmap; var texture: Cardinal; opt: TTextureOptions);
var
  color: TColor;
  f: Cardinal;
  total, i: Integer;
  a: PBytearray;
  tocancel: pbytearray;
begin
  case b.PixelFormat of
    pf32bit:
      f := GL_BGRA_EXT_2;
    pf24bit:
      f := GL_BGR_EXT_2;
  else
    b.PixelFormat := pf24bit;
    f := GL_BGR_EXT_2;
  end;
  if texture = 0 then
    glGenTextures(1, @texture);
  glBindTexture(GL_TEXTURE_2D, texture);
  a := b.Scanline[b.height - 1];
  total := b.width * b.height;
  color := clFuchsia;
  tocancel := @color;
  for i := 0 to total do
  begin
    if (a[i * 4] = tocancel[2]) and (a[(i * 4) + 1] = tocancel[1]) and
      (a[(i * 4) + 2] = tocancel[0]) then
      a[(i * 4) + 3] := 0;
  end;

  TexImage2D(b.width, b.height, f, b.Scanline[b.height - 1], opt);
end;

{ TAdvOpenGLControl }

function TAdvOpenGLControl.Scale: single;
begin
//  Result := FCurrentScale;
  Result := 1;
end;

procedure TAdvOpenGLControl.BeginUpdate;
begin
   inc(FUpdateCnt);
end;

procedure TAdvOpenGLControl.EndUpdate;
begin
  Dec(FUpdateCnt);
  if FUpdateCnt = 0 then
    Refresh;
end;

procedure TAdvOpenGLControl.AddTexture(textureid: GLUINT);
begin
  FTextures[FTexturesCount] := textureid;
  inc(FTexturesCount);
end;

procedure TAdvOpenGLControl.RemoveTextures;
begin
  glDeleteTextures(FTexturesCount, @FTextures);
  FTexturesCount := 0;
end;

procedure TAdvOpenGLControl.RenderControl;
begin
  //
end;

procedure TAdvOpenGLControl.RenderControl2D;
begin
  //
end;

constructor TAdvOpenGLControl.Create(AOwner: TComponent);
begin
  inherited;

  ControlStyle := ControlStyle + [csOpaque];

  FAntiAlias := True;

  Width := 400;
  Height := 300;
  FTexturesCount := 0;
  FZBufferBitmap := TBitmap.Create;
  FZBufferBitmap.Width := Screen.DesktopWidth;
  FZBufferBitmap.Height := Screen.DesktopHeight;
end;

destructor TAdvOpenGLControl.Destroy;
begin
  FreeAndNil(FZBufferBitmap);
  DoneGL;
  inherited;
end;

procedure TAdvOpenGLControl.DestroyWnd;
begin
  DoneGL;
  inherited;
end;


function TAdvOpenGLControl.GetPreview(width: integer = MaxBufferWidth;
  height: integer = MaxBufferHeight): TBitmap;
begin
  Result := TBitmap.Create;
end;

procedure TAdvOpenGLControl.DoneGL;
begin
  DeleteObject(FDIBS);
  DeleteDC(FDC);

  DestroyRC(FRC);
  FRC := 0;
  FDC := 0;
end;

procedure TAdvOpenGLControl.DoRecalculate;
begin
//
end;

procedure TAdvOpenGLControl.DoRender(bufferBitmap: TBitmap; AClientWidth: integer;
  AClientHeight: integer);
begin
  if (Assigned(bufferBitmap) or (FUpdateCnt = 0)) then
  begin
    if Assigned(bufferBitmap) then
    begin
      FBufferBitmap := bufferBitmap;
      FCurrentScale := (bufferBitmap.width / 400) *
        (bufferBitmap.height / bufferBitmap.width);
      FRenderWidth := bufferBitmap.width;
      FRenderHeight := bufferBitmap.height;
    end
    else
    begin
      DoResize();
      FBufferBitmap := FZBufferBitmap;
      FCurrentScale := (AClientWidth / 400) * (AClientHeight / AClientWidth);
      FRenderWidth := AClientWidth;
      FRenderHeight := ClientHeight;
    end;

//    MakeCurrent(FDC, FRC);

    RenderControl;

    glFlush();

    // Stretchdraw OpenGL scene with antialias on mem bitmap
    SetStretchBltMode(FBufferBitmap.Canvas.Handle, HALFTONE);
    StretchBlt(FBufferBitmap.Canvas.Handle, 0, 0, AClientWidth, AClientHeight,
      FDC, 0, MaxBufferHeight - FAHeight, FAWidth, FAHeight, srccopy);

    // Draw with GDI+ on top of OpenGL scene
    FBufferGraphics := TGPGraphics.Create(FBufferBitmap.Canvas.Handle);
    try
      FBufferGraphics.SetSmoothingMode(SmoothingModeAntiAlias);
      FBufferGraphics.SetTextRenderingHint(TextRenderingHintAntiAlias);
      RenderControl2D(FBufferGraphics);
    finally
      FBufferGraphics.Free;
    end;

    if not Assigned(bufferBitmap) then
      bitblt(Canvas.Handle, 0, 0, AClientWidth, AClientHeight,
        FBufferBitmap.Canvas.Handle, 0, 0, srccopy);

    RemoveTextures;
  end
end;

procedure TAdvOpenGLControl.InitGL;
var
  BitmapInfo: tagBITMAPINFO;
  pbits: pointer;
begin
  FDC := CreateCompatibleDC(0);
  FillChar(BitmapInfo, SizeOf(tagBITMAPINFOHEADER), 0);
  BitmapInfo.bmiheader.biSize := SizeOf(tagBITMAPINFOHEADER);
  BitmapInfo.bmiheader.biWidth := MaxBufferWidth;
  BitmapInfo.bmiheader.biHeight := MaxBufferHeight;
  BitmapInfo.bmiheader.biPlanes := 1;
  BitmapInfo.bmiheader.biBitCount := GetDeviceCaps(fdc, BITSPIXEL);
  BitmapInfo.bmiheader.biCompression := BI_RGB;

  FDIBS := CreateDIBSection(FDC, BitmapInfo, DIB_RGB_COLORS, pbits, 0, 0);
  FOldDIBS := SelectObject(FDC, FDIBS);

  FRC := CreateRC(FDC, FOptions);

  Resize();

  HighQualityScene;
end;

procedure TAdvOpenGLControl.SetFDC(const Value: THandle);
begin
  FFDC := value;
end;

procedure TAdvOpenGLControl.Paint;
begin
  DoRender(nil, Width, Height);
end;

procedure TAdvOpenGLControl.PerspectiveProjection(fov, znear, zfar: double);
begin
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity;
  gluPerspective(fov, FAWidth / FAHeight, znear, zfar);
end;

procedure TAdvOpenGLControl.ScreenProjection;
var
  ar, w, aw, ah: Single;
begin
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity;

  aw := Width;
  ah := Height;

  ar := aw / ah;
  w := ah / 2;
  glOrtho(-w * ar, w * ar, -w, w, -ah, ah);
end;

procedure TAdvOpenGLControl.DoResize(AClientWidth: integer = -1;
  AClientHeight: integer = -1);
var
  awidth, aheight: integer;
begin
  if not AntiAlias then
  begin
    FAHeight := Height;
    FAWidth := Width;
    DoRecalculate;

    MakeCurrent(FDC, FRC);
    glViewport(0, 0, fawidth, faheight);
  end
  else
  begin
    if Assigned(Parent) then
    begin;
      if (AClientWidth >= AClientHeight) then
      begin
        awidth := ClientWidth * 4;
        if awidth > MaxBufferWidth then
          awidth := MaxBufferWidth;
        aheight := ROUND(awidth * (AClientHeight / AClientWidth));
      end
      else
      begin
        aheight := AClientWidth * 4;
        if aheight > MaxBufferHeight then
          aheight := MaxBufferHeight;
        awidth := ROUND(aheight * (AClientWidth / AClientHeight));
      end;

      FAHeight := aheight;
      FAWidth := awidth;
      DoRecalculate;

      MakeCurrent(FDC, FRC);
      glViewport(0, 0, awidth, aheight);
    end;
  end;
end;

procedure TAdvOpenGLControl.Resize;
begin
  if Assigned(Parent) then
    DoResize(Width, Height);

  inherited;
end;


procedure TAdvOpenGLControl.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
  begin
    Style := Style or WS_CLIPCHILDREN or WS_CLIPSIBLINGS;
    WindowClass.Style := CS_VREDRAW or CS_HREDRAW or CS_OWNDC or CS_DBLCLKS;
  end;
end;

procedure TAdvOpenGLControl.CreateWnd;
begin
  inherited;
  InitGL;
end;

procedure TAdvOpenGLControl.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  Message.Result := 1;
end;

{ TBitmapFont }

constructor TBitmapFont.Create(Canvas: TCanvas);
begin
  FCanvas := Canvas;
  FFont := TFont.Create;
  FFont.Assign(Canvas.Font);
  FCount := 256;
  FListBase := glGenLists(FCount);
  wglUseFontBitmaps(Canvas.Handle, 0, FCount, FListBase);
end;

destructor TBitmapFont.Destroy;
begin
  FFont.Free;
  glDeleteLists(FListBase, FCount);
  inherited;
end;

procedure TBitmapFont.WriteText(X, Y: single; const t: string;
  Align: TAlignment);
begin
  glPushAttrib(GL_LIST_BIT);
  glListBase(FListBase);
  if Align = taCenter then
  begin
    FCanvas.Font := FFont;
    X := X - FCanvas.TextWidth(t) / 2;
  end
  else if Align = taRightJustify then
  begin
    FCanvas.Font := FFont;
    X := X - FCanvas.TextWidth(t);
  end;
  glRasterPos2f(X, Y);
  glCallLists(Length(t), GL_BYTE, @t[1]);
  glPopAttrib;
end;


end.
