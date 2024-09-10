{********************************************************************}
{                                                                    }
{ written by TMS Software                                            }
{            copyright (c) 2016                                      }
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

unit AdvChartToolBarPopup;

{$I TMSDEFS.inc}

interface

uses
  Classes, Controls, AdvChartToolBar, AdvChartPopup,
  AdvChartGraphics, AdvChartGraphicsTypes, AdvCToolBarPopup, Types
  {$IFNDEF LCLLIB}
  ,AdvChartTypes
  {$ENDIF}
  ;

const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 0; // Minor version nr.
  REL_VER = 0; // Release nr.
  BLD_VER = 0; // Build nr.

  // version history
  // v1.0.0.0 : first release

type
  TAdvChartToolBarChartColorPicker = class(TAdvChartToolBarColorPicker)
  protected
    function GetBitmapRect: TRectF; override;
  public
    procedure DrawSelectedColor(AGraphics: TAdvChartGraphics; ARect: TRectF); override;
  end;

  TAdvChartToolBarEx = class(TAdvChartToolBar)
  public
    function AddColorPicker(AIndex: Integer = -1): TAdvChartToolBarColorPicker; override;
  end;

  TAdvChartToolBarPopupOption = (ctpoFill, ctpoStroke, ctpoType, ctpoLineStyle, ctpoLineWidth, ctpoMarker, ctpoMarkerFill, ctpoMarkerSize, ctpoLabels, ctpoSeries, ctpoUpDown);
  TAdvChartToolBarPopupOptions = set of TAdvChartToolBarPopupOption;

const
  AllOptions = [ctpoFill, ctpoStroke, ctpoType, ctpoLineStyle, ctpoLineWidth, ctpoMarker, ctpoMarkerFill, ctpoMarkerSize, ctpoLabels, ctpoSeries, ctpoUpDown];

  {$IFDEF FMXLIB}
  TTMSFFNCChartToolBarPopupColorSelection = $FF1BADF8;
  {$ELSE}
  TTMSFFNCChartToolBarPopupColorSelection = $F8AD1B;
  {$ENDIF}

