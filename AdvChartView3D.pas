{***************************************************************************}
{ TAdvChartView3D component                                                 }
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

unit AdvChartView3D;

{$I TMSDEFS.INC}

interface

uses
  Classes, Windows, Messages, Graphics, Types,
  OpenGL, SysUtils, Variants, Controls, AdvChartGDIP,
  AdvOpenGLControl, AdvOpenGLX, AdvOpenGLUT, AdvOpenGLUtil
  {$IFDEF DELPHIXE3_LVL}
  , UITypes
  {$ENDIF}
  ;

const
  GL_MULTISAMPLE = $809D;

  MAJ_VER = 1; // Major version nr.
  MIN_VER = 0; // Minor version nr.
  REL_VER = 2; // Release nr.
  BLD_VER = 4; // Build nr.
  DATE_VER = 'JULY, 2017'; // Month version
  CLICKMARGIN = 4;

  // version history
  // 1.0.0.0 : First release
  // 1.0.0.1 : Fixed : Issue with memory leak when creating multiple instances
  // 1.0.0.2 : Fixed : Issue with Top and Left properties not being used
  // 1.0.1.0 : New : PercentageFormat property
  //         : New : OnGetLabelValue event
  // 1.0.2.0 : New : SaveToStream method
  //         : Fixed : Issue with maximum vertex count, causing wrong shading
  // 1.0.2.1 : Fixed : Issue with C++Builder compilation in AdvOpenGLUtil
  // 1.0.2.2 : Fixed : Issues with compilation in C++Builder 2009

type
  TChartType3D = (ctPie3D);

  TChartGradientDirection3D = (gdVertical, gdHorizontal);

  TChartSizeType3D = (stPixels, stPercentage);
  TChartCameraChartType3D = (ckBestView, ckTopCamera, ckRightCamera, ckLeftCamera);
  TChartTextAlignment3D = (taRight, taLeft, taCenter);
  TChartItemPosition3D = (ipTopLeft, ipTopCenter, ipTopRight, ipCenterLeft, ipCenterRight, ipCenterCenter,
    ipBottomLeft, ipBottomCenter, ipBottomRight);

  TChartPosition3D = record
    x, y, z: single;
  end;

  TChartPosition4D = record
    x, y, z, d4: single;
  end;

  TChartPosition2D = record
    x, y: Single;
  end;

  TChartSerie3D = class;
  TChartLegend3D = class;
  TAdvChartView3D = class;

  TChartBase3D = class(TPersistent)
  private
    FChart: TAdvChartView3D;
    procedure UpdateChart;
  public
    property Chart: TAdvChartView3D read FChart;
    constructor Create(AOwner: TPersistent); virtual;
  end;

  TChartGradientFill3D = class(TChartBase3D)
  private
    FColor: TColor;
    FEndColor: TColor;
    FVisible: boolean;
    FDirection: TChartGradientDirection3D;
    procedure SetColor(const Value: TColor);
    procedure SetEndColor(const Value: TColor);
    procedure SetVisible(const Value: boolean);
    procedure SetDirection(const Value: TChartGradientDirection3D);
  public
    constructor Create(AOwner: TPersistent); override;
    procedure Assign(Source: TPersistent); override;
  published
    property Direction: TChartGradientDirection3D read FDirection write SetDirection default gdVertical;
    property Color: TColor read FColor write SetColor default clWhite;
    property EndColor: TColor read FEndColor write SetEndColor default $E3E4E5;
    property Visible: boolean read FVisible write SetVisible default True;
  end;

  TChartLine3D = class(TChartBase3D)
  private
    FVisible: boolean;
    FWidth: integer;
    FStyle: DashStyle;
    FColor: TColor;
    procedure SetVisible(const Value: boolean);
    procedure SetWidth(const Value: integer);
    procedure SetStyle(const Value: DashStyle);
    procedure SetColor(const Value: TColor);
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(AOwner: TPersistent); override;
  published
    property Color: TColor read FColor write SetColor default clDkGray;
    property Style: DashStyle read FStyle write SetStyle default DashStyleSolid;
    property Visible: boolean read FVisible write SetVisible default True;
    property Width: integer read FWidth write SetWidth default 1;
  end;

  TChartSize = record
  cx, cy: Double;
  end;

  TChartValues3D = class(TChartBase3D)
  private
    FImageVisible: boolean;
    FTextAreaPos, FImagePos: TGPRectF;
    FImageAspectRatio: boolean;
    FTickMarkLength: Integer;
    FFill: TChartGradientFill3D;
    FBorder: TChartLine3D;
    FVisible, FShowCaptions, FShowValues, FShowPercentages: boolean;
    FCaptionsFont, FValuesFont: TFont;
    FImagePosition: TChartItemPosition3D;
    FCaptionAlignment: TChartTextAlignment3D;
    FValuesAlignment: TChartTextAlignment3D;
    FValueFormat: string;
    FTransparency: integer;
    FImageWidth, FImageHeight: integer;
    FTickMarkSize: Integer;
    FTickMarkColor: TColor;
    FPercentageFormat: String;
    procedure SetImageVisible(const Value: boolean);
    procedure SetImageHeight(const Value: integer);
    procedure SetImageWidth(const Value: integer);
    function CalcTextSize(GPGraphics: TGPGraphics; AScale: single; const ACaption: String; var APercentage: String; var AValue: string; APercentageValue, AValueValue: Single; Image: TChartGDIPPicture): TChartSize;
    function GetFmtValue(var APercentage: String; var AValue: string; APercentageValue, AValueValue: Single): string;
    procedure SetImagePosition(const Value: TChartItemPosition3D);
    procedure SetTickMarkLength(const Value: Integer);
    procedure SetTransparency(const Value: integer);
    procedure SetVisible(const Value: boolean);
    procedure Render(GPGraphics: TGPGraphics; AScale: single; AImage: TChartGDIPPicture; ACaption, APercentage, AValue: string; APercentageValue, AValueValue: Single; x, y: Double);
    procedure SetShowCaptions(const value: boolean);
    procedure SetShowValues(const Value: boolean);
    procedure SetShowPercentages(const Value: boolean);
    procedure SetCaptionAlignment(const Value: TChartTextAlignment3D);
    procedure SetValuesAlignment(const Value: TChartTextAlignment3D);
    procedure SetValueFormat(const Value: string);
    procedure SetImageAspectRatio(const Value: boolean);
    procedure UpdateChart;
    procedure SetTickMarkColor(const Value: TColor);
    procedure SetTickMarkSize(const Value: Integer);
    procedure SetPercentageFormat(const Value: String);
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
  published
    property ImageVisible: boolean read FImageVisible write SetImageVisible default True;
    property ImageAspectRatio: boolean read FImageAspectRatio write SetImageAspectRatio default True;
    property ImageHeight: integer read FImageHeight write SetImageHeight default 128;
    property ImageWidth: integer read FImageWidth write SetImageWidth default 128;
    property ImagePosition: TChartItemPosition3D read FImagePosition write SetImagePosition default ipCenterCenter;
    property TickMarkLength: Integer read FTickMarkLength write SetTickMarkLength default 15;
    property TickMarkSize: Integer read FTickMarkSize write SetTickMarkSize default 2;
    property TickMarkColor: TColor read FTickMarkColor write SetTickMarkColor default clSilver;
    property Fill: TChartGradientFill3D read FFill write FFill;
    property Border: TChartLine3D read FBorder write FBorder;
    property ShowCaptions: boolean read FShowCaptions write SetShowCaptions default False;
    property ShowValues: boolean read FShowValues write SetShowValues default True;
    property ShowPercentages: boolean read FShowPercentages write SetShowPercentages default False;
    property CaptionsFont: TFont read FCaptionsFont write FCaptionsFont;
    property ValuesFont: TFont read FValuesFont write FValuesFont;
    property CaptionAlignment: TChartTextAlignment3D read FCaptionAlignment write SetCaptionAlignment default taCenter;
    property ValuesAlignment: TChartTextAlignment3D read FValuesAlignment write SetValuesAlignment default taCenter;
    property ValueFormat: string read FValueFormat write SetValueFormat;
    property PercentageFormat: String read FPercentageFormat write SetPercentageFormat;
    property Visible: boolean read FVisible write SetVisible default True;
    property Transparency: integer read FTransParency write SetTransparency default 255;
  end;

  TPointArray = array of TPoint;

  TChartShape3D = class(TCollectionItem)
  private
    FCountVertices: Integer;
    FTransparency: integer;
    FExtraction: single;
    FElevation: single;
    FImage: TChartGDIPPicture;
    FInternalShine: single;
    FCaption: string;
    FColor: TColor;
    FStartAngle, FEndAngle: double;
    FLeft, FTop, FZLocation, FDepth: single;
    FPercentage: Single;
    FValue: Extended;
    FVisible: Boolean;
    FSize: Single;
    FExpansion: Single;
    procedure SetExtraction(const Value: single);
    procedure SetValue(const Value: Extended);
    function GetSerie: TChartSerie3D;
    procedure SetColor(const Value: TColor);
    procedure RenderCylinder(AOriginX, AOriginY, AOriginZ, ARadius,
      ADepth: single; AId: Integer; AStartAngle, AEndangle: Double; AColor: TColor);
    procedure SetCaption(const Value: string);
    function GetChart: TAdvChartView3D;
    procedure SetElevation(const Value: single);
    procedure SetTransparency(const Value: integer);
    procedure SetImage(const Value: TChartGDIPPicture);
    procedure SetVisible(const Value: Boolean);
    procedure SetExpansion(const Value: Single);
  protected
    D2Position: array[0..10] of TChartPosition2D;
    D2PositionDetection: array of TChartPosition2D;

    { calculated values }
    property EndAngle: double read FEndAngle write FEndAngle;
    property StartAngle: double read FStartAngle write FStartAngle;
    property Percentage: single read FPercentage write FPercentage;
    property Top: single read FTop write FTop;
    property Left: single read FLeft write FLeft;
    property Depth: single read FDepth write FDepth;
    property Size: Single read FSize write FSize;
    property ZLocation: single read FZLocation write FZLocation;

    function GetTopPathArray: TPointArray;
    function GetBottomPathArray: TPointArray;
    function GetArcArray: TPointArray;
    function GetLeftSideArray: TPointArray;
    function GetRightSideArray: TPointArray;

    procedure Render;
    procedure Render2D(GPGraphics: TGPGraphics; const AScale: single);
    procedure UpdateChart;
  public
    id: integer;
    property Caption: string Read FCaption write SetCaption;
    property Chart: TAdvChartView3D read GetChart;
    property Serie: TChartSerie3D read GetSerie;
    property Color: TColor read FColor write SetColor default clRed;
    property Value: Extended read FValue write SetValue;
    property Transparency: integer read FTransParency write SetTransparency default 255;
    property Image: TChartGDIPPicture read FImage write SetImage;
    property Expansion: Single read FExpansion write SetExpansion;
    property Extraction: single read FExtraction write SetExtraction;
    property Elevation: single read FElevation write SetElevation;
    property Visible: Boolean read FVisible write SetVisible default True;
    procedure Assign(Source: TPersistent); override;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  end;

  TChartItem3D = class(TChartShape3D)
  public
    constructor Create(Collection: TCollection); override;
  published
    property Caption;
    property Color;
    property Extraction;
    property Elevation;
    property Image;
    property Transparency;
    property Value;
    property Visible;
  end;

  TChartItems3D = class(TCollection)
  private
    FOwner: TPersistent;
    function GetItem(index: integer): TChartItem3D;
    procedure SetItem(index: integer; value: TChartItem3D);
  public
    function GetSerie: TChartSerie3D;
    procedure UpdateSerie; overload;
    constructor Create(AOwner: TPersistent);
    function Add: TChartItem3D;
    function Insert(index: integer): TChartItem3D;
    property Items[Index: integer]: TChartItem3D read GetItem write SetItem; default;
  end;

  TChartSeries3D = class;

  TChartSerie3D = class(TCollectionItem)
  private
    FYRotation, FXRotation, FZRotation: single;
    FTransParency: integer;
    FCaption: string;
    FLeft, FTop, FSize, FDepth: single;
    FItems: TChartItems3D;
    FChartType: TChartType3D;
    FValues: TChartValues3D;
    FLegend: TChartLegend3D;
    FVisible: Boolean;
    FSizeType: TChartSizeType3D;
    FInteraction: Boolean;
    procedure SetDepth(const Value: single);
    procedure SetLeft(const Value: single);
    procedure SetTop(const Value: single);
    procedure SetXRotation(const Value: single);
    procedure SetYRotation(const Value: single);
    procedure SetZRotation(const Value: single);
    procedure UpdateChart overload;
    procedure Render;
    procedure RenderItems;
    procedure Render2D(GPGraphics: TGPGraphics; const AScale: single);
    procedure SetCaption(const Value: string);
    function GetChart: TAdvChartView3D;
    procedure SetChartType(const Value: TChartType3D);
    procedure SetLegend(const Value: TChartLegend3D);
    procedure SetValues(const Value: TChartValues3D);
    procedure SetVisible(const Value: Boolean);
    procedure SetSize(const Value: single);
    procedure SetSizeType(const Value: TChartSizeType3D);
    procedure SetInteraction(const Value: Boolean);
  protected
    procedure CalcValues;
    function GetSize: Double;
    function GetTotal: Double;
    function GetSerieRectangle(A3DRectangle: Boolean = False): TGPRectF;
  public
    property Chart: TAdvChartView3D read GetChart;
    procedure Delete(index: integer);
    function Add: TChartItem3D;
    function XYToItem(X, Y: Integer): TChartItem3D;
    procedure Clear;
    procedure Assign(Source: TPersistent); override;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    function GetDisplayName: string; override;
  published
    property Interaction: Boolean read FInteraction write SetInteraction default True;
    property Legend: TChartLegend3D read FLegend write SetLegend;
    property Values: TChartValues3D read FValues write SetValues;
    property Items: TChartItems3D read FItems write FItems;
    property Depth: single read FDepth write SetDepth;
    property Top: single read FTop write SetTop;
    property Left: single read FLeft write SetLeft;
    property Size: single read FSize write SetSize;
    property SizeType: TChartSizeType3D read FSizeType write SetSizeType default stPixels;
    property Caption: string read FCaption write SetCaption;
    property ChartType: TChartType3D read FChartType write SetChartType default ctPie3D;
    property XRotation: single read FXRotation write SetXRotation;
    property YRotation: single read FYRotation write SetYRotation;
    property ZRotation: single read FZRotation write SetZRotation;
    property Visible: Boolean read FVisible write SetVisible default True;
  end;

  TChartSeries3D = class(TCollection)
  private
    FOwner: TPersistent;
    procedure SetItems(index: integer; value: TChartSerie3D);
    function GetItems(index: integer): TChartSerie3D;
    function GetChart: TAdvChartView3D;
  public
    property Chart: TAdvChartView3D read GetChart;
    function GetOwner: TPersistent; override;
    constructor Create(AOwner: TPersistent);
    procedure UpdateChart; overload;
    property Items[Index: integer]: TChartSerie3D read GetItems write SetItems; default;
    function Add: TChartSerie3D;
    function Insert(Index: integer): TChartSerie3D;
    procedure Delete(Index: integer);
    procedure Clear;
    procedure Render;
    procedure Render2D(GPGraphics: TGPGraphics; const AScale: single);
  end;

  TChartLegend3D = class(TChartBase3D)
  private
    FVisible: boolean;
    FCaptionVisible: boolean;
    FItemsFont: TFont;
    FCaptionFont: TFont;
    FFill: TChartGradientFill3D;
    FBorder: TChartLine3D;
    FPosition: TChartItemPosition3D;
    FCaptionAlignment: TChartTextAlignment3D;
    FMargin: integer;
    FPadding: integer;
    FItemsAlignment: TChartTextAlignment3D;
    FTransparency: Integer;
    procedure RenderLegend(GPGraphics: TGPGraphics; AScale: single; AreaBox: TGPRectF; Serie: TChartSerie3D);
    procedure RenderSerieShape(GPGraphics: TGPGraphics; AShapeRect: TGPRectF; SerieItem: TChartItem3D);
    procedure SetVisible(const Value: boolean);
    procedure SetPosition(const Value: TChartItemPosition3D);
    procedure SetCaptionAlignment(const Value: TChartTextAlignment3D);
    procedure SetCaptionVisible(const Value: boolean);
    procedure SetMargin(const Value: integer);
    procedure SetPadding(const Value: integer);
    procedure SetTransparency(const Value: Integer);
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
  published
    property Transparency: Integer read FTransparency write SetTransparency default 255;
    property Padding: integer read FPadding write SetPadding default 5;
    property CaptionFont: TFont read FCaptionFont write FCaptionFont;
    property ItemsFont: TFont read FItemsFont write FItemsFont;
    property CaptionVisible: boolean read FCaptionVisible write SetCaptionVisible default True;
    property Margin: integer read FMargin write SetMargin default 5;
    property Fill: TChartGradientFill3D read FFill write FFill;
    property Border: TChartLine3D read FBorder write FBorder;
    property Position: TChartItemPosition3D read FPosition write SetPosition default ipTopLeft;
    property Visible: boolean read FVisible write SetVisible default True;
    property CaptionAlignment: TChartTextAlignment3D read FCaptionAlignment write SetCaptionAlignment default taCenter;
  end;

  TChartTitle3D = class(TChartBase3D)
  private
    FPadding, FMargin: integer;
    FVisible: boolean;
    FFont: TFont;
    FFill: TChartGradientFill3D;
    FBorder: TChartLine3D;
    FPosition: TChartItemPosition3D;
    FAlignment: TChartTextAlignment3D;
    FText: string;
    FTransparency: Integer;
    procedure RenderTitle(GPGraphics: TGPGraphics; const AScale: single; AreaBox: TGPRectF);
    procedure SetVisible(const Value: boolean);
    procedure SetPosition(const Value: TChartItemPosition3D);
    procedure SetAlignment(const Value: TChartTextAlignment3D);
    procedure SetMargin(const Value: integer);
    procedure SetPadding(const Value: integer);
    procedure SetBorder(const Value: TChartLine3D);
    procedure SetFill(const Value: TChartGradientFill3D);
    procedure SetFont(const Value: TFont);
    procedure SetText(const Value: string);
    procedure SetTransparency(const Value: Integer);
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Transparency: Integer read FTransparency write SetTransparency default 255;
    property Alignment: TChartTextAlignment3D read FAlignment write SetAlignment default taCenter;
    property Border: TChartLine3D read FBorder write SetBorder;
    property Fill: TChartGradientFill3D read FFill write SetFill;
    property Font: TFont read FFont write SetFont;
    property Position: TChartItemPosition3D read FPosition write SetPosition default ipTopCenter;
    property Margin: integer read FMargin write SetMargin default 5;
    property Padding: integer read FPadding write SetPadding default 5;
    property Text: string read FText write SetText;
    property Visible: boolean read FVisible write SetVisible default True;
  end;

  TAdvChartView3DGetValueEvent = procedure(Sender: TObject; APercentage: Single; AValue: Single; var APercentageString: String; var AValueString: String; var AFormattedString: String) of object;

  TAdvChartView3DItemClickEvent = procedure(Sender: TObject; ASerie: TChartSerie3D; AItem: TChartItem3D) of object;

  {$IFDEF DELPHIXE2_LVL}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  {$ENDIF}
  TAdvChartView3D = class(TAdvOpenGLControl)
  private
    FMoved: Boolean;
    FActiveSerie: TChartSerie3D;
    FX, FY: Integer;
    FMouseDown: Boolean;
    FVersion: string;
    FUpdateCount: Integer;
    FDesignTime, FConstructed: Boolean;
    FColor: TColor;
    FSeries: TChartSeries3D;
    FTitle: TChartTitle3D;
    FOnGetValue: TAdvChartView3DGetValueEvent;
    FOnItemClick: TAdvChartView3DItemClickEvent;
    procedure SetColor(const Value: TColor);
    procedure SetTitle(const Value: TChartTitle3D);
    procedure Setversion(const Value: string);
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
  protected
    procedure CreateWnd; override;
    procedure RenderControl; override;
    procedure RenderControl2D(GPGraphics: TGPGraphics); override;
    procedure CalcSeries;
    function GetVersionNr: Integer; virtual;
    function GetVersionString: string; virtual;
    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    function GetCountVisibleSeries: Integer;
    function Get2DPosition(x, y, z: Double): TChartPosition2D;
    function Get3DPosition(x, y: Double): TChartPosition3D;
    procedure DoItemClick(ASerie: TChartSerie3D; AItem: TChartItem3D); virtual;
    procedure RenderChart;
    procedure DoRecalculate; override;
  public
    procedure SaveToImage(Filename: String; ImageType: TImageType = itPNG; ImageWidth: Integer = -1;
      ImageHeight: Integer = -1; ImageQualityPercentage: integer = 100);
    procedure SaveToStream(AStream: TStream; AWidth: Integer = - 1; AHeight: integer = -1);
    function XYToSerie(X, Y: Integer): TChartSerie3D;
    constructor Create(o: TComponent); override;
    procedure Assign(Source: TPersistent); override;
    destructor Destroy; override;
    procedure UpdateChart;
    procedure InitSample;
    procedure BeginUpdate; override;
    procedure EndUpdate; override;
  published
    property OnGetLabelValue: TAdvChartView3DGetValueEvent read FOnGetValue write FOnGetValue;
    property OnItemClick: TAdvChartView3DItemClickEvent read FOnItemClick write FOnItemClick;
    property Color: TColor read FColor write SetColor default clWhite;
    property Align;
    property Anchors;
    property Constraints;
    property PopupMenu;
    property Series: TChartSeries3D read FSeries write FSeries;
    property ShowHint;
    property TabOrder;
    property TabStop default True;
    property Title: TChartTitle3D read FTitle write SetTitle;
    property Version: string read FVersion write Setversion;
    property Visible;
    property OnCanResize;
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
    property Ctl3D;
    property ParentShowHint;
    property DragKind;
    property DragMode;
    property OnStartDrag;
    property OnEndDrag;
    property OnDragDrop;
    property OnDragOver;
    {$IFDEF DELPHI_TOUCH}
    property OnGesture;
    property Touch;
    {$ENDIF}
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind;
    property BevelWidth;
    property BiDiMode;
    property DockSite;
    property DoubleBuffered;
    property DragCursor;
    property Enabled;
    {$IFDEF DELPHI2006_LVL}
    property Margins;
    property Padding;
    property ParentBackground default False;
    {$ENDIF}
    property ParentBiDiMode;
    property ParentCtl3D;
    property ParentFont;
    property OnConstrainedResize;
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    property OnGetSiteInfo;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnStartDock;
    property OnUnDock;
  end;

