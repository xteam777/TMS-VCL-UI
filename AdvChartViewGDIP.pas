{***************************************************************************}
{ TAdvGDIPChartView component                                               }
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
unit AdvChartViewGDIP;
{$I TMSDEFS.INC}
interface
uses                                                                                         
  Classes, Graphics, Types, Windows, SysUtils,
  AdvChartView, AdvChart, AdvChartGDIP,
  ActiveX, IniFiles, Math, Dialogs,
  Controls
  {$IFDEF DELPHIXE3_LVL}
  , System.UITypes
  {$ENDIF}
  ;
type
  TChartRoundingType = (rtNone, rtTop, rtBottom, rtBoth, rtLeft, rtRight);
  TChartImageType = (itPNG, itBMP, itJPEG, itTIFF, itGIF);
  TAdvGDIPChartSeries = class;
  TAdvGDIPChart = class;
  TChartGDIPLegend = class(TChartLegend)
  private
    FOpacity: integer;
    FGradientType: TChartGradientType;
    FOpacityTo: integer;
    FHatchStyle: THatchStyle;
    FAngle: integer;
    FShadow: boolean;
    Fchart: TadvGdipchart;
    procedure SetOpacity(const Value: integer);
    procedure SetAngle(const Value: integer);
    procedure SetGradientType(const Value: TChartGradientType);
    procedure SetHatchStyle(const Value: THatchStyle);
    procedure SetOpacityTo(const Value: integer);
    procedure SetShadow(const Value: boolean);
    procedure SetChart(const Value: TAdvGdipChart);
  public
    constructor Create(AOwner: TAdvChart); override;
    procedure Draw(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: double); override;
    procedure Assign(Source: TPersistent); override;
    //Settings
    procedure SaveToFile(ini: TMemIniFile;Section: String); override;
    procedure LoadFromFile(ini: TMemIniFile;Section: String); override;
    property Chart: TAdvGDIPChart read FChart write SetChart;
  published
    property Angle: integer read FAngle write SetAngle default 0;
    property GradientType: TChartGradientType read FGradientType write SetGradientType default gtSolid;
    property HatchStyle: THatchStyle read FHatchStyle write SetHatchStyle default HatchStyleHorizontal;
    property Opacity: integer read FOpacity write SetOpacity default 255;
    property OpacityTo: integer read FOpacityTo write SetOpacityTo default 255;
    property Shadow: boolean read FShadow write SetShadow default false;
  end;
  TChartGDIPBackground = class(TChartBackground)
  private
    FGradientType: TChartGradientType;
    FHatchStyle: THatchStyle;
    FAngle: integer;
    FPicture: TChartGDIPPicture;
    procedure SetGradientType(const Value: TChartGradientType);
    procedure SetHatchStyle(const Value: THatchStyle);
    procedure SetAngle(const Value: integer);
    procedure SetPicture(const Value: TChartGDIPPicture);
  protected
    procedure PictureChanged(Sender: TObject);
  public
    constructor Create(AOwner: TAdvChart); override;
    destructor Destroy; override;
    procedure Draw(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: double); override;
    procedure Assign(Source: TPersistent); override;
    //Settings
    procedure SaveToFile(ini: TMemIniFile;Section: String); override;
    procedure LoadFromFile(ini: TMemIniFile;Section: String); override;
  published
    property Angle: integer read FAngle write SetAngle default 0;
    property GradientType: TChartGradientType read FGradientType write SetGradientType default AdvChartGDIP.gtNone;
    property HatchStyle: THatchStyle read FHatchStyle write SetHatchStyle default HatchStyleHorizontal;
    property Picture: TChartGDIPPicture read FPicture write SetPicture;
  end;
  TAdvGDIPChart = class(TAdvChart)
  private
    FMirror: Boolean;
    FMirrorRect: TRect;
    procedure SetMirror(const Value: Boolean);
    function GetSeries: TAdvGDIPChartSeries;
    procedure SetSeries(const Value: TAdvGDIPChartSeries);
    function GetBackground: TChartGDIPBackground;
    procedure SetBackground(const Value: TChartGDIPBackground);
    function GetLegend: TChartGDIPLegend;
    procedure SetLegend(const Value: TChartGDIPLegend);
  protected
    property MirrorRect: TRect read FMirrorRect write FMirrorRect;
    function CreateLegend: TChartLegend; override;
    function CreateBackground: TChartBackground; override;
    function CreateSeries: TChartSeries; override;
    procedure FindInterSection(p1, p2, p3, p4: TPoint; var ptchk: TPointCheck); override;
  public
    procedure SaveToImage(Filename: String; ImageWidth, ImageHeight: integer; ImageType: TChartImageType = itBMP; ImageQualityPercentage: integer = 100);
    procedure SaveToStream(AStream: TMemoryStream; ImageWidth, ImageHeight: integer; ImageType: TChartImageType = itBMP; ImageQualityPercentage: integer = 100);
    function Draw(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double; Initialize: Boolean = false): TRect; override;
  published
    property Background: TChartGDIPBackground read GetBackground write SetBackground;
    property Legend: TChartGDIPLegend read GetLegend write SetLegend;
    property Mirror: Boolean read FMirror write SetMirror default False;
    property Series: TAdvGDIPChartSeries read GetSeries write SetSeries;
  end;
  TChartGDIPAnnotation = class(TChartAnnotation)
  private
    FOpacity: integer;
    FOpacityTo: integer;
    FGradientType: TChartGradientType;
    FHatchStyle: THatchStyle;
    FShadow: boolean;
    FAngle: integer;
    procedure SetOpacity(const Value: integer);
    procedure SetOpacityTo(const Value: integer);
    procedure SetGradientType(const Value: TChartGradientType);
    procedure SetHatchStyle(const Value: THatchStyle);
    procedure SetShadow(const Value: boolean);
    procedure SetAngle(const Value: integer);
  protected
  public
    constructor Create(Collection: TCollection); override;
    procedure Draw(Canvas: TCanvas; DR, TextR: TRect; xm,ym: integer; ScaleX, ScaleY: double); override;
    procedure Assign(Source : TPersistent); override;
    procedure DrawBalloonGP(g: TGPGraphics; b: TGPBrush; p: TGPPen; R: TGPRectF; ScaleX, ScaleY: Double);
  published
    property Angle: integer read FAngle write SetAngle default 0;
    property GradientType: TChartGradientType read FGradientType write SetGradientType default gtSolid;
    property HatchStyle: THatchStyle read FHatchStyle write SetHatchStyle default HatchStyleHorizontal;
    property Opacity: integer read FOpacity write SetOpacity;
    property OpacityTo: integer read FOpacityTo write SetOpacityTo;
    property Shadow: boolean read FShadow write SetShadow;
  end;
  TChartGDIPAnnotations = class(TChartAnnotations)
  private
    function GetItem(Index: Integer): TChartGDIPAnnotation;
    procedure SetItem(Index: Integer; const Value: TChartGDIPAnnotation);
  published
  public
    function GetItemClass: TCollectionItemClass; override;
    function Add:TChartGDIPAnnotation;
    function Insert(index:integer): TChartGDIPAnnotation;
    property Items[Index: Integer]: TChartGDIPAnnotation read GetItem write SetItem; default;
  end;
  TChartGDIPMarker = class(TChartMarker)
  private
    FMarkerPicture: TChartGDIPPicture;
    FMarkerColorTo: TColor;
    FGradientType: TChartGradientType;
    FOpacity: integer;
    FOpacityTo: integer;
    FSelectedColorTo: TColor;
    procedure SetMarkerPicture(const Value: TChartGDIPPicture);
    procedure SetMarkerColorTo(const Value: TColor);
    procedure SetGradientType(const Value: TChartGradientType);
    procedure SetOpacity(const Value: integer);
    procedure SetOpacityTo(const Value: integer);
    procedure SetSelectedColorTo(const Value: TColor);
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    //Settings
    procedure SaveToFile(ini: TMemIniFile;Section: String); override;
    procedure LoadFromFile(ini: TMemIniFile;Section: String); override;
  published
    property GradientType: TChartGradientType read FGradientType write SetGradientType default gtSolid;
    property MarkerPicture: TChartGDIPPicture read FMarkerPicture write SetMarkerPicture;
    property MarkerColorTo: TColor read FMarkerColorTo write SetMarkerColorTo default clNone;
    property SelectedColorTo: TColor read FSelectedColorTo write SetSelectedColorTo default clNone;
    property Opacity: integer read FOpacity write SetOpacity default 255;
    property OpacityTo: integer read FOpacityTo write SetOpacityTo default 255;
  end;
  TGDIPChartSeriePie = class(TChartSeriePie)
  private
    FLegendGradientType: TChartGradientType;
    FLegendOpacity: integer;
    FLegendOpacityTo: integer;
    FLegendHatchStyle: THatchStyle;
    FLegendGradientAngle: integer;
    FLegendTitleGradientAngle: integer;
    FLegendTitleOpacity: integer;
    FLegendTitleGradientType: TChartGradientType;
    FLegendTitleOpacityTo: integer;
    FLegendTitleHatchStyle: THatchStyle;
    procedure SetLegendGradientAngle(const Value: Integer);
    procedure SetLegendGradientType(const Value: TChartGradientType);
    procedure SetLegendHatchStyle(const Value: THatchStyle);
    procedure SetLegendOpacity(const Value: integer);
    procedure SetLegendOpacityTo(const Value: integer);
    procedure SetLegendTitleGradientAngle(const Value: integer);
    procedure SetLegendTitleGradientType(const Value: TChartGradientType);
    procedure SetLegendTitleHatchStyle(const Value: THatchStyle);
    procedure SetLegendTitleOpacity(const Value: integer);
    procedure SetLegendTitleOpacityTo(const Value: integer);
  public
    constructor Create(AOwner: TChartSerie); override;
    procedure Assign(Source: TPersistent); override;
    //Settings
    procedure SaveToFile(ini: TMemIniFile;Section: String); override;
    procedure LoadFromFile(ini: TMemIniFile;Section: String); override;
  published
    property LegendGradientType: TChartGradientType read FLegendGradientType write SetLegendGradientType default gtSolid;
    property LegendOpacity: integer read FLegendOpacity write SetLegendOpacity default 255;
    property LegendOpacityTo: integer read FLegendOpacityTo write SetLegendOpacityTo default 255;
    property LegendHatchStyle: THatchStyle read FLegendHatchStyle write SetLegendHatchStyle default HatchStyleHorizontal;
    property LegendGradientAngle: Integer read FLegendGradientAngle write SetLegendGradientAngle default 0;
    //new title
    property LegendTitleGradientType: TChartGradientType read FLegendTitleGradientType write SetLegendTitleGradientType default gtSolid;
    property LegendTitleOpacity: integer read FLegendTitleOpacity write SetLegendTitleOpacity default 255;
    property LegendTitleOpacityTo: integer read FLegendTitleOpacityTo write SetLegendTitleOpacityTo default 255;
    property LegendTitleHatchStyle: THatchStyle read FLegendTitleHatchStyle write SetLegendTitleHatchStyle default HatchStyleHorizontal;
    property LegendTitleGradientAngle: integer read FLegendTitleGradientAngle write SetLegendTitleGradientAngle default 0;
  end;
  TAdvGDIPChartSerie = class(TChartSerie)
  private
    FOpacity: integer;
    FOpacityTo: integer;
    FLineOpacity: integer;
    FGradientType: TChartGradientType;
    FHatchStyle: THatchStyle;
    FAngle: integer;
    FShadow: boolean;
    FChartPattern: TChartGDIPPicture;
    FDrawValuesSlice: TPointSliceArray;
    procedure SetOpacity(const Value: integer);
    procedure SetLineOpacity(const Value: integer);
    procedure SetGradientType(const Value: TChartGradientType);
    procedure SetOpacityTo(const Value: integer);
    procedure SetAngle(const Value: integer);
    procedure SetHatchStyle(const Value: THatchStyle);
    procedure SetShadow(const Value: boolean);
    function GetAnnotations: TChartGDIPAnnotations;
    procedure SetAnnotations(const Value: TChartGDIPAnnotations);
    procedure SetChartPattern(const Value: TChartGDIPPicture);
    function GetMarkerEx: TChartGDIPMarker;
    procedure SetMarkerEx(const Value: TChartGDIPMarker);
    function GetPie: TGDIPChartSeriePie;
    procedure SetPie(const Value: TGDIPChartSeriePie);
    function GetFunnel: TGDIPChartSeriePie;
  protected
    procedure Draw(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double); override;
    procedure DrawSelected(ACanvas: TCanvas; r: TRect); override;
    procedure DrawSelectedSlice(ACanvas: TCanvas; ptslice: TSlicePoint); override;
    procedure DrawSelectedFunnel(ACanvas: TCanvas; ptFunnel: TFunnelPoint); override;
    procedure FillCylinder(g: TGPGraphics; DR: TRect; SColor, SColorTo: TColor; Idx: integer; Val: Double; ScaleX, ScaleY: Double);
    procedure DrawBar(Canvas: TCanvas; SColor, SColorTo: TColor; dr: TRect; ScaleX, ScaleY: Double; Idx: integer; Val: Double); override;
    procedure DrawGanttBarRect(Canvas: TCanvas; pt: TChartPoint; dr: TRect); override;
    procedure FillPyramid(g: TGPGraphics; SColor, SColorTo: TColor; Dr: TRect; ScaleX, ScaleY: Double; Idx: Integer; val: Double);
    procedure Draw3DBar(canvas: TCanvas; SColor, SColorTo: TColor; dr: TRect; ScaleX, ScaleY: Double); override;
    procedure DrawMarker(Sender: TObject; Canvas: TCanvas; x, y, point: integer; value: TChartPoint); override;
    procedure DrawMarkers(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double); override;
    function DrawLegend(Canvas: TCanvas; R: Trect; ScaleX, ScaleY: Double; Draw: Boolean): TRect; override;
    procedure DrawPieLegend(Canvas: TCanvas; x, y, width, height: integer; Scalex, ScaleY: Double); override;
    procedure DrawPieSlice(Canvas: TCanvas; Center:  TPoint; Radius, RadiusInner, centerh, centerv, indent: integer; StartAngle, SweepAngle: Double; PointIndex: integer; ScaleX, ScaleY: Double); override;
    procedure DrawFunnelPart(Canvas: TCanvas; APoints: TPointArray; APointIndex: Integer; ScaleX, ScaleY: Double); override;
    procedure DrawSpiderArea(Canvas: TCanvas; R: TRect; SpiderArea: TPointArray; ScaleX, ScaleY: Double); override;
    procedure DrawPieValues(Canvas: TCanvas; indent: integer; Center: TPoint; radius, StartAngle, SweepAngle: Double; PointIndex: integer; ScaleX, ScaleY: Double); override;
    procedure DrawGridCircle(Canvas: TCanvas; YG: TChartYGrid; Center: TPoint; diff: integer; Major: Boolean); override;
    procedure DrawGridPieLine(Canvas: TCanvas; YG: TChartYGrid; Center: TPoint; x, y: integer); override;
    procedure Draw3DPolygons(g: TGPGraphics; dpcfrom, dpcto: integer; rct: TGPRectF; dp: TPointArray; pci: integer; s: TChartSerie;
      ScaleX, ScaleY: Double);
    function CreateAnnotations: TChartAnnotations; override;
    function CreatePie: TChartSeriePie; override;
    function CreateMarker: TChartMarker; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    //Settings
    procedure SaveToFile(ini: TMemIniFile;Section: String); override;
    procedure LoadFromFile(ini: TMemIniFile;Section: String); override;
    property Funnel: TGDIPChartSeriePie read GetFunnel;
  published
    property Angle: integer read FAngle write SetAngle default 0;
    property Annotations: TChartGDIPAnnotations read GetAnnotations write SetAnnotations;
    property ChartPattern: TChartGDIPPicture read FChartPattern write SetChartPattern;
    property Opacity: integer read FOpacity write SetOpacity default 255;
    property OpacityTo: integer read FOpacityTo write SetOpacityTo default 255;
    property GradientType: TChartGradientType read FGradientType write SetGradientType default gtSolid;
    property HatchStyle: THatchStyle read FHatchStyle write SetHatchStyle default HatchStyleHorizontal;
    property LineOpacity: integer read FLineOpacity write SetLineOpacity default 255;
    property Marker: TChartGDIPMarker read GetMarkerEx write SetMarkerEx;
    property Shadow: boolean read FShadow write SetShadow default false;
    property Pie: TGDIPChartSeriePie read GetPie write SetPie;
    property SerieType;
  end;
  TAdvGDIPChartSeries = class(TChartSeries)
  private
    function GetItem(Index: Integer): TAdvGDIPChartSerie;
    procedure SetItem(Index: Integer; const Value: TAdvGDIPChartSerie);
  protected
  public
    function GetItemClass: TCollectionItemClass; override;
    property Items[Index: Integer]: TAdvGDIPChartSerie read GetItem write SetItem; default;
    function Add: TAdvGDIPChartSerie;
  end;
  TAdvGDIPChartPane = class;
  TZoomControlSliderType = (stSquare, stArrow, stImage);
  TZoomControlPosition = (zpTopLeft,zpTopRight, zpTopCenter, zpBottomLeft, zpBottomRight, zpBottomCenter, zpCenterLeft, zpCenterCenter, zpCenterRight, zpCustom);
  TZoomControlRangeChanged = procedure(Sender: TObject; PaneIndex, RangeFrom, RangeTo: integer) of object;
  TZoomControlRangeChanging = procedure(Sender: TObject; PaneIndex, RangeFrom, RangeTo: integer) of object;
  TZoomControlAutoUpdate = (auImmediate, auRelease, auNoUpdate);
  
  TAdvGDIPZoomControl = class(TPersistent)
  private
    FOwner: TAdvGDIPChartPane;
    FInternalChart: TAdvGDIPChart;
    FOnChange: TNotifyEvent;
    FVisible: Boolean;
    FPosition: TZoomControlPosition;
    FWidth: integer;
    FHeight: integer;
    FTop: integer;
    FLeft: integer;
    FSlideRangeTo, FSlideRangeFrom: integer;
    FSelectionOpacity: Byte;
    FSliderOpacity: Byte;
    FSelectionColor: TColor;
    FSliderColor: TColor;
    FBorderColor: TColor;
    FBackGroundOpacity: Byte;
    FBackGroundColor: TColor;
    FBorderOpacity: Byte;
    FSlideAutoRange: Boolean;
    FSlideMaximumRange: integer;
    FSlideMinimumRange: integer;
    FAutoUpdate: TZoomControlAutoUpdate;
    FSliderLeftPicture: TChartGDIPPicture;
    FSliderRightPicture: TChartGDIPPicture;
    FSliderType: TZoomControlSliderType;
    FSliderSize: Integer;
    procedure SetVisible(const Value: Boolean);
    procedure SetPosition(const Value: TZoomControlPosition);
    procedure SetHeight(const Value: integer);
    procedure SetWidth(const Value: integer);
    procedure SetLeft(const Value: integer);
    procedure SetTop(const Value: integer);
    procedure SetSlideRangeFrom(const Value: integer);
    procedure SetSlideRangeTo(const Value: integer);
    procedure SetSelectionColor(const Value: TColor);
    procedure SetSelectionOpacity(const Value: Byte);
    procedure SetSliderColor(const Value: TColor);
    procedure SetSliderOpacity(const Value: Byte);
    procedure SetBackGroundColor(const Value: TColor);
    procedure SetBackGroundOpacity(const Value: Byte);
    procedure SetBorderColor(const Value: TColor);
    procedure SetBorderOpacity(const Value: Byte);
    procedure SetSlideAutoRange(const Value: Boolean);
    procedure SetSlideMaximumRange(const Value: integer);
    procedure SetSlideMinimumRange(const Value: integer);
    procedure SetAutoUpdate(const Value: TZoomControlAutoUpdate);
    procedure SetSliderLeftPicture(const Value: TChartGDIPPicture);
    procedure SetSliderRightPicture(const Value: TChartGDIPPicture);
    procedure SetSliderType(const Value: TZoomControlSliderType);
    procedure SetSliderSize(const Value: Integer);
  protected
    procedure Changed;
    procedure PictureChanged(Sender: TObject);
    function GetZoomRectangle(r: TRect): TRect;
    function GetSelectionRectangle(r: Trect): Trect;
    function GetSliderFromRectangle(r: TRect): TRect;
    function GetSliderToRectangle(r: TRect): TRect;
  public
    constructor Create(AOwner: TAdvGDIPChartPane); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Draw(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: double); virtual;
    procedure SaveToFile(ini: TMemIniFile;Section: String);
    procedure LoadFromFile(ini: TMemIniFile;Section: String);
    property Chart: TAdvGDIPChart read FInternalChart write FInternalChart;
  published
    property AutoUpdate: TZoomControlAutoUpdate read FAutoUpdate write SetAutoUpdate default auImmediate;
    property Visible: Boolean read FVisible write SetVisible default false;
    property Position: TZoomControlPosition read FPosition write SetPosition default zpBottomRight;
    property Left: integer read FLeft write SetLeft default 0;
    property Top: integer read FTop write SetTop default 0;
    property Width: integer read FWidth write SetWidth default 100;
    property Height: integer read FHeight write SetHeight default 50;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property SlideRangeFrom: integer read FSlideRangeFrom write SetSlideRangeFrom default 3;
    property SlideRangeTo: integer read FSlideRangeTo write SetSlideRangeTo default 7;
    property SlideAutoRange: Boolean read FSlideAutoRange write SetSlideAutoRange default true;
    property SlideMaximumRange: integer read FSlideMaximumRange write SetSlideMaximumRange default 10;
    property SlideMinimumRange: integer read FSlideMinimumRange write SetSlideMinimumRange default 0;
    property SelectionColor: TColor read FSelectionColor write SetSelectionColor default clWhite;
    property SelectionOpacity: Byte read FSelectionOpacity write SetSelectionOpacity default 100;
    property SliderColor: TColor read FSliderColor write SetSliderColor default clBlack;
    property SliderOpacity: Byte read FSliderOpacity write SetSliderOpacity default 255;
    property SliderLeftPicture: TChartGDIPPicture read FSliderLeftPicture write SetSliderLeftPicture;
    property SliderRightPicture: TChartGDIPPicture read FSliderRightPicture write SetSliderRightPicture;
    property SliderType: TZoomControlSliderType read FSliderType write SetSliderType default stArrow;
    property SliderSize: Integer read FSliderSize write SetSliderSize default 8;
    property Color: TColor read FBackGroundColor write SetBackGroundColor default clWhite;
    property Opacity: Byte read FBackGroundOpacity write SetBackGroundOpacity default 100;
    property BorderColor: TColor read FBorderColor write SetBorderColor default clDkGray;
    property BorderOpacity: Byte read FBorderOpacity write SetBorderOpacity default 255;
  end;
  TAdvGDIPChartPane = class(TChartPane)
  private
    FSXFrom, FSXTo, FSelX, FCx: integer;
    FSelection, FSlFrom, FSlTo, FMDzoom, FMouseMovedWhenDown: Boolean;
    FZoomControl: TAdvGDIPZoomControl;
    function GetSeries: TAdvGDIPChartSeries;
    procedure SetSeries(const Value: TAdvGDIPChartSeries);
    function GetLegend: TChartGDIPLegend;
    procedure SetLegend(const Value: TChartGDIPLegend);
    function GetBackground: TChartGDIPBackground;
    procedure SetBackground(const Value: TChartGDIPBackground);
    function GetChartGDPI: TAdvGDIPChart;
    procedure SetChartGDIP(const Value: TAdvGDIPChart);
    function GetMirror: Boolean;
    procedure SetMirror(const Value: Boolean);
    procedure SetZoomControl(const Value: TAdvGDIPZoomControl);
  protected
    function CreateChart: TAdvChart; override;
    procedure ZoomChanged(Sender: TObject);
    function MouseInZoomRectangle(X, Y: integer): Boolean;
    function MouseOnSlider(X, Y: integer): Boolean;
  public
    property Chart: TAdvGDIPChart read GetChartGDPI write SetChartGDIP;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    //Settings
    procedure SaveToFile(ini: TMemIniFile;Section: String); override;
    procedure LoadFromFile(ini: TMemIniFile;Section: String; AutoCreateSections: Boolean = False); override;
  published
    property Mirror: Boolean read GetMirror write SetMirror default false;
    property Background: TChartGDIPBackground read GetBackground write SetBackground;
    property Legend: TChartGDIPLegend read GetLegend write SetLegend;
    property Series: TAdvGDIPChartSeries read GetSeries write SetSeries;
    property ZoomControl: TAdvGDIPZoomControl read FZoomControl write SetZoomControl;
  end;
  TAdvGDIPChartPanes = class(TChartPanes)
  private
    function GetItem(Index: Integer): TAdvGDIPChartPane;
    procedure SetItem(Index: Integer; const Value: TAdvGDIPChartPane);
  protected
  public
    function GetItemClass: TCollectionItemClass; override;
    property Items[Index: Integer]: TAdvGDIPChartPane read GetItem write SetItem; default;
    function Add: TAdvGDIPChartPane;
  end;
  {$IFDEF DELPHIXE2_LVL}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  {$ENDIF}
  TAdvGDIPChartView = class(TAdvChartView)
  private
    FZoomControlUpdated: Boolean;
    FOnZoomcontrolRangeChanging: TZoomControlRangeChanging;
    FOnZoomcontrolRangeChanged: TZoomControlRangeChanged;
    function GetPanes: TAdvGDIPChartPanes;
    procedure SetPanes(const Value: TAdvGDIPChartPanes);
  protected
    function CreatePanes: TChartPanes; override;
    procedure PP(Pane: integer; Canvas: TCanvas; R: TRect; Print: Boolean); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
     procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    function XYtoPane(X, Y: integer): integer;
    function GetSliderMarginFromRectangle(Pane: TAdvGDIPChartPane): TRect;
    function GetSliderMarginToRectangle(Pane: TAdvGDIPChartPane): TRect;
  public
    procedure UpdateZoomControl;
    procedure Paint; override;
    procedure EndUpdate; override;
    procedure PrintPane(Pane: integer; Canvas: TCanvas; R: TRect); override;
    function GetPaneByID(id: integer): TAdvGDIPChartPane;
    function GetPaneByName(name: string): TAdvGDIPChartPane;
    function GetSerieByName(name: string): TAdvGDIPChartSerie;
    property PaneByName[name: string]: TAdvGDIPChartPane read GetPaneByName;
    property SerieByName[name: string]: TAdvGDIPChartSerie read GetSerieByName;
    procedure SaveToImage(Filename: String; ImageWidth, ImageHeight: integer; ImageType: TChartImageType = itBMP; ImageQualityPercentage: integer = 100);
    property PaneByID[id: integer]: TAdvGDIPChartPane read GetPaneByID;
    function GetPaneClass: TChartPaneClass; override;
    function GetPanesClass: TChartPanesClass; override;
    function GetSeriesClass: TChartSeriesClass; override;
    function GetSerieClass: TChartSerieClass; override;
  published
    property Panes: TAdvGDIPChartPanes read GetPanes write SetPanes;
    property OnZoomControlRangeChanged: TZoomControlRangeChanged read FOnZoomcontrolRangeChanged write FOnZoomcontrolRangeChanged;
    property OnZoomControlRangeChanging: TZoomControlRangeChanging read FOnZoomcontrolRangeChanging write FOnZoomcontrolRangeChanging;
  end;
implementation
{$IFNDEF DELPHI6_LVL}
const
  Nan = -361.0;
function IsNan(d: double): boolean;
begin
  Result := (d = Nan);
end;
{$ENDIF}
type
  EColorError = class(Exception);
  THSVTriplet = record
    H,S,V: double;
  end;
  TRGBTriplet = record
    R,G,B: double;
  end;

function MakeFont(AFont: TFont): TGPFont;
var
  fontFamily: TGPFontFamily;
  fs: Integer;
begin
  fontFamily := TGPFontFamily.Create(AFont.Name);

  if (fontFamily.Status in [FontFamilyNotFound, FontStyleNotFound]) then
  begin
    fontFamily.Free;
    fontFamily := TGPFontFamily.Create('Arial');
  end;

  fs := 0;
  if (fsBold in AFont.Style) then
    fs := fs + 1;
  if (fsItalic in AFont.Style) then
    fs := fs + 2;
  if (fsUnderline in AFont.Style) then
    fs := fs + 4;

  Result := TGPFont.Create(fontFamily, AFont.Size , fs, UnitPoint);

  fontFamily.Free;
end;
procedure RGBToHSV (const R,G,B: Double; var H,S,V: Double); var
  Delta: double;
  Min : double;
begin
  Min := MinValue( [R, G, B] );    
  V := MaxValue( [R, G, B] );
  Delta := V - Min;
  // Calculate saturation: saturation is 0 if r, g and b are all 0
  if V = 0.0 then
    S := 0
  else
    S := Delta / V;
  if (S = 0.0) then
    H := NaN    // Achromatic: When s = 0, h is undefined
  else
  begin       // Chromatic
    if (R = V) then
    // between yellow and magenta [degrees]
      H := 60.0 * (G - B) / Delta
    else
      if (G = V) then
       // between cyan and yellow
        H := 120.0 + 60.0 * (B - R) / Delta
      else
        if (B = V) then
        // between magenta and cyan
          H := 240.0 + 60.0 * (R - G) / Delta;
    if (H < 0.0) then
      H := H + 360.0
  end;
end; {RGBtoHSV}

procedure HSVtoRGB (const H,S,V: double; var R,G,B: double); var
  f : double;
  i : INTEGER;
  hTemp: double; // since H is CONST parameter
  p,q,t: double;
begin
  if (S = 0.0) then    // color is on black-and-white center line
  begin
    if IsNaN(H) then
    begin
      R := V;           // achromatic: shades of gray
      G := V;
      B := V
    end
    else
      raise EColorError.Create('HSVtoRGB: S = 0 and H has a value');
  end
  else
  begin // chromatic color
    if (H = 360.0) then         // 360 degrees same as 0 degrees
      hTemp := 0.0
    else
      hTemp := H;
    hTemp := hTemp / 60;     // h is now IN [0,6)
    i := TRUNC(hTemp);        // largest integer <= h
    f := hTemp - i;                  // fractional part of h
    p := V * (1.0 - S);
    q := V * (1.0 - (S * f));
    t := V * (1.0 - (S * (1.0 - f)));
    case i of
      0: begin R := V; G := t;  B := p  end;
      1: begin R := q; G := V; B := p  end;
      2: begin R := p; G := V; B := t   end;
      3: begin R := p; G := q; B := V  end;
      4: begin R := t;  G := p; B := V  end;
      5: begin R := V; G := p; B := q  end;
    end;
  end;
end; {HSVtoRGB}
procedure GetZoomControlPosition(var x, y: integer; rectangle: TRect; objectwidth, objectheight: integer; position: TZoomControlPosition);
var
  w, h, tw, th: integer;
