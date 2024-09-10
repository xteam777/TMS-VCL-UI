unit IWAdvChartDemoUnit;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, Controls,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWAdvChart, AdvChartViewGDIP, AdvChart, AdvChartGDIP, jpeg,
  IWCompLabel, Math, IWCompListbox, IWHTMLControls, IWCompEdit,
  IWCompCheckbox, IWCompButton, Graphics, IWCompRadioButton;

type
  TIWForm35 = class(TIWAppForm)
    Header: TTIWAdvChart;
    IWLabel1: TIWLabel;
    TIWAdvChart3: TTIWAdvChart;
    IWComboBox1: TIWComboBox;
    IWLabel2: TIWLabel;
    IWComboBox2: TIWComboBox;
    IWLabel3: TIWLabel;
    IWLabel4: TIWLabel;
    IWComboBox3: TIWComboBox;
    IWLabel5: TIWLabel;
    IWEdit1: TIWEdit;
    IWLabel6: TIWLabel;
    IWCheckBox1: TIWCheckBox;
    IWLabel7: TIWLabel;
    IWLabel8: TIWLabel;
    IWCheckBox2: TIWCheckBox;
    IWButton1: TIWButton;
    IWLabel9: TIWLabel;
    IWLabel10: TIWLabel;
    IWComboBox4: TIWComboBox;
    TIWAdvChart1: TTIWAdvChart;
    IWLabel11: TIWLabel;
    IWComboBox5: TIWComboBox;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWComboBox1Change(Sender: TObject);
    procedure IWEdit1Submit(Sender: TObject);
    procedure IWCheckBox1Click(Sender: TObject);
    procedure IWCheckBox2Click(Sender: TObject);
    procedure IWButton1Click(Sender: TObject);
    procedure IWComboBox4Change(Sender: TObject);
    procedure IWComboBox5Change(Sender: TObject);
  public
    procedure CreateRandomPie;
    procedure FillRandomColors;
  end;


implementation

var
  colors1: array of TIWColor;
  colors2: array of TIWColor;
  SelectedSlice: integer;
const
  values: array[0..9] of String = ('Mercedes', 'Audi', 'Land rover', 'BMW', 'Ferrari', 'Bugatti', 'Porsche', 'Range rover', 'Lamborghini', 'Rolls Royce');

{$R *.dfm}


function RGBToColor(R,G,B:Byte): TColor;
begin
  Result:=B Shl 16 Or
          G Shl 8  Or
          R;
end;

procedure TIWForm35.FillRandomColors;
var
  I: Integer;
begin
  SetLength(colors1, 6);
  SetLength(colors2, 6);
  for I := 0 to 5 do
  begin
    Randomize;
    colors1[I] := rgbtocolor(Random(255), Random(255), Random(255));
    Randomize;
    colors2[I] := rgbtocolor(Random(255), Random(255), Random(255));
  end;
end;

procedure TIWForm35.CreateRandomPie;
var
  i: integer;
begin
  FillRandomColors;
  if TIWAdvChart3.Chart.Series.Count = 0 then
    TIWAdvChart3.Chart.Series.Add;

  with TIWAdvChart3.Chart.Series[0] do
  begin
    ClearPoints;
    for I := 0 to 5 do
    begin
      Randomize;
      if SelectedSlice = I then
        AddPiePoints(RandomRange(20, 40), values[I], colors1[Random(6)], colors2[Random(6)], 20)
      else
        AddPiePoints(RandomRange(20, 40), values[I], colors1[Random(6)], colors2[Random(6)]);
    end;
    ChartType := ctPie;
    Pie.ShowValues := true;
    GradientType := TChartGradientType(Random(7));
    Pie.Size := 300;
    Pie.Innersize := 180;
    Randomize;    
    HatchStyle := THatchStyle(Random(50));
    Randomize;    
    Opacity := RandomRange(20, 255);
    Randomize;    
    OpacityTo := RandomRange(20, 255);
    Randomize;
    BorderWidth := RandomRange(1, 4);
    Randomize;
    Bordercolor := RGBToColor(Random(255), Random(255), Random(255));
    Pie.LegendOpacity := 200;
    ValueType := cvPercentage;
    ValueFormat := '%.2g';
    Pie.ValueFont.Color := clWebWHITE;
    Pie.ValueFont.Size := 14;
    Pie.ValueFont.Name := 'TW CEN MT';
  end;