implementation

uses
  Math;

procedure AssignFont(Font1, Font2: TFont); forward;

function PtInGPRect(r: TGPRectF; pt: TPoint): Boolean;
begin
  result := ((pt.X >= r.X) and (pt.X <= r.X + r.Width)) and
     ((pt.Y >= r.Y) and (pt.Y <= r.Y + r.Height));
end;


function Darker(Color:TColor; Percent:Byte):TColor;
var
  r, g, b:Byte;
begin
  Color := ColorToRGB(Color);
  r := GetRValue(Color);
  g := GetGValue(Color);
  b := GetBValue(Color);
  r := r - muldiv(r, Percent, 100);  //Percent% closer to black
  g := g - muldiv(g, Percent, 100);
  b := b - muldiv(b, Percent, 100);
  result := RGB(r, g, b);
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
  if (fsStrikeOut in AFont.Style) then
    fs := fs + 8;

  Result := TGPFont.Create(fontFamily, AFont.Size , fs, UnitPoint);

  fontFamily.Free;
end;

function TChartShape3D.GetArcArray: TPointArray;
var
  I: Integer;
begin
  if Length(D2PositionDetection) = 0 then
    Exit;

  for I := 0 to Length(D2PositionDetection) - 3 - FCountVertices - 1 do
  begin
    SetLength(Result, Length(Result) + 1);
    Result[Length(Result) - 1] := Point(Round(D2PositionDetection[I].x), Round(D2PositionDetection[I].y));
  end;

  for I := Length(D2PositionDetection) - 3 downto FCountVertices + 1 do
  begin
    SetLength(Result, Length(Result) + 1);
    Result[Length(Result) - 1] := Point(Round(D2PositionDetection[I].x), Round(D2PositionDetection[I].y));
  end;

  SetLength(Result, Length(Result) + 1);
  Result[Length(Result) - 1] := Result[0];
end;

function TChartShape3D.GetBottomPathArray: TPointArray;
var
  I: Integer;
begin
  if Length(D2PositionDetection) = 0 then
    Exit;

  for I := FCountVertices + 1 to Length(D2PositionDetection) - 2 do
  begin
    SetLength(Result, Length(Result) + 1);
    Result[Length(Result) - 1] := Point(Round(D2PositionDetection[I].x), Round(D2PositionDetection[I].y));
  end;

  SetLength(Result, Length(Result) + 1);
  Result[Length(Result) - 1] := Point(Round(D2PositionDetection[Length(D2PositionDetection) - 2].X), Round(D2PositionDetection[Length(D2PositionDetection) - 2].y));

  SetLength(Result, Length(Result) + 1);
  Result[Length(Result) - 1] := Result[0];
end;

function TChartShape3D.GetChart: TAdvChartView3D;
begin
  Result := Serie.Chart;
end;

function TChartShape3D.GetLeftSideArray: TPointArray;
begin
  if Length(D2PositionDetection) = 0 then
    Exit;

  SetLength(Result, Length(Result) + 1);
  Result[Length(Result) - 1] := Point(Round(D2PositionDetection[Length(D2PositionDetection) - 1].X), Round(D2PositionDetection[Length(D2PositionDetection) - 1].y));

  SetLength(Result, Length(Result) + 1);
  Result[Length(Result) - 1] := Point(Round(D2PositionDetection[0].x), Round(D2PositionDetection[0].y));

  SetLength(Result, Length(Result) + 1);
  Result[Length(Result) - 1] := Point(Round(D2PositionDetection[FCountVertices + 1].x), Round(D2PositionDetection[FCountVertices + 1].y));

  SetLength(Result, Length(Result) + 1);
  Result[Length(Result) - 1] := Point(Round(D2PositionDetection[Length(D2PositionDetection) - 2].X), Round(D2PositionDetection[Length(D2PositionDetection) - 2].y));

  SetLength(Result, Length(Result) + 1);
  Result[Length(Result) - 1] := Result[0];
end;

function TChartShape3D.GetRightSideArray: TPointArray;
begin
  if Length(D2PositionDetection) = 0 then
    Exit;

  SetLength(Result, Length(Result) + 1);
  Result[Length(Result) - 1] := Point(Round(D2PositionDetection[Length(D2PositionDetection) - 2].X), Round(D2PositionDetection[Length(D2PositionDetection) - 2].y));

  SetLength(Result, Length(Result) + 1);
  Result[Length(Result) - 1] := Point(Round(D2PositionDetection[Length(D2PositionDetection) - 3].x), Round(D2PositionDetection[Length(D2PositionDetection) - 3].y));

  SetLength(Result, Length(Result) + 1);
  Result[Length(Result) - 1] := Point(Round(D2PositionDetection[FCountVertices].x), Round(D2PositionDetection[FCountVertices].y));

  SetLength(Result, Length(Result) + 1);
  Result[Length(Result) - 1] := Point(Round(D2PositionDetection[Length(D2PositionDetection) - 1].X), Round(D2PositionDetection[Length(D2PositionDetection) - 1].y));

  SetLength(Result, Length(Result) + 1);
  Result[Length(Result) - 1] := Result[0];
