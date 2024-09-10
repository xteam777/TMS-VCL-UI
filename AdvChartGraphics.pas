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

unit AdvChartGraphics;

{$I TMSDEFS.inc}

{$IFDEF CMNLIB}
{$DEFINE CMNWEBLIB}
{$ENDIF}
{$IFDEF WEBLIB}
{$DEFINE CMNWEBLIB}
{$ENDIF}

//{$DEFINE SVGSUPPORT}

{$IFDEF WEBLIB}
{$DEFINE LCLWEBLIB}
{$ENDIF}
{$IFDEF LCLLIB}
{$DEFINE LCLWEBLIB}
{$ENDIF}

interface

uses
  {$IFDEF MSWINDOWS}
  Windows,
  {$ENDIF}
  Classes, AdvChartGraphicsTypes, Graphics,
  {$IFDEF WEBLIB}
  JS,
  {$ENDIF}
  {$IFNDEF LIMITEDGRAPHICSMODE}
  AdvChartBitmapContainer,
  {$ENDIF}
  Types, AdvChartTypes
  {$IFDEF CMNLIB}
  ,ImgList
  {$ENDIF}
  {$IFNDEF LCLWEBLIB}
  {$HINTS OFF}
  {$IF COMPILERVERSION > 22}
  ,UITypes
  {$IFEND}
  {$HINTS ON}
  {$ENDIF}
  ;