type
  TAdvChartToolBarPopupSeriesLabelType = (tpsltNone, tpsltNormal, tpsltFloat);

  TAdvChartToolBarPopupSeriesType = (tpstLine, tpstArea, tpstBar, tpstLineBar, tpstHistogram, tpstLineHistogram, tpstCandleStick, tpstLineCandleStick, tpstOHLC, tpstMarkers, tpstStackedBar,
    tpstStackedArea, tpstStackedPercArea, tpstStackedPercBar, tpstError, tpstArrow, tpstScaledArrow, tpstBubble, tpstScaledBubble, tpstPie, tpstHalfPie, tpstDonut, tpstHalfDonut, tpstBand, tpstSpider,
    tpstHalfSpider, tpstVarRadiusPie, tpstVarRadiusHalfPie, tpstVarRadiusDonut, tpstVarRadiusHalfDonut, tpstSizedPie, tpstSizedHalfPie, tpstSizedDonut, tpstSizedHalfDonut, tpstDigitalLine, tpstXYDigitalLine,
    tpstBoxPlot, tpstRenko, tpstXYLine, tpstXYMarkers, tpstGantt, tpstFunnel);

  TAdvChartToolBarPopupSeriesLineStyle = (tpslsNone, tpslsSolid, tpslsDot, tpslsDash, tpslsDashDot, tpslsDashDotDot);

  TAdvChartToolBarPopupSeriesMarkerType = (tpsmNone, tpsmEllipse, tpsmTriangle, tpsmSquare, tpsmDiamond);

  TAdvChartToolBarPopupSeriesFillColorSelectedEvent = procedure(Sender: TObject; AColor: TAdvChartGraphicsColor) of object;
  TAdvChartToolBarPopupSeriesLineColorSelectedEvent = procedure(Sender: TObject; AColor: TAdvChartGraphicsColor) of object;
  TAdvChartToolBarPopupSeriesMarkerFillColorSelectedEvent = procedure(Sender: TObject; AColor: TAdvChartGraphicsColor) of object;
  TAdvChartToolBarPopupSeriesTypeSelectedEvent = procedure(Sender: TObject; AType: TAdvChartToolBarPopupSeriesType) of object;
  TAdvChartToolBarPopupSeriesLineStyleSelectedEvent = procedure(Sender: TObject; AStyle: TAdvChartToolBarPopupSeriesLineStyle) of object;
  TAdvChartToolBarPopupSeriesLineWidthSelectedEvent = procedure(Sender: TObject; AWidth: Integer) of object;
  TAdvChartToolBarPopupSeriesMarkerSizeSelectedEvent = procedure(Sender: TObject; ASize: Integer) of object;
  TAdvChartToolBarPopupSeriesMarkerTypeSelectedEvent = procedure(Sender: TObject; AType: TAdvChartToolBarPopupSeriesMarkerType) of object;
  TAdvChartToolBarPopupSeriesLabelTypeSelectedEvent = procedure(Sender: TObject; AType: TAdvChartToolBarPopupSeriesLabelType) of object;
  TAdvChartToolBarPopupSeriesSelectedEvent = procedure(Sender: TObject; AItemIndex: Integer) of object;

  IAdvChartToolBarPopup = interface
  ['{3A6BD71A-C42E-4724-9E1C-571F6E657437}']
    procedure SeriesFillColorSelected(AColor: TAdvChartGraphicsColor);
    procedure SeriesMarkerFillColorSelected(AColor: TAdvChartGraphicsColor);
    procedure SeriesLineColorSelected(AColor: TAdvChartGraphicsColor);
    procedure SeriesTypeSelected(AType: TAdvChartToolBarPopupSeriesType);
    procedure SeriesLineStyleSelected(AStyle: TAdvChartToolBarPopupSeriesLineStyle);
    procedure SeriesLineWidthSelected(AWidth: Integer);
    procedure SeriesMarkerSizeSelected(ASize: Integer);
    procedure SeriesMarkerTypeSelected(AType: TAdvChartToolBarPopupSeriesMarkerType);
    procedure SeriesLabelTypeSelected(AType: TAdvChartToolBarPopupSeriesLabelType);
    procedure SeriesSelected(AItemIndex: Integer);
    procedure SeriesDown;
    procedure SeriesUp;
  end;

  {$IFNDEF LCLLIB}
  [ComponentPlatformsAttribute(TMSPlatforms)]
  {$ENDIF}
  TAdvChartToolBarPopup = class(TAdvChartCustomToolBarPopup)
  private
    FChartFill: TAdvChartToolBarColorPicker;
    FChartStroke: TAdvChartToolBarColorPicker;
    FChartType: TAdvChartToolBarBitmapPicker;
    FChartLineStyle: TAdvChartToolBarBitmapPicker;
    FChartLineWidth: TAdvChartToolBarItemPicker;
    FChartMarker: TAdvChartToolBarBitmapPicker;
    FChartMarkerFill: TAdvChartToolBarColorPicker;
    FChartMarkerSize: TAdvChartToolBarItemPicker;
    FChartSelector: TAdvChartToolBarItemPicker;
    FChartLabels: TAdvChartToolBarItemPicker;
    FOptions: TAdvChartToolBarPopupOptions;
    FChartUpButton: TAdvChartToolBarButton;
    FChartDownButton: TAdvChartToolBarButton;
    FOnSeriesLabelTypeSelected: TAdvChartToolBarPopupSeriesLabelTypeSelectedEvent;
    FOnSeriesLineWidthSelected: TAdvChartToolBarPopupSeriesLineWidthSelectedEvent;
    FOnSeriesMarkerTypeSelected: TAdvChartToolBarPopupSeriesMarkerTypeSelectedEvent;
    FOnSeriesFillColorSelected: TAdvChartToolBarPopupSeriesFillColorSelectedEvent;
    FOnSeriesLineColorSelected: TAdvChartToolBarPopupSeriesLineColorSelectedEvent;
    FOnSeriesLineStyleSelected: TAdvChartToolBarPopupSeriesLineStyleSelectedEvent;
    FOnSeriesTypeSelected: TAdvChartToolBarPopupSeriesTypeSelectedEvent;
    FOnSeriesSelected: TAdvChartToolBarPopupSeriesSelectedEvent;
    FOnSeriesDownClicked: TNotifyEvent;
    FOnSeriesUpClicked: TNotifyEvent;
    FOnSeriesMarkerSizeSelected: TAdvChartToolBarPopupSeriesMarkerSizeSelectedEvent;
    FOnSeriesMarkerFillColorSelected: TAdvChartToolBarPopupSeriesMarkerFillColorSelectedEvent;
    procedure SetOptions(const Value: TAdvChartToolBarPopupOptions);
    function GetSeriesFillColor: TAdvChartGraphicsColor;
    function GetSeriesLabelType: TAdvChartToolBarPopupSeriesLabelType;
    function GetSeriesLineColor: TAdvChartGraphicsColor;
    function GetSeriesLineStyle: TAdvChartToolBarPopupSeriesLineStyle;
    function GetSeriesLineWidth: Integer;
    function GetSeriesMarkerType: TAdvChartToolBarPopupSeriesMarkerType;
    function GetSeriesType: TAdvChartToolBarPopupSeriesType;
    procedure SetSeriesFillColor(const Value: TAdvChartGraphicsColor);
    procedure SetSeriesLabelType(
      const Value: TAdvChartToolBarPopupSeriesLabelType);
    procedure SetSeriesLineColor(const Value: TAdvChartGraphicsColor);
    procedure SetSeriesLineStyle(
      const Value: TAdvChartToolBarPopupSeriesLineStyle);
    procedure SetSeriesLineWidth(const Value: Integer);
    procedure SetSeriesMarkerType(
      const Value: TAdvChartToolBarPopupSeriesMarkerType);
    procedure SetSeriesType(const Value: TAdvChartToolBarPopupSeriesType);
    function GetSeriesIndex: Integer;
    procedure SetSeriesIndex(const Value: Integer);
    procedure SetSeriesNames(const Value: TStringList);
    function GetSeriesNames: TStringList;
    function GetSeriesMarkerFillColor: TAdvChartGraphicsColor;
    function GetSeriesMarkerSize: Integer;
    procedure SetSeriesMarkerFillColor(const Value: TAdvChartGraphicsColor);
    procedure SetSeriesMarkerSize(const Value: Integer);
  protected
    function GetVersion: String; override;
    function CreateToolBar: TAdvChartToolBar; override;
    procedure UpdateButtons; virtual;
    procedure SeriesMarkerFillColorClicked(Sender: TObject);
    procedure SeriesFillColorClicked(Sender: TObject);
    procedure SeriesLineColorClicked(Sender: TObject);
    procedure SeriesTypeClicked(Sender: TObject);
    procedure SeriesLineStyleClicked(Sender: TObject);
    procedure SeriesLineWidthClicked(Sender: TObject);
    procedure SeriesMarkerSizeClicked(Sender: TObject);
    procedure SeriesMarkerTypeClicked(Sender: TObject);
    procedure SeriesLabelTypeClicked(Sender: TObject);
    procedure SeriesClicked(Sender: TObject);

    procedure SeriesMarkerFillColorSelected(Sender: TObject; AColor: TAdvChartGraphicsColor);
    procedure SeriesFillColorSelected(Sender: TObject; AColor: TAdvChartGraphicsColor);
    procedure SeriesLineColorSelected(Sender: TObject; AColor: TAdvChartGraphicsColor);
    procedure SeriesTypeSelected(Sender: TObject; ABitmap: TAdvChartBitmap);
    procedure SeriesLineStyleSelected(Sender: TObject; ABitmap: TAdvChartBitmap);
    procedure SeriesLineWidthSelected(Sender: TObject; AItemIndex: Integer);
    procedure SeriesMarkerSizeSelected(Sender: TObject; AItemIndex: Integer);
    procedure SeriesMarkerTypeSelected(Sender: TObject; ABitmap: TAdvChartBitmap);
    procedure SeriesLabelTypeSelected(Sender: TObject; AItemIndex: Integer);
    procedure SeriesSelected(Sender: TObject; AItemIndex: Integer);
    procedure SeriesUpClicked(Sender: TObject);
    procedure SeriesDownClicked(Sender: TObject);

    procedure DoSeriesUpClicked; virtual;
    procedure DoSeriesDownClicked; virtual;
    procedure DoSeriesMarkerFillColorSelected(AColor: TAdvChartGraphicsColor); virtual;
    procedure DoSeriesFillColorSelected(AColor: TAdvChartGraphicsColor); virtual;
    procedure DoSeriesLineColorSelected(AColor: TAdvChartGraphicsColor); virtual;
    procedure DoSeriesTypeSelected(AType: TAdvChartToolBarPopupSeriesType); virtual;
    procedure DoSeriesLineStyleSelected(AStyle: TAdvChartToolBarPopupSeriesLineStyle); virtual;
    procedure DoSeriesLineWidthSelected(AWidth: Integer); virtual;
    procedure DoSeriesMarkerSizeSelected(ASize: Integer); virtual;
    procedure DoSeriesMarkerTypeSelected(AType: TAdvChartToolBarPopupSeriesMarkerType); virtual;
    procedure DoSeriesLabelTypeSelected(AType: TAdvChartToolBarPopupSeriesLabelType); virtual;
    procedure DoSeriesSelected(AItemIndex: Integer); virtual;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property AutoAlign;
    property Placement default ppAboveMouseCenter;
    property PlacementRectangle;
    property PlacementControl;
    property Options: TAdvChartToolBarPopupOptions read FOptions write SetOptions default AllOptions;
    property OnSeriesFillColorSelected: TAdvChartToolBarPopupSeriesFillColorSelectedEvent read FOnSeriesFillColorSelected write FOnSeriesFillColorSelected;
    property OnSeriesMarkerFillColorSelected: TAdvChartToolBarPopupSeriesMarkerFillColorSelectedEvent read FOnSeriesMarkerFillColorSelected write FOnSeriesMarkerFillColorSelected;
    property OnSeriesLineColorSelected: TAdvChartToolBarPopupSeriesLineColorSelectedEvent read FOnSeriesLineColorSelected write FOnSeriesLineColorSelected;
    property OnSeriesLineStyleSelected: TAdvChartToolBarPopupSeriesLineStyleSelectedEvent read FOnSeriesLineStyleSelected write FOnSeriesLineStyleSelected;
    property OnSeriesLineWidthSelected: TAdvChartToolBarPopupSeriesLineWidthSelectedEvent read FOnSeriesLineWidthSelected write FOnSeriesLineWidthSelected;
    property OnSeriesMarkerSizeSelected: TAdvChartToolBarPopupSeriesMarkerSizeSelectedEvent read FOnSeriesMarkerSizeSelected write FOnSeriesMarkerSizeSelected;
    property OnSeriesMarkerTypeSelected: TAdvChartToolBarPopupSeriesMarkerTypeSelectedEvent read FOnSeriesMarkerTypeSelected write FOnSeriesMarkerTypeSelected;
    property OnSeriesTypeSelected: TAdvChartToolBarPopupSeriesTypeSelectedEvent read FOnSeriesTypeSelected write FOnSeriesTypeSelected;
    property OnSeriesLabelTypeSelected: TAdvChartToolBarPopupSeriesLabelTypeSelectedEvent read FOnSeriesLabelTypeSelected write FOnSeriesLabelTypeSelected;
    property OnSeriesSelected: TAdvChartToolBarPopupSeriesSelectedEvent read FOnSeriesSelected write FOnSeriesSelected;
    property OnSeriesDownClicked: TNotifyEvent read FOnSeriesDownClicked write FOnSeriesDownClicked;
    property OnSeriesUpClicked: TNotifyEvent read FOnSeriesUpClicked write FOnSeriesUpClicked;
    property SeriesFillColor: TAdvChartGraphicsColor read GetSeriesFillColor write SetSeriesFillColor default gcBlack;
    property SeriesMarkerFillColor: TAdvChartGraphicsColor read GetSeriesMarkerFillColor write SetSeriesMarkerFillColor default gcBlack;
    property SeriesLineColor: TAdvChartGraphicsColor read GetSeriesLineColor write SetSeriesLineColor default gcBlack;
    property SeriesType: TAdvChartToolBarPopupSeriesType read GetSeriesType write SetSeriesType default tpstLine;
    property SeriesLineStyle: TAdvChartToolBarPopupSeriesLineStyle read GetSeriesLineStyle write SetSeriesLineStyle default tpslsSolid;
    property SeriesLineWidth: Integer read GetSeriesLineWidth write SetSeriesLineWidth default 1;
    property SeriesMarkerSize: Integer read GetSeriesMarkerSize write SetSeriesMarkerSize default 1;
    property SeriesMarkerType: TAdvChartToolBarPopupSeriesMarkerType read GetSeriesMarkerType write SetSeriesMarkerType default tpsmNone;
    property SeriesLabelType: TAdvChartToolBarPopupSeriesLabelType read GetSeriesLabelType write SetSeriesLabelType default tpsltNone;
    property SeriesNames: TStringList read GetSeriesNames write SetSeriesNames;
    property SeriesIndex: Integer read GetSeriesIndex write SetSeriesIndex;
    property OnActivate;
    property OnDeactivate;
    property DragGrip;
    property Version;
  end;