end;

procedure TChartShape3D.Assign(Source: TPersistent);
begin
  if Source is TChartShape3D then
  begin
    FExpansion := (Source as TChartShape3D).Expansion;
    FVisible := (Source as TChartShape3D).Visible;
    FCaption := (Source as TChartShape3D).caption;
    FColor := (Source as TChartShape3D).Color;
    FValue := (Source as TChartShape3D).Value;
    FImage.Assign((Source as TChartShape3D).Image);
    FElevation := (Source as TChartShape3D).Elevation;
    FExtraction := (Source as TChartShape3D).Extraction;
  end;
end;

procedure TChartShape3D.SetTransparency(const Value: integer);
begin
  if FTransParency <> Value then
  begin
    FTransparency := value;
    UpdateChart
  end;
end;

procedure TChartSerie3D.SetValues(const Value: TChartValues3D);
begin
  if FValues <> Value then
  begin
    FValues.Assign(Value);
    UpdateChart;
  end;
end;

procedure TChartSerie3D.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := value;
    UpdateChart
  end;
end;

procedure TChartSerie3D.SetSize(const Value: single);
begin
  if FSize <> Value then
  begin
    FSize := Value;
    UpdateChart;
  end;
end;

procedure TChartSerie3D.SetSizeType(const Value: TChartSizeType3D);
begin
  if FSizeType <> Value then
  begin
    FSizeType := Value;
    UpdateChart;
  end;
end;

procedure TChartSerie3D.SetXRotation(const Value: single);
begin
  if FXRotation <> Value then
  begin
    FXRotation := value;
    UpdateChart
  end;
end;

procedure TChartSerie3D.SetYRotation(const Value: single);
begin
  if FYRotation <> Value then
  begin
    FYRotation := value;
    UpdateChart
  end;
end;

procedure TChartSerie3D.SetZRotation(const Value: single);
begin
  if FZRotation <> Value then
  begin
    FZRotation := value;
    UpdateChart
  end;
end;

function TChartSeries3D.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

constructor TChartItems3D.Create(AOwner: TPersistent);
begin
  inherited Create(TChartItem3D);
  FOwner := AOwner;
end;

procedure TChartShape3D.SetElevation(const Value: single);
begin
  if FElevation <> Value then
  begin
    FElevation := value;
    UpdateChart
  end;
end;

procedure TChartShape3D.SetExpansion(const Value: Single);
begin
  if FExpansion <> Value then
  begin
    FExpansion := Value;
    UpdateChart;
  end;
end;

procedure TChartShape3D.SetExtraction(const Value: single);
begin
  if FExtraction <> Value then
  begin
    FExtraction := value;
    UpdateChart
  end;
end;

function TChartShape3D.GetSerie: TChartSerie3D;
begin
  result := TChartItems3D(Collection).GetSerie;
end;

function TChartShape3D.GetTopPathArray: TPointArray;
var
  I: Integer;
begin
  if (Length(D2PositionDetection) = 0) then
    Exit;

  for I := 0 to Length(D2PositionDetection) - 3 - FCountVertices - 1 do
  begin
    SetLength(Result, Length(Result) + 1);
    Result[Length(Result) - 1] := Point(Round(D2PositionDetection[I].x), Round(D2PositionDetection[I].y));
  end;

  SetLength(Result, Length(Result) + 1);
  Result[Length(Result) - 1] := Point(Round(D2PositionDetection[Length(D2PositionDetection) - 1].X), Round(D2PositionDetection[Length(D2PositionDetection) - 1].y));

  SetLength(Result, Length(Result) + 1);
  Result[Length(Result) - 1] := Result[0];
end;

procedure TChartSerie3D.SetCaption(const Value: string);
begin
  if FCaption <> Value then
  begin
    FCaption := value;
    UpdateChart
  end;
end;

function TChartSerie3D.GetDisplayName: String;
begin
  Result := Caption;
end;

function TChartSerie3D.GetSerieRectangle(A3DRectangle: Boolean = False): TGPRectF;
var
  w: Single;
  cnt: Integer;
begin
  Result.X := 0;
  Result.Y := 0;
  Result.Width := 0;
  Result.Height := 0;
  cnt := Chart.GetCountVisibleSeries;
  if cnt > 0 then
  begin
    w := Chart.Width / cnt;
    Result.X := w * Index;
    if A3DRectangle then
      Result.X := Result.X - Chart.Width / 2;
    Result.Width := w;
    Result.Y := 0;
    Result.Height := Chart.Height;

    Result.X := Result.X + Left;
    Result.Y := Result.Y + Top;
  end;
end;

function TChartSerie3D.GetSize: Double;
var
  r: TGPRectF;
  w, h: Single;
  sz: Single;
begin
  Result := 0;
  case SizeType of
    stPixels: Result := Size;
    stPercentage:
    begin
      r := GetSerieRectangle(True);
      w := r.Width;
      h := r.Height;

      if h < w then
        sz := h
      else
        sz := w;

       Result := sz * (Size / 100);
    end;
  end;
end;

function TChartSerie3D.GetTotal: Double;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Items.Count - 1 do
  begin
    if Items[I].Visible then
      Result := Result + Items[I].Value;
  end;
end;

procedure TChartShape3D.SetCaption(const Value: string);
begin
  if FCaption <> Value then
  begin
    FCaption := value;
    UpdateChart
  end;
end;

type
  tdPoint = record
    x, y, z: Double;
  end;

  tdLine = record
    Point1, Point2: tdPoint;
  end;

  tdArc = record
    Center: tdPoint;
    r, sa, ea: Double;
  end;

const
  RADIANS = 57.29577951;

function fix_angle(angle: Double): Double;
begin
  while angle >= 360.0 do
    angle := angle - 360.0;
  while angle < 0 do
    angle := angle + 360.0;
  result := angle;
end;

function distance2d(x1, y1, x2, y2: Double): Double;
var
  a, b, c: Double;
begin
  a := abs(x1 - x2);
  b := abs(y1 - y2);
  c := sqr(a) + sqr(b);
  if c > 0 then
    result := sqrt(c)
  else
    result := 0;
end;

function distance3d(x1, y1, z1, x2, y2, z2: Double): Double;
var
  c: Double;
begin
  c := sqr(abs(x1 - x2)) + sqr(abs(y1 - y2)) + sqr(abs(z1 - z2));
  if c > 0 then
    result := sqrt(c)
  else
    result := 0;
end;

function get_angle_degrees(x1, y1, x2, y2: Double): Double;
var
  part1, part2: Double;
  angle: Double;
begin
  if (x1 = x2) and (y1 = y2) then
  begin
    result := 0.0;
    exit;
  end;
  part1 := abs(y2 - y1);
  if (part1 = 0) then
  begin
    part1 := 0.0000001;
    y1 := y1 + 0.0000001;
  end;
  part2 := abs(x2 - x1);
  if (part2 = 0) then
  begin
    part2 := 0.0000001;
    x1 := x1 + 0.0000001;
  end;
  angle := arctan(part1 / part2) * RADIANS;
  if ((x1 > x2) and (y1 < y2)) then
    angle := 180 - angle;
  if ((x1 > x2) and (y1 > y2)) then
    angle := angle + 180;
  if ((x1 < x2) and (y1 > y2)) then
    angle := 360 - angle;
  angle := fix_angle(angle);
  result := angle;
end;

function midpoint(x1, y1, z1, x2, y2, z2: Double): tdPoint;
var
  Point1: tdPoint;
begin
  Point1.x := ((x2 - x1) / 2) + x1;
  Point1.y := ((y2 - y1) / 2) + y1;
  Point1.z := ((z2 - z1) / 2) + z1;
  result := Point1;
end;

procedure TChartShape3D.Render2D(GPGraphics: TGPGraphics; const AScale: single);
var
  p: TGPPen;
  aax, aay, aaWidth, aaHeight, radius: Double;
  degree: Double;
  sz: TChartSize;
  pct, v: String;
begin
  if not Serie.Values.Visible then
    Exit;

  degree := get_angle_degrees(D2Position[0].x, D2Position[0].y, D2Position[1].x,
    D2Position[1].y);

  radius := Round(distance2d(D2Position[0].x, D2Position[0].y, D2Position[1].x,
    D2Position[1].y) + (Serie.Values.TickMarkLength * AScale));

  p := TGPPen.Create(MakeColor(Serie.Values.Transparency, Serie.Values.TickMarkColor), Serie.Values.TickMarkSize);

  pct := Format(Serie.Values.PercentageFormat, [Percentage]);
  v := Format(Serie.Values.ValueFormat, [Value]);
  sz := Serie.Values.CalcTextSize(GPGraphics, AScale, Caption, pct,
    v, Percentage, Value, Image);

  aaWidth := sz.cx;
  aaHeight := sz.cy;

  aax := Round(D2Position[0].x + cos(get_angle_degrees(D2Position[0].x,
    D2Position[0].y, D2Position[1].x, D2Position[1].y) * Pi / 180) * radius);

  aay := round(D2Position[0].y + sin(get_angle_degrees(D2Position[0].x,
    D2Position[0].y, D2Position[1].x, D2Position[1].y) * Pi / 180) * radius);

  if (degree > 0) and (degree < 30) then
  begin
    aay := aay - round(aaheight / 2);
  end;

  if (degree >= 60) and (degree < 120) then
    aax := aax - round(aaWidth / 2);

  if (degree >= 120) and (degree < 150) then
  begin
    aax := aax - aaWidth;
    aay := aay - round(aaheight / 2);
  end;

  if (degree >= 150) and (degree < 180) then
  begin
    aax := aax - aaWidth;
  end;

  if (degree >= 180) and (degree < 240) then
  begin
    aax := aax - aaWidth;
    aay := aay - round(aaheight / 2);
  end;

  if (degree >= 240) and (degree < 270) then
  begin
    aax := aax - aaWidth;
    aay := aay - aaheight;
  end;

  if (degree >= 270) and (degree < 330) then
  begin
    aax := aax - round(aaWidth / 2);
    aay := aay - aaheight;
  end;

  if (degree > 330) then
  begin
    aay := aay - round(aaheight / 2);
  end;

  GPGraphics.DrawLine(p, D2Position[1].x, D2Position[1].y,
    D2Position[0].x + cos(DegToRad(get_angle_degrees(D2Position[0].x, D2Position[0].y,
    D2Position[1].x, D2Position[1].y))) * radius,
    D2Position[0].y + sin(DegToRad(get_angle_degrees(D2Position[0].x, D2Position[0].y,
    D2Position[1].x, D2Position[1].y))) * radius);

  p.Free;

  Serie.Values.Render(GPGraphics, AScale, Image, caption,
    Format(Serie.Values.PercentageFormat, [Percentage]), Format(Serie.Values.ValueFormat, [Value]), Percentage, Value, aax, aay);
end;

procedure TChartSerie3D.Render2D(GPGraphics: TGPGraphics; const AScale: single);
var
  i: integer;
begin
  if not Visible then
    Exit;

  for i := 0 to Items.Count - 1 do
    if Items[i].Visible then
      Items[i].Render2D(GPGraphics, AScale);

  Legend.RenderLegend(GPGraphics, AScale, GetSerieRectangle, Self);
end;

procedure TChartSerie3D.RenderItems;
var
  I: Integer;
begin
  for I := 0 to Items.Count - 1 do
  begin
    if Items[I].Visible then
      Items[I].Render;
  end;
end;

procedure TChartSeries3D.Render2D(GPGraphics: TGPGraphics; const AScale: single);
var
  i: integer;
begin
  for i := 0 to Count - 1 do
    TChartSerie3D(Items[i]).Render2D(GPGraphics, AScale);
end;

procedure TAdvChartView3D.RenderControl;
begin
  RenderChart;
end;

procedure TAdvChartView3D.RenderControl2D(GPGraphics: TGPGraphics);
begin
  FSeries.Render2D(GPGraphics, Scale);

  if FTitle.Visible then
    FTitle.RenderTitle(GPGraphics, Scale, MakeRect(0, 0, FRenderWidth,
      FRenderHeight));
end;

procedure TChartSerie3D.SetDepth(const Value: single);
begin
  if FDepth <> Value then
  begin
    FDepth := value;
    UpdateChart
  end;
end;

procedure TChartSerie3D.SetInteraction(const Value: Boolean);
begin
  if FInteraction <> Value then
  begin
    FInteraction := Value;
    UpdateChart;
  end;
end;

procedure TChartSerie3D.SetLeft(const Value: single);
begin
  if FLeft <> Value then
  begin
    FLeft := value;
    UpdateChart
  end;
end;

procedure TChartSerie3D.SetLegend(const Value: TChartLegend3D);
begin
  if FLegend <> Value then
  begin
    FLegend.Assign(Value);
    UpdateChart;
  end;
end;

procedure TChartSerie3D.SetTop(const Value: single);
begin
  if FTop <> Value then
  begin
    FTop := value;
    UpdateChart
  end;
end;

procedure TChartSerie3D.SetChartType(const Value: TChartType3D);
begin
  if FChartType <> Value then
  begin
    FChartType := value;
    UpdateChart
  end;
end;