begin
  tw := objectwidth;
  th := objectheight;
  w := Round(rectangle.Right - rectangle.Left);
  h := Round(rectangle.Bottom - rectangle.Top);
  case position of
    zpTopLeft:
    begin
      x := 0;
      y := 0;
    end;
    zpTopRight:
    begin
      x := w - tw;
      y := 0;
    end;
    zpBottomLeft:
    begin
      x := 0;
      y := h - th;
    end;
    zpBottomRight:
    begin
      x := w - tw;
      y := h - th;
    end;
    zpTopCenter:
    begin
      x := (w - tw) div 2;
      y := 0;
    end;
    zpBottomCenter:
    begin
      x := (w - tw) div 2;
      y := h - th;
    end;
    zpCenterCenter:
    begin
      x := (w - tw) div 2;
      y := (h - th) div 2;
    end;
    zpCenterLeft:
    begin
      x := 0;
      y := (h - th) div 2;
    end;
    zpCenterRight:
    begin
      x := w - tw;
      y := (h - th) div 2;
    end;
    zpCustom:
    begin
      x := rectangle.Left;
      y := rectangle.Top;
    end;
  end;
end;

function Limit(a: integer; min,max: integer): integer;
begin
  if a < min then
    a := min;
  if a > max then
    a := max;
  Result := a;
end;
procedure GetPathBalloon(bd:TAnnotationBalloonDirection; ba, l, t, w, h, d, radius: Double; RoundingType: TChartRoundingType; var path: TGPGraphicsPath);
begin
  case RoundingType of
    rtNone:
    begin
      path.AddLine(l, t, l + w, t); // top
      path.AddLine(l + w, t, l + w, t + h); // right
      path.AddLine(l + w, t + h, l, t + h); // bottom
      path.AddLine(l, t + h, l, t); // left
    end;
    rtRight:
    begin
      path.AddLine(l, t, l + w - radius, t); // top
      path.AddArc(l + w - d, t, d, d, 270, 90); // topright
      path.AddLine(l + w, t + radius, l + w, t + h - radius); // right
      path.AddArc(l + w - d, t + h - d, d, d, 0, 90); // bottomright
      path.AddLine(l + w, t + h, l, t + h); // bottom
      path.AddLine(l, t + h - radius, l, t + radius); // left
    end;
    rtLeft:
    begin
      path.AddArc(l, t, d, d, 180, 90); // topleft
      path.AddLine(l + radius, t, l + w - radius, t); // top
      path.AddLine(l + w, t, l + w, t + h); // right
      path.AddLine(l + w - radius, t + h, l + radius, t + h); // bottom
      path.AddArc(l, t + h - d, d, d, 90, 90); // bottomleft
      path.AddLine(l, t + h - radius, l, t + radius); // left
    end;
    rtTop:
    begin
      path.AddArc(l, t, d, d, 180, 90); // topleft
      path.AddLine(l + radius, t, l + w - radius, t); // top
      path.AddArc(l + w - d, t, d, d, 270, 90); // topright
      path.AddLine(l + w, t + radius, l + w, t + h); // right
      path.AddLine(l + w, t + h, l, t + h); // bottom
      path.AddLine(l, t + h, l, t + Radius); // left
    end;
    rtBottom:
    begin
      path.AddLine(l, t, l + w, t); // top
      path.AddLine(l + w, t, l + w, t + h - radius); // right
      path.AddArc(l + w - d, t + h - d, d, d, 0, 90); // bottomright
      path.AddLine(l + w - radius, t + h, l + radius, t + h); // bottom
      path.AddArc(l, t + h - d, d, d, 90, 90); // bottomleft
      path.AddLine(l, t + h - Radius, l, t ); // left
    end;
    rtBoth:
    begin
      case bd of
        hdUpRight:
        begin
          path.AddArc(l, t, d, d, 180, 90); // topleft
          path.AddLine(l + radius, t, l + w - radius - 10 - ba, t); // top
          path.AddLine(MakePoint(l + w - radius - 10 - ba, t), MakePoint(l + w - radius - 10, t - ba));
          path.AddLine(MakePoint(l + w - radius - 10, t - ba), MakePoint(l + w - radius - 10, t));
          path.AddArc(l + w - d, t, d, d, 270, 90); // topright
          path.AddLine(l + w, t + radius, l + w, t + h - radius); // right
          path.AddArc(l + w - d, t + h - d, d, d, 0, 90); // bottomright
          path.AddLine(l + w - radius, t + h, l + radius, t + h); // bottom
          path.AddArc(l, t + h - d, d, d, 90, 90); // bottomleft
          path.AddLine(l, t + h - radius, l, t + radius); // left
        end;
        hdUpLeft:
        begin
          path.AddArc(l, t, d, d, 180, 90); // topleft
          path.AddLine(MakePoint(l + radius + 10, t), MakePoint(l + radius + 10, t - ba));
          path.AddLine(MakePoint(l + radius + 10, t - ba), MakePoint(l + radius + 10 + ba, t));
          path.AddLine(l + radius + 10, t, l + w - radius - 10, t); // top
          path.AddArc(l + w - d, t, d, d, 270, 90); // topright
          path.AddLine(l + w, t + radius, l + w, t + h - radius); // right
          path.AddArc(l + w - d, t + h - d, d, d, 0, 90); // bottomright
          path.AddLine(l + w - radius, t + h, l + radius, t + h); // bottom
          path.AddArc(l, t + h - d, d, d, 90, 90); // bottomleft
          path.AddLine(l, t + h - radius, l, t + radius); // left
        end;
        hdDownRight:
        begin
          path.AddArc(l, t, d, d, 180, 90); // topleft
          path.AddLine(l + radius + 10, t, l + w - radius - 10, t); // top
          path.AddArc(l + w - d, t, d, d, 270, 90); // topright
          path.AddLine(l + w, t + radius, l + w, t + h - radius); // right
          path.AddArc(l + w - d, t + h - d, d, d, 0, 90); // bottomright
          path.AddLine(MakePoint(l + w - radius - 10, t + h), MakePoint(l + w - radius - 10, t + h + ba));
          path.AddLine(MakePoint(l + w - radius - 10, t + h + ba), MakePoint(l + w - radius - 10 - ba, t + h));
          path.AddLine(l + w - radius, t + h, l + radius, t + h); // bottom
          path.AddArc(l, t + h - d, d, d, 90, 90); // bottomleft
          path.AddLine(l, t + h - radius, l, t + radius); // left
        end;
        hdDownLeft:
        begin
          path.AddArc(l, t, d, d, 180, 90); // topleft
          path.AddLine(l + radius + 10, t, l + w - radius - 10, t); // top
          path.AddArc(l + w - d, t, d, d, 270, 90); // topright
          path.AddLine(l + w, t + radius, l + w, t + h - radius); // right
          path.AddArc(l + w - d, t + h - d, d, d, 0, 90); // bottomright
          path.AddLine(l + w - radius, t + h, l + radius + 10, t + h); // bottom
          path.AddLine(MakePoint(l + radius + 10, t + h), MakePoint(l + radius + 10, t + h + ba));
          path.AddLine(MakePoint(l + radius + 10, t + h + ba), MakePoint(l + radius + 10 + ba, t + h));
          path.AddArc(l, t + h - d, d, d, 90, 90); // bottomleft
          path.AddLine(l, t + h - radius, l, t + radius); // left
        end;
      end;
    end;
  end;
end;
procedure GetPath(l, t, w, h, d, radius: Double; RoundingType: TChartRoundingType; var path: TGPGraphicsPath);
begin
  case RoundingType of
    rtNone:
    begin
      path.AddLine(l, t, l + w, t); // top
      path.AddLine(l + w, t, l + w, t + h); // right
      path.AddLine(l + w, t + h, l, t + h); // bottom
      path.AddLine(l, t + h, l, t); // left
    end;
    rtRight:
    begin
      path.AddLine(l, t, l + w - radius, t); // top
      path.AddArc(l + w - d, t, d, d, 270, 90); // topright
      path.AddLine(l + w, t + radius, l + w, t + h - radius); // right
      path.AddArc(l + w - d, t + h - d, d, d, 0, 90); // bottomright
      path.AddLine(l + w, t + h, l, t + h); // bottom
      path.AddLine(l, t + h - radius, l, t + radius); // left
    end;
    rtLeft:
    begin
      path.AddArc(l, t, d, d, 180, 90); // topleft
      path.AddLine(l + radius, t, l + w - radius, t); // top
      path.AddLine(l + w, t, l + w, t + h); // right
      path.AddLine(l + w - radius, t + h, l + radius, t + h); // bottom
      path.AddArc(l, t + h - d, d, d, 90, 90); // bottomleft
      path.AddLine(l, t + h - radius, l, t + radius); // left
    end;
    rtTop:
    begin
      path.AddArc(l, t, d, d, 180, 90); // topleft
      path.AddLine(l + radius, t, l + w - radius, t); // top
      path.AddArc(l + w - d, t, d, d, 270, 90); // topright
      path.AddLine(l + w, t + radius, l + w, t + h); // right
      path.AddLine(l + w, t + h, l, t + h); // bottom
      path.AddLine(l, t + h, l, t + Radius); // left
    end;
    rtBottom:
    begin
      path.AddLine(l, t, l + w, t); // top
      path.AddLine(l + w, t, l + w, t + h - radius); // right
      path.AddArc(l + w - d, t + h - d, d, d, 0, 90); // bottomright
      path.AddLine(l + w - radius, t + h, l + radius, t + h); // bottom
      path.AddArc(l, t + h - d, d, d, 90, 90); // bottomleft
      path.AddLine(l, t + h - Radius, l, t ); // left
    end;
    rtBoth:
    begin
      path.AddArc(l, t, d, d, 180, 90); // topleft
      path.AddLine(l + radius, t, l + w - radius, t); // top
      path.AddArc(l + w - d, t, d, d, 270, 90); // topright
      path.AddLine(l + w, t + radius, l + w, t + h - radius); // right
      path.AddArc(l + w - d, t + h - d, d, d, 0, 90); // bottomright
      path.AddLine(l + w - radius, t + h, l + radius, t + h); // bottom
      path.AddArc(l, t + h - d, d, d, 90, 90); // bottomleft
      path.AddLine(l, t + h - radius, l, t + radius); // left
    end;
  end;
end;

function CreateRoundRectangle(R: TGPRectF; Radius: Integer; RoundingType: TChartRoundingType; Mirror: Boolean): TGPGraphicsPath; overload;
var
  l, t, w, h, d: Double;
begin
  Result := TGPGraphicsPath.Create;
  l := R.X;
  t := R.Y;
  w := R.Width;
  h := R.Height;
  d := Radius shl 1;
  GetPath(l, t, w, h, d, radius, RoundingType, Result);
  Result.CloseFigure();
end;

function CreateBalloonRectangle(R: TGPRectF; BalloonDirection: TAnnotationBalloonDirection; BalloonArrowSize: Integer; Radius: Integer; RoundingType: TChartRoundingType; Mirror: Boolean): TGPGraphicsPath; overload;
var
  l, t, w, h, d, ba: Double;
begin
  Result := TGPGraphicsPath.Create;
  l := R.X;
  t := R.Y;
  w := R.Width;
  h := R.Height;
  d := Radius shl 1;
  ba := BalloonArrowSize;
  GetPathBalloon(BalloonDirection, ba, l, t, w, h, d, radius, RoundingType, Result);
  Result.CloseFigure();
end;

{ TAdvGDIPChartView }
function TAdvGDIPChartView.CreatePanes: TChartPanes;
begin
  Result := TAdvGDIPChartPanes.Create(Self);
end;
function CreateStream(bmp: Graphics.TBitmap): IStream;
var
  pcbWrite: Longint;
  hGlobal: THandle;
  ms: TMemoryStream;
  pstm: IStream;
begin
  ms := TMemoryStream.Create;
  bmp.SaveToStream(ms);
  hGlobal := GlobalAlloc(GMEM_MOVEABLE, ms.Size);
  if (hGlobal = 0) then
  begin
    ms.Free;
    raise Exception.Create('Could not allocate memory for image');
  end;
  try
    pstm := nil;
    // Create IStream* from global memory
    CreateStreamOnHGlobal(hGlobal, TRUE, pstm);
    pstm.Write(ms.Memory, ms.Size,@pcbWrite);
  finally
    ms.Free;
  end;
  
  Result := pstm;
end;
procedure TAdvGDIPChartView.EndUpdate;
begin
  inherited;
  UpdateZoomControl;
end;
function TAdvGDIPChartView.GetPaneByID(id: integer): TAdvGDIPChartPane;
begin
  Result := TAdvGDIPChartPane(Panes.FindItemID(id));
end;
function TAdvGDIPChartView.GetPaneByName(name: string): TAdvGDIPChartPane;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Panes.Count - 1 do
  begin
    if Panes[I].Name = name then
    begin
      Result := Panes[I];
      exit;
    end;
  end;
end;
function TAdvGDIPChartView.GetPaneClass: TChartPaneClass;
begin
  Result := TAdvGDIPChartPane;
end;
function TAdvGDIPChartView.GetPanes: TAdvGDIPChartPanes;
begin
  Result := TAdvGDIPChartPanes(inherited Panes);
end;
function TAdvGDIPChartView.GetPanesClass: TChartPanesClass;
begin
  Result := TAdvGDIPChartPanes;
end;
function TAdvGDIPChartView.GetSerieByName(name: string): TAdvGDIPChartSerie;
var
  I: Integer;
  K: integer;
begin
  result := nil;
  for I := 0 to Panes.Count - 1 do
  begin
    for K := 0 to Panes[I].Series.Count - 1 do
    begin
      if Panes[I].Series[K].Name = name then
      begin
        Result := Panes[I].Series[K];
        exit;
      end;
    end;
  end;
end;
function TAdvGDIPChartView.GetSerieClass: TChartSerieClass;
begin
  Result := TAdvGDIPChartSerie;
end;
function TAdvGDIPChartView.GetSeriesClass: TChartSeriesClass;
begin
  Result := TAdvGDIPChartSeries;
end;
function TAdvGDIPChartView.GetSliderMarginFromRectangle(Pane: TAdvGDIPChartPane): TRect;
begin
  with Pane do
    Result := ZoomControl.GetSliderFromRectangle(ZoomControl.GetZoomRectangle(series.SeriesRectangle));
  Result.Left := Result.Left - 5;
  Result.Right := Result.Right + 5;
end;
function TAdvGDIPChartView.GetSliderMarginToRectangle(
  Pane: TAdvGDIPChartPane): TRect;
begin
  with Pane do
    Result := ZoomControl.GetSliderToRectangle(ZoomControl.GetZoomRectangle(series.SeriesRectangle));
  Result.Left := Result.Left - 5;
  Result.Right := Result.Right + 5;
end;
procedure TAdvGDIPChartView.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  pn: integer;
begin
  inherited;
  //todo code for zoomcontrol
  pn := XYtoPane(x, y);
  if pn <> -1 then
  begin
    with Panes[pn] do
    begin
      FMDzoom := MouseInZoomRectangle(X, Y);
      FCx := X;
    end;
  end;
end;
procedure TAdvGDIPChartView.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  pn, slfr, slto: integer;
  r: TRect;
  I: integer;
begin
  inherited;
  //todo code for zoomcontrol
  pn := XYtoPane(x, y);
  if pn <> -1 then
  begin
    with Panes[pn] do
    begin
      if ZoomControl.Visible then
      begin
        if not FMDzoom then
        begin
          FslFrom := false;
          FSlTo := false;
          FSelection := false;
          FMouseMovedWhenDown := false;
          if MouseOnSlider(X, Y) then
          begin
            SetScreenCursor(crSizeWE);
            FSlFrom := PtInRect(GetSliderMarginFromRectangle(Panes[pn]), Point(X, Y));
            FSlTo := PtInRect(GetSliderMarginToRectangle(Panes[pn]), Point(X, Y));
          end
          else if PtInRect(ZoomControl.GetSelectionRectangle(ZoomControl.GetZoomRectangle(series.SeriesRectangle)), Point(X, Y)) then
          begin
            SetScreenCursor(crHandPoint);
            FSelection := true;
          end
          else
            SetScreenCursor(crDefault);
        end
        else
        begin
          FMouseMovedWhenDown := true;
          r := ZoomControl.GetZoomRectangle(Series.SeriesRectangle);
          if FSlFrom then
            FSXFrom := X
          else if FSlTo then
            FSXTo := X
          else if FSelection then
          begin
            FselX := X - FCx;
            FSXFrom := ZoomControl.GetSliderFromRectangle(ZoomControl.GetZoomRectangle(Series.SeriesRectangle)).Left;
            FSXTo := ZoomControl.GetSliderToRectangle(ZoomControl.GetZoomRectangle(Series.SeriesRectangle)).Left;
          end;
          if FSlFrom then
          begin
            slfr := Max(0, Min(round((FSXFrom - ZoomControl.GetZoomRectangle(Series.SeriesRectangle).Left - (ZoomControl.Chart.GetXScaleStart)) / ZoomControl.Chart.XScale), ZoomControl.Chart.Range.MaxRangeTo));
            if ZoomControl.AutoUpdate = auImmediate then
            begin
              Self.BeginUpdate;
              for I := 0 to Panes.Count - 1 do
              begin
                Panes[I].Range.RangeFrom := slfr;
                Panes[I].Range.RangeTo := ZoomControl.SlideRangeTo;
              end;
              Self.EndUpdate;
            end;
            if Assigned(FOnZoomcontrolRangeChanging) then
              FOnZoomcontrolRangeChanging(self, pn, slfr, ZoomControl.SlideRangeTo);
          end
          else if FSlTo then
          begin
            slto := Max(0, Min(round((FSXTo - ZoomControl.GetZoomRectangle(Series.SeriesRectangle).Left - (ZoomControl.Chart.GetXScaleStart)) / ZoomControl.Chart.XScale), ZoomControl.Chart.Range.MaxRangeTo));
            if ZoomControl.AutoUpdate = auImmediate then
            begin
              Self.BeginUpdate;
              for I := 0 to Panes.Count - 1 do
              begin
                Panes[I].Range.RangeFrom := ZoomControl.SlideRangeFrom;
                Panes[I].Range.RangeTo := slto;
              end;
              Self.EndUpdate;
            end;
            if Assigned(FOnZoomcontrolRangeChanging) then
              FOnZoomcontrolRangeChanging(self, pn, ZoomControl.SlideRangeFrom, slto);
          end
          else if FSelection then
          begin
            slfr := Max(0, Min(round((FSXFrom - ZoomControl.GetZoomRectangle(Series.SeriesRectangle).Left - (ZoomControl.Chart.GetXScaleStart)) / ZoomControl.Chart.XScale), ZoomControl.Chart.Range.MaxRangeTo));
            slto := Max(0, Min(round((FSXTo - ZoomControl.GetZoomRectangle(Series.SeriesRectangle).Left - (ZoomControl.Chart.GetXScaleStart)) / ZoomControl.Chart.XScale), ZoomControl.Chart.Range.MaxRangeTo));
            if ZoomControl.AutoUpdate = auImmediate then
            begin
              Self.BeginUpdate;
              for I := 0 to Panes.Count - 1 do
              begin
                Panes[I].Range.RangeFrom := slfr;
                Panes[I].Range.RangeTo := slto;
              end;
              Self.EndUpdate;
            end;
            if Assigned(FOnZoomcontrolRangeChanging) then
              FOnZoomcontrolRangeChanging(self, pn, slfr, slto);
          end;
          invalidate;
        end;
      end;
    end;
  end;
end;
procedure TAdvGDIPChartView.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  pn, i: integer;
begin
  inherited;
  pn := XYtoPane(x, y);
  if pn <> -1 then
  begin
    with Panes[pn] do
    begin
      FMDzoom := false;
      FSelX := 0;
      if FMouseMovedWhenDown then
      begin
        if not FSelection then
        begin
          if FSlFrom then
            ZoomControl.SlideRangeFrom := round((FSXFrom - ZoomControl.GetZoomRectangle(Series.SeriesRectangle).Left - (ZoomControl.Chart.GetXScaleStart)) / ZoomControl.Chart.XScale)
          else if FSlTo then
            ZoomControl.SlideRangeTo := round((FSXTo - ZoomControl.GetZoomRectangle(Series.SeriesRectangle).Left - (ZoomControl.Chart.GetXScaleStart)) / ZoomControl.Chart.XScale);
          if FslFrom or FSlTo then
          begin
            if ZoomControl.AutoUpdate = auRelease then
            begin
              Self.BeginUpdate;
              for I := 0 to Panes.Count - 1 do
              begin
                Panes[I].Range.RangeFrom := ZoomControl.SlideRangeFrom;
                Panes[I].Range.RangeTo := Zoomcontrol.SlideRangeTo;
              end;
              Self.EndUpdate;
            end;
            if Assigned(FOnZoomcontrolRangeChanged) then
              FOnZoomcontrolRangeChanged(self, pn, ZoomControl.SlideRangeFrom, Zoomcontrol.SlideRangeTo);
          end;
        end
        else
        begin
          FSelection := false;
          ZoomControl.SlideRangeFrom := round((FSXFrom - ZoomControl.GetZoomRectangle(Series.SeriesRectangle).Left - (ZoomControl.Chart.GetXScaleStart)) / ZoomControl.Chart.XScale);
          ZoomControl.SlideRangeTo := round((FSXTo - ZoomControl.GetZoomRectangle(Series.SeriesRectangle).Left - (ZoomControl.Chart.GetXScaleStart)) / ZoomControl.Chart.XScale);
          if ZoomControl.AutoUpdate = auRelease then
          begin
            Self.BeginUpdate;
            for I := 0 to Panes.Count - 1 do
            begin
              Panes[I].Range.RangeFrom := ZoomControl.SlideRangeFrom;
              Panes[I].Range.RangeTo := Zoomcontrol.SlideRangeTo;
            end;
            Self.EndUpdate;
          end;
          if Assigned(FOnZoomcontrolRangeChanged) then
            FOnZoomcontrolRangeChanged(self, pn, ZoomControl.SlideRangeFrom, Zoomcontrol.SlideRangeTo);
        end;
        FSlFrom := false;
        FSlTo := false;
        FMouseMovedWhenDown := false;
        invalidate;
      end;
    end;
  end;
end;
procedure PrintBitmap(Canvas: TCanvas; DestRect: TRect; Bitmap: Graphics.TBitmap);
var
  BitmapHeader: pBitmapInfo;
  BitmapImage: Pointer;
  HeaderSize: DWORD;
  ImageSize: DWORD;
begin
  GetDIBSizes(Bitmap.Handle, HeaderSize, ImageSize);
  GetMem(BitmapHeader, HeaderSize);
  GetMem(BitmapImage, ImageSize);
  try
    GetDIB(Bitmap.Handle, Bitmap.Palette, BitmapHeader^, BitmapImage^);
    StretchDIBits(Canvas.Handle,
      DestRect.Left, DestRect.Top,    // Destination Origin
      DestRect.Right - DestRect.Left, // Destination Width
      DestRect.Bottom - DestRect.Top, // Destination Height
      0, 0,                           // Source Origin
      Bitmap.Width, Bitmap.Height,    // Source Width & Height
      BitmapImage,
      TBitmapInfo(BitmapHeader^),
      DIB_RGB_COLORS,
      SRCCOPY)
  finally
    FreeMem(BitmapHeader);
    FreeMem(BitmapImage)
  end
end {PrintBitmap};
procedure TAdvGDIPChartView.Paint;
var
  i: integer;
begin
  inherited;
  //First time update zoomcontrol to initialize all values
  if not FZoomControlUpdated then
  begin
    UpdateZoomControl;
    FZoomControlUpdated := true;
  end;
  
  //Draw zoom controls
  for I := 0 to Panes.Count - 1 do
    with Panes[I] do
      if ZoomControl.Visible then
        ZoomControl.Draw(Canvas, ZoomControl.GetZoomRectangle(Series.SeriesRectangle), 1, 1);
end;
procedure TAdvGDIPChartView.PP(Pane: integer; Canvas: TCanvas; R: TRect;
  Print: Boolean);
var
  ABmp: Graphics.TBitmap;
  aR: TRect;
  w, h: integer;
  nLogPixelsX_output, nLogPixelsY_output, nLogPixelsX_screen, nLogPixelsY_screen: integer;
  scalex, scaley: Double;
begin
  if Print then
  begin
    ABmp := Graphics.TBitmap.Create;
    w := R.Right - R.Left;
    h := R.Bottom - R.Top;
    ABmp.Width := w;
    ABmp.Height := h;
    aR := Bounds(R.Left, R.Top, ABmp.Width, ABmp.Height);
    Panes[Pane].Chart.InitializeChart(ABmp.Canvas, Bounds(0, 0, ABmp.Width, ABmp.Height), 1, 1);
    Panes[Pane].Draw(ABmp.Canvas, Bounds(0, 0, ABmp.Width, ABmp.Height), 1, 1);
    Panes[Pane].Chart.InitializeChart(Self.Canvas, Panes[Pane].GetPaneRectangle, 1, 1);
    Canvas.StretchDraw(R, ABmp);
    ABmp.Free;
  end
  else
  begin
    nLogPixelsX_output := GetDeviceCaps(Canvas.Handle,LOGPIXELSX);
    nLogPixelsY_output := GetDeviceCaps(Canvas.Handle,LOGPIXELSY);
    nLogPixelsX_screen := GetDeviceCaps(self.Canvas.Handle,LOGPIXELSX);
    nLogPixelsY_screen := GetDeviceCaps(self.Canvas.Handle,LOGPIXELSY);
    scalex := nLogPixelsX_output / nLogPixelsX_screen;
    scaley := nLogPixelsY_output / nLogPixelsY_screen;
    Panes[Pane].Chart.InitializeChart(Canvas, R, Scalex, ScaleY);
    Panes[Pane].Draw(Canvas, R, ScaleX, ScaleY);
    Panes[Pane].Chart.InitializeChart(Self.Canvas, Panes[Pane].GetPaneRectangle, 1, 1);  
  end;
end;
procedure TAdvGDIPChartView.PrintPane(Pane: integer; Canvas: TCanvas; R: TRect);
begin
  PP(Pane, Canvas, R, false);
end;
function GetCLSID(ImageType: TChartImageType): TCLSID;
var
  I: integer;
  num, numi, size: Cardinal;
  clsId: TCLSID;
  pinfo: PImageCodecInfo;
  infoarr: array[0..100] of TImageCodecInfo;
  str: String;
begin
  GdipGetImageEncodersSize(num, size);
  pinfo := AllocMem(size);
  numi := num;
  GdipGetImageEncoders(num, size, pinfo);
  move(pinfo^, infoarr[0], size);
  case ImageType of
    itPNG: str := 'image/png';
    itBMP: str := 'image/bmp';
    itJPEG: str := 'image/jpeg';
    itTIFF: str := 'image/tiff';
    itGIF: str := 'image/gif';
  end;
  for I := 0 to numi - 1 do
  begin
    if infoarr[i].MimeType = str then
    begin
      clsid := infoarr[i].Clsid;
      break;
    end;
  end;
  FreeMem(pinfo);
  Result := clsid;
end;
function GetEncoderQualityParameters(ImageQualityPercentage: integer): TEncoderParameters;
var
  encoderParameters: TEncoderParameters;
  value: integer;
begin
  if ImageQualityPercentage < 0 then
    ImageQualityPercentage := 0;
  if ImageQualityPercentage > 100 then
    ImageQualityPercentage := 100;
  value := ImageQualityPercentage;
  encoderParameters.Count := 1;
  encoderParameters.Parameter[0].NumberOfValues := 1;  
  encoderParameters.Parameter[0].Guid := EncoderQuality;
  encoderParameters.Parameter[0].Type_ := EncoderParameterValueTypeLong;
  encoderParameters.Parameter[0].Value := @value;
  result := encoderParameters;
end;
procedure TAdvGDIPChartView.SaveToImage(Filename: String; ImageWidth, ImageHeight: integer; ImageType: TChartImageType = itBMP; ImageQualityPercentage: integer = 100);
var
  img, finalimg: graphics.TBitmap;
  gpimg: TGPImage;
  I, th, P: Integer;
  r: TRect;
  g: TGPGraphics;
  enc: TEncoderParameters;
begin
  img := nil;
  gpimg := nil;
  g := nil;
  finalimg := nil;
  try
    img := graphics.TBitmap.Create;
    img.Width := Width;
    img.Height := Height;
    for I := 0 to Panes.Count - 1 do
    begin
      th := 0;
      for P := 0 to I - 1 do
      begin
        if Panes[P].Visible then
          th := th + Round(Panes[P].PixelHeight * (img.Height / self.Height));
      end;
      if Panes[I].Visible then
      begin
        r := Bounds(Panes[I].Rectangle.Left, th, Width, Round(Panes[I].PixelHeight * (Height / self.Height)));
        PrintPane(I, img.Canvas, r);
      end;
    end;
    finalimg := graphics.TBitmap.Create;
    finalimg.Width := ImageWidth;
    finalimg.Height := ImageHeight;
    finalimg.Canvas.StretchDraw(Bounds(0, 0, ImageWidth, ImageHeight), img);
    gpimg := TGPImage.Create(CreateStream(finalimg));
    enc := GetEncoderQualityParameters(ImageQualityPercentage);
    gpimg.Save(filename, GetCLSID(ImageType), @enc);
  finally
    gpimg.Free;
    finalimg.Free;
    g.Free;
    img.Free;
  end;
end;
procedure TAdvGDIPChart.SaveToImage(Filename: String; ImageWidth, ImageHeight: integer; ImageType: TChartImageType = itBMP; ImageQualityPercentage: integer = 100);
var
  img: graphics.TBitmap;
  gpimg: TGPImage;
  g: TGPGraphics;
  enc: TEncoderParameters;
begin
  img := nil;
  gpimg := nil;
  g := nil;
  try
    img := graphics.TBitmap.Create;
    img.Width := ImageWidth;
    img.Height := ImageHeight;
    SaveChart(img.Canvas, rect(0, 0, ImageWidth, ImageHeight));
    gpimg := TGPImage.Create(CreateStream(img));
    enc := GetEncoderQualityParameters(ImageQualityPercentage);
    gpimg.Save(filename, GetCLSID(ImageType), @enc);
  finally
    gpimg.Free;
    g.Free;
    img.Free;
  end;
end;
procedure TAdvGDIPChart.SaveToStream(AStream: TMemoryStream; ImageWidth, ImageHeight: integer; ImageType: TChartImageType = itBMP; ImageQualityPercentage: integer = 100);
var
  img: graphics.TBitmap;
  gpimg: TGPImage;
  g: TGPGraphics;
  enc: TEncoderParameters;
  istr: IStream;