implementation

uses
  AdvChartBitmapSelector, AdvChartUtils, SysUtils;

{$R 'AdvChartToolBarPopup.res'}

type
  TAdvChartToolBarOpen = class(TAdvChartToolBar);

{ TAdvChartToolBarPopup }

function TAdvChartToolBarPopup.CreateToolBar: TAdvChartToolBar;
var
  it: TAdvChartBitmapSelectorItem;
  h, w: Integer;
  I: Integer;
begin
  h := 37;
  w := 35;
  Result := TAdvChartToolBarEx.Create(Self);
  Result.Appearance.VerticalSpacing := 2;
  Result.Appearance.HorizontalSpacing := 2;
  FChartFill := Result.AddColorPicker;
  FChartFill.AllowFocus := False;
  FChartFill.Bitmaps.AddBitmapFromResource('TAdvChartToolBarPopupFill', HInstance);
  FChartFill.DropDownPosition := ddpBottom;
  FChartFill.Width := w;
  FChartFill.Height := h;
  FChartFill.ShowHint := True;
  FChartFill.Hint := 'Series Fill Color';
  FChartFill.OnColorSelected := SeriesFillColorSelected;
  FChartFill.OnClick := SeriesFillColorClicked;

  FChartStroke := Result.AddColorPicker;
  FChartStroke.AllowFocus := False;
  FChartStroke.Bitmaps.AddBitmapFromResource('TAdvChartToolBarPopupLine', HInstance);
  FChartStroke.Width := w;
  FChartStroke.Height := h;
  FChartStroke.DropDownPosition := ddpBottom;
  FChartStroke.ShowHint := True;
  FChartStroke.Hint := 'Series Line Color';
  FChartStroke.OnColorSelected := SeriesLineColorSelected;
  FChartStroke.OnClick := SeriesLineColorClicked;

  FChartType := Result.AddBitmapPicker;
  FChartType.BitmapSelector.Columns := 5;
  FChartType.BitmapSelector.Rows := 8;
  FChartType.AllowFocus := False;
  FChartType.Bitmaps.AddBitmapFromResource('TAdvChartToolBar', HInstance);

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartLine', HInstance);
  it.Hint := 'Line';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartArea', HInstance);
  it.Hint := 'Area';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartBar', HInstance);
  it.Hint := 'Bar';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartLineBar', HInstance);
  it.Hint := 'Line Bar';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartHistogram', HInstance);
  it.Hint := 'Histogram';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartLineHistogram', HInstance);
  it.Hint := 'Line Histogram';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartCandleStick', HInstance);
  it.Hint := 'CandleStick';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartLineCandleStick', HInstance);
  it.Hint := 'Line CandleStick';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartOHLC', HInstance);
  it.Hint := 'OHLC';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartMarker', HInstance);
  it.Hint := 'Markers';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartStackedBar', HInstance);
  it.Hint := 'Stacked Bar';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartStackedArea', HInstance);
  it.Hint := 'Stacked Area';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartStackedAreaPerc', HInstance);
  it.Hint := 'Stacked Area (%)';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartStackedBarPerc', HInstance);
  it.Hint := 'Stacked Bar (%)';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartError', HInstance);
  it.Hint := 'Error';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartArrow', HInstance);
  it.Hint := 'Arrow';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartScaledArrow', HInstance);
  it.Hint := 'Scaled Arrow';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartBubble', HInstance);
  it.Hint := 'Bubble';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartScaledBubble', HInstance);
  it.Hint := 'Scaled Bubble';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartPie', HInstance);
  it.Hint := 'Pie';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartHalfPie', HInstance);
  it.Hint := 'Half Pie';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartDonut', HInstance);
  it.Hint := 'Donut';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartHalfDonut', HInstance);
  it.Hint := 'HalfDonut';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartBand', HInstance);
  it.Hint := 'Band';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartSpider', HInstance);
  it.Hint := 'Spider';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartHalfSpider', HInstance);
  it.Hint := 'Half Spider';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartVarRadiusPie', HInstance);
  it.Hint := 'Variable Radius Pie';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartVarRadiusHalfPie', HInstance);
  it.Hint := 'Variable Radius Half Pie';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartVarRadiusDonut', HInstance);
  it.Hint := 'Variable Radius Donut';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartVarRadiusHalfDonut', HInstance);
  it.Hint := 'Variable Radius Half Donut';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartSizedPie', HInstance);
  it.Hint := 'Sized Pie';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartSizedHalfPie', HInstance);
  it.Hint := 'Sized Half Pie';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartSizedDonut', HInstance);
  it.Hint := 'Sized Donut';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartSizedHalfDonut', HInstance);
  it.Hint := 'Sized Half Donut';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartDigitalLine', HInstance);
  it.Hint := 'DigitalLine';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartXYDigitalLine', HInstance);
  it.Hint := 'XY DigitalLine';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartBoxPlot', HInstance);
  it.Hint := 'Boxplot';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartRenko', HInstance);
  it.Hint := 'Renko';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartXYLine', HInstance);
  it.Hint := 'XY Line';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartXYMarker', HInstance);
  it.Hint := 'XY Markers';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartGantt', HInstance);
  it.Hint := 'Gantt';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartType.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupChartFunnel', HInstance);
  it.Hint := 'Funnel';
  it.BitmapSize := it.Bitmap.Width;

  FChartType.SelectedItemIndex := 0;
  FChartType.DropDownWidth := 300;
  FChartType.DropDownHeight := 400;
  FChartType.SelectedItemIndex := 0;
  FChartType.Width := w;
  FChartType.Height := h;
  FChartType.DropDownPosition := ddpBottom;
  FChartType.BitmapSelector.ShowHint := True;
  FChartType.ShowHint := True;
  FChartType.Hint := 'Series Type';
  FChartType.BitmapSelector.Appearance.FillSelected.Color := TTMSFFNCChartToolBarPopupColorSelection;
  FChartType.OnBitmapSelected := SeriesTypeSelected;
  FChartType.OnClick := SeriesTypeClicked;

  FChartLineStyle := Result.AddBitmapPicker;
  FChartLineStyle.AllowFocus := False;
  FChartLineStyle.Width := w;
  FChartLineStyle.Height := h;
  FChartLineStyle.DropDownPosition := ddpBottom;
  FChartLineStyle.ShowHint := True;
  FChartLineStyle.Hint := 'Series Line Style';

  it := FChartLineStyle.Items.Add;
  it.Hint := 'None';
  it.Text := 'None';

  it := FChartLineStyle.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupLineSolid', HInstance);
  it.Hint := 'Solid';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartLineStyle.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupLineDot', HInstance);
  it.Hint := 'Dot';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartLineStyle.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupLineDash', HInstance);
  it.Hint := 'Dash';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartLineStyle.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupLineDashDot', HInstance);
  it.Hint := 'Dash Dot';
  it.BitmapSize := it.Bitmap.Width;

  it := FChartLineStyle.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupLineDashDotDot', HInstance);
  it.Hint := 'Dash Dot Dot';
  it.BitmapSize := it.Bitmap.Width;

  FChartLineStyle.BitmapSelector.Columns := 1;
  FChartLineStyle.BitmapSelector.Rows := FChartLineStyle.Items.Count;
  FChartLineStyle.BitmapSelector.Appearance.FillSelected.Color := TTMSFFNCChartToolBarPopupColorSelection;
  FChartLineStyle.SelectedItemIndex := 1;
  FChartLineStyle.OnBitmapSelected := SeriesLineStyleSelected;
  FChartLineStyle.OnClick := SeriesLineStyleClicked;

  FChartLineWidth := Result.AddItemPicker;
  FChartLineWidth.AllowFocus := False;
  FChartLineWidth.HorizontalTextAlign := gtaCenter;
  FChartLineWidth.StretchText := True;
  FChartLineWidth.Width := w;
  FChartLineWidth.Height := h;
  FChartLineWidth.DropDownPosition := ddpBottom;
  FChartLineWidth.ShowHint := True;
  FChartLineWidth.Hint := 'Series Line Width';
  for I := 1 to 10 do
    FChartLineWidth.Items.Add(IntToStr(I));
  FChartLineWidth.DropDownWidth := FChartLineWidth.Width + 20;
  FChartLineWidth.SelectedItemIndex := 0;
  TAdvChartUtils.SetFontSize(FChartLineWidth.Font, 18);
  FChartLineWidth.OnItemSelected := SeriesLineWidthSelected;
  FChartLineWidth.OnClick := SeriesLineWidthClicked;

  Result.AddSeparator().Height := h;

  FChartMarker := Result.AddBitmapPicker;
  FChartMarker.AllowFocus := False;
  FChartMarker.Width := w;
  FChartMarker.Height := h;
  FChartMarker.DropDownPosition := ddpBottom;
  FChartMarker.ShowHint := True;
  FChartMarker.Hint := 'Series Marker Type';
  FChartMarker.BitmapSelector.Appearance.FillSelected.Color := TTMSFFNCChartToolBarPopupColorSelection;

  it := FChartMarker.Items.Add;
  it.Hint := 'None';
  it.Text := 'None';
  it.HorizontalTextAlign := gtaCenter;

  it := FChartMarker.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupMarkerEllipse', HInstance);
  it.Hint := 'Ellipse';
  it.Text := 'Ellipse';
  it.BitmapSize := it.Bitmap.Width;
  it.BitmapAlign := baLeft;
  it.HorizontalTextAlign := gtaCenter;

  it := FChartMarker.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupMarkerTriangle', HInstance);
  it.Hint := 'Triangle';
  it.Text := 'Triangle';
  it.BitmapSize := it.Bitmap.Width;
  it.BitmapAlign := baLeft;
  it.HorizontalTextAlign := gtaCenter;

  it := FChartMarker.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupMarkerSquare', HInstance);
  it.Hint := 'Square';
  it.Text := 'Square';
  it.BitmapSize := it.Bitmap.Width;
  it.BitmapAlign := baLeft;
  it.HorizontalTextAlign := gtaCenter;

  it := FChartMarker.Items.Add;
  it.Bitmap.LoadFromResource('TAdvChartToolBarPopupMarkerDiamond', HInstance);
  it.Hint := 'Diamond';
  it.Text := 'Diamond';
  it.BitmapSize := it.Bitmap.Width;
  it.BitmapAlign := baLeft;
  it.HorizontalTextAlign := gtaCenter;

  FChartMarker.DropDownWidth := 100;
  FChartMarker.BitmapSelector.Columns := 1;
  FChartMarker.BitmapSelector.Rows := FChartMarker.Items.Count;
  FChartMarker.SelectedItemIndex := 1;
  FChartMarker.OnBitmapSelected := SeriesMarkerTypeSelected;
  FChartMarker.OnClick := SeriesMarkerTypeClicked;

  FChartMarkerFill := Result.AddColorPicker;
  FChartMarkerFill.AllowFocus := False;
  FChartMarkerFill.Bitmaps.AddBitmapFromResource('TAdvChartToolBarPopupMarkerFill', HInstance);
  FChartMarkerFill.DropDownPosition := ddpBottom;
  FChartMarkerFill.Width := w;
  FChartMarkerFill.Height := h;
  FChartMarkerFill.ShowHint := True;
  FChartMarkerFill.Hint := 'Series Marker Color';
  FChartMarkerFill.OnColorSelected := SeriesMarkerFillColorSelected;
  FChartMarkerFill.OnClick := SeriesMarkerFillColorClicked;

  FChartMarkerSize := Result.AddItemPicker;
  FChartMarkerSize.AllowFocus := False;
  FChartMarkerSize.HorizontalTextAlign := gtaCenter;
  FChartMarkerSize.StretchText := True;
  FChartMarkerSize.Width := w;
  FChartMarkerSize.Height := h;
  FChartMarkerSize.DropDownPosition := ddpBottom;
  FChartMarkerSize.ShowHint := True;
  FChartMarkerSize.Hint := 'Series Marker Size';
  for I := 1 to 50 do
    FChartMarkerSize.Items.Add(IntToStr(I));
  FChartMarkerSize.DropDownWidth := FChartMarkerSize.Width + 20;
  FChartMarkerSize.SelectedItemIndex := 0;
  TAdvChartUtils.SetFontSize(FChartMarkerSize.Font, 18);
  FChartMarkerSize.OnItemSelected := SeriesMarkerSizeSelected;
  FChartMarkerSize.OnClick := SeriesMarkerSizeClicked;
  FChartMarkerSize.LastElement := True;

  FChartLabels := Result.AddItemPicker;
  FChartLabels.AllowFocus := False;
  FChartLabels.Width := w + 78;
  FChartLabels.Height := h;
  FChartLabels.HorizontalTextAlign := gtaCenter;
  FChartLabels.Bitmaps.AddBitmapFromResource('TAdvChartToolBarPopupDataLabels', HInstance);
  FChartLabels.DropDownPosition := ddpBottom;
  FChartLabels.ShowHint := True;
  FChartLabels.Hint := 'Series Label Type';
  FChartLabels.Items.Add('None');
  FChartLabels.DropDownWidth := w + 85;
  FChartLabels.DropDownHeight := 100;
  FChartLabels.Items.Add('Normal');
  FChartLabels.Items.Add('Float');
  FChartLabels.SelectedItemIndex := 0;
  FChartLabels.OnItemSelected := SeriesLabelTypeSelected;
  FChartLabels.OnClick := SeriesLabelTypeClicked;

  FChartSelector := Result.AddItemPicker;
  FChartSelector.AllowFocus := False;
  FChartSelector.Width := w + 74;
  FChartSelector.Height := h;
  FChartSelector.HorizontalTextAlign := gtaCenter;
  FChartSelector.DropDownPosition := ddpBottom;
  FChartSelector.ShowHint := True;
  FChartSelector.Hint := 'Series Selector';
  FChartSelector.DropDownWidth := w + 65;
  FChartSelector.DropDownHeight := 100;
  FChartSelector.SelectedItemIndex := 0;
  FChartSelector.OnItemSelected := SeriesSelected;
  FChartSelector.OnClick := SeriesClicked;

  FChartUpButton := Result.AddButton(35, h, 'TAdvChartToolBarPopupUp', 'TAdvChartToolBarPopupUp');
  FChartUpButton.AllowFocus := False;
  FChartUpButton.Hint := 'Move Active Series Up';
  FChartUpButton.OnClick := SeriesUpClicked;
  FChartUpButton.ShowHint := True;

  FChartDownButton := Result.AddButton(35, h, 'TAdvChartToolBarPopupDown', 'TAdvChartToolBarPopupDown');
  FChartDownButton.AllowFocus := False;
  FChartDownButton.Hint := 'Move Active Series Down';
  FChartDownButton.OnClick := SeriesDownClicked;
  FChartDownButton.ShowHint := True;