procedure TChartShape3D.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    UpdateChart
  end;
end;


Constructor TChartShape3D.Create(collection: TCollection);
begin;
  // inherited;
  inherited Create(collection);
  FVisible := True;
  FTransParency := 255;
  FExtraction := 0;
  FExpansion := 0;
  FImage := TChartGDIPPicture.Create;
  FColor := clRed;
  FCaption := 'New Value';
  FElevation := 0;
end;

function glGetFloat(pname: TGLEnum): TGLfloat;
begin
  FillChar(result, SizeOf(result), 0);
  glGetFloatv(pname, @result);
end;

function TAdvChartView3D.Get3DPosition(x, y: Double): TChartPosition3D;
var
  viewport: TVector4i;
  modelview: TMatrix4d;
  projection: TMatrix4d;
  xr, yr, zr: Double;
begin
  glGetDoublev(GL_MODELVIEW_MATRIX, @modelview);
  glGetDoublev(GL_PROJECTION_MATRIX, @projection);
  glGetIntegerv(GL_VIEWPORT, @viewport);
  gluUnProject(x, y, 0, modelview, projection, viewport, @xr, @yr, @zr);
  result.x := xr;
  result.y := yr;
  result.z := zr;
end;

function TAdvChartView3D.Get2DPosition(x, y, z: Double): TChartPosition2D;
var
  viewport: TVector4i;
  modelview: TMatrix4d;
  projection: TMatrix4d;
  xr, yr, zr: Double;
begin
  glGetDoublev(GL_MODELVIEW_MATRIX, @modelview);
  glGetDoublev(GL_PROJECTION_MATRIX, @projection);
  glGetIntegerv(GL_VIEWPORT, @viewport);
  gluProject(x, y, z, modelview, projection, viewport, @xr, @yr, @zr);
  result.x := xr * (FRenderWidth / FAWidth);
  result.y := (FAHeight - yr) * (FRenderHeight / FAHeight);
end;

procedure SetColor(Color: TColor);
var
  ColorPointer: pbytearray;
  mat_specular: array [0 .. 3] of GLfloat;
  mat_diffuse: array [0 .. 3] of GLfloat;
  ambient: array [0 .. 3] of GLfloat;
const
  mat_shininess: GLfloat = 0;
begin
  exit;
  ColorPointer := pbytearray(@Color);
  mat_specular[0] := ColorPointer[0] / 255;
  mat_specular[1] := ColorPointer[1] / 255;
  mat_specular[2] := ColorPointer[2] / 255;
  mat_specular[3] := 0.4;
  mat_diffuse[0] := ColorPointer[0] / 2560;
  mat_diffuse[1] := ColorPointer[1] / 2560;
  mat_diffuse[2] := ColorPointer[2] / 2560;
  mat_diffuse[3] := 0.4;

  ambient[0] := 0; // ColorPointer[0] / 255;
  ambient[1] := 0; // ColorPointer[0] / 255;
  ambient[2] := 0; // ColorPointer[0] / 255;
  ambient[3] := 0;
  mat_specular[3] := 0.7;

  mat_specular[3] := 0.7;

  glMaterialfv(GL_FRONT, GL_AMBIENT, @ambient);
  glMaterialfv(GL_FRONT, GL_DIFFUSE, @mat_diffuse);
  glMaterialfv(GL_FRONT, GL_SPECULAR, @mat_specular); // Using materials
  glMaterialf(GL_FRONT, GL_SHININESS, mat_shininess);
  // ambient[3]:=0;
  // mat_specular[3]:=0;
  // mat_shininess:=0;
  glMaterialfv(GL_BACK, GL_AMBIENT, @ambient);
  glMaterialfv(GL_BACK, GL_DIFFUSE, @mat_diffuse);
  glMaterialfv(GL_BACK, GL_SPECULAR, @mat_specular); // Using materials
  glMaterialf(GL_BACK, GL_SHININESS, mat_shininess);
end;

procedure CreateRectangle(x1, y1, z1, x2, y2, z2, x3, y3, z3, x4, y4,
  z4: single; Color: TColor);
var
  ColorPointer: pbytearray;
  mat_specular: array [0 .. 3] of GLfloat;
  ambient: array [0 .. 3] of GLfloat;
const
  mat_shininess: GLfloat = 255;
begin
  // Color := CLRed;
  ColorPointer := pbytearray(@Color);

  mat_specular[0] := ColorPointer[0] / 255;
  mat_specular[1] := ColorPointer[1] / 255;
  mat_specular[2] := ColorPointer[2] / 255;
  mat_specular[3] := 1;
  ambient[0] := 0; // ColorPointer[0] / 255;
  ambient[1] := 0; // ColorPointer[1] / 255;
  ambient[2] := 0; // ColorPointer[2] / 255;
  ambient[3] := 1;

  // glMaterialfv(GL_FRONT, GL_AMBIENT, @ambient);
  glMaterialfv(GL_FRONT, GL_DIFFUSE, @mat_specular); // Using materials
  glMaterialfv(GL_FRONT, GL_SPECULAR, @mat_specular); // Using materials
  glMaterialf(GL_FRONT, GL_SHININESS, mat_shininess);
  // glMaterialfv(GL_BACK, GL_AMBIENT, @ambient);
  glMaterialfv(GL_BACK, GL_DIFFUSE, @mat_specular); // Using materials
  glMaterialfv(GL_BACK, GL_SPECULAR, @mat_specular); // Using materials
  glMaterialf(GL_BACK, GL_SHININESS, mat_shininess);

  ColorPointer := pbytearray(@Color);
  // glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  glbegin(GL_POLYGON);
  // glColor3f(1,0,0);//ColorPointer[0], ColorPointer[1], ColorPointer[2], 0.4);
  glColor4d(ColorPointer[0], ColorPointer[1], ColorPointer[2], 1);
  glTexCoord2d(0, 1);
  glVertex3f(x1, y1, z1);
  glTexCoord2d(0, 0);
  glVertex3f(x2, y2, z2);
  glTexCoord2d(1, 0);
  glVertex3f(x3, y3, z3);
  glTexCoord2d(1, 1);
  glVertex3f(x4, y4, z4);
  glEnd;
end;

procedure TChartShape3D.RenderCylinder(AOriginX, AOriginY, AOriginZ, ARadius,
  ADepth: single; AId: Integer; AStartAngle, AEndangle: Double; AColor: TColor);
var
  i: integer;
  x, y, d, dr: single;
  ColorPointer: PByteArray;
  ors, ore, ax, ay: single;
  cnt: Single;
  dp: Single;
begin
  FCountVertices := Min(Round(AEndAngle - AStartAngle), 100);
  dp := Depth / 2;
  ors := startangle;
  ore := endangle;

  glLoadname(id);
  ColorPointer := pbytearray(@Color);
  cnt := (endangle - startangle) / FCountVertices;

  glColor4d(ColorPointer[0] / 256, ColorPointer[1] / 256, ColorPointer[2] / 256,
    Transparency / 255);

  //Bottom
  glbegin(GL_POLYGON);
  glVertex3d(AOriginx, AOriginy, AOriginz - dp);
  d := startangle;
  for i := 0 to FCountVertices do
  begin
    dr := DegToRad(d);
    x := AOriginx + cos(dr) * ARadius;
    y := AOriginy + sin(dr) * ARadius;
    glVertex3f(x, y, AOriginz - dp);
    d := d + cnt;
  end;
  glVertex3d(AOriginx, AOriginy, AOriginz - dp);
  glEnd;

  glColor4d(ColorPointer[0] / 512, ColorPointer[1] / 512,
    ColorPointer[2] / 512, Transparency / 255);


  //outer borders
  d := startangle;
  for i := 0 to FCountVertices - 1 do
  begin
    dr := DegToRad(d);
    x := AOriginX + cos(dr) * ARadius;
    y := AOriginy + sin(dr) * ARadius;
    d := d + cnt;
    dr := DegToRad(d);
    glbegin(GL_POLYGON);
    glVertex3f(x, y, AOriginz - dp);
    glVertex3f(x, y, AOriginz + dp);
    x := AOriginx + cos(dr) * ARadius;
    y := AOriginy + sin(dr) * ARadius;
    glVertex3f(x, y, AOriginz + dp);
    glVertex3f(x, y, AOriginz - dp);
    glEnd;
  end;

  //inner borders
  if (ors <> 0) or (ore <> 360) then
  begin
    d := startangle;
    dr := DegToRad(d);
    x := AOriginx + cos(dr) * ARadius;
    y := AOriginy + sin(dr) * ARadius;
    glbegin(GL_POLYGON);
    glVertex3f(x, y, AOriginz - dp);
    glVertex3f(x, y, AOriginz + dp);
    glVertex3f(AOriginx, AOriginy, AOriginz + dp);
    glVertex3f(AOriginx, AOriginy, AOriginz - dp);
    glEnd;

    d := endangle;
    dr := DegToRad(d);
    x := AOriginx + cos(dr) * ARadius;
    y := AOriginy + sin(dr) * ARadius;
    glbegin(GL_POLYGON);
    glVertex3f(x, y, AOriginz - dp);
    glVertex3f(x, y, AOriginz + dp);
    glVertex3f(AOriginx, AOriginy, AOriginz + dp);
    glVertex3f(AOriginx, AOriginy, AOriginz - dp);
    glEnd;
  end;

  glColor4d(ColorPointer[0] / 256, ColorPointer[1] / 256, ColorPointer[2] / 256,
    Transparency / 255);


  SetLength(D2PositionDetection, ((FCountVertices + 1) * 2) + 2);

  //Top
  glbegin(GL_POLYGON);
  glVertex3d(AOriginx, AOriginy, AOriginz + dp);
  d := startangle;
  for i := 0 to FCountVertices do
  begin
    dr := DegToRad(d);
    x := AOriginx + cos(dr) * ARadius;
    y := AOriginy + sin(dr) * ARadius;
    glVertex3f(x, y, AOriginz + dp);
    d := d + cnt;
  end;
  glVertex3d(AOriginx, AOriginy, AOriginz + dp);
  glEnd;

  // calculation of slice position
  d := (startangle + ((endangle - startangle) / 2));
  dr := DegToRad(d);
  x := AOriginx + cos(dr) * ARadius;
  y := AOriginy + sin(dr) * ARadius;
  ax := x;
  ay := y;

  D2Position[0] := Chart.Get2DPosition(AOriginx, AOriginy, AOriginz + dp);
  D2Position[1] := Chart.Get2DPosition(ax, ay, AOriginz + dp);

  d := startangle;
  for i := 0 to FCountVertices do
  begin
    dr := DegToRad(d);
    x := AOriginx + cos(dr) * ARadius;
    y := AOriginy + sin(dr) * ARadius;
    d := d + cnt;

    D2PositionDetection[I] := Chart.Get2DPosition(x, y, AOriginz - dp);
    D2PositionDetection[I + 1 + FCountVertices] := Chart.Get2DPosition(x, y, AOriginz + dp);
  end;

  D2PositionDetection[Length(D2PositionDetection) - 2] := Chart.Get2DPosition(AOriginX, AOriginY, AOriginz + dp);
  D2PositionDetection[Length(D2PositionDetection) - 1] := Chart.Get2DPosition(AOriginX, AOriginY, AOriginz - dp);
end;

destructor TChartShape3D.Destroy;
begin
  FImage.Free;
  inherited;
end;

procedure TChartShape3D.UpdateChart;
begin
  Serie.UpdateChart
end;

procedure TChartShape3D.SetImage(const Value: TChartGDIPPicture);
begin
  if FImage <> Value then
  begin
    FImage.Assign(Value);
    UpdateChart;
  end;
end;

procedure TChartShape3D.Render;
begin
  case Serie.ChartType of
    ctPie3D:  RenderCylinder(Left, Top, ZLocation,
    (Size / 2), Depth, id, StartAngle,
    EndAngle, Color);
  end;
end;

procedure TChartShape3D.SetValue(const Value: Extended);
begin
  if FValue <> Value then
  begin
    FValue := value;
    UpdateChart
  end;
end;

procedure TChartShape3D.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := value;
    UpdateChart
  end;
end;

{ TChartSerie3D }

constructor TChartSerie3D.Create(Collection: TCollection);
begin
  inherited Create(Collection);

  FInteraction := True;
  FVisible := True;
  FTransParency := 255;
  FXRotation := -55;
  FYRotation := 0;
  FZRotation := 0;
  FSizeType := stPixels;

  FLegend := TChartLegend3D.Create(Chart);
  FValues := TChartValues3D.Create(Chart);
  FItems := TChartItems3D.Create(Self);

  FLeft := 0;
  FTop := 0;
  FSize := 300;
  FDepth := 40;
  FChartType := ctPie3D;
end;

destructor TChartSerie3D.Destroy;
begin
  FLegend.Free;
  FItems.Free;
  FValues.Free;
  inherited;
end;


procedure TChartSerie3D.Assign(Source: TPersistent);
begin
  if Source is TChartSerie3D then
  begin
    FVisible := (Source as TChartSerie3D).Visible;
    FSizeType := (Source as TChartSerie3D).SizeType;
    FLegend.Assign((Source as TChartSerie3D).Legend);
    FValues.Assign((Source as TChartSerie3D).Values);
    FItems.Assign((Source as TChartSerie3D).Items);
    FDepth := (Source as TChartSerie3D).Depth;
    FTop := (Source as TChartSerie3D).Top;
    FLeft := (Source as TChartSerie3D).Left;
    FSize := (Source as TChartSerie3D).Size;
    FCaption := (Source as TChartSerie3D).Caption;
    FChartType := (Source as TChartSerie3D).ChartType;
    FYRotation := (Source as TChartSerie3D).YRotation;
    FXRotation := (Source as TChartSerie3D).XRotation;
    FZRotation := (Source as TChartSerie3D).ZRotation;
  end;
