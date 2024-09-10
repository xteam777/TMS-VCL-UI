{********************************************************************}
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

unit AdvChartToolBar;

{$I TMSDEFS.inc}

{$IFDEF CMNLIB}
{$DEFINE CMNWEBLIB}
{$ENDIF}
{$IFDEF WEBLIB}
{$DEFINE CMNWEBLIB}
{$DEFINE VCLWEBLIB}
{$ENDIF}
{$IFDEF VCLLIB}
{$DEFINE VCLWEBLIB}
{$ENDIF}

interface

uses
  Classes, AdvChartGraphics, AdvChartPersistence, AdvChartStyles, AdvChartCustomControl, Controls, Types, AdvChartBitmapSelector,
  AdvChartPopup, AdvChartTypes, AdvChartBitmapContainer, StdCtrls, AdvChartColorSelector,
  {%H-}AdvChartToolBarRes, AdvChartGraphicsTypes
  {$IFNDEF LCLLIB}
  {$IFNDEF WEBLIB}
  ,UITypes, Generics.Collections, Generics.Defaults
  {$ENDIF}
  {$ENDIF}
  {$IFDEF FMXLIB}
  ,FMX.ListBox, FMX.Menus, FMX.Types, FMX.Edit
  {$ENDIF}
  {$IFDEF CMNWEBLIB}
  {$IFNDEF WEBLIB}
  ,Menus
  {$ENDIF}
  {$IFDEF WEBLIB}
  ,Contnrs, WEBLib.Menus
  {$ENDIF}
  ,ExtCtrls
  {$ENDIF}
  {$IFDEF LCLLIB}
  ,fgl
  {$ENDIF}
  ;

const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 0; // Minor version nr.
  REL_VER = 2; // Release nr.
  BLD_VER = 1; // Build nr.

  // version history
  // v1.0.0.0 : first release
  // v1.0.1.0 : New : DisabledBitmaps property
  // v1.0.1.1 : Fixed : Issue with DropDownButton on VCL
  // v1.0.1.2 : Fixed : Issue with bounds loop on LCL
  // v1.0.1.3 : Fixed : Issue with Tag property being overriden
  // v1.0.1.4 : Fixed : Issue with BitmapContainer not being given to internal TAdvChartBitmapSelector in TAdvChartToolBarBitmapPicker
  // v1.0.1.5 : Improved: Added onAnchorClick for HTML text in the TAdvToolBar
  // v1.0.1.6 : Fixed : Issue updating Visible property triggering multiple unnecessary UpdateToolBar calls
  //          : Improved : IsLoading check expanded checking for loading subcontrols
  // v1.0.1.7 : Fixed : Issue in Delphi 11 with begin and end scene for CreateBitmapCanvas
  //          : Fixed : Issue with compact toolbars not getting hidden in combination with TAdvRibbon
  // v1.0.2.0 : Improved : Support for Delphi 11 high dpi handling added
  // v1.0.2.1 : Fixed : Issue with realignment causing extreme slowness at designtime in FMX.

  {$IFDEF WEBLIB}
  AdvTOOLBAREXPANDSVG = 'data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIGhlaWdo'
                +'dD0iMTIiIHdpZHRoPSIxMCI+DQogIDxwYXRoIGQ9Ik0gMiA0IEwgNSA3IEwgOCA0IFoiIHN0eWxlPSJzdHJva2U6YmxhY2s7'
                +'c3Ryb2tlLXdpZHRoOjEiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgLz4NCjwvc3ZnPg==';
  {$ENDIF}