begin
  img := nil;
  gpimg := nil;
  g := nil;
  try
    img := graphics.TBitmap.Create;
    img.Width := ImageWidth;
    img.Height := ImageHeight;
    SaveChart(img.Canvas, rect(0, 0, ImageWidth, ImageHeight));
    gpimg := TGPImage.Create(CreateStream(img));
    enc := GetEncoderQualityParameters(ImageQualityPercentage);
    istr := TStreamAdapter.Create(AStream, soReference);
    gpimg.Save(istr, GetCLSID(ImageType), @enc);
  finally
    gpimg.Free;
    g.Free;
    img.Free;
  end;
end;
procedure TAdvGDIPChartView.SetPanes(const Value: TAdvGDIPChartPanes);
begin
  Panes := Value;
end;
procedure TAdvGDIPChartView.UpdateZoomControl;
var
  i, k: integer;
begin
  for I := 0 to Panes.Count - 1 do
  begin
    with Panes[I] do
    begin
      if ZoomControl.Visible then
      begin
        ZoomControl.Chart.Series.Clear;
        for K := 0 to Series.Count - 1 do
        begin
          if (Series[K].SerieType <> stNormal) and (Series[k].Visible) then
          begin
            with ZoomControl.Chart.Series.Add do
            begin
              Assign(Series[k]);
              SerieType := stNormal;
              YAxis.Position :=yNone;
            end;
          end;
        end;
        if ZoomControl.SlideAutoRange then
        begin
          ZoomControl.Chart.Range.RangeTo := Range.MaxRangeTo;
          ZoomControl.Chart.Range.RangeFrom := 0;
        end
        else
        begin
          ZoomControl.Chart.Range.RangeTo := ZoomControl.SlideMaximumRange;
          ZoomControl.Chart.Range.RangeFrom := ZoomControl.SlideMinimumRange;
        end;
        ZoomControl.Chart.Series.Mode := Series.Mode;
        ZoomControl.Chart.Series.ForceInit(true);
      end;
    end;
  end;
end;
function TAdvGDIPChartView.XYtoPane(X, Y: integer): integer;
var
  I: Integer;
begin
  result := -1;
  for I := 0 to Panes.Count - 1 do
  begin
    if PtInRect(Panes[I].Rectangle, Point(X, Y)) then
    begin
      result := I;
      break;
    end;
  end;
end;
{ TAdvGDIPChartPanes }
function TAdvGDIPChartPanes.Add: TAdvGDIPChartPane;
begin
  Result := TAdvGDIPChartPane(inherited Add);
end;
function TAdvGDIPChartPanes.GetItem(Index: Integer): TAdvGDIPChartPane;
begin
  Result := TAdvGDIPChartPane(inherited Items[Index]);
end;
function TAdvGDIPChartPanes.GetItemClass: TCollectionItemClass;
begin
  Result := TAdvGDIPChartPane;
end;
procedure TAdvGDIPChartPanes.SetItem(Index: Integer;
  const Value: TAdvGDIPChartPane);
begin
  inherited Items[Index] := Value;
end;
{ TAdvGDIPChartPane }
procedure TAdvGDIPChartPane.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if (Source is TAdvGDIPChartPane) then
  begin
    Mirror := (Source as TAdvGDIPChartPane).Mirror;
    ZoomControl.Assign((Source as TAdvGDIPChartPane).ZoomControl);
  end;
end;
constructor TAdvGDIPChartPane.Create(Collection: TCollection);
begin
  inherited;
  FZoomControl := TAdvGDIPZoomControl.Create(Self);
  FZoomControl.OnChange := ZoomChanged;
end;
function TAdvGDIPChartPane.CreateChart: TAdvChart;
begin
  Result := TAdvGDIPChart.Create(Self);
  if Assigned(ChartView) and (csDesigning in ChartView.ComponentState) and not (csLoading in ChartView.componentstate) then
    Result.Range.StartDate := Now;
  Result.GetPaneRectangle := DoGetPaneRectangle;
  Result.OnSerieXAxisGroup := DoSerieXAxisGroup;
  Result.OnGetCountChartType := DoGetCountChartType;
  Result.OnGetCountGroupedChartType := DoGetCountGroupedChartType;
  Result.OnDrawGridPieLineValue := DoDrawGridPieLineValue;
  Result.OnGetGridPieLineValue := DoGetGridPieLineValue;
  Result.OnGetNumberOfPoints := DoGetNumberOfPoints;
  Result.OnGetPoint := DoGetPoint;
end;
destructor TAdvGDIPChartPane.Destroy;
begin
  FZoomControl.Free;
  inherited;
end;
function TAdvGDIPChartPane.GetBackground: TChartGDIPBackground;
begin
  Result := TChartGDIPBackground(inherited Background);
end;
function TAdvGDIPChartPane.GetChartGDPI: TAdvGDIPChart;
begin
  Result := TAdvGDIPChart(inherited Chart);
end;
function TAdvGDIPChartPane.GetLegend: TChartGDIPLegend;
begin
  Result := TChartGDIPLegend(inherited Legend);
end;
function TAdvGDIPChartPane.GetMirror: Boolean;
begin
  Result := Chart.Mirror;
end;
function TAdvGDIPChartPane.GetSeries: TAdvGDIPChartSeries;
begin
  Result := TAdvGDIPChartSeries(inherited Series);
end;
procedure TAdvGDIPChartPane.LoadFromFile(ini: TMemIniFile; Section: String; AutoCreateSections: Boolean = False);
begin
  inherited;
  Chart.Mirror := ini.ReadBool(Section, 'Mirror', Chart.Mirror);
  ZoomControl.LoadFromFile(ini, Section + '.' + 'ZoomControl');
end;
function TAdvGDIPChartPane.MouseInZoomRectangle(X, Y: integer): Boolean;
begin
  result := PtInRect(ZoomControl.GetZoomRectangle(Series.SeriesRectangle), Point(X, Y));
end;
function TAdvGDIPChartPane.MouseOnSlider(X, Y: integer): Boolean;
begin
  result := PtInrect(TAdvGDIPChartView(ChartView).GetSliderMarginFromRectangle(Self), Point(X, Y))
    or PtInrect(TAdvGDIPChartView(ChartView).GetSliderMarginToRectangle(Self), Point(X, Y));
end;
procedure TAdvGDIPChartPane.SaveToFile(ini: TMemIniFile; Section: String);
begin
  inherited;
  ini.WriteBool(Section, 'Mirror', Chart.Mirror);
  ZoomControl.SaveToFile(ini, Section + '.' + 'ZoomControl');
end;
procedure TAdvGDIPChartPane.SetBackground(const Value: TChartGDIPBackground);
begin
  inherited Background := Value;
end;
procedure TAdvGDIPChartPane.SetChartGDIP(const Value: TAdvGDIPChart);
begin
  //inherited Chart := Value;
end;
procedure TAdvGDIPChartPane.SetLegend(const Value: TChartGDIPLegend);
begin
  inherited Legend := Value;
end;
procedure TAdvGDIPChartPane.SetMirror(const Value: Boolean);
begin
  Chart.Mirror := value;
end;
procedure TAdvGDIPChartPane.SetSeries(const Value: TAdvGDIPChartSeries);
begin
  inherited Series := Value;
end;
procedure TAdvGDIPChartPane.SetZoomControl(const Value: TAdvGDIPZoomControl);
begin
  if FZoomControl <> Value then
  begin
    FZoomControl.Assign(Value);
    ZoomChanged(Self);
  end;
end;
procedure TAdvGDIPChartPane.ZoomChanged(Sender: TObject);
begin
  ChartView.Invalidate;
end;
{ TAdvGDIPChart }
function TAdvGDIPChart.CreateBackground: TChartBackground;
begin
  Result := TChartGDIPBackground.Create(Self);
end;
function TAdvGDIPChart.CreateLegend: TChartLegend;
var
 l: TChartGDIPLegend;
begin
  l := TChartGDIPLegend.Create(Self);
  l.Chart := self;
  result := l;
end;
function TAdvGDIPChart.CreateSeries: TChartSeries;
begin
  Result := TAdvGDIPChartSeries.Create(Self);
end;
procedure DrawReflection(graphics: TGPGraphics; img: TGPImage; destinationrectangle: TGPRectf;bkg: TColor);
var
//  rct: TGPRectf;
  reflectivity: integer;
  reflectionHeight, reflectionWidth: integer;
  reflection: TGPBitmap;
  g: TGPGraphics;
  imagerect: TGPRectf;
  brush: TGPLinearGradientBrush;
begin
  // Crop the reflection to the bottom third (or depending on reflectivity)
  reflectivity := 100;
  //  reflectionHeight := round((img.Height * reflectivity) / 255);
  reflectionHeight := round((Integer(img.Height) * reflectivity) / 255);
  reflectionWidth := img.Width;
  {$IFDEF DELPHI7_LVL}
  reflection := TGPBitmap.Create(reflectionWidth, reflectionHeight);
  {$ENDIF}
  {$IFNDEF DELPHI7_LVL}
  reflection := TGPBitmap.CreateWH(reflectionWidth, reflectionHeight);
  {$ENDIF}
  g := TGPGraphics.Create(reflection);
  g.DrawImage(img, MakeRect(0, 0, reflection.Width, reflection.Height),
              0, img.Height - reflection.Height,
              reflection.Width,
              reflection.Height,
              UnitPixel);
  // then flip it
  reflection.RotateFlip(RotateNoneFlipY);
//  imageRect := MakeRect(destinationRectangle.X, destinationRectangle.Y,
//                        destinationRectangle.Width, (destinationRectangle.Height *
//                        reflectivity) / 255);
 imageRect := MakeRect(0,0,
                       destinationRectangle.Width, (destinationRectangle.Height *
                       reflectivity) / 255);
  // Place it on the window.
  //graphics.DrawImageRect(reflection, imageRect);
  // Create gradient brush depending on reflectivity
  brush := TGPLinearGradientBrush.Create(imageRect,
           MakeColor(255 - reflectivity, bkg),
           MakeColor(255,bkg), 90, false);
  // And paint it over reflection image ...
  //graphics.FillRectangle(brush, imageRect);
  g.FillRectangle(brush, imageRect);
  g.Free;
  brush.Free;
  imageRect := MakeRect(destinationRectangle.X, destinationRectangle.Y,
                        destinationRectangle.Width, (destinationRectangle.Height *
                        reflectivity) / 255);
  graphics.DrawImageRect(reflection, imageRect);
end;

function TAdvGDIPChart.Draw(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double; Initialize: Boolean): TRect;
var
  bmp: Graphics.TBitmap;
  pstm: IStream;
  hGlobal: THandle;
  pcbWrite: Longint;
  ms: TMemoryStream;
  gpbmp: TGPBitmap;
  g,gb: TGPGraphics;
  lbrush: TGPLinearGradientBrush;
  clr: TColor;
  CmbRect: Trect;
  zl,i : integer;
  pr: trect;
  colors : array[0..3] of TGPColor;
  positions: array[0..3] of single;
begin
  inherited Draw(Canvas, R, ScaleX, ScaleY, Initialize);
  if not Mirror then
    Exit;
  if Margin.BottomMargin = 0 then
    Exit;
  gpbmp := nil;
  lbrush := nil;
  g := nil;
  if (Owner is TChartPane) then
  begin
    with (Owner as TChartPane) do
    begin
      zl := 0;
      for i := 0 to Series.Count - 1 do
      begin
        if Series[i].ZeroLine then
        begin
          zl := 1;
        end;
      end;

      pr := Rectangle;
      inflaterect(pr,-BorderWidth,-BorderWidth);
      pr.Top := pr.Bottom - XAxis.BottomSize - Margin.BottomMargin + zl;
      pr.Left := Series.SeriesRectangle.Left;
      pr.Right := Series.SeriesRectangle.Right;
      pr.Bottom := pr.Bottom - XAxis.BottomSize - XAxis.BottomLineSize;
      clr := ColorToRGB(ChartView.Color);
    end;
    if (pr.Bottom - pr.Top < 0) or (pr.Right - pr.Left < 0) then
      Exit;
    {if mirror}
    bmp := Graphics.TBitmap.Create;
    bmp.Height := (pr.Bottom - pr.Top);
    bmp.Width := pr.Right - pr.Left;
    bmp.TransparentMode := tmAuto;
    bmp.Transparent := True;
    //PaintText(bmp.Canvas);
    bmp.Canvas.CopyMode := cmSrcCopy;
    bmp.Canvas.CopyRect(Rect(0, 0, bmp.Width, bmp.Height), Canvas, Rect(pr.left, pr.Top - bmp.Height - zl, pr.Right, pr.Top - zl));
    Canvas.Draw(pr.Left, pr.Bottom - bmp.height, bmp);
    ms := TMemoryStream.Create;
    bmp.SaveToStream(ms);
    hGlobal := GlobalAlloc(GMEM_MOVEABLE, ms.Size);
    if (hGlobal = 0) then
    begin
      ms.Free;
      raise Exception.Create('Could not allocate memory for reflection Label');
    end;
    try
      pstm := nil;
      // Create IStream* from global memory
      CreateStreamOnHGlobal(hGlobal, TRUE, pstm);
      pstm.Write(ms.Memory, ms.Size,@pcbWrite);
      gpbmp := TGPBitmap.Create(pstm);
      gpbmp.RotateFlip(RotateNoneFlipY);
      g := TGPGraphics.Create(Canvas.Handle);
      lbrush := TGPLinearGradientBrush.Create(MakeRect(0,0,bmp.Width,bmp.Height),
                 MakeColor(0,clr),MakeColor(255,clr),90,false);

      colors[0] := MakeColor(0,clr);
      colors[1] := MakeColor(220,clr);
      colors[2] := MakeColor(255,clr);
      positions[0] := 0;
      positions[1] := 0.5;
      positions[2] := 1;
      lbrush.SetInterpolationColors(@colors, @positions, 3);
      gb := TGPGraphics.Create(gpbmp);
      gb.FillRectangle(lbrush,MakeRect(0,0,bmp.Width,bmp.Height));
      gb.Free;
      g.DrawImage(gpbmp, pr.Left,pr.Top);
      if YGrid.ShowBorder then
      begin
        Canvas.Brush.Color := YGrid.BorderColor;
        CmbRect := Rect(Series.SeriesRectangle.Left, Series.SeriesRectangle.Top, Series.SeriesRectangle.Right, pr.Bottom);
        Canvas.FrameRect(CmbRect);
      end;
      
    finally
      lbrush.Free;
      gpbmp.Free;
      g.Free;
      ms.Free;
      bmp.Free;
    end;
  end;
end;
procedure TAdvGDIPChart.FindInterSection(p1, p2, p3, p4: TPoint; var ptchk: TPointCheck);
begin
  inherited;
end;
function TAdvGDIPChart.GetBackground: TChartGDIPBackground;
begin
  Result := TChartGDIPBackground(inherited Background);
end;
function TAdvGDIPChart.GetLegend: TChartGDIPLegend;
begin
  Result := TChartGDIPLegend(inherited Legend);
end;
function TAdvGDIPChart.GetSeries: TAdvGDIPChartSeries;
begin
  Result := TAdvGDIPChartSeries(inherited Series);
end;
procedure TAdvGDIPChart.SetBackground(const Value: TChartGDIPBackground);
begin
  inherited Background := Value;
end;
procedure TAdvGDIPChart.SetLegend(const Value: TChartGDIPLegend);
begin
  inherited Legend := Value;
end;
procedure TAdvGDIPChart.SetMirror(const Value: Boolean);
begin
  FMirror := Value;
  Changed;
end;
procedure TAdvGDIPChart.SetSeries(const Value: TAdvGDIPChartSeries);
begin
  inherited Series := Value;
end;
{ TChartGDIPLegend }
procedure TChartGDIPLegend.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if (Source is TChartGDIPLegend) then
  begin
    FAngle := (Source as TChartGDIPLegend).Angle;
    FGradientType := (Source as TChartGDIPLegend).GradientType;
    FHatchStyle := (Source as TChartGDIPLegend).HatchStyle;
    FOpacity := (Source as TChartGDIPLegend).Opacity;
    FOpacityTo := (Source as TChartGDIPLegend).OpacityTo;
    FShadow := (Source as TChartGDIPLegend).Shadow;
  end;
end;
constructor TChartGDIPLegend.Create(AOwner: TAdvChart);
begin
  inherited;
  FAngle := 0;
  FGradientType := gtSolid;
  FHatchStyle := HatchStyleHorizontal;
  FOpacity := 255;
  FOpacityTo := 255;
  FShadow := false;
end;
procedure TChartGDIPLegend.Draw(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: double);
var
  graphics : TGPGraphics;
  fp: TGDIPFillParameters;
  k, i, rsp, rs: integer;
  b: TGPSolidBrush;
//  DR: Trect
  x, y: integer;
  origr: TRect;
begin
  if Visible then
  begin
    origr := Chart.Series.SeriesRectangle;
    GetLegendPosition(x, y, origr.Right - origr.left, origr.Bottom - origr.Top, r.Right - r.Left, r.Bottom - r.Top, Alignment);
    r := Bounds(x + origr.Left, y + origr.Top, r.Right - r.Left, r.Bottom - R.Top);
    // Create GDI+ canvas
    graphics := TGPGraphics.Create(Canvas.Handle);
    if Shadow then
    begin
      ShadowGDIP(graphics,MakeRect((r.Left + 4) / ScaleX + Left, (r.Top + 4) / ScaleY + Top, (r.Right - r.Left) / ScaleX , (r.Bottom - r.Top) / ScaleY));
    end;
    fp.Graphics := graphics;
    fp.GT := GradientType;
    fp.ColorFrom := Color;
    fp.ColorTo := ColorTo;
    fp.OpacityFrom := Opacity;
    fp.OpacityTo := OpacityTo;
    fp.Angle := Angle;
    fp.HatchStyle := HatchStyle;
    fp.Image := nil;
    fp.Path := CreateRoundRectangle(MakeRect((r.Left / ScaleX) + Left , (r.Top / ScaleY) + Top, (r.Right - r.Left) / ScaleX , (r.Bottom - r.Top) / ScaleY), BorderRounding, rtBoth, False);
    fp.Fillpath := True;
    fp.BorderColor := BorderColor;
    fp.BorderWidth := BorderWidth;
    fp.BorderStyle := DashStyleSolid;
    FillGDIP(fp);
    rs := RectangleSize;
    rsp := RectangleSpacing;
    K := 0;
    for I := 0 to Chart.Series.Count - 1 do
    begin
      with Chart.Series.Items[I] do
      begin
        if (ChartType <> ctNone) and (SerieType <> stZoomControl) and ShowInLegend and Visible then
        begin
          case ChartType of
            ctError,ctArrow, ctLine, ctDigitalLine, ctHistogram, ctLineHistogram, ctXYLine, ctXYDigitalLine:
            begin
              fp.ColorFrom := LineColor;
              fp.ColorTo := LineColor;
            end;
          else
            begin
              fp.ColorFrom := Color;
              fp.ColorTo := ColorTo;
            end;
          end;

          fp.Graphics := graphics;
          fp.GT := GradientType;
          fp.OpacityFrom := Opacity;
          fp.OpacityTo := OpacityTo;
          fp.Angle := Angle;
          fp.HatchStyle := HatchStyle;
          fp.Image := nil;
          fp.Path := nil;
          fp.R := MakeRect((R.Left / ScaleX) + Left + rsp, (rsp + (R.Top / ScaleY) + Top + (rsp * K) + ((K) * rs)), rs, rs);
          fp.Fillpath := false;
          fp.BorderColor := BorderColor;
          fp.BorderWidth := BorderWidth;
          fp.BorderStyle := DashStyleSolid;
          b := TGPSolidBrush.Create(MakeColor(255, clWhite));
          graphics.FillRectangle(b, fp.R);
          b.free;
          FillGDIP(fp);
          Canvas.Brush.Style := bsClear;
          graphics.Free;
          Canvas.TextOut(r.Left + Round(Left * ScaleX) + Round(2 * rsp + (rs * ScaleX)), rsp + R.Top
          + Round(Top * ScaleY) + Round(((rsp * K) + (K * rs)) * ScaleY)
          + (rs - Canvas.TextHeight(LegendText)) div 2, LegendText);
          graphics := TGPGraphics.Create(Canvas.Handle);
          Inc(K);
        end;
      end;
    end;
    graphics.Free;
  end;
end;
procedure TChartGDIPLegend.LoadFromFile(ini: TMemIniFile; Section: String);
begin
  inherited;
  Angle := ini.ReadInteger(Section, 'Angle', Angle);
  GradientType := TChartGradientType(ini.ReadInteger(Section, 'GradientType',Integer(GradientType)));
  HatchStyle := THatchStyle(ini.ReadInteger(Section, 'HatchStyle', Integer(HatchStyle)));
  Opacity := ini.ReadInteger(Section, 'Opacity', Opacity);
  OpacityTo := ini.ReadInteger(Section, 'OpacityTo', Opacityto);
  Shadow := ini.ReadBool(Section, 'Shadow', Shadow);
end;
procedure TChartGDIPLegend.SaveToFile(ini: TMemIniFile; Section: String);
begin
  inherited;
  ini.WriteInteger(Section, 'Angle', Angle);
  ini.WriteInteger(Section, 'GradientType',Integer(GradientType));
  ini.WriteInteger(Section, 'HatchStyle', Integer(HatchStyle));
  ini.writeInteger(Section, 'Opacity', Opacity);
  ini.writeInteger(Section, 'OpacityTo', Opacityto);
  ini.WriteBool(Section, 'Shadow', Shadow);
end;
procedure TChartGDIPLegend.SetAngle(const Value: integer);
begin
  if FAngle <> Value then
  begin
     FAngle := Value;
     Changed;
  end;
end;
procedure TChartGDIPLegend.SetChart(const Value: TAdvGdipChart);
begin
  if FChart <> value then
  begin
    FChart := Value;
  end;
end;
procedure TChartGDIPLegend.SetGradientType(const Value: TChartGradientType);
begin
  if (FGradientType <> Value) then
  begin
    FGradientType := Value;
    Changed;
  end;
end;
procedure TChartGDIPLegend.SetHatchStyle(const Value: THatchStyle);
begin
  if (FHatchStyle <> Value) then
  begin
    FHatchStyle := Value;
    Changed;
  end;
end;
procedure TChartGDIPLegend.SetOpacity(const Value: integer);
begin
  FOpacity := Limit(0,255,Value);
  Changed;
end;
procedure TChartGDIPLegend.SetOpacityTo(const Value: integer);
begin
  FOpacityTo := Limit(0,255,Value);
  Changed;  
end;
procedure TChartGDIPLegend.SetShadow(const Value: boolean);
begin
  FShadow := Value;
end;
{ TChartGDIPBackground }
procedure TChartGDIPBackground.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if (Source is TChartGDIPBackground) then
  begin
    FGradientType := (Source as TChartGDIPBackground).GradientType;
    FHatchStyle := (Source as TChartGDIPBackground).HatchStyle;
    FPicture.Assign((Source as TChartGDIPBackground).Picture);
    FAngle := (Source as TChartGDIPBackground).Angle;
  end;
end;
constructor TChartGDIPBackground.Create(AOwner: TAdvChart);
begin
  inherited;
  FAngle := 0;
  FGradientType := AdvChartGDIP.gtNone;
  FHatchStyle := HatchStyleHorizontal;
  FPicture := TChartGDIPPicture.Create;
  FPicture.OnChange := PictureChanged;
end;
destructor TChartGDIPBackground.Destroy;
begin
  FPicture.Free;
  inherited;
end;
procedure TChartGDIPBackground.Draw(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: double);
var
  graphics : TGPGraphics;
  fp: TGDIPFillParameters;
begin
  graphics := TGPGraphics.Create(Canvas.Handle);
  graphics.SetSmoothingMode(SmoothingModeAntiAlias);

  fp.Graphics := graphics;
  fp.Path := nil;
  fp.Fillpath := false;
  fp.R := MakeRect((r.Left / Scalex),(r.Top / ScaleY),(r.Right - r.Left) / ScaleX,(r.Bottom - r.Top) / ScaleY);
  fp.OpacityFrom := 255;
  fp.OpacityTo := 255;
  fp.GT := GradientType;
  fp.ColorFrom := Color;
  fp.ColorTo := ColorTo;
  fp.Angle := Angle;
  fp.HatchStyle := HatchStyle;
  fp.Image := Picture;
  fp.BorderColor := clNone;
  fp.BorderWidth := 0;
  fp.BorderStyle := DashStyleSolid;
  if PictureVisible and not Picture.Empty and (BackgroundPosition = bpTiled) then
  begin
    fp.GT := gtTexture;
  end;
  FillGDIP(fp);
  if PictureVisible and not Picture.Empty then
  begin
    case BackGroundPosition of
    bpTopLeft: Picture.GDIPDraw(graphics, Rect(r.Left,r.Top,r.Left + Picture.Width, r.Top + Picture.Height));
    bpTopRight: Picture.GDIPDraw(graphics, Rect(r.Right - picture.Width, r.Top, r.Right, r.Top + Picture.Height));
    bpBottomLeft: Picture.GDIPDraw(graphics, Rect(r.Left, r.Bottom - Picture.Height, r.Left + Picture.Width, r.Bottom));
    bpBottomRight: Picture.GDIPDraw(graphics, Rect(r.Right - picture.Width, r.Bottom - Picture.Height, r.Right, r.Bottom));
    bpStretched: Picture.GDIPDraw(graphics, Rect(r.Left,r.Top,r.Right, r.Bottom));
    bpCenter:
      begin
        r.Left := r.Left + ((r.Right - r.Left) - Picture.Width) div 2;
        r.Top := r.Top + ((r.Bottom - r.Top) - Picture.Height) div 2;
        Picture.GDIPDraw(graphics, Rect(r.Left,r.Top,r.Left + Picture.Width, r.Top + Picture.Height));
      end;
    end;
  end;
  graphics.Free;
end;
procedure TChartGDIPBackground.LoadFromFile(ini: TMemIniFile; Section: String);
begin
  inherited;
  Angle := ini.ReadInteger(Section, 'Angle', Angle);
  GradientType := TchartGradientType(ini.ReadInteger(Section, 'GradientType',Integer(GradientType)));
  HatchStyle := THatchStyle(ini.ReadInteger(Section, 'HatchStyle', Integer(HatchStyle)));
  //TODO picture
end;
procedure TChartGDIPBackground.PictureChanged(Sender: TObject);
begin
  Changed;
end;
procedure TChartGDIPBackground.SaveToFile(ini: TMemIniFile; Section: String);
begin
  inherited;
  ini.WriteInteger(Section, 'Angle', Angle);
  ini.WriteInteger(Section, 'GradientType',Integer(GradientType));
  ini.WriteInteger(Section, 'HatchStyle', Integer(HatchStyle));
  //TODO picture
end;
procedure TChartGDIPBackground.SetAngle(const Value: integer);
begin
  FAngle := Value;
end;
procedure TChartGDIPBackground.SetGradientType(const Value: TChartGradientType);
begin
  FGradientType := Value;
end;
procedure TChartGDIPBackground.SetHatchStyle(const Value: THatchStyle);
begin
  FHatchStyle := Value;
end;
procedure TChartGDIPBackground.SetPicture(const Value: TChartGDIPPicture);
begin
  FPicture.Assign(Value);
end;
{ TAdvGDIPChartSeries }

function TAdvGDIPChartSeries.Add: TAdvGDIPChartSerie;
begin
  Result := TAdvGDIPChartSerie(inherited Add);
end;

function TAdvGDIPChartSeries.GetItem(Index: Integer): TAdvGDIPChartSerie;
begin
  Result := TAdvGDIPChartSerie(inherited Items[Index]);
end;
function TAdvGDIPChartSeries.GetItemClass: TCollectionItemClass;
begin
  Result := TAdvGDIPChartSerie;
end;
procedure TAdvGDIPChartSeries.SetItem(Index: Integer;
  const Value: TAdvGDIPChartSerie);
begin
  Items[Index] := Value;
end;
{ TAdvGDIPChartSerie }
procedure TAdvGDIPChartSerie.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if (Source is TAdvGDIPChartSerie) then
  begin
    FOpacity := (Source as TAdvGDIPChartSerie).Opacity;
    FOpacityTo := (Source as TAdvGDIPChartSerie).OpacityTo;
    FGradientType := (Source as TAdvGDIPChartSerie).GradientType;
    FLineOpacity := (Source as TAdvGDIPChartSerie).LineOpacity;
    FChartPattern.Assign((Source as TAdvGDIPChartSerie).ChartPattern);
    FAngle := (Source as TAdvGDIPChartSerie).Angle;
    FHatchStyle := (Source as TAdvGDIPChartSerie).HatchStyle;
    FShadow := (Source as TAdvGDIPChartSerie).Shadow;
    Pie.Assign((Source as TAdvGDIPChartSerie).Pie);
    Annotations.Assign((Source as TAdvGDIPChartSerie).Annotations);
    SerieType := (Source as TAdvGDIPChartSerie).SerieType;
    Changed;
  end;
end;
constructor TAdvGDIPChartSerie.Create(Collection: TCollection);
begin
  inherited;
  FOpacity := 255;
  FOpacityTo := 255;
  FGradientType := gtSolid;
  FLineOpacity := 255;
  FChartPattern := TChartGDIPPicture.Create;
end;
function TAdvGDIPChartSerie.CreateAnnotations: TChartAnnotations;
begin
  Result := TChartGDIPAnnotations.Create(Self);
end;
function TAdvGDIPChartSerie.CreatePie: TChartSeriePie;
begin
  Result := TGDIPChartSeriePie.Create(Self);
end;
function TAdvGDIPChartSerie.CreateMarker: TChartMarker;
begin
  Result := TChartGDIPMarker.Create;
end;
destructor TAdvGDIPChartSerie.Destroy;
begin
  FChartPattern.Free;
  inherited;
end;
procedure TAdvGDIPChartSerie.Draw(Canvas: TCanvas; R: TRect; ScaleX,
  ScaleY: Double);
var
  obm: integer;
  graphics : TGPGraphics;
  path: TGPGraphicsPath;
  pen: TGPPen;
  i: integer;
  cr,cg,cb: byte;
//  crt,cgt,cbt: byte;
  col: TColor;
  z, cntstperc, cntst: integer;
//  cs: integer;
  dp, dpline: TPointArray;
  pnt: TPoint;
  rct: TGPRectf;
  {hdp,} hsdp: integer;
  rf,xp: integer;
  s: TChartSerie;
  dp1,dp2{,dpprev}: TPoint;
  fp: TGDIPFillParameters;
  ShadowPoints: TPointArray;
  valuex,valuey,valuexstart,valueystart: integer;
  xpos, lnt, pci: integer;
  arr3D: TPointArray;
  dpc: integer;
  dm: Boolean;
  digitalx: Integer;
  dpDigital: TDigitalLinePointArray;
  chartpt, chartpt2: TChartPoint;
  dpr, dpr1: TPoint;
  serier: TRect;
  smt: integer;
  dppoly: TPointArray;
  pt: TChartPoint;
  cntdef: Integer;