end;

function TChartSerie3D.GetChart: TAdvChartView3D;
begin
  Result := TAdvChartView3D((Collection as TChartSeries3D).FOwner);
end;

procedure TChartSerie3D.UpdateChart;
begin
  if Assigned(Chart) then
    Chart.UpdateChart;
end;

function TChartSerie3D.XYToItem(X, Y: Integer): TChartItem3D;

function PointInPolyGon(APoint: TPoint; const APoints: TPointArray): Boolean;
var
  Count, K, J : Integer;
begin
  Result := False;
  Count := Length(APoints);
  J := Count-1;
  for K := 0 to Count-1 do begin
   if ((APoints[K].Y <= APoint.Y) and (APoint.Y < APoints[J].Y)) or
      ((APoints[J].Y <= APoint.Y) and (APoint.Y < APoints[K].Y)) then
   begin
    if (APoint.x < (APoints[j].X - APoints[K].X) *
       (APoint.y - APoints[K].Y) /
       (APoints[j].Y - APoints[K].Y) + APoints[K].X) then
        Result := not Result;
    end;
    J := K;
  end;
end;
var
  I: Integer;
  it: TChartItem3D;
begin
  Result := nil;
  for I := Items.Count - 1 downto 0 do
  begin
    it := Items[I];
    if it.Visible then
    begin
      if PointInPolygon(Point(X, Y), it.GetTopPathArray) or PointInPolygon(Point(X, Y), it.GetBottomPathArray)
        or PointInPolygon(Point(X, Y), it.GetArcArray) {or PointInPolygon(Point(X, Y), it.GetLeftSideArray) or PointInPolygon(Point(X, Y), it.GetRightSideArray)} then
      begin
        Result := it;
        Break;
      end;
    end;
  end;
end;

procedure TChartSerie3D.Render;
var
  p: TGPRectF;
begin
  try
    glMatrixMode(GL_MODELVIEW);
    glPushMatrix;
    glLoadIdentity;
    p := GetSerieRectangle(True);
    glTranslateF(p.X + p.Width / 2, p.Y, 0);
    glRotatef(XRotation, 1, 0, 0);
    glRotatef(YRotation, 0, 1, 0);
    glRotatef(ZRotation, 0, 0, 1);

    RenderItems;

  finally
    glPopMatrix;
    glDisable(GL_COLOR_MATERIAL);
  end;
end;

function TChartSerie3D.Add: TChartItem3D;
begin
  result := TChartItem3D(FItems.Add);
end;

procedure TChartSerie3D.CalcValues;
var
  total, start, anglediv: Single;
  I: Integer;
  it: TChartItem3D;
begin
  case ChartType of
    ctPie3D:
    begin

      total := GetTotal;
      if total <> 0 then
        anglediv := 360/total
      else
        anglediv := 1;

      start := 0;
      for I := 0 to Items.Count - 1 do
      begin
        it := Items[I];
        if it.Visible then
        begin
          it.FStartAngle := start;
          it.FEndAngle := start + anglediv * it.Value;
          it.FPercentage := 100 / total * it.Value;
          start := it.FEndAngle;

          it.FLeft := 0;
          it.FTop := 0;

          if (it.Extraction > 0)  then
          begin
            it.FLeft := cos(DegToRad((it.startangle + ((it.endangle - it.startangle) / 2)))) * it.Extraction;
            it.FTop := sin(DegToRad((it.startangle + ((it.endangle - it.startangle) / 2)))) * it.Extraction;
          end;

          it.FInternalShine := 50;
          it.FSize := GetSize;
          it.FZLocation := it.Elevation + it.Expansion / 2;
          it.FDepth := depth + it.Expansion;
          it.id := (id * 100) + i;
        end;
      end;
    end;
  end;
end;

procedure TChartSerie3D.Clear;
begin
  FItems.Clear;
end;

procedure TChartSerie3D.Delete(index: integer);
begin
  TChartItem3D(FItems.Items[index]).Destroy;
  FItems.Delete(index);
end;

constructor TChartSeries3D.Create(AOwner: TPersistent);
begin
  inherited Create(TChartSerie3D);
  FOwner := AOwner;
end;

function TChartSeries3D.GetChart: TAdvChartView3D;
begin
  Result := TAdvChartView3D(FOwner);
end;

procedure TChartSeries3D.UpdateChart;
begin
  if Assigned(Chart) then
    Chart.UpdateChart;
end;

procedure TChartSeries3D.Render;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
    if Items[i].Visible then
      Items[i].Render;
end;

procedure TChartSeries3D.SetItems(index: integer; value: TChartSerie3D);
begin
  inherited Items[index] := value;
end;

function TChartSeries3D.GetItems(index: integer): TChartSerie3D;
begin
  result := TChartSerie3D(inherited Items[index]);
end;

function TChartSeries3D.Add: TChartSerie3D;
begin
  result := TChartSerie3D(Inherited Add);
end;

function TChartSeries3D.Insert(index: integer): TChartSerie3D;
begin
  result := TChartSerie3D(Inherited Insert(index));
end;

procedure TChartSeries3D.Delete(index: integer);
begin
  Inherited Delete(index);
end;

procedure TChartSeries3D.Clear;
begin
  inherited Clear;
end;

procedure TAdvChartView3D.RenderChart;
var
  viewport: TVector4i;
  r, g, b: Byte;
  c: TColor;
begin
  glEnable(GLUT_MULTISAMPLE);
  glEnable(GL_TEXTURE_2D);
  glEnable(GL_MULTISAMPLE);
  ScreenProjection;
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();

  glGetIntegerv(GL_VIEWPORT, @viewport);
  gluPickMatrix(0, 0, FAWidth, FAHeight, viewport);
  glMatrixMode(GL_MODELVIEW);
  glEnable(GL_NORMALIZE);

  glScissor(0, 0, FAWidth, FAHeight);
  glEnable(GL_SCISSOR_TEST);

  glClearDepth(1.0);
  glEnable(GL_DEPTH_TEST);
  glDepthRange(0, 1);
  glDepthFunc(GL_LEQUAL);
  glDepthMask(True);
  c := ColorToRGB(Color);
  b := GetRed(c);
  g := GetGreen(c);
  r := GetBlue(c);
  glClearColor(r / 255, g / 255, b / 255, 1);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glMatrixMode(GL_MODELVIEW);

  glHint(GL_LINE_SMOOTH_HINT, GL_NICEST);
  glHint(GL_POLYGON_SMOOTH_HINT, GL_NICEST);
  glShadeModel(GL_SMOOTH);
  glEnable(GL_BLEND);

  glPushMatrix;
  FSeries.Render;
  glPopMatrix;
end;

procedure TAdvChartView3D.SetTitle(const Value: TChartTitle3D);
begin
  FTitle.Assign(Value);
end;

procedure TAdvChartView3D.Setversion(const Value: string);
begin
  //
end;

function TAdvChartView3D.GetCountVisibleSeries: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Series.Count - 1 do
  begin
    if Series[I].Visible then
      Inc(Result);
  end;
end;

function TAdvChartView3D.GetVersionNr: Integer;
begin
  Result := MakeLong(MakeWord(BLD_VER, REL_VER), MakeWord(MIN_VER, MAJ_VER));
end;

function TAdvChartView3D.GetVersionString: string;
var
  vn: Integer;
begin
  vn := GetVersionNr;
  Result := IntToStr(Hi(Hiword(vn))) + '.' + IntToStr(Lo(Hiword(vn))) + '.' + IntToStr(Hi(Loword(vn))) + '.' + IntToStr(Lo(Loword(vn))) + ' ' + DATE_VER;
end;

procedure TAdvChartView3D.InitSample;
var
  s: TChartSerie3D;
  I: Integer;
  si: TChartItem3D;
const
  c: array[0..5] of TColor = ($056EFB, $996600, $33FF66, $3300CC, $F5FFF0, $FFCC00);
begin
  BeginUpdate;
  Series.Clear;
  Title.Text := 'AdvChartView 3D';
  s := Series.Add;
  s.Caption := 'Chart Serie 3D';

  for I := 0 to 5 do
  begin
    si := s.Items.Add;
    si.Caption := 'Value ' + inttostr(I);
    si.Value := RandomRange(50, 100);
    si.Color := c[I];
  end;
  EndUpdate;
end;

procedure TAdvChartView3D.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  if TabStop then
    SetFocus;
  FMouseDown := True;
  FX := X;
  FY := Y;

  FActiveSerie := XYToSerie(X, Y);
  FMoved := False;
end;

procedure TAdvChartView3D.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if FMouseDown and Assigned(FActiveSerie) and (FActiveSerie.Interaction) and ((Abs(FY - Y) > CLICKMARGIN) or (Abs(FX - X) > CLICKMARGIN)) then
  begin
    FMoved := True;
    if ssRight in Shift then
      FActiveSerie.ZRotation := FActiveSerie.ZRotation - X + FX
    else
    begin
      FActiveSerie.YRotation := FActiveSerie.YRotation - X + FX;
      FActiveSerie.XRotation := FActiveSerie.XRotation - Y + FY;
    end;

    FY := Y;
    FX := X;
  end;
end;

procedure TAdvChartView3D.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  it: TChartItem3D;
  s: TChartSerie3D;
begin
  inherited;
  FMouseDown := False;

  if not FMoved then
  begin
    s := XYToSerie(X, Y);
    if Assigned(s) then
    begin
      it := s.XYToItem(X, Y);
      if Assigned(it) then
        DoItemClick(s, it);
    end;
  end;
end;

procedure TAdvChartView3D.Assign(Source: TPersistent);
begin
  if (Source is TAdvChartView3D) then
  begin
    FSeries.Assign((Source as TAdvChartView3D).Series);
    FTitle.Assign((Source as TAdvChartView3D).Title);
    FColor := (Source as TAdvChartView3D).Color;
  end;
end;

procedure TAdvChartView3D.BeginUpdate;
begin
  inherited;
  Inc(FUpdateCount);
end;

procedure TAdvChartView3D.CalcSeries;
var
  I: Integer;
begin
  for I := 0 to Series.Count - 1 do
    Series[I].CalcValues;
end;

constructor TAdvChartView3D.Create(o: TComponent);
begin
  FConstructed := false;

  inherited;

  TabStop := true;

  Width := 600;
  Height := 400;

  FDesignTime := (csDesigning in ComponentState) and not
      ((csReading in Owner.ComponentState) or (csLoading in Owner.ComponentState));

  FUpdateCount := 0;

  FColor := clWhite;

  FSeries := TChartSeries3D.Create(Self);
  FTitle := TChartTitle3D.Create(Self);
  FVersion := GetVersionString;
end;

destructor TAdvChartView3D.Destroy;
begin
  FSeries.Free;
  FTitle.Free;
  inherited;
end;

procedure TAdvChartView3D.DoItemClick(ASerie: TChartSerie3D;
  AItem: TChartItem3D);
begin
  if Assigned(OnItemClick) then
    OnItemClick(Self, ASerie, AItem);
end;

function TAdvChartView3D.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;
  MousePos: TPoint): Boolean;
begin
  if Assigned(FActiveSerie) and (FActiveSerie.Interaction) then
    FActiveSerie.Size := FActiveSerie.Size - Wheeldelta / 10;
  Result := True;
end;

procedure TAdvChartView3D.DoRecalculate;
begin
  inherited;
  CalcSeries;
end;

procedure TAdvChartView3D.EndUpdate;
begin
  Dec(FUpdateCount);
  UpdateChart;
  inherited;
end;

procedure TAdvChartView3D.UpdateChart;
begin
  if (FUpdateCount = 0) and not (csLoading in ComponentState) then
  begin
    CalcSeries;
    Repaint;
  end;
end;

procedure TAdvChartView3D.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  if TabStop then
    Message.Result := DLGC_WANTALLKEYS or DLGC_WANTARROWS
  else
    Message.Result := 0;
end;

function TAdvChartView3D.XYToSerie(X, Y: Integer): TChartSerie3D;
var
  I: Integer;
  r: TGPRectF;
begin
  Result := nil;
  for I := 0 to Series.Count - 1 do
  begin
    r := Series[I].GetSerieRectangle(False);
    if PtInGPRect(r, Point(X, Y)) then
    begin
      Result := Series[I];
      Break;
    end;
  end;
end;

constructor TChartItem3D.Create(collection: TCollection);
begin
  inherited Create(collection);
end;

procedure TAdvChartView3D.SaveToImage(Filename: String; ImageType: TImageType = itPNG; ImageWidth: Integer = -1;
  ImageHeight: Integer = -1; ImageQualityPercentage: integer = 100);
var
  img: TBitmap;
  gpimg: TGPImage;
  g: TGPGraphics;
  enc: TEncoderParameters;
  w, h: Integer;
begin
  img := nil;
  gpimg := nil;
  g := nil;
  try

    if ImageWidth = -1 then
      w := Width
    else
      w := ImageWidth;

    if ImageHeight = -1 then
      h := Height
    else
      h := ImageHeight;

    img := TBitmap.Create;
    img.Width := w;
    img.Height := h;

    DoResize(w, h);
    DoRender(img, w, h);

    gpimg := TGPImage.Create(CreateStream(img));

    enc := GetEncoderQualityParameters(ImageQualityPercentage);

    gpimg.Save(filename, GetCLSID(ImageType), @enc);

  finally
    gpimg.Free;
    g.Free;
    img.Free;
  end;
end;

procedure TAdvChartView3D.SaveToStream(AStream: TStream; AWidth: Integer = - 1; AHeight: integer = -1);
var
  img: TBitmap;
  w, h: Integer;
