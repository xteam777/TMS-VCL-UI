{********************************************************************}
{                                                                    }
{ written by TMS Software                                            }
{            copyright (c) 2017 - 2021                               }
{            Email : info@tmssoftware.com                            }
{            Web : http://www.tmssoftware.com                        }
{                                                                    }
{ The source code is given as is. The author is not responsible      }
{ for any possible damage done due to the use of this code.          }
{ The complete source code remains property of the author and may    }
{ not be distributed, published, given or sold in any form as such.  }
{ No parts of the source code can be included in any other component }
{ or application without written authorization of the author.        }
{********************************************************************}

unit AdvChartGraphics.Win;

{$I TMSDEFS.inc}

interface

{$IFDEF MSWINDOWS}

uses
  Classes, Windows, ActiveX, AdvChartGDIPlusApi, AdvChartGraphicsTypes,
  {%H-}Types, AdvChartGraphics, Graphics, AdvChartUtils, AdvChartTypes
  {$IFNDEF LCLLIB}
  {$HINTS OFF}
  {$IF COMPILERVERSION > 22}
  ,UITypes
  {$IFEND}
  {$HINTS ON}
  {$ENDIF}
  ,AdvChartGDIPlusClasses
  ;
{$ENDIF}

{$IFNDEF LCLLIB}
const
  FPC_FULLVERSION = 0;
{$ENDIF}

{$IFDEF MSWINDOWS}
type
  TAdvChartGraphicsContextWin = class(TAdvChartGraphicsContext)
  private
    FShowAcceleratorChar: Boolean;
    FTextMatrix: TGPMatrix;
    FSmoothingMode: SmoothingMode;
    FSaveGP: Cardinal;
    FScale: Single;
    FMovePoint: TPointF;
    FNeedsRendering: Boolean;
    FFont: TAdvChartGraphicsFont;
    FFill: TAdvChartGraphicsFill;
    FStroke: TAdvChartGraphicsStroke;
    FGPFont: TGPFont;
    FContextSize: TSizeF;
    FGPStringFormat: TGPStringFormat;
    FGPBrush: TGPBrush;
    FGPPen: TGPPen;
    FGPGraphics: TGPGraphics;
    FGPBitmap: TGPBitmap;
    FBitmap: TBitmap;
    {$IFDEF FMXLIB}
    FMapping: Boolean;
    FBitmapData: TBitmapData;
    {$ENDIF}
  protected
    function GetNativeCanvas: Pointer; override;
    procedure DestroyResources;
    procedure ApplyFill(APath: TGPGraphicsPath);
    procedure FontChanged(Sender: TObject);
    procedure FillChanged(Sender: TObject);
    procedure StrokeChanged(Sender: TObject);
    procedure SetSmoothingMode(ASmoothingMode: SmoothingMode);
    procedure RestoreSmoothingMode;
  public
    constructor Create(const AGraphics: TAdvChartGraphics); override;
    destructor Destroy; override;
    function GetFillColor: TAdvChartGraphicsColor; override;
    function CalculateText(AText: string; ARect: TRectF; AWordWrapping: Boolean): TRectF; override;
    function SetTextAngle(ARect: TRectF; {%H-}AAngle: Single): TRectF; override;
    function CreatePath: Pointer; override;
    function GetMatrix: TAdvChartGraphicsMatrix; override;
    procedure Render; override;
    procedure PathOpen(APath: Pointer); override;
    procedure PathMoveTo({%H-}APath: Pointer; APoint: TPointF); override;
    procedure PathLineTo(APath: Pointer; APoint: TPointF); override;
    procedure PathClose(APath: Pointer); override;
    procedure ResetClip; override;
    procedure ResetTransform; override;
    procedure SetScale(AScale: Single); override;
    procedure ScaleTransform(AX, AY: Single); override;
    procedure RotateTransform(AAngle: Single); override;
    procedure TranslateTransform(AX, AY: Single); override;
    procedure SetTextQuality({%H-}ATextQuality: TAdvChartGraphicsTextQuality); override;
    procedure SetAntiAliasing(AAntiAliasing: Boolean); override;
    procedure SetShowAcceleratorChar({%H-}AShowAcceleratorChar: Boolean); override;
    procedure SetSize(AWidth, AHeight: Single); override;
    procedure ResetTextAngle({%H-}AAngle: Single); override;
    procedure SetMatrix(AMatrix: TAdvChartGraphicsMatrix); override;
    procedure BeginScene; override;
    procedure EndScene; override;
    procedure BeginPrinting; override;
    procedure EndPrinting; override;
    procedure StartSpecialPen; override;
    procedure StopSpecialPen; override;
    procedure RestoreState(AState: TAdvChartGraphicsSaveState); override;
    procedure SaveState({%H-}AState: TAdvChartGraphicsSaveState); override;
    procedure SetFontSize(ASize: Integer); override;
    procedure SetFontColor(AColor: TAdvChartGraphicsColor); override;
    procedure SetFontName(AName: string); override;
    procedure SetFont(AFont: TAdvChartGraphicsFont); override;
    procedure SetFontStyles(AStyle: TFontStyles); override;
    procedure SetFill(AFill: TAdvChartGraphicsFill); override;
    procedure SetFillKind(AKind: TAdvChartGraphicsFillKind); override;
    procedure SetFillColor(AColor: TAdvChartGraphicsColor); override;
    procedure SetStroke(AStroke: TAdvChartGraphicsStroke); override;
    procedure SetStrokeKind(AKind: TAdvChartGraphicsStrokeKind); override;
    procedure SetStrokeColor(AColor: TAdvChartGraphicsColor); override;
    procedure SetStrokeWidth(AWidth: Single); override;
    procedure DrawLine({%H-}AStroke: TAdvChartGraphicsStroke; AFromPoint: TPointF; AToPoint: TPointF; {%H-}AModifyPointModeFrom: TAdvChartGraphicsModifyPointMode = gcpmRightDown; {%H-}AModifyPointModeTo: TAdvChartGraphicsModifyPointMode = gcpmRightDown); override;
    procedure DrawPolygon({%H-}AStroke: TAdvChartGraphicsStroke; APolygon: TAdvChartGraphicsPathPolygon); override;
    procedure FillPolygon({%H-}AFill: TAdvChartGraphicsFill; APolygon: TAdvChartGraphicsPathPolygon); override;
    procedure DrawPolyline({%H-}AStroke: TAdvChartGraphicsStroke; APolyline: TAdvChartGraphicsPathPolygon); override;
    procedure FillPolyline({%H-}AFill: TAdvChartGraphicsFill; APolyline: TAdvChartGraphicsPathPolygon); override;
    procedure FillArc({%H-}AFill: TAdvChartGraphicsFill; {%H-}ACenter, {%H-}ARadius: TPointF; {%H-}AStartAngle, {%H-}ASweepAngle: Single); override;
    procedure DrawArc({%H-}AStroke: TAdvChartGraphicsStroke; ACenter, ARadius: TPointF; AStartAngle, ASweepAngle: Single); override;
    procedure FillRect({%H-}AFill: TAdvChartGraphicsFill; ARect: TRectF; {%H-}AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll); override;
    procedure DrawRect({%H-}AStroke: TAdvChartGraphicsStroke; ARect: TRectF; ASides: TAdvChartGraphicsSides; {%H-}AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll); override;
    procedure FillRoundRect({%H-}AFill: TAdvChartGraphicsFill; ARect: TRectF; ARounding: Single; ACorners: TAdvChartGraphicsCorners; {%H-}AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll); override;
    procedure DrawRoundRect({%H-}AStroke: TAdvChartGraphicsStroke; ARect: TRectF; ARounding: Single; ACorners: TAdvChartGraphicsCorners; {%H-}AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll); override;
    procedure FillEllipse({%H-}AFill: TAdvChartGraphicsFill; ARect: TRectF; {%H-}AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll); override;
    procedure DrawEllipse({%H-}AStroke: TAdvChartGraphicsStroke; ARect: TRectF; {%H-}AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll); override;
    procedure DrawBitmap(ABitmap: TAdvChartDrawBitmap; {%H-}ASrcRect, ADstRect: TRectF; {%H-}AOpacity: Single); override;
    procedure ClipRect(ARect: TRectF); override;
    procedure ClipPath({%H-}APath: TAdvChartGraphicsPath); override;
    procedure DrawFocusPath({%H-}AStroke: TAdvChartGraphicsStroke; {%H-}APath: TAdvChartGraphicsPath; {%H-}AColor: TAdvChartGraphicsColor); override;
    procedure DrawFocusRectangle({%H-}AStroke: TAdvChartGraphicsStroke; ARect: TRectF; AColor: TAdvChartGraphicsColor; {%H-}AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll); override;
    procedure DrawText(AText: string; ARect: TRectF; AWordWrapping: Boolean; AHorizontalAlign, AVerticalAlign: TAdvChartGraphicsTextAlign; ATrimming: TAdvChartGraphicsTextTrimming; {%H-}AAngle: Single); override;
    procedure DrawPath({%H-}AStroke: TAdvChartGraphicsStroke; APath: TAdvChartGraphicsPath; APathMode: TAdvChartGraphicsPathDrawMode = pdmPolygon); override;
    procedure FillPath({%H-}AFill: TAdvChartGraphicsFill; APath: TAdvChartGraphicsPath; APathMode: TAdvChartGraphicsPathDrawMode = pdmPolygon); override;
  end;

function GetNativeContextClass: TAdvChartGraphicsContextClass;

{$ENDIF}

implementation

{$IFDEF MSWINDOWS}

uses
  SysUtils;

function GetNativeContextClass: TAdvChartGraphicsContextClass;
begin
  Result := TAdvChartGraphicsContextWin;
end;

function ConvertToGDIPColor(AColor: TAdvChartGraphicsColor; AOpacity: Single): Cardinal;
begin
  Result := MakeColor(Round(AOpacity * 255), TAdvChartGraphics.GetColorRed(AColor), TAdvChartGraphics.GetColorGreen(AColor), TAdvChartGraphics.GetColorBlue(AColor));
end;

function CreateGDIPFontFill(AFont: TAdvChartGraphicsFont): TGPBrush;
begin
  Result := TGPSolidBrush.Create(ConvertToGDIPColor(AFont.Color, 1));
end;

function CreateGDIPFont(AFont: TAdvChartGraphicsFont): TGPFont;
var
  style: integer;
  fn: string;
  sz: Single;
begin
  fn := AFont.Name;
  if (fn = '') or (UpperCase(fn) = 'DEFAULT') then
    fn := 'Arial';

  sz := AFont.Size;
  if sz = 0 then
    sz := 8;

  style := FontStyleRegular;
  if TFontStyle.fsBold in AFont.Style then
    style := style + FontStyleBold;
  if TFontStyle.fsItalic in AFont.Style then
    style := style + FontStyleItalic;
  if TFontStyle.fsUnderline in AFont.Style then
    style := style + FontStyleUnderline;
  if TFontStyle.fsStrikeOut in AFont.Style then
    style := style + FontStyleStrikeout;

  {$IFDEF FMXLIB}
  Result := TGPFont.Create(PChar(fn), sz, style, UnitPixel);
  {$ENDIF}
  {$IFDEF CMNLIB}
  Result := TGPFont.Create(PChar(fn), sz, style, UnitPoint);
  {$ENDIF}
end;

function CreateGDIPPen(AStroke: TAdvChartGraphicsStroke): TGPPen;
begin
  Result := TGPPen.Create(ConvertToGDIPColor(AStroke.Color, AStroke.Opacity), AStroke.Width);
  case AStroke.Kind of
    gskSolid: Result.SetDashStyle(DashStyleSolid);
    gskDash: Result.SetDashStyle(DashStyleDash);
    gskDot: Result.SetDashStyle(DashStyleDot);
    gskDashDot: Result.SetDashStyle(DashStyleDashDot);
    gskDashDotDot: Result.SetDashStyle(DashStyleDashDotDot);
  end;

  Result.SetLineCap(LineCapFlat, LineCapFlat, DashCapFlat);
  Result.SetLineJoin(LineJoinMiterClipped);
  Result.SetMiterLimit(4);
end;

function CreateGPStringFormat(AHAlign: TAdvChartGraphicsTextAlign; AVAlign: TAdvChartGraphicsTextAlign; AWrap: Boolean; ATrimming: TAdvChartGraphicsTextTrimming; AShowAcceleratorChar: Boolean): TGPStringFormat;
var
  flags: integer;
begin
  Result := TGPStringFormat.Create;
  case AHAlign of
    gtaLeading:
      Result.SetAlignment(StringAlignmentNear);
    gtaTrailing:
      Result.SetAlignment(StringAlignmentFar);
    gtaCenter:
      Result.SetAlignment(StringAlignmentCenter);
  end;
  case AValign of
    gtaLeading:
      Result.SetLineAlignment(StringAlignmentNear);
    gtaTrailing:
      Result.SetLineAlignment(StringAlignmentFar);
    gtaCenter:
      Result.SetLineAlignment(StringAlignmentCenter);
  end;

  flags := StringFormatFlagsNoClip;
  if not AWrap then
    flags := flags or StringFormatFlagsNoWrap;

  Result.SetFormatFlags(flags);

  case ATrimming of
    gttCharacter: Result.SetTrimming(StringTrimmingCharacter);
    gttWord: Result.SetTrimming(StringTrimmingWord);
  end;

  if AShowAcceleratorChar then
    Result.SetHotkeyPrefix(HotkeyPrefixShow)
  else
    Result.SetHotkeyPrefix(HotkeyPrefixNone);
end;

function CreateGDIPBrush(AFill: TAdvChartGraphicsFill; APath: TGPGraphicsPath): TGPBrush;
var
  cnt: Integer;
  positions, rpositions: array of Single;
  colors, rcolors: array of TGPColor;
  r: TGPRectF;
  I: Integer;
  it: TAdvChartGraphicsFillGradientItem;
  f0, f1: Boolean;
  o: Integer;
  M, MS: TGPMatrix;
  mm: TAdvChartGraphicsMatrix;
begin
  if Assigned(APath) then
    APath.GetBounds(r);

  Result := nil;
  case AFill.Kind of
    gfkSolid: Result := TGPSolidBrush.Create(ConvertToGDIPColor(AFill.Color, AFill.Opacity));
    gfkTexture, gfkNone: Result := TGPSolidBrush.Create(ConvertToGDIPColor(gcNull, 0));
    gfkGradient:
    begin
      r := MakeRect(r.X - 1, r.Y - 1, r.Width + 2, r.Height + 2);

      case AFill.GradientType of
        gfgtLinear:
        begin
          case AFill.Orientation of
            gfoHorizontal: Result := TGPLinearGradientBrush.Create(r, 0, 0, LinearGradientModeHorizontal);
            gfoVertical: Result := TGPLinearGradientBrush.Create(r, 0, 0, LinearGradientModeVertical);
            gfoCustom: Result := TGPLinearGradientBrush.Create(r, 0, 0, AFill.GradientAngle);
          end;
        end;
        gfgtRadial:
        begin
          Result := TGPPathGradientBrush.Create(APath);
          if AFill.GradientCenterColor <> gcNull then
            TGPPathGradientBrush(Result).SetCenterColor(ConvertToGDIPColor(AFill.GradientCenterColor, AFill.Opacity));

          TGPPathGradientBrush(Result).SetCenterPoint(MakePoint(AFill.GradientCenterPoint.X, AFill.GradientCenterPoint.Y));
        end;
      end;

      case AFill.GradientMode of
        gfgmDefault:
        begin
          if (AFill.ColorMirror <> gcNull) and (AFill.ColorMirrorTo <> gcNull) then
          begin
            SetLength(colors, 4);
            colors[0] := ConvertToGDIPColor(AFill.Color, AFill.Opacity);
            colors[1] := ConvertToGDIPColor(AFill.ColorTo, AFill.Opacity);
            colors[2] := ConvertToGDIPColor(AFill.ColorMirror, AFill.Opacity);
            colors[3] := ConvertToGDIPColor(AFill.ColorMirrorTo, AFill.Opacity);

            SetLength(positions, 4);
            positions[0] := 0.0;
            positions[1] := 0.5;
            positions[2] := 0.5;
            positions[3] := 1;
          end
          else
          begin
            SetLength(colors, 2);
            colors[0] := ConvertToGDIPColor(AFill.Color, AFill.Opacity);
            colors[1] := ConvertToGDIPColor(AFill.ColorTo, AFill.Opacity);

            SetLength(positions, 2);
            positions[0] := 0.0;
            positions[1] := 1;
          end;
        end;
        gfgmCollection:
        begin
          f0 := False;
          f1 := False;
          for I := 0 to AFill.GradientItems.Count - 1 do
          begin
            it := AFill.GradientItems[I];
            if it.Position = 0.0 then
              f0 := True;

            if it.Position = 1.0 then
              f1 := True;
          end;

          SetLength(colors, AFill.GradientItems.Count);
          SetLength(positions, AFill.GradientItems.Count);

          o := 0;
          if not f0 and (AFill.GradientItems.Count > 0) then
          begin
            SetLength(colors, Length(colors) + 1);
            colors[0] := AFill.GradientItems[0].Color;
            SetLength(positions, Length(positions) + 1);
            positions[0] := 0;
            o := 1;
          end;

          for I := 0 to AFill.GradientItems.Count - 1 do
          begin
            it := AFill.GradientItems[I];
            colors[I + o] := ConvertToGDIPColor(it.Color, it.Opacity);
            positions[I + o] := it.Position;
          end;

          if not f1 and (AFill.GradientItems.Count > 0) then
          begin
            SetLength(colors, Length(colors) + 1);
            colors[Length(colors) - 1] := AFill.GradientItems[AFill.GradientItems.Count - 1].Color;
            SetLength(positions, Length(positions) + 1);
            positions[Length(positions) - 1] := 1;
          end;
        end;
      end;

      mm := AFill.GradientMatrix;
      M := TGPMatrix.Create(mm.m11, mm.m12, mm.m21, mm.m22, mm.m31, mm.m32);
      MS := TGPMatrix.Create;
      try
        cnt := Length(colors);
        if Result is TGPLinearGradientBrush then
        begin
          TGPLinearGradientBrush(Result).SetInterpolationColors(@colors[0], @positions[0], cnt);
          TGPLinearGradientBrush(Result).GetTransform(MS);
          MS.Multiply(M);
          TGPLinearGradientBrush(Result).SetTransform(MS);
        end
        else if Result is TGPPathGradientBrush then
        begin
          SetLength(rcolors, Length(colors));
          SetLength(rpositions, Length(positions));
          for I := 0 to Length(colors) - 1 do
            rcolors[I] := colors[Length(colors) - 1 - I];

          for I := 0 to Length(positions) - 1 do
            rpositions[I] := 1 - positions[Length(positions) - I - 1];

          TGPPathGradientBrush(Result).SetInterpolationColors(@rcolors[0], @rpositions[0], cnt);
          TGPLinearGradientBrush(Result).GetTransform(MS);
          MS.Multiply(M);
          TGPPathGradientBrush(Result).SetTransform(M);
        end;
      finally
        M.Free;
        MS.Free;
      end;
    end;
  end;
end;

{ TAdvChartGraphicsContextWin }

procedure TAdvChartGraphicsContextWin.BeginScene;
begin
  if not Assigned(FGPGraphics) then
    Exit;

  {$IFDEF FMXLIB}
  Canvas.BeginScene;
  Canvas.Clear(gcNull);
  {$ENDIF}
  {$IFDEF LCLLIB}
  Canvas.Clear;
  {$ENDIF}
end;

function TAdvChartGraphicsContextWin.CalculateText(AText: string; ARect: TRectF;
  AWordWrapping: Boolean): TRectF;
var
  b: TGPBrush;
  sf: TGPStringFormat;
  rt, bb: TGPRectF;
begin
  Result := RectF(0, 0, 0, 0);
  if not Assigned(FGPGraphics) then
    Exit;

  b := CreateGDIPFontFill(FFont);
  sf := CreateGPStringFormat(gtaLeading, gtaLeading, AWordWrapping, gttNone, FShowAcceleratorChar);
  try
    rt := MakeRect(ARect.Left, ARect.Top, ARect.Width, ARect.Height);
    FGPGraphics.MeasureString(PChar(AText), Length(AText), FGPFont, rt, sf, bb);
    Result := RectF(bb.X, bb.Y, bb.X + bb.Width, bb.Y + bb.Height);
  finally
    sf.Free;
    b.Free;
  end;
end;

procedure TAdvChartGraphicsContextWin.ClipPath(APath: TAdvChartGraphicsPath);
var
  pth: TGPGraphicsPath;
begin
  if not Assigned(FGPGraphics) then
    Exit;

  pth := TGPGraphicsPath(ConvertToPath(APath));
  try
    FGPGraphics.SetClip(pth);
  finally
    pth.Free;
  end;
end;

procedure TAdvChartGraphicsContextWin.ClipRect(ARect: TRectF);
begin
  if not Assigned(FGPGraphics) then
    Exit;

  FGPGraphics.SetClip(MakeRect(ARect.Left, ARect.Top, ARect.Width, ARect.Height));
end;

constructor TAdvChartGraphicsContextWin.Create(const AGraphics: TAdvChartGraphics);
begin
  inherited;
  FScale := TAdvChartUtils.GetDPIScale;
  FNeedsRendering := True;
  FContextSize.cx := 0;
  FContextSize.cy := 0;
  FFont := TAdvChartGraphicsFont.Create;
  FFont.OnChanged := FontChanged;
  FStroke := TAdvChartGraphicsStroke.Create;
  FStroke.OnChanged := StrokeChanged;
  FFill := TAdvChartGraphicsFill.Create;
  FFill.OnChanged := FillChanged;
end;

function TAdvChartGraphicsContextWin.CreatePath: Pointer;
begin
  Result := TGPGraphicsPath.Create;
end;

destructor TAdvChartGraphicsContextWin.Destroy;
begin
  Render;

  if Assigned(FFont) then
  begin
    FFont.Free;
    FFont := nil;
  end;

  if Assigned(FFill) then
  begin
    FFill.Free;
    FFill := nil;
  end;

  if Assigned(FStroke) then
  begin
    FStroke.Free;
    FStroke := nil;
  end;

  if Assigned(FGPPen) then
  begin
    FGPPen.Free;
    FGPPen := nil;
  end;

  if Assigned(FGPBrush) then
  begin
    FGPBrush.Free;
    FGPBrush := nil;
  end;

  if Assigned(FGPFont) then
  begin
    FGPFont.Free;
    FGPFont := nil;
  end;

  if Assigned(FGPStringFormat) then
  begin
    FGPStringFormat.Free;
    FGPStringFormat := nil;
  end;

  DestroyResources;
  inherited;
end;

procedure TAdvChartGraphicsContextWin.DestroyResources;
begin
  if Assigned(FGPBitmap) then
  begin
    FGPBitmap.Free;
    FGPBitmap := nil;
  end;

  if Assigned(FGPGraphics) then
  begin
    FGPGraphics.Restore(FSaveGP);
    FGPGraphics.Free;
    FGPGraphics := nil;
  end;

  if Assigned(FBitmap) then
  begin
    {$IFDEF FMXLIB}
    if FMapping then
    begin
      FBitmap.UnMap(FBitmapData);
      FMapping := False;
    end;
    {$ENDIF}
    FBitmap.Free;
    FBitmap := nil;
  end;
end;

procedure TAdvChartGraphicsContextWin.DrawArc(AStroke: TAdvChartGraphicsStroke;
  ACenter, ARadius: TPointF; AStartAngle, ASweepAngle: Single);
begin
  if not Assigned(FGPGraphics) then
    Exit;

  if FGPPen.GetDashStyle <> DashStyleSolid then
    SetSmoothingMode(SmoothingModeDefault);

  FGPGraphics.DrawArc(FGPPen, ACenter.X - ARadius.X, ACenter.Y - ARadius.Y, ARadius.X * 2, ARadius.Y * 2, AStartAngle, ASweepAngle);

  if FGPPen.GetDashStyle <> DashStyleSolid then
    RestoreSmoothingMode;
end;

procedure TAdvChartGraphicsContextWin.DrawBitmap(ABitmap: TAdvChartDrawBitmap;
  ASrcRect, ADstRect: TRectF; AOpacity: Single);
var
  img: TGPImage;

  function CreateGPImage: TGPImage;
  var
    pstm: IStream;
    pcbWrite: Longint;
    {$HINTS OFF}
    {$WARNINGS OFF}
    {$IFNDEF LCLLIB}
    {$IF COMPILERVERSION > 28}
    aSize: LargeUint;
    {$IFEND}
    {$IF COMPILERVERSION <= 28}
    aSize: Largeint;
    {$IFEND}
    {$ENDIF}
    {$IFDEF LCLLIB}
    {$IF FPC_FULLVERSION < 30002}
    aSize: Int64;
    {$IFEND}
    {$IF FPC_FULLVERSION >= 30002}
    aSize: QWord;
    {$IFEND}
    {$ENDIF}
    {$HINTS ON}
    {$WARNINGS ON}
    TempImage: TGPImage;
    TempGraphics: TGPGraphics;
    hglobal: THandle;
    DataStream: TMemoryStream;
  begin
    Result := nil;
    if Assigned(ABitmap) then
    begin
      DataStream := TMemoryStream.Create;
      ABitmap.SaveToStream(DataStream);
      try
        DataStream.Position := 0;

        hglobal := GlobalAlloc(GMEM_MOVEABLE, DataStream.Size);
        if (hglobal = 0) then
          raise Exception.Create('Could not allocate memory for image');
        try

          pstm := nil;
          // Create IStream* from global memory
          CreateStreamOnHGlobal(hglobal, TRUE, pstm);
      {$WARNINGS OFF}
          pstm.Write(DataStream.Memory, DataStream.Size, @pcbWrite);
      {$WARNINGS ON}
          pstm.Seek(0, STREAM_SEEK_SET, aSize);

          TempImage := TGPImage.Create(pstm);
          if TempImage.GetType = ImageTypeBitmap then
          begin
            Result := TGPBitmap.Create(TempImage.GetWidth, TempImage.GetHeight,
              PixelFormat32bppARGB);
            TempGraphics := TGPGraphics.Create(Result);
            TempGraphics.DrawImage(TempImage, 0, 0, TempImage.GetWidth,
              TempImage.GetHeight);
            TempGraphics.Free;
            TempImage.Free;
          end
          else
            Result := TempImage;

        finally
          GlobalFree(hglobal);
        end;
      finally
        DataStream.Free;
      end;
    end;
  end;
begin
  if not Assigned(ABitmap) or not Assigned(FGPGraphics) then
    Exit;

  img := CreateGPImage;
  try
    FGPGraphics.DrawImage(img, MakeRect(ADstRect.Left, ADstRect.Top, ADstRect.Width, ADstRect.Height));
  finally
    img.Free;
  end;
end;

procedure TAdvChartGraphicsContextWin.DrawEllipse(AStroke: TAdvChartGraphicsStroke;
  ARect: TRectF; AModifyRectMode: TAdvChartGraphicsModifyRectMode);
var
  r: TRectF;
begin
  if not Assigned(FGPGraphics) then
    Exit;

  r := RectF(ARect.Left, ARect.Top, ARect.Right - 1, ARect.Bottom - 1);
  if FGPPen.GetDashStyle <> DashStyleSolid then
    SetSmoothingMode(SmoothingModeDefault);

  FGPGraphics.DrawEllipse(FGPPen, r.Left, r.Top, r.Width, r.Height);

  if FGPPen.GetDashStyle <> DashStyleSolid then
    RestoreSmoothingMode;
end;

procedure TAdvChartGraphicsContextWin.DrawFocusPath(
  AStroke: TAdvChartGraphicsStroke; APath: TAdvChartGraphicsPath;
  AColor: TAdvChartGraphicsColor);
var
  ds: DashStyle;
  c: TGPColor;
  smt: SmoothingMode;
  w: Single;
begin
  if not Assigned(FGPGraphics) then
    Exit;

  smt := FGPGraphics.GetSmoothingMode;
  FGPGraphics.SetSmoothingMode(SmoothingModeDefault);
  ds := FGPPen.GetDashStyle;
  w := FGPPen.GetWidth;
  FGPPen.GetColor(c);
  FGPPen.SetDashStyle(DashStyleDot);
  FGPPen.SetWidth(1);
  FGPPen.SetColor(ConvertToGDIPColor(AColor, 1));
  DrawPath(AStroke, APath);
  FGPPen.SetWidth(w);
  FGPPen.SetDashStyle(ds);
  FGPPen.SetColor(c);
  FGPGraphics.SetSmoothingMode(smt);
end;

procedure TAdvChartGraphicsContextWin.DrawFocusRectangle(
  AStroke: TAdvChartGraphicsStroke; ARect: TRectF; AColor: TAdvChartGraphicsColor;
  AModifyRectMode: TAdvChartGraphicsModifyRectMode);
var
  ds: DashStyle;
  c: TGPColor;
  smt: SmoothingMode;
  w: Single;
begin
  if not Assigned(FGPGraphics) then
    Exit;

  smt := FGPGraphics.GetSmoothingMode;
  FGPGraphics.SetSmoothingMode(SmoothingModeDefault);
  ds := FGPPen.GetDashStyle;
  w := FGPPen.GetWidth;
  FGPPen.GetColor(c);
  FGPPen.SetDashStyle(DashStyleDot);
  FGPPen.SetWidth(1);
  FGPPen.SetColor(ConvertToGDIPColor(AColor, 1));
  DrawRect(AStroke, ARect, AllSides, AModifyRectMode);
  FGPPen.SetWidth(w);
  FGPPen.SetDashStyle(ds);
  FGPPen.SetColor(c);
  FGPGraphics.SetSmoothingMode(smt);
end;

procedure TAdvChartGraphicsContextWin.DrawLine(AStroke: TAdvChartGraphicsStroke;
  AFromPoint, AToPoint: TPointF; AModifyPointModeFrom,
  AModifyPointModeTo: TAdvChartGraphicsModifyPointMode);
begin
  if not Assigned(FGPGraphics) then
    Exit;

  if FGPPen.GetDashStyle <> DashStyleSolid then
    SetSmoothingMode(SmoothingModeDefault);

  FGPGraphics.DrawLine(FGPPen, AFromPoint.X, AFromPoint.Y, AToPoint.X, AToPoint.Y);

  if FGPPen.GetDashStyle <> DashStyleSolid then
    RestoreSmoothingMode;
end;

procedure TAdvChartGraphicsContextWin.DrawPath(AStroke: TAdvChartGraphicsStroke;
  APath: TAdvChartGraphicsPath; APathMode: TAdvChartGraphicsPathDrawMode = pdmPolygon);
var
  p: TAdvChartGraphicsPathPolygon;
  pth: TGPGraphicsPath;
begin
  if Assigned(APath) then
  begin
    if APathMode = pdmPath then
    begin
      if not Assigned(FGPGraphics) then
        Exit;

      if FGPPen.GetDashStyle <> DashStyleSolid then
        SetSmoothingMode(SmoothingModeDefault);

      pth := TGPGraphicsPath(ConvertToPath(APath));
      try
        FGPGraphics.DrawPath(FGPPen, pth);
      finally
        pth.Free;
      end;

      if FGPPen.GetDashStyle <> DashStyleSolid then
        RestoreSmoothingMode;
    end
    else
    begin
      SetLength(p, 0);
      APath.FlattenToPolygon(p);
      case APathMode of
        pdmPolygon: DrawPolygon(AStroke, p);
        pdmPolyline: DrawPolyline(AStroke, p);
      end;
    end;
  end;
end;

procedure TAdvChartGraphicsContextWin.DrawPolygon(AStroke: TAdvChartGraphicsStroke;
  APolygon: TAdvChartGraphicsPathPolygon);
begin
  if not Assigned(FGPGraphics) then
    Exit;

  if Length(APolygon) = 0 then
    Exit;

  if FGPPen.GetDashStyle <> DashStyleSolid then
    SetSmoothingMode(SmoothingModeDefault);

  FGPGraphics.DrawPolygon(FGPPen, PGPPointF(APolygon), Length(APolygon));

  if FGPPen.GetDashStyle <> DashStyleSolid then
    RestoreSmoothingMode;
end;

procedure TAdvChartGraphicsContextWin.DrawPolyline(AStroke: TAdvChartGraphicsStroke;
  APolyline: TAdvChartGraphicsPathPolygon);
begin
  if not Assigned(FGPGraphics) then
    Exit;

  if Length(APolyline) = 0 then
    Exit;

  if FGPPen.GetDashStyle <> DashStyleSolid then
    SetSmoothingMode(SmoothingModeDefault);

  FGPGraphics.DrawLines(FGPPen, PGPPointF(APolyline), Length(APolyline));

  if FGPPen.GetDashStyle <> DashStyleSolid then
    RestoreSmoothingMode;
end;

procedure TAdvChartGraphicsContextWin.DrawRect(AStroke: TAdvChartGraphicsStroke;
  ARect: TRectF; ASides: TAdvChartGraphicsSides;
  AModifyRectMode: TAdvChartGraphicsModifyRectMode);
var
  r: TRectF;
begin
  if not Assigned(FGPGraphics) then
    Exit;

  r := RectF(ARect.Left, ARect.Top, ARect.Right - 1, ARect.Bottom - 1);
  if gsTop in ASides then
    DrawLine(AStroke, PointF(r.Left, r.Top), PointF(r.Right, r.Top));
  if gsLeft in ASides then
    DrawLine(AStroke, PointF(r.Left, r.Top), PointF(r.Left, r.Bottom));
  if gsBottom in ASides then
    DrawLine(AStroke, PointF(r.Left, r.Bottom), PointF(r.Right, r.Bottom));
  if gsRight in ASides then
    DrawLine(AStroke, PointF(r.Right, r.Top), PointF(r.Right, r.Bottom));
end;

procedure TAdvChartGraphicsContextWin.DrawRoundRect(
  AStroke: TAdvChartGraphicsStroke; ARect: TRectF; ARounding: Single;
  ACorners: TAdvChartGraphicsCorners;
  AModifyRectMode: TAdvChartGraphicsModifyRectMode);
var
  pth: TAdvChartGraphicsPath;
  r: TRectF;
  rc: Single;
begin
  r := RectF(ARect.Left, ARect.Top, ARect.Right - 1, ARect.Bottom - 1);
  rc := ARounding;

  pth := TAdvChartGraphicsPath.Create;
  try
    if gcBottomLeft in ACorners then
    begin
      pth.MoveTo(PointF(r.Left + rc, r.Bottom));
      pth.AddArc(PointF(r.Left + rc, r.Bottom - rc), PointF(rc, rc), -270, 90);
      pth.LineTo(PointF(r.Left, r.Bottom - rc));
    end
    else
    begin
      pth.MoveTo(PointF(r.Left, r.Bottom));
    end;

    if gcTopLeft in ACorners then
    begin
      pth.LineTo(PointF(r.Left, r.Top + rc));
      pth.AddArc(PointF(r.Left + rc, r.Top + rc), PointF(rc, rc), -180, 90);
      pth.LineTo(PointF(r.Left + rc, r.Top));
    end
    else
      pth.LineTo(PointF(r.Left, r.Top));

    if gcTopRight in ACorners then
    begin
      pth.LineTo(PointF(r.Right - rc, r.Top));
      pth.AddArc(PointF(r.Right - rc, r.Top + rc), PointF(rc, rc), -90, 90);
      pth.LineTo(PointF(r.Right, r.Top + rc));
    end
    else
      pth.LineTo(PointF(r.Right, r.Top));

    if gcBottomRight in ACorners then
    begin
      pth.LineTo(PointF(r.Right, r.Bottom - rc));
      pth.AddArc(PointF(r.Right - rc, r.Bottom - rc), PointF(rc, rc), 0, 90);
      pth.LineTo(PointF(r.Right - rc, r.Bottom));
    end
    else
      pth.LineTo(PointF(r.Right, r.Bottom));

    if gcBottomLeft in ACorners then
      pth.LineTo(PointF(r.Left + rc, r.Bottom))
    else
      pth.LineTo(PointF(r.Left, r.Bottom));

    pth.ClosePath;

    DrawPath(FStroke, pth);
  finally
    pth.Free;
  end;
end;

procedure TAdvChartGraphicsContextWin.DrawText(AText: string; ARect: TRectF;
  AWordWrapping: Boolean; AHorizontalAlign,
  AVerticalAlign: TAdvChartGraphicsTextAlign;
  ATrimming: TAdvChartGraphicsTextTrimming; AAngle: Single);
var
  b: TGPBrush;
  sf: TGPStringFormat;
  rt: TGPRectF;
begin
  if not Assigned(FGPGraphics) then
    Exit;

  b := CreateGDIPFontFill(FFont);
  sf := CreateGPStringFormat(AHorizontalAlign, AVerticalAlign, AWordWrapping, ATrimming, FShowAcceleratorChar);
  try
    rt := MakeRect(ARect.Left, ARect.Top, ARect.Width, ARect.Height);
    FGPGraphics.DrawString(AText, FGPFont, rt, sf, b);
  finally
    sf.Free;
    b.Free;
  end;
end;

procedure TAdvChartGraphicsContextWin.EndScene;
begin
  if not Assigned(FGPGraphics) then
    Exit;

  Render;
  {$IFDEF FMXLIB}
  Canvas.EndScene;
  {$ENDIF}
end;

procedure TAdvChartGraphicsContextWin.FillArc(AFill: TAdvChartGraphicsFill; ACenter,
  ARadius: TPointF; AStartAngle, ASweepAngle: Single);
var
  p: TGPGraphicsPath;
begin
  if not Assigned(FGPGraphics) then
    Exit;

  p := TGPGraphicsPath.Create;
  try
    p.AddArc(ACenter.X - ARadius.X, ACenter.Y - ARadius.Y, ARadius.X * 2, ARadius.Y * 2, AStartAngle, ASweepAngle);
    ApplyFill(p);
    FGPGraphics.FillPath(FGPBrush, p);
  finally
    p.Free;
  end;
end;

procedure TAdvChartGraphicsContextWin.FillChanged(Sender: TObject);
var
  p: TGPGraphicsPath;
begin
  p := TGPGraphicsPath.Create;
  try
    p.AddRectangle(MakeRect(0, 0, FContextSize.Width, FContextSize.Height));
    ApplyFill(p);
  finally
    p.Free;
  end;
end;

procedure TAdvChartGraphicsContextWin.FillEllipse(AFill: TAdvChartGraphicsFill;
  ARect: TRectF; AModifyRectMode: TAdvChartGraphicsModifyRectMode);
var
  r: TRectF;
  p: TGPGraphicsPath;
begin
  if not Assigned(FGPGraphics) then
    Exit;

  p := TGPGraphicsPath.Create;
  try
    r := RectF(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
    p.AddEllipse(r.Left, r.Top, r.Width, r.Height);
    ApplyFill(p);
    FGPGraphics.FillPath(FGPBrush, p);
  finally
    p.Free;
  end;
end;

procedure TAdvChartGraphicsContextWin.FillPath(AFill: TAdvChartGraphicsFill;
  APath: TAdvChartGraphicsPath; APathMode: TAdvChartGraphicsPathDrawMode = pdmPolygon);
var
  p: TAdvChartGraphicsPathPolygon;
  pth: TGPGraphicsPath;
begin
  if Assigned(APath) then
  begin
    if APathMode = pdmPath then
    begin
      if not Assigned(FGPGraphics) then
        Exit;

      pth := TGPGraphicsPath(ConvertToPath(APath));
      try
        ApplyFill(pth);
        FGPGraphics.FillPath(FGPBrush, pth);
      finally
        pth.Free;
      end;
    end
    else
    begin
      SetLength(p, 0);
      APath.FlattenToPolygon(p);
      case APathMode of
        pdmPolygon: FillPolygon(AFill, p);
        pdmPolyline: FillPolyline(AFill, p);
      end;
    end;
  end;
end;

procedure TAdvChartGraphicsContextWin.FillPolygon(AFill: TAdvChartGraphicsFill;
  APolygon: TAdvChartGraphicsPathPolygon);
var
  p: TGPGraphicsPath;
begin
  if not Assigned(FGPGraphics) then
    Exit;

  if Length(APolygon) = 0 then
    Exit;

  p := TGPGraphicsPath.Create;
  try
    p.AddPolygon(PGPPointF(APolygon), Length(APolygon));
    ApplyFill(p);
    FGPGraphics.FillPath(FGPBrush, p);
  finally
    p.Free;
  end;
end;

procedure TAdvChartGraphicsContextWin.FillPolyline(AFill: TAdvChartGraphicsFill;
  APolyline: TAdvChartGraphicsPathPolygon);
var
  p: TGPGraphicsPath;
begin
  if not Assigned(FGPGraphics) then
    Exit;

  if Length(APolyline) = 0 then
    Exit;

  p := TGPGraphicsPath.Create;
  try
    p.AddPolygon(PGPPointF(APolyline), Length(APolyline));
    ApplyFill(p);
    FGPGraphics.FillPath(FGPBrush, p);
  finally
    p.Free;
  end;
end;

procedure TAdvChartGraphicsContextWin.FillRect(AFill: TAdvChartGraphicsFill;
  ARect: TRectF; AModifyRectMode: TAdvChartGraphicsModifyRectMode);
var
  r: TRectF;
  p: TGPGraphicsPath;
begin
  if not Assigned(FGPGraphics) then
    Exit;

  p := TGPGraphicsPath.Create;
  try
    r := RectF(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
    p.AddRectangle(MakeRect(r.Left, r.Top, r.Width, r.Height));
    ApplyFill(p);
    FGPGraphics.FillPath(FGPBrush, p);
  finally
    p.Free;
  end;
end;

procedure TAdvChartGraphicsContextWin.FillRoundRect(AFill: TAdvChartGraphicsFill;
  ARect: TRectF; ARounding: Single; ACorners: TAdvChartGraphicsCorners;
  AModifyRectMode: TAdvChartGraphicsModifyRectMode);
var
  pth: TAdvChartGraphicsPath;
  r: TRectF;
  rc: Single;
begin
  r := RectF(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
  rc := ARounding;

  pth := TAdvChartGraphicsPath.Create;
  try
    if gcBottomLeft in ACorners then
    begin
      pth.MoveTo(PointF(r.Left + rc, r.Bottom));
      pth.AddArc(PointF(r.Left + rc, r.Bottom - rc), PointF(rc, rc), -270, 90);
      pth.LineTo(PointF(r.Left, r.Bottom - rc));
    end
    else
    begin
      pth.MoveTo(PointF(r.Left, r.Bottom));
    end;

    if gcTopLeft in ACorners then
    begin
      pth.LineTo(PointF(r.Left, r.Top + rc));
      pth.AddArc(PointF(r.Left + rc, r.Top + rc), PointF(rc, rc), -180, 90);
      pth.LineTo(PointF(r.Left + rc, r.Top));
    end
    else
      pth.LineTo(PointF(r.Left, r.Top));

    if gcTopRight in ACorners then
    begin
      pth.LineTo(PointF(r.Right - rc, r.Top));
      pth.AddArc(PointF(r.Right - rc, r.Top + rc), PointF(rc, rc), -90, 90);
      pth.LineTo(PointF(r.Right, r.Top + rc));
    end
    else
      pth.LineTo(PointF(r.Right, r.Top));

    if gcBottomRight in ACorners then
    begin
      pth.LineTo(PointF(r.Right, r.Bottom - rc));
      pth.AddArc(PointF(r.Right - rc, r.Bottom - rc), PointF(rc, rc), 0, 90);
      pth.LineTo(PointF(r.Right - rc, r.Bottom));
    end
    else
      pth.LineTo(PointF(r.Right, r.Bottom));

    if gcBottomLeft in ACorners then
      pth.LineTo(PointF(r.Left + rc, r.Bottom))
    else
      pth.LineTo(PointF(r.Left, r.Bottom));

    pth.ClosePath;

    FillPath(FFill, pth);
  finally
    pth.Free;
  end;
end;

procedure TAdvChartGraphicsContextWin.ApplyFill(APath: TGPGraphicsPath);
begin
  if Assigned(FGPBrush) then
  begin
    FGPBrush.Free;
    FGPBrush := nil;
  end;

  FGPBrush := CreateGDIPBrush(FFill, APath);
end;

procedure TAdvChartGraphicsContextWin.FontChanged(Sender: TObject);
begin
  if Assigned(FGPFont) then
  begin
    FGPFont.Free;
    FGPFont := nil;
  end;

  FGPFont := CreateGDIPFont(FFont);
end;

function TAdvChartGraphicsContextWin.GetFillColor: TAdvChartGraphicsColor;
begin
  Result := Graphics.Fill.Color;
end;

function TAdvChartGraphicsContextWin.GetNativeCanvas: Pointer;
begin
  Result := FGPGraphics;
end;

procedure TAdvChartGraphicsContextWin.PathClose(APath: Pointer);
begin
  TGPGraphicsPath(APath).CloseFigure;
end;

procedure TAdvChartGraphicsContextWin.PathLineTo(APath: Pointer; APoint: TPointF);
begin
  TGPGraphicsPath(APath).AddLine(FMovePoint.X, FMovePoint.Y, APoint.X, APoint.Y);
  FMovePoint := APoint;
end;

procedure TAdvChartGraphicsContextWin.PathMoveTo(APath: Pointer; APoint: TPointF);
begin
  FMovePoint := APoint;
end;

procedure TAdvChartGraphicsContextWin.PathOpen(APath: Pointer);
begin
  TGPGraphicsPath(APath).StartFigure;
end;

procedure TAdvChartGraphicsContextWin.Render;
begin
  if not FNeedsRendering then
    Exit;

  {$IFDEF FMXLIB}
  if Assigned(FGPGraphics) then
  begin
    if FMapping then
    begin
      FBitmap.Unmap(FBitmapData);
      FMapping := False;
    end;

    Canvas.DrawBitmap(FBitmap, RectF(0, 0, FBitmap.Width, FBitmap.Height), RectF(0, 0, FContextSize.Width, FContextSize.Height), 1)
  end;
  {$ENDIF}

  FNeedsRendering := False;
  DestroyResources;
end;

procedure TAdvChartGraphicsContextWin.ResetClip;
begin
  if not Assigned(FGPGraphics) then
    Exit;

  FGPGraphics.ResetClip;
end;

procedure TAdvChartGraphicsContextWin.ResetTextAngle(AAngle: Single);
begin
  if not Assigned(FGPGraphics) then
    Exit;

  if (AAngle <> 0) and Assigned(FTextMatrix) then
  begin
    FGPGraphics.SetTransform(FTextMatrix);
    FTextMatrix.Free;
    FTextMatrix := nil;
  end;
end;

procedure TAdvChartGraphicsContextWin.ResetTransform;
begin
  if not Assigned(FGPGraphics) then
    Exit;

  FGPGraphics.Restore(FSaveGP);
  FSaveGP := FGPGraphics.Save;
end;

procedure TAdvChartGraphicsContextWin.RestoreState(
  AState: TAdvChartGraphicsSaveState);
begin
  if not Assigned(FGPGraphics) then
    Exit;

  FGPGraphics.Restore(AState.CustomSaveDC);
end;

procedure TAdvChartGraphicsContextWin.RotateTransform(AAngle: Single);
begin
  if not Assigned(FGPGraphics) then
    Exit;

  FGPGraphics.RotateTransform(AAngle, MatrixOrderPrepend);
end;

procedure TAdvChartGraphicsContextWin.SaveState(AState: TAdvChartGraphicsSaveState);
begin
  if not Assigned(FGPGraphics) then
    Exit;

  AState.CustomSaveDC := FGPGraphics.Save;
end;

procedure TAdvChartGraphicsContextWin.ScaleTransform(AX, AY: Single);
begin
  if not Assigned(FGPGraphics) then
    Exit;

  FGPGraphics.ScaleTransform(AX, AY, MatrixOrderPrepend);
end;

procedure TAdvChartGraphicsContextWin.SetTextQuality(ATextQuality: TAdvChartGraphicsTextQuality);
begin
  if not Assigned(FGPGraphics) then
    Exit;

  FGPGraphics.Restore(FSaveGP);
  case ATextQuality of
    gtqDefault: FGPGraphics.SetTextRenderingHint(TextRenderingHintSystemDefault);
    gtqAntiAliasing: FGPGraphics.SetTextRenderingHint(TextRenderingHintAntiAlias);
    gtqClearType: FGPGraphics.SetTextRenderingHint(TextRenderingHintClearTypeGridFit);
  end;
  FSaveGP := FGPGraphics.Save;
end;

procedure TAdvChartGraphicsContextWin.SetSmoothingMode(ASmoothingMode: SmoothingMode);
begin
  FSmoothingMode := FGPGraphics.GetSmoothingMode;
  FGPGraphics.SetSmoothingMode(ASmoothingMode)
end;

procedure TAdvChartGraphicsContextWin.RestoreSmoothingMode;
begin
  FGPGraphics.SetSmoothingMode(FSmoothingMode);
end;

procedure TAdvChartGraphicsContextWin.SetScale(AScale: Single);
begin
  FScale := AScale;
end;

procedure TAdvChartGraphicsContextWin.BeginPrinting;
begin

end;

procedure TAdvChartGraphicsContextWin.EndPrinting;
begin

end;

procedure TAdvChartGraphicsContextWin.SetSize(AWidth, AHeight: Single);
begin
  FContextSize.cx := AWidth;
  FContextSize.cy := AHeight;

  DestroyResources;

  {$IFDEF FMXLIB}
  FBitmap := TBitmap.Create(Round(AWidth * FScale), Round(AHeight * FScale));
  FBitmap.BitmapScale := FScale;
  if FBitmap.Map(TMapAccess.Write, FBitmapData) then
  begin
    FMapping := True;
    FGPBitmap := TGPBitmap.Create(FBitmap.Width, FBitmap.Height, FBitmapData.Pitch, PixelFormat32bppPARGB, FBitmapData.Data);
    FGPGraphics := TGPGraphics.Create(FGPBitmap);
    FGPGraphics.Clear(ConvertToGDIPColor(gcNull, 0));
    ScaleTransform(FScale, FScale);
  {$ENDIF}
  {$IFDEF CMNLIB}
  begin
    FGPGraphics := TGPGraphics.Create(Canvas.Handle);
  {$ENDIF}
  end;

  FSaveGP := FGPGraphics.Save;
end;

function TAdvChartGraphicsContextWin.GetMatrix: TAdvChartGraphicsMatrix;
var
  M: TGPMatrix;
  ma: TMatrixArray;
begin
  M := TGPMatrix.Create;
  try
    FGPGraphics.GetTransform(M);
    M.GetElements(ma);
    Result := MatrixIdentity;
    Result.m11 := ma[0];
    Result.m12 := ma[1];
    Result.m21 := ma[2];
    Result.m22 := ma[3];
    Result.m31 := ma[4];
    Result.m32 := ma[5];
  finally
    M.Free;
  end;
end;

procedure TAdvChartGraphicsContextWin.SetMatrix(AMatrix: TAdvChartGraphicsMatrix);
var
  M: TGPMatrix;
begin
  M := TGPMatrix.Create(AMatrix.m11, AMatrix.m12, AMatrix.m21, AMatrix.m22, AMatrix.m31, AMatrix.m32);
  try
    FGPGraphics.SetTransform(M);
  finally
    M.Free;
  end;
end;

procedure TAdvChartGraphicsContextWin.SetShowAcceleratorChar(AShowAcceleratorChar: Boolean);
begin
  if not Assigned(FGPGraphics) then
    Exit;

  FShowAcceleratorChar := AShowAcceleratorChar;
end;

procedure TAdvChartGraphicsContextWin.SetAntiAliasing(AAntiAliasing: Boolean);
begin
  if not Assigned(FGPGraphics) then
    Exit;

  FGPGraphics.Restore(FSaveGP);
  if AAntiAliasing then
    FGPGraphics.SetSmoothingMode(SmoothingModeAntiAlias)
  else
    FGPGraphics.SetSmoothingMode(SmoothingModeDefault);
  FSaveGP := FGPGraphics.Save;
end;

procedure TAdvChartGraphicsContextWin.SetFill(AFill: TAdvChartGraphicsFill);
begin
  if not Assigned(FGPGraphics) then
    Exit;

  FFill.Assign(AFill);
end;

procedure TAdvChartGraphicsContextWin.SetFillColor(AColor: TAdvChartGraphicsColor);
begin
  if not Assigned(FGPGraphics) then
    Exit;

  FFill.Color := AColor;
end;

procedure TAdvChartGraphicsContextWin.SetFillKind(AKind: TAdvChartGraphicsFillKind);
begin
  if not Assigned(FGPGraphics) then
    Exit;

  FFill.Kind := AKind;
end;

procedure TAdvChartGraphicsContextWin.SetFont(AFont: TAdvChartGraphicsFont);
begin
  if not Assigned(FGPGraphics) then
    Exit;

  FFont.Assign(AFont);
end;

procedure TAdvChartGraphicsContextWin.SetFontColor(AColor: TAdvChartGraphicsColor);
begin
  if not Assigned(FGPGraphics) then
    Exit;

  FFont.Color := AColor;
end;

procedure TAdvChartGraphicsContextWin.SetFontName(AName: string);
begin
  if not Assigned(FGPGraphics) then
    Exit;

  FFont.Name := AName;
end;

procedure TAdvChartGraphicsContextWin.SetFontSize(ASize: Integer);
begin
  if not Assigned(FGPGraphics) then
    Exit;

  FFont.Size := ASize;
end;

procedure TAdvChartGraphicsContextWin.SetFontStyles(AStyle: TFontStyles);
begin
  if not Assigned(FGPGraphics) then
    Exit;

  FFont.Style := AStyle;
end;

procedure TAdvChartGraphicsContextWin.SetStroke(AStroke: TAdvChartGraphicsStroke);
begin
  if not Assigned(FGPGraphics) then
    Exit;

  FStroke.Assign(AStroke);
end;

procedure TAdvChartGraphicsContextWin.SetStrokeColor(
  AColor: TAdvChartGraphicsColor);
begin
  if not Assigned(FGPGraphics) then
    Exit;

  FStroke.Color := AColor;
end;

procedure TAdvChartGraphicsContextWin.SetStrokeKind(
  AKind: TAdvChartGraphicsStrokeKind);
begin
  if not Assigned(FGPGraphics) then
    Exit;

  FStroke.Kind := AKind;
end;

procedure TAdvChartGraphicsContextWin.SetStrokeWidth(AWidth: Single);
begin
  if not Assigned(FGPGraphics) then
    Exit;

  FStroke.Width := AWidth;
end;

function TAdvChartGraphicsContextWin.SetTextAngle(ARect: TRectF;
  AAngle: Single): TRectF;
var
  ar: Single;
  cx: TPointF;
  rm: TGPMatrix;
begin
  Result := ARect;
  if not Assigned(FGPGraphics) then
    Exit;

  if AAngle <> 0 then
  begin
    ar := AAngle;
    cx.X := Result.Left + Result.Width / 2;
    cx.Y := Result.Top + Result.Height / 2;
    FTextMatrix := TGPMatrix.Create;
    FGPGraphics.GetTransform(FTextMatrix);
    rm := TGPMatrix.Create;
    rm.Translate(cx.X, cx.Y);
    rm.Rotate(ar);
    FGPGraphics.MultiplyTransform(rm, MatrixOrderPrepend);
    rm.Free;
    if Result.Width < Result.Height then
      Result := RectF(-Result.Height / 2, -Result.Width / 2, Result.Height / 2, Result.Width / 2)
    else
      Result := RectF(-Result.Width / 2, -Result.Height / 2, Result.Width / 2, Result.Height / 2);
  end;
end;

procedure TAdvChartGraphicsContextWin.StartSpecialPen;
begin
  if not Assigned(FGPGraphics) then
    Exit;
end;

procedure TAdvChartGraphicsContextWin.StopSpecialPen;
begin
  if not Assigned(FGPGraphics) then
    Exit;
end;

procedure TAdvChartGraphicsContextWin.StrokeChanged(Sender: TObject);
begin
  if Assigned(FGPPen) then
  begin
    FGPPen.Free;
    FGPPen := nil;
  end;

  FGPPen := CreateGDIPPen(FStroke);
end;

procedure TAdvChartGraphicsContextWin.TranslateTransform(AX, AY: Single);
begin
  if not Assigned(FGPGraphics) then
    Exit;

  FGPGraphics.TranslateTransform(AX, AY, MatrixOrderPrepend);
end;

{$ENDIF}

end.