begin
  if IsDrawing or (SerieType = stZoomControl) or not Visible then
    Exit;
  dm := Chart.Series.IsHorizontal;
  IsDrawing := true;
  rf := 0;
  obm := SetBkMode(Canvas.Handle, TRANSPARENT);
  if not IsPieChart then
      lnt := Length(DrawPoints)
  else
    lnt := 1;
  if lnt > 0 then
  begin
    SetBkMode(Canvas.Handle, obm);
    Canvas.Pen.Style := PenStyle;
    Canvas.Brush.Style := BrushStyle;
    if Color <> clNone then
      Canvas.Brush.Color := Color
    else
      Canvas.Brush.Style := bsClear;
    case ChartType of
      ctNone: // do nothing
      begin
      end;
      ctDigitalLine, ctXYDigitalLine:
      begin
        digitalx := Round(Chart.GetXScaleStart);
        SetLength(dpDigital, 0);
        for I := 0 to Length(DrawPoints) - 1 do
        begin

          if (I = 0) then
          begin
            SetLength(dpDigital, Length(dpDigital) + 1);
            dpDigital[Length(dpDigital) - 1].pt := Point(DrawPoints[I].X - digitalx, ValueToY(ZeroReferencePoint, Chart.Series.SeriesRectangle));
            dpDigital[Length(dpDigital) - 1].Idx := I;
            SetLength(dpDigital, Length(dpDigital) + 1);
            dpDigital[Length(dpDigital) - 1].pt := Point(DrawPoints[i].X - digitalx, DrawPoints[i].Y);
            dpDigital[Length(dpDigital) - 1].Idx := I;
            SetLength(dpDigital, Length(dpDigital) + 1);
            dpDigital[Length(dpDigital) - 1].pt := Point(DrawPoints[i].X + digitalx, DrawPoints[i].Y);
            dpDigital[Length(dpDigital) - 1].Idx := I;
          end
          else if (I = Length(DrawPoints) - 1) then
          begin
            SetLength(dpDigital, Length(dpDigital) + 1);
            dpDigital[Length(dpDigital) - 1].pt := Point(DrawPoints[i - 1].X + digitalx, DrawPoints[i].Y);
            dpDigital[Length(dpDigital) - 1].Idx := I;

            if ChartType = ctXYDigitalLine then
              digitalx := (DrawPoints[i].X - DrawPoints[I - 1].X) div 2;

            SetLength(dpDigital, Length(dpDigital) + 1);
            dpDigital[Length(dpDigital) - 1].pt := Point(DrawPoints[i].X + digitalx, DrawPoints[i].Y);
            dpDigital[Length(dpDigital) - 1].Idx := I;
            SetLength(dpDigital, Length(dpDigital) + 1);
            dpDigital[Length(dpDigital) - 1].pt := Point(DrawPoints[i].X + digitalx, ValueToY(ZeroReferencePoint, Chart.Series.SeriesRectangle));
            dpDigital[Length(dpDigital) - 1].Idx := I;
          end
          else
          begin
            SetLength(dpDigital, Length(dpDigital) + 1);
            dpDigital[Length(dpDigital) - 1].pt := Point(DrawPoints[i - 1].X + digitalx, DrawPoints[i].Y);
            dpDigital[Length(dpDigital) - 1].Idx := I;

            if ChartType = ctXYDigitalLine then
              digitalx := (DrawPoints[i + 1].X - DrawPoints[I].X) div 2;

            SetLength(dpDigital, Length(dpDigital) + 1);
            dpDigital[Length(dpDigital) - 1].pt := Point(DrawPoints[i].X + digitalx, DrawPoints[i].Y);
            dpDigital[Length(dpDigital) - 1].Idx := I;
          end;
        end;
        graphics := TGPGraphics.Create(Canvas.Handle);

        col := ColorToRGB(LineColor);
        cb := (col AND $FF0000) shr 16;
        cg := (col AND $FF00) shr 8;
        cr := (col AND $FF);
        pen := TGPPen.Create(MakeColor(Opacity,cr,cg,cb), LineWidth * ScaleX);
        pen.SetDashStyle(DashStyle(PenStyle));
        graphics.SetSmoothingMode(SmoothingModeAntiAlias);
        if Enable3D then
        begin
          for I := 0 to Length(dpDigital) - 2 do
          begin
            chartpt := GetChartPointFromDrawPoint(dpDigital[I].Idx);
            chartpt2 := GetChartPointFromDrawPoint(dpDigital[I + 1].Idx);
            if chartpt.Defined and chartpt2.Defined then
            begin
              SetLength(arr3D, 4);
              if dm then
              begin
                arr3D[0] := Point(dpDigital[I].pt.X, dpDigital[I].pt.Y);
                arr3D[1] := Point(dpDigital[I].pt.X + Offset3D, dpDigital[I].pt.Y + Offset3D);
                arr3D[2] := Point(dpDigital[I + 1].pt.X + Offset3D, dpDigital[I + 1].pt.Y + Offset3D);
                arr3D[3] := Point(dpDigital[I + 1].pt.X, dpDigital[I + 1].pt.Y);
              end
              else
              begin
                arr3D[0] := Point(dpDigital[I].pt.X, dpDigital[I].pt.Y);
                arr3D[1] := Point(dpDigital[I].pt.X + Offset3D, dpDigital[I].pt.Y - Offset3D);
                arr3D[2] := Point(dpDigital[I + 1].pt.X + Offset3D, dpDigital[I + 1].pt.Y - Offset3D);
                arr3D[3] := Point(dpDigital[I + 1].pt.X, dpDigital[I + 1].pt.Y);
              end;
              path := TGPGraphicsPath.Create;
              path.AddLines(PGPPoint(arr3D), Length(arr3D));
              path.CloseFigure;
              fp.Graphics := graphics;
              fp.Path := path;
              fp.Fillpath := true;
              fp.R := MakeRect(Chart.Series.SeriesRectangle.Left, Chart.Series.SeriesRectangle.Top,
                Chart.Series.SeriesRectangle.Right - Chart.Series.SeriesRectangle.Left, Chart.Series.SeriesRectangle.Bottom - Chart.Series.SeriesRectangle.Top);
              fp.OpacityFrom := Opacity;
              fp.OpacityTo := OpacityTo;
              fp.GT := GradientType;
              fp.ColorFrom := Color;
              fp.ColorTo := ColorTo;
              fp.Angle := Angle;
              fp.HatchStyle := HatchStyle;
              fp.BorderColor := BorderColor;
              fp.BorderWidth := BorderWidth;
              fp.BorderStyle := DashStyle(PenStyle);
              fp.Image := ChartPattern;
              FillGDIP(fp);
              path.Free;
            end;
          end;
        end;
        path := TGPGraphicsPath.Create;
        smt := graphics.GetSmoothingMode;
        graphics.SetSmoothingMode(SmoothingModeDefault);
        for I := 0 to Length(dpDigital) - 2 do
        begin
          chartpt := GetChartPointFromDrawPoint(dpDigital[I].Idx);
          chartpt2 := GetChartPointFromDrawPoint(dpDigital[I + 1].Idx);
          if chartpt.Defined and chartpt2.Defined then
          begin
            path.AddLine(MakePointF(dpDigital[I].pt.X, dpDigital[I].pt.Y), MakePointF(dpDigital[I].pt.X, dpDigital[I + 1].pt.Y));
            path.AddLine(MakePointF(dpDigital[I].pt.X, dpDigital[I + 1].pt.Y), MakePointF(dpDigital[I + 1].pt.X, dpDigital[I + 1].pt.Y));
          end
          else
          begin
            graphics.DrawPath(pen, path);
            path.Reset;
          end;
        end;
        graphics.DrawPath(pen, path);
        graphics.SetSmoothingMode(smt);
        path.Free;
        pen.Free;
        if Shadow then
        begin
          SetLength(ShadowPoints, Length(dpDigital));
          for i := 0 to Length(dpDigital) - 1 do
          begin
            ShadowPoints[i].X := GetDrawPoint(i).X + 3;
            ShadowPoints[i].Y := GetDrawPoint(i).Y + 3;
          end;
          path := TGPGraphicsPath.Create;
          path.AddLines(PGPPoint(dpDigital), Length(dpDigital));
          pen := TGPPen.Create(MakeColor(180,clGray), 3 * ScaleX);
          pen.SetDashStyle(DashStyle(PenStyle));
          graphics.SetSmoothingMode(SmoothingModeAntiAlias);
          graphics.DrawPath(pen, path);
          path.Free;
          pen.Free;
        end;
        graphics.Free;
        DrawValuesDP := drawPoints;
      end;
      ctLine, ctXYLine:
      begin
        graphics := TGPGraphics.Create(Canvas.Handle);
        col := ColorToRGB(LineColor);
        cb := (col AND $FF0000) shr 16;
        cg := (col AND $FF00) shr 8;
        cr := (col AND $FF);
        pen := TGPPen.Create(MakeColor(Opacity,cr,cg,cb), LineWidth * ScaleX);
        pen.SetDashStyle(DashStyle(PenStyle));
        graphics.SetSmoothingMode(SmoothingModeAntiAlias);
        if Enable3D then
        begin
          for I := 0 to Length(DrawPoints) - 2 do
          begin
            SetLength(arr3D, 4);
            if dm then
            begin
              arr3D[0] := Point(DrawPoints[I].X, DrawPoints[I].Y);
              arr3D[1] := Point(DrawPoints[I].X + Offset3D, DrawPoints[I].Y + Offset3D);
              arr3D[2] := Point(DrawPoints[I + 1].X + Offset3D, DrawPoints[I + 1].Y + Offset3D);
              arr3D[3] := Point(DrawPoints[I + 1].X, DrawPoints[I + 1].Y);
            end
            else
            begin
              arr3D[0] := Point(DrawPoints[I].X, DrawPoints[I].Y);
              arr3D[1] := Point(DrawPoints[I].X + Offset3D, DrawPoints[I].Y - Offset3D);
              arr3D[2] := Point(DrawPoints[I + 1].X + Offset3D, DrawPoints[I + 1].Y - Offset3D);
              arr3D[3] := Point(DrawPoints[I + 1].X, DrawPoints[I + 1].Y);
            end;
            path := TGPGraphicsPath.Create;
            path.AddLines(PGPPoint(arr3D), Length(arr3D));
            path.CloseFigure;
            fp.Graphics := graphics;
            fp.Path := path;
            fp.Fillpath := true;
            fp.R := MakeRect(Chart.Series.SeriesRectangle.Left, Chart.Series.SeriesRectangle.Top,
              Chart.Series.SeriesRectangle.Right - Chart.Series.SeriesRectangle.Left, Chart.Series.SeriesRectangle.Bottom - Chart.Series.SeriesRectangle.Top);
            fp.OpacityFrom := Opacity;
            fp.OpacityTo := OpacityTo;
            fp.GT := GradientType;
            fp.ColorFrom := Color;
            fp.ColorTo := ColorTo;
            fp.Angle := Angle;
            fp.HatchStyle := HatchStyle;
            fp.BorderColor := BorderColor;
            fp.BorderWidth := BorderWidth;
            fp.BorderStyle := DashStyle(PenStyle);
            fp.Image := ChartPattern;
            FillGDIP(fp);
            path.Free;
          end;
        end;
        {
        path := TGPGraphicsPath.Create;
        path.AddLines(PGPPoint(DrawPoints), Length(DrawPoints));
        graphics.DrawPath(pen, path);
        path.Free;
        }
        serier := Chart.Series.SeriesRectangle;
        for I := 0 to Length(DrawPoints) - 2 do
        begin
          chartpt := GetChartPointFromDrawPoint(I);
          chartpt2 := GetChartPointFromDrawPoint(I + 1);
          if ((chartpt.Defined and chartpt2.Defined)) {or (ChartType = ctXYLine)} then
          begin
            dpr := DrawPoints[I];
            dpr1 := DrawPoints[I + 1];

            if dpr.Y = serier.Top - Chart.XAxis.TopLineSize then
              dpr.Y := dpr.Y + 1
            else if dpr.Y = serier.Bottom + Chart.XAxis.BottomLineSize then
              dpr.Y := dpr.Y - 1;

            if dpr1.Y = serier.Top - Chart.XAxis.TopLineSize then
              dpr1.Y := dpr1.Y + 1
            else if dpr1.Y = serier.Bottom + Chart.XAxis.BottomLineSize then
              dpr1.Y := dpr1.Y - 1;

            if dpr.X = serier.Left - Chart.YAxis.LeftLineSize then
              dpr.X := dpr.X + 1
            else if dpr.X = serier.Right + Chart.YAxis.RightLineSize then
              dpr.X := dpr.X - 1;

            if dpr1.X = serier.Left - Chart.YAxis.LeftLineSize then
              dpr1.X := dpr1.X + 1
            else if dpr1.X = serier.Right + Chart.YAxis.RightLineSize then
              dpr1.X := dpr1.X - 1;

            graphics.DrawLine(pen, dpr.X, dpr.Y, dpr1.X, dpr1.Y)
          end;
        end;

        pen.Free;
        if Shadow then
        begin
          SetLength(ShadowPoints, Length(DrawPoints));
          for i := 0 to Length(DrawPoints) - 1 do
          begin
            ShadowPoints[i].X := GetDrawPoint(i).X + 3;
            ShadowPoints[i].Y := GetDrawPoint(i).Y + 3;
          end;
          path := TGPGraphicsPath.Create;
          path.AddLines(PGPPoint(ShadowPoints), Length(ShadowPoints));
          pen := TGPPen.Create(MakeColor(180,clGray), 3 * ScaleX);
          pen.SetDashStyle(DashStyle(PenStyle));
          graphics.SetSmoothingMode(SmoothingModeAntiAlias);
          graphics.DrawPath(pen, path);
          path.Free;
          pen.Free;
        end;
        graphics.Free;
        DrawValuesDP := drawPoints;
      end;
      ctBubble, ctScaledBubble:
      begin
        graphics := TGPGraphics.Create(Canvas.Handle);
        graphics.SetSmoothingMode(SmoothingModeAntiAlias);
        for i := 0 to Length(DrawPoints) - 1 do
        begin
          dp1 := GetDrawPoint(i);
          if rf < 0 then
            xp := i
          else
            xp := i + rf;
          case Charttype of
          ctBubble:
            begin
              rct := MakeRect(dp1.X - GetPoint(xp).PixelValue1 * ScaleX, dp1.Y - GetPoint(xp).PixelValue2 * ScaleY, GetPoint(xp).PixelValue1 * 2 * ScaleX, GetPoint(xp).PixelValue2 * 2 * ScaleY);
            end;
          ctScaledBubble:                   
            begin
              valueX := ValueToY(YToValue(dp1.X, R) + Round(GetPoint(xp).PixelValue2 * ScaleX), R);
              valuexStart := ValueToY(YToValue(dp1.X, R) - Round(GetPoint(xp).PixelValue2 * ScaleX), R);
              valueY := ValueToY(YToValue(dp1.Y, R) + Round(GetPoint(xp).PixelValue1 * ScaleY), R);
              valueystart := ValueToY(YToValue(dp1.Y, R) - Round(GetPoint(xp).PixelValue1 * ScaleY), R);
              rct := MakeRect(valuexstart, valueystart, valuex, valuey);
              Canvas.Ellipse(valuexstart, valueystart, valuex, valuey);
            end;
          end;
          path := TGPGraphicsPath.Create;
          path.AddEllipse(rct);
          path.CloseFigure;
          fp.Graphics := graphics;
          fp.Path := path;
          fp.Fillpath := true;
          fp.R := rct;
          fp.OpacityFrom := Opacity;
          fp.OpacityTo := OpacityTo;
          fp.GT := GradientType;
          fp.ColorFrom := Color;
          fp.ColorTo := ColorTo;
          fp.Angle := Angle;
          fp.HatchStyle := HatchStyle;
          fp.BorderColor := BorderColor;
          fp.BorderWidth := BorderWidth;
          fp.BorderStyle := DashStyle(PenStyle);
          fp.Image := ChartPattern;
          FillGDIP(fp);
          path.Free;
        end;
        graphics.Free;
        DrawValuesDP := drawPoints;
      end;
      ctArrow, ctScaledArrow:
      begin
        graphics := TGPGraphics.Create(Canvas.Handle);
        graphics.SetSmoothingMode(SmoothingModeAntiAlias);
        for I := 0 to Length(DrawPoints) - 1 do
        begin
          dp1 := GetDrawPoint(I);
          if rf < 0 then
            XPos := I
          else
            XPos := I + rf;
          valuex := 0;
          valuey := 0;
          case ChartType of
            ctScaledArrow:
            begin
              valuex := ValueToY(YToValue(dp1.X, R) - Round(GetPoint(XPos).PixelValue2 * ScaleX), R);
              valuey := ValueToY(YToValue(dp1.Y, R) + Round(GetPoint(XPos).PixelValue1 * ScaleY), R);
            end;
            ctArrow:
            begin
              valueY := dp1.Y - Round(GetPoint(XPos).PixelValue1 * ScaleY);
              valueX := dp1.X + Round(GetPoint(XPos).PixelValue2 * ScaleX);
            end;
          end;
          path := TGPGraphicsPath.Create;
          pen := TGPPen.Create(MakeColor(255,LineColor), LineWidth * ScaleX);
          pen.SetDashStyle(DashStyle(PenStyle));
          path.AddLine(valuex,valuey,dp1.X,dp1.Y);
          path.CloseFigure;
          graphics.DrawPath(pen, path);
          path.Free;
          pen.Free;
          ArrowGDIP(graphics, Point(valuex, valuey), Point(dp1.X,dp1.Y), ArrowSize, ArrowColor, ScaleX, ScaleY);
        end;
        graphics.Free;
        DrawValuesDP := drawPoints;
      end;
      ctBand, ctArea, ctStackedArea, ctStackedPercArea:
      begin
        cntstperc := 0;
        cntst := 0;
        for I := 0 to Chart.Series.Count - 1 do
        begin
          with Chart.Series.Items[I] do
          begin
            if ChartType in [ctStackedPercArea] then
              Inc(cntstperc);
            if ChartType in [ctStackedArea] then
              Inc(cntst);
          end;
        end;
        z := ValueToY(ZeroReferencePoint,R);
        pci := Chart.Series.GetPreviousChartIndex(ChartType, Index, GroupIndex);
        s := nil;
        if (Index > 0) and (pci <> -1) then
        begin
          if ((ChartType in [ctStackedArea]) and (cntst > 1)) or ((ChartType in [ctStackedPercArea]) and (cntstperc > 1)) then
          begin
            s := Chart.Series.Items[pci];
            hsdp := High(s.DrawPoints);
            for I := 0 to High(DrawPoints) do
            begin
              SetLength(dp, I + 1);
              SetLength(dpline, I + 1);
              if (ChartType = ctStackedPercArea) and (Index = cntstperc - 1) then //FINAL SERIE FORCE MAX VALUES
              begin
                if dm then
                begin
                  if (I = High(DrawPoints) - 1) or (I = High(DrawPoints)) then
                    pnt := Point(s.StackedPointsArea[I].X + (GetDrawPoint(i).X - z), GetDrawPoint(i).Y)
                  else
                    pnt := Point(ValueToY(100, R), GetDrawPoint(i).Y);
                end
                else
                begin
                  if (I = High(DrawPoints) - 1) or (I = High(DrawPoints)) then
                    pnt := Point(GetDrawPoint(i).X, s.StackedPointsArea[I].Y + (GetDrawPoint(i).Y - z))
                  else
                    pnt := Point(GetDrawPoint(i).X, ValueToY(100, R));
                end;
              end
              else
              begin
                if dm then
                  pnt := Point(s.StackedPointsArea[I].X + (GetDrawPoint(i).X - z), GetDrawPoint(i).Y)
                else
                  pnt := Point(GetDrawPoint(i).X, s.StackedPointsArea[I].Y + (GetDrawPoint(i).Y - z));
              end;
              dp[I] := pnt;
              dpline[I] := pnt;
            end;
            for I := 0 to hsdp do
            begin
              SetLength(dp, hsdp + I + 2);
              if dm then
                pnt := Point(s.StackedPointsArea[I].X, GetDrawPoint(i).Y)
              else
                pnt := Point(GetDrawPoint(i).X, s.StackedPointsArea[I].Y);
              dp[hsdp + I + 1] := pnt;
            end;
          end
          else
          begin
            for I := 0 to High(DrawPoints) do
            begin
              SetLength(dp, I + 1);
              SetLength(dpline, I + 1);
              pnt := Point(GetDrawPoint(i).X, GetDrawPoint(i).Y);
              dp[I] := pnt;
              dpline[I] := pnt;
            end;
          end;
        end
        else
        begin
          for I := 0 to High(DrawPoints) do
          begin
            SetLength(dp, I + 1);
            SetLength(dpline, I + 1);
            pnt := Point(GetDrawPoint(i).X, GetDrawPoint(i).Y);
            dp[I] := pnt;
            dpline[I] := pnt;
          end;
        end;
        SetStackedPointsAreaLength(0);
        for I := 0 to High(dp) do
        begin
          SetStackedPointsAreaLength(I + 1);
          pnt := Point(dp[I].X, dp[I].Y);
          StackedPointsArea[I] := pnt;
        end;
      graphics := TGPGraphics.Create(Canvas.Handle);
      graphics.SetSmoothingMode(SmoothingModeAntiAlias);
      if IsEnabled3D then
      begin
        if (ChartType <> ctArea) and (ChartType <> ctBand) and (pci <> -1) then
          dpc := (Length(dp) div 2) - 4
        else if (chartType <> ctBand) then
          dpc := Length(dp) - 3
        else //Band
          dpc := Length(dp) - 2;
        Draw3Dpolygons(graphics, 0, dpc, MakeRect(r.Left,r.Top,r.Right - r.Left,r.Bottom - r.Top), dp, pci, s, Scalex, ScaleY)
      end;
      if Shadow then
      begin
        path := TGPGraphicsPath.Create;
        SetLength(ShadowPoints, Length(dp) - 2);
        for i := 0 to Length(ShadowPoints) - 1 do
        begin
          ShadowPoints[i].X := dp[i].X + 2;
          ShadowPoints[i].Y := dp[i].Y - 2;
        end;
        path.AddLines(PGPPoint(ShadowPoints), Length(ShadowPoints));
        pen := TGPPen.Create(MakeColor(180,clGray), 4 * ScaleX);
        pen.SetDashStyle(DashStyle(PenStyle));
        path.CloseFigure;
        graphics.DrawPath(pen, path);
        pen.Free;
        path.Free;
      end;
      cntdef := 0;
      for I := 0 to GetPointsCount-1 do
      begin
        if not GetPoint(I).Defined then
          Inc(cntdef);
      end;
      if cntdef > 0 then
      begin
        SetLength(dppoly, 0);
        for I := 0 to Length(dp) - 1 do
        begin
          if (I >= 0) and (I < Length(dp) - 1) then
          begin
            pt := GetChartPointFromDrawPoint(I);
            if not pt.Defined then
            begin
              SetLength(dppoly,Length(dppoly) + 1);
              dppoly[Length(dppoly) - 1] := dppoly[Length(dppoly) - 2];
              dppoly[Length(dppoly) - 1].Y := z;
              SetLength(dppoly,Length(dppoly) + 1);
              dppoly[Length(dppoly) - 1] := dppoly[0];
              dppoly[Length(dppoly) - 1].Y := z;


              path := TGPGraphicsPath.Create;
              path.AddLines(PGPPoint(dppoly), Length(dppoly));
              path.CloseFigure;

              fp.Graphics := graphics;
              fp.Path := path;
              fp.Fillpath := true;
              fp.R := MakeRect(r.Left,r.Top,r.Right - r.Left,r.Bottom - r.Top);
              fp.OpacityFrom := Opacity;
              fp.OpacityTo := OpacityTo;
              fp.GT := GradientType;
              fp.ColorFrom := Color;
              fp.ColorTo := ColorTo;
              fp.Angle := Angle;
              fp.HatchStyle := HatchStyle;
              fp.BorderColor := clNone;
              fp.BorderWidth := 0;
              fp.Image := ChartPattern;
              fp.BorderStyle := DashStyle(PenStyle);

              FillGDIP(fp);

              path.Free;

              SetLength(dppoly, 0);
//              SetLength(dppoly,Length(dppoly) + 1);
//              dppoly[Length(dppoly) - 1] := dp[I];
//              dppoly[Length(dppoly) - 1].Y := z;

//              SetLength(dppoly,Length(dppoly) + 1);
//              dppoly[Length(dppoly) - 1] := dp[I];
            end
            else
            begin
              SetLength(dppoly,Length(dppoly) + 1);
              dppoly[Length(dppoly) - 1] := dp[I];
            end;
          end
          else
          begin
            SetLength(dppoly,Length(dppoly) + 1);
            dppoly[Length(dppoly) - 1] := dp[I];
          end;
        end;

        path := TGPGraphicsPath.Create;
        path.AddLines(PGPPoint(dppoly), Length(dppoly));
        path.CloseFigure;
        fp.Graphics := graphics;
        fp.Path := path;
        fp.Fillpath := true;
        fp.R := MakeRect(r.Left,r.Top,r.Right - r.Left,r.Bottom - r.Top);
        fp.OpacityFrom := Opacity;
        fp.OpacityTo := OpacityTo;
        fp.GT := GradientType;
        fp.ColorFrom := Color;
        fp.ColorTo := ColorTo;
        fp.Angle := Angle;
        fp.HatchStyle := HatchStyle;
        fp.BorderColor := clNone;
        fp.BorderWidth := 0;
        fp.Image := ChartPattern;
        fp.BorderStyle := DashStyle(PenStyle);
        FillGDIP(fp);
      
        col := ColorToRGB(LineColor);
        cb := (col AND $FF0000) shr 16;
        cg := (col AND $FF00) shr 8;
        cr := (col AND $FF);
        path.Free;

        SetLength(dppoly, 0);
        for I := 0 to Length(dp) - 2 do
        begin
          if (I >= 0) and (I < Length(dp) - 1) then
          begin
            pt := GetChartPointFromDrawPoint(I);
            if not pt.Defined then
            begin
              SetLength(dppoly,Length(dppoly) + 1);
              dppoly[Length(dppoly) - 1] := dppoly[Length(dppoly) - 2];
              dppoly[Length(dppoly) - 1].Y := z;
              SetLength(dppoly,Length(dppoly) + 1);
              dppoly[Length(dppoly) - 1] := dppoly[0];
              dppoly[Length(dppoly) - 1].Y := z;

              pen := TGPPen.Create(MakeColor(LineOpacity,cr,cg,cb), LineWidth * ScaleX);
              pen.SetDashStyle(DashStyle(PenStyle));

              path := TGPGraphicsPath.Create;
              path.AddLines(PGPPoint(dppoly), Length(dppoly));
              path.CloseFigure;

              graphics.DrawPath(pen, path);

              pen.Free;
              path.Free;

              SetLength(dppoly, 0);
//              SetLength(dppoly,Length(dppoly) + 1);
//              dppoly[Length(dppoly) - 1] := dp[I];
//              dppoly[Length(dppoly) - 1].Y := z;
//
//              SetLength(dppoly,Length(dppoly) + 1);
//              dppoly[Length(dppoly) - 1] := dp[I];
            end
            else
            begin
              SetLength(dppoly,Length(dppoly) + 1);
              dppoly[Length(dppoly) - 1] := dp[I];
            end;
          end
          else
          begin
            SetLength(dppoly,Length(dppoly) + 1);
            dppoly[Length(dppoly) - 1] := dp[I];
          end;
        end;

        pen := TGPPen.Create(MakeColor(LineOpacity,cr,cg,cb), LineWidth * ScaleX);
        pen.SetDashStyle(DashStyle(PenStyle));

        path := TGPGraphicsPath.Create;
        path.AddLines(PGPPoint(dppoly), Length(dppoly));
        path.CloseFigure;

        graphics.DrawPath(pen, path);

        pen.Free;
        path.Free;
      end
      else
      begin
        path := TGPGraphicsPath.Create;
        path.AddLines(PGPPoint(dp), Length(dp));
        path.CloseFigure;

        fp.Graphics := graphics;
        fp.Path := path;
        fp.Fillpath := true;
        fp.R := MakeRect(r.Left,r.Top,r.Right - r.Left,r.Bottom - r.Top);
        fp.OpacityFrom := Opacity;
        fp.OpacityTo := OpacityTo;
        fp.GT := GradientType;
        fp.ColorFrom := Color;
        fp.ColorTo := ColorTo;
        fp.Angle := Angle;
        fp.HatchStyle := HatchStyle;
        fp.BorderColor := clNone;
        fp.BorderWidth := 0;
        fp.Image := ChartPattern;
        fp.BorderStyle := DashStyle(PenStyle);

        FillGDIP(fp);

        col := ColorToRGB(LineColor);

        cb := (col AND $FF0000) shr 16;
        cg := (col AND $FF00) shr 8;
        cr := (col AND $FF);

        pen := TGPPen.Create(MakeColor(LineOpacity,cr,cg,cb), LineWidth * ScaleX);
        pen.SetDashStyle(DashStyle(PenStyle));

        path.Free;
        path := TGPGraphicsPath.Create;
        path.AddLines(PGPPoint(dp), Length(dp));
        path.CloseFigure;

        if not LinePointsOnly then        
          graphics.DrawPath(pen, path);

        if (ChartType = ctArea) then
        begin
          dp1 := dpline[Length(dpline) - 2];
          dp2 := dpline[Length(dpline) - 1];

          SetLength(dpline, Length(dpline) - 2);

          Canvas.Pen.Color := LineColor;
          Canvas.Pen.Width := Round(LineWidth * Scalex);

          path.Free;
          pen.Free;

          col := ColorToRGB(LineColor);
          cb := (col AND $FF0000) shr 16;
          cg := (col AND $FF00) shr 8;
          cr := (col AND $FF);

          pen := TGPPen.Create(MakeColor(LineOpacity, cr, cg, cb), LineWidth * ScaleX);
          pen.SetDashStyle(DashStyle(PenStyle));

          path := TGPGraphicsPath.Create;
          path.AddLines(PGPPoint(dpline), Length(dpline));

          graphics.DrawPath(pen, path);

          SetLength(dpline, Length(dpline) + 2);
          dpline[Length(dpline) - 2] := dp1;
          dpline[Length(dpline) - 1] := dp2;

        end;
        pen.Free;
        path.Free;
      end;

      graphics.Free;

      DrawValuesDP := StackedPointsArea;
    end;
    else
      begin
        IsDrawing := false;
        inherited;
      end;
    end;
  end;
  IsDrawing := false;
  if Assigned(OnSerieDrawPoint) then
  begin
    for I := 0 to Length(DrawPoints) - 1 do
    begin
      if Chart.Range.RangeFrom < 0 then
        XPos := I
      else
        XPos := I + Chart.Range.RangeFrom;
      OnSerieDrawPoint(Self, Canvas, DrawValuesDP[I], GetChartPoint(XPos));
    end;
  end;