type
  TAdvChartGraphics = class;

  TAdvChartGraphicsContext = class
  private
    {$IFDEF AUTOREFCOUNT}
    [Weak]FGraphics: TAdvChartGraphics;
    {$ELSE}
    FGraphics: TAdvChartGraphics;
    {$ENDIF}
    function GetCanvas: TCanvas;
    function GetGraphics: TAdvChartGraphics;
  protected
    function GetNativeCanvas: Pointer; virtual; abstract;
  public
    constructor Create(const AGraphics: TAdvChartGraphics); virtual;
    function CreatePath: Pointer; virtual; abstract;
    function ConvertToPath(APath: TAdvChartGraphicsPath; const Flatness: Single = 0.25): Pointer;
    function GetFillColor: TAdvChartGraphicsColor; virtual; abstract;
    function CalculateText(AText: string; ARect: TRectF; AWordWrapping: Boolean): TRectF; virtual; abstract;
    function SetTextAngle(ARect: TRectF; AAngle: Single): TRectF; virtual; abstract;
    function GetMatrix: TAdvChartGraphicsMatrix; virtual; abstract;
    procedure Render; virtual; abstract;
    procedure PathOpen(APath: Pointer); virtual; abstract;
    procedure PathMoveTo(APath: Pointer; APoint: TPointF); virtual; abstract;
    procedure PathLineTo(APath: Pointer; APoint: TPointF); virtual; abstract;
    procedure SetScale(AScale: Single); virtual; abstract;
    procedure PathClose(APath: Pointer); virtual; abstract;
    procedure ResetClip; virtual; abstract;
    procedure ResetTransform; virtual; abstract;
    procedure ScaleTransform(AX, AY: Single); virtual; abstract;
    procedure RotateTransform(AAngle: Single); virtual; abstract;
    procedure TranslateTransform(AX, AY: Single); virtual; abstract;
    procedure SetTextQuality(ATextQuality: TAdvChartGraphicsTextQuality); virtual; abstract;
    procedure SetAntiAliasing(AAntiAliasing: Boolean); virtual; abstract;
    procedure SetShowAcceleratorChar(AShowAcceleratorChar: Boolean); virtual; abstract;
    procedure SetSize(AWidth, AHeight: Single); virtual; abstract;
    procedure ResetTextAngle(AAngle: Single); virtual; abstract;
    procedure BeginScene; virtual; abstract;
    procedure EndScene; virtual; abstract;
    procedure BeginPrinting; virtual; abstract;
    procedure EndPrinting; virtual; abstract;
    procedure StartSpecialPen; virtual; abstract;
    procedure StopSpecialPen; virtual; abstract;
    procedure RestoreState(AState: TAdvChartGraphicsSaveState); virtual; abstract;
    procedure SaveState(AState: TAdvChartGraphicsSaveState); virtual; abstract;
    procedure SetFontSize(ASize: Integer); virtual; abstract;
    procedure SetFontColor(AColor: TAdvChartGraphicsColor); virtual; abstract;
    procedure SetFontName(AName: string); virtual; abstract;
    procedure SetFont(AFont: TAdvChartGraphicsFont); virtual; abstract;
    procedure SetFontStyles(AStyle: TFontStyles); virtual; abstract;
    procedure SetMatrix(AMatrix: TAdvChartGraphicsMatrix); virtual; abstract;
    procedure SetFill(AFill: TAdvChartGraphicsFill); virtual; abstract;
    procedure SetFillKind(AKind: TAdvChartGraphicsFillKind); virtual; abstract;
    procedure SetFillColor(AColor: TAdvChartGraphicsColor); virtual; abstract;
    procedure SetStroke(AStroke: TAdvChartGraphicsStroke); virtual; abstract;
    procedure SetStrokeKind(AKind: TAdvChartGraphicsStrokeKind); virtual; abstract;
    procedure SetStrokeColor(AColor: TAdvChartGraphicsColor); virtual; abstract;
    procedure SetStrokeWidth(AWidth: Single); virtual; abstract;
    procedure DrawLine(AStroke: TAdvChartGraphicsStroke; AFromPoint: TPointF; AToPoint: TPointF; AModifyPointModeFrom: TAdvChartGraphicsModifyPointMode = gcpmRightDown; AModifyPointModeTo: TAdvChartGraphicsModifyPointMode = gcpmRightDown); virtual; abstract;
    procedure DrawPolygon(AStroke: TAdvChartGraphicsStroke; APolygon: TAdvChartGraphicsPathPolygon); virtual; abstract;
    procedure FillPolygon(AFill: TAdvChartGraphicsFill; APolygon: TAdvChartGraphicsPathPolygon); virtual; abstract;
    procedure DrawPolyline(AStroke: TAdvChartGraphicsStroke; APolyline: TAdvChartGraphicsPathPolygon); virtual; abstract;
    procedure FillPolyline(AFill: TAdvChartGraphicsFill; APolyline: TAdvChartGraphicsPathPolygon); virtual; abstract;
    procedure FillArc(AFill: TAdvChartGraphicsFill; ACenter, ARadius: TPointF; AStartAngle, ASweepAngle: Single); virtual; abstract;
    procedure DrawArc(AStroke: TAdvChartGraphicsStroke; ACenter, ARadius: TPointF; AStartAngle, ASweepAngle: Single); virtual; abstract;
    procedure FillRect(AFill: TAdvChartGraphicsFill; ARect: TRectF; AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll); virtual; abstract;
    procedure DrawRect(AStroke: TAdvChartGraphicsStroke; ARect: TRectF; ASides: TAdvChartGraphicsSides; AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll); virtual; abstract;
    procedure FillRoundRect(AFill: TAdvChartGraphicsFill; ARect: TRectF; ARounding: Single; ACorners: TAdvChartGraphicsCorners; AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll); virtual; abstract;
    procedure DrawRoundRect(AStroke: TAdvChartGraphicsStroke; ARect: TRectF; ARounding: Single; ACorners: TAdvChartGraphicsCorners; AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll); virtual; abstract;
    procedure FillEllipse(AFill: TAdvChartGraphicsFill; ARect: TRectF; AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll); virtual; abstract;
    procedure DrawEllipse(AStroke: TAdvChartGraphicsStroke; ARect: TRectF; AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll); virtual; abstract;
    procedure DrawBitmap(ABitmap: TAdvChartDrawBitmap; ASrcRect, ADstRect: TRectF; AOpacity: Single); virtual; abstract;
    procedure ClipRect(ARect: TRectF); virtual; abstract;
    procedure ClipPath(APath: TAdvChartGraphicsPath); virtual; abstract;
    procedure DrawFocusPath(AStroke: TAdvChartGraphicsStroke; APath: TAdvChartGraphicsPath; AColor: TAdvChartGraphicsColor); virtual; abstract;
    procedure DrawFocusRectangle(AStroke: TAdvChartGraphicsStroke; ARect: TRectF; AColor: TAdvChartGraphicsColor; AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll); virtual; abstract;
    procedure DrawText(AText: string; ARect: TRectF; AWordWrapping: Boolean; AHorizontalAlign, AVerticalAlign: TAdvChartGraphicsTextAlign; ATrimming: TAdvChartGraphicsTextTrimming; AAngle: Single); virtual; abstract;
    procedure DrawPath(AStroke: TAdvChartGraphicsStroke; APath: TAdvChartGraphicsPath; APathMode: TAdvChartGraphicsPathDrawMode = pdmPolygon); virtual; abstract;
    procedure FillPath(AFill: TAdvChartGraphicsFill; APath: TAdvChartGraphicsPath; APathMode: TAdvChartGraphicsPathDrawMode = pdmPolygon); virtual; abstract;
    property Canvas: TCanvas read GetCanvas;
    property NativeCanvas: Pointer read GetNativeCanvas;
    property Graphics: TAdvChartGraphics read GetGraphics;
  end;

  TAdvChartGraphicsContextClass = class of TAdvChartGraphicsContext;

  TAdvChartGraphics = class
  private
    FActiveCanvas: TCanvas;
    FBlockUpdate: Integer;
    FNative: Boolean;
    FContextNative, FContextGeneral: TAdvChartGraphicsContext;
    FBitmap: TBitmap;
    FFill: TAdvChartGraphicsFill;
    FStroke: TAdvChartGraphicsStroke;
    FFont: TAdvChartGraphicsFont;
    {$IFNDEF LIMITEDGRAPHICSMODE}
    FHighlightColor: TAdvChartGraphicsColor;
    FOptimizedHTMLDrawing: Boolean;
    FHighlightTextColor: TAdvChartGraphicsColor;
    FHighlightFontStyles: TFontStyles;
    FURLUnderline: Boolean;
    FURLColor: TAdvChartGraphicsColor;
    FBitmapContainer: TAdvChartBitmapContainer;
    {$IFDEF CMNLIB}
    FImageList: TCustomImageList;
    {$ENDIF}
    {$ENDIF}
    function GetCanvas: TCanvas;
    function GetContext: TAdvChartGraphicsContext;
  protected
    procedure FontChanged(Sender: TObject);
    procedure FillChanged(Sender: TObject);
    procedure StrokeChanged(Sender: TObject);
    procedure InitializeDefaultAppearance;
    function InternalDrawBitmapPartSync(ASourceLeft: Double; ASourceTop: Double; ASourceRight: Double; ASourceBottom: Double; ADestinationLeft: Double; ADestinationTop: Double;
    ADestinationRight: Double; ADestinationBottom: Double; ABitmap: TAdvChartBitmapHelperClass; AAspectRatio: Boolean = True; AStretch: Boolean = False;
    ACenter: Boolean = True; ACropping: Boolean = False): {$IFDEF WEBLIB}TJSPromise{$ELSE}TAdvChartBitmap{$ENDIF};
    function InternalCalculateText(AText: String; ARect: TRectF; AWordWrapping: Boolean = False{$IFNDEF LIMITEDGRAPHICSMODE}; ASupportHTML: Boolean = True{$ENDIF}): TRectF; overload; virtual;
    function InternalDrawText(ARect: TRectF; AText: String; var AControlID: String; var AControlValue: String; var AControlType: string;AWordWrapping: Boolean = False; AHorizontalAlign: TAdvChartGraphicsTextAlign = gtaLeading; AVerticalAlign: TAdvChartGraphicsTextAlign = gtaCenter; ATrimming: TAdvChartGraphicsTextTrimming = gttNone; AAngle: Single = 0;
      AMinWidth: Single = -1; AMinHeight: Single = -1 {$IFNDEF LIMITEDGRAPHICSMODE};ASupportHTML: Boolean = True; ATestAnchor: Boolean = False; AX: Single = -1; AY: Single = - 1{$ENDIF}): String; overload; virtual;
    procedure DrawTexture(ARect: TRectF; ATexture: TAdvChartBitmap; ATextureMode: TAdvChartGraphicsTextureMode);
    {$IFDEF SVGSUPPORT}
    function DrawSVG(ABitmap: TAdvChartBitmapHelperClass; ARect: TRectF): Boolean;
    function HasSVG(ABitmap: TAdvChartBitmapHelperClass): Boolean;
    {$ENDIF}
    class procedure ConvertBitmapToGrayScale(ABitmap: TAdvChartBitmap);
  public class var
    DefaultSelectionFillColor: TAdvChartGraphicsColor;
    DefaultTextFontColor: TAdvChartGraphicsColor;
    DefaultPopupFillColor: TAdvChartGraphicsColor;
    DefaultPopupStrokeColor: TAdvChartGraphicsColor;
    DefaultButtonStrokeColorFocused: TAdvChartGraphicsColor;
    DefaultButtonFillColorFocused: TAdvChartGraphicsColor;
    DefaultButtonStrokeColorDisabled: TAdvChartGraphicsColor;
    DefaultButtonFillColorDisabled: TAdvChartGraphicsColor;
    DefaultButtonStrokeColor: TAdvChartGraphicsColor;
    DefaultButtonFillColor: TAdvChartGraphicsColor;
  public
    constructor Create(ACanvas: TCanvas; ANative: Boolean = False); virtual;
    constructor CreateNative(ACanvas: TCanvas); virtual;
    constructor CreateBitmapCanvas(AWidth: Integer = 1; AHeight: Integer = 1; ANative: Boolean = False; {%H-}AHighDPI: Boolean = True); virtual;
    constructor CreateNativeBitmapCanvas(AWidth: Integer = 1; AHeight: Integer = 1); virtual;
    destructor Destroy; override;
    function GetMatrix: TAdvChartGraphicsMatrix; virtual;
    procedure StartSpecialPen;
    procedure StopSpecialPen;
    procedure BeginPrinting; virtual;
    procedure EndPrinting; virtual;
    procedure BeginScene; virtual;
    procedure EndScene; virtual;
    procedure SetMatrix(const AMatrix: TAdvChartGraphicsMatrix); virtual;
    procedure Assign(Source: TAdvChartGraphics); virtual;
    procedure SetFill(AFill: TAdvChartGraphicsFill); virtual;
    procedure SetStroke(AStroke: TAdvChartGraphicsStroke); virtual;
    procedure RestoreState(AState: TAdvChartGraphicsSaveState; ACanvasOnly: Boolean = False); virtual;
    procedure SetFillKind(AKind: TAdvChartGraphicsFillKind); virtual;
    procedure SetFillColor(AColor: TAdvChartGraphicsColor); virtual;
    procedure SetFontColor(AColor: TAdvChartGraphicsColor); virtual;
    procedure SetFontName(AName: string); virtual;
    procedure SetFont(AFont: TAdvChartGraphicsFont); virtual;
    procedure SetFontSize(ASize: Integer); virtual;
    procedure SetFontStyles(AStyle: TFontStyles); virtual;
    procedure SetStrokeKind(AKind: TAdvChartGraphicsStrokeKind); virtual;
    procedure SetStrokeColor(AColor: TAdvChartGraphicsColor); virtual;
    procedure SetStrokeWidth(AWidth: Single); virtual;
    procedure DrawLine(AFromPoint: TPoint; AToPoint: TPoint; {%H-}AModifyPointModeFrom: TAdvChartGraphicsModifyPointMode = gcpmRightDown; {%H-}AModifyPointModeTo: TAdvChartGraphicsModifyPointMode = gcpmRightDown); overload; virtual;
    procedure DrawLine(AFromPoint: TPointF; AToPoint: TPointF; {%H-}AModifyPointModeFrom: TAdvChartGraphicsModifyPointMode = gcpmRightDown; {%H-}AModifyPointModeTo: TAdvChartGraphicsModifyPointMode = gcpmRightDown); overload; virtual;
    procedure DrawFocusRectangle(ALeft, ATop, ARight, ABottom: Integer; AColor: TAdvChartGraphicsColor = gcBlack; {%H-}AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll); overload; virtual;
    procedure DrawFocusRectangle(ARect: TRect; AColor: TAdvChartGraphicsColor = gcBlack; {%H-}AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll); overload; virtual;
    procedure DrawFocusRectangle(ALeft, ATop, ARight, ABottom: Double; AColor: TAdvChartGraphicsColor = gcBlack; {%H-}AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll); overload; virtual;
    procedure DrawFocusRectangle(ARect: TRectF; AColor: TAdvChartGraphicsColor = gcBlack; {%H-}AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll); overload; virtual;
    procedure DrawFocusPath(APath: TAdvChartGraphicsPath; AColor: TAdvChartGraphicsColor = gcBlack); virtual;
    procedure DrawPolygon(APolygon: TAdvChartGraphicsPathPolygon); virtual;
    procedure DrawPolyline(APolyline: TAdvChartGraphicsPathPolygon); virtual;
    procedure DrawPath(APath: TAdvChartGraphicsPath; APathMode: TAdvChartGraphicsPathDrawMode = pdmPolygon); virtual;
    procedure DrawArc(const Center, Radius: TPointF; StartAngle, SweepAngle: Single); overload; virtual;
    procedure DrawArc(const Center, Radius: TPoint; StartAngle, SweepAngle: Integer); overload; virtual;
    procedure DrawRectangle(ALeft, ATop, ARight, ABottom: Double; {%H-}AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll); overload; virtual;
    procedure DrawRectangle(ALeft, ATop, ARight, ABottom: Double; ASides: TAdvChartGraphicsSides; {%H-}AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll); overload; virtual;
    procedure DrawEllipse(ALeft, ATop, ARight, ABottom: Double; {%H-}AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll); overload; virtual;
    procedure DrawRectangle(ARect: TRectF; {%H-}AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll); overload; virtual;
    procedure DrawRectangle(ARect: TRectF; ASides: TAdvChartGraphicsSides; {%H-}AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll); overload; virtual;
    procedure DrawRectangle(ALeft, ATop, ARight, ABottom: Integer; {%H-}AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll); overload; virtual;
    procedure DrawRectangle(ALeft, ATop, ARight, ABottom: Integer; ASides: TAdvChartGraphicsSides; {%H-}AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll); overload; virtual;
    procedure DrawEllipse(ALeft, ATop, ARight, ABottom: Integer; {%H-}AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll); overload; virtual;
    procedure DrawRectangle(ARect: TRect; {%H-}AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll); overload; virtual;
    procedure DrawRectangle(ARect: TRect; ASides: TAdvChartGraphicsSides; {%H-}AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll); overload; virtual;
    procedure DrawRoundRectangle(ALeft, ATop, ARight, ABottom: Double; ARounding: Single = 10; ACorners: TAdvChartGraphicsCorners = [gcTopLeft, gcTopRight, gcBottomLeft, gcBottomRight]; {%H-}AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll); overload; virtual;
    procedure DrawRoundRectangle(ARect: TRectF; ARounding: Single = 10; ACorners: TAdvChartGraphicsCorners = [gcTopLeft, gcTopRight, gcBottomLeft, gcBottomRight]; {%H-}AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll); overload; virtual;
    procedure DrawRoundRectangle(ALeft, ATop, ARight, ABottom: Integer; ARounding: Integer = 10; ACorners: TAdvChartGraphicsCorners = [gcTopLeft, gcTopRight, gcBottomLeft, gcBottomRight]; {%H-}AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll); overload; virtual;
    procedure DrawRoundRectangle(ARect: TRect; ARounding: Integer = 10; ACorners: TAdvChartGraphicsCorners = [gcTopLeft, gcTopRight, gcBottomLeft, gcBottomRight]; {%H-}AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll); overload; virtual;
    procedure DrawEllipse(ARect: TRectF; {%H-}AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll); overload; virtual;
    procedure DrawBitmapPart(ASourceLeft, ASourceTop, ASourceRight, ASourceBottom: Double; ADestinationLeft, ADestinationTop, ADestinationRight, ADestinationBottom: Double;
    ABitmap: TAdvChartBitmapHelperClass; AAspectRatio: Boolean = True; AStretch: Boolean = False; ACenter: Boolean = True; ACropping: Boolean = False); overload; virtual;
    procedure DrawBitmapPart(ASourceRect: TRectF; ADestinationRect: TRectF; ABitmap: TAdvChartBitmapHelperClass; AAspectRatio: Boolean = True;
      AStretch: Boolean = False; ACenter: Boolean = True; ACropping: Boolean = False); overload; virtual;
    procedure DrawBitmap(ALeft, ATop, ARight, ABottom: Double; ABitmap: TAdvChartBitmapHelperClass; AAspectRatio: Boolean = True;
      AStretch: Boolean = False; ACenter: Boolean = True; ACropping: Boolean = False); overload; virtual;
    procedure DrawBitmap(ARect: TRectF; ABitmap: TAdvChartBitmapHelperClass; AAspectRatio: Boolean = True;
      AStretch: Boolean = False; ACenter: Boolean = True; ACropping: Boolean = False); overload; virtual;
    procedure DrawEllipse(ARect: TRect; {%H-}AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll); overload; virtual;
    procedure DrawBitmapPart(ASourceLeft, ASourceTop, ASourceRight, ASourceBottom: Integer; ADestinationLeft, ADestinationTop, ADestinationRight, ADestinationBottom: Integer;
    ABitmap: TAdvChartBitmapHelperClass; AAspectRatio: Boolean = True; AStretch: Boolean = False; ACenter: Boolean = True; ACropping: Boolean = False); overload; virtual;
    procedure DrawBitmapPart(ASourceRect: TRect; ADestinationRect: TRect; ABitmap: TAdvChartBitmapHelperClass; AAspectRatio: Boolean = True;
      AStretch: Boolean = False; ACenter: Boolean = True; ACropping: Boolean = False); overload; virtual;
    procedure DrawBitmap(ALeft, ATop, ARight, ABottom: Integer; ABitmap: TAdvChartBitmapHelperClass; AAspectRatio: Boolean = True;
      AStretch: Boolean = False; ACenter: Boolean = True; ACropping: Boolean = False); overload; virtual;
    procedure DrawBitmap(ARect: TRect; ABitmap: TAdvChartBitmapHelperClass; AAspectRatio: Boolean = True;
      AStretch: Boolean = False; ACenter: Boolean = True; ACropping: Boolean = False); overload; virtual;
    procedure DrawBitmap(ALeft, ATop: Integer; ABitmap: TAdvChartBitmapHelperClass); overload; virtual;
    procedure DrawBitmap(ALeft, ATop: Single; ABitmap: TAdvChartBitmapHelperClass); overload; virtual;
    procedure DrawCheckBox(ARect: TRectF; AChecked: Boolean = False; AFocused: Boolean = False; AEnabled: Boolean = True; AScaleFactor: Single = 1.0); overload; virtual;
    procedure DrawButton(ARect: TRectF; ADown: Boolean = False; AFocused: Boolean = False; AEnabled: Boolean = True; AAdaptToStyle: Boolean = True; AScaleFactor: Single = 1.0); overload; virtual;
    procedure DrawCloseButton(ARect: TRectF; ADown: Boolean = False; AFocused: Boolean = False; AEnabled: Boolean = True; AAdaptToStyle: Boolean = True; AScaleFactor: Single = 1.0); overload; virtual;
    procedure DrawExpanderButton(ARect: TRectF; AState: TAdvChartGraphicsExpanderState = gesExpanded; ADown: Boolean = False; AFocused: Boolean = False; AEnabled: Boolean = True; AAdaptToStyle: Boolean = True; AScaleFactor: Single = 1.0); overload; virtual;
    procedure DrawCompactButton(ARect: TRectF; AState: TAdvChartGraphicsCompactState = gcsExpanded; ADown: Boolean = False; AFocused: Boolean = False; AEnabled: Boolean = True; AAdaptToStyle: Boolean = True; AScaleFactor: Single = 1.0); overload; virtual;
    procedure DrawDropDownButton(ARect: TRectF; ADown: Boolean = False; AFocused: Boolean = False; AEnabled: Boolean = True; ACenter: Boolean = False; AAdaptToStyle: Boolean = True; AScaleFactor: Single = 1.0); overload; virtual;
    procedure DrawRadioButton(ARect: TRectF; AChecked: Boolean = False; AFocused: Boolean = False; AEnabled: Boolean = True; AScaleFactor: Single = 1.0); overload; virtual;
    procedure DrawProgressBar(ARect: TRectF; AValue: Single; AFormat: string = '%.0f%%'; AMax: Single = 100; AColor: TAdvChartGraphicsColor = gcYellowgreen; ATextColor: TAdvChartGraphicsColor = gcBlack; AShowText: Boolean = True; AEnabled: Boolean = True; AScaleFactor: Single = 1.0); overload; virtual;
    procedure DrawCheckBox(ARect: TRect; AChecked: Boolean = False; AFocused: Boolean = False; AEnabled: Boolean = True; AScaleFactor: Single = 1.0); overload; virtual;
    procedure DrawButton(ARect: TRect; ADown: Boolean = False; AFocused: Boolean = False; AEnabled: Boolean = True; AAdaptToStyle: Boolean = True; AScaleFactor: Single = 1.0); overload; virtual;
    procedure DrawCloseButton(ARect: TRect; ADown: Boolean = False; AFocused: Boolean = False; AEnabled: Boolean = True; AAdaptToStyle: Boolean = True; AScaleFactor: Single = 1.0); overload; virtual;
    procedure DrawExpanderButton(ARect: TRect; AState: TAdvChartGraphicsExpanderState = gesExpanded; ADown: Boolean = False; AFocused: Boolean = False; AEnabled: Boolean = True; AAdaptToStyle: Boolean = True; AScaleFactor: Single = 1.0); overload; virtual;
    procedure DrawCompactButton(ARect: TRect; AState: TAdvChartGraphicsCompactState = gcsExpanded; ADown: Boolean = False; AFocused: Boolean = False; AEnabled: Boolean = True; AAdaptToStyle: Boolean = True; AScaleFactor: Single = 1.0); overload; virtual;
    procedure DrawDropDownButton(ARect: TRect; ADown: Boolean = False; AFocused: Boolean = False; AEnabled: Boolean = True; ACenter: Boolean = False; AAdaptToStyle: Boolean = True; AScaleFactor: Single = 1.0); overload; virtual;
    procedure DrawRadioButton(ARect: TRect; AChecked: Boolean = False; AFocused: Boolean = False; AEnabled: Boolean = True; AScaleFactor: Single = 1.0); overload; virtual;
    procedure DrawProgressBar(ARect: TRect; AValue: Single; AFormat: string = '%.0f%%'; AMax: Single = 100; AColor: TAdvChartGraphicsColor = gcYellowgreen; ATextColor: TAdvChartGraphicsColor = gcBlack; AShowText: Boolean = True; AEnabled: Boolean = True; AScaleFactor: Single = 1.0); overload; virtual;
    {$IFNDEF LIMITEDGRAPHICSMODE}
    procedure DrawBitmapWithName(ALeft, ATop, ARight, ABottom: Double; ABitmapName: string; AApplyScale: Boolean = False; AScale: Single = 0; AAspectRatio: Boolean = True;
      AStretch: Boolean = False; ACenter: Boolean = True; ACropping: Boolean = False); overload; virtual;
    procedure DrawBitmapWithName(ARect: TRectF; ABitmapName: string; AApplyScale: Boolean = False; AScale: Single = 0; AAspectRatio: Boolean = True;
      AStretch: Boolean = False; ACenter: Boolean = True; ACropping: Boolean = False); overload; virtual;
    procedure DrawScaledBitmap(ARect: TRectF; ABitmaps: TAdvScaledBitmaps; AScale: Single = 0; AAspectRatio: Boolean = True;
      AStretch: Boolean = False; ACenter: Boolean = True; ACropping: Boolean = False); overload; virtual;
    procedure DrawScaledBitmap(ALeft, ATop, ARight, ABottom: Double; ABitmaps: TAdvScaledBitmaps; AScale: Single = 0; AAspectRatio: Boolean = True;
      AStretch: Boolean = False; ACenter: Boolean = True; ACropping: Boolean = False); overload; virtual;
    procedure DrawBitmapWithName(ALeft, ATop, ARight, ABottom: Integer; ABitmapName: string; AApplyScale: Boolean = False; AScale: Single = 0; AAspectRatio: Boolean = True;
      AStretch: Boolean = False; ACenter: Boolean = True; ACropping: Boolean = False); overload; virtual;
    procedure DrawBitmapWithName(ARect: TRect; ABitmapName: string; AApplyScale: Boolean = False; AScale: Single = 0; AAspectRatio: Boolean = True;
      AStretch: Boolean = False; ACenter: Boolean = True; ACropping: Boolean = False); overload; virtual;
    procedure DrawScaledBitmap(ARect: TRect; ABitmaps: TAdvScaledBitmaps; AScale: Single = 0; AAspectRatio: Boolean = True;
      AStretch: Boolean = False; ACenter: Boolean = True; ACropping: Boolean = False); overload; virtual;
    procedure DrawScaledBitmap(ALeft, ATop, ARight, ABottom: Integer; ABitmaps: TAdvScaledBitmaps; AScale: Single = 0; AAspectRatio: Boolean = True;
      AStretch: Boolean = False; ACenter: Boolean = True; ACropping: Boolean = False); overload; virtual;
    {$ENDIF}
    function GetBitmapDrawRectangle(ALeft, ATop, ARight, ABottom: Double; ABitmap: TAdvChartBitmapHelperClass; AAspectRatio: Boolean = True;
      AStretch: Boolean = False; ACenter: Boolean = True; ACropping: Boolean = False): TRectF; overload; virtual;
    function GetBitmapDrawRectangle(ARect: TRectF; ABitmap: TAdvChartBitmapHelperClass; AAspectRatio: Boolean = True;
      AStretch: Boolean = False; ACenter: Boolean = True; ACropping: Boolean = False): TRectF; overload; virtual;
    function GetBitmapDrawRectangle(ALeft, ATop, ARight, ABottom: Integer; ABitmap: TAdvChartBitmapHelperClass; AAspectRatio: Boolean = True;
      AStretch: Boolean = False; ACenter: Boolean = True; ACropping: Boolean = False): TRect; overload; virtual;
    function GetBitmapDrawRectangle(ARect: TRect; ABitmap: TAdvChartBitmapHelperClass; AAspectRatio: Boolean = True;
      AStretch: Boolean = False; ACenter: Boolean = True; ACropping: Boolean = False): TRect; overload; virtual;
    procedure ClipRect(ARect: TRectF); overload; virtual;
    function DrawBitmapPartSync(ASourceLeft: Double; ASourceTop: Double; ASourceRight: Double; ASourceBottom: Double; ADestinationLeft: Double; ADestinationTop: Double;
    ADestinationRight: Double; ADestinationBottom: Double; ABitmap: TAdvChartBitmapHelperClass; AAspectRatio: Boolean = True; AStretch: Boolean = False;
    ACenter: Boolean = True; ACropping: Boolean = False): TAdvChartBitmap; virtual; {$IFDEF WEBLIB} async;{$ENDIF}
    function CalculateTextSize(AText: string; ARect: TRectF; AWordWrapping: Boolean = False{$IFNDEF LIMITEDGRAPHICSMODE}; ASupportHTML: Boolean = True{$ENDIF}): TSizeF; overload; virtual;
    function CalculateTextWidth(AText: string; ARect: TRectF; AWordWrapping: Boolean = False{$IFNDEF LIMITEDGRAPHICSMODE}; ASupportHTML: Boolean = True{$ENDIF}): Single; overload; virtual;
    function CalculateTextHeight(AText: string; ARect: TRectF; AWordWrapping: Boolean = False{$IFNDEF LIMITEDGRAPHICSMODE}; ASupportHTML: Boolean = True{$ENDIF}): Single; overload; virtual;
    function CalculateText(AText: String; ARect: TRectF; AWordWrapping: Boolean = False{$IFNDEF LIMITEDGRAPHICSMODE}; ASupportHTML: Boolean = True{$ENDIF}): TRectF; overload; virtual;
    function CalculateTextSize(AText: string): TSizeF; overload; virtual;
    function CalculateTextWidth(AText: string): Single; overload; virtual;
    function CalculateTextHeight(AText: string): Single; overload; virtual;
    function CalculateText(AText: String): TRectF; overload; virtual;
    procedure ClipRect(ARect: TRect); overload; virtual;
    function CalculateTextSize(AText: string; ARect: TRect; AWordWrapping: Boolean = False{$IFNDEF LIMITEDGRAPHICSMODE}; ASupportHTML: Boolean = True{$ENDIF}): TSize; overload; virtual;
    function CalculateTextWidth(AText: string; ARect: TRect; AWordWrapping: Boolean = False{$IFNDEF LIMITEDGRAPHICSMODE}; ASupportHTML: Boolean = True{$ENDIF}): Integer; overload; virtual;
    function CalculateTextHeight(AText: string; ARect: TRect; AWordWrapping: Boolean = False{$IFNDEF LIMITEDGRAPHICSMODE}; ASupportHTML: Boolean = True{$ENDIF}): Integer; overload; virtual;
    function CalculateText(AText: String; ARect: TRect; AWordWrapping: Boolean = False{$IFNDEF LIMITEDGRAPHICSMODE}; ASupportHTML: Boolean = True{$ENDIF}): TRect; overload; virtual;
    function CalculateTextSizeInt(AText: string): TSize; overload; virtual;
    function CalculateTextWidthInt(AText: string): Integer; overload; virtual;
    function CalculateTextHeightInt(AText: string): Integer; overload; virtual;
    function CalculateTextInt(AText: String): TRect; overload; virtual;
    function DrawText(APoint: TPointF; AText: String; AAngle: Single = 0 {$IFNDEF LIMITEDGRAPHICSMODE};ASupportHTML: Boolean = True; ATestAnchor: Boolean = False; AX: Single = -1; AY: Single = - 1{$ENDIF}): String; overload; virtual;
    function DrawText(ARect: TRectF; AText: String; AWordWrapping: Boolean = False; AHorizontalAlign: TAdvChartGraphicsTextAlign = gtaLeading; AVerticalAlign: TAdvChartGraphicsTextAlign = gtaCenter; ATrimming: TAdvChartGraphicsTextTrimming = gttNone; AAngle: Single = 0;
      AMinWidth: Single = -1; AMinHeight: Single = -1 {$IFNDEF LIMITEDGRAPHICSMODE};ASupportHTML: Boolean = True; ATestAnchor: Boolean = False; AX: Single = -1; AY: Single = - 1{$ENDIF}): String; overload; virtual;
    function DrawText(ALeft, ATop, ARight, ABottom: Double; AText: String; AWordWrapping: Boolean = False; AHorizontalAlign: TAdvChartGraphicsTextAlign = gtaLeading; AVerticalAlign: TAdvChartGraphicsTextAlign = gtaCenter; ATrimming: TAdvChartGraphicsTextTrimming = gttNone; AAngle: Single = 0;
      AMinWidth: Single = -1; AMinHeight: Single = -1 {$IFNDEF LIMITEDGRAPHICSMODE};ASupportHTML: Boolean = True; ATestAnchor: Boolean = False; AX: Single = -1; AY: Single = - 1{$ENDIF}): String; overload; virtual;
    function DrawText(ARect: TRect; AText: String; AWordWrapping: Boolean = False; AHorizontalAlign: TAdvChartGraphicsTextAlign = gtaLeading; AVerticalAlign: TAdvChartGraphicsTextAlign = gtaCenter; ATrimming: TAdvChartGraphicsTextTrimming = gttNone; AAngle: Single = 0;
      AMinWidth: Single = -1; AMinHeight: Single = -1 {$IFNDEF LIMITEDGRAPHICSMODE};ASupportHTML: Boolean = True; ATestAnchor: Boolean = False; AX: Single = -1; AY: Single = - 1{$ENDIF}): String; overload; virtual;
    function DrawText(ALeft, ATop, ARight, ABottom: Integer; AText: String; AWordWrapping: Boolean = False; AHorizontalAlign: TAdvChartGraphicsTextAlign = gtaLeading; AVerticalAlign: TAdvChartGraphicsTextAlign = gtaCenter; ATrimming: TAdvChartGraphicsTextTrimming = gttNone; AAngle: Single = 0;
      AMinWidth: Single = -1; AMinHeight: Single = -1 {$IFNDEF LIMITEDGRAPHICSMODE};ASupportHTML: Boolean = True; ATestAnchor: Boolean = False; AX: Single = -1; AY: Single = - 1{$ENDIF}): String; overload; virtual;
    function DrawText(ARect: TRectF; AText: String; var AControlID: String; var AControlValue: String; var AControlType: string;AWordWrapping: Boolean = False; AHorizontalAlign: TAdvChartGraphicsTextAlign = gtaLeading; AVerticalAlign: TAdvChartGraphicsTextAlign = gtaCenter; ATrimming: TAdvChartGraphicsTextTrimming = gttNone; AAngle: Single = 0;
      AMinWidth: Single = -1; AMinHeight: Single = -1 {$IFNDEF LIMITEDGRAPHICSMODE};ASupportHTML: Boolean = True; ATestAnchor: Boolean = False; AX: Single = -1; AY: Single = - 1{$ENDIF}): String; overload; virtual;
    function DrawText(ALeft, ATop, ARight, ABottom: Double; AText: String; var AControlID: String; var AControlValue: String; var AControlType: string; AWordWrapping: Boolean = False; AHorizontalAlign: TAdvChartGraphicsTextAlign = gtaLeading; AVerticalAlign: TAdvChartGraphicsTextAlign = gtaCenter; ATrimming: TAdvChartGraphicsTextTrimming = gttNone; AAngle: Single = 0;
      AMinWidth: Single = -1; AMinHeight: Single = -1 {$IFNDEF LIMITEDGRAPHICSMODE};ASupportHTML: Boolean = True; ATestAnchor: Boolean = False; AX: Single = -1; AY: Single = - 1{$ENDIF}): String; overload; virtual;
    function DrawText(ARect: TRect; AText: String; var AControlID: String; var AControlValue: String; var AControlType: string; AWordWrapping: Boolean = False; AHorizontalAlign: TAdvChartGraphicsTextAlign = gtaLeading; AVerticalAlign: TAdvChartGraphicsTextAlign = gtaCenter; ATrimming: TAdvChartGraphicsTextTrimming = gttNone; AAngle: Single = 0;
      AMinWidth: Single = -1; AMinHeight: Single = -1 {$IFNDEF LIMITEDGRAPHICSMODE};ASupportHTML: Boolean = True; ATestAnchor: Boolean = False; AX: Single = -1; AY: Single = - 1{$ENDIF}): String; overload; virtual;
    function DrawText(ALeft, ATop, ARight, ABottom: Integer; AText: String; var AControlID: String; var AControlValue: String; var AControlType: string; AWordWrapping: Boolean = False; AHorizontalAlign: TAdvChartGraphicsTextAlign = gtaLeading; AVerticalAlign: TAdvChartGraphicsTextAlign = gtaCenter; ATrimming: TAdvChartGraphicsTextTrimming = gttNone; AAngle: Single = 0;
      AMinWidth: Single = -1; AMinHeight: Single = -1 {$IFNDEF LIMITEDGRAPHICSMODE};ASupportHTML: Boolean = True; ATestAnchor: Boolean = False; AX: Single = -1; AY: Single = - 1{$ENDIF}): String; overload; virtual;
    function SaveState(ACanvasOnly: Boolean = False): TAdvChartGraphicsSaveState; virtual;
    property Fill: TAdvChartGraphicsFill read FFill;
    property Stroke: TAdvChartGraphicsStroke read FStroke;
    property Font: TAdvChartGraphicsFont read FFont;
    property Canvas: TCanvas read GetCanvas;
    property Context: TAdvChartGraphicsContext read GetContext;
    property Bitmap: TBitmap read FBitmap;
    {$IFNDEF LIMITEDGRAPHICSMODE}
    property OptimizedHTMLDrawing: Boolean read FOptimizedHTMLDrawing write FOptimizedHTMLDrawing;
    property HighlightColor: TAdvChartGraphicsColor read FHighlightColor write FHighlightColor;
    property HighlightTextColor: TAdvChartGraphicsColor read FHighlightTextColor write FHighlightTextColor;
    property HighlightFontStyle: TFontStyles read FHighlightFontStyles write FHighlightFontStyles;
    {$IFDEF CMNLIB}
    property ImageList: TCustomImageList read FImageList write FImageList;
    {$ENDIF}
    property BitmapContainer: TAdvChartBitmapContainer read FBitmapContainer write FBitmapContainer;
    property URLColor: TAdvChartGraphicsColor read FURLColor write FURLColor default gcBlue;
    property URLUnderline: Boolean read FURLUnderline write FURLUnderline default True;
    class function ApplyHilight(AText, AHilight, ATag: string; ADoCase: Boolean): string;
    class function GetBitmapFromBitmapContainer(ABitmapContainer: TAdvChartBitmapContainer; AName: string; AApplyScale: Boolean = False; AScale: Single = 0): TAdvChartBitmap; virtual;
    class function GetScaledBitmap(ABitmaps: TAdvScaledBitmaps; AScale: Single = 0; ABitmapContainer: TAdvChartBitmapContainer = nil): TAdvChartBitmap;
    {$ENDIF}
    class procedure GetAspectSize(var AWidth: Single; var AHeight: Single; AOriginalWidth: Single; AOriginalHeight: Single; ANewWidth: Single; ANewHeight: Single; AAspectRatio: Boolean = True;
      AStretch: Boolean = False; ACropping: Boolean = False); virtual;
    class procedure DrawSample(ACanvas: TCanvas; ARect: TRectF); virtual;
    class procedure SetDefaultGraphicColors; virtual;
    class function PointInCircle(APoint: TPointF; ACenter: TPointF; const ARadius: Single): Boolean; virtual;
    class function PointInPath(APoint: TPointF; APath: TAdvChartGraphicsPath): Boolean; overload; virtual;
    class function PointInPath(APoint: TPoint; APath: TAdvChartGraphicsPath): Boolean; overload; virtual;
    class function PointInPolygon(APoint: TPointF; APolygon: TAdvChartGraphicsPathPolygon): Boolean; overload; virtual;
    class function PointInPolygon(APoint: TPoint; APolygon: TAdvChartGraphicsPathPolygon): Boolean; overload; virtual;
    class function PointInRect(APoint: TPointF; ARect: TRectF): Boolean; overload; virtual;
    class function PointInRect(APoint: TPoint; ARect: TRect): Boolean; overload; virtual;
    class function GetColorRed(AColor: TAdvChartGraphicsColor): Byte; virtual;
    class function GetColorGreen(AColor: TAdvChartGraphicsColor): Byte; virtual;
    class function GetColorBlue(AColor: TAdvChartGraphicsColor): Byte; virtual;
    {$IFDEF FMXLIB}
    class function GetColorAlpha(AColor: TAdvChartGraphicsColor): Byte; virtual;
    {$ENDIF}
    class function ColorToHTML(AColor: TAdvChartGraphicsColor): string; virtual;
    class function HTMLToColor(AHTML: string): TAdvChartGraphicsColor; virtual;
    class function TextToColor(AText: string): TAdvChartGraphicsColor; virtual;
  end;

  IAdvChartGraphicsExport = interface
    ['{481CA803-8B50-4545-B212-57AC0D065D09}']
    procedure &Export({%H-}AGraphics: TAdvChartGraphics; {%H-}ARect: TRectF);
  end;

