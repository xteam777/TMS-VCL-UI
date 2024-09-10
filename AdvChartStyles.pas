{********************************************************************}
{                                                                    }
{ written by TMS Software                                            }
{            copyright (c) 2016 - 2021                               }
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

unit AdvChartStyles;

{$I TMSDEFS.inc}

{$IFDEF VCLLIB}
{$HINTS OFF}
{$IF COMPILERVERSION > 22}
{$DEFINE VCLSTYLESENABLED}
{$IFEND}
{$ENDIF}

interface

uses
  Classes, Graphics, Controls, Forms, AdvChartTypes, AdvChartCustomComponent, AdvChartGraphicsTypes
  {$IFDEF FMXLIB}
  ,FMX.Types, UITypes
  {$ENDIF}
  {$IFDEF VCLSTYLESENABLED}
  ,VCL.Themes
  {$ENDIF}
  {$IFDEF FNCLIB}
  {$IFDEF WEBLIB}
  ,js, WEBLIB.JSON
  {$ENDIF}
  {$IFNDEF WEBLIB}
  {$IFNDEF LCLLIB}
  {$HINTS OFF}
  {$IF COMPILERVERSION > 26}
  ,JSON
  {$ELSE}
  ,DBXJSON
  {$IFEND}
  {$HINTS ON}
  {$ELSE}
  ,fpjson, jsparser
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}
  ;

type
  IAdvAdaptToStyle = interface
  ['{3EFF288D-3927-4E86-8E9D-EF684B501C9E}']
    function GetAdaptToStyle: Boolean;
    procedure SetAdaptToStyle(const Value: Boolean);
    property AdaptToStyle: Boolean read GetAdaptToStyle write SetAdaptToStyle;
  end;

  TAdvChartStyles = class
  private class var
    {$IFDEF FMXLIB}
    FScene: IScene;
    {$ENDIF}
  protected
    {$IFDEF FMXLIB}
    class function ExtractColor(ABitmap: TBitmap): TAdvChartGraphicsColor; virtual;
    class function ExtractColorTo(ABitmap: TBitmap): TAdvChartGraphicsColor; virtual;
    {$ENDIF}
    {$IFDEF WEBLIB}
    class function ExtractColor(AValue: string): TAdvChartGraphicsColor; virtual;
    class function ExtractColorTo(AValue: string): TAdvChartGraphicsColor; virtual;
    class function ExtractFontName(AValue: string): string; virtual;
    {$ENDIF}
    {$IFDEF VCLSTYLESENABLED}
    class function ExtractColor(AElement: TThemedElementDetails): TAdvChartGraphicsColor; virtual;
    class function ExtractColorTo(AElement: TThemedElementDetails): TAdvChartGraphicsColor; virtual;
    {$ENDIF}
    {$IFDEF FMXLIB}
    class function ParseBrush(ABrush: TBrush; ASecondColor: Boolean): TAdvChartGraphicsColor; virtual;
    class function GetStyleSceneObject: TFmxObject; virtual;
    class function GetStyleBackgroundFill(AStyle: TFmxObject): TBrush; virtual;
    class function GetStyleBackgroundStroke(AStyle: TFmxObject): TStrokeBrush; virtual;
    class function GetStyleDefaultButtonFill(AStyle: TFmxObject): TBrush; virtual;
    class function GetStyleDefaultButtonStroke(AStyle: TFmxObject): TStrokeBrush; virtual;
    class function GetStyleEditTextColor(AStyle: TFmxObject): TAlphaColor; virtual;
    class function GetStyleEditFill(AStyle: TFmxObject): TBrush; virtual;
    class function GetStyleEditStroke(AStyle: TFmxObject): TStrokeBrush; virtual;
    class function GetStyleHeaderFill(AStyle: TFmxObject): TBrush; virtual;
    class function GetStyleHeaderStroke(AStyle: TFmxObject): TStrokeBrush; virtual;
    class function GetStyleSelectionFill(AStyle: TFmxObject): TBrush; virtual;
    class function GetStyleAlternativeSelectionFill(AStyle: TFmxObject): TBrush; virtual;
    class function GetStyleAlternativeBackgroundFill(AStyle: TFmxObject): TBrush; virtual;
    class function GetStyleAlternativeBackgroundStroke(AStyle: TFmxObject): TStrokeBrush; virtual;
    class function GetStyleFocusFill(AStyle: TFmxObject): TBrush; virtual;
    class function GetStyleLineFill(AStyle: TFmxObject): TBrush; virtual;
    class function GetStyleTextFont(AStyle: TFmxObject): TFont; virtual;
    class function GetStyleTextColor(AStyle: TFmxObject): TAlphaColor; virtual;
    class function GetStyleAlternateBackgroundFill(AStyle: TFmxObject): TBrush; virtual;
    class function IsTransparentStyle(AStyle: TFmxObject): Boolean; virtual;
    {$ENDIF}
    {$IFDEF WEBLIB}
    class function GetStyleBackgroundFill: string; virtual;
    class function GetStyleBackgroundStroke: string; virtual;
    class function GetStyleDefaultButtonFill: string; virtual;
    class function GetStyleDefaultButtonStroke: string; virtual;
    class function GetStyleEditTextColor: string; virtual;
    class function GetStyleEditFill: string; virtual;
    class function GetStyleEditStroke: string; virtual;
    class function GetStyleHeaderFill: string; virtual;
    class function GetStyleHeaderStroke: string; virtual;
    class function GetStyleSelectionFill: string; virtual;
    class function GetStyleAlternativeSelectionFill: string; virtual;
    class function GetStyleAlternativeBackgroundFill: string; virtual;
    class function GetStyleAlternativeBackgroundStroke: string; virtual;
    class function GetStyleFocusFill: string; virtual;
    class function GetStyleLineFill: string; virtual;
    class function GetStyleTextFont: string; virtual;
    class function GetStyleTextColor: string; virtual;
    class function GetStyleAlternateBackgroundFill: string; virtual;
    {$ENDIF}
  public
    {$IFDEF FMXLIB}
    class procedure SetActiveScene(AScene: IScene); virtual;
    {$ENDIF}
    {$IFDEF WEBLIB}
    class function FindCSSStyleRule(ARuleName: string): TJSObject; virtual;
    class function FindCSSStyleProperty(ARuleName, APropertyName: string): string; virtual;
    {$ENDIF}
    class function StyleServicesEnabled: Boolean; virtual;
    class function GetStyleLineFillColor(var {%H-}AColor: TAdvChartGraphicsColor): Boolean; virtual;
    class function GetStyleBackgroundFillColor(var {%H-}AColor: TAdvChartGraphicsColor): Boolean; virtual;
    class function GetStyleBackgroundFillColorTo(var {%H-}AColor: TAdvChartGraphicsColor): Boolean; virtual;
    class function GetStyleAlternativeBackgroundFillColor(var {%H-}AColor: TAdvChartGraphicsColor): Boolean; virtual;
    class function GetStyleAlternativeBackgroundFillColorTo(var {%H-}AColor: TAdvChartGraphicsColor): Boolean; virtual;
    class function GetStyleBackgroundStrokeColor(var {%H-}AColor: TAdvChartGraphicsColor): Boolean; virtual;
    class function GetStyleHeaderFillColor(var {%H-}AColor: TAdvChartGraphicsColor): Boolean; virtual;
    class function GetStyleHeaderFillColorTo(var {%H-}AColor: TAdvChartGraphicsColor): Boolean; virtual;
    class function GetStyleHeaderStrokeColor(var {%H-}AColor: TAdvChartGraphicsColor): Boolean; virtual;
    class function GetStyleSelectionFillColor(var {%H-}AColor: TAdvChartGraphicsColor): Boolean; virtual;
    class function GetStyleSelectionFillColorTo(var {%H-}AColor: TAdvChartGraphicsColor): Boolean; virtual;
    class function GetStyleTextFontColor(var {%H-}AColor: TAdvChartGraphicsColor): Boolean; virtual;
    class function GetStyleAlternativeTextFontColor(var {%H-}AColor: TAdvChartGraphicsColor): Boolean; virtual;
    class function GetStyleDefaultButtonFillColor(var {%H-}AColor: TAdvChartGraphicsColor): Boolean; virtual;
    class function GetStyleDefaultButtonStrokeColor(var {%H-}AColor: TAdvChartGraphicsColor): Boolean; virtual;
  end;

  {$IFDEF FNCLIB}
  TAdvChartStylesManagerCanLoadStyleEvent = procedure(Sender: TObject; AStyle: string; AComponent: TComponent; var ACanLoadStyle: Boolean) of object;
  TAdvChartStylesManagerStyleLoadedEvent = procedure(Sender: TObject; AStyle: string; AComponent: TComponent) of object;

  TAdvChartStylesManagerFileArray = array of string;

  TAdvChartStylesManagerComponentArray = array of TComponent;

  IAdvChartStylesManager = interface
    ['{88852C7F-B7B5-4FFA-BB47-6D95600CB1F3}']
    function GetSubComponentArray: TAdvChartStylesManagerComponentArray;
  end;

  TAdvChartStylesManagerOptions = class(TPersistent)
  private
    FAdaptFormColor: Boolean;
  public
    constructor Create; virtual;
  published
    property AdaptFormColor: Boolean read FAdaptFormColor write FAdaptFormColor default True;
  end;

  {$IFNDEF LCLLIB}
  [ComponentPlatformsAttribute(TMSPlatformsWeb)]
  {$ENDIF}
  TAdvChartStylesManager = class(TAdvChartCustomComponent)
  private
    {$IFDEF WEBLIB}
    FComponents: TAdvChartStylesManagerComponentArray;
    {$ENDIF}
    FStyle: string;
    FStyleResource: string;
    FStyleForm: TCustomForm;
    FOnCanLoadStyle: TAdvChartStylesManagerCanLoadStyleEvent;
    FOnStyleLoaded: TAdvChartStylesManagerStyleLoadedEvent;
    FOptions: TAdvChartStylesManagerOptions;
    procedure SetStyle(const Value: string);
    procedure SetStyleResource(const Value: string);
    procedure SetOptions(const Value: TAdvChartStylesManagerOptions);
  protected
    function GetDocURL: string; override;
    procedure InternalLoadStyleFromJSONValue(AJSONValue: TJSONValue; AComponents: TAdvChartStylesManagerComponentArray);
    procedure InternalLoadStyle(AValue: string; AComponents: TAdvChartStylesManagerComponentArray);
    procedure DoCanLoadStyle(AStyle: string; AComponent: TComponent; var ACanLoadStyle: Boolean); virtual;
    procedure DoStyleLoaded(AStyle: string; AComponent: TComponent); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadStyleFromText(AText: string); overload; virtual;
    procedure LoadStyleFromStream(AStream: TStream); overload; virtual;
    procedure LoadStyleFromFile(AFile: string); overload; virtual;
    procedure LoadStyleFromText(AText: string; AComponents: TAdvChartStylesManagerComponentArray); overload; virtual;
    procedure LoadStyleFromStream(AStream: TStream; AComponents: TAdvChartStylesManagerComponentArray); overload; virtual;
    procedure LoadStyleFromFile(AFile: string; AComponents: TAdvChartStylesManagerComponentArray); overload; virtual;
    {$IFNDEF WEBLIB}
    procedure LoadStyleFromResource(AResourceName: string; AComponents: TAdvChartStylesManagerComponentArray); overload; virtual;
    procedure LoadStyleFromResource(AResourceName: string); overload; virtual;
    function GetStyleFromResource(AResourceName: string): string; virtual;
    function GetStyleFromFile(AFile: string): string; virtual;
    function CombineStyles(AFiles: TAdvChartStylesManagerFileArray): string; virtual;
    {$ELSE}
    procedure LoadStyleFromURL(AURL: string; AComponents: TAdvChartStylesManagerComponentArray); overload; virtual;
    procedure LoadStyleFromURL(AURL: string); overload; virtual;
    {$ENDIF}
    property StyleForm: TCustomForm read FStyleForm write FStyleForm;
  published
    property Options: TAdvChartStylesManagerOptions read FOptions write SetOptions;
    property Style: string read FStyle write SetStyle;
    property StyleResource: string read FStyleResource write SetStyleResource;
    property OnCanLoadStyle: TAdvChartStylesManagerCanLoadStyleEvent read FOnCanLoadStyle write FOnCanLoadStyle;
    property OnStyleLoaded: TAdvChartStylesManagerStyleLoadedEvent read FOnStyleLoaded write FOnStyleLoaded;
  end;
  {$ENDIF}

