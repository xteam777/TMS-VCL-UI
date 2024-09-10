unit FinChartGDIP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdvChartPaneEditorGDIP, AdvChartView, AdvChartViewGDIP, Math,
  StdCtrls, jpeg, ExtCtrls;

type
  TForm10 = class(TForm)
    AdvChartPanesEditorDialogGDIP1: TAdvChartPanesEditorDialogGDIP;
    AdvGDIPChartView1: TAdvGDIPChartView;
    Button1: TButton;
    AdvGDIPChartView2: TAdvGDIPChartView;
    Button2: TButton;
    AdvChartPanesEditorDialogGDIP2: TAdvChartPanesEditorDialogGDIP;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    ScrollBar3: TScrollBar;
    ScrollBar4: TScrollBar;
    ScrollBar5: TScrollBar;
    ScrollBar6: TScrollBar;
    Label13: TLabel;
    Label14: TLabel;
    ScrollBar9: TScrollBar;
    ScrollBar10: TScrollBar;
    Label15: TLabel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    ScrollBar1: TScrollBar;
    ScrollBar2: TScrollBar;
    ScrollBar7: TScrollBar;
    ScrollBar8: TScrollBar;
    ScrollBar11: TScrollBar;
    ScrollBar12: TScrollBar;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ScrollBar3Change(Sender: TObject);
    procedure ScrollBar4Change(Sender: TObject);
    procedure ScrollBar7Change(Sender: TObject);
    procedure ScrollBar8Change(Sender: TObject);
    procedure ScrollBar6Change(Sender: TObject);
    procedure ScrollBar5Change(Sender: TObject);
    procedure ScrollBar9Change(Sender: TObject);
    procedure ScrollBar10Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ScrollBar11Change(Sender: TObject);
    procedure ScrollBar12Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Init;
  end;

var
  Form10: TForm10;

implementation

{$R *.dfm}

procedure TForm10.Button1Click(Sender: TObject);
begin
  AdvChartPanesEditorDialogGDIP1.Execute;
end;

procedure TForm10.Button2Click(Sender: TObject);
begin
  AdvChartPanesEditorDialogGDIP2.Execute;
end;

procedure TForm10.Button3Click(Sender: TObject);
begin
  Init;
end;

procedure TForm10.FormCreate(Sender: TObject);
begin
  Init;
end;

procedure TForm10.Init;
var
  c1, c2, c3, c4, c5, c6, c7, c8: TColor;
  I: Integer;
begin
  Randomize;
  c1 := RGB(47,118,179);
  c2 := RGB(11,79,146);
  c3 := RGB(152,190,218);
  c4 := RGB(63,128,181);
  c5 := RGB(137,119,199);
  c6 := RGB(84,73,122);
  c7 := RGB(255,85,0);
  c8 := RGB(179,59,0);

  AdvGDIPChartView1.Panes[0].Series[0].ClearPoints;
  AdvGDIPChartView1.Panes[0].Series[1].ClearPoints;
  AdvGDIPChartView1.Panes[0].Series[2].ClearPoints;
  AdvGDIPChartView2.Panes[0].Series[0].ClearPoints;
  AdvGDIPChartView2.Panes[0].Series[1].ClearPoints;
  AdvGDIPChartView2.Panes[0].Series[2].ClearPoints;
  for I := 0 to 30 do
  begin
    AdvGDIPChartView1.Panes[0].Series[0].AddSinglePoint(RandomRange(0, 50));
    AdvGDIPChartView1.Panes[0].Series[1].AddSinglePoint(RandomRange(10, 30));
    AdvGDIPChartView1.Panes[0].Series[2].AddSinglePoint(RandomRange(10, 40));    
    AdvGDIPChartView2.Panes[0].Series[0].AddSinglePoint(RandomRange(0, 50));
    AdvGDIPChartView2.Panes[0].Series[1].AddSinglePoint(RandomRange(10, 30));
    AdvGDIPChartView2.Panes[0].Series[2].AddSinglePoint(RandomRange(10, 30));    
  end;
  AdvGDIPChartView1.Panes[0].BackGround.Color := c1;
  AdvGDIPChartView1.Panes[0].BackGround.ColorTo := c2;
  AdvGDIPChartView1.Panes[0].Title.Color := c1;
  AdvGDIPChartView1.Panes[0].Title.ColorTo := c2;
  AdvGDIPChartView1.Panes[0].Xaxis.Color := c1;
  AdvGDIPChartView1.Panes[0].Xaxis.ColorTo := c2;
  AdvGDIPChartView1.Panes[0].YAxis.Color := c2;
  AdvGDIPChartView2.Panes[0].YAxis.Color := c4;
  AdvGDIPChartView2.Panes[0].Title.Color := c3;
  AdvGDIPChartView2.Panes[0].Title.ColorTo := c4;
  AdvGDIPChartView2.Panes[0].XAxis.Color := c3;
  AdvGDIPChartView2.Panes[0].XAxis.ColorTo := c4;
  AdvGDIPChartView2.Panes[0].Series[1].Color := c5;
  AdvGDIPChartView2.Panes[0].Series[1].ColorTo := c6;
  AdvGDIPChartView1.Panes[0].Series[1].Color := c7;
  AdvGDIPChartView1.Panes[0].Series[1].ColorTo := c8;
  AdvGDIPChartView2.Panes[0].ChartView.Color := c4;
  ScrollBar1.Position := AdvGDIPChartView2.Panes[0].Series[0].Opacity;
  ScrollBar2.Position := AdvGDIPChartView2.Panes[0].Series[0].OpacityTo;
  ScrollBar3.Position := AdvGDIPChartView1.Panes[0].Series[0].OpacityTo;
  ScrollBar4.Position := AdvGDIPChartView1.Panes[0].Series[1].Opacity;
  ScrollBar5.Position := AdvGDIPChartView1.Panes[0].Series[1].OpacityTo;
  ScrollBar6.Position := AdvGDIPChartView1.Panes[0].Series[0].Opacity;
  ScrollBar7.Position := AdvGDIPChartView2.Panes[0].Series[0].Opacity;
  ScrollBar8.Position := AdvGDIPChartView2.Panes[0].Series[1].OpacityTo;
  ScrollBar9.Position := AdvGDIPChartView1.Panes[0].Series[2].Opacity;
  ScrollBar10.Position := AdvGDIPChartView1.Panes[0].Series[2].OpacityTo;
  ScrollBar11.Position := AdvGDIPChartView2.Panes[0].Series[2].Opacity;
  ScrollBar12.Position := AdvGDIPChartView2.Panes[0].Series[2].OpacityTo;