{$IFDEF WEBLIB}
const
  AdvGRAPHICSCLOSE = 'data:image/PNG;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJ'+
                        'cEhZcwAACxIAAAsSAdLdfvwAAAAYdEVYdFNvZnR3YXJlAHBhaW50Lm5ldCA0LjAuOWwzfk4AAABVSURBVDhPYxh+'+
                        'QBSI/0OYWAFIThjCxA5ACmAYHeCTQwHYFGITwwuQNSBjkgBFmkGAIgNAGv5BaZINQdYMA0Qbgk0zDBBlCCiR4FMA'+
                        'khOCMIcJYGAAAHvVMBv6PIFYAAAAAElFTkSuQmCC';
  AdvGRAPHICSDOWN = 'data:image/PNG;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEwAACxMBA'+
                       'JqcGAAAAGdJREFUOI3tzjsOwjAURNGDUqSgTxU5K2AVrJtswjUsgHSR0qdxAZZFPrS+3ZvRzBsqf9MUtBtazJk+oM'+
                       'e0VTriiZCFX8nbpENMgfARjsn74vKj5IFruhfc8d6zIF9S/Hyk5HS4spMVeFcOjszaOwMAAAAASUVORK5CYII=';
  AdvGRAPHICSDOWN2 = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAA'+
                        'RnQU1BAACxjwv8YQUAAAAJcEhZcwAACxIAAAsSAdLdfvwAAAAZdEVYdFNvZnR3YXJlAHBhaW50Lm5ldCA0LjAuMT'+
                        'ZEaa/1AAAAdElEQVQ4T6XMsQ2AMBBD0UxBBwyA2L9jCWpY5bCLSJfgSFgUr+AHX4mIX2R0yOiQ0SGjQ8Ud5q7RCl'+
                        'vX5IEDLlhS4/gGvuV/5YEJTuCAR+qYjW/N/81Hko8Mx/QKST0yHJOMCYfDMcnokNEho0NGh4zfRXkAxSYKjdpwcI'+
                        'UAAAAASUVORK5CYII=';
  AdvGRAPHICSUP = 'data:image/PNG;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEwAACxMBAJq'+
                     'cGAAAAEZJREFUOI3tjLEJACAMwLLo5EM+rTjpXV7g0oI4tYKbgYwJfJ6Txet4iu6Jxk10TTSuQACidzKAIrGik24ZpC'+
                     'PeJ8ky+DhZ1JENPrPndiwAAAAASUVORK5CYII=';
  AdvGRAPHICSUP2 = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAARn'+
                      'QU1BAACxjwv8YQUAAAAJcEhZcwAACxIAAAsSAdLdfvwAAAAZdEVYdFNvZnR3YXJlAHBhaW50Lm5ldCA0LjAuMTZEaa'+
                      '/1AAAAcklEQVQ4T6XMMQ6AMAiF4S46eSEvremk5/IC+GggKfE1ER2+gZ9AEZFfaMygMYPGDBozaOyshu0aGo0eXmb4'+
                      'hEbw42qGTx4B/HiHCWYYPgmDOWEDPfbmT46uNWEwC/THTp/oLvQwfEFjBo0ZNGbQ+J6UG5Y9CmuVGrAsAAAAAElFTkS'+
                      'uQmCC';
  AdvGRAPHICSPIN = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAAOCAYAAAAfSC3RAAAAAXNSR0IArs4c6QAAAARnQ'+
                      'U1BAACxjwv8YQUAAAAJcEhZcwAADsIAAA7CARUoSoAAAAAZdEVYdFNvZnR3YXJlAHBhaW50Lm5ldCA0LjAuMTZEaa/1'+
                      'AAABKklEQVQ4T2PAB0JDQ5mjoqIEgUxGiAiRIDo6WiY8PHwdEGvW19czQYUJA6AGhbCwsO9Aek1ISIiZvb09C1QKPwB'+
                      'qaAbi/1DNJ4HYiqDNIE1ADZ9AGqGa/wLp6xERESZAaVQ/AyUUgDgIiOdCbQFrQsL/gPgxUM4OFACSQMYdIP4FFPwNxH'+
                      '+gpqNoAortAYayHNSfjAwgNwMFvaCaMTQA8W+g+M7IyEgNiLuQAMgUoNsDgYruoWkCOe1gcHCwHlQpJgA6wwCo6DySJ'+
                      'hD+BDQwCaoEEwA1SQAVzQLiq0BcBMRXgBhk25PAwEBJqDJUkJaWxgr0QzoQbwYqdABGNCeQrQPSDKTv44w3oFPEgYqm'+
                      'Amk9UNqECjMCxWSBeAeUjx1ANWAkZCSD0AADAwDRpKHlJfOjAwAAAABJRU5ErkJggg==';
  AdvGRAPHICSPIN2 = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAAOCAYAAAAfSC3RAAAAAXNSR0IArs4c6QAAAARn'+
                       'QU1BAACxjwv8YQUAAAAJcEhZcwAADsIAAA7CARUoSoAAAAAZdEVYdFNvZnR3YXJlAHBhaW50Lm5ldCA0LjAuMTZEaa'+
                       '/1AAAA/UlEQVQ4T33Su2oCQRTGcddLYWmlQhTLCBIsQgoLSW2nj2Bj7yv4DGkCeYOQxiaBNJapbCI2ooU+gY3gbf1/'+
                       'w47MjosHfsvM7DlzY1JhGN6TQQGBM2bEOgke8IU60tGY4SYlqWGHT7wgC/PPT/SNoFDxH1owKyclWyrawsYJczwj8J'+
                       'O1tR4+oFX8OGONtpLLWGCPA47Q7H78ogqd06yoPXeg4qQCTfaDR1x3ZxuapYsl3NDWJnjCtUjcThNTuKHL6cPNM2yj'+
                       'hHfMMMQ/tNoGuoNYkeiTwwBjvCKPBlS8QuzFWPoU8QadQ29TY3qbFXxH/Ru2oYKbhww7kSdMXQD8wIToOQZE/AAAAA'+
                       'BJRU5ErkJggg==';
  AdvGRAPHICSRIGHT = 'data:image/PNG;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEwAACxMB'+
                        'AJqcGAAAAFNJREFUOI3tzzsSQFAQRNFDqSezHUuwYBJLsBuhEomE4/ll3HBq+nY1PxENRrS5xzK4L1jPSiISesxP'+
                        'JcORJJqwU9xthjrX/ko4mpBQocN0tf1rbDeZDIfcSud0AAAAAElFTkSuQmCC';
  AdvGRAPHICSLEFT = 'data:image/PNG;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEwAACxMBA'+
                       'JqcGAAAAEpJREFUOI3lzKENgEAQAMEJBkkIDdDTSxp6gqMyCkB8IQgMFdwZAutn+U19Bi84MUbxhZrBawSXB+8RDD'+
                       'MaDkyvmQyZyYYuOvh6N24uDUKEV//MAAAAAElFTkSuQmCC';
  AdvCHARTGRAPHICSEXPAND = 'data:image/PNG;base64,iVBORw0KGgoAAAANSUhEUgAAAAcAAAAHCAYAAADEUlfTAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOvwAADr8'+
                         'BOAVTJAAAABh0RVh0U29mdHdhcmUAcGFpbnQubmV0IDQuMC4zjOaXUAAAACVJREFUGFdj+P//P07MEBYW9h8Xxi'+
                         '8JAjglYACnBAzglMAEDAwARZ1DA4NRF38AAAAASUVORK5CYII=';

  AdvCHARTGRAPHICSEXPANDSVG = 'data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB4bWxucz0iaHR0cDovL3d'
    +'3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB3aWR0aD0iMTJweC'
    +'IgaGVpZ2h0PSIxMnB4IiB2aWV3Qm94PSIwIDAgMTIgMTIiIHZlcnNpb249IjEuMSI+CjxnIGlkPSJzdXJmYWNlMSI+CjxwYXRoI'
    +'HN0eWxlPSIgc3Ryb2tlOm5vbmU7ZmlsbC1ydWxlOm5vbnplcm87ZmlsbDpyZ2IoMCUsMCUsMCUpO2ZpbGwtb3BhY2l0eToxOyIg'
    +'ZD0iTSAxMS44Mzk4NDQgMi44ODY3MTkgQyAxMS42Mjg5MDYgMi42NzU3ODEgMTEuMjgxMjUgMi42NzU3ODEgMTEuMDcwMzEyIDI'
    +'uODg2NzE5IEwgNiA3Ljk1NzAzMSBMIDAuOTI5Njg4IDIuODg2NzE5IEMgMC43MTg3NSAyLjY3NTc4MSAwLjM3MTA5NCAyLjY3NT'
    +'c4MSAwLjE2MDE1NiAyLjg4NjcxOSBDIC0wLjA1NDY4NzUgMy4xMDE1NjIgLTAuMDU0Njg3NSAzLjQ0NTMxMiAwLjE2MDE1NiAzL'
    +'jY2MDE1NiBMIDUuNjEzMjgxIDkuMTEzMjgxIEMgNS43MTQ4NDQgOS4yMTQ4NDQgNS44NTU0NjkgOS4yNzM0MzggNiA5LjI3MzQz'
    +'OCBDIDYuMTQ0NTMxIDkuMjczNDM4IDYuMjg1MTU2IDkuMjE0ODQ0IDYuMzg2NzE5IDkuMTEzMjgxIEwgMTEuODM5ODQ0IDMuNjY'
    +'wMTU2IEMgMTIuMDU0Njg4IDMuNDQ1MzEyIDEyLjA1NDY4OCAzLjEwMTU2MiAxMS44Mzk4NDQgMi44ODY3MTkgWiBNIDExLjgzOT'
    +'g0NCAyLjg4NjcxOSAiLz4KPC9nPgo8L3N2Zz4K';

  AdvGRAPHICSDOWNSVG = 'data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB4bWxucz0iaHR0cDovL3d'
    +'3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB3aWR0aD0iMTJweC'
    +'IgaGVpZ2h0PSIxMnB4IiB2aWV3Qm94PSIwIDAgMTIgMTIiIHZlcnNpb249IjEuMSI+CjxnIGlkPSJzdXJmYWNlMSI+CjxwYXRoI'
    +'HN0eWxlPSIgc3Ryb2tlOm5vbmU7ZmlsbC1ydWxlOm5vbnplcm87ZmlsbDpyZ2IoMCUsMCUsMCUpO2ZpbGwtb3BhY2l0eToxOyIg'
    +'ZD0iTSAxMS44Mzk4NDQgMi44ODY3MTkgQyAxMS42Mjg5MDYgMi42NzU3ODEgMTEuMjgxMjUgMi42NzU3ODEgMTEuMDcwMzEyIDI'
    +'uODg2NzE5IEwgNiA3Ljk1NzAzMSBMIDAuOTI5Njg4IDIuODg2NzE5IEMgMC43MTg3NSAyLjY3NTc4MSAwLjM3MTA5NCAyLjY3NT'
    +'c4MSAwLjE2MDE1NiAyLjg4NjcxOSBDIC0wLjA1NDY4NzUgMy4xMDE1NjIgLTAuMDU0Njg3NSAzLjQ0NTMxMiAwLjE2MDE1NiAzL'
    +'jY2MDE1NiBMIDUuNjEzMjgxIDkuMTEzMjgxIEMgNS43MTQ4NDQgOS4yMTQ4NDQgNS44NTU0NjkgOS4yNzM0MzggNiA5LjI3MzQz'
    +'OCBDIDYuMTQ0NTMxIDkuMjczNDM4IDYuMjg1MTU2IDkuMjE0ODQ0IDYuMzg2NzE5IDkuMTEzMjgxIEwgMTEuODM5ODQ0IDMuNjY'
    +'wMTU2IEMgMTIuMDU0Njg4IDMuNDQ1MzEyIDEyLjA1NDY4OCAzLjEwMTU2MiAxMS44Mzk4NDQgMi44ODY3MTkgWiBNIDExLjgzOT'
    +'g0NCAyLjg4NjcxOSAiLz4KPC9nPgo8L3N2Zz4K';

  AdvGRAPHICSUPSVG = 'data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB4bWxucz0iaHR0cDovL3d3'
    +'dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB3aWR0aD0iMTJweCI'
    +'gaGVpZ2h0PSIxMnB4IiB2aWV3Qm94PSIwIDAgMTIgMTIiIHZlcnNpb249IjEuMSI+CjxnIGlkPSJzdXJmYWNlMSI+CjxwYXRoIH'
    +'N0eWxlPSIgc3Ryb2tlOm5vbmU7ZmlsbC1ydWxlOm5vbnplcm87ZmlsbDpyZ2IoMCUsMCUsMCUpO2ZpbGwtb3BhY2l0eToxOyIgZ'
    +'D0iTSAxMS44Mzk4NDQgOC4zMzk4NDQgTCA2LjM4NjcxOSAyLjg4NjcxOSBDIDYuMjg1MTU2IDIuNzg1MTU2IDYuMTQ0NTMxIDIu'
    +'NzI2NTYyIDYgMi43MjY1NjIgQyA1Ljg1NTQ2OSAyLjcyNjU2MiA1LjcxNDg0NCAyLjc4NTE1NiA1LjYxMzI4MSAyLjg4NjcxOSB'
    +'MIDAuMTYwMTU2IDguMzM5ODQ0IEMgLTAuMDU0Njg3NSA4LjU1NDY4OCAtMC4wNTQ2ODc1IDguODk4NDM4IDAuMTYwMTU2IDkuMT'
    +'EzMjgxIEMgMC4zNzEwOTQgOS4zMjQyMTkgMC43MTg3NSA5LjMyNDIxOSAwLjkyOTY4OCA5LjExMzI4MSBMIDYgNC4wNDI5NjkgT'
    +'CAxMS4wNzAzMTIgOS4xMTMyODEgQyAxMS4xNzU3ODEgOS4yMTg3NSAxMS4zMTY0MDYgOS4yNzM0MzggMTEuNDUzMTI1IDkuMjcz'
    +'NDM4IEMgMTEuNTkzNzUgOS4yNzM0MzggMTEuNzM0Mzc1IDkuMjE4NzUgMTEuODM5ODQ0IDkuMTEzMjgxIEMgMTIuMDU0Njg4IDg'
    +'uODk4NDM4IDEyLjA1NDY4OCA4LjU1NDY4OCAxMS44Mzk4NDQgOC4zMzk4NDQgWiBNIDExLjgzOTg0NCA4LjMzOTg0NCAiLz4KPC'
    +'9nPgo8L3N2Zz4K';

  AdvGRAPHICSRIGHTSVG = 'data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB4bWxucz0iaHR0cDovL3d3'
    +'dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB3aWR0aD0iMTJweCI'
    +'gaGVpZ2h0PSIxMnB4IiB2aWV3Qm94PSIwIDAgMTIgMTIiIHZlcnNpb249IjEuMSI+CjxnIGlkPSJzdXJmYWNlMSI+CjxwYXRoIH'
    +'N0eWxlPSIgc3Ryb2tlOm5vbmU7ZmlsbC1ydWxlOm5vbnplcm87ZmlsbDpyZ2IoMCUsMCUsMCUpO2ZpbGwtb3BhY2l0eToxOyIgZ'
    +'D0iTSA5LjExMzI4MSA1LjYxMzI4MSBMIDMuNjYwMTU2IDAuMTYwMTU2IEMgMy40NDUzMTIgLTAuMDU0Njg3NSAzLjEwMTU2MiAt'
    +'MC4wNTQ2ODc1IDIuODg2NzE5IDAuMTYwMTU2IEMgMi42NzU3ODEgMC4zNzEwOTQgMi42NzU3ODEgMC43MTg3NSAyLjg4NjcxOSA'
    +'wLjkyOTY4OCBMIDcuOTU3MDMxIDYgTCAyLjg4NjcxOSAxMS4wNzAzMTIgQyAyLjY3NTc4MSAxMS4yODEyNSAyLjY3NTc4MSAxMS'
    +'42Mjg5MDYgMi44ODY3MTkgMTEuODM5ODQ0IEMgMi45OTIxODggMTEuOTQ1MzEyIDMuMTMyODEyIDEyIDMuMjczNDM4IDEyIEMgM'
    +'y40MTQwNjIgMTIgMy41NTA3ODEgMTEuOTQ1MzEyIDMuNjYwMTU2IDExLjgzOTg0NCBMIDkuMTEzMjgxIDYuMzg2NzE5IEMgOS4y'
    +'MTQ4NDQgNi4yODUxNTYgOS4yNzM0MzggNi4xNDQ1MzEgOS4yNzM0MzggNiBDIDkuMjczNDM4IDUuODU1NDY5IDkuMjE0ODQ0IDU'
    +'uNzE0ODQ0IDkuMTEzMjgxIDUuNjEzMjgxIFogTSA5LjExMzI4MSA1LjYxMzI4MSAiLz4KPC9nPgo8L3N2Zz4K';

  AdvGRAPHICSLEFTSVG = 'data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB4bWxucz0iaHR0cDovL3d3'
    +'dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB3aWR0aD0iMTJweCI'
    +'gaGVpZ2h0PSIxMnB4IiB2aWV3Qm94PSIwIDAgMTIgMTIiIHZlcnNpb249IjEuMSI+CjxnIGlkPSJzdXJmYWNlMSI+CjxwYXRoIH'
    +'N0eWxlPSIgc3Ryb2tlOm5vbmU7ZmlsbC1ydWxlOm5vbnplcm87ZmlsbDpyZ2IoMCUsMCUsMCUpO2ZpbGwtb3BhY2l0eToxOyIgZ'
    +'D0iTSA0LjA0Mjk2OSA2IEwgOS4xMTMyODEgMC45Mjk2ODggQyA5LjMyNDIxOSAwLjcxODc1IDkuMzI0MjE5IDAuMzcxMDk0IDku'
    +'MTEzMjgxIDAuMTYwMTU2IEMgOC44OTg0MzggLTAuMDU0Njg3NSA4LjU1NDY4OCAtMC4wNTQ2ODc1IDguMzM5ODQ0IDAuMTYwMTU'
    +'2IEwgMi44ODY3MTkgNS42MTMyODEgQyAyLjc4NTE1NiA1LjcxNDg0NCAyLjcyNjU2MiA1Ljg1NTQ2OSAyLjcyNjU2MiA2IEMgMi'
    +'43MjY1NjIgNi4xNDQ1MzEgMi43ODUxNTYgNi4yODUxNTYgMi44ODY3MTkgNi4zODY3MTkgTCA4LjMzOTg0NCAxMS44Mzk4NDQgQ'
    +'yA4LjQ0OTIxOSAxMS45NDUzMTIgOC41ODU5MzggMTIgOC43MjY1NjIgMTIgQyA4Ljg2NzE4OCAxMiA5LjAwNzgxMiAxMS45NDUz'
    +'MTIgOS4xMTMyODEgMTEuODM5ODQ0IEMgOS4zMjQyMTkgMTEuNjI4OTA2IDkuMzI0MjE5IDExLjI4MTI1IDkuMTEzMjgxIDExLjA'
    +'3MDMxMiBaIE0gNC4wNDI5NjkgNiAiLz4KPC9nPgo8L3N2Zz4K';

  AdvGRAPHICSCLOSESVG = 'data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciI'
    +'HhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB3aWR0aD0iMTJweCIgaGVpZ2h0PSIxMnB4IiB2aWV3'
    +'Qm94PSIwIDAgMTIgMTIiIHZlcnNpb249IjEuMSI+CjxnIGlkPSJzdXJmYWNlMSI+CjxwYXRoIHN0eWxlPSIgc3Ryb2tlOm5vbmU'
    +'7ZmlsbC1ydWxlOm5vbnplcm87ZmlsbDpyZ2IoMCUsMCUsMCUpO2ZpbGwtb3BhY2l0eToxOyIgZD0iTSA3LjA2MjUgNiBMIDExLj'
    +'c4MTI1IDEuMjgxMjUgQyAxMi4wNzQyMTkgMC45ODgyODEgMTIuMDc0MjE5IDAuNTExNzE5IDExLjc4MTI1IDAuMjE4NzUgQyAxM'
    +'S40ODgyODEgLTAuMDc0MjE4OCAxMS4wMTE3MTkgLTAuMDc0MjE4OCAxMC43MTg3NSAwLjIxODc1IEwgNiA0LjkzNzUgTCAxLjI4'
    +'MTI1IDAuMjE4NzUgQyAwLjk4ODI4MSAtMC4wNzQyMTg4IDAuNTExNzE5IC0wLjA3NDIxODggMC4yMTg3NSAwLjIxODc1IEMgLTA'
    +'uMDc0MjE4OCAwLjUxMTcxOSAtMC4wNzQyMTg4IDAuOTg4MjgxIDAuMjE4NzUgMS4yODEyNSBMIDQuOTM3NSA2IEwgMC4yMTg3NS'
    +'AxMC43MTg3NSBDIC0wLjA3NDIxODggMTEuMDExNzE5IC0wLjA3NDIxODggMTEuNDg4MjgxIDAuMjE4NzUgMTEuNzgxMjUgQyAwL'
    +'jM2NzE4OCAxMS45MjU3ODEgMC41NTg1OTQgMTIgMC43NSAxMiBDIDAuOTQxNDA2IDEyIDEuMTMyODEyIDExLjkyNTc4MSAxLjI4'
    +'MTI1IDExLjc4MTI1IEwgNiA3LjA2MjUgTCAxMC43MTg3NSAxMS43ODEyNSBDIDEwLjg2NzE4OCAxMS45MjU3ODEgMTEuMDU4NTk'
    +'0IDEyIDExLjI1IDEyIEMgMTEuNDQxNDA2IDEyIDExLjYzMjgxMiAxMS45MjU3ODEgMTEuNzgxMjUgMTEuNzgxMjUgQyAxMi4wNz'
    +'QyMTkgMTEuNDg4MjgxIDEyLjA3NDIxOSAxMS4wMTE3MTkgMTEuNzgxMjUgMTAuNzE4NzUgWiBNIDcuMDYyNSA2ICIvPgo8L2c+C'
    +'jwvc3ZnPgo=';


{$ENDIF}

implementation

uses
  SysUtils, Math
  {$IFNDEF WEBLIB}
  {$IFDEF SVGSUPPORT}
  ,AdvChartGraphicsSVGEngine
  {$ENDIF}
  {$ENDIF}
  ,AdvChartUtils
  {$IFNDEF LIMITEDGRAPHICSMODE}
  ,AdvChartHTMLEngine
  {$ENDIF}
  ,AdvChartGraphics.General
  {$IFDEF WEBLIB}
  ,AdvChartGraphics.WEB
  {$ENDIF}
  {$IFDEF MSWINDOWS}
  ,AdvChartGraphics.Win
  {$ENDIF}
  {$IFDEF MACOS}
  {$IFDEF IOS}
  ,AdvChartGraphics.iOS
  {$ENDIF}
  {$IFNDEF IOS}
  ,AdvChartGraphics.Mac
  {$ENDIF}
  {$ENDIF}
  {$IFDEF ANDROID}
  ,AdvChartGraphics.Android
  {$ENDIF}
  {$IFDEF UNIX}
  ,AdvChartGraphics.Unix
  {$ENDIF}
  {$IFDEF LCLLIB}
  {$IFNDEF MSWINDOWS}
  ,LCLIntF
  {$ENDIF}
  {$ENDIF}
  ;

{$IFNDEF LIMITEDGRAPHICSMODE}
{$R AdvChartGraphics.res}
{$ENDIF}

procedure TAdvChartGraphics.EndPrinting;
begin
  Context.EndPrinting;
end;

procedure TAdvChartGraphics.EndScene;
begin
  Context.EndScene;
