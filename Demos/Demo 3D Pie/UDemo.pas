unit UDemo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, AdvOpenGLControl, AdvChartView3D,
  ExtCtrls, StdCtrls, ComCtrls, Math, AdvChartGDIP, ExtDlgs, ShellApi;

type
  TForm825 = class(TForm)
    Panel1: TPanel;
    TrackBar1: TTrackBar;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    TrackBar2: TTrackBar;
    Label3: TLabel;
    TrackBar3: TTrackBar;
    CheckBox1: TCheckBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    CheckBox2: TCheckBox;
    TrackBar4: TTrackBar;
    Label4: TLabel;
    TrackBar5: TTrackBar;
    Label5: TLabel;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    GroupBox4: TGroupBox;
    CheckBox5: TCheckBox;
    Button2: TButton;
    Label6: TLabel;
    TrackBar6: TTrackBar;
    Label7: TLabel;
    TrackBar7: TTrackBar;
    Button3: TButton;
    Button1: TButton;
    AdvChartView3D1: TAdvChartView3D;
    Button4: TButton;
    SavePictureDialog1: TSavePictureDialog;
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
    procedure TrackBar4Change(Sender: TObject);
    procedure TrackBar5Change(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure TrackBar6Change(Sender: TObject);
    procedure TrackBar7Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Initialize;
  end;

var
  Form825: TForm825;

implementation

{$R *.dfm}

procedure TForm825.Button1Click(Sender: TObject);
begin
  Initialize;
end;

procedure TForm825.Button2Click(Sender: TObject);
begin
  ShowMessage('Left-Mouse-Drag Up/Down/Left/Right: Rotate X, Y'+#13#10+'Right-Mouse-Drag Left/Right: Rotate Z'
  +#13#10+'MouseWheel-Scrolling: Change Z-Position');
end;

procedure TForm825.Button3Click(Sender: TObject);
var
  I: Integer;
begin
  AdvChartView3D1.BeginUpdate;
  for I := 0 to AdvChartView3D1.Series[0].Items.Count - 1 do
  begin
    AdvChartView3D1.Series[0].Items[I].Value := RandomRange(10, 200);
    AdvChartView3D1.Series[0].Items[I].Color := RGB(Random(255), Random(255), Random(255));
  end;
  AdvChartView3D1.EndUpdate;
end;

procedure TForm825.Button4Click(Sender: TObject);
var
  fn, ext: string;
  imgt: TImageType;
begin
  if SavePictureDialog1.Execute then
  begin
    fn := SavePictureDialog1.FileName;
    ext := LowerCase(ExtractFileExt(fn));
    imgt := itPNG;
    if (ext = '.jpeg') or (ext = '.jpg') then
      imgt := itJPEG;
    if (ext = '.png') then
      imgt := itPNG;
    if (ext = '.tiff') then
      imgt := itTIFF;
    if (ext = '.bmp') then
      imgt := itBMP;
    if (ext = '.gif') then
      imgt := itGIF;

    AdvChartView3D1.SaveToImage(fn, imgt);
    ShellExecute(0, PChar('open'), PChar(fn), '', '', 0);
  end;
end;

procedure TForm825.CheckBox1Click(Sender: TObject);
begin
  AdvChartView3D1.AntiAlias := CheckBox1.Checked;
  AdvChartView3D1.Repaint;
end;

procedure TForm825.CheckBox2Click(Sender: TObject);
begin
  AdvChartView3D1.BeginUpdate;
  if CheckBox2.Checked then
  begin
    AdvChartView3D1.Series[0].SizeType := stPercentage;
    AdvChartView3D1.Series[0].Size := 80;
  end
  else
  begin
    AdvChartView3D1.Series[0].SizeType := stPixels;
    AdvChartView3D1.Series[0].Size := 400;
  end;
  AdvChartView3D1.EndUpdate;
end;

procedure TForm825.CheckBox3Click(Sender: TObject);
begin
  AdvChartView3D1.Series[0].Values.ShowValues := CheckBox3.Checked;
end;

procedure TForm825.CheckBox4Click(Sender: TObject);
begin
  AdvChartView3D1.Series[0].Values.ImageVisible := CheckBox4.Checked;
end;

procedure TForm825.CheckBox5Click(Sender: TObject);
begin
  AdvChartView3D1.Series[0].Interaction := CheckBox5.Checked;
end;

procedure TForm825.FormCreate(Sender: TObject);
begin
  Initialize;
end;

procedure TForm825.Initialize;
begin
  AdvChartView3D1.BeginUpdate;
  AdvChartView3D1.InitSample;
  AdvChartView3D1.Title.Text := 'TMS Advanced Charts 3D Pie';
  AdvChartView3D1.Series[0].Size := 400;
  AdvChartView3D1.Series[0].Values.ShowCaptions := true;
  AdvChartView3D1.Series[0].Values.ShowValues := true;
  AdvChartView3D1.Series[0].Values.ShowPercentages := true;
  AdvChartView3D1.Series[0].Values.ImageAspectRatio := True;
  AdvChartView3D1.Series[0].Values.ValuesFont.size := 10;
  AdvChartView3D1.Series[0].Values.Fill.Color := clWhite;
  AdvChartView3D1.Series[0].Values.Fill.EndColor := clWhite;
  AdvChartView3D1.Series[0].Items.Clear;

  with AdvChartView3D1.Series[0].Items.Add do
  begin
    Caption := 'Coca Cola';
    Value := 250;
    Color := 255;
    Image.LoadFromFile(ExtractFilePath(Application.ExeName) +  '/img/cola.jpg');
  end;
  with AdvChartView3D1.Series[0].Items.Add do
  begin
    Caption := 'Fanta';
    Value := Random(100) + 10;
    Color := 42495;
    Image.LoadFromFile(ExtractFilePath(Application.ExeName) +  '/img/fanta.jpg');
  end;
  with AdvChartView3D1.Series[0].Items.Add do
  begin
    Caption := 'Sprite';
    Value := Random(100) + 10;
    Color := 5737262;
    Image.LoadFromFile(ExtractFilePath(Application.ExeName) +  '/img/sprite.jpg');
  end;
  with AdvChartView3D1.Series[0].Items.Add do
  begin
    Caption := 'Pepsi';
    Value := Random(100) + 10;
    Color := 11829830;
    Image.LoadFromFile(ExtractFilePath(Application.ExeName) +  '/img/pepsi.jpg');
  end;
  with AdvChartView3D1.Series[0].Items.Add do
  begin
    Caption := 'Ice Tea';
    Value := Random(100) + 10;
    Color := 3329434;
    Image.LoadFromFile(ExtractFilePath(Application.ExeName) +  '/img/icetea.jpg');
  end;
  AdvChartView3D1.Series[0].Items[4].Extraction := 50;

  TrackBar1.Position := Round(AdvChartView3D1.Series[0].XRotation);
  TrackBar2.Position := Round(AdvChartView3D1.Series[0].YRotation);
  TrackBar3.Position := Round(AdvChartView3D1.Series[0].ZRotation);
  TrackBar5.Position := 50;
  TrackBar6.Position := Round(AdvChartView3D1.Series[0].Depth);
  TrackBar7.Position := 255;
  TrackBar4.Position := 0;
  CheckBox2.Checked := False;
  CheckBox5.Checked := True;
  CheckBox1.Checked := True;
  CheckBox3.Checked := True;
  CheckBox4.Checked := True;
  AdvChartView3D1.EndUpdate;
end;

procedure TForm825.TrackBar1Change(Sender: TObject);
begin
  AdvChartView3D1.Series[0].XRotation := TrackBar1.Position;
end;

procedure TForm825.TrackBar2Change(Sender: TObject);
begin
  AdvChartView3D1.Series[0].YRotation := TrackBar2.Position;
end;

procedure TForm825.TrackBar3Change(Sender: TObject);
begin
  AdvChartView3D1.Series[0].ZRotation := TrackBar3.Position;
end;

procedure TForm825.TrackBar4Change(Sender: TObject);
begin
  AdvChartView3D1.Series[0].Items[4].Elevation := TrackBar4.Position;
end;

procedure TForm825.TrackBar5Change(Sender: TObject);
begin
  AdvChartView3D1.Series[0].Items[4].Extraction := TrackBar5.Position;
end;

procedure TForm825.TrackBar6Change(Sender: TObject);
begin
  AdvChartView3D1.Series[0].Depth := TrackBar6.Position;
end;

procedure TForm825.TrackBar7Change(Sender: TObject);
var
  I: Integer;
begin
  AdvChartView3D1.BeginUpdate;
  for I := 0 to AdvChartView3D1.Series[0].Items.Count - 1 do
    AdvChartView3D1.Series[0].Items[I].Transparency := TrackBar7.Position;
  AdvChartView3D1.EndUpdate;
end;

end.
