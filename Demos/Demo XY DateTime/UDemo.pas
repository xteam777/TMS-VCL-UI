unit UDemo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdvChartView, AdvChartViewGDIP, AdvChart;

type
  TForm10 = class(TForm)
    AdvGDIPChartView1: TAdvGDIPChartView;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function ConvertDateTimeToX(Date: TDateTime): integer;
  end;

var
  Form10: TForm10;

implementation

{$R *.dfm}

function TForm10.ConvertDateTimeToX(Date: TDateTime): integer;
begin
  Result := Round(Date - EncodeDate(2010, 05, 1));
end;

procedure TForm10.FormCreate(Sender: TObject);
var
  i: integer;
  d: TDateTime;
begin
  with AdvGDIPChartView1.Panes[0] do
  begin
    XAxis.UnitType := utMinute;
    XAxis.Size := 130;
    Title.Text := 'May 2010';
    Title.Size := 50;
    Title.Font.Size := 16;
    Range.StartDate := EncodeDate(2010, 05, 1);
    with Series[0] do
    begin
      AutoRange := arEnabled;
      ChartType := ctXYLine;
      XAxis.MajorUnitTimeFormat := 'dd/mm/yyyy';
      XAxis.TextBottom.Angle := 50;
      XAxis.MajorUnitSpacing := 20;
      XAxis.XYValuesOffset := 60;
      XAxis.AutoUnits := false;
      for I := 0 to 30 do
      begin
        d := EncodeDate(2010, 05, 1) + I * 5;
        AddSingleXYPoint(ConvertDateTimeToX(d),  Random(100));
      end;
    end;
    Range.RangeTo := 30;
  end;

end;

end.
