unit UDemo;

interface

uses
  Windows, Classes, Graphics, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, Controls,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWAdvChart,
  IWCompButton, AdvChart, IWCompListbox, IWCompLabel, IWCompCheckbox;

type
  TIWForm1 = class(TIWAppForm)
    TIWAdvChart1: TTIWAdvChart;
    IWLabel1: TIWLabel;
    IWComboBox1: TIWComboBox;
    IWLabel2: TIWLabel;
    IWLabel3: TIWLabel;
    IWComboBox2: TIWComboBox;
    IWLabel4: TIWLabel;
    IWComboBox3: TIWComboBox;
    IWLabel5: TIWLabel;
    IWComboBox4: TIWComboBox;
    IWLabel6: TIWLabel;
    IWLabel7: TIWLabel;
    IWButton1: TIWButton;
    IWButton2: TIWButton;
    IWCheckBox2: TIWCheckBox;
    IWLabel8: TIWLabel;
    procedure IWAppFormCreate(Sender: TObject);
    procedure TIWAdvChart1AnnotationClick(Sender: TObject; Serie, Annotation,
      Point: Integer);
    procedure TIWAdvChart1SelectSerieIndex(Sender: TObject; Serie,
      PointIndex: Integer);
    procedure TIWAdvChart1ChartClick(Sender: TObject; X, Y: Integer);
    procedure IWButton1AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWButton2AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWComboBox2AsyncChange(Sender: TObject; EventParams: TStringList);
    procedure IWComboBox1AsyncChange(Sender: TObject; EventParams: TStringList);
    procedure IWComboBox3AsyncChange(Sender: TObject; EventParams: TStringList);
    procedure IWComboBox4AsyncChange(Sender: TObject; EventParams: TStringList);
    procedure IWCheckBox2AsyncChange(Sender: TObject; EventParams: TStringList);
  public
  end;

implementation

{$R *.dfm}

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

procedure TIWForm1.IWAppFormCreate(Sender: TObject);
var
  I: Integer;
begin
  TIWAdvChart1.BeginUpdate;
  for I := 0 to 10 do
  begin
    Randomize;
    TIWAdvChart1.Chart.Series[0].AddSinglePoint((Random(100) + 10));
    Randomize;
    TIWAdvChart1.Chart.Series[1].AddSinglePoint(random(100) + 10)
  end;

  TIWAdvChart1.Chart.Range.RangeTo := 10;

  TIWAdvChart1.Chart.Series[0].AutoRange := arCommonZeroBased;
  TIWAdvChart1.Chart.Series[1].AutoRange := arCommonZeroBased;
  TIWAdvChart1.Chart.Series[0].ShowAnnotationsOnTop := true;
  TIWAdvChart1.Chart.Series[1].ShowAnnotationsOnTop := true;
  TIWAdvChart1.Chart.Series.BarChartSpacing := 0;
  TIWAdvChart1.Chart.Series[0].ValueWidth := 80;
  TIWAdvChart1.Chart.Series[1].ValueWidth := 80;
  TIWAdvChart1.Chart.Series[0].LineColor :=  TIWAdvChart1.Chart.Series[0].Color;
  TIWAdvChart1.Chart.Series[1].LineColor :=  TIWAdvChart1.Chart.Series[1].Color;
  TIWAdvChart1.Chart.Series[0].Bordercolor := clBlack;
  TIWAdvChart1.Chart.Series[1].Bordercolor := clBlack;
  TIWAdvChart1.Chart.Series[1].XAxis.Visible := false;
  TIWAdvChart1.Chart.Series[1].ValueWidth := 80;

  IWComboBox1.ItemIndex := 0;
  IWComboBox2.ItemIndex := 1;
  IWComboBox3.ItemIndex := 2;
  IWComboBox4.ItemIndex := 1;
  TIWAdvChart1.Chart.Series[0].ColorTo := Lighter(TIWAdvChart1.Chart.Series[0].Color, 40);
  TIWAdvChart1.Chart.Series[1].ColorTo := Lighter(TIWAdvChart1.Chart.Series[1].Color, 40);
  TIWAdvChart1.Chart.Series[0].ColorTo := Lighter(TIWAdvChart1.Chart.Series[0].Color, 40);
  TIWAdvChart1.Chart.Series[0].Opacity := 180;
  TIWAdvChart1.Chart.Series[0].OpacityTo := 180;
  TIWAdvChart1.Chart.Series[1].Opacity := 180;
  TIWAdvChart1.Chart.Series[1].OpacityTo := 180;
  TIWAdvChart1.EndUpdate;
end;

procedure TIWForm1.IWButton1AsyncClick(Sender: TObject;
  EventParams: TStringList);
var
  i: integer;