end;

procedure TAdvChartToolBarPopup.DoSeriesDownClicked;
var
  pif: IAdvChartToolBarPopup;
begin
  if Assigned(PlacementControl) and Supports(PlacementControl, IAdvChartToolBarPopUp, pif) then
    pif.SeriesDown;

  if Assigned(OnSeriesDownClicked) then
    OnSeriesDownClicked(Self);
end;

procedure TAdvChartToolBarPopup.DoSeriesFillColorSelected(
  AColor: TAdvChartGraphicsColor);
var
  pif: IAdvChartToolBarPopup;
begin
  if Assigned(PlacementControl) and Supports(PlacementControl, IAdvChartToolBarPopup, pif) then
    pif.SeriesFillColorSelected(AColor);

  if Assigned(OnSeriesFillColorSelected) then
    OnSeriesFillColorSelected(Self, AColor);
end;

procedure TAdvChartToolBarPopup.DoSeriesLabelTypeSelected(
  AType: TAdvChartToolBarPopupSeriesLabelType);
var
  pif: IAdvChartToolBarPopup;
begin
  if Assigned(PlacementControl) and Supports(PlacementControl, IAdvChartToolBarPopup, pif) then
    pif.SeriesLabelTypeSelected(AType);

  if Assigned(OnSeriesLabelTypeSelected) then
    OnSeriesLabelTypeSelected(Self, AType);
