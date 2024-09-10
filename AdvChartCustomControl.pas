﻿{********************************************************************}
{                                                                    }
{ written by TMS Software                                            }
{            copyright (c) 2016 - 2022                               }
{            Email : info@tmssoftware.com                            }
{            Web : https://www.tmssoftware.com                       }
{                                                                    }
{ The source code is given as is. The author is not responsible      }
{ for any possible damage done due to the use of this code.          }
{ The complete source code remains property of the author and may    }
{ not be distributed, published, given or sold in any form as such.  }
{ No parts of the source code can be included in any other component }
{ or application without written authorization of the author.        }
{********************************************************************}

unit AdvChartCustomControl;

{$WARNINGS OFF}

{$I TMSDEFS.inc}

{$IFDEF CMNLIB}
{$DEFINE CMNWEBLIB}
{$ENDIF}
{$IFDEF WEBLIB}
{$DEFINE CMNWEBLIB}
{$DEFINE LCLWEBLIB}
{$DEFINE VCLWEBLIB}
{$ENDIF}
{$IFDEF LCLLIB}
{$DEFINE LCLWEBLIB}
{$ENDIF}
{$IFDEF VCLLIB}
{$DEFINE VCLWEBLIB}
{$ENDIF}

{$IFDEF FMXMOBILE}
{$DEFINE DRAWTRIAL}
{$ENDIF}

{$IFDEF WEBLIB}
{$DEFINE DRAWTRIAL}
{$ENDIF}

{$IFDEF FNCLIB}
{$DEFINE USETRIAL}

{$IFDEF VCLLIB}
{$HINTS OFF}
{$IF COMPILERVERSION > 34}
{$DEFINE VCLSTYLESENABLED}
{$IFEND}
{$HINTS ON}
{$ENDIF}

{$ELSE}
{$IFDEF FMXLIB}
{$DEFINE USETRIAL}
{$ENDIF}
{$ENDIF}

interface

uses
  {$IFDEF MSWINDOWS}
  {%H-}Windows,
  {$ENDIF}
  Classes, Controls, AdvChartGraphics, Graphics, AdvChartStyles
  ,AdvChartPersistence, AdvChartUndo
  {$IFNDEF WEBLIB}
  {$IFDEF FNCLIB}
  ,AdvHint
  {$ELSE}
  {$IFDEF VCLLIB}
  {$IFDEF FREEWARE}
   
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}
  ,Types, AdvChartGraphicsTypes, AdvChartTypes, TypInfo, Forms
  {$IFDEF VCLLIB}
  ,Messages
  {$ENDIF}
  {$IFDEF WEBLIB}
  ,WEBLib.Menus
  {$ENDIF}
  {$IFNDEF LCLLIB}
  {$IFNDEF WEBLIB}
  {$HINTS OFF}
  {$IF COMPILERVERSION > 22}
  ,UITypes
  {$IFEND}
  {$HINTS ON}
  ,Generics.Collections
  {$ENDIF}
  {$ENDIF}
  {$IFDEF LCLLIB}
  ,LMessages, LCLType, {%H-}LCLIntF, fgl
  {$ENDIF}
  {$IFDEF FMXLIB}
  ,FMX.Types, Messaging
  {$ENDIF}
  ;

  {$IFNDEF LCLLIB}
const
  FPC_FULLVERSION = 0;
  {$ENDIF}