end;

procedure TAdvChartGraphics.BeginPrinting;
begin
  Context.BeginPrinting;
end;

procedure TAdvChartGraphics.BeginScene;
begin
  Context.BeginScene;
end;

constructor TAdvChartGraphics.CreateNativeBitmapCanvas(AWidth: Integer = 1; AHeight: Integer = 1);
begin
  CreateBitmapCanvas(AWidth, AHeight, True);
end;

constructor TAdvChartGraphics.CreateBitmapCanvas(AWidth: Integer = 1; AHeight: Integer = 1; ANative: Boolean = False; AHighDPI: Boolean = True);
begin
  FNative := ANative;
  FBitmap := TBitmap.Create{$IFDEF FMXLIB}(AWidth, AHeight){$ENDIF};
  {$IFDEF FMXLIB}
  if AHighDPI then
    FBitmap.BitmapScale := TAdvChartUtils.GetDPIScale;
  {$ENDIF}
  FBitmap.Width := AWidth;
  FBitmap.Height := AHeight;
  FActiveCanvas := FBitmap.Canvas;
  if not ANative then
  begin
    FContextGeneral := TAdvChartGraphicsContextGeneral.Create(Self);
    FContextGeneral.SetSize(AWidth, AHeight);
  end
  else
  begin
    FContextNative := GetNativeContextClass.Create(Self);
    FContextNative.SetSize(AWidth, AHeight);
  end;
  FFill := TAdvChartGraphicsFill.Create;
  FFill.OnChanged := FillChanged;
  FStroke := TAdvChartGraphicsStroke.Create;
  FStroke.OnChanged := StrokeChanged;
  FFont := TAdvChartGraphicsFont.Create;
  FFont.OnChanged := FontChanged;
  InitializeDefaultAppearance;
end;

constructor TAdvChartGraphics.CreateNative(ACanvas: TCanvas);
begin
  Create(ACanvas, True);
end;

constructor TAdvChartGraphics.Create(ACanvas: TCanvas; ANative: Boolean = False);
begin
  FNative := ANative;
  FActiveCanvas := ACanvas;
  if not ANative then
  begin
    FContextGeneral := TAdvChartGraphicsContextGeneral.Create(Self);
    FContextGeneral.SetSize(1, 1);
  end
  else
  begin
    FContextNative := GetNativeContextClass.Create(Self);
    FContextNative.SetSize(1, 1);
  end;
  FFill := TAdvChartGraphicsFill.Create;
  FFill.OnChanged := FillChanged;
  FStroke := TAdvChartGraphicsStroke.Create;
  FStroke.OnChanged := StrokeChanged;
  FFont := TAdvChartGraphicsFont.Create;
  FFont.OnChanged := FontChanged;
  {$IFNDEF LIMITEDGRAPHICSMODE}
  FHighlightColor := gcBlue;
  FHighlightTextColor := gcWhite;
  FHighlightFontStyles := [];
  {$eNDIF}

  InitializeDefaultAppearance;
end;

procedure TAdvChartGraphics.RestoreState(AState: TAdvChartGraphicsSaveState; ACanvasOnly: Boolean = False);
begin
  if not ACanvasOnly then
  begin
    SetFill(AState.Fill);
    SetStroke(AState.Stroke);
    SetFont(AState.Font);
  end;

  Context.RestoreState(AState);

  AState.Free;
end;

function TAdvChartGraphics.SaveState(ACanvasOnly: Boolean = False): TAdvChartGraphicsSaveState;
begin
  Result := TAdvChartGraphicsSaveState.Create;

  if not ACanvasOnly then
  begin
    Result.Fill.Assign(FFill);
    Result.Stroke.Assign(FStroke);
    Result.Font.AssignSource(FFont);
  end;

  Context.SaveState(Result);
end;

procedure TAdvChartGraphics.StopSpecialPen;
begin
  Context.StopSpecialPen;
end;

procedure TAdvChartGraphics.StartSpecialPen;
begin
  Context.StartSpecialPen;
end;

procedure TAdvChartGraphics.Assign(Source: TAdvChartGraphics);
begin
  if Source is TAdvChartGraphics then
  begin
    FFill.BeginUpdate;
    FFill.Assign((Source as TAdvChartGraphics).Fill);
    FFill.EndUpdate;
    FStroke.BeginUpdate;
    FStroke.Assign((Source as TAdvChartGraphics).Stroke);
    FStroke.EndUpdate;
    FFont.BeginUpdate;
    FFont.AssignSource((Source as TAdvChartGraphics).Font);
    FFont.EndUpdate;
  end;
end;

procedure TAdvChartGraphics.SetFill(AFill: TAdvChartGraphicsFill);
begin
  if FBlockUpdate > 0 then
    Exit;

  Inc(FBlockUpdate);
  Context.SetFill(AFill);
  FFill.Assign(AFill);
  Dec(FBlockUpdate);
end;

procedure TAdvChartGraphics.SetFillKind(AKind: TAdvChartGraphicsFillKind);
begin
  if FBlockUpdate > 0 then
    Exit;

  Inc(FBlockUpdate);
  Context.SetFillKind(AKind);
  FFill.Kind := AKind;
  Dec(FBlockUpdate);
end;

procedure TAdvChartGraphics.SetFillColor(AColor: TAdvChartGraphicsColor);
begin
  if FBlockUpdate > 0 then
    Exit;

  Inc(FBlockUpdate);
  Context.SetFillColor(AColor);
  FFill.Color := AColor;
  Dec(FBlockUpdate);
end;

procedure TAdvChartGraphics.SetStrokeKind(AKind: TAdvChartGraphicsStrokeKind);
begin
  if FBlockUpdate > 0 then
    Exit;

  Inc(FBlockUpdate);
  Context.SetStrokeKind(AKind);
  FStroke.Kind := AKind;
  Dec(FBlockUpdate);
end;

procedure TAdvChartGraphics.SetStroke(AStroke: TAdvChartGraphicsStroke);
begin
  if FBlockUpdate > 0 then
    Exit;

  Inc(FBlockUpdate);
  Context.SetStroke(AStroke);
  FStroke.Assign(AStroke);
  Dec(FBlockUpdate);
end;

procedure TAdvChartGraphics.SetStrokeWidth(AWidth: Single);
begin
  if FBlockUpdate > 0 then
    Exit;

  Inc(FBlockUpdate);
  Context.SetStrokeWidth(AWidth);
  FStroke.Width := AWidth;
  Dec(FBlockUpdate);
end;

procedure TAdvChartGraphics.SetStrokeColor(AColor: TAdvChartGraphicsColor);
begin
  if FBlockUpdate > 0 then
    Exit;

  Inc(FBlockUpdate);
  Context.SetStrokeColor(AColor);
  FStroke.Color := AColor;
  Dec(FBlockUpdate);
end;

procedure TAdvChartGraphics.DrawLine(AFromPoint: TPoint; AToPoint: TPoint; AModifyPointModeFrom: TAdvChartGraphicsModifyPointMode = gcpmRightDown;
  AModifyPointModeTo: TAdvChartGraphicsModifyPointMode = gcpmRightDown);
begin
  DrawLine(ConvertToPointF(AFromPoint), ConvertToPointF(AToPoint), AModifyPointModeFrom, AModifyPointModeTo);
end;

procedure TAdvChartGraphics.DrawLine(AFromPoint: TPointF; AToPoint: TPointF; AModifyPointModeFrom: TAdvChartGraphicsModifyPointMode = gcpmRightDown;
  AModifyPointModeTo: TAdvChartGraphicsModifyPointMode = gcpmRightDown);
begin
  if (FStroke.Color <> gcNull) and (FStroke.Kind <> gskNone) then
    Context.DrawLine(FStroke, AFromPoint, AToPoint, AModifyPointModeFrom, AModifyPointModeTo);
end;

procedure TAdvChartGraphics.DrawPolyline(APolyline: TAdvChartGraphicsPathPolygon);
begin
  if (FFill.Color <> gcNull) and (FFill.Kind <> gfkNone) then
    Context.FillPolyline(FFill, APolyline);

  if (FStroke.Color <> gcNull) and (FStroke.Kind <> gskNone) then
    Context.DrawPolyline(FStroke, APolyline);
end;

procedure TAdvChartGraphics.DrawPolygon(APolygon: TAdvChartGraphicsPathPolygon);
var
  pth: TAdvChartGraphicsPath;
begin
  if ((FFill.Color <> gcNull) and (FFill.Kind <> gfkNone)) or (FFill.Kind = gfkTexture) then
  begin
    case FFill.Kind of
      gfkTexture:
      begin
        pth := TAdvChartGraphicsPath.Create;
        try
          pth.AddPolygon(APolygon);
          DrawTexture(pth.GetBounds, FFill.Texture, FFill.TextureMode);
        finally
          pth.Free;
        end;
      end;
      else
        Context.FillPolygon(FFill, APolygon);
    end;
  end;

  if (FStroke.Color <> gcNull) and (FStroke.Kind <> gskNone) then
    Context.DrawPolygon(FStroke, APolygon);
end;

procedure TAdvChartGraphics.DrawPath(APath: TAdvChartGraphicsPath; APathMode: TAdvChartGraphicsPathDrawMode = pdmPolygon);
begin
  if ((FFill.Color <> gcNull) and (FFill.Kind <> gfkNone)) or (FFill.Kind = gfkTexture) then
  begin
    case FFill.Kind of
      gfkTexture: DrawTexture(APath.GetBounds, FFill.Texture, FFill.TextureMode);
      else
        Context.FillPath(FFill, APath, APathMode);
    end;
  end;

  if (FStroke.Color <> gcNull) and (FStroke.Kind <> gskNone) then
    Context.DrawPath(FStroke, APath, APathMode);
end;

procedure TAdvChartGraphics.DrawArc(const Center: TPoint; const Radius: TPoint; StartAngle: Integer; SweepAngle: Integer);
begin
  DrawArc(ConvertToPointF(Center), ConvertToPointF(Radius), StartAngle, SweepAngle);
end;

procedure TAdvChartGraphics.DrawArc(const Center: TPointF; const Radius: TPointF; StartAngle: Single; SweepAngle: Single);
var
  pth: TAdvChartGraphicsPath;
begin
  if (FFill.Color <> gcNull) and (FFill.Kind <> gfkNone) then
  begin
    case FFill.Kind of
      gfkTexture:
      begin
        pth := TAdvChartGraphicsPath.Create;
        try
          pth.AddArc(Center, Radius, StartAngle, SweepAngle);
          DrawTexture(pth.GetBounds, FFill.Texture, FFill.TextureMode);
        finally
          pth.Free;
        end;
      end;
      else
        Context.FillArc(FFill, Center, Radius, StartAngle, SweepAngle);
    end;
  end;

  if (FStroke.Color <> gcNull) and (FStroke.Kind <> gskNone) then
    Context.DrawArc(FStroke, Center, Radius, StartAngle, SweepAngle);
end;

procedure TAdvChartGraphics.DrawRoundRectangle(ARect: TRect; ARounding: Integer = 10; ACorners: TAdvChartGraphicsCorners = [gcTopLeft, gcTopRight, gcBottomLeft, gcBottomRight]; AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll);
begin
  DrawRoundRectangle(ConvertToRectF(ARect), ARounding, ACorners);
end;

procedure TAdvChartGraphics.DrawRoundRectangle(ARect: TRectF; ARounding: Single = 10; ACorners: TAdvChartGraphicsCorners = [gcTopLeft, gcTopRight, gcBottomLeft, gcBottomRight]; AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll);
begin
  DrawRoundRectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom, ARounding, ACorners, AModifyRectMode);
end;

procedure TAdvChartGraphics.DrawRectangle(ALeft: Integer; ATop: Integer; ARight: Integer; ABottom: Integer; AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll);
begin
  DrawRectangle(RectF(ALeft, ATop, ARight, ABottom), AModifyRectMode);
end;

procedure TAdvChartGraphics.DrawRectangle(ALeft: Double; ATop: Double; ARight: Double; ABottom: Double; AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll);
begin
  DrawRectangle(ALeft, ATop, ARight, ABottom, AllSides, AModifyRectMode);
end;

procedure TAdvChartGraphics.DrawRectangle(ALeft: Integer; ATop: Integer; ARight: Integer; ABottom: Integer; ASides: TAdvChartGraphicsSides; AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll);
begin
  DrawRectangle(RectF(ALeft, ATop, ARight, ABottom), ASides, AModifyRectMode);
end;

procedure TAdvChartGraphics.DrawRectangle(ALeft: Double; ATop: Double; ARight: Double; ABottom: Double; ASides: TAdvChartGraphicsSides; AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll);
var
  r: TRectF;
  pth: TAdvChartGraphicsPath;
begin
  r := RectF(ALeft, ATop, ARight, ABottom);
  if ((FFill.Color <> gcNull) and (FFill.Kind <> gfkNone)) or (FFill.Kind = gfkTexture) then
  begin
    case FFill.Kind of
      gfkTexture:
      begin
        pth := TAdvChartGraphicsPath.Create;
        try
          pth.AddRectangle(r);
          DrawTexture(r, FFill.Texture, FFill.TextureMode);
        finally
          pth.Free;
        end;
      end;
      else
        Context.FillRect(FFill, r, AModifyRectMode);
    end;
  end;

  if (FStroke.Color <> gcNull) and (FStroke.Kind <> gskNone) then
    Context.DrawRect(FStroke, r, ASides, AModifyRectMode);
end;

procedure TAdvChartGraphics.DrawRoundRectangle(ALeft: Integer; ATop: Integer; ARight: Integer; ABottom: Integer; ARounding: Integer = 10; ACorners: TAdvChartGraphicsCorners = [gcTopLeft, gcTopRight, gcBottomLeft, gcBottomRight]; AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll);
begin
  DrawRoundRectangle(RectF(ALeft, ATop, ARight, ABottom), ARounding, ACorners);
end;

procedure TAdvChartGraphics.DrawRoundRectangle(ALeft: Double; ATop: Double; ARight: Double; ABottom: Double; ARounding: Single = 10; ACorners: TAdvChartGraphicsCorners = [gcTopLeft, gcTopRight, gcBottomLeft, gcBottomRight]; AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll);
var
  r: TRectF;
  rc: Single;
  pth: TAdvChartGraphicsPath;
begin
  r := RectF(ALeft, ATop, ARight, ABottom);
  if ((FFill.Color <> gcNull) and (FFill.Kind <> gfkNone)) or (FFill.Kind = gfkTexture) then
  begin
    case FFill.Kind of
      gfkTexture:
      begin
        pth := TAdvChartGraphicsPath.Create;
        try
          rc := ARounding;
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

          DrawTexture(r, FFill.Texture, FFill.TextureMode);
        finally
          pth.Free;
        end;
      end;
      else
        Context.FillRoundRect(FFill, r, ARounding, ACorners, AModifyRectMode);
    end;
  end;

  if (FStroke.Color <> gcNull) and (FStroke.Kind <> gskNone) then
    Context.DrawRoundRect(FStroke, r, ARounding, ACorners, AModifyRectMode);
end;

procedure TAdvChartGraphics.DrawRectangle(ARect: TRect; ASides: TAdvChartGraphicsSides; AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll);
begin
  DrawRectangle(ConvertToRectF(ARect), ASides, AModifyRectMode);
end;

procedure TAdvChartGraphics.DrawRectangle(ARect: TRectF; ASides: TAdvChartGraphicsSides; AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll);
begin
  DrawRectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom, ASides, AModifyRectMode);
end;

procedure TAdvChartGraphics.DrawRectangle(ARect: TRect; AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll);
begin
  DrawRectangle(ConvertToRectF(ARect), AModifyRectMode);
end;

procedure TAdvChartGraphics.DrawRectangle(ARect: TRectF; AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll);
begin
  DrawRectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom, AModifyRectMode);
end;

procedure TAdvChartGraphics.SetFontSize(ASize: Integer);
begin
  if FBlockUpdate > 0 then
    Exit;

  Inc(FBlockUpdate);
  Context.SetFontSize(ASize);
  FFont.Size := ASize;
  Dec(FBlockUpdate);
end;

function TAdvChartGraphics.GetMatrix: TAdvChartGraphicsMatrix;
begin
  Result := Context.GetMatrix;
end;

procedure TAdvChartGraphics.SetMatrix(const AMatrix: TAdvChartGraphicsMatrix);
begin
  Context.SetMatrix(AMatrix);
end;

procedure TAdvChartGraphics.SetFontColor(AColor: TAdvChartGraphicsColor);
begin
  if FBlockUpdate > 0 then
    Exit;

  Inc(FBlockUpdate);
  Context.SetFontColor(AColor);
  FFont.Color := AColor;
  Dec(FBlockUpdate);
end;

procedure TAdvChartGraphics.SetFontName(AName: string);
begin
  if FBlockUpdate > 0 then
    Exit;

  Inc(FBlockUpdate);
  Context.SetFontName(AName);
  FFont.Name := AName;
  Dec(FBlockUpdate);
end;

procedure TAdvChartGraphics.SetFont(AFont: TAdvChartGraphicsFont);
begin
  if FBlockUpdate > 0 then
    Exit;

  Inc(FBlockUpdate);
  Context.SetFont(AFont);
  FFont.AssignSource(AFont);
  Dec(FBlockUpdate);
end;

procedure TAdvChartGraphics.SetFontStyles(AStyle: TFontStyles);
begin
  if FBlockUpdate > 0 then
    Exit;

  Inc(FBlockUpdate);
  Context.SetFontStyles(AStyle);
  FFont.Style := AStyle;
  Dec(FBlockUpdate);
end;

destructor TAdvChartGraphics.Destroy;
begin
  if Assigned(FContextNative) then
  begin
    FContextNative.Free;
    FContextNative := nil;
  end;

  if Assigned(FContextGeneral) then
  begin
    FContextGeneral.Free;
    FContextGeneral := nil;
  end;

  if Assigned(FFont) then
  begin
    FFont.Free;
    FFont := nil;
  end;

  if Assigned(FFill) then
  begin
    FFill.OnChanged := nil;
    FFill.Free;
    FFill := nil;
  end;

  if Assigned(FStroke) then
  begin
    FStroke.OnChanged := nil;
    FStroke.Free;
    FStroke := nil;
  end;

  {$IFNDEF LIMITEDGRAPHICSMODE}
  FBitmapContainer := nil;
  {$IFDEF CMNLIB}
  FImageList := nil;
  {$ENDIF}
  {$ENDIF}

  if Assigned(FBitmap) then
  begin
    FBitmap.Free;
    FBitmap := nil;
  end;

  inherited;
end;

procedure TAdvChartGraphics.DrawCloseButton(ARect: TRect; ADown: Boolean = False; AFocused: Boolean = False; AEnabled: Boolean = True; AAdaptToStyle: Boolean = True; AScaleFactor: Single = 1.0);
begin
  DrawCloseButton(ConvertToRectF(ARect), ADown, AFocused, AEnabled, AAdaptToStyle, AScaleFactor);
end;

procedure TAdvChartGraphics.DrawCloseButton(ARect: TRectF; ADown: Boolean = False; AFocused: Boolean = False; AEnabled: Boolean = True; AAdaptToStyle: Boolean = True; AScaleFactor: Single = 1.0);
var
  bmp: TAdvChartBitmapHelperClass;
  bmpa: TBitmap;
  r: TRectF;
  g: TAdvChartGraphics;
begin
  DrawButton(ARect, ADown, AFocused, AEnabled, AAdaptToStyle, AScaleFactor);
  if AAdaptToStyle then
  begin
    bmpa := TBitmap.Create;
    bmpa.SetSize(Round(16 * AScaleFactor), Round(16 * AScaleFactor));
    {$IFDEF CMNLIB}
    bmpa.TransparentMode := tmFixed;
    bmpa.Transparent := True;
    bmpa.TransparentColor := gcWhite;
    {$ENDIF}
    g := TAdvChartGraphics.Create(bmpa.Canvas);
    try
      g.BeginScene;
      {$IFDEF CMNLIB}
      g.Fill.Color := gcWhite;
      g.Fill.Kind := gfkSolid;
      g.Stroke.Kind := gskSolid;
      g.Stroke.Color := gcWhite;
      g.DrawRectangle(0, 0, bmpa.Width, bmpa.Height);
      {$ENDIF}
      g.Stroke.Kind := gskSolid;
      g.Stroke.Color := TAdvChartGraphics.DefaultSelectionFillColor;
      g.Stroke.Width := 2;
      g.DrawLine(PointF(3 * AScaleFactor, 3 * AScaleFactor), PointF(12 * AScaleFactor, 12 * AScaleFactor), gcpmRightDown);
      g.DrawLine(PointF(3 * AScaleFactor, 12 * AScaleFactor), PointF(12 * AScaleFactor, 3 * AScaleFactor), gcpmRightDown);
    finally
      g.EndScene;
      g.Free;
    end;

    try
      r := ARect;
      bmp := TAdvChartBitmap.Create;
      try
        bmp.Assign(bmpa);
        DrawBitmap(r, bmp);
      finally
        bmp.Free;
      end;
    finally
      bmpa.Free;
    end;
  end
  else
  begin
   bmp := TAdvChartBitmap.CreateFromResource('ADVCHARTGRAPHICSCLOSESVG');

    try
      r := ARect;
      InflateRectEx(r, - 6 * AScaleFactor, - 6 * AScaleFactor);
      DrawBitmap(r, bmp);
    finally
      bmp.Free;
    end;
  end;
end;

procedure TAdvChartGraphics.DrawExpanderButton(ARect: TRect; AState: TAdvChartGraphicsExpanderState = gesExpanded; ADown: Boolean = False; AFocused: Boolean = False; AEnabled: Boolean = True; AAdaptToStyle: Boolean = True; AScaleFactor: Single = 1.0);
begin
  DrawExpanderButton(ConvertToRectF(ARect), AState, ADown, AFocused, AEnabled, AAdaptToStyle, AScaleFactor);
end;

procedure TAdvChartGraphics.DrawExpanderButton(ARect: TRectF; AState: TAdvChartGraphicsExpanderState = gesExpanded; ADown: Boolean = False; AFocused: Boolean = False; AEnabled: Boolean = True; AAdaptToStyle: Boolean = True; AScaleFactor: Single = 1.0);
var
  bmpa: TBitmap;
  bmp: TAdvChartBitmapHelperClass;
  r: TRectF;
  g: TAdvChartGraphics;