end;

procedure TAdvChartToolBarPopup.DoSeriesLineColorSelected(
  AColor: TAdvChartGraphicsColor);
var
  pif: IAdvChartToolBarPopup;
begin
  if Assigned(PlacementControl) and Supports(PlacementControl, IAdvChartToolBarPopup, pif) then
    pif.SeriesLineColorSelected(AColor);

  if Assigned(OnSeriesLineColorSelected) then
    OnSeriesLineColorSelected(Self, AColor);
end;

procedure TAdvChartToolBarPopup.DoSeriesLineStyleSelected(
  AStyle: TAdvChartToolBarPopupSeriesLineStyle);
var
  pif: IAdvChartToolBarPopup;
begin
  if Assigned(PlacementControl) and Supports(PlacementControl, IAdvChartToolBarPopup, pif) then
    pif.SeriesLineStyleSelected(AStyle);

  if Assigned(OnSeriesLineStyleSelected) then
    OnSeriesLineStyleSelected(Self, AStyle);
end;

procedure TAdvChartToolBarPopup.DoSeriesLineWidthSelected(AWidth: Integer);
var
  pif: IAdvChartToolBarPopup;
begin
  if Assigned(PlacementControl) and Supports(PlacementControl, IAdvChartToolBarPopup, pif) then
    pif.SeriesLineWidthSelected(AWidth);

  if Assigned(OnSeriesLineWidthSelected) then
    OnSeriesLineWidthSelected(Self, AWidth);