var
  CSSStyleFileName: string = '';

implementation

uses
  AdvChartUtils, SysUtils, AdvChartPersistence, AdvChartGraphics
  {$IFDEF FMXLIB}
  ,UIConsts, FMX.Objects, FMX.Styles, FMX.Styles.Objects, Types
  {$ENDIF}
  ;

{$IFDEF FNCLIB}
{$R 'AdvChartStyles.res'}
{$ENDIF}

{$IFDEF FMXLIB}

class function TAdvChartStyles.ParseBrush(ABrush: TBrush; ASecondColor: Boolean): TAdvChartGraphicsColor;
begin
  case ABrush.Kind of
    TBrushKind.None, TBrushKind.Resource: Result := gcNull;
    TBrushKind.Solid: Result := ABrush.Color;
    TBrushKind.Gradient:
    begin
      if ABrush.Gradient.Points.Count > 0 then
      begin
        if ASecondColor then
          Result := ABrush.Gradient.Points[1].Color
        else
          Result := ABrush.Gradient.Points[0].Color;
      end
      else
        Result := ABrush.Color;
    end;
    TBrushKind.Bitmap:
    begin
      if ASecondColor then
        Result := ExtractColorTo(ABrush.Bitmap.Bitmap)
      else
        Result := ExtractColor(ABrush.Bitmap.Bitmap);
    end;
    else
      Result := gcNull;
  end;
end;

class function TAdvChartStyles.GetStyleSceneObject: TFmxObject;
var
  frm: TCommonCustomForm;
begin
  if Assigned(TAdvChartStyles.FScene) and Assigned(TAdvChartStyles.FScene.GetObject) and (TAdvChartStyles.FScene.GetObject.ClassName <> 'TAdvChartCustomPopupForm') then
  begin
    if Assigned(TAdvChartStyles.FScene.StyleBook) then
      Result := TAdvChartStyles.FScene.StyleBook.Style
    else
      Result := TStyleManager.ActiveStyleForScene(TAdvChartStyles.FScene);
  end
  else
  begin
    frm := Screen.ActiveForm;
    if not Assigned(frm) then
      frm := Application.MainForm;

    if Assigned(frm) and Assigned(frm.StyleBook) then
      Result := frm.StyleBook.Style
    else
      Result := TStyleManager.ActiveStyle(nil);
  end;
end;

class function TAdvChartStyles.IsTransparentStyle(
  AStyle: TFmxObject): Boolean;
var
  st: TStyleDescription;
begin
  Result := False;
  st := TStyleManager.FindStyleDescriptor(AStyle);
  if Assigned(st) then
    Result := LowerCase(st.Title) = 'transparent';
end;

class function TAdvChartStyles.GetStyleAlternateBackgroundFill(
  AStyle: TFmxObject): TBrush;
var
  st, stobj: TFmxObject;
  f: TBrush;
begin
  f := TBrush.Create(TBrushKind.Solid, claNull);
  Result := f;
  if Assigned(AStyle) then
  begin
    st := AStyle.FindStyleResource('gridstyle');
    if Assigned(st) then
    begin
      stobj := st.FindStyleResource('alternatingrowbackground');
      if (Assigned(stobj) and (stobj is TBrushObject)) then
        f.Assign((stobj as TBrushObject).Brush);
    end;
  end;
end;

class function TAdvChartStyles.GetStyleAlternativeSelectionFill(
  AStyle: TFmxObject): TBrush;
var
  st, stobj: TFmxObject;
  f: TBrush;
  bmp: TBitmap;
begin
  f := TBrush.Create(TBrushKind.Solid, claNull);
  Result := f;
  if Assigned(AStyle) then
  begin
    st := AStyle.FindStyleResource('memostyle');
    if Assigned(st) then
    begin
      stobj := st.FindStyleResource('selection');
      if Assigned(stobj) then
      begin
        if (stobj is TRectangle) then
          f.Assign((stobj as TRectangle).Fill)
        else if (stobj is TBrushObject) then
          f.Assign((stobj as TBrushObject).Brush)
        else if stobj is TCustomStyleObject then
        begin
          f.Kind := TBrushKind.Bitmap;
          f.Bitmap.WrapMode := TWrapMode.TileStretch;
          bmp := TBitmap.Create(Round(200), Round(200));
          if bmp.Canvas.BeginScene then
          begin
            (stobj as TCustomStyleObject).DrawToCanvas(bmp.Canvas, RectF(-10, -10, bmp.Width + 10, bmp.Height + 10));
            bmp.Canvas.EndScene;
          end;
          f.Bitmap.Bitmap.Assign(bmp);
          bmp.Free;
        end;
      end;
    end;
  end;
end;

class function TAdvChartStyles.GetStyleDefaultButtonFill(
  AStyle: TFmxObject): TBrush;
var
  st, stobj: TFmxObject;
  f: TBrush;
  bmp: TBitmap;
begin
  f := TBrush.Create(TBrushKind.Solid, claNull);
  Result := f;
  if Assigned(AStyle) then
  begin
    st := AStyle.FindStyleResource('buttonstyle');
    if Assigned(st) then
    begin
      stobj := st.FindStyleResource('background');
      if Assigned(stobj) then
      begin
        if (stobj is TRectangle) then
          f.Assign((stobj as TRectangle).Fill)
        else if stobj is TCustomStyleObject then
        begin
          f.Kind := TBrushKind.Bitmap;
          f.Bitmap.WrapMode := TWrapMode.TileStretch;
          bmp := TBitmap.Create(Round(200), Round(200));
          if bmp.Canvas.BeginScene then
          begin
            (stobj as TCustomStyleObject).DrawToCanvas(bmp.Canvas, RectF(-10, -10, bmp.Width + 10, bmp.Height + 10));
            bmp.Canvas.EndScene;
          end;
          f.Bitmap.Bitmap.Assign(bmp);
          bmp.Free;
        end;
      end;
    end;
  end;
end;

class function TAdvChartStyles.GetStyleBackgroundFill(
  AStyle: TFmxObject): TBrush;
var
  st, stobj: TFmxObject;
  f: TBrush;
  bmp: TBitmap;