begin
  DrawButton(ARect, ADown, AFocused, AEnabled, AAdaptToStyle, AScaleFactor);
  if AAdaptToStyle then
  begin
    bmpa := TBitmap.Create;
    bmpa.SetSize(Round(16 * AScaleFactor), Round(16 * AScaleFactor));
    {$IFDEF CMNLIB}
    bmpa.TransparentMode := tmFixed;
    bmpa.Transparent := True;
    bmpa.TransparentColor := gcWhite;
    {$ENDIF}
    g := TAdvChartGraphics.Create(bmpa.Canvas);
    try
      g.BeginScene;
      {$IFDEF CMNLIB}
      g.Fill.Color := gcWhite;
      g.Fill.Kind := gfkSolid;
      g.Stroke.Kind := gskSolid;
      g.Stroke.Color := gcWhite;
      g.DrawRectangle(0, 0, bmpa.Width, bmpa.Height);
      {$ENDIF}
      g.Stroke.Kind := gskSolid;
      g.Stroke.Width := 2;
      g.Stroke.Color := TAdvChartGraphics.DefaultSelectionFillColor;
      case AState of
        gesCollapsed:
        begin
          g.DrawLine(PointF(5 * AScaleFactor, 6 * AScaleFactor), PointF(8 * AScaleFactor, 9 * AScaleFactor), gcpmRightDown);
          g.DrawLine(PointF(8 * AScaleFactor, 9 * AScaleFactor), PointF(11 * AScaleFactor, 6 * AScaleFactor), gcpmRightDown);
        end;
        gesExpanded:
        begin
          g.DrawLine(PointF(5 * AScaleFactor, 9 * AScaleFactor), PointF(8 * AScaleFactor, 6 * AScaleFactor), gcpmRightDown);
          g.DrawLine(PointF(8 * AScaleFactor, 6 * AScaleFactor), PointF(11 * AScaleFactor, 9 * AScaleFactor), gcpmRightDown);
        end;
      end;
    finally
      g.EndScene;
      g.Free;
    end;

    if Assigned(bmpa) then
    begin
      try
        r := ARect;
        bmp := TAdvChartBitmap.Create;
        try
          bmp.Assign(bmpa);
          DrawBitmap(r, bmp);
        finally
          bmp.Free;
        end;
      finally
        bmpa.Free;
      end;
    end;
  end
  else
  begin
    case AState of
      gesCollapsed: bmp := TAdvChartBitmap.CreateFromResource('ADVCHARTGRAPHICSDOWNSVG');
      gesExpanded: bmp := TAdvChartBitmap.CreateFromResource('ADVCHARTGRAPHICSUPSVG');
      else
        bmp := nil;
    end;

    if Assigned(bmp) then
    begin
      try
        r := ARect;
        InflateRectEx(r, -4 * AScaleFactor, -4 * AScaleFactor);
        DrawBitmap(r, bmp);
      finally
        bmp.Free;
      end;
    end;
  end;
end;

procedure TAdvChartGraphics.DrawCompactButton(ARect: TRect; AState: TAdvChartGraphicsCompactState = gcsExpanded; ADown: Boolean = False; AFocused: Boolean = False; AEnabled: Boolean = True; AAdaptToStyle: Boolean = True; AScaleFactor: Single = 1.0);
begin
  DrawCompactButton(ConvertToRectF(ARect), AState, ADown, AFocused, AEnabled, AAdaptToStyle, AScaleFactor);
end;

procedure TAdvChartGraphics.DrawCompactButton(ARect: TRectF; AState: TAdvChartGraphicsCompactState = gcsExpanded; ADown: Boolean = False; AFocused: Boolean = False; AEnabled: Boolean = True; AAdaptToStyle: Boolean = True; AScaleFactor: Single = 1.0);
var
  bmpa: TBitmap;
  bmp: TAdvChartBitmapHelperClass;
  r: TRectF;
  g: TAdvChartGraphics;
begin
  DrawButton(ARect, ADown, AFocused, AEnabled, AAdaptToStyle, AScaleFactor);
  if AAdaptToStyle then
  begin
    bmpa := TBitmap.Create;
    bmpa.SetSize(Round(16 * AScaleFactor), Round(16 * AScaleFactor));
    {$IFDEF CMNLIB}
    bmpa.TransparentMode := tmFixed;
    bmpa.Transparent := True;
    bmpa.TransparentColor := gcWhite;
    {$ENDIF}
    g := TAdvChartGraphics.Create(bmpa.Canvas);
    try
      g.BeginScene;
      {$IFDEF CMNLIB}
      g.Fill.Color := gcWhite;
      g.Fill.Kind := gfkSolid;
      g.Stroke.Kind := gskSolid;
      g.Stroke.Color := gcWhite;
      g.DrawRectangle(0, 0, bmpa.Width, bmpa.Height);
      {$ENDIF}
      g.Stroke.Kind := gskSolid;
      g.Stroke.Width := 2;
      g.Stroke.Color := TAdvChartGraphics.DefaultSelectionFillColor;
      case AState of
        gcsCollapsed:
        begin
          g.DrawLine(PointF(6 * AScaleFactor, 5 * AScaleFactor), PointF(9 * AScaleFactor, 8 * AScaleFactor), gcpmRightDown);
          g.DrawLine(PointF(9 * AScaleFactor, 8 * AScaleFactor), PointF(6 * AScaleFactor, 11 * AScaleFactor), gcpmRightDown);
        end;
        gcsExpanded:
        begin
          g.DrawLine(PointF(9 * AScaleFactor, 5 * AScaleFactor), PointF(6 * AScaleFactor, 8 * AScaleFactor), gcpmRightDown);
          g.DrawLine(PointF(6 * AScaleFactor, 8 * AScaleFactor), PointF(9 * AScaleFactor, 11 * AScaleFactor), gcpmRightDown);
        end;
      end;
    finally
      g.EndScene;
      g.Free;
    end;

    if Assigned(bmpa) then
    begin
      try
        r := ARect;
        bmp := TAdvChartBitmap.Create;
        try
          bmp.Assign(bmpa);
          DrawBitmap(r, bmp);
        finally
          bmp.Free;
        end;
      finally
        bmpa.Free;
      end;
    end;
  end
  else
  begin
    case AState of
      gcsCollapsed: bmp := TAdvChartBitmap.CreateFromResource('ADVCHARTGRAPHICSRIGHTSVG');
      gcsExpanded: bmp := TAdvChartBitmap.CreateFromResource('ADVCHARTGRAPHICSLEFTSVG');
      else
        bmp := nil;
    end;

    if Assigned(bmp) then
    begin
      try
        r := ARect;
        InflateRectEx(r, -4 * AScaleFactor, -4 * AScaleFactor);
        DrawBitmap(r, bmp);
      finally
        bmp.Free;
      end;
    end;
  end;
end;

procedure TAdvChartGraphics.DrawDropDownButton(ARect: TRect; ADown: Boolean = False; AFocused: Boolean = False; AEnabled: Boolean = True; ACenter: Boolean = False; AAdaptToStyle: Boolean = True; AScaleFactor: Single = 1.0);
begin
  DrawDropDownButton(ConvertToRectF(ARect), ADown, AFocused, AEnabled, ACenter, AAdaptToStyle, AScaleFactor);
end;

procedure TAdvChartGraphics.DrawDropDownButton(ARect: TRectF; ADown: Boolean = False; AFocused: Boolean = False; AEnabled: Boolean = True; ACenter: Boolean = False; AAdaptToStyle: Boolean = True; AScaleFactor: Single = 1.0);
var
  bmp: TAdvChartBitmapHelperClass;
  bmpa: TBitmap;
  r: TRectF;
  g: TAdvChartGraphics;
begin
  DrawButton(ARect, ADown, AFocused, AEnabled, AAdaptToStyle);
  if AAdaptToStyle then
  begin
    bmpa := TBitmap.Create;
    bmpa.SetSize(Round(7 * AScaleFactor), Round(7 * AScaleFactor));
    {$IFDEF CMNLIB}
    bmpa.TransparentMode := tmFixed;
    bmpa.Transparent := True;
    bmpa.TransparentColor := gcWhite;
    {$ENDIF}
    g := TAdvChartGraphics.Create(bmpa.Canvas);
    try
      g.BeginScene;
      {$IFDEF CMNLIB}
      g.Fill.Color := gcWhite;
      g.Fill.Kind := gfkSolid;
      g.Stroke.Kind := gskSolid;
      g.Stroke.Color := gcWhite;
      g.DrawRectangle(0, 0, bmpa.Width, bmpa.Height);
      {$ENDIF}
      g.Stroke.Kind := gskSolid;
      g.Stroke.Color := TAdvChartGraphics.DefaultSelectionFillColor;
      g.DrawLine(PointF(0, 1 * AScaleFactor), PointF(6 * AScaleFactor, 1 * AScaleFactor), gcpmRightDown);
      g.DrawLine(PointF(0, 2 * AScaleFactor), PointF(6 * AScaleFactor, 2 * AScaleFactor), gcpmRightDown);
      g.DrawLine(PointF(1 * AScaleFactor, 3 * AScaleFactor), PointF(5 * AScaleFactor, 3 * AScaleFactor), gcpmRightDown);
      g.DrawLine(PointF(2 * AScaleFactor, 4 * AScaleFactor), PointF(4 * AScaleFactor, 4 * AScaleFactor), gcpmRightDown);
      g.DrawLine(PointF(3 * AScaleFactor, 5 * AScaleFactor), PointF(3 * AScaleFactor, 5 * AScaleFactor), gcpmRightDown);
    finally
      g.EndScene;
      g.Free;
    end;

    try
      if (ARect.Right - bmpa.Width - 10 * AScaleFactor > ARect.Left) and not ACenter then
        r := RectF(ARect.Right - bmpa.Width - 10 * AScaleFactor, ARect.Top, ARect.Right, ARect.Bottom)
      else
        r := ARect;

      bmp := TAdvChartBitmap.Create;
      try
        bmp.Assign(bmpa);
        DrawBitmap(r, bmp);
      finally
        bmp.Free;
      end;
    finally
      bmpa.Free;
    end;
  end
  else
  begin
    bmp := TAdvChartBitmap.Create;
    bmp.LoadFromResource('ADVCHARTGRAPHICSEXPANDSVG');

    try
      if not ACenter then
      begin
        r := RectF(ARect.Right - (16 * AScaleFactor), ARect.Top, ARect.Right - 2 * AScaleFactor, ARect.Bottom);
        InflateRectEx(r, - 2 * AScaleFactor, - 2 * AScaleFactor);
      end
      else
      begin
        r := ARect;
        InflateRectEx(r, - 4 * AScaleFactor, - 4 * AScaleFactor);
      end;

      DrawBitmap(r, bmp);
    finally
      bmp.Free;
    end;
  end;
end;


procedure TAdvChartGraphics.DrawButton(ARect: TRect; ADown: Boolean = False; AFocused: Boolean = False; AEnabled: Boolean = True; AAdaptToStyle: Boolean = True; AScaleFactor: Single = 1.0);
begin
  DrawButton(ConvertToRectF(ARect), ADown, AFocused, AEnabled, AAdaptToStyle, AScaleFactor);
end;

procedure TAdvChartGraphics.DrawButton(ARect: TRectF; ADown: Boolean = False; AFocused: Boolean = False; AEnabled: Boolean = True; AAdaptToStyle: Boolean = True; AScaleFactor: Single = 1.0);
var
  r: TRectF;
begin
  r := ARect;
  Stroke.Kind := gskSolid;
  Stroke.Width := 1;
  Fill.Kind := gfkSolid;

  if AAdaptToStyle then
  begin
    if AEnabled then
    begin
      if not AFocused then
      begin
        Stroke.Color := TAdvChartGraphics.DefaultButtonStrokeColor;
        Fill.Color := TAdvChartGraphics.DefaultButtonFillColor;
      end
      else
      begin
        Stroke.Color := TAdvChartGraphics.DefaultButtonStrokeColorFocused;
        Fill.Color := TAdvChartGraphics.DefaultButtonFillColorFocused;
      end;
    end
    else
    begin
      Stroke.Color := TAdvChartGraphics.DefaultButtonStrokeColorDisabled;
      Fill.Color := TAdvChartGraphics.DefaultButtonFillColorDisabled;
    end;
  end
  else
  begin
    if AEnabled then
    begin
      if not AFocused then
      begin
        Stroke.Color := gcDarkGray;
        Fill.Color := MakeGraphicsColor(225, 225, 225);
      end
      else
      begin
        Stroke.Color := MakeGraphicsColor(60, 127, 177);
        Fill.Color := MakeGraphicsColor(229, 241, 251);
      end;
    end
    else
    begin
      Stroke.Color := gcDarkGray;
      Fill.Color := gcLightgray;
    end;
  end;

  DrawRectangle(r);
  InflateRectEx(r, -1, -1);
  Fill.Kind := gfkNone;

  if not ADown then
    Stroke.Color := Fill.Color
  else
    Stroke.Color := Lighter(Stroke.Color, 40);

  DrawRectangle(r);
end;

procedure TAdvChartGraphics.DrawCheckBox(ARect: TRect; AChecked: Boolean = False; AFocused: Boolean = False; AEnabled: Boolean = True; AScaleFactor: Single = 1.0);
begin
  DrawCheckBox(ConvertToRectF(ARect), AChecked, AFocused, AEnabled, AScaleFactor);
end;

procedure TAdvChartGraphics.DrawCheckBox(ARect: TRectF; AChecked: Boolean = False; AFocused: Boolean = False; AEnabled: Boolean = True; AScaleFactor: Single = 1.0);
var
  c: TAdvChartGraphicsColor;
  r: TRectF;
begin
  r := ARect;
  InflateRectEx(r, -1, -1);

  if AEnabled then
  begin
    if AFocused then
      c := gcSteelBlue
    else
      c := gcBlack;
  end
  else
    c := gcDarkgray;

  Fill.Kind := gfkSolid;
  if AEnabled then
    Fill.Color := Lighter(gcLightgray, 85)
  else
    Fill.Color := gcLightgray;

  Stroke.Width := 1;
  Stroke.Kind := gskSolid;
  Stroke.Color := c;
  DrawRectangle(r);
  InflateRectEx(r, -(r.Right - r.Left) / 5, -(r.Bottom - r.Top) / 5);
  Stroke.Width := 2;
  Stroke.Color := c;
  if AChecked then
  begin
    {$IFDEF FMXLIB}
    DrawLine(PointF(r.Left + 1, r.Top + 1), PointF(r.Right - 1, r.Bottom - 1));
    DrawLine(PointF(r.Right - 1, r.Top + 1), PointF(r.Left + 1, r.Bottom - 1));
    {$ENDIF}
    {$IFDEF CMNWEBLIB}
    DrawLine(PointF(r.Left, r.Top), PointF(r.Right - 1, r.Bottom - 1));
    DrawLine(PointF(r.Right - 1, r.Top), PointF(r.Left, r.Bottom - 1));
    {$ENDIF}
  end;
end;

procedure TAdvChartGraphics.DrawProgressBar(ARect: TRect; AValue: Single; AFormat: string = '%.0f%%'; AMax: Single = 100; AColor: TAdvChartGraphicsColor = gcYellowgreen; ATextColor: TAdvChartGraphicsColor = gcBlack; AShowText: Boolean = True; AEnabled: Boolean = True; AScaleFactor: Single = 1.0);
begin
  DrawProgressBar(ConvertToRectF(ARect), AValue, AFormat, AMax, AColor, ATextColor, AShowText, AEnabled, AScaleFactor);
end;

procedure TAdvChartGraphics.DrawProgressBar(ARect: TRectF; AValue: Single; AFormat: string = '%.0f%%'; AMax: Single = 100; AColor: TAdvChartGraphicsColor = gcYellowgreen; ATextColor: TAdvChartGraphicsColor = gcBlack; AShowText: Boolean = True; AEnabled: Boolean = True; AScaleFactor: Single = 1.0);
var
  r, rp: TRectF;
  v: Single;
  tc, fc: TAdvChartGraphicsColor;
begin
  r := ARect;
  rp := r;

  fc := Fill.Color;
  if AEnabled then
    Fill.Color := Lighter(gcLightGray, 75)
  else
    Fill.Color := gcLightGray;

  Fill.Kind := gfkSolid;
  Stroke.Kind := gskSolid;
  Stroke.Color := gcDarkgray;

  DrawRectangle(r);

  v := Max(0, Min(AValue, AMax));

  if (v >= 0) and (v <= AMax) and (AMax > 0) then
  begin
    InflateRectEx(rp, -1, -1);
    rp.Right := rp.Left + (rp.Right - r.Left) * v / AMax;

    Fill.Color := AColor;
    Stroke.Color := Fill.Color;

    DrawRectangle(rp);

    if AShowText then
    begin
      tc := Font.Color;
      Font.Color := ATextColor;
      DrawText(r, Format(AFormat, [v / AMax * 100]), False, gtaCenter, gtaCenter);
      Font.Color := tc;
    end;
  end;

  Fill.Color := fc;

end;

procedure TAdvChartGraphics.DrawRadioButton(ARect: TRect; AChecked: Boolean = False; AFocused: Boolean = False; AEnabled: Boolean = True; AScaleFactor: Single = 1.0);
begin
  DrawRadioButton(ConvertToRectF(ARect), AChecked, AFocused, AEnabled, AScaleFactor);
end;

procedure TAdvChartGraphics.DrawRadioButton(ARect: TRectF; AChecked: Boolean = False; AFocused: Boolean = False; AEnabled: Boolean = True; AScaleFactor: Single = 1.0);
var
  c: TAdvChartGraphicsColor;
  r: TRectF;
begin
  r := ARect;
  InflateRectEx(r, -1, -1);

  if AEnabled then
  begin
    if AFocused then
      c := gcSteelBlue
    else
      c := gcBlack;
  end
  else
    c := gcDarkgray;

  Fill.Kind := gfkSolid;
  if AEnabled then
    Fill.Color := Lighter(gcLightgray, 85)
  else
    Fill.Color := gcLightgray;

  Stroke.Kind := gskSolid;
  Stroke.Width := 1;
  Stroke.Color := c;
  DrawEllipse(r);
  InflateRectEx(r, -(r.Right - r.Left) / 5, -(r.Bottom - r.Top) / 5);
  Fill.Kind := gfkSolid;
  Fill.Color := c;
  if AChecked then
  begin
    DrawEllipse(r);
  end;
end;

procedure TAdvChartGraphics.DrawBitmap(ALeft, ATop: Single; ABitmap: TAdvChartBitmapHelperClass);
begin
  DrawBitmap(RectF(ALeft, ATop, ALeft + ABitmap.Width, ATop + ABitmap.Height), ABitmap);
end;

procedure TAdvChartGraphics.DrawBitmap(ALeft, ATop: Integer; ABitmap: TAdvChartBitmapHelperClass);
begin
  DrawBitmap(Rect(ALeft, ATop, ALeft + ABitmap.Width, ATop + ABitmap.Height), ABitmap);
end;

procedure TAdvChartGraphics.DrawBitmap(ARect: TRect; ABitmap: TAdvChartBitmapHelperClass; AAspectRatio: Boolean = True;
  AStretch: Boolean = False; ACenter: Boolean = True; ACropping: Boolean = False);
begin
  DrawBitmap(ConvertToRectF(ARect), ABitmap, AAspectRatio, AStretch, ACenter, ACropping);
end;

procedure TAdvChartGraphics.DrawBitmap(ARect: TRectF; ABitmap: TAdvChartBitmapHelperClass; AAspectRatio: Boolean = True;
  AStretch: Boolean = False; ACenter: Boolean = True; ACropping: Boolean = False);
begin
  DrawBitmap(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom, ABitmap, AAspectRatio, AStretch, ACenter, ACropping);
end;

procedure TAdvChartGraphics.DrawBitmap(ALeft: Integer; ATop: Integer; ARight: Integer; ABottom: Integer; ABitmap: TAdvChartBitmapHelperClass; AAspectRatio: Boolean = True;
  AStretch: Boolean = False; ACenter: Boolean = True; ACropping: Boolean = False);
begin
  DrawBitmap(RectF(ALeft, ATop, ARight, ABottom), ABitmap, AAspectRatio, AStretch, ACenter, ACropping);
end;

procedure TAdvChartGraphics.DrawBitmap(ALeft: Double; ATop: Double; ARight: Double; ABottom: Double; ABitmap: TAdvChartBitmapHelperClass; AAspectRatio: Boolean = True;
  AStretch: Boolean = False; ACenter: Boolean = True; ACropping: Boolean = False);
var
  r: TRectF;
begin
  if not Assigned(ABitmap) then
    Exit;

  r := RectF(ALeft, ATop, ARight, ABottom);
  r := GetBitmapDrawRectangle(r, ABitmap, AAspectRatio, AStretch, ACenter, ACropping);

  {$IFDEF SVGSUPPORT}
  if not DrawSVG(ABitmap, r) then
  {$ENDIF}
    Context.DrawBitmap(BitmapToDrawBitmap(ABitmap), RectF(0, 0, ABitmap.Width, ABitmap.Height), r, 1);
end;

function TAdvChartGraphics.InternalDrawBitmapPartSync(ASourceLeft: Double; ASourceTop: Double; ASourceRight: Double; ASourceBottom: Double; ADestinationLeft: Double; ADestinationTop: Double;
  ADestinationRight: Double; ADestinationBottom: Double; ABitmap: TAdvChartBitmapHelperClass; AAspectRatio: Boolean = True; AStretch: Boolean = False;
  ACenter: Boolean = True; ACropping: Boolean = False): {$IFDEF WEBLIB}TJSPromise{$ELSE}TAdvChartBitmap{$ENDIF};
var
  r, rs: TRectF;
  {$IFNDEF WEBLIB}
  g: TAdvChartGraphics;
  bmp: TAdvChartBitmap;
  {$ENDIF}