begin
  img := nil;
  try

    if AWidth = -1 then
      w := Width
    else
      w := AWidth;

    if AHeight = -1 then
      h := Height
    else
      h := AHeight;

    img := TBitmap.Create;
    img.Width := w;
    img.Height := h;

    DoResize(w, h);
    DoRender(img, w, h);

    img.SaveToStream(AStream);
  finally
    img.Free;
  end;
end;

procedure TAdvChartView3D.SetColor(const Value: TColor);
begin
  if (FColor <> Value) then
  begin
    FColor := value;
    UpdateChart;
  end;
end;

procedure TChartGradientFill3D.Assign(Source: TPersistent);
begin
  if (Source is TChartGradientFill3D) then
  begin
    FColor := (Source as TChartGradientFill3D).Color;
    FEndColor := (Source as TChartGradientFill3D).EndColor;
    FVisible := (Source as TChartGradientFill3D).Visible;
    FDirection := (Source as TChartGradientFill3D).Direction;
  end;
end;

constructor TChartGradientFill3D.Create(AOwner: TPersistent);
begin
  inherited;
  FDirection := gdVertical;
  FColor := clWhite;
  FEndColor := $E3E4E5;
  FVisible := True;
end;

procedure TChartGradientFill3D.SetColor(const Value: TColor);
begin
  if (FColor <> Value) then
  begin
    FColor := Value;
    UpdateChart;
  end;
end;

procedure TChartGradientFill3D.SetDirection(
  const Value: TChartGradientDirection3D);
begin
  if FDirection <> Value then
  begin
    FDirection := Value;
    UpdateChart;
  end;
end;

procedure TChartGradientFill3D.SetEndColor(const Value: TColor);
begin
  if (FEndColor <> Value) then
  begin
    FEndColor := value;
    UpdateChart;
  end;
end;

procedure TChartLine3D.SetWidth(const Value: integer);
begin
  if (FWidth <> Value) then
  begin
    FWidth := value;
    UpdateChart
  end;
end;

procedure TChartLine3D.SetStyle(const Value: DashStyle);
begin
  if (FStyle <> Value) then
  begin
    FStyle := value;
    UpdateChart
  end;
end;

procedure TChartLine3D.Assign(Source: TPersistent);
begin
  if (Source is TChartLine3D) then
  begin
    FColor := (Source as TChartLine3D).Color;
    FStyle := (Source as TChartLine3D).Style;
    FVisible := (Source as TChartLine3D).Visible;
    FWidth := (Source as TChartLine3D).Width;
  end;
end;

constructor TChartLine3D.Create(AOwner: TPersistent);
begin
  inherited;
  FColor := clDkGray;
  FStyle := DashStyleSolid;
  FVisible := True;
  FWidth := 1;
end;

procedure TChartLine3D.SetColor(const Value: TColor);
begin
  if (FColor <> Value) then
  begin
    FColor := value;
    UpdateChart
  end;
end;

function TChartValues3D.GetFmtValue(var APercentage: String; var AValue: string; APercentageValue, AValueValue: Single): string;
begin
  if ShowPercentages and not ShowValues then
    Result := APercentage;

  if ShowPercentages and ShowValues then
    Result := APercentage + ' - ' + AValue;

  if not ShowPercentages and ShowValues then
    Result := AValue;

  if Assigned(Chart.OnGetLabelValue) then
    Chart.OnGetLabelValue(Chart, APercentageValue, AValueValue, APercentage, AValue, Result);
end;


function TChartValues3D.CalcTextSize(GPGraphics: TGPGraphics; AScale: single; const ACaption: String; var APercentage: String; var AValue: string; APercentageValue, AValueValue: Single; Image: TChartGDIPPicture): TChartSize;
var
  glw, glh: integer;
  acf, avf: TFont;
  cf, vf: TGPFont;
  strv: string;
  vw: Double;
  sizer: TGPRectF;
begin
  acf := nil;
  avf := nil;
  cf := nil;
  vf := nil;
  try
    acf := TFont.Create;
    avf := TFont.Create;
    acf.Assign(self.CaptionsFont);
    avf.Assign(self.ValuesFont);
    acf.Size := Round(acf.Size * AScale);
    avf.Size := Round(avf.Size * AScale);
    cf := MakeFont(acf);
    vf := MakeFont(avf);

    Result.cx := 0;
    Result.cy := 0;

    if ShowCaptions and (ACaption <> '') then
    begin
      GPGraphics.MeasureString(ACaption, Length(ACaption), cf, MakePointF(0, 0), nil, sizer);
      Result.cy := sizer.Height;
      Result.cx := sizer.Width;
    end;

    StrV := GetFmtValue(APercentage, AValue, APercentageValue, AValueValue);


    if ShowValues and (strv <> '') then
    begin
      GPGraphics.MeasureString(strv, Length(strv), vf, MakePointF(0, 0), nil, sizer);
      Result.cy := Result.cy + sizer.Height;
      vw := sizer.Width;
      if vw > Result.cx then
        Result.cx := vw;
    end;

    Result.cx := Result.cx + (Border.Width * 2);
    Result.cy := Result.cy + (Border.Width * 2);

    FImagePos.X := 0;
    FImagePos.Y := 0;
    FImagePos.Width := 0;
    FImagePos.Height := 0;
    FTextAreaPos.X := 0;
    FTextAreaPos.Y := 0;
    FTextAreaPos.Width := Result.cx;
    FTextAreaPos.Height := Result.cy;

    if ImageVisible and Assigned(Image) and (Image.Width <> 0)
      and (Image.Height <> 0) then
    begin
      glw := Image.Width;
      glh := Image.Height;
      if not ImageAspectRatio then
      begin
        glw := ImageWidth;
        glh := round((ImageWidth * (ImageWidth / ImageHeight)) * AScale);
      end;
      case ImagePosition of
        ipTopLeft:
          begin
            if glw > Result.cx then
              Result.cx := glw;

            FImagePos.X := 0;
            FImagePos.Y := 0;
            FImagePos.Width := glw;
            FImagePos.Height := glh;

            FTextAreaPos.Y := glh + 5;
          end;
        ipTopCenter:
          begin
            if glw > Result.cx then
              Result.cx := glw;

            FImagePos.X := (Result.cx - glw) / 2;
            FImagePos.Y := 0;
            FImagePos.Width := glw;
            FImagePos.Height := glh;

            FTextAreaPos.Y := glh + 5;
          end;
        ipTopRight:
          begin
            if glw > Result.cx then
              Result.cx := glw;

            FImagePos.X := (Result.cx - glw);
            FImagePos.Y := 0;
            FImagePos.Width := glw;
            FImagePos.Height := glh;

            FTextAreaPos.Y := glh + 5;
          end;
        ipCenterLeft:
          begin
            if glh > Result.cy then
              Result.cy := glh;

            FImagePos.X := 0;
            FImagePos.Y := (Result.cy - glh) / 2;
            FImagePos.Width := glw;
            FImagePos.Height := glh;

            FTextAreaPos.X := glw + 5;
          end;
        ipCenterRight:
          begin
            if glh > Result.cy then
              Result.cy := glh;

            FImagePos.X := Result.cx;
            FImagePos.Y := (Result.cy - glh) / 2;
            FImagePos.Width := glw;
            FImagePos.Height := glh;

          end;
        ipCenterCenter:
          begin
            if glh > Result.cy then
              Result.cy := glh;

            FImagePos.X := Result.cx;
            FImagePos.Y := round((Result.cy - glh) / 2);
            FImagePos.Width := glw;
            FImagePos.Height := glh;
          end;
        ipBottomLeft:
          begin
            if glw > Result.cx then
              Result.cx := glw;

            FImagePos.X := 0;
            FImagePos.Y := Result.cy + 5;
            FImagePos.Width := glw;
            FImagePos.Height := glh;
          end;
        ipBottomCenter:
          begin
            if glw > Result.cx then
              Result.cx := glw;

            FImagePos.X := (Result.cx - glw) / 2;
            FImagePos.Y := Result.cy + 5;
            FImagePos.Width := glw;
            FImagePos.Height := glh;
          end;
        ipBottomRight:
          begin
            if glw > Result.cx then
              Result.cx := glw;

            FImagePos.X := (Result.cx - glw);
            FImagePos.Y := Result.cy + 5;
            FImagePos.Width := glw;
            FImagePos.Height := glh;
          end;
      end;
    end;
    if (FTextAreaPos.X + FTextAreaPos.Width > Result.cx) then
      Result.cx := FTextAreaPos.X + FTextAreaPos.Width;
    if (FImagePos.X + FImagePos.Width > Result.cx) then
      Result.cx := FImagePos.X + FImagePos.Width;

    if (FTextAreaPos.Y + FTextAreaPos.Height > Result.cy) then
      Result.cy := FTextAreaPos.Y + FTextAreaPos.Height;
    if (FImagePos.Y + FImagePos.Height > Result.cy) then
      Result.cy := FImagePos.Y + FImagePos.Height;
  finally
    if Assigned(cf) then
      cf.Free;
    if Assigned(vf) then
      vf.free;
    if Assigned(avf) then
      avf.Free;
    if Assigned(acf) then
      acf.Free;
  end;
end;

procedure TChartValues3D.Render(GPGraphics: TGPGraphics; AScale: single; AImage: TChartGDIPPicture; ACaption, APercentage, AValue: string; APercentageValue, AValueValue: Single; x, y: Double);
var
  p: TGPPen;
  b: TGPBrush;
  ar: TGPRectF;
  acf, avf: TFont;
  cf, vf: TGPFont;
  sz: TChartSize;
  tw: Double;
  vstr: string;
  sizer: TGPRectF;
  bi: TGPBrush;
  pt, ptto: TGPPointF;
begin;
  acf := nil;
  avf := nil;
  cf := nil;
  vf := nil;
  try
    acf := TFont.Create;
    avf := TFont.Create;
    acf.Assign(CaptionsFont);
    avf.Assign(ValuesFont);
    acf.Size := Round(acf.Size * AScale);
    avf.Size := Round(avf.Size * AScale);
    cf := MakeFont(acf);
    vf := MakeFont(avf);

    sz := CalcTextSize(GPGraphics, AScale, ACaption, APercentage, AValue, APercentageValue, AValueValue, AImage);

    vstr := GetFmtValue(APercentage, AValue, APercentageValue, AValueValue);

    FTextAreaPos.X := FTextAreaPos.X + x;
    FTextAreaPos.Y := FTextAreaPos.Y + Y;

    FImagePos.X := FImagePos.X + x;
    FImagePos.Y := FImagePos.Y + y;

    case Fill.Direction of
      gdVertical:
      begin
        pt := MakePoint(x + sz.cx / 2, y);
        ptto := MakePoint(x + sz.cx / 2, y + sz.cy);
      end;
      gdHorizontal:
      begin
        pt := MakePoint(x , y + sz.cy / 2);
        ptto := MakePoint(x + sz.cx, y + sz.cy / 2);
      end;
    end;

    b := TGPLinearGradientBrush.Create(pt,ptto,
      MakeColor(Transparency, Fill.Color), MakeColor(Transparency, Fill.EndColor));
    try
      if Fill.Visible then
        GPGraphics.FillRectangle(b, x, y, sz.cx, sz.cy);
    finally
      b.Free;
    end;

    if ImageVisible and Assigned(AImage) then
      AImage.GDIPDraw(GPGraphics, FImagePos);

    if Border.Visible then
    begin
      p := TGPPen.Create(MakeColor(Transparency, Border.Color), Border.Width);
      p.SetDashStyle(Border.Style);
      try
        GPGraphics.DrawRectangle(p, x, y, sz.cx, sz.cy);
      finally
        p.Free;
      end;
    end;

    ar := FTextAreaPos;
    if ShowCaptions and (ACaption <> '') then
    begin
      GPGraphics.MeasureString(ACaption, Length(ACaption), cf, MakePointF(0, 0), nil, sizer);
      tw := sizer.Width;
      case CaptionAlignment of
        taRight: ar.X := FTextAreaPos.X + FTextAreaPos.Width - tw;
        taLeft: ar.X := FTextAreaPos.X;
        taCenter: ar.X := FTextAreaPos.X + (FTextAreaPos.Width - tw) / 2;
      end;
      bi := TGPSolidBrush.Create(MakeColor(Transparency, acf.Color));
      GPGraphics.DrawString(ACaption, Length(ACaption), cf, ar, nil, bi);
      bi.Free;
      ar.Y := ar.Y + sizer.Height;
    end;

    if ShowValues then
    begin
      GPGraphics.MeasureString(vstr, Length(vstr), vf, MakePointF(0, 0), nil, sizer);
      tw := sizer.Width;

      case ValuesAlignment of
        taRight: ar.X := FTextAreaPos.X + FTextAreaPos.Width - tw;
        taLeft: ar.X := FTextAreaPos.X;
        taCenter: ar.X := FTextAreaPos.X + (FTextAreaPos.Width - tw) / 2;
      end;

      bi := TGPSolidBrush.Create(MakeColor(Transparency, avf.Color));
      GPGraphics.DrawString(vstr, Length(vstr), vf, ar, nil, bi);
      bi.Free;

    end;
  finally
    if Assigned(cf) then
      cf.Free;
    if Assigned(vf) then
      vf.Free;
    if Assigned(acf) then
      acf.Free;
    if Assigned(avf) then
      avf.Free;
  end;
end;

procedure TChartValues3D.SetTransparency(const Value: integer);
begin
  if FTransparency <> Value then
  begin
    FTransparency := Value;
    UpdateChart
  end;
end;