end;

procedure TForm10.ScrollBar10Change(Sender: TObject);
begin
  AdvGDIPChartView1.panes[0].Series[2].OpacityTo := ScrollBar10.Position;
  AdvGDIPChartView1.Invalidate;
end;

procedure TForm10.ScrollBar11Change(Sender: TObject);
begin
  AdvGDIPChartView2.Panes[0].Series[2].Opacity := ScrollBar11.Position;
  AdvGDIPChartView2.Invalidate;
end;

procedure TForm10.ScrollBar12Change(Sender: TObject);
begin
  AdvGDIPChartView2.Panes[0].Series[2].OpacityTo := ScrollBar12.Position;
  AdvGDIPChartView2.Invalidate;
end;

procedure TForm10.ScrollBar1Change(Sender: TObject);
begin
  AdvGDIPChartView2.Panes[0].Series[1].Opacity := ScrollBar1.Position;
  AdvGDIPChartView2.Invalidate;
end;

procedure TForm10.ScrollBar2Change(Sender: TObject);
begin
  AdvGDIPChartView2.Panes[0].Series[0].OpacityTo := ScrollBar2.Position;
  AdvGDIPChartView2.Invalidate;
end;

procedure TForm10.ScrollBar3Change(Sender: TObject);
begin
  AdvGDIPChartView1.Panes[0].Series[0].OpacityTo := ScrollBar3.Position;
  AdvGDIPChartView1.Invalidate;
end;

procedure TForm10.ScrollBar4Change(Sender: TObject);
begin
  AdvGDIPChartView1.Panes[0].Series[1].Opacity := ScrollBar4.Position;
  AdvGDIPChartView1.Invalidate;
end;

procedure TForm10.ScrollBar5Change(Sender: TObject);
begin
  AdvGDIPChartView1.Panes[0].Series[1].OpacityTo := ScrollBar5.Position;
  AdvGDIPChartView1.Invalidate;
end;

procedure TForm10.ScrollBar6Change(Sender: TObject);
begin
  AdvGDIPChartView1.Panes[0].Series[0].Opacity := ScrollBar6.Position;
  AdvGDIPChartView1.Invalidate;
end;

procedure TForm10.ScrollBar7Change(Sender: TObject);
begin
  AdvGDIPChartView2.Panes[0].Series[0].Opacity := ScrollBar7.Position;
  AdvGDIPChartView2.Invalidate;
end;

procedure TForm10.ScrollBar8Change(Sender: TObject);
begin
  AdvGDIPChartView2.Panes[0].Series[1].OpacityTo := ScrollBar8.Position;
  AdvGDIPChartView2.Invalidate;
end;

procedure TForm10.ScrollBar9Change(Sender: TObject);
begin
  AdvGDIPChartView1.panes[0].Series[2].Opacity := ScrollBar9.Position;
  AdvGDIPChartView1.Invalidate;
end;

end.