type
  TAdvChartCustomToolBar = class;
  TAdvChartCustomDockPanel = class;
  TAdvChartCustomToolBarSeparator = class;
  TAdvChartDefaultToolBarButton = class;
  TAdvChartToolBarButton = class;
  TAdvChartToolBarDropDownButton = class;

  TAdvChartToolBarCustomButtonAppearance = class(TPersistent)
  private
    FOwner: TAdvChartDefaultToolBarButton;
    FHoverStroke: TAdvChartGraphicsStroke;
    FDownFill: TAdvChartGraphicsFill;
    FNormalFill: TAdvChartGraphicsFill;
    FDownStroke: TAdvChartGraphicsStroke;
    FDisabledFill: TAdvChartGraphicsFill;
    FNormalStroke: TAdvChartGraphicsStroke;
    FDisabledStroke: TAdvChartGraphicsStroke;
    FHoverFill: TAdvChartGraphicsFill;
    FCorners: TAdvChartGraphicsCorners;
    FRounding: Single;
    FTransparent: Boolean;
    FShowInnerStroke: Boolean;
    FInnerStroke: TAdvChartGraphicsStroke;
    FFlatStyle: Boolean;
    FOnChange: TNotifyEvent;
    procedure SetDisabledFill(const Value: TAdvChartGraphicsFill);
    procedure SetDisabledStroke(const Value: TAdvChartGraphicsStroke);
    procedure SetDownFill(const Value: TAdvChartGraphicsFill);
    procedure SetDownStroke(const Value: TAdvChartGraphicsStroke);
    procedure SetHoverFill(const Value: TAdvChartGraphicsFill);
    procedure SetHoverStroke(const Value: TAdvChartGraphicsStroke);
    procedure SetNormalFill(const Value: TAdvChartGraphicsFill);
    procedure SetNormalStroke(const Value: TAdvChartGraphicsStroke);
    procedure SetCorners(const Value: TAdvChartGraphicsCorners); virtual;
    procedure SetRounding(const Value: Single); virtual;
    procedure SetInnerStroke(const Value: TAdvChartGraphicsStroke);
    procedure SetShowInnerStroke(const Value: Boolean);
    procedure SetTransparent(const Value: Boolean);
    function IsRoundingStored: Boolean;
    procedure SetFlatStyle(const Value: Boolean);
  protected
    procedure FillChanged(Sender: TObject);
    procedure StrokeChanged(Sender: TObject);
    procedure Changed; virtual;
    property Transparent: Boolean read FTransparent write SetTransparent default False;
    property ShowInnerStroke: Boolean read FShowInnerStroke write SetShowInnerStroke default True;
    property Rounding: Single read FRounding write SetRounding stored IsRoundingStored nodefault;
    property Corners: TAdvChartGraphicsCorners read FCorners write SetCorners default [gcTopLeft, gcTopRight, gcBottomLeft, gcBottomRight];
    property InnerStroke: TAdvChartGraphicsStroke read FInnerStroke write SetInnerStroke;
    property NormalFill: TAdvChartGraphicsFill read FNormalFill write SetNormalFill;
    property NormalStroke: TAdvChartGraphicsStroke read FNormalStroke write SetNormalStroke;
    property HoverFill: TAdvChartGraphicsFill read FHoverFill write SetHoverFill;
    property HoverStroke: TAdvChartGraphicsStroke read FHoverStroke write SetHoverStroke;
    property DownFill: TAdvChartGraphicsFill read FDownFill write SetDownFill;
    property DownStroke: TAdvChartGraphicsStroke read FDownStroke write SetDownStroke;
    property DisabledFill: TAdvChartGraphicsFill read FDisabledFill write SetDisabledFill;
    property DisabledStroke: TAdvChartGraphicsStroke read FDisabledStroke write SetDisabledStroke;
    property FlatStyle: Boolean read FFlatStyle write SetFlatStyle default False;
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(AOwner: TAdvChartDefaultToolBarButton);
    destructor Destroy; override;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TAdvChartToolBarButtonAppearance = class(TAdvChartToolBarCustomButtonAppearance)
  published
    property Transparent;
    property ShowInnerStroke;
    property Rounding;
    property Corners;
    property InnerStroke;
    property NormalFill;
    property NormalStroke;
    property HoverFill;
    property HoverStroke;
    property DownFill;
    property DownStroke;
    property DisabledFill;
    property DisabledStroke;
    property FlatStyle;
  end;

  TAdvChartToolBarCompactAppearance = class(TAdvChartToolBarCustomButtonAppearance)
  published
    property NormalFill;
    property NormalStroke;
    property HoverFill;
    property HoverStroke;
    property DownFill;
    property DownStroke;
    property DisabledFill;
    property DisabledStroke;
    property FlatStyle;
  end;

  TAdvChartToolBarQuickMenuButtonAppearance = class(TAdvChartToolBarCustomButtonAppearance)
  published
    property NormalFill;
    property NormalStroke;
    property HoverFill;
    property HoverStroke;
    property DownFill;
    property DownStroke;
    property DisabledFill;
    property DisabledStroke;
    property FlatStyle;
  end;

  TAdvChartToolBarElementState = (esNormal, esLarge);

  TAdvChartCustomToolBarElement = class(TAdvChartCustomControl)
  private
    FBlockUpdate: Boolean;
    FOnUpdateToolBar: TNotifyEvent;
    FOnUpdateToolBarControl: TNotifyEvent;
    FCanCopy: Boolean;
    FState: TAdvChartToolBarElementState;
    FLastElement: Boolean;
    FControlIndex: Integer;
    procedure SetState(const Value: TAdvChartToolBarElementState);
    procedure SetLastElement(const Value: Boolean);
  protected
    function GetDocURL: string; override;
    procedure UpdateState; virtual;
    procedure UpdateToolBar; virtual;
    procedure UpdateToolBarControl; virtual;
    {$IFDEF FMXLIB}
    procedure SetVisible(const Value: Boolean); override;
    procedure DoMatrixChanged(Sender: TObject); override;
    {$ENDIF}
    {$IFDEF CMNWEBLIB}
    procedure VisibleChanging; override;
    {$ENDIF}
    {$IFNDEF WEBLIB}
    procedure DefineProperties(Filer : TFiler); override;
    procedure ReadControlIndex(Reader: TReader);
    procedure WriteControlIndex(Writer: TWriter);
    {$ENDIF}
    procedure UpdateControlAfterResize; override;
    property OnUpdateToolBar: TNotifyEvent read FOnUpdateToolBar write FOnUpdateToolBar;
    property OnUpdateToolBarControl: TNotifyEvent read FOnUpdateToolBarControl write FOnUpdateToolBarControl;
    property State: TAdvChartToolBarElementState read FState write SetState default esNormal;
    property LastElement: Boolean read FLastElement write SetLastElement default False;
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property CanCopy: Boolean read FCanCopy write FCanCopy default True;
    property ControlIndex: Integer read FControlIndex write FControlIndex default -1;
  end;

  TAdvChartToolBarButtonBitmapPosition = (bbpLeft, bbpTop);

  TAdvChartToolBarButtonLayout = (bblNone, bblBitmap, bblLabel, bblLarge);

  {$IFDEF FNCLIB}
  TAdvChartDefaultToolBarButton = class(TAdvChartCustomToolBarElement, IAdvChartBitmapContainer)
  {$ENDIF}
  {$IFNDEF FNCLIB}
  TAdvChartDefaultToolBarButton = class(TAdvChartCustomToolBarElement)
  {$ENDIF}
  private
    FOldHeight: Single;
    FBitmapVisible: Boolean;
    FText: String;
    FPopup: TAdvChartPopup;
    FPopupPlacement: TAdvChartPopupPlacement;
    FDropDownHeight: Single;
    FDropDownWidth: Single;
    FDown, FHover, FPrevHover: Boolean;
    FAppearance: TAdvChartToolBarButtonAppearance;
    FBitmapContainer: TAdvChartBitmapContainer;
    FBitmaps: TAdvScaledBitmaps;
    FApplyName: Boolean;
    FDropDownControl: TControl;
    FFont: TAdvChartGraphicsFont;
    FOnBeforeDropDown: TNotifyEvent;
    FCloseOnSelection: Boolean;
    FDownState: Boolean;
    FTextVisible: Boolean;
    FOnCloseDropDown: TNotifyEvent;
    FOnDropDown: TNotifyEvent;
    FVerticalTextAlign: TAdvChartGraphicsTextAlign;
    FHorizontalTextAlign: TAdvChartGraphicsTextAlign;
    FWordWrapping: Boolean;
    FTrimming: TAdvChartGraphicsTextTrimming;
    FBitmapSize: Single;
    FStretchText: Boolean;
    FDisabledBitmaps: TAdvScaledBitmaps;
    FHoverBitmaps: TAdvScaledBitmaps;
    FShowFocus: Boolean;
    FDropDownAutoWidth: Boolean;
    FHoverFontColor: TAdvChartGraphicsColor;
    FDownFontColor: TAdvChartGraphicsColor;
    FDisabledFontColor: TAdvChartGraphicsColor;
    FStretchBitmapIfNoText: Boolean;
    FBitmapPosition: TAdvChartToolBarButtonBitmapPosition;
    FMaximumLayout: TAdvChartToolBarButtonLayout;
    FMinimumLayout: TAdvChartToolBarButtonLayout;
    FLayout: TAdvChartToolBarButtonLayout;
    FCompactLayout: TAdvChartToolBarButtonLayout;
    FLargeLayoutBitmapSize: Single;
    FLargeLayoutBitmaps: TAdvScaledBitmaps;
    FLargeLayoutHoverBitmaps: TAdvScaledBitmaps;
    FLargeLayoutDisabledBitmaps: TAdvScaledBitmaps;
    FAutoBitmapSize: Boolean;
    FLargeLayoutAutoBitmapSize: Boolean;
    procedure SetAppearance(const Value: TAdvChartToolBarButtonAppearance);
    procedure SetBitmapContainer(const Value: TAdvChartBitmapContainer); virtual;
    procedure SetBitmaps(const Value: TAdvScaledBitmaps);
    procedure SetText(const Value: String);
    procedure SetDropDownHeight(const Value: Single);
    procedure SetDropDownWidth(const Value: Single);
    procedure SetBitmapVisible(const Value: Boolean);
    procedure SetTextVisible(const Value: Boolean);
    procedure SetFont(const Value: TAdvChartGraphicsFont); reintroduce;
    procedure SetDropDownControl(const Value: TControl);
    procedure SetCloseOnSelection(const Value: Boolean);
    procedure SetDownState(const Value: Boolean);
    function IsDropDownHeightStored: Boolean;
    function IsDropDownWidthStored: Boolean;
    procedure SetHorizontalTextAlign(const Value: TAdvChartGraphicsTextAlign);
    procedure SetVerticalTextAlign(const Value: TAdvChartGraphicsTextAlign);
    procedure SetWordWrapping(const Value: Boolean);
    procedure SetTrimming(const Value: TAdvChartGraphicsTextTrimming);
    function IsBitmapSizeStored: Boolean;
    procedure SetBitmapSize(const Value: Single);
    procedure SetStretchText(const Value: Boolean);
    procedure SetDisabledBitmaps(const Value: TAdvScaledBitmaps);
    procedure SetHoverBitmaps(const Value: TAdvScaledBitmaps);
    function GetBitmapContainer: TAdvChartBitmapContainer;
    procedure SetShowFocus(const Value: Boolean);
    procedure SetDropDownAutoWidth(const Value: Boolean);
    procedure SetDisabledFontColor(const Value: TAdvChartGraphicsColor);
    procedure SetDownFontColor(const Value: TAdvChartGraphicsColor);
    procedure SetHoverFontColor(const Value: TAdvChartGraphicsColor);
    procedure SetStretchBitmapIfNoText(const Value: Boolean);
    procedure SetBitmapPosition(const Value: TAdvChartToolBarButtonBitmapPosition);
    procedure SetMaximumLayout(const Value: TAdvChartToolBarButtonLayout);
    procedure SetMinimumLayout(const Value: TAdvChartToolBarButtonLayout);
    procedure SetLayout(const Value: TAdvChartToolBarButtonLayout);
    procedure SetCompactLayout(const Value: TAdvChartToolBarButtonLayout);
    function IsLargeLayoutBitmapSizeStored: Boolean;
    procedure SetLargeLayoutBitmaps(const Value: TAdvScaledBitmaps);
    procedure SetLargeLayoutBitmapSize(const Value: Single);
    procedure SetLargeLayoutDisabledBitmaps(const Value: TAdvScaledBitmaps);
    procedure SetLargeLayoutHoverBitmaps(const Value: TAdvScaledBitmaps);
    procedure SetAutoBitmapSize(const Value: Boolean);
    procedure SetLargeLayoutAutoBitmapSize(const Value: Boolean);
  protected
    function CanDrawDesignTime: Boolean; virtual;
    function HasHint: Boolean; override;
    function GetHintString: String; override;
    function GetText: String; virtual;
    function GetTextSize: TSizeF; virtual;
    procedure UpdateControlAfterResize; override;
    procedure ApplyStyle; override;
    procedure ResetToDefaultStyle; override;
    procedure SetAdaptToStyle(const Value: Boolean); override;
    procedure BitmapsChanged(Sender: TObject);
    procedure DoFontChanged(Sender: TObject);
    procedure UpdateLayout; virtual;
    procedure DoClosePopup(Sender: TObject);
    procedure DoPopup(Sender: TObject);
    procedure InitializePopup; virtual;
    procedure UpdateState; override;
    procedure ChangeDPIScale(M, D: Integer); override;
    procedure AppearanceChanged; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetName(const Value: TComponentName); override;
    procedure HandleMouseDown(Button: TAdvMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure HandleMouseMove(Shift: TShiftState; X, Y: Single); override;
    procedure HandleMouseUp(Button: TAdvMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure HandleKeyUp(var Key: Word; Shift: TShiftState); override;
    procedure HandleKeyDown(var Key: Word; Shift: TShiftState); override;
    procedure HandleKeyPress(var Key: Char); override;
    procedure HandleMouseEnter; override;
    procedure HandleMouseLeave; override;
    procedure SelectFirstValue; virtual;
    procedure SelectValueWithCharacter({%H-}ACharacter: Char); virtual;
    procedure SelectLastValue; virtual;
    procedure SelectNextValue; virtual;
    procedure SelectPreviousValue; virtual;
    procedure DrawText(AGraphics: TAdvChartGraphics); virtual;
    procedure DrawBitmap(AGraphics: TAdvChartGraphics; ARect: TRectF); virtual;
    procedure DrawButton({%H-}AGraphics: TAdvChartGraphics); virtual;
    function CanDropDown: Boolean; virtual;
    function CanChangeText: Boolean; virtual;
    function GetTextRect: TRectF; virtual;
    function GetDropDownRect: TRectF; virtual;
    function GetBitmapRect: TRectF; overload; virtual;
    function GetBitmapRect(ARect: TRectF): TRectF; overload; virtual;
    function GetBitmapSize: Single; virtual;
    function GetLargeLayoutBitmapSize: Single; virtual;
    property Appearance: TAdvChartToolBarButtonAppearance read FAppearance write SetAppearance;
    property BitmapVisible: Boolean read FBitmapVisible write SetBitmapVisible default False;
    property Bitmaps: TAdvScaledBitmaps read FBitmaps write SetBitmaps;
    property DisabledBitmaps: TAdvScaledBitmaps read FDisabledBitmaps write SetDisabledBitmaps;
    property HoverBitmaps: TAdvScaledBitmaps read FHoverBitmaps write SetHoverBitmaps;
    property LargeLayoutBitmaps: TAdvScaledBitmaps read FLargeLayoutBitmaps write SetLargeLayoutBitmaps;
    property LargeLayoutDisabledBitmaps: TAdvScaledBitmaps read FLargeLayoutDisabledBitmaps write SetLargeLayoutDisabledBitmaps;
    property LargeLayoutHoverBitmaps: TAdvScaledBitmaps read FLargeLayoutHoverBitmaps write SetLargeLayoutHoverBitmaps;
    property BitmapContainer: TAdvChartBitmapContainer read GetBitmapContainer write SetBitmapContainer;
    property BitmapSize: Single read FBitmapSize write SetBitmapSize stored IsBitmapSizeStored nodefault;
    property AutoBitmapSize: Boolean read FAutoBitmapSize write SetAutoBitmapSize default false;
    property LargeLayoutBitmapSize: Single read FLargeLayoutBitmapSize write SetLargeLayoutBitmapSize stored IsLargeLayoutBitmapSizeStored nodefault;
    property LargeLayoutAutoBitmapSize: Boolean read FLargeLayoutAutoBitmapSize write SetLargeLayoutAutoBitmapSize default False;
    property StretchBitmapIfNoText: Boolean read FStretchBitmapIfNoText write SetStretchBitmapIfNoText default True;
    property Text: String read GetText write SetText;
    property Trimming: TAdvChartGraphicsTextTrimming read FTrimming write SetTrimming default gttCharacter;
    property HorizontalTextAlign: TAdvChartGraphicsTextAlign read FHorizontalTextAlign write SetHorizontalTextAlign default gtaCenter;
    property VerticalTextAlign: TAdvChartGraphicsTextAlign read FVerticalTextAlign write SetVerticalTextAlign default gtaCenter;
    property Font: TAdvChartGraphicsFont read FFont write SetFont;
    property HoverFontColor: TAdvChartGraphicsColor read FHoverFontColor write SetHoverFontColor default gcNull;
    property DownFontColor: TAdvChartGraphicsColor read FDownFontColor write SetDownFontColor default gcNull;
    property DisabledFontColor: TAdvChartGraphicsColor read FDisabledFontColor write SetDisabledFontColor default gcNull;
    property TextVisible: Boolean read FTextVisible write SetTextVisible default True;
    property StretchText: Boolean read FStretchText write SetStretchText default False;
    property WordWrapping: Boolean read FWordWrapping write SetWordWrapping default False;
    property DropDownAutoWidth: Boolean read FDropDownAutoWidth write SetDropDownAutoWidth default False;
    property DropDownHeight: Single read FDropDownHeight write SetDropDownHeight stored IsDropDownHeightStored nodefault;
    property DropDownWidth: Single read FDropDownWidth write SetDropDownWidth stored IsDropDownWidthStored nodefault;
    property DropDownControl: TControl read FDropDownControl write SetDropDownControl;
    property CloseOnSelection: Boolean read FCloseOnSelection write SetCloseOnSelection default True;
    property OnBeforeDropDown: TNotifyEvent read FOnBeforeDropDown write FOnBeforeDropDown;
    property OnDropDown: TNotifyEvent read FOnDropDown write FOnDropDown;
    property OnCloseDropDown: TNotifyEvent read FOnCloseDropDown write FOnCloseDropDown;
    property ApplyName: Boolean read FApplyName write FApplyName default True;
    property ShowFocus: Boolean read FShowFocus write SetShowFocus default False;
    property BitmapPosition: TAdvChartToolBarButtonBitmapPosition read FBitmapPosition write SetBitmapPosition default bbpLeft;
    property CompactLayout: TAdvChartToolBarButtonLayout read FCompactLayout write SetCompactLayout default bblNone;
    property Layout: TAdvChartToolBarButtonLayout read FLayout write SetLayout default bblNone;
    property MinimumLayout: TAdvChartToolBarButtonLayout read FMinimumLayout write SetMinimumLayout default bblBitmap;
    property MaximumLayout: TAdvChartToolBarButtonLayout read FMaximumLayout write SetMaximumLayout default bblLarge;
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Draw(AGraphics: TAdvChartGraphics; ARect: TRectF); override;
    procedure DropDown; virtual;
    procedure CloseDropDown; virtual;
    function GetPopupControl: TAdvChartPopup;
    function GetBitmap: TAdvChartBitmap; virtual;
    property DownState: Boolean read FDownState write SetDownState;
    property PopupPlacement: TAdvChartPopupPlacement read FPopupPlacement write FPopupPlacement default ppBottom;
  end;

  TAdvChartToolBarButtonDropDownKind = (ddkNormal, ddkDropDown, ddkDropDownButton);
  TAdvChartToolBarButtonDropDownPosition = (ddpRight, ddpBottom);

  TAdvChartToolBarDropDownButton = class(TAdvChartDefaultToolBarButton)
  private
    FDefaultStyle: Boolean;
    procedure SetDefaultStyle(const Value: Boolean);
  protected
    procedure RegisterRuntimeClasses; override;
    procedure DrawBitmap(AGraphics: TAdvChartGraphics; ARect: TRectF); override;
    function GetBitmapRect(ARect: TRectF): TRectF; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure LoadSettingsFromFile(AFileName: string); override;
    procedure LoadSettingsFromStream(AStream: TStreamEx); override;
  published
    property DefaultStyle: Boolean read FDefaultStyle write SetDefaultStyle default True;
    property Font;
    property Text;
    property ShowFocus;
    property TextVisible;
    property StretchText;
    property WordWrapping;
    property HorizontalTextAlign;
    property VerticalTextAlign;
    property Trimming;
    property Bitmaps;
    property DisabledBitmaps;
    property HoverBitmaps;
    property BitmapVisible;
    property BitmapContainer;
    property State;
    property LastElement;
    property Appearance;
  end;

  TAdvChartToolBarDropDownButtonClass = class of TAdvChartToolBarDropDownButton;


  TAdvChartCustomToolBarButton = class(TAdvChartDefaultToolBarButton)
  private
    FDropDownButton: TAdvChartToolBarDropDownButton;
    FDropDownKind: TAdvChartToolBarButtonDropDownKind;
    FDropDownPosition: TAdvChartToolBarButtonDropDownPosition;
    FHidden: Boolean;
    FAutoOptionsMenuText: String;
    procedure SetDropDownKind(const Value: TAdvChartToolBarButtonDropDownKind);
    procedure SetDropDownPosition(
      const Value: TAdvChartToolBarButtonDropDownPosition);
    procedure SetHidden(const Value: Boolean);
  protected
    procedure ChangeDPIScale(M, D: Integer); override;
    procedure SetAdaptToStyle(const Value: Boolean); override;
    procedure DoFontChanged(Sender: TObject);
    procedure AppearanceChanged; override;
    procedure UpdateDropDownButton; virtual;
    procedure HandleMouseDown(Button: TAdvMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure DropDownButtonClick(Sender: TObject);
    procedure DrawButton(AGraphics: TAdvChartGraphics); override;
    {$IFDEF FMXLIB}
    procedure SetEnabled(const Value: Boolean); override;
    {$ENDIF}
    {$IFDEF CMNWEBLIB}
    procedure SetEnabled(Value: Boolean); override;
    {$ENDIF}
    function GetDropDownButtonClass: TAdvChartToolBarDropDownButtonClass; virtual;
    function GetDropDownRect: TRectF; override;
    function GetTextRect: TRectF; override;
    function GetBitmapRect(ARect: TRectF): TRectF; overload; override;
    function GetBitmapRect: TRectF; overload; override;
    function CanDropDown: Boolean; override;
    property DropDownKind: TAdvChartToolBarButtonDropDownKind read FDropDownKind write SetDropDownKind default ddkNormal;
    property DropDownPosition: TAdvChartToolBarButtonDropDownPosition read FDropDownPosition write SetDropDownPosition default ddpRight;
    property AutoOptionsMenuText: String read FAutoOptionsMenuText write FAutoOptionsMenuText;
    property Hidden: Boolean read FHidden write SetHidden default False;
    procedure Loaded; override;
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetDropDownButtonControl: TAdvChartToolBarDropDownButton;
    procedure LoadSettingsFromFile(AFileName: string); override;
    procedure LoadSettingsFromStream(AStream: TStreamEx); override;
  end;

  TAdvChartCustomToolBarSeparatorAppearance = class(TPersistent)
  private
    FOwner: TAdvChartCustomToolBarSeparator;
    FStroke: TAdvChartGraphicsStroke;
    FInnerStroke: TAdvChartGraphicsStroke;
    procedure SetStroke(const Value: TAdvChartGraphicsStroke);
    procedure SetInnerStroke(const Value: TAdvChartGraphicsStroke);
  protected
    procedure StrokeChanged(Sender: TObject);
    property Stroke: TAdvChartGraphicsStroke read FStroke write SetStroke;
    property InnerStroke: TAdvChartGraphicsStroke read FInnerStroke write SetInnerStroke;
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(AOwner: TAdvChartCustomToolBarSeparator);
    destructor Destroy; override;
  end;

  TAdvChartToolBarSeparatorAppearance = class(TAdvChartCustomToolBarSeparatorAppearance)
  published
    property Stroke;
    property InnerStroke;
  end;

  TAdvChartCustomToolBarSeparator = class(TAdvChartCustomToolBarElement)
  private
    FAppearance: TAdvChartToolBarSeparatorAppearance;
    procedure SetAppearance(const Value: TAdvChartToolBarSeparatorAppearance);
  protected
    procedure UpdateState; override;
    property Appearance: TAdvChartToolBarSeparatorAppearance read FAppearance write SetAppearance;
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Draw(AGraphics: TAdvChartGraphics; ARect: TRectF); override;
  end;

  {$IFNDEF LCLLIB}
  [ComponentPlatformsAttribute(TMSPlatformsWeb)]
  {$ENDIF}
  TAdvChartToolBarButton = class(TAdvChartCustomToolBarButton)
  protected
    procedure RegisterRuntimeClasses; override;
  public
    property Hidden;
  published
    property Font;
    property AutoOptionsMenuText;
    property DropDownAutoWidth;
    property DropDownKind;
    property DropDownPosition;
    property DropDownHeight;
    property DropDownWidth;
    property DropDownControl;
    property OnBeforeDropDown;
    property OnDropDown;
    property OnCloseDropDown;
    property Text;
    property ShowFocus;
    property TextVisible;
    property StretchText;
    property StretchBitmapIfNoText;
    property HorizontalTextAlign;
    property VerticalTextAlign;
    property Trimming;
    property Bitmaps;
    property LargeLayoutBitmaps;
    property Layout;
    property CompactLayout;
    property MinimumLayout;
    property MaximumLayout;
    property BitmapPosition;
    property DisabledBitmaps;
    property HoverBitmaps;
    property LargeLayoutDisabledBitmaps;
    property LargeLayoutHoverBitmaps;
    property BitmapVisible;
    property BitmapContainer;
    property BitmapSize;
    property AutoBitmapSize;
    property LargeLayoutBitmapSize;
    property LargeLayoutAutoBitmapSize;
    property State;
    property LastElement;
    property Appearance;
    property WordWrapping;
  end;

  TAdvChartToolBarButtonClass = class of TAdvChartToolBarButton;

  {$IFNDEF LCLLIB}
  [ComponentPlatformsAttribute(TMSPlatformsWeb)]
  {$ENDIF}
  TAdvChartToolBarSeparator = class(TAdvChartCustomToolBarSeparator)
  protected
    procedure RegisterRuntimeClasses; override;
  published
    property State;
    property LastElement;
    property Appearance;
  end;

  TAdvChartToolBarSeparatorClass = class of TAdvChartToolBarSeparator;

  TAdvChartToolBarItemPickerItemSelected = procedure(Sender: TObject; AItemIndex: Integer) of object;

  TAdvChartToolBarCustomItemPicker = class(TAdvChartToolBarButton)
  private
    FEdit: TEdit;
    FTimer: TTimer;
    FItemIndex: Integer;
    FItems: TStringList;
    FKeyboardUsed: Boolean;
    FItemSelector: TListBox;
    FOnItemSelected: TAdvChartToolBarItemPickerItemSelected;
    FEditable: Boolean;
    FOnEditChange: TNotifyEvent;
    function GetSelectedItemIndex: Integer;
    procedure SetSelectedItemIndex(const Value: Integer);
    function GetSelectedItem: String;
    procedure SetSelectedItem(const Value: String);
    procedure SetItems(const Value: TStringList);
    procedure SetEditable(const Value: Boolean);
  protected
    procedure ChangeDPIScale(M, D: Integer); override;
    function CanChangeText: Boolean; override;
    function GetText: String; override;
    procedure EnterTimerChanged(Sender: TObject);
    procedure EditChange(Sender: TObject);
    procedure HandleDialogKey(var Key: Word; Shift: TShiftState); override;
    procedure InitializePopup; override;
    procedure SelectValueWithString(AValue: string); virtual;
    procedure SelectValueWithCharacter(ACharacter: Char); override;
    procedure SelectFirstValue; override;
    procedure SelectLastValue; override;
    procedure SelectNextValue; override;
    procedure SelectPreviousValue; override;
    {$IFDEF FMXLIB}
    procedure ItemKeyUp(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure ItemKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure ItemSelected(const Sender: TCustomListBox; const Item: TListBoxItem);
    {$ENDIF}
    {$IFDEF CMNWEBLIB}
    procedure ItemKeyUp(Sender: TObject; var {%H-}Key: Word; {%H-}Shift: TShiftState);
    procedure ItemKeyDown(Sender: TObject; var {%H-}Key: Word; {%H-}Shift: TShiftState);
    procedure ItemSelected(Sender: TObject);
    {$ENDIF}
    procedure DoItemSelected; virtual;
    procedure DoEnter; override;
    property CloseOnSelection;
    property Items: TStringList read FItems write SetItems;
    property OnItemSelected: TAdvChartToolBarItemPickerItemSelected read FOnItemSelected write FOnItemSelected;
    property ListBox: TListBox read FItemSelector;
    property SelectedItemIndex: Integer read GetSelectedItemIndex write SetSelectedItemIndex default -1;
    property SelectedItem: String read GetSelectedItem write SetSelectedItem;
    property Editable: Boolean read FEditable write SetEditable default False;
    property OnEditChange: TNotifyEvent read FOnEditChange write FOnEditChange;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Draw(AGraphics: TAdvChartGraphics; ARect: TRectF); override;
    destructor Destroy; override;
    procedure DropDown; override;
  end;

  {$IFNDEF LCLLIB}
  [ComponentPlatformsAttribute(TMSPlatformsWeb)]
  {$ENDIF}
  TAdvChartToolBarItemPicker = class(TAdvChartToolBarCustomItemPicker)
  published
    property OnItemSelected;
    property SelectedItemIndex;
    property Items;
    property Editable;
    property OnEditChange;
  end;

  TAdvChartToolBarFontNamePickerFontNameSelected = procedure(Sender: TObject; AFontName: String) of object;

  TAdvChartToolBarItemPickerClass = class of TAdvChartToolBarItemPicker;

  {$IFNDEF LCLLIB}
  [ComponentPlatformsAttribute(TMSPlatformsWeb)]
  {$ENDIF}
  TAdvChartToolBarFontNamePicker = class(TAdvChartToolBarCustomItemPicker)
  private
    FOnFontNameSelected: TAdvChartToolBarFontNamePickerFontNameSelected;
    function GetSelectedFontName: String;
    procedure SetSelectedFontName(const Value: String);
  protected
    procedure RegisterRuntimeClasses; override;
    procedure DoItemSelected; override;
  public
    constructor Create(AOwner: TComponent); override;
    property SelectedFontName: String read GetSelectedFontName write SetSelectedFontName;
    property SelectedItemIndex;
    property Items;
  published
    property OnFontNameSelected: TAdvChartToolBarFontNamePickerFontNameSelected read FOnFontNameSelected write FOnFontNameSelected;
    property CloseOnSelection;
    property Editable;
    property OnEditChange;
  end;

  TAdvChartToolBarFontSizePickerFontSizeSelected = procedure(Sender: TObject; AFontSize: Single) of object;

  TAdvChartToolBarFontNamePickerClass = class of TAdvChartToolBarFontNamePicker;

  {$IFNDEF LCLLIB}
  [ComponentPlatformsAttribute(TMSPlatformsWeb)]
  {$ENDIF}
  TAdvChartToolBarFontSizePicker = class(TAdvChartToolBarCustomItemPicker)
  private
    FOnFontSizeSelected: TAdvChartToolBarFontSizePickerFontSizeSelected;
    function GetSelectedFontSize: Single;
    procedure SetSelectedFontSize(const Value: Single);
  protected
    procedure RegisterRuntimeClasses; override;
    procedure DoItemSelected; override;
  public
    constructor Create(AOwner: TComponent); override;
    property SelectedFontSize: Single read GetSelectedFontSize write SetSelectedFontSize;
    property SelectedItemIndex;
    property Items;
  published
    property OnFontSizeSelected: TAdvChartToolBarFontSizePickerFontSizeSelected read FOnFontSizeSelected write FOnFontSizeSelected;
    property CloseOnSelection;
    property Editable;
    property OnEditChange;
  end;

  TAdvChartToolBarColorPickerColorSelected = procedure(Sender: TObject; AColor: TAdvChartGraphicsColor) of object;

  TAdvChartToolBarFontSizePickerClass = class of TAdvChartToolBarFontSizePicker;

  {$IFNDEF LCLLIB}
  [ComponentPlatformsAttribute(TMSPlatformsWeb)]
  {$ENDIF}
  TAdvChartToolBarColorPicker = class(TAdvChartToolBarButton)
  private
    FColorSelector: TAdvChartColorSelector;
    FOnColorSelected: TAdvChartToolBarColorPickerColorSelected;
    function GetSelectedColor: TAdvChartGraphicsColor;
    procedure SetSelectedColor(const Value: TAdvChartGraphicsColor);
    function GetSelectedItemIndex: Integer;
    procedure SetSelectedItemIndex(const Value: Integer);
    function GetItems: TAdvChartColorSelectorItems;
    procedure SetItems(const Value: TAdvChartColorSelectorItems);
  protected
    procedure RegisterRuntimeClasses; override;
    procedure SetAdaptToStyle(const Value: Boolean); override;
    procedure DrawColor(AColor: TAdvChartGraphicsColor; ARect: TRectF; AGraphics: TAdvChartGraphics);
    procedure ColorSelected(Sender: TObject; AColor: TAdvChartGraphicsColor);
    procedure DoColorSelected(AColor: TAdvChartGraphicsColor); virtual;
    function CanChangeText: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    function BlockChange: Boolean;
    function ColorSelector: TAdvChartColorSelector;
    procedure Draw(AGraphics: TAdvChartGraphics; ARect: TRectF); override;
    procedure DrawSelectedColor(AGraphics: TAdvChartGraphics; {%H-}ARect: TRectF); virtual;
  published
    property OnColorSelected: TAdvChartToolBarColorPickerColorSelected read FOnColorSelected write FOnColorSelected;
    property SelectedColor: TAdvChartGraphicsColor read GetSelectedColor write SetSelectedColor default gcNull;
    property SelectedItemIndex: Integer read GetSelectedItemIndex write SetSelectedItemIndex;
    property Items: TAdvChartColorSelectorItems read GetItems write SetItems;
    property CloseOnSelection;
  end;

  TAdvChartToolBarBitmapPickerBitmapSelected = procedure(Sender: TObject; ABitmap: TAdvChartBitmap) of object;

  TAdvChartToolBarColorPickerClass = class of TAdvChartToolBarColorPicker;

  {$IFNDEF LCLLIB}
  [ComponentPlatformsAttribute(TMSPlatformsWeb)]
  {$ENDIF}
  TAdvChartToolBarBitmapPicker = class(TAdvChartToolBarButton)
  private
    FBitmapSelector: TAdvChartBitmapSelector;
    FOnBitmapSelected: TAdvChartToolBarBitmapPickerBitmapSelected;
    function GetSelectedBitmap: TAdvChartBitmap;
    function GetSelectedItemIndex: Integer;
    procedure SetSelectedItemIndex(const Value: Integer);
    function GetItems: TAdvChartBitmapSelectorItems;
    procedure SetItems(const Value: TAdvChartBitmapSelectorItems);
    procedure SetBitmapContainer(const Value: TAdvChartBitmapContainer); override;
  protected
    function GetBitmapRect(ARect: TRectF): TRectF; override;
    function CanChangeText: Boolean; override;
    procedure RegisterRuntimeClasses; override;
    procedure SetAdaptToStyle(const Value: Boolean); override;
    procedure BitmapSelected(Sender: TObject; ABitmap: TAdvChartBitmap);
    procedure DoBitmapSelected(ABitmap: TAdvChartBitmap); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    function BlockChange: Boolean;
    function BitmapSelector: TAdvChartBitmapSelector;
    property SelectedBitmap: TAdvChartBitmap read GetSelectedBitmap;
  published
    property OnBitmapSelected: TAdvChartToolBarBitmapPickerBitmapSelected read FOnBitmapSelected write FOnBitmapSelected;
    property SelectedItemIndex: Integer read GetSelectedItemIndex write SetSelectedItemIndex;
    property Items: TAdvChartBitmapSelectorItems read GetItems write SetItems;
    property CloseOnSelection;
  end;

  TAdvChartToolBarBitmapPickerClass = class of TAdvChartToolBarBitmapPicker;

  TAdvChartCustomToolBarAppearance = class(TPersistent)
  private
    FOwner: TAdvChartCustomToolBar;
    FFill: TAdvChartGraphicsFill;
    FStroke: TAdvChartGraphicsStroke;
    FVerticalSpacing: Single;
    FHorizontalSpacing: Single;
    FDragGripColor: TAdvChartGraphicsColor;
    FDragGrip: Boolean;
    FFlatStyle: Boolean;
    FFont: TAdvChartGraphicsFont;
    FSeparatorStroke: TAdvChartGraphicsStroke;
    FSeparator: Boolean;
    procedure SetFill(const Value: TAdvChartGraphicsFill);
    procedure SetStroke(const Value: TAdvChartGraphicsStroke);
    procedure SetHorizontalSpacing(const Value: Single);
    procedure SetVerticalSpacing(const Value: Single);
    procedure SetDragGrip(const Value: Boolean);
    procedure SetDragGripColor(const Value: TAdvChartGraphicsColor);
    function IsHorizontalSpacingStored: Boolean;
    function IsVerticalSpacingStored: Boolean;
    procedure SetFlatStyle(const Value: Boolean);
    procedure SetSeparator(const Value: Boolean);
    procedure SetSeparatorStroke(const Value: TAdvChartGraphicsStroke);
  protected
    procedure FillChanged(Sender: TObject);
    procedure StrokeChanged(Sender: TObject);
    property Fill: TAdvChartGraphicsFill read FFill write SetFill;
    property Stroke: TAdvChartGraphicsStroke read FStroke write SetStroke;
    property HorizontalSpacing: Single read FHorizontalSpacing write SetHorizontalSpacing stored IsHorizontalSpacingStored nodefault;
    property VerticalSpacing: Single read FVerticalSpacing write SetVerticalSpacing stored IsVerticalSpacingStored nodefault;
    property DragGrip: Boolean read FDragGrip write SetDragGrip default True;
    property DragGripColor: TAdvChartGraphicsColor read FDragGripColor write SetDragGripColor default gcLightgray;
    property FlatStyle: Boolean read FFlatStyle write SetFlatStyle default False;
    property Separator: Boolean read FSeparator write SetSeparator default False;
    property SeparatorStroke: TAdvChartGraphicsStroke read FSeparatorStroke write SetSeparatorStroke;
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(AOwner: TAdvChartCustomToolBar);
    destructor Destroy; override;
  end;

  TAdvChartToolBarAppearance = class(TAdvChartCustomToolBarAppearance)
  published
    property FlatStyle;
    property Fill;
    property Stroke;
    property Separator;
    property SeparatorStroke;
    property HorizontalSpacing;
    property VerticalSpacing;
    property DragGrip;
    property DragGripColor;
  end;

  TAdvChartToolBarOptionMenuItem = class(TMenuItem)
  private
    FControl: TControl;
    FGlyphWidth: Single;
    FCalculate: Boolean;
  protected
    property Calculate: Boolean read FCalculate write FCalculate;
    property GlyphWidth: Single read FGlyphWidth write FGlyphWidth;
  public
    property Control: TControl read FControl write FControl;
  end;

  TAdvChartToolBarControl = class(TPersistent)
  private
    FControlIndex: Integer;
    FControl: TControl;
    FLayout: TAdvChartToolBarButtonLayout;
    FBitmap: TAdvChartBitmap;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TControlClass = class of TControl;

  TAdvChartToolBarCustomizeOptionsMenu = procedure(Sender: TObject; APopupMenu: TPopupMenu) of object;
  TAdvChartToolBarCustomizeOptionsMenuItem = procedure(Sender: TObject; AControl: TControl; AMenuItem: TMenuItem) of object;
  TAdvChartToolBarCanShowOptionsMenuItem = procedure(Sender: TObject; AControl: TControl; var ACanShowItem: Boolean) of object;
  TAdvChartToolBarOptionsMenuItemClick = procedure(Sender: TObject; AControl: TControl; AMenuItem: TMenuItem; var AExecuteDefaultAction: Boolean) of object;
  TAdvChartToolBarIsLastElement = procedure(Sender: TObject; AControl: TControl; var AIsLastElement: Boolean) of object;
  TAdvChartToolBarAnchorClickEvent = procedure(Sender: TObject; AAnchor: string) of object;

  TAdvChartCustomToolBarOptionsMenu = class(TPersistent)
  private
    FOwner: TAdvChartCustomToolBar;
    FShowItemText: Boolean;
    FShowItemBitmap: Boolean;
    FShowButton: Boolean;
    FItemBitmapWidth: Single;
    FAutoItemBitmapWidth: Boolean;
    procedure SetShowButton(const Value: Boolean);
    procedure SetShowItemBitmap(const Value: Boolean);
    procedure SetShowItemText(const Value: Boolean);
    procedure SetAutoItemBitmapWidth(const Value: Boolean);
    procedure SetItemBitmapWidth(const Value: Single);
    function IsItemBitmapWidthStored: Boolean;
  protected
    property ShowButton: Boolean read FShowButton write SetShowButton default True;
    property ShowItemBitmap: Boolean read FShowItemBitmap write SetShowItemBitmap default True;
    property ShowItemText: Boolean read FShowItemText write SetShowItemText default True;
    property AutoItemBitmapWidth: Boolean read FAutoItemBitmapWidth write SetAutoItemBitmapWidth default True;
    property ItemBitmapWidth: Single read FItemBitmapWidth write SetItemBitmapWidth stored IsItemBitmapWidthStored nodefault;
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(AOwner: TAdvChartCustomToolBar);
    destructor Destroy; override;
  end;

  TAdvChartToolBarOptionsMenu = class(TAdvChartCustomToolBarOptionsMenu)
  published
    property ShowButton;
    property ShowItemBitmap;
    property ShowItemText;
    property AutoItemBitmapWidth;
    property ItemBitmapWidth;
  end;

  {$IFDEF WEBLIB}
  TAdvChartToolBarControlObjectList = class(TObjectList)
  private
    function GetItem(Index: Integer): TAdvChartToolBarControl;
    procedure SetItem(Index: Integer; const Value: TAdvChartToolBarControl);
  public
    property Items[Index: Integer]: TAdvChartToolBarControl read GetItem write SetItem; default;
  end;
  TAdvChartToolBarControlList = class(TList)
  private
    function GetItem(Index: Integer): TAdvChartToolBarControl;
    procedure SetItem(Index: Integer; const Value: TAdvChartToolBarControl);
  public
    property Items[Index: Integer]: TAdvChartToolBarControl read GetItem write SetItem; default;
  end;
  TAdvControlList = class(TList)
  private
    function GetItem(Index: Integer): TControl;
    procedure SetItem(Index: Integer; const Value: TControl);
  public
    property Items[Index: Integer]: TControl read GetItem write SetItem; default;
  end;
  {$ENDIF}
  {$IFNDEF WEBLIB}
  TAdvChartToolBarControlObjectList = TObjectList<TAdvChartToolBarControl>;
  TAdvChartToolBarControlList = TList<TAdvChartToolBarControl>;
  TAdvControlList = TList<TControl>;
  {$ENDIF}

  TAdvChartToolBarDragGripMovingEvent = procedure(Sender: TObject; DeltaX: Double; DeltaY: Double) of object;

  TAdvCToolBarPopup = class(TAdvChartPopup)
  public
    property OnClosePopup;
  end;

  {$IFDEF FNCLIB}
  TAdvChartCustomToolBar = class(TAdvChartCustomControl, IAdvChartStylesManager, IAdvChartBitmapContainer)
  {$ENDIF}
  {$IFNDEF FNCLIB}
  TAdvChartCustomToolBar = class(TAdvChartCustomControl)
  {$ENDIF}
  private
    FCompactToolbar: TAdvChartCustomToolBar;
    FCompactPopup: TAdvCToolBarPopup;
    FHover, FHoverP, FQuickMenuButtonHover, FQuickMenuButtonHoverP: Boolean;
    FDown, FQuickMenuButtonDown: Boolean;
    FOldWidth: Single;
    FOldMenuButtonState: Boolean;
    FBitmapContainer: TAdvChartBitmapContainer;
    FInsideDrag, FDragGripMoving, FDragGripDown: Boolean;
    FDragGripDownPt: TPointF;
    FTotalOptionsMenuWidth: Single;
    {$IFNDEF LCLLIB}
    {$IFNDEF WEBLIB}
    FCompareControls: IComparer<TControl>;
    FCompareHiddenControls: IComparer<TAdvChartToolBarControl>;
    {$ENDIF}
    {$ENDIF}
    FHiddenControls: TAdvChartToolBarControlObjectList;
    FCompactControls: TAdvChartToolBarControlObjectList;
    FBlockUpdate, FBlockResize: Boolean;
    FAutoSize: Boolean;
    FAppearance: TAdvChartToolBarAppearance;
    FAutoAlign: Boolean;
    FOptionsMenuButton: TAdvChartToolBarDropDownButton;
    FAutoOptionsMenu: TPopupMenu;
    FOnOptionsMenuCustomize: TAdvChartToolBarCustomizeOptionsMenu;
    FOnOptionsMenuItemCustomize: TAdvChartToolBarCustomizeOptionsMenuItem;
    FOnOptionsMenuButtonClick: TNotifyEvent;
    FOptionsMenu: TAdvChartToolBarOptionsMenu;
    FCustomOptionsMenu: TPopupMenu;
    FOnOptionsMenuItemCanShow: TAdvChartToolBarCanShowOptionsMenuItem;
    FState: TAdvChartToolBarElementState;
    FOnOptionsMenuItemClick: TAdvChartToolBarOptionsMenuItemClick;
    FOnOptionsMenuItemApplyStyle: TAdvChartToolBarCustomizeOptionsMenuItem;
    FOnUpdateDockPanel: TNotifyEvent;
    FOnUpdateControls: TNotifyEvent;
    FOnIsLastElement: TAdvChartToolBarIsLastElement;
    FOnDragGripMoving: TAdvChartToolBarDragGripMovingEvent;
    FAutoMoveToolBar: Boolean;
    FOnInternalDblClick: TNotifyEvent;
    FOnInternalMouseDown: TNotifyEvent;
    FOnInternalMouseMove: TNotifyEvent;
    FOnInternalMouseUp: TNotifyEvent;
    FAutoHeight: Boolean;
    FAutoWidth: Boolean;
    FOnInternalInsertControl: TNotifyEvent;
    FAutoStretchHeight: Boolean;
    FText: string;
    FFont: TAdvChartGraphicsFont;
    FVerticalTextAlign: TAdvChartGraphicsTextAlign;
    FTrimming: TAdvChartGraphicsTextTrimming;
    FHorizontalTextAlign: TAdvChartGraphicsTextAlign;
    FWordWrapping: Boolean;
    FTextVisible: Boolean;
    FMinimumWidth: Single;
    FCompact: Boolean;
    FCanCompact: Boolean;
    FCompactWidth: Single;
    FCompactAppearance: TAdvChartToolBarCompactAppearance;
    FCompactBitmaps: TAdvScaledBitmaps;
    FOnCompactClick: TNotifyEvent;
    FCompactBitmapSize: Single;
    FCompactBitmapVisible: Boolean;
    FCompactExpanderBitmaps: TAdvScaledBitmaps;
    FQuickMenuButton: Boolean;
    FQuickMenuButtonAppearance: TAdvChartToolBarQuickMenuButtonAppearance;
    FOnQuickMenuButtonClick: TNotifyEvent;
    FQuickMenuButtonBitmaps: TAdvScaledBitmaps;
    FQuickMenuButtonHint: string;
    FCompactAutoBitmapSize: Boolean;
    FOnAnchorClick: TAdvChartToolBarAnchorClickEvent;
    procedure SetAppearance(const Value: TAdvChartToolBarAppearance);
    procedure SetAS(const Value: Boolean);
    procedure SetAutoAlign(const Value: Boolean);
    procedure SetOptionsMenu(const Value: TAdvChartToolBarOptionsMenu);
    procedure SetState(const Value: TAdvChartToolBarElementState);
    procedure SetAutoHeight(const Value: Boolean);
    procedure SetAutoWidth(const Value: Boolean);
    procedure SetAutoStretchHeight(const Value: Boolean);
    procedure SetText(const Value: string);
    function GetBitmapContainer: TAdvChartBitmapContainer;
    procedure SetBitmapContainer(const Value: TAdvChartBitmapContainer);
    procedure SetFont(const Value: TAdvChartGraphicsFont); reintroduce;
    procedure SetHorizontalTextAlign(const Value: TAdvChartGraphicsTextAlign);
    procedure SetTrimming(const Value: TAdvChartGraphicsTextTrimming);
    procedure SetVerticalTextAlign(const Value: TAdvChartGraphicsTextAlign);
    procedure SetWordWrapping(const Value: Boolean);
    procedure SetTextVisible(const Value: Boolean);
    function IsMinimumWidthStored: Boolean;
    procedure SetMinimumWidth(const Value: Single);
    procedure SetCompact(const Value: Boolean);
    procedure SetCanCompact(const Value: Boolean);
    function IsCompactWidthStored: Boolean;
    procedure SetCompactWidth(const Value: Single);
    procedure SetCompactAppearance(const Value: TAdvChartToolBarCompactAppearance);
    procedure SetCompactBitmaps(const Value: TAdvScaledBitmaps);
    function IsCompactBitmapSizeStored: Boolean;
    procedure SetCompactBitmapSize(const Value: Single);
    procedure SetCompactBitmapVisible(const Value: Boolean);
    procedure SetCompactExpanderBitmaps(const Value: TAdvScaledBitmaps);
    procedure SetQuickMenuButton(const Value: Boolean);
    procedure SetQuickMenuButtonAppearance(
      const Value: TAdvChartToolBarQuickMenuButtonAppearance);
    procedure SetQuickMenuButtonBitmaps(
      const Value: TAdvScaledBitmaps);
    procedure SetCompactAutoBitmapSize(const Value: Boolean);
    function GetTextRect: TRectF;
  protected
    {$IFDEF FNCLIB}
    function GetSubComponentArray: TAdvChartStylesManagerComponentArray;
    {$ENDIF}
    function GetDocURL: string; override;
    function GetVersion: String; override;
    function CanDrawDesignTime: Boolean; virtual;
    function CanBuildControls: Boolean; virtual;
    function GetOptionsMenuButtonClass: TAdvChartToolBarDropDownButtonClass; virtual;
    function GetBitmapPickerClass: TAdvChartToolBarBitmapPickerClass; virtual;
    function GetToolBarButtonClass: TAdvChartToolBarButtonClass; virtual;
    function GetColorPickerClass: TAdvChartToolBarColorPickerClass; virtual;
    function GetItemPickerClass: TAdvChartToolBarItemPickerClass; virtual;
    function GetFontNamePickerClass: TAdvChartToolBarFontNamePickerClass; virtual;
    function GetFontSizePickerClass: TAdvChartToolBarFontSizePickerClass; virtual;
    function GetToolBarSeparatorClass: TAdvChartToolBarSeparatorClass; virtual;
    function GetTextSize: TSizeF; virtual;
    function GetHiddenControl(AControl: TControl): TAdvChartToolBarControl; virtual;
    function GetCompactControl(AControl: TControl): TAdvChartToolBarControl; virtual;
    function GetHiddenControlCount(AControl: TControl): Integer; virtual;
    function GetCompactControlCount: Integer; virtual;
    function GetCompactTextRect: TRectF; virtual;
    function GetCompactBitmapRect(ARect: TRectF): TRectF; virtual;
    function GetCompactBitmapSize: Single; virtual;
    function GetQuickMenuButtonRect: TRectF; virtual;
    function HasHint: Boolean; override;
    function GetHintString: String; override;
    procedure ChangeDPIScale(M, D: Integer); override;
    procedure HandleQuickMenuButton; virtual;
    procedure CompactAppearanceChanged(Sender: TObject);
    procedure QuickMenuButtonAppearanceChanged(Sender: TObject);
    procedure CompactBitmapsChanged(Sender: TObject);
    procedure CompactExpanderBitmapsChanged(Sender: TObject);
    procedure QuickMenuButtonBitmapsChanged(Sender: TObject);    
    procedure ApplyFlatStyle; virtual;
    procedure SetAdaptToStyle(const Value: Boolean); override;
    procedure ApplyStyle; override;
    procedure ResetToDefaultStyle; override;
    procedure HandleMouseDown(Button: TAdvMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure HandleMouseMove(Shift: TShiftState; X, Y: Single); override;
    procedure HandleMouseLeave; override;
    procedure HandleMouseUp(Button: TAdvMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure HandleCompact; virtual;
    procedure DeactivateAllPopups; virtual;
    procedure DoCompactClick; virtual;
    procedure HandleDblClick({%H-}X, {%H-}Y: Single); override;
    procedure UpdateDockPanel; virtual;
    procedure InsertToolBarControl(AControl: TControl; {%H-}AIndex: Integer);
    procedure DoDragGripMoving(ADeltaX, ADeltaY: Double); virtual;
    {$IFDEF FMXLIB}
    procedure SetVisible(const Value: Boolean); override;
    procedure DoMatrixChanged(Sender: TObject); override;
    {$ENDIF}
    {$IFDEF CMNWEBLIB}
    procedure VisibleChanging; override;
    {$ENDIF}
    function GetDragGripRect(AInteraction: Boolean = False): TRectF;
    procedure CompactControls; virtual;
    procedure UncompactControls; virtual;
    procedure DoCustomizeOptionsMenu; virtual;
    procedure DoCustomizeOptionsMenuItem(AControl: TControl; AMenuItem: TMenuItem); virtual;
    procedure DoCanShowOptionsMenuItem(AControl: TControl; var ACanShowItem: Boolean); virtual;
    procedure UpdateToolBar(Sender: TObject);
    procedure DoIsLastElement(AControl: TControl; var ALastElement: Boolean);
    procedure UpdateToolBarControl(Sender: TObject);
    procedure OptionMenuItemClick(Sender: TObject);
    {$IFDEF FMXLIB}
    procedure OptionMenuItemApplyStyleLookup(Sender: TObject);
    {$ENDIF}
    procedure OptionsButtonClick(Sender: TObject);
    procedure DoCloseCompactPopup(Sender: TObject);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    {$IFDEF FMXLIB}
    procedure DoAddObject(const AObject: TFmxObject); override;
    procedure DoInsertObject(Index: Integer; const AObject: TFmxObject); override;
    procedure DoRemoveObject(const AObject: TFmxObject); override;
    {$ENDIF}

    {$IFDEF CMNWEBLIB}
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    {$ENDIF}
    procedure UpdateControlAfterResize; override;
    procedure UpdateControls; virtual;
    procedure InitializeOptionsMenu; virtual;
    procedure DrawDragGrip(AGraphics: TAdvChartGraphics); virtual;
    procedure DrawText(AGraphics: TAdvChartGraphics); virtual;
    procedure DrawCompactBitmap(AGraphics: TAdvChartGraphics; ARect: TRectF); virtual;
    procedure DrawCompactText(AGraphics: TAdvChartGraphics); virtual;
    procedure DrawCompactExpander(AGraphics: TAdvChartGraphics); virtual;
    procedure ShowOptionsMenu(X, Y: Single); virtual;
    function XYToAnchor(AX, AY: Single): string;
    procedure DoAnchorClick(AAnchor: string); virtual;
    procedure Loaded; override;
    property BlockUpdate: Boolean read FBlockUpdate write FBlockUpdate;
    property OnCompactClick: TNotifyEvent read FOnCompactClick write FOnCompactClick;
    property OnUpdateControls: TNotifyEvent read FOnUpdateControls write FOnUpdateControls;
    property OnUpdateDockPanel: TNotifyEvent read FOnUpdateDockPanel write FOnUpdateDockPanel;
    property OnInternalMouseDown: TNotifyEvent read FOnInternalMouseDown write FOnInternalMouseDown;
    property OnInternalInsertControl: TNotifyEvent read FOnInternalInsertControl write FOnInternalInsertControl;
    property OnInternalMouseUp: TNotifyEvent read FOnInternalMouseUp write FOnInternalMouseUp;
    property OnInternalMouseMove: TNotifyEvent read FOnInternalMouseMove write FOnInternalMouseMove;
    property OnInternalDblClick: TNotifyEvent read FOnInternalDblClick write FOnInternalDblClick;
    property Version: String read GetVersion;
    property AutoSize: Boolean read FAutoSize write SetAS default True;
    property AutoHeight: Boolean read FAutoHeight write SetAutoHeight default True;
    property AutoWidth: Boolean read FAutoWidth write SetAutoWidth default True;
    property AutoAlign: Boolean read FAutoAlign write SetAutoAlign default True;
    property AutoStretchHeight: Boolean read FAutoStretchHeight write SetAutoStretchHeight default False;
    property AutoMoveToolBar: Boolean read FAutoMoveToolBar write FAutoMoveToolBar default True;
    property Appearance: TAdvChartToolBarAppearance read FAppearance write SetAppearance;
    property WordWrapping: Boolean read FWordWrapping write SetWordWrapping default False;
    property Text: string read FText write SetText;
    property TextVisible: Boolean read FTextVisible write SetTextVisible default True;
    property Trimming: TAdvChartGraphicsTextTrimming read FTrimming write SetTrimming default gttCharacter;
    property HorizontalTextAlign: TAdvChartGraphicsTextAlign read FHorizontalTextAlign write SetHorizontalTextAlign default gtaCenter;
    property VerticalTextAlign: TAdvChartGraphicsTextAlign read FVerticalTextAlign write SetVerticalTextAlign default gtaCenter;
    property Font: TAdvChartGraphicsFont read FFont write SetFont;
    property OptionsMenu: TAdvChartToolBarOptionsMenu read FOptionsMenu write SetOptionsMenu;
    property OnOptionsMenuItemCanShow: TAdvChartToolBarCanShowOptionsMenuItem read FOnOptionsMenuItemCanShow write FOnOptionsMenuItemCanShow;
    property OnOptionsMenuCustomize: TAdvChartToolBarCustomizeOptionsMenu read FOnOptionsMenuCustomize write FOnOptionsMenuCustomize;
    property OnOptionsMenuItemCustomize: TAdvChartToolBarCustomizeOptionsMenuItem read FOnOptionsMenuItemCustomize write FOnOptionsMenuItemCustomize;
    property OnOptionsMenuItemApplyStyle: TAdvChartToolBarCustomizeOptionsMenuItem read FOnOptionsMenuItemApplyStyle write FOnOptionsMenuItemApplyStyle;
    property OnOptionsMenuButtonClick: TNotifyEvent read FOnOptionsMenuButtonClick write FOnOptionsMenuButtonClick;
    property OnOptionsMenuItemClick: TAdvChartToolBarOptionsMenuItemClick read FOnOptionsMenuItemClick write FOnOptionsMenuItemClick;
    property CustomOptionsMenu: TPopupMenu read FCustomOptionsMenu write FCustomOptionsMenu;
    property State: TAdvChartToolBarElementState read FState write SetState default esNormal;
    property OnIsLastElement: TAdvChartToolBarIsLastElement read FOnIsLastElement write FOnIsLastElement;
    property OnDragGripMoving: TAdvChartToolBarDragGripMovingEvent read FOnDragGripMoving write FOnDragGripMoving;
    property AutoOptionsMenu: TPopupMenu read FAutoOptionsMenu;
    property BitmapContainer: TAdvChartBitmapContainer read GetBitmapContainer write SetBitmapContainer;
    property MinimumWidth: Single read FMinimumWidth write SetMinimumWidth stored IsMinimumWidthStored nodefault;
    property CompactBitmapVisible: Boolean read FCompactBitmapVisible write SetCompactBitmapVisible default False;
    property CompactAutoBitmapSize: Boolean read FCompactAutoBitmapSize write SetCompactAutoBitmapSize default False;
    property CompactBitmaps: TAdvScaledBitmaps read FCompactBitmaps write SetCompactBitmaps;
    property Compact: Boolean read FCompact write SetCompact default False;
    property QuickMenuButton: Boolean read FQuickMenuButton write SetQuickMenuButton default False;
    property QuickMenuButtonHint: string read FQuickMenuButtonHint write FQuickMenuButtonHint;
    property CompactWidth: Single read FCompactWidth write SetCompactWidth stored IsCompactWidthStored nodefault;
    property CanCompact: Boolean read FCanCompact write SetCanCompact default True;
    property CompactAppearance: TAdvChartToolBarCompactAppearance read FCompactAppearance write SetCompactAppearance;
    property QuickMenuButtonAppearance: TAdvChartToolBarQuickMenuButtonAppearance read FQuickMenuButtonAppearance write SetQuickMenuButtonAppearance;
    property CompactBitmapSize: Single read FCompactBitmapSize write SetCompactBitmapSize stored IsCompactBitmapSizeStored nodefault;
    property CompactExpanderBitmaps: TAdvScaledBitmaps read FCompactExpanderBitmaps write SetCompactExpanderBitmaps;
    property QuickMenuButtonBitmaps: TAdvScaledBitmaps read FQuickMenuButtonBitmaps write SetQuickMenuButtonBitmaps;    
    property OnQuickMenuButtonClick: TNotifyEvent read FOnQuickMenuButtonClick write FOnQuickMenuButtonClick;
    property OnAnchorClick: TAdvChartToolBarAnchorClickEvent read FOnAnchorClick write FOnAnchorClick;
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Build; virtual;
    procedure Draw(AGraphics: TAdvChartGraphics; ARect: TRectF); override;
    {$IFDEF FMXLIB}
    procedure SetBounds(X, Y, AWidth, AHeight: Single); override;
    {$ENDIF}
    function CanExpand: Boolean; virtual;
    function CanShrink: Boolean; virtual;
    function DropDownActive: Boolean; virtual;
    procedure CloseCompactPopup; virtual;
    procedure AddCustomControl(AControl: TControl; AIndex: Integer = -1); virtual;
    function AddCustomControlClass(AControlClass: TControlClass; AIndex: Integer = -1): TControl; virtual;
    function AddButton(AWidth: Single = -1; AHeight: Single = -1; AResource: String = ''; AResourceLarge: String = ''; AText: String = '';
      AIndex: Integer = -1): TAdvChartToolBarButton; overload; virtual;
    function AddSeparator(AIndex: Integer = -1): TAdvChartToolBarSeparator; virtual;
    function AddFontNamePicker(AIndex: Integer = -1): TAdvChartToolBarFontNamePicker; virtual;
    function AddFontSizePicker(AIndex: Integer = -1): TAdvChartToolBarFontSizePicker; virtual;
    function AddColorPicker(AIndex: Integer = -1): TAdvChartToolBarColorPicker; virtual;
    function AddItemPicker(AIndex: Integer = -1): TAdvChartToolBarItemPicker; virtual;
    function AddBitmapPicker(AIndex: Integer = -1): TAdvChartToolBarBitmapPicker; virtual;
    function GetOptionsMenuButtonControl: TAdvChartToolBarDropDownButton; virtual;
  end;

  {$IFNDEF LCLLIB}
  [ComponentPlatformsAttribute(TMSPlatformsWeb)]
  {$ENDIF}
  TAdvChartToolBar = class(TAdvChartCustomToolBar)
  protected
    procedure RegisterRuntimeClasses; override;
  published
    property OnOptionsMenuButtonClick;
    property OnOptionsMenuItemCanShow;
    property OnOptionsMenuCustomize;
    property OnOptionsMenuItemCustomize;
    property OnOptionsMenuItemApplyStyle;
    property OnOptionsMenuItemClick;
    property OnIsLastElement;
    property OnDragGripMoving;
    property OnQuickMenuButtonClick;
    property OnAnchorClick;
    //
    property Version;
    property AutoHeight;
    property AutoWidth;
    property AutoSize;
    property AutoAlign;
    property AutoStretchHeight;
    property AutoMoveToolBar;
    property Appearance;
    property CanCompact;
    property OnCompactClick;
    property CompactBitmapVisible;
    property CompactBitmaps;
    property Compact;
    property CompactWidth;
    property CompactAppearance;
    property CompactBitmapSize;
    property CompactAutoBitmapSize;
    property QuickMenuButtonHint;
    property QuickMenuButton;
    property QuickMenuButtonAppearance;
    property MinimumWidth;
    property WordWrapping;
    property Text;
    property Trimming;
    property HorizontalTextAlign;
    property VerticalTextAlign;
    property Font;
    property OptionsMenu;
    property CustomOptionsMenu;
    property State;
  end;

  TAdvChartCustomDockPanelAppearance = class(TPersistent)
  private
    FOwner: TAdvChartCustomDockPanel;
    FFill: TAdvChartGraphicsFill;
    FStroke: TAdvChartGraphicsStroke;
    FMargins: TAdvMargins;
    procedure SetFill(const Value: TAdvChartGraphicsFill);
    procedure SetStroke(const Value: TAdvChartGraphicsStroke);
    procedure SetMargins(const Value: TAdvMargins);
  protected
    procedure FillChanged(Sender: TObject);
    procedure StrokeChanged(Sender: TObject);
    procedure MarginsChanged(Sender: TObject);
    property Fill: TAdvChartGraphicsFill read FFill write SetFill;
    property Stroke: TAdvChartGraphicsStroke read FStroke write SetStroke;
    property Margins: TAdvMargins read FMargins write SetMargins;
  public
    constructor Create(AOwner: TAdvChartCustomDockPanel);
    destructor Destroy; override;
  end;

  TAdvDockPanelAppearance = class(TAdvChartCustomDockPanelAppearance)
  published
    property Fill;
    property Stroke;
  end;

  TAdvChartCustomDockPanel = class(TAdvChartCustomControl)
  private
    FBlockUpdate: Boolean;
    FAppearance: TAdvDockPanelAppearance;
    FAutoSize: Boolean;
    FAutoAlign: Boolean;
    FState: TAdvChartToolBarElementState;
    procedure SetAppearance(const Value: TAdvDockPanelAppearance);
    procedure SetAutoAlign(const Value: Boolean);
    procedure SetAS(const Value: Boolean);
    procedure SetState(const Value: TAdvChartToolBarElementState);
  protected
    function GetDocURL: string; override;
    function GetVersion: String; override;
    procedure SetAdaptToStyle(const Value: Boolean); override;
    procedure UpdateControls; virtual;
    procedure InitializeControls; virtual;
    procedure RearrangeControls; virtual;
    procedure UpdateDockPanel(Sender: TObject);
    procedure ApplyStyle; override;
    procedure ResetToDefaultStyle; override;

    {$IFDEF FMXLIB}
    procedure DoAddObject(const AObject: TFmxObject); override;
    procedure DoInsertObject(Index: Integer; const AObject: TFmxObject); override;
    procedure DoRemoveObject(const AObject: TFmxObject); override;
    {$ENDIF}
    {$IFDEF CMNWEBLIB}
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    {$ENDIF}

    property Version: String read GetVersion;
    property Appearance: TAdvDockPanelAppearance read FAppearance write SetAppearance;
    property AutoSize: Boolean read FAutoSize write SetAS default True;
    property AutoAlign: Boolean read FAutoAlign write SetAutoAlign default True;
    property State: TAdvChartToolBarElementState read FState write SetState default esNormal;
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Draw(AGraphics: TAdvChartGraphics; ARect: TRectF); override;
    function AddToolBar({%H-}AIndex: Integer = -1): TAdvChartToolBar;
    {$IFDEF FMXLIB}
    procedure SetBounds(X, Y, AWidth, AHeight: Single); override;
    {$ENDIF}
  end;

  {$IFNDEF LCLLIB}
  [ComponentPlatformsAttribute(TMSPlatformsWeb)]
  {$ENDIF}
  TAdvDockPanel = class(TAdvChartCustomDockPanel)
  published
    property Version;
    property Appearance;
    property AutoSize;
    property AutoAlign;
    property State;
  end;

  {$IFDEF CMNWEBLIB}
  TAdvChartToolBarParent = TWinControl;
  {$ENDIF}
  {$IFDEF FMXLIB}
  TAdvChartToolBarParent = TControl;
  {$ENDIF}

implementation

uses
  Math, SysUtils, AdvChartUtils, Graphics, {%H-}StrUtils;

type
  TControlOpen = class(TControl);

function TAdvChartCustomToolBar.AddBitmapPicker(
  AIndex: Integer): TAdvChartToolBarBitmapPicker;
begin
  FBlockUpdate := True;
  Result := GetBitmapPickerClass.Create(Self);
  Result.Appearance.FlatStyle := Appearance.FlatStyle;
  InsertToolBarControl(Result, AIndex);
  FBlockUpdate := False;
  UpdateControls;
end;

function TAdvChartCustomToolBar.AddButton(AWidth: Single = -1; AHeight: Single = -1;
  AResource: String = ''; AResourceLarge: String = ''; AText: String = ''; AIndex: Integer = -1): TAdvChartToolBarButton;
begin
  FBlockUpdate := True;
  Result := GetToolBarButtonClass.Create(Self);
  Result.Appearance.FlatStyle := Appearance.FlatStyle;
  Result.Text := AText;
  if AWidth <> -1 then
  begin
    {$IFDEF FMXLIB}
    Result.Width := AWidth;
    {$ENDIF}
    {$IFDEF CMNWEBLIB}
    Result.Width := Round(AWidth);
    {$ENDIF}
  end;

  if AHeight <> -1 then
  begin
    {$IFDEF FMXLIB}
    Result.Height := AHeight;
    {$ENDIF}
    {$IFDEF CMNWEBLIB}
    Result.Height := Round(AHeight);
    {$ENDIF}
  end;

  if AResource <> '' then
  begin
    Result.Bitmaps.AddBitmapFromResource(AResource, HInstance, 1.0);
    Result.DisabledBitmaps.AddBitmapFromResource(AResource, HInstance, 1.0);
    Result.HoverBitmaps.AddBitmapFromResource(AResource, HInstance, 1.0);
  end;

  if AResourceLarge <> '' then
  begin
    Result.Bitmaps.AddBitmapFromResource(AResourceLarge, HInstance, 1.5);
    Result.DisabledBitmaps.AddBitmapFromResource(AResourceLarge, HInstance, 1.5);
    Result.HoverBitmaps.AddBitmapFromResource(AResourceLarge, HInstance, 1.5);
  end;

  InsertToolBarControl(Result, AIndex);

  FBlockUpdate := False;
  UpdateControls;
end;

function TAdvChartCustomToolBar.AddColorPicker(
  AIndex: Integer): TAdvChartToolBarColorPicker;
begin
  FBlockUpdate := True;
  Result := GetColorPickerClass.Create(Self);
  Result.Appearance.FlatStyle := Appearance.FlatStyle;
  InsertToolBarControl(Result, AIndex);
  FBlockUpdate := False;
  UpdateControls;
end;

procedure TAdvChartCustomToolBar.AddCustomControl(AControl: TControl; AIndex: Integer = -1);
begin
  FBlockUpdate := True;
  InsertToolBarControl(AControl, AIndex);
  FBlockUpdate := False;
  UpdateControls;
end;

function TAdvChartCustomToolBar.AddCustomControlClass(AControlClass: TControlClass;
  AIndex: Integer = -1): TControl;
begin
  FBlockUpdate := True;
  Result := AControlClass.Create(Self);
  InsertToolBarControl(Result, AIndex);
  FBlockUpdate := False;
  UpdateControls;
end;

function TAdvChartCustomToolBar.AddFontNamePicker(
  AIndex: Integer): TAdvChartToolBarFontNamePicker;
begin
  FBlockUpdate := True;
  Result := GetFontNamePickerClass.Create(Self);
  Result.Appearance.FlatStyle := Appearance.FlatStyle;
  InsertToolBarControl(Result, AIndex);
  FBlockUpdate := False;
  UpdateControls;
end;

function TAdvChartCustomToolBar.AddFontSizePicker(
  AIndex: Integer): TAdvChartToolBarFontSizePicker;
begin
  FBlockUpdate := True;
  Result := GetFontSizePickerClass.Create(Self);
  Result.Appearance.FlatStyle := Appearance.FlatStyle;
  InsertToolBarControl(Result, AIndex);
  FBlockUpdate := False;
  UpdateControls;
end;

function TAdvChartCustomToolBar.AddItemPicker(
  AIndex: Integer): TAdvChartToolBarItemPicker;
begin
  FBlockUpdate := True;
  Result := GetItemPickerClass.Create(Self);
  Result.Appearance.FlatStyle := Appearance.FlatStyle;
  InsertToolBarControl(Result, AIndex);
  FBlockUpdate := False;
  UpdateControls;
end;

function TAdvChartCustomToolBar.AddSeparator(AIndex: Integer = -1): TAdvChartToolBarSeparator;
begin
  FBlockUpdate := True;
  Result := GetToolBarSeparatorClass.Create(Self);
  InsertToolBarControl(Result, AIndex);
  FBlockUpdate := False;
  UpdateControls;
end;

procedure TAdvChartCustomToolBar.ApplyFlatStyle;
var
  I: Integer;
  c: TControl;
begin
  for I := 0 to Self.ControlCount - 1 do
  begin
    c := Self.Controls[I];
    {$IFDEF FMXLIB}
    if Supports(c, IDesignerControl) then
      Continue;
    {$ENDIF}

    if c is TAdvChartDefaultToolBarButton then
      (c as TAdvChartDefaultToolBarButton).Appearance.FlatStyle := Appearance.FlatStyle;

    if c is TAdvChartCustomToolBar then
      (c as TAdvChartCustomToolBar).Appearance.FlatStyle := Appearance.FlatStyle;
  end;

  Invalidate;
end;

procedure TAdvChartCustomToolBar.ApplyStyle;
var
  c: TAdvChartGraphicsColor;
begin
  inherited;
  c := gcNull;
  if TAdvChartStyles.GetStyleHeaderFillColor(c) then
  begin
    Appearance.Fill.Kind := gfkSolid;
    Appearance.Fill.Color := c;
  end;

  if TAdvChartStyles.GetStyleHeaderFillColorTo(c) then
  begin
    Appearance.Fill.Kind := gfkGradient;
    Appearance.Fill.ColorTo := c;
  end;
end;

procedure TAdvChartCustomToolBar.Assign(Source: TPersistent);
var
  c, cc: TControl;
  I: Integer;
begin
  inherited;
  if Source is TAdvChartCustomToolBar then
  begin
    FCompactAppearance.Assign((Source as TAdvChartCustomToolBar).CompactAppearance);
    FQuickMenuButtonAppearance.Assign((Source as TAdvChartCustomToolBar).QuickMenuButtonAppearance);
    FQuickMenuButton := (Source as TAdvChartCustomToolBar).QuickMenuButton;
    FCompactBitmaps.Assign((Source as TAdvChartCustomToolBar).CompactBitmaps);
    FCompact := (Source as TAdvChartCustomToolBar).Compact;
    FCanCompact := (Source as TAdvChartCustomToolBar).CanCompact;
    FMinimumWidth := (Source as TAdvChartCustomToolBar).MinimumWidth;
    FCompactWidth := (Source as TAdvChartCustomToolBar).CompactWidth;
    FCompactBitmapSize := (Source as TAdvChartCustomToolBar).CompactBitmapSize;
    FCompactAutoBitmapSize := (Source as TAdvChartCustomToolBar).CompactAutoBitmapSize;
    FCompactExpanderBitmaps.Assign((Source as TAdvChartCustomToolBar).CompactExpanderBitmaps);
    FQuickMenuButtonBitmaps.Assign((Source as TAdvChartCustomToolBar).QuickMenuButtonBitmaps);    
    FCompactBitmapVisible := (Source as TAdvChartCustomToolBar).CompactBitmapVisible;
    FText := (Source as TAdvChartCustomToolBar).Text;
    FTextVisible := (Source as TAdvChartCustomToolBar).TextVisible;
    FWordWrapping := (Source as TAdvChartCustomToolBar).WordWrapping;
    FHorizontalTextAlign := (Source as TAdvChartCustomToolBar).HorizontalTextAlign;
    FVerticalTextAlign := (Source as TAdvChartCustomToolBar).VerticalTextAlign;
    FTrimming := (Source as TAdvChartCustomToolBar).Trimming;
    FFont.Assign((Source as TAdvChartCustomToolBar).Font);
    FAutoSize := (Source as TAdvChartCustomToolBar).AutoSize;
    FAutoHeight := (Source as TAdvChartCustomToolBar).AutoHeight;
    FAutoWidth := (Source as TAdvChartCustomToolBar).AutoWidth;
    FAutoAlign := (Source as TAdvChartCustomToolBar).AutoAlign;
    FAutoStretchHeight := (Source as TAdvChartCustomToolBar).AutoStretchHeight;
    FAutoMoveToolBar := (Source as TAdvChartCustomToolBar).AutoMoveToolBar;
    FAppearance.Assign((Source as TAdvChartCustomToolBar).Appearance);
    for I := 0 to (Source as TAdvChartCustomToolBar).ControlCount - 1 do
    begin
      cc := (Source as TAdvChartCustomToolBar).Controls[I];
      if ((cc is TAdvChartDefaultToolBarButton) and (cc as TAdvChartDefaultToolBarButton).CanCopy) or not ((cc is TAdvChartDefaultToolBarButton) and (cc is TControl)) then
      begin
        if cc is TAdvChartDefaultToolBarButton then
          (cc as TAdvChartDefaultToolBarButton).ApplyName := False;

        c := (TAdvChartUtils.Clone(cc) as TControl);
        if cc is TAdvChartDefaultToolBarButton then
          (cc as TAdvChartDefaultToolBarButton).ApplyName := True;

        AddCustomControl(c);
      end;
    end;
    Invalidate;
  end
  else
    inherited;
end;

procedure TAdvChartCustomToolBar.Build;
begin
  UpdateControls;
end;

procedure TAdvChartCustomToolBar.ChangeDPIScale(M, D: Integer);
begin
  inherited;
  Font.Height := TAdvChartUtils.MulDivInt(Font.Height, M, D);
  Appearance.HorizontalSpacing := TAdvChartUtils.MulDivSingle(Appearance.HorizontalSpacing, M, D);
  Appearance.VerticalSpacing := TAdvChartUtils.MulDivSingle(Appearance.VerticalSpacing, M, D);
  CompactWidth := TAdvChartUtils.MulDivSingle(CompactWidth, M, D);
  CompactBitmapSize := TAdvChartUtils.MulDivSingle(CompactBitmapSize, M, D);
end;

function TAdvChartCustomToolBar.CanShrink: Boolean;
var
  I: Integer;
  c: TControl;
  btn: TAdvChartDefaultToolBarButton;
begin
  Result := False;

  if not Compact and CanCompact then
  begin
    Result := True;
    Exit;
  end;

  for I := Self.ControlCount - 1 downto 0 do
  begin
    c := Self.Controls[I];
    {$IFDEF FMXLIB}
    if Supports(c, IDesignerControl) then
      Continue;
    {$ENDIF}

    if c <> FOptionsMenuButton then
    begin
      if c is TAdvChartDefaultToolBarButton then
      begin
        btn := c as TAdvChartDefaultToolBarButton;
        if (Integer(btn.Layout) > Integer(btn.MinimumLayout)) and (btn.Layout <> bblNone) then
        begin
          Result := True;
          Break;
        end;
      end;
    end;
  end;
end;

procedure TAdvChartCustomToolBar.CloseCompactPopup;
begin
  if Assigned(FCompactPopup) then
    FCompactPopup.IsOpen := False;
end;

function TAdvChartCustomToolBar.CanBuildControls: Boolean;
begin
  Result := True;
end;

function TAdvChartCustomToolBar.CanDrawDesignTime: Boolean;
begin
  Result := False;
end;

function TAdvChartCustomToolBar.CanExpand: Boolean;
var
  I: Integer;
  c: TControl;
  btn: TAdvChartDefaultToolBarButton;
begin
  Result := False;

  if Compact then
  begin
    Result := True;
    Exit;
  end;

  for I := Self.ControlCount - 1 downto 0 do
  begin
    c := Self.Controls[I];
    {$IFDEF FMXLIB}
    if Supports(c, IDesignerControl) then
      Continue;
    {$ENDIF}

    if c <> FOptionsMenuButton then
    begin
      if c is TAdvChartDefaultToolBarButton then
      begin
        btn := c as TAdvChartDefaultToolBarButton;
        if (Integer(btn.Layout) < Integer(btn.MaximumLayout)) and (btn.Layout <> bblNone) then
        begin
          Result := True;
          Break;
        end;
      end;
    end;
  end;
end;

procedure TAdvChartCustomToolBar.CompactAppearanceChanged(Sender: TObject);
begin
  Invalidate;
end;

procedure TAdvChartCustomToolBar.CompactBitmapsChanged(Sender: TObject);
var
  bmp: TAdvChartBitmap;
begin
  bmp := TAdvChartGraphics.GetScaledBitmap(CompactBitmaps, 0, BitmapContainer);
  CompactBitmapVisible := Assigned(bmp) and not IsBitmapEmpty(bmp);
  Invalidate;
end;

procedure TAdvChartCustomToolBar.CompactControls;
var
  I: Integer;
  cc: TAdvChartToolBarControl;
  c: TControl;
begin
  FBlockUpdate := True;
  FCompactControls.Clear;
  for I := Self.ControlCount - 1 downto 0 do
  begin
    c := Self.Controls[I];
    {$IFDEF FMXLIB}
    if Supports(c, IDesignerControl) then
      Continue;
    {$ENDIF}

    if c <> FOptionsMenuButton then
    begin
      cc := TAdvChartToolBarControl.Create;
      cc.FControl := c;
      if c is TAdvChartDefaultToolBarButton then
      begin
        cc.FLayout := (c as TAdvChartDefaultToolBarButton).Layout;
        if ((c as TAdvChartDefaultToolBarButton).CompactLayout = bblNone) and ((c as TAdvChartDefaultToolBarButton).Layout <> bblNone) then
          (c as TAdvChartDefaultToolBarButton).CompactLayout := (c as TAdvChartDefaultToolBarButton).MaximumLayout;
      end;

      if c is TAdvChartCustomToolBarElement then
        cc.FControlIndex := (c as TAdvChartCustomToolBarElement).ControlIndex
      else
        cc.FControlIndex := c.Tag;

      c.Parent := nil;
      c.Visible := False;
      FCompactControls.Add(cc);
    end;
  end;
  FBlockUpdate := True;
  UpdateControls;
  Invalidate;
end;

procedure TAdvChartCustomToolBar.CompactExpanderBitmapsChanged(Sender: TObject);
begin
  Invalidate;
end;

constructor TAdvChartCustomToolBar.Create(AOwner: TComponent);
var
  c: TAdvChartGraphicsColor;
begin
  inherited;
  FHiddenControls := TAdvChartToolBarControlObjectList.Create;
  FCompactControls := TAdvChartToolBarControlObjectList.Create;
  {$IFNDEF LCLLIB}
  {$IFNDEF WEBLIB}
  FCompareControls := TDelegatedComparer<TControl>.Create(
    function(const Item1, Item2: TControl): Integer
    var
      c1, c2: Integer;
    begin
      if Item1 is TAdvChartCustomToolBarElement then
        c1 := (Item1 as TAdvChartCustomToolBarElement).ControlIndex
      else
        c1 := Item1.Tag;

      if Item2 is TAdvChartCustomToolBarElement then
        c2 := (Item2 as TAdvChartCustomToolBarElement).ControlIndex
      else
        c2 := Item2.Tag;

      Result := CompareValue(c1, c2);
    end);
  FCompareHiddenControls := TDelegatedComparer<TAdvChartToolBarControl>.Create(
    function(const Item1, Item2: TAdvChartToolBarControl): Integer
    begin
      Result := CompareValue(Item1.FControlIndex, Item2.FControlIndex);
    end);
  {$ENDIF}
  {$ENDIF}
  FState := esNormal;
  FAppearance := TAdvChartToolBarAppearance.Create(Self);
  FCompactAppearance := TAdvChartToolBarCompactAppearance.Create(nil);
  FCompactAppearance.OnChange := CompactAppearanceChanged;
  FQuickMenuButtonAppearance := TAdvChartToolBarQuickMenuButtonAppearance.Create(nil);
  FQuickMenuButtonAppearance.OnChange := QuickMenuButtonAppearanceChanged;
  FCompactBitmaps := TAdvScaledBitmaps.Create(Self);
  FCompactBitmaps.OnChange := CompactBitmapsChanged;
  FOptionsMenu := TAdvChartToolBarOptionsMenu.Create(Self);
  FMinimumWidth := 30;
  FCompactWidth := 50;
  FCompactBitmapSize := 24;
  FCompactAutoBitmapSize := False;
  FCompactBitmapVisible := False;
  FCompactExpanderBitmaps := TAdvScaledBitmaps.Create(Self);
  FCompactExpanderBitmaps.OnChange := CompactExpanderBitmapsChanged;
  FQuickMenuButtonBitmaps := TAdvScaledBitmaps.Create(Self);
  FQuickMenuButtonBitmaps.OnChange := QuickMenuButtonBitmapsChanged;  
  FCanCompact := True;
  FQuickMenuButton := False;
  FCompact := False;
  FAutoSize := True;
  FAutoWidth := True;
  FAutoHeight := True;
  FAutoAlign := True;
  FAutoStretchHeight := False;
  FAutoMoveToolBar := True;
  FOptionsMenuButton := GetOptionsMenuButtonClass.Create(Self);
  FOptionsMenuButton.Appearance.NormalFill.Kind := gfkSolid;
  c := gcLightgray;
  FOptionsMenuButton.Appearance.NormalFill.Color := c;
  FOptionsMenuButton.Appearance.ShowInnerStroke := False;
  FOptionsMenuButton.Appearance.Rounding := 0;

  FOptionsMenuButton.Appearance.HoverFill.Assign(FOptionsMenuButton.Appearance.NormalFill);
  FOptionsMenuButton.Appearance.DisabledFill.Assign(FOptionsMenuButton.Appearance.NormalFill);
  FOptionsMenuButton.Appearance.DownFill.Assign(FOptionsMenuButton.Appearance.NormalFill);

  FOptionsMenuButton.Appearance.HoverFill.Color := gcLightblue;
  FOptionsMenuButton.Appearance.DownFill.Color := gcLightsteelblue;
  FOptionsMenuButton.Appearance.DisabledFill.Color := gcLightgray;

  {$IFDEF VCLWEBLIB}
  FOptionsMenuButton.AlignWithMargins := True;
  {$ENDIF}
  
  {$IFNDEF LCLLIB}
  FOptionsMenuButton.Margins.Top := 3;
  FOptionsMenuButton.Margins.Bottom := 3;
  FOptionsMenuButton.Margins.Right := 3;
  {$ENDIF}
  {$IFDEF LCLLIB}
  FOptionsMenuButton.BorderSpacing.Top := 3;
  FOptionsMenuButton.BorderSpacing.Bottom := 3;
  FOptionsMenuButton.BorderSpacing.Right := 3;
  {$ENDIF}

  FOptionsMenuButton.CanCopy := False;
  FAutoOptionsMenu := TPopupMenu.Create(Self);
  {$IFDEF FMXLIB}
  FAutoOptionsMenu.Parent := Self;
  FAutoOptionsMenu.Stored := False;
  {$ENDIF}
  FOptionsMenuButton.OnClick := OptionsButtonClick;
  FOptionsMenuButton.Width := 17;
  FOptionsMenuButton.Text := '';
  FOptionsMenuButton.Stored := False;

  FOptionsMenuButton.Bitmaps.AddBitmapFromResource('ADVCHARTTOOLBAROPTIONSMENU', HInstance, 1.0);
  FOptionsMenuButton.Bitmaps.AddBitmapFromResource('ADVCHARTTOOLBAROPTIONSMENULARGE', HInstance, 1.5);
  FOptionsMenuButton.DisabledBitmaps.AddBitmapFromResource('ADVCHARTTOOLBAROPTIONSMENU', HInstance, 1.0);
  FOptionsMenuButton.DisabledBitmaps.AddBitmapFromResource('ADVCHARTTOOLBAROPTIONSMENULARGE', HInstance,1.5);
  FOptionsMenuButton.HoverBitmaps.AddBitmapFromResource('ADVCHARTTOOLBAROPTIONSMENU', HInstance, 1.0);
  FOptionsMenuButton.HoverBitmaps.AddBitmapFromResource('ADVCHARTTOOLBAROPTIONSMENULARGE', HInstance,1.5);

  FHorizontalTextAlign := gtaCenter;
  FVerticalTextAlign := gtaCenter;
  FTrimming := gttCharacter;
  FWordWrapping := False;
  FTextVisible := True;

  FFont := TAdvChartGraphicsFont.Create;

  FCompactPopup := TAdvCToolBarPopup.Create(Self);
  FCompactPopup.OnClosePopup := DoCloseCompactPopup;

  FCompactExpanderBitmaps.AddBitmapFromResource('ADVCHARTGRAPHICSDOWN', HInstance, 1.0);
  FQuickMenuButtonBitmaps.AddBitmapFromResource('ADVCHARTTOOLBARQUICKMENU', HInstance, 1.0);  
end;

procedure TAdvChartCustomToolBar.DeactivateAllPopups;
var
  I: Integer;
begin
  if Assigned(Parent) and (Parent is TAdvChartToolBarParent) then
    for I := 0 to (Parent as TAdvChartToolBarParent).ControlCount - 1 do
      if (Parent as TAdvChartToolBarParent).Controls[I] is TAdvChartCustomToolBar then
        ((Parent as TAdvChartToolBarParent).Controls[I] as TAdvChartCustomToolBar).CloseCompactPopup;
end;

destructor TAdvChartCustomToolBar.Destroy;
begin
  FQuickMenuButtonBitmaps.Free;
  FCompactExpanderBitmaps.Free;
  FCompactPopup.Free;
  FQuickMenuButtonAppearance.Free;
  FCompactAppearance.Free;
  FCompactBitmaps.Free;
  FFont.Free;
  FOptionsMenu.Free;
  FAppearance.Free;
  FHiddenControls.Free;
  FCompactControls.Free;
  inherited;
end;

procedure TAdvChartCustomToolBar.DoAnchorClick(AAnchor: string);
begin
  if Assigned(OnAnchorClick) then
    OnAnchorClick(Self, AAnchor)
  else
    TAdvChartUtils.OpenURL(AAnchor);
end;

procedure TAdvChartCustomToolBar.DoCanShowOptionsMenuItem(AControl: TControl;
  var ACanShowItem: Boolean);
begin
  if Assigned(OnOptionsMenuItemCanShow) then
    OnOptionsMenuItemCanShow(Self, AControl, ACanShowItem);
end;

procedure TAdvChartCustomToolBar.DoCloseCompactPopup(Sender: TObject);
var
  I: Integer;
  cc: TAdvChartToolBarControl;
begin
  FCompactPopup.ContentControl := nil;

  for I := 0 to FCompactControls.Count - 1 do
  begin
    cc := TAdvChartToolBarControl(FCompactControls[I]);
    if Assigned(cc.FControl) then
    begin
      if cc.FControl is TAdvChartDefaultToolBarButton then
        (cc.FControl as TAdvChartDefaultToolBarButton).Layout := cc.FLayout;

      cc.FControl.Parent := nil;
      cc.FControl.Visible := False;
    end;
  end;

  if Assigned(FCompactToolbar) then
  begin
    FCompactToolbar.Free;
    FCompactToolbar := nil;
  end;
end;

procedure TAdvChartCustomToolBar.DoCompactClick;
begin
  if Assigned(OnCompactClick) then
    OnCompactClick(Self);
end;

procedure TAdvChartCustomToolBar.DoCustomizeOptionsMenu;
begin
  if Assigned(OnOptionsMenuCustomize) then
    OnOptionsMenuCustomize(Self, FAutoOptionsMenu);
end;

procedure TAdvChartCustomToolBar.DoCustomizeOptionsMenuItem(AControl: TControl; AMenuItem: TMenuItem);
begin
  if Assigned(OnOptionsMenuItemCustomize) then
    OnOptionsMenuItemCustomize(Self, AControl, AMenuItem);
end;

procedure TAdvChartCustomToolBar.DoDragGripMoving(ADeltaX, ADeltaY: Double);
begin
  if Assigned(OnDragGripMoving) then
    OnDragGripMoving(Self, ADeltaX, ADeltaY);
end;

procedure TAdvChartCustomToolBar.DoIsLastElement(AControl: TControl; var ALastElement: Boolean);
begin
  if Assigned(OnIsLastElement) then
    OnIsLastElement(Self, AControl, ALastElement);
end;

procedure TAdvChartCustomToolBar.HandleQuickMenuButton;
begin
  if Assigned(OnQuickMenuButtonClick) then
    OnQuickMenuButtonClick(Self);
end;

function TAdvChartCustomToolBar.HasHint: Boolean;
begin
  Result := inherited HasHint;
  if FQuickMenuButtonHover then
    Result := QuickMenuButtonHint <> '';
end;

{$IFDEF FMXLIB}
procedure TAdvChartCustomToolBar.DoMatrixChanged(Sender: TObject);
begin
  inherited;
  UpdateDockPanel;
end;
{$ENDIF}

procedure TAdvChartCustomToolBar.HandleMouseLeave;
begin
  inherited;
  FHover := False;
  FQuickMenuButtonHover := False;
  Cursor := crDefault;
  FInsideDrag := False;
  //Invalidate;
end;

{$IFDEF CMNWEBLIB}
procedure TAdvChartCustomToolBar.AlignControls(AControl: TControl; var Rect: TRect);
begin
  inherited;
  UpdateControls;
end;
{$ENDIF}

{$IFDEF FMXLIB}
procedure TAdvChartCustomToolBar.DoAddObject(const AObject: TFmxObject);
begin
  inherited;
  UpdateControls;
end;

procedure TAdvChartCustomToolBar.DoInsertObject(Index: Integer;
  const AObject: TFmxObject);
begin
  inherited;
  UpdateControls;
end;

procedure TAdvChartCustomToolBar.SetBounds(X, Y, AWidth, AHeight: Single);
begin
  inherited;
  UpdateControls;
end;

procedure TAdvChartCustomToolBar.DoRemoveObject(const AObject: TFmxObject);
begin
  inherited;
  UpdateControls;
end;
{$ENDIF}

procedure TAdvChartCustomToolBar.DrawDragGrip(AGraphics: TAdvChartGraphics);
var
  cnt: Integer;

  procedure DrawDots(ARect: TRectF);
  var
    i: integer;
    rdg: TRectF;
    sz: Integer;
  begin
    if State = esLarge then
      sz := ScalePaintValue(3)
    else
      sz := ScalePaintValue(2);

    ARect.Left := ARect.Left;
    ARect.Top := ARect.Top;
    cnt := Round(ARect.Bottom) div (Round(sz) * 2);
    for i := 1 to cnt do
    begin
      rdg := RectF(ARect.Left + ((ARect.Right - ARect.Left) - sz) / 2, ARect.Top + 1, ARect.Left + sz + ((ARect.Right - ARect.Left) - sz) / 2, ARect.Top + 1 + sz);
      rdg := RectF(int(rdg.Left), int(rdg.Top), int(rdg.Right), int(rdg.Bottom));
      AGraphics.DrawRectangle(rdg);
      ARect.Top := ARect.Top + sz * 2;
    end;
  end;
var
  r: TRectF;
begin
  AGraphics.Fill.Color := Appearance.DragGripColor;
  AGraphics.Fill.Kind := gfkSolid;
  r := GetDragGripRect;
  DrawDots(r);
end;

procedure TAdvChartCustomToolBar.DrawText(AGraphics: TAdvChartGraphics);
var
  r: TRectF;
begin
  if TextVisible and (Text <> '') then
  begin
    AGraphics.Font.Assign(Font);

    r := GetTextRect;

    AGraphics.DrawText(r, Text, WordWrapping, HorizontalTextAlign, VerticalTextAlign, Trimming);
  end;
end;

function TAdvChartCustomToolBar.DropDownActive: Boolean;
var
  I: Integer;
  c: TControl;
begin
  Result := False;
  for I := 0 to Self.ControlCount - 1 do
  begin
    c := Self.Controls[I];
    if c is TAdvChartDefaultToolBarButton then
    begin
      if Assigned((c as TAdvChartDefaultToolBarButton).FPopup) then
      begin
        Result := (c as TAdvChartDefaultToolBarButton).FPopup.IsOpen;
        if Result then
          Break;
      end;
    end;
  end;
end;

function TAdvChartCustomToolBar.GetBitmapContainer: TAdvChartBitmapContainer;
begin
  Result := FBitmapContainer;
end;

function TAdvChartCustomToolBar.GetBitmapPickerClass: TAdvChartToolBarBitmapPickerClass;
begin
  Result := TAdvChartToolBarBitmapPicker;
end;

function TAdvChartCustomToolBar.GetCompactBitmapRect(ARect: TRectF): TRectF;
var
  r: TRectF;
  bs: Single;
begin
  r := ARect;
  Result := RectF(r.Left, r.Top, r.Right, r.Top);
  if CompactBitmapVisible then
  begin
    bs := GetCompactBitmapSize;
    if not TextVisible or (Text = '') then
    begin
      Result := RectF(r.Left + 3, r.Top + 3, r.Right - 3, r.Bottom - 3);
      if (bs <> -1) then
      begin
        Result.Left := Round(r.Left + ((r.Right - r.Left) - bs) / 2);
        Result.Top := Round(r.Top + ((r.Bottom - r.Top) - bs) / 2);
        Result.Right := Result.Left + bs;
        Result.Bottom := Result.Top + bs;
      end;
    end
    else if TextVisible and not (Text = '') then
      Result := RectF(r.Left + 3, r.Top + 3, r.Right - 3, r.Top + bs);
  end;
end;

function TAdvChartCustomToolBar.GetCompactBitmapSize: Single;
var
  bmp: TAdvChartBitmap;
begin
  Result := CompactBitmapSize;
  if CompactAutoBitmapSize then
  begin
    bmp := TAdvChartGraphics.GetScaledBitmap(CompactBitmaps, 0, BitmapContainer);
    if Assigned(bmp) and not IsBitmapEmpty(bmp) then
      Result := Max(bmp.Height, bmp.Width);
  end;
end;

function TAdvChartCustomToolBar.GetColorPickerClass: TAdvChartToolBarColorPickerClass;
begin
  Result := TAdvChartToolBarColorPicker;
end;

function TAdvChartCustomToolBar.GetCompactControl(
  AControl: TControl): TAdvChartToolBarControl;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to FCompactControls.Count - 1 do
  begin
    if TAdvChartToolBarControl(FCompactControls[I]).FControl = AControl then
    begin
      Result := TAdvChartToolBarControl(FCompactControls[I]);
      Break;
    end;
  end;
end;

function TAdvChartCustomToolBar.GetCompactControlCount: Integer;
begin
  Result := FCompactControls.Count;
end;

function TAdvChartCustomToolBar.GetDocURL: string;
begin
  Result := TAdvChartBaseDocURL + 'tmsfncuipack/components/' + LowerCase(ClassName);
end;

function TAdvChartCustomToolBar.GetDragGripRect(AInteraction: Boolean = False): TRectF;
var
  r: TRectF;
  f: Single;
begin
  r := LocalRect;
  f := 1;
  if State = esLarge then
    f := 1.75;

  if AInteraction then
    Result := RectF(r.Left, r.Top, r.Left + ScalePaintValue(8 * f), r.Bottom)
  else
    Result := RectF(r.Left + ScalePaintValue(3), r.Top + ScalePaintValue(3), r.Left + ScalePaintValue(6 * f), r.Bottom - ScalePaintValue(3));
end;

function TAdvChartCustomToolBar.GetFontNamePickerClass: TAdvChartToolBarFontNamePickerClass;
begin
  Result := TAdvChartToolBarFontNamePicker;
end;

function TAdvChartCustomToolBar.GetFontSizePickerClass: TAdvChartToolBarFontSizePickerClass;
begin
  Result := TAdvChartToolBarFontSizePicker;
end;

function TAdvChartCustomToolBar.GetHiddenControl(
  AControl: TControl): TAdvChartToolBarControl;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to FHiddenControls.Count - 1 do
  begin
    if TAdvChartToolBarControl(FHiddenControls[I]).FControl = AControl then
    begin
      Result := TAdvChartToolBarControl(FHiddenControls[I]);
      Break;
    end;
  end;              
end;

function TAdvChartCustomToolBar.GetHiddenControlCount(
  AControl: TControl): Integer;
var
  I: Integer;
  lst: TAdvChartToolBarControlList;
begin
  lst := TAdvChartToolBarControlList.Create;
  for I := 0 to FHiddenControls.Count - 1 do
    lst.Add(FHiddenControls[I]);

  {$IFNDEF LCLLIB}
  {$IFNDEF WEBLIB}
  lst.Sort(FCompareHiddenControls);
  {$ENDIF}
  {$ENDIF}
  Result := 0;
  for I := 0 to lst.Count - 1 do
  begin
    if TAdvChartToolBarControl(lst[I]).FControl = AControl then
      Break
    else
      Inc(Result);
  end;
  lst.Free;
end;

function TAdvChartCustomToolBar.GetHintString: String;
begin
  Result := inherited GetHintString;
  if FQuickMenuButtonHover then
    Result := QuickMenuButtonHint
end;

function TAdvChartCustomToolBar.GetItemPickerClass: TAdvChartToolBarItemPickerClass;
begin
  Result := TAdvChartToolBarItemPicker;
end;

function TAdvChartCustomToolBar.GetOptionsMenuButtonClass: TAdvChartToolBarDropDownButtonClass;
begin
  Result := TAdvChartToolBarDropDownButton;
end;

function TAdvChartCustomToolBar.GetOptionsMenuButtonControl: TAdvChartToolBarDropDownButton;
begin
  Result := FOptionsMenuButton;
end;

function TAdvChartCustomToolBar.GetQuickMenuButtonRect: TRectF;
begin
  Result := RectF(Width - 16, Height - 16, Width, Height);
  if Appearance.Separator then
  begin
    Result.Left := Result.Left - Appearance.SeparatorStroke.Width;
    Result.Right := Result.Right - Appearance.SeparatorStroke.Width;
  end;
end;

{$IFDEF FNCLIB}
function TAdvChartCustomToolBar.GetSubComponentArray: TAdvChartStylesManagerComponentArray;
var
  I: Integer;
begin
  SetLength(Result, ControlCount + FHiddenControls.Count + 1);
  for I := 0 to ControlCount - 1 do
    Result[I] := Controls[I];

  for I := 0 to FHiddenControls.Count - 1 do
    Result[I + ControlCount] := FHiddenControls[I].FControl;

  Result[Length(Result) - 1] := FOptionsMenuButton;
end;
{$ENDIF}

function TAdvChartCustomToolBar.GetCompactTextRect: TRectF;
var
  bmpr: TRectF;
  r: TRectF;
begin
  r := LocalRect;
  bmpr := GetCompactBitmapRect(r);
  Result := RectF(r.Left + 3, bmpr.Bottom + 3, r.Right - 3, r.Bottom - 23)
end;

function TAdvChartCustomToolBar.GetTextRect: TRectF;
var
  r: TRectF;
  h, sz: Single;
begin
  sz := 0;
  if Appearance.DragGrip then
  begin
    if State = esLarge then
      sz := 3
    else
      sz := 2;
  end;
  r := LocalRect;
  r := RectF(r.Left + ScalePaintValue(sz), r.Top, r.Right, r.Bottom);
  InflateRectEx(r, ScalePaintValue(-2), ScalePaintValue(-2));

  h := GetTextSize.cy;

  Result := RectF(r.Left, r.Bottom - h, r.Right, r.Bottom);
end;

function TAdvChartCustomToolBar.GetTextSize: TSizeF;
var
  g: TAdvChartGraphics;
  sz: Single;
  r: TRectF;
begin
  Result.cx := 0;
  Result.cy := 0;
  if TextVisible and (Text <> '') then
  begin
    g := TAdvChartGraphics.CreateBitmapCanvas(1, 1, NativeCanvas);
    if not NativeCanvas then
      g.BeginScene;
    g.BitmapContainer := BitmapContainer;
    g.OptimizedHTMLDrawing := OptimizedHTMLDrawing;
    try
      sz := 0;
      if Appearance.DragGrip then
      begin
        if State = esLarge then
          sz := 3
        else
          sz := 2;
      end;

      g.Font.Assign(Font);

      r := LocalRect;
      r := RectF(r.Left + sz, r.Top, r.Right, r.Bottom);
      InflateRectEx(r, -2, -2);
      Result := g.CalculateTextSize(Text, r, WordWrapping);
    finally
      if not NativeCanvas then
        g.EndScene;
      g.Free;
    end;
  end;
end;

function TAdvChartCustomToolBar.GetToolBarButtonClass: TAdvChartToolBarButtonClass;
begin
  Result := TAdvChartToolBarButton;
end;

function TAdvChartCustomToolBar.GetToolBarSeparatorClass: TAdvChartToolBarSeparatorClass;
begin
  Result := TAdvChartToolBarSeparator;
end;

function TAdvChartCustomToolBar.GetVersion: String;
begin
  Result := GetVersionNumber(MAJ_VER, MIN_VER, REL_VER, BLD_VER);
end;

procedure TAdvChartCustomToolBar.UpdateToolBar(Sender: TObject);
begin
  UpdateControls;
end;

procedure TAdvChartCustomToolBar.UpdateToolBarControl(Sender: TObject);
var
  tb: TAdvChartToolBarControl;
  bmp: TAdvChartBitmapHelperClass;
  c: TControl;
  tc: TControl;
  tci: Integer;
begin
  if not Assigned(Sender) then
    Exit;

  FBlockUpdate := True;

  c := Sender as TControl;

  tb := GetHiddenControl(c);
  if Assigned(tb) then
  begin
    tc := tb.FControl;
    tci := Max(0, Min(ControlCount, tb.FControlIndex - GetHiddenControlCount(tc)));
    FHiddenControls.Remove(tb);
    InsertToolBarControl(tc, tci);
    tc.Visible := True;
  end
  else
  begin
    tb := TAdvChartToolBarControl.Create;

    if c is TAdvChartCustomToolBarElement then
      tb.FControlIndex := (c as TAdvChartCustomToolBarElement).ControlIndex
    else
      tb.FControlIndex := c.Tag;

    tb.FControl := c;
    FBlockUpdate := True;
    bmp := c.MakeScreenshot;
    FBlockUpdate := False;
    tb.FBitmap.Assign(bmp);
    bmp.Free;
    FHiddenControls.Add(tb);
    c.Parent := nil;
    c.Visible := False;
  end;

  FBlockUpdate := False;
  UpdateControls;
end;

function TAdvChartCustomToolBar.XYToAnchor(AX, AY: Single): string;
var
  r: TRectF;
  g: TAdvChartGraphics;
begin
  Result := '';
  r := GetTextRect;

  g := TAdvChartGraphics.CreateBitmapCanvas;
  g.BeginScene;
  g.BitmapContainer := BitmapContainer;
  try
    g.Font.Assign(Font);
    Result := g.DrawText(r, FText, FWordWrapping, FHorizontalTextAlign, FVerticalTextAlign, FTrimming, 0, -1, -1, True, True, AX, AY);
  finally
    g.EndScene;
    g.Free;
  end;
end;

procedure TAdvChartCustomToolBar.InitializeOptionsMenu;
{$IFDEF WEBLIB}
begin
{$ENDIF}
{$IFNDEF WEBLIB}
var
  mnu: TAdvChartToolBarOptionMenuItem;
  bmp: TAdvChartBitmapHelperClass;
  I: Integer;
  c: TControl;
  lst: TAdvControlList;
  tb: TAdvChartToolBarControl;
  sh: Boolean;
  bmpw, bw, bh: Single;
  {$IFDEF FMXLIB}
  o: TFmxObject;
  {$ENDIF}
  maxh: Single;
begin
  lst := nil;
  try
    lst := TAdvControlList.Create;
    for I := 0 to Self.ControlCount - 1 do
      lst.Add(Controls[I]);

    for I := 0 to FHiddenControls.Count - 1 do
      lst.Add(TAdvChartToolBarControl(FHiddenControls[I]).FControl);

    {$IFNDEF LCLLIB}
    {$IFNDEF WEBLIB}
    lst.Sort(FCompareControls);
    {$ENDIF}
    {$ENDIF}

    {$IFDEF FMXLIB}
    FAutoOptionsMenu.Clear;
    {$ENDIF}
    {$IFDEF CMNLIB}
    FAutoOptionsMenu.Items.Clear;
    {$ENDIF}

    FTotalOptionsMenuWidth := 0;

    for I := 0 to lst.Count - 1 do
    begin
      c := TControl(lst[I]);

      {$IFDEF FMXLIB}
      if Supports(c, IDesignerControl) then
        Continue;
      {$ENDIF}

      if not (c = FOptionsMenuButton) and not (c is TAdvChartCustomToolBarSeparator) then
      begin
        sh := True;
        DoCanShowOptionsMenuItem(c, sh);
        if sh then
        begin
          mnu := TAdvChartToolBarOptionMenuItem.Create(FAutoOptionsMenu);
          mnu.OnClick := OptionMenuItemClick;
          {$IFDEF FMXLIB}
          mnu.OnApplyStyleLookup := OptionMenuItemApplyStyleLookup;
          mnu.Calculate := True;
          mnu.ApplyStyleLookup;
          {$ENDIF}

          bmpw := 0;
          bw := 0;
          bh := 0;
          {$IFDEF FMXLIB}
          o := mnu.FindStyleResource('checkmark');
          if Assigned(o) and (o is TControl) then
            bmpw := (o as TControl).Width;
          {$ENDIF}

          maxh := 20;
          if OptionsMenu.ShowItemBitmap then
          begin
            tb := GetHiddenControl(c);
            if Assigned(tb) then
            begin
              bmp := tb.FBitmap;
              mnu.Bitmap.Assign(bmp);
              bw := bmp.Width;
              bh := bmp.Height;
            end
            else
            begin
              FBlockUpdate := True;
              bmp := c.MakeScreenshot;
              FBlockUpdate := False;
              mnu.Bitmap.Assign(bmp);
              bw := bmp.Width;
              bh := bmp.Height;
              bmp.Free;
            end;
          end;

          TAdvChartGraphics.GetAspectSize(bw, bh, bw, bh, bw, maxh, True, False, False);
          bmpw := bmpw + int(bw);

          if OptionsMenu.ShowItemText then
          begin
            if c is TAdvChartCustomToolBarButton then
              mnu.Caption := (c as TAdvChartCustomToolBarButton).AutoOptionsMenuText;

            if mnu.Caption = '' then
              mnu.Caption := c.Name;
          end;

          mnu.Control := c;
          mnu.Checked := Assigned(c.Parent);

          DoCustomizeOptionsMenuItem(c, mnu);

          {$IFDEF FMXLIB}
          FAutoOptionsMenu.AddObject(mnu);
          {$ENDIF}
          {$IFDEF CMNLIB}
          FAutoOptionsMenu.Items.Add(mnu);
          {$ENDIF}
          FTotalOptionsMenuWidth := Max(FTotalOptionsMenuWidth, bmpw);
        end;
      end;
    end;

    {$IFDEF FMXLIB}
    for I := 0 to FAutoOptionsMenu.ItemsCount - 1 do
    {$ENDIF}
    {$IFDEF CMNLIB}
    for I := 0 to FAutoOptionsMenu.Items.Count - 1 do
    {$ENDIF}
    begin
      if FAutoOptionsMenu.Items[I] is TAdvChartToolBarOptionMenuItem then
      begin
        mnu := (FAutoOptionsMenu.Items[I] as TAdvChartToolBarOptionMenuItem);
        {$IFDEF FMXLIB}
        mnu.NeedStyleLookup;
        mnu.Calculate := False;
        {$ENDIF}
        if OptionsMenu.AutoItemBitmapWidth then
          mnu.GlyphWidth := FTotalOptionsMenuWidth
        else
          mnu.GlyphWidth := OptionsMenu.ItemBitmapWidth;
      end;
    end;

  finally
    if Assigned(lst) then
      lst.Free;
  end;
{$ENDIF}
end;

procedure TAdvChartCustomToolBar.InsertToolBarControl(AControl: TControl;
  AIndex: Integer);
begin
  {$IFDEF FMXLIB}
  if (AIndex >= 0) and (AIndex <= Self.ControlCount - 1) then
    InsertObject(AIndex, AControl)
  else
    AddObject(AControl);
  {$ENDIF}
  {$IFDEF CMNWEBLIB}
  AControl.Parent := Self;
  if AIndex > -1 then
    SetChildOrder(AControl, AIndex);
  {$ENDIF}

  if Assigned(OnInternalInsertControl) then
    OnInternalInsertControl(AControl);
end;

function TAdvChartCustomToolBar.IsCompactBitmapSizeStored: Boolean;
begin
  Result := CompactBitmapSize <> 24;
end;

function TAdvChartCustomToolBar.IsCompactWidthStored: Boolean;
begin
  Result := CompactWidth <> 50;
end;

function TAdvChartCustomToolBar.IsMinimumWidthStored: Boolean;
begin
  Result := MinimumWidth <> 30;
end;

procedure TAdvChartCustomToolBar.Loaded;
begin
  inherited;
end;

procedure TAdvChartCustomToolBar.HandleCompact;
var
  I: Integer;
  cc: TAdvChartToolBarControl;
begin
  inherited;

  DeactivateAllPopups;

  if Assigned(FCompactToolbar) then
  begin
    FCompactToolbar.Free;
    FCompactToolbar := nil;
  end;

  if Assigned(FCompactPopup) then
  begin
    FCompactPopup.Free;
    FCompactPopup := nil;
  end;

  FCompactPopup := TAdvCToolBarPopup.Create(Self);
  FCompactPopup.OnClosePopup := DoCloseCompactPopup;

  FCompactToolbar := TAdvChartCustomToolBar.Create(FCompactPopup);

  {$IFDEF VCLLIB}
  {$HINTS OFF}
  {$IF COMPILERVERSION >= 33}
  FCompactToolbar.ScaleForPPI(CurrentPPI);
  {$IFEND}
  {$HINTS ON}
  {$ENDIF}

  FCompactToolbar.Assign(Self);
  FCompactToolbar.Compact := False;
  FCompactToolbar.AutoSize := True;
  FCompactToolbar.AutoHeight := False;
  FCompactToolbar.AutoWidth := True;
  FCompactToolbar.AutoStretchHeight := False;
  FCompactToolbar.Appearance.Separator := False;
  FCompactToolbar.SetControlMargins(1, 1, 1, 1);
  FCompactToolbar.Height := Height + 2;

  for I := FCompactControls.Count - 1 downto 0 do
  begin
    cc := TAdvChartToolBarControl(FCompactControls[I]);
    if Assigned(cc.FControl) then
    begin
      if cc.FControl is TAdvChartDefaultToolBarButton then
        (cc.FControl as TAdvChartDefaultToolBarButton).Layout := (cc.FControl as TAdvChartDefaultToolBarButton).CompactLayout;
      cc.FControl.Visible := True;
      cc.FControl.Parent := FCompactToolbar;
    end;
  end;

  FCompactToolbar.UpdateControls;
  FCompactPopup.PlacementControl := Self;
  FCompactPopup.ContentControl := FCompactToolbar;
  FCompactPopup.IsOpen := True;
  DoCompactClick;
end;

procedure TAdvChartCustomToolBar.HandleDblClick(X, Y: Single);
begin
  inherited;
  if Assigned(OnInternalDblClick) then
    OnInternalDblClick(Self);
end;

procedure TAdvChartCustomToolBar.HandleMouseDown(Button: TAdvMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  inherited;
  if Appearance.DragGrip and not FDragGripMoving then
  begin
    FDragGripDown := PtInRectEx(GetDragGripRect(True), PointF(X, Y));
    FDragGripDownPt := PointF(X, Y);
  end;

  if not FDragGripDown then
  begin
    if Compact then
    begin
      FDown := True;
      Invalidate;
      CaptureEx;
    end
    else if QuickMenuButton then
    begin
      FQuickMenuButtonDown := PtInRectEx(GetQuickMenuButtonRect, PointF(X, Y));
      if FQuickMenuButtonDown then
      begin
        Invalidate;
        CaptureEx;
      end;
    end;
  end;

  if Assigned(OnInternalMouseDown) and not (Button = TAdvMouseButton.mbRight) then
    OnInternalMouseDown(Self);
end;

procedure TAdvChartCustomToolBar.HandleMouseMove(Shift: TShiftState; X, Y: Single);
var
  r: TRectF;
  absx, absy: Single;
  pt: TPointF;
  d: TAdvChartCustomDockPanel;
  a: string;
begin
  inherited;

  if Compact then
  begin
    FHoverP := FHover;
    FHover := True;
    if FHover <> FHoverP then
      Invalidate;
  end
  else if QuickMenuButton then
  begin
    FQuickMenuButtonHoverP := FQuickMenuButtonHover;
    FQuickMenuButtonHover := PtInRectEx(GetQuickMenuButtonRect, PointF(X, Y));
    if FQuickMenuButtonHover <> FQuickMenuButtonHoverP then
      Invalidate;
  end;

  if Appearance.DragGrip then
  begin
    if FDragGripDown then
    begin
      if not FDragGripMoving then
      begin
        CaptureEx;
        FDragGripMoving := True;
      end;

      if FDragGripMoving then
      begin
        absx := (FDragGripDownPt.X - X);
        absy := (FDragGripDownPt.Y - Y);
        if AutoMoveToolBar then
        begin
          {$IFDEF FMXLIB}
          pt := PointF(Position.Point.X - absx, Position.Point.Y - absy);
          {$ENDIF}
          {$IFDEF CMNWEBLIB}
          pt := PointF(Left - absx, Top - absy);
          {$ENDIF}

          if Parent is TAdvChartCustomDockPanel then
          begin
            d := Parent as TAdvChartCustomDockPanel;
            if d.AutoAlign then
            begin
              if pt.Y < d.Appearance.Margins.Top then
                pt.Y := Round(d.Appearance.Margins.Top);
              if pt.X < d.Appearance.Margins.Left then
                pt.X := Round(d.Appearance.Margins.Left)
              else if pt.X + Width > d.Width - d.Appearance.Margins.Right then
                pt.X := Round(d.Width - d.Appearance.Margins.Right - Width);

              SetBounds(Round(pt.X), Round(pt.Y), Width, Height);
            end;
          end;
        end;
        FDragGripDownPt := PointF(X + absx, Y + absy);
        DoDragGripMoving(absx, absy);
      end;
    end
    else
    begin
      r := GetDragGripRect(True);
      if PtInRectEx(r, PointF(X, Y)) then
      begin
        if not FInsideDrag then
        begin
          FInsideDrag := True;
          Cursor := crSize;
        end;
      end
      else if FInsideDrag then
      begin
        FInsideDrag := False;
        Cursor := crDefault;
      end;
    end;
  end;

  a := XYToAnchor(X, Y);

  if a <> '' then
    Cursor := crHandPoint
  else if (Cursor = crHandPoint) then
    Cursor := crDefault;

  if Assigned(OnInternalMouseMove) then
    OnInternalMouseMove(Self);
end;

procedure TAdvChartCustomToolBar.HandleMouseUp(Button: TAdvMouseButton; Shift: TShiftState;
  X, Y: Single);
var
  a: string;
begin
  inherited;
  if FDragGripDown then
    ReleaseCaptureEx
  else if FDown and Compact then
  begin
    Invalidate;
    ReleaseCaptureEx;
    HandleCompact;
  end
  else if FQuickMenuButtonDown and QuickMenuButton and not Compact then
  begin
    Invalidate;
    ReleaseCaptureEx;
    HandleQuickMenuButton;
  end;

  FDragGripDown := False;
  FDragGripMoving := False;
  FDown := False;
  FQuickMenuButtonDown := False;

  a := XYToAnchor(X, Y);
  if a <> '' then
    DoAnchorClick(a);

  if Assigned(OnInternalMouseUp) and not (Button = TAdvMouseButton.mbRight) then
    OnInternalMouseUp(Self);
end;

procedure TAdvChartCustomToolBar.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FBitmapContainer) then
    FBitmapContainer := nil;

  if (Operation = opRemove) and (AComponent = FCustomOptionsMenu) then
    FCustomOptionsMenu := nil;
end;

{$IFDEF FMXLIB}
procedure TAdvChartCustomToolBar.OptionMenuItemApplyStyleLookup(Sender: TObject);
var
  c: TControl;
begin
  c := nil;
  if (Sender is TAdvChartToolBarOptionMenuItem) then
    c := (Sender as TAdvChartToolBarOptionMenuItem).FControl;

  if Assigned(OnOptionsMenuItemApplyStyle) and (Sender is TMenuItem) then
    OnOptionsMenuItemApplyStyle(Self, c, Sender as TMenuItem);
end;
{$ENDIF}

procedure TAdvChartCustomToolBar.OptionMenuItemClick(Sender: TObject);
var
  a: Boolean;
  c: TControl;
begin
  a := True;
  c := nil;
  if (Sender is TAdvChartToolBarOptionMenuItem) then
    c := (Sender as TAdvChartToolBarOptionMenuItem).FControl;

  if Assigned(OnOptionsMenuItemClick) and (Sender is TMenuItem) then
    OnOptionsMenuItemClick(Self, c, Sender as TMenuItem, a);

  if a then
    UpdateToolBarControl(c);
end;

procedure TAdvChartCustomToolBar.OptionsButtonClick(Sender: TObject);
var
  pt: TPointF;
begin
  if Assigned(OnOptionsMenuButtonClick) then
    OnOptionsMenuButtonClick(Self)
  else
  begin
    {$IFDEF FMXLIB}
    pt := FOptionsMenuButton.Position.Point;
    {$ENDIF}
    {$IFDEF CMNWEBLIB}
    pt := PointF(FOptionsMenuButton.Left, FOptionsMenuButton.Top);
    {$ENDIF}
    pt := LocalToScreenEx(PointF(pt.X, pt.Y + FOptionsMenuButton.Height));
    ShowOptionsMenu(pt.X, pt.Y);
  end;
end;

procedure TAdvChartCustomToolBar.QuickMenuButtonAppearanceChanged(
  Sender: TObject);
begin
  Invalidate;
end;

procedure TAdvChartCustomToolBar.QuickMenuButtonBitmapsChanged(
  Sender: TObject);
begin
  Invalidate;
end;

procedure TAdvChartCustomToolBar.ResetToDefaultStyle;
begin
  inherited;
  Appearance.DragGripColor := gcLightgray;
  Appearance.Fill.Color := gcWhite;
  Appearance.Stroke.Color := gcGray;
  Appearance.Fill.Kind := gfkGradient;
  Appearance.Stroke.Kind := gskSolid;
  Appearance.Fill.Color := gcWhite;
  Appearance.Fill.ColorTo := MakeGraphicsColor(230, 230, 230);
end;

procedure TAdvChartCustomToolBar.Draw(AGraphics: TAdvChartGraphics; ARect: TRectF);
var
  qr, r: TRectF;
  w: Single;  
begin
  inherited;

  r := LocalRect;

  if Compact then
  begin
    if FDown then
    begin
      AGraphics.Fill.Assign(CompactAppearance.DownFill);
      AGraphics.Stroke.Assign(CompactAppearance.DownStroke);
    end
    else if FHover then
    begin
      AGraphics.Fill.Assign(CompactAppearance.HoverFill);
      AGraphics.Stroke.Assign(CompactAppearance.HoverStroke);
    end
    else
    begin
      AGraphics.Fill.Assign(CompactAppearance.NormalFill);
      AGraphics.Stroke.Assign(CompactAppearance.NormalStroke);
    end;

    if CompactAppearance.FlatStyle then
      AGraphics.Fill.Kind := gfkSolid;

    AGraphics.DrawRectangle(RectF(r.Left, r.Top + 2, r.Right - 3, r.Bottom - 2));
  end
  else
  begin
    AGraphics.Fill.Assign(Appearance.Fill);
    AGraphics.Stroke.Assign(Appearance.Stroke);

    if Appearance.FlatStyle then
      AGraphics.Fill.Kind := gfkSolid;

    AGraphics.DrawRectangle(r);
  end;

  if Compact then
  begin
    DrawCompactBitmap(AGraphics, ARect);
    DrawCompactText(AGraphics);
    DrawCompactExpander(AGraphics);
  end
  else
  begin
    if Appearance.DragGrip then
      DrawDragGrip(AGraphics);

    DrawText(AGraphics);

    if QuickMenuButton then
    begin
      if FQuickMenuButtonDown then
      begin
        AGraphics.Fill.Assign(QuickMenuButtonAppearance.DownFill);
        AGraphics.Stroke.Assign(QuickMenuButtonAppearance.DownStroke);
      end
      else if FQuickMenuButtonHover then
      begin
        AGraphics.Fill.Assign(QuickMenuButtonAppearance.HoverFill);
        AGraphics.Stroke.Assign(QuickMenuButtonAppearance.HoverStroke);
      end
      else
      begin
        AGraphics.Fill.Assign(QuickMenuButtonAppearance.NormalFill);
        AGraphics.Stroke.Assign(QuickMenuButtonAppearance.NormalStroke);
      end;

      if QuickMenuButtonAppearance.FlatStyle then
        AGraphics.Fill.Kind := gfkSolid;
      
      qr := GetQuickMenuButtonRect;
      AGraphics.DrawRectangle(qr);

      InflateRectEx(qr, -2, -2);
      AGraphics.DrawScaledBitmap(qr, QuickMenuButtonBitmaps);      
    end;
  end;

  if Appearance.Separator then
  begin
    AGraphics.Stroke.Assign(Appearance.SeparatorStroke);
    w := Appearance.SeparatorStroke.Width;
    AGraphics.DrawLine(PointF(r.Right - w, r.Top + 4), PointF(r.Right - w, r.Bottom - 4));
  end;

  if IsDesignTime and CanDrawDesignTime then
    AGraphics.DrawFocusRectangle(ARect, gcBlack);
end;

procedure TAdvChartCustomToolBar.DrawCompactBitmap(AGraphics: TAdvChartGraphics;
  ARect: TRectF);
var
  r: TRectF;
begin
  r := GetCompactBitmapRect(ARect);
  AGraphics.BitmapContainer := BitmapContainer;
  AGraphics.DrawScaledBitmap(r, CompactBitmaps)
end;

procedure TAdvChartCustomToolBar.DrawCompactExpander(AGraphics: TAdvChartGraphics);
var
  r: TRectF;
begin
  r := LocalRect;
  r := RectF(r.Left, r.Bottom - 20, r.Right, r.Bottom);
  InflateRectEx(r, -2, -2);
  AGraphics.DrawScaledBitmap(r, CompactExpanderBitmaps);
end;

procedure TAdvChartCustomToolBar.DrawCompactText(AGraphics: TAdvChartGraphics);
var
  tr: TRectF;
  st: TAdvChartGraphicsSaveState;
begin
  if not TextVisible or (Text = '') then
    Exit;

  tr := GetCompactTextRect;
  st := AGraphics.SaveState;
  try
    AGraphics.ClipRect(tr);
    AGraphics.Font.Assign(Font);
    AGraphics.DrawText(tr, Text, WordWrapping, HorizontalTextAlign, VerticalTextAlign, Trimming);
  finally
    AGraphics.RestoreState(st);
  end;
end;

procedure TAdvChartCustomToolBar.UncompactControls;
var
  I: Integer;
  cc: TAdvChartToolBarControl;
  c: TControl;
begin
  FBlockUpdate := True;
  for I := FCompactControls.Count - 1 downto 0 do
  begin
    cc := TAdvChartToolBarControl(FCompactControls[I]);
    c := cc.FControl;
    if Assigned(c) then
    begin
      if c is TAdvChartCustomToolBarElement then
        (c as TAdvChartCustomToolBarElement).FBlockUpdate := True;
      c.Parent := Self;
      c.Visible := True;
      if c is TAdvChartCustomToolBarElement then
        (c as TAdvChartCustomToolBarElement).FBlockUpdate := False;
      {$IFDEF VCLLIB}
      {$HINTS OFF}
      {$IF COMPILERVERSION >= 33}
      c.ScaleForPPI(CurrentPPI);
      {$IFEND}
      {$HINTS ON}
      {$ENDIF}
    end;
  end;

  FBlockUpdate := False;
  UpdateControls;

  Invalidate;
end;

procedure TAdvChartCustomToolBar.UpdateControlAfterResize;
begin
  inherited;
  UpdateDockPanel;
end;

procedure TAdvChartCustomToolBar.SetAdaptToStyle(const Value: Boolean);
begin
  inherited;
  UpdateControls;
end;

procedure TAdvChartCustomToolBar.SetAppearance(
  const Value: TAdvChartToolBarAppearance);
begin
  FAppearance.Assign(Value);
end;

procedure TAdvChartCustomToolBar.SetOptionsMenu(
  const Value: TAdvChartToolBarOptionsMenu);
begin
  FOptionsMenu.Assign(Value);
end;

procedure TAdvChartCustomToolBar.SetQuickMenuButton(const Value: Boolean);
begin
  if FQuickMenuButton <> Value then
  begin
    FQuickMenuButton := Value;
    Invalidate;
  end;
end;

procedure TAdvChartCustomToolBar.SetQuickMenuButtonAppearance(
  const Value: TAdvChartToolBarQuickMenuButtonAppearance);
begin
  FQuickMenuButtonAppearance.Assign(Value);
end;

procedure TAdvChartCustomToolBar.SetQuickMenuButtonBitmaps(
  const Value: TAdvScaledBitmaps);
begin
  FQuickMenuButtonBitmaps.Assign(Value);
end;

procedure TAdvChartCustomToolBar.SetState(const Value: TAdvChartToolBarElementState);
var
  I: Integer;
  c: TControl;
begin
  if FState <> Value then
  begin
    FState := Value;
    for I := 0 to Self.ControlCount - 1 do
    begin
      c := Self.Controls[I];
      if c is TAdvChartCustomToolBarElement then
        (c as TAdvChartCustomToolBarElement).State := FState;
    end;
  end;
end;

procedure TAdvChartCustomToolBar.SetText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    UpdateControls;
  end;
end;

procedure TAdvChartCustomToolBar.SetTextVisible(const Value: Boolean);
begin
  if FTextVisible <> Value then
  begin
    FTextVisible := Value;
    UpdateControls;
  end;
end;

procedure TAdvChartCustomToolBar.SetTrimming(
  const Value: TAdvChartGraphicsTextTrimming);
begin
  if FTrimming <> Value then
  begin
    FTrimming := Value;
    UpdateControls;
  end;
end;

procedure TAdvChartCustomToolBar.SetVerticalTextAlign(
  const Value: TAdvChartGraphicsTextAlign);
begin
  if FVerticalTextAlign <> Value then
  begin
    FVerticalTextAlign := Value;
    UpdateControls;
  end;
end;

procedure TAdvChartCustomToolBar.SetWordWrapping(const Value: Boolean);
begin
  if FWordWrapping <> Value then
  begin
    FWordWrapping := Value;
    UpdateControls;
  end;
end;

procedure TAdvChartCustomToolBar.SetAutoAlign(const Value: Boolean);
begin
  if FAutoAlign <> Value then
  begin
    FAutoAlign := Value;
    UpdateControls;
  end;
end;

procedure TAdvChartCustomToolBar.SetAutoHeight(const Value: Boolean);
begin
  if FAutoHeight <> Value then
  begin
    FAutoHeight := Value;
    UpdateControls;
  end;
end;

procedure TAdvChartCustomToolBar.SetAutoStretchHeight(const Value: Boolean);
begin
  if FAutoStretchHeight <> Value then
  begin
    FAutoStretchHeight := Value;
    UpdateControls;
  end;
end;

procedure TAdvChartCustomToolBar.SetAutoWidth(const Value: Boolean);
begin
  if FAutoWidth <> Value then
  begin
    FAutoWidth := Value;
    UpdateControls;
  end;
end;

procedure TAdvChartCustomToolBar.SetBitmapContainer(
  const Value: TAdvChartBitmapContainer);
var
  I: Integer;
  {$IFDEF FNCLIB}
  c: TControl;
  b: IAdvChartBitmapContainer;
  {$ENDIF}
begin
  FBitmapContainer := Value;
  for I := 0 to Self.ControlCount - 1 do
  begin
    {$IFDEF FNCLIB}
    {$IFNDEF WEBLIB}
    c := Self.Controls[I];
    {$IFDEF FMXLIB}
    if Supports(c, IDesignerControl) then
      Continue;
    {$ENDIF}
    {$ENDIF}
    {$ENDIF}

    {$IFDEF FNCLIB}
    if Supports(c, IAdvChartBitmapContainer, b) then
      b.BitmapContainer := Value;
    {$ENDIF}
  end;
  Invalidate;
end;

procedure TAdvChartCustomToolBar.SetCanCompact(const Value: Boolean);
begin
  if FCanCompact <> Value then
    FCanCompact := Value;
end;

procedure TAdvChartCustomToolBar.SetCompact(const Value: Boolean);
begin
  if FCompact <> Value then
  begin
    if CanCompact then
    begin
      FCompact := Value;
      if Compact then
      begin
        FOldMenuButtonState := OptionsMenu.ShowButton;
        OptionsMenu.ShowButton := False;
        FOldWidth := Width;
        CompactControls;
        Width := Round(CompactWidth);
      end
      else
      begin
        Width := Round(FOldWidth);
        UncompactControls;
        OptionsMenu.ShowButton := FOldMenuButtonState;
      end;

      UpdateControls;
    end;
  end;
end;

procedure TAdvChartCustomToolBar.SetCompactAppearance(
  const Value: TAdvChartToolBarCompactAppearance);
begin
  FCompactAppearance.Assign(Value);
end;

procedure TAdvChartCustomToolBar.SetCompactAutoBitmapSize(const Value: Boolean);
begin
  if FCompactAutoBitmapSize <> Value then
  begin
    FCompactAutoBitmapSize := Value;
    Invalidate;
  end;
end;

procedure TAdvChartCustomToolBar.SetCompactBitmaps(
  const Value: TAdvScaledBitmaps);
begin
  FCompactBitmaps.Assign(Value);
end;

procedure TAdvChartCustomToolBar.SetCompactBitmapSize(const Value: Single);
begin
  if FCompactBitmapSize <> Value then
  begin
    FCompactBitmapSize := Value;
    Invalidate;
  end;
end;

procedure TAdvChartCustomToolBar.SetCompactBitmapVisible(const Value: Boolean);
begin
  if FCompactBitmapVisible <> Value then
  begin
    FCompactBitmapVisible := Value;
    Invalidate;
  end;
end;

procedure TAdvChartCustomToolBar.SetCompactExpanderBitmaps(
  const Value: TAdvScaledBitmaps);
begin
  FCompactExpanderBitmaps.Assign(Value);
end;

procedure TAdvChartCustomToolBar.SetCompactWidth(const Value: Single);
begin
  if FCompactWidth <> Value then
  begin
    FCompactWidth := Value;
    if Compact then
      Width := Round(CompactWidth);
  end;
end;

procedure TAdvChartCustomToolBar.SetFont(const Value: TAdvChartGraphicsFont);
begin
  FFont.Assign(Value);
end;

procedure TAdvChartCustomToolBar.SetHorizontalTextAlign(
  const Value: TAdvChartGraphicsTextAlign);
begin
  if FHorizontalTextAlign <> Value then
  begin
    FHorizontalTextAlign := Value;
    Invalidate;
  end;
end;

procedure TAdvChartCustomToolBar.SetMinimumWidth(const Value: Single);
begin
  if FMinimumWidth <> Value then
  begin
    FMinimumWidth := Value;
    UpdateControls;
  end;
end;

procedure TAdvChartCustomToolBar.SetAS(const Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    UpdateControls;
  end;
end;

{$IFDEF FMXLIB}
procedure TAdvChartCustomToolBar.SetVisible(const Value: Boolean);
{$ENDIF}
{$IFDEF CMNWEBLIB}
procedure TAdvChartCustomToolBar.VisibleChanging;
{$ENDIF}
begin
  inherited;
  UpdateDockPanel;
end;

procedure TAdvChartCustomToolBar.ShowOptionsMenu(X, Y: Single);
begin
  {$IFDEF FMXLIB}
  if not Assigned(CustomOptionsMenu) then
  begin
    InitializeOptionsMenu;
    DoCustomizeOptionsMenu;
    if FAutoOptionsMenu.ItemsCount > 0 then
      FAutoOptionsMenu.Popup(X, Y);
  end
  else
    CustomOptionsMenu.Popup(X, Y);
 {$ENDIF}
 {$IFDEF CMNLIB}
  if not Assigned(CustomOptionsMenu) then
  begin
    InitializeOptionsMenu;
    DoCustomizeOptionsMenu;
    if FAutoOptionsMenu.Items.Count > 0 then
      FAutoOptionsMenu.Popup(Round(X), Round(Y));
  end
  else
    CustomOptionsMenu.Popup(Round(X), Round(Y));
  {$ENDIF}
end;

procedure TAdvChartCustomToolBar.UpdateControls;
var
  I: Integer;
  c: TControl;
  idx: Integer;
  fu: Boolean;
  hc: TAdvChartToolBarControl;
  {$IFDEF FMXLIB}
  maxx, x, w, y, h, hs, hsm, vs, xs, ys, txth, txtw: Single;
  mgr: TBounds;
  {$ENDIF}
  {$IFDEF CMNWEBLIB}
  maxx, x, w, y, h, hs, hsm, vs, xs, ys, txth, txtw: Integer;
  {$ENDIF}
  {$IFDEF LCLLIB}
  mgr: TControlBorderSpacing;
  {$ENDIF}
  {$IFDEF VCLWEBLIB}
  mgr: TMargins;
  {$ENDIF}
  l: Boolean;
  {$IFDEF FNCLIB}
  ia: IAdvAdaptToStyle;
  {$ENDIF}
  sz: TSizeF;
  cn: TControl;
  lm, tm, rm, bm: Single;

  function GetControl(AIndex: Integer): TControl;
  begin
    Result := nil;

    if (AIndex >= 0) and (AIndex <= Self.ControlCount - 1) then
    begin
      if Self.Controls[AIndex].Visible then
      begin
        Result := Self.Controls[AIndex];
        Exit;
      end;
    end;

    while (AIndex >= 0) and (AIndex <= Self.ControlCount - 1) do
    begin
      Inc(AIndex);
      if (AIndex >= 0) and (AIndex <= Self.ControlCount - 1) then
      begin
        if Self.Controls[AIndex].Visible then
        begin
          Result := Self.Controls[AIndex];
          Exit;
        end;
      end;
    end;
  end;

  function IsLoadingEx: Boolean;
  var
    ii: Integer;
    ctl: TControl;
  begin
    Result := IsLoading;
    if not Result then
    begin
      for ii := ControlCount - 1 downto 0 do
      begin
        ctl := Controls[ii];
        if (csLoading in ctl.ComponentState) then
        begin
          Result := True;
          Exit;
        end;
      end;
    end;
  end;

begin
  if FBlockUpdate or FBlockResize or IsLoadingEx or IsDestroying or not CanBuildControls then
    Exit;

  FBlockUpdate := True;
  {$IFDEF FMXLIB}
  hs := Appearance.HorizontalSpacing;
  vs := Appearance.VerticalSpacing;
  {$ENDIF}
  {$IFDEF CMNWEBLIB}
  hs := Round(Appearance.HorizontalSpacing);
  vs := Round(Appearance.VerticalSpacing);
  {$ENDIF}

  x := hs;
  if Appearance.DragGrip then
  begin
    {$IFDEF FMXLIB}
    x := x + GetDragGripRect.Right;
    {$ENDIF}
    {$IFDEF CMNWEBLIB}
    x := x + Round(GetDragGripRect.Right);
    {$ENDIF}
    if hs = 0 then
      x := x + ScalePaintValue(3);
  end;

  y := vs;

  xs := x;
  ys := y;

  hsm := ScalePaintValue(30);
  txth := 0;
  txtw := 0;
  sz := GetTextSize;
  if sz.cy > 0 then
    txth := Round(sz.cy + ScalePaintValue(4));

  if sz.cx > 0 then
    txtw := Round(sz.cx + ScalePaintValue(8));

  w := txtw;
  maxx := 0;
  h := 0;
  idx := 0;

  fu := False;
  for I := 0 to Self.ControlCount - 1 do
  begin
    c := Self.Controls[I];
    {$IFDEF FMXLIB}
    if Supports(c, IDesignerControl) then
      Continue;
    {$ENDIF}

    hc := GetHiddenControl(c);
    fu := not Assigned(hc);
    if fu then
      Break;
  end;

  l := False;
  for I := 0 to Self.ControlCount - 1 do
  begin
    c := Self.Controls[I];
    {$IFDEF FMXLIB}
    if Supports(c, IDesignerControl) then
      Continue;
    {$ENDIF}

    {$IFDEF FNCLIB}
    if Supports(c, IAdvAdaptToStyle, ia) then
      ia.AdaptToStyle := AdaptToStyle;
    {$ENDIF}

    if l then
    begin
      x := xs;
      y := ys + h - vs;
      ys := y;
    end;

    l := False;
    if c is TAdvChartCustomToolBarElement then
    begin
      l := (c as TAdvChartCustomToolBarElement).LastElement;
      (c as TAdvChartCustomToolBarElement).OnUpdateToolBar := UpdateToolBar;
      (c as TAdvChartCustomToolBarElement).OnUpdateToolBarControl := UpdateToolBarControl;
    end;

    DoIsLastElement(c, l);

    if l then
      l := true;

    if not (c = FOptionsMenuButton) then
    begin
      if fu then
      begin
        if c is TAdvChartCustomToolBarElement then
          (c as TAdvChartCustomToolBarElement).ControlIndex := idx
        else
          c.Tag := idx;
      end;

      if c.Visible then
      begin
        {$IFDEF FMXLIB}
        if AutoAlign then
        begin
          c.Position.X := x + c.Margins.Left;
          c.Position.Y := y + c.Margins.Top;
        end;

        if AutoStretchHeight or ((c is TAdvChartDefaultToolBarButton) and ((c as TAdvChartDefaultToolBarButton).Layout = bblLarge)) then
        begin
          h := Height - c.Margins.Bottom - txth - y;
          c.Height := h;
        end
        else
          h := Max(h, c.Position.y + c.Height + vs + c.Margins.Bottom);

        cn := GetControl(I + 1);
        if Assigned(cn) and (cn is TAdvChartDefaultToolBarButton) then
        begin
          case (cn as TAdvChartDefaultToolBarButton).Layout of
            bblBitmap, bblLabel:
            begin
              y := Max(y, c.Position.Y + c.Height + vs + c.Margins.Bottom);
              if y + cn.Margins.Top + cn.Height > Height - cn.Margins.Bottom - txth then
              begin
                x := Max(x, Max(maxx, c.Position.x + c.Width + hs + c.Margins.Right));
                y := ys;
              end
              else
              begin
                c.Position.X := x + c.Margins.Left;
                maxx := Max(x, Max(maxx, c.Position.x + c.Width + hs + c.Margins.Right));
              end;
            end;
            bblNone, bblLarge:
            begin
              y := ys;
              x := Max(x, c.Position.x + c.Width + hs + c.Margins.Right);
            end;
          end;
        end
        else
        begin
          y := ys;
          x := Max(x, Max(maxx, c.Position.x + c.Width + hs + c.Margins.Right));
        end;

        {$ENDIF}
        {$IFDEF VCLWEBLIB}
        if c.AlignWithMargins then
        begin
          if AutoAlign then
          begin
            c.Left := x + c.Margins.Left;
            c.Top := y + c.Margins.Top;
          end;

          if AutoStretchHeight or ((c is TAdvChartDefaultToolBarButton) and ((c as TAdvChartDefaultToolBarButton).Layout = bblLarge)) then
          begin
            h := Height - c.Margins.Bottom - txth - y;
            c.Height := h;
          end
          else
            h := Max(h, c.Top + c.Height + vs + c.Margins.Bottom);

          cn := GetControl(I + 1);
          if Assigned(cn) and (cn is TAdvChartDefaultToolBarButton) then
          begin
            case (cn as TAdvChartDefaultToolBarButton).Layout of
              bblBitmap, bblLabel:
              begin
                y := Max(y, c.Top + c.Height + vs + c.Margins.Bottom);
                if y + cn.Margins.Top + cn.Height > Height - cn.Margins.Bottom - txth then
                begin
                  x := Max(x, Max(maxx, c.Left + c.Width + hs + c.Margins.Right));
                  y := ys;
                end
                else
                begin
                  c.Left := x + c.Margins.Left;
                  maxx := Max(x, Max(maxx, c.Left + c.Width + hs + c.Margins.Right));
                end;
              end;
              bblNone, bblLarge:
              begin
                x := Max(x, c.Left + c.Width + hs + c.Margins.Right);
                y := ys;
              end;
            end;
          end
          else
          begin
            x := Max(x, Max(maxx, c.Left + c.Width + hs + c.Margins.Right));
            y := ys;
          end;
        end
        else
        begin
          if AutoAlign then
          begin
            c.Left := x;
            c.Top := y;
          end;

          if AutoStretchHeight or ((c is TAdvChartDefaultToolBarButton) and ((c as TAdvChartDefaultToolBarButton).Layout = bblLarge)) then
          begin
            h := Height - txth - y;
            c.Height := h
          end
          else
            h := Max(h, c.Top + c.Height + vs);

          cn := GetControl(I + 1);
          if Assigned(cn) and (cn is TAdvChartDefaultToolBarButton) then
          begin
            case (cn as TAdvChartDefaultToolBarButton).Layout of
              bblBitmap, bblLabel:
              begin
                y := Max(y, c.Top + c.Height + vs);
                if y + cn.Height > Height - txth then
                begin
                  x := Max(x, Max(maxx, c.Left + c.Width + hs));
                  y := ys;
                end
                else
                begin
                  c.Left := x;
                  maxx := Max(x, Max(maxx, c.Left + c.Width + hs));
                end;
              end;
              bblNone, bblLarge:
              begin
                x := Max(x, c.Left + c.Width + hs);
                y := ys;
              end;
            end;
          end
          else
          begin
            x := Max(x, Max(maxx, c.Left + c.Width + hs));
            y := ys;
          end;
        end;
        {$ENDIF}
        {$IFDEF LCLLIB}
        if AutoAlign then
        begin
          c.Left := x + c.BorderSpacing.Left;
          c.Top := y + c.BorderSpacing.Top;
        end;

        if AutoStretchHeight or ((c is TAdvChartDefaultToolBarButton) and ((c as TAdvChartDefaultToolBarButton).Layout = bblLarge)) then
        begin
          h := Height - c.BorderSpacing.Bottom - txth - y;
          c.Height := h;
        end
        else
          h := Max(h, c.Top + c.Height + vs + c.BorderSpacing.Bottom);

        cn := GetControl(I + 1);
        if Assigned(cn) and (cn is TAdvChartDefaultToolBarButton) then
        begin
          case (cn as TAdvChartDefaultToolBarButton).Layout of
            bblBitmap, bblLabel:
            begin
              y := Max(y, c.Top + c.Height + vs + c.BorderSpacing.Bottom);
              if y + cn.BorderSpacing.Top + cn.Height > Height - cn.BorderSpacing.Bottom - txth then
              begin
                x := Max(x, Max(maxx, c.Left + c.Width + hs + c.BorderSpacing.Right));
                y := ys;
              end
              else
              begin
                c.Left := x + c.BorderSpacing.Left;
                maxx := Max(x, Max(maxx, c.Left + c.Width + hs + c.BorderSpacing.Right));
              end;
            end;
            bblNone, bblLarge:
            begin
              x := Max(x, c.Left + c.Width + hs + c.BorderSpacing.Right);
              y := ys;
            end;
          end;
        end
        else
        begin
          x := Max(x, Max(maxx, c.Left + c.Width + hs + c.BorderSpacing.Right));
          y := ys;
        end;

        {$ENDIF}
        w := Max(w, x);
      end;
      inc(idx);
    end;
  end;

  if h = 0 then
    h := hsm;

  FOptionsMenuButton.Visible := OptionsMenu.ShowButton;
  if OptionsMenu.ShowButton then
    FOptionsMenuButton.Parent := Self
  else
    FOptionsMenuButton.Parent := nil;

  {$IFDEF FMXLIB}
  if FOptionsMenuButton.Visible then
  begin
    FOptionsMenuButton.Index := Self.ControlCount;
    FOptionsMenuButton.ControlIndex := Self.ControlCount - 1;
    FOptionsMenuButton.Position.Y := FOptionsMenuButton.Margins.Top;
    mgr := FOptionsMenuButton.Margins;

    if AutoSize then
    begin
      FOptionsMenuButton.Position.X := w + mgr.Left;
      if AutoHeight then
        FOptionsMenuButton.Height := h - mgr.Bottom - mgr.Top - txth
      else if AutoStretchHeight then
        FOptionsMenuButton.Height := Height - mgr.Bottom - mgr.Top - txth;
    end
    else
    begin
      FOptionsMenuButton.Position.X := Width - FOptionsMenuButton.Width - mgr.Right;
      FOptionsMenuButton.Height := Height - mgr.Bottom - mgr.Top - txth;
    end;
    w := w + FOptionsMenuButton.Width + mgr.Right + mgr.Left;
  end;

  if AutoSize then
  begin
    if Appearance.Separator then
      w := w + Appearance.SeparatorStroke.Width;

    w := Round(Max(MinimumWidth, w));

    if ControlAlignment = caNone then
    begin
      lm := 0;
      rm := 0;
      tm := 0;
      bm := 0;
      GetControlMargins(lm, tm, rm, bm);
      w := w + lm + rm;
    end;

    h := h + txth;

    if AutoHeight and AutoWidth and (ControlAlignment = caNone) then
      SetBounds(Position.X, Position.Y, w, h)
    else if AutoHeight and not (ControlAlignment in [caLeft, caRight, caClient]) then
      SetBounds(Position.X, Position.Y, Width, h)
    else if AutoWidth and not (ControlAlignment in [caTop, caBottom, caClient]) then
      SetBounds(Position.X, Position.Y, w, Height);
  end;

  {$ENDIF}
  {$IFDEF CMNWEBLIB}
  if FOptionsMenuButton.Visible then
  begin
    FOptionsMenuButton.ControlIndex := Self.ControlCount - 1;
    {$IFDEF LCLLIB}
    FOptionsMenuButton.Top := FOptionsMenuButton.BorderSpacing.Top;
    mgr := FOptionsMenuButton.BorderSpacing;
    {$ENDIF}
    {$IFDEF VCLWEBLIB}
    FOptionsMenuButton.Top := FOptionsMenuButton.Margins.Top;
    mgr := FOptionsMenuButton.Margins;
    if not FOptionsMenuButton.AlignWithMargins then
    begin
      mgr.Left := 0;
      mgr.Top := 0;
      mgr.Right := 0;
      mgr.Bottom := 0;
    end;
    {$ENDIF}

    if AutoSize then
    begin
      FOptionsMenuButton.Left := w + mgr.Left;
      if AutoHeight then
        FOptionsMenuButton.Height := h - mgr.Bottom - mgr.Top
      else if AutoStretchHeight then
        FOptionsMenuButton.Height := Height - mgr.Bottom - txth - mgr.Top;
    end
    else
    begin
      FOptionsMenuButton.Left := Width - FOptionsMenuButton.Width - mgr.Right;
      FOptionsMenuButton.Height := Height - mgr.Bottom - mgr.Top - txth;
    end;
    w := w + FOptionsMenuButton.Width + mgr.Right + mgr.Left;
  end;

  if AutoSize then
  begin
    if Appearance.Separator then
      w := w + Round(Appearance.SeparatorStroke.Width);

    w := Round(Max(MinimumWidth, w));

    if ControlAlignment = caNone then
    begin
      lm := 0;
      rm := 0;
      tm := 0;
      bm := 0;
      GetControlMargins(lm, tm, rm, bm);
      w := w + Round(lm + rm);
    end;

    h := h + txth;

    if AutoHeight and AutoWidth and (ControlAlignment = caNone) then
      SetBounds(Left, Top, w, h)
    else if AutoHeight and not (ControlAlignment in [caLeft, caRight, caClient]) then
      SetBounds(Left, Top, Width, h)
    else if AutoWidth and not (ControlAlignment in [caTop, caBottom, caClient]) then
      SetBounds(Left, Top, w, Height);
  end;
  {$ENDIF}

  if Assigned(OnUpdateControls) then
    OnUpdateControls(Self);

  FBlockUpdate := False;
end;

procedure TAdvChartCustomToolBar.UpdateDockPanel;
begin
  if Assigned(OnUpdateDockPanel) then
    OnUpdateDockPanel(Self);
end;

{ TAdvChartDefaultToolBarButton }

procedure TAdvChartDefaultToolBarButton.AppearanceChanged;
begin
  Invalidate;
end;

procedure TAdvChartDefaultToolBarButton.ApplyStyle;
var
  c: TAdvChartGraphicsColor;
begin
  inherited;
  c := gcNull;
  if TAdvChartStyles.GetStyleBackgroundFillColor(c) then
  begin
    Appearance.NormalFill.Color := c;
    Appearance.NormalFill.Kind := gfkSolid;
    Appearance.DisabledFill.Color := Blend(c, gcDarkgray, 20);
    Appearance.DisabledFill.Kind := gfkSolid;
    Appearance.InnerStroke.Color := Blend(Appearance.NormalFill.Color, Appearance.NormalStroke.Color, 75);
    Appearance.InnerStroke.Kind := gskSolid;
  end;

  c := gcNull;
  if TAdvChartStyles.GetStyleTextFontColor(c) then
    Font.Color := c;

  c := gcNull;
  if TAdvChartStyles.GetStyleBackgroundStrokeColor(c) then
  begin
    Appearance.NormalStroke.Color := c;
    Appearance.DownStroke.Color := c;
    Appearance.DisabledStroke.Color := c;
    Appearance.NormalStroke.Color := c;
    Appearance.DownStroke.Color := c;
    Appearance.DisabledStroke.Color := c;
    Appearance.HoverStroke.Color := c;
  end;

  c := gcNull;
  if TAdvChartStyles.GetStyleSelectionFillColor(c) then
  begin
    Appearance.HoverFill.Color := c;
    Appearance.HoverFill.Kind := gfkSolid;
    Appearance.DownFill.Color := Blend(c, Fill.Color, 20);
    Appearance.DownFill.Kind := gfkSolid;
  end;
end;

procedure TAdvChartDefaultToolBarButton.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TAdvChartDefaultToolBarButton then
  begin
    FLayout := (Source as TAdvChartDefaultToolBarButton).Layout;
    FCompactLayout := (Source as TAdvChartDefaultToolBarButton).CompactLayout;
    FMinimumLayout := (Source as TAdvChartDefaultToolBarButton).MinimumLayout;
    FMaximumLayout := (Source as TAdvChartDefaultToolBarButton).MaximumLayout;
    FBitmapPosition := (Source as TAdvChartDefaultToolBarButton).BitmapPosition;
    FBitmapSize := (Source as TAdvChartDefaultToolBarButton).BitmapSize;
    FLargeLayoutBitmapSize := (Source as TAdvChartDefaultToolBarButton).LargeLayoutBitmapSize;
    FAutoBitmapSize := (Source as TAdvChartDefaultToolBarButton).AutoBitmapSize;
    FLargeLayoutAutoBitmapSize := (Source as TAdvChartDefaultToolBarButton).LargeLayoutAutoBitmapSize;
    FStretchBitmapIfNoText := (Source as TAdvChartDefaultToolBarButton).StretchBitmapIfNoText;
    FAppearance.Assign((Source as TAdvChartDefaultToolBarButton).Appearance);
    FBitmapContainer := (Source as TAdvChartDefaultToolBarButton).BitmapContainer;
    FBitmaps.Assign((Source as TAdvChartDefaultToolBarButton).Bitmaps);
    FDisabledBitmaps.Assign((Source as TAdvChartDefaultToolBarButton).DisabledBitmaps);
    FLargeLayoutHoverBitmaps.Assign((Source as TAdvChartDefaultToolBarButton).LargeLayoutHoverBitmaps);
    FLargeLayoutBitmaps.Assign((Source as TAdvChartDefaultToolBarButton).LargeLayoutBitmaps);
    FLargeLayoutDisabledBitmaps.Assign((Source as TAdvChartDefaultToolBarButton).LargeLayoutDisabledBitmaps);
    FHoverBitmaps.Assign((Source as TAdvChartDefaultToolBarButton).HoverBitmaps);
    FBitmapVisible := (Source as TAdvChartDefaultToolBarButton).BitmapVisible;
    FText := (Source as TAdvChartDefaultToolBarButton).Text;
    FTextVisible := (Source as TAdvChartDefaultToolBarButton).TextVisible;
    FDropDownHeight := (Source as TAdvChartDefaultToolBarButton).DropDownHeight;
    FDropDownWidth := (Source as TAdvChartDefaultToolBarButton).DropDownWidth;
    FDropDownAutoWidth := (Source as TAdvChartDefaultToolBarButton).DropDownAutoWidth;
    FWordWrapping := (Source as TAdvChartDefaultToolBarButton).WordWrapping;
    FHorizontalTextAlign := (Source as TAdvChartDefaultToolBarButton).HorizontalTextAlign;
    FVerticalTextAlign := (Source as TAdvChartDefaultToolBarButton).VerticalTextAlign;
    FTrimming := (Source as TAdvChartDefaultToolBarButton).Trimming;
    FFont.Assign((Source as TAdvChartDefaultToolBarButton).Font);
    FHoverFontColor := (Source as TAdvChartDefaultToolBarButton).HoverFontColor;
    FDownFontColor := (Source as TAdvChartDefaultToolBarButton).DownFontColor;
    FDisabledFontColor := (Source as TAdvChartDefaultToolBarButton).DisabledFontColor;
    FStretchText := (Source as TAdvChartDefaultToolBarButton).StretchText;
    Invalidate;
  end;
end;

procedure TAdvChartDefaultToolBarButton.BitmapsChanged(Sender: TObject);
var
  bmp: TAdvChartBitmap;
begin
  bmp := TAdvChartGraphics.GetScaledBitmap(Bitmaps, 0, BitmapContainer);
  BitmapVisible := Assigned(bmp) and not IsBitmapEmpty(bmp);

  if not BitmapVisible and (Layout = bblLarge) then
  begin
    bmp := TAdvChartGraphics.GetScaledBitmap(LargeLayoutBitmaps, 0, BitmapContainer);
    BitmapVisible := Assigned(bmp) and not IsBitmapEmpty(bmp);
  end;

  Invalidate;
end;

function TAdvChartDefaultToolBarButton.CanChangeText: Boolean;
begin
  Result := True;
end;

function TAdvChartDefaultToolBarButton.CanDrawDesignTime: Boolean;
begin
  Result := False;
end;

function TAdvChartDefaultToolBarButton.CanDropDown: Boolean;
begin
  Result := False;
end;

procedure TAdvChartDefaultToolBarButton.ChangeDPIScale(M, D: Integer);
begin
  inherited;

  BeginUpdate;
  Font.Height := TAdvChartUtils.MulDivInt(Font.Height, M, D);
  BitmapSize := TAdvChartUtils.MulDivSingle(BitmapSize, M, D);
  LargeLayoutBitmapSize := TAdvChartUtils.MulDivSingle(LargeLayoutBitmapSize, M, D);

  if FOldHeight <> -1 then
    FOldHeight := TAdvChartUtils.MulDivSingle(FOldHeight, M, D);
  FDropDownHeight := TAdvChartUtils.MulDivSingle(FDropDownHeight, M, D);
  FDropDownWidth := TAdvChartUtils.MulDivSingle(FDropDownWidth, M, D);

  FPopup.DropDownWidth := TAdvChartUtils.MulDivSingle(FPopup.DropDownWidth, M, D);
  FPopup.DropDownHeight := TAdvChartUtils.MulDivSingle(FPopup.DropDownHeight, M, D);

//  FAppearance.Rounding := TAdvChartUtils.MulDivSingle(FAppearance.Rounding, M, D);
  EndUpdate;
end;

procedure TAdvChartDefaultToolBarButton.CloseDropDown;
begin
  if not Assigned(FPopup) then
    Exit;

  if FPopup.IsOpen then
    FPopup.IsOpen := False;
end;

constructor TAdvChartDefaultToolBarButton.Create(AOwner: TComponent);
begin
  inherited;
  FOldHeight := -1;
  FLayout := bblNone;
  FCompactLayout := bblNone;
  FMinimumLayout := bblBitmap;
  FMaximumLayout := bblLarge;

  FFont := TAdvChartGraphicsFont.Create;
  FFont.OnChanged := DoFontChanged;

  FHoverFontColor := gcNull;
  FDownFontColor := gcNull;
  FDisabledFontColor := gcNull;

  FDownState := False;
  FApplyName := True;
  FCloseOnSelection := True;
  FBitmapSize := 24;
  FLargeLayoutBitmapSize := 32;
  FAutoBitmapSize := False;
  FLargeLayoutAutoBitmapSize := False;
  FStretchBitmapIfNoText := True;
  FStretchText := False;

  FDropDownWidth := 135;
  FDropDownHeight := 135;
  FDropDownAutoWidth := False;
  FPopup := TAdvChartPopup.Create(Self);
  FPopup.DragWithParent := True;
  FPopup.DropDownWidth := FDropDownWidth;
  FPopup.DropDownHeight := FDropDownHeight;
  FPopup.OnPopup := DoPopup;
  FPopup.OnClosePopup := DoClosePopup;
  FPopupPlacement := ppBottom;

  FBitmaps := TAdvScaledBitmaps.Create(Self);
  FBitmaps.OnChange := BitmapsChanged;
  FDisabledBitmaps := TAdvScaledBitmaps.Create(Self);
  FDisabledBitmaps.OnChange := BitmapsChanged;
  FHoverBitmaps := TAdvScaledBitmaps.Create(Self);
  FHoverBitmaps.OnChange := BitmapsChanged;

  FLargeLayoutBitmaps := TAdvScaledBitmaps.Create(Self);
  FLargeLayoutBitmaps.OnChange := BitmapsChanged;
  FLargeLayoutDisabledBitmaps := TAdvScaledBitmaps.Create(Self);
  FLargeLayoutDisabledBitmaps.OnChange := BitmapsChanged;
  FLargeLayoutHoverBitmaps := TAdvScaledBitmaps.Create(Self);
  FLargeLayoutHoverBitmaps.OnChange := BitmapsChanged;

  FAppearance := TAdvChartToolBarButtonAppearance.Create(Self);

  FTextVisible := True;
  FBitmapVisible := False;
  FWordWrapping := False;
  FHorizontalTextAlign := gtaCenter;
  FVerticalTextAlign := gtaCenter;
  FTrimming := gttCharacter;
  FBitmapPosition := bbpLeft;

  Width := 100;
  Height := 24;
end;

procedure TAdvChartDefaultToolBarButton.SetDisabledBitmaps(const Value: TAdvScaledBitmaps);
begin
  FDisabledBitmaps.Assign(Value);
end;

procedure TAdvChartDefaultToolBarButton.SetDisabledFontColor(
  const Value: TAdvChartGraphicsColor);
begin
  if FDisabledFontColor <> Value then
  begin
    FDisabledFontColor := Value;
    Invalidate;
  end;
end;

procedure TAdvChartDefaultToolBarButton.SetHoverBitmaps(const Value: TAdvScaledBitmaps);
begin
  FHoverBitmaps.Assign(Value);
end;

procedure TAdvChartDefaultToolBarButton.SetDownFontColor(
  const Value: TAdvChartGraphicsColor);
begin
  if FDownFontColor <> Value then
  begin
    FDownFontColor := Value;
    Invalidate;
  end;
end;

procedure TAdvChartDefaultToolBarButton.SetHoverFontColor(
  const Value: TAdvChartGraphicsColor);
begin
  if FHoverFontColor <> Value then
  begin
    FHoverFontColor := Value;
    Invalidate;
  end;
end;

procedure TAdvChartDefaultToolBarButton.SetMaximumLayout(
  const Value: TAdvChartToolBarButtonLayout);
begin
  if FMaximumLayout <> Value then
  begin
    FMaximumLayout := Value;
    UpdateToolBar;
  end;
end;

procedure TAdvChartDefaultToolBarButton.SetMinimumLayout(
  const Value: TAdvChartToolBarButtonLayout);
begin
  if FMinimumLayout <> Value then
  begin
    FMinimumLayout := Value;
    UpdateToolBar;
  end;
end;

procedure TAdvChartDefaultToolBarButton.SetDownState(const Value: Boolean);
begin
  FDownState := Value;
  Invalidate;
end;

procedure TAdvChartDefaultToolBarButton.SetDropDownControl(const Value: TControl);
begin
  FDropDownControl := Value;
  if Assigned(FDropDownControl) then
  begin
    if not (csDesigning in ComponentState) then
    begin
      if Assigned(FPopup) then
      begin
        FPopup.ContentControl := FDropDownControl;
        FPopup.FocusedControl := FDropDownControl;
      end;
    end
    else if (csDesigning in ComponentState) then
    begin
      DropDownHeight := FDropDownControl.Height;
      DropDownWidth := FDropDownControl.Width;
    end;
  end;
end;

procedure TAdvChartDefaultToolBarButton.SetDropDownAutoWidth(
  const Value: Boolean);
begin
  if FDropDownAutoWidth <> Value then
  begin
    FDropDownAutoWidth := Value;
    if Assigned(FPopup) then
    begin
      if FDropDownAutoWidth then
        FPopup.DropDownWidth := Width
      else
        FPopup.DropDownWidth := FDropDownWidth;
    end;
  end;
end;

procedure TAdvChartDefaultToolBarButton.SetDropDownHeight(const Value: Single);
begin
  FDropDownHeight := Value;
  if Assigned(FPopup) and not DropDownAutoWidth then
    FPopup.DropDownHeight := FDropDownHeight;
end;

procedure TAdvChartDefaultToolBarButton.SetDropDownWidth(const Value: Single);
begin
  FDropDownWidth := Value;
  if Assigned(FPopup) then
    FPopup.DropDownWidth := FDropDownWidth;
end;

procedure TAdvChartDefaultToolBarButton.SetFont(const Value: TAdvChartGraphicsFont);
begin
  FFont.Assign(Value);
end;

procedure TAdvChartDefaultToolBarButton.SetHorizontalTextAlign(
  const Value: TAdvChartGraphicsTextAlign);
begin
  if FHorizontalTextAlign <> Value then
  begin
    FHorizontalTextAlign := Value;
    Invalidate;
  end;
end;

procedure TAdvChartCustomToolBarButton.SetAdaptToStyle(const Value: Boolean);
begin
  inherited;
  if Assigned(FDropDownButton) then
    FDropDownButton.AdaptToStyle := AdaptToStyle;
end;

procedure TAdvChartCustomToolBarButton.SetDropDownKind(
  const Value: TAdvChartToolBarButtonDropDownKind);
begin
  if FDropDownKind <> Value then
  begin
    FDropDownKind := Value;
    if Assigned(FDropDownButton) then
    begin
      case DropDownKind of
        ddkNormal:
        begin
          FDropDownButton.Visible := False;
          FDropDownButton.Parent := nil;
          {$IFDEF FMXLIB}
          FDropDownButton.HitTest := True;
          {$ENDIF}
          FDropDownButton.Appearance.Transparent := False;
        end;
        ddkDropDown:
        begin
          FDropDownButton.Visible := False;
          FDropDownButton.Parent := Self;
          {$IFDEF FMXLIB}
          FDropDownButton.HitTest := False;
          {$ENDIF}
          FDropDownButton.Appearance.Transparent := True;
        end;
        ddkDropDownButton:
        begin
          FDropDownButton.Visible := True;
          FDropDownButton.Parent := Self;
          {$IFDEF FMXLIB}
          FDropDownButton.HitTest := True;
          {$ENDIF}
          FDropDownButton.Appearance.Transparent := False;
        end;
      end;
    end;
    Invalidate;
  end;
end;

procedure TAdvChartCustomToolBarButton.SetDropDownPosition(const Value: TAdvChartToolBarButtonDropDownPosition);
var
  sc: Single;
begin
  if FDropDownPosition <> Value then
  begin
    sc := TAdvChartUtils.GetDPIScale(Self, 96);

    FDropDownPosition := Value;
    if Assigned(FDropDownButton) then
    begin
      case Value of
        ddpRight:
        begin
          {$IFDEF FMXLIB}
          FDropDownButton.Align := TAlignLayout.Right;
          {$ENDIF}
          {$IFDEF CMNWEBLIB}
          FDropDownButton.Align := alRight;
          {$ENDIF}
          FDropDownButton.Width := Round(sc *17);
          FDropDownButton.Appearance.Corners := [gcTopRight, gcBottomRight];
        end;
        ddpBottom:
        begin
          {$IFDEF FMXLIB}
          FDropDownButton.Align := TAlignLayout.Bottom;
          {$ENDIF}
          {$IFDEF CMNWEBLIB}
          FDropDownButton.Align := alBottom;
          {$ENDIF}
          FDropDownButton.Height := Round(sc * 10);
          FDropDownButton.Appearance.Corners := [gcBottomLeft, gcBottomRight];
        end;
      end;
    end;
  end;
end;

{$IFDEF FMXLIB}
procedure TAdvChartCustomToolBarButton.SetEnabled(const Value: Boolean);
{$ENDIF}
{$IFDEF CMNWEBLIB}
procedure TAdvChartCustomToolBarButton.SetEnabled(Value: Boolean);
{$ENDIF}
var
  d: TAdvChartToolBarDropDownButton;
begin
  inherited;
  d := GetDropDownButtonControl;
  if Assigned(d) then
    d.Enabled := Value;
end;

procedure TAdvChartCustomToolBarButton.SetHidden(const Value: Boolean);
begin
  if FHidden <> Value then
  begin
    FHidden := Value;
    UpdateToolBarControl;
  end;
end;

procedure TAdvChartCustomToolBarButton.UpdateDropDownButton;
begin
  if Assigned(FDropDownButton) then
    FDropDownButton.Appearance.Rounding := Appearance.Rounding;
end;

destructor TAdvChartDefaultToolBarButton.Destroy;
begin
  FFont.Free;
  FPopup.Free;
  FBitmaps.Free;
  FDisabledBitmaps.Free;
  FHoverBitmaps.Free;
  FLargeLayoutBitmaps.Free;
  FLargeLayoutDisabledBitmaps.Free;
  FLargeLayoutHoverBitmaps.Free;
  FAppearance.Free;
  inherited;
end;

procedure TAdvChartDefaultToolBarButton.DoPopup(Sender: TObject);
begin
  InitializePopup;
end;

procedure TAdvChartDefaultToolBarButton.HandleMouseEnter;
begin
  inherited;
end;

procedure TAdvChartDefaultToolBarButton.HandleMouseLeave;
begin
  inherited;
  FDown := False;
  FHover := False;
  FPrevHover := False;
  Invalidate;
end;

procedure TAdvChartCustomToolBarButton.DoFontChanged(Sender: TObject);
begin
  Invalidate;
end;

procedure TAdvChartCustomToolBarButton.AppearanceChanged;
begin
  inherited;
  UpdateDropDownButton;
end;

procedure TAdvChartCustomToolBarButton.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TAdvChartCustomToolBarButton then
  begin
    FDropDownKind := (Source as TAdvChartCustomToolBarButton).DropDownKind;
    FDropDownPosition := (Source as TAdvChartCustomToolBarButton).DropDownPosition;
    FAutoOptionsMenuText := (Source as TAdvChartCustomToolBarButton).AutoOptionsMenuText;
    FHidden := (Source as TAdvChartCustomToolBarButton).Hidden;
    Invalidate;
  end;
end;

function TAdvChartCustomToolBarButton.CanDropDown: Boolean;
begin
  Result := DropDownKind <> ddkNormal;
end;

procedure TAdvChartCustomToolBarButton.ChangeDPIScale(M, D: Integer);
begin
  inherited;

end;

constructor TAdvChartCustomToolBarButton.Create(AOwner: TComponent);
var
  res: string;
begin
  inherited;
  FHidden := False;
  FDropDownPosition := ddpRight;
  FDropDownButton := GetDropDownButtonClass.Create(Self);
  FDropDownButton.TabStop := False;
  FDropDownButton.Text := '';
  FDropDownButton.OnClick := DropDownButtonClick;
  FDropDownButton.Visible := False;
  FDropDownButton.Width := 17;
  FDropDownButton.Appearance.Corners := [gcTopRight, gcBottomRight];
  {$IFDEF FMXLIB}
  FDropDownButton.Align := TAlignLayout.Right;
  {$ENDIF}
  {$IFDEF CMNWEBLIB}
  FDropDownButton.Align := alRight;
  {$ENDIF}
  FDropDownButton.Stored := False;

  {$IFNDEF WEBLIB}
  res := 'AdvTOOLBAREXPANDSVG';
  {$ELSE}
  res := AdvTOOLBAREXPANDSVG;
  {$ENDIF}

  FDropDownButton.Bitmaps.AddBitmapFromResource(res, HInstance);
  FDropDownButton.DisabledBitmaps.AddBitmapFromResource(res, HInstance);
  FDropDownButton.HoverBitmaps.AddBitmapFromResource(res, HInstance);
end;

destructor TAdvChartCustomToolBarButton.Destroy;
begin
  FDropDownButton.Free;
  inherited;
end;

procedure TAdvChartCustomToolBarButton.DrawButton(AGraphics: TAdvChartGraphics);
var
  r: TRectF;
begin
  inherited;
  if Assigned(FDropDownButton) and (DropDownKind = ddkDropDown) then
  begin
    case DropDownPosition of
      ddpRight: r := RectF(Width - FDropDownButton.Width, 0, Width, Height);
      ddpBottom: r := RectF(0, Height - FDropDownButton.Height, Width, Height);
    end;
    FDropDownButton.DrawBitmap(AGraphics, r);
  end;
end;

procedure TAdvChartCustomToolBarButton.DropDownButtonClick(Sender: TObject);
begin
  DropDown;
end;

procedure TAdvChartDefaultToolBarButton.DrawBitmap(AGraphics: TAdvChartGraphics; ARect: TRectF);
var
  r: TRectF;
  bmpa: TBitmap;
  bmp: TAdvChartBitmap;
  g: TAdvChartGraphics;
  x, y: Integer;
begin
  if not BitmapVisible then
    Exit;

  r := GetBitmapRect(ARect);

  if (Self is TAdvChartToolBarDropDownButton) and AdaptToStyle then
  begin
    bmpa := TBitmap.Create;
    bmpa.SetSize(ScalePaintValue(7), ScalePaintValue(7));
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
//      g.DrawLine(PointF(0, 1), PointF(6, 1), gcpmRightDown);
//      g.DrawLine(PointF(0, 2), PointF(6, 2), gcpmRightDown);
//      g.DrawLine(PointF(1, 3), PointF(5, 3), gcpmRightDown);
//      g.DrawLine(PointF(2, 4), PointF(4, 4), gcpmRightDown);
//      g.DrawLine(PointF(3, 5), PointF(3, 5), gcpmRightDown);

      for y := ScalePaintValue(1) to ScalePaintValue(5) do
      begin
        x := Max(0, y - ScalePaintValue(2));
        g.DrawLine(PointF(x, y), PointF((bmpa.Width - 1) - x, y), gcpmRightDown);
        if x >= ((bmpa.Width - 1) - x) then
          Break;
      end;

    finally
      g.EndScene;
      g.Free;
    end;

    try
      bmp := TAdvChartBitmap.Create;
      try
        bmp.Assign(bmpa);
        AGraphics.DrawBitmap(r, bmp);
      finally
        bmp.Free;
      end;
    finally
      bmpa.Free;
    end;
  end
  else
  begin
    AGraphics.BitmapContainer := BitmapContainer;

    case Layout of
      bblLarge:
      begin
        if Enabled then
        begin
          if FHover and (LargeLayoutHoverBitmaps.Count > 0) then
            AGraphics.DrawScaledBitmap(r, LargeLayoutHoverBitmaps, ResourceScaleFactor)
          else if FHover and (HoverBitmaps.Count > 0) then
            AGraphics.DrawScaledBitmap(r, HoverBitmaps, ResourceScaleFactor)
          else if LargeLayoutBitmaps.Count > 0 then
            AGraphics.DrawScaledBitmap(r, LargeLayoutBitmaps, ResourceScaleFactor)
          else
            AGraphics.DrawScaledBitmap(r, Bitmaps, ResourceScaleFactor)
        end
        else
        begin
          if LargeLayoutDisabledBitmaps.Count > 0 then
            AGraphics.DrawScaledBitmap(r, LargeLayoutDisabledBitmaps, ResourceScaleFactor)
          else if DisabledBitmaps.Count > 0 then
            AGraphics.DrawScaledBitmap(r, DisabledBitmaps, ResourceScaleFactor)
          else
            AGraphics.DrawScaledBitmap(r, Bitmaps, ResourceScaleFactor)
        end;
      end
      else
      begin
        if Enabled then
        begin
          if FHover and (HoverBitmaps.Count > 0) then
            AGraphics.DrawScaledBitmap(r, HoverBitmaps, ResourceScaleFactor)
          else
            AGraphics.DrawScaledBitmap(r, Bitmaps, ResourceScaleFactor)
        end
        else if DisabledBitmaps.Count > 0 then
          AGraphics.DrawScaledBitmap(r, DisabledBitmaps, ResourceScaleFactor)
        else
          AGraphics.DrawScaledBitmap(r, Bitmaps, ResourceScaleFactor)
      end;
    end;
  end;
end;

procedure TAdvChartDefaultToolBarButton.DrawButton(AGraphics: TAdvChartGraphics);
begin

end;

procedure TAdvChartDefaultToolBarButton.DrawText(AGraphics: TAdvChartGraphics);
var
  tr: TRectF;
  st: TAdvChartGraphicsSaveState;
begin
  if not TextVisible or (Text = '') then
    Exit;

  tr := GetTextRect;
  st := AGraphics.SaveState;
  try
    AGraphics.ClipRect(tr);
    AGraphics.Font.Assign(Font);

    if Enabled then
    begin
      if (FDown or FDownState) and (DownFontColor <> gcNull) then
        AGraphics.Font.Color := DownFontColor
      else if FHover and (HoverFontColor <> gcNull) then
        AGraphics.Font.Color := HoverFontColor
    end
    else if DisabledFontColor <> gcNull then
      AGraphics.Font.Color := DisabledFontColor;

    AGraphics.DrawText(tr, Text, WordWrapping, HorizontalTextAlign, VerticalTextAlign, Trimming);
  finally
    AGraphics.RestoreState(st);
  end;
end;

procedure TAdvChartDefaultToolBarButton.DropDown;
begin
  if not Assigned(FPopup) then
    Exit;

  FPopup.PlacementControl := Self;

  if not FPopup.IsOpen then
  begin
    if Assigned(OnBeforeDropDown) then
      OnBeforeDropDown(Self);

    if DropDownAutoWidth then
      FPopup.DropDownWidth := Width;

    FPopup.Placement := FPopupPlacement;
    FPopup.IsOpen := True;
    if Assigned(OnDropDown) then
      OnDropDown(Self);
  end
  else
    FPopup.IsOpen := False;
end;

procedure TAdvChartDefaultToolBarButton.DoFontChanged(Sender: TObject);
begin
  Invalidate;
end;

function TAdvChartCustomToolBarButton.GetBitmapRect: TRectF;
begin
  Result := inherited GetBitmapRect;
end;

function TAdvChartCustomToolBarButton.GetBitmapRect(ARect: TRectF): TRectF;
var
  r: TRectF;
  dr: TRectf;
  bs: Single;
begin
  bs := GetBitmapSize;
  case Layout of
    bblLarge: bs := GetLargeLayoutBitmapSize;
  end;

  r := ARect;
  Result := RectF(r.Left, r.Top, r.Left, r.Bottom);
  if BitmapVisible then
  begin
    if DropDownKind <> ddkNormal then
    begin
      dr := GetDropDownRect;
      case BitmapPosition of
        bbpLeft:
        begin
          case DropDownPosition of
            ddpRight: Result := RectF(Result.Left + 3, Result.Top + 3, Result.Left + 3 + bs, Result.Bottom - 3);
            ddpBottom: Result := RectF(Result.Left + 3, Result.Top + 3, Result.Left + 3 + bs, dr.Top - 3);
          end;
        end;
        bbpTop:
        begin
          case DropDownPosition of
            ddpRight: Result := RectF(Result.Left + 3, Result.Top + 3, dr.Left - 3, Result.Top + 3 + bs);
            ddpBottom: Result := RectF(Result.Left + 3, Result.Top + 3, r.Right - 3, Result.Top + 3 + bs);
          end;
        end;
      end;
    end
    else if not TextVisible or (Text = '') then
    begin
      Result := RectF(r.Left + 3, r.Top + 3, r.Right - 3, r.Bottom - 3);
      if (bs <> -1) and not StretchBitmapIfNoText then
      begin
        Result.Left := Round(r.Left + ((r.Right - r.Left) - bs) / 2);
        Result.Top := Round(r.Top + ((r.Bottom - r.Top) - bs) / 2);
        Result.Right := Result.Left + bs;
        Result.Bottom := Result.Top + bs;
      end;      
    end
    else if TextVisible and not (Text = '') then
    begin
      case BitmapPosition of
        bbpLeft: Result := RectF(r.Left + 3, r.Top + 3, r.Left + 3 + bs, r.Bottom - 3);
        bbpTop: Result := RectF(r.Left + 3, r.Top + 3, r.Right - 3, r.Top + 3 + bs);
      end;
    end;
  end;
end;

function TAdvChartCustomToolBarButton.GetDropDownButtonClass: TAdvChartToolBarDropDownButtonClass;
begin
  Result := TAdvChartToolBarDropDownButton;
end;

function TAdvChartCustomToolBarButton.GetDropDownButtonControl: TAdvChartToolBarDropDownButton;
begin
  Result := FDropDownButton;
end;

function TAdvChartCustomToolBarButton.GetDropDownRect: TRectF;
begin
  Result := inherited GetDropDownRect;
  if Assigned(FDropDownButton) and (DropDownKind <> ddkNormal) then
  begin
    if DropDownKind = ddkDropDown then
    begin
      case DropDownPosition of
        ddpRight: Result := RectF(Width - FDropDownButton.Width, 0, Width, Height);
        ddpBottom: Result := RectF(0, Height - FDropDownButton.Height, Width, Height);
      end;
    end
    else
    begin
      {$IFDEF FMXLIB}
      Result := RectF(FDropDownButton.Position.X, FDropDownButton.Position.Y, FDropDownButton.Position.X + FDropDownButton.Width, FDropDownButton.Position.Y + FDropDownButton.Height);
      {$ENDIF}
      {$IFDEF CMNWEBLIB}
      Result := RectF(FDropDownButton.Left, FDropDownButton.Top, FDropDownButton.Left + FDropDownButton.Width, FDropDownButton.Top + FDropDownButton.Height);
      {$ENDIF}
    end;
  end;
end;

function TAdvChartCustomToolBarButton.GetTextRect: TRectF;
var
  bmpr: TRectF;
  dr: TRectF;
  r: TRectF;
begin
  r := LocalRect;
  bmpr := GetBitmapRect(r);
  dr := GetDropDownRect;
  if DropDownKind <> ddkNormal then
  begin
    if not StretchText then
    begin
      case BitmapPosition of
        bbpLeft:
        begin
          case DropDownPosition of
            ddpRight: Result := RectF(bmpr.Right + 3, r.Top + 3, dr.Left - 3, r.Bottom - 3);
            ddpBottom: Result := RectF(bmpr.Right + 3, r.Top + 3, r.Right - 3, dr.Top - 3);
          end;
        end;
        bbpTop:
        begin
          case DropDownPosition of
            ddpRight: Result := RectF(r.Left + 3, bmpr.Bottom + 3, dr.Left - 3, r.Bottom - 3);
            ddpBottom: Result := RectF(r.Left + 3, bmpr.Bottom + 3, r.Right - 3, dr.Top - 3);
          end;
        end;
      end;
    end
    else
    begin
      case DropDownPosition of
        ddpRight: Result := RectF(r.Left + 3, r.Top + 3, dr.Left - 3, r.Bottom - 3);
        ddpBottom: Result := RectF(r.Left + 3, r.Top + 3, r.Right - 3, dr.Top - 3);
      end;
    end;
  end
  else
  begin
    if not StretchText then
    begin
      case BitmapPosition of
        bbpLeft: Result := RectF(bmpr.Right + 3, r.Top + 3, dr.Left - 3, r.Bottom - 3);
        bbpTop: Result := RectF(r.Left + 3, bmpr.Bottom + 3, dr.Left - 3, r.Bottom - 3)
      end;
    end
    else
      Result := RectF(r.Left + 3, r.Top + 3, dr.Left - 3, r.Bottom - 3);
  end;
end;

procedure TAdvChartCustomToolBarButton.HandleMouseDown(Button: TAdvMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  inherited;
  if DropDownKind = ddkDropDown then
    DropDown;
end;

procedure TAdvChartCustomToolBarButton.Loaded;
begin
  inherited;
  {$IFDEF VCLLIB}
  {$HINTS OFF}
  {$IF COMPILERVERSION >= 33}
  FDropDownButton.ScaleForPPI(CurrentPPI);
  {$IFEND}
  {$HINTS ON}
  {$ENDIF}
end;

procedure TAdvChartCustomToolBarButton.LoadSettingsFromFile(AFileName: string);
begin
  inherited;
  if Assigned(FDropDownButton) then
  begin
    FDropDownButton.Appearance.ShowInnerStroke := Appearance.ShowInnerStroke;
    FDropDownButton.Appearance.InnerStroke.Assign(Appearance.InnerStroke);
    FDropDownButton.Appearance.NormalFill.Assign(Appearance.NormalFill);
    FDropDownButton.Appearance.NormalStroke.Assign(Appearance.NormalStroke);
    FDropDownButton.Appearance.HoverFill.Assign(Appearance.HoverFill);
    FDropDownButton.Appearance.HoverStroke.Assign(Appearance.HoverStroke);
    FDropDownButton.Appearance.DownFill.Assign(Appearance.DownFill);
    FDropDownButton.Appearance.DownStroke.Assign(Appearance.DownStroke);
    FDropDownButton.Appearance.DisabledFill.Assign(Appearance.DisabledFill);
    FDropDownButton.Appearance.DisabledStroke.Assign(Appearance.DisabledStroke);
    FDropDownButton.Appearance.FlatStyle := Appearance.FlatStyle;
    FDropDownButton.Fill.Assign(Fill);
    FDropDownButton.Stroke.Assign(Stroke);
  end;
end;

procedure TAdvChartCustomToolBarButton.LoadSettingsFromStream(AStream: TStreamEx);
begin
  inherited;
  if Assigned(FDropDownButton) then
  begin
    FDropDownButton.Appearance.ShowInnerStroke := Appearance.ShowInnerStroke;
    FDropDownButton.Appearance.InnerStroke.Assign(Appearance.InnerStroke);
    FDropDownButton.Appearance.NormalFill.Assign(Appearance.NormalFill);
    FDropDownButton.Appearance.NormalStroke.Assign(Appearance.NormalStroke);
    FDropDownButton.Appearance.HoverFill.Assign(Appearance.HoverFill);
    FDropDownButton.Appearance.HoverStroke.Assign(Appearance.HoverStroke);
    FDropDownButton.Appearance.DownFill.Assign(Appearance.DownFill);
    FDropDownButton.Appearance.DownStroke.Assign(Appearance.DownStroke);
    FDropDownButton.Appearance.DisabledFill.Assign(Appearance.DisabledFill);
    FDropDownButton.Appearance.DisabledStroke.Assign(Appearance.DisabledStroke);
    FDropDownButton.Appearance.FlatStyle := Appearance.FlatStyle;
    FDropDownButton.Fill.Assign(Fill);
    FDropDownButton.Stroke.Assign(Stroke);
  end;
end;

function TAdvChartDefaultToolBarButton.GetBitmap: TAdvChartBitmap;
begin
  Result := TAdvChartGraphics.GetScaledBitmap(Bitmaps, 0, FBitmapContainer);
end;

function TAdvChartDefaultToolBarButton.GetBitmapContainer: TAdvChartBitmapContainer;
begin
  Result := FBitmapContainer;
end;

function TAdvChartDefaultToolBarButton.GetBitmapRect(ARect: TRectF): TRectF;
var
  r: TRectF;
  bs: Single;
begin
  bs := GetBitmapSize;
  case Layout of
    bblLarge: bs := GetLargeLayoutBitmapSize;
  end;

  r := ARect;
  Result := RectF(r.Left, r.Top, r.Left, r.Bottom);
  if BitmapVisible then
  begin
    case BitmapPosition of
      bbpLeft: Result := RectF(Result.Left + 3, Result.Top + 3, Result.Left + 3 + bs, Result.Bottom - 3);
      bbpTop: Result := RectF(Result.Left + 3, Result.Top + 3, Result.Right - 3, Result.Top + 3 + bs);
    end;
  end;
end;

function TAdvChartDefaultToolBarButton.GetBitmapSize: Single;
var
  bmp: TAdvChartBitmap;
begin
  Result := BitmapSize;
  if AutoBitmapSize then
  begin
    bmp := TAdvChartGraphics.GetScaledBitmap(Bitmaps, 0, BitmapContainer);
    if Assigned(bmp) and not IsBitmapEmpty(bmp) then
      Result := Max(bmp.Height, bmp.Width);
  end;
end;

function TAdvChartDefaultToolBarButton.GetBitmapRect: TRectF;
begin
  Result := GetBitmapRect(LocalRect);
end;

function TAdvChartDefaultToolBarButton.GetDropDownRect: TRectF;
var
  r: TRectF;
begin
  r := LocalRect;
  Result := RectF(r.Right, r.Top, r.Right, r.Bottom);
end;

function TAdvChartDefaultToolBarButton.GetHintString: String;
begin
  Result := Hint;
end;

function TAdvChartDefaultToolBarButton.GetLargeLayoutBitmapSize: Single;
var
  bmp: TAdvChartBitmap;
begin
  Result := LargeLayoutBitmapSize;
  if LargeLayoutAutoBitmapSize then
  begin
    bmp := TAdvChartGraphics.GetScaledBitmap(LargeLayoutBitmaps, 0, BitmapContainer);
    if Assigned(bmp) and not IsBitmapEmpty(bmp) then
      Result := Max(bmp.Height, bmp.Width);
  end;
end;

function TAdvChartDefaultToolBarButton.GetPopupControl: TAdvChartPopup;
begin
  Result := FPopup;
end;

function TAdvChartDefaultToolBarButton.GetText: String;
begin
  Result := FText;
end;

function TAdvChartDefaultToolBarButton.GetTextRect: TRectF;
var
  bmpr: TRectF;
  dr: TRectF;
  r: TRectF;
begin
  r := LocalRect;
  bmpr := GetBitmapRect;
  dr := GetDropDownRect;
  if not StretchText then
  begin
    case BitmapPosition of
      bbpLeft: Result := RectF(bmpr.Right + 3, r.Top + 3, dr.Left - 3, r.Bottom - 3);
      bbpTop: Result := RectF(r.Left + 3, bmpr.Bottom + 3, dr.Left - 3, r.Bottom - 3);
    end;
  end
  else
    Result := RectF(r.Left + 3, r.Top + 3, dr.Left - 3, r.Bottom - 3);
end;

function TAdvChartDefaultToolBarButton.GetTextSize: TSizeF;
var
  g: TAdvChartGraphics;
  r: TRectF;
begin
  Result.cx := 0;
  Result.cy := 0;
  if TextVisible and (Text <> '') then
  begin
    g := TAdvChartGraphics.CreateBitmapCanvas(1, 1, NativeCanvas);
    if not NativeCanvas then
      g.BeginScene;
    g.BitmapContainer := BitmapContainer;
    g.OptimizedHTMLDrawing := OptimizedHTMLDrawing;
    try
      g.Font.Assign(Font);
      r := LocalRect;
      InflateRectEx(r, ScalePaintValue(-2), ScalePaintValue(-2));
      Result := g.CalculateTextSize(Text, r, WordWrapping);
    finally
      if not NativeCanvas then
        g.EndScene;
      g.Free;
    end;
  end;
end;

procedure TAdvChartDefaultToolBarButton.InitializePopup;
begin

end;

function TAdvChartDefaultToolBarButton.IsBitmapSizeStored: Boolean;
begin
  Result := BitmapSize <> 24;
end;

function TAdvChartDefaultToolBarButton.IsDropDownHeightStored: Boolean;
begin
  Result := DropDownHeight <> 135;
end;

function TAdvChartDefaultToolBarButton.IsDropDownWidthStored: Boolean;
begin
  Result := DropDownWidth <> 135;
end;

function TAdvChartDefaultToolBarButton.IsLargeLayoutBitmapSizeStored: Boolean;
begin
  Result := LargeLayoutBitmapSize <> 32;
end;

procedure TAdvChartDefaultToolBarButton.HandleKeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    KEY_HOME: SelectFirstValue;
    KEY_END: SelectLastValue;
    KEY_UP, KEY_LEFT:  SelectPreviousValue;
    KEY_DOWN, KEY_RIGHT: SelectNextValue;
    KEY_SPACE: Click;
  end;
end;

procedure TAdvChartDefaultToolBarButton.HandleKeyPress(var Key: Char);
begin
  inherited;
  if (Key >= #32) and not (Ord(Key) in [KEY_F2, KEY_RETURN, KEY_SPACE, KEY_ESCAPE, KEY_HOME, KEY_END, KEY_UP, KEY_LEFT, KEY_DOWN, KEY_RIGHT]) then
    SelectValueWithCharacter(Key);
end;

procedure TAdvChartDefaultToolBarButton.HandleKeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Shift <> [] then
    Exit;

  case Key of
    KEY_RETURN, KEY_F4:
    begin
      if CanDropDown then
        DropDown;
    end;
  end;
end;

procedure TAdvChartDefaultToolBarButton.HandleMouseDown(Button: TAdvMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  inherited;
  if CanFocus then
    SetFocus;

  FDown := True;
  Invalidate;
end;

procedure TAdvChartDefaultToolBarButton.HandleMouseMove(Shift: TShiftState; X,
  Y: Single);
begin
  inherited;
  FHover := True;
  if FPrevHover <> FHover then
    Invalidate;

  FPrevHover := FHover;
end;

procedure TAdvChartDefaultToolBarButton.HandleMouseUp(Button: TAdvMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  inherited;
  FDown := False;
  Invalidate;
end;

function TAdvChartDefaultToolBarButton.HasHint: Boolean;
begin
  Result := Hint <> '';
end;

procedure TAdvChartDefaultToolBarButton.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FBitmapContainer) then
    FBitmapContainer := nil;

  if (Operation = opRemove) and (AComponent = FDropDownControl) then
    FDropDownControl := nil;
end;

procedure TAdvChartDefaultToolBarButton.Draw(AGraphics: TAdvChartGraphics; ARect: TRectF);
var
  r: TRectF;
begin
  inherited;
  if not Appearance.Transparent then
  begin
    if Enabled then
    begin
      if FDown or FDownState then
      begin
        AGraphics.Fill.Assign(Appearance.DownFill);
        AGraphics.Stroke.Assign(Appearance.DownStroke);
      end
      else if FHover then
      begin
        AGraphics.Fill.Assign(Appearance.HoverFill);
        AGraphics.Stroke.Assign(Appearance.HoverStroke);
      end
      else
      begin
        AGraphics.Fill.Assign(Appearance.NormalFill);
        AGraphics.Stroke.Assign(Appearance.NormalStroke);
      end;
    end
    else
    begin
      AGraphics.Fill.Assign(Appearance.DisabledFill);
      AGraphics.Stroke.Assign(Appearance.DisabledStroke);
    end;

    r := LocalRect;

    if Appearance.FlatStyle then
    begin
      AGraphics.Fill.Kind := gfkSolid;
      AGraphics.DrawRectangle(r);
    end
    else
      AGraphics.DrawRoundRectangle(r, Appearance.Rounding, Appearance.Corners);

    if Appearance.ShowInnerStroke and not Appearance.FlatStyle then
    begin
      InflateRectEx(r, -1, -1);
      AGraphics.Stroke.Assign(Appearance.InnerStroke);
      AGraphics.Fill.Kind := gfkNone;
      AGraphics.DrawRoundRectangle(r, Appearance.Rounding, Appearance.Corners);
    end;
  end;

  DrawBitmap(AGraphics, ARect);
  DrawText(AGraphics);
  DrawButton(AGraphics);

  if ShowFocus and Focused then
  begin
    r := GetTextRect;
    AGraphics.DrawFocusRectangle(r);
  end;

  if IsDesignTime and CanDrawDesignTime then
    AGraphics.DrawFocusRectangle(ARect, gcBlack);
end;

procedure TAdvChartDefaultToolBarButton.DoClosePopup(Sender: TObject);
begin
  if Assigned(OnCloseDropDown) then
    OnCloseDropDown(Self);
end;

procedure TAdvChartDefaultToolBarButton.ResetToDefaultStyle;
begin
  inherited;
  Font.Color := gcBlack;
  Appearance.NormalFill.Color := gcWhite;
  Appearance.HoverFill.Color := gcWhite;
  Appearance.DownFill.Color := gcWhite;
  Appearance.DisabledFill.Color := gcLightgray;
  Appearance.NormalStroke.Color := gcGray;
  Appearance.InnerStroke.Color := gcWhite;
  Appearance.HoverStroke.Color := gcGray;
  Appearance.DownStroke.Color := gcGray;
  Appearance.DisabledStroke.Color := gcGray;

  Appearance.NormalFill.Kind := gfkGradient;
  Appearance.HoverFill.Kind := gfkGradient;
  Appearance.DownFill.Kind := gfkGradient;
  Appearance.DisabledFill.Kind := gfkSolid;
  Appearance.NormalStroke.Kind := gskSolid;
  Appearance.InnerStroke.Kind := gskSolid;
  Appearance.HoverStroke.Kind := gskSolid;
  Appearance.DownStroke.Kind := gskSolid;
  Appearance.DisabledStroke.Kind := gskSolid;

  Appearance.NormalFill.Color := MakeGraphicsColor(249, 251, 252);
  Appearance.NormalFill.ColorTo := MakeGraphicsColor(230, 235, 235);
  Appearance.NormalFill.ColorMirror := MakeGraphicsColor(220, 220, 236);
  Appearance.NormalFill.ColorMirrorTo := MakeGraphicsColor(220, 225, 236);

  Appearance.HoverFill.Color := MakeGraphicsColor(229, 231, 232);
  Appearance.HoverFill.ColorTo := MakeGraphicsColor(210, 215, 215);
  Appearance.HoverFill.ColorMirror := MakeGraphicsColor(200, 200, 216);
  Appearance.HoverFill.ColorMirrorTo := MakeGraphicsColor(200, 205, 216);

  Appearance.DownFill.Color := MakeGraphicsColor(219, 221, 222);
  Appearance.DownFill.ColorTo := MakeGraphicsColor(200, 205, 205);
  Appearance.DownFill.ColorMirror := MakeGraphicsColor(190, 190, 206);
  Appearance.DownFill.ColorMirrorTo := MakeGraphicsColor(190, 195, 206);
end;

procedure TAdvChartDefaultToolBarButton.SelectFirstValue;
begin

end;

procedure TAdvChartDefaultToolBarButton.SelectLastValue;
begin

end;

procedure TAdvChartDefaultToolBarButton.SelectNextValue;
begin

end;

procedure TAdvChartDefaultToolBarButton.SelectPreviousValue;
begin

end;

procedure TAdvChartDefaultToolBarButton.SelectValueWithCharacter(
  ACharacter: Char);
begin

end;

procedure TAdvChartDefaultToolBarButton.SetAdaptToStyle(const Value: Boolean);
begin
  inherited;
  if Assigned(FPopup) then
    FPopup.AdaptToStyle := AdaptToStyle;
end;

procedure TAdvChartDefaultToolBarButton.SetAppearance(
  const Value: TAdvChartToolBarButtonAppearance);
begin
  FAppearance.Assign(Value);
end;

procedure TAdvChartDefaultToolBarButton.SetAutoBitmapSize(const Value: Boolean);
begin
  if FAutoBitmapSize <> Value then
  begin
    FAutoBitmapSize := Value;
    UpdateLayout;
    Invalidate;
  end;
end;

procedure TAdvChartDefaultToolBarButton.SetBitmaps(const Value: TAdvScaledBitmaps);
begin
  FBitmaps.Assign(Value);
end;

procedure TAdvChartDefaultToolBarButton.SetBitmapSize(const Value: Single);
begin
  if FBitmapSize <> Value then
  begin
    FBitmapSize := Value;
    UpdateLayout;
    Invalidate;
  end;
end;

procedure TAdvChartDefaultToolBarButton.SetBitmapContainer(
  const Value: TAdvChartBitmapContainer);
begin
  FBitmapContainer := Value;
  UpdateLayout;
  Invalidate;
end;

procedure TAdvChartDefaultToolBarButton.SetBitmapPosition(
  const Value: TAdvChartToolBarButtonBitmapPosition);
begin
  if FBitmapPosition <> Value then
  begin
    FBitmapPosition := Value;
    Invalidate;
  end;
end;

procedure TAdvChartDefaultToolBarButton.SetBitmapVisible(const Value: Boolean);
begin
  FBitmapVisible := Value;
  UpdateLayout;
  Invalidate;
end;

procedure TAdvChartDefaultToolBarButton.SetLargeLayoutAutoBitmapSize(
  const Value: Boolean);
begin
  if FLargeLayoutAutoBitmapSize <> Value then
  begin
    FLargeLayoutAutoBitmapSize := Value;
    UpdateLayout;
    Invalidate;
  end;
end;

procedure TAdvChartDefaultToolBarButton.SetLargeLayoutBitmaps(
  const Value: TAdvScaledBitmaps);
begin
  FLargeLayoutBitmaps.Assign(Value);
end;

procedure TAdvChartDefaultToolBarButton.SetLargeLayoutBitmapSize(
  const Value: Single);
begin
  if FLargeLayoutBitmapSize <> Value then
  begin
    FLargeLayoutBitmapSize := Value;
    UpdateLayout;
    Invalidate;
  end;
end;

procedure TAdvChartDefaultToolBarButton.SetLargeLayoutDisabledBitmaps(
  const Value: TAdvScaledBitmaps);
begin
  FLargeLayoutDisabledBitmaps.Assign(Value);
end;

procedure TAdvChartDefaultToolBarButton.SetLargeLayoutHoverBitmaps(
  const Value: TAdvScaledBitmaps);
begin
  FLargeLayoutHoverBitmaps.Assign(Value);
end;

procedure TAdvChartDefaultToolBarButton.SetLayout(
  const Value: TAdvChartToolBarButtonLayout);
begin
  if FLayout <> Value then
  begin
    FLayout := Value;
    UpdateLayout;
  end;
end;

procedure TAdvChartDefaultToolBarButton.SetCloseOnSelection(const Value: Boolean);
begin
  if FCloseOnSelection <> Value then
  begin
    FCloseOnSelection := Value;
  end;
end;

procedure TAdvChartDefaultToolBarButton.SetCompactLayout(
  const Value: TAdvChartToolBarButtonLayout);
begin
  if FCompactLayout <> Value then
    FCompactLayout := Value;
end;

procedure TAdvChartDefaultToolBarButton.SetName(const Value: TComponentName);
var
  ChangeText: Boolean;
begin
  ChangeText := not (csLoading in ComponentState) and (Name = Text) and
    ((not Assigned(Owner)) or not (Owner is TComponent) or not (csLoading in TComponent(Owner).ComponentState));
  inherited SetName(Value);
  if ChangeText and ApplyName and CanChangeText then
    Text := StringReplace(Text, 'AdvChartToolBar', '', [rfReplaceAll]);
end;

procedure TAdvChartDefaultToolBarButton.SetShowFocus(const Value: Boolean);
begin
  if FShowFocus <> Value then
  begin
    FShowFocus := Value;
    Invalidate;
  end;
end;

procedure TAdvChartDefaultToolBarButton.SetStretchBitmapIfNoText(
  const Value: Boolean);
begin
  if FStretchBitmapIfNoText <> Value then
  begin
    FStretchBitmapIfNoText := Value;
    UpdateLayout;
    Invalidate;
  end;
end;

procedure TAdvChartDefaultToolBarButton.SetStretchText(const Value: Boolean);
begin
  if FStretchText <> Value then
  begin
    FStretchText := Value;
    UpdateLayout;
    Invalidate;
  end;
end;

procedure TAdvChartDefaultToolBarButton.SetText(const Value: String);
begin
  if FText <> Value then
  begin
    FText := Value;
    FTextVisible := Value <> '';
    UpdateLayout;
    Invalidate;
  end;
end;

procedure TAdvChartDefaultToolBarButton.SetTextVisible(const Value: Boolean);
begin
  if FTextVisible <> Value then
  begin
    FTextVisible := Value;
    UpdateLayout;
    Invalidate;
  end;
end;

procedure TAdvChartDefaultToolBarButton.SetTrimming(
  const Value: TAdvChartGraphicsTextTrimming);
begin
  if FTrimming <> Value then
  begin
    FTrimming := Value;
    Invalidate;
  end;
end;

procedure TAdvChartDefaultToolBarButton.SetVerticalTextAlign(
  const Value: TAdvChartGraphicsTextAlign);
begin
  if FVerticalTextAlign <> Value then
  begin
    FVerticalTextAlign := Value;
    Invalidate;
  end;
end;

procedure TAdvChartDefaultToolBarButton.SetWordWrapping(const Value: Boolean);
begin
  if FWordWrapping <> Value then
  begin
    FWordWrapping := Value;
    Invalidate;
  end;
end;

procedure TAdvChartDefaultToolBarButton.UpdateControlAfterResize;
begin
  inherited;
  if Layout = bblLarge then
    FOldHeight := Height;
end;

procedure TAdvChartDefaultToolBarButton.UpdateLayout;
var
  sz: TSizeF;
  w: Single;
begin
  if (Layout = bblNone) or FBlockUpdate then
    Exit;

  FBlockUpdate := True;
  case Layout of
    bblBitmap:
    begin
      TextVisible := False;
      BitmapPosition := bbpLeft;
      StretchText := False;
      Height := Round(GetBitmapSize + 6);
      Width := Round(GetBitmapSize + 6);
    end;
    bblLabel:
    begin
      TextVisible := True;
      BitmapPosition := bbpLeft;
      StretchText := False;
      sz := GetTextSize;
      if BitmapVisible then
      begin
        Height := Round(Max(GetBitmapSize, sz.cy) + 6);
        Width := Round(GetBitmapSize + sz.cx + 12);
      end
      else if TextVisible and (Text <> '') then
      begin
        Height := Round(sz.cy + 6);
        Width := Round(sz.cx + 6);
      end
      else
      begin
        Width := 75;
        Height := 24;
      end;
    end;
    bblLarge:
    begin
      TextVisible := True;
      BitmapPosition := bbpTop;
      StretchText := not BitmapVisible;

      sz := GetTextSize;
      w := 30;
      if BitmapVisible then
        w := Max(w, GetLargeLayoutBitmapSize + 6);

      if TextVisible and (Text <> '') then
        w := Max(w, sz.cx + 12);

      Width := Round(w);

      if FOldHeight <> -1 then
        Height := Round(FOldHeight);
    end;
  end;
  FBlockUpdate := False;

  UpdateToolBar;
end;

procedure TAdvChartDefaultToolBarButton.UpdateState;
var
  f: Single;
begin
  inherited;
  case FState of
    esNormal: f := 0.8;
    esLarge: f := 1.25;
    else
      f := 1;
  end;

  if not (csLoading in ComponentState) then
  begin
    DropDownWidth := DropDownWidth * f;
    DropDownHeight := DropDownHeight * f;
    {$IFDEF FMXLIB}
    Font.Size := Font.Size * f;
    SetBounds(Position.X, Position.Y, int(Width * f), int(Height * f));
    {$ENDIF}
    {$IFDEF VCLWEBLIB}
    Font.Size := Round(Font.Size * f);
    SetBounds(Left, Top, Round(Width * f), Round(Height * f));
    {$ENDIF}
  end;
end;

procedure TAdvChartToolBarCustomButtonAppearance.SetCorners(const Value: TAdvChartGraphicsCorners);
begin
  if FCorners <> Value then
  begin
    FCorners := Value;
    Changed;
  end;
end;

procedure TAdvChartToolBarCustomButtonAppearance.SetRounding(const Value: Single);
begin
  if FRounding <> Value then
  begin
    FRounding := Value;
    Changed;
  end;
end;

procedure TAdvChartToolBarCustomButtonAppearance.StrokeChanged(Sender: TObject);
begin
  Changed;
end;

{ TAdvChartCustomToolBarSeparator }

procedure TAdvChartCustomToolBarSeparator.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TAdvChartCustomToolBarSeparator then
  begin
    FAppearance.Assign((Source as TAdvChartCustomToolBarSeparator).Appearance);
    Invalidate;
  end;
end;

constructor TAdvChartCustomToolBarSeparator.Create(AOwner: TComponent);
begin
  inherited;
  {$IFDEF FMXLIB}
  Width := 3;
  {$ENDIF}
  {$IFDEF CMNWEBLIB}
  Width := 2;
  {$ENDIF}
  Height := 30;
  FAppearance := TAdvChartToolBarSeparatorAppearance.Create(Self);
end;

destructor TAdvChartCustomToolBarSeparator.Destroy;
begin
  FAppearance.Free;
  inherited;
end;

procedure TAdvChartCustomToolBarSeparator.Draw(AGraphics: TAdvChartGraphics; ARect: TRectF);
var
  cp: TPointF;
  r: TRectF;
begin
  inherited;
  r := LocalRect;
  {$IFDEF FMXLIB}
  cp := r.CenterPoint;
  {$ENDIF}
  {$IFDEF CMNWEBLIB}
  cp := PointF(r.Left, r.Top);
  {$ENDIF}
  AGraphics.Stroke.Assign(Appearance.Stroke);
  AGraphics.DrawLine(PointF(cp.X, r.Top), PointF(cp.X, r.Bottom));
  AGraphics.Stroke.Assign(Appearance.InnerStroke);
  AGraphics.DrawLine(PointF(cp.X + 1, r.Top), PointF(cp.X + 1, r.Bottom));
end;

procedure TAdvChartCustomToolBarSeparator.SetAppearance(
  const Value: TAdvChartToolBarSeparatorAppearance);
begin
  FAppearance.Assign(Value);
end;

procedure TAdvChartCustomToolBarSeparator.UpdateState;
var
  f: Single;
begin
  inherited;
  case State of
    esNormal: f := 0.8;
    esLarge: f := 1.25;
    else
      f := 1;
  end;

  if not (csLoading in ComponentState) then
  begin
    {$IFDEF FMXLIB}
    SetBounds(Position.X, Position.Y, Width, int(Height * f));
    {$ENDIF}
    {$IFDEF CMNWEBLIB}
    SetBounds(Left, Top, Width, Round(Height * f));
    {$ENDIF}
  end;
end;

{ TAdvChartToolBarCustomButtonAppearance }

procedure TAdvChartToolBarCustomButtonAppearance.Assign(Source: TPersistent);
begin
  if Source is TAdvChartToolBarCustomButtonAppearance then
  begin
    FNormalFill.Assign((Source as TAdvChartToolBarCustomButtonAppearance).NormalFill);
    FDisabledFill.Assign((Source as TAdvChartToolBarCustomButtonAppearance).DisabledFill);
    FHoverFill.Assign((Source as TAdvChartToolBarCustomButtonAppearance).HoverFill);
    FDownFill.Assign((Source as TAdvChartToolBarCustomButtonAppearance).DownFill);
    FNormalStroke.Assign((Source as TAdvChartToolBarCustomButtonAppearance).NormalStroke);
    FDisabledStroke.Assign((Source as TAdvChartToolBarCustomButtonAppearance).DisabledStroke);
    FHoverStroke.Assign((Source as TAdvChartToolBarCustomButtonAppearance).HoverStroke);
    FDownStroke.Assign((Source as TAdvChartToolBarCustomButtonAppearance).DownStroke);
    FRounding := (Source as TAdvChartToolBarCustomButtonAppearance).Rounding;
    FCorners := (Source as TAdvChartToolBarCustomButtonAppearance).Corners;
    FShowInnerStroke := (Source as TAdvChartToolBarCustomButtonAppearance).ShowInnerStroke;
    FTransparent := (Source as TAdvChartToolBarCustomButtonAppearance).Transparent;
    FFlatStyle := (Source as TAdvChartToolBarCustomButtonAppearance).FlatStyle;
  end
  else
    inherited;
end;

procedure TAdvChartToolBarCustomButtonAppearance.Changed;
begin
  if Assigned(FOwner) then
    FOwner.AppearanceChanged
  else if Assigned(OnChange) then
    OnChange(Self);
end;

constructor TAdvChartToolBarCustomButtonAppearance.Create(AOwner: TAdvChartDefaultToolBarButton);
begin
  FOwner := AOwner;
  FCorners := [gcTopLeft, gcTopRight, gcBottomLeft, gcBottomRight];
  FRounding := 3;
  FTransparent := False;
  FShowInnerStroke := True;
  FFlatStyle := False;

  FNormalFill := TAdvChartGraphicsFill.Create(gfkGradient, MakeGraphicsColor(249, 251, 252), MakeGraphicsColor(230, 235, 235), MakeGraphicsColor(220, 220, 236), MakeGraphicsColor(220, 225, 236));
  FHoverFill := TAdvChartGraphicsFill.Create(gfkGradient, MakeGraphicsColor(229, 231, 232), MakeGraphicsColor(210, 215, 215), MakeGraphicsColor(200, 200, 216), MakeGraphicsColor(200, 205, 216));
  FDownFill := TAdvChartGraphicsFill.Create(gfkGradient, MakeGraphicsColor(219, 221, 222), MakeGraphicsColor(200, 205, 205), MakeGraphicsColor(190, 190, 206), MakeGraphicsColor(190, 195, 206));
  FDisabledFill := TAdvChartGraphicsFill.Create(gfkSolid, gcLightgray);
  FNormalStroke := TAdvChartGraphicsStroke.Create(gskSolid, gcGray);
  FInnerStroke := TAdvChartGraphicsStroke.Create(gskSolid, gcWhite);
  FHoverStroke := TAdvChartGraphicsStroke.Create(gskSolid, gcGray);
  FDownStroke := TAdvChartGraphicsStroke.Create(gskSolid, gcGray);
  FDisabledStroke := TAdvChartGraphicsStroke.Create(gskSolid, gcGray);

  FNormalFill.OnChanged := FillChanged;
  FHoverFill.OnChanged := FillChanged;
  FDownFill.OnChanged := FillChanged;
  FDisabledFill.OnChanged := FillChanged;

  FInnerStroke.OnChanged := StrokeChanged;
  FNormalStroke.OnChanged := StrokeChanged;
  FHoverStroke.OnChanged := StrokeChanged;
  FDownStroke.OnChanged := StrokeChanged;
  FDisabledStroke.OnChanged := StrokeChanged;
end;

destructor TAdvChartToolBarCustomButtonAppearance.Destroy;
begin
  FNormalFill.Free;
  FHoverFill.Free;
  FDownFill.Free;
  FDisabledFill.Free;

  FInnerStroke.Free;
  FNormalStroke.Free;
  FHoverStroke.Free;
  FDownStroke.Free;
  FDisabledStroke.Free;
  inherited;
end;

procedure TAdvChartToolBarCustomButtonAppearance.FillChanged(Sender: TObject);
begin
  Changed;
end;

function TAdvChartToolBarCustomButtonAppearance.IsRoundingStored: Boolean;
begin
  Result := Rounding <> 3;
end;

procedure TAdvChartToolBarCustomButtonAppearance.SetDisabledFill(const Value: TAdvChartGraphicsFill);
begin
  FDisabledFill.Assign(Value);
end;

procedure TAdvChartToolBarCustomButtonAppearance.SetDisabledStroke(
  const Value: TAdvChartGraphicsStroke);
begin
  FDisabledStroke.Assign(Value);
end;

procedure TAdvChartToolBarCustomButtonAppearance.SetDownFill(const Value: TAdvChartGraphicsFill);
begin
  FDownFill.Assign(Value);
end;

procedure TAdvChartToolBarCustomButtonAppearance.SetDownStroke(
  const Value: TAdvChartGraphicsStroke);
begin
  FDownStroke.Assign(Value);
end;

procedure TAdvChartToolBarCustomButtonAppearance.SetFlatStyle(const Value: Boolean);
var
  c: TControl;
  I: Integer;
begin
  if FFlatStyle <> Value then
  begin
    FFlatStyle := Value;
    if Assigned(FOwner) then
    begin
      for I := 0 to FOwner.ControlCount - 1 do
      begin
        c := FOwner.Controls[I];
        {$IFDEF FMXLIB}
        if Supports(c, IDesignerControl) then
          Continue;
        {$ENDIF}

        if c is TAdvChartDefaultToolBarButton then
          (c as TAdvChartDefaultToolBarButton).Appearance.FlatStyle := FlatStyle;

        if c is TAdvChartCustomToolBar then
          (c as TAdvChartCustomToolBar).Appearance.FlatStyle := FlatStyle;
      end;
    end;

    Changed;
  end;
end;

procedure TAdvChartToolBarCustomButtonAppearance.SetHoverFill(const Value: TAdvChartGraphicsFill);
begin
  FHoverFill.Assign(Value);
end;

procedure TAdvChartToolBarCustomButtonAppearance.SetHoverStroke(
  const Value: TAdvChartGraphicsStroke);
begin
  FHoverStroke.Assign(Value);
end;

procedure TAdvChartToolBarCustomButtonAppearance.SetInnerStroke(
  const Value: TAdvChartGraphicsStroke);
begin
  FInnerStroke.Assign(Value);
end;

procedure TAdvChartToolBarCustomButtonAppearance.SetNormalFill(const Value: TAdvChartGraphicsFill);
begin
  FNormalFill.Assign(Value);
end;

procedure TAdvChartToolBarCustomButtonAppearance.SetNormalStroke(
  const Value: TAdvChartGraphicsStroke);
begin
  FNormalStroke.Assign(Value);
end;

procedure TAdvChartToolBarCustomButtonAppearance.SetShowInnerStroke(
  const Value: Boolean);
begin
  if FShowInnerStroke <> Value then
  begin
    FShowInnerStroke := Value;
    Changed;
  end;
end;

procedure TAdvChartToolBarCustomButtonAppearance.SetTransparent(
  const Value: Boolean);
begin
  if FTransparent <> Value then
  begin
    FTransparent := Value;
    Changed;
  end;
end;

{ TAdvChartCustomToolBarAppearance }

procedure TAdvChartCustomToolBarAppearance.Assign(Source: TPersistent);
begin
  if Source is TAdvChartCustomToolBarAppearance then
  begin
    FSeparatorStroke.Assign((Source as TAdvChartCustomToolBarAppearance).SeparatorStroke);
    FSeparator := (Source as TAdvChartCustomToolBarAppearance).Separator;
    FFill.Assign((Source as TAdvChartCustomToolBarAppearance).Fill);
    FStroke.Assign((Source as TAdvChartCustomToolBarAppearance).Stroke);
    FHorizontalSpacing := (Source as TAdvChartCustomToolBarAppearance).HorizontalSpacing;
    FVerticalSpacing := (Source as TAdvChartCustomToolBarAppearance).VerticalSpacing;
    FDragGripColor := (Source as TAdvChartCustomToolBarAppearance).DragGripColor;
    FDragGrip := (Source as TAdvChartCustomToolBarAppearance).DragGrip;
    FFlatStyle := (Source as TAdvChartCustomToolBarAppearance).FlatStyle;
  end;
end;

constructor TAdvChartCustomToolBarAppearance.Create(AOwner: TAdvChartCustomToolBar);
begin
  FOwner := AOwner;
  FFont := TAdvChartGraphicsFont.Create;
  FFlatStyle := False;
  FHorizontalSpacing := 3;
  FVerticalSpacing := 3;
  FDragGrip := True;
  FDragGripColor := gcLightgray;
  FFill := TAdvChartGraphicsFill.Create(gfkGradient, gcWhite, MakeGraphicsColor(230, 230, 230));
  FStroke := TAdvChartGraphicsStroke.Create(gskSolid, gcGray);

  FFill.OnChanged := FillChanged;
  FStroke.OnChanged := StrokeChanged;

  FSeparatorStroke := TAdvChartGraphicsStroke.Create(gskSolid, gcWhite);
  FSeparatorStroke.OnChanged := StrokeChanged;
end;

destructor TAdvChartCustomToolBarAppearance.Destroy;
begin
  FSeparatorStroke.Free;
  FFont.Free;
  FFill.Free;
  FStroke.Free;
  inherited;
end;

procedure TAdvChartCustomToolBarAppearance.FillChanged(Sender: TObject);
begin
  FOwner.Invalidate;
end;

function TAdvChartCustomToolBarAppearance.IsHorizontalSpacingStored: Boolean;
begin
  Result := HorizontalSpacing <> 3;
end;

function TAdvChartCustomToolBarAppearance.IsVerticalSpacingStored: Boolean;
begin
  Result := VerticalSpacing <> 3;
end;

procedure TAdvChartCustomToolBarAppearance.SetDragGrip(const Value: Boolean);
begin
  if FDragGrip <> Value then
  begin
    FDragGrip := Value;
    FOwner.UpdateControls;
  end;
end;

procedure TAdvChartCustomToolBarAppearance.SetDragGripColor(
  const Value: TAdvChartGraphicsColor);
begin
  if FDragGripColor <> Value then
  begin
    FDragGripColor := Value;
    FOwner.Invalidate;
  end;
end;

procedure TAdvChartCustomToolBarAppearance.SetFill(const Value: TAdvChartGraphicsFill);
begin
  FFill.Assign(Value);
end;

procedure TAdvChartCustomToolBarAppearance.SetFlatStyle(const Value: Boolean);
begin
  if FFlatStyle <> Value then
  begin
    FFlatStyle := Value;
    if Assigned(FOwner) then
      FOwner.ApplyFlatStyle;
  end;
end;

procedure TAdvChartCustomToolBarAppearance.SetHorizontalSpacing(
  const Value: Single);
begin
  if FHorizontalSpacing <> Value then
  begin
    FHorizontalSpacing := Value;
    FOwner.UpdateControls;
  end;
end;

procedure TAdvChartCustomToolBarAppearance.SetSeparator(const Value: Boolean);
begin
  if FSeparator <> Value then
  begin
    FSeparator := Value;
    FOwner.Invalidate;
  end;
end;

procedure TAdvChartCustomToolBarAppearance.SetSeparatorStroke(
  const Value: TAdvChartGraphicsStroke);
begin
  FSeparatorStroke.Assign(Value);
end;

procedure TAdvChartCustomToolBarAppearance.SetStroke(const Value: TAdvChartGraphicsStroke);
begin
  FStroke.Assign(Value);
end;

procedure TAdvChartCustomToolBarAppearance.SetVerticalSpacing(
  const Value: Single);
begin
  if FVerticalSpacing <> Value then
  begin
    FVerticalSpacing := Value;
    FOwner.UpdateControls;
  end;
end;

procedure TAdvChartCustomToolBarAppearance.StrokeChanged(Sender: TObject);
begin
  FOwner.Invalidate;
end;

{ TAdvChartCustomToolBarSeparatorAppearance }

procedure TAdvChartCustomToolBarSeparatorAppearance.Assign(Source: TPersistent);
begin
  if Source is TAdvChartCustomToolBarSeparatorAppearance then
  begin
    Stroke.Assign((Source as TAdvChartCustomToolBarSeparatorAppearance).Stroke);
    InnerStroke.Assign((Source as TAdvChartCustomToolBarSeparatorAppearance).InnerStroke);
  end
  else
    inherited;
end;

constructor TAdvChartCustomToolBarSeparatorAppearance.Create(
  AOwner: TAdvChartCustomToolBarSeparator);
begin
  FOwner := AOwner;
  FStroke := TAdvChartGraphicsStroke.Create(gskSolid, gcGray);
  FStroke.OnChanged := StrokeChanged;
  FInnerStroke := TAdvChartGraphicsStroke.Create(gskSolid, gcWhite);
  FInnerStroke.OnChanged := StrokeChanged;
end;

destructor TAdvChartCustomToolBarSeparatorAppearance.Destroy;
begin
  FInnerStroke.Free;
  FStroke.Free;
  inherited;
end;

procedure TAdvChartCustomToolBarSeparatorAppearance.SetInnerStroke(
  const Value: TAdvChartGraphicsStroke);
begin
  FInnerStroke.Assign(Value);
end;

procedure TAdvChartCustomToolBarSeparatorAppearance.SetStroke(
  const Value: TAdvChartGraphicsStroke);
begin
  FStroke.Assign(Value);
end;

procedure TAdvChartCustomToolBarSeparatorAppearance.StrokeChanged(
  Sender: TObject);
begin
  FOwner.Invalidate;
end;

{ TAdvChartCustomDockPanel }

function TAdvChartCustomDockPanel.AddToolBar(AIndex: Integer = -1): TAdvChartToolBar;
begin
  FBlockUpdate := True;
  Result := TAdvChartToolBar.Create(Self);
  {$IFDEF FMXLIB}
  if (AIndex >= 0) and (AIndex <= Self.ControlCount - 1) then
    InsertObject(AIndex, Result)
  else
    AddObject(Result);
  {$ENDIF}
  {$IFDEF CMNWEBLIB}
  Result.Parent := Self;
  {$ENDIF}

  FBlockUpdate := False;
  UpdateControls;
end;

procedure TAdvChartCustomDockPanel.ApplyStyle;
var
  c: TAdvChartGraphicsColor;
begin
  inherited;
  c := gcNull;
  if TAdvChartStyles.GetStyleHeaderFillColor(c) then
  begin
    Appearance.Fill.Kind := gfkSolid;
    Appearance.Fill.Color := c;
  end;

  if TAdvChartStyles.GetStyleHeaderFillColorTo(c) then
  begin
    Appearance.Fill.Kind := gfkGradient;
    Appearance.Fill.ColorTo := c;
  end;
end;

procedure TAdvChartCustomDockPanel.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TAdvChartCustomDockPanel then
  begin
    Appearance.Assign((Source as TAdvChartCustomDockPanel).Appearance);
    AutoSize := (Source as TAdvChartCustomDockPanel).AutoSize;
    AutoAlign := (Source as TAdvChartCustomDockPanel).AutoAlign;
    State := (Source as TAdvChartCustomDockPanel).State;
  end
  else
    inherited;
end;

constructor TAdvChartCustomDockPanel.Create(AOwner: TComponent);
begin
  inherited;
  FState := esNormal;
  FAppearance := TAdvDockPanelAppearance.Create(Self);
  FAutoSize := True;
  FAutoAlign := True;
  {$IFDEF FMXLIB}
  Align := TAlignLayout.Top;
  {$ENDIF}
  {$IFDEF CMNWEBLIB}
  Align := alTop;
  {$ENDIF}
  Height := 40;
end;

destructor TAdvChartCustomDockPanel.Destroy;
begin
  FAppearance.Free;
  inherited;
end;

{$IFDEF CMNWEBLIB}
procedure TAdvChartCustomDockPanel.AlignControls(AControl: TControl; var Rect: TRect);
begin
  inherited;
  UpdateControls;
end;
{$ENDIF}

{$IFDEF FMXLIB}
procedure TAdvChartCustomDockPanel.DoAddObject(const AObject: TFmxObject);
begin
  inherited;
  UpdateControls;
end;

procedure TAdvChartCustomDockPanel.DoInsertObject(Index: Integer;
  const AObject: TFmxObject);
begin
  inherited;
  UpdateControls;
end;

procedure TAdvChartCustomDockPanel.SetBounds(X, Y, AWidth, AHeight: Single);
begin
  inherited;
  UpdateControls;
end;

procedure TAdvChartCustomDockPanel.DoRemoveObject(
  const AObject: TFmxObject);
begin
  inherited;
  UpdateControls;
end;
{$ENDIF}

function TAdvChartCustomDockPanel.GetDocURL: string;
begin
  Result := TAdvChartBaseDocURL + 'tmsfncuipack/components/ttmsfnctoolbar';
end;

function TAdvChartCustomDockPanel.GetVersion: String;
begin
  Result := GetVersionNumber(MAJ_VER, MIN_VER, REL_VER, BLD_VER);
end;

procedure TAdvChartCustomDockPanel.InitializeControls;
var
  I: Integer;
  c: TControl;
begin
  for I := 0 to Self.ControlCount - 1 do
  begin
    c := Self.Controls[I];
    {$IFDEF FMXLIB}
    if Supports(c, IDesignerControl) then
      Continue;
    {$ENDIF}

    if c is TAdvChartCustomToolBar then
    begin
      (c as TAdvChartCustomToolBar).OnUpdateDockPanel := UpdateDockPanel;
      if (c as TAdvChartCustomToolBar).FDragGripMoving then
        Continue;
    end;

    if c.Visible then
    begin
      {$IFDEF FMXLIB}
      if c.Position.y < Appearance.Margins.Top then
        c.Position.y := Appearance.Margins.Top;
      if c.Position.x < Appearance.Margins.Left then
        c.Position.x := Appearance.Margins.Left
      else if c.Position.x + c.Width > Width - Appearance.Margins.Right then
        c.Position.x := Width - Appearance.Margins.Right - c.Width;
      {$ENDIF}
      {$IFDEF CMNWEBLIB}
      if c.Top < Appearance.Margins.Top then
        c.Top := Round(Appearance.Margins.Top);
      if c.Left < Appearance.Margins.Left then
        c.Left := Round(Appearance.Margins.Left)
      else if c.Left + c.Width > Width - Appearance.Margins.Right then
        c.Left := Round(Width - Appearance.Margins.Right - c.Width);
      {$ENDIF}
    end;
  end;
end;

procedure TAdvChartCustomDockPanel.Draw(AGraphics: TAdvChartGraphics; ARect: TRectF);
var
  r: TRectF;
begin
  inherited;
  AGraphics.Fill.Assign(Appearance.Fill);
  AGraphics.Stroke.Assign(Appearance.Stroke);

  r := LocalRect;
  AGraphics.DrawRectangle(r);
end;

procedure TAdvChartCustomDockPanel.RearrangeControls;
var
  c, cl: TControl;
  cr, clr: TRectF;
  I, J: Integer;
begin
  for I := 0 to Self.ControlCount - 1 do
  begin
    c := Self.Controls[I];

    {$IFDEF FMXLIB}
    if Supports(c, IDesignerControl) then
      Continue;
    {$ENDIF}

    if not c.Visible then
      Continue;

    if c is TAdvChartCustomToolBar then
    begin
      if (c as TAdvChartCustomToolBar).FDragGripMoving then
        Continue;
    end;

    for J := 0 to Self.ControlCount - 1 do
    begin
      cl := Self.Controls[J];

      if (cl = c) or not cl.Visible then
        Continue;

      {$IFDEF FMXLIB}
      if Supports(cl, IDesignerControl) then
        Continue;
      {$ENDIF}

      {$IFDEF FMXLIB}
      cr := RectF(c.Position.X, c.Position.Y, c.Position.X + c.Width, c.Position.Y + c.Height);
      clr := RectF(cl.Position.X, cl.Position.Y, cl.Position.X + cl.Width, cl.Position.Y + cl.Height);

      if (clr.Left >= cr.Left - 3) and (clr.Left <= cr.Right + 3) then
      begin
        if (clr.Top < CenterPointEx(cr).Y) and (clr.Top >= cr.Top - 3) then
        begin
          cl.Position.X := c.Position.X + c.Width + 3;
          cl.Position.Y := c.Position.Y;
        end
        else if (clr.Top >= CenterPointEx(cr).Y) and (clr.Top <= cr.Bottom + 3) then
        begin
          cl.Position.Y := c.Position.Y + c.Height + 3;
          cl.Position.X := c.Position.X;
        end;
      end;
      {$ENDIF}

      {$IFDEF CMNWEBLIB}
      cr := RectF(c.Left, c.Top, c.Left + c.Width, c.Top + c.Height);
      clr := RectF(cl.Left, cl.Top, cl.Left + cl.Width, cl.Top + cl.Height);

      if (clr.Left >= cr.Left - 3) and (clr.Left <= cr.Right + 3) then
      begin
        if (clr.Top < CenterPointEx(cr).Y) and (clr.Top >= cr.Top - 3) then
        begin
          cl.Left := c.Left + c.Width + 3;
          cl.Top := c.Top;
        end
        else if (clr.Top >= CenterPointEx(cr).Y) and (clr.Top <= cr.Bottom + 3) then
        begin
          cl.Top := c.Top + c.Height + 3;
          cl.Left := c.Left;
        end;
      end;
      {$ENDIF}
    end;
  end;
end;

procedure TAdvChartCustomDockPanel.ResetToDefaultStyle;
begin
  inherited;

end;

procedure TAdvChartCustomDockPanel.SetAdaptToStyle(const Value: Boolean);
begin
  inherited;
  UpdateControls;
end;

procedure TAdvChartCustomDockPanel.SetAppearance(
  const Value: TAdvDockPanelAppearance);
begin
  FAppearance.Assign(Value);
end;

procedure TAdvChartCustomDockPanel.SetAutoAlign(const Value: Boolean);
begin
  if FAutoAlign <> Value then
  begin
    FAutoAlign := Value;
    UpdateControls;
  end;
end;

procedure TAdvChartCustomDockPanel.SetAS(const Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    UpdateControls;
  end;
end;

procedure TAdvChartCustomDockPanel.SetState(
  const Value: TAdvChartToolBarElementState);
var
  I: Integer;
  c: TControl;
begin
  if FState <> Value then
  begin
    FState := Value;
    for I := 0 to Self.ControlCount - 1 do
    begin
      c := Self.Controls[I];
      if c is TAdvChartCustomToolBar then
        (c as TAdvChartCustomToolBar).State := FState;
    end;
  end;
end;

procedure TAdvChartCustomDockPanel.UpdateControls;
var
  I: Integer;
  {$IFDEF FMXLIB}
  h, hsm: Single;
  {$ENDIF}
  {$IFDEF CMNWEBLIB}
  h, hsm: Integer;
  {$ENDIF}
  c: TControl;
  {$IFDEF FNCLIB}
  ia: IAdvAdaptToStyle;
  {$ENDIF}
begin
  if FBlockUpdate or IsLoading or IsDestroying then
    Exit;

  FBlockUpdate := True;
  h := 0;
  hsm := ScalePaintValue(30);

  if AutoAlign then
  begin
    InitializeControls;
    RearrangeControls;
  end;

  if AutoSize then
  begin
    for I := 0 to Self.ControlCount - 1 do
    begin
      c := Self.Controls[I];
      {$IFDEF FMXLIB}
      if Supports(c, IDesignerControl) then
        Continue;

      if c.Visible then
        h := Max(h, c.Position.y + c.Height + Appearance.Margins.Bottom);
      {$ENDIF}

      {$IFDEF FNCLIB}
      if Supports(c, IAdvAdaptToStyle, ia) then
        ia.AdaptToStyle := AdaptToStyle;
      {$ENDIF}

      {$IFDEF CMNWEBLIB}
      if c.Visible then
        h := Round(Max(h, c.Top + c.Height + Appearance.Margins.Bottom));
      {$ENDIF}
    end;

    if h = 0 then
      h := hsm;

    if csDesigning in ComponentState then
      h := h + ScalePaintValue(15);

    {$IFDEF FMXLIB}
    SetBounds(Position.X, Position.Y, Width, h);
    {$ENDIF}
    {$IFDEF CMNWEBLIB}
    SetBounds(Left, Top, Width, h);
    {$ENDIF}
  end;

  FBlockUpdate := False;
end;

procedure TAdvChartCustomDockPanel.UpdateDockPanel(Sender: TObject);
begin
  UpdateControls;
end;

{ TAdvChartCustomDockPanelAppearance }

constructor TAdvChartCustomDockPanelAppearance.Create(AOwner: TAdvChartCustomDockPanel);
begin
  FOwner := AOwner;
  FFill := TAdvChartGraphicsFill.Create(gfkSolid, gcWhite);
  FStroke := TAdvChartGraphicsStroke.Create(gskSolid, gcGray);

  FFill.OnChanged := FillChanged;
  FStroke.OnChanged := StrokeChanged;
  FMargins := TAdvMargins.Create;
  FMargins.Left := 3;
  FMargins.Top := 3;
  FMargins.Bottom := 3;
  FMargins.Right := 3;
end;

destructor TAdvChartCustomDockPanelAppearance.Destroy;
begin
  FMargins.Free;
  FFill.Free;
  FStroke.Free;
  inherited;
end;

procedure TAdvChartCustomDockPanelAppearance.FillChanged(Sender: TObject);
begin
  FOwner.Invalidate;
end;

procedure TAdvChartCustomDockPanelAppearance.MarginsChanged(
  Sender: TObject);
begin
  FOwner.UpdateControls;
end;

procedure TAdvChartCustomDockPanelAppearance.SetFill(const Value: TAdvChartGraphicsFill);
begin
  FFill.Assign(Value);
end;

procedure TAdvChartCustomDockPanelAppearance.SetMargins(
  const Value: TAdvMargins);
begin
  FMargins.Assign(Value);
end;

procedure TAdvChartCustomDockPanelAppearance.SetStroke(const Value: TAdvChartGraphicsStroke);
begin
  FStroke.Assign(Value);
end;

procedure TAdvChartCustomDockPanelAppearance.StrokeChanged(Sender: TObject);
begin
  FOwner.Invalidate;
end;

{ TAdvChartCustomToolBarElement }

procedure TAdvChartCustomToolBarElement.UpdateToolBarControl;
begin
  if Assigned(OnUpdateToolBarControl) then
    OnUpdateToolBarControl(Self);
end;

{$IFNDEF WEBLIB}
procedure TAdvChartCustomToolBarElement.ReadControlIndex(Reader: TReader);
begin
  ControlIndex := Reader.ReadInteger;
end;

procedure TAdvChartCustomToolBarElement.WriteControlIndex(Writer: TWriter);
begin
  Writer.WriteInteger(ControlIndex);
end;
{$ENDIF}

procedure TAdvChartCustomToolBarElement.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TAdvChartCustomToolBarElement then
  begin
    FState := (Source as TAdvChartCustomToolBarElement).State;
    FLastElement := (Source as TAdvChartCustomToolBarElement).LastElement;
    FCanCopy := (Source as TAdvChartCustomToolBarElement).CanCopy;
  end;
end;

constructor TAdvChartCustomToolBarElement.Create(AOwner: TComponent);
begin
  inherited;
  DisableBackground;
  {$IFDEF CMNLIB}
  ParentColor := True;
  {$IFDEF VCLLIB}
  ParentBackground := True;
  {$ENDIF}
  {$ENDIF}
  FLastElement := False;
  FCanCopy := True;
  FState := esNormal;
end;

{$IFNDEF WEBLIB}
procedure TAdvChartCustomToolBarElement.DefineProperties(Filer: TFiler);
begin
  inherited;
  {$IFDEF LCLLIB}
  Filer.DefineProperty('ControlIndex', @ReadControlIndex, @WriteControlIndex, True);
  {$ENDIF}
  {$IFNDEF LCLLIB}
  Filer.DefineProperty('ControlIndex', ReadControlIndex, WriteControlIndex, True);
  {$ENDIF}
end;
{$ENDIF}

destructor TAdvChartCustomToolBarElement.Destroy;
begin
  inherited;
end;

function TAdvChartCustomToolBarElement.GetDocURL: string;
begin
  Result := TAdvChartBaseDocURL + 'tmsfncuipack/components/ttmsfnctoolbar';
end;

{$IFDEF FMXLIB}
procedure TAdvChartCustomToolBarElement.DoMatrixChanged(Sender: TObject);
begin
  inherited;
  UpdateToolBar;
end;
{$ENDIF}

procedure TAdvChartCustomToolBarElement.UpdateControlAfterResize;
begin
  inherited;
  UpdateToolBar;
end;

procedure TAdvChartCustomToolBarElement.SetLastElement(const Value: Boolean);
begin
  if FLastElement <> Value then
  begin
    FLastElement := Value;
    UpdateToolBar;
  end;
end;

procedure TAdvChartCustomToolBarElement.SetState(
  const Value: TAdvChartToolBarElementState);
begin
  if FState <> Value then
  begin
    FState := Value;
    UpdateState;
  end;
end;

{$IFDEF FMXLIB}
procedure TAdvChartCustomToolBarElement.SetVisible(const Value: Boolean);
{$ENDIF}
{$IFDEF CMNWEBLIB}
procedure TAdvChartCustomToolBarElement.VisibleChanging;
{$ENDIF}
begin
  inherited;
  {$IFDEF FMXLIB}
  if Visible <> Value then
  {$ENDIF}
    UpdateToolBar;
end;

procedure TAdvChartCustomToolBarElement.UpdateState;
begin

end;

procedure TAdvChartCustomToolBarElement.UpdateToolBar;
begin
  if Assigned(OnUpdateToolBar) and not FBlockUpdate then
    OnUpdateToolBar(Self);
end;

{ TAdvChartToolBarControl }

constructor TAdvChartToolBarControl.Create;
begin
  FBitmap := TAdvChartBitmap.Create;
end;

destructor TAdvChartToolBarControl.Destroy;
begin 
  FBitmap.Free;
  inherited;
end;

{ TAdvChartCustomToolBarOptionsMenu }

procedure TAdvChartCustomToolBarOptionsMenu.Assign(Source: TPersistent);
begin
  if Source is TAdvChartCustomToolBarOptionsMenu then
  begin
    FShowItemText := (Source as TAdvChartCustomToolBarOptionsMenu).ShowItemText;
    FShowItemBitmap := (Source as TAdvChartCustomToolBarOptionsMenu).ShowItemBitmap;
    FShowButton := (Source as TAdvChartCustomToolBarOptionsMenu).ShowButton;
    FAutoItemBitmapWidth := (Source as TAdvChartCustomToolBarOptionsMenu).AutoItemBitmapWidth;
    FItemBitmapWidth := (Source as TAdvChartCustomToolBarOptionsMenu).ItemBitmapWidth;
  end;
end;

constructor TAdvChartCustomToolBarOptionsMenu.Create(
  AOwner: TAdvChartCustomToolBar);
begin
  FOwner := AOwner;
  FShowItemText := True;
  FShowButton := True;
  FShowItemBitmap := True;
  FAutoItemBitmapWidth := True;
  FItemBitmapWidth := 50;
end;

destructor TAdvChartCustomToolBarOptionsMenu.Destroy;
begin

  inherited;
end;

function TAdvChartCustomToolBarOptionsMenu.IsItemBitmapWidthStored: Boolean;
begin
  Result := ItemBitmapWidth <> 50;
end;

procedure TAdvChartCustomToolBarOptionsMenu.SetAutoItemBitmapWidth(
  const Value: Boolean);
begin
  if FAutoItemBitmapWidth <> Value then
  begin
    FAutoItemBitmapWidth := Value;
  end;
end;

procedure TAdvChartCustomToolBarOptionsMenu.SetItemBitmapWidth(
  const Value: Single);
begin
  if FItemBitmapWidth <> Value then
  begin
    FItemBitmapWidth := Value;
  end;
end;

procedure TAdvChartCustomToolBarOptionsMenu.SetShowButton(const Value: Boolean);
begin
  if FShowButton <> Value then
  begin
    FShowButton := Value;
    FOwner.FOptionsMenuButton.Visible := FShowButton;
    if FShowButton then
      FOwner.FOptionsMenuButton.Parent := FOwner
    else
      FOwner.FOptionsMenuButton.Parent := nil;

    FOwner.UpdateControls;
  end;
end;

procedure TAdvChartCustomToolBarOptionsMenu.SetShowItemBitmap(
  const Value: Boolean);
begin
  if FShowItemBitmap <> Value then
  begin
    FShowItemBitmap := Value;
  end;
end;

procedure TAdvChartCustomToolBarOptionsMenu.SetShowItemText(const Value: Boolean);
begin
  if FShowItemText <> Value then
  begin
    FShowItemText := Value;
  end;
end;

{ TAdvChartToolBarFontNamePicker }

constructor TAdvChartToolBarFontNamePicker.Create(AOwner: TComponent);
begin
  inherited;
  AutoOptionsMenuText := 'Font Name';
  TAdvChartUtils.GetFonts(FItems);
  {$IFDEF LCLLIB}
  FItems.Insert(0, 'Default');
  {$ENDIF}
end;

procedure TAdvChartToolBarFontNamePicker.DoItemSelected;
begin
  inherited;
  if Assigned(OnFontNameSelected) then
    OnFontNameSelected(Self, SelectedFontName);
end;

function TAdvChartToolBarFontNamePicker.GetSelectedFontName: String;
begin
  Result := GetSelectedItem;
end;

procedure TAdvChartToolBarFontNamePicker.RegisterRuntimeClasses;
begin
  inherited;
  RegisterClass(TAdvChartToolBarFontNamePicker);
end;

procedure TAdvChartToolBarFontNamePicker.SetSelectedFontName(const Value: String);
begin
  SelectedItem := Value;
end;

{ TAdvChartToolBarFontNamePicker }

constructor TAdvChartToolBarFontSizePicker.Create(AOwner: TComponent);
begin
  inherited;
  AutoOptionsMenuText := 'Font Size';
  FItems.Add('8');
  FItems.Add('9');
  FItems.Add('10');
  FItems.Add('11');
  FItems.Add('12');
  FItems.Add('14');
  FItems.Add('16');
  FItems.Add('18');
  FItems.Add('20');
  FItems.Add('22');
  FItems.Add('24');
  FItems.Add('26');
  FItems.Add('28');
  FItems.Add('36');
  FItems.Add('48');
  FItems.Add('72');
end;

procedure TAdvChartToolBarFontSizePicker.DoItemSelected;
begin
  inherited;
  if Assigned(OnFontSizeSelected) then
    OnFontSizeSelected(Self, SelectedFontSize);
end;

function TAdvChartToolBarFontSizePicker.GetSelectedFontSize: Single;
var
  s: String;
begin
  Result := -1;
  s := GetSelectedItem;
  if s <> '' then
    Result := StrToFloat(GetSelectedItem)
end;

procedure TAdvChartToolBarFontSizePicker.RegisterRuntimeClasses;
begin
  inherited;
  RegisterClass(TAdvChartToolBarFontSizePicker);
end;

procedure TAdvChartToolBarFontSizePicker.SetSelectedFontSize(const Value: Single);
begin
  SelectedItem := FloatToStr(Value);
end;

{ TAdvChartToolBarColorPicker }

function TAdvChartToolBarColorPicker.BlockChange: Boolean;
begin
  Result := FColorSelector.BlockChange;
end;

function TAdvChartToolBarColorPicker.CanChangeText: Boolean;
begin
  Result := not (csLoading in ComponentState) and not (csDesigning in ComponentState);
end;

procedure TAdvChartToolBarColorPicker.ColorSelected(Sender: TObject;
  AColor: TAdvChartGraphicsColor);
begin
  if CloseOnSelection and not BlockChange then
    CloseDropDown;
  DoColorSelected(AColor);
  Invalidate;
end;

function TAdvChartToolBarColorPicker.ColorSelector: TAdvChartColorSelector;
begin
  Result := FColorSelector;
end;

constructor TAdvChartToolBarColorPicker.Create(AOwner: TComponent);
begin
  inherited;
  Width := 40;
  Height := 24;
  AutoOptionsMenuText := 'Color';
  FColorSelector := TAdvChartColorSelector.Create(Self);
  FColorSelector.Appearance.HorizontalSpacing := 2;
  FColorSelector.Appearance.VerticalSpacing := 2;
  FColorSelector.Mode := csmExtended;
  FColorSelector.Width := 175;
  FColorSelector.Height := 125;
  FColorSelector.Stored := False;
  FColorSelector.SelectedColor := gcBlack;
  FColorSelector.OnColorSelected := ColorSelected;

  DropDownControl := FColorSelector;
  DropDownWidth := FColorSelector.Width;
  DropDownHeight := FColorSelector.Height;
  DropDownKind := ddkDropDownButton;
end;

procedure TAdvChartToolBarColorPicker.DoColorSelected(AColor: TAdvChartGraphicsColor);
begin
  if Assigned(OnColorSelected) then
    OnColorSelected(Self, AColor);
end;

procedure TAdvChartToolBarColorPicker.DrawColor(AColor: TAdvChartGraphicsColor;
  ARect: TRectF; AGraphics: TAdvChartGraphics);
var
  r: TRectF;
  rounding: integer;
  I, J: Integer;
  st: TAdvChartGraphicsSaveState;
begin
  R := ARect;

  rounding := Round(Max(ScalePaintValue(3.5), Appearance.Rounding / 4));

  InflateRectEx(R, -rounding, -rounding);
  OffsetRectEx(R, ScalePaintValue(0.5), ScalePaintValue(0.5));
  st := AGraphics.SaveState;
  try
    AGraphics.ClipRect(R);
    AGraphics.Stroke.Kind := gskNone;
    AGraphics.Fill.Kind := gfkSolid;
    AGraphics.Stroke.Width := 1;
    AGraphics.Fill.Color := MakeGraphicsColor(255, 255, 255);
    AGraphics.DrawRectangle(R);
    AGraphics.Fill.Color := MakeGraphicsColor(211 , 211 , 211 );
    for I := 0 to Trunc((r.Right - r.Left) / 5) + 1 do
      for J := 0 to Trunc((r.Bottom - r.Top) / 5) + 1 do
        if Odd(I + J) then
          AGraphics.DrawRectangle(RectF(I * 5, J * 5, (I + 1) * 5, (J + 1) * 5), gcrmNone);

    AGraphics.Fill.Kind := gfkSolid;
    AGraphics.Fill.Color := AColor;
    AGraphics.Stroke.Color := gcBlack;
    AGraphics.Stroke.Kind := gskSolid;
    AGraphics.DrawRectangle(R);
  finally
    AGraphics.RestoreState(st);
  end;
end;

procedure TAdvChartToolBarColorPicker.DrawSelectedColor(
  AGraphics: TAdvChartGraphics; ARect: TRectF);
var
  R: TRectF;
  c: TAdvChartGraphicsColor;
  ct: TAdvChartToolBarDropDownButton;
begin
  ct := GetDropDownButtonControl;
  if Assigned(ct) then
  begin
    R := RectF(0, 0, Width - ct.Width, Height);
    c := SelectedColor;
    DrawColor(c, r, AGraphics);
  end;
end;

function TAdvChartToolBarColorPicker.GetItems: TAdvChartColorSelectorItems;
begin
  Result := FColorSelector.Items;
end;

function TAdvChartToolBarColorPicker.GetSelectedColor: TAdvChartGraphicsColor;
begin
  Result := FColorSelector.SelectedColor;
end;

function TAdvChartToolBarColorPicker.GetSelectedItemIndex: Integer;
begin
  Result := FColorSelector.SelectedItemIndex;
end;

procedure TAdvChartToolBarColorPicker.RegisterRuntimeClasses;
begin
  inherited;
  RegisterClass(TAdvChartToolBarColorPicker);
end;

procedure TAdvChartToolBarColorPicker.Draw(AGraphics: TAdvChartGraphics; ARect: TRectF);
begin
  inherited;
  DrawSelectedColor(AGraphics, ARect);
end;

procedure TAdvChartToolBarColorPicker.SetAdaptToStyle(const Value: Boolean);
begin
  inherited;
  if Assigned(FColorSelector) then
    FColorSelector.AdaptToStyle := AdaptToStyle;
end;

procedure TAdvChartToolBarColorPicker.SetItems(
  const Value: TAdvChartColorSelectorItems);
begin
  FColorSelector.Items.Assign(Value);
end;

procedure TAdvChartToolBarColorPicker.SetSelectedColor(const Value: TAdvChartGraphicsColor);
begin
  FColorSelector.SelectedColor := Value;
  Invalidate;
end;

procedure TAdvChartToolBarColorPicker.SetSelectedItemIndex(const Value: Integer);
begin
  FColorSelector.SelectedItemIndex := Value;
  Invalidate;
end;

{ TAdvChartToolBarBitmapPicker }

function TAdvChartToolBarBitmapPicker.BitmapSelector: TAdvChartBitmapSelector;
begin
  Result := FBitmapSelector;
end;

function TAdvChartToolBarBitmapPicker.BlockChange: Boolean;
begin
  Result := FBitmapSelector.BlockChange;
end;

procedure TAdvChartToolBarBitmapPicker.BitmapSelected(Sender: TObject;
  ABitmap: TAdvChartBitmap);
begin
  Bitmaps.Clear;
  DisabledBitmaps.Clear;
  HoverBitmaps.Clear;
  Bitmaps.AddBitmap(ABitmap);
  DisabledBitmaps.AddBitmap(ABitmap);
  HoverBitmaps.AddBitmap(ABitmap);

  if CloseOnSelection and not BlockChange then
    CloseDropDown;
  DoBitmapSelected(ABitmap);
end;

function TAdvChartToolBarBitmapPicker.CanChangeText: Boolean;
begin
  Result := not (csLoading in ComponentState) and not (csDesigning in ComponentState);
end;

constructor TAdvChartToolBarBitmapPicker.Create(AOwner: TComponent);
begin
  inherited;
  Width := 40;
  Height := 24;
  AutoOptionsMenuText := 'Bitmap';
  FBitmapSelector := TAdvChartBitmapSelector.Create(Self);
  FBitmapSelector.Appearance.HorizontalSpacing := 2;
  FBitmapSelector.Appearance.VerticalSpacing := 2;
  FBitmapSelector.Stored := False;
  FBitmapSelector.OnBitmapSelected := BitmapSelected;

  DropDownControl := FBitmapSelector;
  DropDownWidth := FBitmapSelector.Width;
  DropDownHeight := FBitmapSelector.Height;
  DropDownKind := ddkDropDownButton;
end;

procedure TAdvChartToolBarBitmapPicker.DoBitmapSelected(ABitmap: TAdvChartBitmap);
begin
  if Assigned(OnBitmapSelected) then
    OnBitmapSelected(Self, ABitmap);
end;

function TAdvChartToolBarBitmapPicker.GetBitmapRect(ARect: TRectF): TRectF;
var
  r: TRectF;
  dr: TRectf;
begin
  r := ARect;
  Result := RectF(r.Left, r.Top, r.Right, r.Bottom);
  if BitmapVisible then
  begin
    if DropDownKind <> ddkNormal then
    begin
      dr := GetDropDownRect;
      case DropDownPosition of
        ddpRight: Result := RectF(Result.Left + 3, Result.Top + 3, dr.Left - 3, Result.Bottom - 3);
        ddpBottom: Result := RectF(Result.Left + 3, Result.Top + 3, Result.Right - 3, dr.Top - 3);
      end;
    end
    else
      Result := RectF(Result.Left + 3, Result.Top + 3, Result.Right - 3, Result.Bottom - 3);
  end;
end;

function TAdvChartToolBarBitmapPicker.GetItems: TAdvChartBitmapSelectorItems;
begin
  Result := FBitmapSelector.Items;
end;

function TAdvChartToolBarBitmapPicker.GetSelectedBitmap: TAdvChartBitmap;
begin
  Result := FBitmapSelector.SelectedBitmap;
end;

function TAdvChartToolBarBitmapPicker.GetSelectedItemIndex: Integer;
begin
  Result := FBitmapSelector.SelectedItemIndex;
end;

procedure TAdvChartToolBarBitmapPicker.RegisterRuntimeClasses;
begin
  inherited;
  RegisterClass(TAdvChartToolBarBitmapPicker);
end;

procedure TAdvChartToolBarBitmapPicker.SetAdaptToStyle(const Value: Boolean);
begin
  inherited;
  if Assigned(FBitmapSelector) then
    FBitmapSelector.AdaptToStyle := AdaptToStyle;
end;

procedure TAdvChartToolBarBitmapPicker.SetBitmapContainer(
  const Value: TAdvChartBitmapContainer);
begin
  inherited;
  if Assigned(FBitmapSelector) then
    FBitmapSelector.BitmapContainer := Value;
end;

procedure TAdvChartToolBarBitmapPicker.SetItems(
  const Value: TAdvChartBitmapSelectorItems);
begin
  if Assigned(FBitmapSelector) then
    FBitmapSelector.Items.Assign(Value);
end;

procedure TAdvChartToolBarBitmapPicker.SetSelectedItemIndex(const Value: Integer);
begin
  FBitmapSelector.SelectedItemIndex := Value;
  Bitmaps.Clear;
  DisabledBitmaps.Clear;
  HoverBitmaps.Clear;
  Bitmaps.AddBitmap(SelectedBitmap);
  DisabledBitmaps.AddBitmap(SelectedBitmap);
  HoverBitmaps.AddBitmap(SelectedBitmap);
  Invalidate;
end;

{ TAdvChartToolBarDropDownButton }

constructor TAdvChartToolBarDropDownButton.Create(AOwner: TComponent);
begin
  inherited;
  FDefaultStyle := True;
end;

procedure TAdvChartToolBarDropDownButton.DrawBitmap(AGraphics: TAdvChartGraphics;
  ARect: TRectF);
var
  bmp: TAdvChartBitmapHelperClass;
  bmpa: TBitmap;
  r: TRectF;
  g: TAdvChartGraphics;
begin
  if DefaultStyle then
  begin
    r := ARect;

    if not(Assigned(Owner) and (Owner is TAdvChartCustomToolBarButton) and ((Owner as TAdvChartCustomToolBarButton).FDropDownPosition = ddpBottom)) then
      InflateRectEx(r, ScalePaintValue(-2),ScalePaintValue(-2));

    inherited DrawBitmap(AGraphics, r);
  end
  else
  begin
    bmpa := TBitmap.Create;
    bmpa.SetSize(7, 7);
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
      g.Stroke.Color := gcDarkgray;
      g.DrawLine(PointF(0, 1), PointF(6, 1), gcpmRightDown);
      g.DrawLine(PointF(0, 2), PointF(6, 2), gcpmRightDown);
      g.DrawLine(PointF(1, 3), PointF(5, 3), gcpmRightDown);
      g.DrawLine(PointF(2, 4), PointF(4, 4), gcpmRightDown);
      g.DrawLine(PointF(3, 5), PointF(3, 5), gcpmRightDown);
    finally
      g.EndScene;
      g.Free;
    end;

    try
      r := ARect;
      bmp := TAdvChartBitmap.Create;
      try
        bmp.Assign(bmpa);
        AGraphics.DrawBitmap(r, bmp);
      finally
        bmp.Free;
      end;
    finally
      bmpa.Free;
    end;
  end;
end;

function TAdvChartToolBarDropDownButton.GetBitmapRect(ARect: TRectF): TRectF;
var
  r: TRectF;
begin
  r := ARect;
  Result := RectF(r.Left + 3, r.Top + 3, r.Right - 3, r.Bottom - 3);
end;

procedure TAdvChartToolBarDropDownButton.LoadSettingsFromFile(AFileName: string);
begin
  inherited;
  DefaultStyle := False;
end;

procedure TAdvChartToolBarDropDownButton.LoadSettingsFromStream(
  AStream: TStreamEx);
begin
  inherited;
  DefaultStyle := False;
end;

procedure TAdvChartToolBarDropDownButton.RegisterRuntimeClasses;
begin
  inherited;
  RegisterClass(TAdvChartToolBarDropDownButton);
end;

procedure TAdvChartToolBarDropDownButton.SetDefaultStyle(const Value: Boolean);
begin
  if FDefaultStyle <> Value then
  begin
    FDefaultStyle := Value;
    Invalidate;
  end;
end;

{ TAdvChartToolBarCustomItemPicker }

function TAdvChartToolBarCustomItemPicker.CanChangeText: Boolean;
begin
  Result := not (csLoading in ComponentState) and not (csDesigning in ComponentState);
end;

procedure TAdvChartToolBarCustomItemPicker.ChangeDPIScale(M, D: Integer);
begin
  inherited;
  {$IFDEF CMNLIB}
  FItemSelector.Font.Height := TAdvChartUtils.MulDivInt(FItemSelector.Font.Height, M, D);
  FItemSelector.ItemHeight := TAdvChartUtils.MulDivInt(FItemSelector.ItemHeight, M, D);
  {$ENDIF}
end;

constructor TAdvChartToolBarCustomItemPicker.Create(AOwner: TComponent);
begin
  inherited;
  FTimer := TTimer.Create(Self);
  FTimer.Interval := 1;
  FTimer.OnTimer := EnterTimerChanged;
  FTimer.Enabled := False;

  FEdit := TEdit.Create(Self);
  FEdit.TabStop := True;
  {$IFDEF FMXLIB}
  FEdit.Align := TAlignLayout.Client;
  FEdit.Stored := False;
  FEdit.OnChangeTracking := EditChange;
  {$ENDIF}
  {$IFDEF CMNWEBLIB}
  FEdit.Align := alClient;
  FEdit.OnChange := EditChange;
  {$ENDIF}

  Width := 100;
  Height := 24;
  HorizontalTextAlign := gtaLeading;
  FItemIndex := -1;

  FItemSelector := TListBox.Create(Self);
  FItemSelector.Width := 200;
  FItemSelector.Height := 150;
  {$IFDEF LCLLIB}
  FItemSelector.ClickOnSelChange := False;
  {$ENDIF}
  {$IFDEF FMXLIB}
  FItemSelector.Align := TAlignLayout.Client;
  FItemSelector.OnItemClick := ItemSelected;
  {$ENDIF}
  {$IFDEF CMNWEBLIB}
  FItemSelector.Font.Height := -11;
  FItemSelector.Align := alClient;
  FItemSelector.OnClick := ItemSelected;
  {$ENDIF}

  FItemSelector.OnKeyUp := ItemKeyUp;
  FItemSelector.OnKeyDown := ItemKeyDown;

  DropDownControl := FItemSelector;
  DropDownKind := ddkDropDownButton;
  DropDownWidth := FItemSelector.Width;
  DropDownHeight := FItemSelector.Height;

  FItems := TStringList.Create;
end;

destructor TAdvChartToolBarCustomItemPicker.Destroy;
begin
  FTimer.Free;
  FItems.Free;
  inherited;
end;

procedure TAdvChartToolBarCustomItemPicker.DoEnter;
begin
  inherited;
  FTimer.Enabled := Editable;
end;

procedure TAdvChartToolBarCustomItemPicker.DoItemSelected;
begin
  if Assigned(FEdit) {$IFDEF CMNWEBLIB} and FEdit.HandleAllocated{$ENDIF} then
  begin
    FEdit.Text := SelectedItem;
    FEdit.SelStart := Length(FEdit.Text);
  end;

  if Assigned(OnItemSelected) then
    OnItemSelected(Self, SelectedItemIndex);
end;

procedure TAdvChartToolBarCustomItemPicker.Draw(AGraphics: TAdvChartGraphics;
  ARect: TRectF);
begin
  if not Editable then
    inherited;
end;

procedure TAdvChartToolBarCustomItemPicker.DropDown;
begin
  inherited;
  if not Assigned(FPopup) then
    Exit;

  {$IFDEF CMNLIB}
  if Assigned(FItemSelector) then
    FItemSelector.Font.Height := ScalePaintValue(-11);
  {$ENDIF}

  if FPopup.IsOpen and Assigned(FItemSelector) then
  begin
    FItemSelector.ItemIndex := -1;
    FItemSelector.ItemIndex := SelectedItemIndex;
  end;
end;

procedure TAdvChartToolBarCustomItemPicker.EditChange(Sender: TObject);
begin
  SelectedItem := FEdit.Text;
  if Assigned(OnEditChange) then
    OnEditChange(Self);
end;

procedure TAdvChartToolBarCustomItemPicker.EnterTimerChanged(Sender: TObject);
begin
  FEdit.SetFocus;
  FTimer.Enabled := False;
end;

function TAdvChartToolBarCustomItemPicker.GetSelectedItem: String;
begin
  Result := '';
  if Assigned(FItems) and (FItemIndex >= 0) and (FItemIndex <= FItems.Count - 1) then
    Result := FItems[FItemIndex]
end;

function TAdvChartToolBarCustomItemPicker.GetSelectedItemIndex: Integer;
begin
  Result := FItemIndex;
end;

function TAdvChartToolBarCustomItemPicker.GetText: String;
begin
  if Editable then
    Result := FEdit.Text
  else
    Result := SelectedItem;
end;

procedure TAdvChartToolBarCustomItemPicker.HandleDialogKey(var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Shift <> [] then
    Exit;

  if Editable and FEdit.Focused then
  begin
    case Key of
      KEY_F4:
      begin
        if not (ssAlt in Shift) then
          DropDown;
      end;
    end;
  end;
end;

procedure TAdvChartToolBarCustomItemPicker.InitializePopup;
begin
  {$IFDEF FMXLIB}
  FItemSelector.BeginUpdate;
  {$ENDIF}
  FItemSelector.Items.Clear;
  FItemSelector.Items.Assign(FItems);
  FItemSelector.ItemIndex := FItemIndex;
  {$IFDEF FMXLIB}
  FItemSelector.EndUpdate;
  {$ENDIF}
end;

{$IFDEF FMXLIB}
procedure TAdvChartToolBarCustomItemPicker.ItemKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
{$ENDIF}
{$IFDEF CMNWEBLIB}
procedure TAdvChartToolBarCustomItemPicker.ItemKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
{$ENDIF}
begin
  FKeyboardUsed := True;
end;

{$IFDEF FMXLIB}
procedure TAdvChartToolBarCustomItemPicker.ItemKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
{$ENDIF}
{$IFDEF CMNWEBLIB}
procedure TAdvChartToolBarCustomItemPicker.ItemKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
{$ENDIF}
begin
  if (Key = KEY_RETURN) or (Key = KEY_SPACE) then
  begin
    FItemIndex := FItemSelector.ItemIndex;
    if CloseOnSelection then
      DropDown;

    DoItemSelected;
    Invalidate;
  end;

  FKeyBoardUsed := False;
end;

{$IFDEF FMXLIB}
procedure TAdvChartToolBarCustomItemPicker.ItemSelected(const Sender: TCustomListBox; const Item: TListBoxItem);
{$ENDIF}
{$IFDEF CMNWEBLIB}
procedure TAdvChartToolBarCustomItemPicker.ItemSelected(Sender: TObject);
{$ENDIF}
begin
  if FKeyBoardUsed then
    Exit;

  FItemIndex := FItemSelector.ItemIndex;
  if CloseOnSelection then
    DropDown;

  DoItemSelected;
  Invalidate;
end;

procedure TAdvChartToolBarCustomItemPicker.SelectFirstValue;
begin
  inherited;
  FItemIndex := 0;
  DoItemSelected;
  Invalidate;
end;

procedure TAdvChartToolBarCustomItemPicker.SelectLastValue;
begin
  inherited;
  FItemIndex := FItems.Count - 1;
  DoItemSelected;
  Invalidate;
end;

procedure TAdvChartToolBarCustomItemPicker.SelectNextValue;
begin
  inherited;
  if FItemIndex = -1 then
    FItemIndex := 0
  else
    FItemIndex := Min(FItems.Count - 1, FItemIndex + 1);

  DoItemSelected;
  Invalidate;
end;

procedure TAdvChartToolBarCustomItemPicker.SelectPreviousValue;
begin
  inherited;
  if FItemIndex = -1 then
    FItemIndex := 0
  else
    FItemIndex := Max(0, FItemIndex - 1);

  DoItemSelected;
  Invalidate;
end;

procedure TAdvChartToolBarCustomItemPicker.SelectValueWithCharacter(
  ACharacter: Char);
var
  I: Integer;
begin
  inherited;
  for I := 0 to Items.Count - 1 do
  begin
    if TAdvChartUtils.MatchStrEx(ACharacter + '*', Items[I], False) then
    begin
      FItemIndex := I;
      DoItemSelected;
      Invalidate;
      Break;
    end;
  end;
end;

procedure TAdvChartToolBarCustomItemPicker.SelectValueWithString(AValue: string);
var
  I: Integer;
begin
  inherited;
  for I := 0 to Items.Count - 1 do
  begin
    if TAdvChartUtils.MatchStrEx(AValue + '*', Items[I], False) then
    begin
      FItemIndex := I;
      DoItemSelected;
      Invalidate;
      Break;
    end;
  end;
end;

procedure TAdvChartToolBarCustomItemPicker.SetEditable(const Value: Boolean);
begin
  if FEditable <> Value then
  begin
    FEditable := Value;
    if Assigned(FEdit) then
    begin
      if FEditable then
      begin
        FEdit.Parent := Self;
      end
      else
        FEdit.Parent := nil;

      FEdit.Visible := FEditable;
    end;
    Invalidate;
  end;
end;

procedure TAdvChartToolBarCustomItemPicker.SetItems(const Value: TStringList);
begin
  FItems.Assign(Value);
end;

procedure TAdvChartToolBarCustomItemPicker.SetSelectedItem(const Value: String);
begin
  FItemIndex := FItems.IndexOf(Value);
  Invalidate;
end;

procedure TAdvChartToolBarCustomItemPicker.SetSelectedItemIndex(
  const Value: Integer);
begin
  FItemIndex := Value;
  Invalidate;
end;

{ TAdvChartToolBarButton }

procedure TAdvChartToolBarButton.RegisterRuntimeClasses;
begin
  inherited;
  RegisterClass(TAdvChartToolBarButton);
end;

{ TAdvChartToolBarSeparator }

procedure TAdvChartToolBarSeparator.RegisterRuntimeClasses;
begin
  inherited;
  RegisterClass(TAdvChartToolBarSeparator);
end;

{ TAdvChartToolBar }

procedure TAdvChartToolBar.RegisterRuntimeClasses;
begin
  inherited;
  RegisterClass(TAdvChartToolBar);
end;

{$IFDEF WEBLIB}
function TAdvChartToolBarControlObjectList.GetItem(
  Index: Integer): TAdvChartToolBarControl;
begin
  Result := TAdvChartToolBarControl(inherited Items[Index]);
end;

procedure TAdvChartToolBarControlObjectList.SetItem(Index: Integer; const Value: TAdvChartToolBarControl);
begin
  inherited Items[Index] := Value;
end;

function TAdvChartToolBarControlList.GetItem(
  Index: Integer): TAdvChartToolBarControl;
begin
  Result := TAdvChartToolBarControl(inherited Items[Index]);
end;

procedure TAdvChartToolBarControlList.SetItem(Index: Integer; const Value: TAdvChartToolBarControl);
begin
  inherited Items[Index] := Value;
end;

function TAdvControlList.GetItem(Index: Integer): TControl;
begin
  Result := TControl(inherited Items[Index]);
end;

procedure TAdvControlList.SetItem(Index: Integer; const Value: TControl);
begin
  inherited Items[Index] := Value;
end;
{$ENDIF}

initialization
  RegisterClass(TAdvChartToolBarButton);
  {$IFDEF WEBLIB}
  TAdvChartBitmap.CreateFromResource(AdvTOOLBAREXPANDSVG);
  {$ENDIF}

end.