procedure TChartValues3D.SetShowCaptions(const Value: boolean);
begin
  if FShowCaptions <> value then
  begin
    FShowCaptions := value;
    UpdateChart
  end;
end;

procedure TChartValues3D.SetShowValues(const Value: boolean);
begin
  if FShowValues <> Value then
  begin
    FShowValues := value;
    UpdateChart
  end;
end;

procedure TChartValues3D.SetTickMarkColor(const Value: TColor);
begin
  if FTickMarkColor <> Value then
  begin
    FTickMarkColor := Value;
    UpdateChart;
  end;
end;

procedure TChartValues3D.SetTickMarkLength(const Value: Integer);
begin
  if FTickMarkLength <> Value then
  begin
    FTickMarkLength := value;
    UpdateChart;
  end;
end;

procedure TChartValues3D.SetTickMarkSize(const Value: Integer);
begin
  if FTickMarkSize <> Value then
  begin
    FTickMarkSize := value;
    UpdateChart;
  end;
end;

procedure TChartValues3D.SetShowPercentages(const Value: boolean);
begin
  if FShowPercentages <> Value then
  begin
    FShowPercentages := value;
    UpdateChart
  end;
end;

procedure TChartValues3D.SetImagePosition(const Value: TChartItemPosition3D);
begin
  if FImagePosition <> Value then
  begin
    FImagePosition := value;
    UpdateChart
  end;
end;

procedure TChartValues3D.SetCaptionAlignment(const Value: TChartTextAlignment3D);
begin
  if FCaptionAlignment <> Value then
  begin
    FCaptionAlignment := value;
    UpdateChart
  end;
end;

procedure TChartValues3D.SetValuesAlignment(const Value: TChartTextAlignment3D);
begin
  if FValuesAlignment <> Value then
  begin
    FValuesAlignment := value;
    UpdateChart
  end;
end;

procedure TChartValues3D.SetValueFormat(const Value: string);
begin
  if FValueFormat <> Value then
  begin
    FValueFormat := value;
    UpdateChart
  end;
end;