end;
procedure TAdvGDIPChartSerie.Draw3DBar(canvas: TCanvas; SColor,
  SColorTo: TColor; dr: TRect; ScaleX, ScaleY: Double);
var
  arr3D: TPointArray;
  r: TRect;
  graphics: TGPGraphics;
  fp: TGDIPFillParameters;
  path: TGPGraphicsPath;
  dm: Boolean;
begin
  graphics := TGPGraphics.Create(Canvas.Handle);
  graphics.SetSmoothingMode(SmoothingModeAntiAlias);
  r := DR;
  fp.Graphics := graphics;
  fp.Fillpath := true;
  dm := Chart.Series.IsHorizontal;
  if dm then
  begin
    if DR.Left > DR.Right then
      fp.R := MakeRect(r.Right, r.Top, r.Left - r.Right, r.Bottom - r.Top)
    else
      fp.R := MakeRect(r.Left, r.Top, r.Right - r.Left, r.Bottom - r.Top);
  end
  else
  begin
    if DR.Top > DR.Bottom then
      fp.R := MakeRect(r.Left, r.Bottom, r.Right - r.Left, r.Top - r.Bottom)
    else
      fp.R := MakeRect(r.Left, r.Top, r.Right - r.Left, r.Bottom - r.Top);
  end;
  r := Bounds(Round(fp.R.X), Round(fp.R.Y), Round(fp.R.Width), Round(FP.R.Height));
  SetLength(arr3D, 5);
  if dm then
  begin
    arr3D[0] := Point(r.Right, r.Top);
    arr3D[1] := Point(r.Right + Get3DOffset, r.Top + Get3DOffset);
    arr3D[2] := Point(r.Right + Get3DOffset, r.Bottom + Get3DOffset);
    arr3D[3] := Point(r.Right, r.Bottom);
  end
  else
  begin
    arr3D[0] := Point(r.Right, r.Top);
    arr3D[1] := Point(r.Right + Get3DOffset, r.Top - Get3DOffset);
    arr3D[2] := Point(r.Right + Get3DOffset, r.Bottom - Get3DOffset);
    arr3D[3] := Point(r.Right, r.Bottom);
  end;
  arr3D[4] := arr3D[0];
  path := TGPGraphicsPath.Create;
  path.AddLines(PGPPoint(arr3D), Length(arr3D));
  fp.R := MakeRect(r.Right, r.Top - Get3DOffset, Get3DOffset, (r.Bottom - R.Top) + Get3DOffset);
  fp.Path := path;
  fp.GT := GradientType;
  if Darken3D then
  begin
    fp.ColorFrom := DarkenColor(SColor, Darken3D);
    fp.ColorTo := DarkenColor(SColorto, Darken3D);
  end;
  fp.OpacityFrom := Opacity;
  fp.OpacityTo := OpacityTo;
  fp.Angle := Angle;
  fp.HatchStyle := HatchStyle;
  fp.BorderColor := BorderColor;
  fp.BorderWidth := BorderWidth;
  fp.Image := ChartPattern;
  fp.BorderStyle := DashStyle(PenStyle);
  FillGDIP(fp);
  path.Free;
  SetLength(arr3D, 5);
  if dm then
  begin
    arr3D[0] := Point(r.Left, r.Bottom);
    arr3D[1] := Point(r.Right, r.Bottom);
    arr3D[2] := Point(r.Right + Get3DOffset, r.Bottom + Get3DOffset);
    arr3D[3] := Point(r.Left + Get3DOffset, r.Bottom + Get3DOffset);
  end
  else
  begin
    arr3D[0] := Point(r.Left, r.Top);
    arr3D[1] := Point(r.Right, r.Top);
    arr3D[2] := Point(r.Right + Get3DOffset, r.Top - Get3DOffset);
    arr3D[3] := Point(r.Left + Get3DOffset, r.Top - Get3DOffset);
  end;
  arr3D[4] := arr3D[0];
  path := TGPGraphicsPath.Create;
  path.AddLines(PGPPoint(arr3D), Length(arr3D));
  fp.R := MakeRect(r.Left - Get3DOffset, r.Top - Get3DOffset, (r.Right - R.Left) +  Get3DOffset * 2, Get3DOffset  * 2);
  fp.Path := path;
  fp.GT := GradientType;
  fp.ColorFrom := DarkenColor(SColor, Darken3D);
  fp.ColorTo := DarkenColor(SColorto, Darken3D);
  fp.OpacityFrom := Opacity;
  fp.OpacityTo := OpacityTo;
  fp.Angle := Angle;
  fp.HatchStyle := HatchStyle;
  fp.BorderColor := BorderColor;
  fp.BorderWidth := BorderWidth;
  fp.Image := ChartPattern;
  fp.BorderStyle := DashStyle(PenStyle);
  FillGDIP(fp);
  path.Free;
  graphics.Free;
end;
procedure TAdvGDIPChartSerie.Draw3DPolygons(g: TGPGraphics; dpcfrom,
  dpcto: integer; rct: TGPRectF; dp: TPointArray; pci: integer; s: TChartSerie; ScaleX,
  ScaleY: Double);
var
  i: integer;
  pntinter: TPointCheck;
  firstfound, lastfound: Boolean;
  pnt3D, arr3DFirst, arr3Dlast: TPoint;
  arr3D: TPointArray;
  path: TGPGraphicsPath;
  fp: TGDIPFillParameters;
  dm: Boolean;
begin
  dm := Chart.Series.IsHorizontal;
  SetLength(arr3D, 4);
  firstfound := false;
  lastfound := false;
  //search for first point
  if dm then
  begin
    for I := 0 to dpcto do
    begin
      if (ChartType = ctArea) then
      begin
        if (I = 0) and (dp[0].X >= ValueToY(0, Chart.Series.SeriesRectangle)) then
        begin
          pntinter.valid := true;
          pntinter.pt := Point(ValueToY(0, Chart.Series.SeriesRectangle), dp[0].Y);
          firstfound := true;
          arr3DFirst := Point(pntinter.pt.X, pntinter.pt.Y);
        end;
      end;
    end;
  end
  else
  begin
    for I := 0 to dpcto do
    begin
      if (ChartType = ctArea) then
      begin
        if (I = 0) and (dp[0].Y >= ValueToY(0, Chart.Series.SeriesRectangle)) then
        begin
          pntinter.valid := true;
          pntinter.pt := Point(dp[0].X, ValueToY(0, Chart.Series.SeriesRectangle));
          firstfound := true;
          arr3DFirst := Point(pntinter.pt.X, pntinter.pt.Y);
        end;
      end;
    end;
  end;
  if dm then
  begin
    if ChartType = ctBand then
    begin
      for I := dpcfrom to dpcto div 2 do
      begin
        arr3D[0] := Point(dp[I].X, dp[I].Y);
        arr3D[1] := Point(dp[I].X + Get3DOffset, dp[I].Y + Get3DOffset);
        arr3D[2] := Point(dp[I + 1].X + Get3DOffset, dp[I + 1].Y + Get3DOffset);
        arr3D[3] := Point(dp[I + 1].X, dp[I + 1].Y);
        path := TGPGraphicsPath.Create;
        path.AddPolygon(PGPPoint(arr3D), Length(Arr3D));
        path.CloseFigure;
        fp.Graphics := g;
        fp.Path := path;
        fp.Fillpath := true;
        fp.R := rct;
        fp.OpacityFrom := Opacity;
        fp.OpacityTo := OpacityTo;
        fp.GT := GradientType;
        fp.ColorFrom := DarkenColor(Color, Darken3D);
        fp.ColorTo := DarkenColor(Colorto, Darken3D);
        fp.Angle := Angle;
        fp.HatchStyle := HatchStyle;
        fp.BorderColor := BorderColor;
        fp.BorderWidth := BorderWidth;
        fp.BorderStyle := DashStyle(PenStyle);
        fp.Image := ChartPattern;
        FillGDIP(fp);
        path.Free;
      end;
      for I := dpcto downto dpcto div 2  do
      begin
        arr3D[0] := Point(dp[I].X, dp[I].Y);
        arr3D[1] := Point(dp[I].X + Get3DOffset, dp[I].Y + Get3DOffset);
        arr3D[2] := Point(dp[I + 1].X + Get3DOffset, dp[I + 1].Y + Get3DOffset);
        arr3D[3] := Point(dp[I + 1].X, dp[I + 1].Y);
        path := TGPGraphicsPath.Create;
        path.AddPolygon(PGPPoint(arr3D), Length(Arr3D));
        path.CloseFigure;
        fp.Graphics := g;
        fp.R := rct;
        fp.Path := path;
        fp.Fillpath := true;
        fp.OpacityFrom := Opacity;
        fp.OpacityTo := OpacityTo;
        fp.GT := GradientType;
        fp.ColorFrom := DarkenColor(Color, Darken3D);
        fp.ColorTo := DarkenColor(Colorto, Darken3D);
        fp.Angle := Angle;
        fp.HatchStyle := HatchStyle;
        fp.BorderColor := BorderColor;
        fp.BorderWidth := BorderWidth;
        fp.BorderStyle := DashStyle(PenStyle);
        fp.Image := ChartPattern;
        FillGDIP(fp);
        path.Free;
      end;
    end
    else
    begin
      for I := dpcfrom to dpcto do
      begin
        if (ChartType = ctArea) then
        begin
          TAdvGDIPChart(Chart).FindInterSection(dp[I + 1], dp[I],
            Point(ValueToY(0, Chart.Series.SeriesRectangle),Chart.Series.SeriesRectangle.Bottom),
            Point(ValueToY(0, Chart.Series.SeriesRectangle), Chart.Series.SeriesRectangle.Top), pntinter);

          if pntinter.valid then
          begin
            if not firstfound then
            begin
              firstfound := true;
              arr3Dfirst := Point(pntinter.pt.X, pntinter.pt.Y);
            end
            else if not lastfound then
            begin
              lastfound := true;
              arr3Dlast := Point(pntinter.pt.X, pntinter.pt.Y);
            end;
          end;
          if firstfound and lastfound then
          begin
            firstfound := false;
            lastfound := false;
            SetLength(arr3D, 4);
            arr3D[0] := arr3Dfirst;
            arr3D[1] := Point(arr3DFirst.X + Get3DOffset, arr3Dfirst.Y + Get3DOffset);
            arr3D[2] := Point(arr3Dlast.X + Get3DOffset, arr3Dlast.Y + Get3DOffset);
            arr3D[3] := arr3Dlast;
            path := TGPGraphicsPath.Create;
            path.AddPolygon(PGPPoint(arr3D), Length(Arr3D));
            path.CloseFigure;
            fp.Graphics := g;
            fp.R := rct;
            fp.Path := path;
            fp.Fillpath := true;
            fp.OpacityFrom := Opacity;
            fp.OpacityTo := OpacityTo;
            fp.GT := GradientType;
            fp.ColorFrom := DarkenColor(Color, Darken3D);
            fp.ColorTo := DarkenColor(Colorto, Darken3D);
            fp.Angle := Angle;
            fp.HatchStyle := HatchStyle;
            fp.BorderColor := BorderColor;
            fp.BorderWidth := BorderWidth;
            fp.BorderStyle := DashStyle(PenStyle);
            fp.Image := ChartPattern;
            FillGDIP(fp);
            path.Free;
          end;
        end;
        arr3D[0] := Point(dp[I].X, dp[I].Y);
        arr3D[1] := Point(dp[I].X + Get3DOffset, dp[I].Y + Get3DOffset);
        arr3D[2] := Point(dp[I + 1].X + Get3DOffset, dp[I + 1].Y + Get3DOffset);
        arr3D[3] := Point(dp[I + 1].X, dp[I + 1].Y);
        path := TGPGraphicsPath.Create;
        path.AddPolygon(PGPPoint(arr3D), Length(Arr3D));
        path.CloseFigure;
        fp.R := rct;
        fp.Graphics := g;
        fp.Path := path;
        fp.Fillpath := true;
        fp.OpacityFrom := Opacity;
        fp.OpacityTo := OpacityTo;
        fp.GT := GradientType;
        fp.ColorFrom := DarkenColor(Color, Darken3D);
        fp.ColorTo := DarkenColor(Colorto, Darken3D);
        fp.Angle := Angle;
        fp.HatchStyle := HatchStyle;
        fp.BorderColor := BorderColor;
        fp.BorderWidth := BorderWidth;
        fp.BorderStyle := DashStyle(PenStyle);
        fp.Image := ChartPattern;
        FillGDIP(fp);
        path.Free;
      end;
      if (chartType <> ctBand) and (ChartType <> ctArea) and (pci <> -1) and (s <> nil) then
      begin
        //draw final point linking to previous serie
        arr3D[0] := Point(dp[Length(dp) div 2 - 3].X, dp[Length(dp) div 2 - 3].Y);
        arr3D[1] := Point(dp[Length(dp) div 2 - 3].X + Get3DOffset, dp[Length(dp) div 2 - 3].Y + Get3DOffset);
        pnt3D := s.StackedPointsArea[Length(s.DrawPoints) - 3];
        arr3D[2] := Point(pnt3D.X + Get3DOffset, pnt3D.Y + Get3DOffset);
        arr3D[3] := Point(pnt3D.X, pnt3D.Y);
        path := TGPGraphicsPath.Create;
        path.AddPolygon(PGPPoint(arr3D), Length(Arr3D));
        path.CloseFigure;
        fp.Graphics := g;
        fp.Path := path;
        fp.Fillpath := true;
        fp.R := rct;
        fp.OpacityFrom := Opacity;
        fp.OpacityTo := OpacityTo;
        fp.GT := GradientType;
        fp.ColorFrom := DarkenColor(Color, Darken3D);
        fp.ColorTo := DarkenColor(Colorto, Darken3D);
        fp.Angle := Angle;
        fp.HatchStyle := HatchStyle;
        fp.BorderColor := BorderColor;
        fp.BorderWidth := BorderWidth;
        fp.BorderStyle := DashStyle(PenStyle);
        fp.Image := ChartPattern;
        FillGDIP(fp);
        path.Free;
      end;
    end;
  end
  else
  begin
    if ChartType = ctBand then
    begin
      for I := dpcfrom to dpcto div 2 do
      begin
        arr3D[0] := Point(dp[I].X, dp[I].Y);
        arr3D[1] := Point(dp[I].X + Get3DOffset, dp[I].Y - Get3DOffset);
        arr3D[2] := Point(dp[I + 1].X + Get3DOffset, dp[I + 1].Y - Get3DOffset);
        arr3D[3] := Point(dp[I + 1].X, dp[I + 1].Y);
        path := TGPGraphicsPath.Create;
        path.AddPolygon(PGPPoint(arr3D), Length(Arr3D));
        path.CloseFigure;
        fp.Graphics := g;
        fp.Path := path;
        fp.Fillpath := true;
        fp.R := rct;
        fp.OpacityFrom := Opacity;
        fp.OpacityTo := OpacityTo;
        fp.GT := GradientType;
        fp.ColorFrom := DarkenColor(Color, Darken3D);
        fp.ColorTo := DarkenColor(Colorto, Darken3D);
        fp.Angle := Angle;
        fp.HatchStyle := HatchStyle;
        fp.BorderColor := BorderColor;
        fp.BorderWidth := BorderWidth;
        fp.BorderStyle := DashStyle(PenStyle);
        fp.Image := ChartPattern;
        FillGDIP(fp);
        path.Free;
      end;
      for I := dpcto downto dpcto div 2 do
      begin
        arr3D[0] := Point(dp[I].X, dp[I].Y);
        arr3D[1] := Point(dp[I].X + Get3DOffset, dp[I].Y - Get3DOffset);
        arr3D[2] := Point(dp[I + 1].X + Get3DOffset, dp[I + 1].Y - Get3DOffset);
        arr3D[3] := Point(dp[I + 1].X, dp[I + 1].Y);
        path := TGPGraphicsPath.Create;
        path.AddPolygon(PGPPoint(arr3D), Length(Arr3D));
        path.CloseFigure;
        fp.Graphics := g;
        fp.R := rct;
        fp.Path := path;
        fp.Fillpath := true;
        fp.OpacityFrom := Opacity;
        fp.OpacityTo := OpacityTo;
        fp.GT := GradientType;
        fp.ColorFrom := DarkenColor(Color, Darken3D);
        fp.ColorTo := DarkenColor(Colorto, Darken3D);
        fp.Angle := Angle;
        fp.HatchStyle := HatchStyle;
        fp.BorderColor := BorderColor;
        fp.BorderWidth := BorderWidth;
        fp.BorderStyle := DashStyle(PenStyle);
        fp.Image := ChartPattern;
        FillGDIP(fp);
        path.Free;
      end;
    end
    else
    begin
      for I := dpcfrom to dpcto do
      begin
        if (ChartType = ctArea) then
        begin
          TAdvGDIPChart(Chart).FindInterSection(dp[I + 1], dp[I],
              Point(Chart.Series.SeriesRectangle.right, ValueToY(0, Chart.Series.SeriesRectangle)),
              Point(Chart.Series.SeriesRectangle.Left, ValueToY(0, Chart.Series.SeriesRectangle)), pntinter);
          if pntinter.valid then
          begin
            if not firstfound then
            begin
              firstfound := true;
              arr3Dfirst := Point(pntinter.pt.X, pntinter.pt.Y);
            end
            else if not lastfound then
            begin
              lastfound := true;
              arr3Dlast := Point(pntinter.pt.X, pntinter.pt.Y);
            end;
          end;
          if firstfound and lastfound then
          begin
            firstfound := false;
            lastfound := false;
            SetLength(arr3D, 4);
            arr3D[0] := arr3Dfirst;
            arr3D[1] := Point(arr3DFirst.X + Get3DOffset, arr3Dfirst.Y - Get3DOffset);
            arr3D[2] := Point(arr3Dlast.X + Get3DOffset, arr3Dlast.Y - Get3DOffset);
            arr3D[3] := arr3Dlast;
            path := TGPGraphicsPath.Create;
            path.AddPolygon(PGPPoint(arr3D), Length(Arr3D));
            path.CloseFigure;
            fp.Graphics := g;
            fp.R := rct;
            fp.Path := path;
            fp.Fillpath := true;
            fp.OpacityFrom := Opacity;
            fp.OpacityTo := OpacityTo;
            fp.GT := GradientType;
            fp.ColorFrom := DarkenColor(Color, Darken3D);
            fp.ColorTo := DarkenColor(Colorto, Darken3D);
            fp.Angle := Angle;
            fp.HatchStyle := HatchStyle;
            fp.BorderColor := BorderColor;
            fp.BorderWidth := BorderWidth;
            fp.BorderStyle := DashStyle(PenStyle);
            fp.Image := ChartPattern;
            FillGDIP(fp);
            path.Free;
          end;
        end;
        arr3D[0] := Point(dp[I].X, dp[I].Y);
        arr3D[1] := Point(dp[I].X + Get3DOffset, dp[I].Y - Get3DOffset);
        arr3D[2] := Point(dp[I + 1].X + Get3DOffset, dp[I + 1].Y - Get3DOffset);
        arr3D[3] := Point(dp[I + 1].X, dp[I + 1].Y);
        path := TGPGraphicsPath.Create;
        path.AddPolygon(PGPPoint(arr3D), Length(Arr3D));
        path.CloseFigure;
        fp.R := rct;
        fp.Graphics := g;
        fp.Path := path;
        fp.Fillpath := true;
        fp.OpacityFrom := Opacity;
        fp.OpacityTo := OpacityTo;
        fp.GT := GradientType;
        fp.ColorFrom := DarkenColor(Color, Darken3D);
        fp.ColorTo := DarkenColor(Colorto, Darken3D);
        fp.Angle := Angle;
        fp.HatchStyle := HatchStyle;
        fp.BorderColor := BorderColor;
        fp.BorderWidth := BorderWidth;
        fp.BorderStyle := DashStyle(PenStyle);
        fp.Image := ChartPattern;
        FillGDIP(fp);
        path.Free;
      end;
      if (chartType <> ctBand) and (ChartType <> ctArea) and (pci <> -1) and (s <> nil) then
      begin
        //draw final point linking to previous serie
        arr3D[0] := Point(dp[Length(dp) div 2 - 3].X, dp[Length(dp) div 2 - 3].Y);
        arr3D[1] := Point(dp[Length(dp) div 2 - 3].X + Get3DOffset, dp[Length(dp) div 2 - 3].Y - Get3DOffset);
        pnt3D := s.StackedPointsArea[Length(s.DrawPoints) - 3];
        arr3D[2] := Point(pnt3D.X + Get3DOffset, pnt3D.Y - Get3DOffset);
        arr3D[3] := Point(pnt3D.X, pnt3D.Y);
        path := TGPGraphicsPath.Create;
        path.AddPolygon(PGPPoint(arr3D), Length(Arr3D));
        path.CloseFigure;
        fp.Graphics := g;
        fp.Path := path;
        fp.Fillpath := true;
        fp.R := rct;
        fp.OpacityFrom := Opacity;
        fp.OpacityTo := OpacityTo;
        fp.GT := GradientType;
        fp.ColorFrom := DarkenColor(Color, Darken3D);
        fp.ColorTo := DarkenColor(Colorto, Darken3D);
        fp.Angle := Angle;
        fp.HatchStyle := HatchStyle;
        fp.BorderColor := BorderColor;
        fp.BorderWidth := BorderWidth;
        fp.BorderStyle := DashStyle(PenStyle);
        fp.Image := ChartPattern;
        FillGDIP(fp);
        path.Free;
      end;
    end;
  end;
end;
procedure TAdvGDIPChartSerie.DrawBar(Canvas: TCanvas; SColor, SColorTo: TColor; dr: TRect; ScaleX, ScaleY: Double; Idx: integer; Val: Double);
var
  graphics: TGPGraphics;
  fp: TGDIPFillParameters;
  r: TRect;
  str: String;
  rf, xpos: integer;
  al: TAlignment;
  ft, tf: TFont;
  lf: TLogFontW;
  th, tw, x, y: integer;
  DStyle: Word;
begin
  graphics := TGPGraphics.Create(Canvas.Handle);
  graphics.SetSmoothingMode(SmoothingModeAntiAlias);
  r := DR;
  if (BarShape = bsCylinder) and (ChartType <> ctBoxPlot) then
  begin
    FillCylinder(graphics, r, SColor, SColorTo, idx, Val, ScaleX, ScaleY);
  end
  else if (BarShape = bsPyramid)  and (ChartType <> ctBoxPlot) then
  begin
    FillPyramid(graphics, SColor, SColorTo, DR, ScaleX, ScaleY, Idx, val);
  end
  else
  begin
    if Shadow then
    begin
      if Chart.Series.IsHorizontal then
      begin
        if (r.Left - r.Right > 2) then
          ShadowGDIP(graphics, MakeRect(r.Left + 4, r.Bottom - 4, r.Right - r.Left, r.Top - r.Bottom + 4));
      end
      else
      begin
        if (r.Top - r.Bottom > 2) then
          ShadowGDIP(graphics, MakeRect(r.Left + 4, r.Bottom - 4, r.Right - r.Left, r.Top - r.Bottom + 4));
      end;
    end;
    fp.Graphics := graphics;
    fp.Fillpath := false;
    if Chart.Series.IsHorizontal then
    begin
      if DR.Left > DR.Right then
        fp.R := MakeRect(r.Right, r.Top, r.Left - r.Right, r.Bottom - r.Top)
      else
        fp.R := MakeRect(r.Left, r.Top, r.Right - r.Left, r.Bottom - r.Top);
    end
    else
    begin
      if DR.Top > DR.Bottom then
        fp.R := MakeRect(r.Left, r.Bottom, r.Right - r.Left, r.Top - r.Bottom)
      else
        fp.R := MakeRect(r.Left, r.Top, r.Right - r.Left, r.Bottom - r.Top);
    end;
    fp.GT := GradientType;
    fp.ColorFrom := SColor;
    fp.ColorTo := SColorTo;
    fp.OpacityFrom := Opacity;
    fp.OpacityTo := OpacityTo;
    fp.Angle := Angle;
    fp.HatchStyle := HatchStyle;
    fp.BorderColor := BorderColor;
    fp.BorderWidth := BorderWidth;
    fp.Image := ChartPattern;
    fp.BorderStyle := DashStyle(PenStyle);
    FillGDIP(fp);
  end;
  graphics.Free;
  Canvas.Brush.Style := bsClear;
  if ChartType <> ctBoxPlot then
  begin
    str := '';
    rf := Chart.Range.RangeFrom;

    if rf < 0 then
      XPos := idx
    else
      XPos := idx + rf;

    case BarValueTextType of
      btXAxisValue: str := Self.GetPoint(XPos).LegendValue;
    end;

    al := BarValueTextAlignment;
    ft := TFont.Create;
    ft.Assign(BarValueTextFont);

    if Assigned(OnGetBarValueText) then
      OnGetBarValueText(Self, Index, Idx, ft, str, al);

    Canvas.Font.Assign(ft);

    if str <> '' then
    begin
      th := Canvas.TextHeight(str);
      if Chart.Series.IsHorizontal then
      begin
        if th < DR.Bottom - DR.Top then
        begin
          DStyle := 0;
          if Val < 0 then
          begin
            case al of
              taLeftJustify: DStyle := DT_RIGHT;
              taRightJustify: DStyle := DT_LEFT;
              taCenter: DStyle := DT_Center;
            end;
            r := Bounds(DR.Right + 4, DR.Top, DR.Left - DR.Right - 8, DR.Bottom - DR.Top)
          end
          else
          begin
            case al of
              taLeftJustify: DStyle := DT_LEFT;
              taRightJustify: DStyle := DT_RIGHT;
              taCenter: DStyle := DT_Center;
            end;
            r := Bounds(DR.Left + 4, DR.Top, DR.Right - DR.Left - 8, DR.Bottom - DR.Top);
          end;

          DrawText(Canvas.Handle, Pchar(str), Length(str), r, DT_SINGLELINE or DT_END_ELLIPSIS or DT_VCENTER or DStyle)
        end;
      end
      else
      begin
        if th < DR.Right - DR.Left then
        begin
          tf := TFont.Create;
          tf.Assign(Canvas.Font);
          GetObject(tf.Handle, SizeOf(lf), @lf);
          lf.lfEscapement := 900;
          lf.lfOrientation := lf.lfEscapement;
          tf.Handle := CreateFontIndirectW(lf);
          Canvas.Font.Assign(tf);
          tf.Free;

          if Val < 0 then
            r := Bounds(DR.Left, DR.Top + 4, DR.Right - DR.Left, DR.Bottom - DR.Top - 8)
          else
            r := Bounds(DR.Left, DR.Bottom + 4, DR.Right - DR.Left, DR.Top - DR.Bottom - 8);

          tw := Canvas.TextWidth(str);

          x := r.Left + ((r.Right - r.Left) - th) div 2;
          y := 0;
          if Val < 0 then
          begin
            case al of
              taLeftJustify: y := r.Top + tw;
              taRightJustify: y := r.Bottom;
              taCenter: y := r.Bottom - ((r.Bottom - r.Top) - tw) div 2;
            end;
          end
          else
          begin
            case al of
              taLeftJustify: y := r.Bottom;
              taRightJustify: y := r.Top + tw;
              taCenter: y := r.Bottom - ((r.Bottom - r.Top) - tw) div 2;
            end;
          end;

          r := Bounds(x, y, th, tw);
          Canvas.TextOut(x, y, str);
        end;
      end;
    end;
    ft.Free;
  end;
end;
procedure TAdvGDIPChartSerie.DrawFunnelPart(Canvas: TCanvas;
  APoints: TPointArray; APointIndex: Integer; ScaleX, ScaleY: Double);
var
  g: TGPGraphics;
  path: TGPGraphicsPath;
  clr, clrTo: TColor;
  fp: TGDIPFillParameters;
  fHSV: THSVTriplet;
  fRGB: TRGBTriplet;
  r: TGPRectF;
begin
  g := TGPGraphics.Create(Canvas.Handle);
  g.SetSmoothingMode(SmoothingModeAntiAlias);
  path := TGPGraphicsPath.Create;

  fRGB.B := (Color and $0000FF);
  fRGB.G := (Color and $00FF00) shr 8;
  fRGB.R := (Color and $FF0000) shr 16;
  RGBToHSV(fRGB.B, fRGB.G, fRGB.R, fHSV.H, fHSV.S, fHSV.V);
  if GetPointsCount > 0 then
    fHSV.V := ((APointIndex + 1) / GetPointsCount) * fHSV.V;

  HSVToRGB(fHSV.H, fHSV.S, fHSV.V, fRGB.R, fRGB.G, fRGB.B);

  if GetPoint(APointIndex).Color <> clNone then
    clr := GetPoint(APointIndex).Color
  else if Color <> clNone then
    clr := RGB(Round(FRGB.R), Round(FRGB.G), Round(FRGB.B))
  else
    clr := clNone;

  fRGB.B := (ColorTo and $0000FF);
  fRGB.G := (ColorTo and $00FF00) shr 8;
  fRGB.R := (ColorTo and $FF0000) shr 16;
  RGBToHSV(fRGB.B, fRGB.G, fRGB.R, fHSV.H, fHSV.S, fHSV.V);
  if GetPointsCount > 0 then
    fHSV.V := ((APointIndex + 1) / GetPointsCount) * fHSV.V;

  HSVToRGB(fHSV.H, fHSV.S, fHSV.V, fRGB.R, fRGB.G, fRGB.B);

  if GetPoint(APointIndex).ColorTo <> clNone then
    clrTo := GetPoint(APointIndex).ColorTo
  else if ColorTo <> clNone then
    clrTo := RGB(Round(FRGB.R), Round(FRGB.G), Round(FRGB.B))
  else
    clrTo := clNone;

  if Enable3D then
  begin
    r := MakeRect(APoints[0].X, APoints[0].Y - Offset3D / 2, APoints[1].X - APoints[0].X, Offset3D);
    path.AddArc(r, 180, 180);
    path.AddLine(APoints[1].X, APoints[1].Y, APoints[2].X, APoints[2].Y);
    r := MakeRect(APoints[3].X, APoints[2].Y - Offset3D / 2, APoints[2].X - APoints[3].X , Offset3D);
    path.AddArc(r, 0, 180);
  end
  else
    path.AddPolygon(PGPPoint(APoints), Length(APoints));

  path.CloseFigure;

  fp.Graphics := g;
  fp.OpacityFrom := Opacity;
  fp.OpacityTo := OpacityTo;
  fp.Path := path;
  fp.Fillpath := true;
  fp.GT := GradientType;
  fp.Angle := Angle;
  fp.HatchStyle := HatchStyle;
  if Enable3D then
    fp.R := MakeRect(APoints[0].X + 1, APoints[0].Y + 1 - Offset3D / 2, APoints[2].X - 2 - APoints[0].X, APoints[2].Y - 2 - APoints[0].Y + Offset3D)
  else
    fp.R := MakeRect(APoints[0].X, APoints[0].Y, APoints[2].X - APoints[0].X, APoints[2].Y - APoints[0].Y);

  fp.ColorFrom := clr;
  fp.ColorTo := clrTo;
  fp.Image := ChartPattern;
  fp.BorderColor := BorderColor;
  fp.BorderWidth := BorderWidth;
  fp.BorderStyle := TDashstyle(PenStyle);
  fp.Mirror := False;

  FillGDIP(fp);

  if Enable3D then
  begin
    fp.ColorFrom := DarkenColor(fp.ColorFrom, true);
    fp.ColorTo := DarkenColor(fp.ColorTo, true);
    r := MakeRect(APoints[0].X, APoints[0].Y - 0.5 - Offset3D / 2, APoints[1].X - APoints[0].X, Offset3D);
    path.Reset;
    path.AddEllipse(r);
    FillGDIP(fp);
  end;

  g.Free;
  path.free;

  Canvas.Brush.Style := bsClear;
  DrawFunnelValue(Canvas, APoints, APointIndex, ScaleX, ScaleY);