end;

procedure TAdvChartToolBarPopup.DoSeriesMarkerFillColorSelected(
  AColor: TAdvChartGraphicsColor);
var
  pif: IAdvChartToolBarPopup;
begin
  if Assigned(PlacementControl) and Supports(PlacementControl, IAdvChartToolBarPopup, pif) then
    pif.SeriesMarkerFillColorSelected(AColor);

  if Assigned(OnSeriesMarkerFillColorSelected) then
    OnSeriesMarkerFillColorSelected(Self, AColor);
end;

procedure TAdvChartToolBarPopup.DoSeriesMarkerSizeSelected(ASize: Integer);
var
  pif: IAdvChartToolBarPopup;
begin
  if Assigned(PlacementControl) and Supports(PlacementControl, IAdvChartToolBarPopup, pif) then
    pif.SeriesMarkerSizeSelected(ASize);

  if Assigned(OnSeriesMarkerSizeSelected) then
    OnSeriesMarkerSizeSelected(Self, ASize);
end;

procedure TAdvChartToolBarPopup.DoSeriesMarkerTypeSelected(
  AType: TAdvChartToolBarPopupSeriesMarkerType);
var
  pif: IAdvChartToolBarPopup;
begin
  if Assigned(PlacementControl) and Supports(PlacementControl, IAdvChartToolBarPopup, pif) then
    pif.SeriesMarkerTypeSelected(AType);

  if Assigned(OnSeriesMarkerTypeSelected) then
    OnSeriesMarkerTypeSelected(Self, AType);
end;

procedure TAdvChartToolBarPopup.DoSeriesSelected(AItemIndex: Integer);
var
  pif: IAdvChartToolBarPopup;
begin
  if Assigned(PlacementControl) and Supports(PlacementControl, IAdvChartToolBarPopup, pif) then
    pif.SeriesSelected(AItemIndex);

  if Assigned(OnSeriesTypeSelected) then
    OnSeriesSelected(Self, AItemIndex);
end;

procedure TAdvChartToolBarPopup.DoSeriesTypeSelected(
  AType: TAdvChartToolBarPopupSeriesType);
var
  pif: IAdvChartToolBarPopup;
begin
  if Assigned(PlacementControl) and Supports(PlacementControl, IAdvChartToolBarPopup, pif) then
    pif.SeriesTypeSelected(AType);

  if Assigned(OnSeriesTypeSelected) then
    OnSeriesTypeSelected(Self, AType);
end;

procedure TAdvChartToolBarPopup.DoSeriesUpClicked;
var
  pif: IAdvChartToolBarPopup;
begin
  if Assigned(PlacementControl) and Supports(PlacementControl, IAdvChartToolBarPopup, pif) then
    pif.SeriesUp;

  if Assigned(OnSeriesUpClicked) then
    OnSeriesUpClicked(Self);
end;

function TAdvChartToolBarPopup.GetSeriesFillColor: TAdvChartGraphicsColor;
begin
  Result := gcBlack;
  if Assigned(FChartFill) then
    Result := FChartFill.SelectedColor;
end;

function TAdvChartToolBarPopup.GetSeriesIndex: Integer;
begin
  Result := -1;
  if Assigned(FChartSelector) then
    Result := FChartSelector.SelectedItemIndex;
end;

function TAdvChartToolBarPopup.GetSeriesLabelType: TAdvChartToolBarPopupSeriesLabelType;
begin
  Result := tpsltNone;
  if Assigned(FChartLabels) then
  begin
    if (FChartLabels.SelectedItemIndex > -1) then
      Result := TAdvChartToolBarPopupSeriesLabelType(FChartLabels.SelectedItemIndex);
  end;
end;

function TAdvChartToolBarPopup.GetSeriesLineColor: TAdvChartGraphicsColor;
begin
  Result := gcBlack;
  if Assigned(FChartStroke) then
    Result := FChartStroke.SelectedColor;
end;

function TAdvChartToolBarPopup.GetSeriesLineStyle: TAdvChartToolBarPopupSeriesLineStyle;
begin
  Result := tpslsSolid;
  if Assigned(FChartLineStyle) then
  begin
    if (FChartLineStyle.SelectedItemIndex > -1) then
      Result := TAdvChartToolBarPopupSeriesLineStyle(FChartLineStyle.SelectedItemIndex);
  end;
end;

function TAdvChartToolBarPopup.GetSeriesLineWidth: Integer;
begin
  Result := 1;
  if Assigned(FChartLineWidth) then
  begin
    if (FChartLineWidth.SelectedItemIndex > -1) then
      Result := StrToInt(FChartLineWidth.Items[FChartLineWidth.SelectedItemIndex]);
  end;