begin
  f := TBrush.Create(TBrushKind.Solid, claNull);
  Result := f;
  if Assigned(AStyle) then
  begin
    st := AStyle.FindStyleResource('gridstyle');
    if Assigned(st) then
    begin
      stobj := st.FindStyleResource('background');
      if Assigned(stobj) then
      begin
        if (stobj is TRectangle) then
          f.Assign((stobj as TRectangle).Fill)
        else if stobj is TCustomStyleObject then
        begin
          f.Kind := TBrushKind.Bitmap;
          f.Bitmap.WrapMode := TWrapMode.TileStretch;
          bmp := TBitmap.Create(Round(200), Round(200));
          if bmp.Canvas.BeginScene then
          begin
            (stobj as TCustomStyleObject).DrawToCanvas(bmp.Canvas, RectF(-10, -10, bmp.Width + 10, bmp.Height + 10));
            bmp.Canvas.EndScene;
          end;
          f.Bitmap.Bitmap.Assign(bmp);
          bmp.Free;
        end;
      end;
    end;
  end;
end;

class function TAdvChartStyles.GetStyleDefaultButtonStroke(
  AStyle: TFmxObject): TStrokeBrush;
var
  st, stobj: TFmxObject;
  s: TStrokeBrush;
begin
  s := TStrokeBrush.Create(TBrushKind.Solid, claDarkGray);
  Result := s;
  if Assigned(AStyle) then
  begin
    st := AStyle.FindStyleResource('buttonstyle');
    if Assigned(st) then
    begin
      stobj := st.FindStyleResource('background');
      if Assigned(stobj) then
      begin
        if (stobj is TRectangle) then
          s.Assign((stobj as TRectangle).Stroke);
      end;
    end;
  end;
end;

class function TAdvChartStyles.GetStyleBackgroundStroke(
  AStyle: TFmxObject): TStrokeBrush;
var
  st, stobj: TFmxObject;
  s: TStrokeBrush;
begin
  s := TStrokeBrush.Create(TBrushKind.Solid, claDarkGray);
  Result := s;
  if Assigned(AStyle) then
  begin
    st := AStyle.FindStyleResource('gridstyle');
    if Assigned(st) then
    begin
      stobj := st.FindStyleResource('background');
      if Assigned(stobj) then
      begin
        if (stobj is TRectangle) then
          s.Assign((stobj as TRectangle).Stroke);
      end;
    end;
  end;
end;

class function TAdvChartStyles.GetStyleAlternativeBackgroundFill(
  AStyle: TFmxObject): TBrush;
var
  st, stobj: TFmxObject;
  f: TBrush;
  bmp: TBitmap;
begin
  f := TBrush.Create(TBrushKind.Solid, claNull);
  Result := f;
  if Assigned(AStyle) then
  begin
    st := AStyle.FindStyleResource('memostyle');
    if Assigned(st) then
    begin
      stobj := st.FindStyleResource('background');
      if Assigned(stobj) then
      begin
        if (stobj is TRectangle) then
          f.Assign((stobj as TRectangle).Fill)
        else if stobj is TCustomStyleObject then
        begin
          f.Kind := TBrushKind.Bitmap;
          f.Bitmap.WrapMode := TWrapMode.TileStretch;
          bmp := TBitmap.Create(Round(200), Round(200));
          if bmp.Canvas.BeginScene then
          begin
            (stobj as TCustomStyleObject).DrawToCanvas(bmp.Canvas, RectF(-10, -10, bmp.Width + 10, bmp.Height + 10));
            bmp.Canvas.EndScene;
          end;
          f.Bitmap.Bitmap.Assign(bmp);
          bmp.Free;
        end;
      end;
    end;
  end;
end;

class function TAdvChartStyles.GetStyleAlternativeBackgroundStroke(
  AStyle: TFmxObject): TStrokeBrush;
var
  st, stobj: TFmxObject;
  s: TStrokeBrush;
begin
  s := TStrokeBrush.Create(TBrushKind.Solid, claDarkGray);
  Result := s;
  if Assigned(AStyle) then
  begin
    st := AStyle.FindStyleResource('memostyle');
    if Assigned(st) then
    begin
      stobj := st.FindStyleResource('foreground');
      if Assigned(stobj) then
      begin
        if (stobj is TBrushObject) then
          s.Assign((stobj as TBrushObject).Brush);
      end;
    end;
  end;
end;

class function TAdvChartStyles.GetStyleEditTextColor(AStyle: TFmxObject): TAlphaColor;
var
  st, stobj: TFMXObject;
begin
  Result := claBlack;
  if Assigned(AStyle) then
  begin
    st := AStyle.FindStyleResource('editstyle');
    if Assigned(st) then
    begin
      stobj := st.FindStyleResource('foreground');
      if (Assigned(stobj) and (stobj is TBrushObject)) then
      begin
        if (Assigned(stobj) and (stobj is TBrushObject)) then
          Result := (stobj as TBrushObject).Brush.Color;
      end;
    end;
  end;
end;

class function TAdvChartStyles.GetStyleEditFill(
  AStyle: TFmxObject): TBrush;
var
  st, stobj: TFmxObject;
  f: TBrush;
  bmp: TBitmap;
begin
  f := TBrush.Create(TBrushKind.Solid, claNull);
  Result := f;
  if Assigned(AStyle) then
  begin
    st := AStyle.FindStyleResource('editstyle');
    if Assigned(st) then
    begin
      stobj := st.FindStyleResource('background');
      if Assigned(stobj) then
      begin
        if (stobj is TRectangle) then
          f.Assign((stobj as TRectangle).Fill)
        else if stobj is TCustomStyleObject then
        begin
          f.Kind := TBrushKind.Bitmap;
          f.Bitmap.WrapMode := TWrapMode.TileStretch;
          bmp := TBitmap.Create(Round(200), Round(200));
          if bmp.Canvas.BeginScene then
          begin
            (stobj as TCustomStyleObject).DrawToCanvas(bmp.Canvas, RectF(-10, -10, bmp.Width + 10, bmp.Height + 10));
            bmp.Canvas.EndScene;
          end;
          f.Bitmap.Bitmap.Assign(bmp);
          bmp.Free;
        end;
      end;
    end;
  end;
end;

class function TAdvChartStyles.GetStyleEditStroke(
  AStyle: TFmxObject): TStrokeBrush;
var
  st, stobj: TFmxObject;
  s: TStrokeBrush;
begin
  s := TStrokeBrush.Create(TBrushKind.Solid, claDarkGray);
  Result := s;
  if Assigned(AStyle) then
  begin
    st := AStyle.FindStyleResource('editstyle');
    if Assigned(st) then
    begin
      stobj := st.FindStyleResource('background');
      if Assigned(stobj) then
      begin
        if (stobj is TRectangle) then
          s.Assign((stobj as TRectangle).Stroke);
      end;
    end;
  end;
end;

class function TAdvChartStyles.GetStyleFocusFill(AStyle: TFmxObject): TBrush;
var
  st, stobj: TFmxObject;
  f: TBrush;
  bmp: TBitmap;
begin
  f := TBrush.Create(TBrushKind.Solid, claNull);
  Result := f;
  if Assigned(AStyle) then
  begin
    st := AStyle.FindStyleResource('gridstyle');
    if Assigned(st) then
    begin
      stobj := st.FindStyleResource('focus');
      if Assigned(stobj) then
      begin
        if (stobj is TRectangle) then
          f.Assign((stobj as TRectangle).Fill)
        else if stobj is TCustomStyleObject then
        begin
          f.Kind := TBrushKind.Bitmap;
          f.Bitmap.WrapMode := TWrapMode.TileStretch;
          bmp := TBitmap.Create(Round(200), Round(200));
          if bmp.Canvas.BeginScene then
          begin
            (stobj as TCustomStyleObject).DrawToCanvas(bmp.Canvas, RectF(-10, -10, bmp.Width + 10, bmp.Height + 10));
            bmp.Canvas.EndScene;
          end;
          f.Bitmap.Bitmap.Assign(bmp);
          bmp.Free;
        end;
      end;
    end;
  end;
end;

class function TAdvChartStyles.GetStyleHeaderFill(
  AStyle: TFmxObject): TBrush;
var
  st, stobj: TFmxObject;
  f: TBrush;
  bmp: TBitmap;
begin
  f := TBrush.Create(TBrushKind.Solid, claNull);
  Result := f;
  if Assigned(AStyle) then
  begin
    st := AStyle.FindStyleResource('headeritemstyle');
    if Assigned(st) then
    begin
      stobj := st.FindStyleResource('background');
      if Assigned(stobj) then
      begin
        if (stobj is TRectangle) then
          f.Assign((stobj as TRectangle).Fill)
        else if stobj is TButtonStyleObject then
        begin
          f.Kind := TBrushKind.Bitmap;
          f.Bitmap.WrapMode := TWrapMode.TileStretch;
          bmp := TBitmap.Create(Round(200), Round(200));
          if bmp.Canvas.BeginScene then
          begin
            (stobj as TButtonStyleObject).DrawToCanvas(bmp.Canvas, RectF(-10, -10, bmp.Width + 10, bmp.Height + 10));
            bmp.Canvas.EndScene;
          end;
          f.Bitmap.Bitmap.Assign(bmp);
          bmp.Free;
        end;
      end;
    end;
  end;
end;

class function TAdvChartStyles.GetStyleHeaderStroke(
  AStyle: TFmxObject): TStrokeBrush;
var
  st, stobj: TFmxObject;
  s: TStrokeBrush;