begin
  Result := nil;
  r := RectF(ADestinationLeft, ADestinationTop, ADestinationRight, ADestinationBottom);
  rs := RectF(ASourceLeft, ASourceTop, ASourceRight, ASourceBottom);
  if RectIsEmpty(r) or RectIsEmpty(rs) then
    Exit;

  {$IFDEF SVGSUPPORT}
  if not HasSVG(ABitmap) then
  {$ENDIF}
  begin
    {$IFDEF WEBLIB}
    Result := TJSPromise.New(
    procedure(AResolve, AReject : TJSPromiseResolver)
    var
      bmp: TAdvChartBitmap;
      g: TAdvChartGraphics;
    begin
    {$ENDIF}
      g := TAdvChartGraphics.CreateBitmapCanvas(Round(ASourceRight - ASourceLeft), Round(ASourceBottom - ASourceTop), FNative);
      try
        g.BeginScene;
        g.DrawBitmap(-ASourceLeft, -ASourceTop, -ASourceLeft + g.Bitmap.Width, -ASourceTop + g.Bitmap.Height, ABitmap, False, False, False, False);
        g.EndScene;
        bmp := TAdvChartBitmap.Create;
        bmp.Assign(g.Bitmap);
        {$IFDEF WEBLIB}
        AResolve(bmp);
        {$ELSE}
        Result := bmp;
        {$ENDIF}
      finally
        g.Free;
      end;
    {$IFDEF WEBLIB}
    end);
    {$ENDIF}
  end;
end;

function TAdvChartGraphics.DrawBitmapPartSync(ASourceLeft: Double; ASourceTop: Double; ASourceRight: Double; ASourceBottom: Double; ADestinationLeft: Double; ADestinationTop: Double;
  ADestinationRight: Double; ADestinationBottom: Double; ABitmap: TAdvChartBitmapHelperClass; AAspectRatio: Boolean = True; AStretch: Boolean = False;
  ACenter: Boolean = True; ACropping: Boolean = False): TAdvChartBitmap;
begin
  Result := {$IFDEF WEBLIB}await(TAdvChartBitmap,{$ENDIF} InternalDrawBitmapPartSync(ASourceLeft, ASourceTop, ASourceRight, ASourceBottom,
    ADestinationLeft, ADestinationTop, ADestinationRight, ADestinationBottom, ABitmap, AAspectRatio, AStretch, ACenter, ACropping){$IFDEF WEBLIB}){$ENDIF};
end;

procedure TAdvChartGraphics.DrawBitmapPart(ASourceRect: TRect; ADestinationRect: TRect; ABitmap: TAdvChartBitmapHelperClass; AAspectRatio: Boolean = True;
  AStretch: Boolean = False; ACenter: Boolean = True; ACropping: Boolean = False);
begin
  DrawBitmapPart(ConvertToRectF(ASourceRect), ConvertToRectF(ADestinationRect), ABitmap, AAspectRatio, AStretch, ACenter, ACropping);
end;

procedure TAdvChartGraphics.DrawBitmapPart(ASourceRect: TRectF; ADestinationRect: TRectF; ABitmap: TAdvChartBitmapHelperClass; AAspectRatio: Boolean = True;
  AStretch: Boolean = False; ACenter: Boolean = True; ACropping: Boolean = False);
begin
  DrawBitmapPart(ASourceRect.Left, ASourceRect.Top, ASourceRect.Right, ASourceRect.Bottom, ADestinationRect.Left, ADestinationRect.Top, ADestinationRect.Right, ADestinationRect.Bottom,
    ABitmap, AAspectRatio, AStretch, ACenter, ACropping);
end;

procedure TAdvChartGraphics.DrawBitmapPart(ASourceLeft: Integer; ASourceTop: Integer; ASourceRight: Integer; ASourceBottom: Integer; ADestinationLeft: Integer; ADestinationTop: Integer;
  ADestinationRight: Integer; ADestinationBottom: Integer; ABitmap: TAdvChartBitmapHelperClass; AAspectRatio: Boolean = True; AStretch: Boolean = False;
  ACenter: Boolean = True; ACropping: Boolean = False);
begin
  DrawBitmapPart(RectF(ASourceLeft, ASourceTop, ASourceRight, ASourceBottom), RectF(ADestinationLeft, ADestinationTop, ADestinationRight, ADestinationBottom), ABitmap, AAspectRatio, AStretch, ACenter, ACropping);
end;

procedure TAdvChartGraphics.DrawBitmapPart(ASourceLeft: Double; ASourceTop: Double; ASourceRight: Double; ASourceBottom: Double; ADestinationLeft: Double; ADestinationTop: Double;
  ADestinationRight: Double; ADestinationBottom: Double; ABitmap: TAdvChartBitmapHelperClass; AAspectRatio: Boolean = True; AStretch: Boolean = False;
  ACenter: Boolean = True; ACropping: Boolean = False);
var
  r, rs: TRectF;
  g: TAdvChartGraphics;
  bmp: TAdvChartBitmap;
begin
  r := RectF(ADestinationLeft, ADestinationTop, ADestinationRight, ADestinationBottom);
  rs := RectF(ASourceLeft, ASourceTop, ASourceRight, ASourceBottom);
  if RectIsEmpty(r) or RectIsEmpty(rs) then
    Exit;

  {$IFDEF SVGSUPPORT}
  if not DrawSVG(ABitmap, r) then
  {$ENDIF}
  begin
    g := TAdvChartGraphics.CreateBitmapCanvas(Round(ASourceRight - ASourceLeft), Round(ASourceBottom - ASourceTop), FNative);
    try
      g.BeginScene;
      g.DrawBitmap(-ASourceLeft, -ASourceTop, -ASourceLeft + g.Bitmap.Width, -ASourceTop + g.Bitmap.Height, ABitmap, False, False, False, False);
      g.EndScene;
      bmp := TAdvChartBitmap.Create;
      try
        bmp.Assign(g.Bitmap);
        DrawBitmap(r, bmp, AAspectRatio, AStretch, ACenter, ACropping);
      finally
        bmp.Free;
      end;
    finally
      g.Free;
    end;
  end;
end;

class procedure TAdvChartGraphics.GetAspectSize(var AWidth: Single; var AHeight: Single; AOriginalWidth: Single; AOriginalHeight: Single; ANewWidth: Single; ANewHeight: Single;
  AAspectRatio: Boolean = True; AStretch: Boolean = False; ACropping: Boolean = False);
var
  arc, ar: Single;
begin
  if AAspectRatio then
  begin
    if (AOriginalWidth > 0) and (AOriginalHeight > 0) and (ANewWidth > 0) and (ANewHeight > 0) then
    begin
      if (AOriginalWidth < ANewWidth) and (AOriginalHeight < ANewHeight) and (not AStretch) then
      begin
        AWidth := AOriginalWidth;
        AHeight := AOriginalHeight;
      end
      else
      begin
        if AOriginalWidth / AOriginalHeight < ANewWidth / ANewHeight then
        begin
          AHeight := ANewHeight;
          AWidth := ANewHeight * AOriginalWidth / AOriginalHeight;
        end
        else
        begin
          AWidth := ANewWidth;
          AHeight := ANewWidth * AOriginalHeight / AOriginalWidth;
        end;
      end;
    end
    else
    begin
      AWidth := 0;
      AHeight := 0;
    end;
  end
  else
  begin
    if AStretch then
    begin
      AWidth := ANewWidth;
      AHeight := ANewHeight;
    end
    else
    begin
      AWidth := AOriginalWidth;
      AHeight := AOriginalHeight;

      if ACropping then
      begin
        if (AWidth >= AHeight) and (AWidth > 0) then
        begin
          AHeight := AOriginalWidth / AWidth * AHeight;
          AWidth := AOriginalWidth;
        end
        else
        if (AHeight >= AWidth) and (AHeight > 0) then
        begin
          AWidth := AOriginalHeight / AHeight * AWidth;
          AHeight := AOriginalHeight;
        end;

        if AHeight = 0 then
          ar := 1
        else
          ar := AWidth / AHeight;

        if AOriginalHeight = 0 then
          arc := 1
        else
          arc := AOriginalWidth / AOriginalHeight;

        if (ar < 1) or (arc > ar) then
        begin
          AHeight := AOriginalWidth / ar;
          AWidth := AOriginalWidth;
        end
        else
        begin
          AWidth := ar * AOriginalHeight;
          AHeight := AOriginalHeight;
        end;
      end;
    end;
  end;
end;

function TAdvChartGraphics.GetBitmapDrawRectangle(ALeft: Integer; ATop: Integer; ARight: Integer; ABottom: Integer; ABitmap: TAdvChartBitmapHelperClass;
  AAspectRatio: Boolean = True; AStretch: Boolean = False; ACenter: Boolean = True; ACropping: Boolean = False): TRect;
begin
  Result := ConvertToRect(GetBitmapDrawRectangle(RectF(ALeft, ATop, ARight, ABottom), ABitmap, AAspectRatio, AStretch, ACenter, ACropping));
end;

function TAdvChartGraphics.GetBitmapDrawRectangle(ALeft: Double; ATop: Double; ARight: Double; ABottom: Double; ABitmap: TAdvChartBitmapHelperClass;
  AAspectRatio: Boolean = True; AStretch: Boolean = False; ACenter: Boolean = True; ACropping: Boolean = False): TRectF;
var
  bmp: TAdvChartBitmapHelperClass;
  rdest: TRectF;
  w, h: Single;
  x, y: Single;
begin
  Result := RectF(0, 0, 0, 0);
  bmp := ABitmap;
  if Assigned(bmp) then
  begin
    x := 0;
    y := 0;
    w := 0;
    h := 0;
    GetAspectSize(w, h, bmp.Width, bmp.Height, ARight - ALeft, ABottom - ATop, AAspectRatio, AStretch, ACropping);
    if ACenter or ACropping then
    begin
      x := Round((ARight - ALeft - w) / 2);
      y := Round((ABottom - ATop - h) / 2);
    end;

    rdest := RectF(ALeft + x, ATop + y, ALeft + x + w, ATop + y + h);
    Result := rdest;
  end;
end;

function TAdvChartGraphics.GetBitmapDrawRectangle(ARect: TRect; ABitmap: TAdvChartBitmapHelperClass;
  AAspectRatio: Boolean = True; AStretch: Boolean = False; ACenter: Boolean = True; ACropping: Boolean = False): TRect;
begin
  Result := ConvertToRect(GetBitmapDrawRectangle(ConvertToRectF(ARect), ABitmap, AAspectRatio, AStretch, ACenter, ACropping));
end;

function TAdvChartGraphics.GetBitmapDrawRectangle(ARect: TRectF; ABitmap: TAdvChartBitmapHelperClass;
  AAspectRatio: Boolean = True; AStretch: Boolean = False; ACenter: Boolean = True; ACropping: Boolean = False): TRectF;
begin
  Result := GetBitmapDrawRectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom, ABitmap, AAspectRatio, AStretch, ACenter, ACropping);
end;

function TAdvChartGraphics.GetContext: TAdvChartGraphicsContext;
begin
  if FNative then
    Result := FContextNative
  else
    Result := FContextGeneral;
end;

function TAdvChartGraphics.GetCanvas: TCanvas;
begin
  Result := FActiveCanvas;
end;

{$IFNDEF LIMITEDGRAPHICSMODE}
class function TAdvChartGraphics.GetScaledBitmap(ABitmaps: TAdvScaledBitmaps; AScale: Single = 0; ABitmapContainer: TAdvChartBitmapContainer = nil): TAdvChartBitmap;
var
  b: TAdvScaledBitmap;
  bmp: TAdvChartBitmap;
begin
  Result := nil;
  if Assigned(ABitmaps) then
  begin
    if AScale > 0 then
      b := ABitmaps.GetItemByScale(AScale)
    else
      b := ABitmaps.GetItemByScale(TAdvChartUtils.GetDPIScale);

    if Assigned(b) then
    begin
      if Assigned(b.Bitmap) and not IsBitmapEmpty(b.Bitmap) then
        Result := b.Bitmap
      else
      begin
        bmp := GetBitmapFromBitmapContainer(ABitmapContainer, b.BitmapName, True, AScale);
        if Assigned(bmp) and not IsBitmapEmpty(bmp) then
          Result := bmp
        else
        begin
          bmp := GetBitmapFromBitmapContainer(ABitmapContainer, b.BitmapName, False);
          if Assigned(bmp) and not IsBitmapEmpty(bmp) then
            Result := bmp
        end;
      end;
    end;
  end;
end;

class function TAdvChartGraphics.ApplyHilight(AText: string; AHilight: string; ATag: string; ADoCase: Boolean): String;
begin
  Result := HiLight(AText, AHilight, ATag, ADoCase);
end;

class function TAdvChartGraphics.GetBitmapFromBitmapContainer(ABitmapContainer: TAdvChartBitmapContainer; AName: string; AApplyScale: Boolean = False; AScale: Single = 0): TAdvChartBitmap;
begin
  Result := nil;
  if Assigned(ABitmapContainer) and (AName <> '') then
  begin
    if AApplyScale then
    begin
      if AScale > 0 then
        Result := TAdvChartBitmap(ABitmapContainer.FindBitmap(AName + '_' + FloatToStr(AScale)))
      else
        Result := TAdvChartBitmap(ABitmapContainer.FindBitmap(AName + '_' + FloatToStr(TAdvChartUtils.GetDPIScale)));
    end;

    if not Assigned(Result) then
      Result := TAdvChartBitmap(ABitmapContainer.FindBitmap(AName));
  end;
end;

procedure TAdvChartGraphics.DrawBitmapWithName(ARect: TRect; ABitmapName: string; AApplyScale: Boolean = False; AScale: Single = 0;
  AAspectRatio: Boolean = True; AStretch: Boolean = False; ACenter: Boolean = True; ACropping: Boolean = False);
begin
  DrawBitmapWithName(ConvertToRectF(ARect), ABitmapName, AApplyScale, AScale, AAspectRatio, AStretch, ACenter, ACropping);
end;

procedure TAdvChartGraphics.DrawBitmapWithName(ARect: TRectF; ABitmapName: string; AApplyScale: Boolean = False; AScale: Single = 0;
  AAspectRatio: Boolean = True; AStretch: Boolean = False; ACenter: Boolean = True; ACropping: Boolean = False);
var
  b: TAdvChartBitmap;
begin
  b := GetBitmapFromBitmapContainer(FBitmapContainer, ABitmapName, AApplyScale, AScale);
  if Assigned(b) then
    DrawBitmap(ARect, b, AAspectRatio, AStretch, ACenter, ACropping);
end;

procedure TAdvChartGraphics.DrawBitmapWithName(ALeft: Integer; ATop: Integer; ARight: Integer; ABottom: Integer; ABitmapName: string;
  AApplyScale: Boolean = False; AScale: Single = 0; AAspectRatio: Boolean = True; AStretch: Boolean = False; ACenter: Boolean = True;
  ACropping: Boolean = False);
begin
  DrawBitmapWithName(RectF(ALeft, ATop, ARight, ABottom), ABitmapName, AApplyScale, AScale, AAspectRatio, AStretch, ACenter, ACropping);
end;

procedure TAdvChartGraphics.DrawBitmapWithName(ALeft: Double; ATop: Double; ARight: Double; ABottom: Double; ABitmapName: string;
  AApplyScale: Boolean = False; AScale: Single = 0; AAspectRatio: Boolean = True; AStretch: Boolean = False; ACenter: Boolean = True;
  ACropping: Boolean = False);
var
  b: TAdvChartBitmap;
begin
  b := GetBitmapFromBitmapContainer(FBitmapContainer, ABitmapName, AApplyScale, AScale);
  if Assigned(b) then
    DrawBitmap(ALeft, ATop, ARight, ABottom, b, AAspectRatio, AStretch, ACenter, ACropping);
end;

procedure TAdvChartGraphics.DrawScaledBitmap(ARect: TRect; ABitmaps: TAdvScaledBitmaps; AScale: Single = 0;
  AAspectRatio: Boolean = True; AStretch: Boolean = False; ACenter: Boolean = True; ACropping: Boolean = False);
begin
  DrawScaledBitmap(ConvertToRectF(ARect), ABitmaps, AScale, AAspectRatio, AStretch, ACenter, ACropping);
end;

procedure TAdvChartGraphics.DrawScaledBitmap(ARect: TRectF; ABitmaps: TAdvScaledBitmaps; AScale: Single = 0;
  AAspectRatio: Boolean = True; AStretch: Boolean = False; ACenter: Boolean = True; ACropping: Boolean = False);
var
  b: TAdvScaledBitmap;
  bmp: TAdvChartBitmap;
begin
  if Assigned(ABitmaps) then
  begin
    if AScale > 0 then
      b := ABitmaps.GetItemByScale(AScale)
    else
      b := ABitmaps.GetItemByScale(TAdvChartUtils.GetDPIScale);

    if Assigned(b) then
    begin
      if Assigned(b.Bitmap) and not IsBitmapEmpty(b.Bitmap) then
        DrawBitmap(ARect, b.Bitmap, AAspectRatio, AStretch, ACenter, ACropping)
      else
      begin
        bmp := GetBitmapFromBitmapContainer(FBitmapContainer, b.BitmapName, True, AScale);
        if Assigned(bmp) and not IsBitmapEmpty(bmp) then
          DrawBitmap(ARect, bmp, AAspectRatio, AStretch, ACenter, ACropping)
        else
          DrawBitmapWithName(ARect, b.BitmapName, False, b.Scale, AAspectRatio, AStretch, ACenter, ACropping);
      end;
    end;
  end;
end;

procedure TAdvChartGraphics.DrawScaledBitmap(ALeft: Integer; ATop: Integer; ARight: Integer; ABottom: Integer; ABitmaps: TAdvScaledBitmaps; AScale: Single = 0;
  AAspectRatio: Boolean = True; AStretch: Boolean = False; ACenter: Boolean = True; ACropping: Boolean = False);
begin
  DrawScaledBitmap(RectF(ALeft, ATop, ARight, ABottom), ABitmaps, AScale, AAspectRatio, AStretch, ACenter, ACropping);
end;

{$IFDEF SVGSUPPORT}
function TAdvChartGraphics.HasSVG(ABitmap: TAdvChartBitmapHelperClass): Boolean;
{$IFNDEF WEBLIB}
var
  si: TAdvChartGraphicsSVGImport;
{$ENDIF}
begin
  Result := False;
  {$IFNDEF WEBLIB}
  if (ABitmap is TAdvChartBitmap) then
  begin
    si := nil;
    {$IFDEF FMXLIB}
    if Assigned((ABitmap as TAdvChartBitmap).SVG) then
      si := TAdvChartGraphicsSVGImport((ABitmap as TAdvChartBitmap).SVG);
    {$ENDIF}
    {$IFDEF CMNLIB}
    if Assigned(ABitmap.Graphic) and (ABitmap.Graphic is TAdvSVGBitmap) then
      si := TAdvChartGraphicsSVGImport((ABitmap.Graphic as TAdvSVGBitmap).SVG);
    {$ENDIF}

    if Assigned(si) and si.HasElements then
      Result := True;
  end;
  {$ENDIF}
end;

function TAdvChartGraphics.DrawSVG(ABitmap: TAdvChartBitmapHelperClass;
  ARect: TRectF): Boolean;
{$IFNDEF WEBLIB}
var
  si: TAdvChartGraphicsSVGImport;
{$ENDIF}
begin
  Result := False;
  {$IFNDEF WEBLIB}
  if (ABitmap is TAdvChartBitmap) then
  begin
    si := nil;
    {$IFDEF FMXLIB}
    if Assigned((ABitmap as TAdvChartBitmap).SVG) then
      si := TAdvChartGraphicsSVGImport((ABitmap as TAdvChartBitmap).SVG);
    {$ENDIF}
    {$IFDEF CMNLIB}
    if Assigned(ABitmap.Graphic) and (ABitmap.Graphic is TAdvSVGBitmap) then
      si := TAdvChartGraphicsSVGImport((ABitmap.Graphic as TAdvSVGBitmap).SVG);
    {$ENDIF}

    if Assigned(si) and si.HasElements then
    begin
      si.Draw(Self, ARect{$IFDEF CMNLIB}, True{$ELSE}, FNative, not FNative{$ENDIF});
      Result := True;
    end;
  end;
  {$ENDIF}
end;
{$ENDIF}

procedure TAdvChartGraphics.DrawScaledBitmap(ALeft: Double; ATop: Double; ARight: Double; ABottom: Double; ABitmaps: TAdvScaledBitmaps; AScale: Single = 0;
  AAspectRatio: Boolean = True; AStretch: Boolean = False; ACenter: Boolean = True; ACropping: Boolean = False);
var
  b: TAdvScaledBitmap;
  bmp: TAdvChartBitmap;
begin
  if Assigned(ABitmaps) then
  begin
    if AScale > 0 then
      b := ABitmaps.GetItemByScale(AScale)
    else
      b := ABitmaps.GetItemByScale(TAdvChartUtils.GetDPIScale);

    if Assigned(b) then
    begin
      if Assigned(b.Bitmap) and not IsBitmapEmpty(b.Bitmap) then
        DrawBitmap(ALeft, ATop, ARight, ABottom, b.Bitmap, AAspectRatio, AStretch, ACenter, ACropping)
      else
      begin
        bmp := GetBitmapFromBitmapContainer(FBitmapContainer, b.BitmapName, True, AScale);
        if Assigned(bmp) and not IsBitmapEmpty(bmp) then
          DrawBitmap(ALeft, ATop, ARight, ABottom, bmp, AAspectRatio, AStretch, ACenter, ACropping)
        else
          DrawBitmapWithName(ALeft, ATop, ARight, ABottom, b.BitmapName, False, b.Scale, AAspectRatio, AStretch, ACenter, ACropping);
      end;
    end;
  end;
end;
{$ENDIF}

procedure TAdvChartGraphics.ClipRect(ARect: TRect);
begin
  ClipRect(ConvertToRect(ARect));
end;

procedure TAdvChartGraphics.ClipRect(ARect: TRectF);
begin
  Context.ClipRect(ARect);
end;

procedure TAdvChartGraphics.DrawFocusPath(APath: TAdvChartGraphicsPath; AColor: TAdvChartGraphicsColor = gcBlack);
begin
  Context.DrawFocusPath(FStroke, APath, AColor);
end;

procedure TAdvChartGraphics.DrawFocusRectangle(ALeft: Integer; ATop: Integer; ARight: Integer; ABottom: Integer; AColor: TAdvChartGraphicsColor = gcBlack; AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll);
begin
  DrawFocusRectangle(Rect(ALeft, ATop, ARight, ABottom), AColor, AModifyRectMode);
end;

procedure TAdvChartGraphics.DrawFocusRectangle(ALeft: Double; ATop: Double; ARight: Double; ABottom: Double; AColor: TAdvChartGraphicsColor = gcBlack; AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll);
var
  r: TRectF;
begin
  r := RectF(ALeft, ATop, ARight, ABottom);
  Context.DrawFocusRectangle(FStroke, r, AColor, AModifyRectMode);
