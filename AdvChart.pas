{***************************************************************************}
{ TAdvChart component                                                       }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 2013 - 2022                                        }
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

{$B+}

unit AdvChart;

{$I TMSDEFS.INC}

interface

uses
  Classes, Math, SysUtils, Controls,  Windows, DateUtils,
  Graphics, Dialogs, StdCtrls, Forms, IniFiles, Types
  {$IFDEF DELPHIXE3_LVL}
  , System.UITypes
  {$ENDIF}

  ;

const
  CROSSHAIRDISTANCE = 20;
  LOGARITHMICMAX = 100;

type
  {$IFNDEF DELPHI10_LVL}
    TVerticalAlignment = (taAlignTop, taAlignBottom, taVerticalCenter);
  {$ENDIF}

  TAdvChart = class;

  {$IFNDEF DELPHIXE2_LVL}
  TPointF = record
    X: Single;
    Y: Single;
  end;
  {$ENDIF}

  TChartSeriePoint = record
    Serie: Integer;
    Point: Integer;
  end;

  TChartBorderStyle = (cbLeft, cbTop, cbRight, cbBottom);

  TChartBorderStyles = set of TChartBorderStyle;

  TChartBackGroundPosition = (bpTopLeft,bpTopRight,bpBottomLeft,bpBottomRight,bpTiled,bpStretched,bpCenter);

  TChartGradientDirection = (cgdHorizontal, cgdVertical);

  TChartYAxisPosition = (yLeft,yRight,yBoth,yNone);

  TChartXAxisPosition = (xBottom,xTop,xBoth,xNone);

  TTitlePosition = (tTop, tBottom, tBoth, tNone);

  TChartSeriePiePosition = (spTopLeft,spTopRight, spTopCenter, spBottomLeft, spBottomRight, spBottomCenter, spCenterLeft, spCenterCenter, spCenterRight, spCustom);

  TChartLegendAlignment = (laTopLeft, laTopRight, laTopCenter, laCenterLeft, laCenterRight, laCenterCenter, laBottomLeft, laBottomRight, laBottomCenter, laCustom);

  TChartLegend = class(TPersistent)
  private
    FBorderColor: TColor;
    FBorderWidth: integer;
    FBorderRounding: integer;
    FBackgroundPosition: TChartBackGroundPosition;
    FColor: TColor;
    FColorTo: TColor;
    FFont: TFont;
    FGradientSteps: integer;
    FGradientDirection: TChartGradientDirection;
    FLeft: integer;
    FOwner: TAdvChart;
    FOnChange: TNotifyEvent;
    FPicture: TPicture;
    FRectangleSize: integer;
    FRectangleSpacing: integer;
    FTop: integer;
    FVisible: Boolean;
    FDrawBkg: Boolean;
    FAlignment: TChartLegendAlignment;
    procedure SetBorderColor(const Value: TColor);
    procedure SetColor(const Value: TColor);
    procedure SetColorTo(const Value: TColor);
    procedure SetFont(const Value: TFont);
    procedure SetGradientDirection(const Value: TChartGradientDirection);
    procedure SetGradientSteps(const Value: Integer);
    procedure SetLeft(const Value: integer);
    procedure SetRectangleSize(const Value: Integer);
    procedure SetRectangleSpacing(const Value: integer);
    procedure SetTop(const Value: integer);
    procedure SetVisible(const Value: Boolean);
    procedure SetBorderWidth(const Value: integer);
    procedure SetBorderRounding(const Value: integer);
    procedure SetPicture(const Value: TPicture);
    procedure SetBackGroundPosition(const Value: TChartBackGroundPosition);
    procedure SetAlignment(const Value: TChartLegendAlignment);
  protected
    procedure Changed; virtual;
    procedure FontChanged(Sender: TObject);
    property DrawBkg: boolean read FDrawBkg write FDrawBkg;
  public
    constructor Create(AOwner: TAdvChart); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Draw(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: double); virtual;
    //Settings
    procedure SaveToFile(ini: TMemIniFile;Section: String); virtual;
    procedure LoadFromFile(ini: TMemIniFile;Section: String); virtual;
    function GetRectangle: TRect;
  published
    property Alignment: TChartLegendAlignment read FAlignment write SetAlignment default laCustom;
    property BorderColor: TColor read FBorderColor write SetBorderColor default clBlack;
    property BorderWidth: integer read FBorderWidth write SetBorderWidth default 1;
    property BorderRounding: integer read FBorderRounding write SetBorderRounding default 0;
    property BackGroundPosition: TChartBackGroundPosition read FBackgroundPosition write SetBackGroundPosition default bpTopLeft;
    property Color: TColor read FColor write SetColor default clWhite;
    property ColorTo: TColor read FColorTo write SetColorTo default clNone;
    property Font: TFont read FFont write SetFont;
    property GradientDirection: TChartGradientDirection read FGradientDirection write SetGradientDirection default cgdHorizontal;
    property GradientSteps: Integer read FGradientSteps write SetGradientSteps default 100;
    property Left: integer read FLeft write SetLeft default 0;
    property Top: integer read FTop write SetTop default 0;
    property Picture: TPicture read FPicture write SetPicture;
    property RectangleSize: Integer read FRectangleSize write SetRectangleSize default 10;
    property RectangleSpacing: integer read FRectangleSpacing write SetRectangleSpacing default 5;
    property Visible: Boolean read FVisible write SetVisible default true;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TChartNavigatorButtonState = (cnbNormal, cnbHot, cnbDown);

  TChartNavigator = class(TPersistent)
  private
    FAlphaBlendValue: Byte;
    FAlphaBlend: boolean;
    FColor: TColor;
    FColorTo: TColor;
    FGradientDirection: TChartGradientDirection;
    FGradientSteps: Integer;
    FOwner: TAdvChart;
    FOnChange: TNotifyEvent;
    FLeftButtonState: TChartNavigatorButtonState;
    FRightButtonState: TChartNavigatorButtonState;
    FScrollButtons: boolean;
    FScrollButtonLeftColor: TColor;
    FScrollButtonLeftHotColor: TColor;
    FScrollButtonLeftDownColor: TColor;
    FScrollButtonRightColor: TColor;
    FScrollButtonRightHotColor: TColor;
    FScrollButtonRightDownColor: TColor;
    FScrollButtonLeft: TPicture;
    FScrollButtonLeftHot: TPicture;
    FScrollButtonLeftDown: TPicture;
    FScrollButtonRight: TPicture;
    FScrollButtonRightHot: TPicture;
    FScrollButtonRightDown: TPicture;
    FScrollButtonsSize: integer;
    FScrollDelta: integer;
    FSize: integer;
    FVisible: boolean;
    FScrollStep: integer;
    function GetBottomSize: integer;
    procedure SetAlphaBlend(const Value: boolean);
    procedure SetAlphaBlendValue(const Value: byte);
    procedure SetColor(const Value: TColor);
    procedure SetColorTo(const Value: TColor);
    procedure SetGradientDirection(const Value: TChartGradientDirection);
    procedure SetGradientSteps(const Value: integer);
    procedure SetScrollButtons(const Value: boolean);
    procedure SetScrollButtonsSize(const Value: integer);
    procedure SetSize(const Value: integer);
    procedure SetVisible(const Value: boolean);
    procedure SetLeftButtonState(const Value: TChartNavigatorButtonState);
    procedure SetRightButtonState(const Value: TChartNavigatorButtonState);
    procedure SetScrollButtonLeft(const Value: TPicture);
    procedure SetScrollButtonLeftDown(const Value: TPicture);
    procedure SetScrollButtonLeftHot(const Value: TPicture);
    procedure SetScrollButtonRight(const Value: TPicture);
    procedure SetScrollButtonRightDown(const Value: TPicture);
    procedure SetScrollButtonRightHot(const Value: TPicture);
    procedure SetScrollButtonLeftColor(const Value: TColor);
    procedure SetScrollButtonLeftDownColor(const Value: TColor);
    procedure SetScrollButtonLeftHotColor(const Value: TColor);
    procedure SetScrollButtonRightColor(const Value: TColor);
    procedure SetScrollButtonRightDownColor(const Value: TColor);
    procedure SetScrollButtonRightHotColor(const Value: TColor);
    procedure SetScrollStep(const Value: integer);
  protected
    procedure Changed; virtual;
  public
    constructor Create(AOwner: TAdvChart);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Draw(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double);
    procedure DrawArrow(Canvas: TCanvas; R: TRect; Direction: Boolean; ScaleX, ScaleY: Double);
    property BottomSize: integer read GetBottomSize;
    property LeftButtonState: TChartNavigatorButtonState read FLeftButtonState write SetLeftButtonState;
    property RightButtonState: TChartNavigatorButtonState read FRightButtonState write SetRightButtonState;
    //Settings
    procedure SaveToFile(ini: TMemIniFile;Section: String);
    procedure LoadFromFile(ini: TMemIniFile;Section: String);
  published
    property AlphaBlend: boolean read FAlphaBlend write SetAlphaBlend default true;
    property AlphaBlendValue: byte read FAlphaBlendValue write SetAlphaBlendValue default 128;
    property Color: TColor read FColor write SetColor default clWhite;
    property ColorTo: TColor read FColorTo write SetColorTo default clNone;
    property GradientDirection: TChartGradientDirection read FGradientDirection write SetGradientDirection default cgdVertical;
    property GradientSteps: integer read FGradientSteps write SetGradientSteps default 100;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property ScrollButtonLeft: TPicture read FScrollButtonLeft write SetScrollButtonLeft;
    property ScrollButtonLeftHot: TPicture read FScrollButtonLeftHot write SetScrollButtonLeftHot;
    property ScrollButtonLeftDown: TPicture read FScrollButtonLeftDown write SetScrollButtonLeftDown;
    property ScrollButtonRight: TPicture read FScrollButtonRight write SetScrollButtonRight;
    property ScrollButtonRightHot: TPicture read FScrollButtonRightHot write SetScrollButtonRightHot;
    property ScrollButtonRightDown: TPicture read FScrollButtonRightDown write SetScrollButtonRightDown;
    property ScrollButtonLeftColor: TColor read FScrollButtonLeftColor write SetScrollButtonLeftColor default clNone;
    property ScrollButtonLeftHotColor: TColor read FScrollButtonLeftHotColor write SetScrollButtonLeftHotColor default clNone;
    property ScrollButtonLeftDownColor: TColor read FScrollButtonLeftDownColor write SetScrollButtonLeftDownColor default clNone;
    property ScrollButtonRightColor: TColor read FScrollButtonRightColor write SetScrollButtonRightColor default clNone;
    property ScrollButtonRightHotColor: TColor read FScrollButtonRightHotColor write SetScrollButtonRightHotColor default clNone;
    property ScrollButtonRightDownColor: TColor read FScrollButtonRightDownColor write SetScrollButtonRightDownColor default clNone;
    property ScrollButtons: boolean read FScrollButtons write SetScrollButtons default true;
    property ScrollButtonsSize: integer read FScrollButtonsSize write SetScrollButtonsSize default 11;
    property Size: integer read FSize write SetSize default 20;
    property Visible: boolean read FVisible write SetVisible default false;
    property ScrollStep: integer read FScrollStep write SetScrollStep default 1;
  end;

  TChartUnitType = (utNumber, utDay, utMonth, utYear, utWeek, utHour, utMinute, utSecond, utMilliSecond);

  TChartXAxis = class(TPersistent)
  private
    FAlignment: TAlignment;
    FColor: TColor;
    FColorTo: TColor;
    FFont: TFont;
    FGradientDirection: TChartGradientDirection;
    FGradientSteps: Integer;
    FLineWidth: integer;
    FLine: boolean;
    FLineColor: TColor;
    FOnChange: TNotifyEvent;
    FOwner: TAdvChart;
    FPosition: TChartXAxisPosition;
    FSize: integer;
    FText: string;
    FUnitType: TChartUnitType;
    FOffset3D: integer;
    FDarken3D: Boolean;
    FEnable3D: Boolean;
    FAutoSize: Boolean;
    function GetBottomSize: integer;
    function GetTopSize: integer;
    procedure SetAlignment(const Value: TAlignment);
    procedure SetColor(const Value: TColor);
    procedure SetColorTo(const Value: TColor);
    procedure SetFont(const Value: TFont);
    procedure SetGradientDirection(const Value: TChartGradientDirection);
    procedure SetGradientSteps(const Value: Integer);
    procedure SetLine(const Value: boolean);
    procedure SetLineColor(const Value: TColor);
    procedure SetLineWidth(const Value: integer);
    procedure SetPosition(const Value: TChartXAxisPosition);
    procedure SetSize(const Value: integer);
    procedure SetText(const Value: string);
    procedure SetUnitType(const Value: TChartUnitType);
    function GetBottomLineSize: integer;
    function GetTopLineSize: integer;
    procedure SetDarken3D(const Value: Boolean);
    procedure SetEnable3D(const Value: Boolean);
    procedure SetOffset3D(const Value: integer);
    procedure SetAutoSize(const Value: Boolean);
  protected
    procedure FontChanged(Sender: TObject);
    procedure Changed; virtual;
  public
    constructor Create(AOwner: TAdvChart);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Draw(Canvas: TCanvas; R: TRect; Top: boolean; ScaleX, ScaleY: Double; Horizontal: Boolean);
    property TopSize: integer read GetTopSize;
    property BottomSize: integer read GetBottomSize;
    property TopLineSize: integer read GetTopLineSize;
    property BottomLineSize: integer read GetBottomLineSize;
    //Settings
    procedure SaveToFile(ini: TMemIniFile;Section: String);
    procedure LoadFromFile(ini: TMemIniFile;Section: String);
  published
    property AutoSize: Boolean read FAutoSize write SetAutoSize default True;
    property Alignment: TAlignment read FAlignment write SetAlignment default taCenter;
    property Color: TColor read FColor write SetColor default clNone;
    property ColorTo: TColor read FColorTo write SetColorTo default clNone;
    property GradientDirection: TChartGradientDirection read FGradientDirection write SetGradientDirection default cgdHorizontal;
    property GradientSteps: Integer read FGradientSteps write SetGradientSteps default 100;
    property Font: TFont read FFont write SetFont;
    property Line: boolean read FLine write SetLine default true;
    property LineColor: TColor read FLineColor write SetLineColor default clBlack;
    property LineWidth: integer read FLineWidth write SetLineWidth default 1;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Position: TChartXAxisPosition read FPosition write SetPosition default xBottom;
    property Size: integer read FSize write SetSize default 30;
    property Text: string read FText write SetText;
    property UnitType: TChartUnitType read FUnitType write SetUnitType default utNumber;
    property Enable3D: Boolean read FEnable3D write SetEnable3D default false;
    property Darken3D: Boolean read FDarken3D write SetDarken3D default true;
    property Offset3D: integer read FOffset3D write SetOffset3D default 20;
  end;

  TChartYAxis = class(TPersistent)
  private
    FLeftSize: Integer;
    FRightSize: Integer;
    FAlignment: TAlignment;
    FAutoUnits: Boolean;
    FColor: TColor;
    FColorTo: TColor;
    FGradientDirection: TChartGradientDirection;
    FGradientSteps: Integer;
    FFont: TFont;
    FLineWidth: integer;
    FLine: boolean;
    FLineColor: TColor;
    FOnChange: TNotifyEvent;
    FOwner: TAdvChart;
    FPosition: TChartYAxisPosition;
    FSize: integer;
    FText: string;
    FOffset3D: integer;
    FDarken3D: Boolean;
    FEnable3D: Boolean;
    FAutoSize: Boolean;
    function GetLeftSize: integer;
    function GetRightSize: integer;
    procedure SetAlignment(const Value: TAlignment);
    procedure SetAutoUnits(const Value: Boolean);
    procedure SetColor(const Value: TColor);
    procedure SetColorTo(const Value: TColor);
    procedure SetFont(const Value: TFont);
    procedure SetGradientDirection(const Value: TChartGradientDirection);
    procedure SetGradientSteps(const Value: Integer);
    procedure SetLine(const Value: boolean);
    procedure SetLineColor(const Value: TColor);
    procedure SetLineWidth(const Value: integer);
    procedure SetPosition(const Value: TChartYAxisPosition);
    procedure SetSize(const Value: integer);
    procedure SetText(const Value: string);
    function GetLeftLineSize: integer;
    function GetRightLineSize: integer;
    procedure SetDarken3D(const Value: Boolean);
    procedure SetEnable3D(const Value: Boolean);
    procedure SetOffset3D(const Value: integer);
    procedure SetAutoSize(const Value: Boolean);
    procedure SetLeftSize(const Value: integer);
    procedure SetRightSize(const Value: integer);
  protected
    procedure FontChanged(Sender: TObject);
    procedure Changed; virtual;
  public
    constructor Create(AOwner: TAdvChart);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property LeftSize: integer read GetLeftSize write SetLeftSize;
    property LeftLineSize: integer read GetLeftLineSize;
    property RightSize: integer read GetRightSize write SetRightSize;
    property RightLineSize: integer read GetRightLineSize;
    procedure Draw(Canvas: TCanvas; R: TRect; Left: boolean; ScaleX, ScaleY: Double; Horizontal: Boolean);
    //Settings
    procedure SaveToFile(ini: TMemIniFile;Section: String);
    procedure LoadFromFile(ini: TMemIniFile;Section: String);
  published
    property AutoSize: Boolean read FAutoSize write SetAutoSize default True;
    property Alignment: TAlignment read FAlignment write SetAlignment default taCenter;
    property AutoUnits: Boolean read FAutoUnits write SetAutoUnits default true;
    property Color: TColor read FColor write SetColor default clNone;
    property ColorTo: TColor read FColorTo write SetColorTo default clNone;
    property GradientDirection: TChartGradientDirection read FGradientDirection write SetGradientDirection default cgdHorizontal;
    property GradientSteps: Integer read FGradientSteps write SetGradientSteps default 100;
    property Font: TFont read FFont write SetFont;
    property Line: boolean read FLine write SetLine default true;
    property LineColor: TColor read FLineColor write SetLineColor default clBlack;
    property LineWidth: integer read FLineWidth write SetLineWidth default 1;
    property Position: TChartYAxisPosition read FPosition write SetPosition default yLeft;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Size: integer read FSize write SetSize default 30;
    property Text: string read FText write SetText;
    property Enable3D: Boolean read FEnable3D write SetEnable3D default false;
    property Darken3D: Boolean read FDarken3D write SetDarken3D default true;
    property Offset3D: integer read FOffset3D write SetOffset3D default 20;
  end;

  TChartTitle = class(TPersistent)
  private
    FAlignment: TAlignment;
    FVerticalAlignment: TVerticalAlignment;
    FBorderColor: TColor;
    FBorderWidth: integer;
    FColor: TColor;
    FColorTo: TColor;
    FGradientSteps: integer;
    FGradientDirection: TChartGradientDirection;
    FFont: TFont;
    FOnChange: TNotifyEvent;
    FOwner: TAdvChart;
    FPosition: TTitlePosition;
    FSize: integer;
    FText: String;
    function GetBottomSize: integer;
    function GetTopSize: integer;
    procedure SetAlignment(const Value: TAlignment);
    procedure SetColor(const Value: TColor);
    procedure SetFont(const Value: TFont);
    procedure SetPosition(const Value: TTitlePosition);
    procedure SetSize(const Value: integer);
    procedure SetText(const Value: String);
    procedure SetBorderColor(const Value: TColor);
    procedure SetBorderWidth(const Value: Integer);
    procedure SetColorTo(const Value: TColor);
    procedure SetGradientDirection(const Value: TChartGradientDirection);
    procedure SetGradientSteps(const Value: integer);
    procedure SetVerticalAlignment(const Value: TVerticalAlignment);
  protected
    procedure FontChanged(Sender: TObject);
    procedure Changed; virtual;
  public
    constructor Create(AOwner: TAdvChart);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Draw(Canvas: TCanvas; Top: Boolean; R: TRect; ScaleX, ScaleY: Double);
    property TopSize: integer read GetTopSize;
    property BottomSize: integer read GetBottomSize;
    //Settings
    procedure SaveToFile(ini: TMemIniFile;Section: String);
    procedure LoadFromFile(ini: TMemIniFile;Section: String);
  published
    property VerticalAlignment: TVerticalAlignment read FVerticalAlignment write SetVerticalAlignment default taVerticalCenter;
    property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify;
    property BorderColor: TColor read FBorderColor write SetBorderColor default clNone;
    property BorderWidth: integer read FBorderWidth write SetBorderWidth default 0;
    property Color: TColor read FColor write SetColor default clNone;
    property ColorTo: TColor read FColorTo write SetColorTo default clNone;
    property GradientSteps: integer read FGradientSteps write SetGradientSteps default 100;
    property GradientDirection: TChartGradientDirection read FGradientDirection write SetGradientDirection default cgdHorizontal;
    property Font: TFont read FFont write SetFont;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Position: TTitlePosition read FPosition write SetPosition default tNone;
    property Size: integer read FSize write SetSize default 20;
    property Text: String read FText write SetText;
  end;

  TChartBands = class(TPersistent)
  private
    FDistance: double;
    FGradientSteps: integer;
    FGradientDirection: TChartGradientDirection;
    FOnChange: TNotifyEvent;
    FOwner: TAdvChart;
    FPrimaryColor: TColor;
    FPrimaryColorTo: TColor;
    FSecondaryColor: TColor;
    FSecondaryColorTo: TColor;
    FSerieIndex: integer;
    FVisible: Boolean;
    procedure SetGradientDirection(const Value: TChartGradientDirection);
    procedure SetGradientSteps(const Value: integer);
    procedure SetPrimaryColor(const Value: TColor);
    procedure SetPrimaryColorTo(const Value: TColor);
    procedure SetSecondaryColor(const Value: TColor);
    procedure SetSecondaryColorTo(const Value: TColor);
    procedure SetSerieIndex(const Value: integer);
    procedure SetVisible(const Value: boolean);
  protected
    procedure Changed; virtual;
  public
    constructor Create(AOwner: TAdvChart);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    //Settings
    procedure SaveToFile(ini: TMemIniFile;Section: String);
    procedure LoadFromFile(ini: TMemIniFile;Section: String);
  published
    property Distance: double read FDistance write FDistance;
    property GradientSteps: integer read FGradientSteps write SetGradientSteps default 100;
    property GradientDirection: TChartGradientDirection read FGradientDirection write SetGradientDirection default cgdHorizontal;
    property PrimaryColor: TColor read FPrimaryColor write SetPrimaryColor default clSilver;
    property PrimaryColorTo: TColor read FPrimaryColorTo write SetPrimaryColorTo default clWhite;
    property SecondaryColor: TColor read FSecondaryColor write SetSecondaryColor default clNavy;
    property SecondaryColorTo: TColor read FSecondaryColorTo write SetSecondaryColorTo default clWhite;
    property Visible: Boolean read FVisible write SetVisible default false;
    property SerieIndex: integer read FSerieIndex write SetSerieIndex default 0;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TChartBackground = class(TPersistent)
  private
    FBackgroundPosition: TChartBackGroundPosition;
    FGradientDirection: TChartGradientDirection;
    FGradientSteps: integer;
    FColor: TColor;
    FColorTo: TColor;
    FFont: TFont;
    FOnChange: TNotifyEvent;
    FOwner: TAdvChart;
    FPicture: TPicture;
    FPictureVisible: Boolean;
    procedure SetBackgroundPosition(const Value: TChartBackGroundPosition);
    procedure SetColor(const Value: TColor);
    procedure SetColorTo(const Value: TColor);
    procedure SetFont(const Value: TFont);
    procedure SetGradientDirection(const Value: TChartGradientDirection);
    procedure SetGradientSteps(const Value: integer);
    procedure SetPicture(const Value: TPicture);
    procedure SetPictureVisible(const Value: boolean);
  protected
    procedure FontChanged(Sender: TObject);
    procedure PictureChanged(Sender: TObject);
    procedure Changed; virtual;
  public
    constructor Create(AOwner: TAdvChart); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Draw(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double); virtual;
    //Settings
    procedure SaveToFile(ini: TMemIniFile;Section: String); virtual;
    procedure LoadFromFile(ini: TMemIniFile;Section: String); virtual;
  published
    property BackGroundPosition: TChartBackGroundPosition read FBackgroundPosition write SetBackgroundPosition default bpTopLeft;
    property Color: TColor read FColor write SetColor default clNone;
    property ColorTo: TColor read FColorTo write SetColorTo default clNone;
    property GradientSteps: integer read FGradientSteps write SetGradientSteps default 100;
    property GradientDirection: TChartGradientDirection read FGradientDirection write SetGradientDirection default cgdHorizontal;
    property Font: TFont read FFont write SetFont;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Picture: TPicture read FPicture write SetPicture;
    property PictureVisible: boolean read FPictureVisible write SetPictureVisible default false;
  end;

  TChartPointValueType = (cpvSingle, cpvMulti);

  TChartPoint = record
    SingleValue, SingleXValue: Double;
    SecondValue: Double;
    OpenValue: double;
    LowValue: double;
    HighValue: double;
    MedValue: Double;
    CloseValue: double;
    Defined: Boolean;
    PixelValue1: integer;
    PixelValue2: integer;
    Color: TColor;
    ColorTo: TColor;
    TextColor: TColor;
    BorderColor: TColor;
    GradientDirection: TChartGradientDirection;
    TimeStamp, TimeXStamp: TDateTime;
    ValueType: TChartPointValueType;
    LegendValue: string;
    Tag: Integer;
  end;

  TChartRange = class(TPersistent)
  private
    FForceMaxRangeTo: Boolean;
    FMaxRangeTo: integer;
    FOnChange: TNotifyEvent;
    FOwner: TAdvChart;
    FRangeFrom: integer;
    FRangeTo: integer;
    FMaximumScrollRange: integer;
    FMinimumScrollRange: integer;
    FStartDate: TDateTime;
    procedure SetForceMaxRangeTo(const Value: Boolean);
    procedure SetMaxRangeTo(const Value: integer);
    procedure SetRangeFrom(const Value: integer);
    procedure SetRangeTo(const Value: integer);
    procedure SetMaximumScrollRange(const Value: integer);
    procedure SetMinimumScrollRange(const Value: integer);
    procedure SetStartDate(const Value: TDateTime);
  protected
    procedure Changed; virtual;
  public
    constructor Create(AOwner: TAdvChart);
    procedure Assign(Source: TPersistent); override;
    property MaxRangeTo: integer read FMaxRangeTo write SetMaxRangeTo;
    property ForceMaxRangeTo: Boolean read FForceMaxRangeTo write SetForceMaxRangeTo;
    //Settings
    procedure SaveToFile(ini: TMemIniFile;Section: String);
    procedure LoadFromFile(ini: TMemIniFile;Section: String);
  published
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property StartDate: TDateTime read FStartDate write SetStartDate;
    property RangeFrom: integer read FRangeFrom write SetRangeFrom default 0;
    property RangeTo: integer read FRangeTo write SetRangeTo default 10;
    property MinimumScrollRange: integer read FMinimumScrollRange write SetMinimumScrollRange default 0;
    property MaximumScrollRange: integer read FMaximumScrollRange write SetMaximumScrollRange default 0;
  end;

  TChartXGrid = class(TPersistent)
  private
    FMinorDistance: integer;
    FMajorDistance: integer;
    FMinorLineColor: TColor;
    FMajorLineColor: TColor;
    FMinorLineStyle: TPenStyle;
    FMajorLineStyle: TPenStyle;
    FMinorLineWidth: integer;
    FMajorLineWidth: integer;
    FMinorFont: TFont;
    FMajorFont: TFont;
    FOnChange: TNotifyEvent;
    FOnTop: Boolean;
    FOwner: TAdvChart;
    FVisible: Boolean;
    FAutoUnits: Boolean;
    procedure SetMajorDistance(const Value: integer);
    procedure SetMajorFont(const Value: TFont);
    procedure SetMajorLineColor(const Value: TColor);
    procedure SetMajorLineStyle(const Value: TPenStyle);
    procedure SetMajorLineWidth(const Value: integer);
    procedure SetMinorDistance(const Value: integer);
    procedure SetMinorFont(const Value: TFont);
    procedure SetMinorLineColor(const Value: TColor);
    procedure SetMinorLineStyle(const Value: TPenStyle);
    procedure SetMinorLineWidth(const Value: integer);
    procedure SetOnTop(const Value: boolean);
    procedure SetVisible(const Value: boolean);
    procedure SetAutoUnits(const Value: Boolean);
  protected
    procedure FontChanged(Sender: TObject);
    procedure Changed; virtual;
  public
    constructor Create(AOwner: TAdvChart);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Draw(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double);
    //Settings
    procedure SaveToFile(ini: TMemIniFile;Section: String);
    procedure LoadFromFile(ini: TMemIniFile;Section: String);
  published
    property AutoUnits: Boolean read FAutoUnits write SetAutoUnits default true;
    property MinorDistance: integer read FMinorDistance write SetMinorDistance default 10;
    property MajorDistance: integer read FMajorDistance write SetMajorDistance default 20;
    property MinorLineColor: TColor read FMinorLineColor write SetMinorLineColor default clBlack;
    property MajorLineColor: TColor read FMajorLineColor write SetMajorLineColor default clBlack;
    property MinorLineStyle: TPenStyle read FMinorLineStyle write SetMinorLineStyle default psSolid;
    property MajorLineStyle: TPenStyle read FMajorLineStyle write SetMajorLineStyle default psDot;
    property MinorLineWidth: integer read FMinorLineWidth write SetMinorLineWidth default 1;
    property MajorLineWidth: integer read FMajorLineWidth write SetMajorLineWidth default 1;
    property MajorFont: TFont read FMajorFont write SetMajorFont;
    property MinorFont: TFont read FMinorFont write SetMinorFont;
    property OnTop: boolean read FOnTop write SetOnTop default false;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Visible: boolean read FVisible write SetVisible default false;
  end;

  TChartYGrid = class(TPersistent)
  private
    FAutoUnits: Boolean;
    FBorderColor: TColor;
    FMinorDistance: double;
    FMajorDistance: double;
    FMinorLineColor: TColor;
    FMajorLineColor: TColor;
    FMinorLineStyle: TPenStyle;
    FMajorLineStyle: TPenStyle;
    FMinorLineWidth: integer;
    FMajorLineWidth: integer;
    FOnChange: TNotifyEvent;
    FOnTop: Boolean;
    FOwner: TAdvChart;
    FVisible: Boolean;
    FSerieIndex: integer;
    FShowBorder: Boolean;
    procedure SetAutoUnits(const Value: Boolean);
    procedure SetBorderColor(const Value: TColor);
    procedure SetMajorDistance(const Value: double);
    procedure SetMajorLineColor(const Value: TColor);
    procedure SetMajorLineStyle(const Value: TPenStyle);
    procedure SetMajorLineWidth(const Value: integer);
    procedure SetMinorDistance(const Value: double);
    procedure SetMinorLineColor(const Value: TColor);
    procedure SetMinorLineStyle(const Value: TPenStyle);
    procedure SetMinorLineWidth(const Value: integer);
    procedure SetOnTop(const Value: boolean);
    procedure SetSerieIndex(const Value: integer);
    procedure SetShowBorder(const Value: boolean);
    procedure SetVisible(const Value: boolean);
  protected
    procedure Changed; virtual;
  public
    constructor Create(AOwner: TAdvChart); virtual;
    procedure Assign(Source: TPersistent); override;
    procedure Draw(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double); virtual;
    //Settings
    procedure SaveToFile(ini: TMemIniFile;Section: String);
    procedure LoadFromFile(ini: TMemIniFile;Section: String);
  published
    property AutoUnits: Boolean read FAutoUnits write SetAutoUnits default true;
    property BorderColor: TColor read FBorderColor write SetBorderColor default clNone;
    property MinorDistance: double read FMinorDistance write SetMinorDistance;
    property MajorDistance: double read FMajorDistance write SetMajorDistance;
    property MinorLineColor: TColor read FMinorLineColor write SetMinorLineColor default clGray;
    property MajorLineColor: TColor read FMajorLineColor write SetMajorLineColor default clSilver;
    property MinorLineStyle: TPenStyle read FMinorLineStyle write SetMinorLineStyle default psdot;
    property MajorLineStyle: TPenStyle read FMajorLineStyle write SetMajorLineStyle default psSolid;
    property MinorLineWidth: integer read FMinorLineWidth write SetMinorLineWidth default 1;
    property MajorLineWidth: integer read FMajorLineWidth write SetMajorLineWidth default 1;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnTop: boolean read FOnTop write SetOnTop default false;
    property Visible: boolean read FVisible write SetVisible default false;
    property SerieIndex: integer read FSerieIndex write SetSerieIndex default 0;
    property ShowBorder: boolean read FShowBorder write SetShowBorder default false;
  end;

  TChartSerie = class;

  TChartType = (ctNone, ctLine, ctArea, ctBar, ctLineBar, ctHistogram, ctLineHistogram,
    ctCandleStick, ctLineCandleStick, ctOHLC, ctMarkers, ctStackedBar, ctStackedArea,
    ctStackedPercArea, ctStackedPercBar, ctError, ctArrow, ctScaledArrow,
    ctBubble, ctScaledBubble, ctPie, ctHalfPie, ctDonut,ctHalfDonut, ctBand,
    ctSpider, ctHalfSpider,
    ctVarRadiusPie, ctVarRadiusHalfPie, ctVarRadiusDonut, ctVarRadiusHalfDonut,
    ctSizedPie, ctSizedHalfPie, ctSizedDonut, ctSizedHalfDonut, ctDigitalLine, ctBoxPlot, ctRenko,
    ctXYLine, ctXYMarkers, ctGantt, ctFunnel, ctXYDigitalLine);

  TChartMarkerType = (mNone, mCircle, mSquare, mDiamond, mTriangle, mPicture, mCustom);

  TChartSerieGetNumberOfPoints = procedure(Sender: TObject; Serie: Integer; var ANumberOfPoints: Integer) of object;

  TChartSerieGetPoint = procedure(Sender: TObject; Serie: Integer; AIndex: Integer; var APoint: TChartPoint) of object;

  TChartMarkerDrawEvent = procedure(Sender: TObject; Serie: TChartSerie; Canvas: TCanvas; X, Y, Point: integer; value: TChartPoint) of object;

  TChartSerieXAxisCustomGroupEvent = procedure(Sender: TObject; Pane:Integer;Serie:Integer;GroupIndex: Integer; Canvas: TCanvas; R: TRect; var DrawText: Boolean) of object;

  TChartSerieXAxisGroupLineType = (xgltVertical, xgltVerticalLine, xgltWrap, xgltCustom);

  TChartSerieXAxisGroup = class(TCollectionItem)
  private
    FLineColor: TColor;
    FStartIndex: Integer;
    FLineType: TChartSerieXAxisGroupLineType;
    FEndIndex: Integer;
    FFont: TFont;
    FCaption: String;
    FVisible: Boolean;
    FLevel: Integer;
    FSpacing: Integer;
    procedure SetCaption(const Value: String);
    procedure SetEndIndex(const Value: Integer);
    procedure SetFont(const Value: TFont);
    procedure SetLineColor(const Value: TColor);
    procedure SetLineType(const Value: TChartSerieXAxisGroupLineType);
    procedure SetStartIndex(const Value: Integer);
    procedure SetVisible(const Value: Boolean);
    procedure SetLevel(const Value: Integer);
    procedure SetSpacing(const Value: Integer);
  protected
    procedure FontChanged(Sender: TObject);
    procedure Changed;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    //Settings
    procedure SaveToFile(ini: TMemIniFile; Section: String);
    procedure LoadFromFile(ini: TMemIniFile; Section: String);
  published
    property Caption: String read FCaption write SetCaption;
    property Font: TFont read FFont write SetFont;
    property StartIndex: Integer read FStartIndex write SetStartIndex default 0;
    property EndIndex: Integer read FEndIndex write SetEndIndex default 3;
    property LineColor: TColor read FLineColor write SetLineColor default clBlack;
    property LineType: TChartSerieXAxisGroupLineType read FLineType write SetLineType default xgltVertical;
    property Visible: Boolean read FVisible write SetVisible default True;
    property Level: Integer read FLevel write SetLevel default 0;
    property Spacing: Integer read FSpacing write SetSpacing default 3;
  end;

  TChartSerieXAxisGroups = class(TCollection)
  private
    FOwner: TChartSerie;
    function GetItem(Index: Integer): TChartSerieXAxisGroup;
    procedure SetItem(Index: Integer; const Value: TChartSerieXAxisGroup);
  public
    procedure SaveToFile(ini: TMemIniFile; Section: String);
    procedure LoadFromFile(ini: TMemIniFile; Section: String);
    constructor Create(AOwner: TChartSerie);
    function Add: TChartSerieXAxisGroup;
    function Insert(Index: Integer): TChartSerieXAxisGroup;
    property Items[Index: Integer]: TChartSerieXAxisGroup read GetItem write SetItem; default;
  end;

  TChartMarker = class(TPersistent)
  private
    FMarkerType: TChartMarkerType;
    FMarkerSize: Integer;
    FMarkerColor: TColor;
    FMarkerLineColor: TColor;
    FMarkerLineWidth: integer;
    FMarkerPicture: TPicture;
    FSelectedColor: TColor;
    FSelectedLineColor: TColor;
    FSelectedLineWidth: integer;
    FSelectedIndex: integer;
    FSelectedSize: integer;
    FDisplayIndex: integer;
    FOnChange: TNotifyEvent;
    FIncreaseDecreaseMode: Boolean;
    procedure SetMarkerColor(const Value: TColor);
    procedure SetMarkerLineColor(const Value: TColor);
    procedure SetMarkerLineWidth(const Value: integer);
    procedure SetMarkerSize(const Value: Integer);
    procedure SetMarkerType(const Value: TChartMarkerType);
    procedure SetMarkerPicture(const Value: TPicture);
    procedure SetSelectedColor(const Value: TColor);
    procedure SetSelectedLineColor(const Value: TColor);
    procedure SetSelectedLineWidth(const Value: integer);
    procedure SetSelectedSize(const Value: integer);
    procedure SetSelectedIndex(const Value: integer);
    procedure SetIncreaseDecreaseMode(const Value: Boolean);
  protected
    procedure Changed; virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    //Settings
    procedure SaveToFile(ini: TMemIniFile;Section: String); virtual;
    procedure LoadFromFile(ini: TMemIniFile;Section: String); virtual;
    property SelectedIndex: integer read FSelectedIndex write SetSelectedIndex default -1;
    property DisplayIndex: integer read FDisplayIndex write FDisplayIndex;
  published
    property MarkerType: TChartMarkerType read FMarkerType write SetMarkerType default mNone;
    property MarkerColor: TColor read FMarkerColor write SetMarkerColor default clWhite;
    property MarkerSize: Integer read FMarkerSize write SetMarkerSize default 10;
    property MarkerLineWidth: integer read FMarkerLineWidth write SetMarkerLineWidth default 1;
    property MarkerLineColor: TColor read FMarkerLineColor write SetMarkerLineColor default clBlack;
    property MarkerPicture: TPicture read FMarkerPicture write SetMarkerPicture;
    property SelectedColor: TColor read FSelectedColor write SetSelectedColor default clNone;
    property SelectedLineColor: TColor read FSelectedLineColor write SetSelectedLineColor default clNone;
    property SelectedLineWidth: integer read FSelectedLineWidth write SetSelectedLineWidth default 1;
    property SelectedSize: integer read FSelectedSize write SetSelectedSize default 12;
    property IncreaseDecreaseMode: Boolean read FIncreaseDecreaseMode write SetIncreaseDecreaseMode default false;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TChartTextPosition = (ctLeft, ctRight, ctCenter, ctTop, ctBottom);

  TChartXYAxisText = class(TPersistent)
  private
    FAngle: integer;
    FFont: TFont;
    FOffset: integer;
    FOnChange: TNotifyEvent;
    FPosition: TChartTextPosition;
    FText: string;
    procedure SetAngle(const Value: integer);
    procedure SetFont(const Value: TFont);
    procedure SetOffset(const Value: Integer);
    procedure SetPosition(const Value: TChartTextPosition);
    procedure SetText(const Value: string);
  protected
    procedure Changed; virtual;
    procedure FontChanged(Sender: TObject);
    procedure TextTopChanged(Sender: TObject);
    procedure TextBottomChanged(Sender: TObject);
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
    destructor Destroy; override;
    //Settings
    procedure SaveToFile(ini: TMemIniFile;Section: String);
    procedure LoadFromFile(ini: TMemIniFile;Section: String);
  published
    property Angle: integer read FAngle write SetAngle default 0;
    property Font: TFont read FFont write SetFont;
    property Offset: Integer read FOffset write SetOffset default 0;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Position: TChartTextPosition read FPosition write SetPosition default ctLeft;
    property Text: string read FText write SetText;
  end;

  TChartValueType = (cvNone, cvNormal, cvPercentage);

  TChartSerieYAxis = class(TPersistent)
  private
    FMajorFont: TFont;
    FMajorUnit: Double;
    FMajorUnitSpacing: integer;
    FMinorFont: TFont;
    FMinorUnit: Double;
    FMinorUnitSpacing: integer;
    FOnChange: TNotifyEvent;
    FPosition: TChartYAxisPosition;
    FTextLeft: TChartXYAxisText;
    FTextRight: TChartXYAxisText;
    FTickMarkColor: TColor;
    FTickMarkSize: integer;
    FTickMarkWidth: integer;
    FVisible: Boolean;
    FTickMarkSizeMinor: integer;
    FMinorUnitVisible: Boolean;
    FMajorUnitVisible: Boolean;
    FAutoUnits: Boolean;
    procedure SetMajorFont(const Value: TFont);
    procedure SetMajorUnit(const Value: Double);
    procedure SetMajorUnitSpacing(const Value: integer);
    procedure SetMinorFont(const Value: TFont);
    procedure SetMinorUnit(const Value: Double);
    procedure SetMinorUnitSpacing(const Value: integer);
    procedure SetPosition(const Value: TChartYAxisPosition);
    procedure SetTextLeft(const Value: TChartXYAxisText);
    procedure SetTextRight(const Value: TChartXYAxisText);
    procedure SetTickMarkColor(const Value: TColor);
    procedure SetTickMarkSize(const Value: integer);
    procedure SetTickMarkWidth(const Value: integer);
    procedure SetVisible(const Value: Boolean);
    procedure SetTickMarkSizeMinor(const Value: integer);
    procedure SetMajorUnitVisible(const Value: Boolean);
    procedure SetMinorUnitVisible(const Value: Boolean);
    procedure SetAutoUnits(const Value: Boolean);
  protected
    procedure Changed; virtual;
    procedure FontChanged(Sender: TObject);
    procedure TextLeftChanged(Sender: TObject);
    procedure TextRightChanged(Sender: TObject);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    //Settings
    procedure SaveToFile(ini: TMemIniFile;Section: String);
    procedure LoadFromFile(ini: TMemIniFile;Section: String);
  published
    property AutoUnits: Boolean read FAutoUnits write SetAutoUnits default true;
    property MajorFont: TFont read FMajorFont write SetMajorFont;
    property MajorUnit: Double read FMajorUnit write SetMajorUnit;
    property MajorUnitVisible: Boolean read FMajorUnitVisible write SetMajorUnitVisible default true;
    property MajorUnitSpacing: integer read FMajorUnitSpacing write SetMajorUnitSpacing default 2;
    property MinorFont: TFont read FMinorFont write SetMinorFont;
    property MinorUnit: Double read FMinorUnit write SetMinorUnit;
    property MinorUnitVisible: Boolean read FMinorUnitVisible write SetMinorUnitVisible default true;
    property MinorUnitSpacing: integer read FMinorUnitSpacing write SetMinorUnitSpacing default 2;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Position: TChartYAxisPosition read FPosition write SetPosition default yLeft;
    property TextLeft: TChartXYAxisText read FTextLeft write SetTextLeft;
    property TextRight: TChartXYAxisText read FTextRight write SetTextRight;
    property TickMarkColor: TColor read FTickMarkColor write SetTickMarkColor default clNone;
    property TickMarkSize: integer read FTickmarkSize write SetTickMarkSize default 10;
    property TickMarkSizeMinor: integer read FTickMarkSizeMinor write SetTickMarkSizeMinor default 7;
    property TickMarkWidth: integer read FTickMarkWidth write SetTickMarkWidth default 1;
    property Visible: Boolean read FVisible write SetVisible default true;
  end;

  TChartSerieXAxis = class(TPersistent)
  private
    FDateTimeFormat: String;
    FDateTimeFont: TFont;
    FMajorFont: TFont;
    FMajorUnit: Double;
    FMajorUnitSpacing: integer;
    FMajorUnitTimeFormat: String;
    FMinorFont: TFont;
    FMinorUnit: Double;
    FMinorUnitTimeFormat: String;
    FMinorUnitSpacing: integer;
    FOnChange: TNotifyEvent;
    FPosition: TChartXAxisPosition;
    FTextTop: TChartXYAxisText;
    FTextBottom: TChartXYAxisText;
    FTickMarkColor: TColor;
    FTickMarkSize: integer;
    FTickMarkWidth: integer;
    FVisible: Boolean;
    FAutoUnits: Boolean;
    FXYValueOffset: integer;
    FXYValues: Boolean;
    procedure SetMajorFont(const Value: TFont);
    procedure SetMajorUnit(const Value: Double);
    procedure SetMajorUnitSpacing(const Value: integer);
    procedure SetMajorUnitTimeFormat(const Value: String);
    procedure SetMinorFont(const Value: TFont);
    procedure SetMinorUnit(const Value: Double);
    procedure SetMinorUnitSpacing(const Value: integer);
    procedure SetMinorUnitTimeFormat(const Value: String);
    procedure SetPosition(const Value: TChartXAxisPosition);
    procedure SetTextBottom(const Value: TChartXYAxisText);
    procedure SetTextTop(const Value: TChartXYAxisText);
    procedure SetTickMarkColor(const Value: TColor);
    procedure SetTickMarkSize(const Value: integer);
    procedure SetTickMarkWidth(const Value: integer);
    procedure SetVisible(const Value: Boolean);
    procedure SetDateTimeFormat(const Value: String);
    procedure SetDateTimeFont(const Value: TFont);
    procedure SetAutoUnits(const Value: Boolean);
    procedure SetXYValues(const Value: Boolean);
    procedure SetXYValuesOffset(const Value: integer);
  protected
    procedure Changed; virtual;
    procedure FontChanged(Sender: TObject);
    procedure TextTopChanged(Sender: TObject);
    procedure TextBottomChanged(Sender: TObject);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    //Settings
    procedure SaveToFile(ini: TMemIniFile;Section: String);
    procedure LoadFromFile(ini: TMemIniFile;Section: String);
  published
    property DateTimeFormat: String read FDateTimeFormat write SetDateTimeFormat;
    property DateTimeFont: TFont read FDateTimeFont write SetDateTimeFont;
    property MajorFont: TFont read FMajorFont write SetMajorFont;
    property MajorUnit: Double read FMajorUnit write SetMajorUnit;
    property MajorUnitTimeFormat: String read FMajorUnitTimeFormat write SetMajorUnitTimeFormat;
    property MajorUnitSpacing: integer read FMajorUnitSpacing write SetMajorUnitSpacing default 2;
    property MinorFont: TFont read FMinorFont write SetMinorFont;
    property MinorUnit: Double read FMinorUnit write SetMinorUnit;
    property MinorUnitTimeFormat: String read FMinorUnitTimeFormat write SetMinorUnitTimeFormat;
    property MinorUnitSpacing: integer read FMinorUnitSpacing write SetMinorUnitSpacing default 2;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Position: TChartXAxisPosition read FPosition write SetPosition default xBottom;
    property TextTop: TChartXYAxisText read FTextTop write SetTextTop;
    property TextBottom: TChartXYAxisText read FTextBottom write SetTextBottom;
    property TickMarkColor: TColor read FTickMarkColor write SetTickMarkColor default clBlack;
    property TickMarkSize: integer read FTickmarkSize write SetTickMarkSize default 10;
    property TickMarkWidth: integer read FTickMarkWidth write SetTickMarkWidth default 1;
    property Visible: Boolean read FVisible write SetVisible default true;
    property AutoUnits: Boolean read FAutoUnits write SetAutoUnits default true;
    property XYValues: Boolean read FXYValues write SetXYValues default true;
    property XYValuesOffset: integer read FXYValueOffset write SetXYValuesOffset default 0;
  end;

  TChartSerieCrossHairYValue = class(TPersistent)
  private
    FBorderColor: TColor;
    FBorderWidth: integer;
    FColor: TColor;
    FColorTo: TColor;
    FFont: TFont;
    FGradientSteps: integer;
    FGradientDirection: TChartGradientDirection;
    FOnChange: TNotifyEvent;
    FOnFontChange: TNotifyEvent;
    FVisible: Boolean;
    procedure SetBorderColor(const Value: TColor);
    procedure SetColor(const Value: TColor);
    procedure SetColorTo(const Value: TColor);
    procedure SetFont(const Value: TFont);
    procedure SetGradientDirection(const Value: TChartGradientDirection);
    procedure SetGradientSteps(const Value: integer);
    procedure SetVisible(const Value: Boolean);
    procedure SetBorderWidth(const Value: integer);
  protected
    procedure Changed; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    //Settings
    procedure SaveToFile(ini: TMemIniFile;Section: String);
    procedure LoadFromFile(ini: TMemIniFile;Section: String);
  published
    property BorderColor: TColor read FBorderColor write SetBorderColor default clNone;
    property BorderWidth: integer read FBorderWidth write SetBorderWidth default 1;
    property Color: TColor read FColor write SetColor default clNone;
    property ColorTo: TColor read FColorTo write SetColorTo default clNone;
    property Font: TFont read FFont write SetFont;
    property GradientDirection: TChartGradientDirection read FGradientDirection write SetGradientDirection default cgdHorizontal;
    property GradientSteps: integer read FGradientSteps write SetGradientSteps default 100;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnFontChange: TNotifyEvent read FOnFontChange write FOnFontChange;
    property Visible: Boolean read FVisible write SetVisible default true;
  end;

  TChartSerieValueWidthType = (wtPixels, wtPercentage);

  TChartXAxisDrawValue = procedure(Sender: TObject; Serie: TChartSerie; Canvas: TCanvas; ARect: TRect; ValueIndex, XMarker: integer; Top: Boolean; var defaultdraw: Boolean) of object;

  TChartYAxisDrawValue = procedure(Sender: TObject; Serie: TChartSerie; Canvas: TCanvas; ARect: TRect; Value: double; Left: Boolean; var defaultdraw: Boolean) of object;

  TChartAxisGetValue = procedure(Sender: TObject; Serie: TChartSerie; Value: double; var AValue: string) of object;

  TChartSerieMouseEvent = procedure(Sender: TObject; Button: TMouseButton; PaneIndex: integer; SerieIndex: Integer; Index: integer; value: Double; X, Y: integer) of object;

  TChartMode = (cmInit, cmScaling, cmVerticalScrolling, cmHorizontalScrolling);

  TChartSerieAutoRange = (arDisabled, arEnabled, arCommon, arEnabledZeroBased, arCommonZeroBased);

  TPointArray = array of TPoint;

  TDigitalLinePoint = record
    pt: TPoint;
    Idx: Integer;
  end;

  TDigitalLinePointArray = array of TDigitalLinePoint;

  TPointCheck = record
    pt: TPoint;
    valid: Boolean;
  end;

  TRectArray = array of TRect;

  TChartPointArray = array of TChartPoint;

  TAnnotationShape = (asRectangle, asCircle, asRoundRect, asBalloon, asLine);

  TAnnotationArrow = (arLine, arStartArrow, arEndArrow, arDoubleArrow);

  TAnnotationBalloonDirection = (hdUpRight, hdUpLeft, hdDownRight, hdDownLeft);

  TChartAnnotation = class(TCollectionItem)
  private
    FOwner: TPersistent;
    FOnChange: TNotifyEvent;
    FTextHorizontalAlignment: TAlignment;
    FTextVerticalAlignment: TVerticalAlignment;
    FText: String;
    FColor: TColor;
    FColorTo: TColor;
    FPointIndex: integer;
    FShape: TAnnotationShape;
    FBalloonDirection: TAnnotationBalloonDirection;
    FBalloonArrowSize: integer;
    FBorderColor: TColor;
    FBorderRounding: Integer;
    FBorderWidth: integer;
    FLineWidth: integer;
    FLineColor: TColor;
    FFont: TFont;
    FWidth: integer;
    FHeight: integer;
    FAnnotationRect: Trect;
    FAutoSize: Boolean;
    FOffsetX: integer;
    FOffsetY: integer;
    FDisplayIndex: integer;
    FClipRgn: THandle;
    FArrow: TAnnotationArrow;
    FGradientSteps: integer;
    FWordWrap: Boolean;
    FName: String;
    FArrowSize: integer;
    FArrowColor: TColor;
    FGradientDirection: TChartGradientDirection;
    FVisible: Boolean;
    procedure SetArrow(const Value: TAnnotationArrow);
    procedure SetAutoSize(const Value: Boolean);
    procedure SetBorderColor(const Value: TColor);
    procedure SetBorderRounding(const Value: integer);
    procedure SetColor(const Value: TColor);
    procedure SetColorTo(const Value: TColor);
    procedure SetFont(const Value: TFont);
    procedure SetGradientDirection(const Value: TChartGradientDirection);
    procedure SetGradientSteps(const Value: Integer);
    procedure SetHeight(const Value: integer);
    procedure SetOffSetX(const Value: integer);
    procedure SetOffSetY(const Value: integer);
    procedure SetPointIndex(const Value: integer);
    procedure SetShape(const Value: TAnnotationShape);
    procedure SetText(const Value: String);
    procedure SetWidth(const Value: integer);
    procedure SetborderWidth(const Value: integer);
    procedure SetWordWrap(const Value: Boolean);
    procedure SetBalloonDirection(const Value: TAnnotationBalloonDirection);
    procedure SetBalloonArrowSize(const Value: Integer);
    procedure SetArrowSize(const Value: integer);
    procedure SetVisible(const Value: Boolean);
    procedure SetTextHorizontalAlignment(const Value: TAlignment);
    procedure SetTextVerticalAlignment(const Value: TVerticalAlignment);
    procedure SetArrowColor(const Value: TColor);
    procedure SetLineColor(const Value: TColor);
    procedure SetLineWidth(const Value: integer);
    procedure SetName(const Value: String);
    function GetSerie: TChartSerie;
  protected
    procedure Changed; virtual;
    procedure FontChanged(Sender: Tobject);
    function DrawBalloon(Canvas: TCanvas; R: Trect; OldRgn: Thandle; ScaleX, ScaleY: Double): TRect; virtual;
    property Serie: TChartSerie read GetSerie;
    procedure Draw(Canvas: TCanvas; DR, TextR: TRect; xm,ym: integer; ScaleX, ScaleY: double); virtual;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property AnnotationRect: TRect read FAnnotationRect;
    //
    procedure SaveToFile(ini: TMemIniFile;Section: String); virtual;
    procedure LoadFromFile(ini: TMemIniFile;Section: String); virtual;
    property DisplayIndex: integer read FDisplayIndex write FDisplayIndex;
  published
    property Name: String read FName write SetName;
    property TextHorizontalAlignment: TAlignment read FTextHorizontalAlignment write SetTextHorizontalAlignment default taLeftJustify;
    property TextVerticalAlignment: TVerticalAlignment read FTextVerticalAlignment write SetTextVerticalAlignment default taAlignTop;
    property Arrow: TAnnotationArrow read FArrow write SetArrow default arLine;
    property ArrowSize: integer read FArrowSize write SetArrowSize default 10;
    property ArrowColor: TColor read FArrowColor write SetArrowColor default clNone;
    property AutoSize: Boolean read FAutoSize write SetAutoSize default true;
    property BalloonDirection: TAnnotationBalloonDirection read FBalloonDirection write SetBalloonDirection default hdDownLeft;
    property BalloonArrowSize: Integer read FBalloonArrowSize write SetBalloonArrowSize default 15;
    property BorderColor: TColor read FBorderColor write SetBorderColor default clBlack;
    property BorderRounding: integer read FBorderRounding write SetBorderRounding default 0;
    property BorderWidth: integer read FBorderWidth write SetborderWidth default 1;
    property LineWidth: integer read FLineWidth write SetLineWidth default 1;
    property LineColor: TColor read FLineColor write SetLineColor default clBlack;
    property Color: TColor read FColor write SetColor default clYellow;
    property ColorTo: TColor read FColorTo write SetColorTo default clNone;
    property Font: TFont read FFont write SetFont;
    property GradientSteps: Integer read FGradientSteps write SetGradientSteps default 100;
    property GradientDirection: TChartGradientDirection read FGradientDirection write SetGradientDirection default cgdVertical;
    property Height: integer read FHeight write SetHeight default 0;
    property OffsetX: integer read FOffsetX write SetOffSetX default 20;
    property OffsetY: integer read FOffsetY write SetOffSetY default 20;
    property Shape: TAnnotationShape read FShape write SetShape default asRectangle;
    property Text: string read FText write SetText;
    property Width: integer read FWidth write SetWidth default 0;
    property WordWrap: Boolean read FWordWrap write SetWordWrap default false;
    property Visible: Boolean read FVisible write SetVisible default true;
    property PointIndex: integer read FPointIndex write SetPointIndex default -1;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TChartAnnotations = class(TOwnedCollection)
  private
    FOwner: TChartSerie;
    FOnChange: TNotifyEvent;
    function GetItem(Index: Integer): TChartAnnotation;
    procedure SetItem(Index: Integer; const Value: TChartAnnotation);
  protected
    procedure Changed; virtual;
    procedure AnnotationChanged(Sender: TObject);
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AOwner: TChartSerie);
    destructor Destroy; override;
    function GetItemClass: TCollectionItemClass; virtual;
    function Add:TChartAnnotation;
    function Insert(index:integer): TChartAnnotation;
    property Items[Index: Integer]: TChartAnnotation read GetItem write SetItem; default;
    //
    procedure SaveToFile(ini: TMemIniFile;Section: String); virtual;
    procedure LoadFromFile(ini: TMemIniFile;Section: String); virtual;
  published
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TChartSeriePieValuePosition = (vpInsideSlice, vpOutSideSlice);

  TChartSeriePieSizeType = (pstPixels, pstPercentage);

  TChartSerieFunnelSizeType = (fstPixels, fstPercentage);

  TChartSeriePie = class(TPersistent)
  private
    FOwner: TChartSerie;
    FOnChange: TNotifyEvent;
    FSize: integer;
    FPosition: TChartSeriePiePosition;
    FInnerSize: integer;
    FShowValues: Boolean;
    FStartOffsetAngle: integer;
    FValueFont: TFont;
    FLegendVisible: Boolean;
    FLegendLeft: integer;
    FLegendTop: integer;
    FLegendPosition: TChartSeriePiePosition;
    FLegendColor: TColor;
    FLegendBorderColor: TColor;
    FLegendBorderWidth: integer;
    FLegendGradientSteps: integer;
    FLegendGradientDirection: TChartGradientDirection;
    FLegendColorTo: TColor;
    FLegendFont: TFont;
    FLegendTitleGradientSteps: integer;
    FLegendTitleGradientDirection: TChartGradientDirection;
    FLegendTitleColor: TColor;
    FLegendTitleVisible: Boolean;
    FLegendTitleColorTo: TColor;
    FTop: Integer;
    FLeft: Integer;
    FShowGrid: Boolean;
    FShowGridPieLines: Boolean;
    FValuePosition: TChartSeriePieValuePosition;
    FShowLegendOnSlice: Boolean;
    FSizeType: TChartSeriePieSizeType;
    procedure SetPieSize(const Value: integer);
    procedure SetLegendVisible(const Value: Boolean);
    procedure SetLegendFont(const Value: TFont);
    procedure SetLegendColor(const Value: TColor);
    procedure SetLegendGradientDirection(const Value: TChartGradientDirection);
    procedure SetLegendGradientSteps(const Value: integer);
    procedure SetLegendBorderColor(const Value: TColor);
    procedure SetLegendBorderWidth(const Value: Integer);
    procedure SetLegendColorTo(const Value: TColor);
    procedure SetShowValues(const Value: Boolean);
    procedure SetValueFont(const Value: TFont);
    procedure SetStartOffsetAngle(const Value: integer);
    procedure SetLegendOffSetLeft(const Value: integer);
    procedure SetLegendOffSetTop(const Value: integer);
    procedure SetInnerSize(const Value: integer);
    procedure SetLegendTitleColor(const Value: TColor);
    procedure SetLegendTitleGradientSteps(const Value: integer);
    procedure SetLegendTitleVisible(const Value: Boolean);
    procedure SetLegendTitleGradientDirection(
      const Value: TChartGradientDirection);
    procedure SetLegendTitleColorTo(const Value: TColor);
    procedure SetPosition(const Value: TChartSeriePiePosition);
    procedure SetLeft(const Value: Integer);
    procedure SetTop(const Value: Integer);
    procedure SetLegendPosition(const Value: TChartSeriePiePosition);
    procedure SetShowGrid(const Value: Boolean);
    procedure SetShowGridPieLines(const Value: Boolean);
    procedure SetValuePosition(const Value: TChartSeriePieValuePosition);
    procedure SetShowLegendOnSlice(const Value: Boolean);
    procedure SetSizeType(const Value: TChartSeriePieSizeType);
  protected
    procedure Changed; virtual;
    procedure FontChanged(Sender: TObject);
  public
    constructor Create(AOwner: TChartSerie); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function GetPieSize: Integer;
    function GetPieInnerSize: Integer;
    //Settings
    procedure SaveToFile(ini: TMemIniFile;Section: String); virtual;
    procedure LoadFromFile(ini: TMemIniFile;Section: String); virtual;
  published
    property Position: TChartSeriePiePosition read FPosition write SetPosition default spCenterCenter;
    property LegendPosition: TChartSeriePiePosition read FLegendPosition write SetLegendPosition default spCenterRight;
    property Left: Integer read FLeft write SetLeft default 0;
    property Top: Integer read FTop write SetTop default 0;
    property Size: integer read FSize write SetPieSize default 200;
    property SizeType: TChartSeriePieSizeType read FSizeType write SetSizeType default pstPixels;
    property InnerSize: integer read FInnerSize write SetInnerSize default 50;
    property ShowValues: Boolean read FShowValues write SetShowValues default false;
    property ValuePosition: TChartSeriePieValuePosition read FValuePosition write SetValuePosition default vpInsideSlice;
    property ShowGrid: Boolean read FShowGrid write SetShowGrid default true;
    property ShowGridPieLines: Boolean read FShowGridPieLines write SetShowGridPieLines default true;
    property ShowLegendOnSlice: Boolean read FShowLegendOnSlice write SetShowLegendOnSlice default false;
    property StartOffsetAngle: integer read FStartOffsetAngle write SetStartOffsetAngle default 0;
    property ValueFont: TFont read FValueFont write SetValueFont;
    property LegendVisible: Boolean read FLegendVisible write SetLegendVisible default true;
    property LegendOffsetLeft: integer read FLegendLeft write SetLegendOffsetLeft default 0;
    property LegendOffsetTop: integer read FLegendTop write SetLegendOffsetTop default 0;
    property LegendFont: TFont read FLegendFont write SetLegendFont;
    property LegendColor: TColor read FLegendColor write SetLegendColor default clWhite;
    property LegendColorTo: TColor read FLegendColorTo write SetLegendColorTo default clwhite;
    property LegendGradientSteps: integer read FLegendGradientSteps write SetLegendGradientSteps default 32;
    property LegendGradientDirection: TChartGradientDirection read FLegendGradientDirection write SetLegendGradientDirection default cgdHorizontal;
    property LegendBorderColor: TColor read FLegendBorderColor write SetLegendBorderColor default clBlack;
    property LegendBorderWidth: Integer read FLegendBorderWidth write SetLegendBorderWidth default 1;
    //New title
    property LegendTitleVisible: Boolean read FLegendTitleVisible write SetLegendTitleVisible default false;
    property LegendTitleColor: TColor read FLegendTitleColor write SetLegendTitleColor default clgray;
    property LegendTitleColorTo: TColor read FLegendTitleColorTo write SetLegendTitleColorTo default clSilver;
    property LegendTitleGradientSteps: integer read FLegendTitleGradientSteps write SetLegendTitleGradientSteps default 32;
    property LegendTitleGradientDirection: TChartGradientDirection read FLegendTitleGradientDirection write SetLegendTitleGradientDirection default cgdHorizontal;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TSlicePoint = record
    X0, Y0, X1, Y1, X2, Y2, X3, Y3, X4, Y4: integer;
    CX, CY: integer;
    STA, SWA: Single;
  end;

  TFunnelPoint = record
    X0, Y0, X1, Y1, X2, Y2, X3, Y3: integer;
  end;

  TBarRec = record
    SColor: TColor;
    SColorTo: TColor;
    R: TRect;
  end;

  TBarArray = array of TBarRec;

  TPieQuadrant = (pq1, pq2, pq3, pq4);

  TPointSliceArray = array of TSlicePoint;

  TPointFunnelArray = array of TFunnelPoint;

  TSerieType = (stNormal, stZoomControl, stBoth);

  TChartSerieSliceGetValue = procedure(Sender: TObject; Serie: integer;
    legendtext: String; value: Double; valuepointindex: integer;
    var valueposition: TPoint; var valuestring: String) of object;

  TChartBarShape = (bsRectangle, bsCylinder, bsPyramid);

  TChartBarValueTextType = (btCustomValue, btXAxisValue);

  TChartGetBarValueTextEvent = procedure(Sender: TObject; Serie, PointIndex: integer;
    AFont: TFont; var BarText: String; var Alignment: TAlignment) of object;

  TChartDrawEvent = procedure(Sender: TObject; ARect: TRect; ACanvas: TCanvas) of object;

  TChartSerieDrawPoint = procedure(Sender: TObject; ACanvas: TCanvas; APoint: TPoint; AChartPoint: TChartPoint) of object;

  TChartValueFormatType = (vftNormal, vftFloat);

  TChartSerieFunnelMode = (fmWidth, fmHeight);

  TChartSerie = class(TCollectionItem)
  private
    FDPI: Integer;
    FDrawValuesDP: TPointArray;
    FDrawValuesSlice: TPointSliceArray;
    FDrawValuesFunnel: TPointFunnelArray;
    FPie: TChartSeriePie;
    FShowAnnotationsOnTop: Boolean;
    FAutoRange: TChartSerieAutoRange;
    FChartPatternPosition: TChartBackGroundPosition;
    FArrowColor: TColor;
    FArrowSize: integer;
    FBorderwidth: integer;
    FBorderColor: TColor;
    FBorderRounding: integer;
    FBrushStyle: TBrushStyle;
    FCandleColorIncrease: TColor;
    FCandleColorDecrease: TColor;
    FChartType: TChartType;
    FClipRgn: THandle;
    FColor: TColor;
    FColorTo: TColor;
    FCrossHairYValue: TChartSerieCrossHairYValue;
    FDrawMajorValue: Boolean;
    FDrawMinorValue: Boolean;
    FPointsLineBar, FStackedPointsBar: TPointArray;
    FStackedRectsBar: TBarArray;
    FStackedPointsArea: TPointArray;
    FSpiderV: TPointArray;
    FDrawPoints: TPointArray;
    FForceInit: boolean;
    Ffirstpoint: Double;
    FGradientSteps: integer;
    FGradientDirection: TChartGradientDirection;
    FIsDrawing: boolean;
    FItemIndex: Integer;
    FLastPoint: integer;
    FLegendText: string;
    FLineColor: TColor;
    FLineWidth: Integer;
    FMarker: TChartMarker;
    FAnnotations: TChartAnnotations;
    FMax: double;
    FMaximumValue: Double;
    FMi: integer;
    FMin: double;
    FMinimumDistance: Double;
    FMinimumValue: Double;
    FMu: integer;
    FNextPoint: Double;
    FOffSet: double;
    FOldRect: TRect;
    FOldYScale: Double;
    FOnChange: TNotifyEvent;
    FOriginalYScale: Double;
    FOnXAxisDrawValue: TChartXAxisDrawValue;
    FOnYAxisDrawValue: TChartYAxisDrawValue;
    FOnYAxisGetValue: TChartAxisGetValue;
    FOnXAxisGetValue: TChartAxisGetValue;
    FOnMarkerDrawValue: TChartMarkerDrawEvent;
    FOnSerieMouseDown: TChartSerieMouseEvent;
    FOnSerieMouseUp: TChartSerieMouseEvent;
    FPenStyle: TPenStyle;
    FPoints: TChartPointArray;
    FChartPattern: TPicture;
    FSerieMin: double;
    FSerieMax: double;
    FShowValue: boolean;
    FValueFont: TFont;
    FValueAngle: integer;
    FValueFormat: string;
    FValueType: TChartValueType;
    FValueWidth: integer;
    FValueWidthType: TChartSerieValueWidthType;
    FWickColor: TColor;
    FWickWidth: integer;
    FXAxis: TChartSerieXAxis;
    FXMarker, FLastXVal, FLastXMarker: integer;
    FYAxis: TChartSerieYAxis;
    FYScale: double;
    FZeroLine: Boolean;
    FZeroLineColor: TColor;
    FZeroLineWidth: integer;
    FZeroReferencePoint: Double;
    FShowValueInTracker: boolean;
    FCrosshairFontHeight: integer;
    FName: string;
    FReadOnly: Boolean;
    FSelectedIndex: integer;
    FSelectedMarkBorderColor: TColor;
    FSelectedColor: TColor;
    FSelectedMarkSize: integer;
    FSelectedMark: Boolean;
    FFieldNameValue: String;
    FFieldNameXAxis: String;
    FSerieType: TSerieType;
    FShowInLegend: Boolean;
    FOffset3D: integer;
    FEnable3D: Boolean;
    FOnSerieSliceGetValue: TChartSerieSliceGetValue;
    FDarken3D: Boolean;
    FBarShape: TChartBarShape;
    FLogarithmic: Boolean;
    FBarValueTextFont: TFont;
    FBarValueTextAlignment: TAlignment;
    FBarValueTextType: TChartBarValueTextType;
    FOnGetBarValueText: TChartGetBarValueTextEvent;
    FOnSerieDrawPoint: TChartSerieDrawPoint;
    FVisible: Boolean;
    FOnXAxisGetXValue: TChartAxisGetValue;
    FOnXAxisDrawXValue: TChartXAxisDrawValue;
    FMaximumPoints: integer;
    FUseFullRange: Boolean;
    FRangePercentMargin: Integer;
    FXAxisGroups: TChartSerieXAxisGroups;
    FXAxisGroupsVisible: Boolean;
    FGroupIndex: Integer;
    FValueFormatType: TChartValueFormatType;
    FGanttSpacing: Integer;
    FGanttHeight: Integer;
    FDrawFromStartDate: Boolean;
    FTag: Integer;
    FValueOffsetX: Integer;
    FValueOffsetY: Integer;
    FFunnelMode: TChartSerieFunnelMode;
    FFunnelWidthType: TChartSerieFunnelSizeType;
    FFunnelWidth: Integer;
    FFunnelHeightType: TChartSerieFunnelSizeType;
    FFunnelHeight: Integer;
    FFunnelSpacing: Integer;
    FLinePointsOnly: Boolean;
    procedure SetAutoRange(const Value: TChartSerieAutoRange);
    procedure SetBorderColor(const Value: TColor);
    procedure SetBorderWidth(const Value: integer);
    procedure SetBrushStyle(const Value: TBrushStyle);
    procedure SetCandleColorDecrease(const Value: TColor);
    procedure SetCandleColorIncrease(const Value: TColor);
    procedure SetChartType(const Value: TChartType);
    procedure SetColor(const Value: TColor);
    procedure SetColorTo(const Value: TColor);
    procedure SetCrossHairYValue(const Value: TChartSerieCrossHairYValue);
    procedure SetGradientDirection(const Value: TChartGradientDirection);
    procedure SetGradientSteps(const Value: integer);
    procedure SetLegendText(const Value: string);
    procedure SetLineColor(const Value: TColor);
    procedure SetLineWidth(const Value: Integer);
    procedure SetMax(const Value: double);
    procedure SetMin(const Value: double);
    procedure SetOffset(const Value: Double);
    procedure SetOldYScale(const Value: Double);
    procedure SetOriginalYScale(const Value: Double);
    procedure SetPenStyle(const Value: TPenStyle);
    procedure SetChartPattern(const Value: TPicture);
    procedure SetShowValue(const Value: boolean);
    procedure SetValueFormat(const Value: string);
    procedure SetValueType(const Value: TChartValueType);
    procedure SetValueWidth(const Value: integer);
    procedure SetValueWidthType(const Value: TChartSerieValueWidthType);
    procedure SetWickColor(const Value: TColor);
    procedure SetWickWidth(const Value: integer);
    procedure SetXAxis(const Value: TChartSerieXAxis);
    procedure SetYAxis(const Value: TChartSerieYAxis);
    procedure SetYScale(const Value: Double);
    procedure SetZeroLine(const Value: Boolean);
    procedure SetZeroLineColor(const Value: TColor);
    procedure SetZeroLineWidth(const Value: integer);
    procedure SetZeroReferencePoint(const Value: Double);
    procedure SetShowValueInTracker(const Value: boolean);
    procedure DrawDateTimeValues(DateTimeFormat: String; ValueIndex: integer; Canvas: TCanvas; Rect: TRect; m: integer);
    function GetChart: TAdvChart;
    procedure SetChartPatternPosition(const Value: TChartBackGroundPosition);
    procedure SetName(const Value: string);
    procedure SetBorderRounding(const Value: Integer);
    procedure SetShowAnnotationsOnTop(const Value: Boolean);
    procedure SetArrowColor(const Value: TColor);
    procedure SetArrowSize(const Value: integer);
    procedure SetValueAngle(const Value: integer);
    procedure SetValueFont(const Value: TFont);
    procedure SetReadOnly(const Value: Boolean);
    procedure SetSelectedIndex(const Value: integer);
    procedure SetSelectedColor(const Value: TColor);
    procedure SetSelectedMarkBorderColor(const Value: TColor);
    procedure SetSelectedMarkSize(const Value: integer);
    procedure SetSelectedMark(const Value: Boolean);
    procedure SetSerieType(const Value: TSerieType);
    procedure SetShowInLegend(const Value: Boolean);
    procedure SetEnable3D(const Value: Boolean);
    procedure SetOffset3D(const Value: integer);
    procedure SetDarken3D(const Value: Boolean);
    procedure SetBarShape(const Value: TChartBarShape);
    procedure SetLogarithmic(const Value: Boolean);
    procedure SetBarValueTextAlignment(const Value: TAlignment);
    procedure SetBarValueTextFont(const Value: TFont);
    procedure SetBarValueTextType(const Value: TChartBarValueTextType);
    procedure SetVisible(const Value: Boolean);
    procedure SetRangePercentMargin(const Value: Integer);
    procedure SetXAxisGroups(const Value: TChartSerieXAxisGroups);
    procedure SetXAxisGroupsVisible(const Value: Boolean);
    procedure SetGroupIndex(const Value: Integer);
    procedure SetValueFormatType(const Value: TChartValueFormatType);
    procedure SetGanttHeight(const Value: Integer);
    procedure SetGanttSpacing(const Value: Integer);
    procedure SetDrawFromStartDate(const Value: Boolean);
    procedure SetValueOffsetX(const Value: Integer);
    procedure SetValueOffsetY(const Value: Integer);
    procedure SetFunnelMode(const Value: TChartSerieFunnelMode);
    procedure SetFunnelHeight(const Value: Integer);
    procedure SetFunnelHeightType(const Value: TChartSerieFunnelSizeType);
    procedure SetFunnelWidth(const Value: Integer);
    procedure SetFunnelWidthType(const Value: TChartSerieFunnelSizeType);
    procedure SetFunnelSpacing(const Value: Integer);
    function GetFunnel: TChartSeriePie;
    procedure SetLinePointsOnly(const Value: Boolean);
  protected
    function GetFunnelRect(pbr: TRect): TRect;
    function GetMaxLevel(Level: Integer): Integer;
    function GetYMajorUnitSpacing(Right: Boolean): integer;
    function GetYMinorUnitSpacing(Right: Boolean): Integer;
    function GetXMajorUnitSpacing(Bottom: Boolean): integer;
    function GetXMinorUnitSpacing(Bottom: Boolean): Integer;
    function FindXAxisTextForValue(AValue: Double): String;
    function GetXAxisValueSize(Sender: TObject; Serie: TChartSerie; Canvas: TCanvas; ValueIndex: integer; ScaleX, ScaleY: Double;
    DrawCustomValues: Boolean;
     var defaultdraw: Boolean): Integer;
    procedure Changed; virtual;
    procedure FontChanged(Sender: TObject);
    procedure MarkerChanged(Sender: TObject);
    procedure PieChanged(Sender: TObject);
    procedure AnnotationChanged(Sender: TObject);
    procedure PictureChanged(Sender: TObject);
    procedure XAxisChanged(Sender: TObject);
    function GetPreviousGanttGroupHeight: integer;
    procedure YAxisChanged(Sender: TObject);
    procedure CrossHairYValueChanged(Sender: TObject);
    procedure CrossHairYValueFontChanged(Sender: TObject);
    procedure DrawMarker(Sender: TObject; Canvas: TCanvas; x, y, point: integer; value: TChartPoint); virtual;
    function GetDisplayName: string; override;
    property IsDrawing: boolean read FIsDrawing write FIsDrawing;
    procedure Draw(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double); virtual;
    procedure DrawPyramid(Canvas: TCanvas; SColor, SColorTo: TColor; Dr: TRect; ScaleX, ScaleY: Double; Idx: Integer; val: Double); virtual;
    procedure DrawGanttBar(Canvas: TCanvas; pt: TChartPoint; dr: TRect; ScaleX, ScaleY: Double);
    procedure DrawGanttBarRect(Canvas: TCanvas; pt: TChartPoint; dr: TRect); virtual;
    procedure DrawBar(Canvas: TCanvas; SColor, SColorTo: TColor; dr: TRect; ScaleX, ScaleY: Double; Idx: integer; Val: Double); virtual;
    procedure Draw3DBar(canvas: TCanvas; SColor, SColorTo: TColor; dr: TRect; ScaleX, ScaleY: Double); virtual;
    procedure DrawPicture(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double); virtual;
    procedure DrawXValues(Canvas: TCanvas; R: TRect; XAxisY: integer; Top: boolean; ScaleX, ScaleY: double); virtual;
    procedure DrawTotalGrid(Canvas: TCanvas; R: TRect; Center: TPoint; ScaleX, ScaleY: Double);
    procedure DrawTotalGridValues(Canvas: TCanvas; R: TRect; Center: TPoint; ScaleX, ScaleY: Double);
    procedure DrawGridCircles(Canvas: TCanvas; center: TPoint; R: TRect; YG: TChartYGrid; mu, mi, ys, ScaleX, ScaleY: Double);
    procedure DrawGridValues(Canvas: TCanvas; center: TPoint; R: TRect; Y: TChartSerieYAxis; mu, mi, ys, ScaleX, ScaleY: Double);
    procedure DrawGridValue(Canvas: TCanvas; Y: TChartSerieYAxis; Center: TPoint; Value: String; Major: Boolean); virtual;
    procedure DrawGridCircle(Canvas: TCanvas; YG: TChartYGrid; Center: TPoint; diff: integer; Major: Boolean); virtual;
    procedure DrawGridPieLine(Canvas: TCanvas; YG: TChartYGrid; Center: TPoint; x, y: integer); virtual;
    procedure DrawGridPieLineValue(Canvas: TCanvas; YG: TChartYGrid; LineIndex: Integer; AStartAngle, ASweepAngle: Double; Center: TPoint; x, y: integer); virtual;
    procedure DrawYValues(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double); virtual;
    procedure DrawMarkers(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double); virtual;
    function DrawLegend(Canvas: TCanvas; R: Trect; ScaleX, ScaleY: Double; Draw: Boolean): TRect; virtual;
    procedure DrawAnnotations(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double); virtual;
    procedure DrawTickMark(Canvas: TCanvas; x: TChartSerieXAxis; Top: Boolean; Rect: TRect; Scalex, ScaleY: Double);
    procedure DrawPieLegend(Canvas: TCanvas; x, y, width, height: integer; Scalex, ScaleY: Double); virtual;
    procedure DrawPieSlice(Canvas: TCanvas; Center:  TPoint; Radius, RadiusInner, centerh, centerv, indent: integer; StartAngle, SweepAngle: Double; PointIndex: integer; ScaleX, ScaleY: Double); virtual;
    procedure DrawFunnelPart(Canvas: TCanvas; APoints: TPointArray; APointIndex: Integer; ScaleX, ScaleY: Double); virtual;
    procedure DrawFunnelValue(Canvas: TCanvas; APoints: TPointArray; APointIndex: Integer; ScaleX, ScaleY: Double); virtual;
    procedure DrawSpiderArea(Canvas: TCanvas; R: TRect; SpiderArea: TPointArray; ScaleX, ScaleY: Double); virtual;
    procedure DrawPieValues(Canvas: TCanvas; indent: integer; Center: TPoint; radius, StartAngle, SweepAngle: Double; PointIndex: integer; ScaleX, ScaleY: Double); virtual;
    procedure DrawValues(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: double);
    procedure DrawSelected(ACanvas: TCanvas; r: TRect); virtual;
    procedure DrawSelectedSlice(ACanvas: TCanvas; ptslice: TSlicePoint); virtual;
    procedure DrawSelectedFunnel(ACanvas: TCanvas; ptFunnel: TFunnelPoint); virtual;
    procedure Draw3DPolygons(ACanvas: TCanvas; dpcfrom, dpcto: integer; dp: TPointArray; pci: integer; s: TChartSerie;
      ScaleX, ScaleY: Double);
    function GetYValuesSize(R: TRect; Canvas: TCanvas; ScaleX, ScaleY: Double): Integer;
    function GetXValuesSize(Canvas: TCanvas; ScaleX, ScaleY: Double; var totalxSize: Integer): Integer;
    function CreateAnnotations: TChartAnnotations; virtual;
    function CreatePie: TChartSeriePie; virtual;
    function CreateMarker: TChartMarker; virtual;
    property MaximumValue: double read FMaximumValue write FMaximumValue;
    property MinimumValue: double read FMinimumValue write FMinimumValue;
    procedure InitializeLineColor(Canvas: TCanvas; Scalex, ScaleY: Double);
    procedure InitializeBorderColor(Canvas: TCanvas; Scalex, ScaleY: Double);
    procedure InitializePieLegendBorderColor(Canvas: TCanvas; Scalex, ScaleY: Double);
    procedure InitializeBrushColor(Canvas: TCanvas);
    procedure InitializePieLegendBrushColor(Canvas: TCanvas);
    procedure InitializeWickColor(Canvas: TCanvas; ScaleX, ScaleY: Double);
    procedure SetFieldNameValue(const Value: string); virtual;
    procedure SetFieldNameXAxis(const Value: string); virtual;
    function IsPieChart: Boolean;
    function GetQuadrant(center: TPointF; pt: TPointF): TPieQuadrant;
    function Get3DOffset: integer;
    function IsEnabled3D: Boolean;
    function IsHalfPie: Boolean;
    //DB
    function GetDSFieldNames: TStringList; virtual;
    function IsDB: Boolean; virtual;
    property FieldNameValue: String read FFieldNameValue write SetFieldNameValue;
    property FieldNameXAxis: String read FFieldNameXAxis write SetFieldNameXAxis;
    function GetLastPoint: integer;
  public
    function SerieMax: Double;
    function SerieMin: Double;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    property SerieType: TSerieType read FSerieType write SetSerieType;
    property StackedPointsBar: TPointArray read FStackedPointsBar write FStackedPointsBar;
    property StackedPointsArea: TPointArray read FStackedPointsArea write FStackedPointsArea;
    procedure SetStackedPointsBarLength(l: integer);
    procedure SetStackedPointsAreaLength(l: integer);
    property DrawPoints: TPointArray read FDrawPoints write FDrawPoints;
    property SpiderV: TPointArray read FSpiderV write FSpiderV;
    property DrawValuesDP: TPointArray read FDrawValuesDP write FDrawValuesDP;
    property DrawValuesSlice: TPointSliceArray read FDrawValuesSlice write FDrawValuesSlice;
    property DrawValuesFunnel: TPointFunnelArray read FDrawValuesFunnel write FDrawValuesFunnel;
    procedure AssignPrivates(Source: TPersistent);
    procedure Assign(Source: TPersistent); override;
    procedure InitializeDrawPoints(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double);
    procedure SetMinMax(RangeFrom: integer; RangeTo: integer);
    procedure SetArraySize(Size: integer);
    function GetArraySize: integer;
    function PointInPie(x, y, cx, cy, sta, swa: Single): Boolean;
    function PointInFunnel(x, y: Integer; pt: TFunnelPoint): Boolean;
    property Chart: TAdvChart read GetChart;
    function GetPoint(AIndex: Integer): TChartPoint; virtual;
    function GetPointsCount: Integer; virtual;
    property Points: TChartPointArray read FPoints write FPoints;
    property CrosshairFontHeight: integer read FCrosshairFontHeight;
    procedure AddChartPoint(pt: TChartPoint);
    procedure SetSingleDateTime(SingleDateTime: TDateTime; index: integer);
    procedure SetSinglePoint(SinglePoint: double; index: integer);
    procedure RemovePoint(PointIndex: integer);
    procedure AddSinglePoint(Text: String; SingleDateTimeStart, SingleDateTimeEnd: TDateTime; Color: TColor = clWhite;
      ColorTo: TColor = clNone; BorderColor: TColor = clBlack; TextColor: TColor = clBlack; GradientDirection: TChartGradientDirection = cgdVertical); overload;
    procedure AddSinglePoint(SingleValueStart, SingleValueEnd: Double; Text: String; Color: TColor = clWhite;
      ColorTo: TColor = clNone; BorderColor: TColor = clBlack; TextColor: TColor = clBlack; GradientDirection: TChartGradientDirection = cgdVertical); overload;
    procedure AddSinglePoint(SinglePoint: double); overload;
    procedure AddSinglePoint(SinglePoint: double; Defined: Boolean); overload;
    procedure AddSinglePoint(SinglePoint: double; SingleDateTime: TDateTime); overload;
    procedure AddSinglePoint(SinglePoint: double; SingleDateTime: TDateTime; Defined: Boolean); overload;
    procedure AddSinglePoint(SinglePoint: double; Color: TColor); overload;
    procedure AddSinglePoint(SinglePoint: double; Color: TColor; Defined: Boolean); overload;
    procedure AddSinglePoint(SinglePoint: double; SingleDateTime: TDateTime; Color: TColor); overload;
    procedure AddSinglePoint(SinglePoint: double; SingleDateTime: TDateTime; Color: TColor; Defined: Boolean); overload;
    procedure AddSinglePoint(SinglePoint: double; XAxisValue: String); overload;
    procedure AddSinglePoint(SinglePoint: double; Defined: Boolean; XAxisValue: String); overload;
    procedure AddSinglePoint(SinglePoint: double; SingleDateTime: TDateTime; XAxisValue: String); overload;
    procedure AddSinglePoint(SinglePoint: double; SingleDateTime: TDateTime; Defined: Boolean; XAxisValue: String); overload;
    procedure AddSinglePoint(SinglePoint: double; Color: TColor; XAxisValue: String); overload;
    procedure AddSinglePoint(SinglePoint: double; Color: TColor; Defined: Boolean; XAxisValue: String); overload;
    procedure AddSinglePoint(SinglePoint: double; SingleDateTime: TDateTime; Color: TColor; XAxisValue: String); overload;
    procedure AddSinglePoint(SinglePoint: double; SingleDateTime: TDateTime; Color: TColor; Defined: Boolean; XAxisValue: String); overload;
    procedure AddSinglePoint(SinglePoint: double; Color: TColor; ColorTo: TColor; XAxisValue: String); overload;
    procedure AddSingleXYPoint(SingleXPoint, SingleYPoint: double); overload;
    procedure AddSingleXYPoint(SingleXPoint, SingleYPoint: double; Defined: Boolean); overload;
    procedure AddSingleXYPoint(SingleXPoint, SingleYPoint: double; SingleDateTime: TDateTime); overload;
    procedure AddSingleXYPoint(SingleXPoint, SingleYPoint: double; SingleDateTime: TDateTime; Defined: Boolean); overload;
    procedure AddSingleXYPoint(SingleXPoint, SingleYPoint: double; SingleDateTime, SingleXDateTime: TDateTime); overload;
    procedure AddSingleXYPoint(SingleXPoint, SingleYPoint: double; SingleDateTime, SingleXDateTime: TDateTime; Defined: Boolean); overload;
    procedure AddSingleXYPoint(SingleXPoint, SingleYPoint: double; Color: TColor); overload;
    procedure AddSingleXYPoint(SingleXPoint, SingleYPoint: double; Color: TColor; Defined: Boolean); overload;
    procedure AddSingleXYPoint(SingleXPoint, SingleYPoint: double; SingleDateTime: TDateTime; Color: TColor); overload;
    procedure AddSingleXYPoint(SingleXPoint, SingleYPoint: double; SingleDateTime: TDateTime; Color: TColor; Defined: Boolean); overload;
    procedure AddSingleXYPoint(SingleXPoint, SingleYPoint: double; SingleDateTime, SingleXDateTime: TDateTime; Color: TColor); overload;
    procedure AddSingleXYPoint(SingleXPoint, SingleYPoint: double; SingleDateTime, SingleXDateTime: TDateTime; Color: TColor; Defined: Boolean); overload;
    procedure AddSingleXYPoint(SingleXPoint, SingleYPoint: double; XAxisValue: String); overload;
    procedure AddSingleXYPoint(SingleXPoint, SingleYPoint: double; Defined: Boolean; XAxisValue: String); overload;
    procedure AddSingleXYPoint(SingleXPoint, SingleYPoint: double; SingleDateTime: TDateTime; XAxisValue: String); overload;
    procedure AddSingleXYPoint(SingleXPoint, SingleYPoint: double; SingleDateTime: TDateTime; Defined: Boolean; XAxisValue: String); overload;
    procedure AddSingleXYPoint(SingleXPoint, SingleYPoint: double; SingleDateTime, SingleXDateTime: TDateTime; XAxisValue: String); overload;
    procedure AddSingleXYPoint(SingleXPoint, SingleYPoint: double; SingleDateTime, SingleXDateTime: TDateTime; Defined: Boolean; XAxisValue: String); overload;
    procedure AddSingleXYPoint(SingleXPoint, SingleYPoint: double; Color: TColor; XAxisValue: String); overload;
    procedure AddSingleXYPoint(SingleXPoint, SingleYPoint: double; Color: TColor; Defined: Boolean; XAxisValue: String); overload;
    procedure AddSingleXYPoint(SingleXPoint, SingleYPoint: double; SingleDateTime: TDateTime; Color: TColor; XAxisValue: String); overload;
    procedure AddSingleXYPoint(SingleXPoint, SingleYPoint: double; SingleDateTime: TDateTime; Color: TColor; Defined: Boolean; XAxisValue: String); overload;
    procedure AddSingleXYPoint(SingleXPoint, SingleYPoint: double; SingleDateTime, SingleXDateTime: TDateTime; Color: TColor; XAxisValue: String); overload;
    procedure AddSingleXYPoint(SingleXPoint, SingleYPoint: double; SingleDateTime, SingleXDateTime: TDateTime; Color: TColor; Defined: Boolean; XAxisValue: String); overload;
    procedure AddSingleXYPoint(SingleXPoint, SingleYPoint: double; Color: TColor; ColorTo: TColor; XAxisValue: String); overload;

    procedure AddDoublePoint(FirstPoint, SecondPoint: double; XAxisValue: String); overload;
    procedure AddDoublePoint(FirstPoint, SecondPoint: double); overload;
    procedure AddDoublePoint(FirstPoint, SecondPoint: double; Defined: Boolean); overload;
    procedure AddDoublePoint(FirstPoint, SecondPoint: double; SingleDateTime: TDateTime); overload;
    procedure AddDoublePoint(FirstPoint, SecondPoint: double; SingleDateTime: TDateTime; Defined: Boolean); overload;
    procedure AddDoublePoint(FirstPoint, SecondPoint: double; Color: TColor); overload;
    procedure AddDoublePoint(FirstPoint, SecondPoint: double; Color: TColor; Defined: Boolean); overload;
    procedure AddDoublePoint(FirstPoint, SecondPoint: double; SingleDateTime: TDateTime; Color: TColor); overload;
    procedure AddDoublePoint(FirstPoint, SecondPoint: double; SingleDateTime: TDateTime; Color: TColor; Defined: Boolean); overload;
    procedure AddDoubleXYPoint(SingleXPoint, FirstPoint, SecondPoint: double; XAxisValue: String); overload;
    procedure AddDoubleXYPoint(SingleXPoint, FirstPoint, SecondPoint: double); overload;
    procedure AddDoubleXYPoint(SingleXPoint, FirstPoint, SecondPoint: double; Defined: Boolean); overload;
    procedure AddDoubleXYPoint(SingleXPoint, FirstPoint, SecondPoint: double; SingleDateTime: TDateTime); overload;
    procedure AddDoubleXYPoint(SingleXPoint, FirstPoint, SecondPoint: double; SingleDateTime: TDateTime; Defined: Boolean); overload;
    procedure AddDoubleXYPoint(SingleXPoint, FirstPoint, SecondPoint: double; Color: TColor); overload;
    procedure AddDoubleXYPoint(SingleXPoint, FirstPoint, SecondPoint: double; Color: TColor; Defined: Boolean); overload;
    procedure AddDoubleXYPoint(SingleXPoint, FirstPoint, SecondPoint: double; SingleDateTime: TDateTime; Color: TColor); overload;
    procedure AddDoubleXYPoint(SingleXPoint, FirstPoint, SecondPoint: double; SingleDateTime: TDateTime; Color: TColor; Defined: Boolean); overload;
    procedure ClearPoints;
    procedure SetMultiPoints(HighPoint, LowPoint, OpenPoint, ClosePoint: Double; index: integer);
    procedure AddPoints(SinglePoint: Double; PixelValue: integer); overload;
    procedure AddPiePoints(SinglePoint: Double; Color: TColor = clNone; ColorTo: TColor = clNone; PieIndent: integer = 0; Defined: Boolean = true); overload;
    procedure AddPiePoints(SinglePoint: Double; legendvalue: String = ''; Color: TColor = clNone; ColorTo: TColor = clNone; PieIndent: integer = 0; Defined: Boolean = true); overload;
    procedure AddPiePoints(SinglePoint, RadiusValue: Double; legendvalue: String = ''; Color: TColor = clNone; ColorTo: TColor = clNone; PieIndent: integer = 0; Defined: Boolean = true); overload;
    procedure AddPiePoints(SinglePoint, RadiusValue: Double; Color: TColor = clNone; ColorTo: TColor = clNone; PieIndent: integer = 0; Defined: Boolean = true); overload;
    procedure AddPoints(SinglePoint: Double; PixelValue1, PixelValue2: integer); overload;
    procedure AddPoints(SinglePoint: Double; PixelValue1, PixelValue2: integer; Defined: Boolean); overload;
    procedure AddPoints(SinglePoint: Double; PixelValue1, PixelValue2: integer; SingleDateTime: TDateTime); overload;
    procedure AddPoints(SinglePoint: Double; PixelValue1, PixelValue2: integer; SingleDateTime: TDateTime; Defined: Boolean); overload;
    procedure AddMultiPoints(HighPoint, LowPoint, OpenPoint, ClosePoint: Double; XAxisValue: String); overload;
    procedure AddMultiPoints(HighPoint, LowPoint, OpenPoint, ClosePoint: Double); overload;
    procedure AddMultiPoints(HighPoint, LowPoint, OpenPoint, ClosePoint: Double; Defined: Boolean); overload;
    procedure AddMultiPoints(HighPoint, LowPoint, OpenPoint, ClosePoint: Double; SingleDateTime: TDateTime); overload;
    procedure AddMultiPoints(HighPoint, LowPoint, OpenPoint, ClosePoint: Double; SingleDateTime: TDateTime; Defined: Boolean); overload;
    procedure AddMultiPoints(HighPoint, LowPoint, OpenPoint, ClosePoint: Double; Color: TColor); overload;
    procedure AddMultiPoints(HighPoint, LowPoint, OpenPoint, ClosePoint: Double; Color: TColor; Defined: Boolean); overload;
    procedure AddMultiPoints(HighPoint, LowPoint, OpenPoint, ClosePoint: Double; SingleDateTime: TDateTime; Color: TColor); overload;
    procedure AddMultiPoints(HighPoint, LowPoint, OpenPoint, ClosePoint: Double; SingleDateTime: TDateTime; Color: TColor; Defined: Boolean); overload;

    procedure AddMultiPoints(Minimum, Q1, Median, Q3, Maximum: Double; XAxisValue: String); overload;
    procedure AddMultiPoints(Minimum, Q1, Median, Q3, Maximum: Double; Defined: Boolean); overload;
    procedure AddMultiPoints(Minimum, Q1, Median, Q3, Maximum: Double; SingleDateTime: TDateTime); overload;
    procedure AddMultiPoints(Minimum, Q1, Median, Q3, Maximum: Double; SingleDateTime: TDateTime; Defined: Boolean); overload;
    procedure AddMultiPoints(Minimum, Q1, Median, Q3, Maximum: Double; Color: TColor); overload;
    procedure AddMultiPoints(Minimum, Q1, Median, Q3, Maximum: Double; Color: TColor; Defined: Boolean); overload;
    procedure AddMultiPoints(Minimum, Q1, Median, Q3, Maximum: Double; SingleDateTime: TDateTime; Color: TColor); overload;
    procedure AddMultiPoints(Minimum, Q1, Median, Q3, Maximum: Double; SingleDateTime: TDateTime; Color: TColor; Defined: Boolean); overload;
    function GetXTimeStamp(ValueIndex: Integer): TDateTime;
    function ConvertDateToXDate(Date: TDateTime): TDateTime;
    procedure Init(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double);
    procedure XaxisDrawValue(Sender: TObject; Serie: TChartserie; Canvas: TCanvas; ARect: TRect; XAxisY, ValueIndex,
      XMarker: integer; Top: Boolean; ScaleX, ScaleY: Double; DrawCustomValues: Boolean; var defaultdraw: Boolean);
    function GetBarWidth(ScaleX: Double): integer;
    function GetHistogramBarWidth(ScaleX: Double): integer;
    function GetStackedTotal(I: Integer): Double;
    function GetStackedPercValue(sv: Double; I: integer): Double;
    function GetStackedValueString(i: integer): String;
    function GetStackedValue(i: integer): Double;
    function GetPrevSerieStackedValue(PointIndex: integer): Double;
    function GetTotalSeriesValuePyramid(i: integer): Double;
    function GetNextValuePyramid(idx: integer; i: integer): Double;
    function GetPercentageValue(SingleValue: Double): String;
    function GetChartPoint(Index: integer): TChartPoint;
    function GetXYPoint(X, Y: integer): Integer;
    function GetChartPointFromDrawPoint(Index: integer): TChartPoint;
    function GetTotalPoints: Double;
    function GetMaxPoints: Double;
    function GetPieRectangle(Index: integer; R: TRect): TRect;
    function GetPieCenter(pbr: TRect): TPoint;
    function GetLegendCenter(pbr: TRect; width, height: integer): TPoint;
    function GetDrawPoint(Index: integer): TPoint;
    function GetAngle(Text: TChartXYAxisText): integer;
    function ValueToY(value: double; R: TRect): integer;
    function YToValue(value: integer; R: TRect): double;
    function ValueToX(value: double; R: TRect): integer;
    function XToValue(value: integer; R: TRect): double;
    property YScale: Double read FYScale write SetYScale;
    property OldYScale: Double read FOldYScale write SetOldYScale;
    property OriginalYScale: Double read FOriginalYScale write SetOriginalYScale;
    property OffSet: Double read FOffSet write SetOffset;
    procedure MoveTo(SerieIndex: integer);
    function GetMaximumValue: Double;
    property Funnel: TChartSeriePie read GetFunnel;
    property MaximumPoints: integer read FMaximumPoints write FMaximumPoints default -1;
    property UseFullRange: Boolean read FUseFullRange write FUseFullRange default False;
    //Settings
    procedure SaveToFile(ini: TMemIniFile;Section: String); virtual;
    procedure LoadFromFile(ini: TMemIniFile;Section: String); virtual;
    property ReadOnly: Boolean read FReadOnly write SetReadOnly default false;
  published
    property Tag: Integer read FTag write FTag default 0;
    property DrawFromStartDate: Boolean read FDrawFromStartDate write SetDrawFromStartDate default True;
    property ArrowColor: TColor read FArrowColor write SetArrowColor default clNone;
    property ArrowSize: integer read FArrowSize write SetArrowSize default 10;
    property AutoRange: TChartSerieAutoRange read FAutoRange write SetAutoRange default arEnabled;
    property RangePercentMargin: Integer read FRangePercentMargin write SetRangePercentMargin default 5;
    property Pie: TChartSeriePie read FPie write FPie;
    property Annotations: TChartAnnotations read FAnnotations write FAnnotations;
    property ChartPatternPosition: TChartBackGroundPosition read FChartPatternPosition write SetChartPatternPosition default bpTopLeft;
    property BorderWidth: integer read FBorderWidth write SetBorderWidth default 1;
    property BorderColor: TColor read FBorderColor write SetBorderColor default clBlack;
    property BorderRounding: Integer read FBorderRounding write SetBorderRounding default 0;
    property BrushStyle: TBrushStyle read FBrushStyle write SetBrushStyle default bsSolid;
    property ChartType: TChartType read FChartType write SetChartType default ctLine;
    property GroupIndex: Integer read FGroupIndex write SetGroupIndex default 0;
    property Color: TColor read FColor write SetColor default clRed;
    property ColorTo: TColor read FColorTo write SetColorTo default clNone;
    property CandleColorDecrease: TColor read FCandleColorDecrease write SetCandleColorDecrease default clRed;
    property CandleColorIncrease: TColor read FCandleColorIncrease write SetCandleColorIncrease default clGreen;
    property CrossHairYValue: TChartSerieCrossHairYValue read FCrossHairYValue write SetCrossHairYValue;
    property GradientSteps: integer read FGradientSteps write SetGradientSteps default 100;
    property GradientDirection: TChartGradientDirection read FGradientDirection write SetGradientDirection default cgdHorizontal;
    property LineColor: TColor read FLineColor write SetLineColor default clRed;
    property LineWidth: Integer read FLineWidth write SetLineWidth default 1;
    property LinePointsOnly: Boolean read FLinePointsOnly write SetLinePointsOnly default False;
    property LegendText: string read FLegendText write SetLegendText;
    property ShowInLegend: Boolean read FShowInLegend write SetShowInLegend default true;
    property Marker: TChartMarker read FMarker write FMarker;
    property Maximum: double read FMax write SetMax;
    property Minimum: double read FMin write SetMin;
    property Name: string read FName write SetName;
    property PenStyle: TPenStyle read FPenStyle write SetPenStyle default psSolid;
    property ChartPattern: TPicture read FChartPattern write SetChartPattern;
    property ShowValue: boolean read FShowValue write SetShowValue default false;
    property ShowValueInTracker: boolean read FShowValueInTracker write SetShowValueInTracker default true;
    property ShowAnnotationsOnTop: Boolean read FShowAnnotationsOnTop write SetShowAnnotationsOnTop default false;
    property ValueFont: TFont read FValueFont write SetValueFont;
    property ValueAngle: integer read FValueAngle write SetValueAngle default 0;
    property ValueFormat: string read FValueFormat write SetValueFormat;
    property ValueType: TChartValueType read FValueType write SetValueType default cvNormal;
    property ValueFormatType: TChartValueFormatType read FValueFormatType write SetValueFormatType default vftNormal;
    property ValueWidth: integer read FValueWidth write SetValueWidth default 50;
    property ValueWidthType: TChartSerieValueWidthType read FValueWidthType write SetValueWidthType default wtPercentage;
    property ValueOffsetX: Integer read FValueOffsetX write SetValueOffsetX default 0;
    property ValueOffsetY: Integer read FValueOffsetY write SetValueOffsetY default 0;
    property WickColor: TColor read FWickColor write SetWickColor default clBlack;
    property WickWidth: integer read FWickWidth write SetWickWidth default 1;
    property XAxis: TChartSerieXAxis read FXAxis write SetXAxis;
    property YAxis: TChartSerieYAxis read FYAxis write SetYAxis;
    property ZeroLine: Boolean read FZeroLine write SetZeroLine default false;
    property ZeroLineWidth: integer read FZeroLineWidth write SetZeroLineWidth default 1;
    property ZeroLineColor: TColor read FZeroLineColor write SetZeroLineColor default clNone;
    property ZeroReferencePoint: Double read FZeroReferencePoint write SetZeroReferencePoint;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnSerieSliceGetValue: TChartSerieSliceGetValue read FOnSerieSliceGetValue write FOnSerieSliceGetValue;
    property OnSerieDrawPoint: TChartSerieDrawPoint read FOnSerieDrawPoint write FOnSerieDrawPoint;
    property OnXAxisDrawValue: TChartXAxisDrawValue read FOnXAxisDrawValue write FOnXAxisDrawValue;
    property OnXAxisGetValue: TChartAxisGetValue read FOnXAxisGetValue write FOnXAxisGetValue;
    property OnXAxisDrawXValue: TChartXAxisDrawValue read FOnXAxisDrawXValue write FOnXAxisDrawXValue;
    property OnXAxisGetXValue: TChartAxisGetValue read FOnXAxisGetXValue write FOnXAxisGetXValue;
    property OnYAxisDrawvalue: TChartYAxisDrawValue read FOnYAxisDrawValue write FOnYAxisDrawValue;
    property OnYAxisGetValue: TChartAxisGetValue read FOnYAxisGetValue write FOnYAxisGetValue;
    property OnMarkerDrawValue: TChartMarkerDrawEvent read FOnMarkerDrawValue write FOnMarkerDrawValue;
    property OnGetBarValueText: TChartGetBarValueTextEvent read FOnGetBarValueText write FOnGetBarValueText;
    property OnSerieMouseDown: TChartSerieMouseEvent read FOnSerieMouseDown write FOnSerieMouseDown;
    property OnSerieMouseUp: TChartSerieMouseEvent read FOnSerieMouseUp write FOnSerieMouseUp;
    property SelectedIndex: integer read FSelectedIndex write SetSelectedIndex default -1;
    property SelectedMark: Boolean read FSelectedMark write SetSelectedMark default false;
    property SelectedMarkColor: TColor read FSelectedColor write SetSelectedColor default clLime;
    property SelectedMarkBorderColor: TColor read FSelectedMarkBorderColor write SetSelectedMarkBorderColor default clBlack;
    property SelectedMarkSize: integer read FSelectedMarkSize write SetSelectedMarkSize default 8;
    property Enable3D: Boolean read FEnable3D write SetEnable3D default false;
    property Darken3D: Boolean read FDarken3D write SetDarken3D default true;
    property Offset3D: integer read FOffset3D write SetOffset3D default 20;
    property BarShape: TChartBarShape read FBarShape write SetBarShape default bsRectangle;
    property Logarithmic: Boolean read FLogarithmic write SetLogarithmic default false;
    property BarValueTextFont: TFont read FBarValueTextFont write SetBarValueTextFont;
    property BarValueTextAlignment: TAlignment read FBarValueTextAlignment write SetBarValueTextAlignment default taLeftJustify;
    property BarValueTextType: TChartBarValueTextType read FBarValueTextType write SetBarValueTextType default btCustomValue;
    property Visible: Boolean read FVisible write SetVisible default true;
    property XAxisGroups: TChartSerieXAxisGroups read FXAxisGroups write SetXAxisGroups;
    property XAxisGroupsVisible: Boolean read FXAxisGroupsVisible write SetXAxisGroupsVisible default True;
    property GanttHeight: Integer read FGanttHeight write SetGanttHeight default 25;
    property GanttSpacing: Integer read FGanttSpacing write SetGanttSpacing default 20;
    property FunnelMode: TChartSerieFunnelMode read FFunnelMode write SetFunnelMode default fmHeight;
    property FunnelSpacing: Integer read FFunnelSpacing write SetFunnelSpacing default 0;
    property FunnelWidth: Integer read FFunnelWidth write SetFunnelWidth default 80;
    property FunnelHeight: Integer read FFunnelHeight write SetFunnelHeight default 80;
    property FunnelWidthType: TChartSerieFunnelSizeType read FFunnelWidthType write SetFunnelWidthType default fstPercentage;
    property FunnelHeightType: TChartSerieFunnelSizeType read FFunnelHeightType write SetFunnelHeightType default fstPercentage;
  end;

  TChartSeriesDonutMode = (dmNormal, dmStacked);

  TChartDrawingMode = (dmVertical, dmHorizontal);

  TChartSeries = class(TOwnedCollection)
  private
    FMode: TChartMode;
    FSerieValueTotals: Boolean;
    FDonutMode: TChartSeriesDonutMode;
    FOnChange: TNotifyEvent;
    FOwner: TAdvChart;
    FSeriesRectangle: TRect;
    FcntBar: integer;
    FBarChartSpacing: integer;
    FBarChartSpacingType: TChartSerieValueWidthType;
    FChartMode: TChartDrawingMode;
    function GetItem(Index: Integer): TChartSerie;
    procedure SetItem(Index: Integer; Value: TChartSerie);
    procedure SetSerieValueTotals(const Value: Boolean);
    procedure SetDonutMode(const Value: TChartSeriesDonutMode);
    procedure SetBarChartSpacing(const Value: integer);
    procedure SetBarChartSpacingType(const Value: TChartSerieValueWidthType);
    procedure SetChartMode(const Value: TChartDrawingMode);
    function GetSeriesRectangle: TRect;
  protected
    procedure Changed; virtual;
    procedure SerieChanged(Sender: TObject);
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AOwner: TAdvChart);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function GetItemClass: TCollectionItemClass; virtual;
    procedure ForceInit(Force: Boolean);
    procedure Draw(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double; HRGN: THandle);
    procedure DrawXValues(Canvas: TCanvas; R: TRect; Top: boolean; ScaleX, ScaleY: Double);
    procedure DrawYValues(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double);
    procedure DrawMarkers(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double);
    procedure DrawAnnotations(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double);
    procedure DrawPieLegends(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double);
    procedure DrawChartValues(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double);
    function Add:TChartSerie;
    function Insert(index:integer): TChartSerie;
    property Items[Index: Integer]: TChartSerie read GetItem write SetItem; default;
    property Mode: TChartMode read FMode write FMode;
    property SeriesRectangle: TRect read GetSeriesRectangle write FSeriesRectangle;
    //Settings
    procedure SaveToFile(ini: TMemIniFile;Section: String); virtual;
    procedure LoadFromFile(ini: TMemIniFile;Section: String; AutoCreateSeries: Boolean = False); virtual;
    function GetCountChartType(ChartType: TChartType): integer;
    function GetCountGroupedChartType(ChartType: TChartType): integer;
    function GetPreviousChartIndex(ChartType: TChartType; Index: Integer; GroupIndex: Integer): integer;
    function IsHorizontal: Boolean;
  published
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property SerieValueTotals: Boolean read FSerieValueTotals write SetSerieValueTotals default false;
    property DonutMode: TChartSeriesDonutMode read FDonutMode write SetDonutMode default dmNormal;
    property ChartMode: TChartDrawingMode read FChartMode write SetChartMode default dmVertical;
    property BarChartSpacing: integer read FBarChartSpacing write SetBarChartSpacing default 20;
    property BarChartSpacingType: TChartSerieValueWidthType read FBarChartSpacingType write SetBarChartSpacingType default wtPercentage;
  end;

  TChartSeriePointType = (cspYPos, cspSerie);

  TSeriePoint = record
    Point: integer;
    YValue: double;
    Serie: integer;
    XValueAtCursor, XValueAtTracker, XValueYAxis: double;
    PointType: TChartSeriePointType;
    SerieValue: double;
  end;

  TChartCrossHairYValuePositionType = (chYAxis, chAtCursor, chValueTracker);

  TChartCrossHairYValuePosition = set of TChartCrossHairYValuePositionType;

  TChartCrossHairYValues = class(TPersistent)
  private
    FShowSerieValues: Boolean;
    FShowYPosValue: Boolean;
    FPosition: TChartCrossHairYValuePosition;
    FOnChange: TNotifyEvent;
    procedure SetPosition(const Value: TChartCrossHairYValuePosition);
    procedure SetShowSerieValues(const Value: Boolean);
    procedure SetShowYPosValue(const Value: Boolean);
  protected
    procedure Changed; virtual;
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
    //Settings
    procedure SaveToFile(ini: TMemIniFile;Section: String);
    procedure LoadFromFile(ini: TMemIniFile;Section: String);
  published
    property ShowSerieValues: Boolean read FShowSerieValues write SetShowSerieValues default true;
    property ShowYPosValue: Boolean read FShowYPosValue write SetShowYPosValue default false;
    property Position: TChartCrossHairYValuePosition read FPosition write SetPosition;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TChartCrossHairType = (chtNone, chtSmallCrossHair, chtFullSizeCrossHairAtCursor, chtFullSizeCrossHairAtSeries);

  TChartCrossHair = class(TPersistent)
  private
    FDistance: integer;
    FCrossHairType: TChartCrossHairType;
    FCrossHairYValues: TChartCrossHairYValues;
    FOnChange: TNotifyEvent;
    FOwner: TAdvChart;
    FLineColor: TColor;
    FLineWidth: integer;
    FVisible: Boolean;
    procedure SetCrossHairType(const Value: TChartCrossHairType);
    procedure SetCrossHairYValues(const Value: TChartCrossHairYValues);
    procedure SetDistance(const Value: integer);
    procedure SetLineColor(const Value: TColor);
    procedure SetLineWidth(const Value: integer);
    procedure SetVisible(const Value: Boolean);
  protected
    procedure Changed; virtual;
    procedure CrossHairYValuesChanged(Sender: TObject);
  public
    constructor Create(AOwner: TAdvChart);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Draw(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double); virtual;
    //Settings
    procedure SaveToFile(ini: TMemIniFile;Section: String);
    procedure LoadFromFile(ini: TMemIniFile;Section: String);
  published
    property CrossHairType: TChartCrossHairType read FCrossHairType write SetCrossHairType default chtFullSizeCrossHairAtSeries;
    property CrossHairYValues: TChartCrossHairYValues read FCrossHairYValues write SetCrossHairYValues;
    property Distance: integer read FDistance write SetDistance default CrossHairDistance;
    property LineWidth: integer read FLineWidth write SetLineWidth default 1;
    property LineColor: TColor read FLineColor write SetLineColor default clNone;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Visible: Boolean read FVisible write SetVisible default false;
  end;

  TChartMargin = class(TPersistent)
  private
    FBottomMargin: integer;
    FLeftMargin: integer;
    FOnChange: TNotifyEvent;
    FOwner: TAdvChart;
    FRightMargin: integer;
    FTopMargin: integer;
    procedure SetBottomMargin(const Value: integer);
    procedure SetLeftMargin(const Value: integer);
    procedure SetRightMargin(const Value: integer);
    procedure SetTopMargin(const Value: integer);
  protected
    procedure Changed; virtual;
  public
    constructor Create(AOwner: TAdvChart);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    //Settings
    procedure SaveToFile(ini: TMemIniFile;Section: String);
    procedure LoadFromFile(ini: TMemIniFile;Section: String);
  published
    property BottomMargin: integer read FBottomMargin write SetBottomMargin default 0;
    property LeftMargin: integer read FLeftMargin write SetLeftMargin default 0;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property RightMargin: integer read FRightMargin write SetRightMargin default 0;
    property TopMargin: integer read FTopMargin write SetTopMargin default 0;
  end;

  TChartAxisMode = (amXAxisFullWidth, amYAxisFullHeight, amAxisChartWidthHeight);

  TXAxisRangeValue = record
    RangeIndex: Integer;
    Serie: Integer;
  end;

  TYAxisRangeValueMode = (vmMajor, vmMinor);

  TYAxisRangeValue = record
    Serie: Integer;
    ValueStr: String;
    Mode: TYAxisRangeValueMode;
    Value: Double;
  end;

  TChartPaneRectangle = procedure(Chart: TAdvChart; var PaneRect: TRect) of object;

  TChartGetCountChartType = procedure(Sender: TObject; AChartType: TChartType; var ACount: Integer) of object;
  TChartDrawGridPieLineValue = procedure(Sender: TObject; ASerie: TChartSerie; ACanvas: TCanvas; ALineIndex: Integer; AStartAngle, ASweepAngle: Double; ACenter: TPoint; AX, AY: Integer) of object;
  TChartGetGridPieLineValue = procedure(Sender: TObject; ASerie: TChartSerie; ALineIndex: Integer; AStartAngle, ASweepAngle: Double; var AGridPieLineValue: String) of object;

  TAdvChart = class(TPersistent)
  private
    FAxisMode: TChartAxisMode;
    FGDIPDrawing: Boolean;
    FBackground: TChartBackground;
    FBands: TChartBands;
    FCrossHair: TChartCrossHair;
    FForceInitYScale: boolean;
    FMargin: TChartMargin;
    FNavigator: TChartNavigator;
    FLegend: TChartLegend;
    FOnChange: TNotifyEvent;
    FOwner: TPersistent;
    FPointValue: TSeriePoint;
    FRange: TChartRange;
    FSerieMinValue: double;
    FSerieMaxValue: double;
    FSeries: TChartSeries;
    FTitle: TChartTitle;
    FXAxis: TChartXAxis;
    FXGrid: TChartXGrid;
    FXScale: double;
    FYAxis: TChartYAxis;
    FYGrid: TChartYGrid;
    FUpdateCount: Integer;
    FOnDrawBackGround: TChartDrawEvent;
    FOnDrawTitle: TChartDrawEvent;
    FOnDrawXGrid: TChartDrawEvent;
    FOnDrawNavigator: TChartDrawEvent;
    FOnDrawLegend: TChartDrawEvent;
    FOnDrawXValues: TChartDrawEvent;
    FOnDrawYValues: TChartDrawEvent;
    FOnDrawYGrid: TChartDrawEvent;
    FOnDrawSeries: TChartDrawEvent;
    FOnDrawXAxis: TChartDrawEvent;
    FOnDrawYAxis: TChartDrawEvent;
    FGetPaneRectangle: TChartPaneRectangle;
    FOnSerieXAxisGroup: TChartSerieXAxisCustomGroupEvent;
    FXScaleOffset: Boolean;
    FOnGetCountChartType: TChartGetCountChartType;
    FOnGetCountGroupedChartType: TChartGetCountChartType;
    FOnAfterDrawSeries: TChartDrawEvent;
    FOnBeforeDrawSeries: TChartDrawEvent;
    FOnDrawGridPieLineValue: TChartDrawGridPieLineValue;
    FOnGetGridPieLineValue: TChartGetGridPieLineValue;
    FOnGetNumberOfPoints: TChartSerieGetNumberOfPoints;
    FOnGetPoint: TChartSerieGetPoint;
    procedure SetXScale(const Value: double);
    procedure SetAxisMode(const Value: TChartAxisMode);
    procedure SetXScaleOffset(const Value: Boolean);
  protected
    procedure RangeChanged(Sender: TObject);
    procedure XAxisChanged(Sender: TObject);
    procedure YAxisChanged(Sender: TObject);
    procedure XGridChanged(Sender: TObject);
    procedure YGridChanged(Sender: TObject);
    procedure BackgroundChanged(Sender: TObject);
    procedure SeriesChanged(Sender: TObject);
    procedure MarginChanged(Sender: TObject);
    procedure BandsChanged(Sender: TObject);
    procedure LegendChanged(Sender: TObject);
    procedure TitleChanged(Sender: TObject);
    procedure CrossHairChanged(Sender: TObject);
    procedure NavigatorChanged(Sender: TObject);
    procedure Changed; virtual;
    function CreateLegend: TChartLegend; virtual;
    function CreateBackground: TChartBackground; virtual;
    function CreateSeries: TChartSeries; virtual;
    procedure SaveChart(c: TCanvas; R: TRect);
    procedure FindInterSection(p1, p2, p3, p4: TPoint; var ptchk: TPointCheck); virtual;
    procedure DoGetNumberOfPoints(Serie: Integer; var ANumberOfPoints: Integer); virtual;
    procedure DoGetPoint(Serie: Integer; AIndex: Integer; var APoint: TChartPoint); virtual;
    function GetMax3DOffset: integer;
    function GetXAxisTopRect(R: TRect): TRect;
    function GetXAxisBottomRect(R: TRect): TRect;
    function GetYAxisRect(R: TRect): TRect;
  public
    function GetXScaleStart: Double;
    procedure SaveToImage(Filename: String; ImageWidth, ImageHeigth: integer);
    constructor Create(AOwner: TPersistent);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure CalculateYScale(R: TRect; ScaleX, ScaleY: Double);
    procedure DrawZeroLine(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double);
    procedure Initialize(Canvas: TCanvas; R:TRect; ScaleX, ScaleY: Double);
    procedure SetMinMax;
    procedure InitializeChart(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double);
    function SeriesRectangle(R: TRect; ScaleX, ScaleY: Double): TRect;
    function Draw(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double; Initialize: Boolean = false): TRect; virtual;
    procedure DrawXAxis(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double); virtual;
    property ForceInitYScale: boolean read FForceInitYScale write FForceInitYScale;
    property Owner: TPersistent read FOwner;
    property PointValue: TSeriePoint read FPointValue write FPointValue;
    property XScale: double read FXScale write SetXScale;
    property GDIPDrawing: Boolean read FGDIPDrawing write FGDIPDrawing;
    procedure BeginUpdate;
    procedure EndUpdate(Canvas: TCanvas; R: TRect);
    procedure ResetUpdate;
    function XYToSeriePoint(X, Y: Integer): TChartSeriePoint;
    function GetLegendItemAtXY(X, Y: Integer): TChartSerie;
    function GetPieLegendItemAtXY(X, Y: Integer): TChartSeriePoint;
    function GetSerieIndexAtXY(X, Y: Integer): TChartSeriePoint;
    function GetXAxisValue(X, Y: Integer; R: TRect): TXAxisRangeValue;
    function GetYAxisValue(X, Y: Integer; R: TRect): TYAxisRangeValue;
    function GetTotalYAxisLeftSize: Integer;
    function GetTotalYAxisRightSize: Integer;
    function GetTotalYAxisSize(R: TRect; Right: Boolean): Integer;
    function GetTotalXAxisSize(R: TRect; Bottom: Boolean): Integer;
    property GetPaneRectangle: TChartPaneRectangle read FGetPaneRectangle write FGetPaneRectangle;
  published
    property AxisMode: TChartAxisMode read FAxisMode write SetAxisMode;
    property BackGround: TChartBackground read FBackground write FBackground;
    property Bands: TChartBands read FBands write FBands;
    property CrossHair: TChartCrossHair read FCrossHair write FCrossHair;
    property Margin: TChartMargin read FMargin write FMargin;
    property Legend: TChartLegend read FLegend write FLegend;
    property Navigator: TChartNavigator read FNavigator write FNavigator;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Range: TChartRange read FRange write FRange;
    property Series: TChartSeries read FSeries write FSeries;
    property Title: TChartTitle read FTitle write FTitle;
    property XAxis: TChartXAxis read FXAxis write FXAxis;
    property XGrid: TChartXGrid read FXGrid write FXGrid;
    property YAxis: TChartYAxis read FYAxis write FYAxis;
    property YGrid: TChartYGrid read FYGrid write FYGrid;

    property OnDrawGridPieLineValue: TChartDrawGridPieLineValue read FOnDrawGridPieLineValue write FOnDrawGridPieLineValue;
    property OnGetGridPieLineValue: TChartGetGridPieLineValue read FOnGetGridPieLineValue write FOnGetGridPieLineValue;
    property OnBeforeDrawSeries: TChartDrawEvent read FOnBeforeDrawSeries write FOnBeforeDrawSeries;
    property OnAfterDrawSeries: TChartDrawEvent read FOnAfterDrawSeries write FOnAfterDrawSeries;
    property OnDrawBackGround: TChartDrawEvent read FOnDrawBackGround write FOnDrawBackGround;
    property OnDrawXAxis: TChartDrawEvent read FOnDrawXAxis write FOnDrawXAxis;
    property OnDrawXGrid: TChartDrawEvent read FOnDrawXGrid write FOnDrawXGrid;
    property OnDrawYAxis: TChartDrawEvent read FOnDrawYAxis write FOnDrawYAxis;
    property OnDrawYGrid: TChartDrawEvent read FOnDrawYGrid write FOnDrawYGrid;
    property OnDrawLegend: TChartDrawEvent read FOnDrawLegend write FOnDrawLegend;
    property OnDrawSeries: TChartDrawEvent read FOnDrawSeries write FOnDrawSeries;
    property OnDrawTitle: TChartDrawEvent read FOnDrawTitle write FOnDrawTitle;
    property OnDrawYValues: TChartDrawEvent read FOnDrawYValues write FOnDrawYValues;
    property OnDrawXValues: TChartDrawEvent read FOnDrawXValues write FOnDrawXValues;
    property OnDrawNavigator: TChartDrawEvent read FOnDrawNavigator write FOnDrawNavigator;
    property OnSerieXAxisGroup: TChartSerieXAxisCustomGroupEvent read FOnSerieXAxisGroup write FOnSerieXAxisGroup;
    property OnGetCountChartType: TChartGetCountChartType read FOnGetCountChartType write FOnGetCountChartType;
    property OnGetCountGroupedChartType: TChartGetCountChartType read FOnGetCountGroupedChartType write FOnGetCountGroupedChartType;
    property OnGetNumberOfPoints: TChartSerieGetNumberOfPoints read FOnGetNumberOfPoints write FOnGetNumberOfPoints;
    property OnGetPoint: TChartSerieGetPoint read FOnGetPoint write FOnGetPoint;
    property XScaleOffset: Boolean read FXScaleOffset write SetXScaleOffset default True;
  end;

function ConvertToLog(Value: Double): Double;
function DarkenColor(color: TColor; Apply: Boolean): TColor;
procedure GetLegendPosition(var x, y: integer; origw, origh, objectwidth, objectheight: integer; location: TChartLegendAlignment);
procedure DrawArrow(Canvas : TCanvas; ArrowColor: TColor; ArrowSize: integer; origin, target : TPoint; ScaleX, ScaleY: Double);

{$IFNDEF DELPHIXE2_LVL}
function PointF(X, Y: Single): TPointF;

{$ENDIF}

implementation

{$IFNDEF DELPHIXE2_LVL}
function PointF(X, Y: Single): TPointF;
begin
  Result.X := X;
  Result.Y := Y;
end;
{$ENDIF}

function GetDefaultVirtualPoint: TChartPoint;
begin
  Result.SingleValue := 0;
  Result.SingleXValue := 0;
  Result.OpenValue := 0;
  Result.LowValue := 0;
  Result.HighValue := 0;
  Result.MedValue := 0;
  Result.CloseValue := 0;
  Result.Defined := True;
  Result.PixelValue1 := 0;
  Result.PixelValue2 := 0;
  Result.Color := clNone;
  Result.ColorTo := clNone;
  REsult.TextColor := clNone;
  Result.BorderColor := clNone;
  Result.GradientDirection := cgdVertical;
  Result.TimeStamp := 0;
  Result.TimeXStamp := 0;
  Result.ValueType := cpvSingle;
  Result.LegendValue := '';
  Result.Tag := 0;
end;

procedure GetLegendPosition(var x, y: integer; origw, origh, objectwidth, objectheight: integer; location: TChartLegendAlignment);
var
  w, h, tw, th: integer;
begin
  tw := objectwidth;
  th := objectheight;
  w := origw;
  h := origh;
  x := 0;
  y := 0;
  case location of
    laTopLeft:
    begin
      x := 0;
      y := 0;
    end;
    laTopRight:
    begin
      x := w - tw;
      y := 0;
    end;
    laBottomLeft:
    begin
      x := 0;
      y := h - th;
    end;
    laBottomRight:
    begin
      x := w - tw;
      y := h - th;
    end;
    laTopCenter:
    begin
      x := (w - tw) div 2;
      y := 0;
    end;
    laBottomCenter:
    begin
      x := (w - tw) div 2;
      y := h - th;
    end;
    laCenterCenter:
    begin
      x := (w - tw) div 2;
      y := (h - th) div 2;
    end;
    laCenterLeft:
    begin
      x := 0;
      y := (h - th) div 2;
    end;
    laCenterRight:
    begin
      x := w - tw;
      y := (h - th) div 2;
    end;
  end;
end;

function ConvertToLog(Value: Double): Double;
begin
  Result := Value;
  if Result <> 0 then
    Result := Log10(Abs(Value));
end;

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

function GetGreen(color: TColor): BYTE;
begin
  Result := BYTE(Color shr 8);
end;

function GetRed(color: TColor): BYTE;
begin
  result := BYTE(color shr 16);
end;

function GetBlue(color: TColor): BYTE;
begin
  Result := BYTE(Color shr 0);
end;

function MinMaxToUnit(min,max: double; maxlabels: integer): double; var
  i: integer;
  delta,d,r: double;
begin
  i := 0;
  r := 0;

  delta := max - min;

  // normalize range
  if (delta > 0) and (maxlabels > 0) then
  begin

    while abs(delta) < 1 do
    begin
      delta := delta * 10;
      inc(i);
    end;

    while abs(delta) > 10 do
    begin
      delta := delta / 10;
      dec(i);
    end;

    // normalized max. nr. of labels

    d := (delta) / maxlabels;

    // round on math. boundaries of 1,2,5

    if (d <= 0.1) then
      r := 0.1;

    if (d > 0.1) and (d <= 0.2) then
      r := 0.2;

    if (d > 0.2) and (d <= 0.5) then
      r := 0.5;

    if (d > 0.5) then
      r := 1;

    // denormalize unit
    if i < 0 then
    begin
      while i < 0 do
      begin
        r := r * 10;
        inc(i);
      end;
    end
    else
      while i > 0 do
      begin
        r := r / 10;
        dec(i);
      end;

    Result := r;
  end
  else
  begin
    r := 0;
    result := r;
  end;
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

function DarkenColor(color: TColor; Apply: Boolean): TColor;
var
  FRGB: TRGBTriplet;
  fHSV: THSVTriplet;
begin
  result := Color;
  if Apply then
  begin
    fRGB.R := GetRed(Color);
    fRGB.G := GetGreen(Color);
    fRGB.B := GetBlue(Color);
    RGBToHSV(fRGB.B, fRGB.G, fRGB.R, fHSV.H, fHSV.S, fHSV.V);
    fHSV.V := 0.8 * fHSV.V;
    HSVToRGB(fHSV.H, fHSV.S, fHSV.V, fRGB.R, fRGB.G, fRGB.B);
    Result := RGB(Round(fRGB.R), Round(fRGB.G), Round(fRGB.B));
  end
end;

procedure Split
   (const Delimiter: Char;
    Input: string;
    const Strings: TStrings) ;
begin
   Assert(Assigned(Strings)) ;
   Strings.Clear;
   Strings.Delimiter := Delimiter;
   Strings.DelimitedText := Input;
end;

procedure DrawArrow(Canvas : TCanvas; ArrowColor: TColor; ArrowSize: integer; origin, target : TPoint; ScaleX, ScaleY: Double);
var
  quarter: byte;
  fx, px: Integer;
  fy, py: Integer;
  x, y: integer;
  arrowpts: array[0..3] of Tpoint;
  p: tpoint;
  ar: TPoint;
  h: Integer;
  arx, ary: integer;
begin

  arx := Round(ArrowSize * ScaleX);
  ary := Round(ArrowSize * ScaleY);

  arrowpts[0] := target;

  x := target.x - origin.x;
  y := target.y - origin.y;
  h := round(sqrt(sqr(x) + sqr(y)));

  if h = 0 then
    h := 1;

  // quarter?
  if origin.x < target.x then
  begin
    if origin.y < target.y then
      quarter := 1
    else
      quarter := 3;
  end
  else
  begin
    if origin.y < target.y then
      quarter := 2
    else
      quarter := 4;
  end;

  // calculate the actual P position using the adjustments px and py.
  px := x * arx div h;
  py := y * ary div h;
  case quarter of
    1 :
      begin
        p.x := target.x - px;
        p.y := target.y - py;
        ar.x := target.x - (x * arx div h);
        ar.y := target.y - (y * ary div h);
      end;
    2 :
      begin
        p.x := target.x - px;
        p.y := target.y - py;
        ar.x := target.x - (x * arx div h);
        ar.y := target.y - (y * ary div h);
      end;
    3 :
      begin
        p.x := target.x - px;
        p.y := target.y - py;
        ar.x := target.x - (x * arx div h);
        ar.y := target.y - (y * ary div h);
      end;
    4 :
      begin
        p.x := Target.x - px;
        p.y := Target.y - py;
        ar.x := target.x - (x * arx div h);
        ar.y := target.y - (y * ary div h);
      end;
  end;

  //calculate pts[1] and pts[2] from the P position to give us the back of the arrow.
  fx := y * (arx div 2) div h;
  fy := x * (ary div 2) div h;
  case quarter of
    1 :
      begin
        arrowpts[1].x := p.x - fx;
        arrowpts[1].y := p.y + fy;
        arrowpts[3].x := p.x + fx;
        arrowpts[3].y := p.y - fy;
      end;
    2 :
      begin
        arrowpts[1].x := p.x + fx;
        arrowpts[1].y := p.y - fy;
        arrowpts[3].x := p.x - fx;
        arrowpts[3].y := p.y + fy;
      end;
    3 :
      begin
        arrowpts[1].x := p.x + fx;
        arrowpts[1].y := p.y - fy;
        arrowpts[3].x := p.x - fx;
        arrowpts[3].y := p.y + fy;
      end;
    4 :
      begin
        arrowpts[1].x := p.x + fx;
        arrowpts[1].y := p.y - fy;
        arrowpts[3].x := p.x - fx;
        arrowpts[3].y := p.y + fy;
      end;
  end;

  arrowpts[2] := ar;
  if ArrowColor <> clNone then
    canvas.Brush.color := ArrowColor
  else
    canvas.Brush.Style := bsClear;

  Canvas.polygon(arrowpts);
end;

function GetFontStyles(Style: TFontStyles): String;
var
  str: String;
begin
  str := '';
  if (fsBold in Style) then
    str := str + ':0';
  if (fsItalic in Style) then
    str := str + ':1';
  if (fsUnderline in Style) then
    str := str + ':2';
  if (fsStrikeOut in Style) then
    str := str + ':3';

  Result := str;
end;

procedure DrawGradient(Canvas: TCanvas; FromColor, ToColor: TColor; Steps: Integer; R: TRect; Direction: TChartGradientDirection; Border: Boolean;
  BorderColor: TColor; BorderWidth: integer; BorderShape: TAnnotationShape; BorderRounding: integer; BorderStyles: TChartBorderStyles; Horizontal: Boolean; UseBorderStyle: Boolean);
var
  diffr, startr, endr: Integer;
  diffg, startg, endg: Integer;
  diffb, startb, endb: Integer;
  rstepr, rstepg, rstepb, rstepw: Double;
  i, stepw: integer;
//  bw: integer;
  GR: Trect;
  oldbrushstyle: TBrushStyle;
  oldpencolor: TColor;
  oldpenwidth: integer;
  oldbrushcolor: TColor;
  oldpenstyle: TPenStyle;
begin
  oldpenstyle := Canvas.Pen.style;
  oldbrushcolor := Canvas.Brush.color;
  oldbrushstyle := Canvas.Brush.Style;
  oldpenColor := Canvas.Pen.Color;
  oldpenwidth := Canvas.Pen.Width;

  if (Steps = 20) or (Steps = 0) then
    Steps := 1;

  FromColor := ColorToRGB(FromColor);
  ToColor := ColorToRGB(ToColor);

  GR := R;

  if GR.Right < GR.Left then
  begin
    startr := GR.Right;
    GR.Right := GR.Left;
    GR.Left := startr;
  end;

  if GR.Top > GR.Bottom then
  begin
    startr := GR.Top;
    GR.Top := GR.Bottom;
    GR.Bottom := startr;
  end;

  startr := (FromColor and $0000FF);
  startg := (FromColor and $00FF00) shr 8;
  startb := (FromColor and $FF0000) shr 16;
  endr := (ToColor and $0000FF);
  endg := (ToColor and $00FF00) shr 8;
  endb := (ToColor and $FF0000) shr 16;

  diffr := endr - startr;
  diffg := endg - startg;
  diffb := endb - startb;

  rstepr := diffr / steps;
  rstepg := diffg / steps;
  rstepb := diffb / steps;

  if Direction = cgdHorizontal then
    rstepw := (GR.Right - GR.Left - BorderWidth - 1) / Steps
  else
    rstepw := (GR.Bottom - GR.Top  - BorderWidth - 1) / Steps;


  with Canvas do
  begin
    for i := 0 to steps - 1 do
    begin
      endr := startr + Round(rstepr * i);
      endg := startg + Round(rstepg * i);
      endb := startb + Round(rstepb * i);
      stepw := Round(i * rstepw);
      Pen.Color := endr + (endg shl 8) + (endb shl 16);
      Brush.Color := Pen.Color;

      if Direction = cgdHorizontal then
        Rectangle(GR.Left + stepw, GR.Top, GR.Left + stepw + Round(rstepw) + 2, GR.Bottom)
      else
        Rectangle(GR.Left, GR.Top + stepw, GR.Right, GR.Top + stepw + Round(rstepw) + 2);
    end;


    if Border and (BorderWidth > 0) then
    begin
      if BorderColor = clNone then
        BorderColor := FromColor;
      Brush.Style := bsClear;
      Pen.Color := BorderColor;
      Pen.Width := BorderWidth;
      Pen.Style := psSolid;

      case BorderShape of
        asRectangle:
        begin
          if UseBorderStyle then
          begin
            if not Horizontal then
            begin
              if R.Top > R.Bottom then
                R.Top := R.Top - 1
              else
                R.Bottom := R.Bottom - 1;

              r.Right := R.Right - 1;
            end
            else
            begin
              if R.Right < R.Left then
                R.Left := R.Left - 1
              else
                R.Right := R.Right - 1;

              r.Bottom := R.Bottom - 1;
            end;

            if cbLeft in BorderStyles then
            begin
              MoveTo(R.Left, R.Top);
              LineTo(R.Left, R.Bottom);
            end;
            if cbTop in BorderStyles then
            begin
              MoveTo(R.Left, R.Top);
              LineTo(R.Right, R.Top);
            end;
            if cbRight in BorderStyles then
            begin
              MoveTo(R.Right, R.Top);
              LineTo(R.Right, R.Bottom);
            end;
            if cbBottom in BorderStyles then
            begin
              MoveTo(R.Left, R.Bottom);
              LineTo(R.Right, R.Bottom);
            end;
          end
          else
          begin
            Rectangle(R);
          end;
        end;
        asCircle: Ellipse(R);
        asRoundRect: RoundRect(R.Left, R.Top , R.Right, R.Bottom, BorderRounding , BorderRounding);
      end;
    end;
  end;

  Canvas.Brush.Style := oldbrushstyle;
  Canvas.Pen.Color := oldpencolor;
  Canvas.Pen.Width := oldpenwidth;
  Canvas.Pen.Style := oldpenstyle;
  Canvas.Brush.color := oldbrushcolor;
end;


procedure TChartTitle.Assign(Source: TPersistent);
begin
  if Source is TChartTitle then
  begin
    FText := (Source as TChartTitle).Text;
    FBorderColor := (Source as TChartTitle).BorderColor;
    FBorderWidth := (Source as TChartTitle).BorderWidth;
    FColorTo := (Source as TChartTitle).ColorTo;
    FGradientSteps := (Source as TChartTitle).GradientSteps;
    FGradientDirection := (Source as TchartTitle).GradientDirection;
    FFont.Assign((Source as TChartTitle).Font);
    FAlignment := (Source as TChartTitle).Alignment;
    FVerticalAlignment := (Source as TChartTitle).VerticalAlignment;
    FColor := (Source as TChartTitle).Color;
    FSize := (Source as TChartTitle).Size;
    FPosition := (Source as TChartTitle).Position;
  end;
end;

procedure TChartTitle.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TChartTitle.Create(AOwner: TAdvChart);
begin
  FAlignment := taLeftJustify;
  FVerticalAlignment := taVerticalCenter;
  FColorTo := clNone;
  FBorderColor := clNone;
  FBorderWidth := 0;
  GradientSteps := 100;
  GradientDirection := cgdHorizontal;
  FColor := clNone;
  FFont := TFont.Create;
  FOwner := AOwner;
  FPosition := tNone;
  FSize := 20;
  FText := '';
end;

destructor TChartTitle.Destroy;
begin
  FFont.Free;
  inherited;
end;

procedure TChartTitle.Draw(Canvas: TCanvas; Top: Boolean; R: TRect; ScaleX, ScaleY: Double);
var
  DTSTYLE: dword;
begin
    if (Color <> clNone) and (ColorTo <> clNone) then
    begin
      if Top then
        DrawGradient(Canvas, Color, ColorTo, GradientSteps, R, GradientDirection, BorderColor <> clNone, BorderColor, BorderWidth, asRectangle, 0, [cbLeft, cbTop, cbRight, cbBottom], false, false)
      else
        DrawGradient(Canvas, ColorTo, Color, GradientSteps, R, GradientDirection, BorderColor <> clNone, BorderColor, BorderWidth, asRectangle, 0, [cbLeft, cbTop, cbRight, cbBottom], false, false);
    end
    else
    begin
      if (BorderColor <> clNone) and (Color <> clNone) then
      begin
        Canvas.Pen.Color := BorderColor;
        Canvas.Pen.Width := BorderWidth;
        Canvas.Brush.Color := Color;
        Canvas.Rectangle(R);
      end
      else if (Color <> clNone) then
      begin
        Canvas.Pen.Color := Color;
        Canvas.Brush.Color := Color;
        Canvas.Rectangle(R);
      end
      else if (BorderColor <> clNone) then
      begin
        Canvas.Pen.Color := BorderColor;
        Canvas.Pen.Width := BorderWidth;
        Canvas.Brush.Style := bsClear;
        Canvas.Rectangle(R);
      end;
    end;

  Canvas.Font.Assign(FFont);
  Canvas.Brush.Style := bsClear;

  DTSTYLE  := DT_NOCLIP;
  case FAlignment of
    taLeftJustify: DTSTYLE := DTSTYLE or DT_LEFT;
    taCenter: DTSTYLE := DTSTYLE or DT_CENTER;
    taRightJustify: DTSTYLE := DTSTYLE or DT_RIGHT;
  end;

  case FVerticalAlignment of
    taAlignTop: DTSTYLE := DTSTYLE or DT_TOP;
    taAlignBottom: DTSTYLE := DTSTYLE or DT_BOTTOM or DT_SINGLELINE;
    taVerticalCenter: DTSTYLE := DTSTYLE or DT_VCENTER or DT_SINGLELINE;
  end;

  InflateRect(R, -1, -1);
  DrawText(Canvas.Handle, PChar(FText), Length(FText), R, DTSTYLE);
end;

procedure TChartTitle.FontChanged(Sender: TObject);
begin
  Changed;
end;

function TChartTitle.GetBottomSize: integer;
begin
  Result := 0;
  if (Position in [tBottom, tBoth]) then
    Result := Size;
end;

function TChartTitle.GetTopSize: integer;
begin
  Result := 0;
  if (Position in [tTop, tBoth]) then
    Result := Size;
end;

procedure TChartTitle.LoadFromFile(ini: TMemIniFile;Section: String);
var
  A: TStringList;
  str: String;
  I: integer;
begin
  Alignment := TAlignment(ini.ReadInteger(Section, 'Alignment', Integer(Alignment)));
  VerticalAlignment := TVerticalAlignment(ini.ReadInteger(Section, 'VerticalAlignment', Integer(VerticalAlignment)));
  Color := ini.ReadInteger(Section, 'Color', Color);
  ColorTo := ini.ReadInteger(Section, 'ColorTo', ColorTo);
  BorderColor := ini.ReadInteger(Section, 'BorderColor', BorderColor);
  BorderWidth := ini.ReadInteger(Section, 'BorderWidth', BorderWidth);
  GradientSteps := ini.ReadInteger(Section, 'GradientSteps', GradientSteps);
  GradientDirection := TChartGradientDirection(ini.ReadInteger(Section, 'GradientDirection', Integer(GradientDirection)));
  Font.Size := ini.ReadInteger(Section, 'FontSize', Font.Size);
  Font.Color := ini.ReadInteger(Section, 'FontColor', Font.Color);
  Font.Name := ini.ReadString(Section, 'FontName', Font.Name);
  str := ini.ReadString(Section, 'FontStyle', '');
  A := TStringList.Create;
  Split(':',str, A);
  for I := 1 to A.Count - 1 do
  begin
    Font.Style := Font.Style + [TFontStyle(strtoint(A[I]))];
  end;
  A.Free;
  Position := TTitlePosition(ini.ReadInteger(Section, 'Position', Integer(Position)));
  Size := ini.ReadInteger(Section, 'Size', Size);
  Text := ini.ReadString(Section, 'Text', Text);
end;

procedure TChartTitle.SaveToFile(ini: TMemIniFile;Section: String);
begin
  ini.WriteInteger(Section, 'Alignment', Integer(Alignment));
  ini.WriteInteger(Section, 'VerticalAlignment', Integer(VerticalAlignment));
  ini.WriteInteger(Section, 'Color', Color);
  ini.WriteInteger(Section, 'ColorTo', ColorTo);
  ini.WriteInteger(Section, 'GradientSteps', GradientSteps);
  ini.WriteInteger(Section, 'GradienDirection', Integer(GradientDirection));
  ini.WriteInteger(Section, 'BorderColor', BorderColor);
  ini.WriteInteger(Section, 'BorderWidth', BorderWidth);
  ini.WriteInteger(Section, 'FontSize', Font.Size);
  ini.WriteInteger(Section, 'FontColor', Font.Color);
  ini.WriteString(Section, 'FontName', Font.Name);
  ini.WriteString(Section, 'FontStyle', GetFontStyles(Font.Style));
  ini.WriteInteger(Section, 'Position', Integer(Position));
  ini.WriteInteger(Section, 'Size', Size);
  ini.WriteString(Section, 'Text', Text);
end;

procedure TChartTitle.SetAlignment(const Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    Changed;
  end;
end;

procedure TChartTitle.SetBorderColor(const Value: TColor);
begin
  if FBorderColor <> Value then
  begin
    FBorderColor := Value;
    Changed;
  end;
end;

procedure TChartTitle.SetBorderWidth(const Value: Integer);
begin
  if FBorderWidth <> Value then
  begin
    FBorderWidth := Value;
    Changed;
  end;
end;

procedure TChartTitle.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Changed;
  end;
end;

procedure TChartTitle.SetColorTo(const Value: TColor);
begin
  if FColorTo <> Value then
  begin
    FColorTo := Value;
    Changed;
  end;
end;

procedure TChartTitle.SetFont(const Value: TFont);
begin
  if FFont <> Value then
  begin
    FFont.Assign(Value);
    FontChanged(FFont);
  end;
end;

procedure TChartTitle.SetGradientDirection(
  const Value: TChartGradientDirection);
begin
  if FGradientDirection <> Value then
  begin
    FGradientDirection := Value;
    Changed;
  end;
end;

procedure TChartTitle.SetGradientSteps(const Value: integer);
begin
  if FGradientSteps <> Value then
  begin
    FGradientSteps := Value;
    Changed;
  end;
end;

procedure TChartTitle.SetPosition(const Value: TTitlePosition);
begin
  if FPosition <> Value then
  begin
    FPosition := Value;
    Changed;
  end;
end;

procedure TChartTitle.SetSize(const Value: integer);
begin
  if (FSize <> Value) and (Value >= 0) then
  begin
    FSize := Value;
    Changed;
  end;
end;

procedure TChartTitle.SetText(const Value: String);
begin
  if FText <> Value then
  begin
    FText := Value;
    Changed;
  end;
end;

procedure TChartTitle.SetVerticalAlignment(const Value: TVerticalAlignment);
begin
  if FVerticalAlignment <> Value then
  begin
    FVerticalAlignment := Value;
    Changed;
  end;
end;

{ TAdvChart }

procedure TAdvChart.Assign(Source: TPersistent);
begin
  if Source is TAdvChart then
  begin
    FXScaleOffset := (Source as TAdvChart).XScaleOffset;
    FAxisMode := (source as TAdvChart).AxisMode;
    FBackground.Assign((Source as TAdvChart).Background);
    FCrossHair.Assign((Source as TAdvChart).CrossHair);
    FNavigator.Assign((Source as TAdvChart).Navigator);
    FBands.Assign((Source as TAdvChart).Bands);
    FXAxis.Assign((Source as TAdvChart).XAxis);
    FYAxis.Assign((Source as TAdvChart).YAxis);
    FTitle.Assign((Source as TAdvChart).Title);
    FSeries.Assign((Source as TAdvChart).Series);
    Series.Mode := (Source as TAdvChart).Series.Mode;
    FXGrid.Assign((Source as TAdvChart).XGrid);
    FYGrid.Assign((Source as TAdvChart).YGrid);
    FRange.Assign((Source as TAdvChart).Range);
    FMargin.Assign((Source as TAdvChart).Margin);
    FLegend.Assign((Source as TAdvChart).Legend);
  end;
end;

constructor TAdvChart.Create(AOwner: TPersistent);
begin
  FOwner := AOwner;
  FRange := TChartRange.Create(Self);
  FRange.OnChange := RangeChanged;
  FSeries := CreateSeries;
  FSeries.OnChange := SeriesChanged;
  FBackground := CreateBackground;
  FBackground.OnChange := BackgroundChanged;
  FBands := TChartBands.Create(Self);
  FBands.OnChange := BandsChanged;
  FMargin := TChartMargin.Create(Self);
  FMargin.OnChange := MarginChanged;
  FXAxis := TChartXAxis.Create(Self);
  FXAxis.OnChange := XAxisChanged;
  FYAxis := TChartYAxis.Create(Self);
  FYAxis.OnChange := YAxisChanged;
  FTitle := TChartTitle.Create(Self);
  FTitle.OnChange := TitleChanged;
  FXGrid := TChartXGrid.Create(Self);
  FXGrid.OnChange := XGridChanged;
  FYGrid := TChartYGrid.Create(Self);
  FYGrid.OnChange := YGridChanged;
  FCrossHair := TChartCrossHair.Create(Self);
  CrossHair.OnChange := CrossHairChanged;
  FNavigator := TChartNavigator.Create(Self);
  FNavigator.OnChange := NavigatorChanged;
  FLegend := CreateLegend;
  FLegend.OnChange := LegendChanged;
  FAxisMode := amAxisChartWidthHeight;
  FUpdateCount := 0;
  FXScaleOffset := True;
end;

function TAdvChart.CreateLegend: TChartLegend;
begin
  Result := TChartLegend.Create(Self);
end;

function TAdvChart.CreateSeries: TChartSeries;
begin
  Result := TChartSeries.Create(Self);
end;

function TAdvChart.CreateBackground: TChartBackground;
begin
  Result := TChartBackground.Create(Self);
end;

procedure TAdvChart.CrossHairChanged(Sender: TObject);
begin
  Changed;
end;

destructor TAdvChart.Destroy;
begin
  FSeries.Free;
  FXGrid.Free;
  FYGrid.Free;
  FBackground.Free;
  FBands.Free;
  FXAxis.Free;
  FYAxis.Free;
  FTitle.Free;
  FRange.Free;
  FCrossHair.Free;
  FNavigator.Free;
  FLegend.Free;
  FMargin.Free;
  inherited;
end;

procedure TAdvChart.DoGetNumberOfPoints(Serie: Integer; var ANumberOfPoints: Integer);
begin
  if Assigned(OnGetNumberOfPoints) then
    OnGetNumberOfPoints(Self, Serie, ANumberOfPoints);
end;

procedure TAdvChart.DoGetPoint(Serie, AIndex: Integer; var APoint: TChartPoint);
begin
  if Assigned(OnGetPoint) then
    OnGetPoint(Self, Serie, AIndex, APoint);
end;

procedure TAdvChart.InitializeChart(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double);
var
  DR: TRect;
  X: TChartXAxis;
  Y: TChartYAxis;
  T: TChartTitle;
  M: TChartMargin;
  N: TChartNavigator;
  dm: Boolean;
  xt, yl, xb, yr: integer;
begin
  SetMinMax;

  X := XAxis;
  Y := YAxis;
  M := Margin;
  N := Navigator;
  T := Title;

  dm := Series.IsHorizontal;

  if dm then
  begin
    xt := Y.LeftSize;
    yl := X.BottomSize;
    xb := Y.RightSize;
    yr := X.TopSize;
  end
  else
  begin
    xt := X.TopSize;
    yl := Y.LeftSize;
    xb := X.BottomSize;
    yr := Y.RightSize;
  end;

  //INITIALIZE CHART
  DR := Rect(R.Left + Round((yl + M.FLeftMargin) * ScaleX), R.Top + Round((T.TopSize + xt + M.FTopMargin) * ScaleY),
    R.Right - Round(yr * ScaleX) - Round(M.FRightMargin * ScaleX), R.Bottom - Round(xb * ScaleY) -
      Round(T.BottomSize * ScaleY) - Round(M.FBottomMargin * scaleY) - Round(N.BottomSize * ScaleY));

  if (DR.Left < DR.Right) and (DR.Bottom > DR.Top) then
    Initialize(Canvas, DR, ScaleX, ScaleY);
end;

procedure TAdvChart.DrawXAxis(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double);
var
  DR: TRect;
  T: TChartTitle;
  X: TChartXAxis;
  Y: TChartYAxis;
  xt, yl, xb, yr: integer;
  dm: Boolean;
begin
  T := Title;
  X := XAxis;
  Y := YAxis;

  dm := Series.IsHorizontal;

  if dm then
  begin
    xt := Y.LeftSize;
    yl := X.BottomSize;
    xb := Y.RightSize;
    yr := X.TopSize;
  end
  else
  begin
    xt := X.TopSize;
    yl := Y.LeftSize;
    xb := X.BottomSize;
    yr := Y.RightSize;
  end;

  if Series.IsHorizontal then
  begin
    if (X.Position in [xBottom, xBoth]) then
    begin
      case AxisMode of
        amXAxisFullWidth: DR := Rect(R.Left, R.Top , R.Left + Round(yl * ScaleX), R.Bottom);
        else
          DR := Rect(R.Left, R.Top + Round((T.TopSize + xt) * ScaleY), R.Left + Round(yl * ScaleX), R.Bottom - Round(xb * ScaleY) - Round(T.BottomSize * ScaleY));
      end;

      if (DR.Right < R.Right - Round(yr * ScaleX)) and (DR.Top < DR.Bottom) then
        X.Draw(Canvas, DR, false, ScaleX, ScaleY, Series.IsHorizontal);
    end;

    if (X.Position in [xTop, xBoth]) then
    begin
      case AxisMode of
        amXAxisFullWidth: DR := Rect(R.Right - Round(yr * ScaleX), R.Top, R.Right, R.Bottom) ;
      else
        DR := Rect(R.Right - Round(yr * ScaleX), R.Top + Round((T.TopSize + xt) * ScaleY), R.Right, R.Bottom - Round(xb * ScaleY) - Round(T.BottomSize * ScaleY));
      end;

      if (DR.Left > R.Left + Round(yl * ScaleX)) and (DR.Top < DR.Bottom) then
        X.Draw(Canvas, DR, true, ScaleX, ScaleY, Series.IsHorizontal);
    end;
  end
  else
  begin
    if (X.Position in [xBottom, xBoth]) then
    begin
      case AxisMode of
        amXAxisFullWidth: DR := Rect(R.Left ,R.Bottom - Round(X.BottomSize * ScaleY) - Round(T.BottomSize * ScaleY), R.Right, R.Bottom - Round(T.BottomSize * ScaleY));
        else
          DR := Rect(R.Left + Round(Y.LeftSize * ScaleX) ,R.Bottom - Round(X.BottomSize * ScaleY) - Round(T.BottomSize * ScaleY), R.Right - Round(Y.RightSize * ScaleY), R.Bottom - Round(T.BottomSize * ScaleY));
      end;

      if (DR.Top > R.Top + Round((X.TopSize + T.TopSize) * ScaleY)) and (DR.Left < DR.Right) then
        X.Draw(Canvas, DR, false, ScaleX, ScaleY, Series.IsHorizontal);
    end;

    if (X.Position in [xTop, xBoth]) then
    begin
      case AxisMode of
        amXAxisFullWidth: DR := Rect(R.Left,R.Top + Round(T.TopSize * ScaleY), R.Right , R.Top + Round((T.TopSize + X.TopSize) * ScaleY));
      else
        DR := Rect(R.Left + Round(Y.LeftSize * ScaleX),R.Top + Round(T.TopSize * ScaleY), R.Right - Round(Y.RightSize * ScaleX), R.Top + Round((T.TopSize + X.TopSize) * ScaleY));
      end;

      if (DR.Bottom < R.Bottom - Round((XAxis.BottomSize - Title.BottomSize) * ScaleY)) and (DR.Left < DR.Right) then
      begin
        X.Draw(Canvas, DR, true, ScaleX, ScaleY, Series.IsHorizontal);
      end;
    end;
  end;
end;

function TAdvChart.Draw(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double; Initialize: Boolean = false): TRect;
var
  DR: TRect;
  HRGN: THandle;
  BG: TChartBackGround;
  X: TChartXAxis;
  Y: TChartYAxis;
  T: TChartTitle;
  M: TChartMargin;
  N: TChartNavigator;
  XG: TChartXGrid;
  YG: TChartYGrid;
  S: TChartSeries;
  i,mw,sw: Integer;
  L: TChartLegend;
  sCount: integer;
  dm: Boolean;
  xt, yl, xb, yr, yls, yrs, xts, xbs: integer;

  rx, ry, rxg, ryg, rl, rt, srct, ryv, rxv, rnav: TRect;
begin
  if FUpdateCount > 0 then
    Exit;


  if Initialize then
  begin
    Series.ForceInit(true);
    InitializeChart(Canvas, R, ScaleX, ScaleY);
  end;


  BG := BackGround;
  S := Series;
  XG := XGrid;
  YG := YGrid;
  L := Legend;
  X := XAxis;
  Y := YAxis;
  M := Margin;
  N := Navigator;
  T := Title;
  dm := Series.IsHorizontal;

  if dm then
  begin
    xt := Y.LeftSize;
    yl := X.BottomSize;
    xb := Y.RightSize;
    yr := X.TopSize;
    yls := X.BottomLineSize;
    yrs := X.TopLineSize;
    xts := Y.LeftLineSize;
    xbs := Y.RightLineSize;
  end
  else
  begin
    xt := X.TopSize;
    yl := Y.LeftSize;
    xb := X.BottomSize;
    yr := Y.RightSize;
    yls := Y.LeftLineSize;
    yrs := Y.RightLineSize;
    xts := X.TopLineSize;
    xbs := X.BottomLineSize;
  end;

  DR := Rect(R.Left + Round((yl + M.FLeftMargin) * ScaleX), R.Top + Round((T.TopSize + xt + M.FTopMargin) * ScaleY),
    R.Right - Round(yr * ScaleX) - Round(M.FRightMargin * ScaleX), R.Bottom - Round(xb * ScaleY) -
      Round(T.BottomSize * ScaleY) - Round(M.FBottomMargin * scaleY) - Round(N.BottomSize * ScaleY));

  HRGN := CreateRectRgn(DR.Left, DR.Top, DR.Right, DR.Bottom);
  SelectClipRgn(Canvas.Handle,HRGN);

  if (DR.Left < DR.Right) and (DR.Bottom > DR.Top) then
  begin
    BG.Draw(Canvas, DR, ScaleX, ScaleY);
    if Assigned(OnDrawBackGround) then
      OnDrawBackGround(Self, DR, Canvas);
  end;

  SelectClipRgn(Canvas.Handle,0);
  DeleteObject(HRGN);

  //X - AXIS
  if not FGDIPDrawing then
  begin
    if dm then
    begin
      if X.Enable3D then
        R.Bottom := R.Bottom - X.Offset3D;
    end
    else
    begin
      if X.Enable3D then
        R.Right := R.Right - X.Offset3D;
    end;
    DrawXAxis(Canvas, R, ScaleX, ScaleY);
    rx := R;
  end;

  if dm then
  begin
    if Y.Enable3D then
      R.Right := r.Right - Y.Offset3D;
    if (Y.Position in [yRight, yBoth]) then
    begin
      case AxisMode of
        amYAxisFullHeight: DR := Rect(R.Left ,R.Bottom - Round(xb * ScaleY) - Round(T.BottomSize * ScaleY), R.Right, R.Bottom - Round(T.BottomSize * ScaleY));
        else
          DR := Rect(R.Left + Round(yl * ScaleX) ,R.Bottom - Round(xb * ScaleY) - Round(T.BottomSize * ScaleY), R.Right - Round(yr * ScaleY), R.Bottom - Round(T.BottomSize * ScaleY));
      end;

      if (DR.Top > R.Top + Round((xt + T.TopSize) * ScaleY)) and (DR.Left < DR.Right) then
        Y.Draw(Canvas, DR, false, ScaleX, ScaleY, dm);

      ry := DR;
    end;

    if (Y.Position in [yLeft, yBoth]) then
    begin
      case AxisMode of
        amYAxisFullHeight: DR := Rect(R.Left,R.Top + Round(T.TopSize * ScaleY), R.Right , R.Top + Round((T.TopSize + xt) * ScaleY));
      else
        DR := Rect(R.Left + Round(yl * ScaleX),R.Top + Round(T.TopSize * ScaleY), R.Right - Round(yr * ScaleX), R.Top + Round((T.TopSize + xt) * ScaleY));
      end;

      if (DR.Bottom < R.Bottom - Round((xb - Title.BottomSize) * ScaleY)) and (DR.Left < DR.Right) then
      begin
        Y.Draw(Canvas, DR, true, ScaleX, ScaleY, dm);
      end;

      ry := DR;
    end;
  end
  else
  begin
    if Y.Enable3D then
      R.Top := r.Top + Y.Offset3D;

    //Y - AXIS
    if (Y.Position in [yLeft, yBoth]) then
    begin
      case AxisMode of
        amYAxisFullHeight: DR := Rect(R.Left, R.Top , R.Left + Round(yl * ScaleX), R.Bottom);
        else
          DR := Rect(R.Left, R.Top + Round((T.TopSize + xt) * ScaleY), R.Left + Round(yl * ScaleX), R.Bottom - Round(xb * ScaleY) - Round(T.BottomSize * ScaleY));
      end;

      if (DR.Right < R.Right - Round(yr * ScaleX)) and (DR.Top < DR.Bottom) then
        Y.Draw(Canvas, DR, true, ScaleX, ScaleY, dm);

      ry := DR;
    end;

    if (Y.Position in [yRight, yBoth]) then
    begin
      case AxisMode of
        amYAxisFullHeight: DR := Rect(R.Right - Round(yr * ScaleX), R.Top, R.Right, R.Bottom) ;
      else
        DR := Rect(R.Right - Round(yr * ScaleX), R.Top + Round((T.TopSize + xt) * ScaleY), R.Right, R.Bottom - Round(xb * ScaleY) - Round(T.BottomSize * ScaleY));
      end;

      if (DR.Left > R.Left + Round(yl * ScaleX)) and (DR.Top < DR.Bottom) then
        Y.Draw(Canvas, DR, false, ScaleX, ScaleY, dm);

      ry := DR;
    end;
  end;

  if dm then
  begin
      //TITLE
    if (T.Position in [tTop, tBoth]) then
    begin
      case AxisMode of
        amYAxisFullHeight: DR := Rect(R.Left , R.Top, R.Right, R.Top + Round(T.TopSize * ScaleY));
      else
        DR := Rect(R.Left + Round(yl * ScaleX), R.Top, R.Right - Round(yr * ScaleX) + Round(yrs * ScaleX), R.Top + Round(T.TopSize * ScaleY));
      end;

      if (DR.Bottom < R.Bottom - Round(T.BottomSize * ScaleY)) and (DR.Left < DR.Right) then
        T.Draw(Canvas, true, DR, ScaleX, ScaleY);

      rt := DR;
    end;

    if (T.Position in [tBottom, tBoth]) then
    begin
      case AxisMode of
        amYAxisFullHeight: DR := Rect(R.Left, R.Bottom - Round(T.Bottomsize * ScaleY), R.Right, R.Bottom);
      else
        DR := Rect(R.Left + Round(yl * ScaleX) - Round(yls * ScaleX), R.Bottom - Round(T.Bottomsize * ScaleY) + GetMax3DOffset, R.Right - Round(yr * ScaleX) , R.Bottom + GetMax3DOffset);
      end;

      if (DR.Top > R.Top + Round(T.Topsize * ScaleY)) and (DR.Left < DR.Right) then
        T.Draw(Canvas, false, DR, ScaleX, ScaleY);

      rt := DR;
    end;
  end
  else
  begin
      //TITLE
    if (T.Position in [tTop, tBoth]) then
    begin
      case AxisMode of
        amXAxisFullWidth: DR := Rect(R.Left , R.Top, R.Right, R.Top + Round(T.TopSize * ScaleY));
      else
        DR := Rect(R.Left + Round(yl * ScaleX), R.Top - GetMax3DOffset, R.Right - Round(yr * ScaleX) + Round(yrs * ScaleX), R.Top + Round(T.TopSize * ScaleY) - GetMax3DOffset);
      end;

      if (DR.Bottom < R.Bottom - Round(T.BottomSize * ScaleY)) and (DR.Left < DR.Right) then
        T.Draw(Canvas, true, DR, ScaleX, ScaleY);

      rt := DR;
    end;

    if (T.Position in [tBottom, tBoth]) then
    begin
      case AxisMode of
        amXAxisFullWidth: DR := Rect(R.Left, R.Bottom - Round(T.Bottomsize * ScaleY), R.Right, R.Bottom);
      else
        DR := Rect(R.Left + Round(yl * ScaleX) - Round(yls * ScaleX), R.Bottom - Round(T.Bottomsize * ScaleY), R.Right - Round(yr * ScaleX) , R.Bottom);
      end;

      if (DR.Top > R.Top + Round(T.Topsize * ScaleY)) and (DR.Left < DR.Right) then
        T.Draw(Canvas, false, DR, ScaleX, ScaleY);

      rt := DR;
    end;
  end;

  //SERIES
  DR := Rect(R.Left + Round((yl + M.FLeftMargin) * ScaleX) + Round(yls * Scalex),
    R.Top + Round((T.TopSize + xt + M.FTopMargin) * ScaleY)  + Round(xts * Scaley),
      R.Right - Round(yr * ScaleX) - Round(M.FRightMargin * ScaleX) - Round(yrs * Scalex),
        R.Bottom - Round(xb * ScaleY) - Round(T.BottomSize * ScaleY) - Round(xbs * ScaleY) - Round(M.BottomMargin * scaleY) -
          Round(N.BottomSize * ScaleY));

  HRGN := CreateRectRgn(DR.Left, DR.Top - GetMax3DOffset, DR.Right + 1, DR.Bottom);
  SelectClipRgn(Canvas.Handle,HRGN);


  //SERIES AND GRID
  S.SeriesRectangle := DR;

  if Assigned(OnBeforeDrawSeries) then
    OnBeforeDrawSeries(Self, S.SeriesRectangle, Canvas);

  if (DR.Left < DR.Right) and (DR.Bottom > DR.Top) then
  begin
    if (XG.OnTop and YG.OnTop) then
    begin
      //SERIES
      S.Draw(Canvas, DR, ScaleX, ScaleY, HRGN);
      srct := DR;

      //X - GRID
      if XG.Visible then
      begin
        XG.Draw(Canvas, DR, ScaleX, ScaleY);
        rxg := DR;
      end;

      //Y - GRID
      //if YG.Visible then
      YG.Draw(Canvas, DR, ScaleX, ScaleY);
      ryg := DR;

    end
    else if (XG.OnTop and not YG.OnTop) then
    begin
      //Y - GRID
      //if YG.Visible then
      YG.Draw(Canvas, DR, ScaleX, ScaleY);
      ryg := DR;

      //SERIES
      S.Draw(Canvas, DR, ScaleX, ScaleY, HRGN);
      srct := DR;

      //X - GRID
      if XG.Visible then
      begin
        XG.Draw(Canvas, DR, ScaleX, ScaleY);
        rxg := DR;
      end;

    end
    else if (YG.OnTop and not XG.OnTop) then
    begin
      //X - GRID
      if XG.Visible then
      begin
        XG.Draw(Canvas, DR, ScaleX, ScaleY);
        rxg := DR;
      end;

       //SERIES
      S.Draw(Canvas, DR, ScaleX, ScaleY, HRGN);
      srct := DR;

      //Y - GRID
      //if YG.Visible then
      YG.Draw(Canvas, DR, ScaleX, ScaleY);
      ryg := DR;
    end
    else
    begin

      //Y - GRID
      //if YG.Visible then
      YG.Draw(Canvas, DR, ScaleX, ScaleY);
      ryg := DR;

      //X - GRID
      if XG.Visible then
      begin
        XG.Draw(Canvas, DR, ScaleX, ScaleY);
        rxg := DR;
      end;

      //SERIES
      S.Draw(Canvas, DR, ScaleX, ScaleY, HRGN);
      srct := DR;

    end;
  end;

  if (DR.Left < DR.Right) and (DR.Bottom > DR.Top) then
    DrawZeroLine(Canvas, DR, ScaleX, ScaleY);

  SelectClipRgn(Canvas.Handle,0);
  DeleteObject(HRGN);

  if Assigned(OnAfterDrawSeries) then
    OnAfterDrawSeries(Self, S.SeriesRectangle, Canvas);

  S.DrawMarkers(Canvas, DR, ScaleX, ScaleY);

  S.DrawAnnotations(Canvas, DR, ScaleX, ScaleY);

  S.DrawChartValues(Canvas, DR, ScaleX, ScaleY);

  if dm then
  begin
    DR := Rect(R.Left + Round(yl * ScaleX), R.Top + Round((T.TopSize + xt) * ScaleY),
      R.Right - Round(yr * ScaleX), R.Bottom - Round(xb * ScaleY) -
        Round(T.BottomSize * ScaleY) - Round(N.BottomSize * ScaleY));

    if (DR.Top < DR.Bottom) and (DR.Left < DR.Right) then
      S.DrawYValues(Canvas, DR, ScaleX, ScaleY);

    ryv := DR;
  end
  else
  begin
    DR := Rect(R.Left + Round(yl * ScaleX), R.Top + Round((T.TopSize + xt) * ScaleY),
      R.Right - Round(yr * ScaleX), R.Bottom - Round(xb * ScaleY) -
        Round(T.BottomSize * ScaleY) - Round(N.BottomSize * ScaleY));

    if (DR.Top < DR.Bottom) and (DR.Left < DR.Right) then
      S.DrawYValues(Canvas, DR, ScaleX, ScaleY);

    ryv := DR;
  end;

  if dm then
  begin
    if (X.Position in [xBoth, xTop]) and (X.TopSize > 0) then
    begin
      DR := Rect(R.Right - Round(yr * ScaleX), R.Top + Round((T.TopSize + xt + M.FTopMargin + xts) * ScaleY),
        R.Right, R.Bottom - Round(xb * ScaleY) -
          Round(T.BottomSize * ScaleY) - Round(M.FBottomMargin * ScaleY) - Round(N.BottomSize * ScaleY));

      if (DR.Left < DR.Right) and (DR.top < DR.Bottom) then
        S.DrawXValues(Canvas, DR, true, ScaleX, ScaleY);
      rxv := DR;
    end;

    if (X.Position in [xBoth, xBottom]) and (X.BottomSize > 0) then
    begin
      DR := Rect(R.Left, R.Top + Round((T.TopSize + xt + M.FTopMargin + xts) * ScaleY),
        R.Left + Round(yl * ScaleX), R.Bottom - Round(xb * ScaleY) -
          Round(T.BottomSize * ScaleY) - Round(M.FBottomMargin * ScaleY) - Round(N.BottomSize * ScaleY));

      if (DR.Left < DR.Right) and (DR.top < DR.Bottom) then
        S.DrawXValues(Canvas, DR, false, ScaleX, ScaleY);

      rxv := DR;
    end;
  end
  else
  begin
    if (X.Position in [xBoth, xBottom]) and (X.Bottomsize > 0) then
    begin
      DR := Rect(R.Left + Round((Y.LeftSize + M.LeftMargin) * ScaleX) + Round(yls * Scalex),
        R.Bottom - Round(T.BottomSize * ScaleY) - Round(X.BottomSize * ScaleY), R.Right - Round(Y.RightSize * ScaleX) - Round(M.FRightMargin * ScaleX), R.Bottom - Round(T.BottomSize * ScaleY));

      if (DR.Left < DR.Right) and (DR.top < DR.Bottom) then
        S.DrawXValues(Canvas, DR, false, ScaleX, ScaleY);

      rxv := DR;
    end;

    if (X.Position in [xBoth, xTop]) and (X.TopSize > 0) then
    begin
      DR := Rect(R.Left + Round((Y.LeftSize + M.FLeftMargin) * Scalex)+ Round(yls * Scalex), R.Top + Round(T.TopSize * ScaleY),
        R.Right - Round(Y.RightSize * ScaleX) - Round(M.FRightMargin * ScaleX), R.Top + Round((T.TopSize + X.TopSize) * ScaleY));

      if (DR.Left < DR.Right) and (DR.top < DR.Bottom) then
        S.DrawXValues(Canvas, DR, true, ScaleX, ScaleY);

      rxv := DR;
    end;
  end;


  DR := Rect(R.Left + Round((yl + M.LeftMargin) * ScaleX), R.Top + Round((T.TopSize + xt + M.FTopMargin) * ScaleY), R.Right - Round(yr * ScaleX) - Round(M.RightMargin * ScaleX), R.Bottom - Round(xb * ScaleY) - Round(T.BottomSize * ScaleY) - Round(M.BottomMargin * ScaleY));
  if (DR.Left < DR.Right) and (DR.Bottom > DR.Top + N.Size) then
  begin
    N.Draw(Canvas, DR, ScaleX, ScaleY);
    rnav := DR;
  end;

  DR := Rect(R.Left + Round(yl * ScaleX) + Round(M.LeftMargin * Scalex), R.Top + Round(T.TopSize * ScaleY) + Round(xt * ScaleY) + Round(M.TopMargin * ScaleY), R.Right - Round(yr * ScaleX) - Round(M.RightMargin * Scalex), R.Bottom - Round(xb * ScaleY) - Round(T.BottomSize * ScaleY) - Round(M.BottomMargin * ScaleY) - Round(N.BottomSize * ScaleY));

  sCount := 0;
  for I := 0 to Series.Count - 1 do
    if (Series[I].ChartType <> ctNone) and (Series[I].SerieType <> stZoomControl) and Series[i].Visible and Series[I].ShowInLegend then Inc(sCount);

  DR.Bottom := DR.Top + Round(L.RectangleSpacing * ScaleY) + (sCount) * Max(Round(L.RectangleSize * ScaleY) + Round(L.RectangleSpacing * ScaleY), (Canvas.TextHeight('gh') + Round(L.RectangleSpacing * ScaleY)) - Round(L.RectangleSpacing * ScaleY));

  Canvas.Font.Assign(Legend.Font);
  mw := 0;
  for i := 0 to Series.Count - 1 do
  begin
    if (Series[I].ChartType <> ctNone) and (Series[I].SerieType <> stZoomControl) and Series[i].Visible and Series[I].ShowInLegend then
    begin
      sw := Canvas.TextWidth(Series[i].LegendText) + Round(L.RectangleSize * ScaleX) + 3 * Round(L.RectangleSpacing * ScaleX);
      if sw > mw then
        mw := sw;
    end;
  end;

  DR.Right := DR.Left + mw;

  L.Draw(Canvas, DR, ScaleX, ScaleY);
  rl := Bounds(DR.Left + Round(L.Left * ScaleX), DR.Top + Round(L.Top * ScaleY) , DR.Right - DR.Left , DR.Bottom - DR.Top);

  Result := Rect(R.Left + Round((yl + M.FLeftMargin) * ScaleX), R.Top + Round((T.TopSize + xt + M.FTopMargin) * ScaleY), R.Right - Round(yr * ScaleX) - Round(M.FRightMargin * ScaleX), R.Bottom - Round(xb * ScaleY) - Round(T.BottomSize * ScaleY) - Round(M.FBottomMargin * scaleY) - Round(N.BottomSize * ScaleY));

  //Draw events
  if Assigned(OnDrawXAxis) then
    OnDrawXAxis(X, rx, Canvas);

  if Assigned(OnDrawYAxis) then
    OnDrawYAxis(Y, ry, Canvas);

  if Assigned(OnDrawXGrid) then
    OnDrawXGrid(XG, rxg, Canvas);

  if Assigned(OnDrawYGrid) then
    OnDrawYGrid(YG, ryg, Canvas);

  if Assigned(OnDrawLegend) then
    OnDrawLegend(L, rl, Canvas);

  if Assigned(OnDrawSeries) then
    OnDrawSeries(S, srct, Canvas);

  if Assigned(OnDrawTitle) then
    OnDrawTitle(T, rt, Canvas);

  if Assigned(OnDrawYValues) then
    OnDrawYValues(S, ryv, Canvas);

  if Assigned(OnDrawXValues) then
    OnDrawXValues(S, rxv, Canvas);

  if Assigned(OnDrawNavigator) then
    OnDrawNavigator(N, rnav, Canvas);
end;

function TAdvChart.SeriesRectangle(R: TRect; ScaleX, ScaleY: Double): TRect;
begin
  Result := Series.SeriesRectangle;
end;

procedure TAdvChart.FindInterSection(p1, p2, p3, p4: TPoint; var ptchk: TPointCheck);
var
  line1Point1, line1Point2, line2Point1, line2Point2: TPoint;
  r, q, d, s: Double;
begin
  ptchk.valid := false;
  line1Point1 := p1;
  line1Point2 := p2;
  line2Point1 := p3;
  line2Point2 := p4;

  q := (line1Point1.Y - line2Point1.Y)*(line2Point2.X -
    line2Point1.X) - (line1Point1.X - line2Point1.X)*(line2Point2.Y - line2Point1.Y);
  d := (line1Point2.X - line1Point1.X)*(line2Point2.Y -
    line2Point1.Y) - (line1Point2.Y - line1Point1.Y)*(line2Point2.X - line2Point1.X);

  if(d = 0) then
  begin
    Exit;
  end;

  r := q / d;


  q := (line1Point1.Y - line2Point1.Y)*(line1Point2.X - line1Point1.X) -
    (line1Point1.X - line2Point1.X)*(line1Point2.Y - line1Point1.Y);

  s := q / d;

  if((r < 0) or (r > 1) or (s < 0) or (s > 1)) then
  begin
    Exit;
  end;

  ptchk.pt.X := Round(line1Point1.X + r * (line1Point2.X - line1Point1.X));
  ptchk.pt.Y := Round(line1Point1.Y + r * (line1Point2.Y - line1Point1.Y));
  ptchk.valid := true;
end;

function TAdvChart.GetMax3DOffset: integer;
var
  i: integer;
begin
  result := 0;
  for I := 0 to Series.Count - 1 do
  begin
    with Series[I] do
    begin
      if Get3DOffset > result then
      begin
        result := Get3DOffset;
      end;
    end;
  end;
end;

function TAdvChart.GetPieLegendItemAtXY(X, Y: Integer): TChartSeriePoint;
var
  C: Integer;
  bmp: TBitmap;
  pt: Integer;
  pier: TRect;
  nr: Integer;
begin
  Result.Serie := -1;
  Result.Point := -1;
  bmp := TBitmap.Create;
  for C := 0 to Series.Count - 1 do
  begin
    with Series[C] do
    begin
      if Pie.LegendVisible and IsPieChart then
      begin
        pier := DrawLegend(bmp.Canvas, Chart.Series.SeriesRectangle, 1, 1, False);
        if (pier.Right - pier.Left > 0) and (pier.Bottom - pier.Top > 0) then
        begin
          nr := GetPointsCount;
          if PtInRect(pier, Point(X, Y)) and (nr > 0) then
          begin
            Result.Serie := C;
            pt := Floor((y - pier.Top) / ((pier.Bottom - pier.Top) / nr));
            pt := Max(0, Min(nr - 1, pt));

            if (pt >= 0) and (pt <= nr - 1) then
              Result.Point := pt
            else
              Result.Point := -1;

            break;
          end;
        end;
      end;
    end;
  end;

  bmp.Free;
end;

function TAdvChart.GetSerieIndexAtXY(X, Y: Integer): TChartSeriePoint;
var
  dm: Boolean;
  xp: integer;
  pi: Integer;
  dpi: Integer;
  diffy: Integer;
  s: Integer;
  I, K: integer;
  rsel: TRect;
  tempy: Integer;
  found: Boolean;
  ptSlice: TSlicePoint;
  ptFunnel: TFunnelPoint;
  gantth: Integer;
  pt: TChartPoint;
  ganttr: TRect;
  valY, valresy, valdiffy: Double;
begin
  Result.Serie := -1;
  Result.Point := -1;

  try
    dm := Series.IsHorizontal;
    if PtInRect(Series.SeriesRectangle, Point(X, Y)) then
    begin
      if dm then
        xp := Y - Series.SeriesRectangle.Top -  Round(GetXScaleStart)
      else
        xp := X - Series.SeriesRectangle.Left - Round(GetXScaleStart);

      pi := Range.RangeFrom;
      if XScale > 0 then
        pi := Range.RangeFrom + Round(xp / XScale);

      if Range.RangeFrom > 0 then
        dpi := pi - Range.RangeFrom
      else
        dpi := pi;

      diffy := MAXLONG;
      s := -1;
      for I := 0 to Series.Count - 1 do
        Series[I].FDPI := -1;

      for I := 0 to Series.Count - 1 do
      begin
        with Series[I] do
        begin

          case ChartType of
            ctGantt:
            begin
              gantth := GetPreviousGanttGroupHeight;
              for dpi := 0 to Length(DrawValuesDP) - 1 do
              begin
                if (dpi >= 0) and (dpi <= GetPointsCount - 1) then
                begin
                  pt := GetPoint(dpi);
                  if pt.Defined then
                  begin
                     ganttr := Bounds(DrawValuesDP[dpi].Y, Chart.Series.SeriesRectangle.Bottom - gantth - GanttSpacing - GanttHeight,  DrawValuesDP[dpi].X - DrawValuesDP[dpi].Y, GanttHeight);
                     if PtInRect(ganttr, Point(X, Y)) then
                     begin
                       S := I;
                       pi := dpi;
                       break;
                     end;
                  end;
                end;
              end;
            end;
          end;

          if (Length(FDrawValuesDP) > 0) and (ChartType <> ctGantt) then
          begin
            if (ChartType = ctXYLine) or (ChartType = ctXYMarkers) or (ChartType = ctXYDigitalLine) then
            begin
              if dm then
                pi := GetXYPoint(Y, X)
              else
                pi := GetXYPoint(X, Y);

              dpi := pi;
              FDPI := dpi;
            end;

            if (dpi >= 0) and (dpi <= Length(DrawValuesDP) - 1) then
            begin

              case ChartType of
                ctStackedBar, ctStackedPercBar, ctBar, ctLineBar, ctHistogram, ctLineHistogram:
                begin
                  rsel := Chart.Series[I].FStackedRectsBar[dpi].R;
                  if dm then
                  begin
                    if rsel.Right < rsel.Left then
                    begin
                      if PtInRect(Rect(rsel.Right, rsel.Top, rsel.Left, rsel.Bottom), Point(X, Y)) then
                      begin
                        s := I;
                        Break;
                      end;
                    end
                    else
                    begin
                      if PtInRect(rsel, Point(X, Y)) then
                      begin
                        s := I;
                        Break;
                      end;
                    end;
                  end
                  else
                  begin
                    if rsel.Bottom < rsel.Top then
                    begin
                      if PtInRect(Rect(rsel.Left, rsel.Bottom, rsel.Right, rsel.Top), Point(X, Y)) then
                      begin
                        s := I;
                        Break;
                      end;
                    end
                    else
                    begin
                      if PtInRect(rsel, Point(X, Y)) then
                      begin
                        s := I;
                        Break;
                      end;
                    end;
                  end;
                end;
                ctGantt:;
                ctHalfSpider, ctspider, ctPie, ctFunnel, ctHalfPie, ctDonut, ctHalfDonut, ctSizedPie, ctSizedHalfPie, ctSizedDonut, ctSizedHalfDonut,
                ctVarRadiusPie, ctVarRadiusHalfPie, ctVarRadiusDonut, ctVarRadiusHalfDonut:;
                else
                begin
                  if (ChartType <> ctXYLine) and (ChartType <> ctXYDigitalLine) and (ChartType <> ctXYMarkers) and (dpi >= 0) and (dpi <= Length(DrawValuesDP) - 1) then
                  begin
                    tempy := DrawValuesDP[dpi].Y;
                    if (Abs(Y - tempy) < diffy) and (Abs(Y - tempy) < 5) then
                    begin
                      diffy := Abs(Y - tempy);
                      s := I;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;


      valresy := MaxDouble;
      for I := 0 to Series.Count - 1 do
      begin
        if (Series[I].ChartType = ctXYLine) or (Series[I].ChartType = ctXYDigitalLine) or (Series[I].ChartType = ctXYMarkers) then
        begin
          if Series[I].FDPI <> -1 then
          begin
            valY := Series[I].ValueToY(Series[I].GetPoint(Series[I].FDPI).SingleValue, Series.SeriesRectangle);
            valDiffY := Abs(valY - Y);
            if valDiffY < valresy then
            begin
              valResY := valDiffY;
              S := I;
              pi := Series[I].FDpi;
            end;
          end;
        end;
      end;


      if (s <> -1) and (pi <> -1) then
      begin
        Series[s].SelectedIndex := pi;
        Result.Serie := s;
        Result.Point := pi;
        Changed;
      end;

      found := False;
      for I := 0 to Series.Count - 1 do
      begin
        with Series[I] do
        begin
          if (Length(DrawValuesSlice) > 0) or (Length(DrawValuesFunnel) > 0) then
          begin
            case ChartType of
              ctFunnel:
              begin
                for K := 0 to Length(DrawValuesFunnel) - 1 do
                begin
                  ptFunnel := DrawValuesFunnel[K];
                  if GetPoint(K).SingleValue <> 0 then
                  begin
                    if PointInFunnel(X, Y, ptFunnel) then
                    begin
                      SelectedIndex := K;
                      Changed;
                      found := true;
                      break;
                    end;
                  end;
                end;
              end;
              ctHalfSpider, ctspider, ctHalfDonut, ctDonut, ctHalfPie, ctPie, ctSizedPie, ctSizedHalfPie, ctSizedDonut,
              ctSizedHalfDonut, ctVarRadiusPie, ctVarRadiusHalfPie, ctVarRadiusDonut, ctVarRadiusHalfDonut:
              begin
                for K := 0 to Length(DrawValuesSlice) - 1 do
                begin
                  ptslice := DrawValuesSlice[K];
                  if GetPoint(K).SingleValue <> 0 then
                  begin
                    if PointInPie(X, Y, ptSlice.CX, ptSlice.CY, ptSlice.STA, ptSlice.SWA) then
                    begin
                      SelectedIndex := K;
                      Changed;
                      found := true;
                      break;
                    end;
                  end;
                end;
              end;
            end;
            if (SelectedIndex <> -1) and Found then
            begin
              Result.Serie := I;
              Result.Point := SelectedIndex;
              break;
            end;
          end;
        end;
      end;
    end;
  except

  end;
end;

function TAdvChart.GetTotalXAxisSize(R: TRect; Bottom: Boolean): Integer;
var
  totalmax: integer;
  I: integer;
  bmp: TBitmap;
  chk: Boolean;
  tot: Integer;
begin
  bmp := TBitmap.Create;

  result := XAxis.Size;
  totalmax := 0;
  for I := 0 to Series.Count - 1 do
  begin
    if (Series.Items[I].ChartType <> ctNone) and (Series.Items[I].SerieType <> stZoomControl) and Series.Items[i].Visible then
    begin
      if Bottom then
        chk := (Series[i].XAxis.Position in [xBottom, xBoth])
      else
        chk := (Series[i].XAxis.Position in [xTop, xBoth]);

      if chk then
        totalmax := totalmax + Series[i].GetXValuesSize(bmp.Canvas, 1, 1, tot);
    end;
  end;

  if totalmax > XAxis.Size then
    Result := totalmax;

  bmp.Canvas.Font.Assign(XAxis.Font);
  Result := Result + bmp.Canvas.TextHeight(XAxis.Text);
  bmp.Free;
end;

function TAdvChart.GetTotalYAxisLeftSize: Integer;
var
  r: TRect;
begin
  if Assigned(GetPaneRectangle) then
  begin
    GetPaneRectangle(Self, r);
    Result := GetTotalYAxisSize(r, False);
  end
  else
    Result := YAxis.Size
end;

function TAdvChart.GetTotalYAxisRightSize: Integer;
var
  r: TRect;
begin
  if Assigned(GetPaneRectangle) then
  begin
    GetPaneRectangle(Self, r);
    Result := GetTotalYAxisSize(r, True);
  end
  else
    Result := YAxis.Size
end;

function TAdvChart.GetTotalYAxisSize(R: TRect; Right:Boolean): Integer;
var
  I: Integer;
  totalmax: integer;
  bmp: TBitmap;
  chk: Boolean;
begin
  bmp := TBitmap.Create;
  result := YAxis.Size;
  totalmax := 0;

  for I := 0 to Series.Count - 1 do
  begin
    if Right then
      chk := (Series[i].YAxis.Position in [yRight, yBoth])
    else
      chk := (Series[i].YAxis.Position in [yLeft, yBoth]);

    if chk then
      totalmax := totalmax + Series[i].GetYValuesSize(R, bmp.Canvas, 1, 1);
  end;

  if totalmax > YAxis.Size then
    Result := totalmax;

  bmp.Canvas.Font.Assign(YAxis.Font);
  Result := Result + bmp.Canvas.TextHeight(YAxis.Text) + 10;
  bmp.Free;
end;

function TAdvChart.GetXAxisBottomRect(R: TRect): TRect;
var
  DR: TRect;
  X: TChartXAxis;
  Y: TChartYAxis;
  T: TChartTitle;
  M: TChartMargin;
  N: TChartNavigator;
  dm: Boolean;
  xt, yl, xb: integer;
begin
  X := XAxis;
  Y := YAxis;
  M := Margin;
  N := Navigator;
  T := Title;
  dm := Series.IsHorizontal;

  DR := Rect(0,0,0,0);

  if dm then
  begin
    xt := Y.LeftSize;
    yl := X.BottomSize;
    xb := Y.RightSize;
  end
  else
  begin
    xt := X.TopSize;
    yl := Y.LeftSize;
    xb := X.BottomSize;
  end;

  if dm then
  begin
    if (X.Position in [xBoth, xBottom]) and (X.BottomSize > 0) then
    begin
      DR := Rect(R.Left, R.Top + T.TopSize + xt + M.FTopMargin,
        R.Left + yl, R.Bottom - xb -
          T.BottomSize - M.FBottomMargin - N.BottomSize);
    end;
  end
  else
  begin
    if (X.Position in [xBoth, xBottom]) and (X.BottomSize > 0) then
    begin
      DR := Rect(R.Left + Y.LeftSize + M.LeftMargin,
        R.Bottom - T.BottomSize - X.BottomSize, R.Right - Y.RightSize - M.FRightMargin, R.Bottom - T.BottomSize);
    end;
  end;

  Result := DR;
end;


function TAdvChart.GetXAxisTopRect(R: TRect): TRect;
var
  DR: TRect;
  X: TChartXAxis;
  Y: TChartYAxis;
  T: TChartTitle;
  M: TChartMargin;
  N: TChartNavigator;
  dm: Boolean;
  xt, xb, yr: integer;
begin
  X := XAxis;
  Y := YAxis;
  M := Margin;
  N := Navigator;
  T := Title;
  dm := Series.IsHorizontal;

  DR := Rect(0,0,0,0);

  if dm then
  begin
    xt := Y.LeftSize;
    xb := Y.RightSize;
    yr := X.TopSize;
  end
  else
  begin
    xt := X.TopSize;
    xb := X.BottomSize;
    yr := Y.RightSize;
  end;

  if dm then
  begin
    if (X.Position in [xBoth, xTop]) and (X.TopSize > 0) then
    begin
      DR := Rect(R.Right - yr, R.Top + T.TopSize + xt + M.FTopMargin,
        R.Right, R.Bottom - xb -  T.BottomSize - M.FBottomMargin - N.BottomSize);

    end;
  end
  else
  begin
    if (X.Position in [xBoth, xTop]) and (X.TopSize > 0) then
    begin
      DR := Rect(R.Left + Y.LeftSize + M.FLeftMargin, R.Top + T.TopSize,
        R.Right - Y.RightSize - M.FRightMargin, R.Top + T.TopSize + X.TopSize);
    end;
  end;

  Result := DR;
end;

function TAdvChart.GetXAxisValue(X, Y: Integer; R: TRect): TXAxisRangeValue;
var
  I, K: integer;
  tr, br: TRect;
  bmp: TBitmap;
  fv, tv: Integer;
  xs: Double;
  xm: Integer;
  Xi: Integer;
  cnt: integer;
begin
  Result.RangeIndex := -1;
  Result.Serie := -1;
  tR := GetXAxisTopRect(R);
  bR := GetXAxisBottomRect(R);

  bmp := TBitmap.Create;


  cnt := 0;
  for I := 0 to Series.Count - 1 do
  begin
    if (Series.Items[I].ChartType <> ctNone) and (Series.Items[I].SerieType <> stZoomControl) and Series.Items[i].Visible and Series.Items[i].XAxis.Visible then
    begin
      Inc(cnt);
    end;
  end;

  K := 0;
  for I := 0 to Series.Count - 1 do
  begin
    if (Series.Items[I].ChartType <> ctNone) and (Series.Items[I].SerieType <> stZoomControl) and Series.Items[i].Visible and Series.Items[i].XAxis.Visible then
    begin
      with Series.Items[i] do
      begin
        if XAxis.Visible then
        begin
          fv := Chart.Range.RangeFrom;
          tv := Chart.Range.RangeTo;

          xs := Chart.XScale;

          for Xi := fv to tv do
          begin
            if Chart.Series.IsHorizontal then
            begin
              xm := tR.Top + Round(((Xi - Chart.Range.RangeFrom) * xs) + GetXScaleStart);
              if PtInRect(Bounds(tr.Left + ((tr.Right - tr.Left) div cnt) * k , xm - Round(GetXScaleStart), (tr.Right - tr.Left) div cnt, Round(xs)), Point(X, Y)) then
              begin
                Result.RangeIndex := Xi;
                Result.Serie := I;
                break;
              end;

              xm := bR.Top + Round(((Xi - Chart.Range.RangeFrom) * xs) + GetXScaleStart);
              if PtInRect(Bounds(br.Right - ((br.Right - br.Left) div cnt) * (k + 1), xm - Round(GetXScaleStart), (br.Right - br.Left) div cnt, Round(xs)), Point(X, Y)) then
              begin
                Result.RangeIndex := Xi;
                Result.Serie := I;
                break;
              end;
            end
            else
            begin
              xm := tR.Left + Round(((Xi - Chart.Range.RangeFrom) * xs) + GetXScaleStart);
              if PtInRect(Bounds(xm - Round(GetXScaleStart), tr.Bottom  - ((tr.Bottom - tr.Top) div cnt) * (K + 1), Round(xs), (tr.Bottom - tr.Top) div cnt), Point(X, Y)) then
              begin
                Result.RangeIndex := Xi;
                Result.Serie := I;
                break;
              end;
              xm := bR.Left + Round(((Xi - Chart.Range.RangeFrom) * xs) + GetXScaleStart);
              if PtInRect(Bounds(xm - Round(GetXScaleStart), br.Top + ((br.Bottom - br.Top) div cnt) * k, Round(xs), (br.Bottom - br.Top) div cnt), Point(X, Y)) then
              begin
                Result.RangeIndex := Xi;
                Result.Serie := I;
                break;
              end;
            end;
          end;

          Inc(K);

        end;
      end;
    end;
  end;

  bmp.Free;
end;

function TAdvChart.GetXScaleStart: Double;
begin
  Result := 0;
  if XScaleOffset then
    Result := XScale / 2;
end;

function TAdvChart.GetYAxisRect(R: TRect): TRect;
var
  DR: TRect;
  X: TChartXAxis;
  Y: TChartYAxis;
  T: TChartTitle;
  N: TChartNavigator;
  dm: Boolean;
  xt, yl, xb, yr: integer;
begin
  if FUpdateCount > 0 then
    Exit;

  X := XAxis;
  Y := YAxis;
  N := Navigator;
  T := Title;
  dm := Series.IsHorizontal;

  if dm then
  begin
    xt := Y.LeftSize;
    yl := X.BottomSize;
    xb := Y.RightSize;
    yr := X.TopSize;
  end
  else
  begin
    xt := X.TopSize;
    yl := Y.LeftSize;
    xb := X.BottomSize;
    yr := Y.RightSize;
  end;

  if dm then
  begin
    DR := Rect(R.Left + yl, R.Top + T.TopSize + xt,
      R.Right - yr, R.Bottom - xb -
        T.BottomSize - N.BottomSize);
  end
  else
  begin
    DR := Rect(R.Left + yl, R.Top + T.TopSize + xt,
      R.Right - yr, R.Bottom - xb - T.BottomSize - N.BottomSize);
  end;

  Result := DR;
end;

function TAdvChart.GetYAxisValue(X, Y: Integer; R: TRect): TYAxisRangeValue;
var
  jmax, jmin: double;
  jminstr, jmaxstr: string;
  th, tw: integer;
  domaj, domin, domajv, dominv: boolean;
  htpane, httext: integer;
  mu, mi: double;
  min, max: Double;
  yx: TChartSerieYAxis;
  majsl, minsl, majsr, minsr: integer;
  ARect: TRect;
  defaultdraw: boolean;
  j: Double;
  dm: Boolean;
  s: String;
  k: integer;
  compareval: Boolean;
  bmp: TBitmap;
  I: integer;
  pxLeft, pyLeft, pxRight, pyRight: Integer;
begin

  R := Self.GetYAxisRect(R);
  Result.Serie := -1;
  Result.ValueStr := '';
  pxLeft := 0;
  pxRight := 0;
  pyLeft := 0;
  pyRight := 0;
  th := 0;
  tw := 0;

  bmp := TBitmap.Create;
  for I := 0 to Series.Count - 1 do
  begin
    with Series[i] do
    begin
      dm := Chart.Series.IsHorizontal;
      min := MinimumValue;
      max := MaximumValue;

      Yx := YAxis;

      if ((Collection as TChartSeries).FOwner.YAxis.FAutoUnits) or YAxis.AutoUnits then
      begin
        if dm then
        begin
          htpane := R.Right - R.Left;

          bmp.Canvas.Font.Assign(yx.MajorFont);
          httext := bmp.Canvas.TextWidth('WW') + 4;
          mu := MinMaxToUnit(min, max, Round(htpane / (2 * httext)));

          bmp.Canvas.Font.Assign(yx.MinorFont);
          httext := bmp.Canvas.TextWidth('WW') + 4;
          mi := MinMaxToUnit(min, max, Round(htpane / (2 * httext)));
        end
        else
        begin
          htpane := R.Bottom - R.Top;

          bmp.Canvas.Font.Assign(yx.MajorFont);
          httext := bmp.Canvas.TextHeight('gh') + 4;
          mu := MinMaxToUnit(min, max, Round(htpane / (2 * httext)));

          bmp.Canvas.Font.Assign(yx.MinorFont);
          httext := bmp.Canvas.TextHeight('gh') + 4;
          mi := MinMaxToUnit(min, max, Round(htpane / (2 * httext)));
        end;
      end
      else
      begin
        mu := Yx.MajorUnit;
        mi := Yx.MinorUnit;
      end;

      if Logarithmic then
        mu := 1;

      k := 0;
      if Yx.Visible then
      begin
        JMax := min;
        JMin := min;
        if Chart.YAxis.AutoSize then
        begin
          majsl := GetYMajorUnitSpacing(False);
          minsl := GetYMinorUnitSpacing(False);
          majsr := GetYMajorUnitSpacing(True);
          minsr := GetYMajorUnitSpacing(True);
        end
        else
        begin
          majsl := yx.MajorUnitSpacing;
          minsl := yx.MinorUnitSpacing;
          majsr := majsl;
          minsr := minsl;
        end;
    //    ex := false;

        // calculate first value to display

        domaj := (mu > 0);
        domin := (mi > 0);

        if domin then
          Jmin := Round(min / mi)  * mi;

        if domaj then
          Jmax := Round(min / mu)  * mu;

        bmp.Canvas.Brush.Style := bsClear;

        //Y - Values

        if (domaj) then
        begin
          while (JMin <= max + mu) do
          begin
            domajv := JMax <= max + mu;
            if domajv then
            begin
              bmp.Canvas.Font.Assign(yx.FMajorFont);

              if Logarithmic then
              begin
                if (JMax <= LOGARITHMICMAX) and (JMax >= -LOGARITHMICMAX) then
                begin
                  if FValueFormat <> '' then
                  begin
                    case ValueFormatType of
                      vftNormal: s := Format(FValueFormat,[Power(10, Jmax)]);
                      vftFloat: s := FormatFloat(FValueFormat,Power(10, Jmax));
                    end;
                  end
                  else
                    s := FloatToStr(Power(10, Jmax));
                end;
              end
              else
              begin
                if FValueFormat <> '' then
                begin
                  case ValueFormatType of
                    vftNormal: s := Format(FValueFormat,[Jmax]);
                    vftFloat: s := FormatFloat(FValueFormat,Jmax);
                  end;
                end
                else
                  s := FloatToStr(JMax);
              end;

              if dm then
                th := bmp.Canvas.TextWidth(s)
              else
                th := bmp.Canvas.TextHeight('gh');

              if dm then
                tw := bmp.Canvas.TextHeight(s)
              else
                tw := bmp.Canvas.TextWidth(s);

              defaultdraw := true;

              if (yx.Position in [yLeft,yBoth]) then
              begin
                if dm then
                begin
                  ARect.Top := 0;
                  ARect.Left := ValueToY(JMax, Chart.Series.SeriesRectangle) - (th div 2);
                  ARect.Right := ARect.Left + th;
                  ARect.Bottom := r.Top;
                end
                else
                begin
                  ARect.Left := 0;
                  ARect.Top := ValueToY(JMax, Chart.Series.SeriesRectangle) - (th div 2);
                  ARect.Bottom := ARect.Top + th;
                  ARect.Right := r.Left;
                end;

                defaultdraw := true;

                if Assigned(FOnYAxisDrawValue) then
                  FOnYAxisDrawValue(Self, Series[i], bmp.Canvas, ARect, JMax, true, defaultdraw);
              end;

              if (yx.Position in [yRight,yBoth]) then
              begin
                if dm then
                begin
                  ARect.Top := R.Bottom;
                  ARect.Left := ValueToY(JMax, Chart.Series.SeriesRectangle) - (th div 2);
                  ARect.Right := ARect.Left + th;
                  ARect.Bottom := ARect.Top + Chart.FYAxis.RightSize;
                end
                else
                begin
                  ARect.Left := R.Right;
                  ARect.Top := ValueToY(JMax, Chart.Series.SeriesRectangle) - (th div 2);
                  ARect.Bottom := ARect.Top + th;
                  ARect.Right := ARect.Left + Chart.FYAxis.RightSize;
                end;

                defaultdraw := true;

                if Assigned(FOnYAxisDrawValue) then
                  FOnYAxisDrawValue(Self, Series[i], bmp.Canvas, ARect, JMax, true, defaultdraw);
              end;

              if (defaultdraw) then
              begin
                JMaxStr := s;
                if Assigned(OnYAxisGetValue) then
                  OnYAxisGetValue(Self,Series[i], JMax, JMaxStr);

                if yx.MajorUnitVisible then
                begin
                  if dm then
                  begin
                    if (ValueToY(JMax, Chart.Series.SeriesRectangle) >= R.Left) and (ValueToY(jmax, Chart.Series.SeriesRectangle) <= R.Right) then
                    begin
                      case yx.FPosition of
                        yLeft:
                        begin
                          pxLeft := ValueToY(JMax, Chart.Series.SeriesRectangle) - (th div 2);
                          pyLeft := R.Top -  majsl - bmp.Canvas.TextHeight(JMaxStr) - yx.TickMarkSize;
                        end;
                        yRight:
                        begin
                          pxRight := ValueToY(JMax, Chart.Series.SeriesRectangle) - (th div 2);
                          pyRight := R.Bottom + majsr + yx.TickMarkSize;
                        end;
                        yBoth:
                        begin
                          pxLeft := ValueToY(JMax, Chart.Series.SeriesRectangle) - (th div 2);
                          pyLeft := R.Top -  majsl - bmp.Canvas.TextHeight(JMaxStr) - yx.TickMarkSize;
                          pxRight := ValueToY(JMax, Chart.Series.SeriesRectangle) - (th div 2);
                          pyRight := R.Bottom + majsr + yx.TickMarkSize;
                        end;
                      end;
                    end;
                  end
                  else
                  begin
                    if (ValueToY(JMax, Chart.Series.SeriesRectangle) <= R.Bottom) and (ValueToY(jmax, Chart.Series.SeriesRectangle) >= R.Top) then
                    begin
                      case yx.FPosition of
                        yLeft:
                        begin
                          pxLeft := R.Left -  majsl - bmp.Canvas.TextWidth(JMaxStr) - yx.TickMarkSize;
                          pyLeft := ValueToY(JMax, Chart.Series.SeriesRectangle) - (th div 2);
                        end;
                        yRight:
                        begin
                          pxRight := R.Right + majsr + yx.TickMarkSize;
                          pyRight := ValueToY(JMax, Chart.Series.SeriesRectangle) - (th div 2);
                        end;
                        yBoth:
                        begin
                          pxLeft := R.Left -  majsl - bmp.Canvas.TextWidth(JMaxStr) - yx.TickMarkSize;
                          pyLeft := ValueToY(JMax, Chart.Series.SeriesRectangle) - (th div 2);
                          pxRight := R.Right + majsr + yx.TickMarkSize;
                          pyRight := ValueToY(JMax, Chart.Series.SeriesRectangle) - (th div 2);
                        end;
                      end;
                    end;
                  end;
                end;
              end;
            end;

            if PtInRect(Bounds(pxLeft, pyLeft, tw, th), Point(X, Y)) or PtInRect(Bounds(pxRight, pyRight, tw, th), Point(X, Y)) then
            begin
              Result.Serie := I;
              Result.ValueStr := jmaxstr;
              Result.Value := JMax;
              Result.Mode := vmMajor;
            end;

            dominv := JMin <= max + mu;
            if dominv and domin then
            begin
              while (JMin <> JMax) and (JMax > jmin) do
              begin
                if Logarithmic then
                begin
                  j := JMin - (K - 1);
                  if (K <= LOGARITHMICMAX) and (K >= -LOGARITHMICMAX) then
                    j := j * Power(10, K);

                  if FValueFormat <> '' then
                  begin
                    case ValueFormatType of
                      vftNormal: s := Format(FValueFormat,[j]);
                      vftFloat: s := FormatFloat(FValueFormat,j);
                    end;
                  end
                  else
                    s := floattostr(j);

                  j := ConvertToLog(j);
                end
                else
                begin
                  j := Jmin;
                  if FValueFormat <> '' then
                  begin
                    case ValueFormatType of
                      vftNormal: s := Format(FValueFormat,[j]);
                      vftFloat: s := FormatFloat(FValueFormat,j);
                    end;
                  end
                  else
                    s := floattostr(j);
                end;
                bmp.Canvas.Font.Assign(yx.MinorFont);
                if dm then
                  th := bmp.Canvas.TextWidth(s)
                else
                  th := bmp.Canvas.TextHeight('gh');

                if dm then
                  tw := bmp.Canvas.TextHeight(s)
                else
                  tw := bmp.Canvas.TextWidth(s);

                defaultdraw := true;

                if (yx.Position in [yLeft,yBoth]) then
                begin
                  if dm then
                  begin
                    ARect.Top := 0;
                    ARect.Left := ValueToY(j, Chart.Series.SeriesRectangle) - (th div 2);
                    ARect.Right := ARect.Left + th;
                    ARect.Bottom := r.Top;
                  end
                  else
                  begin
                    ARect.Left := 0;
                    ARect.Top := ValueToY(j, Chart.Series.SeriesRectangle) - (th div 2);
                    ARect.Bottom := ARect.Top + th;
                    ARect.Right := r.Left;
                  end;

                  defaultdraw := true;

                  if Assigned(FOnYAxisDrawValue) then
                    FOnYAxisDrawValue(Self, Series[i], bmp.Canvas, ARect, j, true, defaultdraw);
                end;

                if (yx.Position in [yRight,yBoth]) then
                begin
                  if dm then
                  begin
                    ARect.Top := R.Bottom;
                    ARect.Left := ValueToY(j, Chart.Series.SeriesRectangle) - (th div 2);
                    ARect.Right := ARect.Left + th;
                    ARect.Left := ARect.Right + Chart.FYAxis.LeftSize;
                  end
                  else
                  begin
                    ARect.Left := R.Right;
                    ARect.Top := ValueToY(j, Chart.Series.SeriesRectangle) - (th div 2);
                    ARect.Bottom := ARect.Top + th;
                    ARect.Right := ARect.Left + Chart.FYAxis.RightSize;
                  end;
                  defaultdraw := true;

                  if Assigned(FOnYAxisDrawValue) then
                    FOnYAxisDrawValue(Self, Series[i], bmp.Canvas, ARect, j, true, defaultdraw);
                end;

                compareval := false;
                if Logarithmic and (JMax <= LOGARITHMICMAX) and (JMax >= -LOGARITHMICMAX) then
                  compareval := (CompareValue(Round((JMin - (JMax - 1)) * Power(10, JMax)), Round(Power(10, JMax - 1))) = 0);

                if not Logarithmic or (Logarithmic and not compareval) then
                begin
                  if (defaultdraw) and (Jmin <> JMax) then
                  begin
                    JMinstr := s;
                    if Assigned(OnYAxisGetValue) then
                      OnYAxisGetValue(Self, Series[i], j, JMinStr);

                    if yx.MinorUnitVisible then
                    begin
                      if dm then
                      begin
                        if (ValueToY(j, Chart.Series.SeriesRectangle) >= R.Left) and (ValueToY(j, Chart.Series.SeriesRectangle) <= R.Right) then
                        begin
                          case yx.FPosition of
                            yLeft:
                            begin
                              pxLeft := ValueToY(j, Chart.Series.SeriesRectangle) - (th div 2);
                              pyLeft := R.Top -  minsl - bmp.Canvas.TextHeight(JMinStr) - yx.TickMarkSizeMinor;
                            end;
                            yRight:
                            begin
                              pxRight := ValueToY(j, Chart.Series.SeriesRectangle) - (th div 2);
                              pyRight := R.Bottom + minsr + yx.TickMarkSizeMinor;
                            end;
                            yBoth:
                            begin
                              pxLeft := ValueToY(j, Chart.Series.SeriesRectangle) - (th div 2);
                              pyLeft := R.Top -  minsl - bmp.Canvas.TextHeight(JMinStr) - yx.TickMarkSizeMinor;
                              pxRight := ValueToY(j, Chart.Series.SeriesRectangle) - (th div 2);
                              pyRight := R.Bottom + minsr + yx.TickMarkSizeMinor;
                            end;
                          end;
                        end;
                      end
                      else
                      begin
                        if (ValueToY(j, Chart.Series.SeriesRectangle) <= R.Bottom) and (ValueToY(j, Chart.Series.SeriesRectangle) >= R.Top) then
                        begin
                          case yx.FPosition of
                            yLeft:
                            begin
                              pxLeft := R.Left -  minsl - bmp.Canvas.TextWidth(JMinStr) - yx.TickMarkSizeMinor;
                              pyLeft := ValueToY(j, Chart.Series.SeriesRectangle) - (th div 2);
                            end;
                            yRight:
                            begin
                              pxRight := R.Right + minsr + yx.TickMarkSizeMinor;
                              pyRight := ValueToY(j, Chart.Series.SeriesRectangle) - (th div 2);
                            end;
                            yBoth:
                            begin
                              pxLeft := R.Left -  minsl - bmp.Canvas.TextWidth(JMinStr) - yx.TickMarkSizeMinor;
                              pyLeft := ValueToY(j, Chart.Series.SeriesRectangle) - (th div 2);
                              pxRight := R.Right + minsr + yx.TickMarkSizeMinor;
                              pyRight := ValueToY(j, Chart.Series.SeriesRectangle) - (th div 2);
                            end;
                          end;
                        end;
                      end;
                    end;
                  end;
                end;

                if PtInRect(Bounds(pxLeft, pyLeft, tw, th), Point(X, Y)) or PtInRect(Bounds(pxRight, pyRight, tw, th), Point(X, Y)) then
                begin
                  Result.Serie := I;
                  Result.ValueStr := jminstr;
                  Result.Value := j;
                  Result.Mode := vmMinor;
                  break;
                end;

                JMin := JMin + mi;

                if CompareValue(Jmin, Jmax) = 0 then
                  JMin := JMin + mi;
              end;
            end;

            if not domin then
            begin
              JMin := JMin + mu;
            end
            else
            begin
              if CompareValue(Jmin, Jmax) = 0 then
              begin
                JMin := JMin + mi;
              end;
            end;

            Jmax := JMax + mu;
            Inc(K);
            if (JMax > max + mu) then
              break;
          end;
        end;
      end;
    end;
  end;
  bmp.Free;
end;

procedure TAdvChart.Initialize(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double);
var
  c: Double;
  rf: integer;
  rt: integer;
begin
  rf := Range.RangeFrom;
  rt := Range.rangeTo;
  c := rt - rf;
  if XScaleOffset then
    c := c + 1;

  if (c > 0) then
  begin
    if Series.IsHorizontal then
    begin
      if XAxis.Enable3D then
        XScale := (R.Bottom - R.Top - GetMax3DOffset - XAxis.Offset3D) / (c)
      else
        XScale := (R.Bottom - R.Top - GetMax3DOffset) / (c)
    end
    else
    begin
      if XAxis.Enable3D then
        XScale := (R.Right - R.Left - GetMax3DOffset - XAxis.Offset3D) / (c)
      else
        XScale := (R.Right - R.Left - GetMax3DOffset) / (c)
    end;
  end
  else
    XScale := 1;

  if Range.FForceMaxRangeTo then
  begin
    Range.MaxRangeTo := rt;
    Range.FForceMaxRangeTo := false;
  end;

  CalculateYScale(R, ScaleX, ScaleY);
end;

procedure TAdvChart.LegendChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvChart.BackgroundChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvChart.BandsChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvChart.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TAdvChart.MarginChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvChart.NavigatorChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvChart.CalculateYScale(R: TRect; ScaleX, ScaleY: Double);
var
  I: integer;
begin
  if (not FForceInitYScale) then
  begin
    for I := 0 to FSeries.Count - 1 do
    begin
      with Series.Items[I] do
      begin
        if (SerieType <> stZoomControl) and Visible then
        begin
          if (MinimumValue <> MaximumValue) then
          begin
            if Series.IsHorizontal then
            begin
              if self.YAxis.Enable3D then
                FYScale := (R.Right - R.Left - self.YAxis.Offset3D) / (MaximumValue - MinimumValue)
              else
                FYScale := (R.Right - R.Left) / (MaximumValue - MinimumValue)
            end
            else
            begin
              if self.YAxis.Enable3D then
                FYScale := (R.Bottom - R.Top - self.YAxis.Offset3D) / (MaximumValue - MinimumValue)
              else
                FYScale := (R.Bottom - R.Top) / (MaximumValue - MinimumValue)
            end;
          end
          else
            FYScale := 1;

          if FYScale >= 1e12 then
            FYScale := 1e12;

          if FYScale <= 1e-12 then
            FYScale := 1e-12;

          OriginalYScale := FYScale;
        end;
      end;
    end;
  end;
end;

procedure TAdvChart.Changed;
begin
  if FUpdateCount = 0 then
    if Assigned(FOnChange) then
      FOnChange(Self);
end;

procedure TAdvChart.RangeChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvChart.ResetUpdate;
begin
  FUpdateCount := 0;
end;

procedure TAdvChart.DrawZeroLine(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double);
var
  I: integer;
begin
  for I := 0 to FSeries.Count - 1 do
  begin
    with Fseries.Items[I] do
    begin
      if (ZeroLine = true) and (FZeroLineWidth > 0) then
      begin
        Canvas.Pen.Color := FZeroLineColor;
        Canvas.Pen.Width := Round(FZeroLineWidth * ScaleX);
        Canvas.Pen.Style := psSolid;
        if Series.IsHorizontal then
        begin
          Canvas.MoveTo(ValueToY(FZeroReferencePoint, R), r.Top);
          Canvas.LineTo(ValueToY(FZeroReferencePoint, R), r.Bottom);
        end
        else
        begin
          Canvas.MoveTo(R.Left, ValueToY(FZeroReferencePoint, R));
          Canvas.LineTo(R.Right, ValueToY(FZeroReferencePoint, R));
        end;
      end;
    end;
  end;
end;

procedure TAdvChart.EndUpdate(Canvas: TCanvas; R: TRect);
begin
  if FUpdateCount > 0 then
    Dec(FUpdateCount);

  if FUpdateCount = 0 then
    InitializeChart(Canvas, R, 1, 1);
end;

procedure TAdvChart.SaveChart(c: TCanvas; R: TRect);
begin
  Draw(c, R, 1, 1, true);
end;

procedure TAdvChart.SaveToImage(Filename: String; ImageWidth, ImageHeigth: integer);
var
  finalbmp: Graphics.TBitmap;
begin
  finalbmp := Graphics.TBitmap.Create;
  finalbmp.Width := Imagewidth;
  finalbmp.Height := ImageHeigth;
  SaveChart(finalbmp.Canvas, rect(0, 0, ImageWidth, ImageHeigth));
  finalbmp.SaveToFile(Filename);
  finalbmp.Free;
end;

procedure TAdvChart.SeriesChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvChart.SetAxisMode(const Value: TChartAxisMode);
begin
  if FAxisMode <> value then
  begin
    FAxisMode := Value;
    Changed;
  end;
end;

procedure TAdvChart.SetMinMax;
var
  I, sb, sa, K: Integer;
  cmax, cmin: Double;
  stmax: Double;
  offs: Double;
  d: Double;
  max: Double;
  fv, tv: Integer;
  J: Integer;
begin
  cmax := -MAXLONG;
  cmin := MAXLONG;
  sb := Series.GetCountChartType(ctStackedBar);
  sa := Series.GetCountChartType(ctStackedArea);

  for I := 0 to Series.Count - 1 do
    with Series.Items[I] do
      if (SerieType <> stZoomControl) and Visible then
        SetMinMax(Range.RangeFrom, Range.RangeTo);

  for I := 0 to Series.Count - 1 do
  begin
    with Series.Items[I] do
    begin
      if (SerieType <> stZoomControl) and Visible then
      begin
        if (AutoRange in [arCommon, arCommonZeroBased]) and (Series.Mode = cmInit) then
        begin
          case Charttype of
            ctStackedPercArea, ctStackedPercBar:
            begin
              cmax := 100;
              cmin := 0;
            end;
            ctStackedBar, ctStackedArea:
            begin
              if (sa > 1) or (sb > 1) then
              begin
                if UseFullRange then
                begin
                  fv := 0;
                  tv := GetPointsCount - 1;
                end
                else
                begin
                  if Range.RangeFrom < 0 then
                    fv := 0
                  else
                    fv := Range.RangeFrom;

                  if Range.RangeTo < GetPointsCount - 1 then
                    tv := Range.RangeTo
                  else
                    tv := GetPointsCount - 1;
                end;

                for J := fv to tv do
                begin
                  stmax := 0;
                  for K := 0 to Series.Count - 1 do
                  begin
                    if (Series.Items[K].SerieType <> stZoomControl) and Series.Items[K].Visible then
                    begin
                      if (Series.Items[K].AutoRange in [arCommon, arCommonZeroBased]) and (Series.Mode = cmInit) then
                      begin
                        if Series[K].GroupIndex = GroupIndex then
                        begin
                          if j < Series[k].GetPointsCount then
                            stMax := stMax + Series[k].GetPoint(j).SingleValue;
                        end;
                      end;
                    end;
                  end;

                  if stmax > cmax then
                  begin
                    cmax := stmax;
                    FSerieMax := cmax;
                  end;
                end;

                FSerieMax := 0;
                FSerieMin := 0;
                cmin := 0;
              end
              else
              begin
                if cmax < FSerieMax  then
                  cmax := FSerieMax;
                if cmin > FSerieMin then
                  cmin := FSerieMin;
              end;
            end;
            else
            begin
              if cmax < FSerieMax  then
                cmax := FSerieMax;
              if cmin > FSerieMin then
                cmin := FSerieMin;
            end;
          end;
        end;
      end;
    end;
  end;

  for I := 0 to Series.Count - 1 do
  begin
    with Series.Items[I] do
    begin
      if (SerieType <> stZoomControl) and Visible then
      begin
        if (Series.Mode = cmInit) then
        begin
          if Autorange = arCommonZeroBased then
          begin
            cmin := 0;
          end;
          if AutoRange in [arCommon, arCommonZeroBased] then
          begin
            FSerieMax := cmax;
            FSerieMin := cmin;

            if (AutoRange = arCommon) or (AutoRange = arCommonZeroBased) then
              offs := ((RangePercentMargin * Abs(FSerieMax - FSerieMin)) / 100)
            else
              offs := 0;

            FSerieMax := FSerieMax + offs;
            if (AutoRange = arCommon) then
              FSerieMin := FSerieMin - offs;

            MaximumValue := FserieMax;
            MinimumValue := FSerieMin;
          end;
        end;
      end;
    end;
  end;

  max := 0;
  for I := 0 to Series.Count - 1 do
  begin
    with Series[I] do
    begin
      if Logarithmic and not (AutoRange = ardisabled) then
      begin
        //Logaritmic
        d := ConvertToLog(GetMaximumValue);
        d := int(d) + 1;
        MaximumValue := d + ((RangePercentMargin * d) / 100);
        MinimumValue := 0;
        if MaximumValue > max then
          max := MaximumValue;
      end;
    end;
  end;

  for I := 0 to Series.Count - 1 do
  begin
    with Series[I] do
    begin
      if Logarithmic then
      begin
        if AutoRange in [arCommon, arCommonZeroBased] then
        begin
          MaximumValue := max;
        end;
      end;
    end;
  end;

  for I := 0 to Series.Count - 1 do
  begin
    with Series[I] do
    begin
      if (AutoRange <> arDisabled) and (MaximumValue = MinimumValue) then
      begin
        MaximumValue := FMax;
        MinimumValue := FMin;
        FSerieMax := FMax;
        FSerieMin := FMin;
        FSerieMaxValue := FMax;
        FSerieMinValue := FMin;
      end;
    end;
  end;
end;

procedure TAdvChart.SetXScale(const Value: double);
begin
  if (FXScale <> Value) then
  begin
    FXScale := Value;
    Changed;
  end;
end;

procedure TAdvChart.SetXScaleOffset(const Value: Boolean);
begin
  if FXScaleOffset <> Value then
  begin
    FXScaleOffset := Value;
    Changed;
  end;
end;

procedure TAdvChart.TitleChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvChart.XAxisChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvChart.XGridChanged(Sender: TObject);
begin
  Changed;
end;

function TAdvChart.XYToSeriePoint(X, Y: Integer): TChartSeriePoint;
begin
  Result := GetSerieIndexAtXY(X, Y);
end;

procedure TAdvChart.YAxisChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvChart.YGridChanged(Sender: TObject);
begin
  Changed;
end;

{ TChartBackground }

procedure TChartBackground.Assign(Source: TPersistent);
begin
  if Source is TChartBackground then
  begin
    FColor := (Source as TChartBackground).Color;
    FFont.Assign((Source as TChartBackground).Font);
    FColorTo := (Source as TChartBackground).ColorTo;
    FPicture.Assign((Source as TChartBackground).Picture);
    FBackgroundPosition := (Source as TChartBackground).BackGroundPosition;
    FGradientDirection := (Source as TChartBackground).GradientDirection;
    FGradientSteps := (Source as TChartBackground).GradientSteps;
    FPictureVisible := (Source as TchartBackground).PictureVisible;
  end;
end;

procedure TChartBackground.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TChartBackground.Create(AOwner: TAdvChart);
begin
  FPicture := TPicture.Create;
  FPicture.OnChange := PictureChanged;
  FColor := clNone;
  FColorTo := clNone;
  FBackgroundPosition := bpTopLeft;
  FGradientSteps := 100;
  FPictureVisible := false;
  FOwner := AOwner;
  FFont := TFont.Create;
end;

destructor TChartBackground.Destroy;
begin
  FPicture.Free;
  FFont.Free;
  inherited;
end;

procedure TChartBackground.Draw(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double);
var
  xo,yo:integer;
begin
  if FColor <> clNone then
    Canvas.Brush.Color := FColor
  else
    Canvas.Brush.Style := bsClear;

  Canvas.Pen.Color := FColor;

  Canvas.Font.Assign(FFont);

  if (ColorTo <> clNone) then
    DrawGradient(Canvas, Color, ColorTo, GradientSteps, R, GradientDirection, False, clNone, 0, asRectangle, 0, [cbLeft, cbTop, cbRight, cbBottom], false, false)
  else
    Canvas.FillRect(R);

  if not (Picture.Graphic = nil) and PictureVisible then
  begin
    case FBackgroundPosition of
    bpTopLeft:Canvas.Draw(r.Left,r.Top,FPicture.Graphic);
    bpTopRight:Canvas.Draw(Max(r.Left,r.Right - r.Left - Round(FPicture.Width * Scalex)),r.top,FPicture.Graphic);
    bpBottomLeft:Canvas.Draw(r.left,Max(r.top,R.Bottom - Round(FPicture.Height * Scaley)),FPicture.Graphic);
    bpBottomRight:Canvas.Draw(Max(r.Left,r.Right - r.Left - Round(FPicture.Width * ScaleX)),Max(r.Top,R.Bottom - Round(FPicture.Height * ScaleY)),FPicture.Graphic);
    bpCenter:Canvas.Draw(Max(r.Left,r.Right - r.Left - Round(FPicture.Width * Scalex)) shr 1,Max(r.Top,R.Bottom - Round(FPicture.Height * ScaleY)) shr 1,FPicture.Graphic);
    bpTiled:begin
              yo := r.Top;
              while (yo < R.Bottom) do
              begin
                xo := r.Left;
                while (xo < R.Right) do
                begin
                  Canvas.Draw(xo,yo,FPicture.Graphic);
                  xo := xo + Round(FPicture.Width * Scalex);
                end;
                yo := yo + Round(FPicture.Height * ScaleY);
              end;
            end;
    bpStretched:Canvas.StretchDraw(R,FPicture.Graphic);
    end;
  end;
end;


procedure TChartBackground.FontChanged(Sender: TObject);
begin
  Changed;
end;

procedure TChartBackground.LoadFromFile(ini: TMemIniFile;Section: String);
var
  A: TStringList;
  str: String;
  I: integer;
//  st: TMemoryStream;
begin
  BackGroundPosition := TChartBackGroundPosition(ini.ReadInteger(Section, 'BackGroundPosition', Integer(BackGroundPosition)));
  Color := ini.ReadInteger(Section, 'Color', Color);
  ColorTo := ini.ReadInteger(Section, 'ColorTo', ColorTo);
  GradientSteps := ini.ReadInteger(Section, 'GradientSteps', GradientSteps);
  GradientDirection := TChartGradientDirection(ini.ReadInteger(Section, 'GradientDirection', Integer(GradientDirection)));
  Font.Size := ini.ReadInteger(Section, 'FontSize', Font.Size);
  Font.Color := ini.ReadInteger(Section, 'FontColor', Font.Color);
  Font.Name := ini.ReadString(Section, 'FontName', Font.Name);
  str := ini.ReadString(Section, 'FontStyle', '');
  A := TStringList.Create;
  Split(':',str, A);
  for I := 1 to A.Count - 1 do
  begin
    Font.Style := Font.Style + [TFontStyle(strtoint(A[I]))];
  end;
  A.Free;
  PictureVisible := ini.ReadBool(Section, 'PictureVisible', PictureVisible);
end;

procedure TChartBackground.PictureChanged(Sender: TObject);
begin
  Changed;
end;

procedure TChartBackground.SaveToFile(ini: TMemIniFile;Section: String);
begin
  ini.WriteInteger(Section, 'BackGroundPosition', Integer(BackGroundPosition));
  ini.WriteInteger(Section, 'Color', Color);
  ini.WriteInteger(Section, 'ColorTo', ColorTo);
  ini.WriteInteger(Section, 'GradientSteps', GradientSteps);
  ini.WriteInteger(Section, 'GradientDirection', Integer(GradientDirection));
  ini.WriteInteger(Section, 'FontSize', Font.Size);
  ini.WriteInteger(Section, 'FontColor', Font.Color);
  ini.WriteString(Section, 'FontName', Font.Name);
  ini.WriteString(Section, 'FontStyle', GetFontStyles(Font.Style));
  //TODO
//  st := TMemoryStream.Create;
//  Picture.Graphic.SaveToStream(st);
//  st.Seek(0, soFromBeginning);
//  ini.WriteBinaryStream(Section, 'Picture', st);
//  st.Free;
  ini.WriteBool(Section, 'PictureVisible', PictureVisible);
end;

procedure TChartBackground.SetBackgroundPosition(
  const Value: TChartBackGroundPosition);
begin
  if FBackgroundPosition <> Value then
  begin
    FBackgroundPosition := Value;
    Changed;
  end;
end;

procedure TChartBackground.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Changed;
  end;
end;

procedure TChartBackground.SetColorTo(const Value: TColor);
begin
  if FColorTo <> Value then
  begin
    FColorTo := Value;
    Changed;
  end;
end;

procedure TChartBackground.SetFont(const Value: TFont);
begin
  if FFont <> value then
  begin
    FFont.Assign(Value);
    FontChanged(FFont);
  end;
end;

procedure TChartBackground.SetGradientDirection(
  const Value: TChartGradientDirection);
begin
  if FGradientDirection <> Value then
  begin
    FGradientDirection := Value;
    Changed;
  end;
end;

procedure TChartBackground.SetGradientSteps(const Value: integer);
begin
  if (FGradientSteps <> Value) and (Value >= 0) then
  begin
    FGradientSteps := Value;
    Changed;
  end;
end;

procedure TChartBackground.SetPicture(const Value: TPicture);
begin
  if FPicture <> Value then
  begin
    FPicture.Assign(Value);
    PictureChanged(FPicture);
  end;
end;

procedure TChartBackground.SetPictureVisible(const Value: boolean);
begin
  if FPictureVisible <> value then
  begin
    FPictureVisible := Value;
    Changed;
  end;
end;

{ TChartXAxis }

procedure TChartXAxis.Assign(Source: TPersistent);
begin
  if (Source is TChartXAxis) then
  begin
    FColor := (Source as TChartXAxis).Color;
    FColorTo := (Source as TChartXAxis).ColorTo;
    FGradientDirection := (Source as TChartXAxis).GradientDirection;
    FGradientSteps := (Source as TChartXAxis).GradientSteps;
    FAlignment := (Source as TChartXaxis).Alignment;
    FFont.Assign((Source as TChartXAxis).Font);
    FUnitType := (Source as TChartXAxis).UnitType;
    FSize := (Source as TChartXAxis).Size;
    FText := (Source as TChartXAxis).Text;
    FPosition := (Source as TChartXAxis).Position;
    FLine := (Source as TChartXAxis).Line;
    FLineColor := (Source as TChartXAxis).LineColor;
    FLineWidth := (Source as TChartXAxis).LineWidth;
    FEnable3D := (Source as TChartXAxis).Enable3D;
    FDarken3D := (Source as TChartXAxis).Darken3D;
    FOffset3D := (Source as TChartXAxis).Offset3D;
    FAutoSize := (Source as TChartXAxis).AutoSize;
  end;
end;

procedure TChartXAxis.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TChartXAxis.Create(AOwner: TAdvChart);
begin
  FOwner := AOwner;
  FFont := TFont.Create;
  FFont.OnChange := FontChanged;
  FColor := clNone;
  FColorTo := clNone;
  FGradientDirection := cgdHorizontal;
  FGradientSteps := 100;
  UnitType := utNumber;
  FSize := 30;
  FText := '';
  FPosition := xBottom;
  FAlignment := taCenter;
  FLineColor := clBlack;
  FLineWidth := 1;
  FLine := true;
  FOffset3D := 20;
  FEnable3D := false;
  FDarken3D := true;
  FAutoSize := True;
end;

destructor TChartXAxis.Destroy;
begin
  FFont.Free;
  inherited;
end;

procedure TChartXAxis.Draw(Canvas: TCanvas; R: TRect; Top: boolean; ScaleX, ScaleY: Double; Horizontal: Boolean);
var
  DTSTYLE: dword;
  ls, rs: integer;
  tf: TFont;
  lf: TLogFontW;
  arr3D: array[0..3] of TPoint;
  cto: TColor;
  bstyle: TChartBorderStyles;
  tr: TRect;
begin
  DTSTYLE := 0;

  if FColor <> clNone then
  begin
    Canvas.Brush.Style := bsSolid;
    Canvas.Brush.Color := DarkenColor(FColor, Darken3D)
  end
  else
    Canvas.Brush.Style := bsClear;

  if FLineColor <> clNone then
  begin
    Canvas.Pen.Style := psSolid;
    Canvas.Pen.Width := LineWidth;
    Canvas.Pen.Color := LineColor;
  end
  else
    Canvas.Pen.Style := psClear;

  cto := FColor;
  if FColorTo <> clNone then
    cto := FColorTo;

  bstyle := [];
  if Color <> clNone then
  begin
    if Top then
    begin
      case GradientDirection of
        cgdHorizontal:  DrawGradient(Canvas, Color, cto, GradientSteps, R, GradientDirection, false, LineColor, LineWidth, asRectangle, 0, bstyle, false, false) ;
        cgdVertical: DrawGradient(Canvas, Color, cto, GradientSteps, R, GradientDirection, false, LineColor, LineWidth, asRectangle, 0, bstyle, false, false) ;
      end;
    end
    else
    begin
      case GradientDirection of
        cgdHorizontal: DrawGradient(Canvas, Color, cto, GradientSteps, R,GradientDirection, false, LineColor, LineWidth, asRectangle, 0, bstyle, false, false);
        cgdVertical: DrawGradient(Canvas, cto, Color, GradientSteps, R,GradientDirection, false, LineColor, LineWidth, asRectangle, 0, bstyle, false, false);
      end;
    end;
  end;


  if Enable3D and not Top then
  begin
    if Horizontal then
    begin
      arr3D[0] := Point(R.Right, R.Top);
      arr3D[1] := Point(R.Right + Offset3D, R.Top + Offset3D);
      arr3D[2] := Point(R.Right + Offset3D, R.Bottom + Offset3D);
      arr3D[3] := Point(R.Right, R.Bottom);
      Polygon(Canvas.Handle, arr3D, 4);
    end
    else
    begin
      arr3D[0] := Point(R.Left, R.Top);
      arr3D[1] := Point(R.Left + Offset3D, R.Top - Offset3D);
      arr3D[2] := Point(R.Right + Offset3D, R.Top - Offset3D);
      arr3D[3] := Point(R.Right, R.Top);
      Polygon(Canvas.Handle, arr3D, 4);
    end;
  end;


  // draw text here
  if (Text <> '') then
  begin
    tr := r;
    if FOwner.Series.IsHorizontal then
    begin
      tf := TFont.Create;
      tf.Assign(FFont);
      GetObject(tf.Handle, SizeOf(lf), @lf);
      if Top then
      begin
        lf.lfEscapement := -900;
        lf.lfOrientation := -900;
      end
      else
      begin
        lf.lfEscapement := 900;
        lf.lfOrientation := 900;
      end;
      tf.Handle := CreateFontIndirectW(lf);
      Canvas.Font.Assign(tf);
      tf.Free;
    end
    else
      Canvas.Font.Assign(FFont);

    Canvas.Brush.Style := bsClear;

    if FOwner.Series.IsHorizontal then
    begin
      case Alignment of
      taLeftJustify: DTSTYLE := DT_TOP;
      taCenter: DTSTYLE := DT_VCENTER;
      taRightJustify: DTSTYLE := DT_BOTTOM;
      end;

      if Top then
      begin
        DTSTYLE := DTSTYLE or DT_RIGHT;
        tr.Right := tr.Right + Canvas.TextWidth(Text);
      end
      else
      begin
        DTSTYLE := DTSTYLE or DT_LEFT;
        tr.Top := tr.Top + Canvas.TextHeight(Text) * 2;
      end;
    end
    else
    begin
      case Alignment of
      taLeftJustify: DTSTYLE := DT_LEFT;
      taCenter: DTSTYLE := DT_CENTER;
      taRightJustify: DTSTYLE := DT_RIGHT;
      end;

      if Top then
        DTSTYLE := DTSTYLE or DT_TOP
      else
        DTSTYLE := DTSTYLE or DT_BOTTOM;
    end;

    DrawText(Canvas.Handle, Pchar(Text), length(Text), tr, DT_SINGLELINE or DTSTYLE or DT_NOPREFIX or DT_END_ELLIPSIS);
  end;

  if Line and (LineColor <> clNone) then
  begin
    Canvas.Pen.Color := LineColor;
    Canvas.Pen.Width := Round(LineWidth * ScaleX);
    Canvas.Pen.Style := psSolid;

    ls := 0;
    rs := 0;
    if Self.FOwner.FAxisMode = amXAxisFullWidth then
    begin
      ls := Self.FOwner.YAxis.LeftSize;
      rs := Self.FOwner.YAxis.RightSize;
    end;

    if FOwner.Series.IsHorizontal then
    begin
      if Top then
      begin
        Canvas.MoveTo(R.Left, R.Top + ls);
        Canvas.LineTo(R.Left, R.Bottom - rs);
      end
      else
      begin
        Canvas.MoveTo(R.Right, R.Top + ls);
        Canvas.LineTo(R.Right, R.Bottom - rs);
      end;
    end
    else
    begin
      if Top then
      begin
        Canvas.MoveTo(R.Left + ls  , R.Bottom);
        Canvas.LineTo(R.Right - rs, R.Bottom);
      end
      else
      begin
        Canvas.MoveTo(R.Left + ls, R.Top);
        Canvas.LineTo(R.Right - rs, R.Top);
      end;
    end;
  end;
end;

procedure TChartXAxis.FontChanged(Sender: TObject);
begin
  Changed;
end;

function TChartXAxis.GetBottomLineSize: integer;
begin
  Result := 0;
  if (Position in [xBottom, xBoth]) and Line then
  begin
    if FLineWidth = 1 then
      Result := 0
    else
      Result := FLineWidth div 2;
  end;
end;

function TChartXAxis.GetBottomSize: integer;
var
  r: TRect;
begin
  Result := 0;
  if Position in [xBottom, xBoth] then
  begin
    if AutoSize then
    begin
      if Assigned(FOwner.GetPaneRectangle) then
      begin
        FOwner.GetPaneRectangle(FOwner, r);
        Result := FOwner.GetTotalXAxisSize(r, True);
      end
      else
        Result := FSize
    end
    else
    begin
      Result := FSize
    end;
  end;
end;

function TChartXAxis.GetTopLineSize: integer;
begin
  Result := 0;
  if (Position in [xTop, xBoth]) and Line then
  begin
    if FLineWidth = 1 then
      Result := 1
    else
      Result := FLineWidth div 2;
  end;
end;

function TChartXAxis.GetTopSize: integer;
var
  r: TRect;
begin
  Result := 0;
  if Position in [xTop, xBoth] then
  begin
    if AutoSize then
    begin
      if Assigned(FOwner.GetPaneRectangle) then
      begin
        FOwner.GetPaneRectangle(FOwner, r);
        Result := FOwner.GetTotalXAxisSize(r, False);
      end
      else
        Result := FSize
    end
    else
    begin
      Result := FSize
    end;
  end;
end;

procedure TChartXAxis.LoadFromFile(ini: TMemIniFile;Section: String);
var
  A: TStringList;
  I: integer;
  str: String;
begin
  Alignment := TAlignment(ini.ReadInteger(Section, 'Alignment', Integer(Alignment)));
  Color := ini.ReadInteger(Section, 'Color', Color);
  ColorTo := ini.ReadInteger(Section, 'ColorTo', ColorTo);
  GradientDirection := TChartGradientDirection(ini.ReadInteger(Section, 'GradientDirection', Integer(GradientDirection)));
  GradientSteps := ini.ReadInteger(Section, 'GradienSteps', GradientSteps);
  Font.Size := ini.ReadInteger(Section, 'FontSize', Font.Size);
  Font.Color := ini.ReadInteger(Section, 'FontColor', Font.Color);
  Font.Name := ini.ReadString(Section, 'FontName', Font.Name);
  str := ini.ReadString(Section, 'FontStyle', '');
  A := TStringList.Create;
  Split(':',str, A);
  for I := 1 to A.Count - 1 do
  begin
    Font.Style := Font.Style + [TFontStyle(strtoint(A[I]))];
  end;
  A.Free;
  Line := ini.ReadBool(Section, 'Line', Line);
  LineWidth := ini.ReadInteger(Section, 'LineWidth', LineWidth);
  Position := TChartXAxisPosition(ini.ReadInteger(Section, 'Position', Integer(Position)));
  Size := ini.ReadInteger(Section, 'Size', Size);
  Text := ini.ReadString(Section, 'Text', Text);
  UnitType := TChartUnitType(ini.ReadInteger(Section, 'UnitType', Integer(UnitType)));
end;

procedure TChartXAxis.SaveToFile(ini: TMemIniFile;Section: String);
begin
  ini.WriteInteger(Section, 'Alignment', Integer(Alignment));
  ini.WriteInteger(Section, 'Color', Color);
  ini.WriteInteger(Section, 'ColorTo', ColorTo);
  ini.WriteInteger(Section, 'GradientDirection', Integer(GradientDirection));
  ini.WriteInteger(Section, 'GradienSteps', GradientSteps);
  ini.WriteInteger(Section, 'FontSize', Font.Size);
  ini.WriteInteger(Section, 'FontColor', Font.Color);
  ini.WriteString(Section, 'FontName', Font.Name);
  ini.WriteString(Section, 'FontStyle', GetFontStyles(Font.Style));
  ini.WriteBool(Section, 'Line', Line);
  ini.WriteInteger(Section, 'LineWidth', LineWidth);
  ini.WriteInteger(Section, 'Position', Integer(Position));
  ini.WriteInteger(Section, 'Size', Size);
  ini.WriteString(Section, 'Text', Text);
  ini.WriteInteger(Section, 'UnitType', Integer(UnitType));
end;

procedure TChartXAxis.SetAlignment(const Value: TAlignment);
begin
  if (FAlignment <> Value) then
  begin
    FAlignment := Value;
    Changed;
  end;
end;

procedure TChartXAxis.SetAutoSize(const Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    Changed;
  end;
end;

procedure TChartXAxis.SetColor(const Value: TColor);
begin
  if (FColor <> Value) then
  begin
    FColor := Value;
    Changed;
  end;
end;

procedure TChartXAxis.SetColorTo(const Value: TColor);
begin
  if FColorTo <> Value then
  begin
    FColorTo := Value;
    Changed;
  end;
end;

procedure TChartXAxis.SetDarken3D(const Value: Boolean);
begin
  if FDarken3D <> Value then
  begin
    FDarken3D := Value;
    Changed;
  end;
end;

procedure TChartXAxis.SetEnable3D(const Value: Boolean);
begin
  if FEnable3D <> Value then
  begin
    FEnable3D := Value;
    Changed;
  end;
end;

procedure TChartXAxis.SetFont(const Value: TFont);
begin
  if FFont <> Value then
  begin
    FFont.Assign(Value);
  end;
end;

procedure TChartXAxis.SetGradientDirection(
  const Value: TChartGradientDirection);
begin
  if (FGradientDirection <> Value) then
  begin
    FGradientDirection := Value;
    Changed;
  end;
end;

procedure TChartXAxis.SetGradientSteps(const Value: Integer);
begin
  if (FGradientSteps <> Value) and (Value >= 0) then
  begin
    FGradientSteps := Value;
    Changed;
  end;
end;

procedure TChartXAxis.SetLine(const Value: boolean);
begin
  if (FLine <> Value) then
  begin
    FLine := Value;
    Changed
  end;
end;

procedure TChartXAxis.SetLineColor(const Value: TColor);
begin
  if (FLineColor <> Value) then
  begin
    FLineColor := Value;
    Changed;
  end;
end;

procedure TChartXAxis.SetLineWidth(const Value: integer);
begin
  if (FLineWidth <> Value) then
  begin
    FLineWidth := Value;
    Changed;
  end;
end;

procedure TChartXAxis.SetOffset3D(const Value: integer);
begin
  if FOffset3D <> Value then
  begin
    FOffset3D := Value;
    Changed;
  end;
end;

procedure TChartXAxis.SetPosition(const Value: TChartXAxisPosition);
begin
  if FPosition <> Value then
  begin
    FPosition := Value;
    Changed;
  end;
end;

procedure TChartXAxis.SetSize(const Value: integer);
begin
  if (FSize <> Value) and (Value >= 0) then
  begin
    FSize := Value;
    Changed;
  end;
end;

procedure TChartXAxis.SetText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    Changed;
  end;
end;

procedure TChartXAxis.SetUnitType(const Value: TChartUnitType);
begin
  if FUnitType <> Value then
  begin
    FUnitType := Value;
    Changed;
  end;
end;

{ TChartYAxis }

procedure TChartYAxis.Assign(Source: TPersistent);
begin
  if Source is TChartYAxis then
  begin
    FAlignment := (Source as TchartYAxis).Alignment;
    FAutoUnits := (Source as TChartYAxis).AutoUnits;
    FColor := (Source as TChartYAxis).Color;
    FColorTo := (Source as TChartYAxis).ColorTo;
    FGradientSteps := (Source as TchartYAxis).GradientSteps;
    FGradientDirection := (Source as TChartYaxis).GradientDirection;
    FFont.Assign((Source as TChartYAxis).Font);
    FSize := (Source as TChartYAxis).Size;
    FPosition := (Source as TChartYAxis).Position;
    FLine := (Source as TChartYAxis).Line;
    FLineColor := (Source as TChartYAxis).LineColor;
    FLineWidth := (Source as TChartYAxis).LineWidth;
    FText := (Source as TchartYAxis).Text;
    FEnable3D := (Source as TChartYAxis).Enable3D;
    FDarken3D := (Source as TChartYAxis).Darken3D;
    FOffset3D := (Source as TChartYAxis).Offset3D;
    FAutoSize := (Source as TChartYAxis).AutoSize;
    FLeftSize := (Source as TChartYAxis).FLeftSize;
    FRightSize := (Source as TChartYAxis).FRightSize;
  end;
end;

procedure TChartYAxis.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TChartYAxis.Create(AOwner: TAdvChart);
begin
  FOwner := AOwner;
  FAutoUnits := true;
  FText := '';
  FFont := TFont.Create;
  FColor := clNone;
  FColorTo := clNone;
  FAlignment := taCenter;
  FSize := 30;
  FGradientDirection := cgdHorizontal;
  FGradientSteps := 100;
  FPosition := yLeft;
  FLine := true;
  FLineColor := clBlack;
  FLineWidth := 1;
  FOffset3D := 20;
  FDarken3D := true;
  FEnable3D := false;
  FAutoSize := True;
  FLeftSize := -1;
  FRightSize := -1;
end;

destructor TChartYAxis.Destroy;
begin
  FFont.Free;
  inherited;
end;

procedure TChartYAxis.Draw(Canvas: TCanvas; R: TRect; Left: boolean; ScaleX, ScaleY: Double; Horizontal: Boolean);
var
  tf: TFont;
  lf: TLogFontW;
  tw, th: integer;
  ts, bs: integer;
  arr3D: array [0..3] of TPoint;
  cto: TColor;
  bstyle: TChartBorderStyles;
begin
  tf := nil;

  if FColor <> clNone then
  begin
    Canvas.Brush.Style := bsSolid;
    Canvas.Brush.Color := DarkenColor(FColor, Darken3D)
  end
  else
    Canvas.Brush.Style := bsClear;

  if FLineColor <> clNone then
  begin
    Canvas.Pen.Style := psSolid;
    Canvas.Pen.Width := LineWidth;
    Canvas.Pen.Color := LineColor;
  end
  else
    Canvas.Pen.Style := psClear;

  cto := FColor;
  if FColorTo <> clNone then
    cto := FColorTo;

  bstyle := [];
  if Color <> clNone then
  begin
    if Left then
    begin
      case GradientDirection of
        cgdHorizontal:  DrawGradient(Canvas, Color, cto, GradientSteps, R,GradientDirection, false, LineColor, LineWidth, asRectangle, 0, bstyle, false, false);
        cgdVertical: DrawGradient(Canvas, Color, cto, GradientSteps, R,GradientDirection, false, LineColor, LineWidth, asRectangle, 0, bstyle, false, false);
      end;
    end
    else
    begin
      case GradientDirection of
        cgdHorizontal: DrawGradient(Canvas, cto, Color, GradientSteps, R,GradientDirection, false, LineColor, LineWidth, asRectangle, 0, bstyle, false, false);
        cgdVertical: DrawGradient(Canvas, Color, cto, GradientSteps, R,GradientDirection, false, LineColor, LineWidth, asRectangle, 0, bstyle, false, false);
      end;
    end;
  end;

  if Enable3D and Left then
  begin
    if Horizontal then
    begin
      arr3D[0] := Point(R.Left, R.Bottom);
      arr3D[1] := Point(R.Left + Offset3D, R.Bottom + Offset3D);
      arr3D[2] := Point(R.Right + Offset3D, R.Bottom + Offset3D);
      arr3D[3] := Point(R.Right, R.Bottom);
      Polygon(Canvas.Handle, arr3D, 4);
    end
    else
    begin
      arr3D[0] := Point(R.Right, R.Top);
      arr3D[1] := Point(R.Right + Offset3D, R.Top - Offset3D);
      arr3D[2] := Point(R.Right + Offset3D, R.Bottom - Offset3D);
      arr3D[3] := Point(R.Right, R.Bottom);
      Polygon(Canvas.Handle, arr3D, 4);
    end;
  end;

  // draw text here
  if (Text <> '') then
  begin
    try
      tf := TFont.Create;
      tf.Assign(FFont);
      GetObject(tf.Handle, SizeOf(lf), @lf);
      if not FOwner.Series.IsHorizontal then
      begin
        if Left then
        begin
          lf.lfEscapement := 900;
          lf.lfOrientation := 900;
        end
        else
        begin
          lf.lfEscapement := -900;
          lf.lfOrientation := -900;
        end;
      end;
      tf.Handle := CreateFontIndirectW(lf);

      Canvas.Font.Assign(tf);
      Canvas.Brush.Style := bsClear;

      th := 0;

      if FOwner.Series.IsHorizontal then
        th := Canvas.TextHeight(Text);

      tw := Canvas.TextWidth(Text);

      if FOwner.Series.IsHorizontal then
      begin
        if Left then
        begin
          case FAlignment of
          taLeftJustify: Canvas.TextOut(R.Left + tw,R.Top, Text);
          taCenter: Canvas.TextOut(R.Left + (R.Right - R.Left - tw) div 2,R.Top,Text);
          taRightJustify: Canvas.TextOut(R.Right - tw,R.Top, Text);
          end;
        end
        else
        begin
          case FAlignment of
          taLeftJustify: Canvas.TextOut(R.Left + tw,R.Bottom -th,Text);
          taCenter: Canvas.TextOut(R.Left + (R.Right - R.Left - tw) div 2,R.Bottom-th, Text);
          taRightJustify: Canvas.TextOut(R.Right - tw,R.Bottom-th , Text);
          end;
        end;
      end
      else
      begin
        if Left then
        begin
          case FAlignment of
          taLeftJustify: Canvas.TextOut(R.Left, R.Bottom - tw,Text);
          taCenter: Canvas.TextOut(R.Left, R.Bottom - (R.Bottom - R.Top - tw) div 2,Text);
          taRightJustify: Canvas.TextOut(R.Left, R.Top + tw,Text);
          end;
        end
        else
        begin
          case FAlignment of
          taLeftJustify: Canvas.TextOut(R.Right, R.Top + tw,Text);
          taCenter: Canvas.TextOut(R.Right, R.Top + (R.Bottom - R.Top - tw) div 2,Text);
          taRightJustify: Canvas.TextOut(R.Right , R.Bottom - tw,Text);
        end;
      end;
    end;
    finally
      tf.Free;
    end;
  end;

  ts := 0;
  bs := 0;
  if Self.FOwner.FAxisMode = amYAxisFullHeight then
  begin
    with Self.FOwner do
    begin
      if Series.IsHorizontal then
      begin
        ts := XAxis.BottomSize;
        bs := XAxis.TopSize;
      end
      else
      begin
        ts := XAxis.TopSize;
        bs := XAxis.BottomSize;
      end;
    end;
  end;

  if Line and (LineColor <> clNone) then
  begin
    Canvas.Pen.Color := LineColor;
    Canvas.Pen.Width := Round(LineWidth * ScaleX);
    Canvas.Pen.Style := psSolid;
    if FOwner.Series.IsHorizontal then
    begin
      if Left then
      begin
        Canvas.MoveTo(R.Left + ts, R.Bottom);
        Canvas.LineTo(R.Right - bs, R.Bottom);
      end
      else
      begin
        Canvas.MoveTo(R.Left + ts, R.Top);
        Canvas.LineTo(R.Right - bs, R.Top);
      end;
    end
    else
    begin
      if Left then
      begin
        Canvas.MoveTo(R.Right, R.Top + ts);
        Canvas.LineTo(R.Right, R.Bottom - bs);
      end
      else
      begin
        Canvas.MoveTo(R.Left, R.Top + ts);
        Canvas.LineTo(R.Left, R.Bottom - bs);
      end;
    end;
  end;
end;

procedure TChartYAxis.FontChanged(Sender: TObject);
begin
  Changed;
end;

function TChartYAxis.GetLeftLineSize: integer;
begin
  Result := 0;
  if (Position in [yLeft, yBoth]) and Line then
  begin
    if FLineWidth = 1 then
      Result := 1
    else
      Result := FLineWidth div 2;
  end;
end;

function TChartYAxis.GetRightLineSize: integer;
begin
  Result := 0;
  if (Position in [yRight, yBoth]) and Line then
  begin
    if FLineWidth = 1 then
      Result := 0
    else
      Result := FLineWidth div 2;
  end;
end;

function TChartYAxis.GetLeftSize: integer;
var
  r: TRect;
begin
  Result := 0;
  if (Position in [yLeft, yBoth]) then
  begin
    if FLeftSize = -1 then
    begin
      if AutoSize then
      begin
        if Assigned(FOwner.GetPaneRectangle) then
        begin
          FOwner.GetPaneRectangle(FOwner, r);
          Result := FOwner.GetTotalYAxisSize(r, False);
        end
        else
          Result := FSize
      end
      else
      begin
        Result := FSize
      end;
    end
    else
      Result := FLeftSize;
  end;
end;

function TChartYAxis.GetRightSize: integer;
var
  r: TRect;
begin
  Result := 0;
  if (Position in [yRight, yBoth]) then
  begin
    if FRightSize = -1 then
    begin
      if AutoSize then
      begin
        if Assigned(FOwner.GetPaneRectangle) then
        begin
          FOwner.GetPaneRectangle(FOwner, r);
          Result := FOwner.GetTotalYAxisSize(r, True);
        end
        else
          Result := FSize
      end
      else
      begin
        Result := FSize
      end
    end
    else
      Result := FRightSize;
  end;
end;

procedure TChartYAxis.LoadFromFile(ini: TMemIniFile;Section: String);
var
  A: TStringList;
  I: integer;
  str: String;
begin
  AutoUnits := ini.ReadBool(Section, 'AutoUnits', AutoUnits);
  Alignment := TAlignment(ini.ReadInteger(Section, 'Alignment', Integer(Alignment)));
  Color := ini.ReadInteger(Section, 'Color', Color);
  ColorTo := ini.ReadInteger(Section, 'ColorTo', ColorTo);
  GradientDirection := TChartGradientDirection(ini.ReadInteger(Section, 'GradientDirection', Integer(GradientDirection)));
  GradientSteps := ini.ReadInteger(Section, 'GradienSteps', GradientSteps);
  Font.Size := ini.ReadInteger(Section, 'FontSize', Font.Size);
  Font.Color := ini.ReadInteger(Section, 'FontColor', Font.Color);
  Font.Name := ini.ReadString(Section, 'FontName', Font.Name);
  str := ini.ReadString(Section, 'FontStyle', '');
  A := TStringList.Create;
  Split(':',str, A);
  for I := 1 to A.Count - 1 do
  begin
    Font.Style := Font.Style + [TFontStyle(strtoint(A[I]))];
  end;
  A.Free;
  Line := ini.ReadBool(Section, 'Line', Line);
  LineWidth := ini.ReadInteger(Section, 'LineWidth', LineWidth);
  Position := TChartYAxisPosition(ini.ReadInteger(Section, 'Position', Integer(Position)));
  Size := ini.ReadInteger(Section, 'Size', Size);
  Text := ini.ReadString(Section, 'Text', Text);
end;

procedure TChartYAxis.SaveToFile(ini: TMemIniFile;Section: String);
begin
  ini.WriteBool(Section, 'AutoUnits', AutoUnits);
  ini.WriteInteger(Section, 'Alignment', Integer(Alignment));
  ini.WriteInteger(Section, 'Color', Color);
  ini.WriteInteger(Section, 'ColorTo', ColorTo);
  ini.WriteInteger(Section, 'GradientDirection', Integer(GradientDirection));
  ini.WriteInteger(Section, 'GradienSteps', GradientSteps);
  ini.WriteInteger(Section, 'FontSize', Font.Size);
  ini.WriteInteger(Section, 'FontColor', Font.Color);
  ini.WriteString(Section, 'FontName', Font.Name);
  ini.WriteString(Section, 'FontStyle', GetFontStyles(Font.Style));
  ini.WriteBool(Section, 'Line', Line);
  ini.WriteInteger(Section, 'LineWidth', LineWidth);
  ini.WriteInteger(Section, 'Position', Integer(Position));
  ini.WriteInteger(Section, 'Size', Size);
  ini.WriteString(Section, 'Text', Text);
end;

procedure TChartYAxis.SetAlignment(const Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    Changed;
  end;
end;

procedure TChartYAxis.SetAutoSize(const Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    Changed;
  end;
end;

procedure TChartYAxis.SetAutoUnits(const Value: Boolean);
begin
  if FAutoUnits <> value then
  begin
    FAutoUnits := Value;
    Changed;
  end;
end;

procedure TChartYAxis.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Changed;
  end;
end;

procedure TChartYAxis.SetColorTo(const Value: TColor);
begin
  if FColorTo <> Value then
  begin
    FColorTo := Value;
    Changed;
  end;
end;

procedure TChartYAxis.SetDarken3D(const Value: Boolean);
begin
  if FDarken3D <> Value then
  begin
    FDarken3D := Value;
    Changed;
  end;
end;

procedure TChartYAxis.SetEnable3D(const Value: Boolean);
begin
  if FEnable3D <> Value then
  begin
    FEnable3D := Value;
    Changed;
  end;
end;

procedure TChartYAxis.SetFont(const Value: TFont);
begin
  if FFont <> Value then
  begin
    FFont.Assign(Value);
    FontChanged(FFont);
  end;
end;

procedure TChartYAxis.SetGradientDirection(
  const Value: TChartGradientDirection);
begin
  if FGradientDirection <> Value then
  begin
    FGradientDirection := Value;
    Changed;
  end;
end;

procedure TChartYAxis.SetGradientSteps(const Value: Integer);
begin
  if (FGradientSteps <> Value) and (Value >= 0) then
  begin
    FGradientSteps := Value;
    Changed;
  end;
end;

procedure TChartYAxis.SetLeftSize(const Value: integer);
begin
  FLeftSize := Value;
end;

procedure TChartYAxis.SetLine(const Value: boolean);
begin
  if (FLine <> Value) then
  begin
    FLine := Value;
    Changed;
  end;
end;

procedure TChartYAxis.SetLineColor(const Value: TColor);
begin
  if (FLineColor <> Value) then
  begin
    FLineColor := Value;
    Changed;
  end;
end;

procedure TChartYAxis.SetLineWidth(const Value: integer);
begin
  if (FLineWidth <> Value) then
  begin
    FLineWidth := Value;
    Changed;
  end;
end;

procedure TChartYAxis.SetOffset3D(const Value: integer);
begin
  if Offset3D <> Value then
  begin
    FOffset3D := Value;
    Changed;
  end;
end;

procedure TChartYAxis.SetPosition(const Value: TChartYAxisPosition);
begin
  if FPosition <> Value then
  begin
    FPosition := Value;
    Changed;
  end;
end;

procedure TChartYAxis.SetRightSize(const Value: integer);
begin
  FRightSize := Value;
end;

procedure TChartYAxis.SetSize(const Value: integer);
begin
  if (FSize <> Value) and (Value >= 0) then
  begin
    FSize := Value;
    Changed;
  end;
end;

procedure TChartYAxis.SetText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    Changed;
  end;
end;

{ TChartSerie }

procedure TChartSerie.AddSinglePoint(SinglePoint: double);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].SingleValue := SinglePoint;
  FPoints[FLastPoint - 1].Defined := true;
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddMultiPoints(HighPoint, LowPoint, OpenPoint,
  ClosePoint: Double);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := ClosePoint;
  FPoints[FLastPoint - 1].HighValue := Highpoint;
  FPoints[FLastPoint - 1].LowValue := LowPoint;
  FPoints[FLastPoint - 1].OpenValue := OpenPoint;
  FPoints[FLastPoint - 1].CloseValue := ClosePoint;
  FPoints[FLastPoint - 1].ValueType := cpvMulti;
  FPoints[FLastPoint - 1].Defined := true;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddMultiPoints(HighPoint, LowPoint, OpenPoint,
  ClosePoint: Double; SingleDateTime: TDateTime);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := ClosePoint;
  FPoints[FLastPoint - 1].HighValue := Highpoint;
  FPoints[FLastPoint - 1].LowValue := LowPoint;
  FPoints[FLastPoint - 1].OpenValue := OpenPoint;
  FPoints[FLastPoint - 1].CloseValue := ClosePoint;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTime;
  FPoints[FLastPoint - 1].ValueType := cpvMulti;
  FPoints[FLastPoint - 1].Defined := true;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSinglePoint(SinglePoint: double;
  SingleDateTime: TDateTime);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := SinglePoint;
  FPoints[FLastPoint - 1].TimeStamp := SingleDatetime;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  FPoints[FLastPoint - 1].Defined := true;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.Assign(Source: TPersistent);
begin
  if Source is TChartSerie then
  begin
    //PRIVATE
    AssignPrivates(Source);
    //Public
    ReadOnly := (Source as TChartSerie).ReadOnly;
    //PUBLISHED
    FValueOffsetX := (Source as TChartSerie).ValueOffsetX;
    FValueOffsetY := (Source as TChartSerie).ValueOffsetY;
    FGroupIndex := (Source as TChartSerie).GroupIndex;
    FFunnelMode := (Source as TChartSerie).FunnelMode;
    FFunnelSpacing := (Source as TChartSerie).FunnelSpacing;
    FFunnelWidth := (Source as TChartSerie).FunnelWidth;
    FFunnelWidthType := (Source as TChartSerie).FunnelWidthType;
    FFunnelHeight := (Source as TChartSerie).FunnelHeight;
    FFunnelHeightType := (Source as TChartSerie).FunnelHeightType;
    FDrawFromStartDate := (Source as TChartSerie).DrawFromStartDate;
    FVisible := (Source as TChartSerie).Visible;
    FValueFont.Assign((Source as TChartSerie).ValueFont);
    FValueAngle := (Source as TChartSerie).ValueAngle;
    FArrowColor := (Source as TChartSerie).ArrowColor;
    FArrowSize := (Source as TChartSerie).ArrowSize;
    FAutoRange := (Source as TChartSerie).AutoRange;
    FBorderwidth := (Source as TchartSerie).BorderWidth;
    FBorderColor := (Source as TChartSerie).BorderColor;
    FBorderRounding := (Source as TChartSerie).BorderRounding;
    FShowValue := (Source as TChartSerie).ShowValue;
    FMin := (Source as TChartSerie).Minimum;
    FMax := (Source as TChartSerie).Maximum;
    FValueType := (Source as TChartSerie).ValueType;
    FValueFormat := (Source as TChartSerie).ValueFormat;
    FValueFormatType := (Source as TChartSerie).ValueFormatType;
    FChartType := (Source as TChartSerie).ChartType;
    FChartPattern.Assign((Source as TChartSerie).ChartPattern);
    FChartPatternPosition := (Source as TChartSerie).ChartPatternPosition;
    FLineColor := (Source as TChartSerie).LineColor;
    FBrushStyle := (Source as TChartSerie).BrushStyle;
    FPenStyle := (Source as TChartSerie).PenStyle;
    FColor := (Source as TChartSerie).Color;
    FColorTo := (Source as TChartSerie).ColorTo;
    FCandleColorIncrease := (Source as tChartSerie).CandleColorIncrease;
    FCandleColorDecrease := (Source as tChartSerie).CandleColorDecrease;
    FShowValueInTracker := (Source as TchartSerie).ShowValueInTracker;
    FShowValue := (Source as TchartSerie).ShowValue;
    FValueWidth := (Source as TChartSerie).ValueWidth;
    FValueWidthType := (Source as TChartSerie).ValueWidthType;
    FWickColor := (Source as TChartSerie).WickColor;
    FWickWidth := (Source as TchartSerie).WickWidth;
    FGradientSteps := (Source as TChartSerie).GradientSteps;
    FGradientDirection := (Source as TChartSerie).GradientDirection;
    FLineWidth := (Source as TChartSerie).LineWidth;
    FLinePointsOnly := (Source as TChartSerie).LinePointsOnly;
    FMarker.Assign((Source as TChartSerie).Marker);
    FAnnotations.Assign((Source as TChartSerie).Annotations);
    FPie.Assign((Source as TchartSerie).Pie);
    ShowAnnotationsOnTop := (Source as TChartSerie).ShowAnnotationsOnTop;
    FZeroLine := (Source as TChartSerie).ZeroLine;
    FZeroLineWidth := (Source as TChartSerie).ZeroLineWidth;
    FZeroLineColor := (Source as TChartSerie).ZeroLineColor;
    FZeroReferencePoint := (Source as TChartSerie).ZeroReferencePoint;
    FLegendText := (Source as TChartSerie).LegendText;
    FCrossHairYValue.Assign((Source as TChartSerie).CrossHairYValue);
    FXAxis.Assign((Source as TChartSerie).XAxis);
    FYAxis.Assign((Source as TChartSerie).YAxis);
    FName := (Source as TChartSerie).Name;
    FSelectedIndex := (Source as TChartSerie).SelectedIndex;
    FSelectedMarkBorderColor := (Source as TChartSerie).SelectedMarkBorderColor;
    FSelectedColor := (Source as TChartSerie).SelectedMarkColor;
    FSelectedMarkSize := (Source as TChartSerie).SelectedMarkSize;
    FSelectedMark := (Source as TChartSerie).SelectedMark;
    FFieldNameValue := (Source as TChartSerie).FieldNameValue;
    FFieldNameXAxis := (Source as TChartSerie).FieldNameXAxis;
    FShowInLegend := (Source as TChartSerie).ShowInLegend;
    FOffset3D := (Source as TChartSerie).Offset3D;
    FEnable3D := (Source as TChartSerie).Enable3D;
    FDarken3D := (Source as TChartSerie).Darken3D;
    FBarShape := (Source as TChartSerie).BarShape;
    FLogarithmic := (Source as TChartSerie).Logarithmic;
    FBarValueTextFont.Assign((Source as TChartSerie).BarValueTextFont);
    FBarValueTextAlignment := (Source as TChartSerie).BarValueTextAlignment;
    FBarValueTextType := (Source as TChartSerie).BarValueTextType;
    FRangePercentMargin := (Source as TChartSerie).RangePercentMargin;
    FXAxisGroups.Assign((Source as TChartSerie).XAxisGroups);
    FXAxisGroupsVisible := (Source as TChartSerie).XAxisGroupsVisible;
    FGanttSpacing := (Source as TChartSerie).GanttSpacing;
    FGanttHeight := (Source as TChartSerie).GanttHeight;
    FUseFullRange := (Source as TChartSerie).UseFullRange;
    //re-assign events
    OnXAxisDrawValue := (Source as TChartSerie).OnXAxisDrawValue;
    OnXAxisGetValue := (Source as TChartSerie).OnXAxisGetValue;
    OnXAxisDrawXValue := (Source as TChartSerie).OnXAxisDrawXValue;
    OnXAxisGetXValue := (Source as TChartSerie).OnXAxisGetXValue;
    OnYAxisDrawvalue := (Source as TChartSerie).OnYAxisDrawvalue;
    OnYAxisGetValue := (Source as TChartSerie).OnYAxisGetValue;
    OnMarkerDrawValue := (Source as TChartSerie).OnMarkerDrawValue;
    OnSerieMouseDown := (Source as TChartSerie).OnSerieMouseDown;
    OnSerieMouseUp := (Source as TChartSerie).OnSerieMouseUp;

    Changed;
  end;
end;

procedure TChartSerie.AssignPrivates(Source: TPersistent);
begin
  if (Source is TChartSerie) then
  begin
    FLastPoint := (Source as TChartSerie).FLastPoint;
    FForceInit := (Source as TchartSerie).FForceInit;
    FPoints := (Source as TChartSerie).FPoints;
    FMaximumValue := (Source as TChartSerie).FMaximumValue;
    FMinimumValue := (Source as TChartSerie).FMinimumValue;
  end;
end;

procedure TChartSerie.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TChartSerie.ClearPoints;
begin
  SetLength(FPoints, 0);
  FLastPoint := 0;
end;

constructor TChartSerie.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FTag := 0;
  FFunnelMode := fmHeight;
  FFunnelSpacing := 0;
  FFunnelWidthType := fstPercentage;
  FFunnelWidth := 80;
  FFunnelHeightType := fstPercentage;
  FFunnelHeight := 80;
  FDrawFromStartDate := True;
  FGroupIndex := 0;
  FRangePercentMargin := 5;
  FValueOffsetX := 0;
  FValueOffsetY := 0;
  FVisible := True;
  FGanttSpacing := 20;
  FGanttHeight := 25;
  FSerieType := stNormal;
  FSelectedIndex := -1;
  FSelectedMarkBorderColor := clBlack;
  FSelectedColor := clLime;
  FSelectedMarkSize := 8;
  FReadOnly := false;
  FValueFont := TFont.Create;
  FValueAngle := 0;
  FValueFormatType := vftNormal;
  FArrowColor := clNone;
  FArrowSize := 10;
  FBorderwidth := 1;
  FBorderColor := clBlack;
  FWickWidth := 1;
  FZeroReferencePoint := 0;
  FChartPattern := TPicture.Create;
  FMarker := CreateMarker;
  FMarker.OnChange := MarkerChanged;
  FPie := CreatePie;
  FPie.OnChange := PieChanged;
  FAnnotations := CreateAnnotations;
  FAnnotations.OnChange := AnnotationChanged;
  FAutoRange := arEnabled;
  FValueWidth := 50;
  FValueWidthType := wtPercentage;
  FChartPatternPosition := bpTopLeft;
  FLegendText := 'Serie ' + inttostr(Index);
  FName := 'Serie ' + inttostr(Index);
  FShowValue := false;
  FValueType := cvNormal;
  FValueFormat := '%g';
  FLineColor := clRed;
  FGradientSteps := 100;
  FGradientDirection := cgdHorizontal;
  FCandleColorIncrease := clGreen;
  FCandleColorDecrease := clRed;
  FColor := clRed;
  FColorTo := clNone;
  FLineWidth := 1;
  FLinePointsOnly := False;
  FValueWidth := 50;
  FWickColor := clBlack;
  FZeroLineColor := clNone;
  FZeroLineWidth := 1;
  FOffSet := 0;
  FCrossHairYValue := TChartSerieCrossHairYValue.Create;
  FCrossHairYValue.OnChange := CrossHairYValueChanged;
  FCrossHairYValue.OnFontChange := CrossHairYValueFontChanged;
  FXAxis := TChartSerieXAxis.Create;
  FXAxis.OnChange := XAxisChanged;
  FYAxis := TChartSerieYAxis.Create;
  FYAxis.OnChange := YAxisChanged;
  FChartType := ctLine;
  FShowValueInTracker := true;
  FShowAnnotationsOnTop := false;
  FSelectedMark := false;
  FShowInLegend := true;
  FEnable3D := false;
  FOffset3D := 20;
  FDarken3D := true;
  FLogarithmic := false;
  FBarShape := bsRectangle;
  FBarValueTextFont := TFont.Create;
  {$IFNDEF DELPHI9_LVL}
  FBarValueTextFont.Name := 'Tahoma';
  {$ENDIF}
  FBarValueTextAlignment := taLeftJustify;
  FBarValueTextType := btCustomValue;
  FMaximumPoints := -1;

  FXAxisGroups := TChartSerieXAxisGroups.Create(Self);
  FXAxisGroupsVisible := True;

  if Assigned(Chart) then
    OnChange := Chart.Series.SerieChanged;
end;

function TChartSerie.CreateAnnotations: TChartAnnotations;
begin
  Result := TChartAnnotations.Create(Self);
end;

function TChartSerie.CreateMarker: TChartMarker;
begin
  Result := TChartMarker.Create;
end;

function TChartSerie.CreatePie: TChartSeriePie;
begin
  Result := TChartSeriePie.Create(Self);
end;

procedure TChartSerie.CrossHairYValueFontChanged(Sender: TObject);
var
  Canvas: TCanvas;
begin
  Canvas := TCanvas.Create;
  Canvas.Font.Assign(CrossHairYValue.Font);
  FCrosshairFontHeight := Canvas.TextHeight('gh');
  Canvas.Free;
end;

procedure TChartSerie.CrossHairYValueChanged(Sender: TObject);
begin
  Changed;
end;

destructor TChartSerie.Destroy;
begin
  FXAxisGroups.Free;
  FValueFont.Free;
  FPie.Free;
  FChartPattern.Free;
  FMarker.Free;
  FAnnotations.Free;
  FCrossHairYValue.Free;
  FXAxis.Free;
  FYAxis.Free;
  FBarValueTextFont.Free;
  inherited;
end;

procedure TChartSerie.DrawBar(Canvas: TCanvas; SColor, SColorTo: TColor; dr: TRect; ScaleX, ScaleY: Double; Idx: integer; Val: Double);
var
  HRGN, BarRgn, Ellip: THandle;
  bwidth: integer;
  rf, xpos: integer;
  str: String;
  al: TAlignment;
  ft, tf: TFont;
  lf: TLogFontW;
  r: TRect;
  DStyle: Word;
  x, y: integer;
  tw, th: integer;
begin
  if (BarShape = bsPyramid) and (ChartType <> ctBoxPlot) then
  begin
    DrawPyramid(Canvas, SColor, SColorTo, DR, ScaleX, ScaleY, Idx, val);
  end
  else
  begin
    Canvas.Brush.style := FBrushStyle;
    if SColor <> clNone then
      Canvas.Brush.Color := SColor
    else
      Canvas.Brush.Style := bsclear;

    if Chart.Series.IsHorizontal then
    begin
      if (BorderWidth > 0) and (BorderColor <> clNone) and (DR.Bottom - DR.Top > 1) then
        InitializeBorderColor(Canvas, ScaleX, ScaleY)
      else
        Canvas.Pen.Color := SColor;
    end
    else
    begin
      if (BorderWidth > 0) and (BorderColor <> clNone) and (DR.Right - DR.Left > 1) then
        InitializeBorderColor(Canvas, ScaleX, ScaleY)
      else
        Canvas.Pen.color := SColor;
    end;

    bwidth := Max(0, (BorderWidth div 2));

    if SColor <> clNone then
    begin
      Ellip := 0;
      if (BarShape = bsCylinder) and (ChartType <> ctBoxPlot) then
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

        if Chart.Series.IsHorizontal then
        begin
          DR.Left := DR.Left + (((Dr.Bottom - DR.Top) div 3) div 2);
          DR.Right := DR.Right + (((Dr.Bottom - DR.Top) div 3) div 2);

          Canvas.Ellipse(DR.Left + ((DR.Bottom - DR.Top) div 3) div 2, DR.Top, DR.Left - ((DR.Bottom - DR.Top) div 3) div 2, DR.Bottom);
          Ellip := CreateEllipticRgn(DR.Left + ((DR.Bottom - DR.Top) div 3) div 2, DR.Top + 1, DR.Left - ((DR.Bottom - DR.Top) div 3) div 2, DR.Bottom - 1);
        end
        else
        begin
          DR.Top := DR.Top - (((Dr.Right - DR.Left) div 3) div 2);
          DR.Bottom := DR.Bottom - (((Dr.Right - DR.Left) div 3) div 2);

          Canvas.Ellipse(DR.Left, DR.Top + ((DR.Right - DR.Left) div 3) div 2, DR.Right, DR.Top - ((DR.Right - DR.Left) div 3) div 2);
          Ellip := CreateEllipticRgn(DR.Left + 1, DR.Top + ((DR.Right - DR.Left) div 3) div 2, DR.Right, DR.Top - ((DR.Right - DR.Left) div 3) div 2);
        end;
      end;
      if (SColorTo <> clNone) then
      begin
        if (DR.Top > DR.Bottom) then
          HRGN := CreateRectRgn(DR.Left - bwidth , DR.Top + bwidth, DR.Right + bwidth, DR.Bottom - bwidth)
        else
          HRGN := CreateRectRgn(DR.Left - bwidth , DR.Top - bwidth, DR.Right + bwidth, DR.Bottom + bwidth);

        BarRgn := CreateRoundRectRgn(0, 0, 1, 1, 1, 1);
        CombineRgn(BarRgn, HRGN, FClipRgn, RGN_AND);
        if (BarShape = bsCylinder) and (ChartType <> ctBoxPlot)  then
        begin
          CombineRgn(BarRgn, Ellip, BarRgn, RGN_OR);
          if not Chart.Series.IsHorizontal then
            DR.Top := DR.Top + ((DR.Right - DR.Left) div 3) div 2
          else
            DR.Left := DR.Left + 2 - ((DR.Bottom - DR.Top) div 3) div 2;

          DeleteObject(Ellip);
        end;
        DeleteObject(HRGN);
        SelectObject(canvas.Handle, BarRgn);

        if Chart.Series.IsHorizontal then
          DrawGradient(Canvas, SColor, SColorTo,GradientSteps, DR,GradientDirection, true, BorderColor, BorderWidth, asRectangle, 0, [cbTop, cbBottom], True, BarShape = bsCylinder)
        else
          DrawGradient(Canvas, SColor, SColorTo,GradientSteps, DR,GradientDirection, true, BorderColor, BorderWidth, asRectangle, 0, [cbLeft, cbRight], false, BarShape = bsCylinder);

        DeleteObject(BarRgn);
        SelectObject(Canvas.Handle, FClipRgn);
      end
      else
      begin
        if (BarShape = bsCylinder) and (ChartType <> ctBoxPlot)  then
        begin
          Canvas.Pen.Color := clNone;
          Canvas.Pen.Style := psClear;
        end;
        Canvas.RoundRect(DR.Left, DR.Top, DR.Right, DR.Bottom, BorderRounding, BorderRounding);
        if (BarShape = bsCylinder)  and (ChartType <> ctBoxPlot) then
        begin
          Canvas.Pen.Style := PenStyle;
          Canvas.Pen.Color := BorderColor;
          if Chart.Series.IsHorizontal then
          begin
            Canvas.MoveTo(DR.Left, DR.Top);
            Canvas.LineTo(DR.Right, DR.Top);
            Canvas.MoveTo(DR.Left, DR.Bottom - 1);
            Canvas.LineTo(DR.Right, DR.Bottom - 1);
          end
          else
          begin
            Canvas.MoveTo(DR.Left, DR.Top);
            Canvas.LineTo(DR.Left, DR.Bottom);
            Canvas.MoveTo(DR.Right - 1, DR.Top);
            Canvas.LineTo(DR.Right - 1, DR.Bottom);
          end;
        end;
      end;
      if (BarShape = bsCylinder) and (ChartType <> ctBoxPlot)  then
      begin
        if Chart.Series.IsHorizontal then
          Canvas.Ellipse(DR.Right - ((DR.Bottom - DR.Top) div 3) div 2, DR.Top, DR.Right + ((DR.Bottom - DR.Top) div 3) div 2, DR.Bottom)
        else
          Canvas.Ellipse(DR.Left, DR.Bottom - ((DR.Right - DR.Left) div 3) div 2, DR.Right, DR.Bottom + ((DR.Right - DR.Left) div 3) div 2);
      end;
    end;

    if (ChartPattern.Graphic <> nil) then
    begin
      HRGN := CreateRoundRectRgn(DR.Left + bwidth , DR.Top + bwidth , DR.Right - bwidth ,  DR.Bottom - bwidth , BorderRounding, BorderRounding);

      BarRgn := CreateRoundRectRgn(0, 0, 1, 1, 1, 1);
      CombineRgn(BarRgn, HRGN, FClipRgn, RGN_AND);
      DeleteObject(HRGN);
      SelectObject(canvas.Handle, BarRgn);
      DrawPicture(Canvas, Dr, ScaleX, ScaleY);
      DeleteObject(BarRgn);
      SelectObject(Canvas.Handle, FClipRgn);
    end;
  end;

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

procedure TChartSerie.InitializeBorderColor(Canvas: TCanvas; Scalex,
  ScaleY: Double);
begin
  Canvas.Pen.Width := Round(BorderWidth * ScaleX);
  Canvas.Pen.Style := FPenStyle;

  if (BorderColor <> clNone) and (BorderWidth <> 0) then
    Canvas.Pen.Color := BorderColor
  else
    Canvas.Pen.Style := psClear;
end;

procedure TChartSerie.InitializePieLegendBorderColor(Canvas: TCanvas; Scalex,
  ScaleY: Double);
begin
  Canvas.Pen.Width := Round(Pie.LegendBorderWidth * ScaleX);
  Canvas.Pen.Style := psSolid;

  if Pie.LegendBorderColor <> clNone then
  begin
    Canvas.Pen.Style := psSolid;
    Canvas.Pen.Color := Pie.LegendBorderColor;
  end
  else
    Canvas.Pen.Style := psClear;
end;

procedure TChartSerie.InitializePieLegendBrushColor(Canvas: TCanvas);
begin
  if Pie.LegendColor <> clNone then
    Canvas.Brush.Color := Pie.LegendColor
  else
    Canvas.Brush.Style := bsclear;
end;

procedure TChartSerie.InitializeBrushColor(Canvas: TCanvas);
begin
  Canvas.Brush.style := FBrushStyle;

  if Color <> clNone then
    Canvas.Brush.Color := Color
  else
    Canvas.Brush.Style := bsclear;
end;

procedure TChartSerie.InitializeLineColor(Canvas: TCanvas; Scalex, ScaleY: Double);
begin
  Canvas.Pen.Width := Round(LineWidth * ScaleX);
  Canvas.Pen.Style := FPenStyle;

  if LineColor <> clNone then
    Canvas.Pen.Color := LineColor
  else
    Canvas.Pen.Style := psClear;
end;

procedure TChartSerie.InitializeWickColor(Canvas: TCanvas; ScaleX,
  ScaleY: Double);
begin
  Canvas.Pen.Width := Round(WickWidth * ScaleX);
  Canvas.Pen.Style := FPenStyle;

  if FWickColor <> clNone then
    Canvas.Pen.Color := FWickColor
  else
    Canvas.Pen.Style := psClear;
end;

function TChartSerie.IsDB: Boolean;
begin
  Result := false;
end;

function TChartSerie.IsEnabled3D: Boolean;
begin
  result := Enable3D and (Offset3D > 0);
end;

function TChartSerie.IsHalfPie: Boolean;
begin
  result := (ChartType = ctHalfPie) or (ChartType = ctHalfDonut) or (ChartType = ctHalfSpider)
    or (ChartType = ctSizedHalfPie) or (ChartType = ctSizedHalfDonut) or (ChartType = ctVarRadiusHalfPie)
    or (chartType = ctVarRadiusHalfDonut);
end;

function TChartSerie.IsPieChart: Boolean;
begin
  result := (ChartType = ctSpider) or (ChartType = ctHalfSpider) or (ChartType = ctPie) or (ChartType = ctFunnel) or (ChartType = ctHalfPie)
      or (ChartType = ctHalfDonut) or (ChartType = ctDonut) or (ChartType = ctSizedPie) or
        (ChartType = ctSizedHalfPie) or (ChartType = ctSizedDonut) or (chartType = ctSizedHalfDonut) or
          (ChartType = ctVarRadiusPie) or (ChartType = ctVarRadiusHalfPie) or (chartType = ctVarRadiusDonut) or
            (ChartType = ctVarRadiusHalfDonut);
end;

function TChartSerie.GetPieCenter(pbr: TRect): TPoint;
var
  centerv, centerh, psz: Double;
begin
  psz := Pie.GetPieSize div 2;
  centerv := 0;
  centerh := 0;

  case Pie.Position of
  spTopLeft:
  begin
    centerh := (pbr.Left + 5 + psz);
    centerv := (pbr.Top + 5 + psz);
  end;
  spTopRight:
  begin
    centerh := (pbr.Right - psz - 5);
    centerv := (pbr.Top + 5 + psz);
  end;
  spTopCenter:
  begin
    centerh := pbr.Left + ((pbr.Right - pbr.Left) div 2);
    centerv := (pbr.Top + 5 + psz);
  end;
  spBottomLeft:
  begin
    centerh := (pbr.Left + psz + 5);
    centerv := (pbr.Bottom - psz - 5);
  end;
  spBottomRight:
  begin
    centerh := (pbr.Right - psz - 5);
    centerv := (pbr.Bottom - psz - 5);
  end;
  spBottomCenter:
  begin
    centerh := pbr.Left + ((pbr.Right - pbr.Left) div 2);
    centerv := (pbr.Bottom - psz - 5);
  end;
  spCenterLeft:
  begin
    centerh := (pbr.Left + psz + 5);
    centerv := pbr.Top + ((pbr.Bottom - pbr.Top) div 2);
  end;
  spCenterCenter:
  begin
    centerh := pbr.Left + ((pbr.Right - pbr.Left) div 2);
    centerv := pbr.Top + ((pbr.Bottom - pbr.Top) div 2);
  end;
  spCenterRight:
  begin
    centerh := (pbr.Right - 5 - psz);
    centerv := pbr.Top + ((pbr.Bottom - pbr.Top) div 2);
  end;
  end;

  centerh := centerh + Pie.Left;
  centerv := centerv + Pie.Top;

  Result := Point(Round(centerh), Round(centerv));
end;

function TChartSerie.GetLegendCenter(pbr: TRect; width, height: integer): TPoint;
var
 centerv, centerh: Double;
begin
  centerv := 0;
  centerh := 0;
  case Pie.LegendPosition of
  spTopLeft:
  begin
    centerh := (pbr.Left + 5 + width);
    centerv := (pbr.Top + 5 + height);
  end;
  spTopRight:
  begin
    centerh := (pbr.Right - width - 5);
    centerv := (pbr.Top + 5 + height);
  end;
  spTopCenter:
  begin
    centerh := pbr.Left + ((pbr.Right - pbr.Left) div 2);
    centerv := (pbr.Top + 5 + height);
  end;
  spBottomLeft:
  begin
    centerh := (pbr.Left + width + 5);
    centerv := (pbr.Bottom - height - 5);
  end;
  spBottomRight:
  begin
    centerh := (pbr.Right - width - 5);
    centerv := (pbr.Bottom - height - 5);
  end;
  spBottomCenter:
  begin
    centerh := pbr.Left + ((pbr.Right - pbr.Left) div 2);
    centerv := (pbr.Bottom - height - 5);
  end;
  spCenterLeft:
  begin
    centerh := (pbr.Left + Width + 5);
    centerv := pbr.Top + ((pbr.Bottom - pbr.Top) div 2);
  end;
  spCenterCenter:
  begin
    centerh := pbr.Left + ((pbr.Right - pbr.Left) div 2);
    centerv := pbr.Top + ((pbr.Bottom - pbr.Top) div 2);
  end;
  spCenterRight:
  begin
    centerh := (pbr.Right - 5 - width);
    centerv := pbr.Top + ((pbr.Bottom - pbr.Top) div 2);
  end;
  end;

  centerh := centerh + Pie.LegendOffsetLeft;
  centerv := centerv + Pie.LegendOffsetTop;

  Result := Point(Round(centerh), Round(centerv));
end;


function TAdvChart.GetLegendItemAtXY(X, Y: Integer): TChartSerie;
var
  I, K: Integer;
  rsp, rs: integer;
  bmp: TBitmap;
  px, py, pw, ph: Integer;
  DR: TRect;
begin
  Result := nil;
  if Legend.FVisible = true then
  begin

    bmp := TBitmap.Create;

    rs := Legend.RectangleSize;
    rsp := Legend.RectangleSpacing;

    DR := Legend.GetRectangle;

    K := 0;
    for I := 0 to Series.Count - 1 do
    begin
      with Series.Items[I] do
      begin
        if (ChartType <> ctNone) and (SerieType <> stZoomControl) and ShowInLegend and Visible then
        begin
          ph := bmp.Canvas.TextHeight(LegendText);
          pw := bmp.Canvas.TextWidth(LegendText) + 2 * rsp + rs;
          pX := DR.Left;
          pY := rsp + DR.Top + ((rsp * K) + ((K) * rs) + (rs - ph) div 2);

          if PtInRect(Bounds(px, py, pw, ph), Point(X, Y)) then
          begin
            Result := Chart.Series[I];
            break;
          end;
          Inc(K);
        end;
      end;
    end;

    bmp.Free;

  end;
end;

function TChartSerie.GetYMajorUnitSpacing(Right: Boolean): integer;
var
  i: integer;
  bmp: TBitmap;
  R: TRect;
  chk: Boolean;
begin
  R := Bounds(0, 0, 0, 0);
  if Assigned(Chart.GetPaneRectangle) then
    Chart.GetPaneRectangle(Chart, R);

  bmp := TBitmap.Create;
  Result := 0;
  for I := 0 to Index - 1 do
  begin
    if Right then
      chk := (Chart.Series[i].YAxis.Position in [yRight, yBoth]) and (YAxis.Position in [yRight, yBoth])
    else
      chk := (Chart.Series[i].YAxis.Position in [yLeft, yBoth]) and (YAxis.Position in [yLeft, yBoth]);

    if chk then
    begin
      Result := Result + Chart.Series[I].GetYValuesSize(R, bmp.Canvas, 1, 1);
    end;
  end;

  bmp.Free;
end;

function TChartSerie.GetMaximumValue: Double;
var
  i: integer;
  pt: TChartPoint;
begin
  Result := 0;
  for I := 0 to GetPointsCount - 1 do
  begin
    pt := GetPoint(I);
    if pt.SingleValue > result then
      Result := pt.SingleValue;
  end;
end;

function TChartSerie.GetMaxLevel(Level: Integer): Integer;
var
  I: Integer;
  bmp: TBitmap;
  grouph: integer;
begin
  result := 0;
  bmp := TBitmap.Create;
  for I := 0 to XAxisGroups.Count - 1 do
  begin
    if XAxisGroups[I].Visible and (XAxisGroups[I].Level = Level) then
    begin
      bmp.Canvas.Font.Assign(XAxisGroups[i].Font);
      grouph := bmp.Canvas.TextHeight(XAxisGroups[i].Caption) + XAxisGroups[i].Spacing * 2;
      if grouph > result then
        result := grouph;
    end;
  end;
  bmp.Free;
end;

function TChartSerie.GetMaxPoints: Double;
var
  I: Integer;
  total: Double;
  pt: TChartPoint;
begin
  total := 0;
  for I := 0 to GetPointsCount - 1 do
  begin
    pt := GetPoint(I);
    if pt.SingleValue > total then
      total := pt.SingleValue;
  end;

  Result := total;
end;

function TChartSerie.GetYMinorUnitSpacing(Right: Boolean): Integer;
var
  i: integer;
  bmp: TBitmap;
  R: TRect;
  chk: Boolean;
begin
  R := Bounds(0, 0, 0, 0);
  if Assigned(Chart.GetPaneRectangle) then
    Chart.GetPaneRectangle(Chart, R);

  bmp := TBitmap.Create;
  Result := 0;
  for I := 0 to Index - 1 do
  begin
    if Right then
      chk := (Chart.Series[i].YAxis.Position in [yRight, yBoth]) and (YAxis.Position in [yRight, yBoth])
    else
      chk := (Chart.Series[i].YAxis.Position in [yLeft, yBoth]) and (YAxis.Position in [yLeft, yBoth]);

    if chk then
    begin
      Result := Result + Chart.Series[I].GetYValuesSize(R, bmp.Canvas, 1, 1);
    end;
  end;

  bmp.Free;
end;

function TChartSerie.GetNextValuePyramid(idx, i: integer): Double;
var
  rf, J, xpos: integer;
begin
  result := 0;

  if idx < 0 then
    Exit;

  rf := Chart.Range.RangeFrom;

  if rf < 0 then
    XPos := I
  else
    XPos := I + rf;

  if (Xpos >= 0) and (Xpos < GetPointsCount) then
  begin
    if not (ChartType = ctBar) and not (ChartType = ctBar) and not (ChartType = ctHistogram) and not (ChartType = ctLineBar)
      and not (ChartType = ctLineHistogram) then
    begin
      if (ChartType = ctStackedBar) then
      begin
        for J := 0 to idx do
        begin
          if (Chart.Series[J].ChartType = ctStackedBar) and (Chart.Series[j].GroupIndex = GroupIndex) then
            result := result + Chart.Series[J].GetPoint(xpos).SingleValue;
        end;
      end
      else if (ChartType = ctStackedPercBar) then
      begin
        for J := 0 to idx do
        begin
          if (Chart.Series[J].ChartType = ctStackedPercBar) and (Chart.Series[j].GroupIndex = GroupIndex) then
            result := result + Chart.Series[J].GetPoint(xpos).SingleValue;
        end;

        result := GetStackedPercValue(result, I);
      end;
    end
    else
    begin
      result := result + GetPoint(xpos).SingleValue;
    end;
  end;

  if Logarithmic then
    result := ConvertToLog(result)
end;

function TChartSerie.GetPieRectangle(Index: integer; R: TRect): TRect;
var
  part, cntdonut, cntpie, cntHalfDonut, cnthalfpie, cntFunnel: integer;
  DR: TRect;
begin
  DR := R;
  cntdonut := Chart.Series.GetCountChartType(ctDonut);
  cntpie := Chart.Series.GetCountChartType(ctPie);
  cnthalfpie := Chart.Series.GetCountChartType(ctHalfPie);
  cntHalfDonut := Chart.Series.GetCountChartType(ctHalfDonut);
  cntFunnel := Chart.Series.GetCountChartType(ctFunnel);

  if ((ChartType = ctDonut) or (ChartType = ctHalfDonut)) and (Chart.Series.DonutMode = dmStacked) then
  begin
    if (cntdonut > 0) and (cnthalfdonut = 0) then
      cntdonut := 1;

    if (cnthalfdonut > 0) and (cntdonut = 0) then
      cnthalfdonut := 1;

    if (cnthalfdonut > 0) and (cntdonut > 0) then
    begin
      cntdonut := 1;
      cnthalfdonut := 0;
    end;

    part := (DR.Right - DR.Left) div (cntHalfDonut + cnthalfpie + cntpie + cntdonut + cntFunnel);
    DR.Left := DR.Left;
  end
  else if (ChartType = ctSpider) or (ChartType = ctHalfSpider) then
  begin
    part := (DR.Right - DR.Left);
  end
  else
  begin
    part := ((DR.Right - DR.Left) div chart.series.count);
    DR.Left := DR.Left + (part * Index);
  end;

  DR.Right := DR.Left + part;
  Result := DR;
end;

function TChartSerie.GetPoint(AIndex: Integer): TChartPoint;
var
  c: TAdvChart;
begin
  Result := GetDefaultVirtualPoint;
  c := Chart;
  if not Assigned(c) then
    Exit;

  if (AIndex >= 0) and (AIndex <= Length(Points) - 1) then
    Result := Points[AIndex];

  c.DoGetPoint(Index, AIndex, Result);
end;

function TChartSerie.GetPointsCount: Integer;
var
  c: TAdvChart;
begin
  c := Chart;
  if not Assigned(c) then
    Exit;

  Result := Length(Points);
  c.DoGetNumberOfPoints(Index, Result);
  FLastPoint := Result;
end;

function TChartSerie.GetPreviousGanttGroupHeight: integer;
var
  I: Integer;
begin
  Result := 0;
  for I := Index - 1 downto 0 do
  begin
    if Chart.Series[I].ChartType = ctGantt then
      Result := Result + Chart.Series[I].GanttHeight + Chart.Series[I].GanttSpacing * 2;
  end;
end;

function TChartSerie.GetPrevSerieStackedValue(PointIndex: integer): Double;
begin
  Result := 0;
  if Index > 0 then
  begin
    if (PointIndex >= 0) and (PointIndex <= Chart.Series[Index - 1].GetPointsCount - 1) then
      Result := Chart.Series[Index - 1].GetPoint(PointIndex).SingleValue;
  end
  else
  begin
    if (PointIndex >= 0) and (PointIndex <= GetPointsCount - 1) then
      Result := GetPoint(PointIndex).SingleValue;
  end;
end;

function TChartSerie.GetQuadrant(center, pt: TPointF): TPieQuadrant;
begin
  if (center.X <= pt.X) and (center.Y >= pt.Y) then
    result := pq1
  else if (center.X < pt.X) and (center.Y < pt.Y) then
    result := pq4
  else if (center.X >= pt.X) and (center.Y >= pt.Y) then
    result := pq2
  else
    result := pq3;
end;

function TChartSerie.GetBarWidth(ScaleX: Double): integer;
var
  dp1, dp2: TPoint;
  bw, pw: integer;
  bcnt: Integer;
  bargroupspc: integer;
begin
  dp1 := GetDrawPoint(0);
  dp2 := GetDrawPoint(1);

  bcnt := Chart.Series.GetCountChartType(ctBar);
  bcnt := bcnt + Chart.Series.GetCountChartType(ctLineBar);
  bcnt := bcnt + Chart.Series.GetCountChartType(ctHistogram);
  bcnt := bcnt + Chart.Series.GetCountChartType(ctLineHistogram);

  if (ChartType = ctStackedBar) or (ChartType = ctStackedPercBar) then
    bcnt := Chart.Series.GetCountGroupedChartType(ChartType);

  if Length(DrawPoints) > 1 then
  begin
    if Chart.Series.IsHorizontal then
      pw := dp2.y - dp1.y
    else
      pw := dp2.x - dp1.x
  end
  else
    pw := Round(Chart.XScale);

  bargroupspc := 0;
  case Chart.Series.BarChartSpacingType of
    wtPixels: bargroupspc := Chart.Series.BarChartSpacing;
    wtPercentage: bargroupspc := Round(pw * Chart.Series.BarChartSpacing / 100);
  end;

  bw := 0;
  case FValueWidthType of
    wtPixels: bw := Round(FValueWidth * ScaleX);
    wtPercentage:
    if bcnt > 0 then
      bw := Round((((pw - bargroupspc) / bcnt) * FValueWidth) / 100);
  end;

  if bw < 1 then
    bw := 1;

  Result := bw;
end;

function TChartSerie.GetPercentageValue(SingleValue: Double): String;
var
  totalpoints: Double;
begin
  totalPoints := GetTotalPoints;
  if singleValue <> totalPoints then
  begin
    if ValueFormat <> '' then
    begin
      case ValueFormatType of
        vftNormal: Result := Format(FValueFormat,[SingleValue / totalPoints * 100]);
        vftFloat: Result := FormatFloat(FValueFormat,SingleValue / totalPoints * 100);
      end;
    end
    else
      Result := '';
  end
  else
    Result := '100';
end;

function TChartSerie.GetTotalPoints: Double;
var
  I: Integer;
  total: Double;
begin
  total := 0;
  for I := 0 to GetPointsCount - 1 do
  begin
    total := total + GetPoint(I).SingleValue;
  end;

  Result := total;
end;

function TChartSerie.GetTotalSeriesValuePyramid(i: integer): Double;
var
  rf, J, xpos: integer;
begin
  result := 0;

  rf := Chart.Range.RangeFrom;

  if rf < 0 then
    XPos := I
  else
    XPos := I + rf;

  if (Xpos >= 0) and (Xpos < GetPointsCount) then
  begin
    if not (ChartType = ctBar) and not (ChartType = ctHistogram) and not (ChartType = ctLineBar)
      and not (ChartType = ctLineHistogram) then
    begin
      for J := 0 to Chart.Series.Count - 1 do
      begin
        if (Chart.Series[J].ChartType = ctStackedBar) and (GroupIndex = Chart.Series[j].GroupIndex) then
          result := result + Chart.Series[J].GetPoint(xpos).SingleValue
        else if (Chart.Series[J].ChartType = ctStackedPercBar) and (GroupIndex = Chart.Series[j].GroupIndex) then
          result := 100;
      end;
    end
    else
    begin
      result := result + GetPoint(xpos).SingleValue;
    end;
  end;

  if Logarithmic then
    Result := ConvertToLog(Result);
end;

function TChartSerie.GetXValuesSize(Canvas: TCanvas; ScaleX, ScaleY: Double; var totalxSize: Integer): Integer;
var
  x, fv, tv, tw: Integer;
  xs: Double;
  df: Boolean;
  totalSize, res: Integer;
  groupcount, groupmax, totalh, K: integer;
  level: Integer;
begin
  Result := 0;
  totalsize := 0;
  totalxSize := 0;

  fv := Chart.Range.RangeFrom;
  tv := Chart.Range.RangeTo;

  xs := Chart.XScale;

  if xs = 0 then
    exit;

  Fmu := round(XAxis.MajorUnit);
  Fmi := round(XAxis.MinorUnit);

  FMinimumDistance := Chart.FXScale;

  Ffirstpoint := 1 * FMinimumDistance;
  Fnextpoint := (1 + Fmi) * FMinimumDistance;

  tw := Canvas.TextWidth('WW');

  if FMi <> 0 then
  begin
    if XAxis.AutoUnits then
    begin
      while Ffirstpoint + tw + 4 >= Fnextpoint do
      begin
        Ffirstpoint := 1 * FMinimumDistance;
        Fnextpoint := (1 + Fmi) * FMinimumDistance;
        Fmi := Fmi + Fmi;
      end;
    end;
  end;

  Ffirstpoint := 1 * FMinimumDistance;
  Fnextpoint := (1 + Fmu) * FMinimumDistance;

  if FMu <> 0 then
  begin
    if XAxis.AutoUnits then
    begin
      while Ffirstpoint + tw + 4 >= Fnextpoint do
      begin
        Ffirstpoint := 1 * FMinimumDistance;
        Fnextpoint := (1 + Fmu) * FMinimumDistance;
        Fmu := Fmu + Fmu;
      end;
    end;
  end;

  if (Fmu = 0) and (Fmi = 0) then
    Exit;

  if XAxis.Visible then
  begin
    for X := fv to tv do
    begin
      if Chart.Series.IsHorizontal then
      begin
        df := true;
        res := GetXAxisValueSize(Self, Self, Canvas, X, ScaleX, ScaleY, not DrawFromStartDate, df);
        if res > totalSize then
          totalsize := res;
      end
      else
      begin
        df := true;
        res := GetXAxisValueSize(Self, Self, Canvas, X, ScaleX, ScaleY, not DrawFromStartDate, df);
        if res > totalSize then
          totalsize := res;
      end;
    end;

    if ((ChartType = ctXYLine) or (ChartType = ctXYDigitalLine) or (ChartType = ctXYMarkers)) and XAxis.XYValues then
    begin
      for X := 0 to GetPointsCount - 1 do
      begin
        if GetPoint(X).Defined then
        begin
          res := GetXAxisValueSize(Self, Self, Canvas, X,ScaleX, ScaleY, false, df) + XAxis.XYValuesOffset;
          if res > totalXSize then
            totalXsize := res;
        end;
      end;

      totalSize := totalSize + totalxSize;
    end;
  end;

  if XAxisGroupsVisible and XAxis.Visible then
  begin
    groupcount := 0;
    totalh := 0;
    for K := 0 to XAxisGroups.Count - 1 do
    begin
      if XAxisGroups[k].Visible then
        Inc(groupCount);
    end;

    level := -1;
    for K := 0 to XAxisGroups.Count - 1 do
    begin
      if groupcount > 0 then
      begin
        if XAxisGroups[K].Visible then
        begin
          if XAxisGroups[K].Level > level then
          begin
            level := XAxisGroups[K].Level;
            groupmax := GetMaxLevel(XAxisGroups[K].Level);
            totalh := totalh + groupmax;
          end;
        end;
      end;
    end;

    totalsize := totalsize + totalh;
  end;

  Result := totalsize;
end;

function TChartSerie.GetXYPoint(X, Y: integer): Integer;
var
  I: Integer;
  valX, valY, valDiffX, valDiffY, valResX, valResY: Double;
  pts: array of Integer;
  ptsSave: array of Integer;
  K: Integer;
  iVal: Integer;
  iRes: Integer;
  J: Integer;
  check: Boolean;
begin
  iVal := -1;
  iRes := -1;
  valResX := MaxDouble;
  valResY := MaxDouble;
  SetLength(pts, 0);

  valX := XToValue(X, Chart.Series.SeriesRectangle);

  for I := 0 to GetPointsCount - 1 do
  begin
    valDiffX := Abs(GetPoint(i).SingleXValue - valX);

    if valDiffX < valresX then
    begin
      valResX := valDiffX;
      SetLength(pts, 1);
      pts[Length(pts) -  1] := I;
    end;
  end;

  SetLength(ptsSave, 0);
  for K := 0 to Length(pts) - 1 do
  begin
    for I := 0 to GetPointsCount - 1 do
    begin
      if (pts[K] <> i) and (GetPoint(pts[K]).SingleXValue = GetPoint(i).SingleXValue) then
      begin
        SetLength(ptsSave, Length(ptsSave) + 1);
        ptsSave[Length(ptsSave)-1] := i;
      end;
    end;
  end;

  for K := 0 to Length(ptsSave) - 1 do
  begin
    SetLength(pts, Length(pts) + 1);
    pts[Length(pts) - 1] := ptsSave[K];
  end;

  for I := 0 to GetPointsCount - 1 do
  begin
    check := false;
    for J := 0 to Length(pts) - 1 do
    begin
      if (pts[J] = I) then
      begin
        check := true;
        break;
      end;
    end;

    if check then
    begin
      valY := ValueToY(GetPoint(i).SingleValue, Chart.Series.SeriesRectangle);
      valDiffY := Abs(valY - Y);

      if valDiffY < valresy then
      begin
        valResY := valDiffY;
        iVal := i;
      end;
    end;
  end;

  for I := 0 to Length(pts) - 1 do
  begin
    if pts[I] = iVal then
    begin
      iVal := pts[i];
      iRes := iVal;
      break;
    end;
  end;

  Result := iRes;
end;

procedure TChartSerie.DrawPieLegend(Canvas: TCanvas; x, y, width, height: integer; ScaleX, ScaleY: Double);
var
  LRect: TRect;
  drawnongradient: Boolean;
  xSymbol: integer;
  xText: integer;
  yText: integer;
  I: integer;
  pts: array[0..3] of TPoint;
  titleh: integer;
  titlerect: Trect;
  FRGB: TRGBTriplet;
  FHSV: THSVTriplet;
  spc: integer;
  str: string;
  th: integer;
begin
  with Pie do
  begin
    LRect := Bounds(x - width, y - height, 2 * width, 2 * height);
    spc := 5;

    drawnongradient := false;

    if (Color <> clNone) then
    begin
      if (ColorTo <> clNone) then
        DrawGradient(Canvas, LegendColor, LegendColorTo, LegendGradientSteps, Bounds(LRect.Left, LRect.Top, LRect.Right - LRect.Left, LRect.Bottom - LRect.Top), LegendGradientDirection,
          LegendBorderColor <> clNone, LegendBorderColor, LegendBorderWidth, asRectangle, 0, [cbLeft, cbTop, cbRight, cbBottom], false, false)
      else
        drawnongradient := true;
    end
    else
      drawnongradient := true;

    if drawnongradient then
    begin
      InitializePieLegendBrushColor(Canvas);
      InitializePieLegendBorderColor(Canvas, ScaleX, ScaleY);
      Canvas.Rectangle(Bounds(LRect.Left, LRect.Top, LRect.Right - LRect.Left, LRect.Bottom - LRect.Top));
    end;

    for I := 0 to GetPointsCount - 1 do
    begin
      xSymbol := Round(LRect.Left + spc * 2);
      xText := LRect.Left + spc * 4;
      yText := LRect.Top + 5 + Round(I  * ((LRect.Bottom - LRect.Top - 5) / GetPointsCount));
      Canvas.Brush.Style := bsClear;
      if GetPoint(I).Defined then
      begin
        case ValueType of
          cvNone: Canvas.TextOut(xText, yText, GetPoint(I).LegendValue);
          cvNormal:
          begin
            if ValueFormat <> '' then
            begin
              case ValueFormatType of
                vftNormal: str := GetPoint(I).LegendValue + ' (' + Format(ValueFormat, [GetPoint(I).SingleValue]) + ')';
                vftFloat: str := GetPoint(I).LegendValue + ' (' + FormatFloat(ValueFormat, GetPoint(I).SingleValue) + ')';
              end;
            end;
          end;
          cvPercentage: str := GetPoint(I).LegendValue + ' (' + GetPercentageValue(GetPoint(I).SingleValue) + '%)';
        end;
      end
      else
        str := 'Undefined';

      Canvas.TextOut(xText, yText, str);
      th := Round(Canvas.TextHeight(str) / 2);

      //draw symbols
      pts[0] := Point(xSymbol - Round(spc * ScaleX), yText + th - spc);
      pts[1] := Point(xSymbol + Round(spc * ScaleX), yText + th - spc);
      pts[2] := Point(xSymbol + Round(spc * ScaleX), yText + th + spc);
      pts[3] := Point(xSymbol - Round(spc * ScaleX), yText + th + spc);

      if (ChartType <> ctSpider) and (ChartType <> ctHalfSpider) then
      begin
        if GetPoint(I).Color <> clNone then
        begin
          Canvas.Brush.Color := GetPoint(I).Color;
        end
        else
        begin
          fRGB.B := (Color and $0000FF);
          fRGB.G := (Color and $00FF00) shr 8;
          fRGB.R := (Color and $FF0000) shr 16;
          RGBToHSV(fRGB.B, fRGB.G, fRGB.R, fHSV.H, fHSV.S, fHSV.V);
          fHSV.V := ((I + 1) / GetPointsCount) * fHSV.V;
          HSVToRGB(fHSV.H, fHSV.S, fHSV.V, fRGB.R, fRGB.G, fRGB.B);
          Canvas.Brush.Color := RGB(Round(FRGB.R), Round(FRGB.G), Round(FRGB.B));
        end
      end
      else
      begin
        Canvas.Brush.Color := Color;
      end;

      InitializeBorderColor(Canvas, ScaleX, ScaleY);

      Canvas.Polygon(pts);
    end;

    if LegendTitleVisible then
    begin
      titleh := Canvas.TextHeight(LegendText);
      titlerect := Rect(LRect.Left, LRect.Top - titleh, LRect.Right, LRect.Top);
      if (LegendTitleColor <> clNone) then
      begin
        if (LegendTitleColorTo <> clNone) then
        begin
          DrawGradient(Canvas, LegendTitleColor, LegendTitleColorTo, LegendTitleGradientSteps, titlerect, LegendTitleGradientDirection, LegendBorderColor <> clNone, LegendBorderColor, LegendBorderWidth, asRectangle, 0, [cbLeft, cbTop, cbRight, cbBottom], false, false)
        end
        else
          drawnongradient := true;
      end
      else
        drawnongradient := true;

      if drawnongradient then
      begin
        if Pie.LegendTitleColor <> clNone then
          Canvas.Brush.Color := Pie.LegendTitleColor
        else
          Canvas.Brush.Style := bsclear;

        InitializePieLegendBorderColor(Canvas, ScaleX, ScaleY);

        Canvas.Rectangle(titlerect);
      end;

      Canvas.Brush.Style := bsClear;
      Canvas.TextOut(titlerect.Left, titlerect.Top, LegendText);
    end;
  end;
end;

procedure TChartSerie.DrawPieSlice(Canvas: TCanvas; Center:  TPoint; Radius, RadiusInner, centerh, centerv, indent: integer; StartAngle, SweepAngle: Double; PointIndex: integer;
ScaleX, ScaleY: Double);
var
  X1,X2,X3,X4,X5,X6: integer;
  Y1,Y2,Y3,Y4,Y5,Y6: integer;
  c: TPoint;
  ex, ey, pszinner: integer;
  donutrgn, resultrgn: THandle;
begin
  resultrgn := 0;
  pszinner := Round((Pie.GetPieInnerSize div 2) * ScaleX);
  if (ChartType = ctDonut) or (ChartType = cthalfDonut) or
    (ChartType = ctSizedDonut) or (ChartType = ctSizedHalfDonut) or
      (ChartType = ctVarRadiusDonut) or (charttype = ctVarRadiusHalfDonut) then
  begin
    donutrgn := CreateEllipticRgn(center.x - pszinner - indent, center.y - pszinner  - indent, center.x + pszinner + indent, center.y + pszinner + indent);
    resultrgn := CreateEllipticRgn(0, 0, 1, 1);
    CombineRgn(resultrgn, donutrgn, FClipRgn, RGN_XOR);
    DeleteObject(donutrgn);
    SelectObject(canvas.Handle, resultrgn);
  end;

  ex := Round(indent * Cos((Pie.StartOffsetAngle -StartAngle + -SweepAngle / 2) * PI / 180));
  ey := Round(indent * Sin((Pie.StartOffsetAngle -StartAngle + -SweepAngle / 2) * PI / 180));

  c := Point(center.X + ex, center.Y + ey);

  X1 := c.X - Radius;
  Y1 := c.Y - Radius;
  X2 := c.X + Radius;
  Y2 := c.Y + Radius;

  if (StartAngle = 0) and (SweepAngle = 360) then
  begin
    X3 := c.X + Round(Radius * COS(DegToRad(Pie.StartOffsetAngle + StartAngle)));
    Y3 := c.y - Round(Radius * SIN(DegToRad(Pie.StartOffsetAngle + StartAngle)));
    X4 := c.X + Round(Radius * COS(DegToRad(Pie.StartOffsetAngle + StartAngle + SweepAngle)));
    Y4 := c.y - Round(Radius * SIN(DegToRad(Pie.StartOffsetAngle + StartAngle + SweepAngle)));
    X5 := c.X + Round(RadiusInner * COS(DegToRad(Pie.StartOffsetAngle + StartAngle)));
    Y5 := c.y - Round(RadiusInner * SIN(DegToRad(Pie.StartOffsetAngle + StartAngle)));
    X6 := c.X + Round(RadiusInner * COS(DegToRad(Pie.StartOffsetAngle + StartAngle + SweepAngle)));
    Y6 := c.y - Round(RadiusInner * SIN(DegToRad(Pie.StartOffsetAngle + StartAngle + SweepAngle)));
  end
  else
  begin
    X3 := c.X + Floor(Radius * COS(DegToRad(Pie.StartOffsetAngle + StartAngle)));
    Y3 := c.y - Floor(Radius * SIN(DegToRad(Pie.StartOffsetAngle + StartAngle)));
    X4 := c.X + Ceil(Radius * COS(DegToRad(Pie.StartOffsetAngle + StartAngle + SweepAngle)));
    Y4 := c.y - Ceil(Radius * SIN(DegToRad(Pie.StartOffsetAngle + StartAngle + SweepAngle)));
    X5 := c.X + Floor(RadiusInner * COS(DegToRad(Pie.StartOffsetAngle + StartAngle)));
    Y5 := c.y - Floor(RadiusInner * SIN(DegToRad(Pie.StartOffsetAngle + StartAngle)));
    X6 := c.X + Ceil(RadiusInner * COS(DegToRad(Pie.StartOffsetAngle + StartAngle + SweepAngle)));
    Y6 := c.y - Ceil(RadiusInner * SIN(DegToRad(Pie.StartOffsetAngle + StartAngle + SweepAngle)));
  end;

  Canvas.Pie(X1,Y1,X2,Y2,X3,Y3,X4,Y4);

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

  if (ChartType = ctDonut) or (ChartType = ctHalfDonut) or
    (ChartType = ctSizedDonut) or (ChartType = ctSizedHalfDonut) or
      (ChartType = ctVarRadiusDonut) or (ChartType = ctVarRadiusHalfDonut) then
  begin
    DeleteObject(resultrgn);
    SelectObject(Canvas.Handle, FClipRgn);
  end;
end;

procedure TChartSerie.DrawPieValues(Canvas: TCanvas; indent: integer; Center: TPoint; radius, StartAngle, SweepAngle: Double; PointIndex: integer; ScaleX, ScaleY: Double);
var
  c: TPoint;
  ex, ey, th, tw: integer;
  s: String;
begin
  if ValueType <> cvNone then
  begin
    if (ChartType = ctSpider) or (ChartType = ctHalfSpider) or (Pie.ValuePosition = vpOutSideSlice) then
    begin
      ex := Round(((Radius + indent)) * Cos((-Pie.StartOffsetAngle -StartAngle + -SweepAngle / 2) * PI / 180));
      ey := Round(((Radius + indent)) * Sin((-Pie.StartOffsetAngle -StartAngle + -SweepAngle / 2) * PI / 180));
      c := Point(center.X + ex, center.Y + ey);
    end
    else
    begin
      ex := Round(((Radius / 2 + indent)) * Cos((-Pie.StartOffsetAngle -StartAngle + -SweepAngle / 2) * PI / 180));
      ey := Round(((Radius / 2 + indent)) * Sin((-Pie.StartOffsetAngle -StartAngle + -SweepAngle / 2) * PI / 180));
      c := Point(center.X + ex, center.Y + ey);
    end;

    if ValueFormat <> '' then
    begin
      case ValueType of
        cvNormal:
        begin
          case ValueFormatType of
            vftNormal: s := Format(ValueFormat, [GetPoint(PointIndex).SingleValue]);
            vftFloat:  s := FormatFloat(ValueFormat, GetPoint(PointIndex).SingleValue);
          end;
        end;
        cvPercentage: s := GetPercentageValue(GetPoint(PointIndex).SingleValue) + '%';
      end;
    end;

    if Pie.ShowLegendOnSlice then
    begin
      s := GetPoint(PointIndex).LegendValue + ' (' + s+')';
    end;

    if Assigned(FOnSerieSliceGetValue) then
      FOnSerieSliceGetValue(Self, Self.Index, GetPoint(PointIndex).LegendValue, GetPoint(PointIndex).SingleValue, PointIndex, c, s);

    tw := Canvas.TextWidth(s);
    th := Canvas.TextHeight(s);
    if (ChartType = ctSpider) or (Pie.ValuePosition = vpOutSideSlice) then
    begin
      case GetQuadrant(PointF(center.X, center.Y), PointF(c.X, c.Y)) of
        pq1: c := Point(c.X + 5, c.Y - th);
        pq2: c := Point(c.X - tw - 5, c.Y - th);
        pq3: c := Point(c.x - tw - 5, c.Y);
        pq4: c := Point(c.X + 5, c.Y);
      end;
    end
    else if (Pie.ValuePosition = vpInsideSlice) then
      c := Point(c.X - tw div 2, c.Y - th div 2);

    case ValueType of
      cvPercentage, cvNormal: Canvas.TextOut(c.X, c.Y, s);
    end;
  end;
end;

procedure TChartSerie.DrawPyramid(Canvas: TCanvas; SColor, SColorTo: TColor;
  Dr: TRect; ScaleX, ScaleY: Double; Idx: Integer; val: Double);
var
  dheight: double;
  dstep: double;
  delta1,delta2: Integer;
  polypoints: array [0..3] of TPoint;
  arr3D: array [0..3] of TPoint;
  x: Integer;
  w: Double;
begin
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

  // draw stacked pyramid. X,Y is the center of the pyramid bottom
  delta1 := Round((dheight - dstep)/dheight * w / 2);
  if Chart.Series.IsHorizontal then
  begin
    PolyPoints[0].Y := x - delta1;
    PolyPoints[0].x := ValueToY(dstep, Chart.Series.SeriesRectangle);
    PolyPoints[1].y := x + delta1;
    PolyPoints[1].x := ValueToY(dstep, Chart.Series.SeriesRectangle);
  end
  else
  begin
    PolyPoints[0].X := x - delta1;
    PolyPoints[0].Y := ValueToY(dstep, Chart.Series.SeriesRectangle);
    PolyPoints[1].X := x + delta1;
    PolyPoints[1].Y := ValueToY(dstep, Chart.Series.SeriesRectangle);
  end;

  dstep := GetNextValuePyramid(Index, idx);

  delta2 := Round((dheight - dstep)/dheight * w / 2);

  if Chart.Series.IsHorizontal then
  begin
    PolyPoints[2].y := x + delta2;
    PolyPoints[2].x := ValueToY(dstep, Chart.Series.SeriesRectangle);
    PolyPoints[3].y := x - delta2;
    PolyPoints[3].x := ValueToY(dstep, Chart.Series.SeriesRectangle);
  end
  else
  begin
    PolyPoints[2].X := x + delta2;
    PolyPoints[2].Y := ValueToY(dstep, Chart.Series.SeriesRectangle);
    PolyPoints[3].X := x - delta2;
    PolyPoints[3].Y := ValueToY(dstep, Chart.Series.SeriesRectangle);
  end;

  InitializeBorderColor(Canvas, ScaleX, ScaleY);
  InitializeBrushColor(Canvas);

  Polygon(Canvas.Handle, Polypoints, 4);

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
      Canvas.Brush.Color := DarkenColor(Canvas.Brush.Color, Darken3D);
      Polygon(Canvas.Handle, Polypoints, 4);
      if DR.Left > DR.Right then
      begin
        arr3D[0] := Point(Dr.Left, Dr.Top);
        arr3D[1] := Point(Dr.Left + Offset3D, Dr.Top + Offset3D);
        arr3D[2] := Point(Dr.Left + Offset3D, Dr.Bottom + Offset3D);
        arr3D[3] := Point(Dr.Left, Dr.Bottom);
        Polygon(Canvas.Handle, arr3D, 4);
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
      Canvas.Brush.Color := DarkenColor(Canvas.Brush.Color, Darken3D);
      Polygon(Canvas.Handle, Polypoints, 4);
      if DR.Top < DR.Bottom then
      begin
        arr3D[0] := Point(Dr.Left, Dr.Top);
        arr3D[1] := Point(Dr.Left + Offset3D, Dr.Top - Offset3D);
        arr3D[2] := Point(Dr.Right + Offset3D, Dr.Top - Offset3D);
        arr3D[3] := Point(Dr.Right, Dr.Top);
        Polygon(Canvas.Handle, arr3D, 4);
      end;
    end;
  end;
end;

procedure TChartSerie.DrawSelected(ACanvas: TCanvas; r: TRect);
var
  oldbrushstyle: TBrushStyle;
  oldpencolor: TColor;
  oldpenwidth: integer;
  oldbrushcolor: TColor;
  oldpenstyle: TPenStyle;
  size: integer;
begin
  if not SelectedMark then
    Exit;

  oldpenstyle := ACanvas.Pen.style;
  oldbrushcolor := ACanvas.Brush.color;
  oldbrushstyle := ACanvas.Brush.Style;
  oldpenColor := ACanvas.Pen.Color;
  oldpenwidth := ACanvas.Pen.Width;

  ACanvas.Brush.Color := SelectedMarkColor;
  ACanvas.Pen.Style := psSolid;
  ACanvas.Pen.Width := 1;
  ACanvas.Pen.Color := SelectedMarkBorderColor;

  size := SelectedMarkSize;

  //lefttop
  ACanvas.Ellipse(Bounds(r.Left - size div 2, r.Top - size div 2, size, size));
  //righttop
  ACanvas.Ellipse(Bounds(r.right - size div 2, r.Top - size div 2, size, size));
  //leftbottom
  ACanvas.Ellipse(Bounds(r.Left - size div 2, r.bottom - size div 2, size, size));
  //rightbottom
  ACanvas.Ellipse(Bounds(r.Right - size div 2, r.bottom - size div 2, size, size));

  ACanvas.pen.Style := oldpenstyle;
  ACanvas.Brush.Style := oldbrushstyle;
  ACanvas.Brush.Color := oldbrushcolor;
  ACanvas.Pen.Color := oldpencolor;
  ACanvas.Pen.Width := oldpenwidth;
end;

procedure TChartSerie.DrawSelectedFunnel(ACanvas: TCanvas;
  ptFunnel: TFunnelPoint);
var
  oldbrushstyle: TBrushStyle;
  oldpencolor: TColor;
  oldpenwidth: integer;
  oldbrushcolor: TColor;
  oldpenstyle: TPenStyle;
  size: integer;
begin
  if not SelectedMark then
    Exit;

  oldpenstyle := ACanvas.Pen.style;
  oldbrushcolor := ACanvas.Brush.color;
  oldbrushstyle := ACanvas.Brush.Style;
  oldpenColor := ACanvas.Pen.Color;
  oldpenwidth := ACanvas.Pen.Width;

  ACanvas.Brush.Color := SelectedMarkColor;
  ACanvas.Pen.Style := psSolid;
  ACanvas.Pen.Width := 1;
  ACanvas.Pen.Color := SelectedMarkBorderColor;

  size := SelectedMarkSize;

  ACanvas.Ellipse(Bounds(ptFunnel.X0 - size div 2, ptFunnel.Y0 - size div 2, size, size));
  ACanvas.Ellipse(Bounds(ptFunnel.X1 - size div 2, ptFunnel.Y1 - size div 2, size, size));
  ACanvas.Ellipse(Bounds(ptFunnel.X2 - size div 2, ptFunnel.Y2 - size div 2, size, size));
  ACanvas.Ellipse(Bounds(ptFunnel.X3 - size div 2, ptFunnel.Y3 - size div 2, size, size));

  ACanvas.pen.Style := oldpenstyle;
  ACanvas.Brush.Style := oldbrushstyle;
  ACanvas.Brush.Color := oldbrushcolor;
  ACanvas.Pen.Color := oldpencolor;
  ACanvas.Pen.Width := oldpenwidth;
end;

procedure TChartSerie.DrawSelectedSlice(ACanvas: TCanvas; ptslice: TSlicePoint);
var
  oldbrushstyle: TBrushStyle;
  oldpencolor: TColor;
  oldpenwidth: integer;
  oldbrushcolor: TColor;
  oldpenstyle: TPenStyle;
  size: Integer;
begin
  if not SelectedMark then
    Exit;

  oldpenstyle := ACanvas.Pen.style;
  oldbrushcolor := ACanvas.Brush.color;
  oldbrushstyle := ACanvas.Brush.Style;
  oldpenColor := ACanvas.Pen.Color;
  oldpenwidth := ACanvas.Pen.Width;

  ACanvas.Brush.Color := SelectedMarkColor;
  ACanvas.Pen.Style := psSolid;
  ACanvas.Pen.Width := 1;
  ACanvas.Pen.Color := SelectedMarkBorderColor;

  size := SelectedMarkSize;

  case ChartType of
    ctHalfSpider, ctSpider, ctHalfPie, ctPie, ctFunnel, ctSizedPie, ctSizedHalfPie, ctVarRadiusPie, ctVarRadiusHalfPie:
    begin
      ACanvas.Ellipse(Bounds(ptSlice.X0 - size div 2, ptslice.Y0 - size div 2, size, size));
      ACanvas.Ellipse(Bounds(ptSlice.X1 - size div 2, ptslice.Y1 - size div 2, size, size));
      ACanvas.Ellipse(Bounds(ptSlice.X2 - size div 2, ptslice.Y2 - size div 2, size, size));
    end;
    ctHalfDonut, ctDonut, ctSizedDonut, ctSizedHalfDonut, ctVarRadiusDonut, ctVarRadiusHalfDonut:
    begin
      ACanvas.Ellipse(Bounds(ptSlice.X1 - size div 2, ptslice.Y1 - size div 2, size, size));
      ACanvas.Ellipse(Bounds(ptSlice.X2 - size div 2, ptslice.Y2 - size div 2, size, size));
      ACanvas.Ellipse(Bounds(ptSlice.X3- size div 2, ptslice.Y3- size div 2, size, size));
      ACanvas.Ellipse(Bounds(ptSlice.X4- size div 2, ptslice.Y4- size div 2, size, size));
    end;
  end;

  ACanvas.pen.Style := oldpenstyle;
  ACanvas.Brush.Style := oldbrushstyle;
  ACanvas.Brush.Color := oldbrushcolor;
  ACanvas.Pen.Color := oldpencolor;
  ACanvas.Pen.Width := oldpenwidth;
end;

procedure TChartSerie.DrawSpiderArea(Canvas: TCanvas; R: TRect; SpiderArea: TPointArray; ScaleX, ScaleY: Double);
var
  hrgn: THandle;
  AreaRGN: THandle;
begin
  HRGN := CreatePolygonRgn(SpiderArea[0], Length(SpiderArea), ALTERNATE);
  AreaRGN := CreateRectRgn(0, 0, 1, 1);
  CombineRgn(AreaRGN, HRGN, FClipRgn, RGN_AND);

  DeleteObject(HRGN);
  SelectClipRgn(Canvas.Handle,AreaRGN);

  if FColorTo <> clNone then
  begin
    DrawGradient(Canvas, FColor, FColorTo, FGradientSteps, R, FGradientDirection, true, BorderColor, BorderWidth, asRectangle, 0, [cbLeft, cbTop, cbRight, cbBottom], false, false);
  end
  else
  begin
    Canvas.Pen.Style := psClear;
    InitializeBrushColor(Canvas);
    Canvas.Polygon(SpiderArea);
    Canvas.Pen.Color := FLineColor;
    Canvas.Pen.Style := FPenStyle;
  end;

  DrawPicture(Canvas, R, Scalex, ScaleY);

  DeleteObject(AreaRGN);
  SelectClipRgn(Canvas.Handle,FClipRgn);

  if (LineWidth <> 0) and (LineColor <> clNone) then
  begin
    InitializeLineColor(Canvas, ScaleX, ScaleY);
    Canvas.Polyline(SpiderArea);
  end;
end;

procedure TChartSerie.DrawGridCircles(Canvas: TCanvas; center: TPoint; R: TRect; YG: TChartYGrid; mu,
  mi, ys, ScaleX, ScaleY: Double);
var
  min, JMax, JMin: Double;
  diff: integer;
  pos: Double;
  domaj, domin, domajv, dominv: Boolean;
  dolast: Boolean;
  max: Double;
  rad: Integer;
  totalpie: Double;
  startangle, sweepangle: Double;
  cAngle, cntspid: Integer;
  c: TPoint;
  x, y: integer;
begin
  dolast := false;
  if Pie.ShowGrid then
  begin
    min := 0;
    max := MaximumValue;
    JMax := min;
    JMin := min;

    domaj := (mu > 0);
    domin := (mi > 0);

    Canvas.Brush.Style := bsClear;

    if (domaj) then
    begin
      while (JMin <= max) or dolast do
      begin
        domajv := true;{JMax <= max;}
        if domajv then
        begin
          if (YG.MajorLineColor <> clNone) and (YG.MajorLineStyle <> psClear) and (YG.MajorLineWidth <> 0) then
          begin
            pos := Round(R.Bottom - ((r.Bottom - r.Top) / 2) - (JMax - min) * ys);
            diff := Round(Abs(center.Y - pos));
            DrawGridCircle(Canvas, YG, center, diff, true);
          end;
        end;

        dominv := true;{JMin <= max;}
        if dominv and domin then
        begin
          while (JMin <> JMax) and (JMax > JMin) do
          begin
            if (Jmin <> JMax) then
            begin
              if (YG.MinorLineColor <> clNone) and (YG.MinorLineStyle <> psClear) and (YG.MinorLineWidth <> 0) then
              begin
                pos := Round(R.Bottom - ((r.Bottom - r.Top) / 2) - (JMin - min) * ys);
                diff := Round(Abs(center.Y - pos));
                DrawGridCircle(Canvas, YG, center, diff, false);
              end;
            end;

            JMin := JMin + mi;
            if CompareValue(Jmin, Jmax) = 0 then
            begin
              JMin := JMin + mi;
            end;
          end;
        end;

        if dolast then
          break;

        if not domin then
        begin
          JMin := JMin + mu;
        end
        else
        begin
          if CompareValue(Jmin, Jmax) = 0 then
          begin
            JMin := JMin + mi;
          end;
        end;

        JMax := JMax + mu;

        if JMax > max then
        begin
          dolast := true;
        end;
      end;
    end;
    if {(ChartType <> ctSpider) and (ChartType <> ctHalfSpider) and }Pie.ShowGridPieLines then
    begin
      totalpie := GetTotalPoints;   // = 360 °
      startangle := 0;
      sweepangle := 0;

      cAngle := 0;
      case ChartType of
        ctSpider, ctDonut, ctPie, ctFunnel, ctSizedPie, ctSizedDonut, ctVarRadiusPie, ctVarRadiusDonut: cAngle := 360;
        ctHalfSpider, ctHalfPie, ctHalfDonut, ctSizedHalfPie, ctSizedHalfDonut,
          ctVarRadiusHalfPie, ctVarRadiusHalfDonut: cAngle := 180;
      end;

      cntspid := 0;
      if (ChartType = ctSpider) or (ChartType = ctHalfSpider) or (ChartType = ctSizedPie) or (chartType = ctSizedHalfPie) or (chartType = ctSizedDonut) or (Charttype = ctSizedHalfDonut) then
        for rad := 0 to GetPointsCount - 1 do
          if (GetPoint(rad).Defined) and (GetPoint(rad).SingleValue > 0) then
            inc(cntspid);


      for rad := 0 to GetPointsCount - 1 do
      begin
        if (GetPoint(rad).Defined) and (GetPoint(rad).SingleValue > 0) then
        begin
          startangle := startangle + sweepangle;
          if totalpie > 0 then
            sweepangle := (cAngle * GetPoint(rad).SingleValue) / totalpie
          else
            sweepangle := 0;

          if (ChartType = ctSpider) or (ChartType = ctHalfSpider) or (ChartType = ctSizedPie) or (chartType = ctSizedHalfPie) or (chartType = ctSizedDonut) or (Charttype = ctSizedHalfDonut) then
            sweepangle := cAngle / cntspid;

          c := Point(center.X, center.Y);
          pos := R.Bottom - ((R.Bottom - R.Top) / 2) - (JMax - min) * ys;
          diff := Round(Abs(center.Y - pos));
          X := Round(c.X + diff * COS(DegToRad(Pie.StartOffsetAngle + StartAngle)));
          Y := Round(c.y - diff * SIN(DegToRad(Pie.StartOffsetAngle + StartAngle)));


          if Pie.ShowGridPieLines then
            DrawGridPieLine(Canvas, YG, c, x, Y);

          DrawGridPieLineValue(Canvas, YG, rad, startangle, sweepangle, c, x, Y);

          if ((ChartType = ctSizedHalfPie) or (ChartType = ctSizedHalfDonut) or (ChartType = ctHalfPie) or (ChartType = ctHalfDonut) or (ChartType = ctHalfSpider) or
            (ChartType = ctVarRadiusHalfPie) or (ChartType = ctVarRadiusHalfDonut)) and
            (rad = GetPointsCount - 1) then
          begin
            X := Round(c.X + diff * COS(DegToRad(Pie.StartOffsetAngle + StartAngle  + SweepAngle)));
            Y := Round(c.y - diff * SIN(DegToRad(Pie.StartOffsetAngle + StartAngle + SweepAngle)));

            if Pie.ShowGridPieLines then
              DrawGridPieLine(Canvas, YG, c, x, Y);

            DrawGridPieLineValue(Canvas, YG, rad, startangle, sweepangle, c, x, Y);
          end;
        end;
      end;
    end;
  end;
end;

procedure TChartSerie.DrawGridPieLine(Canvas: TCanvas; YG: TChartYGrid;
  Center: TPoint; x, y: integer);
begin
  Canvas.Pen.Style := YG.MajorLineStyle;
  Canvas.Pen.Color := YG.MajorLineColor;
  Canvas.Pen.Width := YG.MajorLineWidth;
  Canvas.MoveTo(Center.X, Center.Y);
  Canvas.LineTo(X, Y);
end;

procedure TChartSerie.DrawGridPieLineValue(Canvas: TCanvas; YG: TChartYGrid;
   LineIndex: Integer; AStartAngle, ASweepAngle: Double; Center: TPoint; x, y: integer);
var
  str: String;
  tw, th: Integer;
  c: TPoint;
begin
  str := '';
  if Assigned(Chart.OnGetGridPieLineValue) then
    Chart.OnGetGridPieLineValue(Self, Self, LineIndex, AStartAngle, ASweepAngle, str);

  if str <> '' then
  begin
    tw := Canvas.TextWidth(str);
    th := Canvas.TextHeight(str);
    c := Point(x, y);
    case GetQuadrant(PointF(center.X, center.Y), PointF(c.X, c.Y)) of
      pq1: c := Point(c.X + 5, c.Y - th);
      pq2: c := Point(c.X - tw - 5, c.Y - th);
      pq3: c := Point(c.x - tw - 5, c.Y);
      pq4: c := Point(c.X + 5, c.Y);
    end;

    Canvas.TextOut(c.X, c.Y, str);
  end;

  if Assigned(Chart.OnDrawGridPieLineValue) then
    Chart.OnDrawGridPieLineValue(Self, Self, Canvas, LineIndex, AStartAngle, ASweepAngle, Center, x, y);
end;

procedure TChartSerie.DrawGanttBar(Canvas: TCanvas; pt: TChartPoint; dr: TRect;
  ScaleX, ScaleY: Double);
begin

  DrawGanttBarRect(Canvas, pt, dr);

  if pt.LegendValue <> '' then
  begin
    Canvas.Brush.Style := bsClear;
    Canvas.Font.Assign(ValueFont);
    if pt.TextColor <> clNone then
      Canvas.Font.Color := pt.TextColor;

    InflateRect(dr, -2, -2);
    DrawText(Canvas.Handle, PChar(pt.LegendValue), Length(pt.LegendValue), dr, DT_SINGLELINE or DT_CENTER or DT_VCENTER or DT_END_ELLIPSIS);
  end;
end;

procedure TChartSerie.DrawGanttBarRect(Canvas: TCanvas; pt: TChartPoint;
  dr: TRect);
begin
  if (pt.Color <> clNone) and (pt.ColorTo <> clNone) then
  begin
    DrawGradient(Canvas, pt.Color, pt.ColorTo, 32, dr, pt.GradientDirection, true, pt.BorderColor, 1, asRectangle,
    0, [cbLeft, cbTop, cbRight, cbBottom], False, True);
  end
  else if (pt.Color <> clNone) then
  begin
    Canvas.Pen.Style := psClear;
    Canvas.Brush.Color := pt.Color;
    Canvas.FillRect(dr);
    if (pt.BorderColor <> clNone) then
    begin
      Canvas.Brush.Style := bsClear;
      Canvas.Pen.Style := psSolid;
      Canvas.Pen.Color := pt.BorderColor;
      Canvas.Rectangle(dr);
    end;
  end;
end;

procedure TChartSerie.DrawGridCircle(Canvas: TCanvas; YG: TChartYGrid; Center: TPoint;
  diff: integer; Major: Boolean);
var
  c: TColor;
  w: integer;
  p: TPenStyle;
  x, xs, y, ys: integer;
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

  Canvas.Pen.Style := p;
  Canvas.Pen.Color := c;
  Canvas.Pen.Width := w;
  if IsHalfPie then
  begin
    x := Center.X + Round(diff * COS(DegToRad(Pie.StartOffsetAngle)));
    y := Center.Y - Round(diff * SIN(DegToRad(Pie.StartOffsetAngle)));
    xs := Center.X + Round(diff * COS(DegToRad(Pie.StartOffsetAngle + 180)));
    ys := Center.Y - Round(diff * SIN(DegToRad(Pie.StartOffsetAngle + 180)));
    Canvas.Arc(center.X - diff, center.Y - diff, Center.X + diff, center.Y + diff, x, y, xs, ys)
  end
  else
    Canvas.Ellipse(center.X - diff, center.Y - diff, Center.X + diff, center.Y + diff)
end;

procedure TChartSerie.DrawGridValue(Canvas: TCanvas; Y: TChartSerieYAxis;
  Center: TPoint; Value: String; Major: Boolean);
var
  spc: integer;
begin
  if Major then
    spc := Y.MajorUnitSpacing
  else
    spc := Y.MinorUnitSpacing;

  Canvas.TextOut(center.X, center.Y + spc, Value);
end;

procedure TChartSerie.DrawGridValues(Canvas: TCanvas; center: TPoint; R: TRect; Y: TChartSerieYAxis;
  mu, mi, ys, ScaleX, ScaleY: Double);
var
  max, min, JMax, JMin: Double;
  domaj, domin, domajv, dominv: Boolean;
  JMaxStr, JMinStr: String;
  dolast: Boolean;
  xv, yv: integer;
  diff: Double;
begin
  dolast := false;
  if Y.Visible then
  begin
    min := 0;
    max := MaximumValue;
    JMax := min;
    JMin := min;

    domaj := (mu > 0);
    domin := (mi > 0);

    Canvas.Brush.Style := bsClear;

    if (domaj) then
    begin
      while (JMin <= max) or dolast do
      begin
        domajv := true;{JMax <= max;}
        if domajv then
        begin
          Canvas.Font.Assign(y.FMajorFont);

          if FValueFormat <> '' then
          begin
            case ValueFormatType of
              vftNormal: JMaxStr := Format(FValueFormat,[JMax]);
              vftFloat: JMaxStr := FormatFloat(FValueFormat,JMax);
            end;
          end
          else
            JMaxStr := FloatToStr(JMax);

          if Assigned(OnYAxisGetValue) then
            OnYAxisGetValue(Self,Self, JMax, JMaxStr);

          if y.MajorUnitVisible then
          begin
            diff := (Jmax - min) * ys;
            xv := center.X + Round(diff* Cos((Pie.StartOffsetAngle) * PI / 180));
            yv := center.Y - Round(diff * Sin((Pie.StartOffsetAngle) * PI / 180));
            DrawGridValue(Canvas, Y, Point(xv, yv), JMaxStr, true);
          end;
        end;

        dominv := true;{JMin <= max;}
        if dominv and domin then
        begin
          while (JMin <> JMax) and (JMax > JMin) do
          begin
            Canvas.Font.Assign(y.FMinorFont);
            if (Jmin <> JMax) then
            begin
              if FValueFormat <> '' then
              begin
                case ValueFormatType of
                  vftNormal: JMaxStr := Format(FValueFormat,[JMin]);
                  vftFloat: JMaxStr := FormatFloat(FValueFormat,JMin);
                end;
              end
              else
                JMinStr := floattostr(JMin);

              if Assigned(OnYAxisGetValue) then
                OnYAxisGetValue(Self, Self, JMin, JMinStr);

              if y.MinorUnitVisible then
              begin
                diff := (JMin - min) * ys;
                xv := center.X + Round(diff* Cos((Pie.StartOffsetAngle) * PI / 180));
                yv := center.Y - Round(diff * Sin((Pie.StartOffsetAngle) * PI / 180));
                DrawGridValue(Canvas, Y, Point(xv, yv), JMinStr, false);
              end;
            end;

            JMin := JMin + mi;
            if CompareValue(Jmin, Jmax) = 0 then
            begin
              JMin := JMin + mi;
            end;
          end;
        end;

        if dolast then
          break;

        if not domin then
        begin
          JMin := JMin + mu;
        end
        else
        begin
          if CompareValue(Jmin, Jmax) = 0 then
          begin
            JMin := JMin + mi;
          end;
        end;

        JMax := JMax + mu;

        if JMax > max then
        begin
          dolast := true;
        end;

      end;
    end;
  end;
end;

procedure TChartSerie.Draw(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double);
var
  obm: integer;
  ncv: Double;
  nov: Double;
  HRGN: THandle;
  bargroupspc, bargroupwidth, start, barspace: Double;
  p, bw, o, c, yval: integer;
  vm: Double;
  I, J, IBarCount, sb, sbperc: Integer;
  dp1,dp2,dpprev: TPoint;
  s: TChartSerie;
  dr: TRect;
  dppareto: TPointArray;
  XPos, valueX, valueY, valuexStart, valueyStart: integer;
  cw,pw: integer;
  candlel: integer;
  candlem: integer;
  candleh: integer;
  z, cntstperc, cntst, pci: integer;
  dp, dpline: TPointArray;
  pnt: TPoint;
  hsdp: integer;
  rf: integer;
  spc, spcto: TColor;
  AreaRgn: THandle;
  center: TPoint;
  pbr: TRect;
  pszinner, radius, radiusinner, rad, psz, centerh, centerv: integer;
  totalpie: double;
  startangle, sweepangle: Double;
  piecolor, fclr: Tcolor;
  lnt, rd: integer;
  ptcenter: TPoint;
  fptCenter: TPoint;
  fHSV: THSVTriplet;
  fRGB: TRGBTriplet;
  cAngle, borderw, cntspid: integer;
  SpiderEX, SpiderEY, SpiderX, SpiderY: Double;
  arr3D: TPointArray;
  dpc: integer;
  dm: Boolean;
  dpDigital: TDigitalLinePointArray;
  digitalx: Integer;
  chartpt, chartpt2: TChartPoint;
  spcBox, spcBoxTo: TColor;
  Boxr: TRect;
  pt: TChartPoint;
  gantth: integer;
  dppoly: TPointArray;
  cntdef: Integer;
  fpts: TPointArray;
  frh: Double;
  totpnt, totmx: Double;
  frwc, frhc, frhcn: Double;
  frwtot, frhtot: Double;
  fval, fvaltot: Double;
  cntf: Integer;
  fnr: TRect;
  fncnt: Integer;
  fc: Double;
  fAngle, fAngleVal: Double;
  fnpos: Integer;
  fnside, fnsiden: Integer;
  dpr, dpr1: TPoint;
  serier: TRect;
begin
  if FIsDrawing or (SerieType = stZoomControl) or not Visible then
    Exit;

  dm := Chart.Series.IsHorizontal;

  FIsDrawing := true;
  rf := Chart.Range.RangeFrom;
  obm := SetBkMode(Canvas.Handle, TRANSPARENT);
  InitializeLineColor(Canvas, ScaleX, ScaleY);
  InitializeBrushColor(Canvas);
  SetLength(FStackedRectsBar, 0);
  SetLength(dppareto, 0);

  borderw := 0;
  if BorderColor <> clNone then
    borderw := BorderWidth;

  if not IsPieChart then
    lnt := Length(FDrawPoints)
  else
    lnt := 1;

  if lnt > 0 then
  begin
    SetBkMode(Canvas.Handle, obm);
    case FChartType of
      ctNone:; //do nothing
      cthalfdonut, ctHalfPie, ctPie, ctFunnel, ctDonut, ctSpider, ctHalfSpider,
      ctSizedPie, ctSizedHalfPie, ctSizedDonut, ctSizedHalfDonut, ctVarRadiusPie, ctVarRadiusHalfPie,
      ctVarRadiusDonut, ctVarRadiusHalfDonut:
      begin
        totalpie := GetTotalPoints;   // = 360 °
        InitializeBorderColor(Canvas, ScaleX, ScaleY);
        psz := (Pie.GetPieSize div 2) * Round(ScaleX);
        pszinner := (Pie.GetPieInnerSize div 2) * Round(ScaleX);
        pbr := GetPieRectangle(Index, R);
        ptcenter := GetPieCenter(pbr);
        centerh := ptCenter.X;
        centerv := ptCenter.Y;
        center := Point(centerh, centerv);
        radius := psz;
        radiusinner := pszinner;

        startangle := 0;
        sweepangle := 0;

        cAngle := 0;
        case ChartType of
          ctSpider, ctDonut, ctPie, ctFunnel, ctSizedPie, ctSizedDonut, ctVarRadiusPie, ctVarRadiusDonut: cAngle := 360;
          ctHalfSpider, ctHalfPie, ctHalfDonut, ctSizedHalfPie, ctSizedHalfDonut,
            ctVarRadiusHalfPie, ctVarRadiusHalfDonut: cAngle := 180;
        end;

        cntspid := 0;
        if (ChartType = ctSpider) or (chartType = ctHalfSpider) or
          (ChartType = ctSizedPie) or (chartType = ctSizedHalfPie) or (chartType = ctSizedDonut) or (Charttype = ctSizedHalfDonut) then
          for rad := 0 to GetPointsCount - 1 do
            if (GetPoint(rad).Defined) and ((GetPoint(rad).SingleValue > 0) or ((ChartType = ctSpider) or (ChartType = ctHalfSpider))) then
              inc(cntspid);

        cntf := 0;
        if ChartType = ctFunnel then
          for rad := 0 to GetPointsCount - 1 do
            if (GetPoint(rad).Defined) and (GetPoint(rad).SingleValue > 0) then
              inc(cntf);

        //DRAWSLICES
        SetLength(FSpiderV, 0);
        if ChartType <> ctFunnel then
        begin
          for rad := 0 to GetPointsCount - 1 do
          begin
            if (GetPoint(rad).Defined) and (GetPoint(rad).SingleValue > 0) then
            begin
              piecolor := GetPoint(rad).color;

              if piecolor <> clNone then
                Canvas.Brush.Color := pieColor
              else if Color <> clNone then
              begin
                fRGB.B := (Color and $0000FF);
                fRGB.G := (Color and $00FF00) shr 8;
                fRGB.R := (Color and $FF0000) shr 16;
                RGBToHSV(fRGB.B, fRGB.G, fRGB.R, fHSV.H, fHSV.S, fHSV.V);
                fHSV.V := ((rad + 1) / GetPointsCount) * fHSV.V;
                HSVToRGB(fHSV.H, fHSV.S, fHSV.V, fRGB.R, fRGB.G, fRGB.B);
                Canvas.Brush.Color := RGB(Round(FRGB.R), Round(FRGB.G), Round(FRGB.B));
              end
              else
                Canvas.Brush.Style := bsClear;

              startangle := startangle + sweepangle;
              if totalpie > 0 then
                sweepangle := (cAngle * GetPoint(rad).SingleValue) / totalpie
              else
                sweepangle := 0;

              if (ChartType = ctSpider) or (chartType = ctHalfSpider) or
                (ChartType = ctSizedPie) or (chartType = ctSizedHalfPie) or (chartType = ctSizedDonut) or (Charttype = ctSizedHalfDonut) then
              begin
                sweepangle := cAngle / Max(1, cntspid);
                radius := Round((psz / Max(1, Self.SerieMax)) * GetPoint(rad).SingleValue);
              end
              else if (ChartType = ctVarRadiusPie) or (chartType = ctVarRadiusHalfPie) or (chartType = ctVarRadiusDonut) or (Charttype = ctVarRadiusHalfDonut) then
              begin
                radius := Round((psz / Max(1, Self.SerieMax)) * GetPoint(rad).SecondValue);
              end;

              if (ChartType <> ctSpider) and (ChartType <> ctHalfSpider) then
                DrawPieSlice(Canvas, center, radius , radiusinner, centerh, centerv, GetPoint(rad).PixelValue1, StartAngle, SweepAngle, rad, Scalex, ScaleY)
              else
              begin
                SetLength(FSpiderV, Length(FSpiderV) + 1);
                SpiderEX := GetPoint(rad).PixelValue1 * Cos((Pie.StartOffsetAngle -StartAngle + -SweepAngle / 2) * PI / 180);
                SpiderEY := GetPoint(rad).PixelValue1 * Sin((Pie.StartOffsetAngle -StartAngle + -SweepAngle / 2) * PI / 180);
                SpiderX := (center.X + SpiderEX) + (Radius * COS(DegToRad(Pie.StartOffsetAngle + StartAngle + (SweepAngle / 2))));
                SpiderY := (center.Y + SpiderEY) - (Radius * SIN(DegToRad(Pie.StartOffsetAngle + StartAngle + (SweepAngle / 2))));
                FSpiderV[Length(FSpiderV) - 1] := Point(Round(SpiderX), Round(SpiderY));
                if rad = GetPointsCount - 1 then
                begin
                  //close polygon
                  SetLength(FSpiderV, Length(FSpiderV) + 1);
                  FSpiderV[Length(FSpiderV) - 1] := FSpiderV[0];
                end;
              end;
            end
          end;

        //draw Spider poly
        if ((ChartType = ctSpider) or (ChartType = ctHalfSpider)) and (Length(FSpiderV) > 0) then
        begin
          DrawSpiderArea(Canvas, Bounds(center.X - psz, center.Y - psz, psz * 2, psz * 2), FSpiderV, ScaleX, ScaleY);
        end;

        //Draw markers
        DrawMarkers(Canvas, pbr, ScaleX, scaleY);

        //DRAW VALUES
        startangle := 0;
        sweepangle := 0;
        Canvas.Brush.Style := bsClear;
        Canvas.Font.Assign(Pie.ValueFont);

        for rad := 0 to GetPointsCount - 1 do
        begin
          if GetPoint(rad).Defined then
          begin
            startangle := startangle + sweepangle;
            if totalpie > 0 then
              sweepangle := (cAngle * GetPoint(rad).SingleValue) / totalpie
            else
              sweepangle := 0;

            if (ChartType = ctSpider) or (chartType = ctHalfSpider) or
              (ChartType = ctSizedPie) or (chartType = ctSizedHalfPie) or (chartType = ctSizedDonut) or (Charttype = ctSizedHalfDonut) then
            begin
              sweepangle := cAngle / Max(1, cntspid);
              radius := Round((psz / Max(1, Self.SerieMax)) * GetPoint(rad).SingleValue);
            end
            else if (ChartType = ctVarRadiusPie) or (chartType = ctVarRadiusHalfPie) or (chartType = ctVarRadiusDonut) or (Charttype = ctVarRadiusHalfDonut) then
            begin
              radius := Round((psz / Max(1, Self.SerieMax)) * GetPoint(rad).SecondValue);
            end;

            if Pie.ShowValues then
            begin
              rd := Radius;
              if pie.ValuePosition = vpInsideSlice then
              begin
                if (chartType = ctSizedDonut) or (Charttype = ctSizedHalfDonut) or
                  (chartType = ctVarRadiusDonut) or (Charttype = ctVarRadiusHalfDonut) or
                    (chartType = ctDonut) or (ChartType = ctHalfDonut) then
                      rd := radius + pszinner;
              end;

              DrawPieValues(Canvas,GetPoint(rad).PixelValue1,center, rd, StartAngle, SweepAngle, rad, Scalex, ScaleY);
            end;
          end;
        end;
        end
        else
        begin
          fvaltot := 0;
          Canvas.Font.Assign(Pie.ValueFont);
          fncnt := GetPointsCount;
          if fncnt > 0 then
          begin
            fnr := GetFunnelRect(pbr);

            if Enable3D then
            begin
              fnr.Top := fnr.Top + (Offset3D div 2);
              fnr.Bottom := fnr.Bottom - (Offset3D div 2);
            end;

            fc := Sqrt(Power((fnr.Bottom - fnr.Top), 2) + Power((fnr.Right - fnr.Left) / 2, 2));
            fAngleVal := ((fnr.Right - fnr.Left) / 2) / fc;
            fAngle := DegToRad((180 - RadToDeg(ArcCos(fAngleVal)) * 2) / 2);

            frh := ((fnr.Bottom - fnr.Top) - (FunnelSpacing * (fncnt - 1))) / fncnt;

            totpnt := GetTotalPoints;
            totmx := GetMaxPoints;
            frhtot := (((fnr.Bottom - fnr.Top) - (FunnelSpacing * (fncnt - 1))) / totpnt) ;
            frwtot := ((fnr.Right - fnr.Left) / totmx) ;

            fptCenter.X := fnr.Left + ((fnr.Right - fnr.Left) div 2);
            fptCenter.Y := fnr.Top + ((fnr.Bottom - fnr.Top) div 2);

            fnpos := fnr.Bottom;

            for rad := 0 to fncnt - 1 do
            begin
              fclr := GetPoint(rad).color;
              if fclr <> clNone then
                Canvas.Brush.Color := fclr
              else if Color <> clNone then
              begin
                fRGB.B := (Color and $0000FF);
                fRGB.G := (Color and $00FF00) shr 8;
                fRGB.R := (Color and $FF0000) shr 16;
                RGBToHSV(fRGB.B, fRGB.G, fRGB.R, fHSV.H, fHSV.S, fHSV.V);
                fHSV.V := ((rad + 1) / GetPointsCount) * fHSV.V;
                HSVToRGB(fHSV.H, fHSV.S, fHSV.V, fRGB.R, fRGB.G, fRGB.B);
                Canvas.Brush.Color := RGB(Round(FRGB.R), Round(FRGB.G), Round(FRGB.B));
              end
              else
                Canvas.Brush.Style := bsClear;

              SetLength(fpts, 4);

              fval := GetPoint(rad).SingleValue;
              case FunnelMode of
                fmHeight:
                begin
                  frhc := frhtot * (fval + fvaltot);
                  frhc := frhc + (FunnelSpacing * rad);
                  if rad = 0 then
                    frhcn := frhtot * fval
                  else
                    frhcn := frhtot * fvaltot;

                  frhcn := frhcn + (FunnelSpacing * rad);
                  fnside := Round(Tan(fAngle) * frhc);
                  fnsiden := Round(Tan(fAngle) * frhcn);

                  if rad > 0 then
                  begin
                    fpts[0] := Point(fptCenter.X - fnside, Round(fnpos - (frhtot * fval)) - FunnelSpacing);
                    fpts[1] := Point(fptCenter.X + fnside, Round(fnpos - (frhtot * fval)) - FunnelSpacing);
                    fpts[2] := Point(fptCenter.X + fnsiden, fnpos - FunnelSpacing);
                    fpts[3] := Point(fptCenter.X - fnsiden, fnpos - FunnelSpacing);
                  end
                  else
                  begin
                    fpts[0] := Point(fptCenter.X - fnside, Round(fnpos - (frhtot * fval)));
                    fpts[1] := Point(fptCenter.X + fnside, Round(fnpos - (frhtot * fval)));
                    fpts[2] := Point(fptCenter.X + fnsiden, fnpos);
                    fpts[3] := Point(fptCenter.X - fnsiden, fnpos);
                  end;

                  fnpos := Round(fnr.Bottom - frhc);
                  fvaltot := fvaltot + fval;
                end;
                fmWidth:
                begin
                  frwc := (frwtot * fval) / 2;
                  fpts[0] := Point(Round(fptCenter.X - frwc), Round(fnpos - frh));
                  fpts[1] := Point(Round(fptCenter.X + frwc), Round(fnpos - frh));
                  fpts[2] := Point(Round(fptCenter.X + frwc), Round(fnpos));
                  fpts[3] := Point(Round(fptCenter.X - frwc), Round(fnpos));
                  fnpos := Round(fnpos - frh - FunnelSpacing);
                end;
              end;

              DrawFunnelPart(Canvas, fpts, rad, ScaleX, ScaleY);
              SetLength(FDrawValuesFunnel, rad + 1);
              FDrawValuesFunnel[rad].X0 := fpts[0].X;
              FDrawValuesFunnel[rad].Y0 := fpts[0].Y;
              FDrawValuesFunnel[rad].X1 := fpts[1].X;
              FDrawValuesFunnel[rad].Y1 := fpts[1].Y;
              FDrawValuesFunnel[rad].X2 := fpts[2].X;
              FDrawValuesFunnel[rad].Y2 := fpts[2].Y;
              FDrawValuesFunnel[rad].X3 := fpts[3].X;
              FDrawValuesFunnel[rad].Y3 := fpts[3].Y;
            end;
          end;
        end;
      end;
      ctDigitalLine, ctXYDigitalLine:
      begin
        digitalx := Round(Chart.GetXScaleStart);
        SetLength(dpDigital, 0);
        for I := 0 to Length(FDrawPoints) - 1 do
        begin
          if (I = 0) then
          begin
            SetLength(dpDigital, Length(dpDigital) + 1);
            dpDigital[Length(dpDigital) - 1].pt := Point(FDrawPoints[I].X - digitalx, ValueToY(ZeroReferencePoint, Chart.Series.SeriesRectangle));
            dpDigital[Length(dpDigital) - 1].Idx := I;
            SetLength(dpDigital, Length(dpDigital) + 1);
            dpDigital[Length(dpDigital) - 1].pt := Point(FDrawPoints[i].X - digitalx, FDrawPoints[i].Y);
            dpDigital[Length(dpDigital) - 1].Idx := I;
            SetLength(dpDigital, Length(dpDigital) + 1);
            dpDigital[Length(dpDigital) - 1].pt := Point(FDrawPoints[i].X + digitalx, FDrawPoints[i].Y);
            dpDigital[Length(dpDigital) - 1].Idx := I;
          end
          else if (I = Length(DrawPoints) - 1) then
          begin
            SetLength(dpDigital, Length(dpDigital) + 1);
            dpDigital[Length(dpDigital) - 1].pt:= Point(FDrawPoints[i - 1].X + digitalx, FDrawPoints[i].Y);
            dpDigital[Length(dpDigital) - 1].Idx := I;

            if ChartType = ctXYDigitalLine then
              digitalx := (DrawPoints[i].X - DrawPoints[I - 1].X) div 2;

            SetLength(dpDigital, Length(dpDigital) + 1);
            dpDigital[Length(dpDigital) - 1].pt := Point(FDrawPoints[i].X + digitalx, FDrawPoints[i].Y);
            dpDigital[Length(dpDigital) - 1].Idx := I;
            SetLength(dpDigital, Length(dpDigital) + 1);
            dpDigital[Length(dpDigital) - 1].pt := Point(FDrawPoints[i].X + digitalx, ValueToY(ZeroReferencePoint, Chart.Series.SeriesRectangle));
            dpDigital[Length(dpDigital) - 1].Idx := I;
          end
          else
          begin
            SetLength(dpDigital, Length(dpDigital) + 1);
            dpDigital[Length(dpDigital) - 1].pt := Point(FDrawPoints[i - 1].X + digitalx, FDrawPoints[i].Y);
            dpDigital[Length(dpDigital) - 1].Idx := I;

            if ChartType = ctXYDigitalLine then
              digitalx := (DrawPoints[i + 1].X - DrawPoints[I].X) div 2;

            SetLength(dpDigital, Length(dpDigital) + 1);
            dpDigital[Length(dpDigital) - 1].pt := Point(FDrawPoints[i].X + digitalx, FDrawPoints[i].Y);
            dpDigital[Length(dpDigital) - 1].Idx := I;
          end;
        end;

        if IsEnabled3D then
        begin
          SetLength(arr3D, 4);
          InitializeBrushColor(Canvas);
          if dm then
          begin
            for I := 0 to Length(dpDigital) - 2 do
            begin
              chartpt := GetChartPointFromDrawPoint(dpDigital[I].Idx);
              chartpt2 := GetChartPointFromDrawPoint(dpDigital[I + 1].Idx);
              if chartpt.Defined and chartpt2.Defined then
              begin
                arr3D[0] := Point(dpDigital[I].pt.X, dpDigital[I].pt.Y);
                arr3D[1] := Point(dpDigital[I].pt.X + Offset3D, dpDigital[I].pt.Y + Offset3D);
                arr3D[2] := Point(dpDigital[I + 1].pt.X + Offset3D, dpDigital[I + 1].pt.Y + Offset3D);
                arr3D[3] := Point(dpDigital[I + 1].pt.X, dpDigital[I + 1].pt.Y);
                Canvas.Polygon(arr3D);
                InitializeLineColor(Canvas, Scalex, ScaleY);
                Canvas.Polyline(arr3D);
              end;
            end;
          end
          else
          begin
            for I := 0 to Length(dpDigital) - 2 do
            begin
              chartpt := GetChartPointFromDrawPoint(dpDigital[I].Idx);
              chartpt2 := GetChartPointFromDrawPoint(dpDigital[I + 1].Idx);
              if chartpt.Defined and chartpt2.Defined then
              begin
                arr3D[0] := Point(dpDigital[I].pt.X, dpDigital[I].pt.Y);
                arr3D[1] := Point(dpDigital[I].pt.X + Offset3D, dpDigital[I].pt.Y - Offset3D);
                arr3D[2] := Point(dpDigital[I + 1].pt.X + Offset3D, dpDigital[I + 1].pt.Y - Offset3D);
                arr3D[3] := Point(dpDigital[I + 1].pt.X, dpDigital[I + 1].pt.Y);
                Canvas.Polygon(arr3D);
                InitializeLineColor(Canvas, Scalex, ScaleY);
                Canvas.Polyline(arr3D);
              end;
            end;
          end;
        end;

        for I := 0 to Length(dpDigital) - 2 do
        begin
          chartpt := GetChartPointFromDrawPoint(dpDigital[I].Idx);
          chartpt2 := GetChartPointFromDrawPoint(dpDigital[I + 1].Idx);
          if chartpt.Defined and chartpt2.Defined then
          begin
            Canvas.MoveTo(dpDigital[I].pt.X, dpDigital[I].pt.Y);
            Canvas.LineTo(dpDigital[I].pt.X, dpDigital[I + 1].pt.Y);
            Canvas.MoveTo(dpDigital[I].pt.X, dpDigital[I + 1].pt.Y);
            Canvas.LineTo(dpDigital[I + 1].pt.X, dpDigital[I + 1].pt.Y);
          end;
        end;

        //Canvas.Polyline(dpDigital);
        FDrawValuesDP := FdrawPoints;
      end;
      ctGantt:
      begin
        gantth := GetPreviousGanttGroupHeight;
        for I := 0 to Length(FDrawPoints) - 1 do
        begin
          if (i >= 0) and (i <= GetPointsCount - 1) then
          begin
            pt := GetPoint(i);
            if pt.Defined then
              DrawGanttBar(Canvas, pt, Bounds(FDrawPoints[i].Y, r.Bottom - gantth - GanttSpacing - GanttHeight,  FDrawPoints[I].X - FDrawPoints[I].Y, GanttHeight), ScaleX, ScaleY);
          end;
        end;
        FDrawValuesDP := FdrawPoints;
      end;
      ctLine, ctXYLine:
      begin
        if IsEnabled3D then
        begin
          SetLength(arr3D, 4);
          InitializeBrushColor(Canvas);
          if dm then
          begin
            for I := 0 to Length(FDrawPoints) - 2 do
            begin
              arr3D[0] := Point(FDrawPoints[I].X, FDrawPoints[I].Y);
              arr3D[1] := Point(FDrawPoints[I].X + Offset3D, FDrawPoints[I].Y + Offset3D);
              arr3D[2] := Point(FDrawPoints[I + 1].X + Offset3D, FDrawPoints[I + 1].Y + Offset3D);
              arr3D[3] := Point(FDrawPoints[I + 1].X, FDrawPoints[I + 1].Y);
              Canvas.Polygon(arr3D);
              InitializeLineColor(Canvas, Scalex, ScaleY);
              Canvas.Polyline(arr3D);
            end;
          end
          else
          begin
            for I := 0 to Length(FDrawPoints) - 2 do
            begin
              arr3D[0] := Point(FDrawPoints[I].X, FDrawPoints[I].Y);
              arr3D[1] := Point(FDrawPoints[I].X + Offset3D, FDrawPoints[I].Y - Offset3D);
              arr3D[2] := Point(FDrawPoints[I + 1].X + Offset3D, FDrawPoints[I + 1].Y - Offset3D);
              arr3D[3] := Point(FDrawPoints[I + 1].X, FDrawPoints[I + 1].Y);
              Canvas.Polygon(arr3D);
              InitializeLineColor(Canvas, Scalex, ScaleY);
              Canvas.Polyline(arr3D);
            end;
          end;
        end;

        serier := Chart.Series.SeriesRectangle;
        for I := 0 to Length(FDrawPoints) - 2 do
        begin
          chartpt := GetChartPointFromDrawPoint(I);
          chartpt2 := GetChartPointFromDrawPoint(I + 1);
          if ((chartpt.Defined and chartpt2.Defined)) {or (ChartType = ctXYLine) }then
          begin
            dpr := FDrawPoints[I];
            dpr1 := FDrawPoints[I + 1];

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

            Canvas.MoveTo(dpr.X, dpr.Y);
            Canvas.LineTo(dpr1.X, dpr1.Y);
          end;
        end;

        //Canvas.Polyline(FDrawPoints);
        FDrawValuesDP := FdrawPoints;
      end;
      ctError:
      begin
        FDrawValuesDP := FdrawPoints;
        for I := 0 to Length(FDrawPoints) - 1 do
        begin
          dp1 := GetDrawPoint(I);

          if rf < 0 then
            XPos := I
          else
            XPos := I + rf;


          if dm then
          begin
            Canvas.MoveTo(dp1.X, dp1.Y);
            Canvas.LineTo(ValueToY(YToValue(dp1.X, R) + GetPoint(XPos).PixelValue1, R), dp1.Y);
            Canvas.MoveTo(dp1.X, dp1.Y);
            Canvas.LineTo(ValueToY(YToValue(dp1.X, R) - GetPoint(XPos).PixelValue2, R), dp1.Y);

            if Marker.MarkerType = mNone then
            begin
              Canvas.MoveTo(dp1.X, dp1.Y - (Round(Marker.MarkerSize * ScaleX) div 2));
              Canvas.LineTo(dp1.X, dp1.Y + (Round(Marker.MarkerSize * scaleX) div 2));
            end;
          end
          else
          begin
            Canvas.MoveTo(dp1.X, dp1.Y);
            Canvas.LineTo(dp1.X, ValueToY(YToValue(dp1.Y, R) + GetPoint(XPos).PixelValue1, R));
            Canvas.MoveTo(dp1.X, dp1.Y);
            Canvas.LineTo(dp1.X, ValueToY(YToValue(dp1.Y, R) - GetPoint(XPos).PixelValue2, R));

            if Marker.MarkerType = mNone then
            begin
              Canvas.MoveTo(dp1.X - (Round(Marker.MarkerSize * ScaleX) div 2), dp1.Y);
              Canvas.LineTo(dp1.X + (Round(Marker.MarkerSize * scaleX) div 2), dp1.Y);
            end;
          end;
        end;
      end;
      ctArrow, ctScaledArrow:
      begin
        InitializeLineColor(Canvas, ScaleX, ScaleY);
        FDrawValuesDP := FDrawPoints;
        for I := 0 to Length(FDrawPoints) - 1 do
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

          Canvas.MoveTo(dp1.X, dp1.Y);
          Canvas.LineTo(valuex, valuey);
          DrawArrow(Canvas, ArrowColor, arrowsize,Point(valuex, valuey), Point(dp1.X,dp1.Y), ScaleX, ScaleY);

        end;
      end;
      ctBubble, ctScaledBubble:
      begin
        FDrawValuesDP := FDrawPoints;
        for I := 0 to Length(FDrawPoints) - 1 do
        begin
          dp1 := GetDrawPoint(i);

          if rf < 0 then
            XPos := I
          else
            XPos := I + rf;

          case Charttype of
            ctBubble: Canvas.Ellipse(Bounds(dp1.X - Round(GetPoint(XPos).PixelValue1 * ScaleX), dp1.Y - Round(GetPoint(XPos).PixelValue2 * ScaleY), Round(GetPoint(XPos).PixelValue1 * 2 * ScaleX), Round(GetPoint(XPos).PixelValue2 * 2 * ScaleY)));
            ctScaledBubble:
            begin
              valueX := ValueToY(YToValue(dp1.X, R) + Round(GetPoint(XPos).PixelValue2 * ScaleX), R);
              valuexStart := ValueToY(YToValue(dp1.X, R) - Round(GetPoint(XPos).PixelValue2 * ScaleX), R);
              valueY := ValueToY(YToValue(dp1.Y, R) + Round(GetPoint(XPos).PixelValue1 * ScaleY), R);
              valueystart := ValueToY(YToValue(dp1.Y, R) - Round(GetPoint(XPos).PixelValue1 * ScaleY), R);
              Canvas.Ellipse(valuexstart, valueystart, valuex, valuey);
            end;
          end;
        end;
      end;
      ctBar,ctLineBar,ctStackedBar,ctStackedPercBar, ctHistogram, ctLineHistogram:
      begin
        sb := Chart.Series.GetCountChartType(ctStackedBar);
        sbperc := Chart.Series.GetCountChartType(ctStackedPercBar);
        IBarCount := Chart.Series.GetCountChartType(ctbar) + Chart.Series.GetCountChartType(ctHistogram);
        IBarCount := IBarCount + Chart.Series.GetCountChartType(ctLineBar) + Chart.Series.GetCountChartType(ctLineHistogram);

        if (ChartType = ctStackedBar) or (ChartType = ctStackedPercBar) then
          IBarCount := Chart.Series.GetCountGroupedChartType(ChartType);

        if IBarCount = 0 then
        begin
          FIsDrawing := false;
          Exit;
        end;

        z := ValueToY(FZeroReferencePoint,R);

        for I := 0 to Length(FDrawPoints) - 1 do
        begin
          dp1 := GetDrawPoint(i);
          pci := Chart.Series.GetPreviousChartIndex(ChartType, Index, GroupIndex);
          if (Index > 0) and (pci <> -1) then
          begin
            if ((ChartType in [ctStackedBar]) and (sb > 1)) or ((ChartType in [ctStackedPercBar])
              and (sbperc > 1)) and (pci <> -1) then
            begin
              s := Chart.Series.Items[pci];
              if s.Visible then
              begin
                dpprev := s.FStackedPointsBar[I];
                if dm then
                  p := dpprev.X
                else
                  p := dpprev.Y
              end
              else
                p := z;
            end
            else
            begin
              p := z;
            end;
          end
          else
          begin
            p := z;
          end;

          if dm then
            yval := dp1.X - z
          else
            yval := dp1.Y - z;

          if ZeroLine and (ZeroLineColor <> clNone) and (Index = 0) then
            p := p - ZeroLineWidth div 2;

          bw := GetBarWidth(ScaleX);
          bargroupwidth := Chart.XScale;
          bargroupspc := 0;
          case Chart.Series.BarChartSpacingType of
            wtPixels: bargroupspc := Chart.Series.BarChartSpacing;
            wtPercentage: bargroupspc := (bargroupwidth * Chart.Series.BarChartSpacing / 100);
          end;

          if dm then
            start := dp1.Y - (bargroupwidth / 2) + bargroupspc / 2
          else
            start := dp1.X - (bargroupwidth / 2) + bargroupspc / 2;

          barspace := (bargroupwidth - bargroupspc) / IBarCount;

          if dm then
          begin
            DR := Bounds(p, Round((start + barspace * Chart.Series.FcntBar) + (barspace / 2) - (bw / 2)), yval, Max(1,bw));
            SetLength(FStackedPointsBar, I + 1);
            SetLength(FPointsLineBar, I + 1);
            FStackedPointsBar[I] := Point(p + yval - (borderw div 2), Round(start + (barspace * Chart.Series.FcntBar) + (barspace / 2) - (bw / 2)));
            FPointsLineBar[I] := Point(p + yval - (borderw div 2), Round(start + (barspace * Chart.Series.FcntBar) + (barspace / 2)));
          end
          else
          begin
            DR := Bounds(Round((start + barspace * Chart.Series.FcntBar) + (barspace / 2) - (bw / 2)), p , Max(1,bw), yval);
            SetLength(FStackedPointsBar, I + 1);
            SetLength(FPointsLineBar, I + 1);
            FStackedPointsBar[I] := Point(Round(start + (barspace * Chart.Series.FcntBar) + (barspace / 2) - (bw / 2)), p + yval - (borderw div 2));
            FPointsLineBar[I] := Point(Round(start + (barspace * Chart.Series.FcntBar) + (barspace / 2)), p + yval - (borderw div 2));
          end;

          if (ChartType = ctHistogram) or (ChartType = ctLineHistogram) then
          begin
            if Chart.Range.RangeFrom < 0 then
            begin
              if (I < 0) or (I > GetPointsCount - 1) then
              begin
                FIsDrawing := false;
                Exit;
              end;
              spc := GetPoint(I).Color;
              spcto := GetPoint(I).ColorTo;
            end
            else
            begin
              if (I + Chart.Range.RangeFrom < 0) or (I + Chart.Range.RangeFrom > GetPointsCount - 1) then
              begin
                FIsDrawing := false;
                Exit;
              end;
              spc := GetPoint(I + Chart.Range.RangeFrom).Color;
              spcto := GetPoint(I + Chart.Range.RangeFrom).ColorTo;
            end;
          end
          else
          begin
            if Chart.Range.RangeFrom < 0 then
            begin
              if GetPoint(I).Color <> clNone then
              begin
                spc := GetPoint(I).Color;
                spcto := GetPoint(I).ColorTo;
              end
              else
              begin
                spc := Color;
                spcto := ColorTo;
              end;
            end
            else
            begin
              if GetPoint(I + Chart.Range.RangeFrom).Color <> clNone then
              begin
                spc := GetPoint(I + Chart.Range.RangeFrom).Color;
                spcto := GetPoint(I + Chart.Range.RangeFrom).ColorTo;
              end
              else
              begin
                spc := Color;
                spcto := ColorTo;
              end;
            end;
          end;

          if not IsEnabled3D then
          begin
            if dm then
            begin
              if (dp1.x - z <> 0) then
                DrawBar(Canvas, spc, spcto, dr, ScaleX, ScaleY, I, GetPoint(i).SingleValue)
            end
            else
            begin
              if (dp1.y - z <> 0) then
                DrawBar(Canvas, spc, spcto, dr, ScaleX, ScaleY, I, GetPoint(i).SingleValue)
            end;
          end;

          SetLength(FStackedRectsBar, Length(FStackedRectsBar) + 1);
          FStackedRectsBar[Length(FStackedRectsBar) - 1].R := dr;
          FStackedRectsBar[Length(FStackedRectsBar) - 1].SColor := spc;
          FStackedRectsBar[Length(FStackedRectsBar) - 1].SColorTo := spcto;
        end;

        FDrawValuesDP := FStackedPointsBar;

        if not (ChartType in [ctStackedBar, ctStackedPercBar]) then
        begin
          if Chart.Series.GetCountChartType(ChartType) > 1 then
            Inc(Chart.Series.FcntBar)
        end
        else
        begin
          if (Chart.Series.FcntBar < IBarCount - 1) then
          begin
            if Index + 1 <= Chart.Series.Count - 1 then
            begin
              if Chart.Series[Index + 1].GroupIndex > GroupIndex then
                Inc(Chart.Series.FcntBar);
            end;
          end;
        end;

        if (FChartType = ctLineBar) or (FChartType = ctLineHistoGram) then
        begin
          InitializeLineColor(Canvas, Scalex, ScaleY);
          Canvas.Polyline(FPointsLineBar);
        end;
      end;
      ctBand, ctArea, ctStackedArea, ctStackedPercArea:
      begin
        cntstperc := 0;
        cntst := 0;
        s := nil;

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

        z := ValueToY(FZeroReferencePoint,R);

        pci := Chart.Series.GetPreviousChartIndex(ChartType, Index, GroupIndex);
        if (Index > 0) and (pci <> -1) then
        begin
          if ((ChartType in [ctStackedArea]) and (cntst > 1)) or ((ChartType in [ctStackedPercArea]) and (cntstperc > 1)) then
          begin
            s := Chart.Series.Items[pci];
            hsdp := High(s.FDrawPoints);
            for I := 0 to High(FDrawPoints) do
            begin
              SetLength(dp, I + 1);
              SetLength(dpline, I + 1);
              if (ChartType = ctStackedPercArea) and (Index = cntstperc - 1) then //FINAL SERIE FORCE MAX VALUES
              begin
                if dm then
                begin
                  if (I = High(FDrawPoints) - 1) or (I = High(FDrawPoints)) then
                    pnt := Point(s.FStackedPointsArea[I].X + (GetDrawPoint(i).X - z), GetDrawPoint(i).y)
                  else
                    pnt := Point(ValueToY(100, R), GetDrawPoint(i).y);
                end
                else
                begin
                  if (I = High(FDrawPoints) - 1) or (I = High(FDrawPoints)) then
                    pnt := Point(GetDrawPoint(i).x, s.FStackedPointsArea[I].Y + (GetDrawPoint(i).Y - z))
                  else
                    pnt := Point(GetDrawPoint(i).X, ValueToY(100, R));
                end;
              end
              else
              begin
                if dm then
                  pnt := Point(s.FStackedPointsArea[I].X + (GetDrawPoint(i).X - z), GetDrawPoint(i).Y)
                else
                  pnt := Point(GetDrawPoint(i).X, s.FStackedPointsArea[I].Y + (GetDrawPoint(i).Y - z));
              end;

              dp[I] := pnt;
              dpline[I] := pnt;
            end;

            for I := 0 to hsdp do
            begin
              SetLength(dp, hsdp + I + 2);
              if dm then
                pnt := Point(s.FStackedPointsArea[I].X, GetDrawPoint(i).Y)
              else
                pnt := Point(GetDrawPoint(i).X, s.FStackedPointsArea[I].Y);
              dp[hsdp + I + 1] := pnt;
            end;
          end
          else
          begin
            for I := 0 to High(FDrawPoints) do
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
          for I := 0 to High(FDrawPoints) do
          begin
            SetLength(dp, I + 1);
            SetLength(dpline, I + 1);
            pnt := Point(GetDrawPoint(i).X,GetDrawPoint(i).Y);
            dp[I] := pnt;
            dpline[I] := pnt;
          end;
        end;

        SetLength(FStackedPointsArea, 0);
        for I := 0 to High(dp) do
        begin
          SetLength(FStackedPointsArea, I + 1);
          pnt := Point(dp[I].X, dp[I].Y);
          FStackedPointsArea[I] := pnt;
        end;

        if IsEnabled3D then
        begin
          if (ChartType <> ctArea) and (ChartType <> ctBand) and (pci <> -1) then
            dpc := (Length(dp) div 2) - 4
          else if (chartType <> ctBand) then
            dpc := Length(dp) - 3
          else //Band
            dpc := Length(dp) - 2;

          Draw3Dpolygons(Canvas, 0, dpc, dp, pci, s, Scalex, ScaleY)
        end;
        InitializeBrushColor(Canvas);

        SetLength(dp, Length(dp) + 1);
        dp[Length(dp) - 1] := dp[0];


        cntdef := 0;
        for I := 0 to GetPointsCount - 1 do
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
                HRGN := CreatePolygonRgn(dppoly[0], Length(dppoly), ALTERNATE);
                AreaRGN := CreateRectRgn(0, 0, 1, 1);
                CombineRgn(AreaRGN, HRGN, FClipRgn, RGN_AND);

                DeleteObject(HRGN);
                SelectClipRgn(Canvas.Handle,AreaRGN);

                if FColorTo <> clNone then
                begin
                  vm := dppoly[0].Y;
                  for P := 0 to High(dppoly)  do
                  begin
                    if vm > dppoly[P].Y  then
                      vm := dppoly[P].Y;
                  end;
                  DrawGradient(Canvas, FColor, FColorTo, FGradientSteps, R, FGradientDirection, true, BorderColor, BorderWidth, asRectangle, 0, [cbLeft, cbTop, cbRight, cbBottom], false, false);
                end
                else
                begin
                  Canvas.Pen.Style := psClear;
                  Canvas.Polygon(dppoly);
                  Canvas.Pen.Color := FLineColor;
                  Canvas.Pen.Style := FPenStyle;
                end;

                DeleteObject(AreaRGN);
                SelectClipRgn(Canvas.Handle,FClipRgn);
                SetLength(dppoly, 0);
//                SetLength(dppoly,Length(dppoly) + 1);
//                dppoly[Length(dppoly) - 1] := dp[I];
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

          SetLength(dppoly, Length(dppoly) + 1);
          dppoly[Length(dppoly) - 1] := dppoly[0];
          HRGN := CreatePolygonRgn(dppoly[0], Length(dppoly), ALTERNATE);
          AreaRGN := CreateRectRgn(0, 0, 1, 1);
          CombineRgn(AreaRGN, HRGN, FClipRgn, RGN_AND);

          DeleteObject(HRGN);
          SelectClipRgn(Canvas.Handle,AreaRGN);


          if FColorTo <> clNone then
          begin
            vm := dppoly[0].Y;
            for P := 0 to High(dppoly)  do
            begin
              if vm > dppoly[P].Y  then
                vm := dppoly[P].Y;
            end;
            DrawGradient(Canvas, FColor, FColorTo, FGradientSteps, R, FGradientDirection, true, BorderColor, BorderWidth, asRectangle, 0, [cbLeft, cbTop, cbRight, cbBottom], false, false);
          end
          else
          begin
            Canvas.Pen.Style := psClear;
            Canvas.Polygon(dppoly);
            Canvas.Pen.Color := FLineColor;
            Canvas.Pen.Style := FPenStyle;
          end;
        end
        else
        begin
          SetLength(dp, Length(dp) + 1);
          dp[Length(dp) - 1] := dp[0];
          HRGN := CreatePolygonRgn(dp[0], Length(dp), ALTERNATE);
          AreaRGN := CreateRectRgn(0, 0, 1, 1);
          CombineRgn(AreaRGN, HRGN, FClipRgn, RGN_AND);

          DeleteObject(HRGN);
          SelectClipRgn(Canvas.Handle,AreaRGN);

          if FColorTo <> clNone then
          begin
            vm := dp[0].Y;
            for P := 0 to High(dp)  do
            begin
              if vm > dp[P].Y  then
                vm := dp[P].Y;
            end;
            DrawGradient(Canvas, FColor, FColorTo, FGradientSteps, R, FGradientDirection, true, BorderColor, BorderWidth, asRectangle, 0, [cbLeft, cbTop, cbRight, cbBottom], false, false);
          end
          else
          begin
            Canvas.Pen.Style := psClear;
            Canvas.Polygon(dp);
            Canvas.Pen.Color := FLineColor;
            Canvas.Pen.Style := FPenStyle;
          end;
        end;

        DrawPicture(Canvas, R, Scalex, ScaleY);

        DeleteObject(AreaRGN);
        SelectClipRgn(Canvas.Handle,FClipRgn);

        FDrawValuesDP := StackedPointsArea;

        if (BorderWidth <> 0) and (BorderColor <> clNone) then
        begin
          InitializeBorderColor(Canvas, ScaleX, ScaleY);
          if cntdef > 0 then
          begin
            SetLength(dppoly, 0);
            for I := 0 to Length(dp) - 1 do
            begin
              if (I >= 0) and (I < Length(dp)) then
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
                  SetLength(dppoly,Length(dppoly) + 1);
                  dppoly[Length(dppoly) - 1] := dppoly[0];

                  Canvas.Polyline(dppoly);
                  SetLength(dppoly, 0);
//                  SetLength(dppoly,Length(dppoly) + 1);
//                  dppoly[Length(dppoly) - 1] := dp[I];
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

            Canvas.Polyline(dppoly);
          end
          else
          begin
            if (BorderWidth <> 0) and (BorderColor <> clNone) then
            begin
              InitializeBorderColor(Canvas, ScaleX, ScaleY);
              dp1 := dpline[Length(dpline) - 2];
              dp2 := dpline[Length(dpline) - 1];
              if (ChartType <> ctBand) and (Length(dpline) - 2 > 0) then
                SetLength(dpline, Length(dpline) - 2);

              if LinePointsOnly then
                Canvas.Polyline(dpline)
              else
                Canvas.Polyline(dp);

              if ChartType <> ctBand then
                SetLength(dpline, Length(dpline) + 2);
              dpline[Length(dpline) - 2] := dp1;
              dpline[Length(dpline) - 1] := dp2;
            end;
          end;
        end;
      end;
      ctMarkers, ctXYMarkers, ctRenko: FDrawValuesDP := FDrawPoints; //DO NOTHING, ONLY MARKERS
      ctCandleStick, ctLineCandleStick, ctBoxPlot:
      begin

        cw := FValuewidth;

        if FChartType = ctLineCandleStick then
          Canvas.Polyline(FDrawPoints);

        IBarCount := 0;

        for J := 0 to (Collection as TChartSeries).Count -1  do
          if (chart.Series.Items[J].ChartType in [ctCandleStick, ctLineCandleStick, ctBoxPlot]) then
             IBarCount := IBarCount + 1;

        dp1 := GetDrawPoint(0);
        dp2 := GetDrawPoint(1);

        if Length(DrawPoints) > 1 then
        begin
          if dm then
            pw := dp2.y - dp1.y
          else
            pw := dp2.x - dp1.x;
        end
        else
          pw := Round(Chart.XScale);

        bw := 0;
        case FValueWidthType of
          wtPixels: bw := Round(FValueWidth * ScaleX);
          wtPercentage: bw := Round((((pw) * cw  / IBarCount)) / 100);
        end;

        if (FValueWidthType = wtPercentage) then
        begin
          if odd(WickWidth) then
          begin
            if not odd(bw) then
              inc(bw);
          end
          else
          begin
            if odd(bw) then
              inc(bw);
          end;
        end;

        for I := 0 to Length(FDrawPoints) - 1  do
        begin
          if Chart.Range.RangeFrom < 0 then
            XPos := I
          else
            XPos := I + Chart.Range.RangeFrom;

          if GetPoint(XPos).CloseValue < GetPoint(XPos).OpenValue then
          begin
            nov := GetPoint(XPos).OpenValue;
            ncv := GetPoint(XPos).CloseValue;
            if FCandleColorDecrease <> clNone then
              Canvas.Brush.Color := FCandleColorDecrease
            else
              Canvas.Brush.Style := bsClear;
          end
          else
          begin
            nov := GetPoint(XPos).CloseValue;
            ncv := GetPoint(XPos).OpenValue;
            if FCandleColorIncrease <> clNone then
              Canvas.Brush.Color := FCandleColorIncrease
            else
              Canvas.Brush.Style := bsClear;
          end;

          if dm then
            candlel := Round(GetDrawPoint(I).Y - bw / 2)
          else
            candlel := Round(GetDrawPoint(I).X - bw / 2);

          candlem := candlel + (bw div 2);

          InitializeWickColor(Canvas, ScaleX, ScaleY);

          if dm then
          begin
            Canvas.MoveTo(Round(ValueToY(GetPoint(XPos).HighValue, R)), candlem);
            Canvas.LineTo(Round(ValueToY(ncv, R)), candlem);

            Canvas.MoveTo(Round(ValueToY(GetPoint(XPos).LowValue,R)), candlem);

            if FWickWidth = 1 then
              Canvas.LineTo(Round(ValueToY(nov,R) - 1), candlem)
            else
              Canvas.LineTo(Round(ValueToY(nov,R)), candlem);
          end
          else
          begin
            Canvas.MoveTo(candlem , Round(ValueToY(GetPoint(XPos).HighValue, R)));
            Canvas.LineTo(candlem, Round(ValueToY(ncv, R)));

            Canvas.MoveTo(candlem, Round(ValueToY(GetPoint(XPos).LowValue,R)));

            if FWickWidth = 1 then
              Canvas.LineTo(candlem, Round(ValueToY(nov,R) - 1))
            else
              Canvas.LineTo(candlem, Round(ValueToY(nov,R)));
          end;

          InitializeBorderColor(Canvas, ScaleX, ScaleY);

          candleh := Round(ValueToY(nov, R)) - Round(ValueToY(ncv, R));
          if candleh = 0 then
            candleh := 1;

          if dm then
            Boxr := Bounds(Round(ValueToY(ncv, R)), candlel, candleh, bw)
          else
            Boxr := Bounds(candlel, Round(ValueToY(ncv, R)), bw, candleh);

          if ChartType = ctBoxPlot then
          begin
            if GetPoint(XPos).Color <> clNone then
            begin
              spcBox := GetPoint(XPos).Color;
              spcBoxto := GetPoint(XPos).ColorTo;
            end
            else
            begin
              spcBox := Color;
              spcBoxto := ColorTo;
            end;
            DrawBar(Canvas, spcBox, spcBoxto, BoxR, ScaleX, ScaleY, 0, 0);
          end
          else
            Canvas.Rectangle(Boxr);

          if ChartType = ctBoxPlot then
          begin
            if dm then
            begin
              Canvas.MoveTo(ValueToY(GetPoint(XPos).MedValue, R), candlel);
              Canvas.LineTo(ValueToY(GetPoint(XPos).MedValue, R), candlel + bw);
            end
            else
            begin
              Canvas.MoveTo(candlel, ValueToY(GetPoint(XPos).MedValue, R));
              Canvas.LineTo(candlel + bw, ValueToY(GetPoint(XPos).MedValue, R));
            end;
          end;

          FDrawValuesDP := FDrawPoints;
        end;
      end;
      ctOHLC:
      begin

        IBarCount := 0;

        for J := 0 to Chart.Series.Count -1  do
          if (Chart.Series.Items[J].ChartType in [ctOHLC]) then
             IBarCount := IBarCount + 1;

        dp1 := GetDrawPoint(0);
        dp2 := GetDrawPoint(1);

        if dm then
        begin
          if Length(DrawPoints) > 1 then
            pw := dp2.y - dp1.y
          else
            pw := Round(Chart.XScale);
        end
        else
        begin
          if Length(DrawPoints) > 1 then
            pw := dp2.x - dp1.x
          else
            pw := Round(Chart.XScale);
        end;


        bw := 0;
        case FValueWidthType of
          wtPixels: bw := Round(FValueWidth * Scalex);
          wtPercentage: bw := Round((((pw) / IBarCount) * FValueWidth / 2) / 100);
        end;

        if bw < 1 then
          bw := 1;

        for I := 0 to Length(FDrawPoints) - 1 do
        begin
          if Chart.Range.RangeFrom < 0 then
            XPos := I
          else
            XPos := I + Chart.Range.RangeFrom;

          if (XPos < 0) or (XPos > GetPointsCount - 1) then
          begin
            FIsDrawing := false;
            Exit;
          end;

          nov := GetPoint(XPos).OpenValue;
          ncv := GetPoint(XPos).CloseValue;
          if GetPoint(XPos).CloseValue < GetPoint(XPos).OpenValue then
          begin
            if FCandleColorDecrease <> clNone then
            begin
              Canvas.Brush.Color := FCandleColorDecrease;
              Canvas.Pen.Color := FCandleColorDecrease;
            end;
          end
          else
          begin
            if FCandleColorIncrease <> clNone then
            begin
              Canvas.Brush.Color := FCandleColorIncrease;
              Canvas.Pen.Color := FCandleColorIncrease;
            end;
          end;

          InitializeBorderColor(Canvas, ScaleX, ScaleY);

          o := Round(ValueToY(nov, R));
          c := Round(ValueToY(ncv, R));
          if dm then
          begin
            Canvas.Rectangle(Bounds(Round(ValueToY(GetPoint(XPos).HighValue, R)),Round(GetDrawPoint(I).Y - (bw / 2)), Round(ValueToY(GetPoint(XPos).LowValue, R) - ValueToY(GetPoint(XPos).HighValue, R)), bw));
            Canvas.Rectangle(Bounds(o - Round(bw / 2), Round(GetDrawPoint(I).Y - bw), bw, bw + Round(bw / 2)));
            Canvas.Rectangle(Bounds(c - Round(bw / 2), Round(GetDrawPoint(I).Y - (bw / 2)), bw, bw + Round(bw / 2)));
          end
          else
          begin
            Canvas.Rectangle(Bounds(Round(GetDrawPoint(I).X - (bw / 2)), Round(ValueToY(GetPoint(XPos).HighValue, R)),bw, Round(ValueToY(GetPoint(XPos).LowValue, R) - ValueToY(GetPoint(XPos).HighValue, R))));
            Canvas.Rectangle(Bounds(Round(GetDrawPoint(I).X - bw), o - Round(bw / 2) , bw + Round(bw / 2) , bw));
            Canvas.Rectangle(Bounds(Round(GetDrawPoint(I).X - (bw / 2)),  c - Round(bw / 2) , bw + Round(bw / 2), bw));
          end;
        end;
        FDrawValuesDP := FDrawPoints;
      end;
    end;
  end;
  FIsDrawing := false;

  if Assigned(OnSerieDrawPoint) then
  begin
    for I := 0 to Length(FDrawPoints) - 1 do
    begin
      if Chart.Range.RangeFrom < 0 then
        XPos := I
      else
        XPos := I + Chart.Range.RangeFrom;
      OnSerieDrawPoint(Self, Canvas, DrawValuesDP[I], GetChartPoint(XPos));
    end;
  end;
end;

procedure TChartSerie.Draw3DBar(canvas: TCanvas; SColor, SColorto: TColor; dr: TRect; ScaleX,
  ScaleY: Double);
var
  arr3D: TPointArray;
  r: TRect;
  dm: Boolean;
begin
  dm := Chart.Series.IsHorizontal;
  if dm then
  begin
    if dr.Left > dr.Right then
      r := Rect(dr.Right, dr.Top, dr.Left, dr.Bottom)
    else
      r := Rect(dr.Left, dr.Top, dr.Right, dr.Bottom);
  end
  else
  begin
    if dr.Top > dr.Bottom then
      r := Rect(dr.Left, dr.Top, dr.Right, dr.Bottom)
    else
      r := Rect(dr.Left, dr.Bottom, dr.Right, dr.Top);
  end;

  SetLength(arr3D, 5);
  Canvas.Brush.style := FBrushStyle;
  sColor := DarkenColor(sColor, Darken3D);

  if Color <> clNone then
    Canvas.Brush.Color := sColor
  else
    Canvas.Brush.Style := bsclear;

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
  Canvas.Pen.Style := psClear;
  Canvas.Polygon(arr3D);

  InitializeBorderColor(Canvas, ScaleX, ScaleY);
  Canvas.Polyline(arr3D);

  SetLength(arr3D, 5);
  Canvas.Brush.style := FBrushStyle;

  if Color <> clNone then
    Canvas.Brush.Color := sColor
  else
    Canvas.Brush.Style := bsclear;

  if dm then
  begin
    arr3D[0] := Point(r.Left, r.Bottom);
    arr3D[1] := Point(r.Right, r.Bottom);
    arr3D[2] := Point(r.Right + Get3DOffset, r.Bottom + Get3DOffset);
    arr3D[3] := Point(r.Left + Get3DOffset, r.Bottom + Get3DOffset);
  end
  else
  begin
    arr3D[0] := Point(r.Left, r.Bottom);
    arr3D[1] := Point(r.Right, r.Bottom);
    arr3D[2] := Point(r.Right + Get3DOffset, r.Bottom - Get3DOffset);
    arr3D[3] := Point(r.Left + Get3DOffset, r.Bottom - Get3DOffset);
  end;

  arr3D[4] := arr3D[0];
  Canvas.Polygon(arr3D);
end;

procedure TChartSerie.Draw3DPolygons(ACanvas: TCanvas; dpcfrom, dpcto: integer; dp: TPointArray; pci: integer; s: TChartSerie;
  ScaleX, ScaleY: Double);
var
  i: integer;
  pntinter: TPointCheck;
  firstfound, lastfound: Boolean;
  pnt3D, arr3DFirst, arr3Dlast: TPoint;
  arr3D: TPointArray;
  svc: TColor;
  dm: Boolean;
begin
  svc := Color;
  Color := DarkenColor(Color, Darken3D);
  SetLength(arr3D, 4);
  firstfound := false;
  lastfound := false;
  //search for first point
  dm := Chart.Series.IsHorizontal;
  if dm then
  begin
    for I := dpcto downto 0 do
    begin
      if (ChartType = ctArea) then
      begin
        if (I = 0) and (dp[0].X >= ValueToY(ZeroReferencePoint, Chart.Series.SeriesRectangle)) then
        begin
          pntinter.valid := true;
          pntinter.pt := Point(ValueToY(ZeroReferencePoint, Chart.Series.SeriesRectangle), dp[0].Y);
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
        if (I = 0) and (dp[0].Y >= ValueToY(ZeroReferencePoint, Chart.Series.SeriesRectangle)) then
        begin
          pntinter.valid := true;
          pntinter.pt := Point(dp[0].X, ValueToY(ZeroReferencePoint, Chart.Series.SeriesRectangle));
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
        InitializeBrushColor(ACanvas);
        arr3D[0] := Point(dp[I].X, dp[I].Y);
        arr3D[1] := Point(dp[I].X + Get3DOffset, dp[I].Y + Get3DOffset);
        arr3D[2] := Point(dp[I + 1].X + Get3DOffset, dp[I + 1].Y + Get3DOffset);
        arr3D[3] := Point(dp[I + 1].X, dp[I + 1].Y);
        ACanvas.Polygon(arr3D);
        InitializeBorderColor(ACanvas, ScaleX, ScaleY);
        ACanvas.Polyline(arr3D);
      end;

      for I := dpcto downto dpcto div 2  do
      begin
        InitializeBrushColor(ACanvas);
        arr3D[0] := Point(dp[I].X, dp[I].Y);
        arr3D[1] := Point(dp[I].X + Get3DOffset, dp[I].Y + Get3DOffset);
        arr3D[2] := Point(dp[I + 1].X + Get3DOffset, dp[I + 1].Y + Get3DOffset);
        arr3D[3] := Point(dp[I + 1].X, dp[I + 1].Y);
        ACanvas.Polygon(arr3D);
        InitializeBorderColor(ACanvas, ScaleX, ScaleY);
        ACanvas.Polyline(arr3D);
      end;
    end
    else
    begin
      for I := dpcfrom to dpcto do
      begin
        if (ChartType = ctArea) then
        begin
          Chart.FindInterSection(dp[I + 1], dp[I],
            Point(ValueToY(ZeroReferencePoint, Chart.Series.SeriesRectangle), Chart.Series.SeriesRectangle.Bottom),
            Point(ValueToY(ZeroReferencePoint, Chart.Series.SeriesRectangle), Chart.Series.SeriesRectangle.Top), pntinter);

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

            InitializeBrushColor(ACanvas);
            ACanvas.Polygon(arr3D);
            InitializeBorderColor(ACanvas, ScaleX, ScaleY);
            ACanvas.Polyline(arr3D);
          end;
        end;
        InitializeBrushColor(ACanvas);
        arr3D[0] := Point(dp[I].X, dp[I].Y);
        arr3D[1] := Point(dp[I].X + Get3DOffset, dp[I].Y + Get3DOffset);
        arr3D[2] := Point(dp[I + 1].X + Get3DOffset, dp[I + 1].Y + Get3DOffset);
        arr3D[3] := Point(dp[I + 1].X, dp[I + 1].Y);
        ACanvas.Polygon(arr3D);
        InitializeBorderColor(ACanvas, ScaleX, ScaleY);
        ACanvas.Polyline(arr3D);
      end;
      if (chartType <> ctBand) and (ChartType <> ctArea) and (pci <> -1) then
      begin
        //draw final point linking to previous serie
        InitializeBrushColor(ACanvas);
        arr3D[0] := Point(dp[Length(dp) div 2 - 3].X, dp[Length(dp) div 2 - 3].Y);
        arr3D[1] := Point(dp[Length(dp) div 2 - 3].X + Get3DOffset, dp[Length(dp) div 2 - 3].Y + Get3DOffset);
        pnt3D := s.StackedPointsArea[Length(s.DrawPoints) - 3];
        arr3D[2] := Point(pnt3D.X + Get3DOffset, pnt3D.Y + Get3DOffset);
        arr3D[3] := Point(pnt3D.X, pnt3D.Y);
        ACanvas.Polygon(arr3D);
        InitializeBorderColor(ACanvas, ScaleX, ScaleY);
        ACanvas.Polyline(arr3D);
      end;
    end;
  end
  else
  begin
    if ChartType = ctBand then
    begin
      for I := dpcfrom to dpcto div 2  do
      begin
        InitializeBrushColor(ACanvas);
        arr3D[0] := Point(dp[I].X, dp[I].Y);
        arr3D[1] := Point(dp[I].X + Get3DOffset, dp[I].Y - Get3DOffset);
        arr3D[2] := Point(dp[I + 1].X + Get3DOffset, dp[I + 1].Y - Get3DOffset);
        arr3D[3] := Point(dp[I + 1].X, dp[I + 1].Y);
        ACanvas.Polygon(arr3D);
        InitializeBorderColor(ACanvas, ScaleX, ScaleY);
        ACanvas.Polyline(arr3D);
      end;

      for I := dpcto downto dpcto div 2 do
      begin
        InitializeBrushColor(ACanvas);
        arr3D[0] := Point(dp[I].X, dp[I].Y);
        arr3D[1] := Point(dp[I].X + Get3DOffset, dp[I].Y - Get3DOffset);
        arr3D[2] := Point(dp[I + 1].X + Get3DOffset, dp[I + 1].Y - Get3DOffset);
        arr3D[3] := Point(dp[I + 1].X, dp[I + 1].Y);
        ACanvas.Polygon(arr3D);
        InitializeBorderColor(ACanvas, ScaleX, ScaleY);
        ACanvas.Polyline(arr3D);
      end;
    end
    else
    begin
      for I := dpcfrom to dpcto do
      begin
        if (ChartType = ctArea) then
        begin
          Chart.FindInterSection(dp[I + 1], dp[I],
            Point(Chart.Series.SeriesRectangle.right, ValueToY(ZeroReferencePoint, Chart.Series.SeriesRectangle)),
            Point(Chart.Series.SeriesRectangle.Left, ValueToY(ZeroReferencePoint, Chart.Series.SeriesRectangle)), pntinter);

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

            InitializeBrushColor(ACanvas);
            ACanvas.Polygon(arr3D);
            InitializeBorderColor(ACanvas, ScaleX, ScaleY);
            ACanvas.Polyline(arr3D);
          end;
        end;
        InitializeBrushColor(ACanvas);
        arr3D[0] := Point(dp[I].X, dp[I].Y);
        arr3D[1] := Point(dp[I].X + Get3DOffset, dp[I].Y - Get3DOffset);
        arr3D[2] := Point(dp[I + 1].X + Get3DOffset, dp[I + 1].Y - Get3DOffset);
        arr3D[3] := Point(dp[I + 1].X, dp[I + 1].Y);
        ACanvas.Polygon(arr3D);
        InitializeBorderColor(ACanvas, ScaleX, ScaleY);
        ACanvas.Polyline(arr3D);
      end;
      if (chartType <> ctBand) and (ChartType <> ctArea) and (pci <> -1) then
      begin
        //draw final point linking to previous serie
        InitializeBrushColor(ACanvas);
        arr3D[0] := Point(dp[Length(dp) div 2 - 3].X, dp[Length(dp) div 2 - 3].Y);
        arr3D[1] := Point(dp[Length(dp) div 2 - 3].X + Get3DOffset, dp[Length(dp) div 2 - 3].Y - Get3DOffset);
        pnt3D := s.StackedPointsArea[Length(s.DrawPoints) - 3];
        arr3D[2] := Point(pnt3D.X + Get3DOffset, pnt3D.Y - Get3DOffset);
        arr3D[3] := Point(pnt3D.X, pnt3D.Y);
        ACanvas.Polygon(arr3D);
        InitializeBorderColor(ACanvas, ScaleX, ScaleY);
        ACanvas.Polyline(arr3D);
      end;
    end;
  end;
  Color := svc;
end;

procedure TChartSerie.DrawValues(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: double);
var
  i, ypos: integer;
  lf: TLogFontW;
  tf: TFont;
  an, bw, tv: Integer;
  str: String;
  cpt: TChartPoint;
  sx, sy: Integer;
begin
  if ShowValue then
  begin
    an := ValueAngle * 10;
    tf := nil;

    try
      tf := TFont.Create;
      tf.Assign(ValueFont);
      GetObject(tf.Handle, SizeOf(lf), @lf);
      lf.lfEscapement := an;
      lf.lfOrientation := lf.lfEscapement;
      tf.Handle := CreateFontIndirectW(lf);
      Canvas.Font.Assign(tf);
    finally
      tf.Free;
    end;

    case ChartType of
      ctStackedArea, ctStackedPercArea, ctArea:
      begin
        tv := Length(FDrawPoints) - 3;
      end
      else
        tv := Length(FDrawPoints) - 1;
    end;

    Canvas.Brush.Style := bsClear;
    for I := 0 to tv do
    begin
      bw := 0;
      with FDrawValuesDP[I] do
      begin
        sx := x + ValueOffsetX;
        sy := y + ValueOffsetY;
        if Chart.Series.IsHorizontal then
          ypos := sx
        else
          ypos := sy;

        case ChartType of
        ctBar, ctStackedBar, ctLineBar, ctStackedPercBar:
          bw := GetBarWidth(ScaleX);
        ctHistogram, ctLineHistogram:
          bw := GetHistogramBarWidth(ScaleX);
        end;

        str := GetStackedValueString(i);
        cpt := GetChartPointFromDrawPoint(i);

        if (str <> '') and cpt.defined then
        begin
          if Chart.Series.IsHorizontal then
          begin
            if (ChartType = ctBubble) or (ChartType = ctScaledBubble) then
            begin
              if GetStackedValue(i) < 0 then
                Canvas.TextOut(ypos - Canvas.TextWidth(str) div 2, sy + Round(bw / 2) - Canvas.TextHeight(str) div 2, str)
              else if GetStackedValue(i) = 0 then
                Canvas.TextOut(ypos + Canvas.TextWidth(str), sy + Round(bw / 2) - Canvas.TextHeight(str) div 2, str)
              else
                Canvas.TextOut(ypos - Canvas.TextWidth(str) div 2, sy + Round(bw / 2) - Canvas.TextHeight(str) div 2, str);
            end
            else if (ChartType = ctCandleStick) or (ChartType = ctLineCandleStick) or (ChartType = ctOHLC) or (ChartType = ctBoxPlot) then
            begin
              str := FloatToStr(cpt.HighValue);
              ypos := ValueToY(cpt.HighValue, Chart.Series.SeriesRectangle);
              Canvas.TextOut(ypos + ValueOffsetX , sy + Round(bw / 2) - Canvas.TextHeight(str) div 2, str);

              str := FloatToStr(cpt.OpenValue);
              ypos := ValueToY(cpt.OpenValue, Chart.Series.SeriesRectangle);
              Canvas.TextOut(ypos + ValueOffsetX - Canvas.TextWidth(str) - 2, sy + Round(bw / 2) - Canvas.TextHeight(str) div 2, str);

              str := FloatToStr(cpt.CloseValue);
              ypos := ValueToY(cpt.CloseValue, Chart.Series.SeriesRectangle);
              Canvas.TextOut(ypos + ValueOffsetX + 2, sy + Round(bw / 2) - Canvas.TextHeight(str) div 2, str);

              str := FloatToStr(cpt.LowValue);
              ypos := ValueToY(cpt.LowValue, Chart.Series.SeriesRectangle);
              Canvas.TextOut(ypos + ValueOffsetX - Canvas.TextWidth(str), sy + Round(bw / 2) - Canvas.TextHeight(str) div 2, str);

              if ChartType = ctBoxPlot then
              begin
                str := FloatToStr(cpt.MedValue);
                ypos := ValueToY(cpt.MedValue, Chart.Series.SeriesRectangle);
                Canvas.TextOut(ypos + ValueOffsetX + 2, sy + Round(bw / 2) - Canvas.TextHeight(str) div 2, str);
              end;
            end
            else
            begin
              if GetStackedValue(i) < 0 then
                Canvas.TextOut(ypos - Canvas.TextWidth(str) - 2, sy + Round(bw / 2) - Canvas.TextHeight(str) div 2, str)
              else
                Canvas.TextOut(ypos + 4, sy + Round(bw / 2) - Canvas.TextHeight(str) div 2, str)
            end;
          end
          else
          begin
            if (ChartType = ctBubble) or (ChartType = ctScaledBubble) then
            begin
              if GetStackedValue(i) < 0 then
                Canvas.TextOut(sx + Round(bw / 2) - Canvas.TextWidth(str) div 2, ypos - Canvas.TextHeight(str) div 2, str)
              else if GetStackedValue(i) = 0 then
                Canvas.TextOut(sx + Round(bw / 2) - Canvas.TextWidth(str) div 2, ypos - Canvas.TextHeight(str), str)
              else
                Canvas.TextOut(sx + Round(bw / 2) - Canvas.TextWidth(str) div 2, ypos - Canvas.TextHeight(str) div 2, str);
            end
            else if (ChartType = ctCandleStick) or (ChartType = ctLineCandleStick) or (ChartType = ctOHLC) or (ChartType = ctBoxPlot) then
            begin
              str := FloatToStr(cpt.HighValue);
              ypos := ValueToY(cpt.HighValue, Chart.Series.SeriesRectangle);
              Canvas.TextOut(sx + Round(bw / 2) - Canvas.TextWidth(str) div 2, ypos + ValueOffsetY - Canvas.TextHeight(str), str);

              str := FloatToStr(cpt.OpenValue);
              ypos := ValueToY(cpt.OpenValue, Chart.Series.SeriesRectangle);
              Canvas.TextOut(sx + Round(bw / 2) - Canvas.TextWidth(str) div 2, ypos+ ValueOffsetY + 2, str);

              str := FloatToStr(cpt.CloseValue);
              ypos := ValueToY(cpt.CloseValue, Chart.Series.SeriesRectangle);
              Canvas.TextOut(sx + Round(bw / 2) - Canvas.TextWidth(str) div 2, ypos+ ValueOffsetY - Canvas.TextHeight(str) - 1, str);

              str := FloatToStr(cpt.LowValue);
              ypos := ValueToY(cpt.LowValue, Chart.Series.SeriesRectangle);
              Canvas.TextOut(sx + Round(bw / 2) - Canvas.TextWidth(str) div 2, ypos+ ValueOffsetY, str);

              if ChartType = ctBoxPlot then
              begin
                str := FloatToStr(cpt.MedValue);
                ypos := ValueToY(cpt.MedValue, Chart.Series.SeriesRectangle);
                Canvas.TextOut(sx + Round(bw / 2) - Canvas.TextWidth(str) div 2, ypos+ ValueOffsetY - Canvas.TextHeight(str) , str);
              end;
            end
            else
            begin
              if GetStackedValue(i) >= 0 then
                Canvas.TextOut(sx + Round(bw / 2) - Canvas.TextWidth(str) div 2, ypos - Canvas.TextHeight(str), str)
              else
                Canvas.TextOut(sx + Round(bw / 2) - Canvas.TextWidth(str) div 2, ypos, str)
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TChartAnnotation.Draw(Canvas: TCanvas; DR, TextR: TRect; xm,ym: integer; ScaleX, ScaleY: double);
var
  HRGN, newRgn: THandle;
  mw,mh: integer;
  DTSTYLE: dword;
  bw, brn, x, y: integer;
  r: TRect;
begin
  if Color <> clnone then
  begin
    Canvas.Brush.Color := Color;
  end;

  bw := Round(BorderWidth * ScaleX);
  brn := Round(BorderRounding * ScaleX);

  if BorderColor <> clNone then
  begin
    Canvas.Pen.Color := BorderColor;
    Canvas.Pen.Width := bw;
  end;

  x := 0;
  y := 0;

  case Shape of
    asLine:
    begin
      with Serie.Chart.Series do
      begin
        r := SeriesRectangle;
        Canvas.Pen.Color := LineColor;
        Canvas.Pen.Width := LineWidth;
        xm := Serie.GetDrawPoint(DisplayIndex).X;
        ym := r.Top;
        x := xm;
        y := r.Bottom;
        Canvas.MoveTo(xm, ym);
        Canvas.LineTo(x, y);
      end;
    end;
    asRectangle:
    begin
      if (ColorTo <> clNone) and (Color <> clNone) then
        DrawGradient(Canvas, Color, ColorTo, GradientSteps, DR, GradientDirection, (BorderColor <> clNone), BorderColor, bw, asRectangle, 0, [cbLeft, cbTop, cbRight, cbBottom], false, false)
      else
        Canvas.Rectangle(DR);
    end;
    asCircle:
    begin
      if (ColorTo <> clNone) and (Color <> clNone) then
      begin
        HRGN := CreateEllipticRgn(DR.Left - bw, DR.Top - bw, DR.Right + bw, DR.Bottom + bw);
        newRgn := CreateRectRgn(DR.Left, DR.Top, DR.Right, DR.Bottom);
        CombineRgn(newRGN,HRGN,FClipRgn,RGN_AND);
        SelectClipRgn(Canvas.Handle,newRGN);
        DrawGradient(Canvas, Color, ColorTo, GradientSteps, DR, GradientDirection, (BorderColor <> clNone), BorderColor, bw, asCircle, 0, [cbLeft, cbTop, cbRight, cbBottom], false, false);
        SelectClipRgn(Canvas.Handle,FClipRgn);
        DeleteObject(newRGN);
        DeleteObject(HRGN);
      end
      else
        Canvas.Ellipse(DR);
    end;
    asRoundRect:
    begin
      if (ColorTo <> clNone) and (Color <> clNone) then
      begin
        HRGN := CreateRoundRectRgn(DR.Left - bw, DR.Top - bw, DR.Right + bw, DR.Bottom + bw, brn, brn);
        newRgn := CreateRectRgn(DR.Left, DR.Top, DR.Right, DR.Bottom);
        CombineRgn(newRGN,HRGN,FClipRgn,RGN_AND);
        SelectClipRgn(Canvas.Handle,newRGN);
        DrawGradient(Canvas, Color, ColorTo, GradientSteps, DR, GradientDirection, (BorderColor <> clNone), BorderColor, bw, asRoundRect, brn, [cbLeft, cbTop, cbRight, cbBottom], false, false);
        SelectClipRgn(Canvas.Handle,FClipRgn);
        DeleteObject(newRGN);
        DeleteObject(HRGN);
      end
      else
        Canvas.RoundRect(DR.Left, DR.Top, DR.Right, DR.Bottom, brn, brn);
    end;
    asBalloon:
    begin
      DR := DrawBalloon(Canvas, DR, FClipRgn, ScaleX, ScaleY);
      TextR := DR;
    end;
  end;

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

  if Shape <> asLine then
  begin
    if (OffsetX < 0) and (OffsetY < 0) then
    begin
      Canvas.MoveTo(dr.Right - mw, dr.Bottom - mh);
      x := dr.Right - mw;
      y := dr.Bottom - mh;
    end
    else if (OffsetX < 0) and (OffsetY > 0) then
    begin
      Canvas.MoveTo(dr.Right - mw, dr.Top + mh);
      x := dr.Right - mw;
      y := dr.Top + mh;
    end
    else if (OffsetX > 0) and (OffsetY < 0) then
    begin
      Canvas.MoveTo(dr.Left + mw, dr.Bottom - mh);
      x := dr.Left + mw;
      y := dr.Bottom - mh;
    end
    else
    begin
      Canvas.MoveTo(dr.Left + mw, dr.Top + mh);
      x := dr.Left + mw;
      y := dr.Top + mh;
    end;

    if LineColor <> clNone then
    begin
      Canvas.Pen.Color := LineColor;
      Canvas.Pen.Width := LineWidth;
    end;

    case Arrow of
      arLine: Canvas.LineTo(xm, ym);
      arStartArrow: Canvas.LineTo(xm, ym);
      arEndArrow: Canvas.LineTo(xm, ym);
      arDoubleArrow: Canvas.LineTo(xm, ym);
    end;
  end;


  case Arrow of
    arStartArrow:
    begin
      DrawArrow(Canvas, ArrowColor, ArrowSize, Point(x, y), Point(xm, ym), ScaleX, ScaleY);
    end;
    arEndArrow:
    begin
      DrawArrow(Canvas, ArrowColor, ArrowSize, Point(xm, ym), Point(x, y), ScaleX, ScaleY);
    end;
    arDoubleArrow:
    begin
      DrawArrow(Canvas, ArrowColor, ArrowSize, Point(xm, ym), Point(x, y), ScaleX, Scaley);
      DrawArrow(Canvas, ArrowColor, ArrowSize, Point(x, y), Point(xm, ym), ScaleX, ScaleY);
    end;
  end;

  if Text <> '' then
  begin
    textr.Left := textr.Left + 1;
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

    DrawText(Canvas.Handle, PChar(Text), length(Text), TextR, DTSTYLE);
  end;
end;

function TChartAnnotation.DrawBalloon(Canvas: TCanvas; R: TRect; OldRGN: THandle; ScaleX, ScaleY: Double): Trect;
var
  BalloonRect: TRect;

  ArrowPoints: array[0..2] of TPoint;
  ArrowRgn, RoundRgn, BalloonRgn, NewRgn: HRGN;
  bsx, bsy: integer;
begin
  { set up drawing regions }

   bsx := Round(BalloonArrowSize * ScaleX);
   bsy := Round(BalloonArrowSize * ScaleY);

  case BalloonDirection of
    hdUpRight:
    begin
      BalloonRect := Rect(R.Left, R.Top + bsy, R.Right, R.Bottom);
      ArrowPoints[0] := Point(Balloonrect.Right - 10, Balloonrect.Top - bsy);
      ArrowPoints[1] := Point(Balloonrect.Right - 10 - bsx - BorderWidth, Balloonrect.Top + BorderWidth);
      ArrowPoints[2] := Point(Balloonrect.Right - 10, Balloonrect.Top + bsy);
    end;
    hdUpLeft:
    begin
      BalloonRect := Rect(R.Left, R.Top + bsy, R.Right, R.Bottom);
      ArrowPoints[0] := Point(Balloonrect.Left + 10, Balloonrect.Top - bsy);
      ArrowPoints[1] := Point(Balloonrect.Left + 10 + bsx + BorderWidth, Balloonrect.Top + BorderWidth);
      ArrowPoints[2] := Point(Balloonrect.Left + 10, Balloonrect.Top + bsy);
    end;
    hdDownRight:
    begin
      BalloonRect := Rect(R.Left, R.Top, R.Right, R.Bottom - bsy);
      ArrowPoints[0] := Point(Balloonrect.Right - 10, Balloonrect.Bottom - bsy);
      ArrowPoints[1] := Point(Balloonrect.Right - 10 - bsx - BorderWidth, Balloonrect.Bottom - BorderWidth);
      ArrowPoints[2] := Point(Balloonrect.Right - 10, Balloonrect.Bottom + bsy);
    end;
    hdDownLeft:
    begin
      BalloonRect := Rect(R.Left, R.Top, R.Right, R.Bottom - bsy);
      ArrowPoints[0] := Point(Balloonrect.Left + 10, Balloonrect.Bottom - bsy);
      ArrowPoints[1] := Point(Balloonrect.Left + 10 + bsx + BorderWidth, Balloonrect.Bottom - BorderWidth);
      ArrowPoints[2] := Point(Balloonrect.Left + 10, Balloonrect.Bottom + bsy);
    end;
  end;

  ArrowRgn := CreatePolygonRgn(ArrowPoints, 3, ALTERNATE);

  RoundRgn := CreateRoundRectRgn(BalloonRect.Left, BalloonRect.Top,
  BalloonRect.Right, BalloonRect.Bottom,
    Round(BorderRounding * ScaleX), Round(BorderRounding * ScaleY));

  BalloonRgn := CreateRectRgn(0, 0, 1, 1);

  CombineRgn(BalloonRgn, RoundRgn, ArrowRgn, RGN_OR);

  SelectObject(Canvas.Handle, BalloonRgn);

  DeleteObject(RoundRgn);
  DeleteObject(ArrowRgn);

  NewRgn := CreateRectRgn(0, 0, 1, 1);

  CombineRgn(NewRgn, BalloonRgn, OldRgn, RGN_AND);

  SelectObject(Canvas.Handle, NewRgn);

  try
    with Canvas do begin
      { draw balloon }
      Brush.Color := Color;
      Pen.Mode := pmCopy;
      if (Color <> clNone) and (Colorto <> Clnone) then
      begin
        DrawGradient(Canvas, Color, ColorTo, GradientSteps, r, GradientDirection, (BorderColor <> clNone), BorderColor, BorderWidth, asRectangle,0, [cbLeft, cbTop, cbRight, cbBottom], false, false);
      end
      else
        PaintRgn(Canvas.Handle, BalloonRgn);

      { draw border }
      Brush.Color := BorderColor;
      FrameRgn(Canvas.Handle, BalloonRgn, Brush.Handle, BorderWidth, BorderWidth);
    end;
  finally
    DeleteObject(BalloonRgn);
    DeleteObject(NewRgn);
    SelectObject(Canvas.Handle, OldRgn);
    Result := BalloonRect;
  end;
end;

function FindLine(X2, Y2, Range, DeltaX, DeltaY:Integer;
    Tangent:real) : TPoint;
var
  DX : Integer;
begin
  if DeltaX < 0 then
     DX := X2 + Round(Sqrt(Sqr(Range) / ( Sqr(Tangent) + 1)))
  else
     DX := X2 - Round(Sqrt(Sqr(Range) / ( Sqr(Tangent) + 1)));
  FindLine.X := DX;
     FindLine.Y := Y2 - Round(Tangent * (X2 - DX))
end;


function FindTangent(DeltaX, DeltaY : Integer) : Real;
var
  m : Real;
begin
  if DeltaX = 0 then
     m := 20
  else if DeltaY = 0then
     m := -0.05
  else
     m := DeltaY / DeltaX;


  if abs(m) < 0.05 then
     m := 0.05
  else if m > 20 then
     m := 20
  else if m < -20 then
     m := -20;
  FindTangent := m;
end;


//procedure DrawArrow(Canvas: Tcanvas;X1, Y1, X2, Y2 : Integer; fill: Boolean; color: Tcolor);
//var
//  Point3, Point4, Point5 : TPoint;
//  m : Real;
//  DeltaX, DeltaY : Integer;
//begin
//   DeltaX := X1 - X2;
//   DeltaY := Y1 - Y2;
//   m := FindTangent(DeltaX, DeltaY);
//   Point3 := FindLine(X1, Y1, 15, DeltaX, DeltaY, m);
//   Point4 := FindLine(Point3.X, Point3.Y, 15, DeltaX, DeltaY, (-1/m));
//   Point5 := FindLine(Point3.X, Point3.Y, 15, -DeltaX, DeltaY, (-1/m));
//   if fill then
//     Canvas.Brush.Color := color
//   else
//     Canvas.Brush.style := bsClear;
//   Canvas.Polygon([Point(X1, Y1),Point(Point4.X, Point4.Y),
//    Point(Point3.X, Point3.Y),Point(Point5.X, Point5.Y),Point(X1, Y1)]);
//end;


procedure TChartSerie.DrawAnnotations(Canvas: TCanvas; R: TRect; ScaleX,
  ScaleY: Double);
var
  I, c: Integer;
  Dr: TRect;
  th: integer;
  xm, ym: integer;
  DTSTYLE: DWord;
  Textr: TRect;
  brx, bry, a, b, diffx, diffy: integer;
  x, y: Double;
  ofx, ofy: integer;
  bw: integer;
  gantth: Integer;
begin
  for I := 0 to Annotations.Count - 1 do
  begin
    with Annotations[I] do
    begin
      if Visible then
      begin
        c := DisplayIndex;
        if (c + Chart.Range.RangeFrom >= Chart.Range.RangeFrom) and (c + Chart.Range.RangeFrom <= Chart.Range.rangeto)
          and (c >= 0) and (c < Length(DrawValuesDP)) or (ChartType = ctXYLine) or (ChartType = ctXYDigitalLine) or (ChartType = ctXYMarkers) or (ChartType = ctGantt)
            and (c < Length(DrawValuesDP)) and (c >= 0) then
        begin
          Canvas.Font.Assign(Font);

          bw := 0;
          case ChartType of
            ctBar, ctStackedBar, ctLineBar, ctStackedPercBar:
              bw := GetBarWidth(ScaleX);
            ctHistogram, ctLineHistogram:
              bw := GetHistogramBarWidth(ScaleX);
          end;

          if Chart.Series.IsHorizontal then
          begin
            xm := DrawValuesDP[c].X;
            ym := DrawValuesDP[c].Y + Round(bw / 2);
          end
          else
          begin
            xm := DrawValuesDP[c].X + Round(bw / 2);
            if ChartType <> ctGantt then
              ym := DrawValuesDP[c].Y
            else
            begin
              gantth := GetPreviousGanttGroupHeight;
              ym := r.Bottom - gantth - GanttSpacing - GanttHeight;
            end;
          end;

          ofx := Round(OffsetX * ScaleX);
          ofy := Round(OffsetY * ScaleY);

          if AutoSize then
          begin
            DTSTYLE := 0;
            if WordWrap then
              DTSTYLE := DTSTYLE or DT_WORDBREAK
            else
              DTSTYLE := DTSTYLE or DT_SINGLELINE;

            DTSTYLE := DTSTYLE or DT_CALCRECT;

            Dr := bounds(xm + ofx , ym + ofy , Round(Width * ScaleX), Round(Height * ScaleY));
            th := DrawText(Canvas.Handle, PChar(Text), Length(Text), Dr, DTSTYLE);
            Textr := Dr;

            brx := Round((BorderRounding div 2) * Scalex);
            bry := Round((BorderRounding div 2) * ScaleY);

            case Shape of
              asRectangle: Dr := TextR;
              asCircle:
              begin
                x := (textr.Right - TextR.Left) / 2;
                y := (textr.Bottom - TextR.Top) / 2;
                b := Round(Sqrt(2) * y);
                a := Round(Sqrt(2) * x);
                diffx := Round(b - y);
                diffy := Round(a - x);
                DR := Rect(TextR.Left - diffx, TextR.Top - diffy, TextR.Right + diffx, TextR.Bottom + diffy);
              end;
              asRoundRect: Dr := rect(xm + ofx - brx, ym + ofy - bry , TextR.Right + brx, TextR.Bottom + bry);
              asBalloon:
              begin
                Dr := rect(xm + ofx - brx, ym + ofy - bry , TextR.Right + brx, TextR.Bottom + bry + th);
              end;
            end;
          end
          else
          begin
            Dr := Bounds(xm + ofx, ym + ofy, Round(Width * ScaleX), Round(Height * ScaleY));
            Textr := Dr;
          end;

          Dr.Right := DR.Right + 2;

          FAnnotationRect := DR;

          FClipRgn := Self.FClipRgn;
          Draw(Canvas, DR, Textr, xm, ym, ScaleX, ScaleY);
        end;
      end;
    end;
  end;
end;

procedure TChartSerie.DrawDateTimeValues(DateTimeFormat: String;
  ValueIndex: integer; Canvas: TCanvas; Rect: TRect; m: integer);
var
  Year, Yearpr, Month, Monthpr, Day, Daypr: Word;
  Hour, HourPr, Minute, MinutePr, Second, SecondPr, MSecond, MSecondPr: Word;
  th: integer;
  dt: String;
  VPr, V: Word;
  chp: TChartPoint;
begin
  if (Chart.XAxis.UnitType <> utNumber) and ((Collection as TChartSeries).SeriesRectangle.Bottom > (Collection as TChartSeries).SeriesRectangle.Top) then
  begin
    Canvas.Font.Assign(XAxis.DateTimeFont);
    th := Canvas.TextHeight('gh') + 1;

    if m < Flastxmarker then
      Flastxval := 0;

    Flastxmarker := m;

    if m > Flastxval then
    begin
      if ValueIndex > 0 then
      begin
        DecodeDate(GetChartPoint(ValueIndex).TimeStamp, Year, Month, Day);
        DecodeDate(GetChartPoint(ValueIndex - 1).TimeStamp, Yearpr, Monthpr, Daypr);
        DecodeTime(GetChartPoint(ValueIndex).TimeStamp, Hour, Minute, Second, MSecond);
        DecodeTime(GetChartPoint(ValueIndex -1).TimeStamp, HourPr, MinutePr, SecondPr, MSecondPr);

        Vpr := 0;
        V := 0;

        case Chart.XAxis.UnitType of
          utDay:
          begin
            VPr := Monthpr;
            V := Month;
          end;
          utMonth:
          begin
            VPr := Yearpr;
            V := Year;
          end;
          utHour:
          begin
            VPr := DayPr;
            V := Day;
          end;
          utMinute:
          begin
            VPr := DayPr;
            V := Day;
          end;
        end;

        if VPr <> V then
        begin
          chp := GetChartPoint(ValueIndex);
        if chp.Defined and (chp.TimeStamp <> 0) then
          begin
            dt := FormatDateTime(DateTimeFormat,chp.TimeStamp);
            Canvas.TextOut(m - th div 2, Rect.Top + th, dt);
            Flastxval := m + Canvas.TextWidth(dt);
          end;
        end;
      end
      else
      begin
        chp := GetChartPoint(ValueIndex);

        if chp.Defined and (chp.TimeStamp <> 0) then
        begin
          dt := FormatDateTime(DateTimeFormat,chp.TimeStamp);
          Canvas.TextOut(m - th div 2, Rect.Top + th, dt);
          Flastxval := m + Canvas.TextWidth(dt);
        end;
      end;
    end;
  end;
end;

procedure TChartSerie.DrawFunnelPart(Canvas: TCanvas; APoints: TPointArray; APointIndex: Integer; ScaleX, ScaleY: Double);
begin
  if Enable3D then
  begin
    Canvas.Ellipse(APoints[3].X, APoints[2].Y - Offset3D div 2, APoints[2].X, APoints[2].Y + Offset3D div 2);
    Canvas.Pen.Style := psClear;
    Canvas.Polygon(APoints);
    InitializeBorderColor(Canvas, ScaleX, ScaleY);
    Canvas.MoveTo(APoints[0].X, APoints[0].Y);
    Canvas.LineTo(APoints[3].X, APoints[3].Y);
    Canvas.MoveTo(APoints[1].X, APoints[1].Y);
    Canvas.LineTo(APoints[2].X, APoints[2].Y);
    if Darken3D then
      Canvas.Brush.Color := DarkenColor(Canvas.Brush.Color, True);
    Canvas.Ellipse(APoints[0].X, APoints[0].Y - Offset3D div 2, APoints[1].X, APoints[0].Y + Offset3D div 2);
  end
  else
    Canvas.Polygon(APoints);


  Canvas.Brush.Style := bsClear;
  DrawFunnelValue(Canvas, APoints, APointIndex, ScaleX, ScaleY);
end;

procedure TChartSerie.DrawFunnelValue(Canvas: TCanvas; APoints: TPointArray;
  APointIndex: Integer; ScaleX, ScaleY: Double);
var
  c: TPoint;
  th, tw: integer;
  s: String;
begin
  if not Pie.ShowValues then
    Exit;

  if ValueType <> cvNone then
  begin
    if ValueFormat <> '' then
    begin
      case ValueType of
        cvNormal:
        begin
          case ValueFormatType of
            vftNormal: s := Format(ValueFormat, [GetPoint(APointIndex).SingleValue]);
            vftFloat:  s := FormatFloat(ValueFormat, GetPoint(APointIndex).SingleValue);
          end;
        end;
        cvPercentage: s := GetPercentageValue(GetPoint(APointIndex).SingleValue) + '%';
      end;
    end;

    if Pie.ShowLegendOnSlice then
      s := GetPoint(APointIndex).LegendValue + ' (' + s+')';

    tw := Canvas.TextWidth(s);
    th := Canvas.TextHeight(s);

    case Pie.ValuePosition of
      vpInsideSlice:  c := Point(APoints[0].X + ((APoints[1].X - APoints[0].X) - tw) div 2, APoints[0].Y + ((APoints[2].Y - APoints[1].Y) - th) div 2);
      vpOutSideSlice: c := Point(10 + APoints[1].X + (APoints[2].X - APoints[1].X) div 2, APoints[0].Y + ((APoints[2].Y - APoints[1].Y) - th) div 2);
    end;
    case ValueType of
      cvPercentage, cvNormal: Canvas.TextOut(c.X, c.Y, s);
    end;
  end;
end;

function TChartSerie.DrawLegend(Canvas: TCanvas; R: Trect; ScaleX, ScaleY: Double; Draw: Boolean): TRect;
var
  hw, hh, hx, hy, tempw, temph, tlh, tlw, i: integer;
  str: String;
  centerh, centerv: integer;
  pbr: Trect;
  ptCenter: TPoint;
  pt: TChartPoint;
begin
  if not Pie.LegendVisible or (not IsPieChart) then
      Exit;

  //DRAW Pie Legend
  if (GetPointsCount > 0) then
  begin
    tlw := -MAXLONG;

    Canvas.Font.Assign(Pie.LegendFont);
    temph := 0;
    for I := 0 to GetPointsCount - 1 do
    begin
      pt := GetPoint(I);
//      if (Points[I].LegendValue <> '') then
      begin
        str := '';
        if (pt.SingleValue > 0) then
        begin
          case ValueType of
            cvNone: str := pt.LegendValue;
            cvNormal:
            begin
              case ValueFormatType of
                vftNormal: str := pt.LegendValue + ' (' + Format(ValueFormat, [pt.SingleValue]) + ')';
                vftFloat: str := pt.LegendValue + ' (' + FormatFloat(ValueFormat, pt.SingleValue) + ')';
              end;
            end;
            cvPercentage: str := pt.LegendValue + ' (' + Format(ValueFormat, [(pt.SingleValue / GetTotalPoints) * 100]) + '%)';
          end;
        end
        else
        begin
          case ValueType of
            cvNone: str := pt.LegendValue;
            cvNormal:
            begin
              case ValueFormatType of
                vftNormal: str := pt.LegendValue + ' (' + Format(ValueFormat, [pt.SingleValue]) + ')';
                vftFloat: str := pt.LegendValue + ' (' + FormatFloat(ValueFormat, pt.SingleValue) + ')';
              end;
            end;
            cvPercentage: str := pt.LegendValue + ' (' + Format(ValueFormat, [pt.SingleValue]) + '%)';
          end;
        end;

        tempw := Canvas.TextWidth(str);
        temph := temph + Canvas.TextHeight(str) + 5;
        if tlw < tempw then
          tlw := tempw;
      end;
    end;

    tlh := temph;
    tlh := Round(tlh * ScaleY);
    tlw := tlw + 25;

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

procedure TChartSerie.DrawMarker(Sender: TObject; Canvas: TCanvas; x,
  y, point: integer; value: TChartPoint);
begin
  if Assigned(FOnMarkerDrawValue) then
    FOnMarkerDrawValue(Sender, Self, Canvas, x, y, point, value);
end;

procedure TChartSerie.DrawMarkers(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double);
var
  x, bw: integer;
  mcp: array of TPoint;
  xm, ym: integer;
  msx, msy: integer;
  m: TchartMarker;
  p: TPicture;
  dwp: TPointArray;
  nr: integer;
  ct, ct2: TChartPoint;
//  c: Integer;
begin
  dwp := nil;
  if (chartType = ctSpider) or (ChartType = ctHalfSpider) then
    dwp := SpiderV
  else
    dwp := DrawValuesDP;

  nr := High(dwp);
  if (ChartType in [ctArea, ctStackedArea, ctStackedPercArea]) then
    dec(nr,2);

  if Length(dwp) = 0 then
    exit;

  m := Marker;

  bw := 0;
  case ChartType of
    ctBar, ctStackedBar, ctLineBar, ctStackedPercBar:
      bw := GetBarWidth(ScaleX);
    ctHistogram, ctLineHistogram:
      bw := GetHistogramBarWidth(ScaleX);
  end;

  msx := 0;
  msy := 0;

  for X := 0 to nr do
  begin
    if chart.Series.IsHorizontal then
    begin
      xm := dwp[X].X ;
      ym := dwp[X].Y + Round(bw / 2);
    end
    else
    begin
      xm := dwp[X].X + Round(bw / 2);
      ym := dwp[X].Y;
    end;

    if (ChartType = ctXYMarkers) or (ChartType = ctXYLine) or (ChartType = ctXYDigitalLine) then
    begin
      ct := GetChartPoint(X);
      ct2 := GetChartPoint(X + 1);
    end
    else
    begin
      ct := GetChartPointFromDrawPoint(X);
      ct2 := GetChartPointFromDrawPoint(X + 1);
    end;

    if m.IncreaseDecreaseMode or (ChartType = ctRenko) then
    begin
      if ct.Defined and ct2.Defined then
      begin
        msx := Round(m.MarkerSize * ScaleX);
        msy := Round(m.MarkerSize * ScaleY);

        if X > 0 then
        begin
          if ct.SingleValue > ct2.SingleValue then
            Canvas.Brush.Color := CandleColorIncrease
          else
            Canvas.Brush.Color := CandleColorDecrease;
        end
        else
          Canvas.Brush.Color := CandleColorIncrease;

        Canvas.Pen.Width := Round(m.FMarkerLineWidth * ScaleX);
        Canvas.Pen.Color := m.FMarkerLineColor;
        Canvas.Pen.Style := psSolid;
      end;
    end
    else
    begin
      if m.DisplayIndex = X then
      begin
        msx := Round(m.SelectedSize * ScaleX);
        msy := Round(m.SelectedSize * ScaleY);

        if m.SelectedColor <> clNone then
          Canvas.Brush.Color := m.SelectedColor
        else
          Canvas.Brush.Style := bsClear;

        Canvas.Pen.Width := Round(m.SelectedLineWidth * ScaleX);
        Canvas.Pen.Color := m.SelectedLineColor;
        Canvas.Pen.Style := psSolid;
      end
      else
      begin
        msx := Round(m.MarkerSize * ScaleX);
        msy := Round(m.MarkerSize * ScaleY);

        if m.MarkerColor <> clNone then
          Canvas.Brush.Color := m.FMarkerColor
        else
          Canvas.Brush.Style := bsClear;

        Canvas.Pen.Width := Round(m.FMarkerLineWidth * ScaleX);
        Canvas.Pen.Color := m.FMarkerLineColor;
        Canvas.Pen.Style := psSolid;
      end;
    end;

    if ct.Defined then
    begin
      case FMarker.MarkerType of
        mNone: ; // draw nothing
        mCircle: Canvas.Ellipse(Bounds(xm - msx div 2 , ym - msy div 2 , msx, msy));
        mSquare: Canvas.Rectangle(Bounds(xm - msx div 2 , ym - msy div 2 , msx, msy));
        mDiamond:
          begin
            SetLength(mcp, 4); //DIAMOND 4 POINTS
            mcp[0] := Point(xm, ym - msy div 2);
            mcp[1] := Point(xm + msx div 2, ym);
            mcp[2] := Point(xm , ym + msy div 2);
            mcp[3] := Point(xm - msx div 2, ym );
            Canvas.Polygon(mcp) ;
          end;
        mTriangle:
          begin
            SetLength(mcp, 3); //TRIANGLE 3 POINTS
            mcp[0] := Point(xm, ym - msy);
            mcp[1] := Point(xm + msx div 2 , ym);
            mcp[2] := Point(xm - msx div 2 , ym);
            Canvas.Polygon(mcp);
          end;
        mPicture:
        begin
          if Assigned(m.MarkerPicture) and Assigned(m.MarkerPicture.Graphic) then
          begin
            p := m.MarkerPicture;
            Canvas.StretchDraw(Rect(xm - msx, ym - msy, xm + (msx div 2), ym + (msy div 2)), p.Graphic);
          end;
        end;
        mCustom:
          begin
            DrawMarker(m, Canvas, xm, ym, X, ct);
          end;
      end;
    end;
  end;
end;

procedure TChartSerie.DrawXValues(Canvas: TCanvas; R: TRect; XAxisY: integer; Top: boolean; ScaleX, ScaleY: Double);
var
  x, fv, tv, tw: Integer;
  xs: Double;
  df: Boolean;
  G: Integer;
  xsize, xheight: integer;
  grouph, groupw, level, groupmax, totalh: Integer;
  piStart, piEnd: Integer;
  xGroup: TChartSerieXAxisGroup;
  S: Integer;
  rGroup: TRect;
  DoDrawText: Boolean;
  horz: Boolean;
  tf: TFont;
  lf: TLogFontW;
  twStr: Integer;
  GSub: Integer;
  tot: integer;
  totsz: integer;
  sz: Integer;
begin
  fv := Chart.Range.RangeFrom;
  tv := Chart.Range.RangeTo;

  xs := Chart.XScale;

  if xs = 0 then
    exit;

  Canvas.Brush.Style := bsClear;

  Fmu := round(XAxis.MajorUnit);
  Fmi := round(XAxis.MinorUnit);

  FMinimumDistance := Chart.FXScale;

  Ffirstpoint := 1 * FMinimumDistance;
  Fnextpoint := (1 + Fmi) * FMinimumDistance;

  tw := Canvas.TextWidth('WW');

  if FMi <> 0 then
  begin
    if XAxis.AutoUnits then
    begin
      while Ffirstpoint + tw + 4 >= Fnextpoint do
      begin
        Ffirstpoint := 1 * FMinimumDistance;
        Fnextpoint := (1 + Fmi) * FMinimumDistance;
        Fmi := Fmi + Fmi;
      end;
    end;
  end;

  Ffirstpoint := 1 * FMinimumDistance;
  Fnextpoint := (1 + Fmu) * FMinimumDistance;

  if FMu <> 0 then
  begin
    if XAxis.AutoUnits then
    begin
      while Ffirstpoint + tw + 4 >= Fnextpoint do
      begin
        Ffirstpoint := 1 * FMinimumDistance;
        Fnextpoint := (1 + Fmu) * FMinimumDistance;
        Fmu := Fmu + Fmu;
      end;
    end;
  end;

  if (Fmu = 0) and (Fmi = 0) then
    Exit;

  if XAxis.Visible then
  begin

    for X := fv to tv do
    begin
      if Chart.Series.IsHorizontal then
      begin
        FXMarker := R.Top + Floor(((X - Chart.Range.RangeFrom) * xs) + Chart.GetXScaleStart - XAxis.TickMarkWidth / 2);
        df := true;
        if (fxmarker > 0) then //and (fxmarker <= r.Right) then
          XAxisDrawValue(Self, Self, Canvas, R, XAxisY, X, FXMarker, Top, ScaleX, ScaleY, not DrawFromStartDate, df);
        if (fxmarker > r.Bottom) then
          Break;
      end
      else
      begin
        FXMarker := R.Left + Floor(((X - Chart.Range.RangeFrom) * xs) + Chart.GetXScaleStart - XAxis.TickMarkWidth / 2);
        df := true;
        if (fxmarker > 0) then //and (fxmarker <= r.Right) then
          XAxisDrawValue(Self, Self, Canvas, R, XAxisY, X, FXMarker, Top, ScaleX, ScaleY, not DrawFromStartDate, df);
        if (fxmarker > r.Right) then
          Break;
      end;
    end;


    if ((ChartType = ctXYLine) or (ChartType = ctXYDigitalLine) or (ChartType = ctXYMarkers)) and XAxis.XYValues then
    begin
      sz := GetXValuesSize(Canvas, ScaleX, ScaleY, tot);
      sz := sz - tot + XAxis.XYValuesOffset;
      if Chart.Series.IsHorizontal then
      begin
        if not Top then
        begin
          R.Right := r.Right - sz;
          XAxisY := XAxisY - sz;
        end
        else
        begin
          R.Left := r.Left + sz;
          XAxisY := XAxisY + sz;
        end;
      end
      else
      begin
        if Top then
        begin
          R.Bottom := r.Bottom - sz;
          XAxisY := XAxisY - sz;
        end
        else
        begin
          r.Top := r.Top + sz;
          XAxisY := XAxisY + sz;
        end;
      end;

      for X := 0 to GetPointsCount - 1 do
      begin
        if GetPoint(X).Defined then
        begin
          if Chart.Series.IsHorizontal then
          begin
            FXMarker := ValueToX(GetChartPoint(X).SingleXValue, Chart.Series.SeriesRectangle);
            df := true;
            if (fxmarker > r.Top) and (fxmarker <= r.Bottom) then
              XAxisDrawValue(Self, Self, Canvas, R, XAxisY, X, FXMarker, Top, ScaleX, ScaleY, true, df);
            if (fxmarker > r.Bottom) then
              break;
          end
          else
          begin
            FXMarker := ValueToX(GetChartPoint(X).SingleXValue, Chart.Series.SeriesRectangle);
            df := true;
            if (fxmarker > r.Left) and (fxmarker <= r.Right) then
              XAxisDrawValue(Self, Self, Canvas, R, XAxisY, X, FXMarker, Top, ScaleX, ScaleY, true, df);
            if (fxmarker > r.Right) then
              break;
          end;
        end;
      end;
    end;


    horz := Chart.Series.IsHorizontal;
    if ((Collection as TChartSeries).SeriesRectangle.Bottom > (Collection as TChartSeries).SeriesRectangle.Top) and ((Collection as TChartSeries).SeriesRectangle.Right > (Collection as TChartSeries).SeriesRectangle.Left) then
    begin
      if XAxisGroupsVisible then
      begin
        xsize := 0;
        xheight := GetXValuesSize(Canvas, 1, 1, totsz);
        for S := 0 to Index - 1 do
          xsize := xsize + Chart.Series[s].GetXValuesSize(Canvas, 1, 1, totsz);

        xsize := xsize + xheight;

        for G := 0 to XAxisGroups.Count - 1 do
        begin
          DoDrawText := True;
          xGroup := XAxisGroups[G];
          if xGroup.Visible then
          begin
            totalh := 0;
            level := -1;
            for GSub := 0 to XAxisGroups.Count - 1 do
            begin
              if XAxisGroups[GSub].Visible then
              begin
                if (XAxisGroups[GSub].Level > level) and (XAxisGroups[GSub].Level >= xGroup.Level) then
                begin
                  level := XAxisGroups[gSub].Level;
                  groupmax := GetMaxLevel(XAxisGroups[GSub].Level);
                  totalh := totalh + groupmax;
                end;
              end;
            end;

            Canvas.Font.Assign(xGroup.Font);
            grouph := Canvas.TextHeight(xGroup.Caption) + 2;

            piStart := Round((xGroup.StartIndex - fv) * Chart.XScale);
            piEnd := Round((xGroup.EndIndex - fv) * Chart.XScale);

            if horz then
            begin
              piStart := Min(r.Bottom - r.Top, Max(piStart, 0));
              piEnd := Min(r.Bottom - r.Top, Max(piEnd, 0));
            end
            else
            begin
              piStart := Min(r.Right - r.Left, Max(piStart, 0));
              piEnd := Min(r.Right - r.Left, Max(piEnd, 0));
            end;

            if piStart <> piEnd then
            begin
              if horz then
              begin
                if Top then
                  rGroup := Bounds(Min(r.Right - grouph, r.Left + XAxis.TickMarkSize + xsize - totalh - 10), piStart + r.Top, grouph, piEnd - piStart)
                else
                  rGroup := Bounds(Max(r.Left , r.Right - XAxis.TickMarkSize - xsize + totalh - grouph + 10), piStart + r.Top, grouph, piEnd - piStart);
              end
              else
              begin
                if not Top then
                  rGroup := Bounds(piStart + r.Left, Min(r.Bottom - grouph,  r.Top + XAxis.TickMarkSize + xsize - totalh), piEnd - piStart, grouph)
                else
                  rGroup := Bounds(piStart + r.Left, Max(r.Top,  r.Bottom - XAxis.TickMarkSize - xsize + totalh - grouph), piEnd - piStart, grouph);
              end;

              Canvas.Pen.Color := xGroup.LineColor;
              Canvas.pen.width := 1;
              groupw := Canvas.TextWidth(xGroup.Caption);

              rGroup := Bounds(rgroup.Left + 3, rgroup.Top, rgroup.Right - rgroup.Left - 6, rgroup.Bottom - rgroup.Top);

              case xGroup.LineType of
                xgltVertical:
                begin
                  if (xGroup.StartIndex - fv) * Chart.XScale >= 0 then
                  begin
                    if horz then
                    begin
                      if not Top then
                      begin
                        Canvas.MoveTo(rgroup.Left, piStart + r.Top);
                        Canvas.LineTo(Min(r.Right, rgroup.Right + xheight - grouph + 5), piStart + r.Top);
                      end
                      else
                      begin
                        Canvas.MoveTo(Max(r.Left, rgroup.Right - xheight + 5), piStart + r.Top);
                        Canvas.LineTo(rgroup.Right + 2, piStart + r.top);
                      end;
                    end
                    else
                    begin
                      if Top then
                      begin
                        Canvas.MoveTo(piStart + r.Left, rgroup.Top);
                        Canvas.LineTo(piStart + r.Left, Min(r.Bottom, rgroup.Bottom + xheight - grouph + 10));
                      end
                      else
                      begin
                        Canvas.MoveTo(piStart + r.Left,  Max(r.Top,rgroup.Top - xheight + grouph - 10));
                        Canvas.LineTo(piStart + r.Left, rgroup.Bottom);
                      end;
                    end;

                    if horz then
                    begin
                      if (xGroup.EndIndex - fv) * Chart.XScale <= r.Bottom - r.Top then
                      begin
                        if not Top then
                        begin
                          Canvas.MoveTo(rgroup.Left, piEnd + r.Top);
                          Canvas.LineTo(Min(r.Right, rgroup.Right + xheight - grouph + 5), piEnd + r.Top);
                        end
                        else
                        begin
                          Canvas.MoveTo(Max(r.Left, rgroup.Right - xheight + 5), piEnd + r.Top);
                          Canvas.LineTo(rgroup.Right + 2, piEnd + r.top);
                        end;
                      end;
                    end
                    else
                    begin
                      if (xGroup.EndIndex - fv) * Chart.XScale <= r.Right - r.Left + 1 then
                      begin
                        if Top then
                        begin
                          Canvas.MoveTo(piEnd + r.Left, rgroup.Top);
                          Canvas.LineTo(piEnd + r.Left, Min(R.Bottom, rgroup.Bottom + xheight - grouph + 10));
                        end
                        else
                        begin
                          Canvas.MoveTo(piEnd + r.Left, Max(r.Top, rgroup.Top - xheight + grouph - 10));
                          Canvas.LineTo(piEnd + r.Left, rgroup.Bottom);
                        end;
                      end;
                    end;
                  end;
                end;
                xgltVerticalLine:
                begin
                  if (xGroup.StartIndex - fv) * Chart.XScale >= 0 then
                  begin
                    if horz then
                    begin
                      if Top then
                      begin
                        Canvas.MoveTo(rgroup.Right, piStart + r.Top);
                        Canvas.LineTo(r.Left, piStart + r.Top);
                      end
                      else
                      begin
                        Canvas.MoveTo(rgroup.Left, piStart + r.Top);
                        Canvas.LineTo(r.Right, piStart + r.Top);
                      end;
                    end
                    else
                    begin
                      if Top then
                      begin
                        Canvas.MoveTo(piStart + r.Left, rgroup.Top);
                        Canvas.LineTo(piStart + r.Left, r.Bottom);
                      end
                      else
                      begin
                        Canvas.MoveTo(piStart + r.Left, r.Top);
                        Canvas.LineTo(piStart + r.Left, rgroup.Bottom);
                      end;
                    end;
                  end;

                  if horz then
                  begin
                    if (xGroup.EndIndex - fv) * Chart.XScale <= r.Bottom - r.Top then
                    begin
                      if Top then
                      begin
                        Canvas.MoveTo(rgroup.Right, piEnd + r.Top);
                        Canvas.LineTo(r.Left, piEnd + r.Top);
                      end
                      else
                      begin
                        Canvas.MoveTo(rgroup.Left, piEnd + r.Top);
                        Canvas.LineTo(r.Right, piEnd + r.Top);
                      end;
                    end;
                  end
                  else
                  begin
                    if (xGroup.EndIndex - fv) * Chart.XScale <= r.Right - r.Left + 1 then
                    begin
                      if Top then
                      begin
                        Canvas.MoveTo(piEnd + r.Left, rgroup.Top);
                        Canvas.LineTo(piEnd + r.Left, r.Bottom);
                      end
                      else
                      begin
                        Canvas.MoveTo(piEnd + r.Left, r.Top);
                        Canvas.LineTo(piEnd + r.Left, rgroup.Bottom);
                      end;
                    end;
                  end;
                end;
                xgltwrap:
                begin
                  if (xGroup.StartIndex - fv) * Chart.XScale >= 0 then
                  begin
                    if horz then
                    begin
                      if Top then
                      begin
                        Canvas.MoveTo(rgroup.Right - grouph div 2 - 15, piStart + r.Top);
                        Canvas.LineTo(rgroup.Right - grouph div 2, piStart + r.Top);
                      end
                      else
                      begin
                        Canvas.MoveTo(rgroup.Right - grouph div 2 + 15, piStart + r.Top);
                        Canvas.LineTo(rgroup.Right - grouph div 2, piStart + r.Top);
                      end;
                    end
                    else
                    begin
                      if Top then
                      begin
                        Canvas.MoveTo(piStart + r.Left, rgroup.Bottom - grouph div 2 + 10);
                        Canvas.LineTo(piStart + r.Left, rgroup.Bottom - grouph div 2);
                      end
                      else
                      begin
                        Canvas.MoveTo(piStart + r.Left, rgroup.Bottom - grouph div 2 - 10);
                        Canvas.LineTo(piStart + r.Left, rgroup.Bottom - grouph div 2);
                      end;
                    end;
                  end;

                  if piend - pistart > groupw + 20 then
                  begin
                    if horz then
                    begin
                      Canvas.MoveTo(rgroup.Right - grouph div 2, piStart + r.Top);
                      Canvas.LineTo(rgroup.Right - grouph div 2, piStart + r.Top - 4 + (piend - pistart) div 2 - groupw div 2);
                      Canvas.MoveTo(rgroup.Left, piStart + r.Top - 4 + (piend - pistart) div 2 - groupw div 2);
                      Canvas.LineTo(rgroup.Right, piStart + r.Top - 4 + (piend - pistart) div 2 - groupw div 2);
                    end
                    else
                    begin
                      Canvas.MoveTo(piStart + r.Left, rgroup.Bottom - grouph div 2);
                      Canvas.LineTo(piStart + r.Left - 4 + (piend - pistart) div 2 - groupw div 2 , rgroup.Bottom - grouph div 2);
                      Canvas.MoveTo(piStart + r.Left - 4 + (piend - pistart) div 2 - groupw div 2 , rgroup.Top);
                      Canvas.LineTo(piStart + r.Left - 4 + (piend - pistart) div 2 - groupw div 2 , rgroup.Bottom - 1);
                    end;
                  end;

                  if horz then
                  begin
                    if (xGroup.EndIndex - fv) * Chart.XScale <= r.Bottom - r.Top then
                    begin
                      if Top then
                      begin
                        Canvas.MoveTo(rgroup.Right - grouph div 2 - 15, piEnd + r.Top);
                        Canvas.LineTo(rgroup.Right - grouph div 2, piEnd + r.Top);
                      end
                      else
                      begin
                        Canvas.MoveTo(rgroup.Right - grouph div 2 + 15, piEnd + r.Top);
                        Canvas.LineTo(rgroup.Right - grouph div 2, piEnd + r.Top);
                      end;
                    end
                  end
                  else
                  begin
                    if (xGroup.EndIndex - fv) * Chart.XScale <= r.Right - r.Left + 1 then
                    begin
                      if Top then
                      begin
                        Canvas.MoveTo(piEnd + r.Left, rgroup.Bottom - grouph div 2 + 10);
                        Canvas.LineTo(piEnd + r.Left, rgroup.Bottom - grouph div 2);
                      end
                      else
                      begin
                        Canvas.MoveTo(piEnd + r.Left, rgroup.Bottom - grouph div 2 - 10);
                        Canvas.LineTo(piEnd + r.Left, rgroup.Bottom - grouph div 2);
                      end;
                    end;
                  end;

                  if piend - pistart > groupw + 20 then
                  begin
                    if horz then
                    begin
                      Canvas.MoveTo(rgroup.Right - grouph div 2, piEnd + r.Top);
                      Canvas.LineTo(rgroup.Right - grouph div 2, piEnd + r.Top + 4 - (piend - pistart) div 2 + groupw div 2);
                      Canvas.MoveTo(rgroup.Left, piEnd + r.Top + 4 - (piend - pistart) div 2 + groupw div 2);
                      Canvas.LineTo(rgroup.Right, piEnd + r.Top + 4 - (piend - pistart) div 2 + groupw div 2);
                    end
                    else
                    begin
                      Canvas.MoveTo(piEnd + r.Left, rgroup.Bottom - grouph div 2);
                      Canvas.LineTo(piEnd + r.Left + 4 - (piend - pistart) div 2 + groupw div 2 , rgroup.Bottom - grouph div 2);
                      Canvas.MoveTo(piEnd + r.Left + 4 - (piend - pistart) div 2 + groupw div 2 , rgroup.Top);
                      Canvas.LineTo(piEnd + r.Left + 4 - (piend - pistart) div 2 + groupw div 2 , rgroup.Bottom - 1);
                    end;
                  end;
                end;
                xgltCustom:
                begin
                  if Assigned(Chart.FOnSerieXAxisGroup) then
                    Chart.FOnSerieXAxisGroup(Chart, -1, Index, G, Canvas, rgroup, DoDrawText);
                end;
              end;

              if DoDrawText then
              begin
                twStr := Canvas.TextWidth('...');
                if horz then
                begin
                  tf := TFont.Create;
                  tf.Assign(xgroup.Font);
                  GetObject(tf.Handle, SizeOf(lf), @lf);
                  if Top then
                  begin
                    lf.lfEscapement := -900;
                    lf.lfOrientation := -900;
                  end
                  else
                  begin
                    lf.lfEscapement := 900;
                    lf.lfOrientation := 900;
                  end;
                  tf.Handle := CreateFontIndirectW(lf);
                  Canvas.Font.Assign(tf);
                  tf.Free;

                  if top then
                  begin
                    if groupw < rgroup.Bottom - rgroup.Top then
                      Canvas.TextOut(rgroup.Left + grouph div 2 + (rgroup.Right - rgroup.Left) div 2 + (rgroup.Right - rgroup.Left - grouph) div 2, rgroup.Top + ((rgroup.Bottom - rgroup.Top) - groupw) div 2, xgroup.Caption)
                    else
                      Canvas.TextOut(rgroup.Left + grouph div 2 + (rgroup.Right - rgroup.Left) div 2 + (rgroup.Right - rgroup.Left - grouph) div 2, rgroup.Top + ((rgroup.Bottom - rgroup.Top) - twStr) div 2, '...');
                  end
                  else
                  begin
                    if groupw < rgroup.Bottom - rgroup.Top then
                      Canvas.TextOut(rgroup.Left + grouph div 2 - (rgroup.Right - rgroup.Left) div 2 + (rgroup.Right - rgroup.Left - grouph) div 2, rgroup.Top + groupw + ((rgroup.Bottom - rgroup.Top) - groupw) div 2, xgroup.Caption)
                    else
                      Canvas.TextOut(rgroup.Left + grouph div 2 - (rgroup.Right - rgroup.Left) div 2 + (rgroup.Right - rgroup.Left - grouph) div 2, rgroup.Top + twstr + ((rgroup.Bottom - rgroup.Top) - twStr) div 2, '...');
                  end;
                 end
                else
                begin
                  DrawText(Canvas.Handle, pChar(xGroup.Caption), length(xGroup.Caption), rgroup,
                     DT_CENTER or DT_VCENTER or DT_END_ELLIPSIS);
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TChartSerie.DrawTotalGrid(Canvas: TCanvas; R: TRect; Center: TPoint; ScaleX,
  ScaleY: Double);
var
  htpane, httext: integer;
  mu, mi: double;
  min, max: Double;
  yg: TChartYGrid;
  y: TChartSerieYAxis;
  ys: Double;
begin
  min := 0;
  max := MaximumValue;
  YG := (Collection as TChartSeries).FOwner.YGrid;
  Y := YAxis;
  if max > 0 then
    Ys := (R.Bottom - R.Top) / 2 / (max - min)
  else
    ys := 1;

  if ((Collection as TChartSeries).FOwner.YAxis.FAutoUnits) or YAxis.AutoUnits then
  begin
    htpane := (R.Bottom - R.Top) div 2;

    Canvas.Font.Assign(y.MajorFont);
    httext := Canvas.TextHeight('gh');
    mu := MinMaxToUnit(min, max, Round(htpane / (2 * httext)));

    Canvas.Font.Assign(y.MinorFont);
    httext := Canvas.TextHeight('gh');
    mi := MinMaxToUnit(min, max, Round(htpane / (2 * httext)));

  end
  else
  begin
    mu := YG.MajorDistance;
    mi := YG.MinorDistance;
  end;

  DrawGridCircles(Canvas, center, R, YG, mu, mi, ys, ScaleX, ScaleY);
end;

procedure TChartSerie.DrawTotalGridValues(Canvas: TCanvas; R: TRect;
  Center: TPoint; ScaleX, ScaleY: Double);
var
  htpane, httext: integer;
  mu, mi: double;
  min, max: Double;
  y: TChartSerieYAxis;
  ys: Double;
begin
  min := 0;
  max := MaximumValue;
  Y := YAxis;
  if max > 0 then
    Ys := (R.Bottom - R.Top) / 2 / (max - min)
  else
    ys := 1;

  if ((Collection as TChartSeries).FOwner.YAxis.FAutoUnits) or YAxis.AutoUnits then
  begin
    htpane := (R.Bottom - R.Top) div 2;

    Canvas.Font.Assign(y.MajorFont);
    httext := Canvas.TextHeight('gh');
    mu := MinMaxToUnit(min, max, Round(htpane / (2 * httext)));

    Canvas.Font.Assign(y.MinorFont);
    httext := Canvas.TextHeight('gh');
    mi := MinMaxToUnit(min, max, Round(htpane / (2 * httext)));
  end
  else
  begin
    mu := Y.MajorUnit;
    mi := Y.MinorUnit;
  end;

  DrawGridValues(Canvas, center, R, Y, mu, mi, ys, ScaleX, ScaleY);
end;

procedure TChartSerie.DrawYValues(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double);
var
  jmax, jmin: double;
  jminstr, jmaxstr: string;
  lf : TLogFontW;
  tf: TFont;
  th: integer;
  domaj, domin, domajv, dominv: boolean;
  htpane, httext: integer;
  mu, mi: double;
  min, max: Double;
  y: TChartSerieYAxis;
  majsl, minsl, majsr, minsr: integer;
  txth: integer;
  txtw: integer;
  tl, tr: TChartXYAxisText;
  ARect: TRect;
  defaultdraw: boolean;
  j: Double;
  dopiegrid: Boolean;
  psz: integer;
  pbr: TRect;
  ptcenter: TPoint;
  centerh, centerv: integer;
  sz: Integer;
  center: TPoint;
  dm: Boolean;
  s: String;
  k: integer;
  compareval: Boolean;
begin
  dm := Chart.Series.IsHorizontal;
  dopiegrid := false;
  if (ChartType = ctSpider) or (ChartType = ctHalfSpider) or
    (ChartType = ctSizedPie) or (ChartType = ctSizedHalfPie) or (ChartType = ctSizedDonut) or (ChartType = ctSizedHalfDonut) or
      (ChartType = ctVarRadiusPie) or (ChartType = ctVarRadiusHalfPie) or (ChartType = ctVarRadiusDonut) or (ChartType = ctVarRadiusHalfDonut) then
      dopiegrid := true;

  if dopiegrid then
  begin
    psz := (Pie.GetPieSize div 2) * Round(ScaleX);
    pbr := GetPieRectangle(Index, Chart.Series.SeriesRectangle);
    ptcenter := GetPieCenter(pbr);
    centerh := ptCenter.X;
    centerv := ptCenter.Y;
    center := Point(centerh, centerv);
    DrawTotalGridValues(Canvas, Bounds(center.X - psz, center.Y - psz, psz * 2, psz * 2), center, ScaleX, ScaleY);
  end
  else
  begin
    min := MinimumValue;
    max := MaximumValue;

    Y := YAxis;

    if ((Collection as TChartSeries).FOwner.YAxis.FAutoUnits) or YAxis.AutoUnits then
    begin
      if dm then
      begin
        htpane := R.Right - R.Left;

        Canvas.Font.Assign(y.MajorFont);
        httext := Canvas.TextWidth('WW') + 4;
        mu := MinMaxToUnit(min, max, Round(htpane / (2 * httext)));

        Canvas.Font.Assign(y.MinorFont);
        httext := Canvas.TextWidth('WW') + 4;
        mi := MinMaxToUnit(min, max, Round(htpane / (2 * httext)));
      end
      else
      begin
        htpane := R.Bottom - R.Top;

        Canvas.Font.Assign(y.MajorFont);
        httext := Canvas.TextHeight('gh') + 4;
        mu := MinMaxToUnit(min, max, Round(htpane / (2 * httext)));

        Canvas.Font.Assign(y.MinorFont);
        httext := Canvas.TextHeight('gh') + 4;
        mi := MinMaxToUnit(min, max, Round(htpane / (2 * httext)));
      end;
    end
    else
    begin
      mu := Y.MajorUnit;
      mi := Y.MinorUnit;

      {
      if not Logarithmic then
      begin
        d := Frac(mu);
        if d > 0 then
        begin
          while d < 1 do
            d := d * 10;
        end;

        if (Length(inttostr(Round(mu))) - Length(IntToStr(Round(d))) < Length(inttostr(Round(max - min))) - 1) then
        begin
          while (Length(inttostr(Round(mu))) - Length(IntToStr(Round(d))) < Length(inttostr(Round(max - min)))) do
          begin
            mu := mu * 10;
            d := Frac(mu);
            if d > 0 then
            begin
              while d < 1 do
                d := d * 10;
            end;
          end;
        end;
        d := Frac(mi);
        if d > 0 then
        begin
          while d < 1 do
            d := d * 10;
        end;
        if (Length(inttostr(Round(mi))) - Length(IntToStr(Round(d))) < Length(inttostr(Round(mu))) - 2) then
        begin
          while (Length(inttostr(Round(mi))) - Length(IntToStr(Round(d))) < Length(inttostr(Round(mi))) - 1) do
          begin
            mi := mi * 10;
            d := Frac(mi);
            if d > 0 then
            begin
              while d < 1 do
                d := d * 10;
            end;
          end;
        end;
      end;
      }
    end;

    if Logarithmic then
      mu := 1;

    k := 0;
    if Y.Visible then
    begin
      tf := nil;
      JMax := min;
      JMin := min;
      if Chart.YAxis.AutoSize then
      begin
        majsl := GetYMajorUnitSpacing(False);
        minsl := GetYMinorUnitSpacing(False);
        majsr := GetYMajorUnitSpacing(True);
        minsr := GetYMajorUnitSpacing(True);
      end
      else
      begin
        majsl := Round(y.MajorUnitSpacing * ScaleY);
        minsl := Round(y.MinorUnitSpacing * ScaleY);
        majsr := majsl;
        minsr := minsl;
      end;
  //    ex := false;

      // calculate first value to display

      domaj := (mu > 0);
      domin := (mi > 0);

      if domin then
        Jmin := Round(min / mi)  * mi;

      if domaj then
        Jmax := Round(min / mu)  * mu;

      Canvas.Brush.Style := bsClear;

      //Y - Values

      if (domaj) then
      begin
        while (JMin <= max + mu) do
        begin
          domajv := JMax <= max + mu;
          if domajv then
          begin
            Canvas.Font.Assign(y.FMajorFont);

            if Logarithmic then
            begin
              if (JMax <= LOGARITHMICMAX) and (JMax >= -LOGARITHMICMAX) then
              begin
                if FValueFormat <> '' then
                begin
                  case ValueFormatType of
                    vftNormal: s := Format(FValueFormat,[Power(10, Jmax)]);
                    vftFloat: s := FormatFloat(FValueFormat,Power(10, Jmax));
                  end;
                end
                else
                  s := FloatToStr(Power(10, Jmax));
              end;
            end
            else
            begin
              if FValueFormat <> '' then
              begin
                case ValueFormatType of
                  vftNormal: s := Format(FValueFormat,[Jmax]);
                  vftFloat: s := FormatFloat(FValueFormat,Jmax);
                end;
              end
              else
                s := FloatToStr(JMax);
            end;

            if dm then
              th := Canvas.TextWidth(s)
            else
              th := Canvas.TextHeight('gh');

            defaultdraw := true;

            if (y.Position in [yLeft,yBoth]) then
            begin
              if dm then
              begin
                ARect.Top := 0;
                ARect.Left := ValueToY(JMax, Chart.Series.SeriesRectangle) - (th div 2);
                ARect.Right := ARect.Left + th;
                ARect.Bottom := r.Top;
              end
              else
              begin
                ARect.Left := 0;
                ARect.Top := ValueToY(JMax, Chart.Series.SeriesRectangle) - (th div 2);
                ARect.Bottom := ARect.Top + th;
                ARect.Right := r.Left;
              end;

              defaultdraw := true;

              if Assigned(FOnYAxisDrawValue) then
                FOnYAxisDrawValue(Self, Self, Canvas, ARect, JMax, true, defaultdraw);
            end;

            if (y.Position in [yRight,yBoth]) then
            begin
              if dm then
              begin
                ARect.Top := R.Bottom;
                ARect.Left := ValueToY(JMax, Chart.Series.SeriesRectangle) - (th div 2);
                ARect.Right := ARect.Left + th;
                ARect.Bottom := ARect.Top + Round(Chart.FYAxis.RightSize * ScaleX);
              end
              else
              begin
                ARect.Left := R.Right;
                ARect.Top := ValueToY(JMax, Chart.Series.SeriesRectangle) - (th div 2);
                ARect.Bottom := ARect.Top + th;
                ARect.Right := ARect.Left + Round(Chart.FYAxis.RightSize * ScaleX);
              end;

              defaultdraw := true;

              if Assigned(FOnYAxisDrawValue) then
                FOnYAxisDrawValue(Self, Self, Canvas, ARect, JMax, true, defaultdraw);
            end;

            if (defaultdraw) then
            begin
              JMaxStr := s;
              if Assigned(OnYAxisGetValue) then
                OnYAxisGetValue(Self,Self, JMax, JMaxStr);

              if y.MajorUnitVisible then
              begin
                if dm then
                begin
                  if (ValueToY(JMax, Chart.Series.SeriesRectangle) >= R.Left) and (ValueToY(jmax, Chart.Series.SeriesRectangle) <= R.Right) then
                  begin
                    case y.FPosition of
                      yLeft: Canvas.TextOut(ValueToY(JMax, Chart.Series.SeriesRectangle) - (th div 2), R.Top -  majsl - Canvas.TextHeight(JMaxStr) - Round(y.TickMarkSize * ScaleX), JMaxStr);
                      yRight: Canvas.TextOut(ValueToY(JMax, Chart.Series.SeriesRectangle) - (th div 2) ,R.Bottom + majsr + Round(y.TickMarkSize * ScaleX),  JMaxStr);
                      yBoth:
                      begin
                        Canvas.TextOut(ValueToY(JMax, Chart.Series.SeriesRectangle) - (th div 2), R.Top -  majsl - Canvas.TextHeight(JMaxStr) - Round(y.TickMarkSize * ScaleX), JMaxStr);
                        Canvas.TextOut(ValueToY(JMax, Chart.Series.SeriesRectangle) - (th div 2) ,R.Bottom + majsr + Round(y.TickMarkSize * ScaleX),  JMaxStr);
                      end;
                    end;
                  end;
                end
                else
                begin
                  if (ValueToY(JMax, Chart.Series.SeriesRectangle) <= R.Bottom) and (ValueToY(jmax, Chart.Series.SeriesRectangle) >= R.Top) then
                  begin
                    case y.FPosition of
                      yLeft: Canvas.TextOut(R.Left -  majsl - Canvas.TextWidth(JMaxStr) - Round(y.TickMarkSize * ScaleX), ValueToY(JMax, Chart.Series.SeriesRectangle) - (th div 2), JMaxStr);
                      yRight: Canvas.TextOut(R.Right + majsr + Round(y.TickMarkSize * ScaleX), ValueToY(JMax, Chart.Series.SeriesRectangle) - (th div 2) , JMaxStr);
                      yBoth:
                      begin
                        Canvas.TextOut(R.Left - majsl - Canvas.TextWidth(JMaxStr) - Round(y.TickMarkSize * Scalex) , ValueToY(JMax, Chart.Series.SeriesRectangle) - (th div 2),JMaxStr);
                        Canvas.TextOut(R.Right + majsr + Round(y.TickMarkSize * ScaleX), ValueToY(JMax, Chart.Series.SeriesRectangle) - (th div 2) , JMaxStr);
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end;

          if defaultdraw then
          begin
            Canvas.Pen.Color := y.TickMarkColor;
            Canvas.Pen.Width := Round(y.TickMarkWidth * Scaley);
            Canvas.Pen.Style := psSolid;
            if dm then
            begin
              if (ValueToY(JMax, Chart.Series.SeriesRectangle) >= R.Left) and (ValueToY(jmax, Chart.Series.SeriesRectangle) <= R.Right) then
              begin
                case y.Position of
                  yLeft:
                  begin
                    Canvas.MoveTo(ValueToY(JMax, Chart.Series.SeriesRectangle), R.Top - Round(y.TickMarkSize * ScaleX));
                    Canvas.LineTo(ValueToY(JMax, Chart.Series.SeriesRectangle), R.Top);
                  end;
                  yRight:
                  begin
                    Canvas.MoveTo(ValueToY(JMax, Chart.Series.SeriesRectangle), R.Bottom);
                    Canvas.LineTo(ValueToY(JMax, Chart.Series.SeriesRectangle), R.Bottom + Round(y.TickMarkSize * ScaleX));
                  end;
                  yBoth:
                  begin
                    Canvas.MoveTo(ValueToY(JMax, Chart.Series.SeriesRectangle), R.Top - Round(y.TickMarkSize * ScaleX));
                    Canvas.LineTo(ValueToY(JMax, Chart.Series.SeriesRectangle), R.Top);
                    Canvas.MoveTo(ValueToY(JMax, Chart.Series.SeriesRectangle), R.Bottom);
                    Canvas.LineTo(ValueToY(JMax, Chart.Series.SeriesRectangle), R.Bottom + Round(y.TickMarkSize * ScaleX));
                  end;
                  yNone: ;
                end;
              end;
            end
            else
            begin
              if (ValueToY(JMax, Chart.Series.SeriesRectangle) <= R.Bottom) and (ValueToY(jmax, Chart.Series.SeriesRectangle) >= R.Top) then
              begin
                case y.Position of
                  yLeft:
                  begin
                    Canvas.MoveTo(R.Left - Round(y.TickMarkSize * ScaleX) ,ValueToY(JMax, Chart.Series.SeriesRectangle));
                    Canvas.LineTo(R.Left ,ValueToY(JMax, Chart.Series.SeriesRectangle));
                  end;
                  yRight:
                  begin
                    Canvas.MoveTo(R.Right,ValueToY(JMax, Chart.Series.SeriesRectangle));
                    Canvas.LineTo(R.Right + Round(y.TickMarkSize * ScaleX),ValueToY(JMax, Chart.Series.SeriesRectangle));
                  end;
                  yBoth:
                  begin
                    Canvas.MoveTo(R.Left - Round(y.TickMarkSize * ScaleX) ,ValueToY(JMax, Chart.Series.SeriesRectangle));
                    Canvas.LineTo(R.Left ,ValueToY(JMax, Chart.Series.SeriesRectangle));
                    Canvas.MoveTo(R.Right, ValueToY(JMax, Chart.Series.SeriesRectangle));
                    Canvas.LineTo(R.Right + Round(y.TickMarkSize * ScaleX),ValueToY(JMax, Chart.Series.SeriesRectangle));
                  end;
                  yNone: ;
                end;
              end;
            end;
          end;

          dominv := JMin <= max + mu;
          if dominv and domin then
          begin
            while (JMin <> JMax) and (JMax > jmin) do
            begin
              if Logarithmic then
              begin
                j := JMin - (K - 1);
                if (K <= LOGARITHMICMAX) and (K >= -LOGARITHMICMAX) then
                  j := j * Power(10, K);

                if FValueFormat <> '' then
                begin
                  case ValueFormatType of
                    vftNormal: s := Format(FValueFormat,[j]);
                    vftFloat: s := FormatFloat(FValueFormat,j);
                  end;
                end
                else
                  s := floattostr(j);

                j := ConvertToLog(j);
              end
              else
              begin
                j := Jmin;
                if FValueFormat <> '' then
                begin
                  case ValueFormatType of
                    vftNormal: s := Format(FValueFormat,[j]);
                    vftFloat: s := FormatFloat(FValueFormat,j);
                  end;
                end
                else
                  s := floattostr(j);
              end;
              Canvas.Font.Assign(y.MinorFont);
              if dm then
                th := Canvas.TextWidth(s)
              else
                th := Canvas.TextHeight('gh');

              defaultdraw := true;

              if (y.Position in [yLeft,yBoth]) then
              begin
                if dm then
                begin
                  ARect.Top := 0;
                  ARect.Left := ValueToY(j, Chart.Series.SeriesRectangle) - (th div 2);
                  ARect.Right := ARect.Left + th;
                  ARect.Bottom := r.Top;
                end
                else
                begin
                  ARect.Left := 0;
                  ARect.Top := ValueToY(j, Chart.Series.SeriesRectangle) - (th div 2);
                  ARect.Bottom := ARect.Top + th;
                  ARect.Right := r.Left;
                end;

                defaultdraw := true;

                if Assigned(FOnYAxisDrawValue) then
                  FOnYAxisDrawValue(Self, Self, Canvas, ARect, j, true, defaultdraw);
              end;

              if (y.Position in [yRight,yBoth]) then
              begin
                if dm then
                begin
                  ARect.Top := R.Bottom;
                  ARect.Left := ValueToY(j, Chart.Series.SeriesRectangle) - (th div 2);
                  ARect.Right := ARect.Left + th;
                  ARect.Left := ARect.Right + Round(Chart.FYAxis.LeftSize * ScaleX);
                end
                else
                begin
                  ARect.Left := R.Right;
                  ARect.Top := ValueToY(j, Chart.Series.SeriesRectangle) - (th div 2);
                  ARect.Bottom := ARect.Top + th;
                  ARect.Right := ARect.Left + Round(Chart.FYAxis.RightSize * ScaleX);
                end;
                defaultdraw := true;

                if Assigned(FOnYAxisDrawValue) then
                  FOnYAxisDrawValue(Self, Self, Canvas, ARect, j, true, defaultdraw);
              end;

              compareval := false;
              if Logarithmic and (JMax <= LOGARITHMICMAX) and (JMax >= -LOGARITHMICMAX) then
                compareval := (CompareValue(Round((JMin - (JMax - 1)) * Power(10, JMax)), Round(Power(10, JMax - 1))) = 0);

              if not Logarithmic or (Logarithmic and not compareval) then
              begin
                if (defaultdraw) and (Jmin <> JMax) then
                begin
                  JMinstr := s;
                  if Assigned(OnYAxisGetValue) then
                    OnYAxisGetValue(Self, Self, j, JMinStr);

                  if y.MinorUnitVisible then
                  begin
                    if dm then
                    begin
                      if (ValueToY(j, Chart.Series.SeriesRectangle) >= R.Left) and (ValueToY(j, Chart.Series.SeriesRectangle) <= R.Right) then
                      begin
                        case y.FPosition of
                          yLeft: Canvas.TextOut(ValueToY(j, Chart.Series.SeriesRectangle) - (th div 2), R.Top -  minsl - Canvas.TextHeight(JMinStr) - Round(y.TickMarkSizeMinor * ScaleX), jminstr);
                          yRight: Canvas.TextOut(ValueToY(j, Chart.Series.SeriesRectangle) - (th div 2),R.Bottom + minsr + Round(y.TickMarkSizeMinor * ScaleX) , JMinStr);
                          yBoth:
                          begin
                            Canvas.TextOut(ValueToY(j, Chart.Series.SeriesRectangle) - (th div 2), R.Top -  minsl - Canvas.TextHeight(JMinStr) - Round(y.TickMarkSizeMinor * ScaleX), jminstr);
                            Canvas.TextOut(ValueToY(j, Chart.Series.SeriesRectangle) - (th div 2) , R.Bottom + minsr + Round(y.TickMarkSizeMinor * ScaleX), JMinStr);
                          end;
                          yNone: ;
                        end;
                      end;
                    end
                    else
                    begin
                      if (ValueToY(j, Chart.Series.SeriesRectangle) <= R.Bottom) and (ValueToY(j, Chart.Series.SeriesRectangle) >= R.Top) then
                      begin
                        case y.FPosition of
                          yLeft: Canvas.TextOut(R.Left -  minsl - Canvas.TextWidth(JMinStr) - Round(y.TickMarkSizeMinor * ScaleX),ValueToY(j, Chart.Series.SeriesRectangle) - (th div 2), jminstr);
                          yRight: Canvas.TextOut(R.Right + minsr + Round(y.TickMarkSizeMinor * ScaleX), ValueToY(j, Chart.Series.SeriesRectangle) - (th div 2) , JMinStr);
                          yBoth:
                          begin
                            Canvas.TextOut(R.Left -  minsl - Canvas.TextWidth(JMinStr) - Round(y.TickMarkSizeMinor * ScaleX),ValueToY(j, Chart.Series.SeriesRectangle) - (th div 2), jminstr);
                            Canvas.TextOut(R.Right + minsr + Round(y.TickMarkSizeMinor * ScaleX), ValueToY(j, Chart.Series.SeriesRectangle) - (th div 2) , JMinStr);
                          end;
                          yNone: ;
                        end;
                      end;
                    end;
                  end;
                end;

                if defaultdraw then
                begin
                  Canvas.Pen.Color := y.TickMarkColor;
                  Canvas.Pen.Width := Round(y.TickMarkWidth * Scaley);
                  if dm then
                  begin
                    if (ValueToY(j, Chart.Series.SeriesRectangle) >= R.Left) and (ValueToY(j, Chart.Series.SeriesRectangle) <= R.Right) then
                    begin
                      case y.Position of
                        yLeft:
                        begin
                          Canvas.MoveTo(ValueToY(j, Chart.Series.SeriesRectangle), R.Top - Round(y.TickMarkSizeMinor * ScaleX));
                          Canvas.LineTo(ValueToY(j, Chart.Series.SeriesRectangle), R.Top);
                        end;
                        yRight:
                        begin
                          Canvas.MoveTo(ValueToY(j, Chart.Series.SeriesRectangle), R.Bottom);
                          Canvas.LineTo(ValueToY(j, Chart.Series.SeriesRectangle), R.Bottom + Round(y.TickMarkSizeMinor * ScaleX));
                        end;
                        yBoth:
                        begin
                          Canvas.MoveTo(ValueToY(j, Chart.Series.SeriesRectangle), R.Top - Round(y.TickMarkSizeMinor * ScaleX));
                          Canvas.LineTo(ValueToY(j, Chart.Series.SeriesRectangle), R.Top);
                          Canvas.MoveTo(ValueToY(j, Chart.Series.SeriesRectangle), R.Bottom);
                          Canvas.LineTo(ValueToY(j, Chart.Series.SeriesRectangle), R.Bottom + Round(y.TickMarkSizeMinor * ScaleX));
                        end;
                        yNone: ;
                      end;
                    end;
                  end
                  else
                  begin
                    if (ValueToY(j, Chart.Series.SeriesRectangle) <= R.Bottom) and (ValueToY(j, Chart.Series.SeriesRectangle) >= R.Top) then
                    begin
                      case y.Position of
                        yLeft:
                        begin
                          Canvas.MoveTo(R.Left - Round(y.TickMarkSizeMinor * ScaleX) ,ValueToY(j, Chart.Series.SeriesRectangle));
                          Canvas.LineTo(R.Left ,ValueToY(j, Chart.Series.SeriesRectangle));
                        end;
                        yRight:
                        begin
                          Canvas.MoveTo(R.Right,ValueToY(j, Chart.Series.SeriesRectangle));
                          Canvas.LineTo(R.Right + Round(y.TickMarkSizeMinor * ScaleX),ValueToY(j, Chart.Series.SeriesRectangle));
                        end;
                        yBoth:
                        begin
                          Canvas.MoveTo(R.Left - Round(y.TickMarkSizeMinor * ScaleX) ,ValueToY(j, Chart.Series.SeriesRectangle));
                          Canvas.LineTo(R.Left ,ValueToY(j, Chart.Series.SeriesRectangle));
                          Canvas.MoveTo(R.Right, ValueToY(j, Chart.Series.SeriesRectangle));
                          Canvas.LineTo(R.Right + Round(y.TickMarkSizeMinor * ScaleX),ValueToY(j, Chart.Series.SeriesRectangle));
                        end;
                        yNone: ;
                      end;
                    end;
                  end;
                end;
              end;

              JMin := JMin + mi;

              if CompareValue(Jmin, Jmax) = 0 then
                JMin := JMin + mi;
            end;
          end;

          if not domin then
          begin
            JMin := JMin + mu;
          end
          else
          begin
            if CompareValue(Jmin, Jmax) = 0 then
            begin
              JMin := JMin + mi;
            end;
          end;

          Jmax := JMax + mu;
          Inc(K);
          if (JMax > max + mu) then
            break;
        end;
      end;

      if (y.TextLeft.Text <> '') then
      begin
        try
          sz := GetYMajorUnitSpacing(False) + GetYValuesSize(R, Canvas, ScaleX, ScaleY) + 4;
          tl := y.TextLeft;
          txth := Canvas.TextHeight(tl.Text);
          txtw := Canvas.TextWidth(tl.Text);

          tf := TFont.Create;
          tf.Assign(y.TextLeft.FFont);
          GetObject(tf.Handle, SizeOf(lf), @lf);

          if dm then
            lf.lfEscapement := 0
          else
            lf.lfEscapement := 900;
          lf.lfOrientation := lf.lfEscapement;
          tf.Handle := CreateFontIndirectW(lf);
          Canvas.Font.Assign(tf);

          if dm then
          begin
            case tl.FPosition of
              ctLeft, ctBottom: Canvas.TextOut(R.Left + 3, r.Top - sz  ,tl.FText);
              ctRight, ctTop: Canvas.TextOut(R.Right - 3 - txtw ,R.Top - sz, tl.FText);
              ctCenter: Canvas.TextOut(R.Left + Round((r.Right - r.Left - txtw) / 2),R.Top - sz ,tl.FText);
            end;
          end
          else
          begin
            case tl.FPosition of
              ctLeft, ctBottom: Canvas.TextOut(R.Left - sz, R.Bottom  ,tl.FText);
              ctRight, ctTop: Canvas.TextOut(R.Left - sz, R.Top + txtw ,tl.FText);
              ctCenter: Canvas.TextOut(R.Left - sz,R.Top + Round((r.Bottom - r.Top - txtw) / 2) + txtw ,tl.FText);
            end;
          end;
        finally
          tf.Free;
        end;
      end;

      if (YAxis.TextRight.Text <> '') then
      begin
        try
          sz := GetYMajorUnitSpacing(True) + GetYValuesSize(R, Canvas, ScaleX, ScaleY) + 4;
          tr := y.TextRight;
          txth := Canvas.TextHeight(tr.Text);
          txtw := Canvas.TextWidth(tr.Text);

          tf := TFont.Create;
          tf.Assign(YAxis.TextRight.FFont);
          GetObject(tf.Handle, SizeOf(lf), @lf);
          if dm then
            lf.lfEscapement := 0
          else
            lf.lfEscapement := -900;
          lf.lfOrientation := lf.lfEscapement;
          tf.Handle := CreateFontIndirectW(lf);
          Canvas.Font.Assign(tf);

          if dm then
          begin
            case tr.FPosition of
              ctLeft, ctBottom: Canvas.TextOut(R.Left + 3, r.Bottom + sz - txth  ,tr.FText);
              ctRight, ctTop: Canvas.TextOut(R.Right - 3 - txtw ,r.Bottom +sz- txth, tr.FText);
              ctCenter: Canvas.TextOut(R.Left + Round((r.Right - r.Left - txtw) / 2),r.Bottom +sz- txth,tr.FText);
            end;
          end
          else
          begin
            case tr.Position of
              ctLeft, ctBottom: Canvas.TextOut(R.Right + sz , R.Bottom - txtw,tr.FText);
              ctRight, ctTop: Canvas.TextOut(R.Right + sz, R.Top ,tr.FText);
              ctCenter: Canvas.TextOut(R.Right + sz,R.Top + Round((r.Bottom - r.Top - txtw) / 2),tr.FText);
            end;
          end;
        finally
          tf.Free;
        end;
      end;
    end;
  end;
end;

function TChartSerie.GetYValuesSize(R: TRect; Canvas: TCanvas; ScaleX, ScaleY: Double): Integer;
var
  jmax, jmin: double;
  jminstr, jmaxstr: string;
  domaj, domin, domajv, dominv: boolean;
  htpane, httext: integer;
  mu, mi: double;
  min, max: Double;
  y: TChartSerieYAxis;
  majs, mins: integer;
  txtw: integer;
  tl, tr: TChartXYAxisText;
  j: Double;
  dm: Boolean;
  s: String;
  k: integer;
  compareval: Boolean;
  totalsizeLeft, totalsizeRight: Integer;
begin
  dm := Chart.Series.IsHorizontal;

  min := MinimumValue;
  max := MaximumValue;

  totalsizeleft := 0;
  totalsizeright := 0;

  Y := YAxis;

  if ((Collection as TChartSeries).FOwner.YAxis.FAutoUnits) or YAxis.AutoUnits then
  begin
    if dm then
    begin
      htpane := R.Right - R.Left;

      Canvas.Font.Assign(y.MajorFont);
      httext := Canvas.TextWidth('WW') + 4;
      mu := MinMaxToUnit(min, max, Round(htpane / (2 * httext)));

      Canvas.Font.Assign(y.MinorFont);
      httext := Canvas.TextWidth('WW') + 4;
      mi := MinMaxToUnit(min, max, Round(htpane / (2 * httext)));
    end
    else
    begin
      htpane := R.Bottom - R.Top;

      Canvas.Font.Assign(y.MajorFont);
      httext := Canvas.TextHeight('gh') + 4;
      mu := MinMaxToUnit(min, max, Round(htpane / (2 * httext)));

      Canvas.Font.Assign(y.MinorFont);
      httext := Canvas.TextHeight('gh') + 4;
      mi := MinMaxToUnit(min, max, Round(htpane / (2 * httext)));
    end;
  end
  else
  begin
    mu := Y.MajorUnit;
    mi := Y.MinorUnit;
  end;

  if Logarithmic then
    mu := 1;

  k := 0;
  if Y.Visible then
  begin
    JMax := min;
    JMin := min;
    majs := Round(y.MajorUnitSpacing * ScaleY);
    mins := Round(y.MinorUnitSpacing * ScaleY);
//    ex := false;

    // calculate first value to display

    domaj := (mu > 0);
    domin := (mi > 0);

    if domin then
      Jmin := Round(min / mi)  * mi;

    if domaj then
      Jmax := Round(min / mu)  * mu;

    //Y - Values

    if (domaj) then
    begin
      while (JMin <= max + mu) do
      begin
        domajv := JMax <= max + mu;
        if domajv then
        begin
          Canvas.Font.Assign(y.FMajorFont);

          if Logarithmic then
          begin
            if (JMax <= LOGARITHMICMAX) and (JMax >= -LOGARITHMICMAX) then
            begin
              if FValueFormat <> '' then
              begin
                case ValueFormatType of
                  vftNormal: s := Format(FValueFormat,[Power(10, Jmax)]);
                  vftFloat: s := FormatFloat(FValueFormat,Power(10, Jmax));
                end;
              end
              else
                s := FloatToStr(Power(10, Jmax));
            end;
          end
          else
          begin
            if FValueFormat <> '' then
            begin
              case ValueFormatType of
                vftNormal: s := Format(FValueFormat,[Jmax]);
                vftFloat: s := FormatFloat(FValueFormat,Jmax);
              end;
            end
            else
              s := FloatToStr(JMax);
          end;

//          if (defaultdraw) then
          begin
            JMaxStr := s;
            if Assigned(OnYAxisGetValue) then
              OnYAxisGetValue(Self,Self, JMax, JMaxStr);

            if y.MajorUnitVisible then
            begin
              if dm then
              begin
               // if (ValueToY(JMax, Chart.Series.SeriesRectangle) >= R.Left) and (ValueToY(jmax, Chart.Series.SeriesRectangle) <= R.Right) then
                begin
                  case y.FPosition of
                    yLeft:
                    begin
                      if majs + Canvas.TextHeight(JMaxStr) + Round(y.TickMarkSize * ScaleX) > totalsizeLeft then
                        totalsizeLeft := majs + Canvas.TextHeight(JMaxStr) + Round(y.TickMarkSize * ScaleX);
                    end;
                    yRight:
                    begin
                      if majs + Canvas.TextHeight(JMaxStr) + Round(y.TickMarkSize * ScaleX) > totalsizeRight then
                        totalsizeRight := majs + Canvas.TextHeight(JMaxStr) + Round(y.TickMarkSize * ScaleX);
                    end;
                    yBoth:
                    begin
                      if majs + Canvas.TextHeight(JMaxStr) + Round(y.TickMarkSize * ScaleX) > totalsizeLeft then
                        totalsizeLeft := majs + Canvas.TextHeight(JMaxStr) + Round(y.TickMarkSize * ScaleX);

                      if majs + Canvas.TextHeight(JMaxStr) + Round(y.TickMarkSize * ScaleX) > totalsizeRight then
                        totalsizeRight := majs + Canvas.TextHeight(JMaxStr) + Round(y.TickMarkSize * ScaleX);
                    end;
                  end;
                end;
              end
              else
              begin
               // if (ValueToY(JMax, Chart.Series.SeriesRectangle) <= R.Bottom) and (ValueToY(jmax, Chart.Series.SeriesRectangle) >= R.Top) then
                begin
                  case y.FPosition of
                    yLeft:
                    begin
                      if majs + Canvas.TextWidth(JMaxStr) + Round(y.TickMarkSize * ScaleX) > totalsizeLeft then
                        totalsizeLeft := majs + Canvas.TextWidth(JMaxStr) + Round(y.TickMarkSize * ScaleX);
                    end;
                    yRight:
                    begin
                      if majs + Canvas.TextWidth(JMaxStr) + Round(y.TickMarkSize * ScaleX) > totalsizeRight then
                        totalsizeRight := majs + Canvas.TextWidth(JMaxStr) + Round(y.TickMarkSize * ScaleX);
                    end;
                    yBoth:
                    begin
                      if majs + Canvas.TextWidth(JMaxStr) + Round(y.TickMarkSize * ScaleX) > totalsizeLeft then
                        totalsizeLeft := majs + Canvas.TextWidth(JMaxStr) + Round(y.TickMarkSize * ScaleX);

                      if majs + Canvas.TextWidth(JMaxStr) + Round(y.TickMarkSize * ScaleX) > totalsizeRight then
                        totalsizeRight := majs + Canvas.TextWidth(JMaxStr) + Round(y.TickMarkSize * ScaleX);
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;

        dominv := JMin <= max + mu;
        if dominv and domin then
        begin
          while (JMin <> JMax) and (JMax > jmin) do
          begin
            if Logarithmic then
            begin
              j := JMin - (K - 1);
              if (K <= LOGARITHMICMAX) and (K >= -LOGARITHMICMAX) then
                j := j * Power(10, K);

              if FValueFormat <> '' then
              begin
                case ValueFormatType of
                  vftNormal: s := Format(FValueFormat,[j]);
                  vftFloat: s := FormatFloat(FValueFormat,j);
                end;
              end
              else
                s := floattostr(j);

              j := ConvertToLog(j);
            end
            else
            begin
              j := Jmin;
              if FValueFormat <> '' then
              begin
                case ValueFormatType of
                  vftNormal: s := Format(FValueFormat,[j]);
                  vftFloat: s := FormatFloat(FValueFormat,j);
                end;
              end
              else
                s := floattostr(j);
            end;
            Canvas.Font.Assign(y.MinorFont);

            compareval := false;
            if Logarithmic and (JMax <= LOGARITHMICMAX) and (JMax >= -LOGARITHMICMAX) then
              compareval := (CompareValue(Round((JMin - (JMax - 1)) * Power(10, JMax)), Round(Power(10, JMax - 1))) = 0);

            if not Logarithmic or (Logarithmic and not compareval) then
            begin
              if (Jmin <> JMax) then
              begin
                JMinstr := s;
                if Assigned(OnYAxisGetValue) then
                  OnYAxisGetValue(Self, Self, j, JMinStr);

                if y.MinorUnitVisible then
                begin
                  if dm then
                  begin
                //    if (ValueToY(j, Chart.Series.SeriesRectangle) >= R.Left) and (ValueToY(j, Chart.Series.SeriesRectangle) <= R.Right) then
                    begin
                      case y.FPosition of
                        yLeft:
                        begin
                          if mins + Canvas.TextHeight(JMinStr) + Round(y.TickMarkSizeMinor * ScaleX) > totalsizeLeft then
                            totalsizeLeft := mins + Canvas.TextWidth(JMinStr) + Round(y.TickMarkSizeMinor * ScaleX);
                        end;
                        yRight:
                        begin
                          if mins + Canvas.TextHeight(JMinStr) + Round(y.TickMarkSizeMinor * ScaleX) > totalsizeRight then
                            totalsizeRight := mins + Canvas.TextWidth(JMinStr) + Round(y.TickMarkSizeMinor * ScaleX);
                        end;
                        yBoth:
                        begin
                          if mins + Canvas.TextHeight(JMinStr) + Round(y.TickMarkSizeMinor * ScaleX) > totalsizeLeft then
                            totalsizeLeft := mins + Canvas.TextWidth(JMinStr) + Round(y.TickMarkSizeMinor * ScaleX);

                          if mins + Canvas.TextHeight(JMinStr) + Round(y.TickMarkSizeMinor * ScaleX) > totalsizeRight then
                            totalsizeRight := mins + Canvas.TextWidth(JMinStr) + Round(y.TickMarkSizeMinor * ScaleX);
                        end;
                      end;
                    end;
                  end
                  else
                  begin
              //      if (ValueToY(j, Chart.Series.SeriesRectangle) <= R.Bottom) and (ValueToY(j, Chart.Series.SeriesRectangle) >= R.Top) then
                    begin
                      case y.FPosition of
                        yLeft:
                        begin
                          if mins + Canvas.TextWidth(JMinStr) + Round(y.TickMarkSizeMinor * ScaleX) > totalsizeLeft then
                            totalsizeLeft := mins + Canvas.TextWidth(JMinStr) + Round(y.TickMarkSizeMinor * ScaleX);
                        end;
                        yRight:
                        begin
                          if mins + Canvas.TextWidth(JMinStr) + Round(y.TickMarkSizeMinor * ScaleX) > totalsizeRight then
                            totalsizeRight := mins + Canvas.TextWidth(JMinStr) + Round(y.TickMarkSizeMinor * ScaleX);
                        end;
                        yBoth:
                        begin
                          if mins + Canvas.TextWidth(JMinStr) + Round(y.TickMarkSizeMinor * ScaleX) > totalsizeLeft then
                            totalsizeLeft := mins + Canvas.TextWidth(JMinStr) + Round(y.TickMarkSizeMinor * ScaleX);

                          if mins + Canvas.TextWidth(JMinStr) + Round(y.TickMarkSizeMinor * ScaleX) > totalsizeRight then
                            totalsizeRight := mins + Canvas.TextWidth(JMinStr) + Round(y.TickMarkSizeMinor * ScaleX);
                        end;
                      end;
                    end;
                  end;
                end;
              end;
            end;

            JMin := JMin + mi;

            if CompareValue(Jmin, Jmax) = 0 then
              JMin := JMin + mi;
          end;
        end;

        if not domin then
        begin
          JMin := JMin + mu;
        end
        else
        begin
          if CompareValue(Jmin, Jmax) = 0 then
          begin
            JMin := JMin + mi;
          end;
        end;

        Jmax := JMax + mu;
        Inc(K);
        if (JMax > max + mu) then
          break;
      end;
    end;

    if (y.TextLeft.Text <> '') then
    begin
      tl := y.TextLeft;
      txtw := Canvas.TextHeight(tl.Text);
      totalsizeLeft := totalsizeLeft + txtw;
    end;

    if (y.TextRight.Text <> '') then
    begin
      tr := y.TextRight;
      txtw := Canvas.TextHeight(tr.Text);

      totalsizeRight := totalsizeRight + txtw ;
    end;
  end;

  if totalsizeLeft > totalsizeRight then
    Result := totalsizeLeft
  else
    Result := totalsizeRight;
end;

function TChartSerie.FindXAxisTextForValue(AValue: Double): String;
var
  l, e, m, cnt: Integer;
  fnd: Boolean;
  dif, dif2: Double;
  pt, ptn: TChartPoint;
begin
  Result := '';
  l  := 0;
  cnt := GetPointsCount;
  e := cnt - 1;

  fnd := False;
  while (l <= e) and not fnd do
  begin
    m := (l + e) div 2;
    pt := GetPoint(m);
    ptn := GetPoint(m + 1);

    if (AValue >= pt.SingleXValue) and (m >= cnt) then
    begin
      fnd := True;
      Result := pt.LegendValue;
    end
    else
    if (AValue >= pt.SingleXValue) and ((m + 1 < cnt) and (AValue <= ptn.SingleXValue)) then
    begin
      fnd := True;
      dif := Abs(AValue - pt.SingleXValue);
      dif2 := Abs(AValue - ptn.SingleXValue);
      if dif > dif2 then
        Result := ptn.LegendValue
      else
        Result := pt.LegendValue;
    end
    else if pt.SingleXValue > AValue then
      e := m - 1
    else
      l := m + 1;
  end;
end;

procedure TChartSerie.FontChanged(Sender: TObject);
begin
  Changed;
end;

function TChartSerie.Get3DOffset: integer;
begin
  result := 0;
  if Enable3D then
    result := Offset3D;
end;

function TChartSerie.GetAngle(Text: TChartXYAxisText): integer;
begin
  Result := -10 * Text.Angle;
end;

function TChartSerie.GetChartPoint(Index: integer): TChartPoint;
begin
  if (Index >= 0) and (Index <= GetPointsCount - 1) then
    Result := GetPoint(Index)
  else
    Result.Defined := false;
end;

function TChartSerie.GetChartPointFromDrawPoint(Index: integer): TChartPoint;
var
  rf: Integer;
  Xpos: Integer;
begin
  rf := Chart.Range.RangeFrom;

  if (rf < 0) or ((ChartType = ctXYLine) or (ChartType = ctXYDigitalLine) or (ChartType = ctXYMarkers) or (ChartType = ctGantt))   then
    XPos := Index
  else
    XPos := Index + rf;

  Result := GetChartPoint(Xpos);
end;

function TChartSerie.GetDisplayName: string;
begin
  if Name <> '' then
    Result := Name
  else
    Result := 'TChartSerie'+ inttostr(Index);
end;

function TChartSerie.GetDrawPoint(Index: integer): TPoint;
begin
  if (Length(FDrawPoints) > 0) and (Index >= 0) and (Index <= High(FDrawPoints)) then
  begin
    Result := FDrawPoints[Index];
  end;
end;

function TChartSerie.GetDSFieldNames: TStringList;
begin
  result := TStringList.Create;
end;

function TChartSerie.GetFunnel: TChartSeriePie;
begin
  Result := FPie;
end;

function TChartSerie.GetFunnelRect(pbr: TRect): TRect;
var
  r: TRect;
  w, h: Integer;
begin
  r := pbr;
  w := r.Right - r.Left;
  case FunnelWidthType of
    fstPixels: w := FunnelWidth;
    fstPercentage: w := Round(w * (FunnelWidth / 100));
  end;

  h := r.Bottom - r.Top;
  case FunnelHeightType of
    fstPixels: h := FunnelHeight;
    fstPercentage: h := Round(h * (FunnelHeight / 100));
  end;

  Result := Bounds(pbr.Left + ((pbr.Right - pbr.Left) div 2) - w div 2, pbr.Top + ((pbr.Bottom - pbr.Top) div 2) - h div 2, w, h);

  case Pie.Position of
    spTopLeft:
    begin
      Result.Left := pbr.Left;
      Result.Top := pbr.Top;
    end;
    spTopRight:
    begin
      Result.Top := pbr.Top;
      Result.Left := pbr.Right - (Result.Right - Result.Left);
    end;
    spTopCenter: Result.Top := pbr.Top;
    spBottomLeft:
    begin
      Result.Top := pbr.Bottom - (Result.Bottom - Result.Top);
      Result.Left := pbr.Left;
    end;
    spBottomRight:
    begin
      Result.Top := pbr.Bottom - (Result.Bottom - Result.Top);
      Result.Left := pbr.Right - (Result.Right - Result.Left);
    end;
    spBottomCenter: Result.Top := pbr.Bottom - (Result.Bottom - Result.Top);
    spCenterLeft: Result.Left := pbr.Left;
    spCenterRight: Result.Left := pbr.Right - (Result.Right - Result.Left);
  end;

  Result.Left := Result.Left + Pie.Left;
  Result.Top := Result.Top + Pie.Top;

  Result.Right := Result.Left + w;
  Result.Bottom := Result.Top + h;
end;

function TChartSerie.GetHistogramBarWidth(ScaleX: Double): integer;
var
  dp1, dp2: TPoint;
  bw, pw: integer;
  bcnt: Integer;
  bargroupspc: integer;
begin
  dp1 := GetDrawPoint(0);
  dp2 := GetDrawPoint(1);

  bcnt := Chart.Series.GetCountChartType(ctHistogram);
  bcnt := bcnt + Chart.Series.GetCountChartType(ctLineHistogram);

  if Length(DrawPoints) > 1 then
  begin
    if Chart.Series.IsHorizontal then
      pw := dp2.y - dp1.y
    else
      pw := dp2.x - dp1.x;
  end
  else
    pw := Round(Chart.XScale);

  bargroupspc := 0;
  case Chart.Series.BarChartSpacingType of
    wtPixels: bargroupspc := Chart.Series.BarChartSpacing;
    wtPercentage: bargroupspc := Round(pw * Chart.Series.BarChartSpacing / 100);
  end;

  bw := 0;
  case FValueWidthType of
    wtPixels: bw := Round(FValueWidth * ScaleX);
    wtPercentage: bw := Round((((pw - bargroupspc) / bcnt) * FValueWidth) / 100);
  end;

  if bw < 1 then
    bw := 1;

  Result := bw;
end;

function TChartSerie.GetLastPoint: integer;
begin
  Result := FLastPoint;
end;

function TChartSerie.GetStackedValue(i: integer): Double;
var
  rf, J, K, xpos: integer;
  totalsv: Double;
  total: Double;
begin
  totalsv := 0;
  total := 0;

  rf := Chart.Range.RangeFrom;

  if rf < 0 then
    XPos := I
  else
    XPos := I + rf;

  for K := 0 to Chart.Series.Count - 1 do
    if (Xpos <= Chart.Series[K].GetPointsCount - 1) and (GroupIndex = Chart.Series[k].GroupIndex) then
      total := total + Chart.Series[K].GetPoint(xpos).SingleValue;

  if (Xpos >= 0) and (Xpos < GetPointsCount) then
  begin
    if (Chart.Series.SerieValueTotals) and (ChartType in [ctStackedBar, ctStackedArea, ctStackedPercArea, ctStackedPercBar]) then
    begin
      for J := 0 to Index do
        if  (GroupIndex = Chart.Series[J].GroupIndex) then
          totalsv := totalsv + Chart.Series[J].GetPoint(xpos).SingleValue
    end
    else
      totalsv := GetPoint(xpos).SingleValue;
  end
  else
  begin
    Result := 0;
    Exit;
  end;

  Result := totalsv;
end;

function TChartSerie.GetStackedValueString(i: integer): String;
var
  rf, J, K, xpos: integer;
  totalsv: Double;
  total: Double;
begin
  try
    totalsv := 0;
    total := 0;

    rf := Chart.Range.RangeFrom;

    if (rf < 0) or ((ChartType = ctXYLine) or (ChartType = ctXYDigitalLine) or (ChartType = ctXYMarkers) or (ChartType = ctGantt))   then
      XPos := I
    else
      XPos := I + rf;

    for K := 0 to Chart.Series.Count - 1 do
      if (Xpos <= Chart.Series[K].GetPointsCount - 1) and (GroupIndex = Chart.Series[k].GroupIndex) then
        total := total + Chart.Series[K].GetPoint(xpos).SingleValue;

    if (Xpos >= 0) and (Xpos < GetPointsCount) then
    begin
      if (Chart.Series.SerieValueTotals) and (ChartType in [ctStackedBar, ctStackedArea, ctStackedPercArea, ctStackedPercBar]) then
      begin
        for J := 0 to Index do
        begin
          if GroupIndex = Chart.Series[J].GroupIndex then
            totalsv := totalsv + Chart.Series[J].GetPoint(xpos).SingleValue
        end;
      end
      else
        totalsv := GetPoint(xpos).SingleValue;
    end
    else
    begin
      Result := '';
      Exit;
    end;

    case ValueType of
      cvNone: exit;
      cvNormal:
      begin
        case ValueFormatType of
          vftNormal: Result := Format(FValueFormat, [totalsv]);
          vftFloat: Result := FormatFloat(FValueFormat, totalsv);
        end;
      end;
      cvPercentage:
      begin
        if total <> 0 then
        begin
          case ValueFormatType of
            vftNormal: Result := Format(FValueFormat, [totalsv / total * 100]) + '%';
            vftFloat: Result := FormatFloat(FValueFormat, totalsv / total * 100) + '%';
          end;
        end
        else
          Result := '';
      end;
    end;
  except
    Result := 'NAN';
  end;
end;

function TChartSerie.GetStackedPercValue(sv: Double; i: integer): Double;
var
 K, cnt: Integer;
 suma, sumb, value: Double;
 rf: integer;
begin
  suma := 0;
  sumb := 0;
  value := 0;

  if Chart.Range.RangeFrom < 0 then
    rf := Chart.Range.RangeFrom
  else
    rf := 0;

  cnt := Chart.Series.Count - 1;

  for K := 0 to cnt do
  begin
    if Chart.Series[K].GetPointsCount > I - rf  then
    begin
      with Chart.Series[K].GetPoint(I - rf) do
      begin
        if Defined and (Chart.Series[K].ChartType in [ctStackedPercArea]) then
        begin
          suma := suma + SingleValue;
        end;
        if Defined and (Chart.Series[K].ChartType in [ctStackedPercBar]) and (Chart.Series[k].GroupIndex = GroupIndex) then
        begin
          sumb := sumb + SingleValue;
        end;
      end;
    end;
  end;

  case ChartType of
    ctStackedPercArea, ctStackedArea:
    begin
      if suma = 0 then
      begin
        Result := 0;
        exit;
      end;
      value := (sv / suma) * 100
    end;
    ctStackedPercBar:
    begin
      if sumb = 0 then
      begin
        Result := 0;
        exit;
      end;
      value := (sv / sumb) * 100
    end;
  end;

  Result := value;
end;

function TChartSerie.GetStackedTotal(I: Integer): Double;
var
  K: integer;
  rf: Integer;
begin
  Result := 0;
  if Chart.Range.RangeFrom < 0 then
    rf := Chart.Range.RangeFrom
  else
    rf := 0;

  for K := 0 to Chart.Series.Count - 1 do
  begin
    if Chart.Series[K].GetPointsCount > I - rf  then
    begin
      with Chart.Series[K].GetPoint(I - rf) do
      begin
        if Defined and (Chart.Series[K].ChartType in [ctStackedPercBar]) and (Chart.Series[k].GroupIndex = GroupIndex) then
        begin
          result := result + SingleValue;
        end;
      end;
    end;
  end;
end;

function TChartSerie.GetChart: TAdvChart;
begin
  Result := nil;
  if Assigned(Collection) then
    Result := (Collection as TChartSeries).FOwner;
end;

procedure TChartSerie.DrawPicture(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: double);
var
  xo,yo,yb:integer;
  p: TPicture;
  bw: integer;
begin
  bw := 0;
  if BorderColor <> clNone then
    bw := BorderWidth;

  if not (FChartPattern.Graphic = nil) then
  begin
    p := FChartPattern;
    case FChartPatternPosition of
    bpTopLeft:Canvas.Draw(r.Left,r.Top,p.Graphic);
    bpTopRight:Canvas.Draw(Max(r.Left,r.Right - r.Left - Round(p.Width * ScaleX)),r.top,p.Graphic);
    bpBottomLeft:Canvas.Draw(r.left,Max(r.top,R.Bottom - Round(p.Height * ScaleY)),p.Graphic);
    bpBottomRight:Canvas.Draw(Max(r.Left,r.Right - r.Left - Round(p.Width * Scalex)),Max(r.Top,R.Bottom - Round(p.Height * ScaleY)),p.Graphic);
    bpCenter:Canvas.Draw(Max(r.Left,r.Right - r.Left - Round(p.Width * Scalex)) shr 1,Max(r.Top,R.Bottom - Round(p.Height * ScaleY)) shr 1,p.Graphic);
    bpTiled:begin
              yo := r.Top;
              yb := R.Bottom;

              if yo > r.Bottom then
              begin
                yo := R.Bottom;
                yb := R.Top;
              end;

              yo := yo + bw;
              while (yo < yb) do
              begin
                xo := r.Left + BorderWidth;
                while (xo < R.Right) do
                begin
                  Canvas.Draw(xo,yo,p.Graphic);
                  xo := xo + Round(p.Width * ScaleX);
                end;
                yo := yo + Round(p.Height * ScaleY);
              end;
            end;
    bpStretched:Canvas.StretchDraw(R,p.Graphic);
    else
    end;
  end;
end;

procedure TChartSerie.Init(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double);
begin
  if (FOldRect.Right <> R.Right) or (FOldRect.Bottom <> R.Bottom) or FForceInit then
  begin
    FOldRect := R;
    InitializeDrawPoints(Canvas, R, ScaleX, ScaleY);
    FForceInit := false;
  end;
end;

procedure TChartSerie.InitializeDrawPoints(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double);
var
  I, K, J, M, X: Integer;
  vp: TChartPoint;
  tv: integer;
  xs: Double;
  o: TAdvChart;
  z: integer;
  sv, svx: integer;
  lt, ltpt: integer;
  L: integer;
  cnt,pt: integer;
  tox: integer;
  d, xd, dt, dtto: TDateTime;
  sr: TRect;
  ptr: TChartPoint;
begin

  K := 0;
  X := 0;
  o := (Collection as TChartSeries).FOwner;
  J := o.FRange.FRangeFrom;
  M := o.FRange.FRangeTo;
  xs := o.Xscale;

  SetLength(FDrawPoints, 0);
  SetLength(FDrawValuesDP, 0);
  SetLength(FDrawValuesSlice, 0);
  SetLength(FPointsLineBar, 0);
  SetLength(FStackedRectsBar, 0);
  SetLength(FStackedPointsArea, 0);


  for I := 0 to GetPointsCount - 1 do
  begin
    ptr := GetPoint(I);
    with ptr do
    begin
      xd := ConvertDateToXDate(Chart.Range.StartDate);
      d := GetXTimeStamp(Chart.Range.RangeTo) - xd;
      if (ChartType = ctXYLine) or (ChartType = ctXYDigitalLine) or (ChartType = ctXYMarkers) then
      begin
        if TimeStamp <> 0 then
        begin
          dt := TimeStamp;
          sr := Chart.Series.SeriesRectangle;
          if d > 0 then
            SingleXValue := ((Chart.Range.RangeTo) / d) * (dt - xd)
          else
            SingleXValue := 0;
        end
      end
      else if (ChartType = ctGantt) then
      begin
        if (TimeStamp <> 0) and (TimeXStamp <> 0) then
        begin
          dt := TimeStamp;
          dtto := TimeXStamp;
          sr := Chart.Series.SeriesRectangle;
          if d > 0 then
            SingleValue := ((Chart.Range.RangeTo ) / d) * (dt - xd)
          else
            SingleValue := 0;

          if d > 0 then
            SingleXValue := ((Chart.Range.RangeTo ) / d) * (dtto - xd)
          else
            SingleXValue := 0;
        end
      end;
    end;

    if (I >= 0) and (I <= Length(Points) - 1) then
      Points[I] := ptr;
  end;


  if (M - J >= 0) then
  begin
    I := 0;
    cnt := 0;

    if FLastPoint > M then
      tv := M
    else
      tv := FLastPoint;

    SetLength(FDrawPoints, 0);
    ltpt := GetPointsCount;
    if ChartType = ctBand then
    begin
      for Pt := 0 to ltpt - 1 do
      begin
        vp := GetPoint(Pt);
        if (I >= J) and (I <= tv {+ 1}) then
        begin
          if vp.Defined then
          begin
            SetLength(FDrawPoints, (X + 1) * 2);
            Inc(X);
          end;
        end;
        Inc(I);
      end;
    end;

    tox := x;
    x := 0;

//    if J < 0 then
//      I := J
//    else
      I := 0;

    for Pt := 0 to ltpt - 1 do
    begin
      vp := GetPoint(Pt);
      if ((I >= J) and (I <= tv {+ 1})) or ((ChartType = ctXYLine) or (ChartType = ctXYDigitalLine) or (ChartType = ctXYMarkers) or (ChartType = ctGantt)) then
      begin
        if vp.Defined or (ChartType = ctCandleStick) or (Charttype = ctLine) or (ChartType = ctDigitalLine) or (ChartType = ctXYLine) or (ChartType = ctXYDigitalLine) or (ChartType = ctXYMarkers) or (ChartType = ctGantt) or (ChartType = ctArea) then
        begin
          if ChartType <> ctBand then
            SetLength(FDrawPoints, X + 1);

          if Charttype in [ctStackedPercArea, ctStackedPercBar] then
          begin
            if J < 0 then
              sv := ValueToY(GetStackedPercValue(vp.SingleValue, I + J), R)
            else
              sv := ValueToY(GetStackedPercValue(vp.SingleValue, I), R)
          end
          else
          begin
            if Logarithmic then
              sv := ValueToY(ConvertToLog(vp.SingleValue), R)
            else
              sv := ValueToY(vp.SingleValue, R);
          end;

          if J < 0 then
          begin
            if Chart.Series.IsHorizontal then
            begin
              if (ChartType = ctXYLine) or (ChartType = ctXYDigitalLine) or (ChartType = ctXYMarkers) or (ChartType = ctGantt) then
              begin
                svx := ValueToX(vp.SingleXValue, R);
                if ChartType = ctGantt then
                  sv := ValueToX(vp.SingleValue, R);
              end
              else
                svx := Round(((K - J) * xs) + Chart.GetXScaleStart) + R.Top;

              FDrawPoints[X] := Point(sv, svx);
              if ChartType = ctBand then
                FDrawPoints[(tox * 2) - 1 - X] := Point(ValueToY(vp.SecondValue, R), svx);
            end
            else
            begin
              if (ChartType = ctXYLine) or (ChartType = ctXYDigitalLine) or (ChartType = ctXYMarkers) or (ChartType = ctGantt) then
              begin
                svx := ValueToX(vp.SingleXValue, R);
                if ChartType = ctGantt then
                  sv := ValueToX(vp.SingleValue, R);
              end
              else
                svx := Round(((K - J) * xs) + Chart.GetXScaleStart) + R.Left;

              FDrawPoints[X] := Point(svx, sv);
              if ChartType = ctBand then
                FDrawPoints[(tox * 2) - 1 - X] := Point(svx, ValueToY(vp.SecondValue, R));
            end;
          end
          else
          begin
            if Chart.Series.IsHorizontal then
            begin
              if (ChartType = ctXYLine) or (ChartType = ctXYDigitalLine) or (ChartType = ctXYMarkers) or (ChartType = ctGantt) then
              begin
                svx := ValueToX(vp.SingleXValue, R);
                if ChartType = ctGantt then
                  sv := ValueToX(vp.SingleValue, R);
              end
              else
                svx := Round((K * xs) + Chart.GetXScaleStart) + R.Top;

              FDrawPoints[X] := Point(sv, svx);
              if ChartType = ctBand then
                FDrawPoints[(tox * 2) - 1 - X] := Point(ValueToY(vp.SecondValue, R), svx);
            end
            else
            begin
              if (ChartType = ctXYLine) or (ChartType = ctXYDigitalLine) or (ChartType = ctXYMarkers) or (ChartType = ctGantt) then
              begin
                svx := ValueToX(vp.SingleXValue, R);
                if ChartType = ctGantt then
                  sv := ValueToX(vp.SingleValue, R);
              end
              else
                svx := Round((K * xs) + Chart.GetXScaleStart) + R.Left;

              FDrawPoints[X] := Point(svx, sv);
              if ChartType = ctBand then
                FDrawPoints[(tox * 2) - 1 - X] := Point(svx, ValueToY(vp.SecondValue, R));
            end;
          end;

          Inc(X);
        end
        else
          if ChartType in [ctStackedBar, ctStackedArea, ctStackedPercArea, ctStackedPercBar] then
          begin
            SetLength(FDrawPoints, X + 1);

            sv := ValueToY(ZeroReferencePoint, R);

            if Chart.Series.IsHorizontal then
            begin
              if J < 0 then
              begin
                svx := Round(((K - J) * xs) + Chart.GetXScaleStart) + R.Left;
                FDrawPoints[X] := Point(sv, svx)
              end
              else
              begin
                svx := Round((K * xs) + Chart.GetXScaleStart) + R.Left;
                FDrawPoints[X] := Point(sv, svx);
              end;
            end
            else
            begin
              if J < 0 then
              begin
                svx := Round(((K - J) * xs) + Chart.GetXScaleStart) + R.Left;
                FDrawPoints[X] := Point(svx, sv)
              end
              else
              begin
                svx := Round((K * xs) + Chart.GetXScaleStart) + R.Left;
                FDrawPoints[X] := Point(svx, sv);
              end;
            end;

            Inc(X);
          end;
        Inc(K);
      end
      else
      begin
        if {vp.Defined and }not (I >= J) then
          Inc(cnt);
      end;
      Inc(I);
    end;

    Marker.DisplayIndex := Marker.SelectedIndex - cnt;


    for L := 0 to Annotations.Count - 1 do
      with Annotations[L] do
        DisplayIndex := PointIndex - cnt;

    z := ValueToY(FZeroReferencePoint,R);

    if (ChartType in [ctArea, ctStackedArea, ctStackedPercArea]) and (GetPointsCount > 0) then
    begin
      lt := Length(FDrawPoints);
      SetLength(FDrawPoints, lt + 2);
      if lt < 2 then
        lt := 2;

      if Chart.Series.IsHorizontal then
      begin
        FDrawPoints[lt] := Point(z, FDrawPoints[lt - 1].Y);
        FDrawPoints[lt + 1] := Point(z, FDrawPoints[0].Y);
      end
      else
      begin
        FDrawPoints[lt] := Point(FDrawPoints[lt - 1].X , z);
        FDrawPoints[lt + 1] := Point(FDrawPoints[0].X, z);
      end;
    end;
  end;
end;

procedure TChartSerie.LoadFromFile(ini: TMemIniFile;Section: String);
var
  str: String;
  A: TStringList;
  i: integer;
begin
  DrawFromStartDate := ini.ReadBool(Section, 'DrawFromStartDate', DrawFromStartDate);
  GroupIndex := ini.ReadInteger(Section, 'GroupIndex', GroupIndex);
  RangePercentMargin := ini.ReadInteger(Section, 'RangePercentMargin', RangePercentMargin);
  ReadOnly := ini.ReadBool(Section, 'ReadOnly', ReadOnly);
  AutoRange := TChartSerieAutoRange(ini.ReadInteger(Section, 'AutoRange', Integer(AutoRange)));
  FChartPatternPosition := TChartBackGroundPosition(ini.ReadInteger(Section, 'ChartPatternPosition', Integer(ChartPatternPosition)));
  BorderWidth := ini.ReadInteger(Section, 'BorderWidth', BorderWidth);
  BorderColor := ini.ReadInteger(Section, 'BorderColor', BorderColor);
  BrushStyle := TBrushStyle(ini.ReadInteger(Section, 'BrushStyle', Integer(BrushStyle)));
  ChartType := TChartType(ini.ReadInteger(Section, 'ChartType', Integer(ChartType)));
  Color := ini.ReadInteger(Section, 'Color', Color);
  ColorTo := ini.ReadInteger(Section, 'ColorTo', ColorTo);
  CandleColorDecrease := ini.ReadInteger(Section, 'CandleColorDecrease', CandleColorDecrease);
  CandleColorIncrease := ini.ReadInteger(Section, 'CandleColorIncrease', CandleColorIncrease);
  CrossHairYValue.LoadFromFile(ini, Section + '.' + 'CrossHairYValue');
  GradientSteps := ini.ReadInteger(Section, 'GradientSteps', GradientSteps);
  GradientDirection := TChartGradientDirection(ini.ReadInteger(Section, 'GradientDirection', Integer(GradientDirection)));
  LineColor := ini.ReadInteger(Section, 'LineColor', LineColor);
  LineWidth := ini.ReadInteger(Section, 'LineWidth', LineWidth);
  LegendText := ini.ReadString(Section, 'LegendText', LegendText);
  Marker.LoadFromFile(ini, Section + '.' + 'Marker');
  Annotations.LoadFromFile(ini, Section + '.' + 'Annotations');
  XAxisGroups.LoadFromFile(ini, Section + '.' + 'XAxisGroups');
  XAxisGroupsVisible := ini.ReadBool(Section, 'XAxisGroupsVisible', XAxisGroupsVisible);
  Maximum := ini.ReadFloat(Section, 'Maximum', Maximum);
  Minimum := ini.ReadFloat(Section, 'Minimum', Minimum);
  PenStyle := TPenStyle(ini.ReadInteger(Section, 'PenStyle', Integer(PenStyle)));
  GanttHeight := ini.ReadInteger(Section, 'GanttHeight', GanttHeight);
  GanttSpacing := ini.ReadInteger(Section, 'GanttSpacing', GanttSpacing);
  //TODO
//  ini.ReadInteger(Section, 'Picture', Integer(Picture));
  ShowValue := ini.ReadBool(Section, 'ShowValue', ShowValue);
  ShowValueInTracker := ini.ReadBool(Section, 'ShowValueInTracker', ShowValueInTracker);
  ShowAnnotationsOnTop := ini.ReadBool(Section, 'ShowAnnotationsOnTop', ShowAnnotationsOnTop);
  ValueFont.Size := ini.ReadInteger(Section, 'ValueFontSize', ValueFont.Size);
  ValueFont.Color := ini.ReadInteger(Section, 'ValueFontColor', ValueFont.Color);
  ValueFont.Name := ini.ReadString(Section, 'ValueFontName', ValueFont.Name);
  str := ini.ReadString(Section, 'ValueFontStyle', '');
  A := TStringList.Create;
  Split(':',str, A);
  for I := 1 to A.Count - 1 do
  begin
    ValueFont.Style := ValueFont.Style + [TFontStyle(strtoint(A[I]))];
  end;
  A.Free;
  ValueFormat := ini.ReadString(Section, 'ValueFormat', ValueFormat);
  ValueFormatType := TChartValueFormatType(ini.readInteger(Section, 'ValueFormatType', Integer(ValueFormatType)));
  ValueType := TChartValueType(ini.ReadInteger(Section, 'ValueType', Integer(ValueType)));
  ValueWidth := ini.ReadInteger(Section, 'ValueWidth', ValueWidth);
  ValueWidthType := TChartSerieValueWidthType(ini.ReadInteger(Section, 'ValueWidthType', Integer(ValueWidthType)));
  WickColor := ini.ReadInteger(Section, 'WickColor', WickColor);
  WickWidth := ini.ReadInteger(Section, 'WickWidth', WickWidth);
  XAxis.LoadFromFile(ini, Section + '.' + 'XAxis');
  YAxis.LoadFromFile(ini, Section + '.' + 'YAxis');
  ZeroLine := ini.ReadBool(Section, 'ZeroLine', ZeroLine);
  ZeroLineWidth := ini.ReadInteger(Section, 'ZeroLineWidth', ZeroLineWidth);
  ZeroLineColor := ini.ReadInteger(Section, 'ZeroLineColor', ZeroLineColor);
  ZeroReferencePoint := ini.ReadFloat(Section, 'ZeroReferencePoint', ZeroReferencePoint);
  SelectedIndex := ini.ReadInteger(Section, 'SelectedIndex', SelectedIndex);
  SelectedMark := ini.ReadBool(Section, 'SelectedMark', SelectedMark);
  SelectedMarkColor := ini.ReadInteger(Section, 'SelectedMarkColor', SelectedMarkColor);
  SelectedMarkBorderColor := ini.ReadInteger(Section, 'SelectedMarkBorderColor', SelectedMarkBorderColor);
  SelectedMarkSize := ini.ReadInteger(Section, 'SelectedMarkSize', SelectedMarkSize);
  ShowInLegend := ini.ReadBool(Section, 'ShowInLegend', ShowInLegend);
  Pie.LoadFromFile(ini, Section + '.' + 'Pie');
  Enable3D := ini.ReadBool(Section, 'Enable3D', Enable3D);
  Offset3D := ini.ReadInteger(Section, 'Offset3D', Offset3D);
  Darken3D := ini.ReadBool(Section, 'Darken3D', Darken3D);
  BarShape := TChartBarShape(ini.ReadInteger(Section, 'BarShape', Integer(BarShape)));
  Logarithmic := ini.ReadBool(Section, 'Logarithmic', Logarithmic);

  BarValueTextAlignment := TAlignment(ini.ReadInteger(Section, 'BarValueTextAlignment', Integer(BarValueTextAlignment)));
  BarValueTextType := TChartBarValueTextType(ini.ReadInteger(Section, 'BarValueTextType', Integer(BarValueTextType)));
  BarValueTextFont.Size := ini.ReadInteger(Section, 'BarValueTextFontSize', BarValueTextFont.Size);
  BarValueTextFont.Color := ini.ReadInteger(Section, 'BarValueTextFontColor', BarValueTextFont.Color);
  BarValueTextFont.Name := ini.ReadString(Section, 'BarValueTextFontName', BarValueTextFont.Name);

  str := ini.ReadString(Section, 'BarValueTextFontStyle', '');
  A := TStringList.Create;
  Split(':',str, A);
  for I := 1 to A.Count - 1 do
  begin
    BarValueTextFont.Style := BarValueTextFont.Style + [TFontStyle(strtoint(A[I]))];
  end;
  A.Free;

  Visible := ini.ReadBool(Section, 'Visible', Visible);
end;

procedure TChartSerie.MarkerChanged(Sender: TObject);
begin
  Changed;
end;

procedure TChartSerie.MoveTo(SerieIndex: integer);
begin
  if (SerieIndex >= 0) and (SerieIndex <= (collection as TChartSeries).Count - 1) then
    Self.Index := SerieIndex;
end;

procedure TChartSerie.PictureChanged(Sender: TObject);
begin
  Changed;
end;

procedure TChartSerie.PieChanged(Sender: TObject);
begin
  Changed;
end;

function TChartSerie.PointInFunnel(x, y: Integer; pt: TFunnelPoint): Boolean;
var
  cnt, K, J : Integer;
  pts: TPointArray;
begin
  Result := False;
  SetLength(pts, 4);
  pts[0].X := pt.X0;
  pts[0].Y := pt.Y0;
  pts[1].X := pt.X1;
  pts[1].Y := pt.Y1;
  pts[2].X := pt.X2;
  pts[2].Y := pt.Y2;
  pts[3].X := pt.X3;
  pts[3].Y := pt.Y3;
  cnt := Length(pts);
  J := cnt-1;
  for K := 0 to cnt-1 do begin
   if ((pts[K].Y <=Y) and (Y < pts[J].Y)) or
      ((pts[J].Y <=Y) and (Y < pts[K].Y)) then
   begin
    if (x < (pts[j].X - pts[K].X) *
       (y - pts[K].Y) /
       (pts[j].Y - pts[K].Y) + pts[K].X) then
        Result := not Result;
    end;
    J := K;
  end;
end;

function TChartSerie.PointInPie(x, y, cx, cy, sta, swa: Single): Boolean;
var
  r: single;
  a: single;
  chk: Boolean;
  pq: TPieQuadrant;
begin
  Result := false;

  r := Sqrt(Power((x - cx), 2) + Power((y - cy), 2));
  a := RadToDeg(ArcTan2(x - cx, y - cy) - DegToRad(Pie.StartOffsetAngle));
  pq := GetQuadrant(PointF(cx, cy), PointF(x, y));
  case pq of
    pq1: a := a - 90;
    pq2, pq3, pq4: a := a + 270;
  end;
  if a < 0 then
    a := a + 360;

  chk := (a >= sta - Pie.StartOffsetAngle) and (a <= swa - Pie.StartOffsetAngle);

  case ChartType of
    ctHalfSpider, ctSpider, ctHalfPie, ctPie, ctFunnel, ctSizedPie, ctSizedHalfPie, ctVarRadiusPie, ctVarRadiusHalfPie:
    begin
      if chk and (r < (Pie.GetPieSize / 2)) then
      begin
        Result := True;
      end;
    end;
    ctHalfDonut, ctDonut, ctSizedDonut, ctSizedHalfDonut, ctVarRadiusDonut, ctVarRadiusHalfDonut:
    begin
      if chk and (r < (Pie.GetPieSize / 2)) and (r > (Pie.GetPieInnerSize / 2)) then
        Result := True;
    end;
  end;
end;

procedure TChartSerie.RemovePoint(PointIndex: integer);
begin
   if Index > High(FPoints) then Exit;
   if Index < Low(FPoints) then Exit;
   if Index = GetPointsCount - 1 then
   begin
     SetLength(FPoints, Length(FPoints) - 1) ;
     Exit;
   end;
   Finalize(FPoints[PointIndex]) ;
   System.Move(FPoints[PointIndex +1], FPoints[PointIndex],(Length(FPoints) - PointIndex -1) * SizeOf(TChartPoint) + 1) ;
   SetLength(FPoints, Length(FPoints) - 1) ;
end;

procedure TChartSerie.SetSelectedColor(const Value: TColor);
begin
  if FSelectedColor <> value then
  begin
    FSelectedColor := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetSelectedIndex(const Value: integer);
begin
  if FSelectedIndex <> value then
  begin
    FSelectedIndex := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetSelectedMark(const Value: Boolean);
begin
  if FSelectedMark <> value then
  begin
    FSelectedMark := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetSelectedMarkBorderColor(const Value: TColor);
begin
  if FSelectedMarkBorderColor <> value then
  begin
    FSelectedMarkBorderColor := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetSelectedMarkSize(const Value: integer);
begin
  if FSelectedMarkSize <> value then
  begin
    FSelectedMarkSize := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetSerieType(const Value: TSerieType);
begin
  if FSerieType <> value then
  begin
    FSerieType := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetShowAnnotationsOnTop(const Value: Boolean);
begin
  if FShowAnnotationsOnTop <> value then
  begin
    FShowAnnotationsOnTop := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetShowInLegend(const Value: Boolean);
begin
  if FShowInLegend <> value then
  begin
    FShowInLegend := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetShowValue(const Value: boolean);
begin
  if FShowvalue <> Value then
  begin
    FShowValue := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetShowValueInTracker(const Value: boolean);
begin
  if FShowValueInTracker <> value then
  begin
    FShowValueInTracker := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetSingleDateTime(SingleDateTime: TDateTime;
  index: integer);
begin
  FPoints[index].TimeStamp := SingleDateTime;
  FPoints[index].Defined := true;
  FPoints[index].ValueType := cpvSingle;
  FPoints[index].Color := clNone;
  FPoints[index].ColorTo := clNone;
  //FLastPoint := index + 1;
end;

procedure TChartSerie.SetSinglePoint(SinglePoint: double; index: integer);
begin
  FPoints[index].SingleValue := SinglePoint;
  FPoints[index].Defined := true;
  FPoints[index].ValueType := cpvSingle;
  FPoints[index].Color := clNone;
  FPoints[index].ColorTo := clNone;
  //FLastPoint := index + 1;
end;

procedure TChartSerie.SetStackedPointsAreaLength(l: integer);
begin
  SetLength(FStackedPointsArea,l);
end;

procedure TChartSerie.SetStackedPointsBarLength(l: integer);
begin
  SetLength(FStackedPointsBar,l);
end;

procedure TChartSerie.SetValueAngle(const Value: integer);
begin
  if FValueAngle <> Value then
  begin
    FValueAngle := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetValueFont(const Value: TFont);
begin
  if FValueFont <> Value then
  begin
    FValueFont.Assign(Value);
    Changed;
  end;
end;

procedure TChartSerie.SetValueFormat(const Value: string);
begin
  if ValueFormat <> Value then
  begin
    FValueFormat := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetValueFormatType(const Value: TChartValueFormatType);
begin
  if FValueFormatType <> Value then
  begin
    FValueFormatType := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetValueOffsetX(const Value: Integer);
begin
  if FValueOffsetX <> Value then
  begin
    FValueOffsetX := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetValueOffsetY(const Value: Integer);
begin
  if FValueOffsetY <> Value then
  begin
    FValueOffsetY := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetValueType(const Value: TChartValueType);
begin
  if FValueType <> Value then
  begin
    FValueType := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetValueWidth(const Value: integer);
begin
  if FValueWidth <> Value then
  begin
    FValueWidth := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetValueWidthType(const Value: TChartSerieValueWidthType);
begin
  if FValueWidthType <> Value then
  begin
    FValueWidthType := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetWickColor(const Value: TColor);
begin
  if FWickColor <> Value then
  begin
    FWickColor := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetWickWidth(const Value: integer);
begin
  if (FWickWidth <> value) and (Value >= 0) then
  begin
    FWickWidth := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetXAxis(const Value: TChartSerieXAxis);
begin
  if FXAxis <> Value then
  begin
    FXAxis.Assign(Value);
    Changed;
  end;
end;

procedure TChartSerie.SetXAxisGroups(const Value: TChartSerieXAxisGroups);
begin
  if FXAxisGroups <> Value then
  begin
    FXAxisGroups.Assign(Value);
    Changed;
  end;
end;

procedure TChartSerie.SetXAxisGroupsVisible(const Value: Boolean);
begin
  if FXAxisGroupsVisible <> Value then
  begin
    FXAxisGroupsVisible := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetYAxis(const Value: TChartSerieYAxis);
begin
  if FYAxis <> Value then
  begin
    FYAxis.Assign(Value);
    Changed;
  end;
end;

procedure TChartSerie.SetYScale(const Value: Double);
begin
  if (FYScale <> Value) then
  begin
    OldYScale := Value;
    FYScale := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetZeroLine(const Value: Boolean);
begin
  if FZeroLine <> Value then
  begin
    FZeroLine := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetZeroLineColor(const Value: TColor);
begin
  if FZeroLineColor <> Value then
  begin
    FZeroLineColor := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetZeroLineWidth(const Value: integer);
begin
  if (FZeroLineWidth <> Value) and (Value >= 0) then
  begin
    FZeroLineWidth := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetZeroReferencePoint(const Value: Double);
begin
  if FZeroReferencePoint <> Value then
  begin
    FZeroReferencePoint := Value;
    Changed;
  end;
end;

function TChartSerie.ValueToX(value: double; R: TRect): integer;
begin
  if Chart.Series.IsHorizontal then
  begin
    if Chart.XScale > 0 then
      Result := r.Top -1 + Round(Chart.GetXScaleStart + (value - Chart.Range.RangeFrom) * Chart.XScale)
    else
      Result := r.Top -1 + Round(Chart.GetXScaleStart + (value - Chart.Range.RangeFrom) * 1);
  end
  else
  begin
    if Chart.XScale > 0 then
      Result := r.Left -1 + Round(Chart.GetXScaleStart + (value - Chart.Range.RangeFrom) * Chart.XScale)
    else
      Result := r.Left -1 + Round(Chart.GetXScaleStart + (value - Chart.Range.RangeFrom) * 1);
  end;
end;

function TChartSerie.ValueToY(value: double; R: TRect): integer;
//var
//  stackedchart: boolean;
//  bw, zl: integer;
begin
//  bw := 0;
//  if (BorderColor <> clNone) and (BorderWidth > 0) then
//    bw := BorderWidth;
//
//  zl := 0;
//  if ZeroLine and (ZeroLineColor <> clNone) and (ZeroReferencePoint = 0) then
//    zl := ZeroLineWidth;


  if Chart.Series.IsHorizontal then
  begin
//    stackedchart := (ChartType in [ctStackedBar, ctStackedPercBar]);
//    if (value = MinimumValue) and ((Index = 0) and stackedchart) or not stackedchart then
//      r.Left := r.Left + zl + bw;
//

    if YScale > 0 then
      Result := Round(r.Left + (value - MinimumValue) * YScale)
    else
      Result := Round(r.Left + (value - MinimumValue) * 1);
  end
  else
  begin
//    stackedchart := (ChartType in [ctStackedBar, ctStackedPercBar]);
//    if (value = MinimumValue) and ((Index = 0) and stackedchart) or not stackedchart then
//      r.Bottom := r.Bottom - zl - bw;


    if YScale > 0 then
      Result := Round(r.Bottom - (value - MinimumValue) * YScale)
    else
      Result := Round(r.Bottom - (value - MinimumValue) * 1);
  end;
end;

function TChartSerie.YToValue(value: integer; R: TRect): double;
begin
  if Chart.Series.IsHorizontal then
  begin
    if FYScale > 0 then
      Result := ((value - r.Left) / YScale) + MinimumValue
    else
      Result := ((value - r.Left) / 1) + MinimumValue;
  end
  else
  begin
    if FYScale > 0 then
      Result := ((r.Bottom - value) / YScale) + MinimumValue
    else
      Result := ((r.Bottom - value) / 1) + MinimumValue;
  end;
end;

procedure TChartSerie.SetMultiPoints(HighPoint, LowPoint, OpenPoint, ClosePoint: double; index: integer);
begin
  FPoints[index].SingleValue := HighPoint;
  FPoints[index].HighValue := Highpoint;
  FPoints[index].LowValue := LowPoint;
  FPoints[index].OpenValue := OpenPoint;
  FPoints[index].CloseValue := ClosePoint;
  FPoints[index].Defined := true;
  FPoints[index].ValueType := cpvMulti;
//  FLastPoint := Index;
end;

procedure TChartSerie.SetName(const Value: string);
begin
  if FName <> value then
  begin
    FName := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetOffset(const Value: Double);
begin
  if FOffSet <> Value then
  begin
    FOffSet := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetOffset3D(const Value: integer);
begin
  if FOffset3D <> value then
  begin
    FOffset3D := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetOldYScale(const Value: Double);
begin
  if FOldYScale <> Value then
  begin
    FOldYScale := Value;
  end;
end;

procedure TChartSerie.SetOriginalYScale(const Value: Double);
begin
  if (FOriginalYScale <> Value) and (Value > 0) then
  begin
    FOriginalYScale := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetPenStyle(const Value: TPenStyle);
begin
  if FPenStyle <> Value then
  begin
    FPenStyle := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetRangePercentMargin(const Value: Integer);
begin
  if FRangePercentMargin <> Value then
  begin
    FRangePercentMargin := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetReadOnly(const Value: Boolean);
begin
  if FReadOnly <> value then
  begin
    FReadOnly := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetChartPattern(const Value: TPicture);
begin
  if FChartPattern <> Value then
  begin
    FChartPattern.Assign(Value);
    PictureChanged(FChartPattern);
  end;
end;

procedure TChartSerie.SetChartPatternPosition(
  const Value: TChartBackGroundPosition);
begin
  if FChartPatternPosition <> Value then
  begin
    FChartPatternPosition := Value;
    Changed;
  end;
end;

procedure TChartSerie.SaveToFile(ini: TMemIniFile;Section: String);
begin
  ini.WriteBool(Section, 'DrawFromStartDate', DrawFromStartDate);
  ini.WriteInteger(Section, 'GanttHeight', GanttHeight);
  ini.WriteInteger(Section, 'GanttSpacing', GanttSpacing);
  ini.WriteInteger(Section, 'GroupIndex', GroupIndex);
  ini.WriteBool(Section, 'ReadOnly', ReadOnly);
  ini.WriteInteger(Section, 'AutoRange', Integer(AutoRange));
  ini.WriteInteger(Section, 'RangePercentMargin', RangePercentMargin);
  ini.WriteInteger(Section, 'ChartPatternPosition', Integer(FChartPatternPosition));
  ini.WriteInteger(Section, 'BorderWidth', BorderWidth);
  ini.WriteInteger(Section, 'BorderColor', BorderColor);
  ini.writeInteger(Section, 'BorderRounding', BorderRounding);
  ini.WriteInteger(Section, 'BrushStyle', Integer(BrushStyle));
  ini.WriteInteger(Section, 'ChartType', Integer(ChartType));
  ini.WriteInteger(Section, 'Color', Color);
  ini.WriteInteger(Section, 'ColorTo', ColorTo);
  ini.WriteInteger(Section, 'CandleColorDecrease', CandleColorDecrease);
  ini.WriteInteger(Section, 'CandleColorIncrease', CandleColorIncrease);
  CrossHairYValue.SaveToFile(ini, Section + '.' + 'CrossHairYValue');
  ini.WriteInteger(Section, 'GradientSteps', GradientSteps);
  ini.WriteInteger(Section, 'GradientDirection', Integer(GradientDirection));
  ini.WriteInteger(Section, 'LineColor', LineColor);
  ini.WriteInteger(Section, 'LineWidth', LineWidth);
  ini.WriteString(Section, 'LegendText', LegendText);
  Marker.SaveToFile(ini, Section + '.' + 'Marker');
  Annotations.SaveToFile(ini, Section + '.' + 'Annotations');
  XAxisGroups.SaveToFile(ini, Section + '.' + 'XAxisGroups');
  ini.WriteBool(Section, 'XAxisGroupsVisible', XAxisGroupsVisible);
  ini.WriteFloat(Section, 'Maximum', Maximum);
  ini.WriteFloat(Section, 'Minimum', Minimum);
  ini.WriteString(Section, 'Name', Name);
  ini.WriteInteger(Section, 'PenStyle', Integer(PenStyle));
  ini.WriteBool(Section, 'ShowValue', ShowValue);
  ini.WriteBool(Section, 'ShowValueInTracker', ShowValueInTracker);
  ini.WriteBool(Section, 'ShowAnnotationsOnTop', ShowAnnotationsOnTop);
  ini.WriteBool(Section, 'SelectedMark', SelectedMark);
  ini.WriteInteger(Section, 'SelectedIndex', SelectedIndex);
  ini.WriteInteger(Section, 'SelectedMarkSize', SelectedMarkSize);
  ini.WriteInteger(Section, 'SelectedMarkColor', SelectedMarkColor);
  ini.WriteInteger(Section, 'SelectedMarkBorderColor', SelectedMarkBorderColor);
  ini.WriteInteger(Section, 'ValueFontSize', ValueFont.Size);
  ini.WriteInteger(Section, 'ValueFontColor', ValueFont.Color);
  ini.WriteString(Section, 'ValueFontName', ValueFont.Name);
  ini.WriteString(Section, 'ValueFontStyle', GetFontStyles(ValueFont.Style));
  ini.WriteString(Section, 'ValueFormat', ValueFormat);
  ini.WriteInteger(Section, 'ValueFormatType', Integer(ValueFormatType));
  ini.WriteInteger(Section, 'ValueType', Integer(ValueType));
  ini.WriteInteger(Section, 'ValueWidth', ValueWidth);
  ini.WriteInteger(Section, 'ValueWidthType', Integer(ValueWidthType));
  ini.WriteInteger(Section, 'WickColor', WickColor);
  ini.WriteInteger(Section, 'WickWidth', WickWidth);
  XAxis.SaveToFile(ini, Section + '.' + 'XAxis');
  YAxis.SaveToFile(ini, Section + '.' + 'YAxis');
  ini.WriteBool(Section, 'ZeroLine', ZeroLine);
  ini.WriteInteger(Section, 'ZeroLineWidth', ZeroLineWidth);
  ini.WriteInteger(Section, 'ZeroLineColor', ZeroLineColor);
  ini.WriteFloat(Section, 'ZeroReferencePoint', ZeroReferencePoint);
  ini.WriteBool(Section, 'ShowInLegend', ShowInLegend);
  //pie
  Pie.SaveToFile(ini, Section +'.' + 'Pie');
  ini.WriteBool(Section, 'Enable3D', Enable3d);
  ini.WriteInteger(Section, 'Offset3D', Offset3D);
  ini.WriteBool(Section, 'Darken3D', Darken3D);
  ini.WriteInteger(Section, 'BarShape', Integer(BarShape));
  ini.WriteBool(Section, 'Logarithmic', Logarithmic);
  ini.WriteInteger(Section, 'BarValueTextAlignment', Integer(BarValueTextAlignment));
  ini.WriteInteger(Section, 'BarValueTextType', Integer(BarValueTextType));
  ini.WriteInteger(Section, 'BarValueTextFontSize', BarValueTextFont.Size);
  ini.WriteInteger(Section, 'BarValueTextFontColor', BarValueTextFont.Color);
  ini.WriteString(Section, 'BarValueTextFontName', BarValueTextFont.Name);
  ini.WriteString(Section, 'BarValueTextFontStyle', GetFontStyles(BarValueTextFont.Style));
  ini.WriteBool(Section, 'Visible', Visible);
  ini.WriteInteger(Section, 'ValueOffsetY', ValueOffsetY);
  ini.WriteInteger(Section, 'ValueOffsetX', ValueOffsetX);
end;

function TChartSerie.SerieMax: Double;
begin
  result := FSerieMax;
end;

function TChartSerie.SerieMin: Double;
begin
  result := FserieMin;
end;

procedure TChartSerie.SetArraySize(Size: integer);
begin
  SetLength(FPoints, Size);
  FLastPoint := Size;
end;

procedure TChartSerie.SetArrowColor(const Value: TColor);
begin
  if FArrowcolor <> Value then
  begin
    FArrowColor := Value;
    changed;
  end;
end;

procedure TChartSerie.SetArrowSize(const Value: integer);
begin
  if FArrowSize <> Value then
  begin
    FArrowSize := Value;
    Changed;
  end;
end;

function TChartSerie.GetArraySize: integer;
begin
  Result := GetPointsCount - 1;
end;

procedure TChartSerie.SetAutoRange(const Value: TChartSerieAutoRange);
begin
  if FAutoRange <> Value then
  begin
    FAutoRange := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetBarShape(const Value: TChartBarShape);
begin
  if FBarShape <> value then
  begin
    FBarShape := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetBarValueTextAlignment(const Value: TAlignment);
begin
  if FBarValueTextAlignment <> value then
  begin
    FBarValueTextAlignment := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetBarValueTextFont(const Value: TFont);
begin
  if FBarValueTextFont <> value then
  begin
    FBarValueTextFont.Assign(Value);
    Changed;
  end;
end;

procedure TChartSerie.SetBarValueTextType(const Value: TChartBarValueTextType);
begin
  if FBarValueTextType <> value then
  begin
    FBarValueTextType := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetBorderColor(const Value: TColor);
begin
  if FBorderColor <> Value then
  begin
    FBorderColor := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetBorderRounding(const Value: Integer);
begin
  if FBorderRounding <> Value then
  begin
    FBorderRounding := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetBorderWidth(const Value: integer);
begin
  if (FBorderWidth <> Value) and (Value >= 0) then
  begin
    FBorderWidth := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetBrushStyle(const Value: TBrushStyle);
begin
  if FBrushStyle <> Value then
  begin
    FBrushStyle := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetCandleColorDecrease(const Value: TColor);
begin
  if FCandleColorDecrease <> Value then
  begin
    FCandleColorDecrease := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetCandleColorIncrease(const Value: TColor);
begin
  if FCandleColorIncrease <> Value then
  begin
    FCandleColorIncrease := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetChartType(const Value: TChartType);
begin
  if FChartType <> Value then
  begin
    FChartType := Value;
    case FChartType of
      ctRenko:
      begin
        Marker.MarkerType := mSquare;
      end;
    end;

    if IsPieChart then
    begin
      Chart.XAxis.Position := xNone;
      Chart.YAxis.Position := yNone;
    end;

    Chart.Series.ForceInit(true);
    Changed;
  end;
end;

procedure TChartSerie.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetColorTo(const Value: TColor);
begin
  if FColorTo <> Value then
  begin
    FColorTo := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetCrossHairYValue(
  const Value: TChartSerieCrossHairYValue);
begin
  if FCrossHairYValue <> Value then
  begin
    FCrossHairYValue.Assign(Value);
    Changed;
  end;
end;

procedure TChartSerie.SetDarken3D(const Value: Boolean);
begin
  if FDarken3D <> Value then
  begin
    FDarken3D := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetDrawFromStartDate(const Value: Boolean);
begin
  if FDrawFromStartDate <> Value then
  begin
    FDrawFromStartDate := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetEnable3D(const Value: Boolean);
begin
  if FEnable3D <> value then
  begin
    FEnable3D := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetFieldNameValue(const Value: string);
begin
  FFieldNameValue := Value;
end;

procedure TChartSerie.SetFieldNameXAxis(const Value: string);
begin
  FFieldNameXAxis := Value;
end;

procedure TChartSerie.SetFunnelHeight(const Value: Integer);
begin
  if FFunnelHeight <> Value then
  begin
    FFunnelHeight := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetFunnelHeightType(
  const Value: TChartSerieFunnelSizeType);
begin
  if FFunnelHeightType <> Value then
  begin
    FFunnelHeightType := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetFunnelMode(const Value: TChartSerieFunnelMode);
begin
  if FFunnelMode <> Value then
  begin
    FFunnelMode := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetFunnelSpacing(const Value: Integer);
begin
  if FFunnelSpacing <> Value then
  begin
    FFunnelSpacing := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetFunnelWidth(const Value: Integer);
begin
  if FFunnelWidth <> Value then
  begin
    FFunnelWidth := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetFunnelWidthType(
  const Value: TChartSerieFunnelSizeType);
begin
  if FFunnelWidthType <> Value then
  begin
    FFunnelWidthType := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetGanttHeight(const Value: Integer);
begin
  if FGanttHeight <> Value then
  begin
    FGanttHeight := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetGanttSpacing(const Value: Integer);
begin
  if FGanttSpacing <> Value then
  begin
    FGanttSpacing := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetGradientDirection(
  const Value: TChartGradientDirection);
begin
  if FGradientDirection <> Value then
  begin
    FGradientDirection := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetGradientSteps(const Value: integer);
begin
  if (FGradientSteps <> Value) and (Value >= 0) then
  begin
    FGradientSteps := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetGroupIndex(const Value: Integer);
begin
  if (FGroupIndex <> Value) and (Value >= 0) then
  begin
    FGroupIndex := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetLegendText(const Value: string);
begin
  if (FLegendText <> Value) then
  begin
    FLegendText := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetLineColor(const Value: TColor);
begin
  if FLineColor <> Value then
  begin
    FLineColor := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetLinePointsOnly(const Value: Boolean);
begin
  if FLinePointsOnly <> Value then
  begin
    FLinePointsOnly := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetLineWidth(const Value: Integer);
begin
  if (FLineWidth <> Value) and (Value >= 0) then
  begin
    FLineWidth := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetLogarithmic(const Value: Boolean);
begin
  if FLogarithmic <> value then
  begin
    FLogarithmic := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetMax(const Value: double);
begin
  if (FMax <> Value) then
  begin
    FMax := Value;
    Changed;
  end;
end;

procedure TChartSerie.SetMin(const Value: double);
begin
  if (FMin <> Value) then
  begin
    FMin := Value;
    Changed;
  end;
end;


procedure TChartSerie.SetMinMax(RangeFrom, RangeTo: integer);
var
  i: integer;
  fv: integer;
  tv: integer;
  hv: Double;
  offsmax, offsmin, lv: Double;
begin
  if (SerieType = stZoomControl) or not Visible then
    Exit;

  //MIN,MAX
  with (Collection as TChartSeries).FOwner do
  begin
    FSerieMaxValue := -MAXLONG;
    FSerieMinValue := MAXLONG;
    hv := 0;
    lv := 0;
//
    if UseFullRange then
    begin
      fv := 0;
      tv := GetPointsCount - 1;
    end
    else
    begin
      if Range.RangeFrom < 0 then
        fv := 0
      else
        fv := Range.RangeFrom;

      if Range.RangeTo < GetPointsCount - 1 then
        tv := Range.RangeTo
      else
        tv := GetPointsCount - 1;
    end;

    for i := fv to tv do
    begin
      with GetPoint(I) do
      begin
        if Defined then
        begin
          case ChartType of
            ctNone:;
            ctCandleStick, ctLineCandleStick, ctOHLC, ctBoxPlot:
            begin
              hv := HighValue;
              lv := LowValue;
            end;
            else
            begin
              hv := SingleValue;
              lv := SingleValue;
            end;
          end;

          if FSerieMaxValue < hv then
            FSerieMaxValue := hv;

          if FSerieMinValue > lv then
            FSerieMinValue := lv;
        end;
      end;
    end;

    for i := fv to tv do
    begin
      with GetPoint(I) do
      begin
        if Defined then
        begin
          case ChartType of
            ctBand:
            begin
              hv := SecondValue;
              lv := SecondValue;
            end;
          end;

          if FSerieMaxValue < hv then
            FSerieMaxValue := hv;

          if FSerieMinValue > lv then
            FSerieMinValue := lv;
        end;
      end;
    end;

    with (Collection as TChartSeries) do
    begin
      if not (AutoRange = arDisabled) {and (Mode = cmInit)} then
      begin
        FSerieMax := FSerieMaxValue;
        FSerieMin := FSerieMinValue;

        if ChartType in [ctStackedPercArea, ctStackedPercBar] then
        begin
          FSerieMax := 100;
          FSerieMin := 0;
        end;
        if AutoRange in [arCommonZeroBased, arEnabledZeroBased] then
        begin
          FSerieMin := 0;
        end;

        if not (AutoRange in [arCommon, arCommonZeroBased]) then
        begin
          if not (AutoRange = arEnabledZeroBased) then
          begin
            offsmax := ((RangePercentMargin * Abs(FSerieMax - FSerieMin)) / 100);
            offsmin := offsmax;
          end
          else
          begin
            offsmax := ((RangePercentMargin * Abs(FSerieMax - FSerieMin)) / 100);
            offsmin := 0;
          end;

          FSerieMax := FSerieMax + offsmax;
          FSerieMin := FSerieMin - offsmin;
          FMaximumValue := FSerieMax;
          FMinimumValue := FSerieMin;
        end;
      end
      else
      begin
        if (Mode = cmInit) then
        begin
          if ChartType in [ctStackedPercArea, ctStackedPercBar] then
          begin
            FSerieMax := 100;
            FSerieMin := 0;
          end
          else
          begin
            FSerieMax := FMax;
            FSerieMin := FMin;
          end;

          FMaximumValue := FSerieMax;
          FMinimumValue := FSerieMin;
        end;
      end;
    end;
  end;
end;

procedure TChartSerie.AddMultiPoints(HighPoint, LowPoint, OpenPoint,
  ClosePoint: Double; SingleDateTime: TDateTime; Color: TColor);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].SingleValue := HighPoint;
  FPoints[FLastPoint - 1].HighValue := Highpoint;
  FPoints[FLastPoint - 1].LowValue := LowPoint;
  FPoints[FLastPoint - 1].OpenValue := OpenPoint;
  FPoints[FLastPoint - 1].CloseValue := ClosePoint;
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTime;
  FPoints[FLastPoint - 1].ValueType := cpvMulti;
  FPoints[FLastPoint - 1].Defined := true;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSinglePoint(SinglePoint: double;
  SingleDateTime: TDateTime; Color: TColor);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].SingleValue := SinglePoint;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTime;
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  FPoints[FLastPoint - 1].Defined := true;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddMultiPoints(HighPoint, LowPoint, OpenPoint,
  ClosePoint: Double; Color: TColor);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].SingleValue := HighPoint;
  FPoints[FLastPoint - 1].HighValue := Highpoint;
  FPoints[FLastPoint - 1].LowValue := LowPoint;
  FPoints[FLastPoint - 1].OpenValue := OpenPoint;
  FPoints[FLastPoint - 1].CloseValue := ClosePoint;
  FPoints[FLastPoint - 1].Defined := true;
  FPoints[FLastPoint - 1].ValueType := cpvMulti;
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSinglePoint(SinglePoint: double; Color: TColor);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].SingleValue := SinglePoint;
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  FPoints[FLastPoint - 1].Defined := true;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddMultiPoints(HighPoint, LowPoint, OpenPoint,
  ClosePoint: Double; SingleDateTime: TDateTime; Defined: Boolean);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := HighPoint;
  FPoints[FLastPoint - 1].HighValue := Highpoint;
  FPoints[FLastPoint - 1].LowValue := LowPoint;
  FPoints[FLastPoint - 1].OpenValue := OpenPoint;
  FPoints[FLastPoint - 1].CloseValue := ClosePoint;
  FPoints[FLastPoint - 1].Timestamp := SingleDateTime;
  FPoints[FLastPoint - 1].ValueType := cpvMulti;
  FPoints[FLastPoint - 1].Defined := Defined;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddMultiPoints(HighPoint, LowPoint, OpenPoint,
  ClosePoint: Double; Defined: Boolean);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := HighPoint;
  FPoints[FLastPoint - 1].HighValue := Highpoint;
  FPoints[FLastPoint - 1].LowValue := LowPoint;
  FPoints[FLastPoint - 1].OpenValue := OpenPoint;
  FPoints[FLastPoint - 1].CloseValue := ClosePoint;
  FPoints[FLastPoint - 1].Defined := Defined;
  FPoints[FLastPoint - 1].ValueType := cpvMulti;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddDoublePoint(FirstPoint, SecondPoint: double;
  SingleDateTime: TDateTime);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].SingleValue := FirstPoint;
  FPoints[FLastPoint - 1].SecondValue := SecondPoint;
  FPoints[FLastPoint - 1].ValueType := cpvMulti;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTime;
  FPoints[FLastPoint - 1].Defined := true;
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddDoublePoint(FirstPoint, SecondPoint: double;
  SingleDateTime: TDateTime; Defined: Boolean);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].SingleValue := FirstPoint;
  FPoints[FLastPoint - 1].SecondValue := SecondPoint;
  FPoints[FLastPoint - 1].ValueType := cpvMulti;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTime;
  FPoints[FLastPoint - 1].Defined := Defined;
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddDoublePoint(FirstPoint, SecondPoint: double);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].SingleValue := FirstPoint;
  FPoints[FLastPoint - 1].SecondValue := SecondPoint;
  FPoints[FLastPoint - 1].ValueType := cpvMulti;
  FPoints[FLastPoint - 1].Defined := true;
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddDoublePoint(FirstPoint, SecondPoint: double;
  Defined: Boolean);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].SingleValue := FirstPoint;
  FPoints[FLastPoint - 1].SecondValue := SecondPoint;
  FPoints[FLastPoint - 1].ValueType := cpvMulti;
  FPoints[FLastPoint - 1].Defined := Defined;
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddDoublePoint(FirstPoint, SecondPoint: double;
  SingleDateTime: TDateTime; Color: TColor);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].SingleValue := FirstPoint;
  FPoints[FLastPoint - 1].SecondValue := SecondPoint;
  FPoints[FLastPoint - 1].ValueType := cpvMulti;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTime;
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].Defined := true;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddDoublePoint(FirstPoint, SecondPoint: double;
  SingleDateTime: TDateTime; Color: TColor; Defined: Boolean);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].SingleValue := FirstPoint;
  FPoints[FLastPoint - 1].SecondValue := SecondPoint;
  FPoints[FLastPoint - 1].ValueType := cpvMulti;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTime;
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].Defined := Defined;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddDoublePoint(FirstPoint, SecondPoint: double;
  XAxisValue: String);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].SingleValue := FirstPoint;
  FPoints[FLastPoint - 1].SecondValue := SecondPoint;
  FPoints[FLastPoint - 1].ValueType := cpvMulti;
  FPoints[FLastPoint - 1].Defined := true;
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].LegendValue := XAxisValue;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddDoublePoint(FirstPoint, SecondPoint: double;
  Color: TColor);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].SingleValue := FirstPoint;
  FPoints[FLastPoint - 1].SecondValue := SecondPoint;
  FPoints[FLastPoint - 1].ValueType := cpvMulti;
  FPoints[FLastPoint - 1].Defined := true;
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddDoublePoint(FirstPoint, SecondPoint: double;
  Color: TColor; Defined: Boolean);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].SingleValue := FirstPoint;
  FPoints[FLastPoint - 1].SecondValue := SecondPoint;
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ValueType := cpvMulti;
  FPoints[FLastPoint - 1].Defined := Defined;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddChartPoint(pt: TChartPoint);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1] := pt;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;


procedure TChartSerie.AddDoubleXYPoint(SingleXPoint, FirstPoint, SecondPoint: double;
  SingleDateTime: TDateTime);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].SingleValue := FirstPoint;
  FPoints[FLastPoint - 1].SingleXValue := SingleXPoint;
  FPoints[FLastPoint - 1].SecondValue := SecondPoint;
  FPoints[FLastPoint - 1].ValueType := cpvMulti;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTime;
  FPoints[FLastPoint - 1].Defined := true;
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddDoubleXYPoint(SingleXPoint, FirstPoint, SecondPoint: double;
  SingleDateTime: TDateTime; Defined: Boolean);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].SingleValue := FirstPoint;
  FPoints[FLastPoint - 1].SingleXValue := SingleXPoint;
  FPoints[FLastPoint - 1].SecondValue := SecondPoint;
  FPoints[FLastPoint - 1].ValueType := cpvMulti;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTime;
  FPoints[FLastPoint - 1].Defined := Defined;
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddDoubleXYPoint(SingleXPoint, FirstPoint, SecondPoint: double);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].SingleValue := FirstPoint;
  FPoints[FLastPoint - 1].SingleXValue := SingleXPoint;
  FPoints[FLastPoint - 1].SecondValue := SecondPoint;
  FPoints[FLastPoint - 1].ValueType := cpvMulti;
  FPoints[FLastPoint - 1].Defined := true;
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddDoubleXYPoint(SingleXPoint, FirstPoint, SecondPoint: double;
  Defined: Boolean);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].SingleValue := FirstPoint;
  FPoints[FLastPoint - 1].SingleXValue := SingleXPoint;
  FPoints[FLastPoint - 1].SecondValue := SecondPoint;
  FPoints[FLastPoint - 1].ValueType := cpvMulti;
  FPoints[FLastPoint - 1].Defined := Defined;
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddDoubleXYPoint(SingleXPoint, FirstPoint, SecondPoint: double;
  SingleDateTime: TDateTime; Color: TColor);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].SingleValue := FirstPoint;
  FPoints[FLastPoint - 1].SingleXValue := SingleXPoint;
  FPoints[FLastPoint - 1].SecondValue := SecondPoint;
  FPoints[FLastPoint - 1].ValueType := cpvMulti;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTime;
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].Defined := true;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddDoubleXYPoint(SingleXPoint, FirstPoint, SecondPoint: double;
  SingleDateTime: TDateTime; Color: TColor; Defined: Boolean);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].SingleValue := FirstPoint;
  FPoints[FLastPoint - 1].SingleXValue := SingleXPoint;
  FPoints[FLastPoint - 1].SecondValue := SecondPoint;
  FPoints[FLastPoint - 1].ValueType := cpvMulti;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTime;
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].Defined := Defined;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddDoubleXYPoint(SingleXPoint, FirstPoint,
  SecondPoint: double; XAxisValue: String);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].SingleValue := FirstPoint;
  FPoints[FLastPoint - 1].SingleXValue := SingleXPoint;
  FPoints[FLastPoint - 1].SecondValue := SecondPoint;
  FPoints[FLastPoint - 1].ValueType := cpvMulti;
  FPoints[FLastPoint - 1].Defined := true;
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].LegendValue := XAxisValue;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddDoubleXYPoint(SingleXPoint, FirstPoint, SecondPoint: double;
  Color: TColor);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].SingleValue := FirstPoint;
  FPoints[FLastPoint - 1].SingleXValue := SingleXPoint;
  FPoints[FLastPoint - 1].SecondValue := SecondPoint;
  FPoints[FLastPoint - 1].ValueType := cpvMulti;
  FPoints[FLastPoint - 1].Defined := true;
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddDoubleXYPoint(SingleXPoint, FirstPoint, SecondPoint: double;
  Color: TColor; Defined: Boolean);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].SingleValue := FirstPoint;
  FPoints[FLastPoint - 1].SingleXValue := SingleXPoint;
  FPoints[FLastPoint - 1].SecondValue := SecondPoint;
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ValueType := cpvMulti;
  FPoints[FLastPoint - 1].Defined := Defined;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddMultiPoints(HighPoint, LowPoint, OpenPoint,
  ClosePoint: Double; SingleDateTime: TDateTime; Color: TColor;
  Defined: Boolean);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].SingleValue := HighPoint;
  FPoints[FLastPoint - 1].HighValue := Highpoint;
  FPoints[FLastPoint - 1].LowValue := LowPoint;
  FPoints[FLastPoint - 1].OpenValue := OpenPoint;
  FPoints[FLastPoint - 1].CloseValue := ClosePoint;
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTime;
  FPoints[FLastPoint - 1].ValueType := cpvMulti;
  FPoints[FLastPoint - 1].Defined := Defined;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddPoints(SinglePoint: Double; PixelValue: integer);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := SinglePoint;
  FPoints[FLastPoint - 1].PixelValue1 := PixelValue;
  FPoints[FLastPoint - 1].PixelValue2 := PixelValue;
  FPoints[FLastPoint - 1].Defined := true;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;


procedure TChartSerie.AddPoints(SinglePoint: Double; PixelValue1, PixelValue2: integer;
  Defined: Boolean);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := SinglePoint;
  FPoints[FLastPoint - 1].PixelValue1 := PixelValue1;
  FPoints[FLastPoint - 1].PixelValue2 := PixelValue2;
  FPoints[FLastPoint - 1].Defined := Defined;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddPoints(SinglePoint: Double; PixelValue1, PixelValue2: integer);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := SinglePoint;
  FPoints[FLastPoint - 1].PixelValue1 := PixelValue1;
  FPoints[FLastPoint - 1].PixelValue2 := PixelValue2;
  FPoints[FLastPoint - 1].Defined := true;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddPiePoints(SinglePoint, RadiusValue: Double;
  legendvalue: String; Color, ColorTo: TColor; PieIndent: integer;
  Defined: Boolean);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := ColorTo;
  FPoints[FLastPoint - 1].SingleValue := SinglePoint;
  FPoints[FLastPoint - 1].SecondValue := RadiusValue;
  FPoints[FLastPoint - 1].PixelValue1 := PieIndent;
  FPoints[FLastPoint - 1].Defined := Defined;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  FPoints[FLastPoint - 1].LegendValue := legendvalue;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddPiePoints(SinglePoint: Double; Color, ColorTo: TColor;
  PieIndent: integer; Defined: Boolean);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := ColorTo;
  FPoints[FLastPoint - 1].SingleValue := SinglePoint;
  FPoints[FLastPoint - 1].PixelValue1 := PieIndent;
  FPoints[FLastPoint - 1].Defined := Defined;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddPoints(SinglePoint: Double; PixelValue1, PixelValue2: integer;
  SingleDateTime: TDateTime; Defined: Boolean);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := SinglePoint;
  FPoints[FLastPoint - 1].PixelValue1 := PixelValue1;
  FPoints[FLastPoint - 1].PixelValue2 := PixelValue2;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTime;
  FPoints[FLastPoint - 1].Defined := Defined;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddPoints(SinglePoint: Double; PixelValue1, PixelValue2: integer;
  SingleDateTime: TDateTime);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := SinglePoint;
  FPoints[FLastPoint - 1].PixelValue1 := PixelValue1;
  FPoints[FLastPoint - 1].PixelValue2 := PixelValue2;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTime;
  FPoints[FLastPoint - 1].Defined := true;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddMultiPoints(HighPoint, LowPoint, OpenPoint,
  ClosePoint: Double; Color: TColor; Defined: Boolean);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].SingleValue := HighPoint;
  FPoints[FLastPoint - 1].HighValue := Highpoint;
  FPoints[FLastPoint - 1].LowValue := LowPoint;
  FPoints[FLastPoint - 1].OpenValue := OpenPoint;
  FPoints[FLastPoint - 1].CloseValue := ClosePoint;
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].ValueType := cpvMulti;
  FPoints[FLastPoint - 1].Defined := Defined;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSinglePoint(SinglePoint: double;
  SingleDateTime: TDateTime; Defined: Boolean);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := SinglePoint;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTime;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  FPoints[FLastPoint - 1].Defined := Defined;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSinglePoint(SinglePoint: double; Defined: Boolean);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := SinglePoint;
  FPoints[FLastPoint - 1].Defined := Defined;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSinglePoint(SinglePoint: double;
  SingleDateTime: TDateTime; Color: TColor; Defined: Boolean);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].SingleValue := SinglePoint;
  FPoints[FLastPoint - 1].Defined := Defined;
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTime;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AnnotationChanged(Sender: TObject);
begin
  Changed;
end;

procedure TChartSerie.AddSinglePoint(SinglePoint: double; Color: TColor;
  Defined: Boolean);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].SingleValue := SinglePoint;
  FPoints[FLastPoint - 1].Defined := Defined;
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddPiePoints(SinglePoint: Double; legendvalue: String = ''; Color: TColor = clNone; ColorTo: TColor = clNone;
  PieIndent: integer = 0; Defined: Boolean = true);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := ColorTo;
  FPoints[FLastPoint - 1].SingleValue := SinglePoint;
  FPoints[FLastPoint - 1].PixelValue1 := PieIndent;
  FPoints[FLastPoint - 1].Defined := Defined;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  FPoints[FLastPoint - 1].LegendValue := legendvalue;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSinglePoint(SinglePoint: double;
  SingleDateTime: TDateTime; XAxisValue: String);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := SinglePoint;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTime;
  FPoints[FLastPoint - 1].LegendValue := XAxisValue;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  FPoints[FLastPoint - 1].Defined := true;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSinglePoint(SinglePoint: double;
  SingleDateTime: TDateTime; Defined: Boolean; XAxisValue: String);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := SinglePoint;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTime;
  FPoints[FLastPoint - 1].LegendValue := XAxisValue;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  FPoints[FLastPoint - 1].Defined := Defined;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSinglePoint(SinglePoint: double; XAxisValue: String);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := SinglePoint;
  FPoints[FLastPoint - 1].LegendValue := XAxisValue;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  FPoints[FLastPoint - 1].Defined := true;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSinglePoint(SinglePoint: double; Defined: Boolean;
  XAxisValue: String);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := SinglePoint;
  FPoints[FLastPoint - 1].LegendValue := XAxisValue;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  FPoints[FLastPoint - 1].Defined := Defined;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSinglePoint(SinglePoint: double;
  SingleDateTime: TDateTime; Color: TColor; XAxisValue: String);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := SinglePoint;
  FPoints[FLastPoint - 1].LegendValue := XAxisValue;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTime;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  FPoints[FLastPoint - 1].Defined := true;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSinglePoint(SinglePoint: double;
  SingleDateTime: TDateTime; Color: TColor; Defined: Boolean;
  XAxisValue: String);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := SinglePoint;
  FPoints[FLastPoint - 1].LegendValue := XAxisValue;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTime;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  FPoints[FLastPoint - 1].Defined := Defined;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSinglePoint(SinglePoint: double; Color: TColor;
  XAxisValue: String);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := SinglePoint;
  FPoints[FLastPoint - 1].LegendValue := XAxisValue;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  FPoints[FLastPoint - 1].Defined := true;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSinglePoint(SinglePoint: double; Color: TColor;
  Defined: Boolean; XAxisValue: String);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := SinglePoint;
  FPoints[FLastPoint - 1].LegendValue := XAxisValue;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  FPoints[FLastPoint - 1].Defined := Defined;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddPiePoints(SinglePoint, RadiusValue: Double; Color,
  ColorTo: TColor; PieIndent: integer; Defined: Boolean);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := ColorTo;
  FPoints[FLastPoint - 1].SingleValue := SinglePoint;
  FPoints[FLastPoint - 1].SecondValue := RadiusValue;
  FPoints[FLastPoint - 1].PixelValue1 := PieIndent;
  FPoints[FLastPoint - 1].Defined := Defined;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSinglePoint(SinglePoint: double; Color,
  ColorTo: TColor; XAxisValue: String);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := ColorTo;
  FPoints[FLastPoint - 1].SingleValue := SinglePoint;
  FPoints[FLastPoint - 1].Defined := true;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  FPoints[FLastPoint - 1].LegendValue := XAxisValue;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSinglePoint(SingleValueStart, SingleValueEnd: Double;
  Text: String; Color, ColorTo, BorderColor, TextColor: TColor;
  GradientDirection: TChartGradientDirection);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := ColorTo;
  FPoints[FLastPoint - 1].SingleValue := SingleValueStart;
  FPoints[FLastPoint - 1].SingleXValue := SingleValueEnd;
  FPoints[FLastPoint - 1].LegendValue := Text;
  FPoints[FLastPoint - 1].TextColor := TextColor;
  FPoints[FLastPoint - 1].BorderColor := BorderColor;
  FPoints[FLastPoint - 1].GradientDirection := GradientDirection;
  FPoints[FLastPoint - 1].Defined := true;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSinglePoint(Text: String; SingleDateTimeStart,
  SingleDateTimeEnd: TDateTime; Color, ColorTo, BorderColor,
  TextColor: TColor; GradientDirection: TChartGradientDirection);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := ColorTo;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTimeStart;
  FPoints[FLastPoint - 1].TimeXStamp := SingleDateTimeEnd;
  FPoints[FLastPoint - 1].LegendValue := Text;
  FPoints[FLastPoint - 1].TextColor := TextColor;
  FPoints[FLastPoint - 1].BorderColor := BorderColor;
  FPoints[FLastPoint - 1].GradientDirection := GradientDirection;
  FPoints[FLastPoint - 1].Defined := true;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddMultiPoints(Minimum, Q1, Median, Q3, Maximum: Double;
  Defined: Boolean);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := Q1;
  FPoints[FLastPoint - 1].HighValue := Maximum;
  FPoints[FLastPoint - 1].LowValue := Minimum;
  FPoints[FLastPoint - 1].MedValue := Median;
  FPoints[FLastPoint - 1].OpenValue := Q3;
  FPoints[FLastPoint - 1].CloseValue := Q1;
  FPoints[FLastPoint - 1].ValueType := cpvMulti;
  FPoints[FLastPoint - 1].Defined := Defined;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddMultiPoints(Minimum, Q1, Median, Q3, Maximum: Double;
  SingleDateTime: TDateTime);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := Q1;
  FPoints[FLastPoint - 1].HighValue := Maximum;
  FPoints[FLastPoint - 1].LowValue := Minimum;
  FPoints[FLastPoint - 1].MedValue := Median;
  FPoints[FLastPoint - 1].OpenValue := Q3;
  FPoints[FLastPoint - 1].CloseValue := Q1;
  FPoints[FLastPoint - 1].ValueType := cpvMulti;
  FPoints[FLastPoint - 1].Defined := true;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTime;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddMultiPoints(HighPoint, LowPoint, OpenPoint,
  ClosePoint: Double; XAxisValue: String);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := ClosePoint;
  FPoints[FLastPoint - 1].HighValue := Highpoint;
  FPoints[FLastPoint - 1].LowValue := LowPoint;
  FPoints[FLastPoint - 1].OpenValue := OpenPoint;
  FPoints[FLastPoint - 1].CloseValue := ClosePoint;
  FPoints[FLastPoint - 1].ValueType := cpvMulti;
  FPoints[FLastPoint - 1].Defined := true;
  FPoints[FLastPoint - 1].LegendValue := XAxisValue;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddMultiPoints(Minimum, Q1, Median, Q3, Maximum: Double;
  XAxisValue: String);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := Q1;
  FPoints[FLastPoint - 1].HighValue := Maximum;
  FPoints[FLastPoint - 1].LowValue := Minimum;
  FPoints[FLastPoint - 1].MedValue := Median;
  FPoints[FLastPoint - 1].OpenValue := Q3;
  FPoints[FLastPoint - 1].CloseValue := Q1;
  FPoints[FLastPoint - 1].ValueType := cpvMulti;
  FPoints[FLastPoint - 1].Defined := true;
  FPoints[FLastPoint - 1].LegendValue := XAxisValue;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddMultiPoints(Minimum, Q1, Median, Q3, Maximum: Double;
  SingleDateTime: TDateTime; Defined: Boolean);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := Q1;
  FPoints[FLastPoint - 1].HighValue := Maximum;
  FPoints[FLastPoint - 1].LowValue := Minimum;
  FPoints[FLastPoint - 1].MedValue := Median;
  FPoints[FLastPoint - 1].OpenValue := Q3;
  FPoints[FLastPoint - 1].CloseValue := Q1;
  FPoints[FLastPoint - 1].ValueType := cpvMulti;
  FPoints[FLastPoint - 1].Defined := true;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTime;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddMultiPoints(Minimum, Q1, Median, Q3, Maximum: Double;
  SingleDateTime: TDateTime; Color: TColor);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].SingleValue := Q1;
  FPoints[FLastPoint - 1].HighValue := Maximum;
  FPoints[FLastPoint - 1].LowValue := Minimum;
  FPoints[FLastPoint - 1].MedValue := Median;
  FPoints[FLastPoint - 1].OpenValue := Q3;
  FPoints[FLastPoint - 1].CloseValue := Q1;
  FPoints[FLastPoint - 1].ValueType := cpvMulti;
  FPoints[FLastPoint - 1].Defined := true;
  FPoints[FLastPoint - 1].TimeStamp :=  SingleDateTime;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddMultiPoints(Minimum, Q1, Median, Q3, Maximum: Double;
  SingleDateTime: TDateTime; Color: TColor; Defined: Boolean);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := Q1;
  FPoints[FLastPoint - 1].HighValue := Maximum;
  FPoints[FLastPoint - 1].LowValue := Minimum;
  FPoints[FLastPoint - 1].MedValue := Median;
  FPoints[FLastPoint - 1].OpenValue := Q3;
  FPoints[FLastPoint - 1].CloseValue := Q1;
  FPoints[FLastPoint - 1].ValueType := cpvMulti;
  FPoints[FLastPoint - 1].Defined := Defined;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTime;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddMultiPoints(Minimum, Q1, Median, Q3, Maximum: Double;
  Color: TColor);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := Q1;
  FPoints[FLastPoint - 1].HighValue := Maximum;
  FPoints[FLastPoint - 1].LowValue := Minimum;
  FPoints[FLastPoint - 1].MedValue := Median;
  FPoints[FLastPoint - 1].OpenValue := Q3;
  FPoints[FLastPoint - 1].CloseValue := Q1;
  FPoints[FLastPoint - 1].ValueType := cpvMulti;
  FPoints[FLastPoint - 1].Defined := true;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddMultiPoints(Minimum, Q1, Median, Q3, Maximum: Double;
  Color: TColor; Defined: Boolean);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := Q1;
  FPoints[FLastPoint - 1].HighValue := Maximum;
  FPoints[FLastPoint - 1].LowValue := Minimum;
  FPoints[FLastPoint - 1].MedValue := Median;
  FPoints[FLastPoint - 1].OpenValue := Q3;
  FPoints[FLastPoint - 1].CloseValue := Q1;
  FPoints[FLastPoint - 1].ValueType := cpvMulti;
  FPoints[FLastPoint - 1].Defined := Defined;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSingleXYPoint(SingleXPoint, SingleYPoint: double);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].SingleValue := SingleYPoint;
  FPoints[FLastPoint - 1].SingleXValue := SingleXPoint;
  FPoints[FLastPoint - 1].Defined := true;
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSingleXYPoint(SingleXPoint, SingleYPoint: double;
  SingleDateTime: TDateTime);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := SingleYPoint;
  FPoints[FLastPoint - 1].SingleXValue := SingleXPoint;
  FPoints[FLastPoint - 1].TimeStamp := SingleDatetime;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  FPoints[FLastPoint - 1].Defined := true;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSingleXYPoint(SingleXPoint, SingleYPoint: double;
  SingleDateTime, SingleXDateTime: TDateTime);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := SingleYPoint;
  FPoints[FLastPoint - 1].SingleXValue := SingleXPoint;
  FPoints[FLastPoint - 1].TimeStamp := SingleDatetime;
  FPoints[FLastPoint - 1].TimeXStamp := SingleXDatetime;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  FPoints[FLastPoint - 1].Defined := true;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSingleXYPoint(SingleXPoint, SingleYPoint: double;
  SingleDateTime: TDateTime; Color: TColor);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].SingleValue := SingleYPoint;
  FPoints[FLastPoint - 1].SingleXValue := SingleXPoint;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTime;
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  FPoints[FLastPoint - 1].Defined := true;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSingleXYPoint(SingleXPoint, SingleYPoint: double;
  SingleDateTime, SingleXDateTime: TDateTime; Color: TColor);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].SingleValue := SingleYPoint;
  FPoints[FLastPoint - 1].SingleXValue := SingleXPoint;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTime;
  FPoints[FLastPoint - 1].TimeXStamp := SingleXDateTime;
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  FPoints[FLastPoint - 1].Defined := true;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSingleXYPoint(SingleXPoint, SingleYPoint: double; Color: TColor);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].SingleValue := SingleYPoint;
  FPoints[FLastPoint - 1].SingleXValue := SingleXPoint;
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  FPoints[FLastPoint - 1].Defined := true;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSingleXYPoint(SingleXPoint, SingleYPoint: double;
  SingleDateTime: TDateTime; Defined: Boolean);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := SingleYPoint;
  FPoints[FLastPoint - 1].SingleXValue := SingleXPoint;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTime;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  FPoints[FLastPoint - 1].Defined := Defined;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSingleXYPoint(SingleXPoint, SingleYPoint: double;
  SingleDateTime, SingleXDateTime: TDateTime; Defined: Boolean);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := SingleYPoint;
  FPoints[FLastPoint - 1].SingleXValue := SingleXPoint;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTime;
  FPoints[FLastPoint - 1].TimeXStamp := SingleDateTime;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  FPoints[FLastPoint - 1].Defined := Defined;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSingleXYPoint(SingleXPoint, SingleYPoint: double; Defined: Boolean);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := SingleYPoint;
  FPoints[FLastPoint - 1].SingleXValue := SingleXPoint;
  FPoints[FLastPoint - 1].Defined := Defined;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSingleXYPoint(SingleXPoint, SingleYPoint: double;
  SingleDateTime: TDateTime; Color: TColor; Defined: Boolean);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].SingleValue := SingleYPoint;
  FPoints[FLastPoint - 1].SingleXValue := SingleXPoint;
  FPoints[FLastPoint - 1].Defined := Defined;
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTime;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSingleXYPoint(SingleXPoint, SingleYPoint: double;
  SingleDateTime, SingleXDateTime: TDateTime; Color: TColor; Defined: Boolean);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].SingleValue := SingleYPoint;
  FPoints[FLastPoint - 1].SingleXValue := SingleXPoint;
  FPoints[FLastPoint - 1].Defined := Defined;
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTime;
  FPoints[FLastPoint - 1].TimeXStamp := SingleXDateTime;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSingleXYPoint(SingleXPoint, SingleYPoint: double; Color: TColor;
  Defined: Boolean);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].SingleValue := SingleYPoint;
  FPoints[FLastPoint - 1].SingleXValue := SingleXPoint;
  FPoints[FLastPoint - 1].Defined := Defined;
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSingleXYPoint(SingleXPoint, SingleYPoint: double;
  SingleDateTime: TDateTime; XAxisValue: String);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := SingleYPoint;
  FPoints[FLastPoint - 1].SingleXValue := SingleXPoint;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTime;
  FPoints[FLastPoint - 1].LegendValue := XAxisValue;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  FPoints[FLastPoint - 1].Defined := true;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSingleXYPoint(SingleXPoint, SingleYPoint: double;
  SingleDateTime, SingleXDateTime: TDateTime; XAxisValue: String);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := SingleYPoint;
  FPoints[FLastPoint - 1].SingleXValue := SingleXPoint;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTime;
  FPoints[FLastPoint - 1].TimeXStamp := SingleXDateTime;
  FPoints[FLastPoint - 1].LegendValue := XAxisValue;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  FPoints[FLastPoint - 1].Defined := true;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSingleXYPoint(SingleXPoint, SingleYPoint: double;
  SingleDateTime: TDateTime; Defined: Boolean; XAxisValue: String);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := SingleYPoint;
  FPoints[FLastPoint - 1].SingleXValue := SingleXPoint;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTime;
  FPoints[FLastPoint - 1].LegendValue := XAxisValue;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  FPoints[FLastPoint - 1].Defined := Defined;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSingleXYPoint(SingleXPoint, SingleYPoint: double;
  SingleDateTime, SingleXDateTime: TDateTime; Defined: Boolean; XAxisValue: String);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := SingleYPoint;
  FPoints[FLastPoint - 1].SingleXValue := SingleXPoint;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTime;
  FPoints[FLastPoint - 1].TimeXStamp := SingleXDateTime;
  FPoints[FLastPoint - 1].LegendValue := XAxisValue;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  FPoints[FLastPoint - 1].Defined := Defined;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSingleXYPoint(SingleXPoint, SingleYPoint: double; XAxisValue: String);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := SingleYPoint;
  FPoints[FLastPoint - 1].SingleXValue := SingleXPoint;
  FPoints[FLastPoint - 1].LegendValue := XAxisValue;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  FPoints[FLastPoint - 1].Defined := true;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSingleXYPoint(SingleXPoint, SingleYPoint: double; Defined: Boolean;
  XAxisValue: String);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := clNone;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := SingleYPoint;
  FPoints[FLastPoint - 1].SingleXValue := SingleXPoint;
  FPoints[FLastPoint - 1].LegendValue := XAxisValue;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  FPoints[FLastPoint - 1].Defined := Defined;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSingleXYPoint(SingleXPoint, SingleYPoint: double;
  SingleDateTime: TDateTime; Color: TColor; XAxisValue: String);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := SingleYPoint;
  FPoints[FLastPoint - 1].SingleXValue := SingleXPoint;
  FPoints[FLastPoint - 1].LegendValue := XAxisValue;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTime;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  FPoints[FLastPoint - 1].Defined := true;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSingleXYPoint(SingleXPoint, SingleYPoint: double;
  SingleDateTime, SingleXDateTime: TDateTime; Color: TColor; XAxisValue: String);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := SingleYPoint;
  FPoints[FLastPoint - 1].SingleXValue := SingleXPoint;
  FPoints[FLastPoint - 1].LegendValue := XAxisValue;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTime;
  FPoints[FLastPoint - 1].TimeXStamp := SingleXDateTime;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  FPoints[FLastPoint - 1].Defined := true;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSingleXYPoint(SingleXPoint, SingleYPoint: double;
  SingleDateTime: TDateTime; Color: TColor; Defined: Boolean;
  XAxisValue: String);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := SingleYPoint;
  FPoints[FLastPoint - 1].SingleXValue := SingleXPoint;
  FPoints[FLastPoint - 1].LegendValue := XAxisValue;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTime;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  FPoints[FLastPoint - 1].Defined := Defined;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSingleXYPoint(SingleXPoint, SingleYPoint: double;
  SingleDateTime, SingleXDateTime: TDateTime; Color: TColor; Defined: Boolean;
  XAxisValue: String);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := SingleYPoint;
  FPoints[FLastPoint - 1].SingleXValue := SingleXPoint;
  FPoints[FLastPoint - 1].LegendValue := XAxisValue;
  FPoints[FLastPoint - 1].TimeStamp := SingleDateTime;
  FPoints[FLastPoint - 1].TimeXStamp := SingleXDateTime;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  FPoints[FLastPoint - 1].Defined := Defined;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSingleXYPoint(SingleXPoint, SingleYPoint: double; Color: TColor;
  XAxisValue: String);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := SingleYPoint;
  FPoints[FLastPoint - 1].SingleXValue := SingleXPoint;
  FPoints[FLastPoint - 1].LegendValue := XAxisValue;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  FPoints[FLastPoint - 1].Defined := true;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSingleXYPoint(SingleXPoint, SingleYPoint: double; Color: TColor;
  Defined: Boolean; XAxisValue: String);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := clNone;
  FPoints[FLastPoint - 1].SingleValue := SingleYPoint;
  FPoints[FLastPoint - 1].SingleXValue := SingleXPoint;
  FPoints[FLastPoint - 1].LegendValue := XAxisValue;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  FPoints[FLastPoint - 1].Defined := Defined;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

procedure TChartSerie.AddSingleXYPoint(SingleXPoint, SingleYPoint: double; Color,
  ColorTo: TColor; XAxisValue: String);
begin
  Inc(FLastPoint);
  SetLength(FPoints, FLastPoint);
  FPoints[FLastPoint - 1].Color := Color;
  FPoints[FLastPoint - 1].ColorTo := ColorTo;
  FPoints[FLastPoint - 1].SingleValue := SingleYPoint;
  FPoints[FLastPoint - 1].SingleXValue := SingleXPoint;
  FPoints[FLastPoint - 1].Defined := true;
  FPoints[FLastPoint - 1].ValueType := cpvSingle;
  FPoints[FLastPoint - 1].LegendValue := XAxisValue;
  if (MaximumPoints <> -1) and (FLastPoint > MaximumPoints) then
  begin
    RemovePoint(0);
    Dec(FLastPoint);
  end;
end;

{ TChartSeries }

function TChartSeries.Add: TChartSerie;
begin
  FMode := cmInit;
  Result := TChartSerie(inherited Add);
end;

procedure TChartSeries.Assign(Source: TPersistent);
begin
  inherited;
  if (Source is TChartSeries) then
  begin
    FSerieValueTotals := (Source as TChartSeries).SerieValueTotals;
    FDonutMode := (Source as TChartSeries).DonutMode;
    FBarChartSpacing := (Source as TChartSeries).BarChartSpacing;
    FBarChartSpacingType := (Source as TChartSeries).BarChartSpacingType;
    FChartMode := (Source as TChartseries).ChartMode;
    Changed;
  end;
end;

procedure TChartSeries.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TChartSeries.Create(AOwner: TAdvChart);
begin
  inherited Create(AOwner, GetItemClass);
  FOwner := AOwner;
  FDonutMode := dmNormal;
  FSerieValueTotals := false;
  FBarChartSpacing := 20;
  FBarChartSpacingType := wtPercentage;
  FChartMode := dmVertical;
end;

destructor TChartSeries.Destroy;
begin
  inherited;
end;

function TChartSeries.GetItemClass: TCollectionItemClass;
begin
  Result := TChartSerie;
end;

function TChartSeries.GetPreviousChartIndex(ChartType: TChartType; Index: Integer; GroupIndex: Integer): integer;
var
  cnt: integer;
  found: boolean;
begin
  cnt := 1;
  found := false;
  result := -1;
  while (found = false) and (Index - cnt >= 0) do
  begin
    if (Items[Index - cnt].ChartType = ChartType) and (Items[Index - cnt].GroupIndex = GroupIndex) then
    begin
      found := true;
      result := Index - cnt;
    end
    else
      Inc(cnt);
  end;
end;

function TChartSeries.GetSeriesRectangle: TRect;
begin
  Result := FSeriesRectangle;
end;

procedure TChartSeries.DrawMarkers(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double);
var
  i: integer;
  HRGN: THandle;
begin
  HRGN := CreateRectRgn(R.Left, R.Top, R.Right, R.Bottom);
  SelectClipRgn(Canvas.Handle,HRGN);
  for I := 0 to Count - 1 do
  begin
    with Items[I] do
    begin
      FClipRgn := HRGN;
      if (YScale > 0) then
      begin
        if ChartType in [ctStackedPercArea, ctStackedBar, ctStackedPercBar, ctStackedArea] then
          DrawMarkers(Canvas, R, ScaleX, ScaleY);
      end;
    end;
  end;
  SelectClipRgn(Canvas.Handle,0);
  DeleteObject(HRGN);
end;

procedure TChartSeries.DrawPieLegends(Canvas: TCanvas; R: TRect; ScaleX,
  ScaleY: Double);
var
  i: integer;
begin
  for I := 0 to Count - 1 do
    with Items[I] do
      DrawLegend(Canvas, R, ScaleX, ScaleY, True);
end;

procedure TChartSeries.Draw(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double; HRGN: THandle);
var
  si, I, dpi: integer;
  drawpt: TPoint;
  rsel: TRect;
  s: TChartSerie;
  c: integer;
  dm: Boolean;
begin
  dm := FOwner.Series.IsHorizontal;
  FcntBar := 0;
  for I := 0 to Count - 1 do
  begin
    with Items[I] do
    begin
      if (YScale > 0) then
      begin
        FClipRgn := HRGN;
        FItemIndex := I;
        Init(Canvas, R, ScaleX, ScaleY);
        Draw(Canvas, R, Scalex, ScaleY);
        if not IsEnabled3D then
        begin
          case ChartType of
            ctLine, ctDigitalLine, ctArea, ctBar, ctLineBar, ctHistogram, ctLineHistogram,
            ctCandleStick, ctLineCandleStick, ctOHLC, ctMarkers, ctError,
            ctArrow, ctScaledArrow, ctBubble, ctScaledBubble, ctBand, ctBoxPlot, ctRenko, ctXYLine, ctXYDigitalLine, ctGantt, ctXYMarkers:
            begin
              DrawMarkers(Canvas, R, Scalex, ScaleY);
            end;
          end;
          if not ShowAnnotationsOnTop then
            DrawAnnotations(Canvas, R, ScaleX, ScaleY);
        end;
      end;
    end;
  end;

  for i := 0 to FOwner.Range.RangeTo - FOwner.Range.RangeFrom do
  begin
    for si := 0 to count - 1 do
    begin
      s := Items[si];
      if s.IsEnabled3D then
      begin
        if i <= Length(s.FStackedRectsBar) - 1 then
        begin
          if (s.ChartType = ctBar) or (s.ChartType = ctStackedbar) or (s.ChartType = ctStackedPercBar) or
            (s.ChartType = ctHistogram) or (s.ChartType = ctLineBar) or (s.ChartType = ctLineHistogram) then
          begin
            if s.BarShape = bsRectangle then
              s.Draw3DBar(Canvas,s.FStackedRectsBar[i].SColor, s.FStackedRectsBar[i].SColorTo, s.FStackedRectsBar[i].R, ScaleX, SCaleY);
            s.DrawBar(Canvas, s.FStackedRectsBar[i].SColor, s.FStackedRectsBar[i].SColorTo, s.FStackedRectsBar[i].R, ScaleX, ScaleY, i, s.GetPoint(i).SingleValue);
          end;
        end;
      end;
    end;
  end;

  for I := 0 to Count - 1 do
  begin
    with Items[I] do
    begin
      if (YScale > 0) then
      begin
        if IsEnabled3D then
        begin
          case ChartType of
            ctLine, ctDigitalLine, ctArea, ctBar, ctLineBar, ctHistogram, ctLineHistogram,
            ctCandleStick, ctLineCandleStick, ctOHLC, ctMarkers, ctError,
            ctArrow, ctScaledArrow, ctBubble, ctScaledBubble, ctBand, ctBoxPlot, ctRenko, ctXYLine, ctXYDigitalLine, ctGantt, ctXYMarkers:
            begin
              DrawMarkers(Canvas, R, Scalex, ScaleY);
            end;
          end;
          if not ShowAnnotationsOnTop then
            DrawAnnotations(Canvas, R, ScaleX, ScaleY);
        end;
      end;
    end;
  end;

  for I := 0 to Count - 1 do
  begin
    with Items[I] do
    begin
      if SelectedIndex <> -1 then
      begin
        if not IsPieChart then
        begin
          if Chart.Range.RangeFrom > 0 then
            dpi := SelectedIndex - Chart.Range.RangeFrom
          else
            dpi := SelectedIndex;

          if (dpi >= 0) and (dpi < Length(FDrawValuesDP)) then
          begin
            drawpt := FDrawValuesDP[dpi];
            drawpt := FDrawPoints[dpi];
            case ChartType of
              ctStackedBar, ctStackedPercBar:
              begin
                if (Chart.Series.Count > 1) and (I > 0) then
                begin
                  if ((Chart.Series[I - 1].ChartType = ctStackedBar) or (Chart.Series[I - 1].ChartType = ctStackedPercBar)) and ((dpi >= 0) and (dpi <= Length(Chart.Series[i - 1].DrawValuesDP) - 1)) then
                  begin
                    if dm then
                      rsel := Bounds(DrawValuesDP[dpi].X - Abs(DrawValuesDP[dpi].X - Chart.Series[I - 1].DrawValuesDP[dpi].X), DrawValuesDP[dpi].Y, Abs(DrawValuesDP[dpi].X - Chart.Series[I - 1].DrawValuesDP[dpi].X), GetBarWidth(1))
                    else
                      rsel := Bounds(DrawValuesDP[dpi].X, DrawValuesDP[dpi].Y, GetBarWidth(1), Abs(DrawValuesDP[dpi].Y - Chart.Series[I - 1].DrawValuesDP[dpi].Y));
                  end;
                end
                else
                begin
                  if dm then
                    rsel := Bounds(ValueToY(0, Chart.Series.SeriesRectangle), DrawValuesDP[dpi].Y, Abs(ValueToY(0, Chart.Series.SeriesRectangle) - DrawValuesDP[dpi].X), GetBarWidth(1))
                  else
                    rsel := Bounds(DrawValuesDP[dpi].X, DrawValuesDP[dpi].Y, GetBarWidth(1), Abs(ValueToY(0, Chart.Series.SeriesRectangle) - DrawValuesDP[dpi].Y))
                end;
              end;
              ctBar, ctLineBar, ctHistogram, ctLineHistogram:
              begin
                if dm then
                begin
                  c := ValueToY(ZeroReferencePoint, Chart.Series.SeriesRectangle) - DrawValuesDP[dpi].X;
                  if c < 0 then
                    rsel := Bounds(ValueToY(ZeroReferencePoint, Chart.Series.SeriesRectangle), DrawValuesDP[dpi].Y, Abs(ValueToY(ZeroReferencePoint, Chart.Series.SeriesRectangle) - DrawValuesDP[dpi].X), GetBarWidth(1))
                  else
                    rsel := Bounds(DrawValuesDP[dpi].X, DrawValuesDP[dpi].Y, Abs(ValueToY(ZeroReferencePoint, Chart.Series.SeriesRectangle) - DrawValuesDP[dpi].X), GetBarWidth(1));
                end
                else
                begin
                  c := ValueToY(ZeroReferencePoint, Chart.Series.SeriesRectangle) - DrawValuesDP[dpi].Y;
                  if c < 0 then
                    rsel := Bounds(DrawValuesDP[dpi].X, ValueToY(ZeroReferencePoint, Chart.Series.SeriesRectangle), GetBarWidth(1), Abs(ValueToY(ZeroReferencePoint, Chart.Series.SeriesRectangle) - DrawValuesDP[dpi].Y))
                  else
                    rsel := Bounds(DrawValuesDP[dpi].X, DrawValuesDP[dpi].Y, GetBarWidth(1), Abs(ValueToY(ZeroReferencePoint, Chart.Series.SeriesRectangle) - DrawValuesDP[dpi].Y));
                end;
              end;
              ctHalfspider, ctspider, ctPie, ctFunnel, ctHalfPie, ctDonut, ctHalfDonut,
              ctSizedPie, ctSizedHalfPie, ctSizedDonut, ctSizedHalfDonut, ctVarRadiusPie, ctVarRadiusHalfPie, ctVarRadiusDonut,
              ctVarRadiusHalfDonut:
              begin
              end;
              else
                rsel := Bounds(DrawValuesDP[dpi].X - 7, DrawValuesDP[dpi].Y - 7, 14, 14);
            end;

            if not IsPieChart then
              DrawSelected(canvas, rsel);
          end
        end
        else
        begin
          if (ChartType = ctFunnel) and (SelectedIndex >= 0) and (SelectedIndex <= Length(DrawValuesFunnel) - 1) then
            DrawSelectedFunnel(Canvas, DrawValuesFunnel[SelectedIndex])
          else if (SelectedIndex >= 0) and (SelectedIndex <= Length(DrawValuesSlice) - 1) then
            DrawSelectedSlice(Canvas, DrawValuesSlice[SelectedIndex]);
        end;
      end;
    end;
  end;
  //new
  DrawPieLegends(Canvas, R, ScaleX, ScaleY);
end;

procedure TChartSeries.DrawAnnotations(Canvas: TCanvas; R: TRect; ScaleX,
  ScaleY: Double);
var
  I: integer;
  HRGN: THandle;
begin
  HRGN := CreateRectRgn(R.Left, R.Top, R.Right, R.Bottom);
  SelectClipRgn(Canvas.Handle,HRGN);

  for I := 0 to Count - 1 do
  begin
    with Items[I] do
    begin
      if (YScale > 0) then
      begin
      FClipRgn := HRGN;
      if ShowAnnotationsOnTop then
        DrawAnnotations(Canvas, R, ScaleX, ScaleY);
      end;
    end;
  end;

  SelectClipRgn(Canvas.Handle,0);
  DeleteObject(HRGN);
end;

procedure TChartSeries.DrawChartValues(Canvas: TCanvas; R: TRect; ScaleX,
  ScaleY: Double);
var
  i: integer;
  HRGN: THandle;
begin
  HRGN := CreateRectRgn(R.Left, R.Top, R.Right, R.Bottom);
  SelectClipRgn(Canvas.Handle,HRGN);

  for I := 0 to Count - 1 do
    if Length(Items[I].DrawValuesDP) > 0 then
      Items[I].DrawValues(Canvas, R, ScaleX, ScaleY);

  SelectClipRgn(Canvas.Handle,0);
  DeleteObject(HRGN);
end;

procedure TChartSeries.DrawXValues(Canvas: TCanvas; R: TRect; Top: boolean; ScaleX, ScaleY: Double);
var
  I: integer;
  XAxisY: integer;
begin
  if FOwner.Series.IsHorizontal then
  begin
    if Top then
      XAxisY := R.Left
    else
      XAxisY := R.Right;
  end
  else
  begin
    if Top then
      XAxisY := R.Bottom
    else
      XAxisY := R.Top;
  end;

  for I := 0 to Count - 1 do
  begin
    if (Items[I].ChartType <> ctNone) and (Items[I].SerieType <> stZoomControl) and Items[i].Visible then
    begin
      Items[I].DrawXValues(Canvas, R, XAxisY, Top, ScaleX, ScaleY);
    end;
  end;
end;

procedure TChartSeries.DrawYValues(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double);
var
  I: integer;
begin
  for I := 0 to Self.Count - 1 do
    Self.Items[I].DrawYValues(Canvas, R, ScaleX, ScaleY);
end;

procedure TChartSeries.ForceInit(Force: Boolean);
var
  I: integer;
begin
  for I := 0 to Self.Count - 1 do
  begin
    Items[I].FForceInit := Force;
  end;
end;

function TChartSeries.IsHorizontal: Boolean;
var
  isp: Boolean;
  i: integer;
begin
  isp := false;
  for I := 0 to Count - 1 do
    if Items[I].IsPieChart then
      isp := true;

  Result := (ChartMode = dmHorizontal) and not isp;
end;

function TChartSeries.GetCountChartType(ChartType: TChartType): integer;
var
  cnt: Integer;
  I: Integer;
begin
  cnt := 0;
  for I := 0 to Count - 1 do
  begin
    if (Items[I].ChartType = ChartType) and (Items[i].Visible) then
      inc(cnt);
  end;

  if Assigned(FOwner.OnGetCountChartType) then
    FOwner.OnGetCountChartType(FOwner, ChartType, cnt);

  Result := cnt;
end;

function TChartSeries.GetCountGroupedChartType(ChartType: TChartType): integer;
var
  cnt: Integer;
  I: Integer;
  gpidx: integer;
begin
  cnt := -1;
  gpidx := 0;
  for I := 0 to Count - 1 do
  begin
    if (Items[I].ChartType = ChartType) and (Items[i].Visible) then
    begin
      if Items[i].GroupIndex > cnt then
      begin
        cnt := Items[i].GroupIndex;
        Inc(gpidx);
      end;
    end;
  end;

  if Assigned(FOwner.OnGetCountGroupedChartType) then
    FOwner.OnGetCountGroupedChartType(FOwner, ChartType, gpidx);

  Result := gpidx;
end;

function TChartSeries.GetItem(Index: Integer): TChartSerie;
begin
  Result := TChartSerie(inherited GetItem(Index));
end;

function TChartSeries.Insert(index: integer): TChartSerie;
begin
  FMode := cmInit;
  {$IFDEF DELPHI4_LVL}
  Result := TChartSerie(inherited Insert(Index));
  {$ELSE}
  Result := TChartSerie(inherited Add);
  {$ENDIF}
end;

procedure TChartSeries.LoadFromFile(ini: TMemIniFile;Section: String; AutoCreateSeries: Boolean = False);
var
  I: Integer;
  aSeriesCount: Integer;
begin
  SerieValueTotals := ini.ReadBool(Section, 'SerieValueTotals', SerieValueTotals);
  DonutMode := TChartSeriesDonutMode(ini.ReadInteger(Section, 'DonutMode', Integer(DonutMode)));
  BarChartSpacing := ini.ReadInteger(Section, 'BarChartSpacing', BarChartSpacing);
  BarChartSpacingType := TChartSerieValueWidthType(ini.ReadInteger(Section, 'BarChartSpacingType', Integer(BarChartSpacingType)));
  ChartMode := TChartDrawingMode(ini.ReadInteger(Section, 'ChartDrawingMode', Integer(ChartMode)));

  if AutoCreateSeries then
  begin
    aSeriesCount := ini.ReadInteger(Section, 'SeriesCount', 0);
    for I := 0 to aSeriesCount - 1 do
      Self.Add;
  end;

  for I := 0 to Self.Count - 1 do
    Self.Items[I].LoadFromFile(ini, Section + '.Serie' + IntToStr(I));
end;

procedure TChartSeries.SaveToFile(ini: TMemIniFile;Section: String);
var
  I: Integer;
begin
 ini.WriteBool(Section, 'SerieValueTotals', SerieValueTotals);
 ini.WriteInteger(Section, 'DonutMode', Integer(DonutMode));
 ini.WriteInteger(Section, 'BarChartSpacing', BarChartSpacing);
 ini.WriteInteger(Section, 'BarChartSpacingType', Integer(BarChartSpacingType));
 ini.WriteInteger(Section, 'ChartDrawingMode', Integer(ChartMode));
 ini.WriteInteger(Section, 'SeriesCount', Self.Count);
 for I := 0 to Self.Count - 1 do
   Self.Items[I].SaveToFile(ini, Section + '.Serie' + IntToStr(I));
end;

procedure TChartSeries.SerieChanged(Sender: TObject);
begin
  Changed;
end;

procedure TChartSeries.SetBarChartSpacing(const Value: integer);
begin
  if FBarChartSpacing <> value then
  begin
    FBarChartSpacing := Value;
    Changed;
  end;
end;

procedure TChartSeries.SetBarChartSpacingType(
  const Value: TChartSerieValueWidthType);
begin
  if FBarChartSpacingType <> value then
  begin
    FBarChartSpacingType := value;
    Changed;
  end;
end;

procedure TChartSeries.SetChartMode(const Value: TChartDrawingMode);
begin
  if FChartMode <> value then
  begin
    FChartMode := Value;
    Changed;
  end;
end;

procedure TChartSeries.SetDonutMode(const Value: TChartSeriesDonutMode);
begin
  if FDonutMode <> value then
  begin
    FDonutMode := Value;
    Changed;
  end;
end;

procedure TChartSeries.SetItem(Index: Integer; Value: TChartSerie);
begin
  inherited SetItem(Index, Value);
  Changed;
end;

procedure TChartSeries.SetSerieValueTotals(const Value: Boolean);
begin
  if FSerieValueTotals <> Value then
  begin
    FSerieValueTotals := Value;
    Changed;
  end;
end;

procedure TChartSeries.Update(Item: TCollectionItem);
begin
  inherited;
  Changed;
end;

{ TRange }

procedure TChartRange.Assign(Source: TPersistent);
begin
  if Source is TChartRange then
  begin
    FRangeFrom := (Source as TChartRange).RangeFrom;
    FRangeTo := (Source as TChartRange).RangeTo;
    FMaxRangeTo := (Source as TChartRange).MaxRangeTo;
    FMaximumScrollRange := (source as TChartRange).MaximumScrollRange;
    FMinimumScrollRange := (Source as TChartRange).MinimumScrollRange;
    FStartDate := (Source as TChartRange).StartDate;
  end;
end;

procedure TChartRange.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TChartRange.Create(AOwner: TAdvChart);
begin
  FOwner := AOwner;
  FForceMaxRangeTo := true;
  FRangeFrom := 0;
  FRangeTo := 10;
  FMaxRangeTo := 10;
  FMaximumScrollRange := 0;
  FMinimumScrollRange := 0;
  if AOwner.FOwner is TControl then
  begin
    if (csDesigning in TControl(AOwner.FOwner).ComponentState) and not (csLoading in TControl(AOwner.FOwner).componentstate) then
      FStartDate := Now;
  end;
end;

procedure TChartRange.LoadFromFile(ini: TMemIniFile;Section: String);
begin
  RangeFrom := ini.ReadInteger(Section, 'RangeFrom', RangeFrom);
  RangeTo := ini.ReadInteger(Section, 'RangeTo', RangeTo);
  MaximumScrollRange := ini.ReadInteger(Section, 'MaximumScrollRange', MaximumScrollRange);
  MinimumScrollRange := ini.ReadInteger(Section, 'MinimumScrollRange', MinimumScrollRange);
  StartDate := ini.ReadDateTime(Section, 'StartDate', StartDate);
end;

procedure TChartRange.SaveToFile(ini: TMemIniFile;Section: String);
begin
  ini.WriteInteger(Section, 'RangeFrom', RangeFrom);
  ini.WriteInteger(Section, 'RangeTo', RangeTo);
  ini.WriteInteger(Section, 'MaximumScrollRange', MaximumScrollRange);
  ini.WriteInteger(Section, 'MinimumScrollRange', MinimumScrollRange);
  ini.WriteDateTime(Section, 'StartDate', StartDate);
end;

procedure TChartRange.SetForceMaxRangeTo(const Value: Boolean);
begin
  if FForceMaxRangeTo <> Value then
  begin
    FForceMaxRangeTo := Value;
    Changed;
  end;
end;

procedure TChartRange.SetMaximumScrollRange(const Value: integer);
begin
  if FMaximumScrollRange <> value then
  begin
    FMaximumScrollRange := Value;
    Changed;
  end;
end;

procedure TChartRange.SetMaxRangeTo(const Value: integer);
begin
  if FMaxRangeTo <> Value then
  begin
    FMaxRangeTo := Value;
    Changed;
  end;
end;

procedure TChartRange.SetMinimumScrollRange(const Value: integer);
begin
  if FMinimumScrollRange <> value then
  begin
    FMinimumScrollRange := Value;
    Changed;
  end;
end;

procedure TChartRange.SetRangeFrom(const Value: integer);
begin
  if (FRangeFrom <> Value) then
  begin
    FRangeFrom := Value;
    Changed;
  end;
end;

procedure TChartRange.SetRangeTo(const Value: integer);
begin
  if (FRangeTo <> Value) then
  begin
    FRangeTo := Value;
    Changed;
  end;
end;

procedure TChartRange.SetStartDate(const Value: TDateTime);
begin
  if FStartDate <> Value then
  begin
    FStartDate := Value;
    Changed;
  end;
end;

{ TChartXGrid }

procedure TChartXGrid.Assign(Source: TPersistent);
begin
  if Source is TChartXGrid then
  begin
    FVisible := (Source as TChartXGrid).Visible;
    FOnTop := (Source as TChartXGrid).OnTop;
    FMinorDistance := (Source as TChartXGrid).MinorDistance;
    FMajorDistance := (Source as TChartXGrid).MajorDistance;
    FMinorLineColor := (Source as TChartXGrid).MinorLineColor;
    FMajorLineColor := (Source as TChartXGrid).MajorLineColor;
    FMinorLineStyle := (Source as TChartXGrid).MinorLineStyle;
    FMajorLineStyle := (Source as TChartXGrid).MajorLineStyle;
    FMinorLineWidth := (Source as TChartXGrid).MinorLineWidth;
    FMajorLineWidth := (Source as TChartXGrid).MajorLineWidth;
    FMinorFont.Assign((Source as TChartXGrid).MinorFont);
    FMajorFont.Assign((Source as TChartXGrid).MajorFont);
    FAutoUnits := (Source as TChartXGrid).AutoUnits;
  end;
end;

procedure TChartXGrid.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TChartXGrid.Create(AOwner: TAdvChart);
begin
  FOwner := AOwner;
  FMinorDistance := 10;
  FMinorLineColor := clBlack;
  FMinorLineStyle := psSolid;
  FMinorLineWidth := 1;
  FMajorDistance := 20;
  FMajorLineColor := clBlack;
  FMajorLineStyle := psDot;
  FMajorLineWidth := 1;
  FMinorFont := TFont.Create;
  FMajorFont := TFont.Create;
  FAutoUnits := True;
end;

destructor TChartXGrid.destroy;
begin
  FMinorFont.Free;
  FMajorFont.Free;
  inherited;
end;

procedure TChartXGrid.Draw(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double);
var
   I, obm: integer;
   xs: double;
   rf, rt: integer;
   mi, mu: integer;
   min, fp, np: Double;
   tw: integer;
begin
  xs := FOwner.XScale;
  rf := FOwner.Range.RangeFrom;
  rt := FOwner.Range.RangeTo;
  mi := MinorDistance;
  mu := MajorDistance;

  if (MinorDistance = 0) or (MajorDistance = 0) then
    exit;


  if AutoUnits then
  begin
    min := xs;

    fp := 1 * min;
    np := (1 + mi) * min;

    if FOwner.Series.IsHorizontal then
      tw := Canvas.TextHeight('gh')
    else
      tw := Canvas.TextWidth('WW');

    while (fp + tw + 4 >= np) and (mi > 0) do
    begin
      fp := 1 * min;
      np := (1 + mi) * min;
      mi := mi + mi;
    end;

    fp := 1 * min;
    np := (1 + mu) * min;

    while (fp + tw + 4 >= np) and (mu > 0) do
    begin
      fp := 1 * min;
      np := (1 + mu) * min;
      mu := mu + mu;
    end;
  end;

  if (mu <> 0) and (mi <> 0) then
  begin
    obm := SetBkMode(Canvas.Handle, TRANSPARENT);
    for I := rf to rt do
    begin
      if (I mod mi = 0) and (I mod mu <> 0) then
      begin
        if MinorLineColor <> clNone then
        begin
          //MAJOR
          Canvas.Pen.Color := FMinorLineColor;
          Canvas.Pen.Style := FMinorLineStyle;
          Canvas.Pen.Width := Round(FMinorLineWidth * ScaleX);
          if FOwner.Series.IsHorizontal then
          begin
            Canvas.MoveTo(R.Left, R.Top + Floor(((i * xs) - (rf) * xs) + FOwner.GetXScaleStart));
            Canvas.LineTo(R.Right, R.Top + Floor(((i * xs) - (rf) * xs) + FOwner.GetXScaleStart));
          end
          else
          begin
            Canvas.MoveTo(R.Left + Floor(((i * xs) - (rf) * xs) + FOwner.GetXScaleStart), R.Top);
            Canvas.LineTo(R.Left + Floor(((i * xs) - (rf) * xs) + FOwner.GetXScaleStart), R.Bottom);
          end;
        end;
      end;

      if (I mod mu) = 0 then
      begin
        if MajorLineColor <> clNone then
        begin
          //MAJOR
          Canvas.Pen.Color := FMajorLineColor;
          Canvas.Pen.Style := FMajorLineStyle;
          Canvas.Pen.Width := Round(FMajorLineWidth * ScaleX);
          if FOwner.Series.IsHorizontal then
          begin
            Canvas.MoveTo(R.Left, R.Top + Floor(((i * xs) - (rf) * xs) + FOwner.GetXScaleStart));
            Canvas.LineTo(R.Right ,r.Top + Floor(((i * xs)  - (rf) * xs) + FOwner.GetXScaleStart));
          end
          else
          begin
            Canvas.MoveTo(R.Left + Floor(((i * xs) - (rf) * xs) + FOwner.GetXScaleStart), R.Top);
            Canvas.LineTo(R.Left + Floor(((i * xs)  - (rf) * xs) + FOwner.GetXScaleStart), R.Bottom);
          end;
        end;
      end;
    end;
    SetBkMode(Canvas.Handle, obm);
  end;
end;

procedure TChartXGrid.FontChanged(Sender: TObject);
begin
  Changed;
end;

procedure TChartXGrid.LoadFromFile(ini: TMemIniFile;Section: String);
var
  A: TStringList;
  str: String;
  I: integer;
begin
  MinorDistance := ini.ReadInteger(Section, 'MinorDistance', MinorDistance);
  MajorDistance := ini.ReadInteger(Section, 'MajorDistance', MajorDistance);
  MinorLineColor := ini.ReadInteger(Section, 'MinorLineColor', MinorLineColor);
  MajorLineColor := ini.ReadInteger(Section, 'MajorLineColor', MajorLineColor);
  MinorLineStyle := TPenStyle(ini.ReadInteger(Section, 'MinorLineStyle', Integer(MinorLineStyle)));
  MajorLineStyle := TPenStyle(ini.ReadInteger(Section, 'MajorLineStyle', Integer(MajorLineStyle)));
  MinorLineWidth := ini.ReadInteger(Section, 'MinorLineWidth', MinorLineWidth);
  MajorLineWidth := ini.ReadInteger(Section, 'MajorLineWidth', MajorLineWidth);

  MajorFont.Size := ini.ReadInteger(Section, 'MajorFontSize', MajorFont.Size);
  MajorFont.Color := ini.ReadInteger(Section, 'MajorFontColor', MajorFont.Color);
  MajorFont.Name := ini.ReadString(Section, 'MajorFontName', MajorFont.Name);
  str := ini.ReadString(Section, 'MajorFontStyle', '');
  A := TStringList.Create;
  Split(':',str, A);
  for I := 1 to A.Count - 1 do
  begin
    MajorFont.Style := MajorFont.Style + [TFontStyle(strtoint(A[I]))];
  end;
  A.Free;
  MinorFont.Size := ini.ReadInteger(Section, 'MinorFontSize', MinorFont.Size);
  MinorFont.Color := ini.ReadInteger(Section, 'MinorFontColor', MinorFont.Color);
  MinorFont.Name := ini.ReadString(Section, 'MinorFontName', MinorFont.Name);
  str := ini.ReadString(Section, 'MinorFontStyle', '');
  A := TStringList.Create;
  Split(':',str, A);
  for I := 1 to A.Count - 1 do
  begin
    MinorFont.Style := MinorFont.Style + [TFontStyle(strtoint(A[I]))];
  end;
  A.Free;

  OnTop := ini.ReadBool(Section, 'OnTop', OnTop);
  Visible := ini.ReadBool(Section, 'Visible', Visible);
end;

procedure TChartXGrid.SaveToFile(ini: TMemIniFile;Section: String);
begin
  ini.WriteInteger(Section, 'MinorDistance', MinorDistance);
  ini.WriteInteger(Section, 'MajorDistance', MajorDistance);
  ini.WriteInteger(Section, 'MinorLineColor', MinorLineColor);
  ini.WriteInteger(Section, 'MajorLineColor', MajorLineColor);
  ini.WriteInteger(Section, 'MinorLineStyle', Integer(MinorLineStyle));
  ini.WriteInteger(Section, 'MajorLineStyle', Integer(MajorLineStyle));
  ini.WriteInteger(Section, 'MinorLineWidth', MinorLineWidth);
  ini.WriteInteger(Section, 'MajorLineWidth', MajorLineWidth);

  ini.WriteInteger(Section, 'MajorFontSize', MajorFont.Size);
  ini.WriteInteger(Section, 'MajorFontColor', MajorFont.Color);
  ini.WriteString(Section, 'MajorFontName', MajorFont.Name);
  ini.WriteString(Section, 'MajorFontStyle', GetFontStyles(MajorFont.Style));

  ini.WriteInteger(Section, 'MinorFontSize', MinorFont.Size);
  ini.WriteInteger(Section, 'MinorFontColor', MinorFont.Color);
  ini.WriteString(Section, 'MinorFontName', MinorFont.Name);
  ini.WriteString(Section, 'MinorFontStyle', GetFontStyles(MinorFont.Style));

  ini.WriteBool(Section, 'OnTop', OnTop);
  ini.WriteBool(Section, 'Visible', Visible);
end;

procedure TChartXGrid.SetAutoUnits(const Value: Boolean);
begin
  if FAutoUnits <> Value then
  begin
    FAutoUnits := Value;
    Changed;
  end;
end;

procedure TChartXGrid.SetMajorDistance(const Value: integer);
begin
  if (FMajorDistance <> value) and (Value >= 0) then
  begin
    FMajorDistance := Value;
    Changed;
  end;
end;

procedure TChartXGrid.SetMajorFont(const Value: TFont);
begin
  if FMajorFont <> Value then
  begin
    FMajorFont.Assign(Value);
    FontChanged(FMajorFont);
  end;
end;

procedure TChartXGrid.SetMajorLineColor(const Value: TColor);
begin
  if FMajorLineColor <> Value then
  begin
    FMajorLineColor := Value;
    Changed;
  end;
end;

procedure TChartXGrid.SetMajorLineStyle(const Value: TPenStyle);
begin
  if FMajorLineStyle <> Value then
  begin
    FMajorLineStyle := Value;
    Changed;
  end;
end;

procedure TChartXGrid.SetMajorLineWidth(const Value: integer);
begin
  if (FMajorLineWidth <> Value) and (Value >= 0) then
  begin
    FMajorLineWidth := Value;
    Changed;
  end;
end;

procedure TChartXGrid.SetMinorDistance(const Value: integer);
begin
  if (FMinorDistance <> Value) and (Value >= 0) then
  begin
    FMinorDistance := Value;
    Changed;
  end;
end;

procedure TChartXGrid.SetMinorFont(const Value: TFont);
begin
  if FMinorFont <> Value then
  begin
    FMinorFont.Assign(Value);
    FontChanged(FMinorFont);
  end;
end;

procedure TChartXGrid.SetMinorLineColor(const Value: TColor);
begin
  if FMinorLineColor <> Value then
  begin
    FMinorLineColor := Value;
    Changed;
  end;
end;

procedure TChartXGrid.SEtMinorLineStyle(const Value: TPenStyle);
begin
  if FMinorLineStyle <> Value then
  begin
    FMinorLineStyle := Value;
    Changed;
  end;
end;

procedure TChartXGrid.SetMinorLineWidth(const Value: integer);
begin
  if (FMinorLineWidth <> Value) and (Value >= 0)then
  begin
    FMinorLineWidth := Value;
    Changed;
  end;
end;

procedure TChartXGrid.SetOnTop(const Value: boolean);
begin
  if FOnTop <> Value then
  begin
    FOnTop := Value;
    Changed;
  end;
end;

procedure TChartXGrid.SetVisible(const Value: boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

{ TChartYGrid }

procedure TChartYGrid.Assign(Source: TPersistent);
begin
  if Source is TChartYGrid then
  begin
    FAutoUnits := (Source as TChartYGrid).AutoUnits;
    FBorderColor := (Source as TChartYGrid).BorderColor;
    FSerieIndex := (Source as TChartYGrid).SerieIndex;
    FVisible := (Source as TChartYGrid).Visible;
    FOnTop := (Source as TChartYGrid).OnTop;
    FMinorDistance := (Source as TChartYGrid).MinorDistance;
    FMajorDistance := (Source as TChartYGrid).MajorDistance;
    FMinorLineColor := (Source as TChartYGrid).MinorLineColor;
    FMajorLineColor := (Source as TChartYGrid).MajorLineColor;
    FMinorLineStyle := (Source as TChartYGrid).MinorLineStyle;
    FMajorLineStyle := (Source as TChartYGrid).MajorLineStyle;
    FMinorLineWidth := (Source as TChartYGrid).MinorLineWidth;
    FMajorLineWidth := (Source as TChartYGrid).MajorLineWidth;
    FShowBorder := (Source as TChartYGrid).ShowBorder;
  end;
end;

procedure TChartYGrid.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TChartYGrid.Create(AOwner: TAdvChart);
begin
  FOwner := AOwner;
  FAutoUnits := true;
  FSerieIndex := 0;
  FMinorDistance := 1;
  FMinorLineColor := clGray;
  FMinorLineStyle := psDot;
  FMinorLineWidth := 1;
  FMajorDistance := 2;
  FMajorLineColor := clSilver;
  FMajorLineStyle := psSolid;
  FMajorLineWidth := 1;
  FBorderColor := clNone;
end;

procedure TChartYGrid.Draw(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double);
var
  JMax, JMin: double;
  domaj, domin, domajv, dominv: boolean;
  htpane, httext: integer;
  mu, mi: double;
  min, max: Double;
  y: TChartSerieYAxis;
  DR: TRect;
  p, s: Boolean;
  dopiegrid: Boolean;
  ptCenter: TPoint;
  pbr: TRect;
  centerh, centerv: integer;
  center: tPoint;
  psz: integer;
  j: Double;
  k: integer;
  compareval: Boolean;
begin
  if not ((SerieIndex >= 0) and (SerieIndex <= FOwner.Series.Count - 1)) then
    Exit;

  dopiegrid := false;
  with FOwner.Series[SerieIndex] do
  begin
    if (ChartType = ctSpider) or (ChartType = ctHalfSpider) or
      (ChartType = ctSizedPie) or (ChartType = ctSizedHalfPie) or (ChartType = ctSizedDonut) or (ChartType = ctSizedHalfDonut) or
        (ChartType = ctVarRadiusPie) or (ChartType = ctVarRadiusHalfPie) or (ChartType = ctVarRadiusDonut) or (ChartType = ctVarRadiusHalfDonut) then
        dopiegrid := true;

    if dopiegrid then
    begin
      psz := (Pie.GetPieSize div 2) * Round(ScaleX);
      pbr := GetPieRectangle(Index, FOwner.Series.SeriesRectangle);
      ptcenter := GetPieCenter(pbr);
      centerh := ptCenter.X;
      centerv := ptCenter.Y;
      center := Point(centerh, centerv);
      DrawTotalGrid(Canvas, Bounds(center.X - psz, center.Y - psz, psz * 2, psz * 2), center, ScaleX, ScaleY);
    end
    else
    begin
      if FShowBorder then
      begin
        Canvas.Brush.Color := BorderColor;
        Canvas.FrameRect(R);
      end;

      p := true;
      s := false;
      y := YAxis;
      min := MinimumValue;
      max := MaximumValue;
      if AutoUnits then
      begin
        if Chart.Series.IsHorizontal then
        begin
          htpane := R.Right - R.Left;
          Canvas.Font.Assign(y.MajorFont);
          httext := Canvas.TextWidth('WW') + 4;
          mu := MinMaxToUnit(min, max, Round(htpane / (2 * httext)));

          Canvas.Font.Assign(y.MinorFont);
          httext := Canvas.TextWidth('WW') + 4;
          mi := MinMaxToUnit(min, max, Round(htpane / (2 * httext)));
        end
        else
        begin
          htpane := R.Bottom - R.Top;
          Canvas.Font.Assign(y.MajorFont);
          httext := Canvas.TextHeight('gh') + 4;
          mu := MinMaxToUnit(min, max, Round(htpane / (2 * httext)));

          Canvas.Font.Assign(y.MinorFont);
          httext := Canvas.TextHeight('gh') + 4;
          mi := MinMaxToUnit(min, max, Round(htpane / (2 * httext)));
        end;
      end
      else
      begin
        mu := MajorDistance;
        mi := MinorDistance;
        {
        if not Logarithmic then
        begin
          d := Frac(mu);
          if d > 0 then
          begin
            while d < 1 do
              d := d * 10;
          end;

          if (Length(inttostr(Round(mu))) - Length(IntToStr(Round(d))) < Length(inttostr(Round(max - min))) - 1) then
          begin
            while (Length(inttostr(Round(mu))) - Length(IntToStr(Round(d))) < Length(inttostr(Round(max - min)))) do
            begin
              mu := mu * 10;
              d := Frac(mu);
              if d > 0 then
              begin
                while d < 1 do
                  d := d * 10;
              end;
            end;
          end;
          d := Frac(mi);
          if d > 0 then
          begin
            while d < 1 do
              d := d * 10;
          end;
          if (Length(inttostr(Round(mi))) - Length(IntToStr(Round(d))) < Length(inttostr(Round(mu))) - 2) then
          begin
            while (Length(inttostr(Round(mi))) - Length(IntToStr(Round(d))) < Length(inttostr(Round(mu))) - 1) do
            begin
              mi := mi * 10;
              d := Frac(mi);
              if d > 0 then
              begin
                while d < 1 do
                  d := d * 10;
              end;
            end;
          end;
        end;
        }
      end;

      if Logarithmic then
        mu := 1;

      JMax := min;
      JMin := min;

      // calculate first value to display

      domaj := (mu > 0);
      domin := (mi > 0);

      if domin then
        Jmin := Round(min / mi)  * mi;

      if domaj then
        Jmax := Round(min / mu)  * mu;


      //DRAW FIRST BAND
      with FOwner.Bands do
      begin
        if FOwner.Bands.Visible then
        begin
          if Chart.Series.IsHorizontal then
          begin
            DR := Rect(R.Left,r.Top, ValueToY(JMax, R) , r.Bottom);
            OffsetRect(DR, Get3DOffset, Get3DOffset);
          end
          else
          begin
            DR := Rect(R.Left,r.Bottom, R.Right {- R.Left} , ValueToY(JMax, R));
            OffsetRect(DR, Get3DOffset, -Get3DOffset);
          end;

          DrawGradient(Canvas, FPrimaryColor, FPrimaryColorTo, FGradientSteps, DR, FGradientDirection, false, clNone, 0, asRectangle, 0, [cbLeft, cbTop, cbRight, cbBottom], false, false);
          p := false;
          s := true;
        end;
      end;

      K := 0;
      //Y - Values
      if domaj then
      begin
        while (JMin <= FMaximumValue + mu) do
        begin
          domajv := JMax <= FMaximumValue + mu;
          if domajv then
          begin
            with FOwner.Bands do
            begin
              if FOwner.Bands.Visible then
              begin
                if Chart.Series.IsHorizontal then
                begin
                  DR := Rect(ValueToY(JMax, R),r.Top, ValueToY(JMax + mu, R) , r.Bottom);
                  OffsetRect(DR, Get3DOffset, Get3DOffset);
                end
                else
                begin
                  DR := Rect(R.Left,ValueToY(JMax, R), R.Right {- R.Left} , ValueToY(JMax + mu, R));
                  OffsetRect(DR, Get3DOffset, -Get3DOffset);
                end;

                if p then
                begin
                  DrawGradient(Canvas, FPrimaryColor, FPrimaryColorTo, FGradientSteps, DR, FGradientDirection, false, clNone, 0, asRectangle, 0, [cbLeft, cbTop, cbRight, cbBottom], false, false);
                end;
                if s then
                begin
                  DrawGradient(Canvas, FSecondaryColor, FSecondaryColorTo, FGradientSteps, DR, FGradientDirection, false, clNone, 0, asRectangle, 0, [cbLeft, cbTop, cbRight, cbBottom], false, false);
                end;
              end;
            end;

            if Self.Visible then
            begin
              if MajorLinecolor <> clNone then
              begin
                Canvas.Pen.Color := MajorLineColor;
                Canvas.Pen.Style := MajorLineStyle;
                Canvas.Pen.Width := Round(MajorLineWidth * ScaleX);
                Canvas.Brush.Style := bsClear;
                if Chart.Series.IsHorizontal then
                begin
                  Canvas.MoveTo(ValueToY(JMax, R), r.Top);
                  Canvas.LineTo(ValueToY(JMax, R), r.Bottom);
                end
                else
                begin
                  Canvas.MoveTo(R.Left, ValueToY(JMax, R));
                  Canvas.LineTo(R.Right,ValueToY(JMax, R));
                end;
              end;
            end;
          end;
          dominv := JMin <= FMaximumValue + mu;
          if dominv and domin then
          begin
            while (JMin <> JMax) and (JMax > JMin) do
            begin
              if Logarithmic then
              begin
                j := JMin - (K - 1);
                if (K <= LOGARITHMICMAX) and (K >= -LOGARITHMICMAX) then
                  j := j * Power(10, K);
                j := ConvertToLog(j);
              end
              else
                j := JMin;


              compareval := false;
              if Logarithmic and (JMax <= LOGARITHMICMAX) and (JMax >= -LOGARITHMICMAX) then
                compareval := (CompareValue(Round((JMin - (JMax - 1)) * Power(10, JMax)), Round(Power(10, JMax - 1))) = 0);

              if not Logarithmic or (Logarithmic and not compareval) then
              begin
                if Self.Visible then
                begin
                  if MinorLineColor <> clNone then
                  begin
                    Canvas.Pen.Color := MinorLineColor;
                    Canvas.Pen.Style := MinorLineStyle;
                    Canvas.Pen.Width := Round(MinorLineWidth * ScaleX);
                    Canvas.Brush.Style := bsClear;
                    if Chart.Series.IsHorizontal then
                    begin
                      Canvas.MoveTo(ValueToY(j, R), R.Top);
                      Canvas.LineTo(ValueToY(j, R), R.Bottom);
                    end
                    else
                    begin
                      Canvas.MoveTo(R.Left, ValueToY(j, R));
                      Canvas.LineTo(R.Right, ValueToY(j, R));
                    end;
                  end;
                end;
              end;

              JMin := JMin + mi;
              if CompareValue(Jmin, Jmax) = 0 then
              begin
                JMin := JMin + mi;
              end;
            end;
          end;
          p := not p;
          s := not s;
          if not domin then
          begin
            JMin := JMin + mu;
          end
          else
          begin
            if CompareValue(Jmin, Jmax) = 0 then
            begin
              JMin := JMin + mi;
            end;
          end;

          JMax := JMax + mu;
          Inc(K);

          if JMax > FMaximumValue + mu then
            break;
        end;
      end;
    end;
  end;
end;

procedure TChartYGrid.LoadFromFile(ini: TMemIniFile;Section: String);
begin
  AutoUnits := ini.ReadBool(Section, 'AutoUnits', AutoUnits);
  MinorDistance := ini.ReadFloat(Section, 'MinorDistance', MinorDistance);
  MajorDistance := ini.ReadFloat(Section, 'MajorDistance', MajorDistance);
  MinorLineColor := ini.ReadInteger(Section, 'MinorLineColor', MinorLineColor);
  MajorLineColor := ini.ReadInteger(Section, 'MajorLineColor', MajorLineColor);
  MinorLineStyle := TPenStyle(ini.ReadInteger(Section, 'MinorLineStyle', Integer(MinorLineStyle)));
  MajorLineStyle := TPenStyle(ini.ReadInteger(Section, 'MajorLineStyle', Integer(MajorLineStyle)));
  MinorLineWidth := ini.ReadInteger(Section, 'MinorLineWidth', MinorLineWidth);
  MajorLineWidth := ini.ReadInteger(Section, 'MajorLineWidth', MajorLineWidth);
  OnTop := ini.ReadBool(Section, 'OnTop', OnTop);
  Visible := ini.ReadBool(Section, 'Visible', Visible);
  SerieIndex := ini.ReadInteger(Section, 'SerieIndex', SerieIndex);
  ShowBorder := ini.ReadBool(Section, 'ShowBorder', ShowBorder);
end;

procedure TChartYGrid.SaveToFile(ini: TMemIniFile;Section: String);
begin
  ini.WriteBool(Section, 'AutoUnits', AutoUnits);
  ini.WriteInteger(Section, 'BorderColor', BorderColor);
  ini.WriteFloat(Section, 'MinorDistance', MinorDistance);
  ini.WriteFloat(Section, 'MajorDistance', MajorDistance);
  ini.WriteInteger(Section, 'MinorLineColor', MinorLineColor);
  ini.WriteInteger(Section, 'MajorLineColor', MajorLineColor);
  ini.WriteInteger(Section, 'MinorLineStyle', Integer(MinorLineStyle));
  ini.WriteInteger(Section, 'MajorLineStyle', Integer(MajorLineStyle));
  ini.WriteInteger(Section, 'MinorLineWidth', MinorLineWidth);
  ini.WriteInteger(Section, 'MajorLineWidth', MajorLineWidth);
  ini.WriteBool(Section, 'OnTop', OnTop);
  ini.WriteBool(Section, 'Visible', Visible);
  ini.WriteInteger(Section, 'SerieIndex', SerieIndex);
  ini.WriteBool(Section, 'ShowBorder', ShowBorder);
end;

procedure TChartYGrid.SetAutoUnits(const Value: Boolean);
begin
  if FAutoUnits <> Value then
  begin
    FAutoUnits := Value;
    Changed;
  end;
end;

procedure TChartYGrid.SetBorderColor(const Value: TColor);
begin
  if FBorderColor <> value then
  begin
    FBorderColor := Value;
    Changed;
  end;
end;

procedure TChartYGrid.SetSerieIndex(const Value: integer);
begin
  if (FSerieIndex <> Value) and (Value >= -1) then
  begin
    FSerieIndex := Value;
    Changed;
  end;
end;

procedure TChartYGrid.SetMajorDistance(const Value: double);
begin
  if (FMajorDistance <> Value) and (Value >= 0) then
  begin
    FMajorDistance := Value;
    Changed;
  end;
end;

procedure TChartYGrid.SetMajorLineColor(const Value: TColor);
begin
  if FMajorLineColor <> Value then
  begin
    FMajorLineColor := Value;
    Changed;
  end;
end;

procedure TChartYGrid.SetMajorLineStyle(const Value: TPenStyle);
begin
  if FMajorLineStyle <> Value then
  begin
    FMajorLineStyle := Value;
    Changed;
  end;
end;

procedure TChartYGrid.SetMajorLineWidth(const Value: integer);
begin
  if (FMajorLineWidth <> Value) and (Value >= 0) then
  begin
    FMajorLineWidth := Value;
    Changed;
  end;
end;

procedure TChartYGrid.SetMinorDistance(const Value: double);
begin
  if (FMinorDistance <> Value) and (Value >= 0) then
  begin
    FMinorDistance := Value;
    Changed;
  end;
end;

procedure TChartYGrid.SetMinorLineColor(const Value: TColor);
begin
  if FMinorLineColor <> Value then
  begin
    FMinorLineColor := Value;
    Changed;
  end;
end;

procedure TChartYGrid.SetMinorLineStyle(const Value: TPenStyle);
begin
  if FMinorLineStyle <> Value then
  begin
    FMinorLineStyle := Value;
    Changed;
  end;
end;

procedure TChartYGrid.SetMinorLineWidth(const Value: integer);
begin
  if (FMinorLineWidth <> Value) and (Value >= 0) then
  begin
    FMinorLineWidth := Value;
    Changed;
  end;
end;

procedure TChartYGrid.SetOnTop(const Value: boolean);
begin
  if FOnTop <> Value then
  begin
    FOnTop := Value;
    Changed;
  end;
end;

procedure TChartYGrid.SetShowBorder(const Value: boolean);
begin
  if FShowBorder <> value then
  begin
    FShowBorder := Value;
    Changed;
  end;
end;

procedure TChartYGrid.SetVisible(const Value: boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

{ TChartCrossHair }

procedure TChartCrossHair.Assign(Source: TPersistent);
begin
  if Source is TChartCrossHair then
  begin
    FVisible := (Source as TChartCrossHair).Visible;
    FLineColor := (Source as TChartCrossHair).LineColor;
    FLineWidth := (Source as TChartCrossHair).LineWidth;
    FDistance := (Source as TChartCrossHair).Distance;
    FCrossHairType := (Source as TChartCrossHair).CrossHairType;
    FCrossHairYValues.Assign((Source as TChartCrossHair).CrossHairYValues);
  end;
end;

procedure TChartCrossHair.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TChartCrossHair.Create(AOwner: TAdvChart);
begin
  FOwner := AOWner;
  FCrossHairYValues := TChartCrossHairYValues.Create;
  FCrossHairYValues.OnChange := CrossHairYValuesChanged;
  FVisible := false;
  FCrossHairType := chtFullSizeCrossHairAtSeries;
  FLineColor := clNone;
  FLineWidth := 1;
end;

procedure TChartCrossHair.CrossHairYValuesChanged(Sender: TObject);
begin
  Changed;
end;

destructor TChartCrossHair.Destroy;
begin
  FCrossHairYValues.Free;
  inherited;
end;

procedure TChartCrossHair.Draw(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double);
var
  X: integer;
  Y: integer;
  cd: integer;
  pv: TSeriePoint;
  xs: Double;
begin
  pv := FOwner.FPointValue;
  xs := FOwner.FXscale;
  if (pv.Point <= FOwner.Range.RangeTo) then
  begin
    X := Round((pv.Point * xs)) - Round((FOwner.Range.RangeFrom * xs)) + R.Left + Round(FOwner.GetXScaleStart);
    Y := Round(pv.YValue);
    cd := CrossHairDistance;

    Canvas.Pen.Width := Round(FLineWidth * Scalex);
    Canvas.Pen.Color := FLineColor;

    Canvas.MoveTo(X - cd, Y);
    Canvas.LineTo(X + cd, Y);
    Canvas.MoveTo(X , Y);
    Canvas.MoveTo(X , Y - cd);
    Canvas.LineTo(X, Y + cd);
  end;
end;

procedure TChartCrossHair.LoadFromFile(ini: TMemIniFile;Section: String);
begin
  CrossHairType := TChartCrossHairType(ini.ReadInteger(Section, 'CrossHairType', Integer(CrossHairType)));
  CrossHairYValues.LoadFromfile(ini, Section + '.' + 'CrossHairYValues');
  Distance := ini.ReadInteger(Section, 'Distance', Distance);
  LineWidth := ini.ReadInteger(Section, 'LineWidth', LineWidth);
  LineColor := ini.ReadInteger(Section, 'LineColor', LineColor);
  Visible := ini.ReadBool(Section, 'Visible', Visible);
end;

procedure TChartCrossHair.SaveToFile(ini: TMemIniFile;Section: String);
begin
  ini.WriteInteger(Section, 'CrossHairType', Integer(CrossHairType));
  CrossHairYValues.SaveToFile(ini, Section + '.' + 'CrossHairYValues');
  ini.WriteInteger(Section, 'Distance', Distance);
  ini.WriteInteger(Section, 'LineWidth', LineWidth);
  ini.WriteInteger(Section, 'LineColor', LineColor);
  ini.WriteBool(Section, 'Visible', Visible);
end;

procedure TChartCrossHair.SetCrossHairType(const Value: TChartCrossHairType);
begin
  if FCrossHairType <> Value then
  begin
    FCrossHairType := Value;
    Changed;
  end;
end;

procedure TChartCrossHair.SetCrossHairYValues(
  const Value: TChartCrossHairYValues);
begin
  if FCrossHairYValues <> Value then
  begin
    FCrossHairYValues := Value;
    CrossHairYValuesChanged(Self);
  end;
end;

procedure TChartCrossHair.SetDistance(const Value: integer);
begin
  if FDistance <> Value then
  begin
    FDistance := Value;
    Changed;
  end;
end;

procedure TChartCrossHair.SetLineColor(const Value: TColor);
begin
  if FLineColor <> Value then
  begin
    FLineColor := Value;
    Changed;
  end;
end;

procedure TChartCrossHair.SetLineWidth(const Value: integer);
begin
  if (FLineWidth <> Value) and (Value >= 0) then
  begin
    FLineWidth := Value;
    Changed;
  end;
end;

procedure TChartCrossHair.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

{ TChartMarker }

procedure TChartMarker.Assign(Source: TPersistent);
begin
  if Source is TChartMarker then
  begin
    FMarkerType := (Source as TChartMarker).MarkerType;
    FMarkerSize := (Source as TChartMarker).MarkerSize;
    FMarkerColor := (Source as TChartMarker).MarkerColor;
    FMarkerLineColor := (Source as TChartMarker).MarkerLineColor;
    FMarkerLineWidth := (Source as TChartMarker).MarkerLineWidth;
    FMarkerPicture.Assign((Source as TChartMarker).MarkerPicture);
    FSelectedColor := (Source as TChartMarker).SelectedColor;
    FSelectedLineColor := (Source as TChartMarker).SelectedLineColor;
    FSelectedLineWidth := (Source as TChartMarker).SelectedLineWidth;
    FSelectedSize := (Source as TChartMarker).SelectedSize;
    FIncreaseDecreaseMode := (Source as TChartMarker).IncreaseDecreaseMode;
  end;
end;

procedure TChartMarker.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TChartMarker.Create;
begin
  FMarkerLineWidth := 1;
  FMarkerType := mNone;
  FMarkerSize := 10;
  FMarkerColor := clWhite;
  FMarkerLineColor := clBlack;
  FSelectedColor := clNone;
  FSelectedLineColor := clNone;
  FSelectedLineWidth := 1;
  FSelectedIndex := -1;
  FSelectedSize := 12;
  FMarkerPicture := TPicture.Create;
  FIncreaseDecreaseMode := false;
end;

destructor TChartMarker.Destroy;
begin
  FMarkerPicture.Free;
  inherited;
end;

procedure TChartMarker.LoadFromFile(ini: TMemIniFile;Section: String);
begin
  MarkerType := TChartMarkerType(ini.ReadInteger(Section, 'MarkerType', Integer(MarkerType)));
  MarkerColor := ini.ReadInteger(Section, 'MarkerColor', MarkerColor);
  MarkerSize := ini.ReadInteger(Section, 'MarkerSize', MarkerSize);
  MarkerLineWidth := ini.ReadInteger(Section, 'MarkerLineWidth', MarkerLineWidth);
  MarkerLineColor := ini.ReadInteger(Section, 'MarkerLineColor', MarkerLineColor);
  SelectedColor := ini.ReadInteger(Section, 'SelectedColor', SelectedColor);
  SelectedLineColor := ini.ReadInteger(Section, 'SelectedLineColor', SelectedLineColor);
  SelectedLineWidth := ini.ReadInteger(Section, 'SelectedLineWidth', SelectedLineWidth);
  SelectedSize := ini.ReadInteger(Section, 'SelectedSize', SelectedSize);
  IncreaseDecreaseMode := ini.ReadBool(Section, 'IncreaseDecrease', IncreaseDecreaseMode);
  //TODO
//  ini.ReadInteger(Section, 'MarkerPicture', Integer(MarkerPicture));
end;

procedure TChartMarker.SaveToFile(ini: TMemIniFile;Section: String);
begin
  ini.WriteInteger(Section, 'MarkerType', Integer(MarkerType));
  ini.WriteInteger(Section, 'MarkerColor', MarkerColor);
  ini.WriteInteger(Section, 'MarkerSize', MarkerSize);
  ini.WriteInteger(Section, 'MarkerLineWidth', MarkerLineWidth);
  ini.WriteInteger(Section, 'MarkerLineColor', MarkerLineColor);
  ini.WriteInteger(Section, 'MarkerPicture', Integer(MarkerPicture));
  ini.WriteInteger(Section, 'SelectedColor', SelectedColor);
  ini.WriteInteger(Section, 'SelectedLineColor', SelectedLineColor);
  ini.WriteInteger(Section, 'SelectedLineWidth', SelectedLineWidth);
  ini.WriteInteger(Section, 'SelectedSize', SelectedSize);
  ini.WriteBool(Section, 'IncreaseDecrease', IncreaseDecreaseMode);
  //TODO
  //Picture
end;

procedure TChartMarker.SetIncreaseDecreaseMode(const Value: Boolean);
begin
  if FIncreaseDecreaseMode <> value then
  begin
    FIncreaseDecreaseMode := Value;
    Changed;
  end;
end;

procedure TChartMarker.SetMarkerColor(const Value: TColor);
begin
  if FMarkerColor <> Value then
  begin
    FMarkerColor := Value;
    Changed;
  end;
end;

procedure TChartMarker.SetMarkerLineColor(const Value: TColor);
begin
  if FMarkerLineColor <> Value then
  begin
    FMarkerLineColor := Value;
    Changed;
  end;
end;

procedure TChartMarker.SetMarkerLineWidth(const Value: integer);
begin
  if (MarkerLineWidth <> Value) and (Value >= 0) then
  begin
    FMarkerLineWidth := Value;
    Changed;
  end;
end;

procedure TChartMarker.SetMarkerPicture(const Value: TPicture);
begin
  if FMarkerPicture <> value then
  begin
    FMarkerPicture.Assign(Value);
    Changed;
  end;
end;

procedure TChartMarker.SetMarkerSize(const Value: Integer);
begin
  if (FMarkerSize <> Value) and (Value >= 0) then
  begin
    FMarkerSize := Value;
    Changed;
  end;
end;

procedure TChartMarker.SetMarkerType(const Value: TChartMarkerType);
begin
  if FMarkerType <> Value then
  begin
    FMarkerType := Value;
    Changed;
  end;
end;

procedure TChartMarker.SetSelectedColor(const Value: TColor);
begin
  if FSelectedColor <> Value then
  begin
    FSelectedColor := Value;
    Changed;
  end;
end;

procedure TChartMarker.SetSelectedIndex(const Value: integer);
begin
  if FSelectedIndex <> Value then
  begin
    FSelectedIndex := Value;
    Changed;
  end;
end;

procedure TChartMarker.SetSelectedLineColor(const Value: TColor);
begin
  if FSelectedLineColor <> Value then
  begin
    FSelectedLineColor := Value;
    Changed;
  end;
end;

procedure TChartMarker.SetSelectedLineWidth(const Value: integer);
begin
  if FSelectedLineWidth <> value then
  begin
    FSelectedLineWidth := Value;
    Changed;
  end;
end;

procedure TChartMarker.SetSelectedSize(const Value: integer);
begin
  if FSelectedSize <> Value then
  begin
    FSelectedSize := Value;
    Changed;
  end;
end;

{ TChartBounds }

procedure TChartBands.Assign(Source: TPersistent);
begin
  if Source is TChartBands then
  begin
    FPrimaryColor := (Source as TChartBands).PrimaryColor;
    FPrimaryColorTo := (Source as TChartBands).PrimaryColorTo;
    FSecondaryColor := (Source as TChartBands).SecondaryColor;
    FSecondaryColorTo := (Source as TChartBands).SecondaryColorTo;
    FGradientSteps := (Source as TChartBands).GradientSteps;
    FGradientDirection := (Source as TChartBands).GradientDirection;
    FVisible := (Source as TChartBands).Visible;
    FDistance := (Source as TChartBands).Distance;
    FSerieIndex := (Source as TChartBands).SerieIndex;
    Changed;
  end;
end;

procedure TChartBands.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TChartBands.Create(AOwner: TAdvChart);
begin
  FOwner := AOWner;
  FPrimaryColor := clSilver;
  FPrimaryColorTo := clWhite;
  FSecondaryColor := clNavy;
  FSecondaryColorTo := clWhite;
  FDistance := 2;
  FGradientSteps := 100;
  FSerieIndex := 0;
  FGradientDirection := cgdHorizontal;
  FVisible := false;
end;

destructor TChartBands.Destroy;
begin
  inherited;
end;

procedure TChartBands.LoadFromFile(ini: TMemIniFile;Section: String);
begin
  Distance := ini.ReadFloat(Section, 'Distance', Distance);
  GradientSteps := ini.ReadInteger(Section, 'GradientSteps', GradientSteps);
  GradientDirection := TChartGradientDirection(ini.ReadInteger(Section, 'GradientDirection', Integer(GradientDirection)));
  PrimaryColor := ini.ReadInteger(Section, 'PrimaryColor', PrimaryColor);
  PrimaryColorTo := ini.ReadInteger(Section, 'PrimaryColorTo', PrimaryColorTo);
  SecondaryColor := ini.ReadInteger(Section, 'SecondaryColor', SecondaryColor);
  SecondaryColorTo := ini.ReadInteger(Section, 'SecondaryColorTo', SecondaryColorTo);
  SerieIndex := ini.ReadInteger(Section, 'SerieIndex', SerieIndex);
  Visible := ini.ReadBool(Section, 'Visible', Visible);
end;

procedure TChartBands.SaveToFile(ini: TMemIniFile;Section: String);
begin
  ini.WriteFloat(Section, 'Distance', Distance);
  ini.WriteInteger(Section, 'GradientSteps', GradientSteps);
  ini.WriteInteger(Section, 'GradientDirection', Integer(GradientDirection));
  ini.WriteInteger(Section, 'PrimaryColor', PrimaryColor);
  ini.WriteInteger(Section, 'PrimaryColorTo', PrimaryColorTo);
  ini.WriteInteger(Section, 'SecondaryColor', SecondaryColor);
  ini.WriteInteger(Section, 'SecondaryColorTo', SecondaryColorTo);
  ini.WriteInteger(Section, 'SerieIndex', SerieIndex);
  ini.WriteBool(Section, 'Visible', Visible);
end;

procedure TChartBands.SetGradientDirection(
  const Value: TChartGradientDirection);
begin
  if FGradientDirection <> Value then
  begin
    FGradientDirection := Value;
    Changed;
  end;
end;

procedure TChartBands.SetGradientSteps(const Value: integer);
begin
  if (FGradientSteps <> Value) and (Value >= 0) then
  begin
    FGradientSteps := Value;
    Changed;
  end;
end;

procedure TChartBands.SetPrimaryColor(const Value: TColor);
begin
  if FPrimaryColor <> Value then
  begin
    FPrimaryColor := Value;
    Changed;
  end;
end;

procedure TChartBands.SetPrimaryColorTo(const Value: TColor);
begin
  if FPrimaryColorTo <> Value then
  begin
    FPrimaryColorTo := Value;
    Changed;
  end;
end;

procedure TChartBands.SetSecondaryColor(const Value: TColor);
begin
  if FSecondaryColor <> Value then
  begin
    FSecondaryColor := Value;
    Changed;
  end;
end;

procedure TChartBands.SetSecondaryColorTo(const Value: TColor);
begin
  if FSecondaryColorTo <> Value then
  begin
    FSecondaryColorTo := Value;
    Changed;
  end;
end;

procedure TChartBands.SetSerieIndex(const Value: integer);
begin
  if (FSerieIndex <> Value) and (Value >= 0) then
  begin
    FSerieIndex := Value;
    Changed;
  end;
end;

procedure TChartBands.SetVisible(const Value: boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

{ TChartXYAxisText }

procedure TChartXYAxisText.Assign(Source: TPersistent);
begin
  if Source is TChartXYAxisText then
  begin
    FAngle := (source as TChartXYAxisText).Angle;
    FText := (Source as TChartXYAxisText).Text;
    FPosition := (Source as TChartXYAxisText).Position;
    FOffset := (Source as TChartXYAxisText).Offset;
    FFont.Assign((Source as TChartXYAxisText).Font);
  end;
end;

procedure TChartXYAxisText.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TChartXYAxisText.Create;
begin
  FFont := TFont.Create;
  FPosition := ctLeft;
  Angle := 0;
  Offset := 0;
  Text := '';
end;

destructor TChartXYAxisText.Destroy;
begin
  FFont.Free;
  inherited;
end;

procedure TChartXYAxisText.FontChanged(Sender: TObject);
begin
  Changed;
end;

procedure TChartXYAxisText.LoadFromFile(ini: TMemIniFile;Section: String);
var
  A : TStringList;
  str: String;
  I: integer;
begin
  Angle := ini.ReadInteger(Section, 'Angle', Integer(Angle));
  Font.Size := ini.ReadInteger(Section, 'FontSize', Font.Size);
  Font.Color := ini.ReadInteger(Section, 'FontColor', Font.Color);
  Font.Name := ini.ReadString(Section, 'FontName', Font.Name);
  str := ini.ReadString(Section, 'FontStyle', '');
  A := TStringList.Create;
  Split(':',str, A);
  for I := 1 to A.Count - 1 do
  begin
    Font.Style := Font.Style + [TFontStyle(strtoint(A[I]))];
  end;
  A.Free;
  Offset := ini.ReadInteger(Section, 'Offset', Offset);
  Position := TChartTextPosition(ini.ReadInteger(Section, 'Position', Integer(Position)));
  Text := ini.ReadString(Section, 'Text', Text);
end;

procedure TChartXYAxisText.SaveToFile(ini: TMemIniFile;Section: String);
begin
  ini.WriteInteger(Section, 'Angle', Integer(Angle));
  ini.WriteInteger(Section, 'FontSize', Font.Size);
  ini.WriteInteger(Section, 'FontColor', Font.Color);
  ini.WriteString(Section, 'FontName', Font.Name);
  ini.WriteString(Section, 'FontStyle', GetFontStyles(Font.Style));
  ini.WriteInteger(Section, 'Offset', Offset);
  ini.WriteInteger(Section, 'Position', Integer(Position));
  ini.WriteString(Section, 'Text', Text);
end;

procedure TChartXYAxisText.SetAngle(const Value: integer);
begin
  if (FAngle <> Value) then
  begin
    FAngle := Value;
    Changed;
  end;
end;

procedure TChartXYAxisText.SetFont(const Value: TFont);
begin
  if FFont <> Value then
  begin
    FFont.Assign(Value);
    FontChanged(FFont);
  end;
end;

procedure TChartXYAxisText.SetOffset(const Value: Integer);
begin
  if FOffset <> Value then
  begin
    FOffset := Value;
    Changed;
  end;
end;

procedure TChartXYAxisText.SetPosition(const Value: TChartTextPosition);
begin
  if FPosition <> Value then
  begin
    FPosition := Value;
    Changed;
  end;
end;

procedure TChartXYAxisText.SetText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    Changed;
  end;
end;

procedure TChartXYAxisText.TextBottomChanged(Sender: TObject);
begin
  Changed;
end;

procedure TChartXYAxisText.TextTopChanged(Sender: TObject);
begin
  Changed;
end;

{ TChartMargin }

procedure TChartMargin.Assign(Source: TPersistent);
begin
  if Source is TChartMargin then
  begin
    FTopMargin := (Source as TChartMargin).TopMargin;
    FBottomMargin := (Source as TChartMargin).BottomMargin;
    FLeftMargin := (Source as TChartMargin).LeftMargin;
    FRightMargin := (Source as TChartMargin).RightMargin;
  end;
end;

procedure TChartMargin.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TChartMargin.Create(AOwner: TAdvChart);
begin
  FOwner := AOwner;
  LeftMargin := 0;
  RightMargin := 0;
  TopMargin := 0;
  BottomMargin := 0;
end;

destructor TChartMargin.Destroy;
begin
  inherited;
end;

procedure TChartMargin.LoadFromFile(ini: TMemIniFile;Section: String);
begin
  BottomMargin := ini.ReadInteger(Section, 'BottomMargin', BottomMargin);
  LeftMargin := ini.ReadInteger(Section, 'LeftMargin', LeftMargin);
  RightMargin := ini.ReadInteger(Section, 'RightMargin', RightMargin);
  TopMargin := ini.ReadInteger(Section, 'TopMargin', TopMargin);
end;

procedure TChartMargin.SaveToFile(ini: TMemIniFile;Section: String);
begin
  ini.WriteInteger(Section, 'BottomMargin', BottomMargin);
  ini.WriteInteger(Section, 'LeftMargin', LeftMargin);
  ini.WriteInteger(Section, 'RightMargin', RightMargin);
  ini.WriteInteger(Section, 'TopMargin', TopMargin);
end;

procedure TChartMargin.SetBottomMargin(const Value: integer);
begin
  if (FBottomMargin <> Value) and (Value >= 0) then
  begin
    FBottomMargin := Value;
    Changed;
  end;
end;

procedure TChartMargin.SetLeftMargin(const Value: integer);
begin
  if (FLeftMargin <> Value) and (Value >= 0) then
  begin
    FLeftMargin := Value;
    Changed;
  end;
end;

procedure TChartMargin.SetRightMargin(const Value: integer);
begin
  if (FRightMargin <> Value) and (Value >= 0) then
  begin
    FRightMargin := Value;
    Changed;
  end;
end;

procedure TChartMargin.SetTopMargin(const Value: integer);
begin
  if (FTopMargin <> Value) and (Value >= 0) then
  begin
    FTopMargin := Value;
    Changed;
  end;
end;

{ TChartNavigator }

procedure TChartNavigator.Assign(Source: TPersistent);
begin
  FVisible := (Source as TChartNavigator).Visible;
  FColor := (Source as TChartNavigator).Color;
  FColorTo := (Source as TChartNavigator).ColorTo;
  FSize := (source as tChartNavigator).Size;
  FGradientDirection := (Source as TChartNavigator).GradientDirection;
  FGradientSteps := (Source as TChartNavigator).GradientSteps;
  FScrollButtonLeftColor := (Source as TChartNavigator).ScrollButtonLeftColor;
  FScrollButtonLeftHotColor := (Source as TChartNavigator).ScrollButtonLeftHotColor;
  FScrollButtonLeftDownColor := (Source as TChartNavigator).ScrollButtonLeftDownColor;
  FScrollButtonRightColor := (Source as TChartNavigator).ScrollButtonRightColor;
  FScrollButtonRightHotColor := (Source as TChartNavigator).ScrollButtonRightHotColor;
  FScrollButtonRightDownColor := (Source as TChartNavigator).ScrollButtonRightDownColor;
  FScrollButtonLeft.Assign((Source as TChartNavigator).ScrollButtonLeft);
  FScrollButtonLeftHot.Assign((Source as TChartNavigator).ScrollButtonLeftHot);
  FScrollButtonLeftDown.Assign((Source as TChartNavigator).ScrollButtonLeftDown);
  FScrollButtonRight.Assign((Source as TChartNavigator).ScrollButtonRight);
  FScrollButtonRightHot.Assign((Source as TChartNavigator).ScrollButtonRightHot);
  FScrollButtonRightDown.Assign((Source as TChartNavigator).ScrollButtonRightDown);
  FLeftButtonState := (Source as TChartNavigator).LeftButtonState;
  FRightButtonState := (Source as TChartNavigator).RightButtonState;
  FScrollButtons := (Source as TChartNavigator).ScrollButtons;
  FScrollDelta := (Source as TChartNavigator).FScrollDelta;
  FScrollButtonsSize := (Source as TChartNavigator).ScrollButtonsSize;
  FAlphaBlendValue := (Source as TChartNavigator).AlphaBlendValue;
  FAlphaBlend := (Source as TChartNavigator).AlphaBlend;
  FScrollStep := (Source as TChartNavigator).ScrollStep;
end;

procedure TChartNavigator.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TChartNavigator.Create(AOwner: TAdvChart);
begin
  ScrollButtonLeftHotColor := clNone;
  ScrollButtonLeftDownColor := clNone;
  ScrollButtonLeftColor := clNone;
  ScrollButtonRightHotColor := clNone;
  ScrollButtonRightDownColor := clNone;
  ScrollButtonRightColor := clNone;
  Fvisible := false;
  FColor := clWhite;
  FColorTo := clNone;
  FScrollButtonLeft := TPicture.Create;
  FScrollButtonLeftHot := TPicture.Create;
  FScrollButtonLeftDown := TPicture.Create;
  FScrollButtonRight := TPicture.Create;
  FScrollButtonRightHot := TPicture.Create;
  FScrollButtonRightDown := TPicture.Create;
  FGradientDirection := cgdVertical;
  FGradientSteps := 100;
  FScrollButtons := true;
  FScrollButtonsSize := 11;
  FSize := 20;
  FAlphaBlendValue := 128;
  FAlphaBlend := true;
  FScrollStep := 1;
  FOwner := AOwner;
end;

destructor TChartNavigator.Destroy;
begin
  FScrollButtonLeft.Free;
  FScrollButtonLeftHot.Free;
  FScrollButtonLeftDown.Free;
  FScrollButtonRight.Free;
  FScrollButtonRightHot.Free;
  FScrollButtonRightDown.Free;
  inherited;
end;

procedure TChartNavigator.DrawArrow(Canvas: TCanvas; R: TRect; Direction: Boolean; ScaleX, ScaleY: Double);
var
  x1 :  INTEGER;
  y1 :  INTEGER;
  sx, sy, szx, szy: integer;
begin
  x1 := R.Left;
  y1 := R.Top;
  szx := Round(Self.Size * ScaleX);
  szy := Round(Self.Size * ScaleY);
  sx := Round(ScrollButtonsSize * ScaleX);
  sy := Round(ScrollButtonsSize * ScaleY);

  if sx > szx then
    sx := szx;

  if sy > szy then
    sy := szy;

  if Direction then
    Canvas.Polygon([Point(X1, Y1 + (sy div 2)),Point(X1 + (sx div 3) * 2, Y1),Point(X1  + (sx div 3) * 2, Y1 + sy)])
  else
    Canvas.Polygon([Point(X1, Y1),Point(X1, Y1 + sy),Point(X1 + (sx div 3) * 2, Y1 + (sy div 2))]);
end;

procedure TChartNavigator.Draw(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double);
var
  DR: TRect;
  s: integer;
  pr, pl: TPicture;
  cl, cr: TColor;
begin
  if FOwner.Series.IsHorizontal then
    Exit;

  DR := Rect(R.Left, R.Bottom - Round(FSize * ScaleY), R.Right, R.Bottom);
  s := ScrollButtonsSize;
  pr := nil;
  pl := nil;
  cr := clNone;
  cl := clNone;
  if Visible then
  begin
    Canvas.Pen.Style := psSolid;
    Canvas.Pen.Width := 1;
    Canvas.Pen.Color := clBlack;
    if ColorTo <> clNone then
      DrawGradient(Canvas, Fcolor, FColorTo, GradientSteps, DR, GradientDirection, true, clBlack, 1, asRectangle, 0, [cbLeft, cbTop, cbRight, cbBottom], false, false)
    else
    begin
      if FColor <> clNone then
        Canvas.Brush.Color := FColor
      else
        Canvas.Brush.Style := bsClear;
      Canvas.Rectangle(R.Left, R.Bottom - Round(FSize * ScaleY), R.Right, R.Bottom);
    end;

    if FScrollButtons then
    begin
      case LeftButtonState of
        cnbNormal:
        begin
          pl := ScrollButtonLeft;
          cl := ScrollButtonLeftColor;
        end;
        cnbHot:
        begin
          pl := ScrollButtonLeftHot;
          cl := ScrollButtonLeftHotColor;
        end;
        cnbDown:
        begin
          pl := ScrollButtonLeftDown;
          cl := ScrollButtonLeftDownColor;
        end;
      end;
      case RightButtonState of
        cnbNormal:
        begin
          pr := ScrollButtonRight;
          cr := ScrollButtonRightColor;
        end;
        cnbHot:
        begin
          pr := ScrollButtonRightHot;
          cr := ScrollButtonRightHotColor;
        end;
        cnbDown:
        begin
          pr := ScrollButtonRightDown;
          cr := ScrollButtonRightDownColor;
        end;
      end;
      if Assigned(pl) and Assigned(pl.Graphic) then
        Canvas.StretchDraw(Bounds(R.Left + Round(5 * ScaleX) , R.Bottom - Round(FSize * ScaleY) + Round(5 * ScaleY), s, s), pl.Graphic)
      else
      begin
        Canvas.Brush.Color := cl;
        DrawArrow(Canvas, Bounds(R.Left + Round(5 * ScaleX) , R.Bottom - Round(FSize * ScaleY) + Round(5 * ScaleY), s, s), true, ScaleX, ScaleY);
      end;

      if Assigned(pr) and Assigned(pr.Graphic) then
        Canvas.StretchDraw(Bounds(R.Right - Round(5 * ScaleX) - s , R.Bottom - Round(FSize * ScaleY) + Round(5 * ScaleY), s, s), pr.Graphic)
      else
      begin
        Canvas.Brush.Color := cr;
        DrawArrow(Canvas, Bounds(R.Right - Round(5 * Scalex) - s , R.Bottom - Round(FSize * ScaleY) + Round(5 * ScaleY), s, s), false, ScaleX, ScaleY);
      end;
    end;
  end;
end;

function TChartNavigator.GetBottomSize: integer;
begin
  Result := 0;
  if Visible and not FOwner.Series.IsHorizontal then
    Result := Size;
end;

procedure TChartNavigator.LoadFromFile(ini: TMemIniFile;Section: String);
begin
  AlphaBlend := ini.ReadBool(Section, 'AlphaBlend', AlphaBlend);
  AlphaBlendValue := ini.ReadInteger(Section, 'AlphaBlendValue', AlphaBlendValue);
  Color := ini.ReadInteger(Section, 'Color', Color);
  ColorTo := ini.ReadInteger(Section, 'ColorTo', ColorTo);
  GradientDirection := TChartGradientDirection(ini.ReadInteger(Section, 'GradientDirection', Integer(GradientDirection)));
  GradientSteps := ini.ReadInteger(Section, 'GradientSteps', GradientSteps);
  //TODO
//  ini.ReadInteger(Section, 'ScrollbuttonLeft', Integer(ScrollButtonLeft));
//  ini.ReadInteger(Section, 'ScrollbuttonLeftHot', Integer(ScrollButtonLeftHot));
//  ini.ReadInteger(Section, 'ScrollbuttonLeftDown', Integer(ScrollButtonLeftDown));
  ini.ReadInteger(Section, 'ScrollbuttonLeftColor', ScrollButtonLeftColor);
  ini.ReadInteger(Section, 'ScrollbuttonLeftHotColor', ScrollButtonLeftHotColor);
  ini.ReadInteger(Section, 'ScrollbuttonLeftDownColor', ScrollButtonLeftDownColor);
//  ini.ReadInteger(Section, 'ScrollbuttonRight', Integer(ScrollButtonRight));
//  ini.ReadInteger(Section, 'ScrollbuttonRightHot', Integer(ScrollButtonRightHot));
//  ini.ReadInteger(Section, 'ScrollbuttonRightDown', Integer(ScrollButtonRightDown));
  ini.ReadInteger(Section, 'ScrollbuttonRightColor', ScrollButtonRightColor);
  ini.ReadInteger(Section, 'ScrollbuttonRightHotColor', ScrollButtonRightHotColor);
  ini.ReadInteger(Section, 'ScrollbuttonRightDownColor', ScrollButtonRightDownColor);
  ScrollButtons := ini.ReadBool(Section, 'ScrollButtons', ScrollButtons);
  ScrollButtonsSize := ini.ReadInteger(Section, 'ScrollButtonsSize', ScrollButtonsSize);
  Size := ini.ReadInteger(Section, 'Size', Size);
  Visible := ini.ReadBool(Section, 'Visible', Visible);
end;

procedure TChartNavigator.SaveToFile(ini: TMemIniFile;Section: String);
begin
  ini.WriteBool(Section, 'AlphaBlend', AlphaBlend);
  ini.WriteInteger(Section, 'AlphaBlendValue', AlphaBlendValue);
  ini.WriteInteger(Section, 'Color', Color);
  ini.WriteInteger(Section, 'ColorTo', ColorTo);
  ini.WriteInteger(Section, 'GradientDirection', Integer(GradientDirection));
  ini.WriteInteger(Section, 'GradientSteps', GradientSteps);
//  ini.WriteInteger(Section, 'ScrollbuttonLeft', Integer(ScrollButtonLeft));
//  ini.WriteInteger(Section, 'ScrollbuttonLeftHot', Integer(ScrollButtonLeftHot));
//  ini.WriteInteger(Section, 'ScrollbuttonLeftDown', Integer(ScrollButtonLeftDown));
  ini.WriteInteger(Section, 'ScrollbuttonLeftColor', ScrollButtonLeftColor);
  ini.WriteInteger(Section, 'ScrollbuttonLeftHotColor', ScrollButtonLeftHotColor);
  ini.WriteInteger(Section, 'ScrollbuttonLeftDownColor', ScrollButtonLeftDownColor);
//  ini.WriteInteger(Section, 'ScrollbuttonRight', Integer(ScrollButtonRight));
//  ini.WriteInteger(Section, 'ScrollbuttonRightHot', Integer(ScrollButtonRightHot));
//  ini.WriteInteger(Section, 'ScrollbuttonRightDown', Integer(ScrollButtonRightDown));
  ini.WriteInteger(Section, 'ScrollbuttonRightColor', ScrollButtonRightColor);
  ini.WriteInteger(Section, 'ScrollbuttonRightHotColor', ScrollButtonRightHotColor);
  ini.WriteInteger(Section, 'ScrollbuttonRightDownColor', ScrollButtonRightDownColor);
  ini.WriteBool(Section, 'ScrollButtons', ScrollButtons);
  ini.WriteInteger(Section, 'ScrollButtonsSize', ScrollButtonsSize);
  ini.WriteInteger(Section, 'Size', Size);
  ini.WriteBool(Section, 'Visible', Visible);
end;

procedure TChartNavigator.SetAlphaBlend(const Value: boolean);
begin
  if FAlphaBlend <> Value then
  begin
    FAlphaBlend := Value;
    Changed;
  end;
end;

procedure TChartNavigator.SetAlphaBlendValue(const Value: byte);
begin
  if (FAlphaBlendValue <> Value) then
  begin
    FAlphaBlendValue := Value;
    Changed;
  end;
end;

procedure TChartNavigator.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Changed;
  end;
end;

procedure TChartNavigator.SetColorTo(const Value: TColor);
begin
  if FColorTo <> Value then
  begin
    FColorTo := Value;
    Changed;
  end;
end;

procedure TChartNavigator.SetGradientDirection(
  const Value: TChartGradientDirection);
begin
  if FGradientDirection <> Value then
  begin
    FGradientDirection := Value;
    Changed;
  end;
end;

procedure TChartNavigator.SetGradientSteps(const Value: integer);
begin
  if (FGradientSteps <> Value) and (Value >= 0) then
  begin
    FGradientSteps := Value;
    Changed;
  end;
end;

procedure TChartNavigator.SetLeftButtonState(
  const Value: TChartNavigatorButtonState);
begin
  if FLeftButtonState <> Value then
  begin
    FLeftButtonState := Value;
    Changed;
  end;
end;

procedure TChartNavigator.SetRightButtonState(
  const Value: TChartNavigatorButtonState);
begin
  if FRightButtonState <> Value then
  begin
    FRightButtonState := Value;
    Changed;
  end;
end;

procedure TChartNavigator.SetScrollButtonLeft(const Value: TPicture);
begin
  if FScrollButtonLeft <> Value then
  begin
    FScrollButtonLeft.Assign(Value);
    Changed;
  end;
end;

procedure TChartNavigator.SetScrollButtonLeftColor(const Value: TColor);
begin
  if FScrollButtonLeftColor <> Value then
  begin
    FScrollButtonLeftColor := Value;
    Changed;
  end;
end;

procedure TChartNavigator.SetScrollButtonLeftDown(const Value: TPicture);
begin
  if FScrollButtonLeftDown <> Value then
  begin
    FScrollButtonLeftDown.Assign(Value);
    Changed;
  end;
end;

procedure TChartNavigator.SetScrollButtonLeftDownColor(const Value: TColor);
begin
  if FScrollButtonLeftDownColor <> Value then
  begin
    FScrollButtonLeftDownColor := Value;
    Changed;
  end;
end;

procedure TChartNavigator.SetScrollButtonLeftHot(const Value: TPicture);
begin
  if FScrollButtonLeftHot <> Value then
  begin
    FScrollButtonLeftHot.Assign(Value);
    Changed;
  end;
end;

procedure TChartNavigator.SetScrollButtonLeftHotColor(const Value: TColor);
begin
  if FScrollButtonLeftHotColor <> Value then
  begin
    FScrollButtonLeftHotColor := Value;
    Changed;
  end;
end;

procedure TChartNavigator.SetScrollButtonRight(const Value: TPicture);
begin
  if FScrollButtonRight <> Value then
  begin
    FScrollButtonRight.Assign(Value);
    Changed;
  end;
end;

procedure TChartNavigator.SetScrollButtonRightColor(const Value: TColor);
begin
  if FScrollButtonRightColor <> value then
  begin
    FScrollButtonRightColor := Value;
    Changed;
  end;
end;

procedure TChartNavigator.SetScrollButtonRightDown(const Value: TPicture);
begin
  if FScrollButtonRightDown <> value then
  begin
    FScrollButtonRightDown.Assign(Value);
    Changed;
  end;
end;

procedure TChartNavigator.SetScrollButtonRightDownColor(const Value: TColor);
begin
  if FScrollButtonRightDownColor <> value then
  begin
    FScrollButtonRightDownColor := Value;
    Changed;
  end;
end;

procedure TChartNavigator.SetScrollButtonRightHot(const Value: TPicture);
begin
  if FScrollButtonRightHot <> Value then
  begin
    FScrollButtonRightHot.Assign(Value);
    Changed;
  end;
end;

procedure TChartNavigator.SetScrollButtonRightHotColor(const Value: TColor);
begin
  if FScrollButtonRightHotColor <> Value then
  begin
    FScrollButtonRightHotColor := Value;
    Changed;
  end;
end;

procedure TChartNavigator.SetScrollButtons(const Value: boolean);
begin
  if FScrollButtons <> Value then
  begin
    FScrollButtons := Value;
    Changed;
  end;
end;

procedure TChartNavigator.SetScrollButtonsSize(const Value: integer);
begin
  if (FScrollbuttonsSize <> Value) and (Value >= 0) then
  begin
    FScrollButtonsSize := Value;
    Changed;
  end;
end;

procedure TChartNavigator.SetScrollStep(const Value: integer);
begin
  if FScrollStep <> value then
  begin
    FScrollStep := Value;
    Changed;
  end;
end;

procedure TChartNavigator.SetSize(const Value: integer);
begin
  if (FSize <> value) and (Value >= 0) then
  begin
    FSize := Value;
    Changed;
  end;
end;

procedure TChartNavigator.SetVisible(const Value: boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

{ TChartLegend }

procedure TChartLegend.Assign(Source: TPersistent);
begin
  FAlignment := (Source as TChartLegend).Alignment;
  FFont.Assign((Source as TChartLegend).Font);
  FPicture.Assign((Source as TChartLegend).Picture);
  FBackgroundPosition := (Source as TChartLegend).BackGroundPosition;
  FBorderRounding := (Source as TChartLegend).BorderRounding;
  FTop := (Source as TChartLegend).Top;
  FLeft := (Source as TChartLegend).Left;
  FColor := (Source as TChartLegend).Color;
  FColorTo := (Source as TChartLegend).ColorTo;
  FBorderColor := (Source as TChartLegend).BorderColor;
  FBorderWidth := (Source as TChartLegend).BorderWidth;
  FVisible := (Source as TChartLegend).Visible;
  FGradientSteps := (Source as TchartLegend).GradientSteps;
  FGradientDirection := (Source as TchartLegend).GradientDirection;
  FRectangleSize := (Source as TChartLegend).RectangleSize;
end;

procedure TChartLegend.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TChartLegend.Create(AOwner: TAdvChart);
begin
  FOwner := AOwner;
  FPicture := TPicture.Create;
  FTop := 0;
  FLeft := 0;
  FRectangleSize := 10;
  FRectangleSpacing := 5;
  FColor := clWhite;
  FBackGroundPosition := bpTopLeft;
  FGradientSteps := 100;
  FGradientDirection := cgdHorizontal;
  FColorTo := clNone;
  FBorderColor := clBlack;
  FBorderWidth := 1;
  FBorderRounding := 0;
  FVisible := true;
  FFont := TFont.Create;
  FDrawBkg := true;
  FAlignment := laCustom;
end;

destructor TChartLegend.Destroy;
begin
  FFont.Free;
  FPicture.Free;
  inherited;
end;

procedure TChartLegend.Draw(Canvas: TCanvas; R: TRect; ScaleX, ScaleY: Double);
var
  I, K: Integer;
  rsp, rs: integer;
  Width,Height, yo, xo: integer;
  DR: TRect;
  HRGN: THandle;
  x, y: integer;
  origr: TRect;
begin
  if FVisible = true then
  begin
    origr := FOwner.Series.SeriesRectangle;
    GetLegendPosition(x, y, origr.Right - origr.left, origr.Bottom - origr.Top, r.Right - r.Left, r.Bottom - r.Top, Alignment);
    r := Bounds(x + origr.Left, y + origr.Top, r.Right - r.Left, r.Bottom - R.Top);


    Height := R.Bottom - R.Top;
    Width := R.Right - R.Left;


    rs := Round(RectangleSize * ScaleX);
    rsp := Round(RectangleSpacing * ScaleX);

    Canvas.Pen.Color := BorderColor;
    Canvas.Pen.Width := Round(BorderWidth * Scalex);

    DR := Bounds(R.Left + Round(FLeft * ScaleX), R.Top + Round(FTop * ScaleY) , Width , Height);

    HRGN := CreateRoundRectRgn(DR.Left - Round(BorderWidth * Scalex), DR.Top - Round(BorderWidth * ScaleY), DR.Right + Round(BorderWidth * Scalex),
      DR.Bottom + Round(BorderWidth * Scaley), BorderRounding, BorderRounding);
    SelectClipRgn(Canvas.Handle,HRGN);

    if FDrawBkg then
    begin
      if FColorTo <> clNone then
      begin
        DrawGradient(Canvas, FColor, FColorTo, FGradientSteps, Bounds(R.Left + Round(FLeft * ScaleX), R.Top + Round(FTop * ScaleY), Width, Height),
          FGradientDirection, True, BorderColor, BorderWidth, asRectangle, 0, [cbLeft, cbTop, cbRight, cbBottom], false, false);
      end
      else
      begin
        if FColor <> clNone then
          Canvas.Brush.Color := FColor
        else
          Canvas.Brush.Style := bsClear;

          Canvas.RoundRect(DR.Left, DR.Top, DR.Right, DR.Bottom, BorderRounding, BorderRounding);
      end;
    end;

    if not (Picture.Graphic = nil) then
    begin
      case FBackgroundPosition of
      bpTopLeft:Canvas.Draw(r.Left + Left,r.Top + Top,FPicture.Graphic);
      bpTopRight:Canvas.Draw(Max(r.Left + Left,r.Right - Left - r.Left - Round(FPicture.Width * Scalex)),r.top + Top,FPicture.Graphic);
      bpBottomLeft:Canvas.Draw(r.left + Left,Max(r.top + Top, R.Bottom - Round(FPicture.Height * Scaley)),FPicture.Graphic);
      bpBottomRight:Canvas.Draw(Max(r.Left + Left,r.Right - Left - r.Left - Round(FPicture.Width * ScaleX)),Max(r.Top + Top,R.Bottom - Top - Round(FPicture.Height * ScaleY)),FPicture.Graphic);
      bpCenter:Canvas.Draw(Max(r.Left + Left,r.Right - Left - r.Left - Round(FPicture.Width * Scalex)) shr 1,Max(r.Top + Top,R.Bottom - Top - Round(FPicture.Height * ScaleY)) shr 1,FPicture.Graphic);
      bpTiled:begin
                yo := r.Top;
                while (yo < R.Bottom) do
                begin
                  xo := r.Left;
                  while (xo < R.Right) do
                  begin
                    Canvas.Draw(xo,yo,FPicture.Graphic);
                    xo := xo + Round(FPicture.Width * Scalex);
                  end;
                  yo := yo + Round(FPicture.Height * ScaleY);
                end;
              end;
      bpStretched:Canvas.StretchDraw(R,FPicture.Graphic);
      end;
    end;

    K := 0;
    for I := 0 to FOwner.FSeries.Count - 1 do
    begin
      with FOwner.FSeries.Items[I] do
      begin
        if (ChartType <> ctNone) and (SerieType <> stZoomControl) and ShowInLegend and Visible then
        begin
          case ChartType of
            ctError,ctArrow,ctLine, ctDigitalLine, ctHistogram, ctLineHistogram, ctXYLine, ctXYDigitalLine: Canvas.Brush.Color := LineColor
          else
            Canvas.Brush.Color := Color;
          end;

          Canvas.Pen.Color := BorderColor;

          Canvas.Font.Assign(Font);

          Canvas.Rectangle(Bounds(R.Left + Round(Left * ScaleX) + rsp, (rsp + R.Top + Round(Top * ScaleY) + (rsp * K) + ((K) * rs)), rs, rs));

          Canvas.Brush.Style := bsClear;
          Canvas.TextOut(R.Left + Round(Left * ScaleX) + 2 * rsp + rs, rsp + R.Top + (Round(Top * ScaleY) + (rsp * K) + ((K) * rs) + (rs - Canvas.TextHeight(LegendText)) div 2), LegendText);
          Inc(K);
        end;
      end;
    end;
    SelectClipRgn(Canvas.Handle,0);
    DeleteObject(HRGN);
  end;
end;

procedure TChartLegend.FontChanged(Sender: TObject);
begin
  Changed;
end;

function TChartLegend.GetRectangle: TRect;
var
  CX: TChartXAxis;
  CY: TChartYAXis;
  M: TChartMargin;
  T: TChartTitle;
  N: TChartNavigator;
  dm: Boolean;
  xt, yl, xb, yr: Integer;
  Dr: TRect;
  R: TRect;
  sCount: integer;
  i: integer;
  bmp: TBitmap;
  mw, sw: Integer;
  origr: TRect;
  x, y: integer;
begin
  bmp := TBitmap.Create;
  CX := FOwner.XAxis;
  CY := FOwner.YAxis;
  M := FOwner.Margin;
  N := FOwner.Navigator;
  T := FOwner.Title;
  dm := FOwner.Series.IsHorizontal;

  if dm then
  begin
    xt := CY.LeftSize;
    yl := CX.BottomSize;
    xb := CY.RightSize;
    yr := CX.TopSize;
  end
  else
  begin
    xt := CX.TopSize;
    yl := CY.LeftSize;
    xb := CX.BottomSize;
    yr := CY.RightSize;
  end;

  R := Bounds(0, 0, 0, 0);
  if Assigned(FOwner.GetPaneRectangle) then
    FOwner.GetPaneRectangle(FOwner, R);

  DR := Rect(R.Left + yl + M.LeftMargin, R.Top + T.TopSize + xt + M.TopMargin
    , R.Right - yr - M.RightMargin , R.Bottom - xb - T.BottomSize - M.BottomMargin - N.BottomSize);

  sCount := 0;
  for I := 0 to FOwner.Series.Count - 1 do
    if (FOwner.Series[I].ChartType <> ctNone) and (FOwner.Series[I].SerieType <> stZoomControl) and FOwner.Series[i].Visible
      and FOwner.Series[I].ShowInLegend then Inc(sCount);

  DR.Bottom := DR.Top + RectangleSpacing + (sCount) * Max(RectangleSize + RectangleSpacing, (bmp.Canvas.TextHeight('gh') + RectangleSpacing) - RectangleSpacing);

  bmp.Canvas.Font.Assign(Font);
  mw := 0;
  for i := 0 to FOwner.Series.Count - 1 do
  begin
    if (Fowner.Series[I].ChartType <> ctNone) and (Fowner.Series[I].SerieType <> stZoomControl) and Fowner.Series[i].Visible
      and Fowner.Series[I].ShowInLegend then
    begin
      sw := bmp.Canvas.TextWidth(FOwner.Series[i].LegendText) + RectangleSize + 3 * RectangleSpacing;
      if sw > mw then
        mw := sw;
    end;
  end;

  DR.Right := DR.Left + mw;

  origr := FOwner.Series.SeriesRectangle;
  GetLegendPosition(x, y, origr.Right - origr.left, origr.Bottom - origr.Top, dr.Right - dr.Left, dr.Bottom - dr.Top, Alignment);
  dr := Bounds(x + origr.Left + Left, y + origr.Top + Top, dr.Right - dr.Left, dr.Bottom - dr.Top);

  bmp.free;

  Result := dr;
end;

procedure TChartLegend.LoadFromFile(ini: TMemIniFile;Section: String);
var
  A: TStringList;
  I: integer;
  str: String;
begin
  Alignment := TChartLegendAlignment(ini.ReadInteger(Section, 'Alignment', Integer(Alignment)));
  BorderColor := ini.ReadInteger(Section, 'BorderColor', BorderColor);
  BorderWidth := ini.ReadInteger(Section, 'BorderWidth', BorderWidth);
  BorderRounding := ini.ReadInteger(Section, 'BorderRounding', BorderRounding);
  Color := ini.ReadInteger(Section, 'Color', Color);
  ColorTo := ini.ReadInteger(Section, 'ColorTo', ColorTo);
  Font.Size := ini.ReadInteger(Section, 'FontSize', Font.Size);
  Font.Color := ini.ReadInteger(Section, 'FontColor', Font.Color);
  Font.Name := ini.ReadString(Section, 'FontName', Font.Name);
  str := ini.ReadString(Section, 'FontStyle', str);
  A := TStringList.Create;
  Split(':',str, A);
  for I := 1 to A.Count - 1 do
  begin
    Font.Style := Font.Style + [TFontStyle(strtoint(A[I]))];
  end;
  A.Free;
  GradientDirection := TChartGradientDirection(ini.ReadInteger(Section, 'GradientDirection', Integer(GradientDirection)));
  GradientSteps := ini.ReadInteger(Section, 'GradientSteps', GradientSteps);
  Left := ini.ReadInteger(Section, 'Left', Left);
  Top := ini.ReadInteger(Section, 'Top', Top);
  RectangleSize := ini.ReadInteger(Section, 'RectangleSize', RectangleSize);
  RectangleSpacing := ini.ReadInteger(Section, 'RectangleSpacing', RectangleSpacing);
  Visible := ini.ReadBool(Section, 'Visible', Visible);
end;

procedure TChartLegend.SaveToFile(ini: TMemIniFile;Section: String);
begin
  ini.WriteInteger(Section, 'Alignment', Integer(Alignment));
  ini.WriteInteger(Section, 'BorderColor', BorderColor);
  ini.WriteInteger(Section, 'BorderWidth', BorderWidth);
  ini.WriteInteger(Section, 'BorderRounding', BorderRounding);
  ini.WriteInteger(Section, 'Color', Color);
  ini.WriteInteger(Section, 'ColorTo', ColorTo);
  ini.WriteInteger(Section, 'FontSize', Font.Size);
  ini.WriteInteger(Section, 'FontColor', Font.Color);
  ini.WriteString(Section, 'FontName', Font.Name);
  ini.WriteString(Section, 'FontStyle', GetFontStyles(Font.Style));
  ini.WriteInteger(Section, 'GradientDirection', Integer(GradientDirection));
  ini.WriteInteger(Section, 'GradientSteps', GradientSteps);
  ini.WriteInteger(Section, 'Left', Left);
  ini.WriteInteger(Section, 'Top', Top);
  ini.WriteInteger(Section, 'RectangleSize', RectangleSize);
  ini.WriteInteger(Section, 'RectangleSpacing', RectangleSpacing);
  ini.WriteBool(Section, 'Visible', Visible);
end;

procedure TChartLegend.SetAlignment(const Value: TChartLegendAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    Changed;
  end;
end;

procedure TChartLegend.SetBackGroundPosition(
  const Value: TChartBackGroundPosition);
begin
  if FBackgroundPosition <> Value then
  begin
    FBackgroundPosition := Value;
    Changed;
  end;
end;

procedure TChartLegend.SetBorderColor(const Value: TColor);
begin
  if FBorderColor <> Value then
  begin
    FBorderColor := Value;
    Changed;
  end;
end;

procedure TChartLegend.SetBorderRounding(const Value: integer);
begin
  if FBorderRounding <> value then
  begin
    FBorderRounding := Value;
    Changed;
  end;
end;

procedure TChartLegend.SetBorderWidth(const Value: integer);
begin
  if FBorderWidth <> Value then
  begin
    FBorderWidth := Value;
    Changed;
  end;
end;

procedure TChartLegend.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
     Changed;
  end;
end;

procedure TChartLegend.SetColorTo(const Value: TColor);
begin
  if FColorTo <> Value then
  begin
    FColorTo := Value;
    Changed;
  end;
end;

procedure TChartLegend.SetFont(const Value: TFont);
begin
  if FFont <> Value then
  begin
    FFont.Assign(Value);
    FontChanged(Self);
  end;
end;

procedure TChartLegend.SetGradientDirection(
  const Value: TChartGradientDirection);
begin
  if (FGradientDirection <> Value) then
  begin
    FGradientDirection := Value;
    Changed;
  end;
end;

procedure TChartLegend.SetGradientSteps(const Value: Integer);
begin
  if (FGradientSteps <> Value) and (Value >= 0) then
  begin
    FGradientSteps := Value;
    Changed;
  end;
end;

procedure TChartLegend.SetLeft(const Value: integer);
begin
  if FLeft <> Value then
  begin
    FLeft := Value;
    Changed;
  end;
end;

procedure TChartLegend.SetPicture(const Value: TPicture);
begin
  if FPicture <> Value then
  begin
    FPicture.Assign(Value);
  end;
end;

procedure TChartLegend.SetRectangleSize(const Value: Integer);
begin
  if (FRectangleSize <> Value) and (Value >= 0) then
  begin
    FRectangleSize := Value;
    Changed;
  end;
end;

procedure TChartLegend.SetRectangleSpacing(const Value: integer);
begin
  if (FRectangleSpacing <> Value) and (Value >= 0) then
  begin
    FRectangleSpacing := Value;
    Changed;
  end;
end;

procedure TChartLegend.SetTop(const Value: integer);
begin
  if FTop <> value then
  begin
    FTop := Value;
    Changed;
  end;
end;

procedure TChartLegend.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

{ TChartSerieYAxis }

procedure TChartSerieYAxis.Assign(Source: TPersistent);
begin
  FMinorUnitSpacing := (Source as TChartSerieYAxis).MinorUnitSpacing;
  FMajorUnitSpacing := (Source as TChartSerieYAxis).MajorUnitSpacing;
  FMajorUnit := (Source as TChartSerieYAxis).MajorUnit;
  FMinorUnit := (Source as TChartSerieYAxis).MinorUnit;
  FMajorFont.Assign((Source as TChartSerieYAxis).MajorFont);
  FMinorFont.Assign((Source as TChartSerieYAxis).MinorFont);
  FPosition := (Source as TChartSerieYAxis).FPosition;
  FTextLeft.Assign((Source as TChartSerieYAxis).TextLeft);
  FTextRight.Assign((Source as TChartSerieYAxis).TextRight);
  FTickMarkColor := (Source as TChartSerieYAxis).TickMarkColor;
  FTickMarkSize := (Source as TChartSerieYAxis).TickMarkSize;
  FTickMarkWidth := (Source as TChartSerieYAxis).TickMarkWidth;
  FTickMarkSizeMinor := (Source as TChartSerieYAxis).TickMarkSizeMinor;
  FMajorUnitVisible := (Source as TChartSerieYAxis).MajorUnitVisible;
  FMinorUnitVisible := (Source as TChartSerieYAxis).MinorUnitVisible;
  FVisible := (Source as TChartSerieYAxis).Visible;
  FAutoUnits := (Source as TChartSerieYAxis).AutoUnits;
  Changed;
end;

procedure TChartSerieYAxis.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TChartSerieYAxis.Create;
begin
  FMajorFont := TFont.Create;
  FMinorFont := TFont.Create;
  FTextLeft := TChartXYAxisText.Create;
  FTextLeft.OnChange := TextLeftChanged;
  FTextRight := TChartXYAxisText.Create;
  FTextRight.OnChange := TextRightChanged;
  FTickMarkColor := clNone;
  FTickMarkSize := 10;
  FTickMarkWidth := 1;
  FTickMarkSizeMinor := 7;
  FVisible := true;
  FMinorUnitVisible := true;
  FMajorUnitVisible := true;
  FAutoUnits := True;
end;

destructor TChartSerieYAxis.Destroy;
begin
  FMajorFont.Free;
  FMinorFont.Free;
  FTextLeft.Free;
  FTextRight.Free;
  inherited;
end;

procedure TChartSerieYAxis.FontChanged(Sender: TObject);
begin
  Changed;
end;

procedure TChartSerieYAxis.LoadFromFile(ini: TMemIniFile;Section: String);
var
  A: TStringList;
  str: String;
  I: integer;
begin
  MajorFont.Size := ini.ReadInteger(Section, 'MajorFontSize', MajorFont.Size);
  MajorFont.Color := ini.ReadInteger(Section, 'MajorFontColor', MajorFont.Color);
  MajorFont.Name := ini.ReadString(Section, 'MajorFontName', MajorFont.Name);
  str := ini.ReadString(Section, 'MajorFontStyle', '');
  A := TStringList.Create;
  Split(':',str, A);
  for I := 1 to A.Count - 1 do
  begin
    MajorFont.Style := MajorFont.Style + [TFontStyle(strtoint(A[I]))];
  end;
  A.Free;
  MinorFont.Size := ini.ReadInteger(Section, 'MinorFontSize', MinorFont.Size);
  MinorFont.Color := ini.ReadInteger(Section, 'MinorFontColor', MinorFont.Color);
  MinorFont.Name := ini.ReadString(Section, 'MinorFontName', MinorFont.Name);
  str := ini.ReadString(Section, 'MinorFontStyle', '');
  A := TStringList.Create;
  Split(':',str, A);
  for I := 1 to A.Count - 1 do
  begin
    MinorFont.Style := MinorFont.Style + [TFontStyle(strtoint(A[I]))];
  end;
  A.Free;
  MajorUnit := ini.ReadFloat(Section, 'MajorUnit', MajorUnit);
  MajorUnitSpacing := ini.ReadInteger(Section, 'MajorUnitSpacing', MajorUnitSpacing);
  MajorUnitVisible := ini.ReadBool(Section, 'MajorUnitVisible', MajorUnitVisible);
  MinorUnit := ini.ReadFloat(Section, 'MinorUnit', MinorUnit);
  MinorUnitSpacing := ini.ReadInteger(Section, 'MinorUnitSpacing', MinorUnitSpacing);
  MinorUnitVisible := ini.ReadBool(Section, 'MinorUnitVisible', MinorUnitVisible);
  Position := TChartYAxisPosition(ini.ReadInteger(Section, 'Position', Integer(Position)));
  TextLeft.LoadFromFile(ini, Section + '.' + 'TextLeft');
  TextRight.LoadFromFile(ini, Section + '.' + 'TextRight');
  TickMarkColor := ini.ReadInteger(Section, 'TickMarkColor', TickMarkColor);
  TickMarkSize := ini.ReadInteger(Section, 'TickMarkSize', TickMarkSize);
  TickMarkSizeMinor := ini.ReadInteger(Section, 'TickMarkSizeMinor', TickMarkSizeMinor);
  TickMarkWidth := ini.ReadInteger(Section, 'TickMarkWidth', TickMarkWidth);
  Visible := ini.ReadBool(Section, 'Visible', Visible);
  AutoUnits := ini.ReadBool(Section, 'AutoUnits', AutoUnits);
end;

procedure TChartSerieYAxis.SaveToFile(ini: TMemIniFile;Section: String);
begin
  ini.WriteInteger(Section, 'MajorFontSize', MajorFont.Size);
  ini.WriteInteger(Section, 'MajorFontColor', MajorFont.Color);
  ini.WriteString(Section, 'MajorFontName', MajorFont.Name);
  ini.WriteString(Section, 'MajorFontStyle', GetFontStyles(MajorFont.Style));
  ini.WriteBool(Section, 'MajorUnitVisible', MajorUnitVisible);
  ini.WriteBool(Section, 'MinorUnitVisible', MinorUnitVisible);

  ini.WriteInteger(Section, 'MinorFontSize', MinorFont.Size);
  ini.WriteInteger(Section, 'MinorFontColor', MinorFont.Color);
  ini.WriteString(Section, 'MinorFontName', MinorFont.Name);
  ini.WriteString(Section, 'MinorFontStyle', GetFontStyles(MinorFont.Style));
  ini.WriteFloat(Section, 'MajorUnit', MajorUnit);
  ini.WriteInteger(Section, 'MajorUnitSpacing', MajorUnitSpacing);
  ini.WriteFloat(Section, 'MinorUnit', MinorUnit);
  ini.WriteInteger(Section, 'MinorUnitSpacing', MinorUnitSpacing);
  ini.WriteInteger(Section, 'Position', Integer(Position));
  TextLeft.SaveToFile(ini, Section + '.' + 'TextLeft');
  TextRight.SavetoFile(ini, Section + '.' + 'TextRight');
  ini.WriteInteger(Section, 'TickMarkColor', TickMarkColor);
  ini.WriteInteger(Section, 'TickMarkSize', TickMarkSize);
  ini.WriteInteger(Section, 'TickMarkWidth', TickMarkWidth);
  ini.WriteBool(Section, 'Visible', Visible);
  ini.WriteBool(Section, 'AutoUnits', AutoUnits);
end;

procedure TChartSerieYAxis.SetAutoUnits(const Value: Boolean);
begin
  if FAutoUnits <> Value then
  begin
    FAutoUnits := Value;
    Changed;
  end;
end;

procedure TChartSerieYAxis.SetMajorFont(const Value: TFont);
begin
  if FMajorFont <> Value then
  begin
    FMajorFont.Assign(Value);
    FontChanged(Self);
  end;
end;

procedure TChartSerieYAxis.SetMajorUnit(const Value: Double);
begin
  if (FMajorUnit <> Value) and (Value >= 0) then
  begin
    FMajorUnit := Value;
    Changed;
  end;
end;

procedure TChartSerieYAxis.SetMajorUnitSpacing(const Value: integer);
begin
  if FMajorUnitSpacing <> Value then
  begin
    FMajorUnitSpacing := Value;
    Changed;
  end;
end;

procedure TChartSerieYAxis.SetMajorUnitVisible(const Value: Boolean);
begin
  if FMajorUnitVisible <> value then
  begin
    FMajorUnitVisible := Value;
    Changed;
  end;
end;

procedure TChartSerieYAxis.SetMinorFont(const Value: TFont);
begin
  if FMinorFont <> Value then
  begin
    FMinorFont.Assign(Value);
    FontChanged(Self);
  end;
end;

procedure TChartSerieYAxis.SetMinorUnit(const Value: Double);
begin
  if (FMinorUnit <> Value) and (Value >= 0) then
  begin
   FMinorUnit := Value;
   Changed;
  end;
end;

procedure TChartSerieYAxis.SetMinorUnitSpacing(const Value: integer);
begin
  if FMinorUnitSpacing <> Value then
  begin
    FMinorUnitSpacing := Value;
    Changed;
  end;
end;

procedure TChartSerieYAxis.SetMinorUnitVisible(const Value: Boolean);
begin
  if FMinorUnitVisible <> value then
  begin
    FMinorUnitVisible := Value;
    Changed;
  end;
end;

procedure TChartSerieYAxis.SetPosition(const Value: TChartYAxisPosition);
begin
  if FPosition <> Value then
  begin
    FPosition := Value;
    Changed;
  end;
end;

procedure TChartSerieYAxis.SetTextLeft(const Value: TChartXYAxisText);
begin
  if FTextLeft <> Value then
  begin
    FTextLeft.Assign(Value);
    TextLeftChanged(Self);
  end;
end;

procedure TChartSerieYAxis.SetTextRight(const Value: TChartXYAxisText);
begin
  if FTextRight <> Value then
  begin
    FTextRight.Assign(Value);
    TextRightChanged(Self);
  end;
end;

procedure TChartSerieYAxis.SetTickMarkColor(const Value: TColor);
begin
  if FTickMarkColor <> Value then
  begin
    FTickMarkColor := Value;
    Changed;
  end;
end;

procedure TChartSerieYAxis.SetTickMarkSize(const Value: integer);
begin
  if FTickMarkSize <> Value then
  begin
    FTickmarkSize := Value;
    Changed;
  end;
end;

procedure TChartSerieYAxis.SetTickMarkSizeMinor(const Value: integer);
begin
  if FTickMarkSizeMinor <> value then
  begin
    FTickMarkSizeMinor := Value;
    Changed;
  end;
end;

procedure TChartSerieYAxis.SetTickMarkWidth(const Value: integer);
begin
  if (FTickMarkWidth <> Value) and (Value >= 0) then
  begin
    FTickMarkWidth := Value;
    Changed;
  end;
end;

procedure TChartSerieYAxis.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

procedure TChartSerieYAxis.TextLeftChanged(Sender: TObject);
begin
  Changed;
end;

procedure TChartSerieYAxis.TextRightChanged(Sender: TObject);
begin
  Changed;
end;

{ TChartSerieXAxis }

procedure TChartSerieXAxis.Assign(Source: TPersistent);
begin
  FDateTimeFormat := (Source as TChartSerieXaxis).DateTimeFormat;
  FDateTimeFont.Assign((Source as TChartSerieXAxis).DateTimeFont);
  FMinorUnitSpacing := (Source as TChartSerieXAxis).MinorUnitSpacing;
  FMajorUnitSpacing := (Source as TChartSerieXAxis).MajorUnitSpacing;
  FMinorUnitTimeFormat := (Source as TChartSerieXAxis).MinorUnitTimeFormat;
  FMajorUnitTimeFormat := (Source as TChartSerieXAxis).MajorUnitTimeFormat;
  FMajorUnit := (Source as TChartSerieXAxis).MajorUnit;
  FMinorUnit := (Source as TChartSerieXAxis).MinorUnit;
  FMajorFont.Assign((Source as TChartSerieXAxis).MajorFont);
  FMinorFont.Assign((Source as TChartSerieXAxis).MinorFont);
  FPosition := (Source as TChartSerieXAxis).FPosition;
  FTextTop.Assign((Source as TChartSerieXAxis).TextTop);
  FTextBottom.Assign((Source as TChartSerieXAxis).TextBottom);
  FTickMarkColor := (Source as TChartSerieXAxis).TickMarkColor;
  FTickMarkSize := (Source as TChartSerieXAxis).TickMarkSize;
  FTickMarkWidth := (Source as TChartSerieXAxis).TickMarkWidth;
  FVisible := (Source as TChartSerieXaxis).Visible;
  FAutoUnits := (Source as TChartSerieXaxis).AutoUnits;
  FXYValueOffset := (Source as TChartSerieXAxis).XYValuesOffset;
  FXYValues := (Source as TChartSerieXAxis).XYValues;
end;

procedure TChartSerieXAxis.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TChartSerieXAxis.Create;
begin
  FMinorFont := TFont.Create;
  FMajorFont := TFont.Create;
  FDateTimeFont := TFont.Create;
  FTextTop := TChartXYAxisText.Create;
  FTextBottom := TChartXYAxisText.Create;
  FMinorUnit := 1;
  FMajorUnit := 1;
  FTickMarkColor := clBlack;
  FTickMarkSize := 10;
  FTickMarkWidth := 1;
  FVisible := true;
  FAutoUnits := true;
  FXYValueOffset := 0;
  FXYValues := true;
end;

destructor TChartSerieXAxis.Destroy;
begin
  FDateTimeFont.Free;
  FMinorFont.Free;
  FMajorFont.Free;
  FTextTop.Free;
  FTextBottom.Free;
  inherited;
end;

procedure TChartSerieXAxis.FontChanged(Sender: TObject);
begin
  Changed;
end;

procedure TChartSerieXAxis.LoadFromFile(ini: TMemIniFile;Section: String);
var
  A: TStringList;
  str: String;
  I: Integer;
begin
  MajorFont.Size := ini.ReadInteger(Section, 'MajorFontSize', MajorFont.Size);
  MajorFont.Color := ini.ReadInteger(Section, 'MajorFontColor', MajorFont.Color);
  MajorFont.Name := ini.ReadString(Section, 'MajorFontName', MajorFont.Name);
  str := ini.ReadString(Section, 'MajorFontStyle', '');
  A := TStringList.Create;
  Split(':',str, A);
  for I := 1 to A.Count - 1 do
  begin
    MajorFont.Style := MajorFont.Style + [TFontStyle(strtoint(A[I]))];
  end;
  A.Free;
  MinorFont.Size := ini.ReadInteger(Section, 'MinorFontSize', MinorFont.Size);
  MinorFont.Color := ini.ReadInteger(Section, 'MinorFontColor', MinorFont.Color);
  MinorFont.Name := ini.ReadString(Section, 'MinorFontName', MinorFont.Name);
  str := ini.ReadString(Section, 'MinorFontStyle', '');
  A := TStringList.Create;
  Split(':',str, A);
  for I := 1 to A.Count - 1 do
  begin
    MinorFont.Style := MinorFont.Style + [TFontStyle(strtoint(A[I]))];
  end;
  A.Free;
  DateTimeFormat := ini.ReadString(Section, 'DateTimeFormat', DateTimeFormat);
  DateTimeFont.Size := ini.ReadInteger(Section, 'DateTimeFontSize', Datetimefont.Size);
  DateTimeFont.Color := ini.ReadInteger(Section, 'DateTimeFontColor', Datetimefont.Color);
  DateTimeFont.Name := ini.ReadString(Section, 'DateTimeFontName', Datetimefont.Name);
  str := ini.ReadString(Section, 'DateTimeFontStyle', '');
  A := TStringList.Create;
  Split(':',str, A);
  for I := 1 to A.Count - 1 do
  begin
    DatetimeFont.Style := DatetimeFont.Style + [TFontStyle(strtoint(A[I]))];
  end;
  A.Free;
  MajorUnit := ini.ReadFloat(Section, 'MajorUnit', MajorUnit);
  MajorUnitTimeFormat := ini.ReadString(Section, 'MajorUnitTimeFormat', MajorUnitTimeFormat);
  MajorUnitSpacing := ini.ReadInteger(Section, 'MajorUnitSpacing', MajorUnitSpacing);
  MinorUnit := ini.ReadFloat(Section, 'MinorUnit', MinorUnit);
  MinorUnitTimeFormat := ini.ReadString(Section, 'MinorUnitTimeFormat', MinorUnitTimeFormat);
  MinorUnitSpacing := ini.ReadInteger(Section, 'MinorUnitSpacing', MinorUnitSpacing);
  Position := TChartXAxisPosition(ini.ReadInteger(Section, 'Position', Integer(Position)));
  TextTop.LoadFromFile(ini, Section + '.' + 'TextTop');
  TextBottom.LoadFromFile(ini, Section + '.' + 'TextBottom');
  TickMarkColor := ini.ReadInteger(Section, 'TickMarkColor', TickMarkColor);
  TickMarkSize := ini.ReadInteger(Section, 'TickMarkSize', TickMarkSize);
  TickMarkWidth := ini.ReadInteger(Section, 'TickMarkWidth', TickMarkWidth);
  Visible := ini.ReadBool(Section, 'Visible', Visible);
  AutoUnits := ini.ReadBool(Section, 'AutoUnits', AutoUnits);
  XYValues := ini.ReadBool(Section, 'XYValues', XYValues);
  XYValuesOffset := ini.ReadInteger(Section, 'XYValuesOffset', XYValuesOffset);
end;

procedure TChartSerieXAxis.SaveToFile(ini: TMemIniFile;Section: String);
begin
  ini.WriteInteger(Section, 'MajorFontSize', MajorFont.Size);
  ini.WriteInteger(Section, 'MajorFontColor', MajorFont.Color);
  ini.WriteString(Section, 'MajorFontName', MajorFont.Name);
  ini.WriteString(Section, 'MajorFontStyle', GetFontStyles(MajorFont.Style));

  ini.WriteInteger(Section, 'MinorFontSize', MinorFont.Size);
  ini.WriteInteger(Section, 'MinorFontColor', MinorFont.Color);
  ini.WriteString(Section, 'MinorFontName', MinorFont.Name);
  ini.WriteString(Section, 'MinorFontStyle', GetFontStyles(MinorFont.Style));
  ini.WriteString(Section, 'DateTimeFormat', DateTimeFormat);
  ini.WriteInteger(Section, 'DateTimeFontSize', Datetimefont.Size);
  ini.WriteInteger(Section, 'DateTimeFontColor', Datetimefont.Color);
  ini.WriteString(Section, 'DateTimeFontName', Datetimefont.Name);
  ini.WriteString(Section, 'DateTimeFontStyle', GetFontStyles(DateTimeFont.Style));

  ini.WriteFloat(Section, 'MajorUnit', MajorUnit);
  ini.WriteString(Section, 'MajorUnitTimeFormat', MajorUnitTimeFormat);
  ini.WriteInteger(Section, 'MajorUnitSpacing', MajorUnitSpacing);
  ini.WriteFloat(Section, 'MinorUnit', MinorUnit);
  ini.WriteString(Section, 'MinorUnitTimeFormat', MinorUnitTimeFormat);
  ini.WriteInteger(Section, 'MinorUnitSpacing', MinorUnitSpacing);
  ini.WriteInteger(Section, 'Position', Integer(Position));
  TextTop.SaveToFile(ini, Section + '.' + 'TextTop');
  TextBottom.SavetoFile(ini, Section + '.' + 'TextBottom');
  ini.WriteInteger(Section, 'TickMarkColor', TickMarkColor);
  ini.WriteInteger(Section, 'TickMarkSize', TickMarkSize);
  ini.WriteInteger(Section, 'TickMarkWidth', TickMarkWidth);
  ini.WriteBool(Section, 'Visible', Visible);
  ini.WriteBool(Section, 'AutoUnits', AutoUnits);
  ini.WriteBool(Section, 'XYValues', XYValues);
  ini.WriteInteger(Section , 'XYValuesOffset', XYValuesOffset);
end;

procedure TChartSerieXAxis.SetAutoUnits(const Value: Boolean);
begin
  if FAutoUnits <> Value then
  begin
    FAutoUnits := Value;
    Changed;
  end;
end;

procedure TChartSerieXAxis.SetDateTimeFont(const Value: TFont);
begin
  if FDateTimeFont <> Value then
  begin
    FDateTimeFont.Assign(Value);
    FontChanged(Self);
  end;
end;

procedure TChartSerieXAxis.SetDateTimeFormat(const Value: String);
begin
  if FDateTimeFormat <> Value then
  begin
    FDateTimeFormat := Value;
    Changed;
  end;
end;

procedure TChartSerieXAxis.SetMajorFont(const Value: TFont);
begin
  if FMajorFont <> Value then
  begin
    FMajorFont.Assign(Value);
    FontChanged(Self);
  end;
end;

procedure TChartSerieXAxis.SetMajorUnit(const Value: Double);
begin
  if (FMajorUnit <> Value) and (Value >= 0) then
  begin
    FMajorUnit := Value;
    Changed;
  end;
end;

procedure TChartSerieXAxis.SetMajorUnitSpacing(const Value: integer);
begin
  if FMajorUnitSpacing <> Value then
  begin
    FMajorUnitSpacing := Value;
    Changed;
  end;
end;

procedure TChartSerieXAxis.SetMajorUnitTimeFormat(const Value: String);
begin
  if FMajorUnitTimeFormat <> Value then
  begin
    FMajorUnitTimeFormat := Value;
    Changed;
  end;
end;

procedure TChartSerieXAxis.SetMinorFont(const Value: TFont);
begin
  if FMinorFont <> Value then
  begin
    FMinorFont.Assign(Value);
    FontChanged(Self);
  end;
end;

procedure TChartSerieXAxis.SetMinorUnit(const Value: Double);
begin
  if (FMinorUnit <> Value) and (Value >= 0) then
  begin
    FMinorUnit := Value;
    Changed;
  end;
end;

procedure TChartSerieXAxis.SetMinorUnitSpacing(const Value: integer);
begin
  if FMinorUnitSpacing <> Value then
  begin
    FMinorUnitSpacing := Value;
    Changed;
  end;
end;

procedure TChartSerieXAxis.SetMinorUnitTimeFormat(const Value: String);
begin
  if FMinorUnitTimeFormat <> Value then
  begin
    FMinorUnitTimeFormat := Value;
    Changed;
  end;
end;

procedure TChartSerieXAxis.SetPosition(const Value: TChartXAxisPosition);
begin
  if FPosition <> Value then
  begin
    FPosition := Value;
    Changed;
  end;
end;

procedure TChartSerieXAxis.SetTextBottom(const Value: TChartXYAxisText);
begin
  if FTextBottom <> Value then
  begin
    FTextBottom.Assign(Value);
    TextBottomChanged(Self);
  end;
end;

procedure TChartSerieXAxis.SetTextTop(const Value: TChartXYAxisText);
begin
  if FTextTop <> Value then
  begin
    FTextTop.Assign(Value);
    TextTopChanged(Self);
  end;
end;

procedure TChartSerieXAxis.SetTickMarkColor(const Value: TColor);
begin
  if FTickMarkColor <> Value then
  begin
    FTickMarkColor := Value;
    Changed;
  end;
end;

procedure TChartSerieXAxis.SetTickMarkSize(const Value: integer);
begin
  if (FTickMarkSize <> Value) then
  begin
    FTickmarkSize := Value;
    Changed;
  end;
end;

procedure TChartSerieXAxis.SetTickMarkWidth(const Value: integer);
begin
  if (FTickMarkWidth <> Value) and (Value >= 0) then
  begin
    FTickMarkWidth := Value;
    Changed;
  end;
end;

procedure TChartSerieXAxis.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

procedure TChartSerieXAxis.SetXYValues(const Value: Boolean);
begin
  if FXYValues <> Value then
  begin
    FXYValues := Value;
    Changed;
  end;
end;

procedure TChartSerieXAxis.SetXYValuesOffset(const Value: integer);
begin
  if FXYValueOffset <> Value then
  begin
    FXYValueOffset := Value;
    Changed;
  end;
end;

procedure TChartSerieXAxis.TextBottomChanged(Sender: TObject);
begin
  Changed;
end;

procedure TChartSerieXAxis.TextTopChanged(Sender: TObject);
begin
  Changed;
end;

procedure TChartSerie.XAxisChanged(Sender: TObject);
begin
  Changed;
end;

procedure TChartSerie.DrawTickMark(Canvas: TCanvas; X: TChartSerieXAxis; Top: Boolean; Rect: TRect; ScaleX, ScaleY: Double);
begin
  if x.TickMarkColor <> clNone then
  begin
    Canvas.Pen.Color := x.TickMarkColor;
    Canvas.Pen.Width := Round(x.TickMarkWidth * ScaleX);
    Canvas.Pen.Style := psSolid;

    if Chart.Series.IsHorizontal then
    begin
      if Top and ((XAxis.Position = xTop) or (XAxis.Position = xBoth)) then
      begin
        Canvas.MoveTo(Rect.Left, FXMarker);
        Canvas.LineTo(Rect.Left + Round(x.TickMarkSize * ScaleX), FXMarker);
      end
      else if not Top and ((XAxis.Position = xBottom) or (XAxis.Position = xBoth)) then
      begin
        Canvas.MoveTo(Rect.Right, FXMarker);
        Canvas.LineTo(Rect.Right - Round(x.TickMarkSize * ScaleX), FXMarker);
      end;
    end
    else
    begin
      if Top and ((XAxis.Position = xTop) or (XAxis.Position = xBoth)) then
      begin
        Canvas.MoveTo(FXMarker, Rect.Bottom);
        Canvas.LineTo(FXMarker, Rect.Bottom - Round(x.TickMarkSize * ScaleX));
      end
      else if not Top and ((XAxis.Position = xBottom) or (XAxis.Position = xBoth)) then
      begin
        Canvas.MoveTo(FXMarker, Rect.Top);
        Canvas.LineTo(FXMarker, Rect.Top + Round(x.TickMarkSize * ScaleX));
      end;
    end;
  end;
end;

procedure TChartSerie.XAxisDrawValue(Sender: TObject; Serie: TChartSerie; Canvas: TCanvas;
  ARect: TRect; XAxisY, ValueIndex: integer; XMarker: integer; Top: Boolean; ScaleX, ScaleY: Double;
  DrawCustomValues: Boolean;
   var defaultdraw: Boolean);
var
  s: string;
  tf: TFont;
  lf: TLogFontW;
  x: TChartSerieXaxis;
  angle: integer;
  m: integer;
  th, tw: Integer;
  modcheck: Boolean;
  xpos, ypos: integer;
  ang: Double;
  dx: integer;
  minst, majst, majsb, minsb: integer;
  dm: Boolean;
  pt: TChartPoint;
  sx: String;
begin
  dm := Chart.Series.IsHorizontal;
  if Chart.XAxis.AutoSize then
  begin
    majst := GetXMajorUnitSpacing(False);
    minst := GetXMinorUnitSpacing(False);
    majsb := GetXMajorUnitSpacing(True);
    minsb := GetXMinorUnitSpacing(True);
  end
  else
  begin
    majst := Round(XAxis.MajorUnitSpacing * ScaleY);
    minst := Round(XAxis.MajorUnitSpacing * ScaleY);
    majsb := majst;
    minsb := minst;
  end;

  if ((Collection as TChartSeries).SeriesRectangle.Bottom > (Collection as TChartSeries).SeriesRectangle.Top) and ((Collection as TChartSeries).SeriesRectangle.Right > (Collection as TChartSeries).SeriesRectangle.Left) then
  begin
    if DrawCustomValues then
    begin
      if Assigned(FOnXAxisDrawXValue) then
        FOnXAxisDrawXValue(Sender, Serie, Canvas, ARect, ValueIndex, XMarker, Top, defaultdraw);
    end
    else
    begin
      if Assigned(FOnXAxisDrawValue) then
        FOnXAxisDrawValue(Sender, Serie, Canvas, ARect, ValueIndex, XMarker, Top, defaultdraw);
    end;

    if defaultdraw then
    begin
      FDrawMajorValue := false;
      FDrawMinorValue := false;

      m := XMarker;
      x := Xaxis;

      if Top then
        angle := -GetAngle(x.TextTop)
      else
        angle := GetAngle(x.TextBottom);


      if (x.DateTimeFormat <> '') then
        DrawDateTimeValues(x.DateTimeFormat, ValueIndex, Canvas, ARect, m);

      if FMu > 0 then
      begin
        if (ValueIndex mod Fmu = 0) then
        begin
          if angle <> 0 then
          begin
            tf := nil;
            try
              tf := TFont.Create;
              tf.Assign(x.MajorFont);
              GetObject(tf.Handle, SizeOf(lf), @lf);
              lf.lfEscapement := angle;
              lf.lfOrientation := lf.lfEscapement;
              tf.Handle := CreateFontIndirectW(lf);
              Canvas.Font.Assign(tf);
            finally
              tf.free;
            end;
          end
          else
            Canvas.Font.Assign(x.MajorFont);

          if Chart.Series.IsHorizontal then
            DrawTickMark(Canvas, x, Top, Rect(XAxisY, ARect.Top, XAxisY, ARect.Bottom), ScaleX, ScaleY)
          else
            DrawTickMark(Canvas, x, Top, Rect(ARect.Left, XAxisY, ARect.Right, XAxisY), ScaleX, ScaleY);


          if (Chart.XAxis.UnitType = utNumber) then
            s := inttostr(ValueIndex)
          else
          begin
            if DrawCustomValues then
              s := FormatDateTime(x.MajorUnitTimeFormat, GetPoint(ValueIndex).TimeStamp)
            else
              s := FormatDateTime(x.MajorUnitTimeFormat, GetXTimeStamp(ValueIndex))
          end;

          pt := GetChartPoint(ValueIndex);

          case ChartType of
            ctXYLine, ctXYMarkers, ctXYDigitalLine:
            begin
              if (ChartType <> ctGantt) then
              begin
                sx := FindXAxisTextForValue(ValueIndex);
                if sx <> '' then
                  s := sx;
              end;
            end
            else
            begin
              if (pt.LegendValue <> '') and (ChartType <> ctGantt) then
                s := pt.LegendValue;
            end;
          end;

          if DrawCustomValues then
          begin
            if Assigned(FOnXAxisGetXValue) then
              FOnXAxisGetXValue(self, self, ValueIndex, s);
          end
          else
          begin
            if Assigned(FOnXAxisGetValue) then
              FOnXAxisGetValue(self, self, ValueIndex, s);
          end;

          th := Canvas.TextHeight(s);
          tw := Canvas.TextWidth(s);

          xpos := -1;
          ypos := -1;

          if Chart.Series.IsHorizontal then
          begin
            if Top and ((XAxis.Position = xTop) or (XAxis.Position = xBoth)) then
            begin
              xpos := ARect.Left + majst + Round(x.TickMarkSize * ScaleY);
              ypos := FXMarker;
            end
            else if not Top and ((XAxis.Position = xBottom) or (XAxis.Position = xBoth)) then
            begin
              xpos := ARect.Right - majsb - Round(x.TickMarkSize * ScaleY) - tw;
              ypos := FXMarker;
            end;
          end
          else
          begin
            if Top and ((XAxis.Position = xTop) or (XAxis.Position = xBoth)) then
            begin
              xpos := FXMarker;
              ypos := ARect.Bottom - majst - Round(x.TickMarkSize * ScaleY) - th;
            end
            else if not Top and ((XAxis.Position = xBottom) or (XAxis.Position = xBoth)) then
            begin
              xpos := FXMarker;
              ypos := ARect.Top + majsb + Round(x.TickMarkSize * ScaleY);
            end;
          end;

          tw := tw div 2;
          th := th div 2;
          if not Chart.Series.IsHorizontal then
            ypos := ypos + th
          else
            xpos := xpos + tw;

          ang := DegToRad(angle / 10);
          if dm then
          begin
            dx := round(th * cos(ang) + tw * sin(ang));
            if abs(angle) > 0 then
            begin
              if not Top then
              begin
                if angle > 0 then
                  Canvas.TextOut(xpos + th div 2,ypos + tw, s)
                else
                  Canvas.TextOut(xpos - dx , ypos - tw, s)
              end
              else
              begin
                if angle > 0 then
                  Canvas.TextOut(xpos - dx + th div 2, ypos + tw , s)
                else
                  Canvas.TextOut(xpos , ypos - tw, s)
              end;
            end
            else
              Canvas.TextOut(xpos - tw, ypos - dx, s);
          end
          else
          begin
            dx := round(tw * cos(ang) + th * sin(ang));
            if abs(angle) > 0 then
            begin
              if not Top then
              begin
                if angle > 0 then
                  Canvas.TextOut(xpos - dx, ypos + tw * 2, s)
                else
                  Canvas.TextOut(xpos - dx, ypos, s)
              end
              else
              begin
                if angle > 0 then
                  Canvas.TextOut(xpos - dx, ypos , s)
                else
                  Canvas.TextOut(xpos - dx, ypos - tw * 2, s)
              end;
            end
            else
              Canvas.TextOut(xpos - dx, ypos - th, s);
          end;
        end;
      end;

      if (Fmi > 0) then
      begin
        modcheck := false;
        if (FMi > 0) and (FMu > 0) then
          modCheck := (ValueIndex mod Fmi = 0) and (ValueIndex mod Fmu <> 0)
        else if (FMi > 0) then
          modcheck := (ValueIndex mod fMi = 0);

        if modcheck then
        begin
          if Top then
            angle := GetAngle(x.TextTop)
          else
            angle := GetAngle(x.TextBottom);

          if angle <> 0 then
          begin
            tf := nil;
            try
              tf := TFont.Create;
              tf.Assign(x.MinorFont);
              GetObject(tf.Handle, SizeOf(lf), @lf);
              lf.lfOrientation := angle;
              lf.lfEscapement := lf.lfOrientation;
              tf.Handle := CreateFontIndirectW(lf);
              Canvas.Font.Assign(tf);
            finally
              tf.free;
            end;
          end
          else
            Canvas.Font.Assign(x.MinorFont);

          if (Chart.XAxis.UnitType = utNumber) then
            s := inttostr(ValueIndex)
          else
          begin
            if DrawCustomValues then
              s := FormatDateTime(x.MinorUnitTimeFormat, GetPoint(ValueIndex).TimeStamp)
            else
              s := FormatDateTime(x.MinorUnitTimeFormat, GetXTimeStamp(ValueIndex))
          end;

          if (GetChartPoint(ValueIndex).LegendValue <> '') and (ChartType <> ctGantt) then
            s := GetChartPoint(ValueIndex).LegendValue;

          if Chart.Series.IsHorizontal then
            DrawTickMark(Canvas, x, Top, Rect(XAxisY, ARect.Top, XAxisY, ARect.Bottom), ScaleX, ScaleY)
          else
            DrawTickMark(Canvas, x, Top, Rect(ARect.Left, XAxisY, ARect.Right, XAxisY), ScaleX, ScaleY);


          if DrawCustomValues then
          begin
            if Assigned(FOnXAxisGetXValue) then
              FOnXAxisGetXValue(self, self, ValueIndex, s);
          end
          else
          begin
            if Assigned(FOnXAxisGetValue) then
              FOnXAxisGetValue(self, self, ValueIndex, s);
          end;

          tw := Canvas.Textwidth(s);
          th := Canvas.TextHeight(s);

          xpos := -1;
          ypos := -1;

          if Chart.Series.IsHorizontal then
          begin
            if Top and ((XAxis.Position = xTop) or (XAxis.Position = xBoth)) then
            begin
              xpos := ARect.Left + minst + Round(x.TickMarkSize * ScaleY);
              ypos := FXMarker;
            end
            else if not Top and ((XAxis.Position = xBottom) or (XAxis.Position = xBoth)) then
            begin
              xpos := ARect.Right - minsb - Round(x.TickMarkSize * ScaleY) - tw;
              ypos := FXMarker;
            end;
          end
          else
          begin
            if Top and ((XAxis.Position = xTop) or (XAxis.Position = xBoth)) then
            begin
              xpos := FXMarker;
              ypos := ARect.Bottom - minst - Round(x.TickMarkSize * ScaleY) - th;
            end
            else if not Top and ((XAxis.Position = xBottom) or (XAxis.Position = xBoth)) then
            begin
              xpos := FXMarker;
              ypos := ARect.Top + minsb + Round(x.TickMarkSize * ScaleY);
            end;
          end;

          tw := tw div 2;
          th := th div 2;

          if not Chart.Series.IsHorizontal then
            ypos := ypos + th
          else
            xpos := xpos + tw;

          ang := DegToRad(angle / 10);
          if dm then
          begin
            dx := round(th * cos(ang) + tw * sin(ang));
            if abs(angle) > 0 then
            begin
              if not Top then
              begin
                if angle > 0 then
                  Canvas.TextOut(xpos + th div 2,ypos + tw, s)
                else
                  Canvas.TextOut(xpos - dx , ypos - tw, s)
              end
              else
              begin
                if angle > 0 then
                  Canvas.TextOut(xpos - dx + th div 2, ypos + tw , s)
                else
                  Canvas.TextOut(xpos , ypos - tw, s)
              end;
            end
            else
              Canvas.TextOut(xpos - tw, ypos - dx, s);
          end
          else
          begin
            dx := round(tw * cos(ang) + th * sin(ang));
            if abs(angle) > 0 then
            begin
              if not Top then
              begin
                if angle > 0 then
                  Canvas.TextOut(xpos - dx, ypos + tw * 2, s)
                else
                  Canvas.TextOut(xpos - dx, ypos, s)
              end
              else
              begin
                if angle > 0 then
                  Canvas.TextOut(xpos - dx, ypos , s)
                else
                  Canvas.TextOut(xpos - dx, ypos - tw * 2, s)
              end;
            end
            else
              Canvas.TextOut(xpos - dx, ypos - th, s);
          end;
        end;
      end;
    end;
  end;
end;

function TChartSerie.GetXAxisValueSize(Sender: TObject; Serie: TChartSerie; Canvas: TCanvas; ValueIndex: integer; ScaleX, ScaleY: Double; DrawCustomValues: Boolean; var defaultdraw: Boolean): Integer;
var
  s: string;
  x: TChartSerieXaxis;
  th, tw: Integer;
  modcheck: Boolean;
  totalsize: Integer;
  majs, mins: integer;
begin
  totalsize := 0;
  FDrawMajorValue := false;
  FDrawMinorValue := false;

  x := Xaxis;

  majs := Round(x.MajorUnitSpacing * ScaleY);
  mins := Round(x.MinorUnitSpacing * ScaleY);

  if FMu > 0 then
  begin
    if (ValueIndex mod Fmu = 0) then
    begin
      Canvas.Font.Assign(x.MajorFont);

      if (Chart.XAxis.UnitType = utNumber) then
        s := inttostr(ValueIndex)
      else
      begin
        if DrawCustomValues then
          s := FormatDateTime(x.MajorUnitTimeFormat, GetPoint(ValueIndex).TimeStamp)
        else
          s := FormatDateTime(x.MajorUnitTimeFormat, GetXTimeStamp(ValueIndex))
      end;

      if (GetChartPoint(ValueIndex).LegendValue <> '') and (ChartType <> ctGantt) then
        s := GetChartPoint(ValueIndex).LegendValue;

      if DrawCustomValues then
      begin
        if Assigned(FOnXAxisGetXValue) then
          FOnXAxisGetXValue(self, self, ValueIndex, s);
      end
      else
      begin
        if Assigned(FOnXAxisGetValue) then
          FOnXAxisGetValue(self, self, ValueIndex, s);
      end;

      th := Canvas.TextHeight(s);
      tw := Canvas.TextWidth(s);

      if Chart.Series.IsHorizontal then
      begin
        if (XAxis.TextBottom.Angle <> 0) or (XAxis.TextTop.Angle <> 0) then
        begin
          if th + majs + (x.TickMarkSize * scaleY) > totalsize then
            totalsize := th + majs + Round(x.TickMarkSize * scaleY);
        end
        else
        begin
          if tw + majs + (x.TickMarkSize * scaleY) > totalsize then
            totalsize := tw + majs + Round(x.TickMarkSize * scaleY);
        end;
      end
      else
      begin
        if (XAxis.TextBottom.Angle <> 0) or (XAxis.TextTop.Angle <> 0) then
        begin
          if tw + majs + (x.TickMarkSize * scaleY) > totalsize then
            totalsize := tw + majs + Round(x.TickMarkSize * scaleY);
        end
        else
        begin
          if th + majs + (x.TickMarkSize * scaleY) > totalsize then
            totalsize := th + majs + Round(x.TickMarkSize * scaleY);
        end;
      end;
    end;
  end;

  if (Fmi > 0) then
  begin
    modcheck := false;
    if (FMi > 0) and (FMu > 0) then
      modCheck := (ValueIndex mod Fmi = 0) and (ValueIndex mod Fmu <> 0)
    else if (FMi > 0) then
      modcheck := (ValueIndex mod fMi = 0);

    if modcheck then
    begin
      Canvas.Font.Assign(x.MinorFont);

      if (Chart.XAxis.UnitType = utNumber) then
        s := inttostr(ValueIndex)
      else
      begin
        if DrawCustomValues then
          s := FormatDateTime(x.MinorUnitTimeFormat, GetPoint(ValueIndex).TimeStamp)
        else
          s := FormatDateTime(x.MinorUnitTimeFormat, GetXTimeStamp(ValueIndex))
      end;

      if (GetChartPoint(ValueIndex).LegendValue <> '') and (ChartType <> ctGantt) then
        s := GetChartPoint(ValueIndex).LegendValue;

      if DrawCustomValues then
      begin
        if Assigned(FOnXAxisGetXValue) then
          FOnXAxisGetXValue(self, self, ValueIndex, s);
      end
      else
      begin
        if Assigned(FOnXAxisGetValue) then
          FOnXAxisGetValue(self, self, ValueIndex, s);
      end;

      tw := Canvas.Textwidth(s);
      th := Canvas.TextHeight(s);

      if Chart.Series.IsHorizontal then
      begin
        if (XAxis.TextBottom.Angle <> 0) or (XAxis.TextTop.Angle <> 0) then
        begin
          if th + mins + (x.TickMarkSize * scaleY) > totalsize then
            totalsize := th + mins + Round(x.TickMarkSize * scaleY);
        end
        else
        begin
          if tw + mins + (x.TickMarkSize * scaleY) > totalsize then
            totalsize := tw + mins + Round(x.TickMarkSize * scaleY);
        end;
      end
      else
      begin
        if (XAxis.TextBottom.Angle <> 0) or (XAxis.TextTop.Angle <> 0) then
        begin
          if tw + mins + (x.TickMarkSize * scaleY) > totalsize then
            totalsize := tw + mins + Round(x.TickMarkSize * scaleY);
        end
        else
        begin
          if th + mins + (x.TickMarkSize * scaleY) > totalsize then
            totalsize := th + mins + Round(x.TickMarkSize * scaleY);
        end;
      end;
    end;
  end;
  Result := totalsize + 10;
end;


function TChartSerie.GetXMajorUnitSpacing(Bottom: Boolean): integer;
var
  i: integer;
  bmp: TBitmap;
  chk: Boolean;
  totsz: integer;
begin
  bmp := TBitmap.Create;
  Result := 0;
  for I := 0 to Index - 1 do
  begin
    if Bottom then
      chk := (Chart.Series[i].XAxis.Position in [xBottom, xBoth]) and (XAxis.Position in [xBottom, xBoth])
    else
      chk := (Chart.Series[i].XAxis.Position in [xTop, xBoth]) and (XAxis.Position in [xTop, xBoth]);

    if chk then
    begin
      Result := Result + Chart.Series[I].GetXValuesSize(bmp.Canvas, 1, 1, totsz);
    end;
  end;

  bmp.Free;
end;

function TChartSerie.GetXMinorUnitSpacing(Bottom: Boolean): Integer;
var
  i: integer;
  bmp: TBitmap;
  chk: Boolean;
  totsz: integer;
begin
  bmp := TBitmap.Create;
  Result := 0;
  for I := 0 to Index - 1 do
  begin
    if Bottom then
      chk := (Chart.Series[i].XAxis.Position in [xBottom, xBoth]) and (XAxis.Position in [xBottom, xBoth])
    else
      chk := (Chart.Series[i].XAxis.Position in [xTop, xBoth]) and (XAxis.Position in [xTop, xBoth]);

    if chk then
    begin
      Result := Result + Chart.Series[I].GetXValuesSize(bmp.Canvas, 1, 1, totsz);
    end;
  end;

  bmp.Free;
end;

function TChartSerie.ConvertDateToXDate(Date: TDateTime): TDateTime;
var
  Y, m, d, h, n, s, z: Word;
begin
  result := Date;
  DecodeDateTime(Result, Y, m, d, h, n, s, z);

  case Chart.XAxis.UnitType of
    utMilliSecond: result := EncodeDateTime(Y, m, d, h, n, s, z);
    utSecond: result := EncodeDateTime(Y, m, d, h, n, s, 0);
    utMinute: result := EncodeDateTime(Y, m, d, h, n, 0, 0);
    utHour: result := EncodeDateTime(Y, m, d, h, 0, 0, 0);
    utDay, utWeek: result := encodeDateTime(y, m, d, 0, 0, 0, 0);
    utMonth: result := EncodeDate(Y, m, 1);
    utYear: result := EncodeDate(Y, 1, 1)
  end;
end;

function TChartSerie.GetXTimeStamp(ValueIndex: integer): TDateTime;
begin
  Result := ConvertDateToXDate(Chart.Range.StartDate);

  case Chart.XAxis.UnitType of
    utMilliSecond: result := IncMilliSecond(result, ValueIndex);
    utSecond: result := IncSecond(result, ValueIndex);
    utMinute: result := IncMinute(result, ValueIndex);
    utHour: result := IncHour(result, ValueIndex);
    utWeek: Result := IncDay(Result, ValueIndex * 7);
    utDay: result := IncDay(result, ValueIndex);
    utMonth: result := IncMonth(result, ValueIndex);
    utYear: result := IncYear(result, ValueIndex);
  end;
end;

function TChartSerie.XToValue(value: integer; R: TRect): double;
begin
  if Chart.Series.IsHorizontal then
  begin
    if Chart.XScale > 0 then
      Result := ((value - r.Top - Chart.GetXScaleStart) / Chart.XScale) + Chart.Range.RangeFrom
    else
      Result := ((value - r.Top - Chart.GetXScaleStart) / 1) +  + Chart.Range.RangeFrom;
  end
  else
  begin
    if Chart.XScale > 0 then
      Result := ((Value - r.Left - Chart.GetXScaleStart) / Chart.XScale) + Chart.Range.RangeFrom
    else
      Result := ((Value - r.Left - Chart.GetXScaleStart) / 1) +  Chart.Range.RangeFrom;
  end;
end;

procedure TChartSerie.YAxisChanged(Sender: TObject);
begin
  Changed;
end;

{ TChartDrawValues }

{ TChartSerieCrossHairYValue }

procedure TChartSerieCrossHairYValue.Assign(Source: TPersistent);
begin
  FVisible := (Source as TChartSerieCrossHairYValue).Visible;
  FBorderWidth := (Source as TChartSerieCrossHairYValue).BorderWidth;
  FColor := (Source as TChartSerieCrossHairYValue).Color;
  FColorTo := (Source as TChartSerieCrossHairYValue).ColorTo;
  FFont.Assign((Source as TChartSerieCrossHairYValue).Font);
  FBorderColor := (Source as TChartSerieCrossHairYValue).BorderColor;
end;

procedure TChartSerieCrossHairYValue.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TChartSerieCrossHairYValue.Create;
begin
  FFont := TFont.Create;
  FVisible := true;
  FColor := clNone;
  FColorTo := clNone;
  FBorderColor := clNone;
end;

destructor TChartSerieCrossHairYValue.Destroy;
begin
  FFont.Free;
  inherited;
end;

procedure TChartSerieCrossHairYValue.LoadFromFile(ini: TMemIniFile;Section: String);
var
  A: TStringList;
  str: String;
  I: integer;
begin
  BorderColor := ini.ReadInteger(Section, 'BorderColor', BorderColor);
  Color := ini.ReadInteger(Section, 'Color', Color);
  ColorTo := ini.ReadInteger(Section, 'ColorTo', ColorTo);
  Font.Size := ini.ReadInteger(Section, 'FontSize', Font.Size);
  Font.Color := ini.ReadInteger(Section, 'FontColor', Font.Color);
  Font.Name := ini.ReadString(Section, 'FontName', Font.Name);
  str := ini.ReadString(Section, 'FontStyle', '');
  A := TStringList.Create;
  Split(':',str, A);
  for I := 1 to A.Count - 1 do
  begin
    Font.Style := Font.Style + [TFontStyle(strtoint(A[I]))];
  end;
  A.Free;
  GradientDirection := TChartGradientDirection(ini.ReadInteger(Section, 'GradientDirection', Integer(GradientDirection)));
  GradientSteps := ini.ReadInteger(Section, 'GradientSteps', GradientSteps);
  Visible := ini.ReadBool(Section, 'Visible', Visible);
end;

procedure TChartSerieCrossHairYValue.SaveToFile(ini: TMemIniFile;Section: String);
begin
  ini.WriteInteger(Section, 'BorderColor', BorderColor);
  ini.WriteInteger(Section, 'Color', Color);
  ini.WriteInteger(Section, 'ColorTo', ColorTo);
  ini.WriteInteger(Section, 'FontSize', Font.Size);
  ini.WriteInteger(Section, 'FontColor', Font.Color);
  ini.WriteString(Section, 'FontName', Font.Name);
  ini.WriteString(Section, 'FontStyle', GetFontStyles(Font.style));
  ini.WriteInteger(Section, 'GradientDirection', Integer(GradientDirection));
  ini.WriteInteger(Section, 'GradientSteps', GradientSteps);
  ini.WriteBool(Section, 'Visible', Visible);
end;

procedure TChartSerieCrossHairYValue.SetBorderColor(const Value: TColor);
begin
  if FBorderColor <> Value then
  begin
    FBorderColor := Value;
    Changed;
  end;
end;

procedure TChartSerieCrossHairYValue.SetBorderWidth(const Value: integer);
begin
  if FBorderWidth <> Value then
  begin
    FBorderWidth := Value;
    Changed;
  end;
end;

procedure TChartSerieCrossHairYValue.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Changed;
  end;
end;

procedure TChartSerieCrossHairYValue.SetColorTo(const Value: TColor);
begin
  if FColorTo <> value then
  begin
    FColorTo := Value;
    Changed;
  end;
end;

procedure TChartSerieCrossHairYValue.SetFont(const Value: TFont);
begin
  if FFont <> Value then
  begin
    FFont.Assign(Value);
    Changed;
  end;
end;

procedure TChartSerieCrossHairYValue.SetGradientDirection(
  const Value: TChartGradientDirection);
begin
  if FGradientDirection <> Value then
  begin
    FGradientDirection := Value;
    Changed;
  end;
end;

procedure TChartSerieCrossHairYValue.SetGradientSteps(const Value: integer);
begin
  if (FGradientSteps <> value) and (Value >= 0) then
  begin
    FGradientSteps := Value;
    Changed;
  end;
end;

procedure TChartSerieCrossHairYValue.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

{ TChartCrossHairYValues }

procedure TChartCrossHairYValues.Assign(Source: TPersistent);
begin
  FShowSerieValues := (Source as TChartCrossHairYValues).ShowSerieValues;
  FShowYPosValue := (Source as TChartCrossHairYValues).ShowYPosValue;
  FPosition := (Source as TChartCrossHairYValues).Position;
end;

procedure TChartCrossHairYValues.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TChartCrossHairYValues.Create;
begin
  FShowSerieValues := true;
  FShowYPosValue := false;
  FPosition := [chYAxis];
end;

procedure TChartCrossHairYValues.LoadFromFile(ini: TMemIniFile; Section: String);
var
  A: TStringList;
  str: String;
  I: integer;
begin
  ShowSerieValues := ini.ReadBool(Section, 'ShowSerieValues', ShowSerieValues);
  ShowYposValue := ini.ReadBool(Section, 'ShowYPosValue', ShowYPosValue);
  str := ini.Readstring(Section, 'Position', '');
  A := TStringList.Create;
  Split(':',str, A);
  for I := 1 to A.Count - 1 do
  begin
    Position := Position + [TChartCrossHairYValuePositionType(strtoint(A[I]))];
  end;
  A.Free;
end;

function GetPositions(position: TChartCrossHairYValuePosition): String;
var
  str: String;
begin
  str := '';
  if chYAxis in position then
    str := str + ':0';
  if chAtCursor in position then
    str := str + ':1';
  if chValueTracker in position then
    str := str + ':2';
  Result := str;
end;

procedure TChartCrossHairYValues.SaveToFile(ini: TMemIniFile; Section: String);
begin
  ini.WriteBool(Section, 'ShowSerieValues', ShowSerieValues);
  ini.WriteBool(Section, 'ShowYPosValue', ShowYPosValue);
  ini.Writestring(Section, 'Position', GetPositions(Position));
end;

procedure TChartCrossHairYValues.SetPosition(
  const Value: TChartCrossHairYValuePosition);
begin
  if FPosition <> value then
  begin
    FPosition := Value;
    Changed;
  end;
end;

procedure TChartCrossHairYValues.SetShowSerieValues(const Value: Boolean);
begin
  if FShowSerieValues <> Value then
  begin
    FShowSerieValues := Value;
    Changed;
  end;
end;

procedure TChartCrossHairYValues.SetShowYPosValue(const Value: Boolean);
begin
  if FShowYPosValue <> Value then
  begin
    FShowYPosValue := Value;
    Changed;
  end;
end;

{ TChartAnnotations }

function TChartAnnotations.Add: TChartAnnotation;
var
  annotation: TChartAnnotation;
begin
  annotation := TChartAnnotation(inherited Add);
  annotation.OnChange := AnnotationChanged;
  Result := annotation;
end;

procedure TChartAnnotations.AnnotationChanged(Sender: TObject);
begin
  Changed;
end;

procedure TChartAnnotations.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TChartAnnotations.Create(AOwner: TChartSerie);
begin
  inherited Create(AOwner, GetItemClass);
  FOwner := AOwner;
end;

destructor TChartAnnotations.Destroy;
begin
  inherited;
end;

function TChartAnnotations.GetItem(Index: Integer): TChartAnnotation;
begin
  Result := TChartAnnotation(inherited GetItem(Index));
end;

function TChartAnnotations.GetItemClass: TCollectionItemClass;
begin
  Result := TChartAnnotation;
end;

function TChartAnnotations.Insert(index: integer): TChartAnnotation;
begin
  Result := TChartAnnotation(inherited Insert(Index));
end;

procedure TChartAnnotations.LoadFromFile(ini: TMemIniFile; Section: String);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Items[I].LoadFromFile(ini, Section + '.' + Items[I].Name);
  end;
end;

procedure TChartAnnotations.SaveToFile(ini: TMemIniFile; Section: String);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Items[I].SaveToFile(ini, Section + '.' + Items[I].Name);
  end;
end;

procedure TChartAnnotations.SetItem(Index: Integer;
  const Value: TChartAnnotation);
begin
  inherited SetItem(Index, Value);
  Changed;
end;

procedure TChartAnnotations.Update(Item: TCollectionItem);
begin
  inherited;
  Changed;
end;

{ TChartAnnotation }

procedure TChartAnnotation.Assign(Source: TPersistent);
begin
  if Source is TChartAnnotation then
  begin
    FName := (Source as TChartAnnotation).Name;
    FLineColor := (Source as TChartAnnotation).LineColor;
    FLineWidth := (Source as TChartAnnotation).LineWidth;
    FArrowColor := (Source as TchartAnnotation).ArrowColor;
    FTextHorizontalAlignment := (Source as TChartAnnotation).TextHorizontalAlignment;
    FTextVerticalAlignment := (Source as TChartAnnotation).TextVerticalAlignment;
    FText := (Source as TChartAnnotation).Text;
    FBalloonArrowSize := (Source as TChartAnnotation).BalloonArrowSize;
    FBalloonDirection := (Source as TChartAnnotation).BalloonDirection;
    FArrowSize := (Source as TChartAnnotation).ArrowSize;
    FColor := (Source as TChartAnnotation).Color;
    FColorTo := (Source as TChartAnnotation).ColorTo;
    FPointIndex := (Source as TChartAnnotation).PointIndex;
    FDisplayIndex := (Source as TChartAnnotation).DisplayIndex;
    FBorderColor := (Source as TChartAnnotation).BorderColor;
    FBorderRounding := (Source as TChartAnnotation).BorderRounding;
    FFont.Assign((Source as TChartAnnotation).Font);
    FWidth := (Source as TChartAnnotation).Width;
    FHeight := (Source as TChartAnnotation).Height;
    FAutoSize := (Source as TChartAnnotation).AutoSize;
    FOffsetX := (Source as TChartAnnotation).OffsetX;
    FOffsetY := (Source as TChartAnnotation).OffsetY;
    FArrow := (Source as TChartAnnotation).Arrow;
    FShape := (Source as TChartAnnotation).Shape;
    FGradientSteps := (Source as TChartAnnotation).GradientSteps;
    FGradientDirection := (Source as TChartAnnotation).GradientDirection;
    FBorderWidth := (Source as TchartAnnotation).BorderWidth;
    FVisible := (Source as TChartAnnotation).Visible;
    FWordWrap := (Source as TchartAnnotation).WordWrap;
  end;
end;

procedure TChartAnnotation.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TChartAnnotation.Create(Collection: TCollection);
begin
  inherited;
  FOwner := (Collection.Owner);
  FName := 'Annotation ' + inttostr(Index);
  FWordWrap := false;
  FText := '';
  TextHorizontalAlignment := taLeftJustify;
  TextVerticalAlignment := taAlignTop;
  FArrowColor := clNone;
  FBalloonDirection := hdDownLeft;
  FColor := clYellow;
  FColorTo := clNone;
  FPointIndex := -1;
  FBorderColor := clBlack;
  FBorderRounding := 0;
  FBalloonArrowSize := 15;
  FFont := TFont.Create;
  FVisible := true;
  FWidth := 0;
  FHeight := 0;
  FAutoSize := true;
  FOffsetX := 20;
  FOffsetY := 20;
  FArrow := arLine;
  FArrowSize := 10;
  FGradientSteps := 100;
  FGradientDirection := cgdVertical;
  FBorderWidth := 1;
  FShape := asRectangle;
end;

destructor TChartAnnotation.Destroy;
begin
  FFont.Free;
  inherited;
end;

procedure TChartAnnotation.FontChanged(Sender: Tobject);
begin
  Changed;
end;

function TChartAnnotation.GetSerie: TChartSerie;
begin
  Result := (Self.FOwner as TChartSerie);
end;

procedure TChartAnnotation.LoadFromFile(ini: TMemIniFile; Section: String);
var
  A: TStringList;
  I: integer;
  str: String;
begin
  Name := ini.ReadString(Section, 'Name', Name);
  TextHorizontalAlignment := TAlignment(ini.ReadInteger(Section, 'TextHorizontalAlignment', Integer(TextHorizontalAlignment)));
  TextVerticalAlignment := TVerticalAlignment(ini.ReadInteger(Section, 'TextVerticalAlignment', Integer(TextVerticalAlignment)));
  Arrow := TAnnotationArrow(ini.ReadInteger(Section, 'Arrow', Integer(Arrow)));
  ArrowSize := ini.ReadInteger(Section, 'ArrowSize', ArrowSize);
  ArrowColor := ini.ReadInteger(Section, 'ArrowColor', ArrowColor);
  AutoSize := ini.ReadBool(Section, 'AutoSize', AutoSize);
  Balloondirection := TAnnotationBalloondirection(ini.ReadInteger(Section, 'BalloonDirection', Integer(BalloonDirection)));
  BalloonArrowSize := ini.ReadInteger(Section, 'BalloonArrowSize', BalloonArrowSize);
  BorderColor := ini.ReadInteger(Section, 'BorderColor', BorderColor);
  BorderRounding := ini.ReadInteger(Section, 'BorderRounding', BorderRounding);
  BorderWidth := ini.ReadInteger(Section, 'BorderWidth', BorderWidth);
  LineWidth := ini.ReadInteger(Section, 'LineWidth', LineWidth);
  LineColor := ini.readInteger(section, 'LineColor', LineColor);
  Color := ini.readInteger(Section, 'Color', Color);
  ColorTo := ini.readInteger(Section, 'ColorTo', ColorTo);
  Font.Size := ini.ReadInteger(Section, 'FontSize', Font.Size);
  Font.Color := ini.ReadInteger(Section, 'FontColor', Font.Color);
  Font.Name := ini.ReadString(Section, 'FontName', Font.Name);
  str := ini.ReadString(Section, 'FontStyle', str);
  A := TStringList.Create;
  Split(':',str, A);
  for I := 1 to A.Count - 1 do
  begin
    Font.Style := Font.Style + [TFontStyle(strtoint(A[I]))];
  end;
  A.Free;
  GradientSteps := ini.ReadInteger(Section, 'GradientSteps', GradientSteps);
  GradientDirection := TChartGradientdirection(ini.readInteger(Section, 'GradientDirection', Integer(GradientDirection)));
  Height := ini.ReadInteger(Section, 'Height', Height);
  OffsetX := ini.ReadInteger(Section, 'OffsetX', OffsetX);
  OffsetY := ini.ReadInteger(Section, 'OffsetY', OffsetY);
  Shape := TAnnotationShape(ini.ReadInteger(Section, 'Shape', Integer(Shape)));
  Text := ini.ReadString(Section, 'Text', Text);
  Width := ini.ReadInteger(Section, 'Width', Width);
  WordWrap := ini.ReadBool(Section, 'WordWrap', WordWrap);
  Visible := ini.ReadBool(Section, 'Visible', Visible);
  PointIndex := ini.ReadInteger(Section, 'PointIndex', PointIndex);
end;

procedure TChartAnnotation.SaveToFile(ini: TMemIniFile; Section: String);
begin
  ini.WriteString(Section, 'Name', Name);
  ini.WriteInteger(Section, 'TextHorizontalAlignment', Integer(TextHorizontalAlignment));
  ini.WriteInteger(Section, 'TextVerticalAlignment', Integer(TextVerticalAlignment));
  ini.WriteInteger(Section, 'Arrow', Integer(Arrow));
  ini.WriteInteger(Section, 'ArrowSize', ArrowSize);
  ini.WriteInteger(Section, 'ArrowColor', ArrowColor);
  ini.WriteBool(Section, 'AutoSize', AutoSize);
  ini.WriteInteger(Section, 'BalloonDirection', Integer(BalloonDirection));
  ini.WriteInteger(Section, 'BalloonArrowSize', BalloonArrowSize);
  ini.WriteInteger(Section, 'BorderColor', BorderColor);
  ini.WriteInteger(Section, 'BorderRounding', BorderRounding);
  ini.WriteInteger(Section, 'BorderWidth', BorderWidth);
  ini.WriteInteger(Section, 'LineWidth', LineWidth);
  ini.WriteInteger(section, 'LineColor', LineColor);
  ini.WriteInteger(Section, 'Color', Color);
  ini.WriteInteger(Section, 'ColorTo', ColorTo);
  ini.WriteInteger(Section, 'FontSize', Font.Size);
  ini.WriteInteger(Section, 'FontColor', Font.Color);
  ini.WriteString(Section, 'FontName', Font.Name);
  ini.WriteString(Section, 'FontStyle',GetFontStyles(Font.Style));
  ini.WriteInteger(Section, 'GradientSteps', GradientSteps);
  ini.WriteInteger(Section, 'GradientDirection', Integer(GradientDirection));
  ini.WriteInteger(Section, 'Height', Height);
  ini.WriteInteger(Section, 'OffsetX', OffsetX);
  ini.WriteInteger(Section, 'OffsetY', OffsetY);
  ini.WriteInteger(Section, 'Shape', Integer(Shape));
  ini.WriteString(Section, 'Text', Text);
  ini.WriteInteger(Section, 'Width', Width);
  ini.WriteBool(Section, 'WordWrap', WordWrap);
  ini.WriteBool(Section, 'Visible', Visible);
  ini.WriteInteger(Section, 'PointIndex', PointIndex);
end;

procedure TChartAnnotation.SetArrow(const Value: TAnnotationArrow);
begin
  if FArrow <> Value then
  begin
    FArrow := Value;
    Changed;
  end;
end;

procedure TChartAnnotation.SetArrowColor(const Value: TColor);
begin
  if FArrowColor <> Value then
  begin
    FArrowColor := Value;
    Changed;
  end;
end;

procedure TChartAnnotation.SetArrowSize(const Value: integer);
begin
  if FArrowSize <> Value then
  begin
    FArrowSize := Value;
    Changed;
  end;
end;

procedure TChartAnnotation.SetAutoSize(const Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    Changed;
  end;
end;

procedure TChartAnnotation.SetBalloonArrowSize(const Value: Integer);
begin
  if FBalloonArrowSize <> Value then
  begin
    FBalloonArrowSize := Value;
    Changed;
  end;
end;

procedure TChartAnnotation.SetBalloonDirection(
  const Value: TAnnotationBalloonDirection);
begin
  if FBalloonDirection <> Value then
  begin
    FBalloonDirection := Value;
    Changed;
  end;
end;

procedure TChartAnnotation.SetBorderColor(const Value: TColor);
begin
  if fBorderColor <> Value then
  begin
    FBorderColor := Value;
    Changed;
  end;
end;

procedure TChartAnnotation.SetBorderRounding(const Value: integer);
begin
  if FBorderRounding <> Value then
  begin
    FBorderRounding := Value;
    Changed;
  end;
end;

procedure TChartAnnotation.SetborderWidth(const Value: integer);
begin
  if FBorderWidth <> value then
  begin
    FBorderWidth := Value;
    Changed;
  end;
end;

procedure TChartAnnotation.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Changed;
  end;
end;

procedure TChartAnnotation.SetColorTo(const Value: TColor);
begin
  if FColorTo <> Value then
  begin
    FColorTo := Value;
    Changed;
  end;
end;

procedure TChartAnnotation.SetFont(const Value: TFont);
begin
  if FFont <> Value then
  begin
    FFont.Assign(Value);
    FontChanged(Self);
  end;
end;

procedure TChartAnnotation.SetGradientDirection(
  const Value: TChartGradientDirection);
begin
  if FGradientDirection <> Value then
  begin
    FGradientDirection := Value;
    Changed;
  end;
end;

procedure TChartAnnotation.SetGradientSteps(const Value: Integer);
begin
  if FGradientSteps <> Value then
  begin
    FGradientSteps := Value;
    Changed;
  end;
end;

procedure TChartAnnotation.SetHeight(const Value: integer);
begin
  if FHeight <> Value then
  begin
    FHeight := Value;
    Changed;
  end;
end;

procedure TChartAnnotation.SetLineColor(const Value: TColor);
begin
  if FLineColor <> Value then
  begin
    FLineColor := Value;
    Changed;
  end;
end;

procedure TChartAnnotation.SetLineWidth(const Value: integer);
begin
  if FLineWidth <> Value then
  begin
    FLineWidth := Value;
    Changed;
  end;
end;

procedure TChartAnnotation.SetName(const Value: String);
begin
  if FName <> value then
  begin
    FName := Value;
    Changed;
  end;
end;

procedure TChartAnnotation.SetOffSetX(const Value: integer);
begin
  if FOffsetX <> Value then
  begin
    FOffsetX := Value;
    Changed;
  end;
end;

procedure TChartAnnotation.SetOffSetY(const Value: integer);
begin
  if FOffsetY <> Value then
  begin
    FOffsetY := Value;
    Changed;
  end;
end;

procedure TChartAnnotation.SetPointIndex(const Value: integer);
begin
  if FPointIndex <> Value then
  begin
    FPointIndex := Value;
    Changed;
  end;
end;

procedure TChartAnnotation.SetShape(const Value: TAnnotationShape);
begin
  if FShape <> Value then
  begin
    FShape := Value;
    Changed;
  end;
end;

procedure TChartAnnotation.SetText(const Value: String);
begin
  if FText <> Value then
  begin
    FText := Value;
    Changed;
  end;
end;

procedure TChartAnnotation.SetTextHorizontalAlignment(const Value: TAlignment);
begin
  if FTextHorizontalAlignment <> Value then
  begin
    FTextHorizontalAlignment := Value;
    Changed;
  end;
end;

procedure TChartAnnotation.SetTextVerticalAlignment(const Value: TVerticalAlignment);
begin
  if FTextVerticalAlignment <> Value then
  begin
    FTextVerticalAlignment := Value;
    Changed;
  end;
end;

procedure TChartAnnotation.SetVisible(const Value: Boolean);
begin
  if (FVisible <> Value) then
  begin
    FVisible := Value;
    Changed;
  end;
end;

procedure TChartAnnotation.SetWidth(const Value: integer);
begin
  if FWidth <> Value then
  begin
    FWidth := Value;
    Changed;
  end;
end;

procedure TChartAnnotation.SetWordWrap(const Value: Boolean);
begin
  if FWordWrap <> value then
  begin
    FWordWrap := Value;
    Changed;
  end;
end;

{ TChartSeriePie }

procedure TChartSeriePie.Assign(Source: TPersistent);
begin
  if (Source is TChartSeriePie) then
  begin
    Position := (Source as TChartSeriePie).Position;
    Left := (Source as TChartSeriePie).Left;
    Top := (Source as TChartSeriePie).Top;
    Size := (source as TChartSeriePie).Size;
    InnerSize := (Source as TChartSeriePie).InnerSize;
    ValueFont.Assign((Source as TChartSeriePie).ValueFont);
    StartOffsetAngle := (Source as TChartSeriePie).StartOffsetAngle;
    ShowValues := (Source as TChartSeriePie).ShowValues;
    LegendColor := (Source as TChartSeriePie).LegendColor;
    LegendColorTo := (Source as TChartSeriePie).LegendColorTo;
    LegendBorderColor := (Source as TchartSeriePie).LegendBorderColor;
    LegendBorderWidth := (Source as TchartSeriePie).LegendBorderWidth;
    LegendGradientSteps := (Source as TchartSeriePie).LegendGradientSteps;
    LegendGradientDirection := (Source as TchartSeriePie).LegendGradientDirection;
    LegendOffsetLeft := (Source as TchartSeriePie).LegendOffsetLeft;
    LegendOffsetTop := (Source as TchartSeriePie).LegendOffsetTop;
    LegendVisible := (Source as TChartSeriePie).LegendVisible;
    LegendFont.assign((Source as TChartSeriePie).LegendFont);
    LegendTitleVisible := (Source as TChartSeriePie).LegendTitleVisible;
    LegendTitleColor := (Source as TchartSeriePie).LegendTitleColor;
    LegendTitleColorTo := (Source as TchartSeriePie).LegendTitleColorTo;
    LegendTitleGradientSteps := (Source as TChartSeriePie).LegendTitleGradientSteps;
    LegendTitleGradientDirection := (Source as TChartSeriePie).LegendTitleGradientDirection;
    LegendPosition := (Source as TChartSeriePie).LegendPosition;
    FShowGrid := (Source as TChartSeriePie).ShowGrid;
    FshowGridPieLines := (Source as TChartSeriePie).ShowGridPieLines;
    FValuePosition := (Source as TChartSeriePie).FValuePosition;
    FShowLegendOnSlice := (Source as TChartSeriePie).ShowLegendOnSlice;
    FSizeType := (Source as TChartSeriePie).SizeType;
  end;
end;

procedure TChartSeriePie.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TChartSeriePie.Create(AOwner: TChartSerie);
begin
  FPosition := spCenterCenter;
  FLegendPosition := spCenterRight;
  FOwner := AOwner;
  FSize := 200;
  FSizeType := pstPixels;
  FLeft := 0;
  FTop := 0;
  FInnerSize := 50;
  FStartOffsetAngle := 0;
  FValueFont := TFont.Create;
  FShowValues := false;
  FLegendColor := clWhite;
  FLegendColorTo := clWhite;
  FLegendBorderColor := clBlack;
  FLegendBorderWidth := 1;
  FLegendGradientSteps := 32;
  FLegendGradientDirection := cgdHorizontal;
  FLegendLeft := 0;
  FLegendTop := 0;
  FLegendVisible := true;
  FLegendFont := TFont.Create;
  FLegendFont.OnChange := FontChanged;
  FShowGrid := true;
  FShowGridPieLines := true;
  FValuePosition := vpInsideSlice;
  FShowLegendOnSlice := false;

  FLegendTitleGradientSteps := 32;
  FLegendTitleGradientDirection := cgdHorizontal;
  FLegendTitleColor := clGray;
  FLegendTitleColorTo := clSilver;
  FLegendTitleVisible := False;
end;

destructor TChartSeriePie.Destroy;
begin
  FLegendFont.Free;
  FValueFont.Free;
  inherited;
end;

procedure TChartSeriePie.FontChanged(Sender: TObject);
begin
  Changed;
end;

function TChartSeriePie.GetPieInnerSize: Integer;
var
  r: TRect;
  sz, w, h: Integer;
begin
  Result := 0;
  case SizeType of
    pstPixels: Result := InnerSize;
    pstPercentage:
    begin
      r := FOwner.GetPieRectangle(FOwner.Index, FOwner.Chart.Series.SeriesRectangle);

      w := r.Right - r.Left;
      h := r.Bottom - r.Top;

      if w > h then
        sz := h
      else
        sz := w;

      Result := Round(sz * (InnerSize / 100));
    end;
  end;
end;

function TChartSeriePie.GetPieSize: Integer;
var
  r: TRect;
  sz, w, h: Integer;
begin
  Result := 0;
  case SizeType of
    pstPixels: Result := Size;
    pstPercentage:
    begin
      r := FOwner.GetPieRectangle(FOwner.Index, FOwner.Chart.Series.SeriesRectangle);

      w := r.Right - r.Left;
      h := r.Bottom - r.Top;

      if w > h then
        sz := h
      else
        sz := w;

      Result := Round(sz * (Size / 100));
    end;
  end;
end;

procedure TChartSeriePie.LoadFromFile(ini: TMemIniFile; Section: String);
var
  a: TStringList;
  str: String;
  i: integer;
begin
  Left := ini.ReadInteger(Section, 'Left', Left);
  Top := ini.ReadInteger(Section, 'Top', Top);
  Position := TChartSeriePiePosition(ini.ReadInteger(Section, 'Position', Integer(Position)));
  Size := ini.ReadInteger(Section, 'Size', Size);
  InnerSize := ini.ReadInteger(Section, 'InnerSize', InnerSize);
  ShowValues := ini.ReadBool(Section, 'ShowValues', ShowValues);
  StartOffsetAngle := ini.ReadInteger(Section, 'StartOffsetAngle', StartOffsetAngle);

  ValueFont.Size := ini.ReadInteger(Section, 'ValueFontSize', ValueFont.Size);
  ValueFont.Color := ini.ReadInteger(Section, 'ValueFontColor', ValueFont.Color);
  ValueFont.Name := ini.ReadString(Section, 'ValueFontName', ValueFont.Name);
  str := ini.ReadString(Section, 'ValueFontStyle', '');
  A := TStringList.Create;
  Split(':',str, A);
  for I := 1 to A.Count - 1 do
  begin
    ValueFont.Style := ValueFont.Style + [TFontStyle(strtoint(A[I]))];
  end;
  A.Free;
  LegendVisible := ini.ReadBool(Section, 'LegendVisible', LegendVisible);
  LegendPosition := TChartSeriePiePosition(ini.ReadInteger(Section, 'LegendPosition', Integer(LegendPosition)));
  LegendOffsetLeft := ini.ReadInteger(Section, 'LegendOffsetLeft', LegendOffsetLeft);
  LegendOffsetTop := ini.ReadInteger(Section, 'LegendOffsetTop', LegendOffsetTop);
  LegendFont.Size := ini.ReadInteger(Section, 'LegendFontSize', ValueFont.Size);
  LegendFont.Color := ini.ReadInteger(Section, 'LegendFontColor', ValueFont.Color);
  LegendFont.Name := ini.ReadString(Section, 'LegendFontName', ValueFont.Name);
  str := ini.ReadString(Section, 'LegendFontStyle', '');
  A := TStringList.Create;
  Split(':',str, A);
  for I := 1 to A.Count - 1 do
  begin
    LegendFont.Style := LegendFont.Style + [TFontStyle(strtoint(A[I]))];
  end;
  A.Free;
  LegendColor := ini.ReadInteger(Section, 'LegendColor', LegendColor);
  LegendColorTo := ini.ReadInteger(Section, 'LegendColorTo', LegendColorTo);
  LegendGradientSteps := ini.ReadInteger(Section, 'LegendGradientSteps',LegendGradientSteps);
  LegendGradientdirection := TChartGradientDirection(ini.ReadInteger(Section, 'LegendGradientDirection', Integer(LegendGradientDirection)));
  LegendBorderColor := ini.ReadInteger(Section, 'LegendBorderColor', LegendBorderColor);
  LegendBorderWidth := ini.ReadInteger(Section, 'LegendBorderWidth', LegendBorderWidth);
  LegendTitleVisible := ini.ReadBool(Section, 'LegendTitleVisible', LegendTitleVisible);
  LegendTitleColor := ini.ReadInteger(Section, 'LegendTitleColor', LegendTitleColor);
  LegendTitleColorTo := ini.ReadInteger(Section, 'LegendTitleColorTo', LegendTitleColorTo);
  LegendTitleGradientSteps := ini.ReadInteger(Section, 'LegendTitleGradientSteps',LegendTitleGradientSteps);
  LegendTitleGradientDirection := TChartGradientDirection(ini.ReadInteger(Section, 'LegendTitleGradientDirection', Integer(LegendTitleGradientDirection)));
  ShowGrid := ini.ReadBool(Section, 'ShowGrid', ShowGrid);
  ShowGridPieLines := ini.ReadBool(Section, 'ShowGridPieLines', ShowGridPieLines);
  ShowLegendOnSlice := ini.ReadBool(Section, 'ShowLegendOnSlice', ShowLegendOnSlice);
  ValuePosition := TChartSeriePieValuePosition(ini.ReadInteger(Section, 'ValuePosition', Integer(ValuePosition)));
  SizeType := TChartSeriePieSizeType(ini.ReadInteger(Section, 'SizeType', Integer(SizeType)));
end;

procedure TChartSeriePie.SetLegendColor(const Value: TColor);
begin
  if FLegendColor <> value then
  begin
    FLegendColor := Value;
    Changed;
  end;
end;

procedure TChartSeriePie.SetLegendColorTo(const Value: TColor);
begin
  if FLegendColorTo <> Value then
  begin
    FLegendColorTo := Value;
    Changed;
  end;
end;

procedure TChartSeriePie.SetLegendFont(const Value: TFont);
begin
  if FLegendFont <> value then
  begin
    FLegendFont.Assign(Value);
    FontChanged(Self);
  end;
end;

procedure TChartSeriePie.SetLegendGradientDirection(
  const Value: TChartGradientDirection);
begin
  if FLegendGradientDirection <> value then
  begin
    FLegendGradientDirection := Value;
    Changed;
  end;
end;

procedure TChartSeriePie.SetLegendGradientSteps(const Value: integer);
begin
  if FLegendGradientSteps <> Value then
  begin
    FLegendGradientSteps := Value;
    Changed;
  end;
end;

procedure TChartSeriePie.SaveToFile(ini: TMemIniFile; Section: String);
begin
  ini.WriteInteger(Section, 'Position', Integer(Position));
  ini.WriteInteger(Section, 'Left', Left);
  ini.WriteInteger(Section, 'Top', Top);
  ini.WriteInteger(Section, 'Size', Size);
  ini.WriteInteger(Section, 'InnerSize', InnerSize);
  ini.WriteBool(Section, 'ShowValues', ShowValues);
  ini.WriteInteger(Section, 'StartOffsetAngle', StartOffsetAngle);
  ini.WriteInteger(Section, 'ValueFontSize', ValueFont.Size);
  ini.WriteInteger(Section, 'ValueFontColor', ValueFont.Color);
  ini.WriteString(Section, 'ValueFontName', ValueFont.Name);
  ini.WriteString(Section, 'ValueFontStyle', GetFontStyles(ValueFont.Style));
  ini.WriteBool(Section, 'LegendVisible', LegendVisible);
  ini.WriteInteger(Section, 'LegendLeft', LegendOffsetLeft);
  ini.WriteInteger(Section, 'LegendTop', LegendOffsetTop);
  ini.WriteInteger(Section, 'LegendPosition', Integer(LegendPosition));
  ini.WriteInteger(Section, 'LegendFontSize', LegendFont.Size);
  ini.WriteInteger(Section, 'LegendFontColor', LegendFont.Color);
  ini.WriteString(Section, 'LegendFontName', LegendFont.Name);
  ini.WriteString(Section, 'LegendFontStyle', GetFontStyles(LegendFont.Style));
  ini.WriteInteger(Section, 'LegendColor', LegendColor);
  ini.WriteInteger(Section, 'LegendColorTo', LegendColorTo);
  ini.WriteInteger(Section, 'LegendGradientSteps',LegendGradientSteps);
  ini.WriteInteger(Section, 'LegendGradientDirection', Integer(LegendGradientDirection));
  ini.WriteInteger(Section, 'LegendBorderColor', LegendBorderColor);
  ini.WriteInteger(Section, 'LegendBorderWidth', LegendBorderWidth);
  ini.WriteBool(Section, 'LegendTitleVisible', LegendTitleVisible);
  ini.WriteInteger(Section, 'LegendTitleColor', LegendTitleColor);
  ini.WriteInteger(Section, 'LegendTitleColorTo', LegendTitleColorTo);
  ini.WriteInteger(Section, 'LegendTitleGradientSteps',LegendTitleGradientSteps);
  ini.WriteInteger(Section, 'LegendTitleGradientDirection', Integer(LegendTitleGradientDirection));
  ini.WriteBool(section, 'ShowGrid', ShowGrid);
  ini.WriteBool(Section, 'ShowGridPieLines', ShowGridPieLines);
  ini.WriteInteger(Section, 'ValuePosition', Integer(ValuePosition));
  ini.WriteBool(Section, 'ShowLegendOnSlice', ShowLegendOnSlice);
  ini.WriteInteger(Section, 'SizeType', Integer(SizeType));
end;

procedure TChartSeriePie.SetInnerSize(const Value: integer);
begin
  if FInnerSize <> value then
  begin
    FInnerSize := Value;
    Changed;
  end;
end;

procedure TChartSeriePie.SetLeft(const Value: Integer);
begin
  if FLeft <> Value then
  begin
    FLeft := Value;
    Changed;
  end;
end;

procedure TChartSeriePie.SetLegendBorderColor(const Value: TColor);
begin
  if FLegendBorderColor <> value then
  begin
    FLegendBorderColor := Value;
    Changed;
  end;
end;

procedure TChartSeriePie.SetLegendBorderWidth(const Value: Integer);
begin
  if FLegendBorderWidth <> value then
  begin
    FLegendBorderWidth := Value;
    Changed;
  end;
end;

procedure TChartSeriePie.SetLegendOffSetLeft(const Value: integer);
begin
  if FLegendLeft <> value then
  begin
    FLegendLeft := Value;
    changed;
  end;
end;

procedure TChartSeriePie.SetLegendOffSetTop(const Value: integer);
begin
  if fLegendTop <> value then
  begin
    FLegendTop := Value;
    Changed;
  end;
end;

procedure TChartSeriePie.SetLegendPosition(const Value: TChartSeriePiePosition);
begin
  if FLegendPosition <> value then
  begin
    FLegendPosition := Value;
    Changed;
  end;
end;

procedure TChartSeriePie.SetLegendTitleColor(const Value: TColor);
begin
  if FLegendTitleColor <> Value then
  begin
    FLegendTitleColor := Value;
    Changed;
  end;
end;

procedure TChartSeriePie.SetLegendTitleColorTo(const Value: TColor);
begin
  if FLegendTitleColorTo <> value then
  begin
    FLegendTitleColorTo := Value;
    Changed;
  end;
end;

procedure TChartSeriePie.SetLegendTitleGradientDirection(
  const Value: TChartGradientDirection);
begin
  if FLegendTitleGradientDirection <> value then
  begin
    FLegendTitleGradientDirection := Value;
    Changed;
  end;
end;

procedure TChartSeriePie.SetLegendTitleGradientSteps(const Value: integer);
begin
  if FLegendTitleGradientSteps <> Value then
  begin
    FLegendTitleGradientSteps := Value;
    Changed;
  end;
end;

procedure TChartSeriePie.SetLegendTitleVisible(const Value: Boolean);
begin
  if FLegendTitleVisible <> Value then
  begin
    FLegendTitleVisible := Value;
    Changed;
  end;
end;

procedure TChartSeriePie.SetLegendVisible(const Value: Boolean);
begin
  if FLegendVisible <> value then
  begin
    FLegendVisible := Value;
    Changed;
  end;
end;

procedure TChartSeriePie.SetPieSize(const Value: integer);
begin
  if FSize <> Value then
  begin
    FSize := Value;
    Changed;
  end;
end;

procedure TChartSeriePie.SetPosition(const Value: TChartSeriePiePosition);
begin
  if FPosition <> value then
  begin
    FPosition := Value;
    Changed;
  end;
end;

procedure TChartSeriePie.SetShowGrid(const Value: Boolean);
begin
  if FShowGrid <> value then
  begin
    FShowGrid := Value;
    Changed;
  end;
end;

procedure TChartSeriePie.SetShowGridPieLines(const Value: Boolean);
begin
  if FShowGridPieLines <> value then
  begin
    FShowGridPieLines := Value;
    Changed;
  end;
end;

procedure TChartSeriePie.SetShowLegendOnSlice(const Value: Boolean);
begin
  if FShowLegendOnSlice <> value then
  begin
    FShowLegendOnSlice := Value;
    Changed;
  end;
end;

procedure TChartSeriePie.SetShowValues(const Value: Boolean);
begin
  if FShowValues <> Value then
  begin
    FShowValues := Value;
    Changed;
  end;
end;

procedure TChartSeriePie.SetSizeType(const Value: TChartSeriePieSizeType);
begin
  if FSizeType <> Value then
  begin
    FSizeType := Value;
    Changed;
  end;
end;

procedure TChartSeriePie.SetStartOffsetAngle(const Value: integer);
begin
  if FStartOffsetAngle <> Value then
  begin
    FStartOffsetAngle := Value;
    Changed;
  end;
end;

procedure TChartSeriePie.SetTop(const Value: Integer);
begin
  if FTop <> Value then
  begin
    FTop := Value;
    Changed;
  end;
end;

procedure TChartSeriePie.SetValueFont(const Value: TFont);
begin
  if FValueFont <> Value then
  begin
    FValueFont.Assign(Value);
    Changed;
  end;
end;

procedure TChartSeriePie.SetValuePosition(
  const Value: TChartSeriePieValuePosition);
begin
  if FValuePosition <> value then
  begin
    FValuePosition := Value;
    Changed;
  end;
end;

{ TChartSerieXAxisGroup }

procedure TChartSerieXAxisGroup.Assign(Source: TPersistent);
begin
  if (Source is TChartSerieXAxisGroup) then
  begin
    FLineColor := (Source as TChartSerieXAxisGroup).LineColor;
    FLineType := (Source as TChartSerieXAxisGroup).LineType;
    FStartIndex := (Source as TChartSerieXAxisGroup).StartIndex;
    FEndIndex := (Source as TChartSerieXAxisGroup).EndIndex;
    FVisible := (Source as TChartSerieXAxisGroup).Visible;
    FFont.Assign((Source as TChartSerieXAxisGroup).Font);
    FCaption := (Source as TChartSerieXAxisGroup).Caption;
    FLevel := (Source as TChartSerieXAxisGroup).Level;
    FSpacing := (Source as TChartSerieXAxisGroup).Spacing;
  end;
end;

procedure TChartSerieXAxisGroup.Changed;
begin
  (collection as TChartSerieXAxisGroups).FOwner.Changed;
end;

constructor TChartSerieXAxisGroup.Create(Collection: TCollection);
begin
  inherited;
  FLineType := xgltVertical;
  FLineColor := clBlack;
  FStartIndex := 0;
  FEndIndex := 3;
  FFont := TFont.Create;
  {$IFNDEF DELPHI9_LVL}
  FFont.Name := 'Tahoma';
  {$ENDIF}
  FFont.OnChange := FontChanged;
  FVisible := True;
  FLevel := 0;
  FSpacing := 3;
end;

destructor TChartSerieXAxisGroup.Destroy;
begin
  FFont.Free;
  inherited;
end;

procedure TChartSerieXAxisGroup.FontChanged(Sender: TObject);
begin
  Changed;
end;

procedure TChartSerieXAxisGroup.LoadFromFile(ini: TMemIniFile; Section: String);
var
  A: TStringList;
  I: integer;
  str: String;
begin

  Caption := ini.ReadString(Section, 'Caption', Caption);
  LineType := TChartSerieXAxisGroupLineType(ini.ReadInteger(Section, 'LineType', Integer(LineType)));
  LineColor := ini.ReadInteger(Section, 'LineColor', LineColor);
  StartIndex := ini.ReadInteger(Section, 'StartIndex', StartIndex);
  EndIndex := ini.ReadInteger(Section, 'EndIndex', EndIndex);


  Font.Size := ini.ReadInteger(Section, 'FontSize', Font.Size);
  Font.Color := ini.ReadInteger(Section, 'FontColor', Font.Color);
  Font.Name := ini.ReadString(Section, 'FontName', Font.Name);

  str := ini.ReadString(Section, 'FontStyle', '');
  A := TStringList.Create;
  Split(':',str, A);
  for I := 1 to A.Count - 1 do
  begin
    Font.Style := Font.Style + [TFontStyle(strtoint(A[I]))];
  end;
  A.Free;

  Visible := ini.ReadBool(Section, 'Visible', Visible);
  Level := ini.ReadInteger(Section, 'Level', Level);
  Spacing := ini.ReadInteger(Section, 'Spacing', Spacing);
end;

procedure TChartSerieXAxisGroup.SaveToFile(ini: TMemIniFile; Section: String);
begin
  ini.WriteInteger(Section, 'Level', Level);
  ini.WriteString(Section, 'Caption', Caption);
  ini.WriteInteger(Section, 'LineType', Integer(LineType));
  ini.WriteInteger(Section, 'LineColor', LineColor);
  ini.WriteInteger(Section, 'StartIndex', StartIndex);
  ini.WriteInteger(Section, 'EndIndex', EndIndex);
  ini.WriteInteger(Section, 'FontSize', Font.Size);
  ini.WriteInteger(Section, 'FontColor', Font.Color);
  ini.WriteString(Section, 'FontName', Font.Name);
  ini.WriteString(Section, 'FontStyle', GetFontStyles(Font.Style));
  ini.WriteBool(Section, 'Visible', Visible);
  ini.WriteInteger(Section, 'Spacing', Spacing);
end;

procedure TChartSerieXAxisGroup.SetCaption(const Value: String);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    Changed;
  end;
end;

procedure TChartSerieXAxisGroup.SetEndIndex(const Value: Integer);
begin
  if FEndIndex <> value then
  begin
    FEndIndex := Value;
    Changed;
  end;
end;

procedure TChartSerieXAxisGroup.SetFont(const Value: TFont);
begin
  if FFont <> Value then
  begin
    FFont.Assign(Value);
    Changed;
  end;
end;

procedure TChartSerieXAxisGroup.SetLevel(const Value: Integer);
begin
  if (FLevel <> Value) and (Value >= 0) then
  begin
    FLevel := Value;
    Changed;
  end;
end;

procedure TChartSerieXAxisGroup.SetLineColor(const Value: TColor);
begin
  if FLineColor <> Value then
  begin
    FLineColor := Value;
    Changed;
  end;
end;

procedure TChartSerieXAxisGroup.SetLineType(const Value: TChartSerieXAxisGroupLineType);
begin
  if FLineType <> Value then
  begin
    FLineType := Value;
    Changed;
  end;
end;

procedure TChartSerieXAxisGroup.SetSpacing(const Value: Integer);
begin
  if (FSpacing <> Value) and (Value >= 0) then
  begin
    FSpacing := Value;
    Changed;
  end;
end;

procedure TChartSerieXAxisGroup.SetStartIndex(const Value: Integer);
begin
  if FStartIndex <> Value then
  begin
    FStartIndex := Value;
    Changed;
  end;
end;

procedure TChartSerieXAxisGroup.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

{ TChartSerieXAxisGroups }

function TChartSerieXAxisGroups.Add: TChartSerieXAxisGroup;
begin
  Result := TChartSerieXAxisGroup(inherited Add);
end;

constructor TChartSerieXAxisGroups.Create(AOwner: TChartSerie);
begin
  inherited Create(TChartSerieXAxisGroup);
  FOwner := AOwner;
end;

function TChartSerieXAxisGroups.GetItem(Index: Integer): TChartSerieXAxisGroup;
begin
  Result := TChartSerieXAxisGroup(inherited Items[Index]);
end;

function TChartSerieXAxisGroups.Insert(Index: Integer): TChartSerieXAxisGroup;
begin
  Result := TChartSerieXAxisGroup(inherited Insert(Index));
end;

procedure TChartSerieXAxisGroups.LoadFromFile(ini: TMemIniFile;
  Section: String);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Items[I].LoadFromFile(ini, Section + '.' + inttostr(Items[I].Index));
  end;
end;

procedure TChartSerieXAxisGroups.SaveToFile(ini: TMemIniFile; Section: String);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Items[I].SaveToFile(ini, Section + '.' + inttostr(Items[I].Index));
  end;
end;

procedure TChartSerieXAxisGroups.SetItem(Index: Integer; const Value: TChartSerieXAxisGroup);
begin
  inherited Items[Index] := Value;
end;

end.