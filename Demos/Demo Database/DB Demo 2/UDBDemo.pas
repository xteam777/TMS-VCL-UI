unit UDBDemo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdvChartView, AdvChartViewGDIP, DBAdvChartViewGDIP, DB, ADODB, AdvChart,
  AdvChartGDIP, StdCtrls;

type
  TForm30 = class(TForm)
    DBAdvGDIPChartView1: TDBAdvGDIPChartView;
    DataSource1: TDataSource;
    ADOConnection1: TADOConnection;
    ADOTable1: TADOTable;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form30: TForm30;

implementation

{$R *.dfm}

procedure TForm30.FormCreate(Sender: TObject);
var
  I, K: integer;
begin
  {$IF COMPILERVERSION > 21}
  FormatSettings.ShortDateFormat := 'mm/dd/yy';
  FormatSettings.DecimalSeparator := '.';
  {$ELSE}
  ShortDateFormat := 'mm/dd/yy';
  DecimalSeparator := '.';
  {$ENDIF}
  //Set connection string to database
  ADOConnection1.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=Finance.mdb;Persist Security Info=False';
  ADOConnection1.Connected := true;

  //Set tablename
  ADOTable1.Connection := ADOConnection1;
  ADOTable1.TableName := 'IntraDay';

  //link to Datasource and datasource to chart
  DataSource1.DataSet := ADOTable1;

  with DBAdvGDIPChartView1.Panes[0] do
  begin
    XAxis.Position := xNone;
    YAxis.Size := 60;
    BorderColor := clBlack;
    //Datasource property of Chart
    DataSource := DataSource1;
    XGrid.Visible := true;
    XGrid.MajorDistance := 4;
    XGrid.MinorDistance := 2;
    XGrid.MajorLineColor := clGray;
    XGrid.MinorLineColor := clsilver;

    Margin.RightMargin := 30;
    Series.Add;
    with Series[0] do
    begin
      AutoRange := arDisabled;
      Maximum := 350;
      Minimum := -210;
      ChartType := ctArea;
      BorderColor := clBlack;
      GradientType := gtHatch;
      Color := RGB(255, 204, 0);
      Opacity := 150;
      OpacityTo := 150;
      Enable3D := true;
      ColorTo := clwhite;
      HatchStyle := HatchStyleWideDownwardDiagonal;
      LineColor := clBlack;
      YAxis.Position := yLeft;
      FieldNameValue := 'CCI(20C)';
      XAxis.Visible := false;
      Marker.MarkerType := mCircle;
      Marker.MarkerColor := clYellow;
      Marker.MarkerColorTo := RGB(255, 204, 0);
      Marker.GradientType := gtForwardDiagonal;
    end;
  end;

  with DBAdvGDIPChartView1.Panes[1] do
  begin
    YAxis.Size := 60;
    BorderColor := clBlack;
    //Datasource property of Chart
    DataSource := DataSource1;
    XAxis.Size := 60;
    Margin.RightMargin := 50;
    XGrid.Visible := true;
    XGrid.MajorDistance := 4;
    XGrid.MinorDistance := 2;
    XGrid.MajorLineColor := clGray;
    XGrid.MinorLineColor := clsilver;
    Legend.Visible := false;

    Series.BarChartSpacing := 0;
    Series.Add;
    with Series[0] do
    begin
      AutoRange := arDisabled;
      Maximum := 125;
      Color := $00C08000;
      ColorTo := $00C08000;
      Opacity := 255;
      OpacityTo := 125;
      ValueWidth := 80;
      BorderColor := clBlack;
      ShowValue := true;
//      ValueAngle := 60;
      ValueFont.Size := 8;
      Valuefont.Color := Color;
      GradientType := gtHorizontal;
      ChartType := ctBar;
      FieldNameValue := '%K(141)';
      FieldNameXAxis := 'Time';
      XAxis.MajorUnit := 2;
      XAxis.MinorUnit := 1;
      XAxis.TextBottom.Angle := 45;
      XAxis.TickMarkColor := clBlack;
    end;
  end;

  ADOTable1.Active := true;

  DBAdvGDIPChartView1.BeginUpdate;
  DBAdvGDIPChartView1.Panes[0].Range.RangeFrom := 100;
  DBAdvGDIPChartView1.Panes[1].Range.RangeFrom := 100;
  DBAdvGDIPChartView1.Panes[0].Range.RangeTo := 130;
  DBAdvGDIPChartView1.Panes[1].Range.RangeTo := 130;
  with DBAdvGDIPChartView1.Panes[0].Series[0] do
  begin
    k := 0;
    for I := 0 to Length(Points) - 1 do
    begin
      if Odd(I) then
      begin
        Annotations.Add;
        Annotations[K].PointIndex := I;
        if I > 0 then
        begin
          if Points[I].SingleValue > 0 then
          begin
            Annotations[K].OffsetY := -30;
          end
          else
            Annotations[K].OffsetY := 10;
        end;
        Annotations[K].Text := floattostr(Points[I].SingleValue);
        Annotations[K].GradientType := gtForwardDiagonal;
        Annotations[K].Color := clYellow;
        Annotations[K].Colorto := RGB(255, 204, 0);
        Annotations[K].Font.Size := 10;
        Annotations[K].Font.Style := [fsBold];
        Inc(K);
      end;
    end;
  end;
  DBAdvGDIPChartView1.EndUpdate;
end;

end.
