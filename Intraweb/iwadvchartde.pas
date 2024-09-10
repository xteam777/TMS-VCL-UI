{***************************************************************************}
{ TMS Advanced Charts for IntraWeb                                          }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 2012                                               }
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

unit IWAdvChartDE;

interface

{$I TMSDEFS.INC}

uses
  AdvChartViewGDIP, IWAdvChart, Classes, Dialogs, AdvChartSerieEditorGDIP,
  {$IFDEF DELPHI6_LVL}
  DesignIntf, DesignEditors
{$ELSE}
  DsgnIntf
{$ENDIF}
  ;

type

  TChartSeriesGDIPProperty = class(TClassProperty)
  public
    function GetAttributes:TPropertyAttributes; override;
    procedure Edit; override;
  end;

  TChartGDIPProperty = class(TClassProperty)
  public
    procedure Edit; override;
  end;

  TChartSeriesGDIPEditor = class(TDefaultEditor)
  protected
  {$IFNDEF DELPHI6_LVL}
    procedure EditProperty(PropertyEditor: TPropertyEditor;
      var Continue, FreeEditor: Boolean); override;
  {$ELSE}
    procedure EditProperty(const PropertyEditor: IProperty; var Continue: Boolean); override;
  {$ENDIF}
  public
  end;


  procedure Register;


implementation

uses
  Forms, SysUtils;

procedure Register;
begin
  RegisterPropertyEditor(TypeInfo(TAdvGDIPChartSeries),TAdvGDIPChart,'Series',TChartSeriesGDIPProperty);
  RegisterPropertyEditor(TypeInfo(TAdvGDIPChart),TTIWAdvChart,'Chart',TChartGDIPProperty);
  RegisterComponentEditor(TTIWAdvChart,TChartSeriesGDIPEditor);
end;

{ TChartSeriesGDIPProperty }

procedure TChartSeriesGDIPProperty.Edit;
var
  SerieEditor: TAdvChartSeriesEditorFormGDIP;
  Chart: TAdvGDIPChart;
  a: TAdvGDIPChartView;
begin
  SerieEditor := TAdvChartSeriesEditorFormGDIP.Create(Application);
  Chart := TAdvGdipChart(GetComponent(0));
  a := TAdvGDIPChartView.Create(Application);
  a.Parent := TTIWAdvChart(Chart.Owner).Parent;
  SerieEditor.ChartView := a;
  SerieEditor.ChartSeries := Chart.Series;
  SerieEditor.Init;
  SerieEditor.ShowModal;
  a.free;
  Modified;
  TTIWAdvChart(Chart.Owner).Invalidate;
  SerieEditor.Free;
end;

function TChartSeriesGDIPProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paSubproperties];
end;

{ TChartGDIPProperty }

procedure TChartGDIPProperty.Edit;
var
  SerieEditor: TAdvChartSeriesEditorFormGDIP;
  Chart: TAdvGDIPChart;
  IWChart: TTIWAdvChart;
  a: TAdvGDIPChartView;
begin
  SerieEditor := TAdvChartSeriesEditorFormGDIP.Create(Application);
  IWChart := TTIWAdvChart(GetComponent(0));
  Chart := IWChart.Chart;
  a := TAdvGDIPChartView.Create(Application);
  a.Parent := IWChart.Parent;
  SerieEditor.ChartView := a;
  SerieEditor.ChartSeries := Chart.Series;
  SerieEditor.Init;
  SerieEditor.ShowModal;
  a.Free;
  Modified;
  IWChart.Invalidate;
  SerieEditor.Free;
end;


{ TChartSeriesGDIPEditor }

{$IFDEF DELPHI6_LVL}
procedure TChartSeriesGDIPEditor.EditProperty(const PropertyEditor: IProperty; var Continue: Boolean);
{$ELSE}
procedure TChartSeriesGDIPEditor.EditProperty(PropertyEditor: TPropertyEditor;
  var Continue, FreeEditor: Boolean);
{$ENDIF}
var
  PropName: string;
begin
  PropName := PropertyEditor.GetName;
  if (CompareText(PropName, 'CHART') = 0) then
  begin
    PropertyEditor.Edit;
    Continue := False;
  end;
end;





end.