end;

procedure TIWForm35.IWAppFormCreate(Sender: TObject);
var
  i: integer;
begin

  TIWAdvChart3.Chart.Series.Clear;
    
  CreateRandomPie;

  with TIWAdvChart3.Chart.Series.Add do
  begin
    for I := 0 to 5 do
    begin
      Randomize;
      if I = 1 then
        AddPiePoints(RandomRange(2, 10), values[I], clWebORANGERED, clWebOrange, 20)
      else
        AddPiePoints(RandomRange(2, 10), values[I], clWebWhite, clWebWhite);
    end;
    ChartType := ctpie;
    GradientType := gtForwardDiagonal;
    Pie.Size := 120;
    Pie.LegendGradientType := gtSolid;
    Pie.LegendOpacity := 150;
    Pie.ShowValues := true;
    Opacity := 150;
    BorderColor := clBlack;
    OpacityTo := 200;
    ValueType := cvPercentage;
    ValueFormat := '%.2g';
    BorderWidth := 1;
  end;

  TIWAdvChart1.Chart.Series.Clear;

  with TIWAdvChart1.Chart.Series.Add do
  begin
    for I := 0 to 8 do
    begin
      Randomize;
      AddSinglePoint(randomRange(20, 50));
    end;
    AutoRange := arCommon;
    ChartType := ctStackedBar;
    LineColor := clWebDARKGOLDENROD;
    Color := clWebLIGHTYELLOW;
    Colorto := clWebDARKGOLDENROD;
    GradientType := gtForwardDiagonal;
    LineWidth := 2;    
    YAxis.TickMarkColor := clWebWhite;
    XAxis.TickMarkColor := clWebWhite;
    YAxis.MajorFont.Color := clWebWhite;
    XAxis.MajorFont.Color := clWebWhite;
    YAxis.MinorFont.Color := clWebWhite;    
    YAxis.MajorFont.Size := 14;
    XAxis.MajorFont.Size := 14;
    YAxis.MinorFont.Size:= 11;
    Marker.GradientType := gtForwardDiagonal;
    Marker.MarkerType := mDiamond;
    Marker.MarkerColor := clWebLIGHTBLUE;
    Marker.MarkerColorTo := clWebDARKBLUE;
    Marker.Opacity := 255;
    Marker.OpacityTo := 200;
    Marker.MarkerSize := 15;
  end;

  with TIWAdvChart1.Chart.Series.Add do
  begin
    for I := 0 to 8 do
    begin
      Randomize;
      AddSinglePoint(randomRange(10, 30));
    end;
    AutoRange := arCommon;
    Color := clWebLIGHTGREEN;
    colorto := clWebDARKGREEN;
    LineColor := clWebDARKGREEN;
    LineWidth := 2;
    ChartType := ctStackedBar;
    GradientType := gtForwardDiagonal;
    XAxis.Visible := false;
    YAxis.Visible := false;
    Marker.MarkerType := mDiamond;
    Marker.GradientType := gtForwardDiagonal;
    Marker.MarkerColor := clWebLIGHTGREEN;
    Marker.MarkerColorTo := clWebDARKGREEN;
    Marker.Opacity := 255;
    Marker.OpacityTo := 200;
    Marker.MarkerSize := 15;
  end;

  with TIWAdvChart1.Chart.Series.Add do
  begin
    for I := 0 to 8 do
    begin
      Randomize;
      AddSinglePoint(randomRange(50, 100));
    end;
    AutoRange := arCommon;
    LineWidth := 2;
    Color := clWebLIGHTGRAY;
    colorto := clWebDARKGRAY;
    LineColor := clWebDARKGRAY;    
    ChartType := ctLine;
    GradientType := gtForwardDiagonal;
    XAxis.Visible := false;
    YAxis.Visible := false;
    Marker.GradientType := gtForwardDiagonal;    
    Marker.MarkerType := mDiamond;
    Marker.MarkerColor := clWebDARKRED;
    Marker.MarkerColorTo := clWebRED;
    Marker.Opacity := 255;
    Marker.OpacityTo := 200;
    Marker.MarkerSize := 15;
  end;

  IWComboBox1.ItemIndex := 6;
  IWComboBox2.ItemIndex := 6;
  IWComboBox3.ItemIndex := 1;

