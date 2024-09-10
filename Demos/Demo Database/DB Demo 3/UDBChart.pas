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
    procedure UpdateColors;
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
  UpdateColors;
end;

procedure TForm29.Button2Click(Sender: TObject);
begin
  ADOTable1.Active := false;
  ADOTable1.TableName := 'Sales2';
  ADOTable1.Active := true;
  UpdateColors;
end;

function Lighter(Color:TColor; Percent:Byte):TColor;
var
  r, g, b:Byte;
begin
  Color := ColorToRGB(Color);
  r := GetRValue(Color);
  g := GetGValue(Color);
  b := GetBValue(Color);
  r := r + muldiv(255 - r, Percent, 100); //Percent% closer to white
  g := g + muldiv(255 - g, Percent, 100);
  b := b + muldiv(255 - b, Percent, 100);
  result := RGB(r, g, b);
end;

function Darker(Color:TColor; Percent:Byte):TColor;
var
  r, g, b:Byte;
begin
  Color := ColorToRGB(Color);
  r := GetRValue(Color);
  g := GetGValue(Color);
  b := GetBValue(Color);
  r := r - muldiv(r, Percent, 100);  //Percent% closer to black
  g := g - muldiv(g, Percent, 100);
  b := b - muldiv(b, Percent, 100);
  result := RGB(r, g, b);
end;

procedure TForm29.FormCreate(Sender: TObject);
var
  I: integer;
  c: TColor;
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
    Title.BorderColor := clBlack;
    Title.BorderWidth := 1;
    Title.GradientDirection := cgdVertical;
    Title.Size := 50;
    Title.Text := 'Database Funnel Chart';
    title.Font.Size := 14;
    Title.Font.Style := [fsBold];
    Background.Color := clWhite;
    Legend.Visible := false;
    Margin.LeftMargin := 0;
    Margin.rightMargin := 0;
    Margin.TopMargin := 0;

    YAxis.AutoUnits := false;
    YGrid.MajorDistance := 50;
    YGrid.MinorDistance := 10;
    YGrid.MinorLineColor := clSilver;
    YGrid.MajorLineColor := clDkGray;
    YGrid.MinorLineStyle := psDash;

    Series.Add;

    with Series[0] do
    begin
      c := 11829830;
      Funnel.LegendColor := c;
      Color := c;
      FieldNameValue := 'Product X';
      FieldNameXAxis := 'Sales by Region';
      LegendText := 'Product X';
      Funnel.LegendTitleColor := c;
      Funnel.ValueFont.Color := c;
    end;

    Series.Add;

    with Series[1] do
    begin
      c := 5737262;
      Funnel.LegendColor := c;
      Color := c;
      YAxis.Visible := false;
      FieldNameValue := 'Product Y';
      FieldNameXAxis := 'Sales by Region';
      LegendText := 'Product Y';
      Funnel.LegendTitleColor := c;
      Funnel.ValueFont.Color := c;
    end;

    Series.Add;

    with Series[2] do
    begin
      c := 42495;
      Funnel.LegendColor := c;
      Color := c;
      YAxis.Visible := false;
      FieldNameValue := 'Combined';
      FieldNameXAxis := 'Sales by Region';
      LegendText := 'Combined';
      Funnel.LegendTitleColor := c;
      Funnel.ValueFont.Color := c;
    end;

    for I := 0 to Series.Count - 1 do
    begin
      with Series[I] do
      begin
        YAxis.MajorUnit := 50;
        YAxis.MajorUnit := 25;
        Funnel.LegendTitleVisible := true;
        Funnel.LegendGradientType := gtForwardDiagonal;
        Funnel.LegendBorderColor := clBlack;
        Funnel.LegendFont.Size := 10;
        ValueFormat := '$%g,000';
        Funnel.ValueFont.Size := 10;
        ChartType := ctFunnel;
        if I = 1 then
          FunnelMode := fmWidth;
        LineColor := clBlack;
        FunnelSpacing := 10;
        AutoRange := arCommonZeroBased;
        FunnelHeightType := fstPixels;
        FunnelWidthType := fstPixels;
        Funnel.Position := spTopCenter;
        FunnelWidth := 200;
        FunnelHeight := 200;
        Enable3D := true;
        Funnel.Top := 50;
        FunnelWidthType := fstPixels;
        Funnel.ShowValues := true;
        Funnel.LegendOffsetTop := -30;
        Funnel.ValuePosition := vpOutSideSlice;
        Funnel.LegendPosition := spBottomCenter;
      end;
    end;

    // open connection
    ADOTable1.Active := true;
    UpdateColors;
  end;

end;

procedure TForm29.UpdateColors;
var
  I, J: Integer;
begin
  with DBAdvGDIPChartView1.Panes[0] do
  begin
    for I := 0 to Series.Count - 1 do
      for J := 0 to Length(Series[I].Points) - 1 do
        Series[I].Points[J].Color := Lighter(Series[I].Color, 15 * J);
  end;
end;

end.
