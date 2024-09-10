{***************************************************************************}
{ TAdvChartView component                                                   }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 2013 - 2020                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : https://www.tmssoftware.com                              }
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of the author.                                      }
{***************************************************************************}

unit AdvChartView;

interface

{$I TMSDEFS.INC}

uses
  Classes,SysUtils, Controls, Graphics, Types, Forms, Windows,
  ExtCtrls, Messages, StdCtrls, Math, Dialogs, IniFiles, Variants, AdvChart
  {$IFDEF DELPHI2006_LVL}
  ,uxTheme
  {$ENDIF}
  {$IFDEF DELPHIXE3_LVL}
  , System.UITypes
  {$ENDIF}
  {$IFDEF DELPHIXE2_LVL}
  , AdvChartToolBarPopup, AdvChartGraphics, AdvChartGraphicsTypes, AdvChartToolBar
  {$ENDIF}
  ;

const
  MAJ_VER = 4; // Major version nr.
  MIN_VER = 2; // Minor version nr.
  REL_VER = 2; // Release nr.
  BLD_VER = 1; // Build nr.
  ZOOMMIN = 0.000000001;
  s_Edit = 'Show sample values';

  //version history
  // v1.5.0.1 : Fixed problem with Drawing 1 point for bar, histogram, candlestick ohlc.
  //          : Fixed removing ctNone from Legend
  //          : Improved repaint handling on mouseleave
  // v1.5.0.2 : Fixed Text Display in Y-Axis.
  // v1.5.0.3 : Fixed Updating AdvGdipchartview after changes are saved in Pane editor.
  //          : Fixed Free Collection object on Cancel gives invalid pointer exception.
  //          : Fixed Infinitive While loop when Major or Minor – unit equals 0.
  // v1.5.0.4 : Fixed PictureChanged repaint event added in AdvChartView / AdvChartViewGdip
  //          : Fixed PaneById for AdvChartViewGDIP
  //          : Improved Taborder for Pane, Serie and Annotation Editors
  //          : Improved independent collection in Editors
  //          : Fixed Zero line correction for stacked chart types
  // v1.5.0.5 : Fixed Access Violation when starting editors with speedbutton
  // v1.6.0.0 : New Donut Chart support for GDI / GDI+ with modes normal and stacked
  //	        : New Band Chart support for GDI / GDI+
  //          : New Annotation Line Shape support
  //          : New AddLineSerie to draw a line with a given start and end point.
  //          : New XYToPaneSerie to find the closest serie matching the X and Y value.
  //          : Improved Pane and Serie access by name
  //          : Improved GDI+ drawing
  // v1.6.1.0 : New Pie position and pie legend position
  //          : Fixed Access Violation when starting serie editor through property pane
  //          : Fixed issue with Rect property in TChartPane for C++
  // v1.6.1.1 : Fixed no autorange when scrolling
  // v1.6.2.0 : Fixed OnXaxisGetValue never called.
  //          : Improved SerieMouseDown and SerieMouseUp new parameter Button: TMouseButton
  //          : Fixed position of Drag Drop Form
  //          : Fixed angle on text left and text right on Y-Axis
  //          : Improved XAxis zooming
  // v1.6.3.0 : Fixed XAxis zooming issue.
  //          : Fixed Editors multi-screen position
  //          : Fixed Pie & Donut legend position
  //          : Fixed Pie & Donut printing
  //          : Improved margin left and right chart overlapping.
  //          : Improved Pie & Donut default slice colors
  // v1.6.3.1 : Fixed Border width on bar chart
  //          : Fixed Gradient draw on bar chart
  // v1.6.4.0 : Improved navigator Scroll steps
  // v1.7.0.0 : New ctHalfPie and ctHalfDonut chart types.
  //          : New select point on chart with Serie.SelectedIndex
  //          : New Exposed event OnSelectSerieIndex
  //          : Improved Chart drawing
  //          : Improved X-Axis custom drawing (new AddSinglePoint overload with parameter XaxisValue)
  //          : Fixed stacked values only for stacked chart types
  //          : Fixed rotated with startangle pie/donut slice values position.
  //          : Fixed issue with AutoRange zerobased
  // v1.7.0.1 : Improved AutoRange EnabledZeroBased and CommonZeroBased with 5% offset on maximum
  // v1.7.1.0 : New : Minor tickmarks
  //          : New : RangeTo and RangeFrom maximum and minimum scroll values
  //          : Fixed : Event OnHorizontalScroll not called
  // v1.7.1.1 : Fixed : issue with SetSinglePoint, SetSingleDateTime and SetMultiPoints
  // v1.7.2.0 : New : function GetChartPointAtCrossHair
  // v1.7.2.1 : Fixed : issue with drawing points when added with SetArraySize
  // v1.7.3.0 : New : function GetPrintScale to use within Custom X-AxisDrawing to calculate correct font size.
  //          : Improved : Chart legend drawing and text positioning
  //          : Improved : Chart title drawing and text positioning
  //          : Fixed : Issue with Mouse-actions when mixing scaling and scrolling
  //          : Fixed : Issue with setting only YAxisShowValues on the Crosshair
  //          : Fixed : Navigator not Auto-scaling YAxis when scrolling left or right
  //          : Fixed : Issue with Annotations autosize text and calculation of background rectangle
  // v2.0.0.0 : New : Pane, Serie and Annotation Editor properties to disable renaming, removing, adding and reordering.
  //          : New : SizedPie, VarRadiusPie and Spider chart
  //          : New : DB-aware chart
  //          : New : ShowInLegend to hide/show series from the legend
  //          : New : Methods AddMovingAverage, AddTrendLine, AddTrendChannel, AddTrendChannelBand, AddBandSerie
  //          : New : Methods MoveSerie and Serie.Move to move series in the collection
  //          : New : 3D Effect with variable 3D offset
  //          : New : GDI+ Zoom control window
  //          : New : Custom Pie Labels with event OnSerieSliceDrawValue
  //          : Fixed : Issue with GDIplus printing
  //          : Fixed : Issue with Pie legend border color
  //          : Fixed : Issue with saving Y-Values angle in Serie Editor
  //          : Fixed : Issue with Serie Events after Editor dialog is shown at runtime
  //          : Fixed : Issue with Serie events after starting Editor
  //          : Fixed : Issue with legend drawing when charttype = ctNone
  //          : Fixed : Issue with drawing one bar
  //          : Fixed : Value not visible when choosing arCommonZeroBased
  //          : Improved : SaveToFile Y-Values font
  //          : Improved : X-Axis values major and minor unit drawing.
  // v2.0.0.1 : Fixed : Issue with ctArea GDI+ 3D drawing
  //          : Fixed : Issue with 1 slice and value 0
  //          : Fixed : Issue with displaying tracker values
  //          : Fixed : Issue with SaveToFile and LoadFromFile Pane.Visible property
  // v2.0.0.2 : Fixed : Issue with missing files DBAdvChartViewReg.pas and DBAdvChartViewGDIPReg.pas
  // v2.1.0.0 : New : function CreateMetaFile
  //          : New : LoadFromCSV and SaveToCSV to load or save chartpoints to a CSV file
  //          : Fixed : Issue with GDI+ Pie colors
  //          : Fixed : Issue with PointInPie division by zero
  //          : Improved : SaveToImage
  // v2.1.0.1 : Fixed : Issue with SelectedMark in GDI+ Pie
  // v2.1.0.2 : Fixed : Issue in GDI+ Editor with saving Autorange of SliderControl
  //          : Improved : Event OnResize exposed
  // v2.1.0.3 : Improved : Annotation Shapes in GDI+
  // v2.1.0.4 : Fixed : Issue with selecting negative bars
  //          : Improved : Hide grid lines with setting color to clNone
  // v2.1.0.5 : Fixed : cleaned up unwanted red line in 3D mode
  // v2.5.0.0 : New : Cylinder / Pyramid shapes for the ctBar, ctStackedBar and ctStackedPercentageBar chart types (property BarShape on Serie level)
  //          : New : Horizontal Charts (property ChartMode on Series level)
  //          : New : Logarithmic YScale (property Logarithmic on Serie level)
  //          : New : Text values on bars
  //          : Improved : Y-Axis values not depending on Chart Margins
  //          : Improved : Apply button added in designer to see updates instantly
  //          : Smaller improvements and fixes
  // v2.5.0.1 : Improved : Marker Picture drawing
  //          : Fixed : Issue with selecting Markers
  //          : Fixed : Issue with TChartSeriePoint record defined twice
  // v2.5.1.0 : New : Added OnDrawChart event to draw on top of chart
  //  	      : Fixed : Issue with Database support on frames
  // v2.5.1.1 : Fixed : Issue in designtime on systems older than Windows XP
  // v2.5.1.2 : Fixed : Issue with AddTrendLine endx
  //          : Fixed : Issue with Selected marker color and line color
  // v2.5.1.3 : Fixed : Small issue with refreshing points
  //          : Fixed : Issue with divided by zero when using DateTime X-Axis UnitType
  // v2.6.0.0 : New : introducing Digital Line type (ctDigitalLine)
  // v2.6.0.1 : Improved : Faster loading of saved chart settings
  // v2.7.0.0 : New : introducing property Marker.IncreaseDecreaseMode type to use Increase and Decrease colors on markers
  //          : New : Visible property On Serie level to easily show hide series
  //          : New : Boxplot chart type
  //          : New : AddParetoLine method to add a new Pareto type bar and line combination
  //          : New : 3D visualization of the YAxis and XAxis
  //          : New : Renko chart type
  // v2.7.0.1 : Fixed : Issue with color range in AdvChartTypeSelector
  // v2.7.1.0 : New : Property AutoUnits on the X-Axis for switching
  //            off automatic calculation of best possible position
  // v2.8.0.0 : New : XYLine and XYMarker chart type
  //          : New : AddSingleXYPoint, AddDoubleXYPoint overload to add custom X values for XY chart types
  //          : New : Display new X values on XAxis (Serie.Xaxis.XYValues)
  // v2.8.0.1 : Improved : Logarithmic Power function limited for invalid floating point operation
  // v2.8.1.0 : New : procedure RemovePoint, property MaximumPoints to remove and set maximum points,
  //          : the first point is delete when the next point is added over the limit.
  //          : Fixed : Issue with displaying values
  // v2.8.1.1 : Fixed : Issue with displaying stacked values if total = 0
  //          : Fixed : Issue at runtime with editors spin edit empty text values
  // v2.8.1.2 : Fixed : Issue in Cylinder shape drawing with zero values
  //          : Fixed : Issue with DrawPoints range error
  // v2.8.1.3 : Fixed : Drawing fixes in Cylinder type
  // v2.8.1.4 : Fixed : Issue with comparevalue
  //          : Improved AutoUnits in X-Grid
  // v2.8.1.5 : Fixed : Issue with XY values on GetChartPointAtSerie
  // v2.8.1.6 : Improved : Added UseFullRange property to recalculate full range of points
  // v2.9.0.0 : New : Optional Automatically create panes when loading settings from file (breaking change: re-save old chart settings files)
  //          : Fixed : Issue with SaveToFile
  //          : Fixed : Issue with Loading Crosshair Positions from ini file
  // v2.9.1.0 : New : Delphi and C++Builder XE support
  // v2.9.5.0 : DB Intraweb support
  //          : Fixed : Issue with loadfromcsv and savetocsv
  // v2.9.5.1 : Fixed : Issue with unused properties text on X-Axis
  // v3.0.0.0 : New : function XYToChartPoint
  //          : New : X-Axis Groups with different line types
  //          : New : Grouped Stacked Bars
  //          : New : Click events on X-Axis, Y-Axis, Legend and Serie points
  //          : New : RangePercentMargin to automatically calculate extra margin to the Maximum of the serie Y-Values.
  //          : Improved : undefined points for line types
  //          : Fixed : Issue with pie slices zero values
  //          : Fixed : Boxplot gradient colors
  // v3.0.5.0 : New : Added ValueFormatType property to switch between Format function and FormatFloat function.
  //          : New : Legend alignment property added
  //          : Improved : Exposed basic control properties
  //          : Improved : Pie legend drawing
  //          : Fixed : Issue with selecting markers in XY chart types
  //          : Fixed : Issue with mousemove access violation in empty chart
  //          : Fixed : Issue with multiple pane crosshairs
  //          : Fixed : Issue with text angle left and right y-axis
  //          : Fixed : Issue with autosizing and text left and right y-Axis
  //          : Smaller fixes and improvements
  // v3.0.6.0 : New : Gantt chart type
  //          : New : EnableInteraction property to enable/disable interaction on mousemove (legend, x and y-axis, and data points interaction)
  //          : Improved : digital line drawing
  //          : Improved : multi Pane interaction
  //          : Improved : Redesign of X-Axis datetime
  //          : Improved : SetAutoYAxisSize to automatically set Y-Axis maximum size for all panes
  //          : Improved : Reduce XY function to only one function : XYToSeriePoint on ChartView level and
  //          XYToSeriePoint on Pane level
  //          : Fixed : Issue with legend drawing Pie
  //          : Fixed : Issue with clicking line type charts and bar charts
  // v3.0.6.1 : Fixed : Issue with datetime conversion in gantt chart
  // v3.0.6.2 : Fixed : Issue with xyline type in combination with datetime values
  // v3.0.7.0 : New : DrawFromStartDate to switch between Range StartDate and added values through SingleDateTime.
  // v3.0.7.1 : Fixed : Issue with DrawSelectedSlice and SelectedMark property
  //          : Fixed : Issue with empty Area charts
  // v3.0.7.2 : Fixed : Issue with Left and Right size Y-Axis
  //          : Fixed : Issue with undefined points on XYLine chart
  // v3.0.7.3 : Fixed : Issue with Explicit properties in editors
  // v3.0.7.4 : Fixed : Issue with text position on pie with startingangle > 0
  // v3.0.7.5 : Fixed : Issue with selecting serie index on XY charts
  // v3.0.7.6 : Fixed : Issue with YAxis values displaying in zoomcontrol
  //          : Fixed : Issue in ctDigitalLine with line shifting
  // v3.0.7.7 : New: XE2 support
  // v3.0.7.8 : Fixed : Issue with XY chart types and scrolling
  // v3.0.8.0 : New : Tag property on Pane, Serie and TChartPoint level
  //          : Fixed : Issue with XY chart types and hints
  //          : Fixed : Issue with selecting panes
  // v3.0.8.1 : Fixed : Issue with deleting panes at runtime
  // v3.0.8.2 : Fixed : Issue with point index / crosshairs
  // v3.0.8.3 : Fixed : Issue with focused pane index
  // v3.0.8.4 : Fixed : Remaining issue with Point index on same X-Values on XY chart types
  // v3.0.8.5 : Fixed : Issue with Crosshairs with invisible series
  // v3.0.8.6 : Fixed : Issue with values not showing in XY chart mode.
  // v3.0.9.0 : New : XScaleOffset boolean property to enable or disable charts that start without offset
  // v3.0.9.1 : Fixed : Initialize random values for designtime preview
  // v3.0.9.2 : Fixed : Issue with drawing vertical values in bars
  // v3.0.10.0 : New : Support for IntraWeb 12.0 and 12.1
  // v3.0.10.1 : Fixed : Issue with packages in Registered distribution
  // v3.0.10.2 : Improved : Help files for XE2
  // v3.0.11.0 : Fixed : Issue with packages and demos in IntraWeb 12.0 and 12.1
  // v3.0.11.1 : Fixed : Issue with pane editor persistence of X-Axis UnitType
  // v3.0.11.2 : Fixed : Access violation when double-clicking chart in XE2
  // v3.1.0.0 : New : XE3 support
  // v3.1.0.1 : Improved : OnGetCountChartType / OnGetCountGroupedChartType to draw multiple series on the same position
  //          : Fixed : Issue in Intraweb charts
  // v3.1.0.2 : Fixed : Issue with editors delete key
  // v3.1.1.0 : New : OnBeforeDrawSeries / OnAfterDrawSeries events
  // v3.1.2.0 : New : CtrlZooming property on pane level to zoom with a draggable area and the CTRL Key.
  //          : New : OnGetCrossHairValue event to customize crosshair values
  //          : Fixed : Issue with X-Grid line position
  //          : Fixed : Issue with crosshair line drawing
  // v3.1.2.1 : Fixed : Issue with title and 3D enabled charts
  //          : Improved : title position vertical with VerticalAlignment property
  // v3.1.2.2 : Fixed : Issue with OnLegendClick
  // v3.1.3.3 : New : Display values outside spider chart
  // v3.1.3.4 : Fixed : Issue displaying crosshairs in combination with zoomcontrol
  // v3.2.0.0 : New : Funnel Chart type
  // v3.2.0.1 : Fixed : Issue with ZoomControl.Assign()
  //          : Fixed : Issue with Selecting point in XY charts
  // v3.2.0.2 : Fixed : Issue with charttype xyline and undefined points
  // v3.2.0.3 : Fixed : Issues with handling one point pie chart click / selection detection
  // v3.2.0.4 : Fixed : Issue with pie slice detection
  // v3.2.0.5 : Fixed : Issue with demo due to recent changes
  // v3.2.0.6 : Fixed : Issue with pie slice drawing with small values
  // v3.2.0.7 : Fixed : Issue with rounding pie slice values
  // v3.2.0.8 : Improved : Undefined area chart points
  // v3.2.0.9 : Improved : Moving average calculation
  // v3.2.1.0 : Fixed : Issue with rects initialization in X-Axis calculation
  // v3.2.1.1 : Fixed : Issue with out of range exception when drawing annotations
  // v3.2.1.2 : Improved : Gantt annotation drawing
  //          : Fixed : Issue with small pie values and single point pie charts
  // v3.2.1.3 : Fixed : Issue with horizontal / vertical drawn lines not visible
  // v3.2.1.4 : Fixed : Issue with assignment of events
  // v3.2.1.5 : Fixed : Issue with C++ linker on CreateMetaFile (use CreateMeta instead)
  // v3.2.1.6 : Fixed : Issue with placement of crosshair values
  // v3.2.2.0 : New : Modified to allow to add child controls
  // v3.2.2.1 : Improved : X-axis label generation in chart from a TAdvStringGrid via TAdvChartLink
  // v3.2.2.2 : Fixed : Issue with canvas region not applied when drawing
  // v3.2.2.3 : Fixed : Issue with updating values in tracker for XY type charts
  // v3.2.2.4 : Fixed : Issue with control over values shown in tracker
  //          : Fixed : Issue with x-axis values not drawn under certain circumstances
  //          : Fixed : Issue with values returned from CTRL zooming region not valid
  //          : Fixed : Issue with mouse interaction on series that are not visible
  // v3.2.2.5 : New : ctXYDigitalLine chart type
  // v3.2.2.6 : Improved : Multiline text drawing in title bar when align = taAlignTop
  // v3.2.2.7 : Fixed : Issue with zooming in and small values out of range now limited with ZOOMMIN constant
  // v3.2.2.8 : Fixed : Issue with tickmark calculation on x-axis
  // v3.3.0.0 : New : virtual mode
  //          : Fixed : Range check error
  //          : Fixed : Issue with crosshair value drawing
  // v3.3.0.1 : Fixed : Issue with xy conversion persistence
  // v3.3.1.0 : New : ZoomingTouchMode to allow zooming an area without the CTRL key
  //          : Fixed : Issue with drawing of markers and values in horizontal mode
  // v3.3.1.1 : Improved: Fall back to disabled minimum and maximum when serie displays equal values
  //          : Fixed : Issue with tickmarks still drawing with defaultdraw := false in OnYAxisDrawValue event
  // v3.3.1.2 : Fixed : Issue with X-Axis value added through AddSingleXYPoint not drawn at the correct position.
  // v3.3.1.3 : Fixed : Division by zero when drawing gradients
  // v3.3.1.4 : Various fixes and improvements in editors and drawing
  // v3.3.1.5 : Fixed : Issues in handling ctrl zooming
  // v3.4.0.0 : New: Popup toolbar to configure series visuals
  // v3.4.0.1 : Improved: X-Axis and Y-Axis Auto-size by default and are not visible when setting the ChartType to a pie chart variant.
  //          : Fixed: Issue with "Show Sample Values" option not being persisted.
  // v3.4.0.2 : Fixed: Issue with detecting negative bars
  // v4.2.1.0 : New : RAD Studio 10.2 Tokyo Support
  // v4.2.1.1 : Fixed : Issue with bar text drawing in GDI+ version of chart
  // v4.2.1.2 : Improved : Anti-aliased drawing of text in 3D version of chart
  // v4.2.1.3 : Fixed : Issue with undefined timestamp for time-based X-axis
  // v4.2.1.4 : Fixed : Issue with retrieving color for specific point when using ctBar chart type
  // v4.2.1.5 : Fixed : Issue with saving YValuesOffsetX and YValuesOffsetY
  // v4.2.1.6 : Fixed : Issue with selectedmark not showing in combination with X/Y charts.
  // v4.2.1.7 : Fixed : Removed Date in version history
  // v4.2.1.8 : Fixed : Access violation RAD Studio 10.4 with VCL Styles
  // v4.2.1.9 : Fixed : Issue with calculating/initializing chart series performance
  // v4.2.2.0 : Fixed : Regression with initializing series
  //          : Improved : LinePointsOnly property on series level to turn off full line drawing for area charts
  // v4.2.2.1 : Fixed : Issue with calculating inner size of a pie
  //          : Fixed : invalid floating point error when hovering over slices
  // v4.2.2.2 : Fixed : Issue with detection of slices in donut mode

type
  TAdvChartView = class;

  TCrackedWinControl = class(TWinControl)

  end;

  TCrackedChartSerie = class(TChartSerie)

  end;

  TChartTrackerTitle = class(TPersistent)
  private
    FColor: TColor;
    FColorTo: TColor;
    FFont: TFont;
    FGradientDirection: TChartGradientDirection;
    FGradientSteps: integer;
    FOnChange: TNotifyEvent;
    FSize: integer;
    FText: String;
    procedure SetColor(const Value: TColor);
    procedure SetColorTo(const Value: TColor);
    procedure SetFont(const Value: TFont);
    procedure SetGradientDirection(const Value: TChartGradientDirection);
    procedure SetGradientSteps(const Value: Integer);
    procedure SetSize(const Value: integer);
    procedure SetText(const Value: String);
 protected
    procedure Changed; virtual;
  public
    constructor Create(AOwner: TadvchartView);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    //Settings
    procedure SaveToFile(ini: TMemIniFile; Section: String);
    procedure LoadFromFile(ini: TMemIniFile; Section: String);
  published
    property Color: TColor read FColor write SetColor default clNone;
    property ColorTo: TColor read FColorTo write SetColorTo default clNone;
    property Font: TFont read FFont write SetFont;
    property GradientDirection: TChartGradientDirection read FGradientDirection write SetGradientDirection default cgdHorizontal;
    property GradientSteps: Integer read FGradientSteps write SetGradientSteps default 100;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Size: integer read FSize write SetSize default 20;
    property Text: String read FText write SetText;
  end;

  TFormMoveEvent = procedure(Sender: TObject; X,Y: integer) of object;

  TTrackerItem = class(TCollectionItem)
  private
    FColor: TColor;
    FTextColor: TColor;
    FText: TStringList;
    procedure SetText(const Value: TStringList);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    //Settings
    procedure SaveToFile(ini: TMemIniFile; Section: String);
    procedure LoadFromFile(ini: TMemIniFile; Section: String);
  published
    property TextColor: TColor read FTextColor write FTextColor default clNone;
    property Color: TColor read FColor write FColor default clNone;
    property Text: TStringList read FText write SetText;
  end;

  TTrackerItems = class(TCollection)
  private
    function GetItem(Index: Integer): TTrackerItem;
    procedure SetItem(Index: Integer; const Value: TTrackerItem);
  public
    constructor Create;
    function Add: TTrackerItem;
    function Insert(Index: Integer): TTrackerItem;
    property Items[Index: Integer]: TTrackerItem read GetItem write SetItem; default;
  end;

  TTrackerList = class(TCustomControl)
  private
    FTrackerItems: TTrackerItems;
    FTitle: string;
    FTitleFont: TFont;
    FColorTo: TColor;
    FGradientDirection: TChartGradientDirection;
    FSize: TSize;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure SetTitle(const Value: string);
    procedure SetTrackerItems(const Value: TTrackerItems);
    procedure SetTitleFont(const Value: TFont);
    procedure SetColorTo(const Value: TColor);
    procedure SetGradientDirection(const Value: TChartGradientDirection);
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetSize: TSize;
    //Settings
    procedure SaveToFile(ini: TMemIniFile; Section: String);
    procedure LoadFromFile(ini: TMemIniFile; Section: String);
  published
    property Align;
    property Anchors;
    property Constraints;
    property ColorTo: TColor read FColorTo write SetColorTo default clNone;
    property Font;
    property GradientDirection: TChartGradientDirection read FGradientDirection write SetGradientDirection default cgdHorizontal;
    property Items: TTrackerItems read FTrackerItems write SetTrackerItems;
    property Title: string read FTitle write SetTitle;
    property TitleFont: TFont read FTitleFont write SetTitleFont;
    property Visible;
  end;

  TTrackerForm = class(TForm)
  private
    FOnMove: TFormMoveEvent;
    FTrackerList: TTrackerList;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMMove(var Message: TWMMove); message WM_MOVE;
  protected
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
  public
    property TrackerList: TTrackerList read FTrackerList;
  published
    property OnMove: TFormMoveEvent read FOnMove write FOnMove;
  end;

  TChartTracker = class(TPersistent)
  private
    FOwner: TAdvChartView;
    FAlphaBlend: Boolean;
    FAlphaBlendValue: Byte;
    FAutoSize: Boolean;
    FBorderStyle: TFormBorderStyle;
    FColor: TColor;
    FColorTo: TColor;
    FFont: TFont;
    FGradientSteps: integer;
    FGradientDirection : TChartGradientDirection;
    FHeight: integer;
    FLeft: integer;
    FOnChange: TNotifyEvent;
    FTitle: TChartTrackerTitle;
    FTrackerForm: TTrackerForm;
    FTop: integer;
    FVisible: Boolean;
    FWidth: integer;
    FUpdateCount: integer;
    FOpenValuePrefix: string;
    FHighValuePrefix: string;
    FCloseValuePrefix: string;
    FLowValuePrefix: string;
    procedure SetAlphaBlend(const Value: Boolean);
    procedure SetAlphaBlendValue(const Value: Byte);
    procedure SetAutoSize(const Value: Boolean);
    procedure SetBorderStyle(const Value: TFormBorderStyle);
    procedure SetColor(const Value: TColor);
    procedure SetColorTo(const Value: TColor);
    procedure SetFont(const Value: TFont);
    procedure SetGradientDirection(const Value: TChartGradientDirection);
    procedure SetGradientSteps(const Value: integer);
    procedure SetHeight(const Value: integer);
    procedure SetLeft(const Value: integer);
    procedure SetTitle(const Value: TChartTrackerTitle);
    procedure SetTop(const Value: integer);
    procedure SetVisible(const Value: Boolean);
    procedure SetWidth(const Value: integer);
    procedure SetCloseValuePrefix(const Value: string);
    procedure SetHighValuePrefix(const Value: string);
    procedure SetLowValuePrefix(const Value: string);
    procedure SetOpenValuePrefix(const Value: string);
  protected
    procedure Changed; virtual;
    procedure TitleChanged(Sender: TObject);
  public
    constructor Create(AOwner: TadvchartView);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure DoAutoSize;
    procedure SetValues;
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure SetTrackerFormSize(Canvas: TCanvas);
    property TrackerForm: TTrackerForm read FTrackerForm write FTrackerForm;
    //Settings
    procedure SaveToFile(ini: TMemIniFile; Section: String);
    procedure LoadFromFile(ini: TMemIniFile; Section: String);
  published
    property AlphaBlend: Boolean read FAlphaBlend write SetAlphaBlend default false;
    property AlphaBlendValue: Byte read FAlphaBlendValue write SetAlphaBlendValue default 255;
    property AutoSize: Boolean read FAutoSize write SetAutoSize default true;
    property BorderStyle: TFormBorderStyle read FBorderStyle write SetBorderStyle default bsToolWindow;
    property Color: TColor read FColor write SetColor default clNone;
    property ColorTo: TColor read FColorTo write SetColorTo default clNone;
    property Font: TFont read FFont write SetFont;
    property GradientDirection: TChartGradientDirection read FGradientDirection write SetGradientDirection default cgdHorizontal;
    property GradientSteps: integer read FGradientSteps write SetGradientSteps default 100;
    property Height: integer read FHeight write SetHeight default 50;
    property Left: integer read FLeft write SetLeft default 0;
    property Title: TChartTrackerTitle read FTitle write SetTitle;
    property Top: integer read FTop write SetTop default 0;
    property Visible: Boolean read FVisible write SetVisible default false;
    property Width: integer read FWidth write SetWidth default 50;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;

    property OpenValuePrefix: string read FOpenValuePrefix write SetOpenValuePrefix;
    property HighValuePrefix: string read FHighValuePrefix write SetHighValuePrefix;
    property LowValuePrefix: string read FLowValuePrefix write SetLowValuePrefix;
    property CloseValuePrefix: string read FCloseValuePrefix write SetCloseValuePrefix;
  end;

  TChartSplitter = class(TPersistent)
  private
    FChart: TAdvChart;
    FColor: TColor;
    FColorTo: TColor;
    FGradientSteps: integer;
    FGradientDirection: TChartGradientDirection;
    FHeight: integer;
    FLineColor: TColor;
    FLineWidth: Integer;
    FVisible: boolean;
    FOnChange: TNotifyEvent;
    procedure SetColor(const Value: TColor);
    procedure SetColorTo(const Value: TColor);
    procedure SetGradientDirection(const Value: TChartGradientDirection);
    procedure SetGradientSteps(const Value: integer);
    procedure SetHeight(const Value: integer);
    procedure SetLineColor(const Value: TColor);
    procedure SetLineWidth(const Value: integer);
    procedure SetVisible(const Value: boolean);
  protected
    procedure Changed; virtual;
  public
    constructor Create(AOwner: TPersistent);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Draw(Canvas: TCanvas; R: TRect);
    //Settings
    procedure SaveToFile(ini: TMemIniFile; Section: String);
    procedure LoadFromFile(ini: TMemIniFile; Section: String);
  published
    property Color: TColor read FColor write SetColor default clSilver;
    property ColorTo: TColor read FColorTo write SetColorTo default clNone;
    property GradientSteps: integer read FGradientSteps write SetGradientSteps default 100;
    property GradientDirection: TChartGradientDirection read FGradientDirection write SetGradientDirection default cgdHorizontal;
    property Height: integer read FHeight write SetHeight default 3;
    property LineColor: TColor read FLineColor write SetLineColor default clNone;
    property LineWidth: integer read FLineWidth write SetLineWidth default 1;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Visible: boolean read FVisible write SetVisible default false;
  end;

  TPaneHeightType = (htPixels, htPercentage, htAuto);

  TPaneOptionType = (poMoving, poHorzScroll, poVertScroll, poHorzScale, poVertScale);

  TPaneOptions = set of TPaneOptionType;

  TChartPaneCtrlZooming = (czNone, czXAxis, czYAxis, czBoth);

  TChartPane = class(TCollectionItem)
  private
    FChart: TAdvChart;
    //FAllowMoving: boolean;
    FBorderColor: TColor;
    FBorderStyle: TBorderStyle;
    FBorderWidth: integer;
    FDragZoom: boolean;
    FHeight: double;
    FHeightType: TPaneHeightType;
    FLbc: boolean;
    FMouseDownOnNavigator: boolean;
    FName: String;
    FNormalZoom: boolean;
    FOldHeight: double;
    FOnNavigator: boolean;
    FOnChange: TNotifyEvent;
    FPixelsMoved: integer;
    FRbc: boolean;
    FRect: TRect;
    FSeriesRect: TRect;
    FSplitter: TChartSplitter;
    FTimerScroll: TTimer;
    FTimerZoomOut: TTimer;
    FVerticalCrossHairPoints: array of TSeriePoint;
    FVerticalCrossHairX: integer;
    FVerticalCrossHairY: integer;
    FVisible: Boolean;
    FUpdateCount: integer;
    FOptions: TPaneOptions;
    FFocused: boolean;
    FDrawLines: Boolean;
    FTag: Integer;
    FCtrlZooming: TChartPaneCtrlZooming;
    FZoomingTouchMode: Boolean;
    function GetBackground: TChartBackground;
    function GetBands: TChartBands;
    function GetCrossHair: TChartCrossHair;
    function GetLegend: TChartLegend;
    function GetMargin: TChartMargin;
    function GetNavigator: TChartNavigator;
    function GetRange: TChartRange;
    function GetSeries: TChartSeries;
    function GetTitle: TChartTitle;
    function GetXAxis: TChartXAxis;
    function GetXGrid: TChartXGrid;
    function GetYAxis: TChartYAxis;
    function GetYGrid: TChartYGrid;
    procedure SetBackground(const Value: TChartBackground);
    procedure SetBands(const Value: TChartBands);
    procedure SetBorderColor(const Value: TColor);
    procedure SetBorderStyle(const Value: TBorderStyle);
    procedure SetBorderWidth(const Value: integer);
    procedure SetCrossHair(const Value: TChartCrossHair);
    procedure SetHeight(const Value: double);
    procedure SetHeightType(const Value: TPaneHeightType);
    procedure SetLegend(const Value: TChartLegend);
    procedure SetMargin(const Value: TChartMargin);
    procedure SetNavigator(const Value: TChartNavigator);
    procedure SetRange(const Value: TChartRange);
    procedure SetSeries(const Value: TChartSeries);
    procedure SetSplitter(const Value: TChartSplitter);
    procedure SetTitle(const Value: TChartTitle);
    procedure SetVisible(const Value: Boolean);
    procedure SetXAxis(const Value: TChartXAxis);
    procedure SetXGrid(const Value: TChartXGrid);
    procedure SetYAxis(const Value: TChartYAxis);
    procedure SetYGrid(const Value: TChartYGrid);
    function GetChartView: TAdvChartView;
    procedure SetName(const Value: String);
    function GetAxisMode: TChartAxisMode;
    procedure SetAxisMode(const Value: TChartAxisMode);
    procedure SetDrawLines(const Value: Boolean);
    function GetXScaleOffset: Boolean;
    procedure SetXScaleOffset(const Value: Boolean);
  protected
    FDS: TComponent;
    procedure DoDrawGridPieLineValue(Sender: TObject; ASerie: TChartSerie; ACanvas: TCanvas; ALineIndex: Integer; AStartAngle, ASweepAngle: Double; ACenter: TPoint; AX, AY: Integer);
    procedure DoGetGridPieLineValue(Sender: TObject; ASerie: TChartSerie; ALineIndex: Integer; AStartAngle, ASweepAngle: Double; var AGridPieLineValue: String);
    procedure DoBeforeDrawSeries(Sender: TObject; ARect: TRect; ACanvas: TCanvas);
    procedure DoAfterDrawSeries(Sender: TObject; ARect: TRect; ACanvas: TCanvas);
    procedure DoGetCountChartType(Sender: TObject; AChartType: TChartType; var ACount: Integer);
    procedure DoGetCountGroupedChartType(Sender: TObject; AChartType: TChartType; var ACountGrouped: Integer);
    procedure DoSerieXAxisGroup(Sender: TObject; Pane, Serie, GroupIndex: Integer; Canvas: TCanvas; R: TRect; var DrawText: Boolean);
    procedure DoGetNumberOfPoints(Sender: TObject; Serie: Integer; var ANumberOfPoints: Integer);
    procedure DoGetPoint(Sender: TObject; Serie: Integer; AIndex: Integer; var APoint: TChartPoint);
    procedure PaneChanged(Sender: TObject);
    procedure ChartChanged(Sender: TObject);
    procedure SplitterChanged(Sender: TObject);
    procedure TimerScrollChanged(Sender: TObject);
    procedure TimerZoomOutChanged(Sender: TObject);
    function CreateChart: TAdvChart; virtual;
    function SynchNormalZoom(X, ClickX, SynchedPane, CurrentPane: integer): Boolean;
    procedure DoVertScroll(oldy,newy: integer);
    procedure DoVertScale(oldy,newy: integer);
    procedure UpdateRange(newrf, newrt: integer);
    //DB
    function GetDS: TComponent; virtual;
    procedure SetDS(ADS: TComponent); virtual;
    function GetDSNames: TStringList; virtual;
    function IsDB: Boolean; virtual;
    property DS: TComponent read GetDS write SetDS;
    procedure LoadData; virtual;
    procedure DoGetPaneRectangle(Chart: TAdvChart; var PaneRect: TRect);
    property DrawLines: Boolean read FDrawLines write SetDrawLines;
    function GetVisibleSerieIndex: Integer;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure DrawVerticalLines(Canvas: TCanvas; R: TRect);
    procedure DoScrolling(SynchedPane, CurrentPane: integer; synched: boolean);
    procedure DoZoomOut(SynchedPane, CurrentPane: integer; synched: boolean);
    procedure DrawVerticalCrossHair(Canvas: TCanvas; R: TRect; X, Y: integer);
    procedure DrawHorizontalCrossHair(Canvas: TCanvas; R: TRect; X, Y: integer);
    procedure DrawTextBackGround(Canvas: TCanvas; P: TSeriePoint);
    procedure DoZoomIn;
    procedure SetMaxRangeTo(Max: integer);
    function DrawChart(ACanvas: TCanvas; R: TRect; ScaleX, ScaleY: Double; Initialize: Boolean = False): TRect;
    procedure Draw(ACanvas: TCanvas; R: TRect; ScaleX, ScaleY: Double; Initialize: Boolean = False); overload; virtual;
    procedure Draw(ACanvas: TCanvas; R: TRect; Initialize: Boolean = True); overload; virtual;
    function PixelHeight: integer;
    property Chart: TAdvChart read FChart;
    property Focused:boolean read FFocused;
    property ChartView: TAdvChartView read GetChartView;
    procedure BeginUpdate;
    procedure EndUpdate(Canvas: TCanvas; R: Trect);
    procedure InitSample;
    function GetPaneRectangle: TRect;
    function GetChartPointAtCrossHair(SerieIndex: integer): TChartPoint;
    procedure AddParetoLine(serieindex, startx, endx: integer;
      UseCommonYRange: Boolean = true; serielinecolor: TColor = clBlack; serielinewidth: integer = 1);
    procedure AddLineSerie(startx, endx: integer; startvalue, endvalue: Double;
      UseCommonYRange: Boolean = true; serielinecolor: TColor = clBlack; serielinewidth: integer = 1);
    procedure AddBandSerie(startx, endx: integer; startvalue1, startvalue2,
      endvalue1,endvalue2: Double; UseCommonYRange: Boolean = true;
      serielinecolor: TColor = clBlack; serielinewidth: integer =
      1;seriebandcolor: TColor = clGray);
    procedure AddTrendLine(serieindex, startx, endx: integer;
      UseCommonYRange: Boolean = true; serielinecolor: TColor = clBlack;
      serielinewidth: integer = 1);
    procedure AddTrendChannel(serieindex, startx, endx: integer;
      UseCommonYRange: Boolean = true; serielinecolor: TColor = clBlack;
      serielinewidth: integer = 1);
    procedure AddTrendChannelBand(serieindex, startx, endx: integer;
      UseCommonYRange: Boolean = true; serielinecolor: TColor = clBlack;
      serielinewidth: integer = 1; seriebandcolor: TColor = clGray);
    procedure AddMovingAverage(serieindex, startx, endx, window: integer;
      UseCommonYRange: Boolean = true; serielinecolor: TColor = clBlack;
      serielinewidth: integer = 1);

    procedure MoveSerie(SerieIndexFrom: integer; SerieIndexTo: integer);
    //Settings
    procedure SaveToFile(ini: TMemIniFile; Section: String); virtual;
    procedure LoadFromFile(ini: TMemIniFile; Section: String; AutoCreateSeries: Boolean = False); virtual;
    property Rectangle: TRect read FRect;
  published
    property Tag: Integer read FTag write FTag default 0;
    property AxisMode: TChartAxisMode read GetAxisMode write SetAxisMode default amAxisChartWidthHeight;
    property XScaleOffset: Boolean read GetXScaleOffset write SetXScaleOffset default True;
    property Bands: TChartBands read GetBands write SetBands;
    property BackGround: TChartBackground read GetBackground write SetBackground;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property BorderColor: TColor read FBorderColor write SetBorderColor default clNone;
    property BorderWidth: integer read FBorderWidth write SetBorderWidth default 1;
    property CrossHair: TChartCrossHair read GetCrossHair write SetCrossHair;
    property Height: double read FHeight write SetHeight;
    property HeightType: TPaneHeightType read FHeightType write SetHeightType default htPercentage;
    property Legend: TChartLegend read GetLegend write SetLegend;
    property Margin: TChartMargin read GetMargin write SetMargin;
    property Navigator: TChartNavigator read GetNavigator write SetNavigator;
    property Name: String read FName write SetName;
    property Options: TPaneOptions read FOptions write FOptions;
    property Range: TChartRange read GetRange write SetRange;
    property Series: TChartSeries read GetSeries write SetSeries;
    property Splitter: TChartSplitter read FSplitter write SetSplitter;
    property Title: TChartTitle read GetTitle write SetTitle;
    property Visible: Boolean read FVisible write SetVisible default true;
    property XAxis: TChartXAxis read GetXAxis write SetXAxis;
    property XGrid: TChartXGrid read GetXGrid write SetXGrid;
    property YAxis: TChartYAxis read GetYAxis write SetYAxis;
    property YGrid: TChartYGrid read GetYGrid write SetYGrid;
    property CtrlZooming: TChartPaneCtrlZooming read FCtrlZooming write FCtrlZooming default czXAxis;
    property ZoomingTouchMode: Boolean read FZoomingTouchMode write FZoomingTouchMode default False;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TChartPanes = class(TOwnedCollection)
  private
    FOnChange: TNotifyEvent;
    FOwner: TAdvChartView;
    function GetItem(Index: Integer): TChartPane;
    procedure SetItem(Index: Integer; const Value: TChartPane);
  protected
    procedure Changed; virtual;
    procedure Update(Item: TCollectionItem); override;
  public
    function GetItemClass: TCollectionItemClass; virtual;
    constructor Create(AOwner: TAdvChartView);
    destructor Destroy; override;
    function Add:TChartPane;
    property Items[Index: Integer]: TChartPane read GetItem write SetItem; default;
    function Insert(index:integer): TChartPane;
  published
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TChartLegendClick = procedure(Sender: TObject; Pane: Integer; Serie: Integer; LegendText: String) of object;

  TChartPieLegendClick = procedure(Sender: TObject; Pane: Integer; Serie: Integer; PointIndex: Integer) of object;

  TChartSelectSerieIndexEvent = procedure(Sender: TObject; Pane: integer; Serie: integer; PointIndex: integer) of object;

  TChartSerieIndexHintEvent = procedure(Sender: TObject; Pane: integer; Serie: integer; PointIndex: integer; var Hint: String) of object;

  TChartHorzScrollEvent = procedure(Sender: TObject; Pane: integer; Delta, RangeFrom, RangeTo: integer) of object;

  TChartVertScrollEvent = procedure(Sender: TObject; Pane: integer; Delta, Max, Min: Double) of object;

  TChartZoomYAxisEvent = procedure(Sender: TObject; Pane: integer; SerieMin, SerieMax, YScale: Double) of object;

  TChartZoomXAxisEvent = procedure(Sender: TObject; Pane: integer; XScale: Double) of object;

  TChartPaneMovedEvent = procedure(Sender: TObject; FromPosition, ToPosition: integer) of object;

  TChartPaneSizedEvent = procedure(Sender: TObject; CurrentPaneIndex, MovingPaneIndex : integer; var CurrentNewSize, MovingNewSize: integer; var Allow: boolean) of object;

  TChartPaneSelectedEvent = procedure(Sender: TObject; FocusedPaneIndex: integer) of object;

  TChartZoomSelectionEvent = procedure(Sender: TObject; Pane, startx, starty, endx, endy: integer) of object;

  TChartAnnotationMouseEvent = procedure(Sender: TObject; Pane, Serie, Annotation, Point: integer) of object;

  TChartXAxisClickEvent = procedure(Sender: TObject; Pane, Serie, RangeIndex: Integer) of object;

  TChartYAxisClickEvent = procedure(Sender: TObject; Pane, Serie: Integer; ValueStr: String; Value: Double; Mode: TYAxisRangeValueMode) of object;

  TZoomDirection = (zdInit, zdZoomIn, zdZoomOut);

  TChartMouseState = (cmsClick, cmsMouseDown, cmsMouseUp);

  TChartSerieClass = class of TChartSerie;
  TChartPaneClass = class of TChartPane;
  TChartSeriesClass = class of TChartSeries;
  TChartPanesClass = class of TChartPanes;

  TChartDrawEvent = procedure(Sender: TObject; ARect: TRect; ACanvas: TCanvas) of object;

  TChartPaneDrawEvent = procedure(Sender: TObject; ARect: TRect; ACanvas: TCanvas; APaneIndex: Integer) of object;
  TChartGetCrossHairValueEvent = procedure(Sender: TObject; ACrosshairPoint: TSeriePoint; var ACrossHairText: String) of object;

  TChartGetNumberOfPoints = procedure(Sender: TObject; Pane, Serie: Integer; var ANumberOfPoints: Integer) of object;

  TChartGetPoint = procedure(Sender: TObject; Pane, Serie: Integer; AIndex: Integer; var APoint: TChartPoint) of object;

  {$IFDEF DELPHIXE2_LVL}
  TChartPopupActivateMode = (amMouseLeft, amMouseRight, amBoth);

  TChartPopup = class(TPersistent)
  private
    FEnabled: Boolean;
    FOptions: TAdvChartToolBarPopupOptions;
    FActivateMode: TChartPopupActivateMode;
    FDragGrip: Boolean;
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create; virtual;
  published
    property Enabled: Boolean read FEnabled write FEnabled default False;
    property Options: TAdvChartToolBarPopupOptions read FOptions write FOptions default AllOptions;
    property ActivateMode: TChartPopupActivateMode read FActivateMode write FActivateMode default amBoth;
    property DragGrip: Boolean read FDragGrip write FDragGrip default True;
  end;
  {$ENDIF}

  {$IFDEF DELPHIXE2_LVL}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  TAdvChartView = class(TCustomControl, IAdvChartToolBarPopup)
  {$ELSE}
  TAdvChartView = class(TCustomControl)
  {$ENDIF}
  private
    {$IFDEF DELPHIXE2_LVL}
    FPopup: TChartPopup;
    FActiveSerie: TChartSerie;
    FToolBarPopup: TAdvChartToolBarPopup;
    FOnToolBarPopupActivate: TNotifyEvent;
    FOnToolBarPopupDeactivate: TNotifyEvent;
    {$ENDIF}
    FHintSeriePoint: TChartSeriePoint;
    FLastDesignChoice: integer;
    FIsWinXP: Boolean;
    FConstructed: Boolean;
    FCh: boolean;
    FCx: integer;
    FCy: integer;
    FCrpi: integer;
    FCpi: integer;
    FDesignTime: Boolean;
    FDragDelta: integer;
    FDragClickY: integer;
    FDragOldTop: integer;
    FDragAlphaBlendValue: Byte;
    FDragAlphaBlend: Boolean;
    FDragForm: TForm;
    FPanes: TChartPanes;
    FMaximumY, FMinimumY: integer;
    FMpi: integer;
    FMc: boolean;
    FMouseDownOnAxis, FMouseDownOnSerie: boolean;
    FMdx: integer;
    FMdy: integer;
    FOnHorizontalScroll: TChartHorzScrollEvent;
    FOnVerticalScroll: TChartVertScrollEvent;
    FOnLeftScroll: TChartHorzScrollEvent;
    FOnPaneMoved: TChartPaneMovedEvent;
    FOnPaneSized: TChartPaneSizedEvent;
    FOnPaneSelected: TChartPaneSelectedEvent;
    FOnRightScroll: TChartHorzScrollEvent;
    FOnTrackerClose: TCloseQueryEvent;
    FOnTrackerMove: TFormMoveEvent;
    FOnYScaleZoom: TChartZoomYAxisEvent;
    FOnXScaleZoom: TChartZoomXAxisEvent;
    FOnAnnotationMouseDown: TChartAnnotationMouseEvent;
    FOnAnnotationMouseUp: TChartAnnotationMouseEvent;
    FOnAnnotationClick: TChartAnnotationMouseEvent;
    FPanesSynched: boolean;
    FRegionForm: TForm;