end;

procedure TIWForm35.IWButton1Click(Sender: TObject);
begin
  CreateRandomPie;
end;

procedure TIWForm35.IWCheckBox1Click(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to TIWAdvChart3.Chart.Series.Count - 1 do
    TIWAdvChart3.Chart.Series[I].Pie.ShowValues := IWCheckBox1.Checked;
end;

procedure TIWForm35.IWCheckBox2Click(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to TIWAdvChart1.Chart.Series.Count - 1 do
  begin
    if IWCheckBox2.Checked then
      TIWAdvChart1.Chart.Series[I].Marker.MarkerType := TChartMarkerType(RandomRange(1, 4))
    else
      TIWAdvChart1.Chart.Series[I].Marker.MarkerType := mNone;
  end;
end;

procedure TIWForm35.IWComboBox1Change(Sender: TObject);
var
  ct: tChartType;
  s: integer;
begin
  s := 0;
  ct := ctLine;
  case TIWComboBox(Sender).Tag of
  1: s := 0;
  2: s := 1;
  3: s := 2;
  end;

  case TIWComboBox(Sender).ItemIndex of
  0: ct := ctNone;
  1: ct := ctLine;
  2: ct := ctArea;
  3: ct := ctBar;
  4: ct := ctLineBar;
  5: ct := ctMarkers;
  6: ct := ctStackedBar;
  7: ct := ctStackedArea;
  8: ct := ctStackedPercArea;
  9: ct := ctStackedPercBar;
  end;

  TIWAdvChart1.Chart.Series[s].ChartType := ct;
end;

procedure TIWForm35.IWComboBox4Change(Sender: TObject);
begin
  SelectedSlice := IWComboBox4.ItemIndex;
  CreateRandomPie;  
end;


procedure TIWForm35.IWComboBox5Change(Sender: TObject);
var
  i: integer;
begin
  for I := 0 to TIWAdvChart3.Chart.Series.Count - 1 do
  begin
    with TIWAdvChart3.Chart.Series[I] do
    begin
      case IwComboBox5.ItemIndex of
      0:
        begin
          ChartType := ctpie;
          Pie.LegendOffsetLeft := 0;
          Pie.LegendOffsetTop := 0;
        end;
      1:
        begin
          ChartType := ctdonut;
          if i = 0 then
          begin
            Pie.LegendOffsetTop :=  -60;
            Pie.LegendOffsetLeft :=  30;
          end
          else
          begin
            Pie.LegendOffsetTop :=  60;
            Pie.LegendOffsetLeft :=  120;
          end;
        end;
      end;
    end;
  end;

  case IwComboBox5.ItemIndex of
  0:TIWAdvChart3.Chart.Series.DonutMode := dmNormal;
  1:TIWAdvChart3.Chart.Series.DonutMode := dmStacked;
  end;
end;

procedure TIWForm35.IWEdit1Submit(Sender: TObject);
var
  i: integer;
begin
  for I := 0 to TIWAdvChart3.Chart.Series.Count - 1 do
    TIWAdvChart3.Chart.Series[I].Pie.StartOffsetAngle := strtoint(IWEdit1.Text);
end;

initialization
  TIWForm35.SetAsMainForm;

end.