begin
  s := TStrokeBrush.Create(TBrushKind.Solid, claDarkGray);
  Result := s;
  if Assigned(AStyle) then
  begin
    st := AStyle.FindStyleResource('headeritemstyle');
    if Assigned(st) then
    begin
      stobj := st.FindStyleResource('background');
      if Assigned(stobj) then
      begin
        if (stobj is TRectangle) then
          s.Assign((stobj as TRectangle).Stroke);
      end;
    end;
  end;
end;

class function TAdvChartStyles.GetStyleLineFill(AStyle: TFmxObject): TBrush;
var
  st, stobj: TFmxObject;
  f: TBrush;
  bmp: TBitmap;
begin
  f := TBrush.Create(TBrushKind.Solid, claNull);
  Result := f;
  if Assigned(AStyle) then
  begin
    st := AStyle.FindStyleResource('gridstyle');
    if Assigned(st) then
    begin
      stobj := st.FindStyleResource('linefill');
      if Assigned(stobj) then
      begin
        if (stobj is TBrushObject) then
          f.Assign((stobj as TBrushObject).Brush)
        else if stobj is TCustomStyleObject then
        begin
          f.Kind := TBrushKind.Bitmap;
          f.Bitmap.WrapMode := TWrapMode.TileStretch;
          bmp := TBitmap.Create(Round(200), Round(200));
          if bmp.Canvas.BeginScene then
          begin
            (stobj as TCustomStyleObject).DrawToCanvas(bmp.Canvas, RectF(-10, -10, bmp.Width + 10, bmp.Height + 10));
            bmp.Canvas.EndScene;
          end;
          f.Bitmap.Bitmap.Assign(bmp);
          bmp.Free;
        end;
      end;
    end;
  end;
end;

class function TAdvChartStyles.GetStyleSelectionFill(
  AStyle: TFmxObject): TBrush;
var
  st, stobj: TFmxObject;
  f: TBrush;
  bmp: TBitmap;
begin
  f := TBrush.Create(TBrushKind.Solid, claNull);
  Result := f;
  if Assigned(AStyle) then
  begin
    st := AStyle.FindStyleResource('gridstyle');
    if Assigned(st) then
    begin
      stobj := st.FindStyleResource('selection');
      if Assigned(stobj) then
      begin
        if (stobj is TRectangle) then
          f.Assign((stobj as TRectangle).Fill)
        else if (stobj is TBrushObject) then
          f.Assign((stobj as TBrushObject).Brush)
        else if stobj is TCustomStyleObject then
        begin
          f.Kind := TBrushKind.Bitmap;
          f.Bitmap.WrapMode := TWrapMode.TileStretch;
          bmp := TBitmap.Create(Round(200), Round(200));
          if bmp.Canvas.BeginScene then
          begin
            (stobj as TCustomStyleObject).DrawToCanvas(bmp.Canvas, RectF(-10, -10, bmp.Width + 10, bmp.Height + 10));
            bmp.Canvas.EndScene;
          end;
          f.Bitmap.Bitmap.Assign(bmp);
          bmp.Free;
        end;
      end;
    end;
  end;
end;

class function TAdvChartStyles.GetStyleTextColor(
  AStyle: TFmxObject): TAlphaColor;
var
  st, stobj: TFmxObject;
begin
  Result := claBlack;
  if Assigned(AStyle) then
  begin
    st := AStyle.FindStyleResource('headeritemstyle');
    if Assigned(st) then
    begin
      stobj := st.FindStyleResource('text');
      if (Assigned(stobj) and (stobj is TText)) then
        Result := (stobj as TText).TextSettings.FontColor;
    end;
  end;
end;

class function TAdvChartStyles.GetStyleTextFont(AStyle: TFmxObject): TFont;
var
  st, stobj: TFmxObject;
begin
  Result := TFont.Create;
  if Assigned(AStyle) then
  begin
    st := AStyle.FindStyleResource('headeritemstyle');
    if Assigned(st) then
    begin
      stobj := st.FindStyleResource('text');
      if (Assigned(stobj) and (stobj is TText)) then
        Result.Assign((stobj as TText).TextSettings.Font);
    end;
  end;
end;
{$ENDIF}

{ TAdvChartStyles }

{$IFDEF FMXLIB}
class function TAdvChartStyles.ExtractColor(
  ABitmap: TBitmap): TAdvChartGraphicsColor;
var
  dt: TBitmapData;
begin
  Result := gcNull;
  if not Assigned(ABitmap) then
    Exit;
  if ABitmap.Map(TMapAccess.Read, dt) then
  begin
    Result := dt.GetPixel(dt.Width div 2, 1);
    ABitmap.Unmap(dt);
  end;
end;

class function TAdvChartStyles.ExtractColorTo(
  ABitmap: TBitmap): TAdvChartGraphicsColor;
var
  dt: TBitmapData;
begin
  Result := gcNull;
  if not Assigned(ABitmap) then
    Exit;
  if ABitmap.Map(TMapAccess.Read, dt) then
  begin
    Result := dt.GetPixel(dt.Width div 2, dt.Height - 1);
    ABitmap.Unmap(dt);
  end;
end;
{$ENDIF}

{$IFDEF WEBLIB}

class function TAdvChartStyles.GetStyleBackgroundFill: string;
begin
  Result := FindCSSStyleProperty('.AdvGridStyle', 'background');
end;

class function TAdvChartStyles.GetStyleBackgroundStroke: string;
begin
  Result := FindCSSStyleProperty('.AdvGridStyle', 'border-color');
end;

class function TAdvChartStyles.GetStyleDefaultButtonFill: string;
begin
  Result := FindCSSStyleProperty('.AdvButtonStyle', 'background');
end;

class function TAdvChartStyles.GetStyleDefaultButtonStroke: string;
begin
  Result := FindCSSStyleProperty('.AdvButtonStyle', 'border-color');
end;

class function TAdvChartStyles.GetStyleEditTextColor: string;
begin
  Result := FindCSSStyleProperty('.AdvChartEditStyle', '--foreground');
end;

class function TAdvChartStyles.GetStyleEditFill: string;
begin
  Result := FindCSSStyleProperty('.AdvChartEditStyle', 'background');
end;

class function TAdvChartStyles.GetStyleEditStroke: string;
begin
  Result := FindCSSStyleProperty('.AdvStyle', 'border-color');
end;

class function TAdvChartStyles.GetStyleHeaderFill: string;
begin
  Result := FindCSSStyleProperty('.AdvHeaderItemStyle', 'background');
end;

class function TAdvChartStyles.GetStyleHeaderStroke: string;
begin
  Result := FindCSSStyleProperty('.AdvHeaderItemStyle', 'border-color');
end;

class function TAdvChartStyles.GetStyleSelectionFill: string;
begin
  Result := FindCSSStyleProperty('.AdvGridStyle', '--selection');
end;

class function TAdvChartStyles.GetStyleAlternativeSelectionFill: string;
begin
  Result := FindCSSStyleProperty('.AdvMemoStyle', '--selection');
end;

class function TAdvChartStyles.GetStyleAlternativeBackgroundFill: string;
begin
  Result := FindCSSStyleProperty('.AdvMemoStyle', 'background');
end;

class function TAdvChartStyles.GetStyleAlternativeBackgroundStroke: string;
begin
  Result := FindCSSStyleProperty('.AdvMemoStyle', 'border-color');
end;

class function TAdvChartStyles.GetStyleFocusFill: string;
begin
  Result := FindCSSStyleProperty('.AdvGridStyle', '--focus');
end;

class function TAdvChartStyles.GetStyleLineFill: string;
begin
  Result := FindCSSStyleProperty('.AdvGridStyle', '--linefill');
end;

class function TAdvChartStyles.GetStyleTextFont: string;
begin
  Result := FindCSSStyleProperty('.AdvHeaderItemStyle', 'font-family');
end;

class function TAdvChartStyles.GetStyleTextColor: string;
begin
  Result := FindCSSStyleProperty('.AdvHeaderItemStyle', 'color');
end;

class function TAdvChartStyles.GetStyleAlternateBackgroundFill: string;
begin
  Result := FindCSSStyleProperty('.AdvGridStyle', '--alternatingrowbackground');
end;

class function TAdvChartStyles.ExtractColor(AValue: string): TAdvChartGraphicsColor;
var
  s, s2, s3: string;
  sl, sl2: TStringList;
  p, p2: Integer;

  function ParseValue(AValue: string): Integer;
  begin
    Result := StrToInt(Trim(StringReplace(AValue, 'rgb(', '', [rfReplaceAll])))
  end;
begin
  Result := gcNull;
  if AValue <> '' then
  begin
    s := LowerCase(StringReplace(AValue, ' ', '', [rfReplaceAll]));
    if Pos('linear-gradient', s) = 1 then
    begin
      p := Pos('rgb', s);
      if p = 0 then
        p := Pos('#', s);
      p2 := Pos(')', s, p);
      s2 := Copy(s, p, p2 - p + 1);
      p := Pos('rgb', s, p2);
      if p = 0 then
        p := Pos('#', s);
      p2 := Pos(')', s, p);
      s3 := Copy(s, p, p2 - p + 1);
      Result := ExtractColor(s2);
    end
    else if Pos('rgb', s) = 1 then
    begin
      sl := TStringList.Create;
      try
        sl.Delimiter := ',';
        sl.DelimitedText := s;
        Result := MakeGraphicsColor(ParseValue(sl[0]), ParseValue(sl[1]), ParseValue(sl[2]));
      finally
        sl.Free;
      end;
    end
    else if Pos('#', s) = 1 then
      Result := HexToColor(s);
  end;
