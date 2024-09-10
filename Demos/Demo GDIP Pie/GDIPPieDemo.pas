unit GDIPPieDemo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdvChartView, AdvChartGDIP, AdvChartViewGDIP, Math, AdvChart, jpeg,
  StdCtrls, ExtCtrls, AdvChartPaneEditorGDIP, AdvChartPaneEditor,
  AdvChartSerieEditor, Menus, ExtDlgs;

type
  TForm19 = class(TForm)
    AdvGDIPChartView1: TAdvGDIPChartView;
    AdvChartPanesEditorDialogGDIP1: TAdvChartPanesEditorDialogGDIP;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    EditPiechart1: TMenuItem;
    Save1: TMenuItem;
    opng1: TMenuItem;
    tobmp1: TMenuItem;
    oTiff1: TMenuItem;
    ogif1: TMenuItem;
    ojpeg1: TMenuItem;
    SavePictureDialog1: TSavePictureDialog;
    ojpeg100quality1: TMenuItem;
    ojpeg100quality2: TMenuItem;
    Startangle2: TMenuItem;
    N902: TMenuItem;
    N452: TMenuItem;
    N02: TMenuItem;
    SwitchtoDonut1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure EditPiechart1Click(Sender: TObject);
    procedure opng1Click(Sender: TObject);
    procedure tobmp1Click(Sender: TObject);
    procedure oTiff1Click(Sender: TObject);
    procedure ogif1Click(Sender: TObject);
    procedure ojpeg1Click(Sender: TObject);
    procedure ojpeg100quality1Click(Sender: TObject);
    procedure ojpeg100quality2Click(Sender: TObject);
    procedure N02Click(Sender: TObject);
    procedure N452Click(Sender: TObject);
    procedure N902Click(Sender: TObject);
    procedure SwitchtoDonut1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure SetAngle(Angle: integer);
    { Public declarations }
  end;

var
  Form19: TForm19;

implementation

{$R *.dfm}


procedure TForm19.Button2Click(Sender: TObject);
begin
  AdvChartPanesEditorDialogGDIP1.Execute;
end;

procedure TForm19.EditPiechart1Click(Sender: TObject);
begin
  AdvChartPanesEditorDialogGDIP1.Execute;
end;

procedure TForm19.FormCreate(Sender: TObject);
const
  colors1: array[0..4] of TColor = (clRed, clBlue, clGreen, clPurple, clMaroon);
  colors2: array[0..4] of TColor = (clDkGray, clLtGray, clLime, clOlive, clLime);
  colors3: array[0..4] of TColor = (clBlue, clLime, clFuchsia, clAqua, clRed);
  values: array[0..9] of String = ('Mercedes', 'Audi', 'Land rover', 'BMW', 'Ferrari', 'Bugatti', 'Porsche', 'Range rover', 'Lamborghini', 'Rolls Royce');
var
  I: Integer;
  c: TColor;
begin
  for I := 0 to 9 do
  begin
    Randomize;
    if I <= 5 then
    begin
      AdvGDIPChartView1.Panes[0].Series[0].AddPiePoints(RandomRange(20, 100), values[I], colors1[1], Colors3[I], 0, true);
      AdvGDIPChartView1.Panes[0].Series[1].AddPiePoints(I + 1, values[I], clWhite, colors1[I], 0, true);
    end
    else
    begin
      c := RGB(Random(255), Random(255), Random(255));
      AdvGDIPChartView1.Panes[0].Series[0].AddPiePoints(RandomRange(20, 100), values[I], colors2[I], Colors3[I], 0, true);
      AdvGDIPChartView1.Panes[0].Series[1].AddPiePoints(I, values[I], c, c, 20, true);
    end;
  end;

  AdvGDIPChartView1.Panes[0].Series[0].ChartType := ctpie;
  AdvGDIPChartView1.Panes[0].Series[1].ChartType := ctpie;

  AdvGDIPChartView1.Panes[0].Series[0].LegendText := 'Donut Chart 1';
  AdvGDIPChartView1.Panes[0].Series[1].LegendText := 'Donut Chart 2';

  AdvGDIPChartView1.Panes[0].Series[0].Pie.LegendGradientType := gtHatch;
  AdvGDIPChartView1.Panes[0].Series[0].Pie.LegendHatchStyle := HatchStyleForwardDiagonal;
  AdvGDIPChartView1.Panes[0].Series[0].Pie.LegendOpacity := 100;
  AdvGDIPChartView1.Panes[0].Series[0].Pie.LegendOpacityTo := 100;

  AdvGDIPChartView1.Panes[0].Series[0].Pie.ValueFont.Color := clNavy;

  AdvGDIPChartView1.Panes[0].Series[1].Pie.LegendGradientType := gtBackwardDiagonal;
  AdvGDIPChartView1.Panes[0].Series[1].Pie.LegendOpacity := 255;
  AdvGDIPChartView1.Panes[0].Series[1].Pie.LegendOpacityTo := 120;

  AdvGDIPChartView1.Panes[0].Series[0].Pie.Size := 250;
  AdvGDIPChartView1.Panes[0].Series[1].Pie.Size := 250;

  AdvGDIPChartView1.Panes[0].Series[1].Pie.LegendFont.Color := clPurple;

  AdvGDIPChartView1.Color := clBlue;

  SwitchtoDonut1Click(self);
