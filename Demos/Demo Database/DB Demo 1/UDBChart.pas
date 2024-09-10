unit UDBChart;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, AdvChartView, AdvChartViewGDIP, DBAdvChartViewGDIP, DB, ADODB, AdvChart,
  AdvChartGDIP, StdCtrls;

type
  TForm29 = class(TForm)
    DBAdvGDIPChartView1: TDBAdvGDIPChartView;
    ADOConnection1: TADOConnection;
    ADOTable1: TADOTable;
    DataSource1: TDataSource;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form29: TForm29;

implementation

{$R *.dfm}

procedure TForm29.Button1Click(Sender: TObject);
begin
  ADOTable1.Active := false;
  ADOTable1.TableName := 'Sales';
  ADOTable1.Active := true;
end;

procedure TForm29.Button2Click(Sender: TObject);
begin
  ADOTable1.Active := false;
  ADOTable1.TableName := 'Sales2';
  ADOTable1.Active := true;
end;

procedure TForm29.FormCreate(Sender: TObject);
var
  I: integer;
begin
  DBAdvGDIPChartView1.Panes[0].BorderColor := clBlack;
  DBAdvGDIPChartView1.Panes[0].BorderWidth := 3;

  with DBAdvGDIPChartView1.Panes[0] do
  begin
    Series.Clear;
    //Set connection string to database
    ADOConnection1.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=sales.mdb;Persist Security Info=False';
    ADOConnection1.Connected := true;

    //Set tablename
    ADOTable1.Connection := ADOConnection1;
    ADOTable1.TableName := 'Sales';

    //link to Datasource and datasource to chart
    DataSource1.DataSet := ADOTable1;
    //Datasource property of Chart
    DataSource := DataSource1;

    XAxis.Position := xNone;
    YAxis.Position := yNone;
    Title.Color := RGB(255, 255, 210);
    Title.ColorTo := RGB(255, 255, 210);
    Title.BorderColor := clBlack;
    Title.BorderWidth := 1;
    Title.GradientDirection := cgdVertical;
    Title.Size := 50;
    Title.Text := 'Database Spider Chart';
    title.Font.Size := 14;
    Title.Font.Style := [fsBold];
    Background.GradientType := gtHatch;
    Background.HatchStyle := HatchStyleWideDownwardDiagonal;
    Background.Color := RGB(255, 255, 210);
    BackGround.ColorTo := clWhite;
    Legend.Visible := false;
    Margin.LeftMargin := 0;
    Margin.rightMargin := 0;
    Margin.TopMargin := 0;
    series.DonutMode := dmStacked;

    YAxis.AutoUnits := false;
    YGrid.MajorDistance := 50;
    YGrid.MinorDistance := 10;
    YGrid.MinorLineColor := clSilver;
    YGrid.MajorLineColor := clDkGray;
    YGrid.MinorLineStyle := psDash;

    Series.Add;

    with Series[0] do
    begin
      Pie.LegendOffsetTop := (Self.Height div 2) - 150;
      Pie.LegendColor := clRed;
      Color := clRed;
      FieldNameValue := 'Product X';
      FieldNameXAxis := 'Sales by Region';
      LegendText := 'Product X';
      Pie.LegendTitleColor := clRed;
      Pie.ValueFont.Color := clRed;
    end;

    Series.Add;

    with Series[1] do
    begin
      Pie.LegendOffsetTop := (Self.Height div 2);
      Pie.LegendColor := clGreen;
      Color := clGreen;
      Pie.ShowGrid := false;
      YAxis.Visible := false;
      FieldNameValue := 'Product Y';
      FieldNameXAxis := 'Sales by Region';
      LegendText := 'Product Y';
      Pie.LegendTitleColor := clGreen;
      Pie.ValueFont.Color := clGreen;
    end;

    Series.Add;

    with Series[2] do
    begin
      Pie.LegendOffsetTop := (Self.Height div 2) + 150;
      Pie.LegendColor := clBlue;
      Color := clBlue;
      Pie.ShowGrid := false;
      YAxis.Visible := false;
      FieldNameValue := 'Combined';
      FieldNameXAxis := 'Sales by Region';
      LegendText := 'Combined';
      Pie.LegendTitleColor := clBlue;
      Pie.ValueFont.Color := clBlue;
    end;

    for I := 0 to Series.Count - 1 do
    begin
      with Series[I] do
      begin
        YAxis.MajorUnit := 50;
        YAxis.MajorUnit := 25;
        Pie.LegendTitleVisible := true;
        pie.LegendOpacity := 50;
        pie.LegendOpacityto := 0;
        Pie.LegendTitleOpacity := 50;
        Pie.LegendGradientType := gtForwardDiagonal;
        Pie.LegendBorderColor := clBlack;
        Pie.Position := spCustom;
        Pie.Left := self.Width div 3;
        Pie.Top := self.Height div 2;
        Pie.LegendFont.Size := 10;
        ValueFormat := '$%g,000';
        Pie.ValueFont.Size := 10;
        ChartType := ctSpider;
        Opacity := 50;
        LineColor := clBlack;
        AutoRange := arCommonZeroBased;
        Pie.Size := 400;
        Pie.ShowValues := true;
        Pie.ValuePosition := vpOutSideSlice;
        pie.LegendPosition := spCustom;
        Pie.LegendOffsetLeft := Self.Width - 150;
      end;
    end;

    // open connection
    ADOTable1.Active := true;
  end;
end;

end.