end;

class function TAdvChartStyles.ExtractColorTo(AValue: string): TAdvChartGraphicsColor;
var
  s, s2, s3: string;
  sl, sl2: TStringList;
  p, p2: Integer;

  function ParseValue(AValue: string): Integer;
  begin
    Result := StrToInt(Trim(StringReplace(AValue, 'rgb(', '', [rfReplaceAll])))
  end;
begin
  Result := gcNull;
  if AValue <> '' then
  begin
    s := LowerCase(StringReplace(AValue, ' ', '', [rfReplaceAll]));
    if Pos('linear-gradient', s) = 1 then
    begin
      p := Pos('rgb', s);
      if p = 0 then
        p := Pos('#', s);
      p2 := Pos(')', s, p);
      s2 := Copy(s, p, p2 - p + 1);
      p := Pos('rgb', s, p2);
      if p = 0 then
        p := Pos('#', s);
      p2 := Pos(')', s, p);
      s3 := Copy(s, p, p2 - p + 1);
      Result := ExtractColor(s3);
    end
    else if Pos('rgb', s) = 1 then
    begin
      sl := TStringList.Create;
      try
        sl.Delimiter := ',';
        sl.DelimitedText := s;
        Result := MakeGraphicsColor(ParseValue(sl[0]), ParseValue(sl[1]), ParseValue(sl[2]));
      finally
        sl.Free;
      end;
    end
    else if Pos('#', s) = 1 then
      Result := HexToColor(s);
  end;
end;

class function TAdvChartStyles.ExtractFontName(AValue: string): string;
begin
  Result := AValue;
end;

class function TAdvChartStyles.FindCSSStyleProperty(ARuleName, APropertyName: string): string;
var
  j: TJSObject;
  s: string;
  v: string;
begin
  Result := '';
  j := FindCSSStyleRule(ARuleName);
  if Assigned(j) then
  begin
    s := APropertyName;
    asm
      v = j.style.getPropertyValue(s);
    end;
    Result := v;
  end;
end;

class function TAdvChartStyles.FindCSSStyleRule(ARuleName: string): TJSObject;
var
  s, f: string;
begin
  Result := nil;
  s := ARuleName;
  f := CSSStyleFileName;
  asm
    for (var i = 0; i < document.styleSheets.length; i++){
      var fn = document.styleSheets[i].href;
      if (fn != null) {
      if (f == fn.substring(fn.lastIndexOf('/')+1)){
        var classes = document.styleSheets[i].rules || document.styleSheets[i].cssRules;
        for (var x = 0; x < classes.length; x++) {
            if (classes[x].selectorText.startsWith(s)) {
                return classes[x];
            }
        }
       }
      }
    }
  end;
end;
{$ENDIF}

{$IFDEF VCLSTYLESENABLED}
class function TAdvChartStyles.ExtractColor(AElement: TThemedElementDetails): TAdvChartGraphicsColor;
var
  bmp: TBitmap;
begin
  bmp := TBitmap.Create;
  try
    bmp.SetSize(200, 200);
    StyleServices.DrawElement(bmp.Canvas.Handle, AElement, Rect(0, 0, 200, 200));
    Result := bmp.Canvas.Pixels[bmp.Width div 2, 2];
  finally
    bmp.Free;
  end;
end;

class function TAdvChartStyles.ExtractColorTo(AElement: TThemedElementDetails): TAdvChartGraphicsColor;
var
  bmp: TBitmap;
begin
  bmp := TBitmap.Create;
  try
    bmp.SetSize(200, 200);
    StyleServices.DrawElement(bmp.Canvas.Handle, AElement, Rect(0, 0, 200, 200));
    Result := bmp.Canvas.Pixels[bmp.Width div 2, bmp.Height - 2];
  finally
    bmp.Free;
  end;
end;
{$ENDIF}

class function TAdvChartStyles.GetStyleBackgroundFillColor(var AColor: TAdvChartGraphicsColor): Boolean;
{$IFDEF FMXLIB}
var
  f: TBrush;
{$ENDIF}
{$IFDEF VCLSTYLESENABLED}
var
  l: TThemedElementDetails;
  c: TColor;
{$ENDIF}
{$IFDEF WEBLIB}
var
  f: string;
  c: TAdvChartGraphicsColor;
{$ENDIF}
begin
  Result := False;
  if StyleServicesEnabled then
  begin
    {$IFDEF FMXLIB}
    f := GetStyleBackgroundFill(GetStyleSceneObject);
    if Assigned(f) then
    begin
      AColor := ParseBrush(f, False);
      Result := AColor <> claNull;
      f.Free;
    end;
    {$ENDIF}
    {$IFDEF VCLSTYLESENABLED}
    l := StyleServices.GetElementDetails(tgCellNormal);
    c := clNone;
    StyleServices.GetElementColor(l, ecFillColor, c);
    if c = clNone then
      c := ExtractColor(l);

    AColor := c;
    Result := c <> clNone;
    {$ENDIF}
    {$IFDEF WEBLIB}
    f := GetStyleBackgroundFill;
    if f <> '' then
    begin
      c := ExtractColor(f);
      AColor := c;
      Result := c <> gcNull;
    end;
    {$ENDIF}
  end;
end;

class function TAdvChartStyles.GetStyleBackgroundFillColorTo(var AColor: TAdvChartGraphicsColor): Boolean;
{$IFDEF FMXLIB}
var
  f: TBrush;
{$ENDIF}
{$IFDEF VCLSTYLESENABLED}
var
  l: TThemedElementDetails;
  c: TColor;
{$ENDIF}
{$IFDEF WEBLIB}
var
  f: string;
  c: TAdvChartGraphicsColor;
{$ENDIF}
begin
  Result := False;
  if StyleServicesEnabled then
  begin
    {$IFDEF FMXLIB}
    f := GetStyleBackgroundFill(GetStyleSceneObject);
    if Assigned(f) then
    begin
      AColor := ParseBrush(f, True);
      Result := AColor <> claNull;
      f.Free;
    end;
    {$ENDIF}
    {$IFDEF VCLSTYLESENABLED}
    l := StyleServices.GetElementDetails(tgGradientCellNormal);
    c := clNone;
    StyleServices.GetElementColor(l, ecFillColor, c);
    if c = clNone then
      c := ExtractColorTo(l);

    AColor := c;
    Result := c <> clNone;
    {$ENDIF}
    {$IFDEF WEBLIB}
    f := GetStyleBackgroundFill;
    if f <> '' then
    begin
      c := ExtractColorTo(f);
      AColor := c;
      Result := c <> gcNull;
    end;
    {$ENDIF}
  end;
end;

class function TAdvChartStyles.GetStyleAlternativeBackgroundFillColor(var AColor: TAdvChartGraphicsColor): Boolean;
{$IFDEF FMXLIB}
var
  f: TBrush;
{$ENDIF}
{$IFDEF VCLSTYLESENABLED}
var
  l: TThemedElementDetails;
  c: TColor;
{$ENDIF}
{$IFDEF WEBLIB}
var
  f: string;
  c: TAdvChartGraphicsColor;
{$ENDIF}
begin
  Result := False;
  if StyleServicesEnabled then
  begin
    {$IFDEF FMXLIB}
    f := GetStyleAlternativeBackgroundFill(GetStyleSceneObject);
    if Assigned(f) then
    begin
      AColor := ParseBrush(f, False);
      Result := AColor <> claNull;
      f.Free;
    end;
    {$ENDIF}
    {$IFDEF VCLSTYLESENABLED}
    l := StyleServices.GetElementDetails(teBackgroundNormal);
    c := ExtractColor(l);
    AColor := c;
    Result := c <> clNone;
    {$ENDIF}
    {$IFDEF WEBLIB}
    f := GetStyleAlternativeBackgroundFill;
    if f <> '' then
    begin
      c := ExtractColor(f);
      AColor := c;
      Result := c <> gcNull;
    end;
    {$ENDIF}
  end;
end;

class function TAdvChartStyles.GetStyleAlternativeBackgroundFillColorTo(var AColor: TAdvChartGraphicsColor): Boolean;
{$IFDEF FMXLIB}
var
  f: TBrush;
{$ENDIF}
{$IFDEF VCLSTYLESENABLED}
var
  l: TThemedElementDetails;
  c: TColor;
{$ENDIF}
{$IFDEF WEBLIB}
var
  f: string;
  c: TAdvChartGraphicsColor;
{$ENDIF}
begin
  Result := False;
  if StyleServicesEnabled then
  begin
    {$IFDEF FMXLIB}
    f := GetStyleAlternativeBackgroundFill(GetStyleSceneObject);
    if Assigned(f) then
    begin
      AColor := ParseBrush(f, True);
      Result := AColor <> claNull;
      f.Free;
    end;
    {$ENDIF}
    {$IFDEF VCLSTYLESENABLED}
    l := StyleServices.GetElementDetails(teBackgroundNormal);
    c := clNone;
    StyleServices.GetElementColor(l, ecGradientColor1, c);
    AColor := c;
    Result := c <> clNone;
    {$ENDIF}
    {$IFDEF WEBLIB}
    f := GetStyleAlternativeBackgroundFill;
    if f <> '' then
    begin
      c := ExtractColorTo(f);
      AColor := c;
      Result := c <> gcNull;
    end;
    {$ENDIF}
  end;
