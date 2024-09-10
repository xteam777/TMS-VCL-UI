{***************************************************************************}
{ TAdvChart design time support                                             }
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

unit AdvChartView3DDE;

interface

{$I TMSDEFS.INC}

uses
  AdvChart, AdvChartView3D, AdvChartSerieEditor3D, AdvChartPointEditor3D,
  {$IFDEF DELPHI6_LVL}
  DesignIntf, DesignEditors
  {$ELSE}
  DsgnIntf
  {$ENDIF}
  ;

type

  TChartSeriesProperty = class(TClassProperty)
  public
    function GetAttributes:TPropertyAttributes; override;
    procedure Edit; override;
  end;

  TChartPointsProperty = class(TClassProperty)
  public
    function GetAttributes:TPropertyAttributes; override;
    procedure Edit; override;
  end;

  procedure Register;

implementation

uses
  Forms;


procedure Register;
begin
  RegisterPropertyEditor(TypeInfo(TChartSeries3D),TAdvChartView3D,'Series',TChartSeriesProperty);
  RegisterPropertyEditor(TypeInfo(TChartItems3D), TChartSerie3D, 'Items', TChartPointsProperty);
end;

{ TChartPointsProperty }

procedure TChartPointsProperty.Edit;
var
  ItemsEditor: TAdvChartPointEditorForm3D;
  Serie: TChartSerie3D;
begin
  ItemsEditor := TAdvChartPointEditorForm3D.Create(Application);
  Serie := TChartSerie3D(GetComponent(0));
  ItemsEditor.ChartItems := Serie.Items;
  ItemsEditor.Chartview := Serie.Chart;
  ItemsEditor.Init;
  try
    ItemsEditor.ShowModal;
  finally
    Modified;
    Serie.Chart.UpdateChart;
    ItemsEditor.Free;
  end;
end;

function TChartPointsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

{ TChartSeriesProperty }

procedure TChartSeriesProperty.Edit;
var
  SerieEditor: TAdvChartSeriesEditorForm3D;
  c: TAdvChartView3D;
begin
  SerieEditor := TAdvChartSeriesEditorForm3D.Create(Application);
  c := TAdvChartView3D(GetComponent(0));
  SerieEditor.ChartSeries := c.Series;
  SerieEditor.ChartView := c;
  SerieEditor.Init;
  SerieEditor.ShowModal;
  Modified;
  c.Invalidate;
  SerieEditor.Free;
end;

function TChartSeriesProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;


end.
