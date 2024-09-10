{***************************************************************************}
{ TAdvChartSerieEditor3D component                                          }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 2013                                               }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of the author.                                      }
{***************************************************************************}

unit AdvChartSerieEditor3D;

{$I TMSDEFS.INC}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdvChartView3D, StdCtrls, ComCtrls, ExtCtrls, ExtDlgs, AdvChartGDIP,
  AdvChartSelectors, AdvChartPointEditor3D, ShellApi, Math, Buttons, ToolWin, Mask, AdvChartSpin, CheckLst,
  AdvOpenGLControl
  {$IFDEF DELPHIXE3_LVL}
  , UITypes
  {$ENDIF}
  ;


type
  TSaveMode = (notsaving, saving, cancel);

  TAdvChartSeriesEditorForm3D = class(TForm)
    PageControl1: TPageControl;
    Panel3: TPanel;
    Panel4: TPanel;
    Button15: TButton;
    Button16: TButton;
    ListBox1: TCheckListBox;
    Panel5: TPanel;
    SpeedButton3: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Button18: TButton;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    TabSheet2: TTabSheet;
    PageControl2: TPageControl;
    TabSheet11: TTabSheet;
    GroupBox2: TGroupBox;
    Panel1: TPanel;
    Image1: TImage;
    AdvChartSpinEdit1: TAdvChartSpinEdit;
    AdvChartSpinEdit2: TAdvChartSpinEdit;
    AdvChartSpinEdit3: TAdvChartSpinEdit;
    Label5: TLabel;
    AdvChartSpinEdit6: TAdvChartSpinEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    TrackBar3: TTrackBar;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    CheckBox1: TCheckBox;
    Label17: TLabel;
    Label18: TLabel;
    CheckBox4: TCheckBox;
    Label19: TLabel;
    CheckBox5: TCheckBox;
    Label20: TLabel;
    CheckBox6: TCheckBox;
    AdvChartSpinEdit7: TAdvChartSpinEdit;
    Label21: TLabel;
    Label22: TLabel;
    Edit1: TEdit;
    Label23: TLabel;
    CheckBox7: TCheckBox;
    Label24: TLabel;
    CheckBox8: TCheckBox;
    Label25: TLabel;
    Label26: TLabel;
    AdvChartSpinEdit8: TAdvChartSpinEdit;
    AdvChartSpinEdit9: TAdvChartSpinEdit;
    Label28: TLabel;
    ComboBox1: TComboBox;
    Label29: TLabel;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    AdvColorSelector8: TAdvChartColorSelector;
    AdvChartColorSelector1: TAdvChartColorSelector;
    Label33: TLabel;
    CheckBox10: TCheckBox;
    Label34: TLabel;
    Label35: TLabel;
    AdvChartColorSelector2: TAdvChartColorSelector;
    AdvChartSpinEdit12: TAdvChartSpinEdit;
    Label36: TLabel;
    AdvChartSpinEdit13: TAdvChartSpinEdit;
    ColorDialog1: TColorDialog;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    AdvChartSpinEdit15: TAdvChartSpinEdit;
    AdvChartColorSelector3: TAdvChartColorSelector;
    Label40: TLabel;
    CheckBox11: TCheckBox;
    ComboBox4: TComboBox;
    Button8: TButton;
    Label41: TLabel;
    Label42: TLabel;
    Button1: TButton;
    FontDialog1: TFontDialog;
    Label43: TLabel;
    Label44: TLabel;
    GroupBox7: TGroupBox;
    Label48: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    CheckBox15: TCheckBox;
    ComboBox6: TComboBox;
    Button2: TButton;
    Button3: TButton;
    ComboBox5: TComboBox;
    Label50: TLabel;
    ComboBox7: TComboBox;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    AdvChartSpinEdit14: TAdvChartSpinEdit;
    AdvChartSpinEdit16: TAdvChartSpinEdit;
    Label49: TLabel;
    CheckBox12: TCheckBox;
    GroupBox8: TGroupBox;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    AdvChartSpinEdit17: TAdvChartSpinEdit;
    AdvChartColorSelector4: TAdvChartColorSelector;
    AdvChartColorSelector5: TAdvChartColorSelector;
    CheckBox13: TCheckBox;
    AdvChartSpinEdit20: TAdvChartSpinEdit;
    AdvChartColorSelector7: TAdvChartColorSelector;
    CheckBox14: TCheckBox;
    ComboBox8: TComboBox;
    Label3: TLabel;
    AdvChartSpinEdit4: TAdvChartSpinEdit;
    ComboBox9: TComboBox;
    Label6: TLabel;
    ComboBox10: TComboBox;
    Label10: TLabel;
    Edit2: TEdit;
    Label11: TLabel;
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ListBox1ClickCheck(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ListBox1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton4Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure AdvChartSpinEdit1Change(Sender: TObject);
    procedure AdvChartSpinEdit2Change(Sender: TObject);
    procedure AdvChartSpinEdit3Change(Sender: TObject);
    procedure AdvChartSpinEdit6Change(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure AdvChartSpinEdit7Change(Sender: TObject);
    procedure AdvColorSelector8Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvChartColorSelector1Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure CheckBox10Click(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure AdvChartSpinEdit9Change(Sender: TObject);
    procedure AdvChartSpinEdit8Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure AdvChartColorSelector2Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvChartSpinEdit12Change(Sender: TObject);
    procedure AdvChartSpinEdit13Change(Sender: TObject);
    procedure AdvChartColorSelector3Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure ComboBox4Change(Sender: TObject);
    procedure AdvChartSpinEdit15Change(Sender: TObject);
    procedure CheckBox11Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure CheckBox15Click(Sender: TObject);
    procedure CheckBox12Click(Sender: TObject);
    procedure ComboBox5Change(Sender: TObject);
    procedure ComboBox7Change(Sender: TObject);
    procedure AdvChartSpinEdit14Change(Sender: TObject);
    procedure AdvChartSpinEdit16Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure AdvChartSpinEdit17Change(Sender: TObject);
    procedure AdvChartColorSelector4Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvChartColorSelector5Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure CheckBox13Click(Sender: TObject);
    procedure AdvChartColorSelector7Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure ComboBox8Change(Sender: TObject);
    procedure AdvChartSpinEdit20Change(Sender: TObject);
    procedure CheckBox14Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ComboBox9Change(Sender: TObject);
    procedure ComboBox10Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
  private
    { Private declarations }
    FAllowR: Boolean;
    FChartview: TAdvChartView3D;
    FChartSeries: TChartSeries3D;
    Mode: TSaveMode;
    col: TChartSeries3D;
    FApply: TNotifyEvent;
    FChartPreview: TAdvChartView3D;
    procedure StartPointsEditor;
    procedure ApplyChanges(Sender: TObject);
    procedure ClearSelectedChartTypes;
    procedure CorrectTop(lbl: TLabel);
  public
    { Public declarations }
    property ChartSeries: TChartSeries3D read FChartSeries write FChartSeries;
    property ChartView: TAdvChartView3D read FChartview write FChartview;
    property AllowEditing: Boolean read FAllowR write FAllowR;
    procedure Init;
    procedure InitListBox;
    procedure SaveChanges;
    property Apply: TNotifyEvent read FApply write FApply;
  end;

  {$IFDEF DELPHIXE2_LVL}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  {$ENDIF}
  TAdvChartSeriesEditorDialog3D = class(TCommonDialog)
  private
    FForm: TAdvChartSeriesEditorForm3D;
    FChartView: TAdvChartView3D;
    FCaption: string;
    FAllowPointEditing: Boolean;
    FAllowSerieNameChange: Boolean;
    FAllowSerieReorder: Boolean;
    FAllowSerieAdding: Boolean;
    FAllowSerieRemoving: Boolean;
    procedure SetChartView(const Value: TAdvChartView3D);
  protected
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    function Execute: Boolean; override;
    property Form: TAdvChartSeriesEditorForm3D read FForm;
  published
    property Caption: string read FCaption write FCaption;
    property ChartView: TAdvChartView3D read FChartView write SetChartView;
    property AllowPointEditing: Boolean read FAllowPointEditing write FAllowPointEditing default True;
    property AllowSerieNameChange: Boolean read FAllowSerieNameChange write FAllowSerieNameChange default true;
    property AllowSerieRemoving: Boolean read FAllowSerieRemoving write FAllowSerieRemoving default true;
    property AllowSerieAdding: Boolean read FAllowSerieAdding write FAllowSerieAdding default true;
    property AllowSerieReorder: Boolean read FAllowSerieReorder write FAllowSerieReorder default true;
  end;

var
  AdvChartSeriesEditorForm3D: TAdvChartSeriesEditorForm3D;
  cs: TChartSerie3D;
  StartingPoint: TPoint;

implementation

{$R *.dfm}

procedure Split
   (const Delimiter: Char;
    Input: string;
    const Strings: TStrings) ;
begin
   Assert(Assigned(Strings)) ;
   Strings.Clear;
   Strings.Delimiter := Delimiter;
   Strings.DelimitedText := Input;
end;

procedure TAdvChartSeriesEditorForm3D.AdvChartColorSelector1Select(
  Sender: TObject; Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    AdvChartColorSelector1.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvChartColorSelector1.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvChartColorSelector1.SelectedColor := ColorDialog1.Color;
    end;
  end;

  cs.Values.Fill.EndColor := AdvChartColorSelector1.SelectedColor;
end;

procedure TAdvChartSeriesEditorForm3D.AdvChartColorSelector2Select(
  Sender: TObject; Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    AdvChartColorSelector2.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvChartColorSelector2.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvChartColorSelector2.SelectedColor := ColorDialog1.Color;
    end;
  end;

  cs.Values.TickMarkColor := AdvChartColorSelector2.SelectedColor;
end;

procedure TAdvChartSeriesEditorForm3D.AdvChartColorSelector3Select(
  Sender: TObject; Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    AdvChartColorSelector3.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvChartColorSelector3.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvChartColorSelector3.SelectedColor := ColorDialog1.Color;
    end;
  end;

  cs.Values.Border.Color := AdvChartColorSelector3.SelectedColor;
end;

procedure TAdvChartSeriesEditorForm3D.AdvChartColorSelector4Select(
  Sender: TObject; Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    AdvChartColorSelector4.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvChartColorSelector4.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvChartColorSelector4.SelectedColor := ColorDialog1.Color;
    end;
  end;

  cs.Legend.Fill.Color := AdvChartColorSelector4.SelectedColor;
end;

procedure TAdvChartSeriesEditorForm3D.AdvChartColorSelector5Select(
  Sender: TObject; Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    AdvChartColorSelector5.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvChartColorSelector5.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvChartColorSelector5.SelectedColor := ColorDialog1.Color;
    end;
  end;

  cs.Legend.Fill.EndColor := AdvChartColorSelector5.SelectedColor;
end;

procedure TAdvChartSeriesEditorForm3D.AdvChartColorSelector7Select(
  Sender: TObject; Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    AdvChartColorSelector7.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvChartColorSelector7.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvChartColorSelector7.SelectedColor := ColorDialog1.Color;
    end;
  end;

  cs.Legend.Border.Color := AdvChartColorSelector7.SelectedColor;
end;

procedure TAdvChartSeriesEditorForm3D.AdvChartSpinEdit12Change(Sender: TObject);
begin
  cs.Values.TickMarkLength := AdvChartSpinEdit12.Value;
end;

procedure TAdvChartSeriesEditorForm3D.AdvChartSpinEdit13Change(Sender: TObject);
begin
  cs.Values.TickMarkSize := AdvChartSpinEdit13.Value;
end;

procedure TAdvChartSeriesEditorForm3D.AdvChartSpinEdit14Change(Sender: TObject);
begin
  cs.Legend.Margin := AdvChartSpinEdit14.Value;
end;

procedure TAdvChartSeriesEditorForm3D.AdvChartSpinEdit15Change(Sender: TObject);
begin
  cs.Values.Border.Width := AdvChartSpinEdit15.Value;
end;

procedure TAdvChartSeriesEditorForm3D.AdvChartSpinEdit16Change(Sender: TObject);
begin
  cs.Legend.Padding := AdvChartSpinEdit16.Value;
end;

procedure TAdvChartSeriesEditorForm3D.AdvChartSpinEdit17Change(Sender: TObject);
begin
  cs.Legend.Transparency := AdvChartSpinEdit17.Value;
end;

procedure TAdvChartSeriesEditorForm3D.AdvChartSpinEdit1Change(Sender: TObject);
begin
  cs.Left := AdvChartSpinEdit1.FloatValue;
end;

procedure TAdvChartSeriesEditorForm3D.AdvChartSpinEdit20Change(Sender: TObject);
begin
  cs.Legend.Border.Width := AdvChartSpinEdit20.Value;
end;

procedure TAdvChartSeriesEditorForm3D.AdvChartSpinEdit2Change(Sender: TObject);
begin
  cs.Top := AdvChartSpinEdit2.FloatValue;
end;

procedure TAdvChartSeriesEditorForm3D.AdvChartSpinEdit3Change(Sender: TObject);
begin
  cs.Size := AdvChartSpinEdit3.FloatValue;
end;

procedure TAdvChartSeriesEditorForm3D.AdvChartSpinEdit6Change(Sender: TObject);
begin
  cs.Depth := AdvChartSpinEdit6.FloatValue;
end;

procedure TAdvChartSeriesEditorForm3D.AdvChartSpinEdit7Change(Sender: TObject);
begin
  cs.Values.Transparency := AdvChartSpinEdit7.Value;
end;

procedure TAdvChartSeriesEditorForm3D.AdvChartSpinEdit8Change(Sender: TObject);
begin
  cs.Values.ImageHeight := AdvChartSpinEdit8.Value;
end;

procedure TAdvChartSeriesEditorForm3D.AdvChartSpinEdit9Change(Sender: TObject);
begin
  cs.Values.ImageWidth := AdvChartSpinEdit9.Value;
end;

procedure TAdvChartSeriesEditorForm3D.AdvColorSelector8Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advcolorselector8.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvColorSelector8.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvColorSelector8.SelectedColor := ColorDialog1.Color;
    end;
  end;

  cs.Values.Fill.Color := AdvColorSelector8.SelectedColor;
end;

procedure TAdvChartSeriesEditorForm3D.ApplyChanges(Sender: TObject);
begin
  SaveChanges;
  if Assigned(Apply) then
    Apply(Self);
end;

procedure TAdvChartSeriesEditorForm3D.Button15Click(Sender: TObject);
begin
  Mode := saving;
  SaveChanges;
  Self.Close;
  ModalResult := mrOk;
end;

procedure TAdvChartSeriesEditorForm3D.Button16Click(Sender: TObject);
begin
  Mode := cancel;
  Self.Close;
  ModalResult := mrCancel;
end;

procedure TAdvChartSeriesEditorForm3D.Button18Click(Sender: TObject);
begin
  SaveChanges;
  if Assigned(Apply) then
    Apply(Self);
end;

procedure TAdvChartSeriesEditorForm3D.Button1Click(Sender: TObject);
begin
  FontDialog1.Font.Assign(cs.Values.CaptionsFont);
  if FontDialog1.Execute then
  begin
    cs.Values.CaptionsFont.Assign(FontDialog1.Font);
    Label44.Font.Assign(cs.Values.CaptionsFont);
    CorrectTop(label44);
  end;
end;

procedure TAdvChartSeriesEditorForm3D.Button2Click(Sender: TObject);
begin
  FontDialog1.Font.Assign(cs.Legend.ItemsFont);
  if FontDialog1.Execute then
  begin
    cs.Legend.ItemsFont.Assign(FontDialog1.Font);
    Label54.Font.Assign(cs.Legend.ItemsFont);
    CorrectTop(label54);
  end;
end;

procedure TAdvChartSeriesEditorForm3D.Button3Click(Sender: TObject);
begin
  FontDialog1.Font.Assign(cs.Legend.CaptionFont);
  if FontDialog1.Execute then
  begin
    cs.Legend.CaptionFont.Assign(FontDialog1.Font);
    Label55.Font.Assign(cs.Legend.CaptionFont);
    CorrectTop(label55);
  end;
end;

procedure TAdvChartSeriesEditorForm3D.Button8Click(Sender: TObject);
begin
  FontDialog1.Font.Assign(cs.Values.ValuesFont);
  if FontDialog1.Execute then
  begin
    cs.Values.ValuesFont.Assign(FontDialog1.Font);
    Label43.Font.Assign(cs.Values.ValuesFont);
    CorrectTop(label43);
  end;
end;

procedure TAdvChartSeriesEditorForm3D.CheckBox10Click(Sender: TObject);
begin
  cs.Values.Fill.Visible := CheckBox10.Checked;
end;

procedure TAdvChartSeriesEditorForm3D.CheckBox11Click(Sender: TObject);
begin
  cs.Values.Border.Visible := CheckBox11.Checked;
end;

procedure TAdvChartSeriesEditorForm3D.CheckBox12Click(Sender: TObject);
begin
  cs.Legend.CaptionVisible := CheckBox12.Checked;
end;

procedure TAdvChartSeriesEditorForm3D.CheckBox13Click(Sender: TObject);
begin
  cs.Legend.Fill.Visible := CheckBox13.Checked;
end;

procedure TAdvChartSeriesEditorForm3D.CheckBox14Click(Sender: TObject);
begin
  cs.Legend.Border.Visible := CheckBox14.Checked;
end;

procedure TAdvChartSeriesEditorForm3D.CheckBox15Click(Sender: TObject);
begin
  cs.Legend.Visible := CheckBox15.Checked;
end;

procedure TAdvChartSeriesEditorForm3D.CheckBox1Click(Sender: TObject);
begin
  cs.Values.ShowValues := CheckBox1.Checked;
end;

procedure TAdvChartSeriesEditorForm3D.CheckBox4Click(Sender: TObject);
begin
  cs.Values.ShowCaptions := CheckBox4.Checked;
end;

procedure TAdvChartSeriesEditorForm3D.CheckBox5Click(Sender: TObject);
begin
  cs.Values.ShowPercentages := CheckBox5.Checked;
end;

procedure TAdvChartSeriesEditorForm3D.CheckBox6Click(Sender: TObject);
begin
  cs.Values.Visible := CheckBox6.Checked;
end;

procedure TAdvChartSeriesEditorForm3D.CheckBox7Click(Sender: TObject);
begin
  cs.Values.ImageVisible := CheckBox7.Checked;
end;

procedure TAdvChartSeriesEditorForm3D.CheckBox8Click(Sender: TObject);
begin
  cs.Values.ImageAspectRatio := CheckBox8.Checked;
end;

procedure TAdvChartSeriesEditorForm3D.ClearSelectedChartTypes;
var
  I, K, J: Integer;
begin
  with PageControl2 do
  begin
    for I := 0 to PageCount - 1 do
    begin
      with Pages[I] do
      begin
        for K := 0 to Pages[I].ControlCount - 1 do
        begin
          if Pages[I].Controls[K] is TGroupBox then
          begin
            for J := 0 to TGroupBox(Pages[I].Controls[K]).ControlCount - 1 do
            begin
              if TGroupBox(Pages[I].Controls[K]).Controls[J] is TPanel then
              begin
                if (TGroupBox(Pages[I].Controls[K]).Controls[J] as TPanel).Tag = 99 then
                  TPanel(TGroupBox(Pages[I].Controls[K]).Controls[J]).Color := clWhite;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TAdvChartSeriesEditorForm3D.ComboBox10Change(Sender: TObject);
begin
  cs.Legend.Fill.Direction := TChartGradientDirection3D(ComboBox10.ItemIndex);
end;

procedure TAdvChartSeriesEditorForm3D.ComboBox1Change(Sender: TObject);
begin
  cs.Values.ImagePosition := TChartItemPosition3D(ComboBox1.ItemIndex);
end;

procedure TAdvChartSeriesEditorForm3D.ComboBox2Change(Sender: TObject);
begin
  cs.Values.CaptionAlignment := TChartTextAlignment3D(ComboBox2.ItemIndex);
end;

procedure TAdvChartSeriesEditorForm3D.ComboBox3Change(Sender: TObject);
begin
  cs.Values.ValuesAlignment := TChartTextAlignment3D(ComboBox3.ItemIndex);
end;

procedure TAdvChartSeriesEditorForm3D.ComboBox4Change(Sender: TObject);
begin
  cs.Values.Border.Style := DashStyle(ComboBox4.ItemIndex);
end;

procedure TAdvChartSeriesEditorForm3D.ComboBox5Change(Sender: TObject);
begin
  cs.Legend.CaptionAlignment := TChartTextAlignment3D(ComboBox5.ItemIndex);
end;

procedure TAdvChartSeriesEditorForm3D.ComboBox7Change(Sender: TObject);
begin
  cs.Legend.Position := TChartItemPosition3D(ComboBox7.ItemIndex);
end;

procedure TAdvChartSeriesEditorForm3D.ComboBox8Change(Sender: TObject);
begin
  cs.Legend.Border.Style := DashStyle(ComboBox8.ItemIndex);
end;

procedure TAdvChartSeriesEditorForm3D.ComboBox9Change(Sender: TObject);
begin
  cs.Values.Fill.Direction := TChartGradientDirection3D(ComboBox9.ItemIndex);
end;

procedure TAdvChartSeriesEditorForm3D.CorrectTop(lbl: TLabel);
begin
  lbl.Top := Round(lbl.Tag - (lbl.Font.Size - 8) / 2);
end;

procedure TAdvChartSeriesEditorForm3D.Edit1Change(Sender: TObject);
begin
  cs.Values.ValueFormat := Edit1.Text;
end;

procedure TAdvChartSeriesEditorForm3D.Edit2Change(Sender: TObject);
begin
  cs.Values.PercentageFormat := Edit2.Text;
end;

procedure TAdvChartSeriesEditorForm3D.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Mode = notsaving then
  begin
    case MessageDlg('Save Changes ?',mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
      begin
        SaveChanges;
        col.Free;
        ModalResult := mrOk;
      end;
      mrNo:
      begin
        col.Free;
        ModalResult := mrCancel;
      end;
      mrCancel: Action := caNone;
    end;
  end
  else
  begin
    Col.free;
  end;
end;

procedure TAdvChartSeriesEditorForm3D.FormCreate(Sender: TObject);
begin
  {$IFDEF DELPHI9_LVL}
  DoubleBuffered := true;
  {$ENDIF}

  FChartPreview := TAdvChartView3D.Create(GroupBox1);
  FChartPreview.InitSample;
  FChartPreview.Parent := GroupBox1;
  FChartPreview.SetBounds(172, 119, 211, 138);
  FChartPreview.Title.Visible := False;
  FChartPreview.Series[0].Values.Visible := False;
  FChartPreview.Series[0].Size := FChartPreview.Width / 2;
  FChartPreview.Series[0].Legend.Visible := False;
  FChartPreview.Series[0].Depth := 10;
end;

procedure TAdvChartSeriesEditorForm3D.FormDestroy(Sender: TObject);
begin
  if Assigned(FChartPreview) then
    FChartPreview.Free;
end;

procedure TAdvChartSeriesEditorForm3D.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Mode := saving;
    SaveChanges;
    Self.Close;
    ModalResult := mrok;
  end
  else if Key = VK_ESCAPE then
  begin
    Mode := cancel;
    Self.Close;
    ModalResult := mrCancel;
  end
  else if (Key = VK_DELETE) and (ListBox1.Focused) then
  begin
    if listbox1.ItemIndex >= 0 then
    begin
      if MessageDlg('Do you want to remove the selected serie?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        col[Listbox1.ItemIndex].Free;
        InitListBox;
      end;
    end;
  end;
end;

procedure TAdvChartSeriesEditorForm3D.Image1Click(Sender: TObject);
begin
  ClearSelectedChartTypes;
  if Assigned((Sender as TImage).Parent) and ((Sender as TImage).Parent is TPanel) then
  begin
    ((Sender as TImage).Parent as TPanel).Color := $00B37B59;
    cs.ChartType := TChartType3D((Sender as TImage).Tag);
  end;
end;

procedure TAdvChartSeriesEditorForm3D.Init;
var
 i: integer;
 K: integer;
begin
  PageControl1.ActivePageIndex := 0;

  col := TChartSeries3D.Create(nil);
  ListBox1.Items.Clear;
  K := 0;

  for i := 0 to ChartSeries.Count - 1 do
  begin
//    if not ChartSeries[i].ReadOnly then
    begin
      Col.Add;
      Col[K].Assign(ChartSeries[i]);
      Inc(K);
    end;
  end;
  InitListBox;
end;

procedure TAdvChartSeriesEditorForm3D.InitListBox;
var
  i: integer;
begin
  ListBox1.Items.Clear;
  for i := 0 to col.Count - 1 do
  begin
    listbox1.Items.Add(Col[i].Caption);
    ListBox1.Checked[i] := Col[i].Visible;
  end;

  if Listbox1.Items.Count = 0 then
  begin
    PageControl1.Enabled := false;
    PageControl1.Visible := false;
    Panel3.Visible := true;
  end
  else
  begin
    ListBox1.ItemIndex := 0;
    ListBox1Click(ListBox1);
  end;
end;

procedure TAdvChartSeriesEditorForm3D.ListBox1Click(Sender: TObject);
var
  I, J, K: Integer;
begin
  if listbox1.ItemIndex >= 0 then
  begin
    cs := Col[listbox1.ItemIndex];
    PageControl1.Enabled := not (cs = nil);
    PageControl1.Visible := not (cs = nil);
    Panel3.Visible := false;

    AdvChartSpinEdit1.FloatValue := cs.Left;
    AdvChartSpinEdit2.FloatValue := cs.Top;
    AdvChartSpinEdit3.FloatValue := cs.Size;
    AdvChartSpinEdit6.FloatValue := cs.Depth;
    TrackBar1.Position := Round(cs.XRotation);
    TrackBar2.Position := Round(cs.YRotation);
    TrackBar3.Position := Round(cs.ZRotation);

    CheckBox1.Checked := cs.Values.ShowValues;
    CheckBox4.Checked := cs.Values.ShowCaptions;
    CheckBox5.Checked := cs.Values.ShowPercentages;
    CheckBox6.Checked := cs.Values.Visible;
    AdvChartSpinEdit7.Value := cs.Values.Transparency;
    AdvColorSelector8.SelectedColor := cs.Values.Fill.Color;
    AdvChartColorSelector1.SelectedColor := cs.Values.Fill.EndColor;
    CheckBox10.Checked := cs.Values.Fill.Visible;
    CheckBox7.Checked := cs.Values.ImageVisible;
    CheckBox8.Checked := cs.Values.ImageAspectRatio;
    AdvChartSpinEdit9.Value := cs.Values.ImageWidth;
    AdvChartSpinEdit8.Value := cs.Values.ImageHeight;
    Edit1.Text := cs.Values.ValueFormat;
    Edit2.Text := cs.Values.PercentageFormat;
    ComboBox2.ItemIndex := Integer(cs.Values.ValuesAlignment);
    ComboBox3.ItemIndex := Integer(cs.Values.CaptionAlignment);
    AdvChartColorSelector2.SelectedColor := cs.Values.TickMarkColor;
    AdvChartSpinEdit12.Value := cs.Values.TickMarkLength;
    AdvChartSpinEdit13.Value := cs.Values.TickMarkSize;
    ComboBox1.ItemIndex := Integer(cs.Values.ImagePosition);
    CheckBox11.Checked := cs.Values.Border.Visible;
    AdvChartSpinEdit15.Value := cs.Values.Border.Width;
    ComboBox4.ItemIndex := Integer(cs.Values.Border.Style);
    AdvChartColorSelector3.SelectedColor := cs.Values.Border.Color;

    Label43.Font.Assign(cs.Values.ValuesFont);
    CorrectTop(Label43);

    Label44.Font.Assign(cs.Values.CaptionsFont);
    CorrectTop(Label44);


    CheckBox15.Checked := cs.Legend.Visible;
    CheckBox12.Checked := cs.Legend.CaptionVisible;

    ComboBox5.ItemIndex := Integer(cs.Legend.CaptionAlignment);
    ComboBox7.ItemIndex := Integer(cs.Legend.Position);
    AdvChartSpinEdit14.Value := cs.Legend.Margin;
    AdvChartSpinEdit16.Value := cs.Legend.Padding;

    Label54.Font.Assign(cs.Legend.ItemsFont);
    CorrectTop(Label54);

    Label55.Font.Assign(cs.Legend.CaptionFont);
    CorrectTop(Label55);

    AdvChartSpinEdit17.Value := cs.Legend.Transparency;
    AdvChartColorSelector4.SelectedColor := cs.Legend.Fill.Color;
    AdvChartColorSelector5.SelectedColor := cs.Legend.Fill.EndColor;
    CheckBox13.Checked := cs.Legend.Fill.Visible;
    AdvChartColorSelector7.SelectedColor := cs.Legend.Border.Color;
    ComboBox8.ItemIndex := Integer(cs.Legend.Border.Style);
    AdvChartSpinEdit20.Value := cs.Legend.Border.Width;
    CheckBox14.Checked := cs.Legend.Border.Visible;
    ComboBox9.ItemIndex := Integer(cs.Values.Fill.Direction);
    ComboBox10.ItemIndex := Integer(cs.Legend.Fill.Direction);


    FChartPreview.Series[0].XRotation := cs.XRotation;
    FChartPreview.Series[0].ZRotation := cs.ZRotation;
    FChartPreview.Series[0].YRotation := cs.YRotation;


    with PageControl2 do
    begin
      for I := 0 to PageCount - 1 do
      begin
        with Pages[I] do
        begin
          for K := 0 to Pages[I].ControlCount - 1 do
          begin
            if Pages[I].Controls[K] is TGroupBox then
            begin
              for J := 0 to TGroupBox(Pages[I].Controls[K]).ControlCount - 1 do
              begin
                if TGroupBox(Pages[I].Controls[K]).Controls[J] is TPanel then
                begin
                  if (TGroupBox(Pages[I].Controls[K]).Controls[J] as TPanel).Tag = 99 then
                  begin
                    if ((TGroupBox(Pages[I].Controls[K]).Controls[J] as TPanel).Controls[0] as TImage).Tag = integer(cs.ChartType) then
                    begin
                      (TGroupBox(Pages[I].Controls[K]).Controls[J] as TPanel).Color := $00B37B59;
                      PageControl2.ActivePageIndex := I;
                      Exit;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;


procedure TAdvChartSeriesEditorForm3D.ListBox1ClickCheck(Sender: TObject);
begin
  if (ListBox1.ItemIndex >= 0) and (ListBox1.ItemIndex <= ListBox1.Items.Count - 1) then
    Col[ListBox1.ItemIndex].Visible := ListBox1.Checked[ListBox1.ItemIndex];
end;

procedure TAdvChartSeriesEditorForm3D.ListBox1DblClick(Sender: TObject);
begin
  if SpeedButton4.Enabled then
    StartPointsEditor;
end;

procedure TAdvChartSeriesEditorForm3D.ListBox1DragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  DropPosition, StartPosition: Integer;
  DropPoint: TPoint;
begin
  if FAllowR then
  begin
    DropPoint.X := X;
    DropPoint.Y := Y;
    with Source as TListBox do
    begin
      StartPosition := ItemAtPos(StartingPoint,True) ;
      DropPosition := ItemAtPos(DropPoint,True) ;
      if (StartPosition <> - 1) and (DropPosition <> -1) then
      begin
        Items.Move(StartPosition, DropPosition) ;
        Col[StartPosition].Index := DropPosition;
      end;
    end;
  end;
end;

procedure TAdvChartSeriesEditorForm3D.ListBox1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := (Source = ListBox1) and FAllowR;
end;

procedure TAdvChartSeriesEditorForm3D.ListBox1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  StartingPoint.X := X;
  StartingPoint.Y := Y;
end;

procedure TAdvChartSeriesEditorForm3D.SaveChanges;
var
  I: integer;
begin
  ChartView.BeginUpdate;
  ChartSeries.Clear;
  for I := 0 to col.Count - 1 do
  begin
    ChartSeries.Add;
    ChartSeries[I].Assign(col[I]);
  end;
  ChartView.EndUpdate;
end;

procedure TAdvChartSeriesEditorForm3D.SpeedButton1Click(Sender: TObject);
begin
  if listbox1.ItemIndex >= 0 then
  begin
    Col[Listbox1.ItemIndex].Free;
    InitListBox;
  end;
end;

procedure TAdvChartSeriesEditorForm3D.SpeedButton2Click(Sender: TObject);
begin
  Col.Add;
  InitListBox;
end;

procedure TAdvChartSeriesEditorForm3D.SpeedButton3Click(Sender: TObject);
var
  s: String;
begin
  if ListBox1.Items.Count <> 0 then
  begin
    InputQuery('Serie name', 'Please enter new name',s);
    if s <> '' then
    begin
      cs.Caption := s;
      ListBox1.Items[cs.Index] := s;
    end;
  end;
end;

procedure TAdvChartSeriesEditorForm3D.SpeedButton4Click(Sender: TObject);
begin
  StartPointsEditor;
end;

procedure TAdvChartSeriesEditorForm3D.StartPointsEditor;
var
  ac: TAdvChartPointEditorForm3D;
begin
  if ListBox1.Items.Count <> 0 then
  begin
    ac := TAdvChartPointEditorForm3D.Create(Self);
    ac.ChartItems := cs.Items;
    ac.Chartview := FChartView;
    ac.Init;
    ac.Apply := ApplyChanges;
    ac.ShowModal;
    ac.Free;
  end;
end;

procedure TAdvChartSeriesEditorForm3D.TrackBar1Change(Sender: TObject);
begin
  cs.XRotation := Trackbar1.Position;
  Label14.Caption := floattostr(cs.XRotation);
  FChartPreview.Series[0].XRotation := cs.XRotation;
end;

procedure TAdvChartSeriesEditorForm3D.TrackBar2Change(Sender: TObject);
begin
  cs.YRotation := Trackbar2.Position;
  Label15.Caption := floattostr(cs.YRotation);
  FChartPreview.Series[0].YRotation := cs.YRotation;
end;

procedure TAdvChartSeriesEditorForm3D.TrackBar3Change(Sender: TObject);
begin
  cs.ZRotation := Trackbar3.Position;
  Label16.Caption := floattostr(cs.ZRotation);
  FChartPreview.Series[0].ZRotation := cs.ZRotation;
end;

{ TAdvChartSerieEditorDialog3D }

constructor TAdvChartSeriesEditorDialog3D.Create(AOwner: TComponent);
begin
  inherited;
  FAllowSerieRemoving := true;
  FAllowSerieNameChange := true;
  FAllowSerieReorder := true;
  FAllowSerieAdding := true;
  FAllowPointEditing := true;
end;

function TAdvChartSeriesEditorDialog3D.Execute: Boolean;
begin
  if not Assigned(FChartView) then
  begin
    raise Exception.Create('The dialog does not have AdvChartView3D Component assigned.');
    Result := False;
    Exit;
  end;

  FForm := TAdvChartSeriesEditorForm3D.Create(Application);
  FForm.ChartSeries := FChartView.Series;
  FForm.ChartView := FChartView;
  FForm.SpeedButton4.Enabled := AllowPointEditing;
  FForm.SpeedButton3.Enabled := AllowSerieNameChange;
  FForm.SpeedButton2.Enabled := AllowSerieAdding;
  FForm.SpeedButton1.Enabled := AllowSerieRemoving;
  FForm.FAllowR := AllowSerieReorder;
  if FCaption <> '' then
    Form.Caption := FCaption;
  try
    FForm.Init;
    if Assigned(OnShow) then
      OnShow(Self);
    Result := FForm.ShowModal = mrOK;
    if Assigned(OnClose) then
      OnClose(Self);
  finally
    FForm.Free;
  end;
end;

procedure TAdvChartSeriesEditorDialog3D.Notification(AComponent: TComponent;
  AOperation: TOperation);
begin
  inherited;
  if (AComponent = FChartView) and (AOperation = opRemove) then
    FChartView := nil;
end;

procedure TAdvChartSeriesEditorDialog3D.SetChartView(const Value: TAdvChartView3D);
begin
  FChartView := Value;
end;

end.