end;

class function TAdvChartStyles.GetStyleBackgroundStrokeColor(var AColor: TAdvChartGraphicsColor): Boolean;
{$IFDEF FMXLIB}
var
  s: TStrokeBrush;
{$ENDIF}
{$IFDEF VCLSTYLESENABLED}
var
  l: TThemedElementDetails;
  c: TColor;
{$ENDIF}
{$IFDEF WEBLIB}
var
  f: string;
  c: TAdvChartGraphicsColor;
{$ENDIF}
begin
  Result := False;
  if StyleServicesEnabled then
  begin
    {$IFDEF FMXLIB}
    s := GetStyleBackgroundStroke(GetStyleSceneObject);
    if Assigned(s) then
    begin
      AColor := ParseBrush(s, False);
      Result := AColor <> claNull;
      s.Free;
    end;
    {$ENDIF}
    {$IFDEF VCLSTYLESENABLED}
    l := StyleServices.GetElementDetails(tgCellNormal);
    c := clNone;
    StyleServices.GetElementColor(l, ecBorderColor, c);
    AColor := c;
    Result := c <> clNone;
    {$ENDIF}
    {$IFDEF WEBLIB}
    f := GetStyleBackgroundStroke;
    if f <> '' then
    begin
      c := ExtractColor(f);
      AColor := c;
      Result := c <> gcNull;
    end;
    {$ENDIF}
  end;
end;

class function TAdvChartStyles.GetStyleDefaultButtonFillColor(var AColor: TAdvChartGraphicsColor): Boolean;
{$IFDEF FMXLIB}
var
  f: TBrush;
{$ENDIF}
{$IFDEF VCLSTYLESENABLED}
var
  l: TThemedElementDetails;
  c: TColor;
{$ENDIF}
{$IFDEF WEBLIB}
var
  f: string;
  c: TAdvChartGraphicsColor;
{$ENDIF}
begin
  Result := False;
  if StyleServicesEnabled then
  begin
    {$IFDEF FMXLIB}
    f := GetStyleDefaultButtonFill(GetStyleSceneObject);
    if Assigned(f) then
    begin
      AColor := ParseBrush(f, False);
      Result := AColor <> claNull;
      f.Free;
    end;
    {$ENDIF}
    {$IFDEF VCLSTYLESENABLED}
    l := StyleServices.GetElementDetails(tcbButtonNormal);
    c := ExtractColor(l);
    AColor := c;
    Result := c <> clNone;
    {$ENDIF}
    {$IFDEF WEBLIB}
    f := GetStyleDefaultButtonFill;
    if f <> '' then
    begin
      c := ExtractColor(f);
      AColor := c;
      Result := c <> gcNull;
    end;
    {$ENDIF}
  end;
end;

class function TAdvChartStyles.GetStyleDefaultButtonStrokeColor(var AColor: TAdvChartGraphicsColor): Boolean;
{$IFDEF FMXLIB}
var
  s: TStrokeBrush;
{$ENDIF}
{$IFDEF VCLSTYLESENABLED}
var
  l: TThemedElementDetails;
  c: TColor;
{$ENDIF}
{$IFDEF WEBLIB}
var
  f: string;
  c: TAdvChartGraphicsColor;
{$ENDIF}
begin
  Result := False;
  if StyleServicesEnabled then
  begin
    {$IFDEF FMXLIB}
    s := GetStyleDefaultButtonStroke(GetStyleSceneObject);
    if Assigned(s) then
    begin
      AColor := ParseBrush(s, False);
      Result := AColor <> claNull;
      s.Free;
    end;
    {$ENDIF}
    {$IFDEF VCLSTYLESENABLED}
    l := StyleServices.GetElementDetails(tcbButtonNormal);
    c := clNone;
    StyleServices.GetElementColor(l, ecBorderColor, c);
    AColor := c;
    Result := c <> clNone;
    {$ENDIF}
    {$IFDEF WEBLIB}
    f := GetStyleDefaultButtonStroke;
    if f <> '' then
    begin
      c := ExtractColor(f);
      AColor := c;
      Result := c <> gcNull;
    end;
    {$ENDIF}
  end;
end;

class function TAdvChartStyles.GetStyleHeaderFillColor(var AColor: TAdvChartGraphicsColor): Boolean;
{$IFDEF FMXLIB}
var
  f: TBrush;
{$ENDIF}
{$IFDEF VCLSTYLESENABLED}
var
  l: TThemedElementDetails;
  c: TColor;
{$ENDIF}
{$IFDEF WEBLIB}
var
  f: string;
  c: TAdvChartGraphicsColor;
{$ENDIF}
begin
  Result := False;
  if StyleServicesEnabled then
  begin
    {$IFDEF FMXLIB}
    f := GetStyleHeaderFill(GetStyleSceneObject);
    if Assigned(f) then
    begin
      AColor := ParseBrush(f, False);
      Result := AColor <> claNull;
      f.Free;
    end;
    {$ENDIF}
    {$IFDEF VCLSTYLESENABLED}
    l := StyleServices.GetElementDetails(tgFixedCellNormal);
    c := ExtractColor(l);
    AColor := c;
    Result := c <> clNone;
    {$ENDIF}
    {$IFDEF WEBLIB}
    f := GetStyleHeaderFill;
    if f <> '' then
    begin
      c := ExtractColor(f);
      AColor := c;
      Result := c <> gcNull;
    end;
    {$ENDIF}
  end;
end;

class function TAdvChartStyles.GetStyleHeaderFillColorTo(var AColor: TAdvChartGraphicsColor): Boolean;
{$IFDEF FMXLIB}
var
  f: TBrush;
{$ENDIF}
{$IFDEF VCLSTYLESENABLED}
var
  l: TThemedElementDetails;
  c: TColor;
{$ENDIF}
{$IFDEF WEBLIB}
var
  f: string;
  c: TAdvChartGraphicsColor;
{$ENDIF}
begin
  Result := False;
  if StyleServicesEnabled then
  begin
    {$IFDEF FMXLIB}
    f := GetStyleHeaderFill(GetStyleSceneObject);
    if Assigned(f) then
    begin
      AColor := ParseBrush(f, True);
      Result := AColor <> claNull;
      f.Free;
    end;
    {$ENDIF}
    {$IFDEF VCLSTYLESENABLED}
    l := StyleServices.GetElementDetails(tgFixedCellNormal);
    c := ExtractColorTo(l);
    AColor := c;
    Result := c <> clNone;
    {$ENDIF}
    {$IFDEF WEBLIB}
    f := GetStyleHeaderFill;
    if f <> '' then
    begin
      c := ExtractColorTo(f);
      AColor := c;
      Result := c <> gcNull;
    end;
    {$ENDIF}
  end;
end;

class function TAdvChartStyles.GetStyleHeaderStrokeColor(var AColor: TAdvChartGraphicsColor): Boolean;
{$IFDEF FMXLIB}
var
  s: TStrokeBrush;
{$ENDIF}
{$IFDEF VCLSTYLESENABLED}
var
  l: TThemedElementDetails;
  c: TColor;
{$ENDIF}
{$IFDEF WEBLIB}
var
  f: string;
  c: TAdvChartGraphicsColor;
{$ENDIF}
begin
  Result := False;
  if StyleServicesEnabled then
  begin
    {$IFDEF FMXLIB}
    s := GetStyleHeaderStroke(GetStyleSceneObject);
    if Assigned(s) then
    begin
      AColor := ParseBrush(s, False);
      Result := AColor <> claNull;
      s.Free;
    end;
    {$ENDIF}
    {$IFDEF VCLSTYLESENABLED}
    l := StyleServices.GetElementDetails(tgFixedCellNormal);
    c := clNone;
    StyleServices.GetElementColor(l, ecBorderColor, c);
    AColor := c;
    Result := c <> clNone;
    {$ENDIF}
    {$IFDEF WEBLIB}
    f := GetStyleHeaderStroke;
    if f <> '' then
    begin
      c := ExtractColor(f);
      AColor := c;
      Result := c <> gcNull;
    end;
    {$ENDIF}
  end;
end;

class function TAdvChartStyles.GetStyleLineFillColor(
  var AColor: TAdvChartGraphicsColor): Boolean;
{$IFDEF FMXLIB}
var
  f: TBrush;
{$ENDIF}
{$IFDEF VCLSTYLESENABLED}
var
  l: TThemedElementDetails;
  c: TColor;
{$ENDIF}
{$IFDEF WEBLIB}
var
  f: string;
  c: TAdvChartGraphicsColor;
{$ENDIF}
begin
  Result := False;
  if StyleServicesEnabled then
  begin
    {$IFDEF FMXLIB}
    f := GetStyleLineFill(GetStyleSceneObject);
    if Assigned(f) then
    begin
      AColor := ParseBrush(f, False);
      Result := AColor <> claNull;
      f.Free;
    end;
    {$ENDIF}
    {$IFDEF VCLSTYLESENABLED}
    l := StyleServices.GetElementDetails(tgCellNormal);
    c := clNone;
    StyleServices.GetElementColor(l, ecBorderColor, c);
    AColor := c;
    Result := c <> clNone;
    {$ENDIF}
    {$IFDEF WEBLIB}
    f := GetStyleLineFill;
    if f <> '' then
    begin
      c := ExtractColor(f);
      AColor := c;
      Result := c <> gcNull;
    end;
    {$ENDIF}
  end;