end;

procedure TForm19.SetAngle(Angle: integer);
var
  i: integer;
begin
  AdvGDIPChartView1.BeginUpdate;
  for I := 0 to AdvGDIPChartView1.Panes[0].Series.Count - 1 do
    AdvGDIPChartView1.Panes[0].Series[I].Pie.StartOffsetAngle := Angle;
  AdvGDIPChartView1.EndUpdate;
end;

procedure TForm19.SwitchtoDonut1Click(Sender: TObject);
var
  I: Integer;
begin
  SwitchtoDonut1.Caption := 'Switch to ' + File1.Caption;
  if File1.Caption = '&Pie' then
    File1.Caption := '&Donut'
  else
    File1.Caption := '&Pie';

  AdvGDIPChartView1.BeginUpdate;
  with AdvGDIPChartView1.Panes[0] do
  begin
    Title.Text := StringReplace(File1.Caption, '&', '', [rfReplaceAll]) + ' Chart with TAdvChartviewGDIP';
    for I := 0 to Series.Count - 1 do
    begin
      with Series[I] do
      begin
        Pie.LegendOffsetLeft := 0;
        Pie.LegendOffsetTop := 0;
        if File1.Caption = '&Pie' then
        begin
          ChartType := ctPie;
          Pie.Size := 250;
          Pie.LegendTitleVisible := false;
          Pie.InnerSize := 0;
          Pie.LegendPosition := spCenterRight;
        end
        else
        begin
          Pie.Size := Pie.Size + (Pie.Size div 2) * I;
          if I > 0 then
          begin
            Pie.InnerSize := Series[I - 1].Pie.Size;
            Pie.LegendPosition := spBottomLeft;
          end
          else
          begin
            Pie.InnerSize := 100;
            Pie.LegendPosition := spBottomRight;
          end;
            
          ChartType := ctDonut;
          Pie.LegendTitleVisible := true;
        end;
      end;
    end;
    if File1.Caption = '&Pie' then
      Series.DonutMode := dmNormal
    else
      Series.DonutMode := dmStacked;
  end;
  AdvGDIPChartView1.EndUpdate;
end;

procedure TForm19.tobmp1Click(Sender: TObject);
begin
  SavePictureDialog1.FilterIndex := 5;
  if SavePictureDialog1.Execute then
    AdvGDIPChartView1.SaveToImage(SavePictureDialog1.FileName, AdvGDIPChartView1.Width, AdvGDIPChartView1.Height, itBMP);
end;

procedure TForm19.N02Click(Sender: TObject);
begin
  Setangle(0);
end;

procedure TForm19.N452Click(Sender: TObject);
begin
  Setangle(45);
end;

procedure TForm19.N902Click(Sender: TObject);
begin
  Setangle(90);
end;

procedure TForm19.ogif1Click(Sender: TObject);
begin
  SavePictureDialog1.FilterIndex := 2;
  if SavePictureDialog1.Execute then
    AdvGDIPChartView1.SaveToImage(SavePictureDialog1.FileName, AdvGDIPChartView1.Width, AdvGDIPChartView1.Height, itGIF);
end;

procedure TForm19.ojpeg100quality1Click(Sender: TObject);
begin
  SavePictureDialog1.FilterIndex := 4;
  if SavePictureDialog1.Execute then
    AdvGDIPChartView1.SaveToImage(SavePictureDialog1.FileName, AdvGDIPChartView1.Width, AdvGDIPChartView1.Height, itJPEG, 50);
end;

procedure TForm19.ojpeg100quality2Click(Sender: TObject);
begin
  SavePictureDialog1.FilterIndex := 4;
  if SavePictureDialog1.Execute then
    AdvGDIPChartView1.SaveToImage(SavePictureDialog1.FileName, AdvGDIPChartView1.Width, AdvGDIPChartView1.Height, itJPEG, 100);
end;

procedure TForm19.ojpeg1Click(Sender: TObject);
begin
  SavePictureDialog1.FilterIndex := 4;
  if SavePictureDialog1.Execute then
    AdvGDIPChartView1.SaveToImage(SavePictureDialog1.FileName, AdvGDIPChartView1.Width, AdvGDIPChartView1.Height, itJPEG, 0);
end;

procedure TForm19.opng1Click(Sender: TObject);
begin
  SavePictureDialog1.FilterIndex := 3;
  if SavePictureDialog1.Execute then
    AdvGDIPChartView1.SaveToImage(SavePictureDialog1.FileName, AdvGDIPChartView1.Width, AdvGDIPChartView1.Height, itPNG);
end;

procedure TForm19.oTiff1Click(Sender: TObject);
begin
  SavePictureDialog1.FilterIndex := 1;
  if SavePictureDialog1.Execute then
    AdvGDIPChartView1.SaveToImage(SavePictureDialog1.FileName, AdvGDIPChartView1.Width, AdvGDIPChartView1.Height, itTIFF);
end;

end.