end;

procedure TAdvGDIPChartSerie.DrawMarker(Sender: TObject; Canvas: TCanvas; x, y,
  point: integer; value: TChartPoint);
begin
  inherited;
end;
procedure TAdvGDIPChartSerie.DrawMarkers(Canvas: TCanvas; R: TRect; ScaleX,
  ScaleY: Double);
var
  x: integer;
  mcp: array of TGPPoint;
  xm, ym: integer;
  msx, msy: integer;
  m: TChartGDIPMarker;
  graphics: TGPGraphics;
  path: TGPGraphicsPath;
  gpr: TGPRectf;
  nr: integer;
  fp: TGDIPFillParameters;
  bw: integer;
  dwp: TPointArray;
  dm: Boolean;
  ct, ct2: TChartPoint;
begin
  dm := Chart.Series.IsHorizontal;
  graphics := TGPGraphics.Create(Canvas.Handle);
  graphics.SetSmoothingMode(SmoothingModeAntiAlias);
  m := Marker;
  if (chartType = ctSpider) or (ChartType = ctHalfSpider) then
    dwp := SpiderV
  else
    dwp := DrawValuesDP;
  nr := High(dwp);
  if (ChartType in [ctArea, ctStackedArea, ctStackedPercArea]) then
    dec(nr,2);
  //X - Values
  for X := 0 to nr do
  begin
    if (ChartType = ctXYLine) or (ChartType = ctXYDigitalLine) or (ChartType = ctXYMarkers) then
    begin
      ct := GetChartPoint(X);
      ct2 := GetChartPoint(X + 1);
    end
    else
    begin
//      if ChartType = ctArea then
//      begin
//        ct := GetChartPointFromDrawPoint(X);
//        c := X;
//        while (not ct.Defined) and (c < GetPointsCount - 1) do
//        begin
//          Inc(c);
//          ct := GetChartPointFromDrawPoint(c);
//        end;
//      end
//      else
//      begin
        ct := GetChartPointFromDrawPoint(X);
        ct2 := GetChartPointFromDrawPoint(X + 1);
//      end;
    end;

    if ct.defined then
    begin
      bw := 0;
      case ChartType of
        ctBar, ctStackedBar, ctLineBar, ctStackedPercBar:
          bw := GetBarWidth(ScaleX);
        ctHistogram, ctLineHistogram:
          bw := GetHistoGramBarWidth(ScaleX);
      end;
      if dm then
      begin
        xm := dwp[X].X ;
        ym := dwp[X].Y + Round(bw / 2);
      end
      else
      begin
        xm := dwp[X].X + Round(bw / 2);
        ym := dwp[X].Y;
      end;
      fp.Graphics := graphics;
      fp.BorderStyle := DashStyleSolid;
      if m.IncreaseDecreaseMode or (ChartType = ctRenko) then
      begin
        msx := Round(m.MarkerSize * ScaleX);
        msy := Round(m.MarkerSize * ScaleY);
        fp.BorderColor := m.MarkerLineColor;
        fp.BorderWidth := m.MarkerLineWidth;

        if X > 0 then
        begin
          if ct.SingleValue > ct2.SingleValue then
            fp.ColorFrom := CandleColorIncrease
          else
            fp.ColorFrom := CandleColorDecrease;
        end
        else
          fp.ColorFrom := CandleColorIncrease;

        fp.ColorTo := fp.ColorFrom;
      end
      else
      begin
        if m.DisplayIndex = X then
        begin
          msx := Round(m.SelectedSize * ScaleX);
          msy := Round(m.SelectedSize * ScaleY);
          fp.ColorFrom := m.SelectedColor;
          fp.ColorTo := m.SelectedColorTo;
          fp.BorderColor := m.SelectedLineColor;
          fp.BorderWidth := m.SelectedLineWidth;
        end
        else
        begin
          msx := Round(m.MarkerSize * ScaleX);
          msy := Round(m.MarkerSize * ScaleY);
          fp.ColorFrom := m.MarkerColor;
          fp.ColorTo := m.MarkerColorTo;
          fp.BorderColor := m.MarkerLineColor;
          fp.BorderWidth := m.MarkerLineWidth;
        end;
      end;
      fp.GT := m.GradientType;
      fp.R := MakeRect(xm - msx div 2,ym - msy div 2,msx,msy);
      fp.OpacityFrom := m.Opacity;
      fp.OpacityTo := m.OpacityTo;
      fp.Angle := 0;
      fp.BorderStyle := DashStyleSolid;
      fp.Path := nil;
      case Marker.MarkerType of
        mNone: ; // draw nothing
        mCircle:
          begin
            path := TGPGraphicsPath.Create;
            gpr.X := xm - msx div 2;
            gpr.Y := ym - msy div 2;
            gpr.Width := msx;
            gpr.Height := msy;
            path.AddEllipse(gpr);
            path.CloseFigure;
          
            fp.Path := path;
            fp.Fillpath := true;
            FillGDIP(fp);
            path.Free;
          end;
        mSquare:
          begin
            fp.Fillpath := false;
            FillGDIP(fp);
          end;
        mDiamond:
          begin
            SetLength(mcp, 4); //DIAMOND 4 POINTS
            mcp[0] := MakePoint(xm, ym - msy div 2);
            mcp[1] := MakePoint(xm + msx div 2, ym);
            mcp[2] := MakePoint(xm , ym + msy div 2);
            mcp[3] := MakePoint(xm - msx div 2, ym );
            nr := 4;
            path := TGPGraphicsPath.Create;
            path.AddPolygon(PGPPoint(mcp),nr);
            path.CloseFigure;
            fp.Path := path;
            fp.Fillpath := true;
            FillGDIP(fp);
          
            path.Free;
          end;
        mTriangle:
          begin
            SetLength(mcp, 3); //TRIANGLE 3 POINTS
            mcp[0] := MakePoint(xm, ym - msy div 2);
            mcp[1] := MakePoint(xm + msx div 2 , ym + msy div 2);
            mcp[2] := MakePoint(xm - msx div 2 , ym + msy div 2);
            nr := 3;
            path := TGPGraphicsPath.Create;
            path.AddPolygon(PGPPoint(mcp),nr);
            path.CloseFigure;
            fp.Path := path;
            fp.Fillpath := true;
            FillGDIP(fp);
            path.Free;
          end;
        mPicture:
        begin
          if not m.MarkerPicture.Empty then
          begin
            R.TopLeft := Point(xm - msx div 2 , ym - msy div 2);
            m.MarkerPicture.GDIPDraw(graphics, Bounds(r.Left, r.Top ,msx, msy));
          end;
        end;
        mCustom:
          begin
            DrawMarker(m, Canvas, xm, ym, X, ct);
          end;
      end;
    end;
  end;
  graphics.Free;
end;
procedure TAdvGDIPChartSerie.DrawPieLegend(Canvas: TCanvas; x, y, width,
  height: integer; Scalex, ScaleY: Double);
var
  LRect: TRect;
  xSymbol: integer;
  xText: integer;
  yText: integer;
  I: integer;
  g: TGPGraphics;
  fp: TGDIPFillParameters;
  clr: TColor;
  clrTo: TColor;
  titleh: integer;
  titleRect: TGPRectF;
  FRGB: TRGBTriplet;
  FHSV: THSVTriplet;
  spc: Integer;
  str: String;
  th: Single;
  ft: TGPFont;
  sizer: TGPRectF;
  xTexts, yTexts: Single;
  b: TGPSolidBrush;
begin
  with Pie do
  begin
    if not LegendVisible then
      Exit;
    Canvas.Brush.Style := bsClear;
    g := nil;
    ft := nil;
    b := nil;
    try
      g := TGPGraphics.Create(Canvas.Handle);
      g.SetSmoothingMode(SmoothingModeAntiAlias);
      ft := MakeFont(LegendFont);
      b := TGPSolidBrush.Create(MakeColor(255, LegendFont.Color));
      LRect := Bounds(x - width, y - height, 2 * width, 2 * height);
      spc := 5;
      fp.Graphics := g;
      fp.path := nil;
      fp.Fillpath := false;
      fp.R := MakeRect(LRect.Left, LRect.Top, LRect.Right - LRect.Left, LRect.Bottom - LRect.Top);
      fp.GT := LegendGradientType;
      fp.ColorFrom := LegendColor;
      fp.ColorTo := LegendColorTo;
      fp.OpacityFrom := LegendOpacity;
      fp.OpacityTo := LegendOpacityTo;
      fp.HatchStyle := LegendHatchStyle;
      fp.Angle := LegendGradientAngle;
      fp.Image := nil;
      fp.BorderColor := LegendBorderColor;
      fp.BorderWidth := LegendBorderWidth;
      fp.BorderStyle := DashStyleSolid;
      FillGDIP(fp);
      for I := 0 to GetPointsCount - 1 do
      begin
        xSymbol := Round(LRect.Left + spc * 2);
        xText := LRect.Left + spc * 4;
        yText := LRect.Top + 5 + Round(I  * ((LRect.Bottom - LRect.Top - 5) / GetPointsCount));
        if GetPoint(I).Defined then
        begin
          case ValueType of
            cvNone: str := GetPoint(I).LegendValue;
            cvNormal:
            begin
              case ValueFormatType of
                vftNormal: str := GetPoint(I).LegendValue + ' (' + Format(ValueFormat, [GetPoint(I).SingleValue]) + ')';
                vftFloat: str := GetPoint(I).LegendValue + ' (' + FormatFloat(ValueFormat, GetPoint(I).SingleValue) + ')';
              end;
            end;
            cvPercentage: str := GetPoint(I).LegendValue + ' (' + GetPercentageValue(GetPoint(I).SingleValue) + '%)';
          end;
        end
        else
          str := 'Undefined';
        xTexts := xText;
        yTexts := yText;
        g.DrawString(str, Length(str), ft, MakePoint(xTexts, yTexts), b);
        g.MeasureString(str, Length(str), ft, MakePoint(xTexts, yTexts), nil, sizer);
        th := sizer.Height;
        clr := clNone;
        clrto := clNone;
        if (ChartType <> ctSpider) and (ChartType <> ctHalfSpider) then
        begin
          if GetPoint(I).Color <> clNone then
          begin
            clr := GetPoint(I).Color;
          end
          else
          begin
            fRGB.B := (Color and $0000FF);
            fRGB.G := (Color and $00FF00) shr 8;
            fRGB.R := (Color and $FF0000) shr 16;
            RGBToHSV(fRGB.B, fRGB.G, fRGB.R, fHSV.H, fHSV.S, fHSV.V);
            fHSV.V := ((I + 1) / GetPointsCount) * fHSV.V;
            HSVToRGB(fHSV.H, fHSV.S, fHSV.V, fRGB.R, fRGB.G, fRGB.B);
            clr := RGB(Round(FRGB.R), Round(FRGB.G), Round(FRGB.B));
          end;
          if GetPoint(I).ColorTo <> clNone then
          begin
            clrTo := GetPoint(I).ColorTo;
          end
          else
          begin
            fRGB.B := (Color and $0000FF);
            fRGB.G := (Color and $00FF00) shr 8;
            fRGB.R := (Color and $FF0000) shr 16;
            RGBToHSV(fRGB.B, fRGB.G, fRGB.R, fHSV.H, fHSV.S, fHSV.V);
            fHSV.V := ((I + 1) / GetPointsCount) * fHSV.V;
            HSVToRGB(fHSV.H, fHSV.S, fHSV.V, fRGB.R, fRGB.G, fRGB.B);
            clrto := Color;
          end;
        end
        else
        begin
          if Color <> clNone then
            clr := Color;
          if Colorto <> clNone then
            clrTo := ColorTo;
        end;

        fp.ColorFrom := clr;
        fp.ColorTo := clrTo;
        fp.OpacityFrom := Self.Opacity;
        fp.OpacityTo := Self.OpacityTo;
        fp.HatchStyle := Self.HatchStyle;
        fp.GT := Self.GradientType;
        fp.Angle := Self.Angle;
        fp.BorderColor := Self.BorderColor;
        fp.BorderWidth := self.BorderWidth;
        fp.BorderStyle := DashStyle(Self.PenStyle);
        fp.Image := Self.ChartPattern;
        fp.R := MakeRect(xSymbol - spc, yText - spc + th / 2, spc * 2, spc * 2);

        FillGDIP(fp);
      end;
      if LegendTitleVisible then
      begin
        titleh := Canvas.TextHeight(LegendText);
        titlerect := MakeRect(LRect.Left, LRect.Top - titleh, LRect.Right - LRect.Left, titleh);
        fp.Graphics := g;
        fp.path := nil;
        fp.Fillpath := false;
        fp.R := titlerect;
        fp.GT := LegendTitleGradientType;
        fp.ColorFrom := LegendTitleColor;
        fp.ColorTo := LegendTitleColorTo;
        fp.OpacityFrom := LegendTitleOpacity;
        fp.OpacityTo := LegendTitleOpacityTo;
        fp.HatchStyle := LegendTitleHatchStyle;
        fp.Angle := LegendTitleGradientAngle;
        fp.Image := nil;
        fp.BorderColor := LegendBorderColor;
        fp.BorderWidth := LegendBorderWidth;
        fp.BorderStyle := DashStyleSolid;
        FillGDIP(fp);
        Canvas.TextOut(LRect.Left + 2, LRect.Top - titleh, LegendText);
      end;
    finally
      if Assigned(b) then
        b.Free;
      if Assigned(ft) then
        ft.Free;
      if Assigned(g) then      
        g.Free;
    end;
  end;
end;

procedure TAdvGDIPChartSerie.DrawPieSlice(Canvas: TCanvas; Center:  TPoint; Radius, RadiusInner, centerh, centerv,
  indent: integer; StartAngle, SweepAngle: Double; PointIndex: integer; ScaleX, ScaleY: Double);
var
  c: TPoint;
  g: TGPGraphics;
  path: TGPGraphicsPath;
  pierect, pierectinner: TGPRectF;
  clr, clrTo: TColor;
  fp: TGDIPFillParameters;
  ex, ey: integer;
  fHSV: THSVTriplet;
  fRGB: TRGBTriplet;
  X3,X4: integer;
  Y3,Y4: integer;
  X5,Y5: Integer;
  x6,Y6: Integer;
begin
  g := TGPGraphics.Create(Canvas.Handle);
  g.SetSmoothingMode(SmoothingModeAntiAlias);
  path := TGPGraphicsPath.Create;
  ex := Round(indent * Cos((-Pie.StartOffsetAngle -StartAngle + -SweepAngle / 2) * PI / 180));
  ey := Round(indent * Sin((-Pie.StartOffsetAngle -StartAngle + -SweepAngle / 2) * PI / 180));
  c := Point(center.X + ex, center.Y + ey);
  PieRect := MakeRect(c.X - Radius, c.Y - Radius, Radius * 2, Radius * 2);
  case ChartType of
    ctHalfSpider, ctSpider, ctpie, ctFunnel, ctHalfPie, ctSizedPie, ctSizedHalfPie, ctVarRadiusPie, ctVarRadiusHalfPie: path.AddPie(pierect, -Pie.StartOffsetAngle -StartAngle, -SweepAngle);
    ctdonut, ctHalfDonut, ctSizedDonut, ctSizedHalfDonut, ctVarRadiusDonut, ctVarRadiusHalfDonut:
    begin
      path.AddArc(pieRect, -Pie.StartOffsetAngle -StartAngle, -SweepAngle);
      RadiusInner := Pie.GetPieInnerSize div 2;
      pierectinner := MakeRect(c.X - RadiusInner, c.Y - RadiusInner, RadiusInner  * 2, RadiusInner * 2);
      path.AddArc(pierectinner, -Pie.StartOffsetAngle - StartAngle - SweepAngle, Sweepangle);
    end;
  end;
  X3 := c.X + Round(Radius * COS(DegToRad(Pie.StartOffsetAngle + StartAngle)));
  Y3 := c.y - Round(Radius * SIN(DegToRad(Pie.StartOffsetAngle + StartAngle)));
  X4 := c.X + Round(Radius * COS(DegToRad(Pie.StartOffsetAngle + StartAngle + SweepAngle)));
  Y4 := c.y - Round(Radius * SIN(DegToRad(Pie.StartOffsetAngle + StartAngle + SweepAngle)));

  X5 := c.X + Round(RadiusInner * COS(DegToRad(Pie.StartOffsetAngle + StartAngle)));
  Y5 := c.y - Round(RadiusInner * SIN(DegToRad(Pie.StartOffsetAngle + StartAngle)));
  X6 := c.X + Round(RadiusInner * COS(DegToRad(Pie.StartOffsetAngle + StartAngle + SweepAngle)));
  Y6 := c.y - Round(RadiusInner * SIN(DegToRad(Pie.StartOffsetAngle + StartAngle + SweepAngle)));

  SetLength(FDrawValuesSlice, PointIndex + 1);
  FDrawValuesSlice[PointIndex].CX := c.X;
  FDrawValuesSlice[PointIndex].CY := c.Y;
  FDrawValuesSlice[PointIndex].STA := Pie.StartOffsetAngle + StartAngle;
  FDrawValuesSlice[PointIndex].SWA := Pie.StartOffsetAngle + StartAngle + SweepAngle;

  FDrawValuesSlice[PointIndex].X0 := c.X;
  FDrawValuesSlice[PointIndex].Y0 := c.Y;
  FDrawValuesSlice[PointIndex].X1 := X3;
  FDrawValuesSlice[PointIndex].Y1 := Y3;
  FDrawValuesSlice[PointIndex].X2 := X4;
  FDrawValuesSlice[PointIndex].Y2 := Y4;
  FDrawValuesSlice[PointIndex].X3 := X5;
  FDrawValuesSlice[PointIndex].Y3 := Y5;
  FDrawValuesSlice[PointIndex].X4 := X6;
  FDrawValuesSlice[PointIndex].Y4 := Y6;

  DrawValuesSlice := FDrawValuesSlice;
  fRGB.B := (Color and $0000FF);
  fRGB.G := (Color and $00FF00) shr 8;
  fRGB.R := (Color and $FF0000) shr 16;
  RGBToHSV(fRGB.B, fRGB.G, fRGB.R, fHSV.H, fHSV.S, fHSV.V);
  fHSV.V := ((PointIndex + 1) / GetPointsCount) * fHSV.V;
  HSVToRGB(fHSV.H, fHSV.S, fHSV.V, fRGB.R, fRGB.G, fRGB.B);
  Canvas.Brush.Color := RGB(Round(FRGB.R), Round(FRGB.G), Round(FRGB.B));
  if GetPoint(PointIndex).Color <> clNone then
    clr := GetPoint(PointIndex).Color
  else if Color <> clNone then
    clr := RGB(Round(FRGB.R), Round(FRGB.G), Round(FRGB.B))
  else
    clr := clNone;
  if GetPoint(PointIndex).ColorTo <> clNone then
    clrTo := GetPoint(PointIndex).ColorTo
  else if Color <> clNone then
    clrTo := RGB(Round(FRGB.R), Round(FRGB.G), Round(FRGB.B))
  else
    clrTo := clNone;

  path.CloseFigure;    
  fp.Graphics := g;
  fp.OpacityFrom := Opacity;
  fp.OpacityTo := OpacityTo;
  fp.Path := path;
  fp.Fillpath := true;
  fp.GT := GradientType;
  fp.Angle := Angle;
  fp.HatchStyle := HatchStyle;
  fp.Mirror := False;
  fp.R := pierect;
  fp.ColorFrom := clr;
  fp.ColorTo := clrTo;
  fp.Image := ChartPattern;
  fp.BorderColor := BorderColor;
  fp.BorderWidth := BorderWidth;
  fp.BorderStyle := TDashstyle(PenStyle);
  FillGDIP(fp);
  g.Free;
  path.free;
end;
procedure TAdvGDIPChartSerie.DrawPieValues(Canvas: TCanvas; indent: integer;
  Center: TPoint; radius, StartAngle, SweepAngle: Double; PointIndex: integer;
  ScaleX, ScaleY: Double);
begin
  inherited;
end;
procedure TAdvGDIPChartSerie.FillPyramid(g: TGPGraphics; SColor,
  SColorTo: TColor; Dr: TRect; ScaleX, ScaleY: Double; Idx: Integer;
  val: Double);
var
  dheight: double;
  dstep: double;
  delta1,delta2: Integer;
  polypoints: TPointArray;
  arr3D: TPointArray;
  x: Integer;
  w: Double;
  fp: TGDIPFillParameters;
  pt: TGPGraphicsPath;
begin
  SetLength(polypoints, 4);
  SetLength(arr3D, 4);
  if Chart.Series.IsHorizontal then
  begin
    w := DR.Bottom - DR.Top;
    x := DR.Top + Round(w) div 2;
  end
  else
  begin
    w := DR.Right - DR.Left;
    x := DR.Left + Round(w) div 2;
  end;

  dheight := GetTotalSeriesValuePyramid(idx);
  if dheight = 0 then
    Exit;

  if (Chart.Series.GetCountChartType(ctStackedBar) > 0) or (Chart.Series.GetCountChartType(ctStackedPercBar) > 0) then
    dstep := GetNextValuePyramid(Index - 1, idx)
  else
    dstep := 0;

  delta1 := round((dheight - dstep)/dheight * w / 2);
  // draw stacked pyramid. X,Y is the center of the pyramid bottom
  if Chart.Series.IsHorizontal then
  begin
    PolyPoints[0].Y := x - delta1;
    PolyPoints[0].X := ValueToY(dstep, Chart.Series.SeriesRectangle);
    PolyPoints[1].Y := x + delta1;
    PolyPoints[1].X := ValueToY(dstep, Chart.Series.SeriesRectangle);
  end
  else
  begin
    PolyPoints[0].X := x - delta1;
    PolyPoints[0].Y := ValueToY(dstep, Chart.Series.SeriesRectangle);
    PolyPoints[1].X := x + delta1;
    PolyPoints[1].Y := ValueToY(dstep, Chart.Series.SeriesRectangle);
  end;

  dstep := GetNextValuePyramid(Index, idx);

  delta2 := round((dheight - dstep)/dheight * w / 2);

  if Chart.Series.IsHorizontal then
  begin
    PolyPoints[2].Y := x + delta2;
    PolyPoints[2].X := ValueToY(dstep, Chart.Series.SeriesRectangle);
    PolyPoints[3].Y := x - delta2;
    PolyPoints[3].X := ValueToY(dstep, Chart.Series.SeriesRectangle);
  end
  else
  begin
    PolyPoints[2].X := x + delta2;
    PolyPoints[2].Y := ValueToY(dstep, Chart.Series.SeriesRectangle);
    PolyPoints[3].X := x - delta2;
    PolyPoints[3].Y := ValueToY(dstep, Chart.Series.SeriesRectangle);
  end;

  fp.Graphics := g;
  fp.GT := GradientType;
  fp.ColorFrom := SColor;
  fp.ColorTo := SColorTo;
  fp.OpacityFrom := Opacity;
  fp.OpacityTo := OpacityTo;
  fp.Angle := Angle;
  fp.HatchStyle := HatchStyle;
  fp.BorderColor := BorderColor;
  fp.BorderWidth := BorderWidth;
  fp.Image := ChartPattern;
  fp.BorderStyle := DashStyle(PenStyle);
  fp.Fillpath := true;
  if Chart.Series.IsHorizontal then
  begin
    if DR.Left > DR.Right then
      fp.R := MakeRect(dr.Right, dr.Top, dr.Left - dr.Right, dr.Bottom - dr.Top)
    else
      fp.R := MakeRect(dr.Left, dr.Top, dr.Right - dr.Left, dr.Bottom - dr.Top);
  end
  else
  begin
    if DR.Top > DR.Bottom then
      fp.R := MakeRect(dr.Left, dr.Bottom, dr.Right - dr.Left, dr.Top - dr.Bottom)
    else
      fp.R := MakeRect(dr.Left, dr.Top, dr.Right - dr.Left, dr.Bottom - dr.Top);
  end;
  pt := TGPGraphicsPath.Create;
  fp.Path := pt;
  pt.AddPolygon(PGPPoint(PolyPoints), Length(PolyPoints));
  FillGDIP(fp);

  if Enable3D then
  begin
    if Chart.Series.IsHorizontal then
    begin
      PolyPoints[0].Y := PolyPoints[1].Y;
      PolyPoints[0].X := PolyPoints[1].X;
      PolyPoints[1].Y := PolyPoints[2].Y;
      PolyPoints[1].X := PolyPoints[2].X;
      PolyPoints[2].Y := PolyPoints[1].Y + round(Offset3D * (2 * delta2 / w));
      PolyPoints[2].X := PolyPoints[1].X + round(Offset3D * (2 * delta2 / w));
      PolyPoints[3].Y := PolyPoints[0].Y + round(Offset3D * (2 * delta1 / w));
      PolyPoints[3].X := PolyPoints[0].X + round(Offset3D * (2 * delta1 / w));
      pt.Reset;
      pt.AddPolygon(PGPPoint(PolyPoints), Length(PolyPoints));
      fp.R.Y := FP.R.Y - Offset3D;
      fp.R.Height := FP.R.Height + Offset3D * 2;
      fp.ColorFrom := DarkenColor(SColor, Darken3D);
      fp.ColorTo := DarkenColor(SColorTo, Darken3D);
      FillGDIP(fp);
      if DR.Left > DR.Right then
      begin
        arr3D[0] := Point(Dr.Left, Dr.Top);
        arr3D[1] := Point(Dr.Left + Offset3D, Dr.Top + Offset3D);
        arr3D[2] := Point(Dr.Left + Offset3D, Dr.Bottom + Offset3D);
        arr3D[3] := Point(Dr.Left, Dr.Bottom);
        pt.Reset;
        pt.AddPolygon(PGPPoint(arr3D), Length(arr3D));
        FillGDIP(fp);
      end;
    end
    else
    begin
      PolyPoints[0].X := PolyPoints[1].X;
      PolyPoints[0].Y := PolyPoints[1].Y;
      PolyPoints[1].X := PolyPoints[2].X;
      PolyPoints[1].Y := PolyPoints[2].Y;
      PolyPoints[2].X := PolyPoints[1].X + round(Offset3D * (2 * delta2 / w));
      PolyPoints[2].Y := PolyPoints[1].Y - round(Offset3D * (2 * delta2 / w));
      PolyPoints[3].X := PolyPoints[0].X + round(Offset3D * (2 * delta1 / w));
      PolyPoints[3].Y := PolyPoints[0].Y - round(Offset3D * (2 * delta1 / w));
      pt.Reset;
      pt.AddPolygon(PGPPoint(PolyPoints), Length(PolyPoints));
      fp.R.Y := FP.R.Y - Offset3D;
      fp.R.Height := FP.R.Height + Offset3D * 2;
      fp.R.Width := fp.R.Width + Offset3D;
      fp.ColorFrom := DarkenColor(SColor, Darken3D);
      fp.ColorTo := DarkenColor(SColorTo, Darken3D);
      FillGDIP(fp);
      if DR.Top < DR.Bottom then
      begin
        arr3D[0] := Point(Dr.Left, Dr.Top);
        arr3D[1] := Point(Dr.Left + Offset3D, Dr.Top - Offset3D);
        arr3D[2] := Point(Dr.Right + Offset3D, Dr.Top - Offset3D);
        arr3D[3] := Point(Dr.Right, Dr.Top);
        pt.Reset;
        pt.AddPolygon(PGPPoint(arr3D), Length(arr3D));
        FillGDIP(fp);
      end;
    end;
  end;

  pt.Free;
end;

procedure TAdvGDIPChartSerie.DrawSelected(ACanvas: TCanvas; r: TRect);
var
  g: TGPGraphics;
  b: TGPBrush;
  p: TGPPen;
  size: integer;
begin
  if not SelectedMark  then
    Exit;
  g := TGPGraphics.Create(ACanvas.Handle);
  g.SetSmoothingMode(SmoothingModeAntiAlias);
  b := TGPSolidBrush.Create(MakeColor(255, SelectedMarkColor));
  p := TGPPen.Create(MakeColor(255, SelectedMarkBorderColor));
  size := SelectedMarkSize;
  //lefttop
  g.fillEllipse(b, r.Left - size / 2, r.Top - size / 2, size, size);
  g.DrawEllipse(p, r.Left - size / 2, r.Top - size / 2, size, size);
  //righttop
  g.fillEllipse(b, r.right - size / 2, r.Top - size / 2, size, size);
  g.DrawEllipse(p, r.right - size / 2, r.Top - size / 2, size, size);
  //leftbottom
  g.fillEllipse(b, r.Left - size / 2, r.bottom - size / 2, size, size);
  g.DrawEllipse(p, r.Left - size / 2, r.bottom - size / 2, size, size);
  //rightbottom
  g.fillEllipse(b, r.Right - size / 2, r.bottom - size / 2, size, size);
  g.DrawEllipse(p, r.Right - size / 2, r.bottom - size / 2, size, size);
  b.Free;
  p.Free;
  g.free;
end;
procedure TAdvGDIPChartSerie.DrawSelectedFunnel(ACanvas: TCanvas;
  ptFunnel: TFunnelPoint);
var
  g: TGPGraphics;
  b: TGPBrush;
  p: TGPPen;
  size: integer;