end;

function TAdvChartToolBarPopup.GetSeriesMarkerFillColor: TAdvChartGraphicsColor;
begin
  Result := gcBlack;
  if Assigned(FChartMarkerFill) then
    Result := FChartMarkerFill.SelectedColor;
end;

function TAdvChartToolBarPopup.GetSeriesMarkerSize: Integer;
begin
  Result := 1;
  if Assigned(FChartMarkerSize) then
  begin
    if (FChartMarkerSize.SelectedItemIndex > -1) then
      Result := StrToInt(FChartMarkerSize.Items[FChartMarkerSize.SelectedItemIndex]);
  end;
end;

function TAdvChartToolBarPopup.GetSeriesMarkerType: TAdvChartToolBarPopupSeriesMarkerType;
begin
  Result := tpsmNone;
  if Assigned(FChartMarker) then
  begin
    if (FChartMarker.SelectedItemIndex > -1) then
      Result := TAdvChartToolBarPopupSeriesMarkerType(FChartMarker.SelectedItemIndex);
  end;
end;

function TAdvChartToolBarPopup.GetSeriesNames: TStringList;
begin
  Result := nil;
  if Assigned(FChartSelector) then
    Result := FChartSelector.Items;
end;

function TAdvChartToolBarPopup.GetSeriesType: TAdvChartToolBarPopupSeriesType;
begin
  Result := tpstLine;
  if Assigned(FChartType) then
  begin
    if (FChartType.SelectedItemIndex > -1) then
      Result := TAdvChartToolBarPopupSeriesType(FChartType.SelectedItemIndex);
  end;
end;

function TAdvChartToolBarPopup.GetVersion: String;
begin
  Result := GetVersionNumber(MAJ_VER, MIN_VER, REL_VER, BLD_VER);
end;

procedure TAdvChartToolBarPopup.SeriesClicked(Sender: TObject);
begin
  DoSeriesSelected(FChartSelector.SelectedItemIndex);
end;

procedure TAdvChartToolBarPopup.SeriesDownClicked(Sender: TObject);
begin
  DoSeriesDownClicked;
end;

procedure TAdvChartToolBarPopup.SeriesFillColorClicked(Sender: TObject);
begin
  DoSeriesFillColorSelected(FChartFill.SelectedColor);
end;

procedure TAdvChartToolBarPopup.SeriesFillColorSelected(Sender: TObject;
  AColor: TAdvChartGraphicsColor);
begin
  DoSeriesFillColorSelected(FChartFill.SelectedColor);
end;

procedure TAdvChartToolBarPopup.SeriesLabelTypeClicked(Sender: TObject);
begin
  if (FChartLabels.SelectedItemIndex > -1) then
    DoSeriesLabelTypeSelected(TAdvChartToolBarPopupSeriesLabelType(FChartLabels.SelectedItemIndex));
end;

procedure TAdvChartToolBarPopup.SeriesLabelTypeSelected(Sender: TObject;
  AItemIndex: Integer);
begin
  if (FChartLabels.SelectedItemIndex > -1) then
    DoSeriesLabelTypeSelected(TAdvChartToolBarPopupSeriesLabelType(FChartLabels.SelectedItemIndex));
end;

procedure TAdvChartToolBarPopup.SeriesLineColorClicked(Sender: TObject);
begin
  DoSeriesLineColorSelected(FChartStroke.SelectedColor);
end;

procedure TAdvChartToolBarPopup.SeriesLineColorSelected(Sender: TObject;
  AColor: TAdvChartGraphicsColor);
begin
  DoSeriesLineColorSelected(FChartStroke.SelectedColor);
end;

procedure TAdvChartToolBarPopup.SeriesLineStyleClicked(Sender: TObject);
begin
  if (FChartLineStyle.SelectedItemIndex > -1) then
    DoSeriesLineStyleSelected(TAdvChartToolBarPopupSeriesLineStyle(FChartLineStyle.SelectedItemIndex));
end;

procedure TAdvChartToolBarPopup.SeriesLineStyleSelected(Sender: TObject;
  ABitmap: TAdvChartBitmap);
begin
  if (FChartLineStyle.SelectedItemIndex > -1) then
    DoSeriesLineStyleSelected(TAdvChartToolBarPopupSeriesLineStyle(FChartLineStyle.SelectedItemIndex));
end;

procedure TAdvChartToolBarPopup.SeriesLineWidthClicked(Sender: TObject);
begin
  if (FChartLineWidth.SelectedItemIndex > -1) then
    DoSeriesLineWidthSelected(StrToInt(FChartLineWidth.Items[FChartLineWidth.SelectedItemIndex]));
end;

procedure TAdvChartToolBarPopup.SeriesLineWidthSelected(Sender: TObject;
  AItemIndex: Integer);
begin
  if (FChartLineWidth.SelectedItemIndex > -1) then
    DoSeriesLineWidthSelected(StrToInt(FChartLineWidth.Items[FChartLineWidth.SelectedItemIndex]));
end;

procedure TAdvChartToolBarPopup.SeriesMarkerFillColorClicked(Sender: TObject);
begin
  DoSeriesMarkerFillColorSelected(FChartMarkerFill.SelectedColor);
end;

procedure TAdvChartToolBarPopup.SeriesMarkerFillColorSelected(Sender: TObject;
  AColor: TAdvChartGraphicsColor);
begin
  DoSeriesMarkerFillColorSelected(FChartMarkerFill.SelectedColor);
end;

procedure TAdvChartToolBarPopup.SeriesMarkerSizeClicked(Sender: TObject);
begin
  if (FChartMarkerSize.SelectedItemIndex > -1) then
    DoSeriesMarkerSizeSelected(StrToInt(FChartMarkerSize.Items[FChartMarkerSize.SelectedItemIndex]));
end;

procedure TAdvChartToolBarPopup.SeriesMarkerSizeSelected(Sender: TObject;
  AItemIndex: Integer);
begin
  if (FChartMarkerSize.SelectedItemIndex > -1) then
    DoSeriesMarkerSizeSelected(StrToInt(FChartMarkerSize.Items[FChartMarkerSize.SelectedItemIndex]));
end;

procedure TAdvChartToolBarPopup.SeriesMarkerTypeClicked(Sender: TObject);
begin
  if (FChartMarker.SelectedItemIndex > -1) then
    DoSeriesMarkerTypeSelected(TAdvChartToolBarPopupSeriesMarkerType(FChartMarker.SelectedItemIndex));
end;

procedure TAdvChartToolBarPopup.SeriesMarkerTypeSelected(Sender: TObject;
  ABitmap: TAdvChartBitmap);