end;

procedure TAdvChartGraphics.DrawFocusRectangle(ARect: TRect; AColor: TAdvChartGraphicsColor = gcBlack; AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll);
begin
  DrawFocusRectangle(ConvertToRectF(ARect), AColor, AModifyRectMode);
end;

procedure TAdvChartGraphics.DrawFocusRectangle(ARect: TRectF; AColor: TAdvChartGraphicsColor = gcBlack; AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll);
begin
  DrawFocusRectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom, AColor, AModifyRectMode);
end;

procedure TAdvChartGraphics.FontChanged(Sender: TObject);
begin
  SetFont(Sender as TAdvChartGraphicsFont);
end;

procedure TAdvChartGraphics.StrokeChanged(Sender: TObject);
begin
  SetStroke(Sender as TAdvChartGraphicsStroke);
end;

procedure TAdvChartGraphics.FillChanged(Sender: TObject);
begin
  SetFill(Sender as TAdvChartGraphicsFill);
end;

function TAdvChartGraphics.DrawText(ALeft, ATop, ARight, ABottom: Integer; AText: String; AWordWrapping: Boolean = False; AHorizontalAlign: TAdvChartGraphicsTextAlign = gtaLeading;
  AVerticalAlign: TAdvChartGraphicsTextAlign = gtaCenter; ATrimming: TAdvChartGraphicsTextTrimming = gttNone; AAngle: Single = 0;
  AMinWidth: Single = -1; AMinHeight: Single = -1{$IFNDEF LIMITEDGRAPHICSMODE};ASupportHTML: Boolean = True; ATestAnchor: Boolean = False; AX: Single = -1; AY: Single = - 1{$ENDIF}): String;
var
  AControlID, AControlValue, AControlType: string;
begin
  AControlID := '';
  AControlValue := '';
  AControlType := '';
  Result := DrawText(RectF(ALeft, ATop, ARight, ABottom), AText, AControlID, AControlValue, AControlType, AWordWrapping, AHorizontalAlign, AVerticalAlign, ATrimming,
    AAngle, AMinWidth, AMinHeight{$IFNDEF LIMITEDGRAPHICSMODE}, ASupportHTML, ATestAnchor, AX, AY{$ENDIF});
end;

function TAdvChartGraphics.DrawText(ALeft, ATop, ARight, ABottom: Double; AText: String; AWordWrapping: Boolean = False; AHorizontalAlign: TAdvChartGraphicsTextAlign = gtaLeading;
  AVerticalAlign: TAdvChartGraphicsTextAlign = gtaCenter; ATrimming: TAdvChartGraphicsTextTrimming = gttNone; AAngle: Single = 0;
  AMinWidth: Single = -1; AMinHeight: Single = -1{$IFNDEF LIMITEDGRAPHICSMODE};ASupportHTML: Boolean = True; ATestAnchor: Boolean = False; AX: Single = -1; AY: Single = - 1{$ENDIF}): String;
var
  AControlID, AControlValue, AControlType: string;
begin
  AControlID := '';
  AControlValue := '';
  AControlType := '';
  Result := DrawText(RectF(ALeft, ATop, ARight, ABottom), AText, AControlID, AControlValue, AControlType, AWordWrapping, AHorizontalAlign, AVerticalAlign, ATrimming,
    AAngle, AMinWidth, AMinHeight{$IFNDEF LIMITEDGRAPHICSMODE}, ASupportHTML, ATestAnchor, AX, AY{$ENDIF});
end;

function TAdvChartGraphics.DrawText(ALeft, ATop, ARight, ABottom: Integer; AText: String; var AControlID: string; var AControlValue: string; var AControlType: string; AWordWrapping: Boolean = False; AHorizontalAlign: TAdvChartGraphicsTextAlign = gtaLeading;
  AVerticalAlign: TAdvChartGraphicsTextAlign = gtaCenter; ATrimming: TAdvChartGraphicsTextTrimming = gttNone; AAngle: Single = 0;
  AMinWidth: Single = -1; AMinHeight: Single = -1{$IFNDEF LIMITEDGRAPHICSMODE};ASupportHTML: Boolean = True; ATestAnchor: Boolean = False; AX: Single = -1; AY: Single = - 1{$ENDIF}): String;
begin
  Result := DrawText(RectF(ALeft, ATop, ARight, ABottom), AText, AControlID, AControlValue, AControlType, AWordWrapping, AHorizontalAlign, AVerticalAlign, ATrimming,
    AAngle, AMinWidth, AMinHeight{$IFNDEF LIMITEDGRAPHICSMODE}, ASupportHTML, ATestAnchor, AX, AY{$ENDIF});
end;

function TAdvChartGraphics.DrawText(ALeft, ATop, ARight, ABottom: Double; AText: String; var AControlID: string; var AControlValue: string; var AControlType: string; AWordWrapping: Boolean = False; AHorizontalAlign: TAdvChartGraphicsTextAlign = gtaLeading;
  AVerticalAlign: TAdvChartGraphicsTextAlign = gtaCenter; ATrimming: TAdvChartGraphicsTextTrimming = gttNone; AAngle: Single = 0;
  AMinWidth: Single = -1; AMinHeight: Single = -1{$IFNDEF LIMITEDGRAPHICSMODE};ASupportHTML: Boolean = True; ATestAnchor: Boolean = False; AX: Single = -1; AY: Single = - 1{$ENDIF}): String;
begin
  Result := DrawText(RectF(ALeft, ATop, ARight, ABottom), AText, AControlID, AControlValue, AControlType, AWordWrapping, AHorizontalAlign, AVerticalAlign, ATrimming,
    AAngle, AMinWidth, AMinHeight{$IFNDEF LIMITEDGRAPHICSMODE}, ASupportHTML, ATestAnchor, AX, AY{$ENDIF});
end;

procedure TAdvChartGraphics.InitializeDefaultAppearance;
begin
  {$IFNDEF LIMITEDGRAPHICSMODE}
  FURLColor := gcBlue;
  FURLUnderline := True;
  {$ENDIF}
  SetFill(Fill);
  SetStroke(Stroke);
  SetFont(Font);
end;

{$IFDEF FMXLIB}
class function TAdvChartGraphics.GetColorAlpha(AColor: TAdvChartGraphicsColor): Byte;
begin
  Result := TAlphaColorRec(AColor).A;
end;
{$ENDIF}

class function TAdvChartGraphics.GetColorRed(AColor: TAdvChartGraphicsColor): Byte;
begin
  {$IFDEF FMXLIB}
  Result := TAlphaColorRec(AColor).R;
  {$ENDIF}
  {$IFDEF CMNWEBLIB}
  AColor := ColorToRGB(AColor);
  Result := GetRValue(AColor);
  {$ENDIF}
end;

class function TAdvChartGraphics.GetColorGreen(AColor: TAdvChartGraphicsColor): Byte;
begin
  {$IFDEF FMXLIB}
  Result := TAlphaColorRec(AColor).G;
  {$ENDIF}
  {$IFDEF CMNWEBLIB}
  AColor := ColorToRGB(AColor);
  Result := GetGValue(AColor);
  {$ENDIF}
end;

class function TAdvChartGraphics.GetColorBlue(AColor: TAdvChartGraphicsColor): Byte;
begin
  {$IFDEF FMXLIB}
  Result := TAlphaColorRec(AColor).B;
  {$ENDIF}
  {$IFDEF CMNWEBLIB}
  AColor := ColorToRGB(AColor);
  Result := GetBValue(AColor);
  {$ENDIF}
end;

class function TAdvChartGraphics.TextToColor(AText: string): TAdvChartGraphicsColor;
var
  i: integer;
  s: string;
  c: TStringList;
begin
  s := AText;

  s := LowerCase(s);
  if pos('cl',s) = 1 then
    Delete(s,1,2);

  if pos('cla',s) = 1 then
    Delete(s,1,3);

  if pos('gc',s) = 1 then
    Delete(s,1,2);

  Result := gcBlack;
  c := ColorLookup;
  if Assigned(c) then
  begin
    i := c.IndexOf(LowerCase(s));
    if (i >= 0) and (i <= c.Count - 1) then
      Result := TAdvChartGraphicsColorObject(c.Objects[i]).Color;
  end;
end;

class function TAdvChartGraphics.HTMLToColor(AHTML: string): TAdvChartGraphicsColor;
var
  r,g,b: Integer;
begin
  Result := gcNull;
  if AHTML = '' then
    Exit;

  if Length(AHTML) = 4 then
  begin
    r := StrToInt('$' + Copy(AHTML,2,1) + Copy(AHTML,2,1));
    g := StrToInt('$' + Copy(AHTML,3,1) + Copy(AHTML,3,1));
    b := StrToInt('$' + Copy(AHTML,4,1) + Copy(AHTML,4,1));
  end
  else
  begin
    r := StrToInt('$' + Copy(AHTML,2,2));
    g := StrToInt('$' + Copy(AHTML,4,2));
    b := StrToInt('$' + Copy(AHTML,6,2));
  end;

{$IFDEF CMNWEBLIB}
  Result := RGB(r, g, b);
{$ELSE}
  Result := MakeGraphicsColor(r, g, b);
{$ENDIF}
end;

class function TAdvChartGraphics.ColorToHTML(AColor: TAdvChartGraphicsColor): string;
const
  HTMLHexColor = '#RRGGBB';
  HexDigit: array[0..$F] of Char = '0123456789ABCDEF';
var
  c: TAdvChartGraphicsColor;
  i: Integer;
begin
  {$IFDEF ZEROSTRINGINDEX}
  i := 0;
  {$ELSE}
  i := 1;
  {$ENDIF}

  {$IFDEF FMXLIB}
  c := AColor;
  {$ENDIF}
  {$IFNDEF FMXLIB}
  c := ColorToRGB(AColor);
  {$ENDIF}
  Result := HtmlHexColor;
  Result[1 + i] := HexDigit[GetColorRed(c) shr 4];
  Result[2 + i] := HexDigit[GetColorRed(c) and $F];
  Result[3 + i] := HexDigit[GetColorGreen(c) shr 4];
  Result[4 + i] := HexDigit[GetColorGreen(c) and $F];
  Result[5 + i] := HexDigit[GetColorBlue(c) shr 4];
  Result[6 + i] := HexDigit[GetColorBlue(c) and $F];
end;

procedure TAdvChartGraphics.DrawTexture(ARect: TRectF; ATexture: TAdvChartBitmap; ATextureMode: TAdvChartGraphicsTextureMode);
var
  LR, R, IR: TRectF;
  I, J: Integer;
begin
  if IsBitmapEmpty(ATexture) then
    Exit;

  LR := ARect;
  case ATextureMode of
    gtmOriginal:
    begin
      R := RectF(ARect.Left, ARect.Top, ARect.Left + ATexture.Width, ARect.Top + ATexture.Height);
      IntersectRectEx(IR, LR, R);
      DrawBitmapPart(RectF(0, 0, (IR.Right - IR.Left), (IR.Bottom - IR.Top)), RectF(R.Left, R.Top, R.Left + (IR.Right - IR.Left), R.Top + (IR.Bottom - IR.Top)), ATexture, False, False, False, False);
    end;
    gtmFit:
    begin
      R := RectF(0, 0, ATexture.Width, ATexture.Height);
      R := RectSnapToPixelEx(RectFitIntoEx(R, ARect), 1, False);
      DrawBitmapPart(RectF(0, 0, ATexture.Width, ATexture.Height), R, ATexture, False, True, False, False);
    end;
    gtmStretch: DrawBitmapPart(RectF(0, 0, ATexture.Width, ATexture.Height), ARect, ATexture, False, True, False, False);
    gtmTile:
    begin
      for I := 0 to Trunc((LR.Right - LR.Left) / ATexture.Width) + 1 do
      begin
        for J := 0 to Trunc((LR.Bottom - LR.Top) / ATexture.Height) + 1 do
        begin
          R := RectF(LR.Left, LR.Top, LR.Left + ATexture.Width, LR.Top + ATexture.Height);
          OffsetRectEx(R, I * ATexture.Width, J * ATexture.Height);
          IntersectRectEx(IR, LR, R);
          if IntersectRectEx(IR, R) then
            DrawBitmap(RectF(R.Left, R.Top, (R.Left + (IR.Right - IR.Left)), (R.Top + (IR.Bottom - IR.Top))), ATexture, False, False, False, False);
        end;
      end;
    end;
    gtmCenter:
    begin
      R := RectF(0, 0, ATexture.Width, ATexture.Height);
      R := RectSnapToPixelEx(RectCenterAtEx(R, ARect), 1, False);
      DrawBitmapPart(RectF(0, 0, ATexture.Width, ATexture.Height), R, ATexture, True, False, True, False);
    end;
  end;
end;

function TAdvChartGraphics.DrawText(ARect: TRect; AText: String; AWordWrapping: Boolean = False; AHorizontalAlign: TAdvChartGraphicsTextAlign = gtaLeading;
  AVerticalAlign: TAdvChartGraphicsTextAlign = gtaCenter; ATrimming: TAdvChartGraphicsTextTrimming = gttNone; AAngle: Single = 0;
  AMinWidth: Single = -1; AMinHeight: Single = -1{$IFNDEF LIMITEDGRAPHICSMODE};ASupportHTML: Boolean = True; ATestAnchor: Boolean = False; AX: Single = -1; AY: Single = - 1{$ENDIF}): String;
var
  AControlID, AControlValue, AControlType: string;
begin
  AControlID := '';
  AControlValue := '';
  AControlType := '';
  Result := DrawText(ConvertToRectF(ARect), AText, AControlID, AControlValue, AControlType, AWordWrapping, AHorizontalAlign, AVerticalAlign, ATrimming, AAngle, AMinWidth, AMinHeight{$IFNDEF LIMITEDGRAPHICSMODE}, ASupportHTML, ATestAnchor, AX, AY{$ENDIF});
end;

function TAdvChartGraphics.DrawText(ARect: TRect; AText: String; var AControlID: string; var AControlValue: string; var AControlType: string; AWordWrapping: Boolean = False; AHorizontalAlign: TAdvChartGraphicsTextAlign = gtaLeading;
  AVerticalAlign: TAdvChartGraphicsTextAlign = gtaCenter; ATrimming: TAdvChartGraphicsTextTrimming = gttNone; AAngle: Single = 0;
  AMinWidth: Single = -1; AMinHeight: Single = -1{$IFNDEF LIMITEDGRAPHICSMODE};ASupportHTML: Boolean = True; ATestAnchor: Boolean = False; AX: Single = -1; AY: Single = - 1{$ENDIF}): String;
begin
  Result := DrawText(ConvertToRectF(ARect), AText, AControlID, AControlValue, AControlType, AWordWrapping, AHorizontalAlign, AVerticalAlign, ATrimming, AAngle, AMinWidth, AMinHeight{$IFNDEF LIMITEDGRAPHICSMODE}, ASupportHTML, ATestAnchor, AX, AY{$ENDIF});
end;

function TAdvChartGraphics.DrawText(APoint: TPointF; AText: String; AAngle: Single = 0{$IFNDEF LIMITEDGRAPHICSMODE};ASupportHTML: Boolean = True; ATestAnchor: Boolean = False; AX: Single = -1; AY: Single = - 1{$ENDIF}): String;
var
  AControlID, AControlValue, AControlType: string;
begin
  AControlID := '';
  AControlValue := '';
  AControlType := '';

  Result := DrawText(RectF(APoint.X, APoint.Y, APoint.X + 10000, APoint.Y + 10000), AText, AControlID, AControlValue, AControlType, False, gtaLeading, gtaLeading, gttNone, AAngle, -1, -1{$IFNDEF LIMITEDGRAPHICSMODE}, ASupportHTML, ATestAnchor, AX, AY{$ENDIF});
end;

function TAdvChartGraphics.DrawText(ARect: TRectF; AText: String; AWordWrapping: Boolean = False;AHorizontalAlign: TAdvChartGraphicsTextAlign = gtaLeading;
  AVerticalAlign: TAdvChartGraphicsTextAlign = gtaCenter; ATrimming: TAdvChartGraphicsTextTrimming = gttNone; AAngle: Single = 0;
  AMinWidth: Single = -1; AMinHeight: Single = -1{$IFNDEF LIMITEDGRAPHICSMODE};ASupportHTML: Boolean = True; ATestAnchor: Boolean = False; AX: Single = -1; AY: Single = - 1{$ENDIF}): String;
var
  AControlID, AControlValue, AControlType: string;
begin
  AControlID := '';
  AControlValue := '';
  AControlType := '';
  Result := DrawText(ARect, AText, AControlID, AControlValue, AControlType, AWordWrapping, AHorizontalAlign, AVerticalAlign, ATrimming, AAngle, AMinWidth, AMinHeight{$IFNDEF LIMITEDGRAPHICSMODE}, ASupportHTML, ATestAnchor, AX, AY{$ENDIF});
end;

function TAdvChartGraphics.DrawText(ARect: TRectF; AText: String; var AControlID: string; var AControlValue: string; var AControlType: string; AWordWrapping: Boolean = False;AHorizontalAlign: TAdvChartGraphicsTextAlign = gtaLeading;
  AVerticalAlign: TAdvChartGraphicsTextAlign = gtaCenter; ATrimming: TAdvChartGraphicsTextTrimming = gttNone; AAngle: Single = 0;
  AMinWidth: Single = -1; AMinHeight: Single = -1{$IFNDEF LIMITEDGRAPHICSMODE};ASupportHTML: Boolean = True; ATestAnchor: Boolean = False; AX: Single = -1; AY: Single = - 1{$ENDIF}): String;
var
  lst: TStringList;
  i, l, p: Integer;
  b: Boolean;
  r, rd: TRectF;
const
  arr: array[0..1] of string = ('<BR>', '<BR/>');
begin
  rd := ARect;

  {$IFNDEF LIMITEDGRAPHICSMODE}
  b := (not ATestAnchor) and OptimizedHTMLDrawing;
  {$ELSE}
  b := false;
  {$ENDIF}

  b := b and TAdvChartUtils.IsHTML(AText);

  if b then
  begin
    for I := 0 to Length(arr) - 1 do
    begin
      p := Pos(arr[I], UpperCase(AText));
      l := Length(arr[I]);
    end;

    if (p > 0) and (l > 0) then
    begin
      lst := TStringList.Create;
      try
        lst.LineBreak := Copy(AText, p, l);
        lst.Text := AText;

        for I := 0 to lst.Count - 1 do
        begin
          r := CalculateText(lst[I], rd, AWordWrapping{$IFNDEF LIMITEDGRAPHICSMODE}, ASupportHTML{$ENDIF});
          InternalDrawText(RectF(r.Left, r.Top, r.Right + 1, r.Bottom), lst[I], AControlID, AControlValue, AControlType, AWordWrapping, AHorizontalAlign, AVerticalAlign,
            ATrimming, AAngle, AMinWidth, AMinHeight{$IFNDEF LIMITEDGRAPHICSMODE}, ASupportHTML, ATestAnchor, AX, AY{$ENDIF});

          rd.Top := rd.Top + (r.Bottom - r.Top);
          rd.Bottom := rd.Bottom + (r.Bottom - r.Top);
        end;

      finally
        lst.Free;
      end;
    end
    else
      b := False;
  end;

  if not b then
  begin
    Result := InternalDrawText(ARect, AText, AControlID, AControlValue, AControlType, AWordWrapping, AHorizontalAlign, AVerticalAlign,
      ATrimming, AAngle, AMinWidth, AMinHeight{$IFNDEF LIMITEDGRAPHICSMODE}, ASupportHTML, ATestAnchor, AX, AY{$ENDIF});
  end;
end;

function TAdvChartGraphics.InternalDrawText(ARect: TRectF; AText: String; var AControlID: string; var AControlValue: string; var AControlType: string; AWordWrapping: Boolean = False;AHorizontalAlign: TAdvChartGraphicsTextAlign = gtaLeading;
  AVerticalAlign: TAdvChartGraphicsTextAlign = gtaCenter; ATrimming: TAdvChartGraphicsTextTrimming = gttNone; AAngle: Single = 0;
  AMinWidth: Single = -1; AMinHeight: Single = -1{$IFNDEF LIMITEDGRAPHICSMODE};ASupportHTML: Boolean = True; ATestAnchor: Boolean = False; AX: Single = -1; AY: Single = - 1{$ENDIF}): String;
var
{$IFNDEF LIMITEDGRAPHICSMODE}
  a, s: String;
  fa: String;
  XSize, YSize: Single;
  hl, ml: Integer;
  hr, cr: TRectF;
  xs, ys: Single;
  lc: Integer;
  htmlr: TRectF;
  isanchor: boolean;
  st: TAdvChartGraphicsSaveState;
{$ENDIF}
  oldc: TAdvChartGraphicsColor;