begin
  if not SelectedMark then
    Exit;

  g := TGPGraphics.Create(ACanvas.Handle);
  g.SetSmoothingMode(SmoothingModeAntiAlias);

  b := TGPSolidBrush.Create(MakeColor(255, SelectedMarkColor));
  p := TGPPen.Create(MakeColor(255, SelectedMarkBorderColor));

  size := SelectedMarkSize;

  g.fillEllipse(b, ptFunnel.X0 - size / 2, ptFunnel.Y0 - size / 2, size, size);
  g.DrawEllipse(p, ptFunnel.X0 - size / 2, ptFunnel.Y0 - size / 2, size, size);
  g.fillEllipse(b, ptFunnel.X1 - size / 2, ptFunnel.Y1 - size / 2, size, size);
  g.DrawEllipse(p, ptFunnel.X1 - size / 2, ptFunnel.Y1 - size / 2, size, size);
  g.fillEllipse(b, ptFunnel.X2 - size / 2, ptFunnel.Y2 - size / 2, size, size);
  g.DrawEllipse(p, ptFunnel.X2 - size / 2, ptFunnel.Y2 - size / 2, size, size);
  g.fillEllipse(b, ptFunnel.X3 - size / 2, ptFunnel.Y3 - size / 2, size, size);
  g.DrawEllipse(p, ptFunnel.X3 - size / 2, ptFunnel.Y3 - size / 2, size, size);

  b.Free;
  p.Free;
  g.free;
end;

procedure TAdvGDIPChartSerie.DrawSelectedSlice(ACanvas: TCanvas;
  ptslice: TSlicePoint);
var
  g: TGPGraphics;
  b: TGPBrush;
  p: TGPPen;
  size: integer;
begin
  if not SelectedMark then
    Exit;

  g := TGPGraphics.Create(ACanvas.Handle);
  g.SetSmoothingMode(SmoothingModeAntiAlias);
  b := TGPSolidBrush.Create(MakeColor(255, SelectedMarkColor));
  p := TGPPen.Create(MakeColor(255, SelectedMarkBorderColor));
  size := SelectedMarkSize;
  case ChartType of
    ctHalfSpider, ctSpider, ctPie, ctFunnel, ctHalfPie, ctSizedPie, ctSizedHalfPie, ctVarRadiusPie, ctVarRadiusHalfPie:
    begin
      g.fillEllipse(b, ptslice.X0 - size / 2, ptslice.Y0 - size / 2, size, size);
      g.DrawEllipse(p, ptslice.X0 - size / 2, ptslice.Y0 - size / 2, size, size);
      g.fillEllipse(b, ptslice.X1 - size / 2, ptslice.Y1 - size / 2, size, size);
      g.DrawEllipse(p, ptslice.X1 - size / 2, ptslice.Y1 - size / 2, size, size);
      g.fillEllipse(b, ptslice.X2 - size / 2, ptslice.Y2 - size / 2, size, size);
      g.DrawEllipse(p, ptslice.X2 - size / 2, ptslice.Y2 - size / 2, size, size);
    end;
    ctHalfDonut, ctDonut, ctSizedDonut, ctSizedHalfDonut, ctVarRadiusDonut, ctVarRadiusHalfDonut:
    begin
      g.fillEllipse(b, ptslice.X1 - size / 2, ptslice.Y1 - size / 2, size, size);
      g.DrawEllipse(p, ptslice.X1 - size / 2, ptslice.Y1 - size / 2, size, size);
      g.fillEllipse(b, ptslice.X2 - size / 2, ptslice.Y2 - size / 2, size, size);
      g.DrawEllipse(p, ptslice.X2 - size / 2, ptslice.Y2 - size / 2, size, size);

      g.fillEllipse(b, ptslice.X3 - size / 2, ptslice.Y3 - size / 2, size, size);
      g.DrawEllipse(p, ptslice.X3 - size / 2, ptslice.Y3 - size / 2, size, size);
      g.fillEllipse(b, ptslice.X4 - size / 2, ptslice.Y4 - size / 2, size, size);
      g.DrawEllipse(p, ptslice.X4 - size / 2, ptslice.Y4 - size / 2, size, size);
    end;
  end;
  b.Free;
  p.Free;
  g.free;
end;
procedure TAdvGDIPChartSerie.DrawSpiderArea(Canvas: TCanvas; R: TRect;
  SpiderArea: TPointArray; ScaleX, ScaleY: Double);
var
  graphics: TGPGraphics;
  path: TGPGraphicsPath;
  ShadowPoints: TPointArray;
  i: integer;
  pen: TGPPen;
  fp: TGDIPFillParameters;
begin
  graphics := TGPGraphics.Create(Canvas.Handle);
  graphics.SetSmoothingMode(SmoothingModeAntiAlias);
  if Shadow then
  begin
    path := TGPGraphicsPath.Create;
    SetLength(ShadowPoints, Length(SpiderArea) - 2);
    for i := 0 to Length(ShadowPoints) - 1 do
    begin
      ShadowPoints[i].X := SpiderArea[i].X + 2;
      ShadowPoints[i].Y := SpiderArea[i].Y - 2;
    end;
    path.AddLines(PGPPoint(ShadowPoints), Length(ShadowPoints));
    pen := TGPPen.Create(MakeColor(180,clGray), 4 * ScaleX);
    pen.SetDashStyle(DashStyle(PenStyle));
    path.CloseFigure;
    graphics.DrawPath(pen, path);
    pen.Free;
    path.Free;
  end;
  path := TGPGraphicsPath.Create;
  path.AddLines(PGPPoint(SpiderArea), Length(SpiderArea));
  fp.Graphics := graphics;
  fp.Path := path;
  fp.Fillpath := true;
  fp.R := MakeRect(r.Left,r.Top,r.Right - r.Left,r.Bottom - r.Top);
  fp.OpacityFrom := Opacity;
  fp.OpacityTo := OpacityTo;
  fp.GT := GradientType;
  fp.ColorFrom := Color;
  fp.ColorTo := ColorTo;
  fp.Angle := Angle;
  fp.HatchStyle := HatchStyle;
  fp.BorderColor := clNone;
  fp.BorderWidth := 0;
  fp.Image := ChartPattern;
  fp.BorderStyle := DashStyle(PenStyle);
  FillGDIP(fp);
  pen := TGPPen.Create(MakeColor(LineOpacity,LineColor), LineWidth * ScaleX);
  pen.SetDashStyle(DashStyle(PenStyle));
  path.Free;
  path := TGPGraphicsPath.Create;
  path.AddLines(PGPPoint(SpiderArea), Length(SpiderArea));
  graphics.DrawPath(pen, path);
  pen.Free;
  path.Free;
  graphics.Free;
end;
procedure TAdvGDIPChartSerie.FillCylinder(g: TGPGraphics; DR: TRect; SColor, SColorTo: TColor; idx: integer; Val: Double; ScaleX, ScaleY: Double);
var
  fp: TGDIPFillParameters;
  pt: TGPGraphicsPath;
  rp: TGPRectF;
begin
  if Chart.Series.IsHorizontal then
  begin
    if DR.Right < DR.Left then
      DR := Rect(DR.Right, DR.Top, DR.Left, DR.Bottom);
  end
  else
  begin
    if DR.Top < DR.Bottom then
      DR := Rect(DR.Left, DR.Bottom, DR.Right, DR.Top);
  end;

  fp.Graphics := g;
  fp.GT := GradientType;
  fp.ColorFrom := SColor;
  fp.ColorTo := SColorTo;
  fp.OpacityFrom := Opacity;
  fp.OpacityTo := OpacityTo;
  fp.Angle := Angle;
  fp.HatchStyle := HatchStyle;
  fp.BorderColor := BorderColor;
  fp.BorderWidth := BorderWidth;
  fp.Image := ChartPattern;
  fp.BorderStyle := DashStyle(PenStyle);
  fp.Fillpath := true;
  if Chart.Series.IsHorizontal then
  begin
    if DR.Left > DR.Right then
      Rp := MakeRect(dr.Right, dr.Top, dr.Left - dr.Right, dr.Bottom - dr.Top)
    else
      Rp := MakeRect(dr.Left, dr.Top, dr.Right - dr.Left, dr.Bottom - dr.Top);
    rp.X := rp.X + ((rp.Height / 3) / 2);
  end
  else
  begin
    if DR.Top > DR.Bottom then
      Rp := MakeRect(dr.Left, dr.Bottom, dr.Right - dr.Left, dr.Top - dr.Bottom)
    else
      Rp := MakeRect(dr.Left, dr.Top, dr.Right - dr.Left, dr.Bottom - dr.Top);

    rp.Y := rp.Y - ((rp.Width / 3) / 2);
  end;

  pt := TGPGraphicsPath.Create;
  fp.Path := pt;
  if Chart.Series.IsHorizontal then
  begin
    pt.AddEllipse(rp.X - (rp.Height / 3) / 2, rp.Y, ((rp.Height) / 3), rp.Height);
    fp.R := MakeRect(rp.X - (rp.Height / 3) / 2, rp.Y, ((rp.Height) / 3), rp.Height);
  end
  else
  begin
    pt.AddEllipse(rp.X,rp.Y + rp.Height - (rp.width / 3) / 2, rp.width, ((rp.Width) / 3));
    fp.R := MakeRect(rp.X,rp.Y + rp.Height - (rp.width / 3) / 2, rp.width, ((rp.Width) / 3));
  end;
  FillGDIP(fp);
  pt.Reset;
  if Chart.Series.IsHorizontal then
  begin
    pt.AddArc(rp.X - (rp.Height / 3) / 2, rp.Y, ((rp.Height) / 3), rp.Height, 90, 180);
    pt.AddArc(rp.X + rp.Width - (rp.Height / 3) / 2, rp.Y, ((rp.Height) / 3), rp.Height, 270, -180);
    pt.AddLine(rp.X, rp.Y + rp.Height, rp.X + rp.Width - (rp.Height / 3) / 2, rp.Y + rp.Height);
  end
  else
  begin
    pt.AddArc(rp.X, rp.Y + rp.Height - (rp.Width / 3) / 2, rp.Width, ((rp.Width) / 3), 0, 180);
    pt.AddArc(rp.X, rp.Y - (rp.Width / 3) / 2, rp.Width, ((rp.Width) / 3), 180, -180);
    pt.AddLine(rp.X + rp.Width, rp.Y, rp.X + rp.Width, rp.Y + rp.Height);
  end;

  if Chart.Series.IsHorizontal then
    fp.R := MakeRect(rp.X - (rp.Height / 3), rp.Y, rp.Width + (rp.Height) / 3, rp.Height)
  else
    fp.R := MakeRect(rp.X, rp.Y - (rp.Width / 3), rp.Width, rp.Height + (rp.Width) / 3);

  FillGDIP(fp);
  pt.Reset;
  if Chart.Series.IsHorizontal then
  begin
    pt.AddEllipse(rp.X + rp.Width - (rp.Height / 3) / 2, rp.Y, ((rp.Height) / 3), rp.Height);
    fp.R := MakeRect(rp.X + rp.Width - (rp.Height / 3) / 2, rp.Y, ((rp.Height) / 3), rp.Height);
  end
  else
  begin
    pt.AddEllipse(rp.X, rp.Y - (rp.Width / 3) / 2, rp.Width, ((rp.Width) / 3));
    fp.R := MakeRect(rp.X, rp.Y - (rp.Width / 3) / 2, rp.Width, ((rp.Width) / 3));
  end;
  FillGDIP(fp);
  pt.Free;
end;

procedure TAdvGDIPChartSerie.DrawGanttBarRect(Canvas: TCanvas; pt: TChartPoint;
  dr: TRect);
var
  graphics: TGPGraphics;
  fp: TGDIPFillParameters;
  r: TRect;
begin
  graphics := TGPGraphics.Create(Canvas.Handle);
  graphics.SetSmoothingMode(SmoothingModeAntiAlias);
  r := DR;
  fp.Graphics := graphics;
  fp.Fillpath := false;
  fp.R := MakeRect(r.Left, r.Top, r.Right - r.Left, r.Bottom - r.Top);
  if pt.GradientDirection = cgdHorizontal then
    fp.GT := gtHorizontal
  else
    fp.GT := gtVertical;
  fp.ColorFrom := pt.Color;
  fp.ColorTo := pt.ColorTo;
  fp.OpacityFrom := Opacity;
  fp.OpacityTo := OpacityTo;
  fp.Angle := Angle;
  fp.HatchStyle := HatchStyle;
  fp.BorderColor := pt.BorderColor;
  fp.BorderWidth := 1;
  fp.BorderStyle := DashStyleSolid;
  FillGDIP(fp);
  graphics.Free;
end;

procedure TAdvGDIPChartSerie.DrawGridCircle(Canvas: TCanvas;
  YG: TChartYGrid; Center: TPoint; diff: integer; Major: Boolean);
var
  g: TGPGraphics;
  c: TColor;
  w: integer;
  p: TPenStyle;
  pt: TGPGraphicsPath;
  pn: TGPPen;
begin
  if Major then
  begin
    c := YG.MajorLineColor;
    w := YG.MajorLineWidth;
    p := YG.MajorLineStyle;
  end
  else
  begin
    c := YG.MinorLineColor;
    w := YG.MinorLineWidth;
    p := YG.MinorLineStyle;
  end;

  g := TGPGraphics.Create(Canvas.Handle);
  g.SetSmoothingMode(SmoothingModeAntiAlias);
  pt := TGPGraphicsPath.Create;
  if IsHalfPie then
    pt.AddArc(MakeRect(center.X - diff, center.Y - diff, diff * 2, diff * 2), -Pie.StartOffsetAngle, -180)
  else
    pt.AddEllipse(MakeRect(center.X - diff, center.Y - diff, diff * 2, diff * 2));
  pn := TGPPen.Create(MakeColor(255, c), w);
  pn.SetDashStyle(DashStyle(p));
  g.DrawPath(pn, pt);
  pn.Free;
  pt.Free;
  g.Free;
end;
procedure TAdvGDIPChartSerie.DrawGridPieLine(Canvas: TCanvas; YG: TChartYGrid;
  Center: TPoint; x, y: integer);
var
  g: TGPGraphics;
  p: TGPPen;
begin
  g := TGPGraphics.Create(Canvas.Handle);
  g.SetSmoothingMode(SmoothingModeAntiAlias);
  p := TGPPen.Create(MakeColor(255, YG.MajorLineColor), YG.MajorLineWidth);
  p.SetDashStyle(DashStyle(yg.MajorLineStyle));
  g.DrawLine(p, Center.X, Center.Y, x, y);
  g.Free;

end;
function TAdvGDIPChartSerie.DrawLegend(Canvas: TCanvas; R: Trect; ScaleX, ScaleY: Double; Draw: Boolean): TRect;
var
  hw, hh, hx, hy, i: integer;
  str: String;
  tlh, tlw: Double;
  tempw, temph: Double;
  centerh, centerv: integer;
  pbr: Trect;
  ptCenter: TPoint;
  g: TGPGraphics;
  ft: TGPFont;
  sizer: TGPRectF;
begin
  if not Pie.LegendVisible or (not IsPieChart) then
      Exit;

  g := TGPGraphics.Create(Canvas.Handle);
  ft := MakeFont(Pie.LegendFont);

  if (GetPointsCount > 0) then
  begin
    tlw := -MAXLONG;

    Canvas.Font.Assign(Pie.LegendFont);
    temph := 0;
    for I := 0 to GetPointsCount - 1 do
    begin
//      if (Points[I].LegendValue <> '') then
      begin
        str := '';
        if (GetPoint(I).SingleValue > 0) then
        begin
          case ValueType of
            cvNone: str := GetPoint(I).LegendValue;
            cvNormal:
            begin
              case ValueFormatType of
                vftNormal: str := GetPoint(I).LegendValue + ' (' + Format(ValueFormat, [GetPoint(I).SingleValue]) + ')';
                vftFloat: str := GetPoint(I).LegendValue + ' (' + FormatFloat(ValueFormat, GetPoint(I).SingleValue) + ')';
              end;
            end;
            cvPercentage: str := GetPoint(I).LegendValue + ' (' + Format(ValueFormat, [(GetPoint(I).SingleValue / GetTotalPoints) * 100]) + '%)';
          end;
        end
        else
        begin
          case ValueType of
            cvNone: str := GetPoint(I).LegendValue;
            cvNormal:
            begin
              case ValueFormatType of
                vftNormal: str := GetPoint(I).LegendValue + ' (' + Format(ValueFormat, [GetPoint(I).SingleValue]) + ')';
                vftFloat: str := GetPoint(I).LegendValue + ' (' + FormatFloat(ValueFormat, GetPoint(I).SingleValue) + ')';
              end;
            end;
            cvPercentage: str := GetPoint(I).LegendValue + ' (' + Format(ValueFormat, [GetPoint(I).SingleValue]) + '%)';
          end;
        end;

        g.MeasureString(str, Length(str), ft, MakeRect(0, 0, 10000, 10000), sizer);

        tempw := sizer.Width;
        temph := temph + sizer.Height + 5;
        if tlw < tempw then
          tlw := tempw;
      end;
    end;

    tlh := temph;
    tlh := Round(tlh * ScaleY);
    tlw := tlw + 25;


    g.Free;
    ft.Free;


    tempw := Canvas.TextWidth(LegendText);
    if tlw < tempw then
      tlw := tempw;

    hw := Round(tlw / 2);
    hh := Round(tlh);
    hh := Round(hh / 2);
    pbr := GetPieRectangle(Index, Chart.Series.SeriesRectangle);
    ptcenter := GetLegendCenter(pbr, hw, hh);
    centerh := ptCenter.X;
    centerv := ptCenter.Y;
    hx := centerh;
    hy := centerv;
    if (hw > 0) and (hh > 0) and Draw then
      DrawPieLegend(Canvas, hx, hy, hw, hh, ScaleX, ScaleY);

    Result := Bounds(hx - hw, hy - hh, hw * 2, hh * 2);
  end;
end;

function TAdvGDIPChartSerie.GetAnnotations: TChartGDIPAnnotations;
begin
  Result := TChartGDIPAnnotations(inherited Annotations);
end;
function TAdvGDIPChartSerie.GetFunnel: TGDIPChartSeriePie;
begin
  Result := Pie;
end;

function TAdvGDIPChartSerie.GetMarkerEx: TChartGDIPMarker;
begin
  Result := TChartGDIPMarker(inherited Marker);
end;
function TAdvGDIPChartSerie.GetPie: TGDIPChartSeriePie;
begin
  Result := TGDIPChartSeriePie(inherited Pie);
end;
procedure TAdvGDIPChartSerie.LoadFromFile(ini: TMemIniFile; Section: String);
begin
  inherited;
  Angle := ini.ReadInteger(Section, 'Angle', Angle);
  GradientType := TChartGradientType(ini.ReadInteger(Section, 'GradientType',Integer(GradientType)));
  HatchStyle := THatchStyle(ini.ReadInteger(Section, 'HatchStyle', Integer(HatchStyle)));
  Opacity := ini.ReadInteger(Section, 'Opacity', Opacity);
  OpacityTo := ini.ReadInteger(Section, 'OpacityTo', Opacityto);
  Shadow := ini.ReadBool(Section, 'Shadow', Shadow);
  LineOpacity := ini.ReadInteger(Section, 'LineOpacity', LineOpacity);
end;
procedure TAdvGDIPChartSerie.SaveToFile(ini: TMemIniFile; Section: String);
begin
  inherited;
  ini.WriteInteger(Section, 'Angle', Angle);
  ini.WriteInteger(Section, 'GradientType',Integer(GradientType));
  ini.WriteInteger(Section, 'HatchStyle', Integer(HatchStyle));
  ini.writeInteger(Section, 'Opacity', Opacity);
  ini.writeInteger(Section, 'OpacityTo', Opacityto);
  ini.WriteBool(Section, 'Shadow', Shadow);
  ini.WriteInteger(Section, 'LineOpacity', LineOpacity);
end;
procedure TAdvGDIPChartSerie.SetAngle(const Value: integer);
begin
  if (FAngle <> Value) then
  begin
    FAngle := Value;
    Changed;
  end;
end;
procedure TAdvGDIPChartSerie.SetAnnotations(const Value: TChartGDIPAnnotations);
begin
  inherited Annotations := Value;
end;
procedure TAdvGDIPChartSerie.SetChartPattern(const Value: TChartGDIPPicture);
begin
  FChartPattern.Assign(Value);
end;
procedure TAdvGDIPChartSerie.SetGradientType(const Value: TChartGradientType);
begin
  if (FGradientType <> Value) then
  begin
    FGradientType := Value;
    Changed;
  end;
end;
procedure TAdvGDIPChartSerie.SetHatchStyle(const Value: THatchStyle);
begin
  if (FHatchStyle <> Value) then
  begin
    FHatchStyle := Value;
    Changed;
  end;
end;
procedure TAdvGDIPChartSerie.SetLineOpacity(const Value: integer);
begin
  if (FLineOpacity <> Value) then
  begin
    FLineOpacity := Limit(Value,0,255);
    Changed;
  end;
end;
procedure TAdvGDIPChartSerie.SetMarkerEx(const Value: TChartGDIPMarker);
begin
  inherited Marker := Value;
end;
procedure TAdvGDIPChartSerie.SetOpacity(const Value: integer);
begin
  if FOpacity <> Value then
  begin
    FOpacity := Limit(Value,0,255);
    Changed;
  end;
end;
procedure TAdvGDIPChartSerie.SetOpacityTo(const Value: integer);
begin
  if FOpacityTo <> Value then
  begin
    FOpacityTo := Limit(Value,0,255);
    Changed;
  end;
end;
procedure TAdvGDIPChartSerie.SetPie(const Value: TGDIPChartSeriePie);
begin
  inherited Pie := Value;
end;
procedure TAdvGDIPChartSerie.SetShadow(const Value: boolean);
begin
  if (FShadow <> Value) then
  begin
    FShadow := Value;
    Changed;
  end;
end;
{ TChartGDIPAnnotations }
function TChartGDIPAnnotations.Add: TChartGDIPAnnotation;
begin
  Result := TChartGDIPAnnotation(inherited Add);
end;
function TChartGDIPAnnotations.GetItem(Index: Integer): TChartGDIPAnnotation;
begin
  Result := TChartGDIPAnnotation(inherited Items[Index]);
end;
function TChartGDIPAnnotations.GetItemClass: TCollectionItemClass;
begin
  Result := TChartGDIPAnnotation;
end;
function TChartGDIPAnnotations.Insert(index: integer): TChartGDIPAnnotation;
begin
  Result := TChartGDIPAnnotation(inherited Insert(Index));
end;
procedure TChartGDIPAnnotations.SetItem(Index: Integer;
  const Value: TChartGDIPAnnotation);
begin
  inherited Items[Index] := Value;
end;
{ TChartGDIPAnnotation }
procedure TChartGDIPAnnotation.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  Angle := (Source as TChartGDIPAnnotation).Angle;
  GradientType := (Source as TChartGDIPAnnotation).GradientType;
  HatchStyle := (Source as TChartGDIPAnnotation).HatchStyle;
  Opacity := (Source as TChartGDIPAnnotation).Opacity;
  OpacityTo := (Source as TChartGDIPAnnotation).OpacityTo;
  Shadow := (Source as TChartGDIPAnnotation).Shadow;
end;
constructor TChartGDIPAnnotation.Create(Collection: TCollection);
begin
  inherited;
  FOpacity := 255;
  FOpacityTo := 255;
end;
procedure TChartGDIPAnnotation.Draw(Canvas: TCanvas; DR, TextR: TRect; xm, ym: integer;
  ScaleX, ScaleY: double);
var
//  HRGN, newRgn: THandle;
//  FClipRgn: THandle;
  mw,mh: integer;
//  arx,ary: integer;
  x,y: integer;
  DTSTYLE: dword;
  graphics: TGPGraphics;
  pen: TGPPen;
  path: TGPGraphicsPath;
  R: TGPRectF;
  lb: TGPBrush;
  bp: TGPPen;
  start, stop: TGPColor;
  pth: TGPGraphicsPath;
  bw, brn: Integer;
  rl: TGPRectF;
begin
  InflateRect(DR,2,2);
  bw := Round(BorderWidth * ScaleX);
  brn := Round(BorderRounding * ScaleX);
  graphics := TGPGraphics.Create(Canvas.Handle);
  graphics.SetSmoothingMode(SmoothingModeAntiAlias);
  if Shadow and (Shape <> asLine) then
  begin
    ShadowGDIP(graphics,MakeRect(Dr.Left + 4, Dr.Top + 4, Dr.Right - Dr.Left , Dr.Bottom - Dr.Top));
  end;
  if Shape <> asLine then
  begin
    R := MakeRect(DR.Left, DR.Top, DR.Right - DR.Left, DR.Bottom - DR.Top);
    lb := nil;
    start := MakeColor(Opacity, Color);
    if ColorTo = clNone then
      stop := start
    else
      stop := MakeColor(OpacityTo, ColorTo);

    if Shape = asBalloon then
    begin
      case BalloonDirection of
        hdUpLeft, hdUpRight: rl := MakeRect(R.X, r.Y - BalloonArrowSize, r.Width, r.Height + BalloonArrowSize * 2);
        hdDownRight, hdDownLeft: rl := MakeRect(R.X, r.Y, r.Width, r.Height + BalloonArrowSize);
      end;
    end
    else
      rl := MakeRect(R.X, r.Y, r.Width, r.Height);

    case GradientType of
      gtSolid: lb := TGPSolidBrush.Create(start);
      gtVertical: lb := TGPLinearGradientBrush.Create(MakePoint(rl.X, rl.Y), MakePoint(rl.X, rl.Y + rl.Height), start, stop);
      gtHorizontal: lb := TGPLinearGradientBrush.Create(MakePoint(rl.X, rl.Y), MakePoint(rl.X + rl.Width, rl.Y), start, stop);
      gtForwardDiagonal: lb := TGPLinearGradientBrush.Create(MakePoint(rl.X, rl.Y), MakePoint(rl.X + rl.Width, rl.Y + rl.Height), start, stop);
      gtBackwardDiagonal: lb := TGPLinearGradientBrush.Create(MakePoint(rl.X, rl.Y + rl.Height), MakePoint(rl.X + rl.Width, rl.Y), stop, start);
      gtHatch: lb := TGPHatchBrush.Create(HatchStyle, start, stop);
      gtAngle: lb := TGPLinearGradientBrush.Create(rl, start, stop, Angle);
    end;
    bp := nil;
    if BorderColor <> clNone then    
      bp := TGPPen.Create(MakeColor(255, BorderColor), BorderWidth);
    case Shape of
     asRectangle:
     begin
       if Assigned(lb) then
         graphics.FillRectangle(lb, R);

       if Assigned(bp) then
         graphics.DrawRectangle(bp, R);

     end;
     asRoundRect:
     begin
       pth := CreateRoundRectangle(R, BorderRounding, rtBoth, false);
       if Assigned(lb) then
         graphics.FillPath(lb, pth);

       if Assigned(bp) then
         graphics.DrawPath(bp, pth);

       pth.Free;
     end;
     asBalloon:
     begin
       DrawBalloonGP(graphics, lb, bp, R, ScaleX, ScaleY);
     end;
     asCircle:
     begin
       if Assigned(lb) then
         graphics.FillEllipse(lb, R);

       if Assigned(bp) then
         graphics.DrawEllipse(bp, R);

     end;
    end;
    if Assigned(lb) then
      lb.Free;

    if Assigned(bp) then    
      bp.Free;

    mw := 0;
    mh := 0;
    case Shape of
      asCircle:
      begin
        mw := bw;
        mh := bw;
      end;
      asRectangle:
      begin
        mw := bw;
        mh := bw;
      end;
      asRoundRect, asBalloon:
      begin
        mw := brn div 2 - bw;
        mh := brn div 2 - bw;
      end;
    end;

    if (OffsetX < 0) and (OffsetY < 0) then
    begin
      x := dr.Right - mw;
      y := dr.Bottom - mh;
    end
    else if (OffsetX < 0) and (OffsetY > 0) then
    begin
      x := dr.Right - mw;
      y := dr.Top + mh;
    end
    else if (OffsetX > 0) and (OffsetY < 0) then
    begin
      x := dr.Left + mw;
      y := dr.Bottom - mh;
    end
    else
    begin
      x := dr.Left + mw;
      y := dr.Top + mh;
    end;
  end
  else
  begin
    x := Serie.GetDrawPoint(DisplayIndex).x;
    y := Serie.Chart.Series.SeriesRectangle.Bottom;
    xm := x;
    ym := Serie.Chart.Series.SeriesRectangle.Top;
  end;
  path := TGPGraphicsPath.Create;
  pen := TGPPen.Create(MakeColor(255,LineColor), LineWidth);
  path.AddLine(x,y,xm,ym);
  path.CloseFigure;
  
  graphics.DrawPath(pen, path);
  path.Free;
  pen.Free;
  case Arrow of
    arStartArrow:
    begin
      ArrowGDIP(Graphics, Point(x, y), Point(xm, ym), ArrowSize, ArrowColor, ScaleX, ScaleY);
    end;
    arEndArrow:
    begin
      ArrowGDIP(Graphics, Point(xm, ym), Point(x, y), ArrowSize, ArrowColor, ScaleX, ScaleY);
    end;
    arDoubleArrow:
    begin
      ArrowGDIP(Graphics, Point(xm, ym), Point(x, y), ArrowSize, ArrowColor, ScaleX, Scaley);
      ArrowGDIP(Graphics, Point(x, y), Point(xm, ym), ArrowSize, ArrowColor, ScaleX, ScaleY);
    end;
  end;
  graphics.Free;
  // draw text
  Canvas.Brush.Style := bsClear;
  OffsetRect(DR,2,2);
  if Text <> '' then
  begin
    Canvas.Brush.Style := bsClear;
    DTSTYLE  := DT_NOCLIP;
    case TextHorizontalAlignment of
      taLeftJustify: DTSTYLE := DTSTYLE or DT_LEFT;
      taCenter: DTSTYLE := DTSTYLE or DT_CENTER;
      taRightJustify: DTSTYLE := DTSTYLE or DT_RIGHT;
    end;
    case TextVerticalAlignment of
      taAlignTop: DTSTYLE := DTSTYLE or DT_TOP;
      taAlignBottom: DTSTYLE := DTSTYLE or DT_BOTTOM;
      taVerticalCenter: DTSTYLE := DTSTYLE or DT_VCENTER;
    end;
    if WordWrap then
      DTSTYLE := DTSTYLE or DT_WORDBREAK
    else
      DTSTYLE := DTSTYLE or DT_SINGLELINE;
    DrawText(Canvas.Handle, pchar(Text), length(Text), DR, DTSTYLE);
  end;
end;
procedure TChartGDIPAnnotation.DrawBalloonGP(g: TGPGraphics; b: TGPBrush; p: TGPPen; R: TGPRectF;
  ScaleX, ScaleY: Double);
var
  path: TGPGraphicsPath;
