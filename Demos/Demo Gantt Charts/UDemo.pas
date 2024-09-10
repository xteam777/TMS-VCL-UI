unit UDemo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdvChartView, AdvChartViewGDIP, AdvChart, DateUtils, Math;

type
  TForm303 = class(TForm)
    AdvGDIPChartView1: TAdvGDIPChartView;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure DrawYAxisCustom(Sender: TObject; ARect: TRect; ACanvas: TCanvas);
    function GetPreviousGanttGroupHeight(Index: Integer): integer;
  public
    { Public declarations }
  end;

var
  Form303: TForm303;

implementation

{$R *.dfm}

function TForm303.GetPreviousGanttGroupHeight(Index: Integer): integer;
var
  I: Integer;
begin
  Result := 0;
  for I := Index - 1 downto 0 do
  begin
    Result := Result + AdvGDIPChartView1.Panes[0].Series[I].GanttHeight + AdvGDIPChartView1.Panes[0].Series[I].GanttSpacing * 2;
  end;
    Result := Result + AdvGDIPChartView1.Panes[0].Series[Index].GanttSpacing + AdvGDIPChartView1.Panes[0].Series[Index].GanttHeight div 2;
end;

procedure TForm303.DrawYAxisCustom(Sender: TObject; ARect: TRect;
  ACanvas: TCanvas);
var
  rLeft, rRight: TRect;
  i: integer;
  tw, th: Integer;
  str: String;
begin
  rLeft := AdvGDIPChartView1.Panes[0].Series.SeriesRectangle;
  rRight := ARect;
  for I := 0 to AdvGDIPChartView1.Panes[0].Series.Count - 1 do
  begin
    if AdvGDIPChartView1.Panes[0].Series[I].ChartType = ctGantt then
    begin
      str := AdvGDIPChartView1.Panes[0].Series[I].LegendText;
      ACanvas.Font.Color := AdvGDIPChartView1.Panes[0].Series[I].Color;
      ACanvas.Font.Size := 12;
      tw := ACanvas.TextWidth(str);
      th := ACanvas.Textheight(str);
      ACanvas.TextOut(rLeft.Left - tw - 10 , rLeft.Bottom - th div 2 - GetPreviousGanttGroupHeight(I), str);
    end;
  end;

end;

procedure TForm303.FormCreate(Sender: TObject);
var
  i: integer;
  d: TDateTime;
  sd: TDateTime;
  iCount: integer;
begin
  AdvGDIPChartView1.BeginUpdate;
  with AdvGDIPChartView1.Panes[0] do
  begin
    Range.StartDate := EncodeTime(7, 0, 0, 0);  // TDatetime variable in combination with datetime X-Axis.
    Range.RangeFrom := 0; //Start time
    Range.RangeTo := 13 * 60;//End Time (Start time + 12 * 60 (60 minutes in 1 hour) units depends on UnitType)
    XGrid.Visible := true;
    XGrid.MajorDistance := 1;
    with Series.Add do
    begin
      LegendText := 'Nor Adrenaline 6ml h.';
      ChartType := ctGantt;
      XAxis.MajorUnitTimeFormat := 'hh:nn';
      XAxis.MinorUnitTimeFormat := 'hh:nn';
      XAxis.MajorUnit := 60;
      XAxis.MinorUnit := 30;
      XAxis.Position := xTop;
      Color := clRed;
      AddSinglePoint('6 ml', EncodeTime(7, 30, 0, 0), EncodeTime(10, 45, 0, 0), Color);
      AddSinglePoint('7 ml', EncodeTime(10, 45, 0, 0), EncodeTime(11, 30, 0, 0), Color);

    end;

    with Series.Add do
    begin
      LegendText := 'Epiniphrine';
      ChartType := ctGantt;
      Color := clGreen;
      AddSinglePoint('20 ml', EncodeTime(9, 0, 0, 0), EncodeTime(9, 40, 0, 0), Color);
      AddSinglePoint('10 ml', EncodeTime(9, 40, 0, 0), EncodeTime(10, 30, 0, 0), Color);

    end;

    with Series.Add do
    begin
      LegendText := 'Midazilam';
      ChartType := ctGantt;
      Color := clPurple;
      AddSinglePoint('6 ml', EncodeTime(12, 30, 0, 0), EncodeTime(13, 0, 0, 0), Color);
      AddSinglePoint('8 ml', EncodeTime(13, 0, 0, 0), EncodeTime(14, 0, 0, 0), Color);
      AddSinglePoint('Empty', EncodeTime(14, 0, 0, 0), EncodeTime(16, 30, 0, 0), clNone);

    end;

    with Series.Add do
    begin
      LegendText := 'Vantomycin';
      ChartType := ctGantt;
      Color := clBlue;
      AddSinglePoint('5 ml', EncodeTime(7, 30, 0, 0), EncodeTime(15, 0, 0, 0), Color);
      AddSinglePoint('Empty', EncodeTime(15, 0, 0, 0), EncodeTime(16, 45, 0, 0), clNone);
      AddSinglePoint('4 ml', EncodeTime(16, 45, 0, 0), EncodeTime(17, 0, 0, 0), Color);

    end;

    with Series.Add do
    begin
      LegendText := 'Ferusomide';
      ChartType := ctGantt;
      Color := clMedGray;
      AddSinglePoint('11 ml', EncodeTime(8, 30, 0, 0), EncodeTime(9, 30, 0, 0), Color);
      AddSinglePoint('7 ml', EncodeTime(9, 30, 0, 0), EncodeTime(12, 30, 0, 0), Color);
      AddSinglePoint('7 ml', EncodeTime(12, 30, 0, 0), EncodeTime(18, 30, 0, 0), Color);
      AddSinglePoint('Empty', EncodeTime(18, 30, 0, 0), EncodeTime(19, 30, 0, 0), clNone);

    end;

    Legend.Visible := false;
    YAxis.AutoSize := True;
    YAxis.LeftSize := 200;
    YAxis.RightSize := 75;
    YAxis.Position := yBoth;
    YGrid.Visible := true;
    XAxis.UnitType := utMinute;
    XAxis.Position := xBoth;
    XGrid.AutoUnits := False;
    XGrid.MajorDistance := 60;
    XGrid.MinorDistance := 30;

    for I := 0 to Series.Count - 1 do
    begin
      Series[i].XAxis.Visible := I = 0;
      Series[i].XAxis.Position := xtop;
      Series[i].YAxis.Visible := False;
      Series[i].XAxis.AutoUnits := False;
    end;

    with Series.Add do
    begin
      ChartType := ctXYLine;
      sd := IncMinute(Range.StartDate, Range.RangeTo - Range.RangeFrom);
      d := Range.StartDate;
      iCount := 1;
      XAxis.Visible := FAlse;
      YAxis.Position := yRight;
      LineWidth := 3;
      LineColor := clLime;
      YAxis.AutoUnits := False;
      AutoRange := arDisabled;
      Minimum := 0;
      Maximum := 500;
      while d < sd do
      begin
        d := IncMinute(d, RandomRange(1, 5));
        AddSinglePoint(iCount, d);
        Inc(iCount);
      end;


    end;


    Chart.OnDrawYAxis := DrawYAxisCustom;
  end;

  AdvGDIPChartView1.EndUpdate;
end;

end.
