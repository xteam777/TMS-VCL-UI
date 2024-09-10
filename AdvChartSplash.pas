{***************************************************************************}
{ TAdvChartView component                                                   }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 2012 - 2016                                        }
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

unit AdvChartSplash;

interface

const
  MAJ_VER = 4; // Major version nr.
  MIN_VER = 2; // Minor version nr.
  REL_VER = 1; // Release nr.
  BLD_VER = 3; // Build nr.
  DATE_VER = 'JULY, 2018'; // Month version

  //version history
  //v3.5.0.0 : New : OpenGL 3D Pie Chart.
  //v3.5.1.0 : New : ValueOffsetX and ValueOffsetY properties on serie level to position values
  //         : Fixed : Issue with serie crosshairs when used in zoom control
  //v3.5.2.0 : New : CtrlZooming property on pane level to zoom with a draggable area and the CTRL Key.
  //         : New : OnGetCrossHairValue event to customize crosshair values
  //         : Fixed : Issue with X-Grid line position
  //         : Fixed : Issue with crosshair line drawing
  //v3.5.2.1 : Fixed : Issue with Delphi 2007 package
  //v3.5.2.2 : Fixed : Issue with 3D Form editor
  //v3.5.2.3 : Fixed : Issue with intraweb chart in combination with regions
  //v3.5.2.4 : Fixed : Issue with title and 3D enabled charts
  //         : Improved : title position vertical with VerticalAlignment property
  //v3.6.0.0 : New : Delphi & C++Builder XE4 support
  //         : New : 64-bit support
  //         : Improved : title position vertical with Vertica lAlignment property
  //         : Fixed : Issue with title and 3D enabled charts
  //v3.6.0.1 : Fixed : Issue with form files
  //v3.6.0.2 : Fixed : Issue with OnLegendClick
  //v3.6.0.3 : Fixed : Issue with IntraWeb package for C++Builder
  //v3.6.0.4 : Fixed : Issue with memory leak when creating multiple instances in TAdvChartView3D
  //v3.6.1.0 : New : Intraweb 12.2.x support
  //         : New : Intraweb 14.0.x support
  //         : New : XE4 Intraweb support
  //v3.6.1.1 : Fixed : Issue with Top and Left properties not being used
  //v3.6.2.0 : New : PercentageFormat property
  //         : New : OnGetLabelValue event
  //v3.6.3.0 : New : Display spider values outside grid area with OnGetGridPieLineValue
  //v3.6.3.1 : Fixed : Issue with explicit properties in DFM file
  //v3.6.4.0 : New : SaveToStream method
  //         : New : XE5 support
  //         : Fixed: Issue with maximum vertex count, causing wrong shading
  //v3.6.4.1 : Fixed : Issue displaying crosshairs in combination with zoomcontrol
  //v3.6.5.0 : New : Intraweb 14 support in XE5
  //v3.7.0.0 : New : Funnel Chart type
  //v3.7.0.1 : Fixed : Issue with ZoomControl.Assign()
  //         : Fixed : Issue with selecting point in XY charts
  //v3.7.0.2 : Fixed : Issue with charttype xyline and undefined points
  //v3.7.0.3 : Fixed : Issues with handling one point pie chart click / selection detection
  //v3.7.0.4 : Fixed : Issue with pie slice detection
  //v3.7.0.5 : Fixed : Issue with demo due to recent changes
  //v3.7.0.6 : Fixed : Issue with pie slice drawing with small values
  //v3.7.0.7 : Fixed : Issue with rounding pie slice values
  //v3.8.0.0 : New : XE6 Support
  //         : Improved : Undefined area chart points
  //v3.8.0.1 : Improved : Moving average calculation
  //v3.8.0.2 : New : XE6 Intraweb Support
  //         : Fixed : Issue with intialization of rects in X-Axis calculation
  //v3.8.0.3 : Fixed : Issue with out of range exception when drawing annotations
  //v3.8.0.4 : Improved : Gantt annotation drawing
  //         : Fixed : Issue with small pie values and single point pie charts
  //v3.8.1.0 : New : XE7 Support
  //v3.8.1.1 : Fixed : Issue with horizontal / vertical lines not visible
  //v3.8.1.2 : Fixed : Issue with C++Builder compilation in AdvOpenGLUtil
  //         : Fixed : Issue with XE7 tmsdefs.inc file for Intraweb
  //v3.8.1.3 : Fixed : Issue with assignment of events
  //v3.8.1.4 : Fixed : Issue with C++ linker on CreateMetaFile (use CreateMeta instead)
  //v3.8.1.5 : Improved : FieldByName Text instead of AsString for X-Axis field value
  //v3.8.1.6 : Fixed : Issues with compilation in C++Builder 2009
  //v3.8.1.7 : Fixed : Issue with DB version updating and managing connections
  //v3.8.1.8 : Fixed : Issue with placement of crosshair values
  //v3.8.1.9 : Improved : Intraweb Packages for XE7 with iw14.0.x support
  //v3.8.2.0 : Improved : Automated installer improvement for file caching issues
  //         : Fixed : Issue with xscale offset and CTRL zooming
  //v3.8.2.1 : Improved : X-axis label generation in chart from a TAdvStringGrid via TAdvChartLink
  //v3.8.2.2 : Fixed : Issue with canvas region not applied when drawing
  //v3.8.2.3 : Fixed : Issue with updating values in tracker for XY type charts
  //v3.8.3.0 : New : Support for Delphi XE8 & C++Builder XE8 Prof, Ent. Architect added
  //         : Fixed : Issue with x-axis values not drawn under certain circumstances
  //         : Fixed : Issue with values returned from CTRL zooming region not valid
  //         : Fixed : Issue with mouse interaction on series that are not visible
  //v3.8.3.1 : Improved : Drawing of crosshair values
  //v3.8.4.0 : New : ctXYDigitalLine chart type
  //v3.8.4.1 : Fixed : Issue with C++Builder 64-bit linking with GDI+ version
  //v3.8.4.2 : Improved : Intraweb Packages for XE8 with iw14.0.0 support
  //v3.8.4.3 : Re-upload of v3.8.4.2
  //v3.8.4.4 : Improved : Added missing iw14.0.X package for XE8
  //v3.8.4.5 : Improved : Multiline text drawing in title bar when align = taAlignTop
  //v3.8.5.0 : New : Support for Delphi 10 Seattle & C++Builder 10 Seattle Prof, Ent. Architect added
  //v3.8.6.0 : New : Intraweb Packages for Delphi 10 Seattle with iw14.0.0 support
  //v3.8.6.1 : Fixed : Issue with zooming in and small values out of range now limited with ZOOMMIN constant
  //         : Fixed : Issue with Intraweb package dependencies
  //v3.8.7.0 : New : Pie slice click detection in AdvChartView3D through an OnItemClick event
  //v3.8.7.1 : Fixed : Issue with tickmark calculation on x-axis
  //v3.9.0.0 : New : virtual mode
  //         : Fixed : Range check error
  //         : Fixed : Issue with crosshair drawing
  //v3.9.0.1 : Fixed : Issue with xy conversion persistence
  //v3.9.1.0 : New : ZoomingTouchMode to allow zooming an area without the CTRL key
  //         : Fixed : Issue with drawing of markers and values in horizontal mode
  //v3.9.1.1 : Fixed : Issue with tickmarks still drawing with defaultdraw := false in OnYAxisDrawValue event
  //v3.9.1.2 : Fixed : Issue with X-Axis value added through AddSingleXYPoint not drawn at the correct position.
  //v4.0.0.0 : New : TAdvChartViewPDFIO component to export Chart to PDF
  //v4.0.0.1 : Fixed : Issue with setting color in TAdvChartView3D
  //v4.0.1.0 : New: Intraweb Packages for Delphi 10 Seattle with iw14.0.x support
  //         : Fixed : Division by zero when drawing gradients
  //v4.0.1.1 : Fixed : Issue updating correct version number
  //v4.1.0.0 : New : RAD Studio 10.1 Berlin Support
  //v4.1.1.0 : New : Intraweb Packages for Delphi 10.1 Berlin with iw14.0.x support
  //v4.1.1.1 : Fixed : Various fixes and improvements in editors and drawing
  //v4.1.1.2 : Fixed : Issues in handling ctrl zooming
  //v4.1.1.3 : Fixed : Missing Intraweb 14 packages for Delphi 2009, 2010 and XE
  //v4.2.0.0 : New : Popup toolbar to configure series visuals (XE2 and newer)
  //         : Improved : Product name change for consistency
  //v4.2.0.1 : Improved : X-Axis and Y-Axis Auto-size by default and are not visible when setting the ChartType to a pie chart variant.
  //         : Fixed : Issue with clearing data in DB version of TAdvChartView
  //         : Fixed : Issue with "Show Sample Values" option not being persisted.
  //v4.2.0.2 : Fixed : Issue with detecting negative bars
  //v4.2.1.0 : New : RAD Studio 10.2 Tokyo Support
  //v4.2.1.1 : Fixed : Issue with bar text drawing in GDI+ version of chart
  //v4.2.1.2 : Improved : tips and FAQ designtime helpers
  //v4.2.1.3 : Fixed : Issue with saving YValuesOffsetX and YValuesOffsetY

  
procedure Register;
 
implementation
 
uses
  ToolsApi, Classes, Graphics, SysUtils, DesignIntf, Dialogs;

  {$I TMSProductSplash.inc}

procedure Register;
begin
  ForceDemandLoadState(dlDisable);
  AddSplash;
end;

end.