end;

class function TAdvChartStyles.GetStyleSelectionFillColor(var AColor: TAdvChartGraphicsColor): Boolean;
{$IFDEF FMXLIB}
var
  f: TBrush;
{$ENDIF}
{$IFDEF VCLSTYLESENABLED}
var
  l: TThemedElementDetails;
  c: TColor;
{$ENDIF}
{$IFDEF WEBLIB}
var
  f: string;
  c: TAdvChartGraphicsColor;
{$ENDIF}
begin
  Result := False;
  if StyleServicesEnabled then
  begin
    {$IFDEF FMXLIB}
    f := GetStyleSelectionFill(GetStyleSceneObject);
    if Assigned(f) then
    begin
      AColor := ParseBrush(f, False);
      Result := AColor <> claNull;
      f.Free;
    end;
    {$ENDIF}
    {$IFDEF VCLSTYLESENABLED}
    l := StyleServices.GetElementDetails(tgCellSelected);
    c := clNone;
    StyleServices.GetElementColor(l, ecFillColor, c);
    c := ExtractColor(l);
    AColor := c;
    Result := c <> clNone;
    {$ENDIF}
    {$IFDEF WEBLIB}
    f := GetStyleSelectionFill;
    if f <> '' then
    begin
      c := ExtractColor(f);
      AColor := c;
      Result := c <> gcNull;
    end;
    {$ENDIF}
  end;
end;

class function TAdvChartStyles.GetStyleSelectionFillColorTo(var AColor: TAdvChartGraphicsColor): Boolean;
{$IFDEF FMXLIB}
var
  f: TBrush;
{$ENDIF}
{$IFDEF VCLSTYLESENABLED}
var
  l: TThemedElementDetails;
  c: TColor;
{$ENDIF}
{$IFDEF WEBLIB}
var
  f: string;
  c: TAdvChartGraphicsColor;
{$ENDIF}
begin
  Result := False;
  if StyleServicesEnabled then
  begin
    {$IFDEF FMXLIB}
    f := GetStyleSelectionFill(GetStyleSceneObject);
    if Assigned(f) then
    begin
      AColor := ParseBrush(f, True);
      Result := AColor <> claNull;
      f.Free;
    end;
    {$ENDIF}
    {$IFDEF VCLSTYLESENABLED}
    l := StyleServices.GetElementDetails(tgCellSelected);
    c := clNone;
    StyleServices.GetElementColor(l, ecFillColor, c);
    c := ExtractColorTo(l);
    AColor := c;
    Result := c <> clNone;
    {$ENDIF}
    {$IFDEF WEBLIB}
    f := GetStyleSelectionFill;
    if f <> '' then
    begin
      c := ExtractColorTo(f);
      AColor := c;
      Result := c <> gcNull;
    end;
    {$ENDIF}
  end;
end;

class function TAdvChartStyles.GetStyleTextFontColor(var AColor: TAdvChartGraphicsColor): Boolean;
{$IFDEF VCLSTYLESENABLED}
var
  l: TThemedElementDetails;
  c: TColor;
{$ENDIF}
{$IFDEF WEBLIB}
var
  f: string;
  c: TAdvChartGraphicsColor;
{$ENDIF}
begin
  Result := False;
  if StyleServicesEnabled then
  begin
    {$IFDEF FMXLIB}
    AColor := GetStyleTextColor(GetStyleSceneObject);
    Result := AColor <> claNull;
    {$ENDIF}
    {$IFDEF VCLSTYLESENABLED}
    AColor := gcBlack;
    l := StyleServices.GetElementDetails(tgCellNormal);
    c := clNone;
    StyleServices.GetElementColor(l, ecTextColor, c);
    AColor := c;
    Result := c <> clNone;
    {$ENDIF}
    {$IFDEF WEBLIB}
    f := GetStyleTextColor;
    if f <> '' then
    begin
      c := ExtractColor(f);
      AColor := c;
      Result := c <> gcNull;
    end;
    {$ENDIF}
  end;
end;

class function TAdvChartStyles.GetStyleAlternativeTextFontColor(var AColor: TAdvChartGraphicsColor): Boolean;
{$IFDEF VCLSTYLESENABLED}
var
  l: TThemedElementDetails;
  c: TColor;
{$ENDIF}
{$IFDEF WEBLIB}
var
  f: string;
  c: TAdvChartGraphicsColor;
{$ENDIF}
begin
  Result := False;
  if StyleServicesEnabled then
  begin
    {$IFDEF FMXLIB}
    AColor := GetStyleEditTextColor(GetStyleSceneObject);
    Result := AColor <> claNull;
    {$ENDIF}
    {$IFDEF VCLSTYLESENABLED}
    AColor := gcBlack;
    l := StyleServices.GetElementDetails(tgCellSelected);
    c := clNone;
    StyleServices.GetElementColor(l, ecTextColor, c);
    AColor := c;
    Result := c <> clNone;
    {$ENDIF}
    {$IFDEF WEBLIB}
    f := GetStyleEditTextColor;
    if f <> '' then
    begin
      c := ExtractColor(f);
      AColor := c;
      Result := c <> gcNull;
    end;
    {$ENDIF}
  end;
end;

{$IFDEF FMXLIB}
class procedure TAdvChartStyles.SetActiveScene(AScene: IScene);
begin
  if Assigned(AScene) and Assigned(AScene.GetObject) and (AScene.GetObject.ClassName <> 'TAdvChartCustomPopupForm') then
    FScene := AScene
  else if not Assigned(AScene) then
    FScene := nil;
end;
{$ENDIF}

class function TAdvChartStyles.StyleServicesEnabled: Boolean;
{$IFDEF FMXLIB}
var
  s: TFmxObject;
{$ENDIF}
begin
  {$IFDEF WEBLIB}
  Result := True;
  {$ENDIF}
  {$IFDEF LCLLIB}
  Result := False;
  {$ENDIF}
  {$IFDEF FMXLIB}
  s := GetStyleSceneObject;
  Result := Assigned(s);
  {$ENDIF}
  {$IFDEF VCLLIB}
  {$IFDEF VCLSTYLESENABLED}
  {$HINTS OFF}
  {$IF COMPILERVERSION >= 34}
  Result := StyleServices.Enabled and (StyleServices.Name <> 'Windows') and (StyleServices.Name <> 'Windows10');
  {$IFEND}
  {$IF COMPILERVERSION < 34}
  Result := (StyleServices.Enabled) and (StyleServices.Name <> 'Windows');
  {$IFEND}
  {$HINTS ON}
  {$ENDIF}
  {$IFNDEF VCLSTYLESENABLED}
  Result := False;
  {$ENDIF}
  {$ENDIF}
end;

{$IFDEF FNCLIB}

{ TAdvStyleManager }

function TAdvChartStylesManager.GetDocURL: string;
begin
  Result := TAdvChartBaseDocURL + 'tmsfnccore/components/ttmsfncstyling';
end;

procedure TAdvChartStylesManager.DoCanLoadStyle(AStyle: string;
  AComponent: TComponent; var ACanLoadStyle: Boolean);
begin
  if Assigned(OnCanLoadStyle) then
    OnCanLoadStyle(Self, AStyle, AComponent, ACanLoadStyle);
end;

constructor TAdvChartStylesManager.Create(AOwner: TComponent);
begin
  inherited;
  FOptions := TAdvChartStylesManagerOptions.Create;
end;

destructor TAdvChartStylesManager.Destroy;
begin
  FOptions.Free;
  inherited;
end;

procedure TAdvChartStylesManager.DoStyleLoaded(AStyle: string;
  AComponent: TComponent);
begin
  if Assigned(OnStyleLoaded) then
    OnStyleLoaded(Self, AStyle, AComponent);
end;

procedure TAdvChartStylesManager.InternalLoadStyle(AValue: string; AComponents: TAdvChartStylesManagerComponentArray);
var
  v, jv, va, fc: TJSONValue;
  fcs: string;
  ja: TJSONArray;
  I: Integer;
  f: TCustomForm;
  c: TAdvChartGraphicsColor;
begin
  v := TAdvChartUtils.ParseJSON(AValue);
  if Assigned(v) then
  begin
    try
      if Options.AdaptFormColor then
      begin
        fc := TAdvChartUtils.GetJSONValue(v, 'FormColor');
        if Assigned(fc) then
        begin
          fcs := TAdvChartUtils.GetJSONProp(v, 'FormColor');
          f := StyleForm;
          if not Assigned(f) then
            f := TAdvChartUtils.GetOwnerForm(Self);

          if Assigned(f) then
          begin
            c := TAdvChartGraphics.HTMLToColor(fcs);
            {$IFDEF FMXLIB}
            f.Fill.Kind := TBrushKind.Solid;
            f.Fill.Color := c;
            {$ELSE}
            f.Color := c;
            {$ENDIF}
          end;
        end;
      end;

      va := TAdvChartUtils.GetJSONValue(v, 'Styles');
      if va is TJSONArray then
      begin
        ja := va as TJSONArray;
        for I := 0 to TAdvChartUtils.GetJSONArraySize(ja) - 1 do
        begin
          jv := TAdvChartUtils.GetJSONArrayItem(ja, I);
          if Assigned(jv) then
            InternalLoadStyleFromJSONValue(jv, AComponents);
        end;
      end
      else
      begin
        if Assigned(v) then
          InternalLoadStyleFromJSONValue(v, AComponents);
      end;
    finally
      v.Free;
    end;
  end;