type
  {$IFDEF FNCLIB}
  {$IFNDEF WEBLIB}
  IAdvShortCutHint = interface
  ['{A3E21A73-163A-4617-841B-8E0A62BF41B0}']
    function HasShortCut(AShortCut: string): Boolean;
    function HandleShortCut(AShortCut: string): Boolean;
    function GetShortCutHint: string;
    function IsShortCutHintActive: Boolean;
    procedure ShowShortCutHint;
    procedure CancelShortCutHint(AClearShortCutHintString: Boolean = True);
    procedure SetShortCutHint(const Value: string);
    property ShortCutHint: string read GetShortCutHint write SetShortCutHint;
  end;
  {$ENDIF}
  {$ENDIF}

  {$IFNDEF LCLWEBLIB}
  FNCJSLibReferenceAttribute = class(TCustomAttribute)
  strict private
    FAttrs: string;
    FCSSs: string;
    FDesc: string;
    FSrcs: string;
  public
    constructor Create(const AScrs: string); overload;
    constructor Create(const AScrs, ACSSs: string); overload;
    constructor Create(const AScrs, ACSSs, AAttrs: string); overload;
    constructor Create(const AScrs, ACSSs, AAttrs, ADesc: string); overload;
    property Attrs: string read FAttrs;
    property CSSs: string read FCSSs;
    property Desc: string read FDesc;
    property Srcs: string read FSrcs;
  end;
  {$ENDIF}

  TAdvChartCustomDesignerForm = class(TForm);

  TAdvChartCustomControl = class;

  TAdvControlAlignment = (caNone, caTop, caBottom, caLeft, caRight, caClient);

  {$IFDEF FNCLIB}
  {$IFNDEF WEBLIB}
  TAdvChartCustomControlShortCutWindowList = TObjectList<TAdvHint>;
  {$ENDIF}
  {$ENDIF}

  {$IFDEF FMXLIB}
  TAdvChartCustomControlBaseCommon = class(TControl, IAdvAdaptToStyle, IAdvProductInfo {$IFDEF FNCLIB}, IAdvShortCutHint{$ENDIF})
  {$ENDIF}
  {$IFDEF CMNWEBLIB}
  TAdvChartCustomControlBaseCommon = class({$IFDEF WEBLIB}TWebCustomControl{$ELSE}TCustomControl{$ENDIF}, IAdvAdaptToStyle, IAdvProductInfo {$IFNDEF WEBLIB}{$IFDEF FNCLIB}, IAdvShortCutHint{$ENDIF}{$ENDIF}) {NOPP}
  {$ENDIF}
  private
    {$IFDEF FMXLIB}
    {$IFDEF MSWINDOWS}
    FMessageHandler: HWND;
    {$ENDIF}
    {$ENDIF}
    FResourceScaleFactor: Single;
    FPaintScaleFactor: Single;
    FDesigntimeFormPixelsPerInch: Integer;
    {$IFDEF CMNWEBLIB}
    FAllowFocus: Boolean;
    {$ENDIF}
    {$IFDEF FNCLIB}
    FShortCutHint: string;
    {$IFNDEF WEBLIB}
    FShortCutLimitation: string;
    FShortCutWindowList: TAdvChartCustomControlShortCutWindowList;
    {$ENDIF}
    {$ENDIF}
    FAllowGetChildren: Boolean;
    FAdaptToStyle: Boolean;
    FAdaptedToStyle: Boolean;
    FTransparent: Boolean;
    FBufferedPainting: Boolean;
    FNativeCanvas: Boolean;
    FAntiAliasing: Boolean;
    FOptimizedHTMLDrawing: Boolean;
    FShowAcceleratorChar: Boolean;
    FTextQuality: TAdvChartGraphicsTextQuality;
    FOnInternalDblClick: TNotifyEvent;
    FOnInternalMouseDown: TNotifyEvent;
    FOnInternalMouseMove: TNotifyEvent;
    FOnInternalMouseUp: TNotifyEvent;
    function GetAllowFocus: Boolean;
    {$IFDEF FNCLIB}
    function GetShortCutHint: string;
    {$ENDIF}
    function GetControlAlignment: TAdvControlAlignment;
    procedure SetAllowFocus(const Value: Boolean);
    procedure SetControlAlignment(const Value: TAdvControlAlignment);
    procedure SetAntiAliasing(const Value: Boolean);
    procedure SetOptimizedHTMLDrawing(const Value: Boolean);
    procedure SetShowAcceleratorChar(const Value: Boolean);
    procedure SetNativeCanvas(const Value: Boolean);
    procedure SetTextQuality(const Value: TAdvChartGraphicsTextQuality);
    {$IFDEF FNCLIB}
    procedure SetShortCutHint(const Value: string);
    {$ENDIF}
  protected
    function GetVersion: string; virtual;
    function GetDocURL: string; virtual;
    function GetTipsURL: string; virtual;
    function HandleDesignHitTest(const APoint: TPoint): Boolean; virtual;
    function GetClientMousePos: TPointF; virtual;
    function ConvertScreenToClient(APoint: TPointF): TPointF; virtual;
    function ConvertClientToScreen(APoint: TPointF): TPointF; virtual;
    function GetDragObjectScreenShot: TAdvChartBitmap; virtual;
    function GetAdaptToStyle: Boolean; virtual;
    {$IFDEF FMXLIB}
    procedure SetEnabled(const Value: Boolean); override;
    {$ENDIF}
    {$IFNDEF FMXLIB}
    procedure SetEnabled(Value: Boolean); override;
    {$ENDIF}
    {$IFDEF FNCLIB}
    {$IFNDEF WEBLIB}
    function HasShortCut(AShortCut: string): Boolean; virtual;
    function HandleShortCut(AShortCut: string): Boolean; virtual;
    function ExecuteShortCutMethod(AShortCut: string): Boolean; virtual;
    function IsShortCutHintActive: Boolean; virtual;
    {$ENDIF}
    {$ENDIF}
    {$IFDEF FMXLIB}
    procedure SetParent(const Value: TFmxObject); override;
    procedure Loaded; override;
    {$ENDIF}
    procedure CalcFactor;
    procedure ChangeDPIScale({%H-}M, {%H-}D: Integer); virtual;
    procedure DestroyGraphicElements; virtual; abstract;
    procedure SetDefaultGraphicColors; virtual;
    procedure SetAdaptToStyle(const Value: Boolean); virtual;
    procedure CancelHint; virtual;
    procedure BeginDrag; virtual;
    procedure InitializeStyle;
    procedure ApplyStyle; virtual;
    procedure ResetToDefaultStyle; virtual;
    procedure HandleMouseLeave; virtual;
    procedure HandleMouseEnter; virtual;
    procedure HandleMouseDown({%H-}Button: TAdvMouseButton; {%H-}Shift: TShiftState; {%H-}X, {%H-}Y: Single); virtual;
    procedure HandleMouseMove({%H-}Shift: TShiftState; {%H-}X, {%H-}Y: Single); virtual;
    procedure HandleDblClick({%H-}X, {%H-}Y: Single); virtual;
    procedure HandleMouseUp({%H-}Button: TAdvMouseButton; {%H-}Shift: TShiftState; {%H-}X, {%H-}Y: Single); virtual;
    procedure HandleKeyPress(var {%H-}Key: Char); virtual;
    {$IFDEF LCLLIB}
    procedure HandleUTF8KeyPress(var {%$H-}UTF8Key: TUTF8Char); virtual;
    {$ENDIF}
    procedure HandleKeyDown(var {%H-}Key: Word; {%H-}Shift: TShiftState); virtual;
    procedure HandleDialogKey(var {%H-}Key: Word; {%H-}Shift: TShiftState); virtual;
    procedure HandleKeyUp(var {%H-}Key: Word; {%H-}Shift: TShiftState); virtual;
    procedure HandleMouseWheel({%H-}Shift: TShiftState; {%H-}WheelDelta: Integer; var {%H-}Handled: Boolean); virtual;
    procedure HandleDragOver(const {%H-}Source: TObject; const {%H-}Point: TPointF; var {%H-}Accept: Boolean); virtual;
    procedure HandleDragDrop(const {%H-}Source: TObject; const {%H-}Point: TPointF); virtual;
    {$IFDEF FNCLIB}
    {$IFNDEF WEBLIB}
    procedure GetShortCutHints(AShortCutHints: TStringList); virtual;
    procedure ShowShortCutHint; virtual;
    procedure CustomizeShortCut({%H-}AShortCutWindow: TAdvHint; {%H-}AShortCut: string; {%H-}AShortCutRect: TRectF; var {%H-}AShortCutPosition: TPointF); virtual;
    procedure CancelShortCutHint(AClearShortCutHintString: Boolean = True); virtual;
    {$ENDIF}
    {$ENDIF}
    property AdaptToStyle: Boolean read GetAdaptToStyle write SetAdaptToStyle default False;
    property Transparent: Boolean read FTransparent write FTransparent default False;
    property BufferedPainting: Boolean read FBufferedPainting write FBufferedPainting default False;
    property NativeCanvas: Boolean read FNativeCanvas write SetNativeCanvas default False;
    property AntiAliasing: Boolean read FAntiAliasing write SetAntiAliasing default True;
    property OptimizedHTMLDrawing: Boolean read FOptimizedHTMLDrawing write SetOptimizedHTMLDrawing default True;
    property ShowAcceleratorChar: Boolean read FShowAcceleratorChar write SetShowAcceleratorChar default True;
    property TextQuality: TAdvChartGraphicsTextQuality read FTextQuality write SetTextQuality default gtqAntiAliasing;
    property OnInternalMouseDown: TNotifyEvent read FOnInternalMouseDown write FOnInternalMouseDown;
    property OnInternalMouseUp: TNotifyEvent read FOnInternalMouseUp write FOnInternalMouseUp;
    property OnInternalMouseMove: TNotifyEvent read FOnInternalMouseMove write FOnInternalMouseMove;
    property OnInternalDblClick: TNotifyEvent read FOnInternalDblClick write FOnInternalDblClick;
    {$IFDEF FNCLIB}
    property ShortCutHint: string read GetShortCutHint write SetShortCutHint;
    {$ENDIF}
    property AllowGetChildren: Boolean read FAllowGetChildren write FAllowGetChildren default False;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property AllowFocus: Boolean read GetAllowFocus write SetAllowFocus default True;
    property Canvas;
    property ControlAlignment: TAdvControlAlignment read GetControlAlignment write SetControlAlignment default caNone;
    procedure SetControlMargins(ALeft, ATop, ARight, ABottom: Single);
    procedure GetControlMargins(var ALeft, ATop, ARight, ABottom: Single);

    function ScaleResourceValue(const Value: Integer): Integer; overload;
    function ScaleResourceValue(const Value: Double): Double; overload;

    function ScalePaintValue(const Value: Integer): Integer; overload;
    function ScalePaintValue(const Value: Double): Double; overload;

    property ResourceScaleFactor: Single read FResourceScaleFactor;
    property PaintScaleFactor: Single read FPaintScaleFactor;
    property DesigntimeFormPixelsPerInch: Integer read FDesigntimeFormPixelsPerInch;

    {$IFDEF FMXLIB}
    procedure SetBounds(X, Y, AWidth, AHeight: Single); override;
    {$ENDIF}
  end;

  {$IFDEF FMXLIB}
  TAdvChartCustomControlBase = class(TAdvChartCustomControlBaseCommon)
  private
    FStyleChangedId: Integer;
    function GetL: Single;
    function GetT: Single;
    procedure SetTop(const Value: Single);
    procedure SetLeft(const Value: Single);
  protected
    procedure StyleChangedHandler(const Sender: TObject; const Msg: TMessage); virtual;
    procedure DoMouseEnter; override;
    procedure DoMouseLeave; override;
    procedure DragOver(const Data: TDragObject; const Point: TPointF; var Operation: TDragOperation); override;
    procedure DragDrop(const Data: TDragObject; const Point: TPointF); override;
    procedure MouseDown(Button: TAdvMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Single); override;
    procedure MouseUp(Button: TAdvMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure KeyDown(var Key: Word; var KeyChar: WideChar; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; var KeyChar: WideChar; Shift: TShiftState); override;
    procedure DialogKey(var Key: Word; Shift: TShiftState); override;
    procedure MouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean); override;
    procedure DblClick; override;
    {$HINTS OFF}
    {$IF COMPILERVERSION < 30}
    function GetHintString: String; virtual;
    function HasHint: Boolean; virtual;
    {$IFEND}
    {$IF COMPILERVERSION = 28}
    procedure BeginUpdate; virtual;
    procedure EndUpdate; virtual;
    {$IFEND}
    {$HINTS ON}
  public
    property Left: Single read GetL write SetLeft;
    property Top: Single read GetT write SetTop;
    procedure Invalidate; virtual;
    procedure SetNewScene(AScene: IScene); override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;
  {$ENDIF}

  {$IFDEF CMNWEBLIB}
  TAdvChartCustomControlBase = class(TAdvChartCustomControlBaseCommon)
  private
    FStored: Boolean;
    FHitTest: Boolean;
    {$IFDEF VCLLIB}
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMMouseWheel(var Message: TWMMouseWheel); message WM_MOUSEWHEEL;
    procedure WMEraseBkGnd(var Message: TWMEraseBkGnd); message WM_ERASEBKGND;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMFocusChanged(var Message: TCMFocusChanged); message CM_FOCUSCHANGED;
    procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST;
    {$HINTS OFF}
    {$IF COMPILERVERSION > 22}
    procedure CMStyleChanged(var Message: TMessage); message CM_STYLECHANGED;
    {$IFEND}
    {$HINTS ON}
    {$ENDIF}
    {$IFDEF LCLLIB}
    procedure WMGetDlgCode(var {%H-}Message: TLMNoParams); message LM_GETDLGCODE;
    {$IFDEF MSWINDOWS}
    procedure WMEraseBkGnd(var {%H-}Message: TLMEraseBkGnd); message LM_ERASEBKGND;
    procedure WMPaint(var {%H-}Message: TLMPaint); message LM_PAINT;
    {$ENDIF}
    procedure WMMouseWheel(var {%H-}Message: TLMMouseEvent); message LM_MOUSEWHEEL;
    procedure CMMouseLeave(var {%H-}Message: TLMNoParams); message CM_MOUSELEAVE;
    procedure CMMouseEnter(var {%H-}Message: TLMNoParams); message CM_MOUSEENTER;
    procedure CMFocusChanged(var {%H-}Message: TLMessage); message CM_FOCUSCHANGED;
    procedure CMHintShow(var {%H-}Message: TLMessage); message CM_HINTSHOW;
    procedure WMNCHitTest(var Message: TLMessage) ; message LM_NCHITTEST;
    {$HINTS OFF}
    {$IF FPC_FULLVERSION < 30000}
    procedure WMLButtonDBLCLK(var Message: TLMLButtonDblClk); message LM_LBUTTONDBLCLK;
    {$IFEND}
    {$HINTS ON}
    {$ENDIF}
    {$IFDEF WEBLIB}
    procedure MouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean); override;
    procedure DoMouseLeave; override;
    procedure DoMouseEnter; override;
    {$ENDIF}
  protected
    function GetLocalRect: TRectF; virtual;
    function GetHintString: String; virtual;
    function HasHint: Boolean; virtual;
    procedure MouseDown(Button: TAdvMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TAdvMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    {$IFDEF LCLLIB}
    procedure UTF8KeyPress(var UTF8Key: TUTF8Char); override;
    {$ENDIF}
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure DblClick; override;
    {$IFDEF VCLLIB}
    {$HINTS OFF}
    {$IF COMPILERVERSION > 30}
    procedure ChangeScale(M, D: Integer; isDpiChange: Boolean); override;
    {$ELSE}
    procedure ChangeScale(M, D: Integer); override;
    {$IFEND}
    {$HINTS ON}
    {$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    {$IFDEF WEBLIB}
    procedure BeginUpdate; override;
    procedure EndUpdate; override;
    {$ENDIF}
    {$IFNDEF WEBLIB}
    procedure BeginUpdate; virtual;
    procedure EndUpdate; virtual;
    {$ENDIF}
    procedure DragDrop(Source: TObject; X, Y: Integer); override;
    function CanFocus: Boolean; override;
    property LocalRect: TRectF read GetLocalRect;
    property Stored: Boolean read FStored write FStored default True;
    property HitTest: Boolean read FHitTest write FHitTest default True;
  end;
  {$ENDIF}

  TAdvChartCustomControlBeforeDrawEvent = procedure(Sender: TObject; AGraphics: TAdvChartGraphics; ARect: TRectF; var ADefaultDraw: Boolean) of object;
  TAdvChartCustomControlAfterDrawEvent = procedure(Sender: TObject; AGraphics: TAdvChartGraphics; ARect: TRectF) of object;
  TAdvChartCustomControlCanSavePropertyEvent = procedure(Sender: TObject; AObject: TObject; APropertyName: string; APropertyType: TTypeKind; var ACanSave: Boolean) of object;
  TAdvChartCustomControlCanLoadPropertyEvent = procedure(Sender: TObject; AObject: TObject; APropertyName: string; APropertyType: TTypeKind; var ACanLoad: Boolean) of object;

  TAdvChartCustomControl = class(TAdvChartCustomControlBase, IAdvChartGraphicsExport, IAdvChartPersistence)
  private
    class var FBlockPersistenceInterface: Boolean;
  private
    FBlockInvalidate: Boolean;
    FAppearancePersisting: Boolean;
    FExporting: Boolean;
    FExportRect: TRectF;
    FOnBeforeDraw: TAdvChartCustomControlBeforeDrawEvent;
    FOnAfterDraw: TAdvChartCustomControlAfterDrawEvent;
    FOnCanSaveProperty: TAdvChartCustomControlCanSavePropertyEvent;
    FOnCanLoadProperty: TAdvChartCustomControlCanLoadPropertyEvent;
    {$IFDEF FMXLIB}
    FColor: TAdvChartGraphicsColor;
    {$ENDIF}
    FCheckedChk, FUnCheckedChk, FCheckedFocusChk, FUnCheckedFocusChk, FCheckedDisabledChk, FUnCheckedDisabledChk: TAdvChartBitmapHelperClass;
    FCheckedRd, FUnCheckedRd, FCheckedFocusRd, FUnCheckedFocusRd, FCheckedDisabledRd, FUnCheckedDisabledRd: TAdvChartBitmapHelperClass;
    FDownBtn, FNormalBtn, FDownFocusBtn, FNormalFocusBtn, FNormalDisabledBtn: TAdvChartBitmapHelperClass;
    FFill: TAdvChartGraphicsFill;
    FStroke: TAdvChartGraphicsStroke;
    FDataPointer: Pointer;
    FDataBoolean: Boolean;
    FDataString: String;
    FDataObject: TObject;
    FDataInteger: NativeInt;
    FUndoManager: TAdvChartUndoManager;
    function GetUndoManager: TAdvChartUndoManager;
    procedure SetFill(const Value: TAdvChartGraphicsFill);
    procedure SetStroke(const Value: TAdvChartGraphicsStroke);
    {$IFDEF FMXLIB}
    procedure SetColor(const Value: TAdvChartGraphicsColor);
    {$ENDIF}
  protected
    {$IFDEF WEBLIB}
    class function GetVersionNumber(AMaj, AMin, ARel, ABld: ShortInt): string;
    {$ENDIF}
    function IsAppearanceProperty({%H-}AObject: TObject; {%H-}APropertyName: string; {%H-}APropertyType: TTypeKind): Boolean; virtual;
    function CanSaveProperty({%H-}AObject: TObject; {%H-}APropertyName: string; {%H-}APropertyType: TTypeKind): Boolean; virtual;
    function CanLoadProperty({%H-}AObject: TObject; {%H-}APropertyName: string; {%H-}APropertyType: TTypeKind): Boolean; virtual;
    function GetVersion: string; override;
    function LocalToScreenEx(APoint: TPointF): TPointF; virtual;
    function ScreenToLocalEx(APoint: TPointF): TPointF; virtual;
    function GetContentRect: TRectF; virtual;
    function GetControlRect: TRectF; virtual;
    function GetLocalRect: TRectF; override;
    function IsExporting: Boolean; virtual;
    {$IFDEF CMNLIB}
    function GetTransparentColor: TAdvChartGraphicsColor; virtual;
    {$ENDIF}
    {$IFDEF WEBLIB}
    procedure SetColor(AValue: TColor); override;
    {$ENDIF}
    procedure ChangeDPIScale({%H-}M, {%H-}D: Integer); override;
    procedure RegisterRuntimeClasses; virtual;
    procedure &Export({%H-}AGraphics: TAdvChartGraphics; {%H-}ARect: TRectF); virtual;
    procedure BeforeExport; virtual;
    procedure AfterExport; virtual;
    procedure ApplyStyle; override;
    procedure ResetToDefaultStyle; override;
    procedure DestroyGraphicElements; override;
    {$IFDEF FMXLIB}
    procedure TurnOffAnimation(chk: TFmxObject); virtual;
    {$ENDIF}
    {$IFDEF LCLLIB}
    procedure DoSetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    {$ENDIF}
    {$IFDEF VCLLIB}
    procedure CreateWnd; override;
    {$ENDIF}
    procedure UpdateControlAfterResize; virtual;
    procedure CreateCheckBoxBitmaps; virtual;
    procedure CreateRadioButtonBitmaps; virtual;
    procedure CreateButtonBitmaps(AWidth, AHeight: Single); virtual;
    procedure DoBeforeDraw(AGraphics: TAdvChartGraphics; ARect: TRectF; var ADefaultDraw: Boolean); virtual;
    procedure DoAfterDraw(AGraphics: TAdvChartGraphics; ARect: TRectF); virtual;
    procedure DoCanSaveProperty(AObject: TObject; APropertyName: string; APropertyType: TTypeKind; var ACanSave: Boolean); virtual;
    procedure DoCanLoadProperty(AObject: TObject; APropertyName: string; APropertyType: TTypeKind; var ACanLoad: Boolean); virtual;
    procedure DrawBackground(AGraphics: TAdvChartGraphics; {%H-}ARect: TRectF); virtual;
    procedure StrokeChanged(Sender: TObject);
    procedure FillChanged(Sender: TObject);
    procedure Draw({%H-}AGraphics: TAdvChartGraphics; {%H-}ARect: TRectF); virtual;
    procedure DrawControl; virtual;
    procedure DoBitmapChanged(Sender: TObject);
    {$IFDEF DRAWTRIAL}
    {$IFDEF FREEWARE}
    procedure DrawTrial(AGraphics: TAdvChartGraphics; {%H-}ARect: TRectF); virtual;
    {$ENDIF}
    {$ENDIF}
    property Fill: TAdvChartGraphicsFill read FFill write SetFill;
    property Stroke: TAdvChartGraphicsStroke read FStroke write SetStroke;
    procedure CaptureEx; virtual;
    procedure ReleaseCaptureEx; virtual;
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetCheckBoxBitmap(AChecked: Boolean = False; AFocused: Boolean = False; AEnabled: Boolean = True): TAdvChartBitmapHelperClass; virtual;
    function GetRadioButtonBitmap(AChecked: Boolean = False; AFocused: Boolean = False; AEnabled: Boolean = True): TAdvChartBitmapHelperClass; virtual;
    function GetButtonBitmap(AWidth, AHeight: Single; ADown: Boolean = False; AFocused: Boolean = False; AEnabled: Boolean = True): TAdvChartBitmapHelperClass; virtual;
    function IsDesignTime: Boolean; virtual;
    function IsLoading: Boolean; virtual;
    function IsReading: Boolean; virtual;
    function IsDesigning: Boolean; virtual;
    function IsDesignerForm: Boolean; virtual;
    function IsDestroying: Boolean; virtual;
    procedure SaveSettingsToFile(AFileName: string; AAppearanceOnly: Boolean = False); virtual;
    procedure LoadSettingsFromFile(AFileName: string); virtual;
    procedure SaveSettingsToStream(AStream: TStreamEx; AAppearanceOnly: Boolean = False); virtual;
    procedure LoadSettingsFromStream(AStream: TStreamEx); virtual;
    procedure DisableBackground;
    procedure EnableBackground;
    procedure DisableFill;
    procedure EnableFill;
    procedure DisableStroke;
    procedure EnableStroke;
    procedure Resize; override;
    procedure Paint; override;
    property DataPointer: Pointer read FDataPointer write FDataPointer;
    property DataBoolean: Boolean read FDataBoolean write FDataBoolean;
    property DataObject: TObject read FDataObject write FDataObject;
    property DataString: String read FDataString write FDataString;
    property DataInteger: NativeInt read FDataInteger write FDataInteger;
    property UndoManager: TAdvChartUndoManager read GetUndoManager;
    class property BlockPersistenceInterface: Boolean read FBlockPersistenceInterface write FBlockPersistenceInterface;
    property BlockInvalidate: Boolean read FBlockInvalidate write FBlockInvalidate;
  published
    property AdaptToStyle;
    property AllowFocus default True;
    {$IFDEF FMXLIB}
    property Anchors;
    property Hint;
    property ShowHint;
    property Color: TAdvChartGraphicsColor read FColor write SetColor default gcWhite;
    property Align;
    property CanParentFocus;
    property ClipChildren default True;
    property ClipParent default False;
    property DisableFocusEffect default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Height;
    property HitTest default True;
    property Locked default False;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    {$HINTS OFF}
    {$IF COMPILERVERSION > 27}
    property Size;
    {$IFEND}
    {$HINTS ON}
    property TabOrder;
    property TabStop default True;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;
    property OnApplyStyleLookup;
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    property OnKeyDown;
    property OnKeyUp;
    property OnCanFocus;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnResize;
    {$ENDIF}

    {$IFDEF CMNLIB}
    property Align;
    {$IFDEF LCLLIB}
    property BorderSpacing;
    {$ENDIF}
    {$IFNDEF LCLLIB}
    property BevelEdges;
    property BevelInner;
    property BevelKind;
    property BevelOuter;
    property BevelWidth;
    property Ctl3D;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    {$HINTS OFF}
    {$IF COMPILERVERSION > 23}
    property StyleElements;
    {$IFEND}
    {$HINTS ON}
    property Touch;
    property OnGesture;
    property OnMouseActivate;
    {$ENDIF}
    property Anchors;
    property BiDiMode;
    property Color default gcWhite;
    property Constraints;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property TabStop default True;
    property ParentBiDiMode;
    property ParentColor default False;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Hint;
    property TabOrder;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnStartDock;
    property OnStartDrag;
    {$ENDIF}
    {$IFDEF WEBLIB}
    property Align;
    property AlignWithMargins;
    property DoubleBuffered;
    property Color;
    property Margins;
    property Enabled;
    property Font;
    property ParentDoubleBuffered;
    property TabStop;
    property ShowHint;
    property Hint;
    property TabOrder;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelUp;
    property OnMouseWheelDown;
    property OnDragOver;
    property OnDragDrop;
    property PopupMenu;
    {$ENDIF}
    property ShowAcceleratorChar;
    property OnBeforeDraw: TAdvChartCustomControlBeforeDrawEvent read FOnBeforeDraw write FOnBeforeDraw;
    property OnAfterDraw: TAdvChartCustomControlAfterDrawEvent read FOnAfterDraw write FOnAfterDraw;
    property OnCanSaveProperty: TAdvChartCustomControlCanSavePropertyEvent read FOnCanSaveProperty write FOnCanSaveProperty;
    property OnCanLoadProperty: TAdvChartCustomControlCanLoadPropertyEvent read FOnCanLoadProperty write FOnCanLoadProperty;
  end;

  TAdvChartCustomControlClass = class of TAdvChartCustomControl;

  TAdvControl = class(TAdvChartCustomControl)
  protected
    procedure RegisterRuntimeClasses; override;
  end;

implementation

uses
  AdvChartUtils, SysUtils
  {$IFNDEF LCLLIB}
  ,StdCtrls
  {$ENDIF}
  {$IFDEF VCLSTYLESENABLED}
  ,VCL.Themes
  {$ENDIF}
  {$IFDEF FMXLIB}
  ,FMX.Platform, FMX.Ani
  {$ENDIF}
  {$IFDEF VCLLIB}
  ,AdvChartXPVS
  {$ENDIF}
  {$IFDEF USETRIAL}
  {$IFNDEF LCLLIB}
  {$IFNDEF WEBLIB}
  {$IFNDEF FMXMOBILE}
  {$IFDEF FREEWARE}
  {$IFDEF MSWINDOWS}
  ,System.Win.Registry, WinApi.ShellApi
  {$ENDIF}
  {$IFDEF MACOS}
  ,MacApi.AppKit, MacApi.Foundation, MacApi.Helpers
  {$ENDIF}
  {$IFDEF FMXLIB}
  ,FMX.Objects, UIConsts
  {$ENDIF}
  {$IFDEF VCLLIB}
  ,ExtCtrls
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}
  ;

{$IFDEF CMNLIB}
type
  TWinControlProtected = class(TWinControl)
  public
    procedure PaintCtrls(DC: HDC; First: TControl);
  end;
{$ENDIF}

{$IFDEF CMNLIB}
function CreateShiftStateEx: TShiftState;
begin
  Result := [];
  if GetKeyState(VK_SHIFT) < 0 then
    Include(Result, ssShift);
  if GetKeyState(VK_CONTROL) < 0 then
    Include(Result, ssCtrl);
  if GetKeyState(VK_MENU) < 0 then
    Include(Result, ssAlt);
end;
{$ENDIF}

{ TAdvChartCustomControlBaseCommon }

procedure TAdvChartCustomControlBaseCommon.SetAdaptToStyle(const Value: Boolean);
begin
  FAdaptToStyle := Value;
  InitializeStyle;
end;

{$IFDEF FMXLIB}
procedure TAdvChartCustomControlBaseCommon.Loaded;
begin
  CalcFactor;
  inherited;
end;

procedure TAdvChartCustomControlBaseCommon.SetBounds(X, Y, AWidth, AHeight: Single);
begin
  CalcFactor;
  inherited;
end;

procedure TAdvChartCustomControlBaseCommon.SetParent(const Value: TFmxObject);
begin
  CalcFactor;
  inherited;
end;
{$ENDIF}

procedure TAdvChartCustomControlBaseCommon.CalcFactor;
begin
  FResourceScaleFactor := TAdvChartUtils.GetDPIScale(Self, 96);
  {$IFDEF FMXLIB}
  FPaintScaleFactor := 1.0;
  {$ELSE}
  FPaintScaleFactor := FResourceScaleFactor;
  {$ENDIF}
end;

procedure TAdvChartCustomControlBaseCommon.ChangeDPIScale(M, D: Integer);
begin

end;

function TAdvChartCustomControlBaseCommon.GetAdaptToStyle: Boolean;
begin
  Result := FAdaptToStyle;
end;

procedure TAdvChartCustomControlBaseCommon.ApplyStyle;
begin

end;

procedure TAdvChartCustomControlBaseCommon.ResetToDefaultStyle;
begin

end;

procedure TAdvChartCustomControlBaseCommon.SetDefaultGraphicColors;
var
  c: TAdvChartGraphicsColor;
begin
  c := gcNull;
  if TAdvChartStyles.GetStyleBackgroundFillColor(c) then
    TAdvChartGraphics.DefaultPopupFillColor := c
  else
    TAdvChartGraphics.DefaultPopupFillColor := gcWhite;

  c := gcNull;
  if TAdvChartStyles.GetStyleBackgroundStrokeColor(c) then
    TAdvChartGraphics.DefaultPopupStrokeColor := c
  else
    TAdvChartGraphics.DefaultPopupStrokeColor := gcSilver;

  c := gcNull;
  if TAdvChartStyles.GetStyleDefaultButtonFillColor(c) then
    TAdvChartGraphics.DefaultButtonFillColor := c
  else
    TAdvChartGraphics.DefaultButtonFillColor := MakeGraphicsColor(225, 225, 225);

  c := gcNull;
  if TAdvChartStyles.GetStyleLineFillColor(c) then
    TAdvChartGraphics.DefaultButtonStrokeColor := c
  else
    TAdvChartGraphics.DefaultButtonStrokeColor := gcDarkgray;

  c := gcNull;
  if TAdvChartStyles.GetStyleTextFontColor(c) then
    TAdvChartGraphics.DefaultTextFontColor := c
  else
    TAdvChartGraphics.DefaultTextFontColor := gcBlack;

  c := gcNull;
  if TAdvChartStyles.GetStyleSelectionFillColor(c) then
  begin
    TAdvChartGraphics.DefaultSelectionFillColor := c;
    TAdvChartGraphics.DefaultButtonFillColorFocused := Blend(c, TAdvChartGraphics.DefaultButtonFillColor, 25);
    TAdvChartGraphics.DefaultButtonStrokeColorFocused := Blend(c, TAdvChartGraphics.DefaultButtonStrokeColor, 30);
  end
  else
  begin
    TAdvChartGraphics.DefaultSelectionFillColor := gcBlack;
    TAdvChartGraphics.DefaultButtonFillColorFocused := MakeGraphicsColor(229, 241, 251);
    TAdvChartGraphics.DefaultButtonStrokeColorFocused := MakeGraphicsColor(60, 127, 177);
  end;

  TAdvChartGraphics.DefaultButtonStrokeColorDisabled := gcDarkGray;
  TAdvChartGraphics.DefaultButtonFillColorDisabled := gcLightgray;
end;

procedure TAdvChartCustomControlBaseCommon.InitializeStyle;
begin
  {$IFDEF FMXLIB}
  TAdvChartStyles.SetActiveScene(Scene);
  {$ENDIF}
  SetDefaultGraphicColors;
  DestroyGraphicElements;
  if AdaptToStyle then
  begin
    FAdaptedToStyle := True;
    ApplyStyle;
  end
  else if FAdaptedToStyle then
  begin
    ResetToDefaultStyle;
    FAdaptedToStyle := False;
  end;

  Invalidate;
end;

function TAdvChartCustomControlBaseCommon.GetVersion: string;
begin
  Result := '';
end;

function TAdvChartCustomControlBaseCommon.GetDocURL: string;
begin
  Result := TAdvChartBaseDocURL;
end;

function TAdvChartCustomControlBaseCommon.HandleDesignHitTest(const APoint: TPoint): Boolean;
begin
  Result := False;
end;

function TAdvChartCustomControlBaseCommon.GetTipsURL: string;
begin
  Result := TAdvChartBaseTipsURL;
end;

function TAdvChartCustomControlBaseCommon.GetClientMousePos: TPointF;
begin
  Result := ConvertScreenToClient(TAdvChartUtils.GetMousePos);
end;

{$IFDEF CMNWEBLIB}
function TAdvChartCustomControlBaseCommon.ConvertClientToScreen(APoint: TPointF): TPointF;
var
  p: TPoint;
begin
  p := ClientToScreen(Point(Round(APoint.X), Round(APoint.Y)));
  Result := PointF(p.X, p.Y);
end;
{$ENDIF}

{$IFDEF FMXLIB}
function TAdvChartCustomControlBaseCommon.ConvertClientToScreen(APoint: TPointF): TPointF;
begin
  Result := LocalToScreen(APoint);
end;
{$ENDIF}

{$IFDEF CMNWEBLIB}
function TAdvChartCustomControlBaseCommon.ConvertScreenToClient(APoint: TPointF): TPointF;
var
  p: TPoint;
begin
  p := ScreenToClient(Point(Round(APoint.X), Round(APoint.Y)));
  Result := PointF(p.X, p.Y);
end;
{$ENDIF}

{$IFDEF FMXLIB}
function TAdvChartCustomControlBaseCommon.ConvertScreenToClient(APoint: TPointF): TPointF;
begin
  Result := ScreenToLocal(APoint);
end;
{$ENDIF}

constructor TAdvChartCustomControlBaseCommon.Create(AOwner: TComponent);
var
  ppi: Integer;
{$IFDEF VCLLIB}
{$HINTS OFF}
{$IF COMPILERVERSION > 34}
  f: TCustomForm;
{$IFEND}
{$HINTS ON}
{$ENDIF}
begin
  inherited;
  ppi := 96;
  {$IFDEF VCLLIB}
  {$HINTS OFF}
  {$IF COMPILERVERSION > 34}
  f := TAdvChartUtils.GetOwnerForm(Self);
  if Assigned(f) then
    ppi := f.PixelsPerInch;
  {$IFEND}
  {$HINTS ON}
  {$ENDIF}

  FDesigntimeFormPixelsPerInch := ppi;

  FPaintScaleFactor := 1.0;
  FResourceScaleFactor := 1.0;
  {$IFDEF FNCLIB}
  {$IFNDEF WEBLIB}
  FShortCutWindowList := TAdvChartCustomControlShortCutWindowList.Create;
  {$ENDIF}
  {$ENDIF}
  SetDefaultGraphicColors;
  FAdaptToStyle := False;
  FAdaptedToStyle := False;
  FTransparent := False;
  FNativeCanvas := False;
  FBufferedPainting := False;
  FAntiAliasing := True;
  FOptimizedHTMLDrawing := True;
  FShowAcceleratorChar := True;
  FTextQuality := gtqAntiAliasing;
  {$IFDEF CMNWEBLIB}
  FAllowFocus := True;
  {$ENDIF}
end;

destructor TAdvChartCustomControlBaseCommon.Destroy;
begin
  {$IFDEF FNCLIB}
  {$IFNDEF WEBLIB}
  CancelShortCutHint;
  FShortCutWindowList.Free;
  {$ENDIF}
  {$ENDIF}

  {$IFDEF FMXLIB}
  {$IFDEF MSWINDOWS}
  DeallocateHWnd(FMessageHandler);
  {$ENDIF}
  {$ENDIF}
  inherited;
end;

function TAdvChartCustomControlBaseCommon.GetAllowFocus: Boolean;
begin
  {$IFDEF FMXLIB}
  Result := CanFocus;
  {$ENDIF}
  {$IFDEF CMNWEBLIB}
  Result := FAllowFocus;
  {$ENDIF}
end;

procedure TAdvChartCustomControlBaseCommon.SetAllowFocus(const Value: Boolean);
begin
  {$IFDEF FMXLIB}
  CanFocus := Value;
  {$ENDIF}
  {$IFDEF CMNWEBLIB}
  FAllowFocus := Value;
  {$ENDIF}
end;

{$IFDEF FNCLIB}
function TAdvChartCustomControlBaseCommon.GetShortCutHint: string;
begin
  Result := FShortCutHint;
end;

procedure TAdvChartCustomControlBaseCommon.SetShortCutHint(const Value: string);
begin
  FShortCutHint := Value;
end;

{$IFNDEF WEBLIB}
function TAdvChartCustomControlBaseCommon.IsShortCutHintActive: Boolean;
begin
  Result := FShortCutWindowList.Count > 0;
end;

procedure TAdvChartCustomControlBaseCommon.CancelShortCutHint(AClearShortCutHintString: Boolean = True);
begin
  FShortCutWindowList.Clear;
  if AClearShortCutHintString then
    FShortCutLimitation := '';
end;

procedure TAdvChartCustomControlBaseCommon.CustomizeShortCut(AShortCutWindow: TAdvHint; AShortCut: string; AShortCutRect: TRectF; var AShortCutPosition: TPointF);
begin

end;

procedure TAdvChartCustomControlBaseCommon.GetShortCutHints(AShortCutHints: TStringList);
begin
  AShortCutHints.Add(ShortCutHint);
end;

procedure TAdvChartCustomControlBaseCommon.ShowShortCutHint;
var
  pt: TPointF;
  r: TRect;
  I: Integer;
  h: TAdvHint;
  s: string;
  l: TStringList;
begin
  CancelShortCutHint(False);
  l := TStringList.Create;
  try
    GetShortCutHints(l);

    for I := 0 to l.Count - 1 do
    begin
      s := l[I];
      if (s <> '') and ((Pos(FShortCutLimitation, s) > 0) or (FShortCutLimitation = '')) then
      begin
        h := TAdvHint.Create(Self);
        r := h.Calculate(s);
        pt := PointF((Width - (r.Right - r.Left)) / 2, Height - (r.Bottom - r.Top) / 2);
        CustomizeShortCut(h, s, ConvertToRectF(r), pt);
        pt := ConvertClientToScreen(pt);
        h.ShowHintAt(s, Round(pt.X), Round(pt.Y));
        FShortCutWindowList.Add(h);
      end;
    end;
  finally
    l.Free;
  end;
end;

function TAdvChartCustomControlBaseCommon.ExecuteShortCutMethod(AShortCut: String): Boolean;
begin
  Result := False;
  if AShortCut = ShortCutHint then
  begin
    Click;
    Result := True;
  end;
end;

function TAdvChartCustomControlBaseCommon.HasShortCut(AShortCut: string): Boolean;
var
  sl: TStringList;
  i: Integer;
  s: string;
begin
  Result := False;
  sl := TStringList.Create;
  try
    GetShortCutHints(sl);
    for I := 0 to sl.Count - 1 do
    begin
      s := sl[I];
      if (s <> '') and ((Pos(AShortCut, s) = 1) or (AShortCut = '')) then
      begin
        Result := True;
        Break;
      end;
    end;
  finally
    sl.Free;
  end;
end;

function TAdvChartCustomControlBaseCommon.HandleShortCut(AShortcut: string): Boolean;
var
  sl: TStringList;
  s: string;
  I: Integer;
  b: Boolean;
begin
  Result := False;
  if not Enabled then
    Exit;

  Result := ExecuteShortCutMethod(AShortCut);
  if Result then
  begin
    CancelShortCutHint;
    FShortCutLimitation := '';
  end
  else
  begin
    FShortCutLimitation := AShortCut;
    sl := TStringList.Create;
    try
      GetShortCutHints(sl);
      b := False;
      for I := 0 to sl.Count - 1 do
      begin
        s := sl[I];
        if (s <> '') and ((Pos(FShortCutLimitation, s) = 1) or (FShortCutLimitation = '')) then
        begin
          b := True;
          Break;
        end;
      end;

      if b then
        ShowShortCutHint
      else
        CancelShortCutHint;
    finally
      sl.Free;
    end;
  end;
end;
{$ENDIF}
{$ENDIF}

procedure TAdvChartCustomControlBaseCommon.SetTextQuality(const Value: TAdvChartGraphicsTextQuality);
begin
  if FTextQuality <> Value then
  begin
    FTextQuality := Value;
    Invalidate;
  end;
end;

procedure TAdvChartCustomControlBaseCommon.SetNativeCanvas(const Value: Boolean);
begin
  if FNativeCanvas <> Value then
  begin
    FNativeCanvas := Value;
    Invalidate;
  end;
end;

procedure TAdvChartCustomControlBaseCommon.SetAntiAliasing(const Value: Boolean);
begin
  if FAntiAliasing <> Value then
  begin
    FAntiAliasing := Value;
    Invalidate;
  end;
end;

procedure TAdvChartCustomControlBaseCommon.SetOptimizedHTMLDrawing(const Value: Boolean);
begin
  if FOptimizedHTMLDrawing <> Value then
  begin
    FOptimizedHTMLDrawing := Value;
    Invalidate;
  end;
end;

procedure TAdvChartCustomControlBaseCommon.SetShowAcceleratorChar(const Value: Boolean);
begin
  if FShowAcceleratorChar <> Value then
  begin
    FShowAcceleratorChar := Value;
    Invalidate;
  end;
end;

function TAdvChartCustomControlBaseCommon.GetControlAlignment: TAdvControlAlignment;
begin
  Result := caNone;
  {$IFDEF FMXLIB}
  case Align of
    TAlignLayout.None: Result := caNone;
    TAlignLayout.Top: Result := caTop;
    TAlignLayout.Bottom: Result := caBottom;
    TAlignLayout.Left: Result := caLeft;
    TAlignLayout.Right: Result := caRight;
    TAlignLayout.Client: Result := caClient;
  end;
  {$ENDIF}
  {$IFDEF CMNWEBLIB}
  case Align of
    alNone: Result := caNone;
    alTop: Result := caTop;
    alBottom: Result := caBottom;
    alLeft: Result := caLeft;
    alRight: Result := caRight;
    alClient: Result := caClient;
  end;
  {$ENDIF}
end;

procedure TAdvChartCustomControlBaseCommon.SetControlAlignment(const Value: TAdvControlAlignment);
begin
  {$IFDEF FMXLIB}
  case Value of
    caNone: Align := TAlignLayout.None;
    caTop: Align := TAlignLayout.Top;
    caBottom: Align := TAlignLayout.Bottom;
    caLeft: Align := TAlignLayout.Left;
    caRight: Align := TAlignLayout.Right;
    caClient: Align := TAlignLayout.Client;
  end;
  {$ENDIF}
  {$IFDEF CMNWEBLIB}
  case Value of
    caNone: Align := alNone;
    caTop: Align := alTop;
    caBottom: Align := alBottom;
    caLeft: Align := alLeft;
    caRight: Align := alRight;
    caClient: Align := alClient;
  end;
  {$ENDIF}
end;

procedure TAdvChartCustomControlBaseCommon.HandleMouseLeave;
begin

end;

procedure TAdvChartCustomControlBaseCommon.HandleMouseEnter;
begin

end;

procedure TAdvChartCustomControlBaseCommon.HandleMouseDown(Button: TAdvMouseButton; Shift: TShiftState; X: Single; Y: Single);
begin

end;

procedure TAdvChartCustomControlBaseCommon.HandleMouseMove(Shift: TShiftState; X: Single; Y: Single);
begin

end;

procedure TAdvChartCustomControlBaseCommon.HandleDblClick(X: Single; Y: Single);
begin

end;

procedure TAdvChartCustomControlBaseCommon.HandleDragOver(const Source: TObject; const Point: TPointF; var Accept: Boolean);
begin

end;

procedure TAdvChartCustomControlBaseCommon.HandleDragDrop(const Source: TObject; const Point: TPointF);
begin
end;

procedure TAdvChartCustomControlBaseCommon.HandleMouseUp(Button: TAdvMouseButton; Shift: TShiftState; X: Single; Y: Single);
begin

end;

{$IFDEF LCLLIB}
procedure TAdvChartCustomControlBaseCommon.HandleUTF8KeyPress(var {%$H-}UTF8Key: TUTF8Char);
begin
end;
{$ENDIF}

procedure TAdvChartCustomControlBaseCommon.HandleKeyPress(var Key: Char);
begin

end;

procedure TAdvChartCustomControlBaseCommon.HandleKeyDown(var Key: Word; Shift: TShiftState);
begin

end;

procedure TAdvChartCustomControlBaseCommon.HandleDialogKey(var Key: Word; Shift: TShiftState);
begin

end;

procedure TAdvChartCustomControlBaseCommon.HandleKeyUp(var Key: Word; Shift: TShiftState);
begin

end;

procedure TAdvChartCustomControlBaseCommon.HandleMouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
begin

end;

{$IFDEF FMXLIB}
procedure TAdvChartCustomControlBase.StyleChangedHandler(const Sender: TObject; const Msg: TMessage);
begin
  InitializeStyle;
end;

constructor TAdvChartCustomControlBase.Create(AOwner: TComponent);
begin
  inherited;
  FStyleChangedId := TMessageManager.DefaultManager.SubscribeToMessage(TStyleChangedMessage, StyleChangedHandler);
end;

destructor TAdvChartCustomControlBase.Destroy;
var
  frm: TCustomForm;
begin
  frm := TAdvChartUtils.GetOwnerForm(Self);
  if Assigned(frm) and (csDestroying in frm.ComponentState) then
    TAdvChartStyles.SetActiveScene(nil);

  TMessageManager.DefaultManager.Unsubscribe(TStyleChangedMessage, FStyleChangedId);
  inherited;
end;

procedure TAdvChartCustomControlBase.Invalidate;
begin
  Invalidate;
end;

{$HINTS OFF}
{$IF COMPILERVERSION < 30}
function TAdvChartCustomControlBase.GetHintString: String;
begin
  Result := '';
end;

function TAdvChartCustomControlBase.HasHint: Boolean;
begin
  Result := False;
end;
{$IFEND}
{$HINTS ON}

function TAdvChartCustomControlBase.GetL: Single;
begin
  Result := Position.X;
end;

function TAdvChartCustomControlBase.GetT: Single;
begin
  Result := Position.Y;
end;

procedure TAdvChartCustomControlBase.SetTop(const Value: Single);
begin
  Position.Y := Value;
end;

procedure TAdvChartCustomControlBase.SetLeft(const Value: Single);
begin
  Position.X := Value;
end;

{$HINTS OFF}
{$IF COMPILERVERSION = 28}
procedure TAdvChartCustomControlBase.BeginUpdate;
begin
end;

procedure TAdvChartCustomControlBase.EndUpdate;
begin
end;
{$IFEND}
{$HINTS ON}

procedure TAdvChartCustomControlBase.KeyDown(var Key: Word; var KeyChar: WideChar;
  Shift: TShiftState);
begin
  inherited;
  if KeyChar = ' ' then
    Key := KEY_SPACE;

  if KeyChar = '-' then
    Key := KEY_SUBTRACT;

  if KeyChar = '+' then
    Key := KEY_ADD;

  if KeyChar = '*' then
    Key := KEY_MULTIPLY;

  if KeyChar = '/' then
    Key := KEY_DIVIDE;

  HandleKeyPress(KeyChar);
  HandleKeyDown(Key, Shift);
end;

procedure TAdvChartCustomControlBase.KeyUp(var Key: Word; var KeyChar: WideChar;
  Shift: TShiftState);
begin
  inherited;
  if KeyChar = ' ' then
    Key := KEY_SPACE;

  HandleKeyUp(Key, Shift);
end;

procedure TAdvChartCustomControlBase.DialogKey(var Key: Word; Shift: TShiftState);
begin
  inherited;
  HandleDialogKey(Key, Shift);
end;

procedure TAdvChartCustomControlBase.DragOver(const Data: TDragObject; const Point: TPointF; var Operation: TDragOperation);
var
  b: Boolean;
begin
  inherited;
  b := Operation = TDragOperation.Move;
  HandleDragOver(Data.Source, Point, b);
  if b then
    Operation := TDragOperation.Move;
end;

procedure TAdvChartCustomControlBase.DragDrop(const Data: TDragObject; const Point: TPointF);
begin
  inherited;
  HandleDragDrop(Data.Source, Point);
end;

procedure TAdvChartCustomControlBase.MouseDown(Button: TAdvMouseButton; Shift: TShiftState; X,
  Y: Single);
begin
  inherited;
  HandleMouseDown(Button, Shift, X, Y);
  if Assigned(OnInternalMouseDown) then
    OnInternalMouseDown(Self);
end;

procedure TAdvChartCustomControlBase.MouseMove(Shift: TShiftState; X, Y: Single);
begin
  inherited;
  HandleMouseMove(Shift, X, Y);
  if Assigned(OnInternalMouseMove) then
    OnInternalMouseMove(Self);
end;

procedure TAdvChartCustomControlBase.MouseUp(Button: TAdvMouseButton; Shift: TShiftState; X,
  Y: Single);
begin
  inherited;
  HandleMouseUp(Button, Shift, X, Y);
  if Assigned(OnInternalMouseUp) then
    OnInternalMouseUp(Self);
end;

procedure TAdvChartCustomControlBase.MouseWheel(Shift: TShiftState; WheelDelta: Integer;
  var Handled: Boolean);
begin
  inherited;
  HandleMouseWheel(Shift, WheelDelta, Handled);
end;

procedure TAdvChartCustomControlBase.DoMouseEnter;
begin
  inherited;
  HandleMouseEnter;
end;

procedure TAdvChartCustomControlBase.SetNewScene(AScene: IScene);
begin
  inherited;
  TAdvChartStyles.SetActiveScene(AScene);
end;

procedure TAdvChartCustomControlBase.DoMouseLeave;
begin
  inherited;
  HandleMouseLeave;
end;

{$ENDIF}

procedure TAdvChartCustomControlBase.DblClick;
var
  pf: TPointF;
begin
  inherited;
  pf := ConvertScreenToClient(TAdvChartUtils.GetMousePos);
  HandleDblClick(pf.X, pf.Y);
  if Assigned(OnInternalDblClick) then
    OnInternalDblClick(Self);
end;

{$IFDEF CMNWEBLIB}

{$IFDEF VCLLIB}
{$HINTS OFF}
{$IF COMPILERVERSION > 30}
procedure TAdvChartCustomControlBase.ChangeScale(M, D: Integer; isDpiChange: Boolean);
{$ELSE}
procedure TAdvChartCustomControlBase.ChangeScale(M, D: Integer);
{$IFEND}
begin
  inherited;
  CalcFactor;
  ChangeDPIScale(M, D);
end;
{$HINTS ON}
{$ENDIF}

{$IFDEF LCLLIB}
procedure TAdvChartCustomControlBase.UTF8KeyPress(var UTF8Key: TUTF8Char);
begin
  inherited;
  HandleUTF8KeyPress(UTF8Key);
end;
{$ENDIF}

procedure TAdvChartCustomControlBase.KeyPress(var Key: Char);
begin
  inherited;
  HandleKeyPress(Key);
end;

procedure TAdvChartCustomControlBase.KeyDown(var Key: Word; Shift: TShiftState);
var
  Ctrl: TWinControl;
begin
  inherited;
  HandleDialogKey(Key, Shift);
  HandleKeyDown(Key, Shift);
  if Key = KEY_TAB then
  begin
    {$IFNDEF WEBLIB}
    if ssShift in Shift then
      Ctrl := TWinControlProtected(Self.Parent).FindNextControl(Self, False, True, True)
    else
      Ctrl := TWinControlProtected(Self.Parent).FindNextControl(Self, True, True, True);

    if Assigned(Ctrl) and Ctrl.CanFocus then
      Ctrl.SetFocus;
    {$ENDIF}
  end;

  {$IFDEF LCLLIB}
  {$IFDEF UNIX}
  case Key of
    KEY_UP, KEY_DOWN: Key := 0;
  end;
  {$ENDIF}
  {$ENDIF}
end;

procedure TAdvChartCustomControlBase.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
  HandleKeyUp(Key, Shift);
end;

procedure TAdvChartCustomControlBase.DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  inherited;
  HandleDragOver(Source, PointF(X, Y), Accept);
end;

procedure TAdvChartCustomControlBase.DragDrop(Source: TObject; X, Y: Integer);
begin
  inherited;
  HandleDragDrop(Source, PointF(X, Y));
end;

procedure TAdvChartCustomControlBase.MouseDown(Button: TAdvMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  HandleMouseDown(Button, Shift, X, Y);
  if Assigned(OnInternalMouseDown) then
    OnInternalMouseDown(Self);
end;

procedure TAdvChartCustomControlBase.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  HandleMouseMove(Shift, X, Y);
  if Assigned(OnInternalMouseMove) then
    OnInternalMouseMove(Self);
end;

procedure TAdvChartCustomControlBase.MouseUp(Button: TAdvMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  HandleMouseUp(Button, Shift, X, Y);
  if Assigned(OnInternalMouseUp) then
    OnInternalMouseUp(Self);
end;

{$IFNDEF WEBLIB}

{ TWinControlProtected }

procedure TWinControlProtected.PaintCtrls(DC: HDC; First: TControl);
begin
  PaintControls(DC, First);
end;
{$ENDIF}

{$IFDEF VCLLIB}
procedure TAdvChartCustomControlBase.CMHintShow(var Message: TMessage);
var
  h: String;
begin
  with TCMHintShow(Message).HintInfo^ do
  begin
    if HasHint then
    begin
      h := GetHintString;
      HintStr := h;
      ReshowTimeout := 0;
    end;
  end;
end;

{$HINTS OFF}
{$IF COMPILERVERSION > 22}
procedure TAdvChartCustomControlBase.CMStyleChanged(var Message: TMessage);
begin
  InitializeStyle;
end;
{$IFEND}
{$HINTS ON}

procedure TAdvChartCustomControlBase.CMDesignHitTest(var Message: TCMDesignHitTest);
var
  P: TPoint;
begin
  inherited;
  GetCursorPos(P);
  P := ScreenToClient(P);
  if HandleDesignHitTest(P) then
    Message.Result := 1;
end;

procedure TAdvChartCustomControlBase.WMNCHitTest(var Message: TWMNCHitTest);
begin
  if not HitTest then
    Message.Result := HTTRANSPARENT
  else
    inherited;
end;

procedure TAdvChartCustomControlBase.WMPaint(var Message: TWMPaint);
var
  DC, MemDC: HDC;
  MemBitmap, OldBitmap: HBITMAP;
  PS: TPaintStruct;
  dbl: boolean;
  p: TPoint;
  i: integer;
begin
  if not Transparent then
  begin
    inherited;
    Exit;
  end;

  if Assigned(Parent) then
  begin
    DC := Message.DC;
    if DC <> 0 then
    begin
      dbl := Parent.DoubleBuffered;
      if (Parent is TCustomForm) then
        Parent.DoubleBuffered := false;
      i := SaveDC(DC);
      p := ClientOrigin;
      Windows.ScreenToClient(Parent.Handle, p);
      p.x := -p.x;
      p.y := -p.y;
      MoveWindowOrg(DC, p.x, p.y);
      SendMessage(Parent.Handle, WM_ERASEBKGND, DC, 0);
      SendMessage(Parent.Handle, WM_PAINT, DC, 0);
      if (Parent is TWinControlProtected) then
        (Parent as TWinControlProtected).PaintCtrls(DC, nil);
      RestoreDC(DC, i);
      Parent.DoubleBuffered := dbl;
    end;
  end;

  if not DoubleBuffered or (Message.DC <> 0) then
  begin
    if not (csCustomPaint in ControlState) and (ControlCount = 0) then
      inherited
    else
      PaintHandler(Message);
  end
  else
  begin
    DC := GetDC(0);
    MemBitmap := CreateCompatibleBitmap(DC, ClientRect.Right, ClientRect.Bottom);
    ReleaseDC(0, DC);
    MemDC := CreateCompatibleDC(0);
    OldBitmap := SelectObject(MemDC, MemBitmap);
    try
      DC := BeginPaint(Handle, PS);
      Perform(WM_ERASEBKGND, MemDC, 0);
      Message.DC := MemDC;
      WMPaint(Message);
      Message.DC := 0;
      BitBlt(DC, 0, 0, ClientRect.Right, ClientRect.Bottom, MemDC, 0, 0, SRCCOPY);
      EndPaint(Handle, PS);
    finally
      SelectObject(MemDC, OldBitmap);
      DeleteDC(MemDC);
      DeleteObject(MemBitmap);
    end;
  end;
end;

procedure TAdvChartCustomControlBase.WMEraseBkGnd(var Message: TWMEraseBkGnd);
begin
  if Transparent then
    Message.Result := 1
  else
    inherited;
end;

procedure TAdvChartCustomControlBase.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  if TabStop then
    Message.result := DLGC_WANTALLKEYS or DLGC_WANTARROWS
  else
    Message.result := DLGC_WANTALLKEYS or DLGC_WANTARROWS or DLGC_WANTTAB;
end;

procedure TAdvChartCustomControlBase.WMMouseWheel(var Message: TWMMouseWheel);
var
  b: Boolean;
begin
  inherited;
  b := message.Result > 0;
  HandleMouseWheel(CreateShiftStateEx, Message.WheelDelta, b);
end;

procedure TAdvChartCustomControlBase.CMFocusChanged(var Message: TCMFocusChanged);
begin
  Invalidate;
end;

procedure TAdvChartCustomControlBase.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  HandleMouseLeave;
end;

procedure TAdvChartCustomControlBase.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  HandleMouseEnter;
end;
{$ENDIF}

{$IFDEF WEBLIB}
procedure TAdvChartCustomControlBase.DoMouseEnter;
begin
  inherited;
  HandleMouseEnter;
end;

procedure TAdvChartCustomControlBase.DoMouseLeave;
begin
  inherited;
  HandleMouseLeave;
end;

procedure TAdvChartCustomControlBase.MouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
begin
  inherited;
  HandleMouseWheel(Shift, WheelDelta, Handled);
end;
{$ENDIF}

{$IFDEF LCLLIB}
procedure TAdvChartCustomControlBase.CMFocusChanged(var Message: TLMessage);
begin
  Invalidate;
end;

procedure TAdvChartCustomControlBase.CMMouseLeave(var Message: TLMNoParams);
begin
  HandleMouseLeave;
end;

procedure TAdvChartCustomControlBase.CMMouseEnter(var Message: TLMNoParams);
begin
  HandleMouseEnter;
end;

procedure TAdvChartCustomControlBase.CMHintShow(var Message: TLMessage);
var
  h: String;
begin
  with TCMHintShow(Message).HintInfo^ do
  begin
    if HasHint then
    begin
      h := GetHintString;
      HintStr := h;
      ReshowTimeout := 0;
    end;
  end;
end;

procedure TAdvChartCustomControlBase.WMNCHitTest(var Message: TLMessage);
begin
  if not HitTest then
    Message.Result := HTTRANSPARENT
  else
    inherited;
end;

{$HINTS OFF}
{$IF FPC_FULLVERSION < 30000}
procedure TAdvChartCustomControlBase.WMLButtonDBLCLK(var Message: TLMLButtonDblClk);
var
  MP: TPoint;
begin
  if (csCaptureMouse in ControlStyle) and (mbLeft in CaptureMouseButtons) then
  begin
    MouseCapture := True;
  end;
  // first send a dblclick
  if csClickEvents in ControlStyle then DblClick;
  // then send the mousedown
  if not (csNoStdEvents in ControlStyle) then
  begin
    MP := GetMousePosFromMessage(Message.Pos);
    MouseDown(mbLeft, KeysToShiftState(Message.Keys) + [ssDouble], MP.X, MP.Y);
  end;
end;
{$IFEND}
{$HINTS ON}

{$IFDEF MSWINDOWS}
procedure TAdvChartCustomControlBase.WMPaint(var Message: TLMPaint);
var
  DC, MemDC: HDC;
  MemBitmap, OldBitmap: HBITMAP;
  PS: TPaintStruct;
  dbl: boolean;
  p: TPoint;
  i: integer;
begin
  if not Transparent then
  begin
    inherited;
    Exit;
  end;

  if Assigned(Parent) then
  begin
    DC := Message.DC;
    if DC <> 0 then
    begin
      i := SaveDC(DC);
      p := ClientOrigin;
      Windows.ScreenToClient(Parent.Handle, p);
      p.x := -p.x;
      p.y := -p.y;
      MoveWindowOrg(DC, p.x, p.y);
      SendMessage(Parent.Handle, WM_ERASEBKGND, DC, 0);
      SendMessage(Parent.Handle, WM_PAINT, DC, 0);
      if (Parent is TWinControlProtected) then
        (Parent as TWinControlProtected).PaintCtrls(DC, nil);
      RestoreDC(DC, i);
    end;
  end;

  if not DoubleBuffered or (Message.DC <> 0) then
  begin
    if not (csCustomPaint in ControlState) and (ControlCount = 0) then
      inherited
    else
      PaintHandler(Message);
  end
  else
  begin
    DC := GetDC(0);
    MemBitmap := CreateCompatibleBitmap(DC, ClientRect.Right, ClientRect.Bottom);
    ReleaseDC(0, DC);
    MemDC := CreateCompatibleDC(0);
    OldBitmap := SelectObject(MemDC, MemBitmap);
    try
      DC := BeginPaint(Handle, PS);
      Perform(WM_ERASEBKGND, MemDC, 0);
      Message.DC := MemDC;
      WMPaint(Message);
      Message.DC := 0;
      BitBlt(DC, 0, 0, ClientRect.Right, ClientRect.Bottom, MemDC, 0, 0, SRCCOPY);
      EndPaint(Handle, PS);
    finally
      SelectObject(MemDC, OldBitmap);
      DeleteDC(MemDC);
      DeleteObject(MemBitmap);
    end;
  end;
end;

procedure TAdvChartCustomControlBase.WMEraseBkGnd(var Message: TLMEraseBkGnd);
begin
  if Transparent then
    Message.Result := 1
  else
    inherited;
end;
{$ENDIF}

procedure TAdvChartCustomControlBase.WMGetDlgCode(var Message: TLMNoParams);
begin
  if TabStop then
    Message.result := DLGC_WANTALLKEYS or DLGC_WANTARROWS
  else
    Message.result := DLGC_WANTALLKEYS or DLGC_WANTARROWS or DLGC_WANTTAB;
end;

procedure TAdvChartCustomControlBase.WMMouseWheel(var Message: TLMMouseEvent);
var
  b: Boolean;
begin
  inherited;
  b := Message.Result > 0;
  HandleMouseWheel(CreateShiftStateEx, Message.WheelDelta, b);
end;
{$ENDIF}

function TAdvChartCustomControlBase.CanFocus: Boolean;
begin
  Result := inherited CanFocus;
  Result := Result and AllowFocus;
end;

procedure TAdvChartCustomControlBase.BeginUpdate;
begin
  {$IFDEF WEBLIB}
  inherited;
  {$ENDIF}
end;

procedure TAdvChartCustomControlBase.EndUpdate;
begin
  {$IFDEF WEBLIB}
  inherited;
  {$ENDIF}
end;

function TAdvChartCustomControlBase.GetLocalRect: TRectF;
begin
  Result := RectF(0, 0, Width, Height);
end;

constructor TAdvChartCustomControlBase.Create(AOwner: TComponent);
begin
  inherited;
  FHitTest := True;
  FStored := True;
  {$IFNDEF WEBLIB}
  DoubleBuffered := True;
  {$ENDIF}
  ControlStyle := ControlStyle + [csAcceptsControls];
end;
{$ENDIF}

{$IFDEF VCLLIB}
procedure TAdvChartCustomControl.CreateWnd;
begin
  inherited;
  CreateCheckBoxBitmaps;
  CreateRadioButtonBitmaps;
end;
{$ENDIF}

{$IFDEF WEBLIB}
class function TAdvChartCustomControl.GetVersionNumber(AMaj, AMin, ARel, ABld: ShortInt): string;
begin
  Result := '';
end;
{$ENDIF}

procedure TAdvChartCustomControl.DisableBackground;
begin
  FFill.Kind := gfkNone;
  FStroke.Kind := gskNone;
  {$IFDEF CMNLIB}
  Color := clBtnFace;
  ParentColor := False;
  {$ENDIF}
  {$IFDEF WEBLIB}
  Color := clNone;
  {$ENDIF}
end;

procedure TAdvChartCustomControl.EnableBackground;
begin
  FFill.Kind := gfkSolid;
  FStroke.Kind := gskSolid;
end;

procedure TAdvChartCustomControl.DisableStroke;
begin
  FStroke.Kind := gskNone;
end;

{$IFDEF LCLLIB}
procedure TAdvChartCustomControl.DoSetBounds(ALeft, ATop, AWidth,
  AHeight: Integer);
begin
  inherited DoSetBounds(ALeft, ATop, AWidth, AHeight);
  UpdateControlAfterResize;
end;
{$ENDIF}

{$IFDEF WEBLIB}
procedure TAdvChartCustomControl.SetColor(AValue: TColor);
begin
  inherited;
  if Assigned(Fill) then
    Fill.Color := AValue;
  Invalidate;
end;
{$ENDIF}

{$IFDEF FMXLIB}
procedure TAdvChartCustomControl.SetColor(const Value: TAdvChartGraphicsColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Fill.Color := Color;
    Invalidate;
  end;
end;
{$ENDIF}

procedure TAdvChartCustomControl.Resize;
begin
  inherited;
  {$IFNDEF LCLLIB}
  UpdateControlAfterResize;
  {$ENDIF}
end;

procedure TAdvChartCustomControl.EnableStroke;
begin
  FStroke.Kind := gskSolid;
end;

procedure TAdvChartCustomControl.DisableFill;
begin
  FFill.Kind := gfkNone;
end;

procedure TAdvChartCustomControl.EnableFill;
begin
  FFill.Kind := gfkSolid;
end;

procedure TAdvChartCustomControl.Assign(Source: TPersistent);
begin
  if Source is TAdvChartCustomControl then
  begin
    FFill.Assign((Source as TAdvChartCustomControl).Fill);
    FStroke.Assign((Source as TAdvChartCustomControl).Stroke);
  end
  else
    inherited;
end;

constructor TAdvChartCustomControl.Create(AOwner: TComponent);
begin
  inherited;
  {$IFDEF FMXLIB}
  FColor := gcWhite;
  CanFocus := True;
  ClipChildren := True;
  DisableFocusEffect := True;
  {$ENDIF}
  {$IFDEF CMNWEBLIB}
  {$IFNDEF WEBLIB}
  ParentColor := False;
  {$ENDIF}
  Color := gcWhite;
  {$ENDIF}
  {$IFDEF WEBLIB}
  LinkTouchEvents := True;
  AllowTouch := False;
  {$ENDIF}
  TabStop := True;
  FFill := TAdvChartGraphicsFill.Create;
  FStroke := TAdvChartGraphicsStroke.Create;
  FFill.OnChanged := FillChanged;
  FStroke.OnChanged := StrokeChanged;

  if not IsDesignerForm then
    RegisterRuntimeClasses;
end;

destructor TAdvChartCustomControl.Destroy;
begin
  if Assigned(FUndoManager) then
  begin
    FUndoManager.Free;
    FUndoManager := nil;
  end;

  if Assigned(FDownBtn) then
  begin
    FDownBtn.Free;
    FDownBtn := nil;
  end;

  if Assigned(FNormalBtn) then
  begin
    FNormalBtn.Free;
    FNormalBtn := nil;
  end;

  if Assigned(FDownFocusBtn) then
  begin
    FDownFocusBtn.Free;
    FDownFocusBtn := nil;
  end;

  if Assigned(FNormalFocusBtn) then
  begin
    FNormalFocusBtn.Free;
    FNormalFocusBtn := nil;
  end;

  if Assigned(FNormalDisabledBtn) then
  begin
    FNormalDisabledBtn.Free;
    FNormalDisabledBtn := nil;
  end;

  if Assigned(FCheckedChk) then
  begin
    FCheckedChk.Free;
    FCheckedChk := nil;
  end;

  if Assigned(FCheckedFocusChk) then
  begin
    FCheckedFocusChk.Free;
    FCheckedFocusChk := nil;
  end;

  if Assigned(FUnCheckedDisabledChk) then
  begin
    FUnCheckedDisabledChk.Free;
    FUnCheckedDisabledChk := nil;
  end;

  if Assigned(FCheckedDisabledChk) then
  begin
    FCheckedDisabledChk.Free;
    FCheckedDisabledChk := nil;
  end;

  if Assigned(FUnCheckedChk) then
  begin
    FUnCheckedChk.Free;
    FUnCheckedChk := nil;
  end;

  if Assigned(FUnCheckedFocusChk) then
  begin
    FUnCheckedFocusChk.Free;
    FUnCheckedFocusChk := nil;
  end;

  if Assigned(FCheckedRd) then
  begin
    FCheckedRd.Free;
    FCheckedRd := nil;
  end;

  if Assigned(FCheckedFocusRd) then
  begin
    FCheckedFocusRd.Free;
    FCheckedFocusRd := nil;
  end;

  if Assigned(FUnCheckedRd) then
  begin
    FUnCheckedRd.Free;
    FUnCheckedRd := nil;
  end;

  if Assigned(FUnCheckedFocusRd) then
  begin
    FUnCheckedFocusRd.Free;
    FUnCheckedFocusRd := nil;
  end;

  if Assigned(FUnCheckedDisabledRd) then
  begin
    FUnCheckedDisabledRd.Free;
    FUnCheckedDisabledRd := nil;
  end;

  if Assigned(FCheckedDisabledRd) then
  begin
    FCheckedDisabledRd.Free;
    FCheckedDisabledRd := nil;
  end;

  FFill.Free;
  FStroke.Free;

  inherited;
end;

function TAdvChartCustomControl.GetUndoManager: TAdvChartUndoManager;
begin
  if not Assigned(FUndoManager) then
    FUndoManager := TAdvChartUndoManager.Create(Self);

  Result := FUndoManager;
end;

procedure TAdvChartCustomControl.SetFill(const Value: TAdvChartGraphicsFill);
begin
  FFill.Assign(Value);
end;

procedure TAdvChartCustomControl.SetStroke(const Value: TAdvChartGraphicsStroke);
begin
  FStroke.Assign(Value);
end;

procedure TAdvChartCustomControl.DoCanSaveProperty(AObject: TObject; APropertyName: string; APropertyType: TTypeKind; var ACanSave: Boolean);
begin
  if Assigned(OnCanSaveProperty) then
    OnCanSaveProperty(Self, AObject, APropertyName, APropertyType, ACanSave);
end;

procedure TAdvChartCustomControl.DoCanLoadProperty(AObject: TObject; APropertyName: string; APropertyType: TTypeKind; var ACanLoad: Boolean);
begin
  if Assigned(OnCanLoadProperty) then
    OnCanLoadProperty(Self, AObject, APropertyName, APropertyType, ACanLoad);
end;

procedure TAdvChartCustomControl.DoBeforeDraw(AGraphics: TAdvChartGraphics; ARect: TRectF; var ADefaultDraw: Boolean);
begin
  if Assigned(OnBeforeDraw) then
    OnBeforeDraw(Self, AGraphics, ARect, ADefaultDraw);
end;

procedure TAdvChartCustomControl.DoAfterDraw(AGraphics: TAdvChartGraphics; ARect: TRectF);
begin
  if Assigned(OnAfterDraw) then
    OnAfterDraw(Self, AGraphics, ARect);
end;

procedure TAdvChartCustomControl.DrawBackground(AGraphics: TAdvChartGraphics; ARect: TRectF);
begin
  AGraphics.Fill.Assign(Fill);
  AGraphics.Fill.Color := Color;
  AGraphics.Stroke.Assign(Stroke);
  AGraphics.DrawRectangle(ARect);
end;

{$IFDEF DRAWTRIAL}
{$IFDEF FREEWARE}
procedure TAdvChartCustomControl.DrawTrial(AGraphics: TAdvChartGraphics; {%H-}ARect: TRectF);
var
  s: String;
begin
  if not (Parent is TAdvChartCustomControl) then
  begin
    InflateRectEx(ARect, -5, -5);
    AGraphics.Font.Color := gcRed;
    TAdvChartUtils.SetFontSize(AGraphics.Font, 10);
    s := ClassName + ' Trial ' + GetVersion;
    AGraphics.DrawText(ARect, s, False, gtaTrailing, gtaTrailing);
  end;
end;
{$ENDIF}
{$ENDIF}

procedure TAdvChartCustomControl.DrawControl;
var
  g, gbmp: TAdvChartGraphics;
  r: TRectF;
  df: Boolean;
  bmp: TAdvChartBitmap;
  {$IFDEF FMXLIB}
  sc: Single;
  {$ENDIF}
begin
  if BufferedPainting then
  begin
    {$IFDEF FMXLIB}
    sc := TAdvChartUtils.GetDPIScale;
    g := TAdvChartGraphics.CreateBitmapCanvas(Round(Width * sc), Round(Height * sc), NativeCanvas);
    {$ENDIF}
    {$IFDEF CMNWEBLIB}
    g := TAdvChartGraphics.CreateBitmapCanvas(Width, Height, NativeCanvas);
    {$ENDIF}
    g.BeginScene;
  end
  else
    g := TAdvChartGraphics.Create(Canvas, NativeCanvas);

  {$IFNDEF LIMITEDGRAPHICSMODE}
  g.OptimizedHTMLDrawing := OptimizedHTMLDrawing;
  {$ENDIF}
  g.Context.SetSize(Width, Height);
  g.Context.SetAntiAliasing(AntiAliasing);
  g.Context.SetShowAcceleratorChar(ShowAcceleratorChar);
  g.Context.SetTextQuality(TextQuality);
  try
    r := RectF(0, 0, Width, Height);
    df := True;
    DoBeforeDraw(g, r, df);
    if df then
    begin
      DrawBackground(g, r);
      Draw(g, r);
      DoAfterDraw(g, r);
    end;
    {$IFDEF DRAWTRIAL}
    {$IFDEF FREEWARE}
    DrawTrial(g, r);
    {$ENDIF}
    {$ENDIF}

    if BufferedPainting then
      g.EndScene;

    g.Context.Render;

    if BufferedPainting then
    begin
      bmp := TAdvChartBitmap.Create;
      try
        bmp.Assign(g.Bitmap);
        gbmp := TAdvChartGraphics.Create(Canvas, False);
        try
          gbmp.Context.SetSize(Width, Height);
          gbmp.Context.SetAntiAliasing(AntiAliasing);
          gbmp.Context.SetShowAcceleratorChar(ShowAcceleratorChar);
          gbmp.Context.SetTextQuality(TextQuality);
          gbmp.DrawBitmap(r, bmp);
        finally
          gbmp.Free;
        end;
      finally
        bmp.Free;
      end;
    end;
  finally
    g.Free;
  end;
end;

procedure TAdvChartCustomControl.Draw(AGraphics: TAdvChartGraphics; ARect: TRectF);
begin

end;

procedure TAdvChartCustomControl.Paint;
begin
  {$IFDEF FMXLIB}
  CalcFactor;
  {$ENDIF}
  inherited;
  if not BlockInvalidate then
    DrawControl;
end;

procedure TAdvChartCustomControl.StrokeChanged(Sender: TObject);
begin
  Invalidate;
end;

procedure TAdvChartCustomControl.FillChanged(Sender: TObject);
begin
  {$IFDEF FMXLIB}
  FColor := Fill.Color;
  {$ENDIF}
  {$IFDEF CMNWEBLIB}
  if (Fill.Kind <> gfkNone) and (Fill.Kind <> gfkTexture) and (Fill.Color <> gcNull) then
    Color := Fill.Color
  else
    {$IFDEF WEBLIB}
    Color := clNone;
    {$ELSE}
    Color := clBtnFace;
    {$ENDIF}
  {$ENDIF}
  Invalidate;
end;

procedure TAdvChartCustomControl.UpdateControlAfterResize;
begin

end;

procedure TAdvChartCustomControl.DoBitmapChanged(Sender: TObject);
begin
  {$IFDEF WEBLIB}
  if FBlockInvalidate then
    Exit;
  FBlockInvalidate := True;
  Invalidate;
  FBlockInvalidate := False;
  {$ENDIF}
end;

{$IFDEF CMNLIB}
function TAdvChartCustomControl.GetTransparentColor: TAdvChartGraphicsColor;
var
  c: TAdvChartGraphicsColor;
begin
  Result := $FFFFFE;
  if TAdvChartStyles.GetStyleBackgroundFillColorTo(c) then
    Result := c;
end;
{$ENDIF}

procedure TAdvChartCustomControl.CreateCheckBoxBitmaps;
var
{$IFDEF FMXLIB}
  chk: TCheckBox;
  f: TCommonCustomForm;
  fo: IControl;
{$ENDIF}
{$IFDEF CMNWEBLIB}
  {$IFNDEF LCLWEBLIB}
  rc: TRect;
  dChecked: Cardinal;
  hth: HTHEME;
  ThemeStyle: DWord;
  {$ENDIF}
  {$IFDEF LCLWEBLIB}
  g: TAdvChartGraphics;
  {$ENDIF}
  {$IFDEF VCLSTYLESENABLED}
  lDetails: TThemedElementDetails;
  {$ENDIF}
  bmp: TBitmap;
  sc: Single;
{$ENDIF}
begin
  {$IFDEF CMNWEBLIB}
  sc := ResourceScaleFactor;
  {$ENDIF}

  if Assigned(FCheckedFocusChk) then
  begin
    FCheckedFocusChk.Free;
    FCheckedFocusChk := nil;
  end;

  if Assigned(FUnCheckedChk) then
  begin
    FUnCheckedChk.Free;
    FUnCheckedChk := nil;
  end;

  if Assigned(FCheckedChk) then
  begin
    FCheckedChk.Free;
    FCheckedChk := nil;
  end;

  if Assigned(FUnCheckedFocusChk) then
  begin
    FUnCheckedFocusChk.Free;
    FUnCheckedFocusChk := nil;
  end;

  if Assigned(FUnCheckedDisabledChk) then
  begin
    FUnCheckedDisabledChk.Free;
    FUnCheckedDisabledChk := nil;
  end;

  if Assigned(FCheckedDisabledChk) then
  begin
    FCheckedDisabledChk.Free;
    FCheckedDisabledChk := nil;
  end;

  {$IFDEF FMXLIB}
  chk := TCheckBox.Create(Self);
  chk.Width := chk.Height;
  chk.Text := '';
  chk.Parent := Self;
  chk.IsChecked := false;
  chk.NeedStyleLookup;
  chk.ApplyStyleLookup;

  {$IFDEF FMXMOBILE}
  chk.Width := 25;
  chk.Height := 25;
  {$ENDIF}

  TurnOffAnimation(chk);
  FUnCheckedChk := chk.MakeScreenshot;
  chk.IsChecked := true;
  FCheckedChk := chk.MakeScreenshot;
  chk.Enabled := False;
  chk.IsChecked := False;
  FUnCheckedDisabledChk := chk.MakeScreenshot;
  chk.IsChecked := True;
  FCheckedDisabledChk := chk.MakeScreenshot;
  chk.Enabled := True;

  f := TAdvChartUtils.GetParentForm(Self);
  fo := nil;
  if Assigned(f) then
    fo := f.Focused;

  chk.SetFocus;
  chk.IsChecked := false;
  FUnCheckedFocusChk := chk.MakeScreenshot;
  chk.IsChecked := true;
  FCheckedFocusChk := chk.MakeScreenshot;
  chk.Parent := nil;
  chk.Free;

  if Assigned(fo) then
    fo.SetFocus;
  {$ENDIF}

  {$IFDEF CMNWEBLIB}
  bmp := TBitmap.Create;
  {$IFDEF VCLLIB}
  rc := Bounds(0, 0, Round(16 * sc), Round(16 * sc));
  {$ENDIF}
  {$IFDEF LCLWEBLIB}
  g := TAdvChartGraphics.Create(bmp.Canvas);
  {$ENDIF}
  try
    {$IFNDEF WEBLIB}
    bmp.PixelFormat := pf24bit;
    bmp.TransparentMode := tmFixed;
    bmp.Transparent := True;
    bmp.TransparentColor := GetTransparentColor;
    {$ENDIF}
    bmp.SetSize(Round(16 * sc), Round(16 * sc));

    FUnCheckedChk := TAdvChartBitmap.Create;
    FUnCheckedChk.OnChange := DoBitmapChanged;

    {$IFDEF VCLLIB}
    bmp.Canvas.Brush.Color := GetTransparentColor;
    bmp.Canvas.Brush.Style := bsSolid;
    bmp.Canvas.FillRect(rc);

    {$IFDEF VCLSTYLESENABLED}
    if TAdvChartStyles.StyleServicesEnabled then
    begin
      lDetails := StyleServices.GetElementDetails(tbCheckBoxUncheckedNormal);
      StyleServices.DrawElement(bmp.Canvas.Handle, lDetails, rc, nil, Round(96*sc));
    end
    else
    {$ENDIF}
    begin
      DChecked := DFCS_BUTTONCHECK;
      ThemeStyle := CBS_UNCHECKEDNORMAL;
      if IsThemeActive and Self.HandleAllocated then
      begin
        if Assigned(OpenThemeDataForDpi) then
          hth := OpenThemeDataForDpi(Self.Handle,'button', Round(96*sc))
        else
          hth := OpenThemeData(Self.Handle, 'button');
        DrawThemeBackground(hth, bmp.Canvas.Handle, BP_CHECKBOX, ThemeStyle,@rc,nil);
        CloseThemeData(hth);
      end
      else
        DrawFrameControl(bmp.Canvas.Handle,rc,DFC_BUTTON, DChecked);
    end;
    {$ENDIF}
    {$IFDEF LCLWEBLIB}
    g.Fill.Kind := gfkSolid;
    g.Fill.Color := gcWhite;
    g.Stroke.Kind := gskSolid;
    g.Stroke.Color := gcWhite;
    g.DrawRectangle(RectF(0, 0, bmp.Width, bmp.Height));
    g.DrawCheckBox(RectF(0, 0, bmp.Width, bmp.Height), False, False, True);
    {$ENDIF}

    FUnCheckedChk.Assign(bmp);

    FCheckedChk := TAdvChartBitmap.Create;
    FCheckedChk.OnChange := DoBitmapChanged;

    {$IFDEF VCLLIB}
    bmp.Canvas.Brush.Color := GetTransparentColor;
    bmp.Canvas.Brush.Style := bsSolid;
    bmp.Canvas.FillRect(rc);

    {$IFDEF VCLSTYLESENABLED}
    if TAdvChartStyles.StyleServicesEnabled then
    begin
      lDetails := StyleServices.GetElementDetails(tbCheckBoxCheckedNormal);
      StyleServices.DrawElement(bmp.Canvas.Handle, lDetails, rc, nil, Round(96*sc));
    end
    else
    {$ENDIF}
    begin
      DChecked := DFCS_BUTTONCHECK or DFCS_CHECKED;
      ThemeStyle := CBS_CHECKEDNORMAL;
      if IsThemeActive and Self.HandleAllocated then
      begin
        if Assigned(OpenThemeDataForDpi) then
          hth := OpenThemeDataForDpi(Self.Handle,'button', Round(96*sc))
        else
          hth := OpenThemeData(Self.Handle, 'button');
        DrawThemeBackground(hth, bmp.Canvas.Handle, BP_CHECKBOX, ThemeStyle,@rc,nil);
        CloseThemeData(hth);
      end
      else
        DrawFrameControl(bmp.Canvas.Handle,rc,DFC_BUTTON, DChecked);
    end;
    {$ENDIF}
    {$IFDEF LCLWEBLIB}
    g.Fill.Kind := gfkSolid;
    g.Fill.Color := gcWhite;
    g.Stroke.Kind := gskSolid;
    g.Stroke.Color := gcWhite;
    g.DrawRectangle(RectF(0, 0, bmp.Width, bmp.Height));
    g.DrawCheckBox(RectF(0, 0, bmp.Width, bmp.Height), True, False, True);
    {$ENDIF}

    FCheckedChk.Assign(bmp);

    FUnCheckedFocusChk := TAdvChartBitmap.Create;
    FUnCheckedFocusChk.OnChange := DoBitmapChanged;

    {$IFDEF VCLLIB}
    bmp.Canvas.Brush.Color := GetTransparentColor;
    bmp.Canvas.Brush.Style := bsSolid;
    bmp.Canvas.FillRect(rc);

    {$IFDEF VCLSTYLESENABLED}
    if TAdvChartStyles.StyleServicesEnabled then
    begin
      lDetails := StyleServices.GetElementDetails(tbCheckBoxUncheckedHot);
      StyleServices.DrawElement(bmp.Canvas.Handle, lDetails, rc, nil, Round(96*sc));
    end
    else
    {$ENDIF}
    begin
      DChecked := DFCS_BUTTONCHECK or DFCS_HOT;
      ThemeStyle := CBS_UNCHECKEDHOT;
      if IsThemeActive and Self.HandleAllocated then
      begin
        if Assigned(OpenThemeDataForDpi) then
          hth := OpenThemeDataForDpi(Self.Handle,'button', Round(96*sc))
        else
          hth := OpenThemeData(Self.Handle, 'button');
        DrawThemeBackground(hth, bmp.Canvas.Handle, BP_CHECKBOX, ThemeStyle,@rc,nil);
        CloseThemeData(hth);
      end
      else
        DrawFrameControl(bmp.Canvas.Handle,rc,DFC_BUTTON, DChecked);
    end;
    {$ENDIF}
    {$IFDEF LCLWEBLIB}
    g.Fill.Kind := gfkSolid;
    g.Fill.Color := gcWhite;
    g.Stroke.Kind := gskSolid;
    g.Stroke.Color := gcWhite;
    g.DrawRectangle(RectF(0, 0, bmp.Width, bmp.Height));
    g.DrawCheckBox(RectF(0, 0, bmp.Width, bmp.Height), False, True, True);
    {$ENDIF}

    FUnCheckedFocusChk.Assign(bmp);

    FCheckedFocusChk := TAdvChartBitmap.Create;
    FCheckedFocusChk.OnChange := DoBitmapChanged;

    {$IFDEF VCLLIB}
    bmp.Canvas.Brush.Color := GetTransparentColor;
    bmp.Canvas.Brush.Style := bsSolid;
    bmp.Canvas.FillRect(rc);

    {$IFDEF VCLSTYLESENABLED}
    if TAdvChartStyles.StyleServicesEnabled then
    begin
      lDetails := StyleServices.GetElementDetails(tbCheckBoxCheckedHot);
      StyleServices.DrawElement(bmp.Canvas.Handle, lDetails, rc, nil, Round(96*sc));
    end
    else
    {$ENDIF}
    begin
      DChecked := DFCS_BUTTONCHECK or DFCS_CHECKED or DFCS_HOT;
      ThemeStyle := CBS_CHECKEDHOT;
      if IsThemeActive and Self.HandleAllocated then
      begin
        if Assigned(OpenThemeDataForDpi) then
          hth := OpenThemeDataForDpi(Self.Handle,'button', Round(96*sc))
        else
          hth := OpenThemeData(Self.Handle, 'button');
        DrawThemeBackground(hth, bmp.Canvas.Handle, BP_CHECKBOX, ThemeStyle,@rc,nil);
        CloseThemeData(hth);
      end
      else
        DrawFrameControl(bmp.Canvas.Handle,rc,DFC_BUTTON, DChecked);
    end;
    {$ENDIF}
    {$IFDEF LCLWEBLIB}
    g.Fill.Kind := gfkSolid;
    g.Fill.Color := gcWhite;
    g.Stroke.Kind := gskSolid;
    g.Stroke.Color := gcWhite;
    g.DrawRectangle(RectF(0, 0, bmp.Width, bmp.Height));
    g.DrawCheckBox(RectF(0, 0, bmp.Width, bmp.Height), True, True, True);
    {$ENDIF}

    FCheckedFocusChk.Assign(bmp);

    FUnCheckedDisabledChk := TAdvChartBitmap.Create;
    FUnCheckedDisabledChk.OnChange := DoBitmapChanged;

    {$IFDEF VCLLIB}
    bmp.Canvas.Brush.Color := GetTransparentColor;
    bmp.Canvas.Brush.Style := bsSolid;
    bmp.Canvas.FillRect(rc);

    {$IFDEF VCLSTYLESENABLED}
    if TAdvChartStyles.StyleServicesEnabled then
    begin
      lDetails := StyleServices.GetElementDetails(tbCheckBoxUncheckedDisabled);
      StyleServices.DrawElement(bmp.Canvas.Handle, lDetails, rc, nil, Round(96*sc));
    end
    else
    {$ENDIF}
    begin
      DChecked := DFCS_BUTTONCHECK or DFCS_INACTIVE;
      ThemeStyle := CBS_UNCHECKEDDISABLED;
      if IsThemeActive and Self.HandleAllocated then
      begin
        if Assigned(OpenThemeDataForDpi) then
          hth := OpenThemeDataForDpi(Self.Handle,'button', Round(96*sc))
        else
          hth := OpenThemeData(Self.Handle, 'button');
        DrawThemeBackground(hth, bmp.Canvas.Handle, BP_CHECKBOX, ThemeStyle,@rc,nil);
        CloseThemeData(hth);
      end
      else
        DrawFrameControl(bmp.Canvas.Handle,rc,DFC_BUTTON, DChecked);
    end;
    {$ENDIF}
    {$IFDEF LCLWEBLIB}
    g.Fill.Kind := gfkSolid;
    g.Fill.Color := gcWhite;
    g.Stroke.Kind := gskSolid;
    g.Stroke.Color := gcWhite;
    g.DrawRectangle(RectF(0, 0, bmp.Width, bmp.Height));
    g.DrawCheckBox(RectF(0, 0, bmp.Width, bmp.Height), False, False, False);
    {$ENDIF}

    FUnCheckedDisabledChk.Assign(bmp);

    FCheckedDisabledChk := TAdvChartBitmap.Create;
    FCheckedDisabledChk.OnChange := DoBitmapChanged;

    {$IFDEF VCLLIB}
    bmp.Canvas.Brush.Color := GetTransparentColor;
    bmp.Canvas.Brush.Style := bsSolid;
    bmp.Canvas.FillRect(rc);

    {$IFDEF VCLSTYLESENABLED}
    if TAdvChartStyles.StyleServicesEnabled then
    begin
      lDetails := StyleServices.GetElementDetails(tbCheckBoxCheckedDisabled);
      StyleServices.DrawElement(bmp.Canvas.Handle, lDetails, rc, nil, Round(96*sc));
    end
    else
    {$ENDIF}
    begin
      DChecked := DFCS_BUTTONCHECK or DFCS_CHECKED or DFCS_INACTIVE;
      ThemeStyle := CBS_CHECKEDDISABLED;
      if IsThemeActive and Self.HandleAllocated then
      begin
        if Assigned(OpenThemeDataForDpi) then
          hth := OpenThemeDataForDpi(Self.Handle,'button', Round(96*sc))
        else
          hth := OpenThemeData(Self.Handle, 'button');
        DrawThemeBackground(hth, bmp.Canvas.Handle, BP_CHECKBOX, ThemeStyle,@rc,nil);
        CloseThemeData(hth);
      end
      else
        DrawFrameControl(bmp.Canvas.Handle,rc,DFC_BUTTON, DChecked);
    end;
    {$ENDIF}
    {$IFDEF LCLWEBLIB}
    g.Fill.Kind := gfkSolid;
    g.Fill.Color := gcWhite;
    g.Stroke.Kind := gskSolid;
    g.Stroke.Color := gcWhite;
    g.DrawRectangle(RectF(0, 0, bmp.Width, bmp.Height));
    g.DrawCheckBox(RectF(0, 0, bmp.Width, bmp.Height), True, False, False);
    {$ENDIF}

    FCheckedDisabledChk.Assign(bmp);
  finally
    {$IFDEF LCLWEBLIB}
    g.Free;
    {$ENDIF}
    bmp.Free;
  end;
  {$ENDIF}
end;

procedure TAdvChartCustomControl.CreateButtonBitmaps(AWidth, AHeight: Single);
var
{$IFDEF FMXLIB}
  btn: TButton;
  f: TCommonCustomForm;
  fo: IControl;
{$ENDIF}
{$IFDEF CMNWEBLIB}
  {$IFNDEF LCLWEBLIB}
  rc: TRect;
  dChecked: Cardinal;
  hth: HTHEME;
  ThemeStyle: DWord;
  {$ENDIF}
  {$IFDEF LCLWEBLIB}
  g: TAdvChartGraphics;
  {$ENDIF}
  {$IFDEF VCLSTYLESENABLED}
  lDetails: TThemedElementDetails;
  {$ENDIF}
  bmp: TBitmap;
  sc: Single;
{$ENDIF}
begin
  {$IFDEF CMNWEBLIB}
  sc := ResourceScaleFactor;
  {$ENDIF}

  if Assigned(FDownBtn) then
  begin
    FDownBtn.Free;
    FDownBtn := nil;
  end;

  if Assigned(FNormalBtn) then
  begin
    FNormalBtn.Free;
    FNormalBtn := nil;
  end;

  if Assigned(FDownFocusBtn) then
  begin
    FDownFocusBtn.Free;
    FDownFocusBtn := nil;
  end;

  if Assigned(FNormalFocusBtn) then
  begin
    FNormalFocusBtn.Free;
    FNormalFocusBtn := nil;
  end;

  if Assigned(FNormalDisabledBtn) then
  begin
    FNormalDisabledBtn.Free;
    FNormalDisabledBtn := nil;
  end;

  {$IFDEF FMXLIB}
  btn := TButton.Create(Self);
  btn.Width := AWidth;
  btn.Height := AHeight;
  btn.Text := '';
  btn.Parent := Self;
  btn.StaysPressed := True;
  btn.IsPressed := False;
  btn.NeedStyleLookup;
  btn.ApplyStyleLookup;

  TurnOffAnimation(btn);
  FNormalBtn := btn.MakeScreenshot;
  btn.IsPressed := true;
  FDownBtn := btn.MakeScreenshot;
  btn.Enabled := False;
  btn.IsPressed := False;
  FNormalDisabledBtn := btn.MakeScreenshot;
  btn.Enabled := True;

  f := TAdvChartUtils.GetParentForm(Self);
  fo := nil;
  if Assigned(f) then
    fo := f.Focused;

  btn.SetFocus;
  btn.IsPressed := false;
  FNormalFocusBtn := btn.MakeScreenshot;
  btn.IsPressed := true;
  FDownFocusBtn := btn.MakeScreenshot;
  btn.Parent := nil;
  btn.Free;

  if Assigned(fo) then
    fo.SetFocus;
  {$ENDIF}

  {$IFDEF CMNWEBLIB}
  bmp := TBitmap.Create;
  {$IFDEF VCLLIB}
  rc := Bounds(0, 0, Round(AWidth * sc), Round(AHeight * sc));
  {$ENDIF}
  {$IFDEF LCLWEBLIB}
  g := TAdvChartGraphics.Create(bmp.Canvas);
  {$ENDIF}
  try
    {$IFNDEF WEBLIB}
    bmp.PixelFormat := pf24bit;
    bmp.TransparentMode := tmFixed;
    bmp.Transparent := True;
    bmp.TransparentColor := GetTransparentColor;
    {$ENDIF}
    bmp.SetSize(Round(AWidth * sc), Round(AHeight * sc));

    FNormalBtn := TAdvChartBitmap.Create;
    FNormalBtn.OnChange := DoBitmapChanged;

    {$IFDEF VCLLIB}
    bmp.Canvas.Brush.Color := GetTransparentColor;
    bmp.Canvas.Brush.Style := bsSolid;
    bmp.Canvas.FillRect(rc);

    {$IFDEF VCLSTYLESENABLED}
    if TAdvChartStyles.StyleServicesEnabled then
    begin
      lDetails := StyleServices.GetElementDetails(ttbButtonNormal);
      StyleServices.DrawElement(bmp.Canvas.Handle, lDetails, rc, nil, Round(96*sc));
    end
    else
    {$ENDIF}
    begin
      DChecked := DFCS_BUTTONPUSH;
      ThemeStyle := PBS_NORMAL;
      if IsThemeActive and Self.HandleAllocated then
      begin
        if Assigned(OpenThemeDataForDpi) then
          hth := OpenThemeDataForDpi(Self.Handle,'button', Round(96*sc))
        else
          hth := OpenThemeData(Self.Handle, 'button');
        DrawThemeBackground(hth, bmp.Canvas.Handle, BP_PUSHBUTTON, ThemeStyle,@rc,nil);
        CloseThemeData(hth);
      end
      else
        DrawFrameControl(bmp.Canvas.Handle,rc, DFC_BUTTON, DChecked);
    end;
    {$ENDIF}
    {$IFDEF LCLWEBLIB}
    g.Fill.Kind := gfkSolid;
    g.Fill.Color := gcWhite;
    g.Stroke.Kind := gskSolid;
    g.Stroke.Color := gcWhite;
    g.DrawRectangle(RectF(0, 0, bmp.Width, bmp.Height));
    g.DrawButton(RectF(0, 0, bmp.Width, bmp.Height), False, False, True, AdaptToStyle);
    {$ENDIF}

    FNormalBtn.Assign(bmp);

    FDownBtn := TAdvChartBitmap.Create;
    FDownBtn.OnChange := DoBitmapChanged;

    {$IFDEF VCLLIB}
    bmp.Canvas.Brush.Color := GetTransparentColor;
    bmp.Canvas.Brush.Style := bsSolid;
    bmp.Canvas.FillRect(rc);

    {$IFDEF VCLSTYLESENABLED}
    if TAdvChartStyles.StyleServicesEnabled then
    begin
      lDetails := StyleServices.GetElementDetails(ttbButtonPressed);
      StyleServices.DrawElement(bmp.Canvas.Handle, lDetails, rc, nil, Round(96*sc));
    end
    else
    {$ENDIF}
    begin
      DChecked := DFCS_BUTTONPUSH or DFCS_PUSHED;
      ThemeStyle := PBS_PRESSED;
      if IsThemeActive and Self.HandleAllocated then
      begin
        if Assigned(OpenThemeDataForDpi) then
          hth := OpenThemeDataForDpi(Self.Handle,'button', Round(96*sc))
        else
          hth := OpenThemeData(Self.Handle, 'button');
        DrawThemeBackground(hth, bmp.Canvas.Handle, BP_PUSHBUTTON, ThemeStyle,@rc,nil);
        CloseThemeData(hth);
      end
      else
        DrawFrameControl(bmp.Canvas.Handle,rc, DFC_BUTTON, DChecked);
    end;
    {$ENDIF}
    {$IFDEF LCLWEBLIB}
    g.Fill.Kind := gfkSolid;
    g.Fill.Color := gcWhite;
    g.Stroke.Kind := gskSolid;
    g.Stroke.Color := gcWhite;
    g.DrawRectangle(RectF(0, 0, bmp.Width, bmp.Height));
    g.DrawButton(RectF(0, 0, bmp.Width, bmp.Height), True, False, True, AdaptToStyle);
    {$ENDIF}

    FDownBtn.Assign(bmp);

    FNormalFocusBtn := TAdvChartBitmap.Create;
    FNormalFocusBtn.OnChange := DoBitmapChanged;

    {$IFDEF VCLLIB}
    bmp.Canvas.Brush.Color := GetTransparentColor;
    bmp.Canvas.Brush.Style := bsSolid;
    bmp.Canvas.FillRect(rc);

    {$IFDEF VCLSTYLESENABLED}
    if TAdvChartStyles.StyleServicesEnabled then
    begin
      lDetails := StyleServices.GetElementDetails(ttbButtonHot);
      StyleServices.DrawElement(bmp.Canvas.Handle, lDetails, rc, nil, Round(96*sc));
    end
    else
    {$ENDIF}
    begin
      DChecked := DFCS_BUTTONPUSH or DFCS_HOT;
      ThemeStyle := PBS_HOT;
      if IsThemeActive and Self.HandleAllocated then
      begin
        if Assigned(OpenThemeDataForDpi) then
          hth := OpenThemeDataForDpi(Self.Handle,'button', Round(96*sc))
        else
          hth := OpenThemeData(Self.Handle, 'button');
        DrawThemeBackground(hth, bmp.Canvas.Handle, BP_PUSHBUTTON, ThemeStyle,@rc,nil);
        CloseThemeData(hth);
      end
      else
        DrawFrameControl(bmp.Canvas.Handle,rc, DFC_BUTTON, DChecked);
    end;
    {$ENDIF}
    {$IFDEF LCLWEBLIB}
    g.Fill.Kind := gfkSolid;
    g.Fill.Color := gcWhite;
    g.Stroke.Kind := gskSolid;
    g.Stroke.Color := gcWhite;
    g.DrawRectangle(RectF(0, 0, bmp.Width, bmp.Height));
    g.DrawButton(RectF(0, 0, bmp.Width, bmp.Height), True, True, True, AdaptToStyle);
    {$ENDIF}

    FNormalFocusBtn.Assign(bmp);

    FDownFocusBtn := TAdvChartBitmap.Create;
    FDownFocusBtn.OnChange := DoBitmapChanged;

    {$IFDEF VCLLIB}
    bmp.Canvas.Brush.Color := GetTransparentColor;
    bmp.Canvas.Brush.Style := bsSolid;
    bmp.Canvas.FillRect(rc);

    {$IFDEF VCLSTYLESENABLED}
    if TAdvChartStyles.StyleServicesEnabled then
    begin
      lDetails := StyleServices.GetElementDetails(ttbButtonPressed);
      StyleServices.DrawElement(bmp.Canvas.Handle, lDetails, rc, nil, Round(96*sc));
    end
    else
    {$ENDIF}
    begin
      DChecked := DFCS_BUTTONPUSH or DFCS_PUSHED or DFCS_HOT;
      ThemeStyle := PBS_HOT or PBS_PRESSED;
      if IsThemeActive and Self.HandleAllocated then
      begin
        if Assigned(OpenThemeDataForDpi) then
          hth := OpenThemeDataForDpi(Self.Handle,'button', Round(96*sc))
        else
          hth := OpenThemeData(Self.Handle, 'button');
        DrawThemeBackground(hth, bmp.Canvas.Handle, BP_PUSHBUTTON, ThemeStyle,@rc,nil);
        CloseThemeData(hth);
      end
      else
        DrawFrameControl(bmp.Canvas.Handle,rc, DFC_BUTTON, DChecked);
    end;
    {$ENDIF}
    {$IFDEF LCLWEBLIB}
    g.Fill.Kind := gfkSolid;
    g.Fill.Color := gcWhite;
    g.Stroke.Kind := gskSolid;
    g.Stroke.Color := gcWhite;
    g.DrawRectangle(RectF(0, 0, bmp.Width, bmp.Height));
    g.DrawButton(RectF(0, 0, bmp.Width, bmp.Height), False, True, True, AdaptToStyle);
    {$ENDIF}

    FDownFocusBtn.Assign(bmp);

    FNormalDisabledBtn := TAdvChartBitmap.Create;
    FNormalDisabledBtn.OnChange := DoBitmapChanged;

    {$IFDEF VCLLIB}
    bmp.Canvas.Brush.Color := GetTransparentColor;
    bmp.Canvas.Brush.Style := bsSolid;
    bmp.Canvas.FillRect(rc);

    {$IFDEF VCLSTYLESENABLED}
    if TAdvChartStyles.StyleServicesEnabled then
    begin
      lDetails := StyleServices.GetElementDetails(ttbButtonDisabled);
      StyleServices.DrawElement(bmp.Canvas.Handle, lDetails, rc, nil, Round(96*sc));
    end
    else
    {$ENDIF}
    begin
      DChecked := DFCS_BUTTONPUSH or DFCS_INACTIVE;
      ThemeStyle := PBS_DISABLED;
      if IsThemeActive and Self.HandleAllocated then
      begin
        if Assigned(OpenThemeDataForDpi) then
          hth := OpenThemeDataForDpi(Self.Handle,'button', Round(96*sc))
        else
          hth := OpenThemeData(Self.Handle, 'button');
        DrawThemeBackground(hth, bmp.Canvas.Handle, BP_PUSHBUTTON, ThemeStyle,@rc,nil);
        CloseThemeData(hth);
      end
      else
        DrawFrameControl(bmp.Canvas.Handle,rc, DFC_BUTTON, DChecked);
    end;
    {$ENDIF}
    {$IFDEF LCLWEBLIB}
    g.Fill.Kind := gfkSolid;
    g.Fill.Color := gcWhite;
    g.Stroke.Kind := gskSolid;
    g.Stroke.Color := gcWhite;
    g.DrawRectangle(RectF(0, 0, bmp.Width, bmp.Height));
    g.DrawButton(RectF(0, 0, bmp.Width, bmp.Height), False, False, False, AdaptToStyle);
    {$ENDIF}

    FNormalDisabledBtn.Assign(bmp);
  finally
    {$IFDEF LCLWEBLIB}
    g.Free;
    {$ENDIF}
    bmp.Free;
  end;
  {$ENDIF}
end;

procedure TAdvChartCustomControl.CreateRadioButtonBitmaps;
var
{$IFDEF FMXLIB}
  Rd: TRadioButton;
  f: TCommonCustomForm;
  fo: IControl;
{$ENDIF}
{$IFDEF CMNWEBLIB}
  {$IFNDEF LCLWEBLIB}
  rc: TRect;
  dChecked: Cardinal;
  hth: HTHEME;
  ThemeStyle: DWord;
  {$ENDIF}
  {$IFDEF LCLWEBLIB}
  g: TAdvChartGraphics;
  {$ENDIF}
  {$IFDEF VCLSTYLESENABLED}
  lDetails: TThemedElementDetails;
  {$ENDIF}
  bmp: TBitmap;
  sc: Single;
{$ENDIF}
begin
  {$IFDEF CMNWEBLIB}
  sc := ResourceScaleFactor;
  {$ENDIF}

  if Assigned(FCheckedFocusRd) then
  begin
    FCheckedFocusRd.Free;
    FCheckedFocusRd := nil;
  end;

  if Assigned(FUnCheckedRd) then
  begin
    FUnCheckedRd.Free;
    FUnCheckedRd := nil;
  end;

  if Assigned(FCheckedRd) then
  begin
    FCheckedRd.Free;
    FCheckedRd := nil;
  end;

  if Assigned(FUnCheckedFocusRd) then
  begin
    FUnCheckedFocusRd.Free;
    FUnCheckedFocusRd := nil;
  end;

  if Assigned(FUnCheckedDisabledRd) then
  begin
    FUnCheckedDisabledRd.Free;
    FUnCheckedDisabledRd := nil;
  end;

  if Assigned(FCheckedDisabledRd) then
  begin
    FCheckedDisabledRd.Free;
    FCheckedDisabledRd := nil;
  end;

  {$IFDEF FMXLIB}
  Rd := TRadioButton.Create(Self);
  Rd.Width := Rd.Height;
  Rd.Text := '';
  Rd.Parent := Self;
  Rd.IsChecked := false;
  Rd.NeedStyleLookup;
  Rd.ApplyStyleLookup;

  {$IFDEF FMXMOBILE}
  Rd.Width := 25;
  Rd.Height := 25;
  {$ENDIF}

  TurnOffAnimation(Rd);
  FUnCheckedRd := Rd.MakeScreenshot;
  Rd.IsChecked := true;
  FCheckedRd := Rd.MakeScreenshot;
  Rd.Enabled := False;
  Rd.IsChecked := False;
  FUnCheckedDisabledRd := Rd.MakeScreenshot;
  Rd.IsChecked := true;
  FCheckedDisabledRd := Rd.MakeScreenshot;
  Rd.Enabled := True;

  f := TAdvChartUtils.GetParentForm(Self);
  fo := nil;
  if Assigned(f) then
    fo := f.Focused;

  Rd.SetFocus;
  Rd.IsChecked := false;
  FUnCheckedFocusRd := Rd.MakeScreenshot;
  Rd.IsChecked := true;
  FCheckedFocusRd := Rd.MakeScreenshot;
  Rd.Parent := nil;
  Rd.Free;

  if Assigned(fo) then
    fo.SetFocus;
  {$ENDIF}

  {$IFDEF CMNWEBLIB}
  bmp := TBitmap.Create;
  {$IFDEF VCLLIB}
  rc := Bounds(0, 0, Round(16 * sc), Round(16 * sc));
  {$ENDIF}
  {$IFDEF LCLWEBLIB}
  g := TAdvChartGraphics.Create(bmp.Canvas);
  {$ENDIF}
  try
    {$IFNDEF WEBLIB}
    bmp.PixelFormat := pf24bit;
    bmp.TransparentMode := tmFixed;
    bmp.Transparent := True;
    bmp.TransparentColor := GetTransparentColor;
    {$ENDIF}
    bmp.SetSize(Round(16 * sc), Round(16 * sc));

    FUnCheckedRd := TAdvChartBitmap.Create;
    FUnCheckedRd.OnChange := DoBitmapChanged;

    {$IFDEF VCLLIB}
    bmp.Canvas.Brush.Color := GetTransparentColor;
    bmp.Canvas.Brush.Style := bsSolid;
    bmp.Canvas.FillRect(rc);

    {$IFDEF VCLSTYLESENABLED}
    if TAdvChartStyles.StyleServicesEnabled then
    begin
      lDetails := StyleServices.GetElementDetails(tbRadioButtonUncheckedNormal);
      StyleServices.DrawElement(bmp.Canvas.Handle, lDetails, rc, nil, Round(96*sc));
    end
    else
    {$ENDIF}
    begin
      DChecked := DFCS_BUTTONRADIO;
      ThemeStyle := RBS_UNCHECKEDNORMAL;
      if IsThemeActive and Self.HandleAllocated then
      begin
        if Assigned(OpenThemeDataForDpi) then
          hth := OpenThemeDataForDpi(Self.Handle,'button', Round(96*sc))
        else
          hth := OpenThemeData(Self.Handle, 'button');
        DrawThemeBackground(hth, bmp.Canvas.Handle, BP_RADIOBUTTON, ThemeStyle,@rc,nil);
        CloseThemeData(hth);
      end
      else
        DrawFrameControl(bmp.Canvas.Handle,rc,DFC_BUTTON, DChecked);
    end;
    {$ENDIF}
    {$IFDEF LCLWEBLIB}
    g.Fill.Kind := gfkSolid;
    g.Fill.Color := gcWhite;
    g.Stroke.Kind := gskSolid;
    g.Stroke.Color := gcWhite;
    g.DrawRectangle(RectF(0, 0, bmp.Width, bmp.Height));
    g.DrawRadioButton(RectF(0, 0, bmp.Width, bmp.Height), False, False, True);
    {$ENDIF}

    FUnCheckedRd.Assign(bmp);

    FCheckedRd := TAdvChartBitmap.Create;
    FCheckedRd.OnChange := DoBitmapChanged;

    {$IFDEF VCLLIB}
    bmp.Canvas.Brush.Color := GetTransparentColor;
    bmp.Canvas.Brush.Style := bsSolid;
    bmp.Canvas.FillRect(rc);

    {$IFDEF VCLSTYLESENABLED}
    if TAdvChartStyles.StyleServicesEnabled then
    begin
      lDetails := StyleServices.GetElementDetails(tbRadioButtonCheckedNormal);
      StyleServices.DrawElement(bmp.Canvas.Handle, lDetails, rc, nil, Round(96*sc));
    end
    else
    {$ENDIF}
    begin
      DChecked := DFCS_BUTTONRADIO or DFCS_CHECKED;
      ThemeStyle := RBS_CHECKEDNORMAL;
      if IsThemeActive and Self.HandleAllocated then
      begin
        if Assigned(OpenThemeDataForDpi) then
          hth := OpenThemeDataForDpi(Self.Handle,'button', Round(96*sc))
        else
          hth := OpenThemeData(Self.Handle, 'button');
        DrawThemeBackground(hth, bmp.Canvas.Handle, BP_RADIOBUTTON, ThemeStyle,@rc,nil);
        CloseThemeData(hth);
      end
      else
        DrawFrameControl(bmp.Canvas.Handle,rc,DFC_BUTTON, DChecked);
    end;
    {$ENDIF}
    {$IFDEF LCLWEBLIB}
    g.Fill.Kind := gfkSolid;
    g.Fill.Color := gcWhite;
    g.Stroke.Kind := gskSolid;
    g.Stroke.Color := gcWhite;
    g.DrawRectangle(RectF(0, 0, bmp.Width, bmp.Height));
    g.DrawRadioButton(RectF(0, 0, bmp.Width, bmp.Height), True, False, True);
    {$ENDIF}

    FCheckedRd.Assign(bmp);

    FUnCheckedFocusRd := TAdvChartBitmap.Create;
    FUnCheckedFocusRd.OnChange := DoBitmapChanged;

    {$IFDEF VCLLIB}
    bmp.Canvas.Brush.Color := GetTransparentColor;
    bmp.Canvas.Brush.Style := bsSolid;
    bmp.Canvas.FillRect(rc);

    {$IFDEF VCLSTYLESENABLED}
    if TAdvChartStyles.StyleServicesEnabled then
    begin
      lDetails := StyleServices.GetElementDetails(tbRadioButtonUncheckedHot);
      StyleServices.DrawElement(bmp.Canvas.Handle, lDetails, rc, nil, Round(96*sc));
    end
    else
    {$ENDIF}
    begin
      DChecked := DFCS_BUTTONRADIO or DFCS_HOT;
      ThemeStyle := RBS_UNCHECKEDHOT;
      if IsThemeActive and Self.HandleAllocated then
      begin
        if Assigned(OpenThemeDataForDpi) then
          hth := OpenThemeDataForDpi(Self.Handle,'button', Round(96*sc))
        else
          hth := OpenThemeData(Self.Handle, 'button');
        DrawThemeBackground(hth, bmp.Canvas.Handle, BP_RADIOBUTTON, ThemeStyle,@rc,nil);
        CloseThemeData(hth);
      end
      else
        DrawFrameControl(bmp.Canvas.Handle,rc,DFC_BUTTON, DChecked);
    end;
    {$ENDIF}
    {$IFDEF LCLWEBLIB}
    g.Fill.Kind := gfkSolid;
    g.Fill.Color := gcWhite;
    g.Stroke.Kind := gskSolid;
    g.Stroke.Color := gcWhite;
    g.DrawRectangle(RectF(0, 0, bmp.Width, bmp.Height));
    g.DrawRadioButton(RectF(0, 0, bmp.Width, bmp.Height), False, True, True);
    {$ENDIF}

    FUnCheckedFocusRd.Assign(bmp);

    FCheckedFocusRd := TAdvChartBitmap.Create;
    FCheckedFocusRd.OnChange := DoBitmapChanged;

    {$IFDEF VCLLIB}
    bmp.Canvas.Brush.Color := GetTransparentColor;
    bmp.Canvas.Brush.Style := bsSolid;
    bmp.Canvas.FillRect(rc);

    {$IFDEF VCLSTYLESENABLED}
    if TAdvChartStyles.StyleServicesEnabled then
    begin
      lDetails := StyleServices.GetElementDetails(tbRadioButtonCheckedHot);
      StyleServices.DrawElement(bmp.Canvas.Handle, lDetails, rc, nil, Round(96*sc));
    end
    else
    {$ENDIF}
    begin
      DChecked := DFCS_BUTTONRADIO or DFCS_CHECKED or DFCS_HOT;
      ThemeStyle := RBS_CHECKEDHOT;
      if IsThemeActive and Self.HandleAllocated then
      begin
        if Assigned(OpenThemeDataForDpi) then
          hth := OpenThemeDataForDpi(Self.Handle,'button', Round(96*sc))
        else
          hth := OpenThemeData(Self.Handle, 'button');
        DrawThemeBackground(hth, bmp.Canvas.Handle, BP_RADIOBUTTON, ThemeStyle,@rc,nil);
        CloseThemeData(hth);
      end
      else
        DrawFrameControl(bmp.Canvas.Handle,rc,DFC_BUTTON, DChecked);
    end;
    {$ENDIF}
    {$IFDEF LCLWEBLIB}
    g.Fill.Kind := gfkSolid;
    g.Fill.Color := gcWhite;
    g.Stroke.Kind := gskSolid;
    g.Stroke.Color := gcWhite;
    g.DrawRectangle(RectF(0, 0, bmp.Width, bmp.Height));
    g.DrawRadioButton(RectF(0, 0, bmp.Width, bmp.Height), True, True, True);
    {$ENDIF}

    FCheckedFocusRd.Assign(bmp);

    FUnCheckedDisabledRd := TAdvChartBitmap.Create;
    FUnCheckedDisabledRd.OnChange := DoBitmapChanged;

    {$IFDEF VCLLIB}
    bmp.Canvas.Brush.Color := GetTransparentColor;
    bmp.Canvas.Brush.Style := bsSolid;
    bmp.Canvas.FillRect(rc);

    {$IFDEF VCLSTYLESENABLED}
    if TAdvChartStyles.StyleServicesEnabled then
    begin
      lDetails := StyleServices.GetElementDetails(tbRadioButtonUncheckedDisabled);
      StyleServices.DrawElement(bmp.Canvas.Handle, lDetails, rc, nil, Round(96*sc));
    end
    else
    {$ENDIF}
    begin
      DChecked := DFCS_BUTTONRADIO or DFCS_INACTIVE;
      ThemeStyle := RBS_UNCHECKEDDISABLED;
      if IsThemeActive and Self.HandleAllocated then
      begin
        if Assigned(OpenThemeDataForDpi) then
          hth := OpenThemeDataForDpi(Self.Handle,'button', Round(96*sc))
        else
          hth := OpenThemeData(Self.Handle, 'button');
        DrawThemeBackground(hth, bmp.Canvas.Handle, BP_RADIOBUTTON, ThemeStyle,@rc,nil);
        CloseThemeData(hth);
      end
      else
        DrawFrameControl(bmp.Canvas.Handle,rc,DFC_BUTTON, DChecked);
    end;
    {$ENDIF}
    {$IFDEF LCLWEBLIB}
    g.Fill.Kind := gfkSolid;
    g.Fill.Color := gcWhite;
    g.Stroke.Kind := gskSolid;
    g.Stroke.Color := gcWhite;
    g.DrawRectangle(RectF(0, 0, bmp.Width, bmp.Height));
    g.DrawRadioButton(RectF(0, 0, bmp.Width, bmp.Height), False, False, False);
    {$ENDIF}

    FUnCheckedDisabledRd.Assign(bmp);

    FCheckedDisabledRd := TAdvChartBitmap.Create;
    FCheckedDisabledRd.OnChange := DoBitmapChanged;

    {$IFDEF VCLLIB}
    bmp.Canvas.Brush.Color := GetTransparentColor;
    bmp.Canvas.Brush.Style := bsSolid;
    bmp.Canvas.FillRect(rc);

    {$IFDEF VCLSTYLESENABLED}
    if TAdvChartStyles.StyleServicesEnabled then
    begin
      lDetails := StyleServices.GetElementDetails(tbRadioButtonCheckedDisabled);
      StyleServices.DrawElement(bmp.Canvas.Handle, lDetails, rc, nil, Round(96*sc));
    end
    else
    {$ENDIF}
    begin
      DChecked := DFCS_BUTTONRADIO or DFCS_CHECKED or DFCS_INACTIVE;
      ThemeStyle := RBS_CHECKEDDISABLED;
      if IsThemeActive and Self.HandleAllocated then
      begin
        if Assigned(OpenThemeDataForDpi) then
          hth := OpenThemeDataForDpi(Self.Handle,'button', Round(96*sc))
        else
          hth := OpenThemeData(Self.Handle, 'button');
        DrawThemeBackground(hth, bmp.Canvas.Handle, BP_RADIOBUTTON, ThemeStyle,@rc,nil);
        CloseThemeData(hth);
      end
      else
        DrawFrameControl(bmp.Canvas.Handle,rc,DFC_BUTTON, DChecked);
    end;
    {$ENDIF}
    {$IFDEF LCLWEBLIB}
    g.Fill.Kind := gfkSolid;
    g.Fill.Color := gcWhite;
    g.Stroke.Kind := gskSolid;
    g.Stroke.Color := gcWhite;
    g.DrawRectangle(RectF(0, 0, bmp.Width, bmp.Height));
    g.DrawRadioButton(RectF(0, 0, bmp.Width, bmp.Height), True, False, False);
    {$ENDIF}

    FCheckedDisabledRd.Assign(bmp);
  finally
    {$IFDEF LCLWEBLIB}
    g.Free;
    {$ENDIF}
    bmp.Free;
  end;
  {$ENDIF}
end;

function TAdvChartCustomControl.GetButtonBitmap(AWidth, AHeight: Single; ADown: Boolean = False; AFocused: Boolean = False; AEnabled: Boolean = True): TAdvChartBitmapHelperClass;
begin
  CreateButtonBitmaps(AWidth, AHeight);

  if ADown then
  begin
    if AEnabled then
    begin
      if AFocused then
        Result := FDownFocusBtn
      else
        Result := FDownBtn;
    end
    else
      Result := FNormalDisabledBtn;
  end
  else
  begin
    if AEnabled then
    begin
      if AFocused then
        Result := FNormalFocusBtn
      else
        Result := FNormalBtn;
    end
    else
      Result := FNormalDisabledBtn;
  end;
end;

function TAdvChartCustomControl.GetCheckBoxBitmap(AChecked: Boolean; AFocused: Boolean; AEnabled: Boolean): TAdvChartBitmapHelperClass;
begin
  if (not Assigned(FCheckedChk) or not Assigned(FCheckedFocusChk) or not Assigned(FUnCheckedChk)
    or not Assigned(FUnCheckedFocusChk) or not Assigned(FCheckedDisabledChk) or not Assigned(FUnCheckedDisabledChk)) then
    CreateCheckBoxBitmaps;

  if AChecked then
  begin
    if AEnabled then
    begin
      if AFocused then
        Result := FCheckedFocusChk
      else
        Result := FCheckedChk;
    end
    else
      Result := FCheckedDisabledChk;
  end
  else
  begin
    if AEnabled then
    begin
      if AFocused then
        Result := FUnCheckedFocusChk
      else
        Result := FUnCheckedChk;
    end
    else
      Result := FUnCheckedDisabledChk;
  end;
end;

function TAdvChartCustomControl.GetRadioButtonBitmap(AChecked: Boolean; AFocused: Boolean; AEnabled: Boolean): TAdvChartBitmapHelperClass;
begin
  if (not Assigned(FCheckedRd) or not Assigned(FCheckedFocusRd) or not Assigned(FUnCheckedRd)
    or not Assigned(FUnCheckedFocusRd) or not Assigned(FCheckedDisabledRd) or not Assigned(FUnCheckedDisabledRd)) then
    CreateRadioButtonBitmaps;

  if AChecked then
  begin
    if AEnabled then
    begin
      if AFocused then
        Result := FCheckedFocusRd
      else
        Result := FCheckedRd;
    end
    else
      Result := FCheckedDisabledRd;
  end
  else
  begin
    if AEnabled then
    begin
      if AFocused then
        Result := FUnCheckedFocusRd
      else
        Result := FUnCheckedRd;
    end
    else
      Result := FUnCheckedDisabledRd;
  end;
end;

function TAdvChartCustomControl.IsDesignTime: Boolean;
begin
  Result := False;
  if Assigned(Owner) then
    Result := (csDesigning in ComponentState) and not ((csReading in Owner.ComponentState) or (csLoading in Owner.ComponentState));
end;

function TAdvChartCustomControl.IsReading: Boolean;
begin
  Result := False;
  if Assigned(Owner) then
    Result := (csReading in Owner.ComponentState);
end;

function TAdvChartCustomControl.IsDesigning: Boolean;
begin
  Result := (csDesigning in ComponentState);
end;

function TAdvChartCustomControl.IsDesignerForm: Boolean;
var
  frm: TCustomForm;
begin
  frm := TAdvChartUtils.GetOwnerForm(Self);
  Result := IsDesigning;
  if Assigned(frm) then
    Result := Result or (frm is TAdvChartCustomDesignerForm);
end;

function TAdvChartCustomControl.IsDestroying: Boolean;
begin
  Result := (csDestroying in ComponentState);
end;

function TAdvChartCustomControl.IsLoading: Boolean;
begin
  Result := False;
  if Assigned(Owner) then
    Result := (csLoading in Owner.ComponentState)
end;

procedure TAdvChartCustomControl.ResetToDefaultStyle;
begin
  inherited;
  Fill.Color := gcWhite;
  Stroke.Color := gcSilver;
end;

procedure TAdvChartCustomControl.ChangeDPIScale({%H-}M, {%H-}D: Integer);
begin
  inherited;
  if not IsLoading then
  begin
    CreateCheckBoxBitmaps;
    CreateRadioButtonBitmaps;
  end;
end;

procedure TAdvChartCustomControl.RegisterRuntimeClasses;
begin

end;

procedure TAdvChartCustomControl.&Export({%H-}AGraphics: TAdvChartGraphics; {%H-}ARect: TRectF);
begin
  FExporting := True;
  FExportRect := ARect;
  BeforeExport;
  Draw(AGraphics, ARect);
  FExporting := False;
  AfterExport;
end;

procedure TAdvChartCustomControl.ApplyStyle;
var
  c: TAdvChartGraphicsColor;
begin
  inherited;
  c := gcNull;
  if TAdvChartStyles.GetStyleBackgroundFillColor(c) then
    Fill.Color := c;

  c := gcNull;
  if TAdvChartStyles.GetStyleLineFillColor(c) then
    Stroke.Color := c;
end;

procedure TAdvChartCustomControl.DestroyGraphicElements;
begin
  if Assigned(FDownBtn) then
  begin
    FDownBtn.Free;
    FDownBtn := nil;
  end;

  if Assigned(FNormalBtn) then
  begin
    FNormalBtn.Free;
    FNormalBtn := nil;
  end;

  if Assigned(FDownFocusBtn) then
  begin
    FDownFocusBtn.Free;
    FDownFocusBtn := nil;
  end;

  if Assigned(FNormalFocusBtn) then
  begin
    FNormalFocusBtn.Free;
    FNormalFocusBtn := nil;
  end;

  if Assigned(FNormalDisabledBtn) then
  begin
    FNormalDisabledBtn.Free;
    FNormalDisabledBtn := nil;
  end;

  if Assigned(FCheckedChk) then
  begin
    FCheckedChk.Free;
    FCheckedChk := nil;
  end;

  if Assigned(FCheckedFocusChk) then
  begin
    FCheckedFocusChk.Free;
    FCheckedFocusChk := nil;
  end;

  if Assigned(FUnCheckedDisabledChk) then
  begin
    FUnCheckedDisabledChk.Free;
    FUnCheckedDisabledChk := nil;
  end;

  if Assigned(FCheckedDisabledChk) then
  begin
    FCheckedDisabledChk.Free;
    FCheckedDisabledChk := nil;
  end;

  if Assigned(FUnCheckedChk) then
  begin
    FUnCheckedChk.Free;
    FUnCheckedChk := nil;
  end;

  if Assigned(FUnCheckedFocusChk) then
  begin
    FUnCheckedFocusChk.Free;
    FUnCheckedFocusChk := nil;
  end;

  if Assigned(FCheckedRd) then
  begin
    FCheckedRd.Free;
    FCheckedRd := nil;
  end;

  if Assigned(FCheckedFocusRd) then
  begin
    FCheckedFocusRd.Free;
    FCheckedFocusRd := nil;
  end;

  if Assigned(FUnCheckedRd) then
  begin
    FUnCheckedRd.Free;
    FUnCheckedRd := nil;
  end;

  if Assigned(FUnCheckedFocusRd) then
  begin
    FUnCheckedFocusRd.Free;
    FUnCheckedFocusRd := nil;
  end;

  if Assigned(FUnCheckedDisabledRd) then
  begin
    FUnCheckedDisabledRd.Free;
    FUnCheckedDisabledRd := nil;
  end;

  if Assigned(FCheckedDisabledRd) then
  begin
    FCheckedDisabledRd.Free;
    FCheckedDisabledRd := nil;
  end;
end;

procedure TAdvChartCustomControl.AfterExport;
begin
end;

procedure TAdvChartCustomControl.BeforeExport;
begin
end;

function TAdvChartCustomControl.IsExporting: Boolean;
begin
  Result := FExporting;
end;

function TAdvChartCustomControl.GetLocalRect: TRectF;
begin
  if IsExporting then
    Result := FExportRect
  else
    Result := inherited;
end;

function TAdvChartCustomControl.GetControlRect: TRectF;
begin
  if IsExporting then
    Result := FExportRect
  else
    Result := RectF(0, 0, Width, Height);
end;

function TAdvChartCustomControl.GetContentRect: TRectF;
begin
  Result := GetControlRect;
end;

function TAdvChartCustomControl.GetVersion: String;
begin
  Result := '';
end;

function TAdvChartCustomControl.IsAppearanceProperty(AObject: TObject; APropertyName: string; APropertyType: TTypeKind): Boolean;
var
  Prop: TAdvPropertyInfo;
  pName, cn: string;
begin
  Result := False;
  Prop := GetPropInfo(AObject, APropertyName);
  if Assigned(Prop) then
  begin
    pName := TAdvChartPersistence.GetPropInfoName(Prop);

    cn := TAdvChartPersistence.GetPropInfoTypeName(Prop);
    Result := (cn = 'TAlphaColor') or (cn = 'TColor') or (cn = 'TGraphicsColor') or
      (cn = 'TAdvChartGraphicsFill') or (cn = 'TAdvChartGraphicsStroke') or (Pos('Appearance', pName) > 0);

    Result := Result or (APropertyName = 'Fill') or (APropertyName = 'Stroke') or (APropertyName = 'Font');
  end;
end;

function TAdvChartCustomControl.CanSaveProperty(AObject: TObject; APropertyName: string; APropertyType: TTypeKind): Boolean;
begin
  if (AObject = Self) and not BlockPersistenceInterface then
    Result := (TAdvChartUtils.IndexOfTextInArray(APropertyName, ExcludePropertyList) = -1)
  else
    Result := True;

  if FAppearancePersisting then
    Result := Result and IsAppearanceProperty(AObject, APropertyName, APropertyType);

  DoCanSaveProperty(AObject, APropertyName, APropertyType, Result);
end;

function TAdvChartCustomControl.CanLoadProperty(AObject: TObject; APropertyName: string; APropertyType: TTypeKind): Boolean;
begin
  if (AObject = Self) and not BlockPersistenceInterface then
    Result := (TAdvChartUtils.IndexOfTextInArray(APropertyName, ExcludePropertyList) = -1)
  else
    Result := True;

  DoCanLoadProperty(AObject, APropertyName, APropertyType, Result);
end;

procedure TAdvChartCustomControl.SaveSettingsToFile(AFileName: string; AAppearanceOnly: Boolean = False);
begin
  FAppearancePersisting := AAppearanceOnly;
  TAdvChartPersistence.SaveSettingsToFile(Self, AFileName);
  FAppearancePersisting := False;
end;

procedure TAdvChartCustomControl.LoadSettingsFromFile(AFileName: string);
begin
  BeginUpdate;
  TAdvChartPersistence.LoadSettingsFromFile(Self, AFileName);
  EndUpdate;
  Invalidate;
end;

procedure TAdvChartCustomControl.SaveSettingsToStream(AStream: TStreamEx; AAppearanceOnly: Boolean = False);
begin
  FAppearancePersisting := AAppearanceOnly;
  TAdvChartPersistence.SaveSettingsToStream(Self, AStream);
  FAppearancePersisting := False;
end;

procedure TAdvChartCustomControl.LoadSettingsFromStream(AStream: TStreamEx);
begin
  BeginUpdate;
  TAdvChartPersistence.LoadSettingsFromStream(Self, AStream);
  EndUpdate;
  Invalidate;
end;

function TAdvChartCustomControl.LocalToScreenEx(APoint: TPointF): TPointF;
{$IFDEF CMNWEBLIB}
var
  pt: TPoint;
{$ENDIF}
begin
  {$IFDEF FMXLIB}
  Result := LocalToScreen(APoint);
  {$ENDIF}
  {$IFDEF CMNWEBLIB}
  pt := ClientToScreen(Point(Round(APoint.X), Round(APoint.Y)));
  Result := PointF(pt.X, pt.Y);
  {$ENDIF}
end;

function TAdvChartCustomControl.ScreenToLocalEx(APoint: TPointF): TPointF;
{$IFDEF CMNWEBLIB}
var
  pt: TPoint;
{$ENDIF}
begin
  {$IFDEF FMXLIB}
  Result := ScreenToLocal(APoint);
  {$ENDIF}
  {$IFDEF CMNWEBLIB}
  pt := ScreenToClient(Point(Round(APoint.X), Round(APoint.Y)));
  Result := PointF(pt.X, pt.Y);
  {$ENDIF}
end;

{$IFDEF FMXLIB}
procedure TAdvChartCustomControl.TurnOffAnimation(chk: TFmxObject);
var
  I: Integer;
begin
  if Assigned(chk) then
  begin
    if chk is TAnimation then
      (chk as TAnimation).Duration := 0;

    for I := 0 to chk.ChildrenCount - 1 do
    begin
      TurnOffAnimation(chk.Children[I]);
    end;
  end;
end;
{$ENDIF}

procedure TAdvChartCustomControl.CaptureEx;
begin
  {$IFDEF FMXLIB}
  Capture;
  {$ENDIF}
  {$IFDEF VCLLIB}
  SetCapture(Self.Handle);
  {$ENDIF}
  {$IFDEF LCLLIB}
  MouseCapture := True;
  {$ENDIF}
  {$IFDEF WEBLIB}
  Capture;
  {$ENDIF}
end;

procedure TAdvChartCustomControl.ReleaseCaptureEx;
begin
  {$IFNDEF LCLLIB}
  {$IFNDEF WEBLIB}
  ReleaseCapture;
  {$ENDIF}
  {$ENDIF}
  {$IFDEF LCLLIB}
  MouseCapture := False;
  {$ENDIF}
  {$IFDEF WEBLIB}
  ReleaseCapture;
  {$ENDIF}
end;

function TAdvChartCustomControlBaseCommon.ScaleResourceValue(const Value: Integer): Integer;
begin
  Result := TAdvChartUtils.MulDivInt(Value, Round(FResourceScaleFactor * 100), 100);
end;

function TAdvChartCustomControlBaseCommon.ScaleResourceValue(const Value: Double): Double;
begin
  Result := Value * FResourceScaleFactor;
end;

{$IFDEF FMXLIB}
procedure TAdvChartCustomControlBaseCommon.SetEnabled(const Value: Boolean);
{$ENDIF}
{$IFNDEF FMXLIB}
procedure TAdvChartCustomControlBaseCommon.SetEnabled(Value: Boolean);
{$ENDIF}
begin
  inherited;

  Invalidate;
end;

function TAdvChartCustomControlBaseCommon.ScalePaintValue(const Value: Integer): Integer;
begin
  {$IFDEF FMXLIB}
  Result := Value;
  {$ELSE}
  Result := TAdvChartUtils.MulDivInt(Value, Round(FPaintScaleFactor * 100), 100);
  {$ENDIF}
end;

function TAdvChartCustomControlBaseCommon.ScalePaintValue(const Value: Double): Double;
begin
  {$IFDEF FMXLIB}
  Result := Value;
  {$ELSE}
  Result := Value * FPaintScaleFactor;
  {$ENDIF}
end;

procedure TAdvChartCustomControlBaseCommon.GetControlMargins(var ALeft: Single; var ATop: Single; var ARight: Single; var ABottom: Single);
begin
  {$IFNDEF LCLLIB}
  {$IFDEF VCLWEBLIB}
  if not AlignWithMargins then
    Exit;
  {$ENDIF}
  ALeft := Margins.Left;
  ATop := Margins.Top;
  ARight := Margins.Right;
  ABottom := Margins.Bottom;
  {$ENDIF}
  {$IFDEF LCLLIB}
  ALeft := BorderSpacing.Left;
  ATop := BorderSpacing.Top;
  ARight := BorderSpacing.Right;
  ABottom := BorderSpacing.Bottom;
  {$ENDIF}
end;

procedure TAdvChartCustomControlBaseCommon.SetControlMargins(ALeft: Single; ATop: Single; ARight: Single; ABottom: Single);
begin
  {$IFDEF FMXLIB}
  Margins.Left := ALeft;
  Margins.Top := ATop;
  Margins.Right := ARight;
  Margins.Bottom := ABottom;
  {$ENDIF}
  {$IFDEF VCLWEBLIB}
  AlignWithMargins := True;
  Margins.Left := Round(ALeft);
  Margins.Top := Round(ATop);
  Margins.Right := Round(ARight);
  Margins.Bottom := Round(ABottom);
  {$ENDIF}
  {$IFDEF LCLLIB}
  BorderSpacing.Left := Round(ALeft);
  BorderSpacing.Top := Round(ATop);
  BorderSpacing.Right := Round(ARight);
  BorderSpacing.Bottom := Round(ABottom);
  {$ENDIF}
end;

procedure TAdvChartCustomControlBaseCommon.BeginDrag;
{$IFDEF FMXLIB}
{$HINTS OFF}
{$IF COMPILERVERSION > 27}
var
  DragImage: TAdvChartBitmap;
begin
  DragImage := TAdvChartBitmap.Create;
  DragImage.Width := 1;
  DragImage.Height := 1;
  try
    Root.BeginInternalDrag(Self, DragImage);
  finally
    DragImage.Free;
  end;
{$IFEND}
{$IF COMPILERVERSION <= 27}
begin
{$IFEND}
{$HINTS ON}
{$ENDIF}
{$IFDEF CMNLIB}
begin
  inherited BeginDrag(True);
{$ENDIF}
{$IFDEF WEBLIB}
begin
{$ENDIF}
end;

{$IFDEF FMXLIB}
procedure TAdvChartCustomControlBaseCommon.CancelHint;
begin
  {$HINTS OFF}
  {$IF COMPILERVERSION > 29}
  Application.CancelHint;
  {$IFEND}
  {$HINTS ON}
end;
{$ENDIF}

function TAdvChartCustomControlBaseCommon.GetDragObjectScreenShot: TAdvChartBitmap;
begin
  Result := nil;
end;

{$IFDEF CMNWEBLIB}
procedure TAdvChartCustomControlBaseCommon.CancelHint;
begin
  {$IFNDEF WEBLIB}
  Application.CancelHint;
  {$ENDIF}
end;

function TAdvChartCustomControlBase.GetHintString: string;
begin
  Result := '';
end;

function TAdvChartCustomControlBase.HasHint: Boolean;
begin
  Result := False;
end;
{$ENDIF}

{$IFNDEF LCLWEBLIB}

{ FNCJSLibReferenceAttribute }

constructor FNCJSLibReferenceAttribute.Create(const AScrs: string);
begin
  inherited Create;
  FSrcs := AScrs;
end;

constructor FNCJSLibReferenceAttribute.Create(const AScrs, ACSSs: string);
begin
  Create(AScrs);
  FCSSs := ACSSs;
end;

constructor FNCJSLibReferenceAttribute.Create(const AScrs, ACSSs, AAttrs: string);
begin
  Create(AScrs, ACSSs);
  FAttrs := AAttrs;
end;

constructor FNCJSLibReferenceAttribute.Create(const AScrs, ACSSs, AAttrs, ADesc: string);
begin
  Create(AScrs, ACSSs, AAttrs);
  FDesc := ADesc;
end;

{$ENDIF}

{ TAdvControl }

procedure TAdvControl.RegisterRuntimeClasses;
begin
  inherited;
  RegisterClass(TAdvControl);
end;

{$IFDEF USETRIAL}
{$IFNDEF WEBLIB}
{$IFNDEF LCLLIB}
{$IFNDEF FMXMOBILE}
{$IFDEF FREEWARE}
const TMSPRODUCTOFFSET = 700;
{$I TMSProductTrial.inc}
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$ENDIF}

{$WARNINGS ON}

end.