procedure TChartValues3D.SetVisible(const Value: boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := value;
    UpdateChart
  end;
end;

procedure TChartValues3D.UpdateChart;
begin
  if Assigned(Chart) then
    Chart.UpdateChart;
end;

procedure TChartValues3D.Assign(Source: TPersistent);
begin
  if Source is TChartValues3D then
  begin
    FImageVisible := (Source as TChartValues3D).ImageVisible;
    FImageAspectRatio := (Source as TChartValues3D).ImageAspectRatio;
    FImageWidth := (Source as TChartValues3D).ImageWidth;
    FImageHeight := (Source as TChartValues3D).ImageHeight;
    FImagePosition := (Source as TChartValues3D).ImagePosition;
    FTickMarkLength := (Source as TChartValues3D).TickMarkLength;
    FFill.Assign((Source as TChartValues3D).Fill);
    FBorder.Assign((Source as TChartValues3D).Border);
    FShowCaptions := (Source as TChartValues3D).ShowCaptions;
    FShowValues := (Source as TChartValues3D).ShowValues;
    FShowPercentages := (Source as TChartValues3D).ShowPercentages;
    FCaptionsFont.Assign((Source as TChartValues3D).CaptionsFont);
    FValuesFont.Assign((Source as TChartValues3D).ValuesFont);
    FCaptionAlignment := (Source as TChartValues3D).CaptionAlignment;
    FValuesAlignment := (Source as TChartValues3D).ValuesAlignment;
    FValueFormat := (Source as TChartValues3D).ValueFormat;
    FPercentageFormat := (Source as TChartValues3D).PercentageFormat;
    FVisible := (Source as TChartValues3D).Visible;
    FTransparency := (Source as TChartValues3D).Transparency;
    FTickMarkSize := (Source as TChartValues3D).TickMarkSize;
    FTickMarkColor := (Source as TChartValues3D).TickMarkColor;
  end;
end;

constructor TChartValues3D.Create(AOwner: TPersistent);
begin
  inherited;

  FTickMarkLength := 15;
  FTickMarkSize := 2;
  FTickMarkColor := clSilver;

  FValueFormat := '%.0f';
  FPercentageFormat := '%.0f%%';

  FImageVisible := true;
  FImageWidth := 128;
  FImageHeight := 128;
  FImageAspectRatio := True;
  FImagePosition := ipCenterCenter;
  FBorder := TChartLine3D.Create(Chart);
  FFill := TChartGradientFill3D.Create(Chart);

  FCaptionAlignment := taCenter;
  FValuesAlignment := taCenter;
  FValuesFont := TFont.Create;
  FCaptionsFont := TFont.Create;
  FTransParency := 255;

  FShowCaptions := False;
  FShowPercentages := False;
  FShowValues := True;
  FVisible := True;
end;


destructor TChartValues3D.Destroy;
begin
  FFill.Free;
  FBorder.Free;
  FValuesFont.Free;
  FCaptionsFont.Free;
  inherited;
end;

procedure TAdvChartView3D.CreateWnd;
begin
  inherited;

  gluLookAt(0, 0, -50, 0, 0, 0, 0, 1, 0);
  if FDesignTime and not FConstructed then
    InitSample;

  FConstructed := True;

  UpdateChart;
end;

procedure AssignFont(Font1, Font2: TFont);
begin
  Font1.Name := Font2.Name;
  Font1.Size := Font2.Size;
  Font1.Color := Font2.Color;
  Font1.Style := Font2.Style;
end;

procedure TChartGradientFill3D.SetVisible(const Value: boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    UpdateChart
  end;
end;

procedure TChartLine3D.SetVisible(const Value: boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := value;
    UpdateChart
  end;
end;

procedure TChartValues3D.SetImageHeight(const Value: integer);
begin
  if FImageHeight <> value then
  begin
    FImageHeight := value;
    UpdateChart
  end;
end;

procedure TChartValues3D.SetImageWidth(const Value: integer);
begin
  if FImageWidth <> value then
  begin
    FImageWidth := value;
    UpdateChart
  end;
end;

procedure TChartValues3D.SetPercentageFormat(const Value: String);
begin
  if FPercentageFormat <> Value then
  begin
    FPercentageFormat := value;
    UpdateChart
  end;
end;

procedure TChartValues3D.SetImageAspectRatio(const Value: boolean);
begin
  if FImageAspectRatio <> Value then
  begin
    FImageAspectRatio := value;
    UpdateChart
  end;
end;

procedure TChartValues3D.SetImageVisible(const Value: boolean);
begin
  if FImageVisible <> Value then
  begin
    FImageVisible := value;
    UpdateChart
  end;
end;

procedure TChartTitle3D.Assign(Source: TPersistent);
begin
  if (Source is TChartTitle3D) then
  begin
    FAlignment := (Source as TChartTitle3D).Alignment;
    FBorder.Assign((Source as TChartTitle3D).Border);
    FFill.Assign((Source as TChartTitle3D).Fill);
    FFont.Assign((Source as TChartTitle3D).Font);
    FPosition := (Source as TChartTitle3D).Position;
    FMargin := (Source as TChartTitle3D).Margin;
    FPadding := (Source as TChartTitle3D).Padding;
    FText  := (Source as TChartTitle3D).Text;
    FVisible  := (Source as TChartTitle3D).Visible;
    FTransparency := (Source as TChartTitle3D).Transparency;
  end;
end;

constructor TChartTitle3D.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);

  FFont := TFont.Create;
  FBorder := TChartLine3D.Create(AOwner as TAdvChartView3D);
  FFill := TChartGradientFill3D.Create(AOwner as TAdvChartView3D);

  FVisible := true;
  FTransparency := 255;
  FAlignment := taCenter;

  FFont.Size := 12;

  FMargin := 5;
  FPadding := 5;
  FPosition := ipTopCenter;
end;

destructor TChartTitle3D.Destroy;
begin
  FFont.Free;
  FFill.Free;
  FBorder.Free;
  inherited;
end;

procedure TChartTitle3D.RenderTitle(GPGraphics: TGPGraphics; const AScale: single; AreaBox: TGPRectF);
var
  ar: TGPRectF;
  bw, bh, aw, ah: Double;
  p: TGPPen;
  b, bf: TGPBrush;
  ff: TFont;
  ft: TGPFont;
  ms, pd: Single;
  sizer: TGPRectF;
  pt, ptto: TGPPointF;
  sf: TGPStringFormat;
begin
  ff := nil;
  ft := nil;
  bf := nil;
  try
    ff := TFont.Create;
    ff.Assign(FFont);
    ff.Size := Round(FFont.Size * AScale);
    ft := MakeFont(ff);
    bf := TGPSolidBrush.Create(MakeColor(Transparency, ff.Color));


    ms := (Margin * AScale);
    pd := (Padding * AScale);

    GPGraphics.MeasureString(Text, Length(Text), ft, MakePointF(0, 0), nil, sizer);

    aw := sizer.Width + (ms * 2);
    ah := sizer.Height + (ms * 2);

    bw := AreaBox.Width;
    bh := AreaBox.Height;

    case Position of
      ipBottomLeft, ipCenterLeft, ipTopLeft: AreaBox.X := AreaBox.X + pd;
      ipBottomRight, ipCenterRight, ipTopRight: AreaBox.X := AreaBox.X - pd;
    end;

    case Position of
      ipTopLeft, ipTopCenter, ipTopRight: AreaBox.Y := AreaBox.Y + pd;
      ipBottomRight, ipBottomLeft, ipBottomCenter: AreaBox.Y := AreaBox.Y - pd;
    end;

    case Position of
      ipTopLeft:
      begin
        ar.x := AreaBox.X;
        ar.y := AreaBox.Y;
        ar.Width := aw;
        ar.Height := ah;
      end;
      ipTopCenter:
      begin
        ar.x := AreaBox.X + ((bw - aw) / 2);
        ar.y := AreaBox.Y;
        ar.Width := aw;
        ar.Height := ah;
      end;
      ipTopRight:
      begin
        ar.x := AreaBox.X + (bw - aw);
        ar.y := AreaBox.Y;
        ar.Width := aw;
        ar.Height := ah;
      end;
      ipCenterLeft:
      begin
        ar.x := AreaBox.X;
        ar.y := AreaBox.Y + ((bh - ah) / 2);
        ar.Width := aw;
        ar.Height := ah;
      end;
      ipCenterRight:
      begin
        ar.x := AreaBox.X + (bw - aw);
        ar.y := AreaBox.Y + ((bh - ah) / 2);
        ar.Width := aw;
        ar.Height := ah;
      end;
      ipCenterCenter:
      begin
        ar.x := AreaBox.X + ((bw - aw) / 2);
        ar.y := AreaBox.Y + ((bh - ah) / 2);
        ar.Width := aw;
        ar.Height := ah;
      end;
      ipBottomLeft:
      begin
        ar.x := AreaBox.X;
        ar.y := AreaBox.Y + (bh - ah);
        ar.Width := aw;
        ar.Height := ah;
      end;
      ipBottomCenter:
      begin
        ar.x := AreaBox.X + ((bw - aw) / 2);
        ar.y := AreaBox.Y + (bh - ah);
        ar.Width := aw;
        ar.Height := ah;
      end;
      ipBottomRight:
      begin
        ar.x := AreaBox.X + (bw - aw);
        ar.y := AreaBox.Y + (bh - ah);
        ar.Width := aw;
        ar.Height := ah;
      end;
    end;

    if Fill.Visible then
    begin
      case Fill.Direction of
        gdVertical:
        begin
          pt := MakePoint(ar.x + ar.Width / 2, ar.y);
          ptto := MakePointF(ar.x + ar.Width / 2, ar.Y + ar.Height);
        end;
        gdHorizontal:
        begin
          pt := MakePoint(ar.x, ar.y + ar.Height / 2);
          ptto := MakePoint(ar.x + ar.Width, ar.Y + ar.Height / 2);
        end;
      end;

      b := TGPLinearGradientBrush.Create(pt, ptto,
        MakeColor(Transparency, Fill.Color), MakeColor(Transparency, Fill.EndColor));
      GPGraphics.FillRectangle(b, ar.x, ar.y, ar.Width, ar.Height);
      b.Free;
    end;

    if Border.Visible then
    begin
      p := TGPPen.Create(MakeColor(Transparency, Border.Color), Border.Width);
      p.SetDashStyle(Border.Style);
      GPGraphics.DrawRectangle(p, ar.x, ar.y, ar.Width, ar.Height);
      p.Free;
    end;

    sf := TGPStringFormat.Create;
    case Alignment of
      taRight: sf.SetAlignment(StringAlignmentFar);
      taLeft: sf.SetAlignment(StringAlignmentNear);
      taCenter: sf.SetAlignment(StringAlignmentCenter);
    end;
    sf.SetLineAlignment(StringAlignmentCenter);
    GPGraphics.DrawString(Text, Length(Text), ft, ar, sf, bf);

    sf.Free;

  finally
    if Assigned(ft) then
      ft.Free;
    if Assigned(bf) then
      bf.Free;
    if Assigned(ff) then
      ff.Free;
  end;
end;

procedure TChartTitle3D.SetMargin(const Value: integer);
begin
  if (FMargin <> Value) then
  begin
    FMargin := value;
    UpdateChart
  end;
end;

procedure TChartTitle3D.SetPadding(const Value: integer);
begin
  if (FPadding <> Value) then
  begin
    FPadding := value;
    UpdateChart
  end;
end;

procedure TChartTitle3D.SetText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    UpdateChart
  end;
end;

procedure TChartTitle3D.SetTransparency(const Value: Integer);
begin
  if FTransparency <> Value then
  begin
    FTransparency := Value;
    UpdateChart
  end;
end;

procedure TChartTitle3D.SetVisible(const Value: boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    UpdateChart
  end;
end;

procedure TChartTitle3D.SetPosition(const Value: TChartItemPosition3D);
begin
  if FPosition <> Value then
  begin
    FPosition := Value;
    UpdateChart
  end;
end;

procedure TChartLegend3D.Assign(Source: TPersistent);
begin
  if Source is TChartLegend3D then
  begin
    FPadding := (Source as TChartLegend3D).Padding;
    FCaptionFont.Assign((Source as TChartLegend3D).CaptionFont);
    FItemsFont.Assign((Source as TChartLegend3D).ItemsFont);
    FCaptionVisible := (Source as TChartLegend3D).CaptionVisible;
    FMargin := (Source as TChartLegend3D).Margin;
    FFill.Assign((Source as TChartLegend3D).Fill);
    FBorder.Assign((Source as TChartLegend3D).Border);
    FPosition := (Source as TChartLegend3D).Position;
    FVisible := (Source as TChartLegend3D).Visible;
    FCaptionAlignment := (Source as TChartLegend3D).CaptionAlignment;
    FTransparency := (Source as TChartLegend3D).Transparency;
  end;
end;

constructor TChartLegend3D.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FCaptionFont := TFont.Create;
  FBorder := TChartLine3D.Create(Chart);
  FFill := TChartGradientFill3D.Create(Chart);
  FPadding := 5;
  FMargin := 5;
  FCaptionVisible := true;
  FPosition := ipTopLeft;
  FCaptionAlignment := taLeft;
  FItemsAlignment := taLeft;
  FItemsFont := TFont.Create;
  FVisible := true;
  FTransparency := 255;
end;

destructor TChartLegend3D.Destroy;
begin
  FFill.Free;
  FBorder.Free;
  FCaptionFont.Free;
  FItemsFont.Free;
  inherited;
end;

procedure TChartLegend3D.RenderSerieShape(GPGraphics: TGPGraphics;
  AShapeRect: TGPRectF; SerieItem: TChartItem3D);
var
  b: TGPSolidBrush;
  p: TGPPen;
  pth: TGPGraphicsPath;
begin
  b := TGPSolidBrush.Create(MakeColor(Transparency, SerieItem.Color));
  p := TGPPen.Create(Makecolor(Transparency, Darker(SerieItem.Color, 30)));
  try
    case SerieItem.Serie.ChartType of
      ctPie3D:
      begin
        pth := TGPGraphicsPath.Create;
        pth.AddPie(AShapeRect, 0, 300);
        GPGraphics.FillPath(b, pth);
        GPGraphics.DrawPath(p, pth);
        pth.Free;
      end;
    end;
  finally
    p.Free;
    b.Free;
  end;
end;

procedure TChartLegend3D.RenderLegend(GPGraphics: TGPGraphics; AScale: single; AreaBox: TGPRectF;
  serie: TChartSerie3D);
type
  TLegendItem = record
    sizer: TGPRectF;
  end;
var
  ar: TGPRectF;
  br: TGPRectF;
  bw, bh, ah, aw, ms, pd: Single;
  i: integer;
  b, bc, bi: TGPBrush;
  p: TGPPen;
  at, ith: Single;
  acf, aif: TFont;
  str: String;
  fct, fit: TGPFont;
  itstr: String;
  sizer: TGPRectF;
  lst: array of TLegendItem;
  cpr: TGPRectF;
  sz: Single;
  pt, ptto: TGPPointF;
begin
  if not Visible then
    Exit;

  str := Serie.caption;

  acf := nil;
  aif := nil;
  bi := nil;
  bc := nil;
  fct := nil;
  fit := nil;

  try
    sz := (15 * AScale);
    acf := TFont.Create;
    aif := TFont.Create;
    acf.Assign(CaptionFont);
    aif.Assign(ItemsFont);
    aif.Size := Round(ItemsFont.Size * AScale);
    acf.Size := Round(CaptionFont.Size * AScale);

    fct := MakeFont(acf);
    fit := MakeFont(aif);
    bi := TGPSolidBrush.Create(MakeColor(Transparency, aif.Color));
    bc := TGPSolidBrush.Create(MakeColor(Transparency, acf.Color));

    aw := 0;
    ah := 0;
    ms := Margin * AScale;
    pd := Padding * AScale;

    SetLength(lst, 0);
    for i := 0 to Serie.Items.Count - 1 do
    begin
      sizer := MakeRect(0, 0, 0, 0);
      if Serie.Items[I].Visible then
      begin
        itstr := Serie.Items[I].Caption;
        GPGraphics.MeasureString(itstr, Length(itstr), fit, MakePointF(0, 0), nil, sizer);
        ah := ah + sizer.Height + ms;
        if sizer.Width + sz + ms * 3 > aw then
          aw := sizer.Width + sz + ms * 3;
      end;

      SetLength(lst, Length(lst) + 1);
      lst[Length(lst) - 1].sizer := sizer;
    end;

    cpr := MakeRect(0, 0, 0, 0);
    if CaptionVisible and (Serie.Caption <> '') then
      GPGraphics.MeasureString(str, Length(str), fct, MakePointF(0, 0), nil, cpr);

    if cpr.Width + (ms * 2) > aw then
      aw := cpr.Width + (ms * 2);

    if cpr.Height > 0 then
      ah := ah + cpr.Height + (ms * 2)
    else
      ah := ah + cpr.Height + ms;

    bw := AreaBox.Width;
    bh := AreaBox.Height;

    case Position of
      ipBottomLeft, ipCenterLeft, ipTopLeft: AreaBox.X := AreaBox.X + pd;
      ipBottomRight, ipCenterRight, ipTopRight: AreaBox.X := AreaBox.X - pd;
    end;

    case Position of
      ipTopLeft, ipTopCenter, ipTopRight: AreaBox.Y := AreaBox.Y + pd;
      ipBottomRight, ipBottomLeft, ipBottomCenter: AreaBox.Y := AreaBox.Y - pd;
    end;

    case Position of
      ipTopLeft:
      begin
        ar.x := AreaBox.X;
        ar.y := AreaBox.Y;
        ar.Width := aw;
        ar.Height := ah;
      end;
      ipTopCenter:
      begin
        ar.x := AreaBox.X + ((bw - aw) / 2);
        ar.y := AreaBox.Y;
        ar.Width := aw;
        ar.Height := ah;
      end;
      ipTopRight:
      begin
        ar.x := AreaBox.X + (bw - aw);
        ar.y := AreaBox.Y;
        ar.Width := aw;
        ar.Height := ah;
      end;
      ipCenterLeft:
      begin
        ar.x := AreaBox.X;
        ar.y := AreaBox.Y + round((bh - ah) / 2);
        ar.Width := aw;
        ar.Height := ah;
      end;
      ipCenterRight:
      begin
        ar.x := AreaBox.X + (bw - aw);
        ar.y := AreaBox.Y + round((bh - ah) / 2);
        ar.Width := aw;
        ar.Height := ah;
      end;
      ipCenterCenter:
      begin
        ar.x := AreaBox.X + round((bw - aw) / 2);
        ar.y := AreaBox.Y + round((bh - ah) / 2);
        ar.Width := aw;
        ar.Height := ah;
      end;
      ipBottomLeft:
      begin
        ar.x := AreaBox.Y;
        ar.y := AreaBox.X + (bh - ah);
        ar.Width := aw;
        ar.Height := ah;
      end;
      ipBottomCenter:
      begin
        ar.x := AreaBox.X + ((bw - aw) / 2);
        ar.y := AreaBox.Y + (bh - ah);
        ar.Width := aw;
        ar.Height := ah;
      end;
      ipBottomRight:
      begin
        ar.x := AreaBox.X + (bw - aw);
        ar.y := AreaBox.Y + (bh - ah);
        ar.Width := aw;
        ar.Height := ah;
      end;
    end;

    if Fill.Visible then
    begin
      case Fill.Direction of
        gdVertical:
        begin
          pt := MakePoint(ar.x + ar.Width / 2, ar.y);
          ptto := MakePoint(ar.x + ar.Width / 2, ar.Y + ar.Height);
        end;
        gdHorizontal:
        begin
          pt := MakePoint(ar.x, ar.y + ar.Height / 2);
          ptto := MakePoint(ar.x + ar.Width, ar.Y + ar.Height / 2);
        end;
      end;

      b := TGPLinearGradientBrush.Create(pt, ptto, MakeColor(Transparency, Fill.Color),
          MakeColor(Transparency, Fill.EndColor));
      GPGraphics.FillRectangle(b, ar.x, ar.y, ar.Width, ar.Height);
      b.Free;
    end;

    if Border.Visible then
    begin
      p := TGPPen.Create(MakeColor(Transparency, Border.Color), Border.Width);
      p.SetDashStyle(Border.Style);
      GPGraphics.DrawRectangle(p, ar.x, ar.y, ar.Width, ar.Height);
      p.Free;
    end;

    at := ar.Y;
    if CaptionVisible and (Serie.Caption <> '') then
    begin
      case CaptionAlignment of
        taRight: br := MakeRect((ar.x + ar.Width - cpr.Width) - ms,
          ar.y + ms, ar.Width - ms, ar.Height - ms);
        taLeft: br := MakeRect(ar.x + ms, ar.y + ms, ar.Width - ms, ar.Height - ms);
        taCenter: br := MakeRect(ar.x + ((ar.Width - cpr.Width / 2)) - ms,
          ar.y + ms, ar.Width - ms, ar.Height - ms);
      end;

      GPGraphics.DrawString(str, Length(str), fct, br, nil, bc);
      at := at + ms + cpr.Height;
    end;

    for i := 0 to Serie.Items.Count - 1 do
    begin
      if Serie.Items[I].Visible then
      begin
        ith := lst[I].sizer.Height;
        ar.y := at;

        RenderSerieShape(GPGraphics, MakeRect(ar.X + ms, ar.Y + ms + (ith - sz) / 2, sz, sz), serie.Items[I]);

        br := MakeRect(ar.x + ms * 2 + sz, ar.y + ms, ar.Width - ms, ar.Height - ms);
        GPGraphics.DrawString(Serie.Items[i].Caption, Length(Serie.Items[I].Caption), fit, br, nil, bi);

        at := at + ith + ms;
      end;
    end;
  finally
    if Assigned(fct) then
      fct.Free;
    if Assigned(fit) then
      fit.Free;
    if Assigned(bc) then
      bc.Free;
    if Assigned(bi) then
      bi.Free;
    if Assigned(acf) then
      acf.Free;
    if Assigned(aif) then
      aif.Free;
  end;
end;

procedure TChartLegend3D.SetVisible(const Value: boolean);
begin
  if (FVisible <> Value) then
  begin
    FVisible := value;
    UpdateChart
  end;
end;

procedure TChartLegend3D.SetCaptionVisible(const Value: boolean);
begin
  if FCaptionVisible <> Value then
  begin
    FCaptionVisible := Value;
    UpdateChart
  end;
end;

procedure TChartLegend3D.SetPadding(const Value: integer);
begin
  if (FPadding <> Value) then
  begin
    FPadding := value;
    UpdateChart
  end;
end;

procedure TChartLegend3D.SetMargin(const Value: integer);
begin
  if (FMargin <> value) then
  begin
    FMargin := value;
    UpdateChart
  end;
end;

procedure TChartLegend3D.SetPosition(const Value: TChartItemPosition3D);
begin
  if FPosition <> Value then
  begin
    FPosition := Value;
    UpdateChart
  end;
end;

procedure TChartLegend3D.SetTransparency(const Value: Integer);
begin
  if FTransparency <> Value then
  begin
    FTransparency := Value;
    UpdateChart;
  end;
end;

procedure TChartLegend3D.SetCaptionAlignment
  (const Value: TChartTextAlignment3D);
begin
  if FCaptionAlignment <> Value then
  begin
    FCaptionAlignment := Value;
    UpdateChart
  end;
end;

procedure TChartTitle3D.SetAlignment(const Value: TChartTextAlignment3D);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    UpdateChart
  end;
end;

procedure TChartTitle3D.SetBorder(const Value: TChartLine3D);
begin
  if FBorder <> Value then
  begin
    FBorder.Assign(Value);
    UpdateChart
  end;
end;

procedure TChartTitle3D.SetFill(const Value: TChartGradientFill3D);
begin
  if FFill <> Value then
  begin
    FFill.Assign(Value);
    UpdateChart
  end;
end;

procedure TChartTitle3D.SetFont(const Value: TFont);
begin
  if FFont <> Value then
  begin
    FFont.Assign(Value);
    UpdateChart
  end;
end;

procedure TChartItems3D.UpdateSerie;
begin
  GetSerie.UpdateChart
end;

function TChartItems3D.GetItem(index: integer): TChartItem3D;
begin
  Result := TChartItem3D(inherited Items[index]);
end;

function TChartItems3D.GetSerie: TChartSerie3D;
begin
  Result := FOwner as TChartSerie3D;
end;

procedure TChartItems3D.SetItem(index: integer; value: TChartItem3D);
begin
  inherited Items[index] := Value;
end;

function TChartItems3D.Add: TChartItem3D;
begin
  Result := TChartItem3D(inherited Add);
end;

function TChartItems3D.Insert(index: integer): TChartItem3D;
begin
  Result := TChartItem3D(inherited Insert(index));
end;

{ TChartBase3D }

constructor TChartBase3D.Create(AOwner: TPersistent);
begin
  inherited Create;
  FChart := AOwner as TAdvChartView3D;
end;

procedure TChartBase3D.UpdateChart;
begin
  if Assigned(Chart) then
    Chart.UpdateChart;
end;

end.