begin
  TIWAdvChart1.BeginUpdate;
  for I := 0 to Length(TIWAdvChart1.Chart.Series[0].Points) - 1 do
  begin
    randomize;
    TIWAdvChart1.Chart.Series[0].Points[I].SingleValue := Random(100) + 10;
  end;
  TIWAdvChart1.EndUpdate;
end;

procedure TIWForm1.IWButton2AsyncClick(Sender: TObject;
  EventParams: TStringList);
var
  i: integer;
begin
  TIWAdvChart1.BeginUpdate;
  for I := 0 to Length(TIWAdvChart1.Chart.Series[1].Points) - 1 do
  begin
    randomize;
    TIWAdvChart1.Chart.Series[1].Points[I].SingleValue := Random(100) + 10;
  end;
  TIWAdvChart1.EndUpdate;
end;

procedure TIWForm1.IWCheckBox2AsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  TIWAdvChart1.BeginUpdate;
  if IWCheckBox2.Checked then
    TIWAdvChart1.Chart.Series.ChartMode := dmHorizontal
  else
    TIWAdvChart1.Chart.Series.ChartMode := dmVertical;
  TIWAdvChart1.EndUpdate;
end;

procedure TIWForm1.IWComboBox1AsyncChange(Sender: TObject;
  EventParams: TStringList);
var
  i: integer;
  c: TChartBarShape;
begin
  TIWAdvChart1.BeginUpdate;
  for I := 0 to TIWAdvChart1.Chart.Series.Count - 1 do
  begin
    c := bsRectangle;
    case IWComboBox1.ItemIndex of
    0: c := bsRectangle;
    1: c := bsCylinder;
    2: c := bsPyramid;
    end;
    TIWAdvChart1.Chart.Series[I].BarShape := c;
  end;
  TIWAdvChart1.EndUpdate;
end;

procedure TIWForm1.IWComboBox2AsyncChange(Sender: TObject;
  EventParams: TStringList);
var
  i: integer;
  c: TChartType;
begin
  TIWAdvChart1.BeginUpdate;
  for I := 0 to TIWAdvChart1.Chart.Series.Count - 1 do
  begin
    c := ctbar;
    case IWComboBox2.ItemIndex of
    0: c := ctLine;
    1: c := ctBar;
    2: c := ctStackedBar;
    3: c := ctStackedPercBar;
    4: c := ctArea;
    5: c := ctStackedArea;
    6: c := ctStackedPercArea;
    end;
    TIWAdvChart1.Chart.Series[I].ChartType := c;
  end;
  TIWAdvChart1.EndUpdate;
end;

procedure TIWForm1.IWComboBox3AsyncChange(Sender: TObject;
  EventParams: TStringList);
var
  c: TColor;
begin
  TIWAdvChart1.BeginUpdate;
  c := clRed;
  case IWComboBox3.ItemIndex of
  0: c := clRed;
  1: c := clBlue;
  2: c := clGreen;
  3: c := RGB(255, 132, 0);
  4: c := clSilver;
  end;
  tiwadvchart1.Chart.Series[0].Color := c;
  tiwadvchart1.Chart.Series[0].ColorTo := Lighter(c, 40);
  TIWAdvChart1.EndUpdate;
end;

procedure TIWForm1.IWComboBox4AsyncChange(Sender: TObject;
  EventParams: TStringList);
var
  c: TColor;
begin
  TIWAdvChart1.BeginUpdate;
  c := clRed;
  case IWComboBox4.ItemIndex of
  0: c := clRed;
  1: c := clBlue;
  2: c := clGreen;
  3: c := RGB(255, 132, 0);
  4: c := clSilver;
  end;
  tiwadvchart1.Chart.Series[1].Color := c;
  tiwadvchart1.Chart.Series[1].ColorTo := Lighter(c, 40);
  TIWAdvChart1.EndUpdate;
end;

procedure TIWForm1.TIWAdvChart1AnnotationClick(Sender: TObject; Serie,
  Annotation, Point: Integer);
begin
  IWLAbel1.Caption := 'Annotation clicked : ' + inttostr(Annotation);
end;

procedure TIWForm1.TIWAdvChart1ChartClick(Sender: TObject; X, Y: Integer);
begin
  TIWAdvChart1.BeginUpdate;
  TIWAdvChart1.Chart.Series[0].SelectedIndex := -1;
  TIWAdvChart1.Chart.Series[1].SelectedIndex := -1;
  TIWAdvChart1.EndUpdate;
  IWLabel1.caption := 'Chart clicked';
end;

procedure TIWForm1.TIWAdvChart1SelectSerieIndex(Sender: TObject; Serie,
  PointIndex: Integer);
begin
  IWLabel1.Caption := 'Serie clicked : ' + IntToStr(Serie) + ' : Value : ' + floattostr(TIWAdvChart1.Chart.Series[Serie].Points[PointIndex].SingleValue);
end;

initialization
  TIWForm1.SetAsMainForm;

end.