end;

procedure TAdvChartStylesManager.InternalLoadStyleFromJSONValue(
  AJSONValue: TJSONValue; AComponents: TAdvChartStylesManagerComponentArray);
var
  ct: string;
  I, K: Integer;
  f: TCustomForm;
  io: IAdvChartPersistence;
  s: TStringStream;
  st: string;
  b: Boolean;
  sm: IAdvChartStylesManager;
  arr: TAdvChartStylesManagerComponentArray;

  function IsComponentInArray(AComponent: TComponent): Boolean;
  var
    K: Integer;
  begin
    if Assigned(AComponents) and (Length(AComponents) = 0) or not Assigned(AComponents) then
      Result := True
    else
    begin
      Result := False;
      for K := 0 to Length(AComponents) - 1 do
      begin
        if AComponents[K] = AComponent then
        begin
          Result := True;
          Break;
        end;
      end;
    end;
  end;

  procedure ApplyStyleToComponent(AComponent: TComponent);
  begin
    if not Assigned(AComponent) then
      Exit;

    if (AComponent.ClassName = ct) and IsComponentInArray(AComponent) then
    begin
      if Supports(AComponent, IAdvChartPersistence, io) then
      begin
        st := TAdvChartUtils.GetJSONValueAsString(AJSONValue);
        b := True;
        DoCanLoadStyle(st, AComponent, b);
        if b then
        begin
          s := TStringStream.Create(st);
          try
            io.LoadSettingsFromStream(s);
          finally
            s.Free;
          end;

          DoStyleLoaded(st, AComponent);
        end;
      end;
    end;
  end;
begin
  f := StyleForm;
  if not Assigned(f) then
    f := TAdvChartUtils.GetOwnerForm(Self);

  if not Assigned(f) then
    Exit;

  if Assigned(AJSONValue) then
  begin
    ct := TAdvChartUtils.GetJSONProp(AJSONValue, TAdvChartPersistence.ClassTypeVariable);
    if ct <> '' then
    begin
      for I := f.ComponentCount - 1 downto 0 do
      begin
        ApplyStyleToComponent(f.Components[I]);
        if Supports(f.Components[I], IAdvChartStylesManager, sm) then
        begin
          arr := sm.GetSubComponentArray;
          for K := 0 to Length(arr) - 1 do
            ApplyStyleToComponent(arr[K]);
        end;
      end;
    end;
  end;
end;

{$IFNDEF WEBLIB}
function TAdvChartStylesManager.CombineStyles(AFiles: TAdvChartStylesManagerFileArray): string;
var
  I: Integer;
  sl: TStringList;
begin
  Result := '';
  if Length(AFiles) = 0 then
    Exit;

  Result := '{';
  Result := Result + '"Styles": [';
  sl := TStringList.Create;
  try
    for I := 0 to Length(AFiles) - 1 do
    begin
      if FileExists(AFiles[I]) then
        sl.LoadFromFile(AFiles[I])
      else
        sl.Text := AFiles[I];

      Result := Result + sl.Text;
      if I < Length(AFiles) - 1 then
        Result := Result + ',';
    end;
  finally
    sl.Free;
  end;
  Result := Result + ']}';
end;

function TAdvChartStylesManager.GetStyleFromFile(AFile: string): string;
var
  ss: {$IFDEF LCLLIB}TStringList{$ELSE}TStringStream{$ENDIF};
begin
  Result := '';
  {$IFNDEF WEBLIB}
  if not FileExists(AFile) then
    Exit;
  {$ENDIF}

  ss := {$IFDEF LCLLIB}TStringList{$ELSE}TStringStream{$ENDIF}.Create;
  try
    {$IFNDEF WEBLIB}
    ss.LoadFromFile(AFile);
    Result := {$IFDEF LCLLIB}ss.Text{$ELSE}ss.DataString{$ENDIF};
    {$ENDIF}
  finally
    {$IFNDEF WEBLIB}
    ss.Free;
    {$ENDIF}
  end;
end;

function TAdvChartStylesManager.GetStyleFromResource(AResourceName: string): string;
var
  r: TResourceStream;
  ss: {$IFDEF LCLLIB}TStringList{$ELSE}TStringStream{$ENDIF};
begin
  Result := '';
  r := nil;
  try
    r := TAdvChartUtils.GetResourceStream(AResourceName, HInstance);
    if Assigned(r) then
    begin
      ss := {$IFDEF LCLLIB}TStringList{$ELSE}TStringStream{$ENDIF}.Create;
      try
        ss.LoadFromStream(r);
        Result := {$IFDEF LCLLIB}ss.Text{$ELSE}ss.DataString{$ENDIF};
      finally
        ss.Free;
      end;
    end;
  finally
    if Assigned(r) then
      r.Free;
  end;
end;

procedure TAdvChartStylesManager.LoadStyleFromResource(AResourceName: string; AComponents: TAdvChartStylesManagerComponentArray);
var
  r: TResourceStream;
begin
  r := nil;
  try
    r := TAdvChartUtils.GetResourceStream(AResourceName, HInstance);
    if Assigned(r) then
      LoadStyleFromStream(r, AComponents);
  finally
    if Assigned(r) then
      r.Free;
  end;
end;

procedure TAdvChartStylesManager.LoadStyleFromResource(AResourceName: string);
var
  a: TAdvChartStylesManagerComponentArray;
begin
  SetLength(a, 0);
  LoadStyleFromResource(AResourceName, a);
end;
{$ENDIF}

{$IFDEF WEBLIB}
procedure TAdvChartStylesManager.LoadStyleFromURL(AURL: string);
var
  a: TAdvChartStylesManagerComponentArray;
begin
  SetLength(a, 0);
  LoadStyleFromFile(AURL, a);
end;

procedure TAdvChartStylesManager.LoadStyleFromURL(AURL: string; AComponents: TAdvChartStylesManagerComponentArray);
begin
  LoadStyleFromFile(AURL, AComponents);
end;
{$ENDIF}

procedure TAdvChartStylesManager.LoadStyleFromFile(AFile: string);
var
  a: TAdvChartStylesManagerComponentArray;
begin
  SetLength(a, 0);
  LoadStyleFromFile(AFile, a);
end;

procedure TAdvChartStylesManager.LoadStyleFromFile(AFile: string; AComponents: TAdvChartStylesManagerComponentArray);
var
  ss: {$IFDEF LCLLIB}TStringList{$ELSE}TStringStream{$ENDIF};
begin
  {$IFNDEF WEBLIB}
  if not FileExists(AFile) then
    Exit;
  {$ENDIF}

  ss := {$IFDEF LCLLIB}TStringList{$ELSE}TStringStream{$ENDIF}.Create;
  try
    {$IFDEF WEBLIB}
    FComponents := AComponents;
    {$ENDIF}
    ss.LoadFromFile(AFile {$IFDEF WEBLIB}, procedure begin{$ELSE});{$ENDIF}
    InternalLoadStyle({$IFDEF LCLLIB}ss.Text{$ELSE}ss.DataString{$ENDIF}, AComponents);
    {$IFDEF WEBLIB}
    ss.Free;
    end);
    {$ENDIF}
  finally
    {$IFNDEF WEBLIB}
    ss.Free;
    {$ENDIF}
  end;
end;

procedure TAdvChartStylesManager.LoadStyleFromStream(AStream: TStream);
var
  a: TAdvChartStylesManagerComponentArray;
begin
  SetLength(a, 0);
  LoadStyleFromStream(AStream, a);
end;

procedure TAdvChartStylesManager.LoadStyleFromStream(AStream: TStream; AComponents: TAdvChartStylesManagerComponentArray);
var
  ss: {$IFDEF LCLLIB}TStringList{$ELSE}TStringStream{$ENDIF};
begin
  ss := {$IFDEF LCLLIB}TStringList{$ELSE}TStringStream{$ENDIF}.Create;
  try
    ss.LoadFromStream(AStream);
    InternalLoadStyle({$IFDEF LCLLIB}ss.Text{$ELSE}ss.DataString{$ENDIF}, AComponents);
  finally
    ss.Free;
  end;
end;

procedure TAdvChartStylesManager.LoadStyleFromText(AText: string);
var
  a: TAdvChartStylesManagerComponentArray;
begin
  SetLength(a, 0);
  InternalLoadStyle(AText, a);
end;

procedure TAdvChartStylesManager.LoadStyleFromText(AText: string; AComponents: TAdvChartStylesManagerComponentArray);
begin
  InternalLoadStyle(AText, AComponents);
end;

procedure TAdvChartStylesManager.SetStyle(const Value: string);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    LoadStyleFromFile(FStyle);
  end;
end;

procedure TAdvChartStylesManager.SetOptions(const Value: TAdvChartStylesManagerOptions);
begin
  FOptions.Assign(Value);
end;

procedure TAdvChartStylesManager.SetStyleResource(const Value: string);
begin
  if FStyleResource <> Value then
  begin
    FStyleResource := Value;
    if FStyleResource <> '' then
    begin
      {$IFNDEF WEBLIB}
      LoadStyleFromResource('TAdvSTYLE_' + FStyleResource);
      {$ENDIF}
    end;
  end;
end;

constructor TAdvChartStylesManagerOptions.Create;
begin
  FAdaptFormColor := True;
end;

{$ENDIF}

end.