begin
  inherited;

  oldc := Context.GetFillColor;
  Context.SetFillColor(FFont.Color);

  {$IFDEF WEBLIB}
  if (AMinHeight > -1) and (ARect.Bottom - ARect.Top < AMinHeight) then
    ARect.Bottom := ARect.Top + AMinHeight;

  if (AMinWidth > -1) and (ARect.Right - ARect.Left < AMinWidth) then
    ARect.Right := ARect.Left + AMinWidth;
  {$ENDIF}
  {$IFNDEF WEBLIB}
  if (AMinHeight > -1) and (ARect.Height < AMinHeight) then
    ARect.Height := AMinHeight;

  if (AMinWidth > -1) and (ARect.Width < AMinWidth) then
    ARect.Width := AMinWidth;
  {$ENDIF}

  ARect := Context.SetTextAngle(ARect, AAngle);

  Result := '';

  {$IFNDEF LIMITEDGRAPHICSMODE}
  if ((Pos('</', AText) > 0) or (Pos('/>', AText)  > 0) or (Pos('<BR>', UpperCase(AText)) > 0)) and ASupportHTML then
  begin
    hr := RectF(0, 0, 0, 0);
    XSize := 0;
    YSize := 0;
    hl := -1;
    ml := -1;
    fa := '';
    s := '';
    a := '';
    lc := 0;
    cr := RectF(0, 0, 0, 0);
    AControlID := '';
    AControlValue := '';
    AControlType := '';
    HTMLDrawEx(Self, AText, ARect,0, 0,-1,-1,0,False,True,False,False,False,False,AWordWrapping,False, '', 1.0,URLColor,
        gcNull,gcNull,gcNull,a,s,fa,XSize,YSize,hl,ml,hr, cr, AControlID, AControlValue, AControlType, lc, 0, FBitmapContainer, 1, URLUnderline{$IFDEF CMNLIB}, FImageList{$ENDIF},
        HighlightColor, HighlightTextColor, HighlightFontStyle);

    YSize := YSize + 1;
    XSize := XSize + 1;

    if (AWordWrapping and (lc <= 1)) or (not AWordWrapping) then
    begin
      xs := ARect.Left;
      ys := ARect.Top;

      case AHorizontalAlign of
        gtaCenter: xs := xs + ((ARect.Right - ARect.Left) - XSize) / 2;
        gtaTrailing: xs := ARect.Left + (ARect.Right - ARect.Left) - XSize;
      end;

      case AVerticalAlign of
        gtaCenter: ys := ys + ((ARect.Bottom - ARect.Top) - YSize) / 2;
        gtaTrailing: ys := ys + (ARect.Bottom - ARect.Top) - YSize;
      end;

      htmlr := RectF(xs, ys, xs + XSize, ys + YSize);
    end
    else
      htmlr := ARect;

    st := SaveState(True);
    ClipRect(ARect);
    isanchor := HTMLDrawEx(Self, AText, htmlr,Round(AX), Round(AY),-1,-1,0,ATestAnchor,False,False,False,False,False,AWordWrapping,False, '', 1.0,URLColor,
        gcNull,gcNull,gcNull,a,s,fa,XSize,YSize,hl,ml,hr,cr, AControlID, AControlValue, AControlType, lc, 0, FBitmapContainer, 1, URLUnderline{$IFDEF CMNLIB}, FImageList{$ENDIF},
        HighlightColor, HighlightTextColor, HighlightFontStyle);
    RestoreState(st, True);

    if isanchor then
      Result := a;
  end
  else if not ATestAnchor then
  {$ENDIF}
    Context.DrawText(AText, ARect, AWordWrapping, AHorizontalAlign, AVerticalAlign, ATrimming, AAngle);

  Context.ResetTextAngle(AAngle);
  Context.SetFillColor(oldc);
end;

procedure TAdvChartGraphics.DrawEllipse(ALeft: Integer; ATop: Integer; ARight: Integer; ABottom: Integer; AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll);
begin
  DrawEllipse(RectF(ALeft, ATop, ARight, ABottom), AModifyRectMode);
end;

procedure TAdvChartGraphics.DrawEllipse(ALeft: Double; ATop: Double; ARight: Double; ABottom: Double; AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll);
var
  r: TRectF;
  pth: TAdvChartGraphicsPath;
begin
  r := RectF(ALeft, ATop, ARight, ABottom);
  if ((FFill.Color <> gcNull) and (FFill.Kind <> gfkNone)) or (FFill.Kind = gfkTexture) then
  begin
    case FFill.Kind of
      gfkTexture:
      begin
        pth := TAdvChartGraphicsPath.Create;
        try
          pth.AddEllipse(r);
          DrawTexture(r, FFill.Texture, FFill.TextureMode);
        finally
          pth.Free;
        end;
      end;
      else
        Context.FillEllipse(FFill, r, AModifyRectMode);
    end;
  end;

  if (FStroke.Color <> gcNull) and (FStroke.Kind <> gskNone) then
    Context.DrawEllipse(FStroke, r, AModifyRectMode);
end;

class procedure TAdvChartGraphics.SetDefaultGraphicColors;
begin
  TAdvChartGraphics.DefaultPopupFillColor := gcWhite;
  TAdvChartGraphics.DefaultPopupStrokeColor := gcSilver;
  TAdvChartGraphics.DefaultButtonFillColor := MakeGraphicsColor(225, 225, 225);
  TAdvChartGraphics.DefaultButtonStrokeColor := gcDarkgray;
  TAdvChartGraphics.DefaultTextFontColor := gcBlack;
  TAdvChartGraphics.DefaultSelectionFillColor := gcBlack;
  TAdvChartGraphics.DefaultButtonFillColorFocused := MakeGraphicsColor(229, 241, 251);
  TAdvChartGraphics.DefaultButtonStrokeColorFocused := MakeGraphicsColor(60, 127, 177);
  TAdvChartGraphics.DefaultButtonStrokeColorDisabled := gcDarkGray;
  TAdvChartGraphics.DefaultButtonFillColorDisabled := gcLightgray;
end;

class procedure TAdvChartGraphics.ConvertBitmapToGrayScale(ABitmap: TAdvChartBitmap);
type
  TAdvChartGraphicsColorToGrayscale = (ctgLightness, ctgAverage, ctgLuminosity);

  function MinColor(const A, B, C: Integer): Integer;
  begin
    Result := Min(A, Min(B, C));
  end;

  function MaxColor(const A, B, C: Integer): Integer;
  begin
    Result := Max(A, Max(B, C));
  end;

  function ColorToGray(AColor: TAdvChartGraphicsColor; AMode: TAdvChartGraphicsColorToGrayscale = ctgLuminosity): TAdvChartGraphicsColor;
  var
    R, G, B, X: Byte;
    {$IFNDEF CMNLIB}
    A: Byte;
    {$ENDIF}
  begin
    {$IFDEF FMXLIB}
    R := TAlphaColorRec(AColor).R;
    G := TAlphaColorRec(AColor).G;
    B := TAlphaColorRec(AColor).B;
    A := TAlphaColorRec(AColor).A;
    {$ENDIF}
    {$IFDEF CMNLIB}
    R := AColor and $FF;
    G := (AColor and $FF00) shr 8;
    B := (AColor and $FF0000) shr 16;
    {$ENDIF}
    case AMode of
      ctgLightness: X := (MaxColor(R, G, B) + MinColor(R, G, B)) div 2;
      ctgAverage: X := (R + G + B) div 3;
      ctgLuminosity: X := Round(0.21 *R + 0.71*G + 0.07*B);
      else
        X := 0;
    end;
    {$IFDEF FMXLIB}
    Result := MakeGraphicsColor(X, X, X, A);
    {$ENDIF}
    {$IFDEF CMNLIB}
    Result := TAdvChartGraphicsColor(RGB(X, X, X));
    {$ENDIF}
  end;

var
  I, J: Integer;
  {$IFDEF FMXLIB}
  m: TBitmapData;
  {$ENDIF}
begin
  if Assigned(ABitmap) and not IsBitmapEmpty(ABitmap) then
  begin
    {$IFDEF FMXLIB}
    if ABitmap.Map(TMapAccess.ReadWrite, m) then
    begin
    {$ENDIF}
    {$IFDEF CMNLIB}
    begin
    {$ENDIF}
    {$IFDEF WEBLIB}
    begin
    {$ENDIF}
      for I := 0 to ABitmap.Width - 1 do
      begin
        for J := 0 to ABitmap.Height - 1 do
        begin
          {$IFDEF CMNLIB}
          ABitmap.Bitmap.Canvas.Pixels[I, J] := ColorToGray(ABitmap.Bitmap.Canvas.Pixels[I, J]);
          {$ENDIF}
          {$IFDEF FMXLIB}
          m.SetPixel(I, J, ColorToGray(m.GetPixel(I, J)));
          {$ENDIF}
        end;
      end;
      {$IFDEF FMXLIB}
      ABitmap.Unmap(m);
      {$ENDIF}
    end;
  end;
end;

class procedure TAdvChartGraphics.DrawSample(ACanvas: TCanvas; ARect: TRectF);
var
  g: TAdvChartGraphics;
begin
  g := TAdvChartGraphics.Create(ACanvas);
  try
    g.Font.Name := 'Courier New';
    g.Font.Size := 20;
    g.Font.Color := gcWhite;
    g.Fill.Kind := gfkGradient;
    g.Fill.Color := gcDarkorange;
    g.Fill.ColorTo := gcSteelblue;
    g.Stroke.Color := gcDarkblue;
    g.DrawRectangle(ARect);
    g.DrawText(ARect, 'Sample', False, gtaCenter);
  finally
    g.Free;
  end;
end;

class function TAdvChartGraphics.PointInPolygon(APoint: TPoint; APolygon: TAdvChartGraphicsPathPolygon): Boolean;
begin
  Result := PointInPolygon(ConvertToPointF(APoint), APolygon);
end;

class function TAdvChartGraphics.PointInPolygon(APoint: TPointF; APolygon: TAdvChartGraphicsPathPolygon): Boolean;
begin
  Result := PointInPolygon(APoint, APolygon);
end;

class function TAdvChartGraphics.PointInRect(APoint: TPoint; ARect: TRect): Boolean;
begin
  Result := PointInRect(ConvertToPointF(APoint), ConvertToRectF(ARect));
end;

class function TAdvChartGraphics.PointInRect(APoint: TPointF; ARect: TRectF): Boolean;
begin
  Result := PtInRectEx(ARect, APoint);
end;

class function TAdvChartGraphics.PointInCircle(APoint, ACenter: TPointF; const ARadius: Single): Boolean;
begin
  if ARadius > 0 then
    Result := Sqr((APoint.X - ACenter.X) / ARadius) + Sqr((APoint.Y - ACenter.Y) / ARadius) <= 1
  else
    Result := False;
end;

class function TAdvChartGraphics.PointInPath(APoint: TPoint; APath: TAdvChartGraphicsPath): Boolean;
begin
  Result := PointInPath(ConvertToPointF(APoint), APath);
end;

class function TAdvChartGraphics.PointInPath(APoint: TPointF; APath: TAdvChartGraphicsPath): Boolean;
begin
  Result := APath.IsPointVisible(APoint);
end;

function TAdvChartGraphics.CalculateTextSizeInt(AText: String): TSize;
begin
  Result := ConvertToSize(CalculateTextSize(AText));
end;

function TAdvChartGraphics.CalculateTextSize(AText: String): TSizeF;
begin
  Result := CalculateTextSize(AText, RectF(0, 0, 10000, 10000));
end;

function TAdvChartGraphics.CalculateTextHeightInt(AText: String): Integer;
begin
  Result := Round(CalculateTextHeight(AText));
end;

function TAdvChartGraphics.CalculateTextHeight(AText: String): Single;
begin
  Result := CalculateTextHeight(AText, RectF(0, 0, 10000, 10000));
end;

function TAdvChartGraphics.CalculateTextWidthInt(AText: String): Integer;
begin
  Result := Round(CalculateTextWidth(AText));
end;

function TAdvChartGraphics.CalculateTextWidth(AText: String): Single;
begin
  Result := CalculateTextWidth(AText, RectF(0, 0, 10000, 10000));
end;

function TAdvChartGraphics.CalculateTextSize(AText: String; ARect: TRect; AWordWrapping: Boolean = False{$IFNDEF LIMITEDGRAPHICSMODE}; ASupportHTML: Boolean = True{$ENDIF}): TSize;
begin
  Result := ConvertToSize(CalculateTextSize(AText, ConvertToRectF(ARect), AWordWrapping{$IFNDEF LIMITEDGRAPHICSMODE}, ASupportHTML{$ENDIF}));
end;

function TAdvChartGraphics.CalculateTextSize(AText: String; ARect: TRectF; AWordWrapping: Boolean = False{$IFNDEF LIMITEDGRAPHICSMODE}; ASupportHTML: Boolean = True{$ENDIF}): TSizeF;
var
  r: TRectF;
begin
  r := CalculateText(AText, ARect, AWordWrapping{$IFNDEF LIMITEDGRAPHICSMODE}, ASupportHTML{$ENDIF});
  Result.cx := r.Right - r.Left;
  Result.cy := r.Bottom - r.Top;
end;

function TAdvChartGraphics.CalculateTextHeight(AText: String; ARect: TRect; AWordWrapping: Boolean = False{$IFNDEF LIMITEDGRAPHICSMODE}; ASupportHTML: Boolean = True{$ENDIF}): Integer;
begin
  Result := Round(CalculateTextHeight(AText, ConvertToRectF(ARect), AWordWrapping{$IFNDEF LIMITEDGRAPHICSMODE}, ASupportHTML{$ENDIF}));
end;

function TAdvChartGraphics.CalculateTextHeight(AText: String; ARect: TRectF; AWordWrapping: Boolean = False{$IFNDEF LIMITEDGRAPHICSMODE}; ASupportHTML: Boolean = True{$ENDIF}): Single;
var
  r: TRectF;
begin
  r := CalculateText(AText, ARect, AWordWrapping{$IFNDEF LIMITEDGRAPHICSMODE}, ASupportHTML{$ENDIF});
  Result := r.Bottom - r.Top;
end;

function TAdvChartGraphics.CalculateTextWidth(AText: String; ARect: TRect; AWordWrapping: Boolean = False{$IFNDEF LIMITEDGRAPHICSMODE}; ASupportHTML: Boolean = True{$ENDIF}): Integer;
begin
  Result := Round(CalculateTextWidth(AText, ConvertToRectF(ARect), AWordWrapping{$IFNDEF LIMITEDGRAPHICSMODE}, ASupportHTML{$ENDIF}));
end;

function TAdvChartGraphics.CalculateTextWidth(AText: String; ARect: TRectF; AWordWrapping: Boolean = False{$IFNDEF LIMITEDGRAPHICSMODE}; ASupportHTML: Boolean = True{$ENDIF}): Single;
var
  r: TRectF;
begin
  r := CalculateText(AText, ARect, AWordWrapping{$IFNDEF LIMITEDGRAPHICSMODE}, ASupportHTML{$ENDIF});
  Result := r.Right - r.Left;
end;

function TAdvChartGraphics.CalculateTextInt(AText: String): TRect;
begin
  Result := ConvertToRect(CalculateText(AText));
end;

function TAdvChartGraphics.CalculateText(AText: String): TRectF;
begin
  Result := CalculateText(AText, RectF(0, 0, 10000, 10000));
end;

function TAdvChartGraphics.CalculateText(AText: String;
  ARect: TRect; AWordWrapping: Boolean = False{$IFNDEF LIMITEDGRAPHICSMODE}; ASupportHTML: Boolean = True{$ENDIF}): TRect;
begin
  Result := ConvertToRect(CalculateText(AText, ConvertToRectF(ARect), AWordWrapping{$IFNDEF LIMITEDGRAPHICSMODE}, ASupportHTML{$ENDIF}));
end;

function TAdvChartGraphics.CalculateText(AText: String;
  ARect: TRectF; AWordWrapping: Boolean = False{$IFNDEF LIMITEDGRAPHICSMODE}; ASupportHTML: Boolean = True{$ENDIF}): TRectF;
var
  lst: TStringList;
  i, l, p: Integer;
  b: Boolean;
  r: TRectF;
  y: Single;
const
  arr: array[0..1] of string = ('<BR>', '<BR/>');
begin
  Result := ARect;

  {$IFNDEF LIMITEDGRAPHICSMODE}
  b := OptimizedHTMLDrawing and TAdvChartUtils.IsHTML(AText);
  {$ELSE}
  b := False;
  {$ENDIF}

  if b then
  begin
    for I := 0 to Length(arr) - 1 do
    begin
      p := Pos(arr[I], UpperCase(AText));
      l := Length(arr[I]);
    end;

    if (p > 0) and (l > 0) then
    begin
      lst := TStringList.Create;
      try
        lst.LineBreak := Copy(AText, p, l);
        lst.Text := AText;

        y := 0;
        for I := 0 to lst.Count - 1 do
        begin
          r := InternalCalculateText(lst[I], ARect, AWordWrapping{$IFNDEF LIMITEDGRAPHICSMODE}, ASupportHTML{$ENDIF});
          y := y + (r.Bottom - r.Top);
        end;

        Result.Bottom := Result.Top + y;

      finally
        lst.Free;
      end;
    end
    else
      b := False;
  end;

  if not b then
    Result := InternalCalculateText(AText, ARect, AWordWrapping{$IFNDEF LIMITEDGRAPHICSMODE}, ASupportHTML{$ENDIF});
end;

function TAdvChartGraphics.InternalCalculateText(AText: String;
  ARect: TRectF; AWordWrapping: Boolean = False{$IFNDEF LIMITEDGRAPHICSMODE}; ASupportHTML: Boolean = True{$ENDIF}): TRectF;
{$IFNDEF LIMITEDGRAPHICSMODE}
var
  a, s: String;
  fa: String;
  XSize, YSize: Single;
  hl, ml: Integer;
  hr, cr: TRectF;
  lc: Integer;
  AControlID, AControlType, AControlValue: string;
{$ENDIF}
begin
  Result := ARect;

  if Round(Result.Right - Result.Left) <= 0 then
  begin
    Result.Bottom := Result.Top;
    Exit;
  end;

  if AText <> '' then
  begin
    {$IFNDEF LIMITEDGRAPHICSMODE}
    if ASupportHTML and ((Pos('</', AText) > 0) or (Pos('/>', AText)  > 0) or (Pos('<BR>', UpperCase(AText)) > 0)) then
    begin
      hr := RectF(0, 0, 0, 0);
      XSize := 0;
      YSize := 0;
      hl := -1;
      ml := -1;
      fa := '';
      s := '';
      a := '';
      lc := 0;
      cr := RectF(0, 0, 0, 0);
      AControlID := '';
      AControlValue := '';
      AControlType := '';
      HTMLDrawEx(Self, AText, ARect, 0, 0,-1,-1,0,False,True,False,False,False,False,AWordWrapping,False, '', 1.0,URLColor,
        gcNull,gcNull,gcNull,a,s,fa,XSize,YSize,hl,ml,hr,cr, AControlID, AControlValue, AControlType, lc, 0, FBitmapContainer, 1, URLUnderline{$IFDEF CMNLIB}, FImageList{$ENDIF},
        HighlightColor, HighlightTextColor, HighlightFontStyle);

      YSize := YSize + 1;

      Result.Right := Result.Left + XSize;
      Result.Bottom := Result.Top + YSize;
    end
    else
    {$ENDIF}
    begin
      Result := Context.CalculateText(AText, ARect, AWordWrapping);
      Result.Bottom := Result.Bottom + 1;
    end;
  end
  else
  begin
    Result.Right := Result.Left;
    Result.Bottom := Result.Top;
  end;
end;

procedure TAdvChartGraphics.DrawEllipse(ARect: TRect; AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll);
begin
  DrawEllipse(ConvertToRectF(ARect), AModifyRectMode);
end;

procedure TAdvChartGraphics.DrawEllipse(ARect: TRectF; AModifyRectMode: TAdvChartGraphicsModifyRectMode = gcrmShrinkAll);
begin
  DrawEllipse(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom, AModifyRectMode);
end;

{ TAdvChartGraphicsContext }

function TAdvChartGraphicsContext.ConvertToPath(APath: TAdvChartGraphicsPath; const Flatness: Single = 0.25): Pointer;
var
  J, I: Integer;
  BPts: TAdvChartGraphicsPathPolygon;
  B: TAdvChartGraphicsPathCubicBezier;
  F, Len: Single;
  SegCount: Integer;
  CurPoint: TPointF;
  x: TPointF;
begin
  Result := CreatePath;
  if APath.Count > 0 then
  begin
    F := Max(Flatness, 0.05);
    J := 0;
    while J < APath.Count do
    begin
      case APath[J].Kind of
        gppMoveTo:
          begin
            PathOpen(Result);
            PathMoveTo(Result, APath[J].Point);
            CurPoint := APath[J].Point;
          end;
        gppLineTo:
          begin
            PathLineTo(Result, APath[J].Point);
            CurPoint := APath[J].Point;
          end;
        gppCurveTo:
          begin
            B[0] := CurPoint;
            B[1] := APath[J].Point;
            Inc(J);
            B[2] := APath[J].Point;
            Inc(J);
            B[3] := APath[J].Point;
            BPts := APath.CreateBezier(B, 6);
            Len := 0;
            for I := 0 to High(BPts) - 1 do
            begin
              x.X := BPts[I].X - BPts[I + 1].X;
              x.Y := BPts[I].Y - BPts[I + 1].Y;
              Len := Len + GetPointLength(x);
            end;
            SegCount := Round(Len / F);
            if SegCount < 2 then
              PathLineTo(Result, B[3])
            else
            begin
              BPts := APath.CreateBezier(B, SegCount);
              for I := 0 to High(BPts) do
                PathLineTo(Result, BPts[I]);
              CurPoint := APath[J].Point;
            end;
          end;
        gppClose: PathClose(Result);
      end;
      Inc(J);
    end;
  end;
end;

constructor TAdvChartGraphicsContext.Create(const AGraphics: TAdvChartGraphics);
begin
  FGraphics := AGraphics;
end;

function TAdvChartGraphicsContext.GetGraphics: TAdvChartGraphics;
begin
  Result := FGraphics;
end;

function TAdvChartGraphicsContext.GetCanvas: TCanvas;
begin
  Result := nil;
  if Assigned(Graphics) then
    Result := Graphics.Canvas;
end;

{$IFDEF WEBLIB}
initialization
begin
  TAdvChartBitmap.CreateFromResource(AdvGRAPHICSCLOSE);
  TAdvChartBitmap.CreateFromResource(AdvGRAPHICSDOWN);
  TAdvChartBitmap.CreateFromResource(AdvGRAPHICSRIGHT);
  TAdvChartBitmap.CreateFromResource(AdvGRAPHICSLEFT);
  TAdvChartBitmap.CreateFromResource(AdvCHARTGRAPHICSEXPAND);
  TAdvChartBitmap.CreateFromResource(AdvGRAPHICSPIN);
  TAdvChartBitmap.CreateFromResource(AdvGRAPHICSPIN2);
  TAdvChartBitmap.CreateFromResource(AdvGRAPHICSDOWN);
  TAdvChartBitmap.CreateFromResource(AdvGRAPHICSDOWN2);
  TAdvChartBitmap.CreateFromResource(AdvGRAPHICSUP);
  TAdvChartBitmap.CreateFromResource(AdvGRAPHICSUP2);
  TAdvChartBitmap.CreateFromResource(AdvCHARTGRAPHICSEXPANDSVG);
  TAdvChartBitmap.CreateFromResource(AdvGRAPHICSUPSVG);
  TAdvChartBitmap.CreateFromResource(AdvGRAPHICSRIGHTSVG);
  TAdvChartBitmap.CreateFromResource(AdvGRAPHICSLEFTSVG);
  TAdvChartBitmap.CreateFromResource(AdvGRAPHICSDOWNSVG);
  TAdvChartBitmap.CreateFromResource(AdvGRAPHICSCLOSESVG);
end;
{$ENDIF}

end.
