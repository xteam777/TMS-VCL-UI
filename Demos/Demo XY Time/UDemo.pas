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
    function ConvertDateTimeToX(Date: TDateTime): Double;
  end;

var
  Form10: TForm10;

implementation

{$R *.dfm}

function TForm10.ConvertDateTimeToX(Date: TDateTime): Double;
begin
  Result := (Date - EncodeTime(10, 0, 0, 0)) * 24 * 60;
end;

procedure TForm10.FormCreate(Sender: TObject);
var
  i: integer;
  d: TDateTime;
  c: Integer;
begin
  with AdvGDIPChartView1.Panes[0] do
  begin
    XAxis.UnitType := utMinute;
    XAxis.Size := 130;
    Title.Text := 'May 2010';
    Title.Size := 50;
    Title.Font.Size := 16;
    Range.StartDate := EncodeTime(10, 0, 0, 0);
    with Series[0] do
    begin
      AutoRange := arEnabled;
      ChartType := ctXYLine;
      XAxis.MajorUnitTimeFormat := 'hh:nn:ss';
      XAxis.TextBottom.Angle := 50;
      XAxis.MajorUnitSpacing := 20;
      XAxis.XYValuesOffset := 60;
      XAxis.AutoUnits := false;
      c := 2;
      for I := 0 to 19 do
      begin
        d := EncodeTime(10, 0, 0, 0) + (1 / 24 / 60 * c);
        c := c + (Random(5) + 1);
        AddSingleXYPoint(ConvertDateTimeToX(d),  Random(100));
      end;
    end;
    Range.RangeTo := 19;
  end;
end;

end.