begin
  if (FChartMarker.SelectedItemIndex > -1) then
    DoSeriesMarkerTypeSelected(TAdvChartToolBarPopupSeriesMarkerType(FChartMarker.SelectedItemIndex));
end;

procedure TAdvChartToolBarPopup.SeriesSelected(Sender: TObject;
  AItemIndex: Integer);
begin
  if (FChartSelector.SelectedItemIndex > -1) then
    DoSeriesSelected(FChartSelector.SelectedItemIndex);
end;

procedure TAdvChartToolBarPopup.SeriesTypeClicked(Sender: TObject);
begin
  if (FChartType.SelectedItemIndex > -1) then
    DoSeriesTypeSelected(TAdvChartToolBarPopupSeriesType(FChartType.SelectedItemIndex));
end;

procedure TAdvChartToolBarPopup.SeriesTypeSelected(Sender: TObject;
  ABitmap: TAdvChartBitmap);
begin
  if (FChartType.SelectedItemIndex > -1) then
    DoSeriesTypeSelected(TAdvChartToolBarPopupSeriesType(FChartType.SelectedItemIndex));
end;

procedure TAdvChartToolBarPopup.SeriesUpClicked(Sender: TObject);
begin
  DoSeriesUpClicked;
end;

procedure TAdvChartToolBarPopup.SetOptions(
  const Value: TAdvChartToolBarPopupOptions);
begin
  if FOptions <> Value then
  begin
    FOptions := Value;
    UpdateButtons;
  end;
end;

procedure TAdvChartToolBarPopup.SetSeriesFillColor(
  const Value: TAdvChartGraphicsColor);
begin
  if Assigned(FChartFill) then
    FChartFill.SelectedColor := Value;
end;

procedure TAdvChartToolBarPopup.SetSeriesIndex(const Value: Integer);
begin
  if Assigned(FChartSelector) then
    FChartSelector.SelectedItemIndex := Value;
end;

procedure TAdvChartToolBarPopup.SetSeriesLabelType(
  const Value: TAdvChartToolBarPopupSeriesLabelType);
begin
  if Assigned(FChartLabels) then
    FChartLabels.SelectedItemIndex := Integer(Value);
end;

procedure TAdvChartToolBarPopup.SetSeriesLineColor(
  const Value: TAdvChartGraphicsColor);
begin
  if Assigned(FChartStroke) then
    FChartStroke.SelectedColor := Value;
end;

procedure TAdvChartToolBarPopup.SetSeriesLineStyle(
  const Value: TAdvChartToolBarPopupSeriesLineStyle);
begin
  if Assigned(FChartLineStyle) then
    FChartLineStyle.SelectedItemIndex := Integer(Value);
end;

procedure TAdvChartToolBarPopup.SetSeriesLineWidth(const Value: Integer);
begin
  if Assigned(FChartLineWidth) then
    FChartLineWidth.SelectedItemIndex := FChartLineWidth.Items.IndexOf(IntToStr(Value));
end;

procedure TAdvChartToolBarPopup.SetSeriesMarkerFillColor(
  const Value: TAdvChartGraphicsColor);
begin
  if Assigned(FChartMarkerFill) then
    FChartMarkerFill.SelectedColor := Value;
end;

procedure TAdvChartToolBarPopup.SetSeriesMarkerSize(const Value: Integer);
begin
  if Assigned(FChartMarkerSize) then
    FChartMarkerSize.SelectedItemIndex := FChartMarkerSize.Items.IndexOf(IntToStr(Value));
end;

procedure TAdvChartToolBarPopup.SetSeriesMarkerType(
  const Value: TAdvChartToolBarPopupSeriesMarkerType);
begin
  if Assigned(FChartMarker) then
    FChartMarker.SelectedItemIndex := Integer(Value);
end;

procedure TAdvChartToolBarPopup.SetSeriesNames(const Value: TStringList);
begin
  if Assigned(FChartSelector) then
    FChartSelector.Items.Assign(Value);
end;

procedure TAdvChartToolBarPopup.SetSeriesType(
  const Value: TAdvChartToolBarPopupSeriesType);
begin
  if Assigned(FChartType) then
    FChartType.SelectedItemIndex := Integer(Value);
end;

procedure TAdvChartToolBarPopup.UpdateButtons;
begin
  FChartFill.Hidden := not (ctpoFill in Options);
  FChartStroke.Hidden := not (ctpoStroke in Options);
  FChartType.Hidden := not (ctpoType in Options);
  FChartLineStyle.Hidden := not (ctpoLineStyle in Options);
  FChartLineWidth.Hidden := not (ctpoLineWidth in Options);
  FChartMarker.Hidden := not (ctpoMarker in Options);
  FChartLabels.Hidden := not (ctpoLabels in Options);
  FChartSelector.Hidden := not (ctpoSeries in Options);
  FChartUpButton.Hidden := not (ctpoUpDown in Options);
  FChartDownButton.Hidden := not (ctpoUpDown in Options);
  FChartMarkerFill.Hidden := not (ctpoMarkerFill in Options);
  FChartMarkerSize.Hidden := not (ctpoMarkerSize in Options);
end;

constructor TAdvChartToolBarPopup.Create(AOwner: TComponent);
begin
  inherited;
  Placement := ppAboveMouseCenter;
  FOptions := AllOptions;
  TAdvChartToolBarOpen(ToolBar).Appearance.FlatStyle := True;
end;

{ TAdvChartToolBarEx }

function TAdvChartToolBarEx.AddColorPicker(
  AIndex: Integer): TAdvChartToolBarColorPicker;
begin
  BlockUpdate := True;
  Result := TAdvChartToolBarChartColorPicker.Create(Self);
  InsertToolBarControl(Result, AIndex);
  BlockUpdate := False;
  UpdateControls;
end;

{ TAdvChartToolBarChartColorPicker }

procedure TAdvChartToolBarChartColorPicker.DrawSelectedColor(AGraphics: TAdvChartGraphics;
  ARect: TRectF);
var
  R: TRectF;
  c: TAdvChartGraphicsColor;
  ct: TAdvChartToolBarDropDownButton;
begin
  ct := GetDropDownButtonControl;
  if Assigned(ct) then
  begin
    R := RectF(ARect.Left, ARect.Bottom - ct.Height - 12, ARect.Right, ARect.Bottom - ct.Height);
    c := SelectedColor;
    DrawColor(c, r, AGraphics);
  end;
end;

function TAdvChartToolBarChartColorPicker.GetBitmapRect: TRectF;
begin
  Result := GetContentRect;
  Result.Height := Result.Height - 12;
end;

end.