//    FPositionLabel: TLabel;
    FRx, FRy: integer;
    FSch: integer;
    FShc: integer;
    FScy: integer;
    FSplitterDelta: integer;
    FSplitterHeight: integer;
    FTracker: TChartTracker;
    FVerticalCrossHairSynched: boolean;
    FXAxisZoomSensitivity: Double;
    FYAxisZoomSensitivity: Double;
    FZoomColor: TColor;
    FZoomForm: TForm;
    FOnZoomSelection: TChartZoomSelectionEvent;
    FZoomStyle: TBrushStyle;
    FVersion: string;
    FFocusedPane: integer;
    FOnSerieMouseDown: TChartSerieMouseEvent;
    FOnSerieMouseUp: TChartSerieMouseEvent;
    FForceCursor: Boolean;
    FOnSelectSerieIndex: TChartSelectSerieIndexEvent;
    FShowDesignHelper: Boolean;
    FDesigntimeValues: Boolean;
    FOnDrawChart: TChartDrawEvent;
    FOnDrawPane: TChartDrawEvent;
    FNonVisual: Boolean;
    FOnLegendClick: TChartLegendClick;
    FOnSerieIndexClick: TChartSelectSerieIndexEvent;
    FOnXAxisClick: TChartXAxisClickEvent;
    FOnYAxisClick: TChartYAxisClickEvent;
    FOnSerieXAxisCustomGroup: TChartSerieXAxisCustomGroupEvent;
    FClickCursor: TCursor;
    FOnPieLegendClick: TChartPieLegendClick;
    FOnSerieIndexHint: TChartSerieIndexHintEvent;
    FEnableInteraction: Boolean;
    FOnGetCountChartType: TChartGetCountChartType;
    FOnGetCountGroupedChartType: TChartGetCountChartType;
    FOnBeforeDrawSeries: TChartPaneDrawEvent;
    FOnAfterDrawSeries: TChartPaneDrawEvent;
    FOnGetCrossHairValue: TChartGetCrossHairValueEvent;
    FOnDrawGridPieLineValue: TChartDrawGridPieLineValue;
    FOnGetGridPieLineValue: TChartGetGridPieLineValue;
    FOnGetNumberOfPoints: TChartGetNumberOfPoints;
    FOnGetPoint: TChartGetPoint;
    procedure SetDragAlphaBlend(const Value: boolean);
    procedure SetDragAlphaBlendValue(const Value: Byte);
    procedure SetPanes(const Value: TChartPanes);
    procedure SetPanesSynched(const Value: Boolean);
    procedure SetTracker(const Value: TChartTracker);
    procedure SetVerticalCrossHairSynched(const Value: boolean);
    procedure SetXAxisZoomSensitivity(const Value: Double);
    procedure SetYAxisZoomSensitivity(const Value: Double);
    procedure SetZoomColor(const Value: TColor);
    procedure SetZoomStyle(const Value: TBrushStyle);
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure CMWantSpecialKey(var Msg: TCMWantSpecialKey); message CM_WANTSPECIALKEY;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    function GetVersion: string;
    function GetFocusedPane: integer;
    procedure Setversion(const Value: string);
    procedure SetForceCursor(const Value: Boolean);
    procedure SetShowDesignHelper(const Value: Boolean);
    {$IFDEF DELPHI2006_LVL}
    procedure CMDesignHitTest(var Msg: TCMDesignHitTest); message CM_DESIGNHITTEST;
    {$ENDIF}
    procedure CMHintShow(Var Msg: TMessage); message CM_HINTSHOW;
    procedure SetEnableInteraction(const Value: Boolean);
    procedure SetDesigntimeValues(const Value: Boolean);
    {$IFDEF DELPHIXE2_LVL}
    procedure SetPopup(const Value: TChartPopup);
    function GetToolBarPopup: TAdvChartToolBarPopup;
    {$ENDIF}
  protected
    {$IFDEF DELPHIXE2_LVL}
    procedure DoToolBarPopupActivate(Sender: TObject);
    procedure DoToolBarPopupDeactivate(Sender: TObject);
    procedure SeriesMarkerFillColorSelected(AColor: TAdvChartGraphicsColor); virtual;
    procedure SeriesMarkerSizeSelected(ASize: Integer); virtual;
    procedure SeriesFillColorSelected(AColor: TAdvChartGraphicsColor); virtual;
    procedure SeriesLineColorSelected(AColor: TAdvChartGraphicsColor); virtual;
    procedure SeriesTypeSelected(AType: TAdvChartToolBarPopupSeriesType); virtual;
    procedure SeriesLineStyleSelected(AStyle: TAdvChartToolBarPopupSeriesLineStyle); virtual;
    procedure SeriesLineWidthSelected(AWidth: Integer); virtual;
    procedure SeriesMarkerTypeSelected(AType: TAdvChartToolBarPopupSeriesMarkerType); virtual;
    procedure SeriesLabelTypeSelected(AType: TAdvChartToolBarPopupSeriesLabelType); virtual;
    procedure SeriesSelected(AItemIndex: Integer); virtual;
    procedure SeriesDown; virtual;
    procedure SeriesUp; virtual;
    {$ENDIF}
    procedure Changed; virtual;
    procedure PP(Pane: Integer; Canvas: TCanvas; R: TRect; Print: Boolean); virtual;
    procedure SetScreenCursor(c: TCursor);
    procedure TrackerChanged(Sender: TObject);
    procedure PanesChanged(Sender: TObject);
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Click; override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
     procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure DoLeftScroll(Sender: TObject; Pane, Delta, RangeFrom, RangeTo: integer); virtual;
    procedure DoRightScroll(Sender: TObject; Pane, Delta, RangeFrom, RangeTo: integer); virtual;
    procedure DoHorizontalScroll(Sender: TObject; Pane, Delta, RangeFrom, RangeTo: integer); virtual;
    procedure DoVerticalScroll(Sender: TObject; Pane: integer; Delta, min, max: Double); virtual;
    procedure DoXScaleZoom(Sender: TObject; Pane: integer; XScale: Double); virtual;
    procedure SerieMouseDown(Sender: TObject; Button: TMouseButton; PaneIndex: integer; SerieIndex: Integer; Index: integer; value: Double; X, Y: integer); virtual;
    procedure SerieMouseUp(Sender: TObject; Button: TMouseButton; PaneIndex: integer; SerieIndex: Integer; Index: integer; value: Double; X, Y: integer); virtual;
    procedure AnnotationMouseDown(Sender: TObject; Pane, Serie, Annotation, Point: integer); virtual;
    procedure AnnotationMouseUp(Sender: TObject; Pane, Serie, Annotation, Point: integer); virtual;
    procedure AnnotationClick(Sender: TObject; Pane, Serie, Annotation, Point: integer); virtual;
    procedure DoYScaleZoom(Sender: TObject; Pane: integer; SerieMin, SerieMax, YScale: Double); virtual;
    procedure ZoomSelection(Sender: TObject; Pane, startx, starty, endx, endy: integer); virtual;
    procedure PaneSelected(Sender: TObject; FocusedPaneIndex: integer);
    procedure PaneMoved(Sender: TObject; FromPosition, ToPosition: integer); virtual;
    procedure PaneSized(Sender: TObject; CurrentPaneIndex, MovingPaneIndex: integer; var CurrentNewSize, MovingNewSize: integer; var Allow: Boolean);
    procedure TrackerClosed(Sender: TObject; var CanClose: Boolean);
    procedure TrackerMoved(Sender: TObject; X,Y: integer);
    function CreatePanes: TChartPanes; virtual;
    function CheckLeftButton(X, Y: integer): Boolean;
    function CheckRightButton(X, Y: integer): Boolean;
    procedure Resize; override;
    procedure LoadData; virtual;
    function ChartPointToString(p: TChartPoint): String;
    function StringToChartPoint(s: String): TChartPoint;
    procedure InitPaneRects; virtual;
    {$IFDEF DELPHI2006_LVL}
    function MouseOverDesignChoice(X, Y: Integer): Integer;
    procedure HandleDesignChoice(X,Y: integer);
    procedure PaintDesigner;
    {$ENDIF}
    {$IFDEF DELPHIXE2_LVL}
    procedure ActiveSeriesToPopup;
    {$ENDIF}
  public
    constructor Create(Aowner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    procedure Assign(Source: TPersistent); override;
    procedure CreateWnd; override;
    procedure DoEnter; override;
    procedure DoExit; override;
    function GetCanvas: TCanvas;
    property NonVisual: Boolean read FNonVisual write FNonVisual;

    function GetPaneClass: TChartPaneClass; virtual;
    function GetPanesClass: TChartPanesClass; virtual;
    function GetSeriesClass: TChartSeriesClass; virtual;
    function GetSerieClass: TChartSerieClass; virtual;

    property EnableInteraction: Boolean read FEnableInteraction write SetEnableInteraction default true;

    procedure SetPanesRange(RangeFrom, RangeTo: integer);
    procedure ClearPaneSeries;
    procedure BeginUpdate;
    procedure EndUpdate; virtual;
    procedure DoGetNumberOfPoints(Sender: TObject; Pane, Serie: Integer; var ANumberOfPoints: Integer);
    procedure DoGetPoint(Sender: TObject; Pane, Serie: Integer; AIndex: Integer; var APoint: TChartPoint);
    procedure PrintAllPanes(Canvas: TCanvas; R: TRect);
    procedure PrintPane(Pane: Integer; Canvas: TCanvas; R: TRect); virtual;
    procedure SaveAllPanesToBitmap(Filename: String; Width, Height: integer);
    procedure SavePaneToBitmap(Pane: Integer; Filename: String; Width, Heigth: integer);
    procedure LoadFromCSV(FileName: String; CreateChart: Boolean = false);
    procedure SaveToCSV(FileName: String);
    function GenerateBitmap(Width, Height: Integer): Graphics.TBitmap; virtual;
    function CreateMetaFile(Width, Height: integer): TMetaFile; overload;
    function CreateMetaFile(Pane: Integer; Width, Height: integer): TMetaFile; overload;
    function CreateMeta(Width, Height: integer): TMetaFile; overload; //c++
    function CreateMeta(Pane: Integer; Width, Height: integer): TMetaFile; overload; //c++
    function GetVersionNr: Integer; virtual;
    function GetVersionString: string; virtual;
    function GetPaneByID(id: integer): TChartPane;
    function GetPaneByName(name: string): TChartPane;
    function GetSerieByName(name: string): TChartSerie;
    function IsYPositionChartPoint(X, Y: integer; MouseDown: Boolean; Button: TMouseButton): Boolean;
    function IsYPosChartAnnotation(MousePos: TPoint; MouseState: TChartMouseState): Boolean;
    function GetPrintScale(Canvas: TCanvas): Double;
    property PaneByID[id: integer]: TChartPane read GetPaneByID;
    property PaneByName[name: string]: TChartPane read GetPaneByName;
    property SerieByName[name: string]: TChartSerie read GetSerieByName;
    property FocusedPane: integer read GetFocusedPane write FFocusedPane;
    procedure InitSample;
    //Settings
    procedure SaveToFile(Filename: String); virtual;
    procedure LoadFromFile(Filename: String; AutoCreatePanes: Boolean = False; AutoCreateSeries: Boolean = False); virtual;
    property ForceCursor: Boolean read FForceCursor write SetForceCursor;
    function XYToSeriePoint(X, Y, Pane: Integer): TChartSeriePoint;
    procedure SetAutoYAxisSize;
    {$IFDEF DELPHIXE2_LVL}
    property ToolBarPopup: TAdvChartToolBarPopup read GetToolBarPopup;
    procedure ShowToolBarPopupAt(X, Y: Integer; ASerie: TChartSerie);
    procedure ShowToolBarPopupAtSeries(ASerie: TChartSerie);
    procedure HideToolBarPopup;

    procedure AddToolBarPopupCustomControl(AControl: TControl; AIndex: Integer = -1); virtual;
    function AddToolBarPopupCustomControlClass(AControlClass: TControlClass; AIndex: Integer = -1): TControl; virtual;
    function AddToolBarPopupButton(AWidth: Single = -1; AHeight: Single = -1; AResource: String = ''; AResourceLarge: String = ''; AText: String = '';
      AIndex: Integer = -1): TAdvChartToolBarButton; overload; virtual;
    function AddToolBarPopupSeparator(AIndex: Integer = -1): TAdvChartToolBarSeparator; virtual;
    function AddToolBarPopupFontNamePicker(AIndex: Integer = -1): TAdvChartToolBarFontNamePicker; virtual;
    function AddToolBarPopupFontSizePicker(AIndex: Integer = -1): TAdvChartToolBarFontSizePicker; virtual;
    function AddToolBarPopupColorPicker(AIndex: Integer = -1): TAdvChartToolBarColorPicker; virtual;
    function AddToolBarPopupItemPicker(AIndex: Integer = -1): TAdvChartToolBarItemPicker; virtual;
    function AddToolBarPopupBitmapPicker(AIndex: Integer = -1): TAdvChartToolBarBitmapPicker; virtual;
    {$ENDIF}
  published
    property ShowDesignHelper: Boolean read FShowDesignHelper write SetShowdesignHelper default True;
    property DesigntimeValues: Boolean read FDesigntimeValues write SetDesigntimeValues default True;
    {$IFDEF DELPHIXE2_LVL}
    property Popup: TChartPopup read FPopup write SetPopup;
    {$ENDIF}
    property Align;
    property Anchors;
    property Color;
    property Constraints;
    property DragAlphaBlend: boolean read FDragAlphaBlend write SetDragAlphaBlend default false;
    property DragAlphaBlendValue: Byte read FDragAlphaBlendValue write SetDragAlphaBlendValue default 255;
    property Hint;
    property Panes: TChartPanes read FPanes write SetPanes;
    property PanesSynched: Boolean read FPanesSynched write SetPanesSynched default false;
    property PopupMenu;
    property ShowHint;
    property TabOrder default 0;
    property TabStop;
    property Tracker: TChartTracker read FTracker write SetTracker;
    property VerticalCrossHairsSynched: boolean read FVerticalCrossHairSynched write SetVerticalCrossHairSynched default false;
    property Version: string read GetVersion write Setversion;
    property Visible;
    property XAxisZoomSensitivity: Double read FXAxisZoomSensitivity write SetXAxisZoomSensitivity;
    property YAxisZoomSensitivity: Double read FYAxisZoomSensitivity write SetYAxisZoomSensitivity;
    property ZoomColor: TColor read FZoomColor write SetZoomColor default clNone;
    property ZoomStyle: TBrushStyle read FZoomStyle write SetZoomStyle default bsSolid;
    property OnKeyDown;
    property OnKeyUp;
    property OnKeyPress;
    property OnMouseMove;
    property OnMouseDown;
    property OnMouseUp;
    property OnResize;
    {$IFDEF DELPHI2006_LVL}
    property OnMouseEnter;
    property OnMouseLeave;
    {$ENDIF}
    property OnDrawGridPieLineValue: TChartDrawGridPieLineValue read FOnDrawGridPieLineValue write FOnDrawGridPieLineValue;
    property OnGetGridPieLineValue: TChartGetGridPieLineValue read FOnGetGridPieLineValue write FOnGetGridPieLineValue;
    property OnGetCrossHairValue: TChartGetCrossHairValueEvent read FOnGetCrossHairValue write FOnGetCrossHairValue;
    property OnGetCountChartType: TChartGetCountChartType read FOnGetCountChartType write FOnGetCountChartType;
    property OnGetCountGroupedChartType: TChartGetCountChartType read FOnGetCountGroupedChartType write FOnGetCountGroupedChartType;
    property OnGetNumberOfPoints: TChartGetNumberOfPoints read FOnGetNumberOfPoints write FOnGetNumberOfPoints;
    property OnGetPoint: TChartGetPoint read FOnGetPoint write FOnGetPoint;
    property OnXAxisClick: TChartXAxisClickEvent read FOnXAxisClick write FOnXAxisClick;
    property OnYAxisClick: TChartYAxisClickEvent read FOnYAxisClick write FOnYAxisClick;
    property OnLegendClick: TChartLegendClick read FOnLegendClick write FOnLegendClick;
    property OnPieLegendClick: TChartPieLegendClick read FOnPieLegendClick write FOnPieLegendClick;
    property OnSerieIndexHint: TChartSerieIndexHintEvent read FOnSerieIndexHint write FOnSerieIndexHint;
    property OnSerieIndexClick: TChartSelectSerieIndexEvent read FOnSerieIndexClick write FOnSerieIndexClick;
    property OnSelectSerieIndex: TChartSelectSerieIndexEvent read FOnSelectSerieIndex write FOnSelectSerieIndex;
    property OnHorizontalScroll: TChartHorzScrollEvent read FOnHorizontalScroll write FOnHorizontalScroll;
    property OnLeftScroll: TChartHorzScrollEvent read FOnLeftScroll write FOnLeftScroll;
    property OnRightScroll: TChartHorzScrollEvent read FOnRightScroll write FOnRightScroll;
    property OnVerticalScroll: TChartVertScrollEvent read FOnVerticalScroll write FOnVerticalScroll;
    property OnPaneSelected: TChartPaneSelectedEvent read FOnPaneSelected write FOnPaneSelected;
    property OnPaneMoved: TChartPaneMovedEvent read FOnPaneMoved write FOnPaneMoved;
    property OnPaneSized: TChartPaneSizedEvent read FOnPaneSized write FOnPaneSized;
    property OnYScaleZoom: TChartZoomYAxisEvent read FOnYScaleZoom write FOnYScaleZoom;
    property OnXScaleZoom: TChartZoomXAxisEvent read FOnXScaleZoom write FOnXScaleZoom;
    property OnTrackerClose: TCloseQueryEvent read FOnTrackerClose write FOnTrackerClose;
    property OnTrackerMove: TFormMoveEvent read FOnTrackerMove write FOnTrackerMove;
    property OnZoomSelection: TChartZoomSelectionEvent read FOnZoomSelection write FOnZoomSelection;
    property OnSerieMouseDown: TChartSerieMouseEvent read FOnSerieMouseDown write FOnSerieMouseDown;
    property OnSerieMouseUp: TChartSerieMouseEvent read FOnSerieMouseUp write FOnSerieMouseUp;
    property OnAnnotationMouseDown: TChartAnnotationMouseEvent read FOnAnnotationMouseDown write FOnAnnotationMouseDown;
    property OnAnnotationMouseUp: TChartAnnotationMouseEvent read FOnAnnotationMouseUp write FOnAnnotationMouseUp;
    property OnAnnotationClick: TChartAnnotationMouseEvent read FOnAnnotationClick write FOnAnnotationClick;
    property OnDrawChart: TChartDrawEvent read FOnDrawChart write FOnDrawChart;
    property OnBeforeDrawSeries: TChartPaneDrawEvent read FOnBeforeDrawSeries write FOnBeforeDrawSeries;
    property OnAfterDrawSeries: TChartPaneDrawEvent read FOnAfterDrawSeries write FOnAfterDrawSeries;
    property OnDrawPane: TChartDrawEvent read FOnDrawPane write FOnDrawPane;
    property OnSerieXAxisCustomGroup: TChartSerieXAxisCustomGroupEvent read FOnSerieXAxisCustomGroup write FOnSerieXAxisCustomGroup;
    property ClickCursor: TCursor read FClickCursor write FClickCursor default crDefault;
    {$IFDEF DELPHIXE2_LVL}
    property OnToolBarPopupActivate: TNotifyEvent read FOnToolBarPopupActivate write FOnToolBarPopupActivate;
    property OnToolBarPopupDeactivate: TNotifyEvent read FOnToolBarPopupDeactivate write FOnToolBarPopupDeactivate;
    {$ENDIF}
    property Ctl3D;
    property ParentShowHint;
    property DragKind;
    property DragMode;
    property OnDblClick;
    property OnClick;
    property OnEnter;
    property OnExit;
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
    property Padding;
    property ParentBackground default False;
    {$ENDIF}
    property ParentBiDiMode;
    property ParentCtl3D;
    property ParentFont;
    property OnCanResize;
    property OnConstrainedResize;
    property OnContextPopup;
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
  {$IFDEF DELPHIXE2_LVL}
  System.Win.Registry
  {$ELSE}
  Registry
  {$ENDIF}
  ,ShellApi
{$IFDEF DELPHIXE2_LVL}
  ,AdvChartPopup
{$ENDIF}
  ;

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


procedure DrawGradient(Canvas: TCanvas; FromColor, ToColor: TColor; Steps: Integer; R: TRect; Direction: TChartGradientDirection; Border: Boolean; BorderColor: TColor; BorderWidth: integer);
var
  diffr, startr, endr: Integer;
  diffg, startg, endg: Integer;
  diffb, startb, endb: Integer;
  rstepr, rstepg, rstepb, rstepw: Real;
  i, stepw: Word;
begin
  if Steps = 0 then
    Steps := 1;

  FromColor := ColorToRGB(FromColor);
  ToColor := ColorToRGB(ToColor);

  if R.Right < R.Left then
  begin
    startr := R.Right;
    R.Right := R.Left;
    R.Left := startr;
  end;

  if R.Top > R.Bottom then
  begin
    startr := r.Top;
    r.Top := r.Bottom;
    r.Bottom := startr;
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
    rstepw := (R.Right - R.Left) / Steps
  else
    rstepw := (R.Bottom - R.Top) / Steps;

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
        Rectangle(R.Left + stepw, R.Top, R.Left + stepw + Round(rstepw) + 1, R.Bottom)
      else
        Rectangle(R.Left, R.Top + stepw, R.Right, R.Top + stepw + Round(rstepw) + 1);
    end;

    if Border then
    begin
      Brush.Style := bsClear;
      Pen.Color := BorderColor;
      Pen.Width := BorderWidth;
      Rectangle(R);
    end;
  end;
end;

{ TAdvChartPane }

procedure TChartPane.AddBandSerie(startx, endx: integer; startvalue1,
  startvalue2, endvalue1, endvalue2: Double; UseCommonYRange: Boolean;
  serielinecolor: TColor; serielinewidth: integer; seriebandcolor: TColor);
var
  d1,d2: Double;
  f, t: integer;
  I, K: integer;
begin
  if startx > endx then
  begin
    t := startx;
    f := endx;
  end
  else
  begin
    t := endx;
    f := startx;
  end;

  d1 := (endvalue1 - startvalue1) / (t - f);
  d2 := (endvalue2 - startvalue2) / (t - f);

  with Series.Add do
  begin
    YAxis.Visible := false;
    XAxis.Visible := false;
    ChartType := ctBand;
    LineColor := serielinecolor;
    LineWidth := serieLineWidth;
    Color := seriebandcolor;

    //Undefined values to the startvalue
    for I := 0 to f - 1 do
      AddDoublePoint(0,0, false);

    //values from startvalue to endvalue with delta
    K := 0;
    for I := f to t - 1 do
    begin
      AddDoublePoint(startvalue1 + (K * d1),startvalue2 + (K * d2), true);
      Inc(K);
    end;
  end;

  if UseCommonYRange then
    for I := 0 to Series.Count - 1 do
      with Series[I] do
        AutoRange := arCommon;
end;

procedure TChartPane.AddLineSerie(startx, endx: integer; startvalue,
  endvalue: Double; UseCommonYRange: Boolean = true; serielinecolor: TColor = clBlack; serielinewidth: integer = 1);
var
  d: Double;
  f, t: integer;
  I, K: integer;
begin
  if startx > endx then
  begin
    t := startx;
    f := endx;
  end
  else
  begin
    t := endx;
    f := startx;
  end;

  d := (endvalue - startvalue) / (t - f);

  with Series.Add do
  begin
    YAxis.Visible := false;
    XAxis.Visible := false;
    ChartType := ctLine;
    LineColor := serielinecolor;
    LineWidth := serieLineWidth;
    ShowInLegend := false;

    //Undefined values to the startvalue
    for I := 0 to f - 1 do
      AddSinglePoint(0, false);

    //values from startvalue to endvalue with delta
    K := 0;
    for I := f to t do
    begin
      AddSinglePoint(startvalue + (K * d), true);
      Inc(K);
    end;
  end;

  if UseCommonYRange then
    for I := 0 to Series.Count - 1 do
      with Series[I] do
        AutoRange := arCommon;
end;

procedure TChartPane.AddMovingAverage(serieindex, startx, endx, window: integer;
  UseCommonYRange: Boolean; serielinecolor: TColor; serielinewidth: integer);
var
  i: integer;
  startsum: double;
  cs: TChartSerie;
  res: double;
begin
  if window <= 0 then
    raise Exception.Create('Moving average window size must be 1 or higher');

  startsum := 0;

  for i := startx to startx + window - 1 do
  begin
    startsum := startsum + Series[SerieIndex].GetPoint(i).SingleValue;
  end;

  cs := Series.Add;

  with cs do
  begin
    YAxis.Visible := false;
    XAxis.Visible := false;
    ChartType := ctLine;
    LineColor := serielinecolor;
    LineWidth := serieLineWidth;
    ShowInLegend := false;
  end;

  //Undefined values to the startvalue
  for I := 0 to window - 2 do
    cs.AddSinglePoint(0, false);

  //Moving averages
  for i := startx + window to endx do
  begin
    res := startsum / window;
    cs.AddSinglePoint(res);
    if i < endx then
    begin
      startsum := startsum - Series[SerieIndex].GetPoint(i - window).SingleValue;
      startsum := startsum + Series[SerieIndex].GetPoint(i).SingleValue;
    end;
  end;

  if UseCommonYRange then
    for I := 0 to Series.Count - 1 do
      with Series[I] do
        AutoRange := arCommon;
end;

procedure TChartPane.AddParetoLine(serieindex, startx, endx: integer;
  UseCommonYRange: Boolean; serielinecolor: TColor; serielinewidth: integer);
var
  i: integer;
  sum, sumtotal: Double;
  f, t: integer;
begin
  if startx >= endx then
    raise Exception.Create('End point should be larger than start point');

  if startx > endx then
  begin
    t := startx;
    f := endx;
  end
  else
  begin
    t := endx;
    f := startx;
  end;

  with Series.Add do
  begin
    YAxis.Visible := false;
    XAxis.Visible := false;
    ChartType := ctLine;
    LineColor := serielinecolor;
    LineWidth := serieLineWidth;
    ShowInLegend := false;
    ValueFormat := '%.1f%%';
    ShowValue := true;
    for I := 0 to f - 1 do
      AddSinglePoint(0, false);

    sumtotal := 0;
    for I := f to t do
      sumtotal := sumtotal + Series[serieindex].GetPoint(I).SingleValue;

    if sumtotal > 0 then
    begin
      sum := 0;
      for I := f to t do
      begin
        sum := sum + (Series[serieindex].GetPoint(I).SingleValue / sumtotal * 100);
        AddSinglePoint(sum);
      end;
    end;
  end;

  if UseCommonYRange then
    for I := 0 to Series.Count - 1 do
      with Series[I] do
        AutoRange := arCommonZeroBased;
end;

procedure TChartPane.AddTrendChannel(serieindex, startx, endx: integer;
  UseCommonYRange: Boolean; serielinecolor: TColor; serielinewidth: integer);
var
  i: integer;
  count: integer;
  yAxisValuesSum : double;
  xAxisValuesSum : double;
  xxSum : double;
  xySum : double;
  slope: double;
  intercept: double;
  mean: double;
  dev: double;
begin
  if startx >= endx then
    raise Exception.Create('End point should be larger than start point');

  count := endx - startx;

  yAxisValuesSum := 0;
  xAxisValuesSum := 0;
  xxSum := 0;
  xySum := 0;

  for i := startx to endx do
  begin
    yAxisValuesSum := yAxisValuesSum +
Series[SerieIndex].GetPoint(i).SingleValue;
  end;

  mean := yAxisValuesSum / count;
  dev := 0;

  for i := startx to endx do
  begin
    xAxisValuesSum := xAxisValuesSum + i;
    xySum := xysum + i * Series[SerieIndex].GetPoint(i).SingleValue;
    xxSum := xxsum + i * i;
    dev := dev + sqr((mean - Series[SerieIndex].GetPoint(i).SingleValue));
  end;

  dev := sqrt(dev / count);

  slope := (count * xySum - xAxisValuesSum * yAxisValuesSum) / ( (count *
xxSum) - (xAxisValuesSum * yAxisValuesSum));
  intercept := (yAxisValuesSum - slope * xAxisValuesSum) / count;

  AddLineSerie(startx,endx,intercept + dev,count * slope + (intercept + dev), UseCommonYRange, SerieLineColor, SerieLineWidth);
  AddLineSerie(startx,endx,intercept - dev,count * slope + (intercept - dev), UseCommonYRange, SerieLineColor, SerieLineWidth);
end;

procedure TChartPane.AddTrendChannelBand(serieindex, startx, endx: integer;
  UseCommonYRange: Boolean; serielinecolor: TColor; serielinewidth: integer;
  seriebandcolor: TColor);
var
  i: integer;
  count: integer;
  yAxisValuesSum : double;
  xAxisValuesSum : double;
  xxSum : double;
  xySum : double;
  slope: double;
  intercept: double;
  mean: double;
  dev: double;
begin
  if startx >= endx then
    raise Exception.Create('End point should be larger than start point');

  count := endx - startx;

  yAxisValuesSum := 0;
  xAxisValuesSum := 0;
  xxSum := 0;
  xySum := 0;

  for i := startx to endx do
  begin
    yAxisValuesSum := yAxisValuesSum +
Series[SerieIndex].GetPoint(i).SingleValue;
  end;

  mean := yAxisValuesSum / count;
  dev := 0;

  for i := startx to endx do
  begin
    xAxisValuesSum := xAxisValuesSum + i;
    xySum := xysum + i * Series[SerieIndex].GetPoint(i).SingleValue;
    xxSum := xxsum + i * i;
    dev := dev + sqr((mean - Series[SerieIndex].GetPoint(i).SingleValue));
  end;

  dev := sqrt(dev / count);

  slope := (count * xySum - xAxisValuesSum * yAxisValuesSum) / ( (count *
xxSum) - (xAxisValuesSum * yAxisValuesSum));
  intercept := (yAxisValuesSum - slope * xAxisValuesSum) / count;

  AddBandSerie(startx, endx,intercept - dev,intercept + dev,count * slope + (intercept - dev),count * slope + (intercept + dev),UseCommonYRange, SerieLineColor, SerieLineWidth,SerieBandColor);
end;

procedure TChartPane.AddTrendLine(serieindex, startx, endx: integer;
  UseCommonYRange: Boolean; serielinecolor: TColor; serielinewidth:
integer);
var
  i: integer;
  count: integer;
  yAxisValuesSum : double;
  xAxisValuesSum : double;
  xxSum : double;
  xySum : double;
  slope: double;
  intercept: double;

begin
  if startx >= endx then
    raise Exception.Create('End point should be larger than start point');

  count := endx - startx + 1;

  yAxisValuesSum := 0;
  xAxisValuesSum := 0;
  xxSum := 0;
  xySum := 0;

  for i := startx to endx do
  begin
    yAxisValuesSum := yAxisValuesSum +
Series[SerieIndex].GetPoint(i).SingleValue;
    xAxisValuesSum := xAxisValuesSum + I;
    xySum := xysum + i * Series[SerieIndex].GetPoint(i).SingleValue;
    xxSum := xxsum + i * i;
  end;

  slope := (count * xySum - xAxisValuesSum * yAxisValuesSum) / ( (count *
xxSum) - (xAxisValuesSum * xAxisValuesSum));
  intercept := (yAxisValuesSum - slope * xAxisValuesSum) / count;

  AddLineSerie(startx,endx,startx * slope + intercept,endx * slope + intercept, UseCommonYRange, SerieLineColor, SerieLineWidth);
end;

procedure TChartPane.Assign(Source: TPersistent);
begin
  if (Source is TChartPane) then
  begin
    XScaleOffset := (Source as TChartPane).XScaleOffset;
//    FAllowMoving := (Source as TChartPane).AllowMoving;
    FBorderColor := (Source as TChartPane).BorderColor;
    FBorderWidth := (Source as TChartPane).BorderWidth;
    FBorderStyle := (Source as TChartPane).BorderStyle;
    FName := (Source as TChartPane).Name;
    AxisMode := (Source as TChartPane).AxisMode;
    FHeight := (Source as TChartPane).Height;
    FVisible := (Source as TChartPane).Visible;
    FSplitter.Assign((Source as TChartPane).Splitter);
    Navigator.Assign((Source as TchartPane).Navigator);
    Margin.Assign((Source as TChartPane).Margin);
    XAxis.Assign((Source as TChartPane).XAxis);
    YAxis.Assign((Source as TChartPane).YAxis);
    XGrid.Assign((Source as TChartPane).XGrid);
    YGrid.Assign((Source as TChartPane).YGrid);
    Title.Assign((Source as TChartPane).Title);
    CrossHair.Assign((Source as TChartPane).CrossHair);
    BackGround.Assign((Source as TChartPane).BackGround);
//    FRect := (Source as TChartPane).Rectangle;
    Series.Assign((Source as TChartPane).Series);
    Legend.Assign((Source as TChartPane).Legend);
    Bands.Assign((Source as TChartPane).Bands);
    FHeightType := (Source as TChartPane).HeightType;
    FOptions := (Source as TChartPane).Options;
    FDS := (Source as TChartPane).DS;
    Range.Assign((Source as TChartPane).Range);
    FCtrlZooming := (Source as TChartPane).CtrlZooming;
  end;
end;

procedure TChartPane.BeginUpdate;
begin
  inc(FUpdateCount);
  FChart.BeginUpdate;
end;

procedure TChartPane.ChartChanged(Sender: TObject);
begin
  if Assigned(Collection) then
    TAdvChartView((Collection as TChartPanes).Owner).Invalidate;
end;

constructor TChartPane.Create(Collection: TCollection);
begin
  inherited;
  FChart := CreateChart;
  FChart.OnChange := ChartChanged;
  FChart.OnBeforeDrawSeries := DoBeforeDrawSeries;
  FChart.OnAfterDrawSeries := DoAfterDrawSeries;

  FTag := 0;

  FSplitter := TChartSplitter.Create(Self);
  FSplitter.OnChange := SplitterChanged;
  FSplitter.FChart := FChart;

  FVisible := true;

  if Assigned(Collection) then
    FTimerScroll := TTimer.Create(TAdvChartView((Collection as TChartPanes).Owner))
  else
    FTimerScroll := TTimer.Create(nil);

  FTimerScroll.OnTimer := TimerScrollChanged;
  FTimerScroll.Enabled := false;

  if Assigned(Collection) then
    FTimerZoomOut := TTimer.Create(TAdvChartView((Collection as TChartPanes).Owner))
  else
    FTimerZoomOut := TTimer.Create(nil);

  FTimerZoomOut.OnTimer := TimerZoomOutChanged;
  FTimerZoomOut.Enabled := false;

  //FAllowMoving := true;
  FName := 'ChartPane ' + inttostr(ID);
  FHeight := 100;
  FHeightType := htPercentage;
  FBorderWidth := 1;
  FBorderStyle := bsSingle;
  FBorderColor := clNone;

  FCtrlZooming := czXAxis;
end;

function TChartPane.CreateChart: TAdvChart;
begin
  Result := TAdvChart.Create(Self);
  if (csDesigning in ChartView.ComponentState) and not (csLoading in ChartView.componentstate) then
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

destructor TChartPane.Destroy;
begin
  FChart.Free;
  FSplitter.Free;
  FTimerScroll.Free;
  FTimerZoomOut.Free;
  inherited;
end;

procedure TChartPane.Draw(ACanvas: TCanvas; R: TRect; Scalex, Scaley: Double; Initialize: Boolean = False);
var
  FocusPen: HPEN;
  FocusPenBrush: tagLOGBRUSH;
  OldPen: TPen;
begin
  if not Visible then
    Exit;

  FChart.Draw(ACanvas,R, ScaleX, ScaleY, Initialize);

  if (BorderStyle = bsSingle) and (BorderColor <> clNone) then
  begin
    ACanvas.Pen.Color := BorderColor;
    ACanvas.Pen.Width := BorderWidth;
    ACanvas.Pen.Style := psSolid;
    ACanvas.Brush.Color := clNone;
    ACanvas.Brush.Style := bsClear;
    ACanvas.Rectangle(R);
    InflateRect(R,-BorderWidth,-BorderWidth);
  end;

  // show focus rectangle
  if FFocused then
  begin
    InflateRect(R,-1,-1);

    ACanvas.Brush.Style := bsClear;
    FocusPenBrush.lbColor := clBlack;
    FocusPenBrush.lbStyle := BS_SOLID;
    FocusPen := ExtCreatePen(PS_COSMETIC or PS_ALTERNATE, 1, FocusPenBrush, 0, nil);

    OldPen := TPen.Create;
    OldPen.Assign(ACanvas.Pen);

    SelectObject(ACanvas.Handle, FocusPen);

    ACanvas.Rectangle(R.Left, R.Top, R.Right, R.Bottom);

    SelectObject(ACanvas.Handle, OldPen.Handle);

    OldPen.Free;

    DeleteObject(FocusPen);
  end;
end;

procedure TChartPane.Draw(ACanvas: TCanvas; R: TRect; Initialize: Boolean);
begin
  Draw(ACanvas, R, 1, 1, Initialize);
end;

function TChartPane.DrawChart(ACanvas: TCanvas; R: TRect; ScaleX, ScaleY: Double; Initialize: Boolean): TRect;
begin
  if (BorderStyle = bsSingle) then
  begin
    ACanvas.Pen.Color := BorderColor;
    ACanvas.Pen.Width := BorderWidth;
    ACanvas.Pen.Style := psSolid;
    ACanvas.Brush.Style := bsClear;
    ACanvas.Rectangle(R);
    InflateRect(R, -BorderWidth, -BorderWidth);
  end;

  Result := FChart.Draw(ACanvas, R, ScaleX, ScaleY, Initialize);
end;

procedure TChartPane.DrawHorizontalCrossHair(Canvas: TCanvas; R: TRect; X,
  Y: integer);
begin
  Canvas.Pen.Color := CrossHair.LineColor;
  Canvas.Pen.Width := CrossHair.LineWidth;
  if series.IsHorizontal then
  begin
    Canvas.MoveTo(X, R.Top);
    Canvas.LineTo(X, R.Bottom);
  end
  else
  begin
    Canvas.MoveTo(R.Left, Y);
    Canvas.LineTo(R.Right, Y);
  end;
end;

procedure TChartPane.DrawTextBackGround(Canvas: TCanvas; P: TSeriePoint);
begin
  with Series.Items[P.Serie] do
  begin
    Canvas.Font.Assign(CrossHairYValue.Font);
    if ColorTo = clNone then
    begin
      if Color <> clNone then
      begin
        Canvas.Brush.Color := Color;
      end
      else
        Canvas.Brush.Style := bsClear;
    end
    else
    begin
      if Color <> clNone then
      begin
      {
        DrawGradient(Canvas, Color, ColorTo, GradientSteps,
          Bounds(Round(P.XValueYAxis), Round(P.YValue) - Canvas.TextHeight(Format(ValueFormat,
          [YToValue(Round(P.YValue), FSeriesRect)])) ,
          Length(Format(ValueFormat, [YToValue(Round(P.YValue - OffSet), FSeriesRect)])),
          Canvas.TextHeight(floattostr(YToValue(Round(P.YValue), FSeriesRect)))) , GradientDirection);
      }
      end;
    end;
  end;
end;

procedure TChartPane.DrawVerticalCrossHair(Canvas: TCanvas; R: TRect; X,
  Y: integer);
begin
  Canvas.Pen.Color := CrossHair.LineColor;
  Canvas.Pen.Width := CrossHair.LineWidth;
  if Series.IsHorizontal then
  begin
    Canvas.MoveTo(R.Left, Y);
    Canvas.LineTo(R.Right, Y);
  end
  else
  begin
    Canvas.MoveTo(X, R.Top);
    Canvas.LineTo(X, R.Bottom);
  end;
end;

function TChartPane.GetAxisMode: TChartAxisMode;
begin
  Result := Fchart.AxisMode;
end;

function TChartPane.GetBackground: TChartBackground;
begin
  Result := FChart.BackGround;
end;

function TChartPane.GetBands: TChartBands;
begin
  Result := FChart.Bands;
end;

function TChartPane.GetChartPointAtCrossHair(SerieIndex: integer): TChartPoint;
var
  crosshairinpane: Boolean;
  cpi: integer;
begin
  with ChartView do
  begin
    if CrossHair.Visible then
    begin
      if Series.IsHorizontal then
      begin
        if FVerticalCrosshairSynched then
          crosshairinpane := (FVerticalCrossHairY > FSeriesRect.Top) and (FVerticalCrossHairY < FSeriesRect.Bottom)
        else
          crosshairinpane := (FVerticalCrossHairY > FSeriesRect.Top) and (FVerticalCrossHairX < FSeriesRect.Bottom) and (FVerticalCrossHairX > FRect.Left) and (FVerticalCrossHairX < FRect.Right);

      //cursor in chart area
        if crosshairinpane then
        begin
          if (Series[SerieIndex].ChartType = ctXYLine) or (Series[SerieIndex].ChartType = ctXYDigitalLine) or (Series[SerieIndex].ChartType = ctXYMarkers) then
            result := Series[SerieIndex].GetChartPoint(Series[SerieIndex].GetXYPoint(FVerticalCrossHairY, FVerticalCrossHairX))
          else
          begin
            cpi := FChart.Range.RangeFrom + round((FVerticalCrossHairY - FSeriesRect.Top - (Chart.GetXScaleStart)) / FChart.XScale);
            result := Series[serieindex].GetChartPoint(cpi);
          end;
        end;
      end
      else
      begin
        if FVerticalCrosshairSynched then
          crosshairinpane := (FVerticalCrossHairX > FSeriesRect.Left) and (FVerticalCrossHairX < FSeriesRect.Right)
        else
          crosshairinpane := (FVerticalCrossHairX > FSeriesRect.Left) and (FVerticalCrossHairX < FSeriesRect.Right) and (FVerticalCrossHairY > FRect.Top) and (FVerticalCrossHairY < FRect.Bottom);

      //cursor in chart area
        if crosshairinpane then
        begin
          if (Series[SerieIndex].ChartType = ctXYLine) or (Series[SerieIndex].ChartType = ctXYDigitalLine) or (Series[SerieIndex].ChartType = ctXYMarkers) then
            result := Series[SerieIndex].GetChartPoint(Series[SerieIndex].GetXYPoint(FVerticalCrossHairX, FVerticalCrossHairY))
          else
          begin
            cpi := FChart.Range.RangeFrom + round((FVerticalCrossHairX - FSeriesRect.Left - (Chart.GetXScaleStart)) / FChart.XScale);
            result := Series[serieindex].GetChartPoint(cpi);
          end;
        end;
      end;
    end;
  end;
end;

function TChartPane.GetChartView: TAdvChartView;
begin
  Result := nil;
  if Assigned(Collection) then
    Result := (Collection as TChartPanes).FOwner;
end;

function TChartPane.GetCrossHair: TChartCrossHair;
begin
  Result := FChart.CrossHair;
end;

function TChartPane.GetDS: TComponent;
begin
  Result := FDS;
end;

function TChartPane.GetDSNames: TStringList;
begin
  Result := nil;
end;

function TChartPane.GetLegend: TChartLegend;
begin
  Result := FChart.Legend;
end;

function TChartPane.GetMargin: TChartMargin;
begin
  Result := FChart.Margin;
end;

function TChartPane.GetNavigator: TChartNavigator;
begin
  Result := FChart.Navigator;
end;

function TChartPane.GetPaneRectangle: TRect;
begin
  result := FRect;
end;

function TChartPane.GetRange: TChartRange;
begin
  Result := FChart.Range;
end;

function TChartPane.GetSeries: TChartSeries;
begin
  Result := FChart.Series;
end;

function TChartPane.GetTitle: TChartTitle;
begin
  Result := FChart.Title;
end;

function TChartPane.GetVisibleSerieIndex: Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Series.Count - 1 do
  begin
    if Series[I].Visible then
    begin
      Result := I;
      Break;
    end;
  end;
end;

function TChartPane.GetXAxis: TChartXAxis;
begin
  Result := FChart.XAxis;
end;

function TChartPane.GetXGrid: TChartXGrid;
begin
  Result := FChart.XGrid;
end;

function TChartPane.GetXScaleOffset: Boolean;
begin
  Result  := FChart.XScaleOffset;
end;

function TChartPane.GetYAxis: TChartYAxis;
begin
  Result := FChart.YAxis;
end;

function TChartPane.GetYGrid: TChartYGrid;
begin
  Result := FChart.YGrid;
end;

procedure TChartPane.InitSample;
begin
  ChartView.Color := clWhite;
  BorderColor := clBlack;
  Series.Clear;
  BorderWidth := 1;
  Title.Text := 'TAdvChartView';
  Title.Position := tTop;
  Title.Alignment := taCenter;
  Title.Size := 20;

  XAxis.Text := 'X-axis';
  XAxis.Position := xBottom;
  XAxis.Size := 30;
  YAxis.Size := 40;
  YAxis.Text := 'Y-axis';

  //Height := 100;
  //HeightType := htPercentage;

  YAxis.Position := yLeft;

  Margin.TopMargin := 10;
  Margin.LeftMargin := 10;
  Margin.RightMargin := 10;

  with Series.Add do
  begin
    Xaxis.MajorUnit := 1;
    YAxis.TextLeft.Angle := -90;
    YAxis.TextRight.Angle := 90;
    Color := RGB(255, 85, 0);
    LineColor := Color;
    YAxis.MajorUnitSpacing := 10;
    YAxis.MinorUnitSpacing := 10;
    Minimum := 0;
    Maximum := 12;
    AutoRange := arDisabled;
    ChartType := ctLine;
    ValueWidth := 80;
    ValueWidthType := wtPercentage;
    ClearPoints;
    AddSingleXYPoint(0.5, Random(10) + 1);
    AddSingleXYPoint(1.5, Random(10) + 1);
    AddSingleXYPoint(1.8, Random(10) + 1);
    AddSingleXYPoint(2.8, Random(10) + 1);
    AddSingleXYPoint(3.4, Random(10) + 1);
    AddSingleXYPoint(4.8, Random(10) + 1);

    Yaxis.MajorUnit := 1;
    YAxis.MajorUnitSpacing := 0;

    YAxis.TickMarkColor := clRed;

    XAxis.TickMarkSize := 6;
    XAxis.TickMarkWidth := 1;
    XAxis.TickMarkColor := clBlack;
    Marker.MarkerType := mCircle;
    Marker.MarkerColor := Color;
    Marker.SelectedColor := Color;
    Marker.SelectedLineColor := clBlack;
    Marker.SelectedSize := Marker.MarkerSize + 5;
  end;

  with Series.Add do
  begin
    Minimum := 0;
    Maximum := 12;
    AutoRange := arDisabled;
    Xaxis.MajorUnit := 1;
    XAxis.Visible := false;
    YAxis.TextLeft.Angle := -90;
    YAxis.TextRight.Angle := 90;
    Color := RGB(0, 131, 207);
    LineColor := Color;
    YAxis.Visible := False;
    ValueWidth := 80;
    ValueWidthType := wtPercentage;
    ChartType := ctLine;
    ClearPoints;
    AddSingleXYPoint(0.2, Random(10) + 1);
    AddSingleXYPoint(1.2, Random(10) + 1);
    AddSingleXYPoint(1.5, Random(10) + 1);
    AddSingleXYPoint(2.0, Random(10) + 1);
    AddSingleXYPoint(3.4, Random(10) + 1);
    AddSingleXYPoint(4.5, Random(10) + 1);
    Marker.MarkerType := mCircle;
    Marker.MarkerColor := Color;
    Marker.SelectedColor := Color;
    Marker.SelectedLineColor := clBlack;
    Marker.SelectedSize := Marker.MarkerSize + 5;
  end;

  with Series.Add do
  begin
    Xaxis.MajorUnit := 1;
    Color := RGB(130, 186, 102);
    LineColor := Color;
    YAxis.MajorUnitSpacing := 10;
    YAxis.MinorUnitSpacing := 10;
    YAxis.TextLeft.Angle := -90;
    YAxis.TextRight.Angle := 90;
    Minimum := 0;
    Maximum := 12;
    YAxis.Visible := False;
    XAXis.Visible := False;
    AutoRange := arDisabled;
    ChartType := ctLine;
    ValueWidth := 80;
    ValueWidthType := wtPercentage;
    ClearPoints;
    AddSingleXYPoint(1, Random(10) + 1);
    AddSingleXYPoint(2, Random(10) + 1);
    AddSingleXYPoint(3.5, Random(10) + 1);
    AddSingleXYPoint(4.0, Random(10) + 1);
    AddSingleXYPoint(4.5, Random(10) + 1);
    AddSingleXYPoint(5.0, Random(10) + 1);

    Yaxis.MajorUnit := 2;
    YAxis.MajorUnitSpacing := 0;
    YAxis.TickMarkColor := clBlue;

    XAxis.TickMarkSize := 6;
    XAxis.TickMarkWidth := 2;
    XAxis.TickMarkColor := clRed;
    Marker.MarkerType := mCircle;
    Marker.MarkerColor := Color;
    Marker.SelectedColor := Color;
    Marker.SelectedLineColor := clBlack;
    Marker.SelectedSize := Marker.MarkerSize + 5;
  end;

  Range.RangeFrom := 0;
  Range.RangeTo := 5;
  Range.StartDate := Now;

  Series.ForceInit(true);
end;

function TChartPane.IsDB: Boolean;
begin
  Result := false;
end;

procedure TChartPane.LoadData;
begin
  //
end;

procedure TChartPane.LoadFromFile(ini: TMemIniFile; Section: String; AutoCreateSeries: Boolean = False);
var
  A: TStringList;
  str: String;
  I: integer;
begin
  AxisMode := TChartAxisMode(ini.ReadInteger(Section, 'AxisMode', Integer(AxisMode)));
  Bands.LoadFromFile(ini, Section + '.' + 'Bands');
  Background.LoadFromFile(ini, Section + '.' + 'BackGround');
  BorderStyle := TFormBorderStyle(ini.ReadInteger(Section, 'BorderStyle', Integer(BorderStyle)));
  BorderColor := ini.ReadInteger(Section, 'BorderColor', BorderColor);
  BorderWidth := ini.ReadInteger(Section, 'BorderWidth', BorderWidth);
  CrossHair.LoadFromFile(ini, Section + '.' + 'CrossHair');
  Height := ini.ReadFloat(Section, 'Height', Height);
  HeightType := TPaneHeightType(ini.ReadInteger(Section, 'HeightType', Integer(HeightType)));
  Legend.LoadFromFile(ini, Section + '.' + 'Legend');
  Margin.LoadFromFile(ini, Section + '.' + 'Margin');
  Navigator.LoadFromFile(ini, Section + '.' + 'Navigator');
  Name := ini.ReadString(Section, 'Name', Name);
  str := ini.ReadString(Section, 'Options', '');
  A := TStringList.Create;
  Split(':',str, A);
  for I := 1 to A.Count - 1 do
  begin
    Options := Options + [TPaneOptionType(strtoint(A[I]))];
  end;
  A.Free;
  Range.LoadFromFile(ini, Section + '.' + 'Range');
  Series.LoadFromFile(ini, Section + '.' + 'Series', AutoCreateSeries);
  Splitter.LoadFromFile(ini, Section + '.' + 'Splitter');
  Title.LoadFromFile(ini, Section + '.' + 'Title');
  Visible := ini.ReadBool(Section ,'Visible', Visible);
  XAxis.LoadFromFile(ini, Section + '.' + 'XAxis');
  YAxis.LoadFromFile(ini, Section + '.' + 'YAxis');
  XGrid.LoadFromFile(ini, Section + '.' + 'XGrid');
  YGrid.LoadFromFile(ini, Section + '.' + 'YGrid');
end;

procedure TChartPane.MoveSerie(SerieIndexFrom, SerieIndexTo: integer);
begin
  if (SerieIndexFrom >= 0) and (SerieIndexFrom <= Series.Count - 1)
    and (SerieIndexTo >= 0) and (SerieIndexTo <= Series.Count - 1) then
      Series[SerieIndexFrom].Index := SerieIndexTo;
end;

procedure TChartPane.PaneChanged(Sender: TObject);
begin
  if Index < (Collection as TChartPanes).Count then
  begin
    with TAdvChartView((Collection as TChartPanes).Owner) do
    begin
      FSeriesRect := FChart.SeriesRectangle(Panes[Index].FRect, 1, 1);
    end;
  end;
end;

function TChartPane.PixelHeight: integer;
var
  th,i,j: integer;
  panes: TChartPanes;
begin

  panes := (Collection as TChartPanes);

  if HeightType = htPixels then
    Result := Round(FHeight)
  else
  begin
    th := (Panes.Owner as TAdvChartView).Height;

    j := 0;

    for i := 0 to Panes.Count - 1 do
    begin
      if Panes.Items[I].Visible then
      begin
        if Panes.Items[i].HeightType = htPixels then
        begin
          th := th - Round(Panes.Items[i].Height);
        end;

        if Panes.Items[i].HeightType = htAuto then
          inc(j);
      end;
    end;

    if HeightType = htPercentage then
    begin
      Result := round(th * FHeight / 100);
    end
    else
    begin
      Result := round(th / j);
    end;
  end;

end;

procedure TChartPane.DrawVerticalLines(Canvas: TCanvas; R: TRect);
var
  P: TSeriePoint;
  pth, th, tw, pt, tx, ty: integer;
  I: Integer;
  vx, vy: integer;
  xv: Integer;
  clipy: integer;
  txt: string;
  HRGN: THandle;
  dodraw: Boolean;
begin
  if (FUpdateCount > 0) then
    Exit;

  pth := 0;
  vx := FVerticalCrossHairX;
  vy := FVerticalCrossHairY;

  for I := 0 to (Collection as TChartPanes).Count - 1 do
  begin
    with (Collection as TChartPanes).Items[I] do
    begin
      if Visible then
      begin
        if (Collection as TChartPanes)[I].Series.IsHorizontal then
          pth := pth + FSeriesRect.Right + Margin.RightMargin + FSeriesRect.Left + Margin.LeftMargin
        else
          pth := pth + FSeriesRect.Bottom + Margin.BottomMargin + Navigator.BottomSize + FSeriesRect.Top + Margin.TopMargin ;//+ Splitter.Height;
      end;
    end;
  end;

  if CrossHair.Visible and (CrossHair.CrossHairType <> chtNone) then
  begin
    if Series.IsHorizontal then
      HRGN := CreateRectRgn(FRect.Left, FRect.Top, pth, FRect.Bottom)
    else
      HRGN := CreateRectRgn(FRect.Left, FRect.Top, FRect.Right, pth);

    SelectClipRgn(Canvas.Handle,HRGN);
    Canvas.Pen.Color := CrossHair.LineColor;
    Canvas.Pen.Width := CrossHair.LineWidth;

    if (CrossHair.CrossHairType = chtFullSizeCrossHairAtSeries) then
    begin
      DrawVerticalCrossHair(Canvas, R, vx, vy);

      for pt := 0 to Length(FVerticalCrossHairPoints) - 1 do
      begin
        P := FVerticalCrossHairPoints[pt];
        if ((P.Serie >= 0) and (p.Serie <= Series.Count - 1) and Series[P.Serie].Visible) or (p.Serie = -1) then
        begin
         clipy := Round(P.YValue);

          if Series.IsHorizontal then
            dodraw := (clipy < FSeriesRect.Right) and (clipy > FSeriesRect.Left)
          else
            dodraw := (clipy < FSeriesRect.Bottom) and (clipy > FSeriesRect.Top);

          if dodraw then
          begin
            if Series.IsHorizontal then
            begin
              Canvas.MoveTo(clipy, FSeriesRect.Top);
              Canvas.LineTo(clipy, FSeriesRect.Bottom);
            end
            else
            begin
              Canvas.MoveTo(FSeriesRect.Left, clipy);
              Canvas.LineTo(FSeriesRect.Right,clipy);
            end;
          end;
        end;
      end;
    end
    else if CrossHair.CrossHairType = chtSmallCrossHair then
    begin
      Canvas.Pen.Color := CrossHair.LineColor;
      Canvas.Pen.Width := CrossHair.LineWidth;
      Canvas.MoveTo(vx - 15, vy);
      canvas.LineTo(vx + 15, vy);
      Canvas.MoveTo(vx, vy - 15);
      canvas.LineTo(vx, vy + 15);
    end
    else
      if CrossHair.CrossHairType = chtFullSizeCrossHairAtCursor then
      begin
        DrawVerticalCrossHair(Canvas, R, vx, vy);
        DrawHorizontalCrossHair(Canvas, FSeriesRect, vx, vy);
      end;

      SelectClipRgn(Canvas.Handle,0);
      DeleteObject(HRGN);


      for pt := 0 to Length(FVerticalCrossHairPoints) - 1 do
      begin
        P := FVerticalCrossHairPoints[pt];
        if (P.Serie >= 0) and (P.Serie < Series.Count) then
        begin
          with TCrackedChartSerie(Series[P.Serie]) do
          begin
            if (ChartType <> ctNone) and CrossHairYValue.Visible and (SerieType <> stZoomControl) and Visible then
            begin

              clipy := round(p.YValue);

              if Series.IsHorizontal then
              begin
                if clipy > FSeriesRect.Right then
                  clipy := FSeriesRect.Right;
                if clipy < FSeriesRect.Left then
                  clipy := FSeriesRect.Left;
              end
              else
              begin
                if clipy > FSeriesRect.Bottom then
                  clipy := FSeriesRect.Bottom;
                if clipy < FSeriesRect.Top then
                  clipy := FSeriesRect.Top;
              end;

              with CrossHairYValue do
              begin
                if Visible then
                begin
                  if P.PointType = cspYPos then
                    txt := Format(ValueFormat, [YToValue(Round(P.YValue), FSeriesRect)])
                  else
                    txt := Format(ValueFormat, [p.SerieValue]);

                  if Assigned(ChartView.OnGetCrossHairValue) then
                    ChartView.OnGetCrossHairValue(Self, p, txt);

                  Canvas.Font.Assign(CrossHairYValue.Font);
                  if Series.IsHorizontal then
                  begin
                    th := Canvas.TextWidth(txt) + 4;
                    tw := Canvas.TextHeight('gh');
                  end
                  else
                  begin
                    th := Canvas.TextHeight('gh');
                    tw := Canvas.TextWidth(txt) + 4;
                  end;

                  if Series.IsHorizontal then
                  begin
                    ty := clipy;
                    if ty + th > FSeriesRect.Right then
                      ty := clipy - th;
                  end
                  else
                  begin
                    ty := clipy - th;
                    if ty < FSeriesRect.Top then
                      ty := clipy;
                  end;

                  if chYAxis in CrossHair.CrossHairYValues.Position then
                  begin
                      xv := Round(p.XValueYAxis - tw);

                      if CrossHairYValue.Color = clNone then
                        Canvas.Brush.Style := bsClear
                      else
                      begin
                        Canvas.Brush.Color := CrossHairYValue.Color;
                        if CrossHairYValue.ColorTo <> clNone then
                        begin
                          if Series.IsHorizontal then
                          begin
                            DrawGradient(Canvas,CrossHairYValue.Color, CrossHairYValue.ColorTo, CrossHairYValue.GradientSteps,
                            Rect(ty, xv, ty + th, xv + Canvas.TextHeight(txt)),
                            CrossHairYValue.GradientDirection, true, CrossHairYValue.BorderColor, CrossHairYValue.BorderWidth);
                          end
                          else
                          begin
                            DrawGradient(Canvas,CrossHairYValue.Color, CrossHairYValue.ColorTo, CrossHairYValue.GradientSteps,
                            Rect(xv, ty, xv + Canvas.TextWidth(txt), ty + th),
                            CrossHairYValue.GradientDirection, true, CrossHairYValue.BorderColor, CrossHairYValue.BorderWidth);
                          end;
                          Canvas.Brush.Style := bsClear;
                        end;
                      end;

                      if Series.IsHorizontal then
                        Canvas.TextOut(ty, xv + 2, txt)
                      else
                        Canvas.TextOut(xv + 2, ty, txt);
                  end;

                  if chAtCursor in CrossHair.CrossHairYValues.Position then
                  begin
                    if CrossHairYValue.Color = clNone then
                      Canvas.Brush.Style := bsClear
                    else
                    begin
                      Canvas.Brush.Color := CrossHairYValue.Color;
                      if CrossHairYValue.ColorTo <> clNone then
                      begin
                        if Series.IsHorizontal then
                        begin
                          DrawGradient(Canvas,CrossHairYValue.Color, CrossHairYValue.ColorTo, CrossHairYValue.GradientSteps,
                          Rect(clipy - th, Round(P.XValueAtCursor), ty, Round(P.XValueAtCursor) + Canvas.TextHeight(txt)),
                          CrossHairYValue.GradientDirection, true, CrossHairYValue.BorderColor, CrossHairYValue.BorderWidth);
                        end
                        else
                        begin
                          DrawGradient(Canvas,CrossHairYValue.Color, CrossHairYValue.ColorTo, CrossHairYValue.GradientSteps,
                          Rect(Round(P.XValueAtCursor), ty, Round(P.XValueAtCursor) + Canvas.TextWidth(txt), clipy),
                          CrossHairYValue.GradientDirection, true, CrossHairYValue.BorderColor, CrossHairYValue.BorderWidth);
                        end;
                        Canvas.Brush.Style := bsClear;
                      end;
                    end;

                    if Series.IsHorizontal then
                    begin
                      tx := Round(p.XValueAtCursor) - tw;
                      if tx < FSeriesRect.Top then
                        tx := Round(p.XValueAtCursor);

                      Canvas.TextOut(ty, tx, txt)
                    end
                    else
                    begin
                      tx := Round(p.XValueAtCursor);
                      if tx + tw > FSeriesRect.Right then
                        tx := tx - tw;

                      Canvas.TextOut(tx, ty, txt)
                    end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TChartPane.EndUpdate(Canvas: TCanvas; R: TRect);
begin
  if FUpdateCount > 0 then
    Dec(FUpdateCount);

  FChart.EndUpdate(Canvas, R);
end;

function GetOptions(options: TPaneOptions): String;
var
  str: String;
begin
  str := '';
  if poMoving in Options then
    str := str + ':0';
  if poHorzScroll in Options then
    str := str + ':1';
  if poVertScroll in Options then
    str := str + ':2';
  if poHorzScale in Options then
    str := str + ':3';
  if poVertScale in Options then
    str := str + ':4';
  Result := str;
end;

procedure TChartPane.SaveToFile(ini: TMemIniFile; Section: String);
begin
  ini.WriteInteger(Section, 'AxisMode', Integer(AxisMode));
  Bands.SaveToFile(ini, Section + '.' + 'Bands');
  Background.SaveTofile(ini, Section + '.' + 'BackGround');
  ini.WriteInteger(Section, 'BorderStyle', Integer(BorderStyle));
  ini.WriteInteger(Section, 'BorderColor', BorderColor);
  ini.WriteInteger(Section, 'BorderWidth', BorderWidth);
  CrossHair.SaveToFile(ini, Section + '.' + 'CrossHair');
  ini.WriteFloat(Section, 'Height', Height);
  ini.WriteInteger(Section, 'HeightType', Integer(HeightType));
  Legend.SaveToFile(ini, Section + '.' + 'Legend');
  Margin.SaveToFile(ini, Section + '.' + 'Margin');
  Navigator.SaveToFile(ini, Section + '.' + 'Navigator');
  ini.WriteString(Section, 'Name', Name);
  ini.WriteString(Section, 'Options', GetOptions(Options));
  Range.SaveToFile(ini, Section + '.' + 'Range');
  ini.WriteInteger(Section, 'RectangleLeft', Rectangle.Left);
  ini.WriteInteger(Section, 'RectangleTop', Rectangle.Top);
  ini.WriteInteger(Section, 'RectangleRight', Rectangle.Right);
  ini.WriteInteger(Section, 'RectangleBottom', Rectangle.Bottom);
  Series.SaveToFile(ini, Section + '.' + 'Series');
  Splitter.SaveToFile(ini, Section + '.' + 'Splitter');
  Title.SaveToFile(ini, Section + '.' + 'Title');
  ini.WriteBool(Section ,'Visible', Visible);
  XAxis.SaveToFile(ini, Section + '.' + 'XAxis');
  YAxis.SaveToFile(ini, Section + '.' + 'YAxis');
  XGrid.SaveToFile(ini, Section + '.' + 'XGrid');
  YGrid.SaveToFile(ini, Section + '.' + 'YGrid');
end;

procedure TChartPane.SetAxisMode(const Value: TChartAxisMode);
begin
  if FChart.AxisMode <> value then
  begin
    FChart.AxisMode := value;
    ChartChanged(Self);
  end;
end;

procedure TChartPane.SetBackground(const Value: TChartBackground);
begin
  FChart.BackGround.Assign(Value);
end;

procedure TChartPane.SetBands(const Value: TChartBands);
begin
  FChart.Bands.Assign(Value);
end;

procedure TChartPane.SetBorderColor(const Value: TColor);
begin
  if (FBorderColor <> Value) then
  begin
    FBorderColor := Value;
    ChartChanged(self);
  end;
end;

procedure TChartPane.SetBorderStyle(const Value: TBorderStyle);
begin
  if (FBorderStyle <> Value) then
  begin
    FBorderStyle := Value;
    ChartChanged(self);
  end;
end;

procedure TChartPane.SetBorderWidth(const Value: integer);
begin
  if (Value >= 1) then
  begin
    FBorderWidth := Value;
    ChartChanged(self);
  end;
end;

procedure TChartPane.SetCrossHair(const Value: TChartCrossHair);
begin
  FChart.CrossHair.Assign(Value);
end;

procedure TChartPane.SetDrawLines(const Value: Boolean);
begin
  if FDrawLines <> Value then
  begin
    FDrawLines := Value;
    if CrossHair.Visible then
      ChartChanged(Self);
  end;
end;

procedure TChartPane.SetDS(ADS: TComponent);
begin
  FDS := ADS;
end;

procedure TChartPane.SetHeight(const Value: double);
var
  I: Integer;
begin
  if Value < 0 then
    Exit;

  if (HeightType = htPercentage) and (value > 100) then
    Exit;

  if (FHeight <> Value) then
  begin
    FOldHeight := FHeight;
    FHeight := Value;

    Series.ForceInit(true);

    if FChart.ForceInitYScale then
    begin
      for I := 0 to Series.Count - 1 do
      begin
        if (FOldHeight > 0) then
          Series.Items[I].YScale := (Series.Items[I].OldYScale * FHeight) / FOldHeight;
      end;
    end;
    ChartChanged(Self);
  end;
end;

procedure TChartPane.SetHeightType(const Value: TPaneHeightType);
begin
  if (FHeightType <> Value) then
  begin
    FHeightType := Value;
    ChartChanged(Self);
  end;
end;

procedure TChartPane.SetLegend(const Value: TChartLegend);
begin
  FChart.Legend.Assign(Value);
end;

procedure TChartPane.SetMargin(const Value: TChartMargin);
begin
  FChart.Margin.Assign(Value);
end;

procedure TChartPane.SetMaxRangeTo(Max: integer);
begin
  FChart.Range.MaxRangeTo := Max;
end;

procedure TChartPane.SetName(const Value: String);
begin
  if FName <> value then
  begin
    FName := Value;
    ChartChanged(Self);
  end;
end;

procedure TChartPane.SetNavigator(const Value: TChartNavigator);
begin
  FChart.Navigator.Assign(Value);
end;

procedure TChartPane.SetRange(const Value: TChartRange);
begin
  FChart.Range.Assign(Value);
end;

procedure TChartPane.SetSeries(const Value: TChartSeries);
begin
  FChart.Series.Assign(Value);
end;

procedure TChartPane.SetSplitter(const Value: TChartSplitter);
begin
  FSplitter := Value;
end;

procedure TChartPane.SetTitle(const Value: TChartTitle);
begin
  FChart.Title.Assign(Value);
end;

procedure TChartPane.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    ChartChanged(Self);
  end;
end;

procedure TChartPane.SetXAxis(const Value: TChartXAxis);
begin
  FChart.XAxis.Assign(Value);
end;

procedure TChartPane.SetXGrid(const Value: TChartXGrid);
begin
  FChart.XGrid.Assign(Value);
end;

procedure TChartPane.SetXScaleOffset(const Value: Boolean);
begin
  FChart.XScaleOffset := Value;
end;

procedure TChartPane.SetYAxis(const Value: TChartYAxis);
begin
  FChart.YAxis.Assign(Value);
end;

procedure TChartPane.SetYGrid(const Value: TChartYGrid);
begin
  FChart.YGrid.Assign(Value);
end;

procedure TChartPane.SplitterChanged(Sender: TObject);
begin
  if Assigned(Collection) then
    TAdvChartView((Collection as TChartPanes).Owner).Invalidate;
end;

procedure TChartPane.DoGetCountChartType(Sender: TObject;
  AChartType: TChartType; var ACount: Integer);
begin
  if Assigned(ChartView.OnGetCountChartType) then
    ChartView.OnGetCountChartType(Sender, AChartTYpe, ACount);
end;

procedure TChartPane.DoGetCountGroupedChartType(Sender: TObject;
  AChartType: TChartType; var ACountGrouped: Integer);
begin
  if Assigned(ChartView.OnGetCountGroupedChartType) then
    ChartView.OnGetCountGroupedChartType(Sender, AChartTYpe, ACountGrouped);
end;

procedure TChartPane.DoGetGridPieLineValue(Sender: TObject; ASerie: TChartSerie;
  ALineIndex: Integer; AStartAngle, ASweepAngle: Double;
  var AGridPieLineValue: String);
begin
  if Assigned(ChartView.OnGetGridPieLineValue) then
    ChartView.OnGetGridPieLineValue(Sender, ASerie, ALineIndex, AStartAngle, ASweepAngle, AGridPieLineValue);
end;

procedure TChartPane.DoGetNumberOfPoints(Sender: TObject; Serie: Integer;
  var ANumberOfPoints: Integer);
begin
  ChartView.DoGetNumberOfPoints(Self, Index, Serie, ANumberOfPoints);
end;

procedure TChartPane.DoGetPaneRectangle(Chart: TAdvChart; var PaneRect: TRect);
begin
  PaneRect := GetPaneRectangle;
end;

procedure TChartPane.DoGetPoint(Sender: TObject; Serie, AIndex: Integer;
  var APoint: TChartPoint);
begin
  ChartView.DoGetPoint(Self, Index, Serie, AIndex, APoint);
end;

procedure TChartPane.DoScrolling(SynchedPane, CurrentPane: integer; synched: boolean);
var
  p: TChartPane;
begin
  if synched = false then
    SynchedPane := CurrentPane;

  p := TAdvChartView((Collection as TChartPanes).Owner).Panes[SynchedPane];
  if p.FLbc then
  begin
    p.FChart.Series.ForceInit(true);
    p.UpdateRange(p.FChart.Range.RangeFrom - p.Navigator.ScrollStep, p.FChart.Range.RangeTo - p.Navigator.ScrollStep);
    p.Chart.InitializeChart(p.ChartView.Canvas, p.FRect, 1, 1);
    TAdvChartView((Collection as TChartPanes).Owner).DoLeftScroll(Self, CurrentPane,-p.Navigator.ScrollStep,p.FChart.Range.RangeFrom,p.FChart.Range.RangeTo);
  end;

  if p.FRbc then
  begin
    p.FChart.Series.ForceInit(true);
    p.UpdateRange(p.FChart.Range.RangeFrom + p.Navigator.ScrollStep, p.FChart.Range.RangeTo + p.Navigator.ScrollStep);
    p.Chart.InitializeChart(p.ChartView.Canvas, p.FRect, 1, 1);
    TAdvChartView((Collection as TChartPanes).Owner).DoRightScroll(Self, CurrentPane,+p.Navigator.ScrollStep,p.FChart.Range.RangeFrom,p.FChart.Range.RangeTo);
  end;
end;

procedure TChartPane.DoSerieXAxisGroup(Sender: TObject; Pane, Serie,
  GroupIndex: Integer; Canvas: TCanvas; R: TRect; var DrawText: Boolean);
begin
  if Assigned(ChartView.OnSerieXAxisCustomGroup) then
    ChartView.OnSerieXAxisCustomGroup(Sender, Index, Serie, GroupIndex, Canvas, R, DrawText);
end;

procedure TChartPane.DoVertScale(oldy,newy: integer);
var
  K: integer;
  oldpixy,newpixy: double;
  mdelta: double;

begin
  ChartView.BeginUpdate;
  for K := 0 to Series.Count - 1 do
  begin
    with TCrackedChartSerie(Series.items[K]) do
    begin
      if (YScale > 1e-12) and (YScale < 1e12) then
      begin
        Series.ForceInit(true);
        AutoRange := arDisabled;
        Series.Mode := cmScaling;

        oldpixy := YToValue(oldy, FSeriesRect);
        newpixy := YToValue(newy, FSeriesRect);

        mdelta := (oldpixy - newpixy) * ChartView.YAxisZoomSensitivity;

        MinimumValue := MinimumValue - mdelta;
        MaximumValue := MaximumValue + mdelta;

        ChartView.DoYScaleZoom(Self, K, MinimumValue, MaximumValue, YScale);
        Chart.InitializeChart(ChartView.Canvas, FRect, 1, 1);
      end
      else
      begin
        oldpixy := YToValue(oldy, FSeriesRect);
        newpixy := YToValue(newy, FSeriesRect);
        mdelta := (oldpixy - newpixy) * YScale * ChartView.YAxisZoomSensitivity;

        MinimumValue := MinimumValue - mdelta;
        MaximumValue := MaximumValue + mdelta;
      end;
    end;
  end;
  ChartView.EndUpdate;
end;

procedure TChartPane.DoVertScroll(oldy,newy: integer);
var
  j: integer;
  oldpixy,newpixy: double;
  mdelta: double;
begin
  ChartView.BeginUpdate;
  for j := 0 to Series.Count - 1 do
  begin
    if TCrackedChartSerie(Series.Items[j]).AutoRange = arDisabled then
    begin
      Series.ForceInit(true);
      with TCrackedChartSerie(Series.Items[j]) do
      begin
        OffSet := Offset + oldy - newy;

        oldpixy := YToValue(oldy, FSeriesRect);
        newpixy := YToValue(newy, FSeriesRect);

        mdelta := (oldpixy - newpixy) / ChartView.YAxisZoomSensitivity;
        ChartView.DoVerticalScroll(Self, Index, mdelta, MinimumValue, MaximumValue);

        Series.Mode := cmVerticalScrolling;
        MinimumValue := MinimumValue + mdelta;
        MaximumValue := MaximumValue + mdelta;
      end;
    end;
  end;
  Chartview.EndUpdate;
end;

procedure TChartPane.DoZoomOut(SynchedPane, CurrentPane: integer;
  synched: boolean);
var
  xs: double;
  p: TChartPane;
begin
  if synched = false then
    SynchedPane := CurrentPane;

  p := (Collection as TChartPanes).FOwner.Panes[SynchedPane];
  xs := p.FChart.XScale;
  if (xs >= 1) then
  begin
    FPixelsMoved := Round(xs * Chartview.FXAxisZoomSensitivity);
    p.FChart.Series.ForceInit(true);
    p.UpdateRange(p.FChart.Range.RangeFrom - Round(FPixelsMoved / xs), p.FChart.Range.RangeTo + Round(FPixelsMoved / xs));
  end
  else
  begin
    p.FChart.Series.ForceInit(true);
    p.FChart.XScale := 1;
  end;
end;

procedure TChartPane.TimerScrollChanged(Sender: TObject);
var
  I: integer;
begin
  with TAdvChartView((Collection as TChartPanes).Owner) do
  begin
    if PanesSynched then
    begin
      for I := 0 to (Collection as TChartPanes).Count - 1 do
      begin
        DoScrolling(I, fcpi, true);
      end;
    end
    else
      DoScrolling(-1, fcpi, false);
  end;
end;

procedure TChartPane.TimerZoomOutChanged(Sender: TObject);
var
  I: integer;
begin
  with TAdvChartView((Collection as TChartPanes).Owner) do
  begin
    if PanesSynched then
    begin
      for I := 0 to (Collection as TChartPanes).Count - 1 do
      begin
        DoZoomOut(I, fcpi, true);
      end;
    end
    else
      DoZoomOut(-1, fcpi, false);
  end;
end;

procedure TChartPane.UpdateRange(newrf, newrt: integer);
var
  rf, rt: integer;
begin
  with Range do
  begin
    if (MaximumScrollRange = 0) and (MinimumScrollRange = 0) then
    begin
      RangeFrom := newrf;
      RangeTo := newrt;
    end
    else
    begin
      rf := newrf;
      rt := newrt;
      if (rf >= MinimumScrollRange) and (rf <= MaximumScrollRange) and (rt >= MinimumScrollRange) and (rt <= MaximumScrollRange) then
      begin
        RangeFrom := newrf;
        RangeTo := newrt;
      end;
    end;
  end;
end;

{ TAdvChartView }

{$IFDEF DELPHIXE2_LVL}

procedure TChartPopup.Assign(Source: TPersistent);
begin
  if Source is TChartPopup then
  begin
    FEnabled := (Source as TChartPopup).Enabled;
    FOptions := (Source as TChartPopup).Options;
    FActivateMode := (Source as TChartPopup).ActivateMode;
    FDragGrip := (Source as TChartPopup).DragGrip;
  end;
end;

constructor TChartPopup.Create;
begin
  FEnabled := False;
  FOptions := AllOptions;
  FActivateMode := amBoth;
  FDragGrip := True;
end;

procedure TAdvChartView.SetPopup(const Value: TChartPopup);
begin
  FPopup.Assign(Value);
end;

{$ENDIF}

procedure TAdvChartView.AnnotationClick(Sender: TObject; Pane, Serie,
  Annotation, Point: integer);
begin
  if Assigned(FOnAnnotationClick) then
    FOnAnnotationClick(Sender, Pane, Serie, Annotation, Point);
end;

procedure TAdvChartView.AnnotationMouseDown(Sender: TObject; Pane, Serie,
  Annotation, Point: integer);
begin
  if Assigned(FOnAnnotationMouseDown) then
    FOnAnnotationMouseDown(Sender, Pane, Serie, Annotation, Point);
end;

procedure TAdvChartView.AnnotationMouseUp(Sender: TObject; Pane, Serie,
  Annotation, Point: integer);
begin
  if Assigned(FOnAnnotationMouseUp) then
    FOnAnnotationMouseUp(Sender, Pane, Serie, Annotation, Point);
end;

procedure TAdvChartView.Assign(Source: TPersistent);
begin
  if Source is TAdvChartView then
  begin
    Color := (Source as TAdvChartView).Color;
    FPanes.Assign((Source as TAdvChartView).Panes);
    FDragAlphaBlendValue := (Source as TAdvChartView).DragAlphaBlendValue;
    FDragAlphaBlend := (Source as TAdvChartView).DragAlphaBlend;
    FZoomColor := (Source as TAdvChartview).ZoomColor;
    FZoomStyle := (Source as TAdvChartview).ZoomStyle;
    FPanesSynched := (Source as TAdvChartView).PanesSynched;
    FVerticalCrossHairSynched := (Source as TAdvChartView).VerticalCrossHairsSynched;
    FYAxisZoomSensitivity := (Source as TAdvChartView).YAxisZoomSensitivity;
    FXAxisZoomSensitivity := (Source as TAdvChartView).XAxisZoomSensitivity;
    FShowDesignHelper := (Source as TAdvChartView).ShowDesignHelper;
    FDesigntimeValues := (Source as TAdvChartView).DesigntimeValues;
    FEnableInteraction := (Source as TAdvChartView).EnableInteraction;
    {$IFDEF DELPHIXE2_LVL}
    FPopup.Assign((Source as TAdvChartView).Popup);
    {$ENDIF}
  end;
end;

procedure TAdvChartView.BeginUpdate;
var
  i: integer;
begin
  for i := 0 to Panes.Count - 1 do
  begin
    Panes[i].BeginUpdate;
  end;
end;

{$IFDEF DELPHIXE2_LVL}
procedure TAdvChartView.DoToolBarPopupActivate(Sender: TObject);
begin
  if Assigned(OnToolBarPopupActivate) then
    OnToolBarPopupActivate(Self);
end;

procedure TAdvChartView.DoToolBarPopupDeactivate(Sender: TObject);
begin
  if Assigned(OnToolBarPopupDeactivate) then
    OnToolBarPopupDeactivate(Self);
end;

procedure TAdvChartView.SeriesMarkerFillColorSelected(AColor: TColor);
begin
  if Assigned(FActiveSerie) then
    FActiveSerie.Marker.MarkerColor := AColor;
end;

procedure TAdvChartView.SeriesMarkerSizeSelected(ASize: Integer);
begin
  if Assigned(FActiveSerie) then
    FActiveSerie.Marker.MarkerSize := ASize;
end;

procedure TAdvChartView.SeriesFillColorSelected(AColor: TAdvChartGraphicsColor);
begin
  if Assigned(FActiveSerie) then
    FActiveSerie.Color := AColor;
end;

procedure TAdvChartView.SeriesUp;
begin
  BeginUpdate;
  if Assigned(FActiveSerie) then
  begin
    if FActiveSerie.Index > 0 then
      FActiveSerie.Index := FActiveSerie.Index - 1;
  end;
  EndUpdate;
end;

procedure TAdvChartView.SeriesDown;
begin
  BeginUpdate;
  if Assigned(FActiveSerie) then
  begin
    if FActiveSerie.Index < FActiveSerie.Chart.Series.Count - 1 then
      FActiveSerie.Index := FActiveSerie.Index + 1;
  end;
  EndUpdate;
end;

procedure TAdvChartView.SeriesSelected(AItemIndex: Integer);
begin
  if (FCpi >= 0) and (FCpi <= Panes.Count - 1) then
  begin
    if (AItemIndex >= 0) and (AItemIndex <= Panes[FCpi].Series.Count - 1) then
    begin
      FActiveSerie := Panes[FCpi].Series[AItemIndex];
      ActiveSeriesToPopup;
    end;
  end;
end;

procedure TAdvChartView.SeriesLineColorSelected(AColor: TAdvChartGraphicsColor);
begin
  if Assigned(FActiveSerie) then
    FActiveSerie.LineColor := AColor;
end;

procedure TAdvChartView.SeriesTypeSelected(AType: TAdvChartToolBarPopupSeriesType);
begin
  if Assigned(FActiveSerie) then
  begin
    case AType of
      tpstLine: FActiveSerie.ChartType := ctLine;
      tpstArea: FActiveSerie.ChartType := ctArea;
      tpstBar: FActiveSerie.ChartType := ctBar;
      tpstLineBar: FActiveSerie.ChartType := ctLineBar;
      tpstHistogram: FActiveSerie.ChartType := ctHistogram;
      tpstLineHistogram: FActiveSerie.ChartType := ctLineHistogram;
      tpstCandleStick: FActiveSerie.ChartType := ctCandleStick;
      tpstLineCandleStick: FActiveSerie.ChartType := ctLineCandleStick;
      tpstOHLC: FActiveSerie.ChartType := ctOHLC;
      tpstMarkers: FActiveSerie.ChartType := ctMarkers;
      tpstStackedBar: FActiveSerie.ChartType := ctStackedBar;
      tpstStackedArea: FActiveSerie.ChartType := ctStackedArea;
      tpstStackedPercArea: FActiveSerie.ChartType := ctStackedPercArea;
      tpstStackedPercBar: FActiveSerie.ChartType := ctStackedPercBar;
      tpstError: FActiveSerie.ChartType := ctError;
      tpstArrow: FActiveSerie.ChartType := ctArea;
      tpstScaledArrow: FActiveSerie.ChartType := ctScaledArrow;
      tpstBubble: FActiveSerie.ChartType := ctBubble;
      tpstScaledBubble: FActiveSerie.ChartType := ctScaledBubble;
      tpstPie: FActiveSerie.ChartType := ctPie;
      tpstHalfPie: FActiveSerie.ChartType := ctHalfPie;
      tpstDonut: FActiveSerie.ChartType := ctDonut;
      tpstHalfDonut: FActiveSerie.ChartType := ctHalfDonut;
      tpstBand: FActiveSerie.ChartType := ctBand;
      tpstSpider: FActiveSerie.ChartType := ctSpider;
      tpstHalfSpider: FActiveSerie.ChartType := ctHalfSpider;
      tpstVarRadiusPie: FActiveSerie.ChartType := ctVarRadiusPie;
      tpstVarRadiusHalfPie: FActiveSerie.ChartType := ctVarRadiusHalfPie;
      tpstVarRadiusDonut: FActiveSerie.ChartType := ctVarRadiusDonut;
      tpstVarRadiusHalfDonut: FActiveSerie.ChartType := ctVarRadiusHalfDonut;
      tpstSizedPie: FActiveSerie.ChartType := ctSizedPie;
      tpstSizedHalfPie: FActiveSerie.ChartType := ctSizedHalfPie;
      tpstSizedDonut: FActiveSerie.ChartType := ctSizedDonut;
      tpstSizedHalfDonut: FActiveSerie.ChartType := ctSizedHalfDonut;
      tpstDigitalLine: FActiveSerie.ChartType := ctDigitalLine;
      tpstXYDigitalLine: FActiveSerie.ChartType := ctXYDigitalLine;
      tpstBoxPlot: FActiveSerie.ChartType := ctBoxPlot;
      tpstRenko: FActiveSerie.ChartType := ctRenko;
      tpstXYLine: FActiveSerie.ChartType := ctXYLine;
      tpstXYMarkers: FActiveSerie.ChartType := ctXYMarkers;
      tpstGantt: FActiveSerie.ChartType := ctGantt;
      tpstFunnel: FActiveSerie.ChartType := ctFunnel;
    end;
  end;
end;

procedure TAdvChartView.SeriesLineStyleSelected(AStyle: TAdvChartToolBarPopupSeriesLineStyle);
begin
  if Assigned(FActiveSerie) then
  begin
    case AStyle of
      tpslsNone: FActiveSerie.PenStyle := psClear;
      tpslsSolid: FActiveSerie.PenStyle := psSolid;
      tpslsDot: FActiveSerie.PenStyle := psDot;
      tpslsDash: FActiveSerie.PenStyle := psDash;
      tpslsDashDot: FActiveSerie.PenStyle := psDashDot;
      tpslsDashDotDot: FActiveSerie.PenStyle := psDashDotDot;
    end;
  end;
end;

procedure TAdvChartView.SeriesLineWidthSelected(AWidth: Integer);
begin
  if Assigned(FActiveSerie) then
    FActiveSerie.LineWidth := AWidth;
end;

procedure TAdvChartView.SeriesMarkerTypeSelected(AType: TAdvChartToolBarPopupSeriesMarkerType);
begin
  if Assigned(FActiveSerie) then
  begin
    case AType of
      tpsmNone: FActiveSerie.Marker.MarkerType := mNone;
      tpsmEllipse: FActiveSerie.Marker.MarkerType := mCircle;
      tpsmTriangle: FActiveSerie.Marker.MarkerType := mTriangle;
      tpsmSquare: FActiveSerie.Marker.MarkerType := mSquare;
      tpsmDiamond: FActiveSerie.Marker.MarkerType := mDiamond;
    end;
  end;
end;

procedure TAdvChartView.SeriesLabelTypeSelected(AType: TAdvChartToolBarPopupSeriesLabelType);
begin
  if Assigned(FActiveSerie) then
  begin
    case AType of
      tpsltNone: FActiveSerie.ShowValue := False;
      tpsltNormal:
      begin
        FActiveSerie.ShowValue := True;
        FActiveSerie.ValueFormatType := vftNormal;
      end;
      tpsltFloat:
      begin
        FActiveSerie.ShowValue := True;
        FActiveSerie.ValueFormatType := vftFloat;
      end;
    end;
  end;
end;
{$ENDIF}

procedure TAdvChartView.Changed;
begin
  invalidate;
end;

function TAdvChartView.ChartPointToString(p: TChartPoint): String;
begin
  Result := floattostr(p.SingleValue);
  result := result + '";"';
  result := result + floattostr(p.SecondValue);
  result := result + '";"';
  result := result + floattostr(p.OpenValue);
  result := result + '";"';
  result := result + floattostr(p.LowValue);
  result := result + '";"';
  result := result + floattostr(p.HighValue);
  result := result + '";"';
  result := result + floattostr(p.CloseValue);
  result := result + '";"';
  result := result + booltostr(p.Defined);
  result := result + '";"';
  result := result + inttostr(p.PixelValue1);
  result := result + '";"';
  result := result + inttostr(p.PixelValue2);
  result := result + '";"';
  result := result + inttostr(p.Color);
  result := result + '";"';
  result := result + inttostr(p.ColorTo);
  result := result + '";"';
  result := result + FloatToStr(p.TimeStamp);
  result := result + '";"';
  result := result + IntToStr(Integer(p.ValueType));
  result := result + '";"';
  result := result + p.LegendValue;
  result := result + '";"';
  result := result + floattostr(p.SingleXValue);
  result := result + '";"';
  result := result + floattostr(p.MedValue);
  result := result + '";"';
end;

function TAdvChartView.CheckLeftButton(X, Y: integer): Boolean;
var
  dm: Boolean;
begin
  Result := false;
  with Panes[FCpi] do
  begin
    dm := Series.IsHorizontal;
    if dm then
    begin
        if (Y > FRect.Bottom - Navigator.BottomSize - YAxis.RightSize - Title.BottomSize - Margin.BottomMargin + 5)
          and (Y < FRect.Bottom - Navigator.BottomSize - Title.BottomSize - Margin.BottomMargin - YAxis.RightSize + 5 + Navigator.ScrollButtonsSize)
            and (X > FRect.Left + 5 + XAxis.BottomSize + Margin.LeftMargin)
              and (X < FRect.Left + 5 + Navigator.Scrollbuttonssize + XAxis.BottomSize + Margin.LeftMargin) then
              begin
                Result := true;
              end;
    end
    else
    begin
        if (Y > FRect.Bottom - Navigator.BottomSize - XAxis.BottomSize - Title.BottomSize - Margin.BottomMargin + 5)
          and (Y < FRect.Bottom - Navigator.BottomSize - Title.BottomSize - Margin.BottomMargin - XAxis.BottomSize + 5 + Navigator.ScrollButtonsSize)
            and (X > FRect.Left + 5 + YAxis.LeftSize + Margin.LeftMargin)
              and (X < FRect.Left + 5 + Navigator.Scrollbuttonssize + YAxis.LeftSize + Margin.LeftMargin) then
              begin
                Result := true;
              end;
    end;
  end;
end;

function TAdvChartView.CheckRightButton(X, Y: integer): Boolean;
var
  dm: Boolean;
begin
  Result := false;
  with Panes[FCpi] do
  begin
    dm := Series.IsHorizontal;
    if dm then
    begin
      if (Y > FRect.Bottom - Navigator.BottomSize - Title.BottomSize - YAxis.RightSize - Margin.BottomMargin + 5)
        and (Y < FRect.Bottom - Navigator.BottomSize - YAxis.RightSize - Margin.BottomMargin + 5 + Navigator.ScrollButtonsSize)
          and (X > FRect.Right - Margin.RightMargin - 5 - Navigator.ScrollbuttonsSize - XAxis.TopSize)
            and (X < FRect.Right - Margin.RightMargin - 5 - XAxis.TopSize) then
            begin
              Result := true;
            end;
    end
    else
    begin
      if (Y > FRect.Bottom - Navigator.BottomSize - Title.BottomSize - XAxis.BottomSize - Margin.BottomMargin + 5)
        and (Y < FRect.Bottom - Navigator.BottomSize - XAxis.BottomSize - Margin.BottomMargin + 5 + Navigator.ScrollButtonsSize)
          and (X > FRect.Right - Margin.RightMargin - 5 - Navigator.ScrollbuttonsSize - YAxis.RightSize)
            and (X < FRect.Right - Margin.RightMargin - 5 - YAxis.RightSize) then
            begin
              Result := true;
            end;
    end;
  end;
end;

procedure TAdvChartView.ClearPaneSeries;
var
  i,j: integer;
begin
  for i := 0 to Panes.Count - 1 do
  begin
    for j := 0 to Panes[i].Series.Count - 1 do
      Panes[i].Series[j].ClearPoints;
  end;
end;

procedure TAdvChartView.Click;
begin
  inherited;
  if Panes.Count = 0 then
    Exit
  else
    IsYPosChartAnnotation(ScreenToClient(Mouse.CursorPos), cmsClick);
end;

{$IFDEF DELPHI2006_LVL}
procedure TAdvChartView.CMDesignHitTest(var Msg: TCMDesignHitTest);
var
  r: TRect;
  p: TPoint;
  nc: Integer;
begin
  inherited;
  if (csDesigning in ComponentState) and FShowDesignHelper then
  begin
    GetCursorPos(P);
    P := ScreenToClient(P);
    nc := MouseOverDesignChoice(P.X, P.Y);
    if nc <> FLastDesignChoice then
    begin
      r := ClientRect;
      r := Rect(r.Right - 150, r.Bottom - 70, r.Right, r.Bottom);
      InvalidateRect(Handle, @r, true);
    end;
    FLastDesignChoice := nc;
    if nc in [1, 2, 3] then
      Msg.Result := 1;
  end;
end;
{$ENDIF}

procedure TAdvChartView.CMHintShow(var Msg: TMessage);
var
  pt: TPoint;
  ct: TChartSeriePoint;
  P: Integer;
  str: String;
begin
  with TCMHintShow(Msg).HintInfo^ do
  begin
    pt := CursorPos;
    for P := 0 to Panes.Count - 1 do
    begin
      ct :=  XYToSeriePoint(pt.X, pt.Y, P);
      if (ct.Serie <> -1) and (ct.Point <> -1) then
      begin
        HintStr := Panes[P].Series[ct.Serie].Name + ' Point Value: ' + floattostr(Panes[P].Series[CT.Serie].GetPoint(ct.Point).SingleValue);
        str := HintStr;
        if Assigned(OnSerieIndexHint) then
          OnSerieIndexHint(Self, P, ct.Serie, ct.Point, HintStr);
      end;
    end;
    ReshowTimeout := 0;
  end;
end;

procedure TAdvChartView.CMMouseLeave(var Msg: TMessage);
var
  i: integer;
begin
  inherited;
  for I := 0 to Panes.Count - 1 do
    Panes[I].DrawLines := false;
  SetScreenCursor(crDefault);
end;

procedure TAdvChartView.CMWantSpecialKey(var Msg: TCMWantSpecialKey);
begin
  inherited;
  if msg.CharCode in [VK_UP,VK_DOWN,VK_LEFT,VK_RIGHT] then
    Msg.Result := 1;
end;

constructor TAdvChartView.Create(Aowner: TComponent);
var
  VerInfo: TOSVersioninfo;
begin
  FConstructed := false;
  inherited;

  FDesignTime := (csDesigning in ComponentState) and not
      ((csReading in Owner.ComponentState) or (csLoading in Owner.ComponentState));


  FClickCursor := crDefault;
  FLastDesignChoice := -1;
  FTracker := TChartTracker.Create(Self);
  FTracker.OnChange := TrackerChanged;

  {$IFDEF DELPHIXE2_LVL}
  FPopup := TChartPopup.Create;
  {$ENDIF}

  FPanes := CreatePanes;
  FPanes.OnChange := PanesChanged;

  DoubleBuffered := true;
  ZoomColor := clNone;
  FDragAlphaBlendValue := 255;
  FDragAlphaBlend := false;
  FDragForm := nil;
  FZoomForm := nil;
  FPanesSynched := false;
  FVerticalCrossHairSynched := false;
  FYAxisZoomSensitivity := 1;
  FXAxisZoomSensitivity := 1;
  Width := 400;
  Height := 300;
  FVersion := GetVersionString;
  FShowDesignHelper := True;
  FDesigntimeValues := True;

  ControlStyle := ControlStyle + [csAcceptsControls];

  FEnableInteraction := True;

  VerInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  GetVersionEx(verinfo);

  FIsWinXP := (verinfo.dwMajorVersion > 5) OR
    ((verinfo.dwMajorVersion = 5) AND (verinfo.dwMinorVersion >= 1));
end;

function TAdvChartView.CreateMetaFile(Width, Height: integer): TMetaFile;
var
  I, th, P: Integer;
  r: TRect;
  mfc: TMetafileCanvas;
begin
  result := TMetafile.Create;
  result.Width := Width;
  result.Height := Height;
  mfc := TMetafileCanvas.Create(result, 0);
  result.Width := Width;
  result.Height := Height;

  for I := 0 to Panes.Count - 1 do
  begin
    th := 0;
    for P := 0 to I - 1 do
    begin
      if Panes[P].Visible then
        th := th + Round(Panes[P].PixelHeight * (result.Height / self.Height));
    end;
    if Panes[I].Visible then
    begin
      r := Bounds(Panes[I].Rectangle.Left, th, Width, Round(Panes[I].PixelHeight * (result.Height / self.Height)));
      PP(I, mfc, r, false);
    end;
  end;
  mfc.Free;
end;

function TAdvChartView.CreateMeta(Width, Height: integer): TMetaFile;
begin
  Result := CreateMetaFile(Width, Height);
end;

function TAdvChartView.CreateMeta(Pane, Width, Height: integer): TMetaFile;
begin
  Result := CreateMetaFile(Pane, Width, Height);
end;

function TAdvChartView.CreateMetaFile(Pane, Width, Height: integer): TMetaFile;
var
  mfc: TMetafileCanvas;
begin
  result := TMetafile.Create;
  result.Width := Width;
  Result.Height := Height;
  mfc := TMetafileCanvas.Create(result, 0);
  result.Width := Width;
  result.Height := Height;
  PP(Pane, mfc, rect(0, 0, Width, Height), false);
  mfc.Free;
end;

function TAdvChartView.CreatePanes: TChartPanes;
begin
  Result := TChartPanes.Create(Self);
end;

procedure TAdvChartView.InitSample;
begin
  BeginUpdate;
  Panes.Clear;
  with Panes.Add do
  begin
    InitSample;
  end;
  EndUpdate;
end;

procedure TAdvChartView.CreateWnd;
var
  TrackerRect: Trect;
  I: Integer;
  K: Integer;
begin
  inherited;

  if FDesignTime and not FConstructed then
    InitSample;

  if (csDesigning in ComponentState) and not
      ((csReading in Owner.ComponentState) or (csLoading in Owner.ComponentState)) then
  begin
    for I := 0 to Panes.Count - 1 do
    begin
      for K := 0 to Panes[I].Series.Count - 1 do
      begin
        Panes[I].Series[K].ClearPoints;
        Panes[I].Series[K].AddSingleXYPoint(0.5, Random(10) + 1);
        Panes[I].Series[K].AddSingleXYPoint(1.5, Random(10) + 1);
        Panes[I].Series[K].AddSingleXYPoint(1.8, Random(10) + 1);
        Panes[I].Series[K].AddSingleXYPoint(2.8, Random(10) + 1);
        Panes[I].Series[K].AddSingleXYPoint(3.4, Random(10) + 1);
        Panes[I].Series[K].AddSingleXYPoint(4.8, Random(10) + 1);
      end;
    end;
  end;


  if not (csDesigning in ComponentState) then
  begin
    with Tracker do
    begin
      FTrackerForm := TTrackerForm.CreateNew(self);
      FTrackerForm.DoubleBuffered := true;
      FTrackerForm.FormStyle := fsStayOnTop;
      FTrackerForm.OnCloseQuery := OnTrackerClose;
      FTrackerForm.OnMove := TrackerMoved;

      FTracker.BeginUpdate;

      FTrackerForm.FTrackerList := TTrackerList.Create(Tracker.FTrackerForm);
      FTrackerForm.FTrackerList.Align := alClient;
      FTrackerForm.FTrackerList.Parent := Tracker.FTrackerForm;
      FTrackerForm.FTrackerList.Visible := true;
      FTrackerForm.FTrackerList.Color := Tracker.Color;
      FTrackerForm.FTrackerList.ColorTo := Tracker.ColorTo;
      FTrackerForm.FTrackerList.Font.Assign(Tracker.Font);
      FTrackerForm.FTrackerList.TitleFont.Assign(Tracker.Title.Font);

      {
      pb := TPaintBox.Create(Tracker.FTrackerForm);
      pb.Align := alClient;
      pb.Parent := Tracker.FTrackerForm;
      }
      FTrackerForm.AlphaBlend := Tracker.AlphaBlend;
      FTrackerForm.AlphaBlendValue := Tracker.AlphaBlendValue;
      FTrackerForm.BorderStyle := Tracker.BorderStyle;

      if AutoSize then
      begin
        Tracker.DoAutoSize;
        //SetTrackerFormSize(pb.Canvas);
      end
      else
      begin
        TrackerRect := Bounds(Tracker.Left , Tracker.Top, Width, Height);
        FTrackerForm.SetBounds(TrackerRect.Left, TrackerRect.Top, Width, Height);
      end;
      Tracker.SetValues;
      if Tracker.Visible then
        Tracker.FTrackerForm.Show;

      FTracker.EndUpdate;
    end;
  end;
  FConstructed := true;
end;

destructor TAdvChartView.Destroy;
begin
  {$IFDEF DELPHIXE2_LVL}
  if Assigned(FToolBarPopup) then
    FToolBarPopup.Free;
  FPopup.Free;
  {$ENDIF}
  FPanes.Free;
  FTracker.Free;
  inherited;
end;

procedure TChartPane.DoAfterDrawSeries(Sender: TObject; ARect: TRect;
  ACanvas: TCanvas);
begin
  if Assigned(ChartView.OnAfterDrawSeries) then
    ChartView.OnAfterDrawSeries(Sender, ARect, ACanvas, index);
end;

procedure TChartPane.DoBeforeDrawSeries(Sender: TObject; ARect: TRect;
  ACanvas: TCanvas);
begin
  if Assigned(ChartView.OnBeforeDrawSeries) then
    ChartView.OnBeforeDrawSeries(Sender, ARect, ACanvas, index);
end;

procedure TChartPane.DoDrawGridPieLineValue(Sender: TObject;
  ASerie: TChartSerie; ACanvas: TCanvas;  ALineIndex: Integer; AStartAngle, ASweepAngle: Double; ACenter: TPoint; AX, AY: Integer);
begin
  if Assigned(ChartView.OnDrawGridPieLineValue) then
    ChartView.OnDrawGridPieLineValue(Self, ASerie, ACanvas, ALineIndex, AStartAngle, ASweepAngle, ACenter, AX, AY);
end;

procedure TAdvChartView.DoEnter;
begin
  inherited;

  if Panes.Count > 0 then
  begin
    if FFocusedPane = -1 then
      FFocusedPane := 0;
    if FFocusedPane > Panes.Count - 1 then
      FFocusedPane := Panes.Count - 1;

    Panes[FFocusedPane].FFocused := true;
    PaneSelected(Panes[FFocusedPane], FFocusedPane);
    Invalidate;
  end;
end;

procedure TAdvChartView.DoExit;
var
  i: integer;
begin
  inherited;

  for i := 0 to Panes.Count - 1 do
   Panes[i].FFocused := false;

  Invalidate;
end;

procedure TAdvChartView.DoGetNumberOfPoints(Sender: TObject; Pane, Serie: Integer;
  var ANumberOfPoints: Integer);
begin
  if Assigned(OnGetNumberOfPoints) then
  begin
    if (Pane >= 0) and (Pane <= Panes.Count - 1) then
      if (Serie >= 0) and (Serie <= Panes[Pane].Series.Count - 1) then
        Panes[Pane].Series[Serie].ClearPoints;

    OnGetNumberOfPoints(Self, Pane, Serie, ANumberOfPoints);
  end;
end;

procedure TAdvChartView.DoGetPoint(Sender: TObject; Pane, Serie, AIndex: Integer;
  var APoint: TChartPoint);
begin
  if Assigned(OnGetPoint) then
    OnGetPoint(Self, Pane, Serie, AIndex, APoint);
end;

procedure TAdvChartView.DoHorizontalScroll(Sender: TObject; Pane, Delta,
  RangeFrom, RangeTo: integer);
begin
  if Assigned(FOnHorizontalScroll) then
    FOnHorizontalScroll(Sender, Pane, Delta, RangeFrom, RangeTo);
end;

procedure TAdvChartView.DoLeftScroll(Sender: TObject; Pane, Delta, RangeFrom, RangeTo: integer);
begin
  if Assigned(FOnLeftScroll) then
    FOnLeftScroll(Self, Pane, Delta, RangeFrom, RangeTo);
end;

procedure TAdvChartView.DoRightScroll(Sender: TObject; Pane, Delta, RangeFrom, RangeTo: integer);
begin
  if Assigned(FOnRightScroll) then
    FOnRightScroll(Self, Pane, Delta, RangeFrom, RangeTo);
end;

procedure TAdvChartView.DoVerticalScroll(Sender: TObject; Pane: integer; Delta, min, max: Double);
begin
  if Assigned(FOnVerticalScroll) then
    FOnVerticalScroll(Sender, Pane, Delta, min, max);
end;

procedure TAdvChartView.DoXScaleZoom(Sender: TObject; Pane: integer;
  XScale: Double);
begin
  if Assigned(FOnXScaleZoom) then
    FOnXScaleZoom(Self, Pane, XScale);
end;

procedure TAdvChartView.DoYScaleZoom(Sender: TObject; Pane: integer; SerieMin, SerieMax,
  YScale: Double);
begin
  if Assigned(FOnYScaleZoom) then
    FOnYScaleZoom(Self, Pane, SerieMin, SerieMax, YScale);
end;

procedure TAdvChartView.EndUpdate;
var
  i, fp: integer;
  r: TRect;
begin
  InitPaneRects;


  fp := 0;
  if NonVisual then
    r := Bounds(0, 0, Width, Height)
  else
    r := ClientRect;

  //

  for i := 0 to Panes.Count - 1 do
  begin
    with Panes[I] do
    begin
      if Visible then
      begin
        if FSplitter.Visible then
        begin
          if I <> fp then
          begin
            FSplitter.Draw(Canvas, r);
            r.Top := r.Top + FSplitter.FHeight;
          end;
        end;

        r.Bottom := r.Top + PixelHeight;
        Series.ForceInit(true);
      end
      else
      begin
        inc(fp);
      end;
      EndUpdate(Canvas, r);
      r.Top := r.Bottom;
    end;
  end;



  if Tracker.Visible then
    Tracker.DoAutoSize;

  Invalidate;
end;

function TAdvChartView.GetPaneClass: TChartPaneClass;
begin
  Result := TChartPane;
end;

function TAdvChartView.GetPanesClass: TChartPanesClass;
begin
  Result := TChartPanes;
end;

function TAdvChartView.GetSeriesClass: TChartSeriesClass;
begin
  Result := TChartSeries;
end;

function TAdvChartView.GetSerieClass: TChartSerieClass;
begin
  Result := TChartSerie;
end;

function TAdvChartView.GenerateBitmap(Width, Height: Integer): Graphics.TBitmap;
var
  I, th, P: Integer;
  r: TRect;
begin
  Result := Graphics.TBitmap.Create;
  Result.Width := Width;
  Result.Height := Height;
  for I := 0 to Panes.Count - 1 do
  begin
    th := 0;
    for P := 0 to I - 1 do
    begin
      if Panes[P].Visible then
        th := th + Round(Panes[P].PixelHeight * (Result.Height / self.Height));
    end;
    if Panes[I].Visible then
    begin
      r := Bounds(Panes[I].Rectangle.Left, th, Width, Round(Panes[I].PixelHeight * (Result.Height / self.Height)));
      PP(I, Result.Canvas, r, false);
    end;
  end;
end;

function TAdvChartView.GetCanvas: TCanvas;
begin
  Result := Self.Canvas;
end;

function TAdvChartView.GetFocusedPane: integer;
begin
  if Focused then
    Result := FFocusedPane
  else
    Result := -1;
end;

function TAdvChartView.GetPaneByID(id: integer): TChartPane;
begin
  Result := TChartPane(Panes.FindItemID(id));
end;

function TAdvChartView.GetPaneByName(name: string): TChartPane;
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

function TAdvChartView.GetPrintScale(Canvas: TCanvas): Double;
var
  nLogPixelsY_output, nLogPixelsY_screen: integer;
begin
  nLogPixelsY_output := GetDeviceCaps(Canvas.Handle,LOGPIXELSY);
  nLogPixelsY_screen := GetDeviceCaps(GetCanvas.Handle,LOGPIXELSY);
  result := nLogPixelsY_output / nLogPixelsY_screen;
end;

function TAdvChartView.GetSerieByName(name: string): TChartSerie;
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

function TAdvChartView.GetVersion: string;
begin
  Result := FVersion;
end;

function TAdvChartView.GetVersionNr: Integer;
begin
  Result := MakeLong(MakeWord(BLD_VER, REL_VER), MakeWord(MIN_VER, MAJ_VER));
end;

function TAdvChartView.GetVersionString: string;
var
  vn: Integer;
begin
  vn := GetVersionNr;
  Result := IntToStr(Hi(Hiword(vn))) + '.' + IntToStr(Lo(Hiword(vn))) + '.' + IntToStr(Hi(Loword(vn))) + '.' + IntToStr(Lo(Loword(vn)));
end;

procedure TAdvChartView.KeyDown(var Key: Word; Shift: TShiftState);
var
  K: integer;
  mid: integer;
begin
  inherited;
  case Key of
  VK_TAB:
    begin
      if (ssShift in Shift) then
      begin
        if (FFocusedPane > 0) and (FFocusedPane < Panes.Count) then
        begin
          Panes[FFocusedPane].FFocused := false;
          dec(FFocusedPane);
          Panes[FFocusedPane].FFocused := true;
          Invalidate;
        end
        else
        begin
          PostMessage(GetParentForm(Self).Handle,WM_NEXTDLGCTL,integer(true),integer(false));
        end;
      end
      else
      begin
        if (FFocusedPane >= 0) and (FFocusedPane < Panes.Count - 1) then
        begin
          Panes[FFocusedPane].FFocused := false;
          inc(FFocusedPane);
          Panes[FFocusedPane].FFocused := true;
          Invalidate;
        end
        else
        begin
          PostMessage(GetParentForm(Self).Handle,WM_NEXTDLGCTL,integer(false),integer(false));
        end;
      end;
    end;
    VK_LEFT:
    begin
      if (ssShift in Shift) then
      begin
        if FPanesSynched then
        begin
          for K := 0 to Panes.Count - 1 do
          begin
            if (poHorzScale in Panes[K].Options) then
            begin
              Panes[K].FNormalZoom := true;
              Panes[Fcpi].SynchNormalZoom(2, 0, K, Fcpi);
            end;
          end;
        end
        else
        begin
          if (poHorzScale in Panes[Fcpi].Options) then
          begin
            Panes[FFocusedPane].FNormalZoom := true;
            Panes[FFocusedPane].SynchNormalZoom(2, 0, -1, FFocusedPane);
          end;
        end;
      end
      else
      begin
        if FPanesSynched then
        begin
          for K := 0 to Panes.Count - 1 do
          begin
            if (poHorzScroll in Panes[K].Options) then
            begin
              Panes[K].FLbc := true;
              Panes[K].FRbc := false;
              Panes[K].DoScrolling(K, K, false);
            end;
          end;
        end
        else
        begin
          if (poHorzScroll in Panes[Fcpi].Options) then
          begin
            Panes[FFocusedPane].FLbc := true;
            Panes[FFocusedPane].FRbc := false;
            Panes[FFocusedPane].DoScrolling(FFocusedPane, FFocusedPane, true);
          end;
        end;
      end;
    end;
    VK_RIGHT:
    begin
      if ssShift in Shift then
      begin
        if FPanesSynched then
        begin
          for K := 0 to Panes.Count - 1 do
          begin
            if (poHorzScale in Panes[K].Options) then
            begin
              Panes[K].FNormalZoom := true;
              Panes[Fcpi].SynchNormalZoom(0, 2, K, Fcpi);
            end;
          end;
        end
        else
        begin
          if (FFocusedPane >= 0) and (poHorzScale in Panes[FFocusedPane].Options) then
          begin
            Panes[FFocusedPane].FNormalZoom := true;
            Panes[FFocusedPane].SynchNormalZoom(0, 2, -1, FFocusedPane);
          end;
        end;
      end
      else
      begin
        if FPanesSynched then
        begin
          for K := 0 to Panes.Count - 1 do
          begin
            if (poHorzScroll in Panes[K].Options) then
            begin
              Panes[K].FLbc := false;
              Panes[K].FRbc := true;
              Panes[FCpi].DoScrolling(K, K, false);
            end;
          end;
        end
        else
        begin
          if (FFocusedPane >= 0) and (poHorzScroll in Panes[FFocusedPane].Options) then
          begin
            Panes[FFocusedPane].FLbc := false;
            Panes[FFocusedPane].FRbc := true;
            Panes[FFocusedPane].DoScrolling(FFocusedPane, FFocusedPane, true);
          end;
        end;
      end;
    end;
    VK_UP:
    begin
      mid := Panes[FFocusedPane].FSeriesRect.Top + (Panes[FFocusedPane].FSeriesRect.Bottom - Panes[FFocusedPane].FSeriesRect.Top) div 2;
      if not (ssShift in Shift) then
        Panes[FFocusedPane].DoVertScroll(mid, mid + (Panes[FFocusedPane].PixelHeight div 10))
      else
        Panes[FFocusedPane].DoVertScale(mid, mid + (Panes[FFocusedPane].PixelHeight div 10));
    end;
    VK_DOWN:
    begin
      mid := Panes[FFocusedPane].FSeriesRect.Top + (Panes[FFocusedPane].FSeriesRect.Bottom - Panes[FFocusedPane].FSeriesRect.Top) div 2;
      if not (ssShift in Shift) then
        Panes[FFocusedPane].DoVertScroll(mid, mid - (Panes[FFocusedPane].PixelHeight div 10))
      else
        Panes[FFocusedPane].DoVertScale(mid, mid - (Panes[FFocusedPane].PixelHeight div 10));
    end;
  end;
end;

procedure TAdvChartView.LoadData;
begin
  //
end;

procedure TAdvChartView.LoadFromCSV(FileName: String; CreateChart: Boolean = false);
var
  sl, slint: TStringList;
  I, K, J, pti: Integer;
  p: TChartPane;
  s: TChartSerie;
  pt: string;
begin
  BeginUpdate;
  sl := TStringList.Create;
  sl.LoadFromFile(FileName);
  slint := TStringList.Create;

  if CreateChart then
    Panes.Clear;

  K := -1;
  J := -1;
  p := nil;
  s := nil;
  for I := 0 to sl.Count - 1 do
  begin
    Split(';', sl[I], slint);

    if K <> StrToInt(slint[0]) then
    begin
      Inc(K);
      p := nil;
    end;

    if p = nil then
    begin
      if CreateChart then
        p := Panes.Add
      else
      begin
        if K <= Panes.Count -1 then
          p := Panes[K];
      end;
    end;

    if Assigned(p) then
    begin
      if J <> StrToInt(slint[1]) then
      begin
        Inc(J);
        s := nil;
      end;

      if (s = nil) then
      begin
        if CreateChart then
          s := p.Series.Add
        else
        begin
          if J <= p.Series.Count - 1 then
            s := p.Series[J];
        end;
        if Assigned(s) then
          s.ClearPoints;
      end;
    end;

    if Assigned(s) then
    begin
      pt := '';
      for pti := 2 to slint.Count - 1 do
      begin
        if pti > 2 then
          pt := pt +'";"'+ slint[pti]
        else
          pt := '"' + slint[pti];
      end;

      pt := pt + '"';

      s.AddChartPoint(StringToChartPoint(pt));
    end;
  end;

  sl.Free;
  slint.Free;
  EndUpdate;
end;

procedure TAdvChartView.LoadFromFile(Filename: String; AutoCreatePanes: Boolean = False; AutoCreateSeries: Boolean = False);
var
  I: Integer;
  ini: TMemIniFile;
  str: String;
  A: TStringList;
  aPaneCount: Integer;
begin
  BeginUpdate;
  ini := TMemIniFile.Create(Filename);
  Align := TAlign(ini.ReadInteger(name,'Align',Integer(Align)));

  str := ini.ReadString(name, 'Anchors', '');
  A := TStringList.Create;
  Split(':',str, A);
  for I := 1 to A.Count - 1 do
  begin
    Anchors := Anchors + [TAnchorKind(strtoint(A[I]))];
  end;
  A.Free;

  Color := ini.ReadInteger(name,'Color',Color);
  //TODO : constraints
//  Constraints := TSizeConstraints(ini.ReadInteger(name,'Constraints', Integer(Constraints)));
  DragAlphaBlend := ini.ReadBool(name,'DragAlphaBlend',DragAlphaBlend);
  DragAlphaBlendValue := ini.ReadInteger(name, 'DragAlphaBlendValue',DragAlphaBlendValue);
  Hint := ini.ReadString(name, 'Hint',Hint);
  PanesSynched  := ini.ReadBool(name, 'PanesSynched', PanesSynched);
  //TODO : popupmenu
  ShowHint := ini.ReadBool(name, 'ShowHint', ShowHint);
  TabOrder := TTaborder(ini.ReadInteger(name, 'TabOrder', TabOrder));
  TabStop := ini.ReadBool(name, 'TabStop', TabStop);
  VerticalCrossHairsSynched := ini.ReadBool(name, 'VerticalCrossHairsSynched', VerticalCrossHairsSynched);
  Visible := ini.ReadBool(name, 'Visible',Visible);
  XAxisZoomSensitivity := ini.ReadFloat(name, 'XAxisZoomSensitivity', XAxisZoomSensitivity);
  YAxisZoomSensitivity := ini.ReadFloat(name, 'YAxisZoomSensitivity', YAxisZoomSensitivity);
  ZoomColor := ini.ReadInteger(name, 'ZoomColor', ZoomColor);
  ZoomStyle := TBrushStyle(ini.ReadInteger(name, 'ZoomStyle', Integer(ZoomStyle)));

  EnableInteraction := ini.ReadBool(name, 'EnableInteraction', EnableInteraction);

  Tracker.LoadFromFile(ini, name + '.' + 'Tracker');

  if AutoCreatePanes then
  begin
    Panes.Free;  //Need to recreate the Panes collection, as TCollections FNextID is not reset when using .Clear.
    CreatePanes;
    aPaneCount := ini.ReadInteger(name, 'PaneCount', 0);
    for I := 0 to aPaneCount - 1 do
      Panes.Add;
  end;

  for I := 0 to Panes.Count - 1 do
    Panes[I].LoadFromFile(ini, name + '.Pane' + IntToStr(I), AutoCreateSeries);

  ini.UpdateFile;
  ini.Free;

  EndUpdate;

end;

function TAdvChartView.IsYPosChartAnnotation(MousePos: TPoint; MouseState: TChartMouseState): Boolean;
var
  I: integer;
  K: integer;
begin
  Result := false;
  with Panes[FFocusedPane] do
  begin
    for I := 0 to Series.Count - 1 do
    begin
      with Series[I] do
      begin
        for K := 0 to Annotations.Count - 1 do
        begin
          with Annotations[K] do
          begin
            if PtInRect(AnnotationRect, MousePos) then
            begin
              Result := true;
              case MouseState of
                cmsClick: AnnotationClick(Self, FFocusedPane, I, K, PointIndex);
                cmsMouseDown: AnnotationMouseDown(Self, FFocusedPane, I, K, PointIndex);
                cmsMouseUp: AnnotationMouseUp(Self, FFocusedPane, I, K, PointIndex);
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

function TAdvChartView.IsYPositionChartPoint(X, Y: integer; MouseDown: Boolean; Button: TMouseButton): Boolean;
var
  i, c: integer;
  v: Double;
  xm, ym: integer;
  dm: Boolean;
  xp: Integer;
  pi: integer;
  K: Integer;
begin
  Result := false;

  FFocusedPane := Max(0, Min(FFocusedPane, Panes.Count - 1));

  with Panes[FFocusedPane] do
  begin
    dm := Series.IsHorizontal;
    for I := 0 to Series.Count - 1 do
    begin
      with Series[I] do
      begin

        if (ChartType = ctXYLine) or (ChartType = ctXYDigitalLine) or (ChartType = ctXYMarkers) then
        begin
          if dm then
            c := GetXYPoint(Y, X)
          else
            c := GetXYPoint(X, Y);

          pi := c;
        end
        else
        begin
          if dm then
            xp := Y - Series.SeriesRectangle.Top -  Round(Chart.GetXScaleStart)
          else
            xp := X - Series.SeriesRectangle.Left - Round(Chart.GetXScaleStart);

          pi := Range.RangeFrom;
          if Chart.XScale > 0 then
            pi := Range.RangeFrom + Round(xp / Chart.XScale);

          if Range.RangeFrom > 0 then
            c := pi - Range.RangeFrom
          else
            c := pi;

          if ChartType = ctArea then
          begin
            for K := 0 to c do
            begin
              if not GetPoint(K).Defined then
              begin
                c := c - 1;
                pi := pi - 1;
              end;
            end;
          end;
        end;

        ym := 0;
        xm := 0;

        if (Length(DrawValuesDP) > 0) and (c >= 0) and (c <= Length(DrawValuesDP) - 1) then
        begin
          xm := DrawValuesDP[c].X;
          ym := DrawValuesDP[c].Y;

          case ChartType of
            ctStackedPercBar, ctStackedBar, ctLineHistogram, ctHistogram, ctLineBar, ctBar:
            begin
              if dm then
                ym := ym + GetBarWidth(1) div 2
              else
                xm := xm + GetBarWidth(1) div 2;
            end;
          end;
        end;

        if PtInRect(Bounds(xm - Marker.MarkerSize div 2, ym - Marker.MarkerSize div 2, Marker.MarkerSize, Marker.MarkerSize), Point(X, Y)) then
        begin
          Marker.SelectedIndex := pi;
          v := YtoValue(ym, FSeriesRect);

          if MouseDown then
            SerieMouseDown(Self, Button, FFocusedPane, I, pi ,v , xm, ym)
          else
            SerieMouseUp(Self, Button, FFocusedPane, I, pi , v, xm, ym);

          Chartview.BeginUpdate;

          Chart.Series.ForceInit(true);
          Chart.InitializeChart(Canvas, FRect, 1, 1);

          Chartview.EndUpdate;

          Result := true;
          Exit;
        end;
      end;
    end;
  end;
end;

procedure TAdvChartView.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  I: Integer;
  zfb: TRect;
  N: TChartNavigator;
  R: TRect;
begin
  inherited;

  if Panes.Count = 0 then
    Exit;


  IsYPositionChartPoint(X, Y, true, Button);
  IsYPosChartAnnotation(Point(X, Y), cmsMouseDown);

  FCx := X;
  FCy := Y;
  FMaximumY := Y;
  FMinimumY := Y;

  for I := 0 to Panes.Count - 1 do
  begin
    if not Panes[I].Visible then
      Continue;

    if (Y > Panes[I].FRect.Top - FSplitterHeight) and (Y < Panes[I].FRect.Bottom) then
    begin
      if Fmc = false then
      begin
        fcpi := I;
        Fmc := true;
      end;
    end;
    if Panes[fcpi].FOnNavigator = false then
    begin
      if (Y > Panes[I].FRect.Top - FSplitterHeight) and (Y < Panes[I].FRect.Top) then
      begin
        if Panes[I].Index <> 0 then
        begin
          FScy := Y;

          Fmpi := fcpi - 1;
          while (Panes[Fmpi].Visible = false) do
          begin
            Fmpi := Fmpi - 1;
          end;

          FSch := Panes[Fmpi].PixelHeight;
          FShc := Panes[fcpi].PixelHeight;
          Fch := true;
        end;
      end;
    end
    else
    begin
      Panes[Fcpi].FMouseDownOnNavigator := true;
      if ssCtrl in Shift then
      begin
        with Panes[Fcpi] do
        begin
          FTimerZoomOut.Enabled := true;
          FTimerZoomOut.Interval := 100;
        end;
      end;
    end;
  end;

  with Panes[Fcpi] do
  begin
    N := Navigator;

    if FMouseDownOnNavigator then
    begin
      FDragZoom := false;
      Frbc := false;
      Flbc:= false;
      if CheckLeftButton(X, Y) then
      begin
        //left button clicked
        N.LeftButtonState := cnbDown;
        Flbc := true;
        FTimerScroll.Enabled := true;
        FTimerScroll.Interval := 50;
        DoLeftScroll(Self, Fcpi,-N.ScrollStep,FChart.Range.RangeFrom,FChart.Range.RangeTo);
      end
      else
        FDragZoom := true;

      if CheckRightButton(X, Y) then
      begin
        //right button clicked
        N.RightButtonState := cnbDown;
        Frbc := true;
        FTimerScroll.Enabled := true;
        FTimerScroll.Interval := 50;
        DoRightScroll(Self, Fcpi,+N.ScrollStep,FChart.Range.RangeFrom,FChart.Range.RangeTo);
      end
      else
        FDragZoom := true;

      if (ssShift in Shift)  then
      begin
        if (FDragZoom) and (Frbc = false) and (Flbc = false) then
        begin
          zfb := Bounds(FSeriesRect.Left, FSeriesRect.Top, FSeriesRect.Right, FSeriesRect.Bottom);
          FZoomForm := TForm.Create(Application);
          FZoomForm.Position := poDesigned;
          FZoomForm.BorderStyle := bsNone;
          FZoomForm.AlphaBlend := Navigator.AlphaBlend ;
          FZoomForm.AlphaBlendValue := Navigator.AlphaBlendValue;
          FZoomForm.Color := FZoomColor;
          FZoomForm.Brush.Style := FZoomStyle;
          FZoomForm.BorderWidth := 2;
          FZoomForm.SetBounds(zfb.Left + Self.Parent.ClientOrigin.X + Self.Left + FCx , zfb.Top + Self.Parent.ClientOrigin.Y , zfb.Right, zfb.Bottom);
        end;
      end
      else
      begin
        FNormalZoom := true;
      end;
    end;
  end;

  R := Panes[Fcpi].Series.SeriesRectangle;
  if (Panes[FCpi].CtrlZooming <> czNone) and ((ssCtrl in Shift) or Panes[FCpi].ZoomingTouchMode) and (X > R.Left) and (X < R.Right) and (Y > R.Top) and (Y < R.bottom) and (Fcpi = FFocusedPane) then
  begin
    zfb := Bounds(R.Left, R.Top , R.Right, R.Bottom);
    FRegionForm := TForm.Create(Application);
    FRegionForm.Position := poDesigned;
    FRegionForm.BorderStyle := bsNone;
    FRegionForm.AlphaBlend := N.AlphaBlend;
    FRegionForm.AlphaBlendValue := N.AlphaBlendValue;
    FRegionForm.Color := FZoomColor;
    FRegionForm.Brush.Style := FZoomStyle;
    FRegionForm.SetBounds(zfb.Left + Self.Parent.ClientOrigin.X + Self.Left + FCx , zfb.Top + Self.Parent.ClientOrigin.Y + FCy, zfb.Right, zfb.Bottom);
  end;

  if FCh = false then
  begin
    FDragClickY := Y;
    FMdx := X;
    FMdy := Y;
    if PtInRect(Panes[FCpi].Series.SeriesRectangle, Point(X, Y)) then
      FMouseDownOnSerie := true
    else
      FMouseDownOnAxis := true;
  end
  else
    SetScreenCursor(crSizeNS);

  if TabStop and (FFocusedPane >= 0) and (FFocusedPane <= Panes.Count - 1) then
  begin
    Panes[FFocusedPane].FFocused := false;
    FFocusedPane := FCpi;
    Panes[FFocusedPane].FFocused := true;
    PaneSelected(Panes[FFocusedPane], FFocusedPane);
    Invalidate;
    SetFocus;
  end;
end;

procedure TAdvChartView.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  I, K, J, L, csb, csa, csbperc, csaperc, cnt: integer;
  sp: TSeriePoint;
  dfb: TRect;
  pv: integer;
  chx: Boolean;
  di: TImage;
  allow: boolean;
  cnewh, mnewh: integer;
  cpi: integer;
  cp: TChartPoint;
  rect: TRect;
  crosshairinpane,hasseriepoint: boolean;
  tot,ptot: double;
  P: Integer;
  pn: TChartPane;
  chk: Boolean;
  serieLegend: TChartSerie;
  seriepoint: TChartSeriePoint;
  pnh: Integer;
  xval: TXAxisRangeValue;
  yval: TYAxisRangeValue;
  seriepielegend: TChartSeriePoint;
begin
  inherited;

  if Panes.Count = 0 then
    Exit;

  FCpi := Max(0, Min(Fcpi, Panes.Count - 1));

  if (Panes[FCpi].CtrlZooming <> czNone) and ((ssCtrl in Shift) or Panes[FCpi].ZoomingTouchMode) then
  begin
    with Panes[FCpi] do
    begin
      rect := Panes[FCpi].Series.SeriesRectangle;
      if (Y > rect.Top) and (Y < rect.Bottom) and (X > rect.left) and (X < rect.Right) and (FCpi = FFocusedPane) then
      begin
        if Assigned(FRegionForm) then
        begin
          if (X < rect.Right) and (X > rect.Left) and (Y > rect.Top) and (Y < rect.Bottom) then
          begin
            if (Y - FCy) > 0 then
            begin
              FRegionForm.Height := Y - FCy;
              FMinimumY := Y;
              FRegionForm.Top := Self.ClientOrigin.Y + FCY;
            end
            else
            begin
              FMaximumY := Y;
              FRegionForm.Height := Abs(Y - FCy);
              FRegionForm.Top := Self.ClientOrigin.Y + Y;
            end;
            if (X - FCx) > 0 then
            begin
              FRegionForm.Width := X - FCx;
              FRegionForm.Left := Self.ClientOrigin.X + FCX;
            end
            else
            begin
              FRegionForm.Width := Abs(X - FCx);
              FRegionForm.Left := Self.ClientOrigin.X + X;
            end;
            FRegionForm.Show;
          end;
        end;
      end;
    end;
  end
  else
  begin
    if (Fcpi < Panes.Count) and (Panes[Fcpi].FOnNavigator = false) or (Panes[Fcpi].FMouseDownOnNavigator = false) then
    begin
      with Panes[FCpi] do
      begin
        if CheckLeftButton(X, Y) then
          Navigator.LeftButtonState := cnbHot
        else
          Navigator.LeftButtonState := cnbNormal;

        if CheckRightButton(X, Y) then
          Navigator.RightButtonState := cnbHot
        else
          Navigator.RightButtonState := cnbNormal;
      end;
      if not Fch then
      begin
        for I := 0 to Panes.Count - 1 do
        begin
          with Panes[I] do
          begin
            DrawLines := true;
            // crosshair handling
            K := 0;
            SetLength(FVerticalCrossHairPoints,K);

            if CrossHair.Visible then
            begin
              if Panes[I].Series.IsHorizontal then
              begin
                if FVerticalCrosshairSynched then
                  crosshairinpane := (Y > FSeriesRect.Top) and (Y < FSeriesRect.Bottom)
                else
                  crosshairinpane := (Y > FSeriesRect.Top) and (Y < FSeriesRect.Bottom) and (X > FRect.Left) and (X < FRect.Right);
              end
              else
              begin
                if FVerticalCrosshairSynched then
                  crosshairinpane := (X > FSeriesRect.Left) and (X < FSeriesRect.Right)
                else
                  crosshairinpane := (X > FSeriesRect.Left) and (X < FSeriesRect.Right) and (Y > FRect.Top) and (Y < FRect.Bottom);
              end;

              //cursor in chart area
              if crosshairinpane then
              begin
                cpi := FChart.Range.RangeFrom;
                if FChart.XScale > 0 then
                begin
                  if Panes[I].Series.IsHorizontal then
                    cpi := FChart.Range.RangeFrom + round((Y - FSeriesRect.Top - (Chart.GetXScaleStart)) / FChart.XScale)
                  else
                    cpi := FChart.Range.RangeFrom + round((X - FSeriesRect.Left - (Chart.GetXScaleStart)) / FChart.XScale);
                end;

                if CrossHair.CrossHairYValues.ShowSerieValues then
                begin
                  tot := 0;
                  for J := 0 to Series.Count - 1 do
                  begin
                    if (Series[j].ChartType = ctXYLine) or (Series[j].ChartType = ctXYDigitalLine) or (Series[j].ChartType = ctXYMarkers) then
                    begin
                      if Panes[i].Series.IsHorizontal then
                        cp := Series[J].GetChartPoint(Series[j].GetXYPoint(Y, X))
                      else
                        cp := Series[J].GetChartPoint(Series[j].GetXYPoint(X, Y));
                    end
                    else
                      cp := Series[J].GetChartPoint(cpi);

                    sp.SerieValue := cp.SingleValue;

                    hasseriepoint := cp.Defined;

                    if hasseriepoint then
                    begin
                      case Series[j].ChartType of
                      ctStackedBar, ctStackedArea:
                        begin
                          csb := 0;
                          csa := 0;
                          cnt := 0;

                          for L := 0 to Series.Count - 1 do
                          begin
                            with Series[L] do
                            begin
                              if ChartType in [ctStackedBar] then
                                Inc(csb);

                              if ChartType in [ctStackedArea] then
                                Inc(csa);
                            end;
                          end;

                          case Series[j].ChartType of
                            ctStackedBar: cnt := csb;
                            ctStackedArea: cnt := csa;
                          end;

                          if cnt > 1 then
                          begin
                            if Series[j].Logarithmic then
                              sp.YValue := Series[J].ValueToY(ConvertToLog(cp.SingleValue + tot), FSeriesRect)
                            else
                              sp.YValue := Series[J].ValueToY(cp.SingleValue + tot, FSeriesRect);

                            tot := tot + cp.SingleValue;
                            sp.SerieValue := tot;
                          end
                          else
                          begin
                            if Series[j].Logarithmic then
                              sp.YValue := Series[J].ValueToY(ConvertToLog(cp.SingleValue), FSeriesRect)
                            else
                              sp.YValue := Series[J].ValueToY(cp.SingleValue, FSeriesRect);
                          end;
                        end;
                      ctStackedPercBar, ctStackedPercArea:
                        begin
                          csbperc := 0;
                          csaperc := 0;
                          ptot := 0;
                          cnt := 0;

                          for L := 0 to Series.Count - 1 do
                          begin
                            ptot := ptot + Series[L].GetChartPoint(cpi).SingleValue;
                            with Series[L] do
                            begin
                              if ChartType in [ctStackedPercBar] then
                                Inc(csbperc);

                              if ChartType in [ctStackedPercArea] then
                                Inc(csaperc);
                            end;
                          end;

                          if ptot <> 0 then
                            ptot := cp.SingleValue / ptot * 100
                          else
                            ptot := 0;


                          case Series[j].ChartType of
                            ctStackedPercBar: cnt := csbperc;
                            ctStackedPercArea: cnt := csaperc;
                          end;

                          if cnt > 1 then
                          begin
                            if Series[j].Logarithmic then
                              sp.YValue := Series[J].ValueToY(ConvertToLog(ptot + tot), FSeriesRect)
                            else
                              sp.YValue := Series[J].ValueToY(ptot + tot, FSeriesRect);

                            sp.SerieValue := ptot + tot;
                            tot := tot + ptot;
                          end
                          else
                          begin
                            if Series[j].Logarithmic then
                            begin
                              sp.YValue := Series[J].ValueToY(ConvertToLog(Series[J].GetStackedPercValue(cp.SingleValue, cpi)), FSeriesRect);
                              sp.SerieValue := Series[J].GetStackedPercValue(cp.SingleValue, cpi);
                            end
                            else
                            begin
                              sp.YValue := Series[J].ValueToY(Series[J].GetStackedPercValue(cp.SingleValue, cpi), FSeriesRect);
                              sp.SerieValue := Series[J].GetStackedPercValue(cp.SingleValue, cpi);
                            end;
                          end;
                        end;
                      else
                      begin
                        if Series[j].Logarithmic then
                          sp.YValue := Series[J].ValueToY(ConvertToLog(cp.SingleValue), FSeriesRect)
                        else
                          sp.YValue := Series[J].ValueToY(cp.SingleValue, FSeriesRect);
                      end;
                      end;

                      sp.Serie := J;
                      sp.PointType := cspSerie;
                      sp.Point := cpi;

                      if Panes[I].Series.IsHorizontal then
                      begin
                        if (chAtCursor in CrossHair.CrossHairYValues.Position) then
                          sp.XValueAtCursor := Y + 2
                        else
                          sp.XValueAtCursor := -1;

                        if (chYAxis in CrossHair.CrossHairYValues.Position) then
                          sp.XValueYAxis := FSeriesRect.Bottom
                        else
                          sp.XValueYAxis := -1;
                      end
                      else
                      begin
                        if (chAtCursor in CrossHair.CrossHairYValues.Position) then
                          sp.XValueAtCursor := X + 2
                        else
                          sp.XValueAtCursor := -1;

                        if (chYAxis in CrossHair.CrossHairYValues.Position) then
                          sp.XValueYAxis := FSeriesRect.Right
                        else
                          sp.XValueYAxis := -1;
                      end;

                      sp.XValueAtTracker := tracker.Left;
                      SetLength(FVerticalCrossHairPoints, K + 1);
                      FVerticalCrossHairPoints[K] := sp;
                      inc(K);
                    end;
                  end;
                end;


                if Panes[I].Series.IsHorizontal then
                begin
                  if (CrossHair.CrossHairYValues.ShowYPosValue) and
                     (X > FRect.Left) and (X < FRect.Right) {and hasseriepoint} then
                  begin
                    sp.YValue := X;

                    sp.PointType := cspYPos;

                    if (chYAxis in CrossHair.CrossHairYValues.Position) then
                      sp.XValueYAxis := FSeriesRect.Bottom
                    else
                      sp.XValueYAxis := -1;


                    if (chAtCursor in CrossHair.CrossHairYValues.Position) then
                      sp.XValueAtCursor := Y + 2
                    else
                      sp.XValueAtCursor := -1;

                    sp.XValueAtTracker := Tracker.Left;
                    sp.Serie := YGrid.SerieIndex;
                    sp.PointType := cspYPos;
                    sp.Serie := GetVisibleSerieIndex;

                    SetLength(FVerticalCrossHairPoints, K + 1);
                    FVerticalCrossHairPoints[K] := sp;
                  end;
                end
                else
                begin
                  if (CrossHair.CrossHairYValues.ShowYPosValue) and
                     (Y > FRect.Top) and (Y < FRect.Bottom) {and hasseriepoint} then
                  begin
                    sp.YValue := Y;

                    sp.PointType := cspYPos;

                    if (chYAxis in CrossHair.CrossHairYValues.Position) then
                      sp.XValueYAxis := FSeriesRect.Right
                    else
                      sp.XValueYAxis := -1;


                    if (chAtCursor in CrossHair.CrossHairYValues.Position) then
                      sp.XValueAtCursor := X + 2
                    else
                      sp.XValueAtCursor := -1;

                    sp.XValueAtTracker := Tracker.Left;
                    sp.Serie := YGrid.SerieIndex;
                    sp.PointType := cspYPos;
                    sp.Serie := GetVisibleSerieIndex;

                    SetLength(FVerticalCrossHairPoints, K + 1);
                    FVerticalCrossHairPoints[K] := sp;
                  end;
                end;

                FVerticalCrossHairX := X;
                FVerticalCrossHairY := Y;
                Invalidate;
              end
              else
              begin
                FDrawLines := false;
                Invalidate;
              end;
            end;

            if FTracker.Visible then
            begin
              FTracker.SetValues;
            end;

            // splitter handling

            FOnNavigator := false;
            if (Y > FRect.Top - FSplitterHeight) and (Y < FRect.Bottom) then
            begin
              FCrpi := I;
            end;

            // navigator handling

            if (FMouseDownOnAxis = false) and (FMouseDownOnSerie = false) and (FMouseDownOnNavigator = false) then
            begin
              if Navigator.Visible then
              begin
                if (Y > FRect.Top + (PixelHeight - Navigator.Size - XAxis.BottomSize - Title.BottomSize - Margin.BottomMargin)) and (Y < FRect.Top + (PixelHeight - XAxis.BottomSize - Title.BottomSize - Margin.BottomMargin)) then
                  if (X > FSeriesRect.Left) and (X < FSeriesRect.Right) then
                    FOnNavigator := true
                  else
                    FOnNavigator := false;
              end;
            end;

            if (Y > FRect.Top - FSplitterHeight) and (Y < FRect.Bottom) then
            begin
              if FSplitter.FVisible = false then
                FSplitterHeight := 0
              else
                FSplitterHeight := FSplitter.FHeight;

              if FMc = false then
              begin
                if (Y > FRect.Top - FSplitterHeight) and (Y  < FRect.Top) then
                begin
                  if Index <> 0 then
                  begin
                    SetScreenCursor(crSizeNS);
                  end;
                end
                else
                begin
                  SetScreenCursor(crDefault);
                  FCh := false;
                end;
              end
              else
              begin
                if FMouseDownOnAxis or FMouseDownOnSerie then
                begin
                  if (Abs(X - FMdx) > 10) or (Abs(Y - FMdy) > 10) then
                  begin
                    if (ssShift in Shift) and (poMoving in Panes[Fcpi].Options) then
                    begin
                      SetScreenCursor(crDrag);
                      with Panes[Fcpi] do
                      begin
                        if (poMoving in Options) then
                        begin
                          if not Assigned(FDragForm) then
                          begin
                            //Build Form
                            FDragForm := nil;
                            dfb := Bounds(FSeriesRect.Left , FSeriesRect.Top , FSeriesRect.Right , FSeriesRect.Bottom);

                            FDragForm := TForm.Create(Application);
                            FDragForm.Position := poDesigned;
                            FDragForm.SetBounds(Self.Parent.ClientOrigin.X + Self.Left , dfb.Top + Self.Parent.ClientOrigin.Y + Self.Top , ClientWidth, PixelHeight);

                            FDragOldTop := FDragForm.Top;

                            with Panes[Fcpi] do
                            begin
                              FDragForm.BorderStyle := bsNone;
                              FDragForm.BorderWidth := 4;
                              FDragForm.Brush.Style := bsClear;
                              FDragForm.Brush.Color := clBlack;
                              FDragForm.AlphaBlend := FDragAlphaBlend;
                              FDragForm.AlphaBlendValue := FDragAlphaBlendValue;
                              {$IFDEF DELPHIXE6_LVL}
                              FDragForm.StyleElements := [];
                              {$ENDIF}
                              di := TImage.Create(FDragForm);
                              di.Width := FRect.Right;
                              di.Height := PixelHeight;
                              BitBlt(di.Canvas.Handle,0,0,FRect.Right, FRect.Bottom, Self.Canvas.Handle, FRect.Left, FRect.Top, SRCCopy);
                              di.Parent := FDragForm;
                            end;
                            FDragForm.Show;
                          end;
                          FDragDelta := (Y - FDragClickY);
                          FDragForm.SetBounds(FDragForm.Left, FDragDelta + FDragOldTop , FDragForm.Width, PixelHeight)
                        end;
                      end;
                    end
                    else
                    begin
                      pn := Panes[Fcpi];
                      if (poVertScale in pn.Options) and FMouseDownOnAxis then
                      begin
                        if pn.Series.IsHorizontal then
                        begin
                          if ((X > pn.FSeriesRect.Left) and (X < pn.FSeriesRect.Right) and (Y > pn.FRect.Top) and (Y < pn.FSeriesRect.Top)) or ((X > pn.FSeriesRect.Left)
                            and (X < pn.FSeriesRect.Right) and (Y < pn.FRect.Bottom) and (Y > pn.FSeriesRect.Bottom)) then
                          begin
                            pn.DoVertScale(Fcx, X);
                            FCx := X;
                          end
                        end
                        else
                        begin
                          if ((Y > pn.FSeriesRect.Top) and (Y < pn.FSeriesRect.Bottom) and (X > pn.FRect.Left) and (X < pn.FSeriesRect.Left)) or ((Y > pn.FSeriesRect.Top)
                            and (Y < pn.FSeriesRect.Bottom) and (X < pn.FRect.Right) and (X > pn.FSeriesRect.Right)) then
                          begin
                            pn.DoVertScale(Fcy, Y);
                            FCy := Y;
                          end
                        end;
                      end;

                      if (poVertScroll in pn.Options) and FMouseDownOnSerie then
                      begin
                        if pn.Series.IsHorizontal then
                        begin
                          if (X < pn.FSeriesRect.Right) and (X > pn.FSeriesRect.Left) and (Y > pn.FSeriesRect.Top) and (Y < pn.FSeriesRect.Bottom) then
                            pn.DoVertScroll(FCx, X);
                        end
                        else
                        begin
                          if (Y < pn.FSeriesRect.Bottom) and (Y > pn.FSeriesRect.Top) and (X > pn.FSeriesRect.Left) and (X < pn.FSeriesRect.Right) then
                            pn.DoVertScroll(FCy, Y);
                        end;
                      end;

                      if (poHorzScroll in pn.Options) and FMouseDownOnSerie then
                      begin
                        if pn.Series.IsHorizontal then
                          chk := (X > pn.FSeriesRect.Left) and (X < pn.FSeriesRect.Right) and (Y > pn.FSeriesRect.Top) and (Y < pn.FSeriesRect.Bottom)
                        else
                          chk := (Y > pn.FSeriesRect.Top) and (Y < pn.FSeriesRect.Bottom) and (X > pn.FSeriesRect.Left) and (X < pn.FSeriesRect.Right);

                        if chk then
                        begin
                          if pn.Series.IsHorizontal then
                            FPixelsMoved := Abs(FCY - Y)
                          else
                            FPixelsMoved := Abs(FCx - X);

                          if (FPixelsMoved > Round(pn.FChart.XScale)) then
                          begin
                            if not PanesSynched then
                            begin
                              if pn.Series.IsHorizontal then
                              begin
                                if Y < FCy then
                                begin
                                  pn.Series.Mode := cmHorizontalScrolling;
                                  pn.UpdateRange(pn.FChart.Range.RangeFrom + Round(FPixelsMoved / pn.FChart.XScale), pn.FChart.Range.RangeTo + Round(FPixelsMoved / pn.FChart.XScale));
                                  pn.Series.ForceInit(true);
                                  pn.Chart.InitializeChart(Canvas, pn.FRect, 1, 1);
                                end
                                else if y > FCy then
                                begin
                                  pn.Series.Mode := cmHorizontalScrolling;
                                  pn.UpdateRange(pn.FChart.Range.RangeFrom - Round(FPixelsMoved / pn.FChart.XScale), pn.FChart.Range.RangeTo - Round(FPixelsMoved / pn.FChart.XScale));
                                  pn.Series.ForceInit(true);
                                  pn.Chart.InitializeChart(Canvas, pn.FRect, 1, 1);
                                end;
                                DoHorizontalScroll(Self, Index, FPixelsMoved, pn.FChart.Range.RangeFrom, pn.FChart.Range.RangeTo);
                                FCy := y;
                              end
                              else
                              begin
                                if X < FCx then
                                begin
                                  pn.Series.Mode := cmHorizontalScrolling;
                                  pn.UpdateRange(pn.FChart.Range.RangeFrom + Round(FPixelsMoved / pn.FChart.XScale), pn.FChart.Range.RangeTo + Round(FPixelsMoved / pn.FChart.XScale));
                                  pn.Series.ForceInit(true);
                                  pn.Chart.InitializeChart(Canvas, pn.FRect, 1, 1);
                                end
                                else if X > FCx then
                                begin
                                  pn.Series.Mode := cmHorizontalScrolling;
                                  pn.UpdateRange(pn.FChart.Range.RangeFrom - Round(FPixelsMoved / pn.FChart.XScale), pn.FChart.Range.RangeTo - Round(FPixelsMoved / pn.FChart.XScale));
                                  pn.Series.ForceInit(true);
                                  pn.Chart.InitializeChart(Canvas, pn.FRect, 1, 1);
                                end;
                                DoHorizontalScroll(Self, Index, FPixelsMoved, pn.FChart.Range.RangeFrom, pn.FChart.Range.RangeTo);
                                FCx := X;
                              end;
                            end
                            else
                            begin
                              for K := 0 to Panes.Count - 1 do
                              begin
                                if Panes[K].Series.IsHorizontal then
                                begin
                                  if (y < FCy) then
                                  begin
                                    Panes[K].Series.Mode := cmHorizontalScrolling;
                                    if (Panes[K].FChart.XScale <> 0) then
                                      Panes[K].UpdateRange(Panes[K].FChart.Range.RangeFrom + Round(FPixelsMoved / Panes[K].FChart.XScale), Panes[K].FChart.Range.RangeTo + Round(FPixelsMoved / Panes[K].FChart.XScale));
                                    Panes[K].Series.ForceInit(true);
                                    Panes[K].Chart.InitializeChart(Canvas, Panes[K].FRect, 1, 1);
                                  end
                                  else if (y > FCy) then
                                  begin
                                    Panes[K].Series.Mode := cmHorizontalScrolling;
                                    if (Panes[K].FChart.XScale <> 0) then
                                      Panes[K].UpdateRange(Panes[K].FChart.Range.RangeFrom - Round(FPixelsMoved / Panes[K].FChart.XScale), Panes[K].FChart.Range.RangeTo - Round(FPixelsMoved / Panes[K].FChart.XScale));
                                    Panes[K].Series.ForceInit(true);
                                    Panes[K].Chart.InitializeChart(Canvas, Panes[K].FRect, 1, 1);
                                  end;
                                end
                                else
                                begin
                                  if (X < FCx) then
                                  begin
                                    Panes[K].Series.Mode := cmHorizontalScrolling;
                                    if (Panes[K].FChart.XScale <> 0) then
                                      Panes[K].UpdateRange(Panes[K].FChart.Range.RangeFrom + Round(FPixelsMoved / Panes[K].FChart.XScale), Panes[K].FChart.Range.RangeTo + Round(FPixelsMoved / Panes[K].FChart.XScale));
                                    Panes[K].Series.ForceInit(true);
                                    Panes[K].Chart.InitializeChart(Canvas, Panes[K].FRect, 1, 1);
                                  end
                                  else if (X > FCx) then
                                  begin
                                    Panes[K].Series.Mode := cmHorizontalScrolling;
                                    if (Panes[K].FChart.XScale <> 0) then
                                      Panes[K].UpdateRange(Panes[K].FChart.Range.RangeFrom - Round(FPixelsMoved / Panes[K].FChart.XScale), Panes[K].FChart.Range.RangeTo - Round(FPixelsMoved / Panes[K].FChart.XScale));
                                    Panes[K].Series.ForceInit(true);
                                    Panes[K].Chart.InitializeChart(Canvas, Panes[K].FRect, 1, 1);
                                  end;
                                end;

                                DoHorizontalScroll(Self, Index, FPixelsMoved, Panes[K].FChart.Range.RangeFrom, Panes[K].FChart.Range.RangeTo);
                              end;
                              FCx := X;
                            end;
                          end;
                        end;
                      end;

                      if pn.Series.IsHorizontal then
                        FCX := X
                      else
                        FCy := Y;

                      if (poHorzScale in pn.Options) and FMouseDownOnAxis then
                      begin
                        if pn.Series.IsHorizontal then
                        begin
                          chk := ((X > pn.FRect.Right - pn.YAxis.LeftSize) or (X < pn.FSeriesRect.Right) and (X > pn.FSeriesRect.Right)
                          and (X < pn.FRect.Right) and (Y > pn.FSeriesRect.Top) and (Y < pn.FSeriesRect.Bottom + pn.Navigator.BottomSize)) or ((X < pn.FRect.Left + pn.YAxis.LeftSize)
                            and (X > pn.FRect.Left) and (X < pn.FSeriesRect.Left) and (Y > pn.FSeriesRect.Top) and (Y < pn.FSeriesRect.Bottom))
                        end
                        else
                        begin
                          chk := ((Y > pn.FRect.Bottom - pn.XAxis.BottomSize) or (Y < pn.FSeriesRect.Bottom + pn.Navigator.BottomSize) and (Y > pn.FSeriesRect.Bottom)
                          and (Y < pn.FRect.Bottom) and (X > pn.FSeriesRect.Left) and (X < pn.FSeriesRect.Right)) or ((Y < pn.FRect.Top + pn.XAxis.TopSize)
                            and (Y > pn.FRect.Top) and (Y < pn.FSeriesRect.Top) and (X > pn.FSeriesRect.Left) and (X < pn.FSeriesRect.Right));
                        end;
                        if chk then
                        begin
                          if (pn.FChart.XAxis.Position <> xNone) and (pn.Fchart.XAxis.Size <> 0) then
                          begin
                            if FPanesSynched then
                            begin
                              for K := 0 to Panes.Count - 1 do
                              begin
                                Panes[K].FNormalZoom := true;
                                if Panes[K].Series.IsHorizontal then
                                  SynchNormalZoom(Y, FCY, K, Fcpi)
                                else
                                  SynchNormalZoom(X, FCx, K, Fcpi);
                              end;
                            end
                            else
                            begin
                              Panes[Fcpi].FNormalZoom := true;
                              if Panes[fcpi].Series.IsHorizontal then
                                SynchNormalZoom(Y, FCy, -1, Fcpi)
                              else
                                SynchNormalZoom(X, FCx, -1, Fcpi);
                            end;
                            if pn.Series.IsHorizontal then
                              FCy := Y
                            else
                              FCx := X;
                          end;
                        end;
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end
      else
      begin
        if FMc then
        begin
          with Panes[Fcpi] do
          begin
            FSplitterDelta := Y - FScy;
            Allow := true;

            if (FSch + FSplitterDelta >= 0) and (FShc - FSplitterDelta >= 0) then
            begin
              cnewh := fshc - FSplitterDelta;
              mnewh := Fsch + FSplitterDelta;

              PaneSized(Self, Fcpi, FMpi, cnewh, mnewh, allow);

              if allow then
              begin
                if Panes[Fmpi].HeightType = htPercentage then
                  Panes[Fmpi].Height := mnewh / self.Height * 100
                else
                  Panes[Fmpi].Height := mnewh;

                if Panes[FCpi].HeightType = htPercentage then
                  Panes[FCpi].Height := cnewh / self.Height * 100
                else
                  Panes[Fcpi].Height := cnewh;
              end;
            end
            else
            begin
              if (Fsch + FSplitterDelta < 0) then
              begin
                cnewh := Fsch + fshc;
                mnewh := 0;

                PaneSized(Self, Fcpi, Fmpi, cnewh, mnewh, allow);

                if Allow then
                begin
                  Panes[Fcpi].Height := cnewh;
                  Panes[Fmpi].Height := mnewh;
                end;
              end
              else
              begin
                if (fshc - FSplitterDelta < 0) then
                begin
                  cnewh := 0;
                  mnewh := Fsch + fshc;
                  PaneSized(Self, Fcpi, fmpi, cnewh, mnewh, allow);

                  if Allow then
                  begin
                    Panes[Fcpi].Height := cnewh;
                    Panes[Fmpi].Height := mnewh;
                  end;
                end;
              end;
            end;
          end;

          InitPaneRects;
          for P := 0 to Panes.Count - 1 do
          begin
            Panes[P].Chart.InitializeChart(Canvas, Panes[P].FRect, 1, 1);
          end;
        end;
      end;
    end
    else
    begin
      with Panes[Fcpi] do
      begin
        if Assigned(FZoomForm) and FDragZoom then
        begin
          if (X < FSeriesRect.Right) and (X > FSeriesRect.Left) then
          begin
            if (X - FCx) > 0 then
            begin
              FZoomForm.Width := X - FCx;
            end
            else
            begin
              FZoomForm.Width := Abs(X - FCx);
              FzoomForm.Left := Self.ClientOrigin.X +  X;
            end;
            FZoomForm.Show;
          end;
        end
        else
        begin
          pv := 0;
          for I := 0 to Panes.Count - 1 do
            if Panes[I].FVisible then
              pv := pv + 1;

          if PanesSynched and (pv > 1) then
          begin
            chx := false;
            for I := 0 to Panes.Count - 1 do
            begin
              Panes[I].FNormalZoom := true;
              if Panes[i].Series.IsHorizontal then
                SynchNormalZoom(Y, FCy, I, Fcpi)
              else
                SynchNormalZoom(X, FCx, I, Fcpi);
            end;
          end
          else
          begin
            if Panes[fcpi].Series.IsHorizontal then
              SynchNormalZoom(Y, FCy, -1, Fcpi)
            else
              SynchNormalZoom(X, FCx, -1, Fcpi);
          end;

          if panes[fcpi].Series.IsHorizontal then
            FCy := Y
          else
            FCx := X;
        end;
      end;
    end;
  end;

  if EnableInteraction then
  begin
    pnh := -1;
    for I := 0 to Panes.Count - 1 do
    begin
      if Panes[i].Visible then
      begin
        if PtInRect(Panes[i].Rectangle, Point(X, Y)) then
        begin
          pnh := I;
          break;
        end;
      end;
    end;

    if (pnh >= 0) and (pnh <= Panes.Count - 1) then
    begin
      serieLegend := Panes[pnh].Chart.GetLegendItemAtXY(X, Y);
      if Assigned(SerieLegend) and Assigned(OnLegendClick) then
        SetScreenCursor(ClickCursor);

      seriepielegend := Panes[pnh].Chart.GetPieLegendItemAtXY(X, Y);
      if (seriepielegend.Serie <> -1) and (seriepielegend.Point <> -1) and Assigned(OnPieLegendClick) then
        SetScreenCursor(ClickCursor);

      xval := Panes[pnh].Chart.GetXAxisValue(X, Y, Panes[pnh].FRect);
      if (xval.Serie <> -1) and (xval.RangeIndex <> -1) and Assigned(OnXAxisClick) then
        SetScreenCursor(ClickCursor);

      yval := Panes[pnh].Chart.GetYAxisValue(X, Y, Panes[pnh].FRect);
      if (yval.Serie <> -1) and Assigned(OnYAxisClick) then
        SetScreenCursor(ClickCursor);

      seriepoint := Panes[pnh].Chart.GetSerieIndexAtXY(X, Y);

      if (Seriepoint.Serie <> FHintSeriePoint.Serie) or (Seriepoint.Point <> FHintSeriePoint.Point) then
      begin
        FHintSeriePoint := seriePoint;
        Application.CancelHint;
      end;

      if (not Assigned(serieLegend) and (seriepielegend.Serie = -1) and (seriepielegend.Point = -1)) and (seriepoint.Serie <> -1) and (seriepoint.Point <> -1) and Assigned(OnSerieIndexClick) then
        SetScreenCursor(ClickCursor);
    end;
  end;
end;

{$IFDEF DELPHI2006_LVL}
procedure TAdvChartView.HandleDesignChoice(X,Y: integer);
var
  i: integer;
begin

  i := MouseOverDesignChoice(X, Y);

  if i = 1 then
  begin
    DesigntimeValues := not DesigntimeValues;
    if (MessageDlg('Are you sure you want to delete all panes / series?',mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    begin
      if DesigntimeValues then
        InitSample
      else
        Self.Panes.Clear;
    end;
  end;

  if (i = 3) then
  begin
    ShowDesignHelper := false;
  end;

  Changed;
end;

function TAdvChartView.MouseOverDesignChoice(X, Y: Integer): Integer;
var
  r: TRect;
  fh: Integer;
  h: Integer;
begin
  Result := -1;

  r := ClientRect;
  Canvas.Font.Name := 'Tahoma';
  Canvas.Font.Size := 8;

  fh := Canvas.TextHeight('gh') + 2;

  h := 3 * fh + 5;

  if (x > r.Right - 16) and
    (y > r.Bottom - h) and
    (y < r.Bottom - h + 16) then
    Result := 3;

  if (x > r.Right - 130) and (x < r.Right - 130 + Canvas.TextWidth(s_Edit) + 18) and
    (y > r.Bottom - h + fh + 4) and
    (y < r.Bottom - h + 2 * fh + 4) then
    Result := 1;
end;
{$ENDIF}

function TChartPane.SynchNormalZoom(X, ClickX, SynchedPane, CurrentPane: integer): Boolean;
var
  rt, rf: integer;
  p: TChartPane;
begin
  Result := true;

  if SynchedPane = -1 then
    SynchedPane := CurrentPane;

  p := TAdvChartView((Collection as TChartPanes).Owner).Panes[SynchedPane];
  if p.FNormalZoom and p.FVisible then
  begin
    FPixelsMoved := ClickX - X;

    rt := p.FChart.Range.RangeTo - FPixelsMoved;
    rf := p.FChart.Range.RangeFrom + FPixelsMoved;

    if p.FChart.Range.RangeTo - p.FChart.Range.RangeFrom > 5 then
    begin
      if rt - rf < 5 then
        p.FChart.Range.RangeFrom := p.FChart.Range.RangeTo - 5
      else
        p.UpdateRange(p.FChart.Range.RangeFrom + FPixelsMoved, p.FChart.Range.RangeTo - FPixelsMoved);
    end
    else
    begin
      if FPixelsMoved < 0 then
        p.UpdateRange(p.FChart.Range.RangeFrom + FPixelsMoved, p.FChart.Range.RangeTo - FPixelsMoved);
    end;

    p.Series.ForceInit(true);
    p.Chart.InitializeChart(TAdvChartView((Collection as TChartPanes).Owner).Canvas, p.FRect, 1, 1);
    (Collection as TChartPanes).FOwner.DoXScaleZoom(Self, SynchedPane, p.Chart.XScale);
    Result := true;
  end;
end;

procedure TAdvChartView.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  I: integer;
  ch: boolean;
  chi: integer;
  J: Integer;
  serieLegend: TChartSerie;
  xval: TXAxisRangeValue;
  yval: TYAxisRangeValue;
  seriepoint: TChartSeriePoint;
  seriepielegend: TChartSeriePoint;
begin
  inherited;

  {$IFDEF DELPHI2006_LVL}
  if (csDesigning in ComponentState) then
  begin
    HandleDesignChoice(X,Y);
    Exit;
  end;
  {$ENDIF}

  if Panes.Count = 0 then
    Exit;

  if (FCx > x - 2) and (FCX < x + 2) and (FCy > y - 2) and (FCy < y + 2) and EnableInteraction then
  begin
    for I := 0 to Panes.Count - 1 do
    begin
      with Panes[i] do
      begin
        serieLegend := Chart.GetLegendItemAtXY(X, Y);
        if Assigned(serieLegend) then
        begin
          if Assigned(OnLegendClick) then
            OnLegendClick(Self, I, serieLegend.Index, serieLegend.LegendText);
        end;

        seriepielegend := Chart.GetPieLegendItemAtXY(X, Y);
        if (seriepielegend.Serie <> -1) and (seriepielegend.Point <> -1) then
        begin
          if Assigned(OnPieLegendClick) then
            OnPieLegendClick(Self, I, seriepielegend.Serie, seriepielegend.Point);
        end;

        xval := Chart.GetXAxisValue(X, Y, FRect);
        if (xval.Serie <> -1) and (xval.RangeIndex <> -1) then
        begin
          if Assigned(OnXAxisClick) then
            OnXAxisClick(Self, I, xval.Serie, xval.RangeIndex);
        end;

        yval := Chart.GetYAxisValue(X, Y, FRect);
        if (yval.Serie <> -1) then
        begin
          if Assigned(OnYAxisClick) then
            OnYAxisClick(Self, I, yval.serie, yval.ValueStr, yval.Value, yval.mode);
        end;

        seriepoint := Chart.GetSerieIndexAtXY(X, Y);
        if (not Assigned(serieLegend) and (seriepielegend.Serie = -1) and (seriepielegend.Point = -1)) and (seriepoint.Serie <> -1) and (seriepoint.Point <> -1) then
        begin
          if Assigned(FOnSelectSerieIndex) then
            FOnSelectSerieIndex(Self, I, seriepoint.Serie, seriepoint.Point);

          if Assigned(OnSerieIndexClick) then
            OnSerieIndexClick(Self, I, seriepoint.Serie, seriepoint.Point);

          {$IFDEF DELPHIXE2_LVL}
          if Popup.Enabled and ((seriepoint.Serie >= 0) and (seriepoint.Serie <= Series.Count - 1)) then
          begin
            case Popup.ActivateMode of
              amMouseLeft:
              begin
                if (Button = mbLeft) then
                  ShowToolBarPopupAtSeries(Series[seriepoint.Serie]);
              end;
              amMouseRight:
              begin
                if (Button = mbRight) then
                  ShowToolBarPopupAtSeries(Series[seriepoint.Serie]);
              end;
              amBoth: ShowToolBarPopupAtSeries(Series[seriepoint.Serie]);
            end;
          end;
          {$ENDIF}
        end
        else
        begin
          {$IFDEF DELPHIXE2_LVL}
          if Popup.Enabled then
            HideToolBarPopup;
          {$ENDIF}
        end;
      end;
    end;
  end
  else
  begin
   {$IFDEF DELPHIXE2_LVL}
    if Popup.Enabled then
      HideToolBarPopup;
    {$ENDIF}
  end;


  IsYPositionChartPoint(X, Y, False, Button);
  IsYPosChartAnnotation(Point(X, Y), cmsMouseUp);

  FRx := X;
  FRy := Y;
  with Panes[Fcpi] do
  begin
    if FOnNavigator = false then
    begin
      ch := false;
      chi := -1;
      if (FCh = false) and (FMc = true) then
        begin
        for I := 0 to Panes.Count - 1 do
        begin
          if (Y >= Panes[I].FRect.Top - FSplitterHeight) and (Y <= Panes[I].FRect.Bottom) then
          begin
            begin
              if I <> Fcpi then
              begin
                ch := true;
                chi := I;
                break;
              end;
            end;
          end;
        end;
        if (ssShift in Shift) and (ch = true) and (poMoving in Options) then
        begin
          Index := chi;
          PaneMoved(Self, Fcpi, chi);
        end;
      end;
    end
    else
    begin
      if Assigned(FZoomForm) and Panes[Fcpi].FDragZoom and (Panes[FCpi].CtrlZooming <> czNone) then
      begin
        if PanesSynched then
        begin
          for I := 0 to Panes.Count - 1 do
          begin
            ZoomSelection(Self, I, FCx, FCY, X, Y);
            Panes[I].DoZoomIn;
          end;
        end
        else
        begin
          ZoomSelection(Self, Fcpi, FCx, FCY, X, Y);
          Panes[Fcpi].DoZoomIn;
        end;
      end;
    end;

    FOnNavigator := false;
    FTimerScroll.Enabled := false;
    FTimerZoomOut.Enabled := false;
    FMouseDownOnNavigator := false;
    Navigator.LeftButtonState := cnbNormal;
    Navigator.RightButtonState := cnbNormal;
    FMc := false;
    FCh := false;
    FMouseDownOnAxis := false;
    FMouseDownOnSerie := false;

    if Assigned(FRegionForm) then
    begin
      if PanesSynched then
      begin
        for I := 0 to Panes.Count - 1 do
        begin
          with Panes[I] do
          begin
            if (Panes[I].CtrlZooming <> czNone)  then
            begin
              for J := 0 to Series.Count - 1 do
              begin
                Series.ForceInit(true);
                with TCrackedChartSerie(Series[j]) do
                begin
                  MaximumValue := YToValue(FMaximumY, FSeriesRect);
                  MinimumValue := YToValue(FMinimumY, FSeriesRect);
                end;
              end;
              ZoomSelection(Self, I, FCx, FMaximumY, X, FMinimumY);
              DoZoomIn;
            end;
          end;
        end;
      end
      else
      begin
        if (Panes[FCpi].CtrlZooming <> czNone)  then
        begin
          ZoomSelection(Self, Fcpi, FCx, FMaximumY, X, FMinimumY);
          Panes[Fcpi].DoZoomIn;
        end;
      end;
      FRegionForm.Free;
      FRegionForm := nil;
    end;
    if Assigned(FDragForm) then
    begin
      FDragForm.Free;
      FDragForm := nil;
    end;
    if Assigned(FZoomForm) then
    begin
      FZoomForm.Free;
      FZoomForm := nil;
    end;
    SetScreenCursor(crArrow);
  end;
end;

procedure TChartPane.DoZoomIn;
var
  ort, orf, nrf, nrt: integer;
  I: Integer;
  pmin, pmax: Double;
begin
  if FSeriesRect.Right - FSeriesRect.Left <= 0 then
    Exit;

  with TAdvChartView((Collection as TChartPanes).Owner) do
  begin
    if (CtrlZooming = czXAxis) or (CtrlZooming = czBoth) then
    begin
      if (FRx - FCx) > 0 then
      begin
        orf := FChart.Range.RangeFrom;
        ort := FChart.Range.RangeTo;
        nrf := Round(orf + ((FCx - Chart.GetXScaleStart - FSeriesRect.Left) * ((ort - orf) / (FSeriesRect.Right - FSeriesRect.Left))));
        nrt := Round(orf + ((FRx - Chart.GetXScaleStart - FSeriesRect.Left) * ((ort - orf) / (FSeriesRect.Right - FSeriesRect.Left))));
        if nrt > nrf then
          UpdateRange(nrf, nrt);
      end
      else if (FRx - FCx) < 0 then
      begin
        orf :=  FChart.Range.RangeFrom;
        ort := FChart.Range.RangeTo;
        nrf := Round(orf + ((FRx - Chart.GetXScaleStart - FSeriesRect.Left) * ((ort - orf) / (FSeriesRect.Right - FSeriesRect.Left))));
        nrt := Round(orf + ((FCx - Chart.GetXScaleStart - FSeriesRect.Left) * ((ort - orf) / (FSeriesRect.Right - FSeriesRect.Left))));
        if nrt > nrf then
          UpdateRange(nrf, nrt);
      end;
      Series.ForceInit(true);
      Chart.InitializeChart(Canvas, FRect, 1, 1);
    end;

    if (CtrlZooming = czYAxis) or (CtrlZooming = czBoth) then
    begin
      if (FRy - FCy) > 0 then
      begin
        Series.ForceInit(true);
        Series.Mode := cmScaling;
        for I := 0 to Series.Count - 1 do
        begin
          Series[I].AutoRange := arDisabled;
          pmin := Series[I].YToValue(FRy, FSeriesRect);
          pmax := Series[I].YToValue(FCy, FSeriesRect);
          if pmax - pmin > ZOOMMIN then
          begin
            TCrackedChartSerie(Series[I]).MinimumValue := pmin;
            TCrackedChartSerie(Series[I]).MaximumValue := pmax;
          end;
        end;
        Chart.InitializeChart(ChartView.Canvas, FRect, 1, 1);
      end
      else if (FRy - FCy) < 0 then
      begin
        Series.ForceInit(true);
        Series.Mode := cmScaling;
        for I := 0 to Series.Count - 1 do
        begin
          Series[I].AutoRange := arDisabled;
          pmin := Series[I].YToValue(FCy, FSeriesRect);
          pmax := Series[I].YToValue(FRy, FSeriesRect);
          if pmax - pmin > ZOOMMIN then
          begin
            TCrackedChartSerie(Series[I]).MinimumValue := pmin;
            TCrackedChartSerie(Series[I]).MaximumValue := pmax;
          end;
        end;
        Chart.InitializeChart(ChartView.Canvas, FRect, 1, 1);
      end;
    end;
  end;
end;

procedure TAdvChartView.Paint;
var
  i: integer;
  r: TRect;
  fp: integer;
  {$IFDEF FREEWARE}
  tw: integer;
  fwt: string;
  {$ENDIF}
begin
  r := ClientRect;
  fp := 0;
  // loop through all panes & draw
  for i := 0 to Panes.Count - 1 do
  begin
    with Panes[I] do
    begin
      if Visible then
      begin
        if FSplitter.Visible then
        begin
          if I <> fp then
          begin
            FSplitter.Draw(Canvas, r);
            r.Top := r.Top + FSplitter.FHeight;
          end;
        end;

        r.Bottom := r.Top + PixelHeight;

        FRect := r;

        Draw(Canvas, R, 1, 1);

        FSeriesRect := FChart.SeriesRectangle(R, 1, 1);

        if DrawLines and (FUpdateCount = 0) and CrossHair.Visible then
        begin
          DrawVerticalLines(Canvas, FSeriesRect)
        end;

        if Assigned(OnDrawPane) then
          OnDrawPane(Self, R, Canvas);

        r.Top := r.Bottom;
      end
      else
      begin
        inc(fp);
      end;
    end;
  end;

  {$IFDEF DELPHI2006_LVL}
  PaintDesigner;
  {$ENDIF}

  {$IFDEF FREEWARE}
  r := ClientRect;
  fwt := self.classname + ' trial version';
  Canvas.Font.Color := clGray;
  Canvas.Font.Style := [fsItalic];
  tw := Canvas.TextWidth(fwt);
  if Panes.Count > 0 then
    r.Top := Panes[0].Title.TopSize + Panes[0].XAxis.TopSize;
  Canvas.TextOut(r.Right - tw - 4, r.Top, fwt);
  {$ENDIF}

  if Assigned(OnDrawChart) then
    OnDrawChart(Self, ClientRect, Canvas);
end;

{$IFDEF DELPHIXE2_LVL}
procedure TAdvChartView.ActiveSeriesToPopup;
var
  p: TAdvChartToolBarPopup;
  I: Integer;
  s: String;
begin
  p := ToolBarPopup;
  if Assigned(p) and Assigned(FActiveSerie) then
  begin
    p.SeriesFillColor := FActiveSerie.Color;
    p.SeriesLineColor := FActiveSerie.LineColor;
    p.SeriesLineWidth := FActiveSerie.LineWidth;

    if FActiveSerie.ShowValue then
    begin
      case FActiveSerie.ValueFormatType of
        vftNormal: p.SeriesLabelType := tpsltNormal;
        vftFloat: p.SeriesLabelType := tpsltFloat;
      end;
    end
    else
      p.SeriesLabelType := tpsltNone;

    case FActiveSerie.Marker.MarkerType of
      mNone: p.SeriesMarkerType := tpsmNone;
      mCircle: p.SeriesMarkerType := tpsmEllipse;
      mSquare: p.SeriesMarkerType := tpsmSquare;
      mDiamond: p.SeriesMarkerType := tpsmDiamond;
      mTriangle: p.SeriesMarkerType := tpsmTriangle;
    end;

    case FActiveSerie.PenStyle of
      psSolid: p.SeriesLineStyle := tpslsSolid;
      psDash: p.SeriesLineStyle := tpslsDash;
      psDot: p.SeriesLineStyle := tpslsDot;
      psDashDot: p.SeriesLineStyle := tpslsDashDot;
      psDashDotDot: p.SeriesLineStyle := tpslsDashDotDot;
      psClear: p.SeriesLineStyle := tpslsNone;
    end;

    case FActiveSerie.ChartType of
      ctLine: p.SeriesType := tpstLine;
      ctArea:  p.SeriesType := tpstArea;
      ctBar:  p.SeriesType := tpstBar;
      ctLineBar: p.SeriesType := tpstLineBar;
      ctHistogram: p.SeriesType := tpstHistogram;
      ctLineHistogram: p.SeriesType := tpstLineHistogram;
      ctCandleStick: p.SeriesType := tpstCandleStick;
      ctLineCandleStick: p.SeriesType := tpstLineCandleStick;
      ctOHLC: p.SeriesType := tpstOHLC;
      ctMarkers: p.SeriesType := tpstMarkers;
      ctStackedBar: p.SeriesType := tpstStackedBar;
      ctStackedArea: p.SeriesType := tpstStackedArea;
      ctStackedPercArea: p.SeriesType := tpstStackedPercArea;
      ctStackedPercBar: p.SeriesType := tpstStackedPercBar;
      ctError: p.SeriesType := tpstError;
      ctArrow: p.SeriesType := tpstArrow;
      ctScaledArrow: p.SeriesType := tpstScaledArrow;
      ctBubble: p.SeriesType := tpstBubble;
      ctScaledBubble: p.SeriesType := tpstScaledBubble;
      ctPie: p.SeriesType := tpstPie;
      ctHalfPie: p.SeriesType := tpstHalfPie;
      ctDonut: p.SeriesType := tpstDonut;
      ctHalfDonut: p.SeriesType := tpstHalfDonut;
      ctBand: p.SeriesType := tpstBand;
      ctSpider: p.SeriesType := tpstSpider;
      ctHalfSpider: p.SeriesType := tpstHalfSpider;
      ctVarRadiusPie: p.SeriesType := tpstVarRadiusPie;
      ctVarRadiusHalfPie: p.SeriesType := tpstVarRadiusHalfPie;
      ctVarRadiusDonut: p.SeriesType := tpstVarRadiusDonut;
      ctVarRadiusHalfDonut: p.SeriesType := tpstVarRadiusHalfDonut;
      ctSizedPie: p.SeriesType := tpstSizedPie;
      ctSizedHalfPie: p.SeriesType := tpstSizedHalfPie;
      ctSizedDonut: p.SeriesType := tpstSizedDonut;
      ctSizedHalfDonut: p.SeriesType := tpstSizedHalfDonut;
      ctDigitalLine: p.SeriesType := tpstDigitalLine;
      ctBoxPlot: p.SeriesType := tpstBoxPlot;
      ctRenko: p.SeriesType := tpstRenko;
      ctXYLine: p.SeriesType := tpstXYLine;
      ctXYMarkers: p.SeriesType := tpstXYMarkers;
      ctGantt: p.SeriesType := tpstGantt;
      ctFunnel: p.SeriesType := tpstFunnel;
      ctXYDigitalLine: p.SeriesType := tpstXYDigitalLine;
    end;

    p.SeriesMarkerFillColor := FActiveSerie.Marker.MarkerColor;
    p.SeriesMarkerSize := FActiveSerie.Marker.MarkerSize;

    p.SeriesNames.Clear;
    if (Fcpi >= 0) and (Fcpi <= Panes.Count - 1) then
    begin
      for I := 0 to Panes[Fcpi].Series.Count - 1 do
      begin
        s := Panes[FCpi].Series[I].Name;
        if s = '' then
          s := 'Series ' + inttostr(I);

        p.SeriesNames.Add(s);
      end;

      p.SeriesIndex := FActiveSerie.Index;
    end;
  end;
end;
{$ENDIF}

{$IFDEF DELPHI2006_LVL}
procedure TAdvChartView.PaintDesigner;
var
  R: TRect;
  fh,i: Integer;
  P: TPoint;
  htheme: THandle;
  cr: TRect;
  DChecked, ThemeStyle: Word;
begin
  if not FIsWinXP then
    Exit;

  if not FShowDesignHelper then
    Exit;

  if (csDesigning in ComponentState) then
  begin
    r := ClientRect;

    Canvas.Font.Name := 'Tahoma';
    Canvas.Font.Size := 8;
    Canvas.Brush.Color := RGB(245, 245, 245);
    Canvas.Pen.Color := clGray; //$B99D7F;

    Canvas.Font.Color := clNavy;
    Canvas.Font.Style := [fsUnderline];
    fh := Canvas.TextHeight('gh') + 2;

    r.Left := r.Right - 130;
    r.Top := r.Bottom - (3 * fh) - 5;

    Canvas.Rectangle(r);

    Canvas.Pen.Color := clNavy;
    Canvas.Pen.Width := 2;
    Canvas.MoveTo(R.Right - 12, r.Top + 5);
    Canvas.LineTo(R.Right - 5, r.Top + 12);
    Canvas.MoveTo(R.Right - 5, r.Top + 5);
    Canvas.LineTo(R.Right - 12, r.Top + 12);

    GetCursorPos(P);
    P := ScreenToClient(P);

    i := MouseOverDesignChoice(P.X, P.Y);

    if i = 1 then
      Canvas.Font.Style := [fsUnderline]
    else
      Canvas.Font.Style := [];


    cr := Rect(r.Left + 4, r.Top + 3 + fh, r.Left + 4 + 16, r.Top + 2 + fh + 16);

    if DesigntimeValues then
    begin
      DChecked := DFCS_BUTTONCHECK or DFCS_CHECKED;
      ThemeStyle := CBS_CHECKEDNORMAL;
    end
    else
    begin
      DChecked := DFCS_BUTTONCHECK;
      ThemeStyle := CBS_UNCHECKEDNORMAL
    end;

    if FIsWinXP and IsThemeActive then
    begin
      htheme := OpenThemeData(Handle,'button');
      DrawThemeBackground(HTheme, Canvas.Handle, BP_CHECKBOX, ThemeStyle,cr,nil);
      CloseThemeData(htheme);
    end
    else
      DrawFrameControl(Canvas.Handle,cr,DFC_BUTTON, DChecked);


    Canvas.TextOut(r.Left + 4 + 18, r.Top + 4 + fh, s_Edit);

    if i = 2 then
      Canvas.Font.Style := [fsUnderline]
    else
      Canvas.Font.Style := [];
  end;
end;
{$ENDIF}

procedure TAdvChartView.InitPaneRects;
var
  i: integer;
  r: TRect;
  fp: integer;
begin
  r := Bounds(0, 0, Width, Height);
  fp := 0;

  // loop through all panes & draw
  for i := 0 to Panes.Count - 1 do
  begin
    with Panes[I] do
    begin
      if Visible then
      begin
        if FSplitter.Visible then
        begin
          if I <> fp then
          begin
            r.Top := r.Top + FSplitter.FHeight;
          end;
        end;
        r.Bottom := r.Top + PixelHeight;
        FRect := r;
        FSeriesRect := FChart.SeriesRectangle(R, 1, 1);
        r.Top := r.Bottom;
      end
      else
      begin
        inc(fp);
      end;
    end;
  end;
end;


procedure TAdvChartView.PaneMoved(Sender: TObject; FromPosition,
  ToPosition: integer);
begin
  if Assigned(FOnPaneMoved) then
    FOnPaneMoved(Self, FromPosition, ToPosition);
end;

procedure TAdvChartView.PanesChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvChartView.PaneSelected(Sender: TObject;
  FocusedPaneIndex: integer);
begin
  if Assigned(FOnPaneSelected) then
    FOnPaneSelected(Self, FocusedPaneIndex);
end;

procedure TAdvChartView.PaneSized(Sender: TObject; CurrentPaneIndex, MovingPaneIndex: integer;
  var CurrentNewSize, MovingNewSize: integer; var Allow: Boolean);
begin
  if Assigned(FOnPaneSized) then
    FOnPaneSized(Self, CurrentPaneIndex, MovingPaneIndex, CurrentNewSize, MovingNewSize, Allow);
end;

procedure TAdvChartView.PP(Pane: Integer; Canvas: TCanvas; R: TRect;
  Print: Boolean);
begin
  PrintPane(Pane, Canvas, R);
end;

procedure TAdvChartView.PrintPane(Pane: Integer; Canvas: TCanvas; R: TRect);
var
  nLogPixelsX_output, nLogPixelsY_output, nLogPixelsX_screen, nLogPixelsY_screen: integer;
  scalex, scaley: Double;
begin
  nLogPixelsX_output := GetDeviceCaps(Canvas.Handle,LOGPIXELSX);
  nLogPixelsY_output := GetDeviceCaps(Canvas.Handle,LOGPIXELSY);

  nLogPixelsX_screen := GetDeviceCaps(self.Canvas.Handle,LOGPIXELSX);
  nLogPixelsY_screen := GetDeviceCaps(self.Canvas.Handle,LOGPIXELSY);

  scalex := nLogPixelsX_output / nLogPixelsX_screen;
  scaley := nLogPixelsY_output / nLogPixelsY_screen;

  Panes[Pane].Chart.InitializeChart(Canvas, R, Scalex, ScaleY);
  Panes[Pane].Draw(Canvas, R, ScaleX, ScaleY);
  Panes[Pane].Chart.InitializeChart(Self.Canvas, Panes[Pane].FRect, 1, 1);
end;

procedure TAdvChartView.Resize;
var
  I: integer;
begin
  inherited;

  InitPaneRects;

  for i := 0 to Panes.Count - 1 do
  begin
    with Panes[I] do
    begin
      if Visible then
      begin
        Chart.Series.ForceInit(true);
        Chart.InitializeChart(Canvas, FRect, 1, 1);
      end;
    end;
  end;
end;

procedure TAdvChartView.PrintAllPanes(Canvas: TCanvas; R: TRect);
var
  I, th, P: Integer;
  nr: TRect;
begin
 for I := 0 to Panes.Count - 1 do
  begin
    th := 0;
    for P := 0 to I - 1 do
    begin
      if Panes[P].Visible then
        th := th + Round(Panes[P].PixelHeight * (R.Bottom - R.Top) / self.Height);
    end;
    if Panes[I].Visible then
    begin
      nr := Bounds(R.Left, R.Top + th, R.Right - R.Left, Round(Panes[I].PixelHeight * (R.Bottom - R.Top) / self.Height));
      PP(I, Canvas, nr, true);
    end;
  end;
end;

procedure TAdvChartView.SaveAllPanesToBitmap(Filename: String; Width,
  Height: integer);
var
  bmp: Graphics.TBitmap;
  I, th, P: Integer;
  r: TRect;
begin
  bmp := Graphics.TBitmap.Create;
  bmp.Width := Width;
  bmp.Height := Height;
  for I := 0 to Panes.Count - 1 do
  begin
    th := 0;
    for P := 0 to I - 1 do
    begin
      if Panes[P].Visible then
        th := th + Round(Panes[P].PixelHeight * (bmp.Height / self.Height));
    end;
    if Panes[I].Visible then
    begin
      r := Bounds(Panes[I].Rectangle.Left, th, Width, Round(Panes[I].PixelHeight * (bmp.Height / self.Height)));
      PP(I, bmp.Canvas, r, false);
    end;
  end;
  bmp.SaveToFile(Filename);
  bmp.Free;
end;

procedure TAdvChartView.SavePaneToBitmap(Pane: Integer; Filename: String; Width,
  Heigth: integer);
var
  bmp: Graphics.TBitmap;
begin
  bmp := Graphics.TBitmap.Create;
  bmp.Width := Width;
  bmp.Height := Heigth;
  PP(Pane, bmp.Canvas, rect(0, 0, Width, Heigth), false);
  bmp.SaveToFile(Filename);
  bmp.Free;
end;

function GetAnchors(Anchors: TAnchors): String;
var
  str: String;
begin
  str := '';
  if akLeft in Anchors then
    str := str + ':0';
  if akTop in Anchors then
    str := str + ':1';
  if akRight in Anchors then
    str := str + ':2';
  if akBottom in Anchors then
    str := str + ':3';
  Result := str;
end;

procedure TAdvChartView.SaveToCSV(FileName: String);
var
  I, C, k: Integer;
  sl: TStringList;
begin
  sl := TStringList.Create;
  for I := 0 to Panes.Count - 1 do
    with Panes[I] do
      for K := 0 to Series.Count - 1 do
        for C := 0 to Series[K].GetPointsCount - 1 do
          sl.Add('"'+inttostr(I)+'";"'+ inttostr(K)+'";"'+ChartPointToString(Series[K].GetPoint(C)));

  sl.SaveToFile(FileName);
  sl.Free;
end;

procedure TAdvChartView.SaveToFile(Filename: String);
var
  I: Integer;
  ini: TMemIniFile;
begin
  ini := TMemIniFile.Create(Filename);

  ini.WriteInteger(name,'Align',Integer(Align));
  ini.WriteString(name,'Anchors',GetAnchors(Anchors));
  ini.WriteInteger(name,'Color',Color);
  ini.WriteInteger(name,'Constraints', Integer(Constraints));
  ini.WriteBool(name,'DragAlphaBlend',DragAlphaBlend);
  ini.WriteInteger(name, 'DragAlphaBlendValue',DragAlphaBlendValue);
  ini.WriteString(name, 'Hint',Hint);
  ini.WriteBool(name, 'PanesSynched', PanesSynched);
  ini.WriteInteger(name, 'PopupMenu', Integer(PopupMenu));
  ini.WriteBool(name, 'ShowHint', ShowHint);
  ini.WriteInteger(name, 'TabOrder', Integer(TabOrder));
  ini.WriteBool(name, 'TabStop', TabStop);
  ini.WriteBool(name, 'VerticalCrossHairsSynched', VerticalCrossHairsSynched);
  ini.WriteString(name, 'Version', Version);
  ini.WriteBool(name, 'Visible',Visible);
  ini.WriteFloat(name, 'XAxisZoomSensitivity', XAxisZoomSensitivity);
  ini.WriteFloat(name, 'YAxisZoomSensitivity', YAxisZoomSensitivity);
  ini.WriteInteger(name, 'ZoomColor', ZoomColor);
  ini.WriteInteger(name, 'ZoomStyle', Integer(ZoomStyle));

  ini.WriteBool(name, 'EnableInteraction', EnableInteraction);

  Tracker.SaveToFile(ini, name + '.' + 'Tracker');

  for I := 0 to Panes.Count - 1 do
  begin
//    Panes[I].SaveToFile(ini, name + '.' + Panes[I].Name);
    Panes[I].SaveToFile(ini, name + '.Pane' + IntToStr(I));
  end;

  ini.WriteInteger(name, 'PaneCount', Panes.Count);

  ini.UpdateFile;
  ini.Free;

end;

procedure TAdvChartView.SerieMouseDown(Sender: TObject; Button: TMouseButton; PaneIndex: integer; SerieIndex: Integer;
  Index: integer; value: Double; X, Y: integer);
begin
  if Assigned(FOnSerieMouseDown) then
    FOnSerieMouseDown(Sender, Button, PaneIndex, SerieIndex, Index, Value, X, Y);
end;

procedure TAdvChartView.SerieMouseUp(Sender: TObject; Button: TMouseButton; PaneIndex: integer; SerieIndex: Integer;
  Index: integer; value: Double; X, Y: integer);
begin
  if Assigned(FOnSerieMouseUp) then
    FOnSerieMouseUp(Sender, Button, PaneIndex, SerieIndex, Index, Value, X, Y);
end;

procedure TAdvChartView.SetAutoYAxisSize;
var
  I: Integer;
  maxl, maxr: Integer;
  ls, rs: Integer;
begin
  maxl := 0;
  maxr := 0;
  for I := 0 to Panes.Count - 1 do
  begin
    ls := Panes[I].Chart.GetTotalYAxisLeftSize;
    if ls > maxl then
      maxl := ls;

    rs := Panes[I].Chart.GetTotalYAxisRightSize;
    if rs > maxr then
      maxr := rs;
  end;

  for I := 0 to Panes.Count - 1 do
  begin
    Panes[I].YAxis.LeftSize := maxl;
    Panes[I].YAxis.RightSize := maxr;
  end;
end;

procedure TAdvChartView.SetDesigntimeValues(const Value: Boolean);
begin
  if FDesigntimeValues <> Value then
  begin
    FDesigntimeValues := Value;
    Changed;
  end;
end;

procedure TAdvChartView.SetDragAlphaBlend(const Value: boolean);
begin
  if FDragAlphaBlend <> Value then
  begin
    FDragAlphaBlend := Value;
    Changed;
  end;
end;

procedure TAdvChartView.SetDragAlphaBlendValue(const Value: Byte);
begin
  if (FDragAlphaBlendValue <> Value) then
  begin
    FDragAlphaBlendValue := Value;
    Changed;
  end;
end;

procedure TAdvChartView.SetEnableInteraction(const Value: Boolean);
begin
  if FEnableInteraction <> Value then
  begin
    FEnableInteraction := Value;
    Changed;
  end;
end;

procedure TAdvChartView.SetForceCursor(const Value: Boolean);
begin
  if FForceCursor <> value then
  begin
    FForceCursor := Value;
    Changed;
  end;
end;

procedure TAdvChartView.SetPanes(const Value: TChartPanes);
begin
  if FPanes <> value then
  begin
    FPanes.Assign(Value);
    changed;
  end;
end;

procedure TAdvChartView.SetPanesRange(RangeFrom, RangeTo: integer);
var
  i,j,m,n : integer;
begin
  for i := 0 to Panes.Count - 1 do
  begin
    m := RangeTo;

    for j := 0 to Panes[i].Series.Count - 1 do
    begin
      n := Panes[i].Series[j].GetArraySize;
      if n > m then
        m := n;
    end;

    Panes[i].Range.RangeFrom := RangeFrom;
    Panes[i].Range.RangeTo := RangeTo;
    Panes[i].Range.ForceMaxRangeTo := false;
    Panes[i].Range.MaxRangeTo := m;
  end;

end;

procedure TAdvChartView.SetPanesSynched(const Value: Boolean);
begin
  if FPanesSynched <> Value then
  begin
    FPanesSynched := Value;
    Changed;
  end;
end;

procedure TAdvChartView.SetScreenCursor(c: TCursor);
begin
  if not ForceCursor then
  begin
    Screen.Cursor := c;
  end;
end;

procedure TAdvChartView.SetShowDesignHelper(const Value: Boolean);
begin
  if FShowDesignHelper <> value then
  begin
    FShowDesignHelper := Value;
    Changed;
  end;
end;

procedure TAdvChartView.SetTracker(const Value: TChartTracker);
begin
  if FTracker <> Value then
  begin
    FTracker.Assign(Value);
    Changed;
  end;
end;

procedure TAdvChartView.Setversion(const Value: string);
begin

end;

procedure TAdvChartView.SetVerticalCrossHairSynched(const Value: boolean);
begin
  if FVerticalCrossHairSynched <> Value then
  begin
    FVerticalCrossHairSynched := Value;
    Changed;
  end;
end;

procedure TAdvChartView.SetXAxisZoomSensitivity(const Value: Double);
begin
  if (FXAxisZoomSensitivity <> Value) and (Value > 0) then
  begin
    FXAxisZoomSensitivity := Value;
    Changed;
  end;
end;

procedure TAdvChartView.SetYAxisZoomSensitivity(const Value: Double);
begin
  if (FYAxisZoomSensitivity <> Value) and (Value > 0) then
  begin
    FYAxisZoomSensitivity := Value;
    Changed;
  end;
end;

procedure TAdvChartView.SetZoomColor(const Value: TColor);
begin
  if (FZoomColor <> Value) then
  begin
    FZoomColor := Value;
    Changed;
  end;
end;

procedure TAdvChartView.SetZoomStyle(const Value: TBrushStyle);
begin
  if FZoomStyle <> value then
  begin
    FZoomStyle := Value;
    Changed;
  end;
end;

function TAdvChartView.StringToChartPoint(s: String): TChartPoint;
var
  a: TStringList;
begin
  a := TStringList.Create;
  Split(';', s, a);
  Result.SingleValue := strtofloat(a[0]);
  Result.SecondValue := strtofloat(a[1]);
  Result.OpenValue := strtofloat(a[2]);
  Result.LowValue := strtofloat(a[3]);
  Result.HighValue := strtofloat(a[4]);
  Result.CloseValue := strtofloat(a[5]);
  Result.Defined := StrToBool(a[6]);
  Result.PixelValue1 := StrToInt(a[7]);
  Result.PixelValue2 := StrToInt(a[8]);
  Result.Color := StrToInt(a[9]);
  Result.ColorTo := StrToInt(a[10]);
  Result.TimeStamp := StrToFloat(a[11]);
  Result.ValueType := TChartPointValueType(StrToInt(a[12]));
  Result.LegendValue := a[13];
  Result.SingleXValue := strtofloat(a[14]);
  Result.MedValue := strtofloat(a[15]);
end;

procedure TAdvChartView.TrackerChanged(Sender: TObject);
begin
  Self.Invalidate;
  {
  if Assigned(Tracker.TrackerForm) then
  begin
    if Tracker.TrackerForm.HandleAllocated and Tracker.TrackerForm.Visible then
    begin
      Tracker.TrackerForm.Left := Left;
      Tracker.TrackerForm.Top := Top;
    end;
  end;
  }
end;

procedure TAdvChartView.TrackerClosed(Sender: TObject; var CanClose: Boolean);
begin
  if Assigned(FOnTrackerClose) then
    FOnTrackerClose(Self, CanClose);
end;

procedure TAdvChartView.TrackerMoved(Sender: TObject; X, Y: integer);
begin
  if Assigned(FOnTrackerMove) then
  begin
    FOnTrackerMove(Self, X,Y);
  end;

  if (Tracker.FUpdateCount = 0) and not (csLoading in ComponentState) then
  begin
    Tracker.FLeft := X - Parent.ClientOrigin.X;
    Tracker.FTop := Y - Parent.ClientOrigin.Y
  end;
end;

procedure TAdvChartView.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := Message.Result or DLGC_WANTTAB;
end;

procedure TAdvChartView.WMPaint(var Message: TWMPaint);
var
  DC, MemDC: HDC;
  MemBitmap, OldBitmap: HBITMAP;
  PS: TPaintStruct;
begin
  if not FDoubleBuffered or (Message.DC <> 0) then
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
      Perform(WM_ERASEBKGND, MemDC, MemDC);
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

{$IFDEF DELPHIXE2_LVL}
function TAdvChartView.GetToolBarPopup;
begin
  if not Assigned(FToolBarPopup) then
  begin
    FToolBarPopup := TAdvChartToolBarPopup.Create(Self);
    FToolBarPopup.PlacementControl := Self;
    FToolBarPopup.OnActivate := DoToolBarPopupActivate;
    FToolBarPopup.OnDeactivate := DoToolBarPopupDeactivate;
  end;

  Result := FToolBarPopup;
  Result.Options := Popup.Options;
  Result.DragGrip := Popup.DragGrip;
end;

function TAdvChartView.AddToolBarPopupButton(AWidth: Single = -1; AHeight: Single = -1;
  AResource: String = ''; AResourceLarge: String = ''; AText: String = ''; AIndex: Integer = -1): TAdvChartToolBarButton;
begin
  Result := ToolBarPopup.ToolBar.AddButton(AWidth, AHeight, AResource, AResourceLarge, AText, AIndex);
end;

procedure TAdvChartView.AddToolBarPopupCustomControl(AControl: TControl; AIndex: Integer = -1);
begin
  ToolBarPopup.ToolBar.AddCustomControl(AControl, AIndex);
end;

function TAdvChartView.AddToolBarPopupCustomControlClass(AControlClass: TControlClass;
  AIndex: Integer = -1): TControl;
begin
  Result := ToolBarPopup.ToolBar.AddCustomControlClass(AControlClass, AIndex);
end;

function TAdvChartView.AddToolBarPopupSeparator(AIndex: Integer = -1): TAdvChartToolBarSeparator;
begin
  Result := ToolBarPopup.ToolBar.AddSeparator(AIndex);
end;

function TAdvChartView.AddToolBarPopupFontNamePicker(AIndex: Integer = -1): TAdvChartToolBarFontNamePicker;
begin
  Result := ToolBarPopup.ToolBar.AddFontNamePicker(AIndex);
end;

function TAdvChartView.AddToolBarPopupFontSizePicker(AIndex: Integer = -1): TAdvChartToolBarFontSizePicker;
begin
  Result := ToolBarPopup.ToolBar.AddFontSizePicker(AIndex);
end;

function TAdvChartView.AddToolBarPopupBitmapPicker(AIndex: Integer = -1): TAdvChartToolBarBitmapPicker;
begin
  Result := ToolBarPopup.ToolBar.AddBitmapPicker(AIndex);
end;

function TAdvChartView.AddToolBarPopupColorPicker(AIndex: Integer = -1): TAdvChartToolBarColorPicker;
begin
  Result := ToolBarPopup.ToolBar.AddColorPicker(AIndex);
end;

function TAdvChartView.AddToolBarPopupItemPicker(AIndex: Integer = -1): TAdvChartToolBarItemPicker;
begin
  Result := ToolBarPopup.ToolBar.AddItemPicker(AIndex);
end;

procedure TAdvChartView.HideToolBarPopup;
var
  p: TAdvChartToolBarPopup;
begin
  FActiveSerie := nil;
  p := ToolBarPopup;
  if Assigned(p) then
    p.Deactivate;
end;

procedure TAdvChartView.ShowToolBarPopupAtSeries(ASerie: TChartSerie);
var
  p: TAdvChartToolBarPopup;
begin
  FActiveSerie := ASerie;
  p := ToolBarPopup;
  if Assigned(p) then
  begin
    p.Placement := ppAboveMouseCenter;
    p.PlacementRectangle.Left := 0;
    p.PlacementRectangle.Top := 0;
    p.PlacementRectangle.Right := 0;
    p.PlacementRectangle.Bottom := 0;
    ActiveSeriesToPopup;
    p.Activate;
  end;
end;

procedure TAdvChartView.ShowToolBarPopupAt(X: Integer; Y: Integer; ASerie: TChartSerie);
var
  p: TAdvChartToolBarPopup;
  pt: TPoint;
begin
  FActiveSerie := ASerie;
  p := ToolBarPopup;
  if Assigned(p) then
  begin
    p.Placement := ppAbsolute;
    pt := ClientToScreen(Point(X, Y));
    p.PlacementRectangle.Left := pt.X;
    p.PlacementRectangle.Top := pt.Y;
    p.PlacementRectangle.Right := pt.X;
    p.PlacementRectangle.Bottom := pt.Y;
    ActiveSeriesToPopup;
    p.Activate;
  end;
end;
{$ENDIF}

function TAdvChartView.XYToSeriePoint(X, Y, Pane: Integer): TChartSeriePoint;
begin
  if (Pane >= 0) and (Pane <= Panes.Count - 1) then
    Result := Panes[Pane].Chart.GetSerieIndexAtXY(X, Y);
end;

procedure TAdvChartView.ZoomSelection(Sender: TObject; Pane, startx, starty,
  endx, endy: integer);
begin
  if Assigned(FOnZoomSelection) then
    FOnZoomSelection(Sender, Pane, startx, starty, endx, endy);
end;

{ TChartPanes }

function TChartPanes.Add: TChartPane;
begin
  Result := TChartPane(inherited Add);
end;

procedure TChartPanes.Changed;
begin
  FOwner.Invalidate;
end;

constructor TChartPanes.Create(AOwner: TAdvChartView);
begin
  inherited Create(AOwner, GetItemClass);
  FOwner := AOwner;
end;

destructor TChartPanes.Destroy;
begin
  inherited;
end;

function TChartPanes.GetItem(Index: Integer): TChartPane;
begin
  Result := TChartPane(inherited GetItem(Index));
end;

function TChartPanes.GetItemClass: TCollectionItemClass;
begin
  Result := TChartPane;
end;

function TChartPanes.Insert(index: integer): TChartPane;
begin
  {$IFDEF DELPHI4_LVL}
  Result := TChartPane(inherited Insert(Index));
  {$ELSE}
  Result := TChartPane(inherited Add);
  {$ENDIF}
end;

procedure TChartPanes.SetItem(Index: Integer; const Value: TChartPane);
begin
  inherited SetItem(Index, Value);
end;

procedure TChartPanes.Update(Item: TCollectionItem);
begin
  inherited;
  Changed;
end;

{ TChartSplitters }

procedure TChartSplitter.Assign(Source: TPersistent);
begin
  if Source is TChartSplitter then
  begin
    FHeight := (Source as TChartSplitter).Height;
    FVisible := (Source as TChartSplitter).Visible;
    FColor := (Source as TChartSplitter).Color;
    FColorTo := (Source as TChartSplitter).ColorTo;
    FGradientSteps := (Source as TChartSplitter).GradientSteps;
    FGradientDirection := (Source as TChartSplitter).GradientDirection;
    FLineColor := (Source as TChartSplitter).LineColor;
    FLineWidth := (Source as TChartSplitter).LineWidth;
  end;
end;

procedure TChartSplitter.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TChartSplitter.Create(AOwner: TPersistent);
begin
  FHeight := 3;
  FVisible := false;
  FColor := clSilver;
  FColorTo := clNone;
  FLineColor := clNone;
  LineWidth := 1;
  FGradientSteps := 100;
  FGradientDirection := cgdHorizontal;
end;

destructor TChartSplitter.Destroy;
begin
  inherited;
end;

procedure TChartSplitter.Draw(Canvas: TCanvas; R: TRect);
begin
  Canvas.Pen.Width := LineWidth;
  Canvas.Pen.Color := LineColor;
  Canvas.Brush.Color := Color;
  if ColorTo = clNone then
    Canvas.Rectangle(Bounds(R.Left,R.Top,R.Right,FHeight))
  else
    DrawGradient(Canvas, FColor, FColorTo, FGradientSteps, Bounds(R.Left,R.Top,R.Right,FHeight), FGradientDirection, False, clNone, 0);

end;

procedure TChartSplitter.LoadFromFile(ini: TMemIniFile; Section: String);
begin
  Color := ini.ReadInteger(Section, 'Color', Color);
  ColorTo := ini.ReadInteger(Section, 'ColorTo', ColorTo);
  GradientSteps := ini.ReadInteger(Section, 'GradientSteps', GradientSteps);
  GradientDirection := TChartGradientDirection(ini.ReadInteger(Section, 'GradientDirection', Integer(GradientDirection)));
  Height := ini.ReadInteger(Section, 'Height', Height);
  LineColor := ini.ReadInteger(Section, 'LineColor', LineColor);
  LineWidth := ini.ReadInteger(Section, 'LineWidth', LineWidth);
  Visible := ini.ReadBool(Section, 'Visible', Visible);
end;

procedure TChartSplitter.SaveToFile(ini: TMemIniFile; Section: String);
begin
  ini.WriteInteger(Section, 'Color', Color);
  ini.WriteInteger(Section, 'ColorTo', ColorTo);
  ini.WriteInteger(Section, 'GradientSteps', GradientSteps);
  ini.WriteInteger(Section, 'GradientDirection', Integer(GradientDirection));
  ini.WriteInteger(Section, 'Height', Height);
  ini.WriteInteger(Section, 'LineColor', LineColor);
  ini.WriteInteger(Section, 'LineWidth', LineWidth);
  ini.WriteBool(Section, 'Visible', Visible);
end;

procedure TChartSplitter.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Changed;
  end;
end;

procedure TChartSplitter.SetColorTo(const Value: TColor);
begin
  if FColorTo <> Value then
  begin
    FColorTo := Value;
    Changed;
  end;
end;

procedure TChartSplitter.SetGradientDirection(
  const Value: TChartGradientDirection);
begin
  if FGradientDirection <> Value then
  begin
    FGradientDirection := Value;
    Changed;
  end;
end;

procedure TChartSplitter.SetGradientSteps(const Value: integer);
begin
  if (FGradientSteps <> Value) and (Value >= 0) then
  begin
    FGradientSteps := Value;
    Changed;
  end;
end;

procedure TChartSplitter.SetHeight(const Value: integer);
begin
  if (FHeight <> Value) and (Value >= 0) then
  begin
    FHeight := Value;
    Changed;
  end;
end;

procedure TChartSplitter.SetLineColor(const Value: TColor);
begin
  if FLineColor <> value then
  begin
    FLineColor := Value;
    Changed;
  end;
end;

procedure TChartSplitter.SetLineWidth(const Value: integer);
begin
  if (FLineWidth <> Value) and (Value >= 0) then
  begin
    FLineWidth := Value;
    Changed;
  end;
end;

procedure TChartSplitter.SetVisible(const Value: boolean);
begin
  if (FVisible <> Value) then
  begin
    FVisible := Value;
    Changed;
  end;
end;
{ TChartTracker }

procedure TChartTracker.Assign(Source: TPersistent);
begin
  FVisible := (Source as TChartTracker).Visible;
  FColor := (Source as TChartTracker).Color;
  FColorTo := (Source as TChartTracker).ColorTo;
  FTop := (Source as TChartTracker).Top;
  FLeft := (Source as TChartTracker).Left;
  FWidth := (Source as TChartTracker).Width;
  FHeight := (Source as TChartTracker).Height;
  FGradientSteps := (Source as TChartTracker).GradientSteps;
  FGradientDirection  := (Source as TChartTracker).GradientDirection;
  FFont.Assign((Source as TChartTracker).Font);
  FTitle.Font.Assign((Source as TChartTracker).Title.Font);
//  FTrackerForm.Assign((Source as TChartTracker).FTrackerForm);
end;

procedure TChartTracker.BeginUpdate;
begin
  inc(FUpdateCount);
end;

procedure TChartTracker.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TChartTracker.Create(AOwner: TAdvChartView);
begin
  FOwner := AOwner;
  FAutoSize := true;
  FFont := TFont.Create;
  FColor := clNone;
  FColorTo := clNone;
  FGradientSteps := 100;
  FGradientDirection := cgdHorizontal;
  FBorderStyle := bsToolWindow;
  FTop := 0;
  FLeft := 0;
  FVisible := false;
  FWidth := 50;
  FHeight := 50;
  FAlphaBlend := false;
  FAlphaBlendValue := 255;

  if Assigned(FOwner) and FOwner.FDesignTime then
  begin
    FOpenValuePrefix := 'O:';
    FHighValuePrefix := 'H:';
    FLowValuePrefix := 'L:';
    FCloseValuePrefix := 'C:';
  end;


  Ftitle := TChartTrackerTitle.Create(AOwner);
  FTitle.OnChange := TitleChanged;
end;

destructor TChartTracker.Destroy;
begin
  FFont.Free;
  FTitle.Free;
  inherited;
end;

procedure TChartTracker.DoAutoSize;
var
  tl: TTrackerList;
  I,J: integer;
begin
  if not AutoSize then
    Exit;

  if not Assigned(FTrackerForm) then
    Exit;

  tl := TTrackerList.Create(FTrackerForm);
  tl.Parent := FTrackerForm;
  tl.Font.Assign(self.Font);
  tl.TitleFont.Assign(Title.Font);
  tl.Width := 100;
  tl.Height := 100;
  tl.Visible := true;

  for I := 0 to FOwner.Panes.Count - 1 do
  begin
    with FOwner.Panes[I] do
    begin
      if CrossHair.CrossHairYValues.ShowSerieValues and (chValueTracker in CrossHair.CrossHairYValues.Position) then
      begin
        for J := 0 to Series.Count - 1 do
        begin
          with Series[J] do
          begin
            if (ChartType in [ctOHLC,ctCandleStick,ctLineCandleStick]) then
            begin
              with tl.Items.Add do
              begin
                Color := Series[J].Color;
                TextColor := Font.Color;
                Text.Add(LegendText+': ');
                with TCrackedChartSerie(Series[j]) do
                begin
                  Text.Add(HighValuePrefix + Format(ValueFormat,[MaximumValue]));
                  Text.Add(OpenValuePrefix + Format(ValueFormat,[MaximumValue]));
                  Text.Add(CloseValuePrefix + Format(ValueFormat,[MaximumValue]));
                  Text.Add(LowValuePrefix + Format(ValueFormat,[MaximumValue]));
                end;
              end;
            end
            else
            begin
              with tl.Items.Add do
              begin
                Color := Series[j].Color;
                TextColor := Font.Color;
                Text.Add(LegendText+': ');
                Text.Add(Format(Series[J].ValueFormat,[TCrackedChartSerie(Series[j]).MaximumValue]));
              end;
            end;
          end;
        end;
      end;
    end;
  end;

  tl.Paint;

  FTrackerForm.Width := tl.GetSize.cx + 2 + GetSystemMetrics(SM_CXEDGE) * 2;
  FTrackerForm.Height := tl.GetSize.cy + GetSystemMetrics(SM_CYCAPTION);
  tl.Free;
end;

procedure TChartTracker.SetValues;
var
  I, J, pt: Integer;
  point: TSeriePoint;
begin

  if Visible and Assigned(FTrackerForm) then
  begin
    FTrackerForm.TrackerList.Items.Clear;

    for I := 0 to FOwner.Panes.Count - 1 do
    begin
      with FOwner.Panes[I] do
      begin
        if CrossHair.CrossHairYValues.ShowSerieValues and (chValueTracker in FOwner.Panes[I].CrossHair.CrossHairYValues.Position) then
        begin
          for J := 0 to Series.Count - 1 do
          begin
            with Series[J] do
            begin
              if Length(FVerticalCrossHairPoints) > 0 then
              begin
                for pt := 0 to Length(FVerticalCrossHairPoints) - 1 do
                begin
                  Point := FVerticalCrossHairPoints[pt];
                  if (point.Serie = J) and (point.PointType = cspSerie) then
                  begin
                    if (ChartType in [ctOHLC,ctCandleStick,ctLineCandleStick]) then
                    begin
                      with FTrackerForm.TrackerList.Items.Add do
                      begin
                        Color := Series[j].Color;
                        TextColor := Font.Color;
                        Text.Add(LegendText+': ');
                        Text.Add(HighValuePrefix + Format(Series[J].ValueFormat,[Series[J].GetChartPoint(point.Point).HighValue]));
                        Text.Add(OpenValuePrefix + Format(Series[J].ValueFormat,[Series[J].GetChartPoint(point.Point).OpenValue]));
                        Text.Add(CloseValuePrefix + Format(Series[J].ValueFormat,[Series[J].GetChartPoint(point.Point).CloseValue]));
                        Text.Add(LowValuePrefix + Format(Series[J].ValueFormat,[Series[J].GetChartPoint(point.Point).LowValue]));
                      end;
                    end
                    else
                    begin
                      if ShowValueInTracker then
                        with FTrackerForm.TrackerList.Items.Add do
                        begin
                          Color := Series[j].Color;
                          TextColor := Font.Color;
                          Text.Add(LegendText+': ');
                          if (Series[J].ChartType = ctXYLine) or (Series[J].ChartType = ctXYDigitalLine) or (Series[J].ChartType = ctXYMarkers) then
                            Text.Add(Format(Series[J].ValueFormat,[point.SerieValue]))
                          else
                            Text.Add(Format(Series[J].ValueFormat,[Series[J].GetChartPoint(point.Point).SingleValue]))
                        end;
                    end;
                  end;
                end;
              end
              else
              begin
                if ShowValueInTracker then
                begin
                  with FTrackerForm.TrackerList.Items.Add do
                  begin
                    Color := Series[j].Color;
                    TextColor := Font.Color;
                    Text.Add(LegendText+': ');
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;

  FTrackerForm.TrackerList.Invalidate;

  Exit;
end;

procedure TChartTracker.EndUpdate;
begin
  if FUpdateCount > 0 then
  begin
    dec(FUpdateCount);
  end;
end;

procedure TChartTracker.LoadFromFile(ini: TMemIniFile; Section: String);
var
  A: TStringList;
  I: integer;
  str: String;
begin
  AlphaBlend := ini.ReadBool(Section, 'AlphaBlend', AlphaBlend);
  AlphaBlendValue := ini.ReadInteger(Section, 'AlphaBlendValue', AlphaBlendValue);
  AutoSize := ini.ReadBool(Section, 'AutoSize', AutoSize);
  BorderStyle := TFormBorderStyle(ini.ReadInteger(Section, 'BorderStyle', Integer(BorderStyle)));
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
  GradientSteps := ini.ReadInteger(Section, 'GradientSteps', Integer(GradientSteps));
  Height := ini.ReadInteger(Section, 'Height', Height);
  Left := ini.ReadInteger(Section, 'Left', Left);
  Top := ini.ReadInteger(Section, 'Top', Top);
  Visible := ini.ReadBool(Section, 'Visible', Visible);
  Width := ini.ReadInteger(Section, 'Width', Width);
  Title.LoadFromFile(ini, Section + '.Title');
end;

procedure TChartTracker.SaveToFile(ini: TMemIniFile; Section: String);
begin
  ini.WriteBool(Section, 'AlphaBlend', AlphaBlend);
  ini.WriteInteger(Section, 'AlphaBlendValue', AlphaBlendValue);
  ini.WriteBool(Section, 'AutoSize', AutoSize);
  ini.WriteInteger(Section, 'BorderStyle', Integer(BorderStyle));
  ini.WriteInteger(Section, 'Color', Color);
  ini.WriteInteger(Section, 'ColorTo', ColorTo);
  ini.WriteInteger(Section, 'FontSize', Font.Size);
  ini.WriteInteger(Section, 'FontColor', Font.Color);
  ini.WriteString(Section, 'FontName', Font.Name);
  ini.WriteString(Section, 'FontStyle', GetFontStyles(Font.Style));
  ini.WriteInteger(Section, 'GradientDirection', Integer(GradientDirection));
  ini.WriteInteger(Section, 'GradientSteps', Integer(GradientSteps));
  ini.WriteInteger(Section, 'Height', Height);
  ini.WriteInteger(Section, 'Left', Left);
  ini.WriteInteger(Section, 'Top', Top);
  ini.WriteBool(Section, 'Visible', Visible);
  ini.WriteInteger(Section, 'Width', Width);
  Title.SaveToFile(ini, Section + '.Title');
end;

procedure TChartTracker.SetAlphaBlend(const Value: Boolean);
begin
  if FAlphaBlend <> Value then
  begin
    FAlphaBlend := Value;
    Changed;
  end;
end;

procedure TChartTracker.SetAlphaBlendValue(const Value: Byte);
begin
  if FAlphaBlendValue <> Value then
  begin
    FAlphaBlendValue := Value;
    Changed;
  end;
end;

procedure TChartTracker.SetAutoSize(const Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    Changed;
  end;
end;

procedure TChartTracker.SetBorderStyle(const Value: TFormBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    Changed;
  end;
end;

procedure TChartTracker.SetCloseValuePrefix(const Value: string);
begin
  if FCloseValuePrefix <> Value then
  begin
    FCloseValuePrefix := Value;
    Changed;
  end;
end;

procedure TChartTracker.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Changed;
  end;
end;

procedure TChartTracker.SetColorTo(const Value: TColor);
begin
  if FColorTo <> Value then
  begin
    FColorTo := Value;
    Changed;
  end;
end;

procedure TChartTracker.SetFont(const Value: TFont);
begin
  if FFont <> Value then
  begin
    FFont.Assign(Value);
    Changed;
  end;
end;

procedure TChartTracker.SetGradientDirection(
  const Value: TChartGradientDirection);
begin
  if FGradientDirection <> Value then
  begin
    FGradientDirection := Value;
    Changed;
  end;
end;

procedure TChartTracker.SetGradientSteps(const Value: integer);
begin
  if (FGradientSteps <> Value) and (Value >= 0) then
  begin
    FGradientSteps := Value;
    Changed;
  end;
end;

procedure TChartTracker.SetHeight(const Value: integer);
begin
  if (FHeight <> value) and (Value >= 0) then
  begin
    FHeight := Value;
    Changed;
  end;
end;

procedure TChartTracker.SetHighValuePrefix(const Value: string);
begin
  if FHighValuePrefix <> Value then
  begin
    FHighValuePrefix := Value;
    Changed;
  end;
end;

procedure TChartTracker.SetLeft(const Value: integer);
begin
  if FLeft <> value then
  begin
    FLeft := Value;
    Changed;
  end;
end;

procedure TChartTracker.SetLowValuePrefix(const Value: string);
begin
  if FLowValuePrefix <> Value then
  begin
    FLowValuePrefix := Value;
    Changed;
  end;
end;

procedure TChartTracker.SetOpenValuePrefix(const Value: string);
begin
  if FOpenValuePrefix <> Value then
  begin
    FOpenValuePrefix := Value;
    Changed;
  end;
end;

procedure TChartTracker.SetTitle(const Value: TChartTrackerTitle);
begin
  if FTitle <> Value then
  begin
    FTitle.Assign(Value);
    TitleChanged(Self);
  end;
end;

procedure TChartTracker.SetTop(const Value: integer);
begin
  if FTop <> value then
  begin
    FTop := Value;
    Changed;
  end;
end;

procedure TChartTracker.SetTrackerFormSize(Canvas: TCanvas);
var
  th, tw, strmin, strmax: integer;
  I,J,K: Integer;
  max, min: double;
  twmax, twmin: integer;
  TotalSeriesCount: integer;
  maxtextw: integer;
begin
  Exit;

  tw := 0;
  strmin := 0;
  strmax := 0;
  max := 0;
  canvas.Font.Assign(Title.Font);
  TotalSeriesCount := 0;
  maxtextw := 0;

  for I := 0 to FOwner.Panes.Count - 1 do
  begin
    with FOwner.Panes[I] do
    begin
      for K := 0 to Series.Count - 1 do
      begin
        with Series.Items[K] do
        begin
          th := TPaintBox(FTrackerForm.Controls[0]).Canvas.TextWidth(LegendText);
          if maxtextw < th  then
            maxtextw := th;
        end;
      end;
    end;
  end;


  for K := 0 to FOwner.Panes.Count - 1 do
  begin
    TotalSeriesCount := TotalSeriesCount + FOwner.Panes[K].Series.Count;
  end;

  Canvas.Font.Assign(Font);
  for I := 0 to FOwner.Panes.Count - 1 do
  begin
    with FOwner.Panes[I] do
    begin
      for J := 0 to Series.Count - 1 do
      begin
        with TCrackedChartSerie(Series[J]) do
        begin
          if (SerieType <> stZoomControl) and Visible then
          begin
            max := 12345678;
            min := 12345678;
            twmin := Canvas.TextWidth(floattostr(min));
            twmax := Canvas.TextWidth(floattostr(max));

            case ChartType of
              ctNone: ;
              ctLine, ctArea, ctBar, ctLineBar, ctHistogram, ctLineHistogram, ctXYLine, ctXYDigitalLine:
              begin
                strmin := twmin + 10;
              end;
              ctCandleStick, ctLineCandleStick, ctOHLC:
              begin
              begin
                strmin := twmin * 4;
                strmax := (twmax * 4) + 40;
              end;
              end;
            end;

            if strmin > strmax then
              tw := strmin;
            if strmin < strmax then
              tw := strmax;
          end;
        end;
      end;
    end;
  end;
  Th := Canvas.TextHeight(floattostr(max)) + Title.Size;
  FTrackerForm.SetBounds(Left, Top, maxtextw +  tw, th * TotalSeriesCount); //(th * TotalSeriesCount));
end;

procedure TChartTracker.SetVisible(const Value: Boolean);
begin
  if FVisible <> value then
  begin
    FVisible := Value;
    if Assigned(FTrackerForm) then
      FTrackerForm.Visible := Value;
    Changed;
  end;
end;

procedure TChartTracker.SetWidth(const Value: integer);
begin
  if FWidth <> Value then
  begin
    FWidth := Value;
    Changed;
  end;
end;

procedure TChartTracker.TitleChanged(Sender: TObject);
begin
  Changed;
end;

{ TChartTrackerTitle }

procedure TChartTrackerTitle.Assign(Source: TPersistent);
begin
  inherited;
  FColor := (Source as TChartTrackerTitle).Color;
  FColorTo := (Source as TChartTrackerTitle).ColorTo;
  FFont.Assign((Source as TChartTrackerTitle).Font);
  FText := (Source as TChartTrackerTitle).Text;
  FGradientDirection := (Source as TChartTrackerTitle).GradientDirection;
  FGradientSteps := (Source as TChartTrackerTitle).GradientSteps;
  FSize := (Source as TChartTrackerTitle).Size;
end;

procedure TChartTrackerTitle.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TChartTrackerTitle.Create(AOwner: TadvchartView);
begin
  FFont := TFont.Create;
  FColor := clNone;
  FColorTo := clNone;
  FText := 'TRACKER';
  FGradientDirection := cgdHorizontal;
  FGradientSteps := 100;
  FSize := 20;
end;

destructor TChartTrackerTitle.Destroy;
begin
  FFont.free;
  inherited;
end;

procedure TChartTrackerTitle.LoadFromFile(ini: TMemIniFile; Section: String);
var
  str: String;
  A: TStringList;
  I: Integer;
begin
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
  Size := ini.ReadInteger(Section, 'Size', Size);
  Text := ini.ReadString(Section, 'Text', Text);
end;

procedure TChartTrackerTitle.SaveToFile(ini: TMemIniFile; Section: String);
begin
  ini.WriteInteger(Section, 'Color', Color);
  ini.WriteInteger(Section, 'ColorTo', ColorTo);
  ini.WriteInteger(Section, 'FontSize', Font.Size);
  ini.WriteInteger(Section, 'FontColor', Font.Color);
  ini.WriteString(Section, 'FontName', Font.Name);
  ini.WriteString(Section, 'FontStyle', GetFontStyles(Font.Style));
  ini.WriteInteger(Section, 'GradientDirection', Integer(GradientDirection));
  ini.WriteInteger(Section, 'GradientSteps', GradientSteps);
  ini.WriteInteger(Section, 'Size', Size);
  ini.WriteString(Section, 'Text', Text);
end;

procedure TChartTrackerTitle.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Changed;
  end;
end;

procedure TChartTrackerTitle.SetColorTo(const Value: TColor);
begin
  if FColorTo <> Value then
  begin
    FColorTo := Value;
    Changed;
  end;
end;

procedure TChartTrackerTitle.SetFont(const Value: TFont);
begin
  if FFont <> value then
  begin
    FFont.Assign(Value);
    Changed;
  end;
end;

procedure TChartTrackerTitle.SetGradientDirection(
  const Value: TChartGradientDirection);
begin
  if FGradientDirection <> Value then
  begin
    FGradientDirection := Value;
    Changed;
  end;
end;

procedure TChartTrackerTitle.SetGradientSteps(const Value: Integer);
begin
  if (FGradientSteps <> Value) and (Value >= 0) then
  begin
    FGradientSteps := Value;
    Changed;
  end;
end;

procedure TChartTrackerTitle.SetSize(const Value: integer);
begin
  if (FSize <> Value) and (Value >= 0) then
  begin
    FSize := Value;
    Changed;
  end;
end;

procedure TChartTrackerTitle.SetText(const Value: String);
begin
  if (FText <> Value) then
  begin
    FText := Value;
    Changed;
  end;
end;

{ TTrackerForm }

procedure TTrackerForm.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  (Owner as TAdvChartView).MouseMove(Shift,X,Y);
end;

procedure TTrackerForm.WMMove(var Message: TWMMove);
begin
  inherited;

  if Assigned(FOnMove) then
  begin
    FOnMove(Self,Message.XPos, Message.YPos);
  end;
end;

procedure TTrackerForm.WMNCHitTest(var Message: TWMNCHitTest);
begin
  inherited;

  if Message.Result <> HTCAPTION then
    Message.Result := HTTRANSPARENT;
end;

{ TTrackerItems }

function TTrackerItems.Add: TTrackerItem;
begin
  Result := TTrackerItem(inherited Add);
end;

constructor TTrackerItems.Create;
begin
  inherited Create(TTrackerItem);
end;

function TTrackerItems.GetItem(Index: Integer): TTrackerItem;
begin
  Result := TTrackerItem(inherited Items[Index]);
end;

function TTrackerItems.Insert(Index: Integer): TTrackerItem;
begin
  Result := TTrackerItem(inherited Insert(Index));
end;

procedure TTrackerItems.SetItem(Index: Integer; const Value: TTrackerItem);
begin
  inherited Items[Index] := Value;
end;

{ TTrackerList }

constructor TTrackerList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FTrackerItems := TTrackerItems.Create;
  FTitleFont := TFont.Create;
  FColorTo := clNone;
end;

destructor TTrackerList.Destroy;
begin
  FTrackerItems.Free;
  FTitleFont.Free;
  inherited;
end;

function TTrackerList.GetSize: TSize;
begin
  Result := FSize;
end;

procedure TTrackerList.LoadFromFile(ini: TMemIniFile; Section: String);
var
  A: TStringList;
  I: integer;
  str: string;
begin
  Align := TAlign(ini.ReadInteger(Section, 'Align', Integer(Align)));

  str := ini.ReadString(name, 'Anchors', '');
  A := TStringList.Create;
  Split(':',str, A);
  for I := 1 to A.Count - 1 do
  begin
    Anchors := Anchors + [TAnchorKind(strtoint(A[I]))];
  end;
  A.Free;
  Constraints := TSizeConstraints(ini.ReadInteger(Section,'Constraints', Integer(Constraints)));
  ColorTo := ini.ReadInteger(Section, 'ColorTo',ColorTo);
  Font.Size := ini.ReadInteger(Section, 'FontSize', Font.Size);
  Font.Color := ini.ReadInteger(Section, 'FontColor', Font.Color);
  Font.Name := ini.ReadString(Section, 'FontName', Font.Name);
  str := ini.ReadString(name, 'FontStyle', '');
  A := TStringList.Create;
  Split(':',str, A);
  for I := 1 to A.Count - 1 do
  begin
    Font.Style := Font.Style + [TFontStyle(strtoint(A[I]))];
  end;
  A.Free;
  GradientDirection := TChartGradientDirection(ini.ReadInteger(Section, 'GradientDirection', Integer(GradientDirection)));
  for I := 0 to Items.Count - 1 do
  begin
    Items[I].LoadFromFile(ini,Section + ':' + 'TrackerListItems');
  end;
  Title := ini.ReadString(Section, 'Title', Title);
  TitleFont.Size := ini.ReadInteger(Section, 'TitleFontSize', TitleFont.Size);
  TitleFont.Color := ini.ReadInteger(Section, 'TitleFontColor', TitleFont.Color);
  TitleFont.Name := ini.ReadString(Section, 'TitleFontName', TitleFont.Name);
  str := ini.ReadString(Section, 'TitleFontStyle', '');
  A := TStringList.Create;
  Split(':',str, A);
  for I := 1 to A.Count - 1 do
  begin
    TitleFont.Style := TitleFont.Style + [TFontStyle(strtoint(A[I]))];
  end;
  A.Free;
  Visible := ini.ReadBool(Section, 'Visible', Visible);
end;

procedure TTrackerList.Paint;
const
  textvspacing = 4;
  texthspacing = 4;

var
  i,j: integer;
  th,tw,rt,mw: integer;
  r: TRect;
  twa: array[0..5] of integer;

begin
  r := ClientRect;

  rt := r.Top;

  DrawGradient(Canvas,Color,ColorTo,128,r,FGradientDirection, false, clNone, 0);

  if (Title <> '') then
  begin
    Canvas.Font.Assign(TitleFont);
    th := Canvas.TextHeight('gh') + textvspacing;
    Canvas.TextOut(2, r.Top, Title);
    r.Top := r.Top + th;
  end;

  Canvas.Font.Assign(Font);
  th := Canvas.TextHeight('gh') + textvspacing;

  for i := 0 to 5 do
    twa[i] := 0;

  for i := 0 to FTrackerItems.Count - 1 do
  begin
    for j := 0 to Min(5, FTrackerItems[i].Text.Count - 1) do
    begin
      tw := Canvas.TextWidth(FTrackerItems[i].Text[j]) + texthspacing;
      if tw > twa[j + 1] then
        twa[j + 1] := tw;
    end;
  end;

  for i := 1 to 5 do
    twa[i] := twa[i - 1] + twa[i];

  mw := 0;

  for i := 0 to FTrackerItems.Count - 1 do
  begin
    r.Bottom := r.Top + th;

    Canvas.Brush.Color := FTrackerItems[i].Color;
    Canvas.Pen.Color := FTrackerItems[i].Color;
    Canvas.Rectangle(r);
    Canvas.Font.Color := FTrackerItems[i].TextColor;

    for j := 0 to Min(5, FTrackerItems[i].Text.Count - 1) do
    begin
      Canvas.TextOut(Max(2,twa[j]),r.Top,FTrackerItems[i].Text[j]);
      tw := Canvas.TextWidth(FTrackerItems[i].Text[j]);
      if (Max(2,twa[j]) + tw > mw) then
        mw := Max(2,twa[j]) + tw;
    end;

    r.Top := r.Top + th;
  end;

  FSize.cy := r.Bottom - rt;
  FSize.cx := mw;
end;

procedure TTrackerList.SaveToFile(ini: TMemIniFile; Section: String);
var
  I: Integer;
begin
  ini.WriteInteger(Section, 'Align', Integer(Align));
  ini.WriteString(Section,'Anchors',GetAnchors(Anchors));
  ini.WriteInteger(Section,'Constraints', Integer(Constraints));
  ini.WriteInteger(Section, 'ColorTo',ColorTo);
  ini.WriteInteger(Section, 'FontSize', Font.Size);
  ini.WriteInteger(Section, 'FontColor', Font.Color);
  ini.WriteString(Section, 'FontName', Font.Name);
  ini.WriteString(Section, 'FontStyle', GetFontStyles(Font.Style));
  ini.WriteInteger(Section, 'GradientDirection', Integer(GradientDirection));
  for I := 0 to Items.Count - 1 do
  begin
    Items[I].SaveToFile(ini,Section + ':' + 'TrackerListItems');
  end;
  ini.WriteString(Section, 'Title', Title);
  ini.WriteInteger(Section, 'TitleFontSize', TitleFont.Size);
  ini.WriteInteger(Section, 'TitleFontColor', TitleFont.Color);
  ini.WriteString(Section, 'TitleFontName', TitleFont.Name);
  ini.WriteString(Section, 'TitleFontStyle', GetFontStyles(TitleFont.Style));
  ini.WriteBool(Section, 'Visible', Visible);
end;

procedure TTrackerList.SetColorTo(const Value: TColor);
begin
  if (FColorTo <> Value) then
  begin
    FColorTo := Value;
    Invalidate;
  end;
end;

procedure TTrackerList.SetGradientDirection(
  const Value: TChartGradientDirection);
begin
  if (FGradientDirection <> Value) then
  begin
    FGradientDirection := Value;
    Invalidate;
  end;
end;

procedure TTrackerList.SetTitle(const Value: string);
begin
  FTitle := Value;
  Invalidate;
end;

procedure TTrackerList.SetTitleFont(const Value: TFont);
begin
  FTitleFont.Assign(Value);
end;

procedure TTrackerList.SetTrackerItems(const Value: TTrackerItems);
begin
  FTrackerItems.Assign(Value);
end;

procedure TTrackerList.WMNCHitTest(var Message: TWMNCHitTest);
begin
  Message.Result := HTTRANSPARENT;
end;

{ TTrackerItem }

constructor TTrackerItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FText := TStringList.Create;
end;

destructor TTrackerItem.Destroy;
begin
  FText.Free;
  inherited;
end;

procedure TTrackerItem.LoadFromFile(ini: TMemIniFile; Section: String);
var
  cnt, I: integer;
begin
  TextColor := ini.ReadInteger(Section, 'TextColor', TextColor);
  Color := ini.ReadInteger(Section, 'Color', Color);
  cnt := ini.ReadInteger(Section, 'StringCount', Text.Count);
  for I := 0 to cnt - 1 do
  begin
    Text.Add(ini.ReadString(Section, 'Text:' + inttostr(I), ''));
  end;
end;

procedure TTrackerItem.SaveToFile(ini: TMemIniFile; Section: String);
var
  I: Integer;
  str: String;
begin
  ini.WriteInteger(Section, 'TextColor', TextColor);
  ini.WriteInteger(Section, 'Color', Color);
  str := '';
  ini.WriteInteger(Section, 'StringCount', Text.Count);
  for I := 0 to Text.Count - 1 do
  begin
    ini.WriteString(Section, 'Text:' + inttostr(I), Text[I]);
  end;
end;

procedure TTrackerItem.SetText(const Value: TStringList);
begin
  FText.Assign(Value);
end;

{$IFDEF FREEWARE}
{$IFNDEF DELPHIXE2_LVL}
{$I TRIAL.INC}
{$ENDIF}
{$ENDIF}


end.