begin
  path := CreateBalloonRectangle(R, BalloonDirection, BalloonArrowSize, BorderRounding, rtBoth, false);

  if Assigned(b) then
    g.FillPath(b, path);

  if Assigned(p) then
    g.DrawPath(p, path);

  path.Free;
end;

procedure TChartGDIPAnnotation.SetAngle(const Value: integer);
begin
  if (FAngle <> Value) then
  begin
    FAngle := Value;
    Changed;
  end;
end;
procedure TChartGDIPAnnotation.SetGradientType(const Value: TChartGradientType);
begin
  if (FGradientType <> Value) then
  begin
    FGradientType := Value;
    Changed;
  end;
end;
procedure TChartGDIPAnnotation.SetHatchStyle(const Value: THatchStyle);
begin
  if (FHatchStyle <> Value) then
  begin
    FHatchStyle := Value;
    Changed;
  end;
end;
procedure TChartGDIPAnnotation.SetOpacity(const Value: integer);
begin
  FOpacity := Limit(0,255,Value);
  Changed;
end;
procedure TChartGDIPAnnotation.SetOpacityTo(const Value: integer);
begin
  FOpacityTo := Limit(0,255,Value);
  Changed;
end;
procedure TChartGDIPAnnotation.SetShadow(const Value: boolean);
begin
  if (FShadow <> Value) then
  begin
    FShadow := Value;
    Changed;
  end;
end;
{ TChartGDIPMarker }
procedure TChartGDIPMarker.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if (Source is TChartGDIPMarker) then
  begin
    FGradientType := (Source as TChartGDIPMarker).GradientType;
    FMarkerColorTo := (Source as TChartGDIPMarker).MarkerColorTo;
    FMarkerPicture.Assign((Source as TChartGDIPMarker).MarkerPicture);
    Opacity := (Source as TChartGDIPMarker).Opacity;
    OpacityTo := (Source as TChartGDIPMarker).OpacityTo;
    FSelectedColorTo := (Source as TChartGDIPMarker).SelectedColorTo;
  end;
end;
constructor TChartGDIPMarker.Create;
begin
  inherited Create;
  FMarkerPicture := TChartGDIPPicture.Create;
  FOpacity := 255;
  FSelectedColorTo := clNone;
  FMarkerColorTo := clNone;
  FOpacityTo := 255;
end;
destructor TChartGDIPMarker.Destroy;
begin
  FMarkerPicture.Free;
  inherited;
end;
 
procedure TChartGDIPMarker.LoadFromFile(ini: TMemIniFile; Section: String);
begin
  inherited;
  GradientType := TChartGradientType(ini.ReadInteger(Section, 'GradientType', Integer(GradientType)));
//    property MarkerPicture: TChartGDIPPicture read FMarkerPicture write SetMarkerPicture;
  MarkerColorTo := ini.ReadInteger(Section, 'MarkerColorTo', MarkerColorTo);
  Opacity := ini.ReadInteger(Section, 'Opacity', Opacity);
  OpacityTo := ini.ReadInteger(Section, 'OpacityTo', OpacityTo);
end;
procedure TChartGDIPMarker.SaveToFile(ini: TMemIniFile; Section: String);
begin
  inherited;
  ini.WriteInteger(Section, 'GradientType', Integer(GradientType));
//    property MarkerPicture: TChartGDIPPicture read FMarkerPicture write SetMarkerPicture;
  ini.WriteInteger(Section, 'MarkerColorTo', MarkerColorTo);
  ini.WriteInteger(Section, 'Opacity', Opacity);
  ini.WriteInteger(Section, 'OpacityTo', OpacityTo);
end;
procedure TChartGDIPMarker.SetGradientType(const Value: TChartGradientType);
begin
  if FGradientType <> value then
  begin
    FGradientType := Value;
    Changed;
  end;
end;
procedure TChartGDIPMarker.SetMarkerColorTo(const Value: TColor);
begin
  if FMarkerColorTo <> value then
  begin
    FMarkerColorTo := Value;
    Changed;
  end;
end;
procedure TChartGDIPMarker.SetMarkerPicture(const Value: TChartGDIPPicture);
begin
  if FMarkerPicture <> value then
  begin
    FMarkerPicture.Assign(Value);
    Changed;
  end;
end;
procedure TChartGDIPMarker.SetOpacity(const Value: integer);
begin
  if FOpacity <> value then
  begin
    FOpacity := Limit(0,255,Value);
    Changed;
  end;
end;
procedure TChartGDIPMarker.SetOpacityTo(const Value: integer);
begin
  if FOpacityTo <> value then
  begin
    FOpacityTo := Limit(0,255,Value);
    Changed;
  end;
end;
procedure TChartGDIPMarker.SetSelectedColorTo(const Value: TColor);
begin
  if FSelectedColorTo <> value then
  begin
    FSelectedColorTo := Value;
    Changed;
  end;
end;

//TGDIPChartSeriePie
procedure TGDIPChartSeriePie.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TGDIPChartSeriePie then
  begin
    LegendGradientType := (Source as TGDIPChartSeriePie).LegendGradientType;
    LegendOpacity := (Source as TGDIPChartSeriePie).LegendOpacity;
    LegendOpacityTo := (Source as TGDIPChartSeriePie).LegendOpacityTo;
    LegendHatchStyle := (Source as TGDIPChartSeriePie).LegendHatchStyle;
    LegendGradientAngle := (Source as TGDIPChartSeriePie).LegendGradientAngle;
    LegendTitleGradientType := (Source as TGDIPChartSeriePie).LegendTitleGradientType;
    LegendTitleOpacity := (Source as TGDIPChartSeriePie).LegendTitleOpacity;
    LegendTitleOpacityTo := (Source as TGDIPChartSeriePie).LegendTitleOpacityTo;
    LegendTitleHatchStyle := (Source as TGDIPChartSeriePie).LegendTitleHatchStyle;
    LegendTitleGradientAngle := (Source as TGDIPChartSeriePie).LegendTitleGradientAngle;
  end;
end;
constructor TGDIPChartSeriePie.Create(AOwner: TChartSerie);
begin
  inherited Create(AOwner);
  FLegendGradientType := gtSolid;
  FLegendOpacity := 255;
  FLegendOpacityTo := 255;
  FLegendHatchStyle := HatchStyleHorizontal;
  FLegendGradientAngle := 0;
  FLegendTitleGradientType := gtSolid;
  FLegendTitleOpacity := 255;
  FLegendTitleOpacityTo := 255;
  FLegendTitleHatchStyle := HatchStyleHorizontal;
  FLegendTitleGradientAngle := 0;
end;
procedure TGDIPChartSeriePie.LoadFromFile(ini: TMemIniFile; Section: String);
begin
  inherited;
  LegendGradientType := TChartGradientType(ini.ReadInteger(Section, 'LegendGradientType', integer(LegendGradientType)));
  LegendOpacity := ini.ReadInteger(Section, 'LegendOpacity', LegendOpacity);
  LegendOpacityTo := ini.ReadInteger(Section, 'LegendOpacityTo', LegendOpacityTo);
  LegendHatchStyle := THatchStyle(ini.ReadInteger(Section, 'LegendHatchStyle', Integer(LegendHatchStyle)));
  LegendGradientAngle := ini.ReadInteger(Section, 'LegendGradientAngle', LegendGradientAngle);
  LegendTitleGradientType := TChartGradientType(ini.ReadInteger(Section, 'LegendTitleGradientType', integer(LegendTitleGradientType)));
  LegendTitleOpacity := ini.ReadInteger(Section, 'LegendTitleOpacity', LegendTitleOpacity);
  LegendTitleOpacityTo := ini.ReadInteger(Section, 'LegendTitleOpacityTo', LegendTitleOpacityTo);
  LegendTitleHatchStyle := THatchStyle(ini.ReadInteger(Section, 'LegendTitleHatchStyle', Integer(LegendTitleHatchStyle)));
  LegendTitleGradientAngle := ini.ReadInteger(Section, 'LegendTitleGradientAngle', LegendTitleGradientAngle);
end;
procedure TGDIPChartSeriePie.SaveToFile(ini: TMemIniFile; Section: String);
begin
  inherited;
  ini.WriteInteger(Section, 'LegendGradientType', integer(LegendGradientType));
  ini.WriteInteger(Section, 'LegendOpacity', LegendOpacity);
  ini.WriteInteger(Section, 'LegendOpacityTo', LegendOpacityTo);
  ini.WriteInteger(Section, 'LegendHatchStyle', Integer(LegendHatchStyle));
  ini.WriteInteger(Section, 'LegendGradientAngle', LegendGradientAngle);
  ini.WriteInteger(Section, 'LegendTitleGradientType', integer(LegendTitleGradientType));
  ini.WriteInteger(Section, 'LegendTitleOpacity', LegendTitleOpacity);
  ini.WriteInteger(Section, 'LegendTitleOpacityTo', LegendTitleOpacityTo);
  ini.WriteInteger(Section, 'LegendTitleHatchStyle', Integer(LegendTitleHatchStyle));
  ini.WriteInteger(Section, 'LegendTitleGradientAngle', LegendTitleGradientAngle);
end;
procedure TGDIPChartSeriePie.SetLegendGradientAngle(const Value: Integer);
begin
  if FLegendGradientAngle <> value then
  begin
    FLegendGradientAngle := Value;
    Changed;
  end;
end;
procedure TGDIPChartSeriePie.SetLegendGradientType(
  const Value: TChartGradientType);
begin
  if FLegendGradientType <> value then
  begin
    FLegendGradientType := Value;
    Changed;
  end;
end;
procedure TGDIPChartSeriePie.SetLegendHatchStyle(const Value: THatchStyle);
begin
  if FLegendHatchStyle <> Value then
  begin
    FLegendHatchStyle := Value;
    Changed;
  end;
end;
procedure TGDIPChartSeriePie.SetLegendOpacity(const Value: integer);
begin
  if FLegendOpacity <> value then
  begin
    FLegendOpacity := Limit(0,255,Value);
    Changed;
  end;
end;
procedure TGDIPChartSeriePie.SetLegendOpacityTo(const Value: integer);
begin
  if FLegendOpacityTo <> value then
  begin
    FLegendOpacityTo := Limit(0,255,Value);
    Changed;
  end;
end;
procedure TGDIPChartSeriePie.SetLegendTitleGradientAngle(const Value: integer);
begin
  if FLegendTitleGradientAngle <> value then
  begin
    FLegendTitleGradientAngle := Value;
    Changed;
  end;
end;
procedure TGDIPChartSeriePie.SetLegendTitleGradientType(
  const Value: TChartGradientType);
begin
  if FLegendTitleGradientType <> Value then
  begin
    FLegendTitleGradientType := Value;
    Changed;
  end;
end;
procedure TGDIPChartSeriePie.SetLegendTitleHatchStyle(const Value: THatchStyle);
begin
  if FLegendTitleHatchStyle <> Value then
  begin
    FLegendTitleHatchStyle := Value;
    Changed;
  end;
end;
procedure TGDIPChartSeriePie.SetLegendTitleOpacity(const Value: integer);
begin
  if FLegendTitleOpacity <> Value then
  begin
    FLegendTitleOpacity := Value;
    Changed;
  end;
end;
procedure TGDIPChartSeriePie.SetLegendTitleOpacityTo(const Value: integer);
begin
  if FLegendTitleOpacityTo <> Value then
  begin
    FLegendTitleOpacityTo := Value;
    Changed;
  end;
end;
{ TAdvGDIPZoomControl }
procedure TAdvGDIPZoomControl.Assign(Source: TPersistent);
begin
  if (Source is TAdvGDIPZoomControl) then
  begin
    FLeft := (Source as TAdvGDIPZoomControl).Left;
    FTop := (Source as TAdvGDIPZoomControl).Top;
    FPosition := (Source as TAdvGDIPZoomControl).Position;
    FWidth := (Source as TAdvGDIPZoomControl).Width;
    FHeight := (Source as TAdvGDIPZoomControl).Height;
    FVisible := (Source as TAdvGDIPZoomControl).Visible;
    FSliderOpacity := (Source as TAdvGDIPZoomControl).SliderOpacity;
    FSliderColor := (Source as TAdvGDIPZoomControl).SliderColor;
    FSelectionOpacity := (Source as TAdvGDIPZoomControl).SelectionOpacity;
    FSelectionColor := (Source as TAdvGDIPZoomControl).SelectionColor;
    FBorderColor := (Source as TAdvGDIPZoomControl).BorderColor;
    FBorderOpacity := (Source as TAdvGDIPZoomControl).BorderOpacity;
    FBackGroundColor := (Source as TAdvGDIPZoomControl).Color;
    FBackGroundOpacity := (Source as TAdvGDIPZoomControl).Opacity;
    FSlideRangeFrom := (Source as TAdvGDIPZoomControl).SlideRangeFrom;
    FSlideRangeTo := (Source as TAdvGDIPZoomControl).SlideRangeTo;
    FSlideAutoRange := (Source as TAdvGDIPZoomControl).SlideAutoRange;
    FAutoUpdate := (Source as TAdvGDIPZoomControl).AutoUpdate;
    FSliderLeftPicture.Assign((Source as TAdvGDIPZoomControl).SliderLeftPicture);
    FSliderRightPicture.Assign((Source as TAdvGDIPZoomControl).SliderRightPicture);
    FSliderSize := (Source as TAdvGDIPZoomControl).SliderSize;
    FSliderType := (Source as TAdvGDIPZoomControl).SliderType;
    FSlideMaximumRange := (Source as TAdvGDIPZoomControl).SlideMaximumRange;
    FSlideMinimumRange := (Source as TAdvGDIPZoomControl).SlideMinimumRange;
    Changed;
  end;
end;
procedure TAdvGDIPZoomControl.Changed;
begin
  FOwner.Chart.Changed;
end;
constructor TAdvGDIPZoomControl.Create(AOwner: TAdvGDIPChartPane);
begin
  FOwner := AOwner;
  FVisible := false;
  FPosition := zpBottomRight;
  FWidth := 100;
  FHeight := 50;
  FLeft := 0;
  FTop := 0;
  FSlideRangeTo := 7;
  FSlideRangeFrom := 3;
  FSliderOpacity := 255;
  FSliderColor := clBlack;
  FSelectionOpacity := 100;
  FSelectionColor := clWhite;
  FBorderColor := clDkGray;
  FBorderOpacity := 255;
  FBackGroundColor := clwhite;
  FBackGroundOpacity := 100;
  FSlideAutoRange := true;
  FSlideMaximumRange := 10;
  FSlideMinimumRange := 0;
  FInternalChart := TAdvGDIPChart.Create(FOwner.ChartView);
  FInternalChart.XAxis.Position := xNone;
  FInternalChart.YAxis.Position := yNone;
  FInternalChart.Legend.Visible := false;
  FAutoUpdate := auImmediate;
  FSliderRightPicture := TChartGDIPPicture.Create;
  FSliderLeftPicture := TChartGDIPPicture.Create;
  FSliderRightPicture.OnChange := PictureChanged;
  FSliderLeftPicture.OnChange := PictureChanged;
  FSliderType := stArrow;
  FSliderSize := 8;
end;
destructor TAdvGDIPZoomControl.Destroy;
begin
  FInternalChart.Free;
  FSliderLeftPicture.Free;
  FSliderRightPicture.Free;
  inherited;
end;
procedure TAdvGDIPZoomControl.Draw(Canvas: TCanvas; R: TRect; ScaleX,
  ScaleY: double);
var
  g: TGPGraphics;
  b: TGPBrush;
  bg: TGPRectF;
  p: TGPPen;
  rsstart, rsstop: Trect;
  path: TGPGraphicsPath;
  arrp: TPointArray;
begin
  // Background
  g := TGPGraphics.Create(Canvas.Handle);
  bg := MakeRect(r.Left, r.Top, r.Right - r.Left, r.Bottom - r.Top);
//  b := TGPLinearGradientBrush.Create(bg, MakeColor(Opacity, Color), MakeColor(, clwhite), LinearGradientModeVertical);
  b := TGPSolidBrush.Create(Makecolor(Opacity, Color));
  g.FillRectangle(b, bg);
  p := TGPPen.Create(MakeColor(BorderOpacity, BorderColor));
  g.DrawRectangle(p, bg);
  p.Free;
  b.free;
  g.Free;
  //draw chart
  FInternalChart.Draw(Canvas, R, ScaleX, ScaleY, true);
  rsstart := GetSliderFromRectangle(r);
  rsstop := GetSliderToRectangle(r);
  g := TGPGraphics.Create(Canvas.Handle);
  //draw selection area overlay
  b := TGPSolidBrush.Create(Makecolor(SelectionOpacity, SelectionColor));
  g.FillRectangle(b, Makerect(rsstart.Left, rsstart.Top, rsstop.Right-rsstart.Left, rsstart.Bottom - rsstart.Top));
  b.Free;
  //draw selectors
  b := TGPSolidBrush.Create(MakeColor(SliderOpacity, SliderColor));
  g.FillRectangle(b, Makerect(rsstart.left, rsstart.top, rsstart.Right - rsstart.Left, rsstart.Bottom - rsstart.Top));
  g.FillRectangle(b, Makerect(rsstop.left, rsstop.top, rsstop.Right - rsstop.Left, rsstop.Bottom - rsstop.Top));
  case SliderType of
    stSquare:
    begin
      g.FillRectangle(b, Makerect(rsstart.left - SliderSize / 2, rsstart.Top + ((rsstart.bottom - rsstart.top) / 2) - SliderSize / 2, SliderSize / 2, SliderSize));
      g.FillRectangle(b, Makerect(rsstop.Right - 1, rsstop.Top + ((rsstop.bottom - rsstop.top) / 2) - SliderSize / 2, SliderSize / 2, SliderSize));
    end;
    stArrow:
    begin
      //draw handles
      SetLength(arrp, 3);
      path := TGPGraphicsPath.Create;
      arrp[0] := Point(rsstart.Left, rsstart.Top + ((rsstart.bottom - rsstart.top) div 2) - SliderSize div 2);
      arrp[1] := Point(rsstart.Left, rsstart.Top + ((rsstart.bottom - rsstart.top) div 2) + SliderSize div 2);
      arrp[2] := Point(rsstart.Left - SliderSize div 2, rsstart.Top + ((rsstart.bottom - rsstart.top) div 2));
      path.AddLines(PGPPOINT(arrp), Length(arrp));
      path.CloseFigure;
      g.FillPath(b, path);
      path.Free;
      path := TGPGraphicsPath.Create;
      arrp[0] := Point(rsstop.Right, rsstop.Top + ((rsstop.bottom - rsstop.top) div 2) - SliderSize div 2);
      arrp[1] := Point(rsstop.Right, rsstop.Top + ((rsstop.bottom - rsstop.top) div 2) + SliderSize div 2);
      arrp[2] := Point(rsstop.Right + SliderSize div 2, rsstop.Top + ((rsstop.bottom - rsstop.top) div 2));
      path.AddLines(PGPPOINT(arrp), Length(arrp));
      path.CloseFigure;
      g.FillPath(b, path);
      path.Free;
    end;
    stImage:
    begin
      if Assigned(FSliderLeftPicture) and not FSliderLeftPicture.Empty then
        FSliderLeftPicture.GDIPDraw(g, Bounds(rsstart.left - SliderSize div 2, rsstart.Top + ((rsstart.bottom - rsstart.top) div 2) - SliderSize div 2, SliderSize , SliderSize));
      if Assigned(FSliderRightPicture) and not FSliderRightPicture.Empty then
        FSliderRightPicture.GDIPDraw(g, Bounds(rsstop.left + 2 - slidersize div 2, rsstop.Top + ((rsstop.bottom - rsstop.top) div 2) - SliderSize div 2, SliderSize, SliderSize));
    end;
  end;
  b.free;
  g.Free;
end;
function TAdvGDIPZoomControl.GetSelectionRectangle(r: Trect): Trect;
begin
  result.Left := GetSliderFromRectangle(r).Right;
  result.Top := r.Top;
  result.Right := GetSliderToRectangle(r).Left;
  result.Bottom := r.Bottom;
end;
function TAdvGDIPZoomControl.GetSliderFromRectangle(r: TRect): TRect;
begin
  if Fowner.FSlFrom and Fowner.FMDzoom then
    result.Left := Fowner.FSXFrom - 1
  else
    result.Left := r.Left + Round((Chart.XScale * SlideRangeFrom) + (Chart.GetXScaleStart)) - 1;
  if FOwner.FSelection then
    result.Left := result.Left + FOwner.FSelX;
  Result.Top := r.Top;
  result.Bottom := r.Bottom;
  result.Left := Max(Min(result.Left, Round(r.Right - (Chart.GetXScaleStart))), Round(r.Left + (Chart.GetXScaleStart)));
  result.Right := Result.Left + 2;
end;
function TAdvGDIPZoomControl.GetSliderToRectangle(r: TRect): TRect;
begin
  if Fowner.FSlTo and FOwner.FMDzoom then
    result.Left := Fowner.FSXTo - 1
  else
    result.Left := r.Left + Round((Chart.XScale * SlideRangeTo) + (Chart.GetXScaleStart)) - 1;
  if FOwner.FSelection then
    result.Left := result.Left + FOwner.FSelX;
  Result.Top := r.Top;
  result.Bottom := r.Bottom;
  result.Left := Max(Min(result.Left, Round(r.Right - (Chart.GetXScaleStart))), Round(r.Left + (Chart.GetXScaleStart)));
  result.Right := Result.Left + 2;
end;
function TAdvGDIPZoomControl.GetZoomRectangle(r: TRect): TRect;
var
  x, y: integer;
begin
  if Position <> zpCustom then
  begin
    GetZoomControlPosition(x, y, r, Width, Height, Position);
    result := Bounds(r.Left + x, r.Top + y, Width, Height);
  end
  else
  begin
    result := Bounds(r.Left + Left, r.top + Top, Width, Height);
  end;
  result.Right := result.Right - 2;
  result.Bottom := result.Bottom - 2;
end;
procedure TAdvGDIPZoomControl.LoadFromFile(ini: TMemIniFile; Section: String);
begin
  Visible := ini.ReadBool(Section, 'Visible', Visible);
  Position := TZoomControlPosition(ini.ReadInteger(Section, 'Position', integer(Position)));
  Left := ini.ReadInteger(Section, 'Left', Left);
  Top := ini.ReadInteger(Section, 'Top', Top);
  Width := ini.ReadInteger(Section, 'Width', Width);
  Height := ini.ReadInteger(Section, 'Height', Height);
  SlideRangeFrom := ini.ReadInteger(Section, 'SlideRangeFrom', SlideRangeFrom);
  SlideRangeTo := ini.ReadInteger(Section, 'SlideRangeTo', SlideRangeTo);
  SlideAutoRange := ini.ReadBool(Section, 'SlideAutoRange', SlideAutoRange);
  SlideMaximumRange := ini.ReadInteger(Section, 'SlideMaximumRange', SlideMaximumRange);
  SlideMinimumRange := ini.ReadInteger(Section, 'SlideMinimumRange', SlideMinimumRange);
  SelectionColor := ini.ReadInteger(Section, 'SelectionColor', SelectionColor);
  SelectionOpacity := ini.ReadInteger(Section, 'SelectionOpacity', SelectionOpacity);
  SliderColor := ini.ReadInteger(Section, 'SliderColor', SliderColor);
  SliderOpacity := ini.ReadInteger(Section, 'SliderOpacity', SliderOpacity);
  Color := ini.ReadInteger(Section, 'Color', Color);
  Opacity := ini.ReadInteger(Section, 'Opacity', Opacity);
  BorderColor := ini.ReadInteger(Section, 'BorderColor', BorderColor);
  BorderOpacity := ini.ReadInteger(Section, 'BorderOpacity', BorderOpacity);
  SliderType := TzoomControlSliderType(ini.ReadInteger(Section, 'SliderType', Integer(SliderType)));
  SliderSize := ini.ReadInteger(Section, 'SliderSize', SliderSize);
end;
procedure TAdvGDIPZoomControl.PictureChanged(Sender: TObject);
begin
  Changed;
end;
procedure TAdvGDIPZoomControl.SaveToFile(ini: TMemIniFile; Section: String);
begin
  ini.WriteBool(Section, 'Visible', Visible);
  ini.WriteInteger(Section, 'Position', integer(Position));
  ini.WriteInteger(Section, 'Left', Left);
  ini.WriteInteger(Section, 'Top', Top);
  ini.WriteInteger(Section, 'Width', Width);
  ini.WriteInteger(Section, 'Height', Height);
  ini.WriteInteger(Section, 'SlideRangeFrom', SlideRangeFrom);
  ini.WriteInteger(Section, 'SlideRangeTo', SlideRangeTo);
  ini.WriteBool(Section, 'SlideAutoRange', SlideAutoRange);
  ini.WriteInteger(Section, 'SlideMaximumRange', SlideMaximumRange);
  ini.WriteInteger(Section, 'SlideMinimumRange', SlideMinimumRange);
  ini.WriteInteger(Section, 'SelectionColor', SelectionColor);
  ini.WriteInteger(Section, 'SelectionOpacity', SelectionOpacity);
  ini.WriteInteger(Section, 'SliderColor', SliderColor);
  ini.WriteInteger(Section, 'SliderOpacity', SliderOpacity);
  ini.WriteInteger(Section, 'Color', Color);
  ini.WriteInteger(Section, 'Opacity', Opacity);
  ini.WriteInteger(Section, 'BorderColor', BorderColor);
  ini.WriteInteger(Section, 'BorderOpacity', BorderOpacity);
  ini.WriteInteger(Section, 'SliderType', Integer(SliderType));
  ini.WriteInteger(Section, 'SliderSize', SliderSize);
end;
procedure TAdvGDIPZoomControl.SetAutoUpdate(
  const Value: TZoomControlAutoUpdate);
begin
  if FAutoUpdate <> value then
  begin
    FAutoUpdate := Value;
    Changed;
  end;
end;
procedure TAdvGDIPZoomControl.SetBackGroundColor(const Value: TColor);
begin
  if FBackGroundColor <> value then
  begin
    FBackGroundColor := Value;
    Changed;
  end;
end;
procedure TAdvGDIPZoomControl.SetBackGroundOpacity(const Value: Byte);
begin
  if FBackGroundOpacity <> value then
  begin
    FBackGroundOpacity := Value;
    Changed;
  end;
end;
procedure TAdvGDIPZoomControl.SetBorderColor(const Value: TColor);
begin
  if FBorderColor <> value then
  begin
    FBorderColor := Value;
    Changed;
  end;
end;
procedure TAdvGDIPZoomControl.SetBorderOpacity(const Value: Byte);
begin
  if FBorderOpacity <> Value then
  begin
    FBorderOpacity := Value;
    Changed;
  end;
end;
procedure TAdvGDIPZoomControl.SetHeight(const Value: integer);
begin
  if FHeight <> value then
  begin
    FHeight := Value;
    Changed;
  end;
end;
procedure TAdvGDIPZoomControl.SetLeft(const Value: integer);
begin
  if FLeft <> Value then
  begin
    FLeft := Value;
    Changed;
  end;
end;
procedure TAdvGDIPZoomControl.SetPosition(const Value: TZoomControlPosition);
begin
  if FPosition <> value then
  begin
    FPosition := Value;
    Changed;
  end;
end;
procedure TAdvGDIPZoomControl.SetSelectionColor(const Value: TColor);
begin
  if FSelectionColor <> value then
  begin
    FSelectionColor := Value;
    Changed;
  end;
end;
procedure TAdvGDIPZoomControl.SetSelectionOpacity(const Value: Byte);
begin
  if FSelectionOpacity <> value then
  begin
    FSelectionOpacity := Value;
    Changed;
  end;
end;
procedure TAdvGDIPZoomControl.SetSlideAutoRange(const Value: Boolean);
begin
  if FSlideAutoRange <> value then
  begin
    FSlideAutoRange := Value;
    Changed;
  end;
end;
procedure TAdvGDIPZoomControl.SetSlideMaximumRange(const Value: integer);
begin
  if FSlideMaximumRange <> Value then
  begin
    FSlideMaximumRange := Value;
    Changed;
  end;
end;
procedure TAdvGDIPZoomControl.SetSlideMinimumRange(const Value: integer);
begin
  if FSlideMinimumRange <> Value then
  begin
    FSlideMinimumRange := Value;
    Changed;
  end;
end;
procedure TAdvGDIPZoomControl.SetSlideRangeFrom(const Value: integer);
begin
//  if (Value >= Chart.Range.RangeFrom) and (Value <= Chart.Range.RangeTo) then
    FSlideRangeFrom := Value;
//  else
//    FSlideRangeFrom := 0;
  Changed;
end;
procedure TAdvGDIPZoomControl.SetSlideRangeTo(const Value: integer);
begin
//  if (Value >= Chart.Range.RangeFrom) and (Value <= Chart.Range.RangeTo) then
    FSlideRangeTo := Value;
//  else
//    FSlideRangeTo := Chart.Range.RangeTo;
  Changed;
end;
procedure TAdvGDIPZoomControl.SetSliderColor(const Value: TColor);
begin
  if FSliderColor <> value then
  begin
    FSliderColor := Value;
    Changed;
  end;
end;
procedure TAdvGDIPZoomControl.SetSliderLeftPicture(
  const Value: TChartGDIPPicture);
begin
  if FSliderLeftPicture <> Value then
  begin
    FSliderLeftPicture.Assign(Value);
    Changed;
  end;
end;
procedure TAdvGDIPZoomControl.SetSliderOpacity(const Value: Byte);
begin
  if FSliderOpacity <> Value then
  begin
    FSliderOpacity := Value;
    Changed;
  end;
end;
procedure TAdvGDIPZoomControl.SetSliderRightPicture(
  const Value: TChartGDIPPicture);
begin
  if FSliderRightPicture <> Value then
  begin
    FSliderRightPicture.Assign(Value);
    Changed;
  end;
end;
procedure TAdvGDIPZoomControl.SetSliderSize(const Value: Integer);
begin
  if FSliderSize <> value then
  begin
    FSliderSize := Value;
    Changed;
  end;
end;
procedure TAdvGDIPZoomControl.SetSliderType(
  const Value: TZoomControlSliderType);
begin
  if FSliderType <> value then
  begin
    FSliderType := Value;
    Changed;
  end;
end;
procedure TAdvGDIPZoomControl.SetTop(const Value: integer);
begin
  if FTop <> value then
  begin
    FTop := Value;
    Changed;
  end;
end;
procedure TAdvGDIPZoomControl.SetVisible(const Value: Boolean);
begin
  if FVisible <> value then
  begin
    FVisible := Value;
    Changed;
  end;
end;
procedure TAdvGDIPZoomControl.SetWidth(const Value: integer);
begin
  if FWidth <> value then
  begin
    FWidth := Value;
    Changed;
  end;
end;
end.
