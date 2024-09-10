{***************************************************************************}
{ TAdvGDIPChartSerieEditor component                                        }
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

unit AdvChartSerieEditorGDIP;

{$I TMSDEFS.INC}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdvChartGDIP, AdvChartViewGDIP, StdCtrls, ComCtrls, ExtCtrls, ExtDlgs,
  advChartselectors, AdvChartTypeSelector, Math, Buttons,
  ToolWin, Mask, AdvChart, AdvChartView, AdvChartSpin, AdvChartAnnotationEditorGDIP,
  CheckLst;

type
  TCrackedChartSerie = class(TAdvGDIPChartSerie)
  
  end;
  
  TSaveMode = (notsaving, saving, cancel);
  TAdvChartSeriesEditorFormGDIP = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    Panel3: TPanel;
    GroupBox1: TGroupBox;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    SpinEdit18: TAdvChartSpinEdit;
    SpinEdit17: TAdvChartSpinEdit;
    AdvColorSelector13: TAdvChartColorSelector;
    GroupBox2: TGroupBox;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    SpinEdit19: TAdvChartSpinEdit;
    ComboBox9: TComboBox;
    GroupBox3: TGroupBox;
    Label64: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    GroupBox4: TGroupBox;
    ComboBox8: TComboBox;
    Label60: TLabel;
    CheckBox4: TCheckBox;
    Edit6: TEdit;
    Label58: TLabel;
    Label57: TLabel;
    SpinEdit16: TAdvChartSpinEdit;
    Label56: TLabel;
    Label53: TLabel;
    SpinEdit15: TAdvChartSpinEdit;
    Edit5: TEdit;
    Label59: TLabel;
    Label55: TLabel;
    SpinEdit14: TAdvChartSpinEdit;
    SpinEdit13: TAdvChartSpinEdit;
    Label54: TLabel;
    Label52: TLabel;
    Label51: TLabel;
    Label50: TLabel;
    Edit4: TEdit;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    GroupBox6: TGroupBox;
    Label85: TLabel;
    Label86: TLabel;
    Label87: TLabel;
    Label88: TLabel;
    Label89: TLabel;
    SpinEdit25: TAdvChartSpinEdit;
    ComboBox15: TComboBox;
    Edit12: TEdit;
    Button11: TButton;
    GroupBox7: TGroupBox;
    Label90: TLabel;
    Label91: TLabel;
    Label92: TLabel;
    Label93: TLabel;
    Label94: TLabel;
    SpinEdit26: TAdvChartSpinEdit;
    ComboBox17: TComboBox;
    Edit13: TEdit;
    Button12: TButton;
    GroupBox8: TGroupBox;
    Label95: TLabel;
    Label100: TLabel;
    Label101: TLabel;
    SpinEdit27: TAdvChartSpinEdit;
    SpinEdit28: TAdvChartSpinEdit;
    AdvColorSelector14: TAdvChartColorSelector;
    GroupBox5: TGroupBox;
    Label74: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    Label82: TLabel;
    ComboBox13: TComboBox;
    CheckBox5: TCheckBox;
    SpinEdit21: TAdvChartSpinEdit;
    SpinEdit23: TAdvChartSpinEdit;
    Button9: TButton;
    Button10: TButton;
    GroupBox9: TGroupBox;
    Label99: TLabel;
    Label98: TLabel;
    Label97: TLabel;
    CheckBox6: TCheckBox;
    AdvColorSelector15: TAdvChartColorSelector;
    SpinEdit29: TAdvChartSpinEdit;
    GroupBox20: TGroupBox;
    ComboBox4: TComboBox;
    SpinEdit5: TAdvChartSpinEdit;
    Label34: TLabel;
    Label33: TLabel;
    CheckBox1: TCheckBox;
    Label30: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label29: TLabel;
    AdvColorSelector10: TAdvChartColorSelector;
    AdvColorSelector9: TAdvChartColorSelector;
    AdvColorSelector8: TAdvChartColorSelector;
    Button8: TButton;
    GroupBox22: TGroupBox;
    Label37: TLabel;
    Label32: TLabel;
    Edit1: TEdit;
    Label36: TLabel;
    TabSheet5: TTabSheet;
    GroupBox10: TGroupBox;
    Label44: TLabel;
    Label49: TLabel;
    Label46: TLabel;
    Label48: TLabel;
    Label45: TLabel;
    ComboBox7: TComboBox;
    Panel1: TPanel;
    Image2: TImage;
    AdvColorSelector12: TAdvChartColorSelector;
    SpinEdit11: TAdvChartSpinEdit;
    SpinEdit12: TAdvChartSpinEdit;
    GroupBox23: TGroupBox;
    AdvColorSelector6: TAdvChartColorSelector;
    Label22: TLabel;
    GroupBox24: TGroupBox;
    Panel2: TPanel;
    Label4: TLabel;
    Label2: TLabel;
    ComboBox2: TComboBox;
    GroupBox25: TGroupBox;
    Label27: TLabel;
    Label26: TLabel;
    SpinEdit4: TAdvChartSpinEdit;
    AdvColorSelector7: TAdvChartColorSelector;
    Button13: TButton;
    Button14: TButton;
    OpenPictureDialog1: TOpenPictureDialog;
    FontDialog1: TFontDialog;
    SpinEdit31: TAdvChartSpinEdit;
    SpinEdit20: TAdvChartSpinEdit;
    SpinEdit32: TAdvChartSpinEdit;
    ComboBox10: TComboBox;
    Button7: TButton;
    SpinEdit33: TAdvChartSpinEdit;
    SpinEdit34: TAdvChartSpinEdit;
    AdvChartView1: TAdvChartView;
    Panel4: TPanel;
    Button15: TButton;
    Button16: TButton;
    ListBox1: TCheckListBox;
    Panel5: TPanel;
    SpeedButton3: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    AdvSpinEdit1: TAdvChartSpinEdit;
    AdvSpinEdit2: TAdvChartSpinEdit;
    AdvSpinEdit4: TAdvChartSpinEdit;
    AdvSpinEdit5: TAdvChartSpinEdit;
    AdvSpinEdit3: TAdvChartSpinEdit;
    Label6: TLabel;
    AdvBrushStyleSelector1: TAdvChartBrushStyleSelector;
    SpinEdit3: TAdvChartSpinEdit;
    Label23: TLabel;
    AdvColorSelector1: TAdvChartColorSelector;
    Label5: TLabel;
    Label3: TLabel;
    SpinEdit1: TAdvChartSpinEdit;
    Label28: TLabel;
    AdvPenStyleSelector1: TAdvChartPenStyleSelector;
    GroupBox19: TGroupBox;
    Label42: TLabel;
    SpinEdit10: TAdvChartSpinEdit;
    ComboBox6: TComboBox;
    Label43: TLabel;
    GroupBox21: TGroupBox;
    Label39: TLabel;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Label38: TLabel;
    Label41: TLabel;
    ComboBox5: TComboBox;
    Edit3: TEdit;
    Label40: TLabel;
    SpinEdit6: TAdvChartSpinEdit;
    Label7: TLabel;
    SpinEdit7: TAdvChartSpinEdit;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    AdvChartColorSelector1: TAdvChartColorSelector;
    AdvChartColorSelector2: TAdvChartColorSelector;
    Label11: TLabel;
    SpinEdit8: TAdvChartSpinEdit;
    Label12: TLabel;
    SpinEdit9: TAdvChartSpinEdit;
    SpeedButton4: TSpeedButton;
    ComboBox1: TComboBox;
    Label1: TLabel;
    GroupBox26: TGroupBox;
    CheckBox7: TCheckBox;
    Label13: TLabel;
    AdvChartColorSelector3: TAdvChartColorSelector;
    AdvChartColorSelector4: TAdvChartColorSelector;
    Label14: TLabel;
    Label16: TLabel;
    ComboBox3: TComboBox;
    ComboBox25: TComboBox;
    Label17: TLabel;
    Label131: TLabel;
    AdvChartSpinEdit2: TAdvChartSpinEdit;
    CheckBox29: TCheckBox;
    Label133: TLabel;
    Label134: TLabel;
    AdvChartSpinEdit3: TAdvChartSpinEdit;
    AdvChartSpinEdit4: TAdvChartSpinEdit;
    AdvGDIPChartView1: TAdvGDIPChartView;
    AdvChartColorSelector5: TAdvChartColorSelector;
    AdvChartColorSelector6: TAdvChartColorSelector;
    Label20: TLabel;
    Label21: TLabel;
    Label31: TLabel;
    Label35: TLabel;
    AdvChartSpinEdit1: TAdvChartSpinEdit;
    AdvChartSpinEdit5: TAdvChartSpinEdit;
    ComboBox11: TComboBox;
    Label47: TLabel;
    GroupBox27: TGroupBox;
    Label75: TLabel;
    Label79: TLabel;
    AdvChartColorSelector7: TAdvChartColorSelector;
    AdvChartSpinEdit6: TAdvChartSpinEdit;
    Button1: TButton;
    Label83: TLabel;
    Label84: TLabel;
    AdvChartSpinEdit7: TAdvChartSpinEdit;
    ColorDialog1: TColorDialog;
    TabSheet8: TTabSheet;
    GroupBox30: TGroupBox;
    Label96: TLabel;
    AdvChartSpinEdit8: TAdvChartSpinEdit;
    GroupBox28: TGroupBox;
    Label110: TLabel;
    Button2: TButton;
    CheckBox8: TCheckBox;
    AdvChartSpinEdit14: TAdvChartSpinEdit;
    Label112: TLabel;
    AdvChartSpinEdit16: TAdvChartSpinEdit;
    Label116: TLabel;
    ComboBox20: TComboBox;
    Label125: TLabel;
    Label126: TLabel;
    Label127: TLabel;
    AdvChartSpinEdit20: TAdvChartSpinEdit;
    AdvChartSpinEdit21: TAdvChartSpinEdit;
    GroupBox34: TGroupBox;
    Label128: TLabel;
    Label129: TLabel;
    Label130: TLabel;
    Label132: TLabel;
    AdvChartColorSelector13: TAdvChartColorSelector;
    AdvChartColorSelector14: TAdvChartColorSelector;
    CheckBox11: TCheckBox;
    AdvChartSpinEdit22: TAdvChartSpinEdit;
    Label135: TLabel;
    Label136: TLabel;
    Label137: TLabel;
    Label138: TLabel;
    Label139: TLabel;
    Label140: TLabel;
    Label141: TLabel;
    Label142: TLabel;
    Label143: TLabel;
    Label144: TLabel;
    Label145: TLabel;
    Label146: TLabel;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    AdvChartSpinEdit23: TAdvChartSpinEdit;
    Label148: TLabel;
    DTB: TTabSheet;
    GroupBox35: TGroupBox;
    Label149: TLabel;
    Label150: TLabel;
    ComboBox21: TComboBox;
    ComboBox22: TComboBox;
    Image1: TImage;
    PageControl2: TPageControl;
    TabSheet9: TTabSheet;
    GroupBox11: TGroupBox;
    ChartTypeSelector1: TAdvChartTypeSelector;
    ChartTypeSelector3: TAdvChartTypeSelector;
    ChartTypeSelector4: TAdvChartTypeSelector;
    ChartTypeSelector2: TAdvChartTypeSelector;
    TabSheet10: TTabSheet;
    GroupBox12: TGroupBox;
    ChartTypeSelector5: TAdvChartTypeSelector;
    ChartTypeSelector6: TAdvChartTypeSelector;
    ChartTypeSelector7: TAdvChartTypeSelector;
    AdvChartTypeSelector9: TAdvChartTypeSelector;
    GroupBox14: TGroupBox;
    ChartTypeSelector11: TAdvChartTypeSelector;
    AdvChartTypeSelector8: TAdvChartTypeSelector;
    TabSheet11: TTabSheet;
    GroupBox31: TGroupBox;
    AdvChartTypeSelector1: TAdvChartTypeSelector;
    AdvChartTypeSelector2: TAdvChartTypeSelector;
    AdvChartTypeSelector4: TAdvChartTypeSelector;
    AdvChartTypeSelector5: TAdvChartTypeSelector;
    GroupBox36: TGroupBox;
    AdvChartTypeSelector10: TAdvChartTypeSelector;
    AdvChartTypeSelector11: TAdvChartTypeSelector;
    AdvChartTypeSelector12: TAdvChartTypeSelector;
    AdvChartTypeSelector13: TAdvChartTypeSelector;
    GroupBox37: TGroupBox;
    AdvChartTypeSelector14: TAdvChartTypeSelector;
    AdvChartTypeSelector15: TAdvChartTypeSelector;
    AdvChartTypeSelector16: TAdvChartTypeSelector;
    AdvChartTypeSelector17: TAdvChartTypeSelector;
    GroupBox38: TGroupBox;
    AdvChartTypeSelector18: TAdvChartTypeSelector;
    AdvChartTypeSelector19: TAdvChartTypeSelector;
    TabSheet12: TTabSheet;
    GroupBox13: TGroupBox;
    ChartTypeSelector8: TAdvChartTypeSelector;
    ChartTypeSelector9: TAdvChartTypeSelector;
    ChartTypeSelector10: TAdvChartTypeSelector;
    GroupBox33: TGroupBox;
    AdvChartTypeSelector3: TAdvChartTypeSelector;
    TabSheet13: TTabSheet;
    GroupBox16: TGroupBox;
    ChartTypeSelector14: TAdvChartTypeSelector;
    ChartTypeSelector13: TAdvChartTypeSelector;
    ChartTypeSelector19: TAdvChartTypeSelector;
    AdvChartTypeSelector7: TAdvChartTypeSelector;
    TabSheet14: TTabSheet;
    GroupBox18: TGroupBox;
    ChartTypeSelector20: TAdvChartTypeSelector;
    GroupBox15: TGroupBox;
    ChartTypeSelector12: TAdvChartTypeSelector;
    GroupBox17: TGroupBox;
    ChartTypeSelector17: TAdvChartTypeSelector;
    ChartTypeSelector18: TAdvChartTypeSelector;
    ChartTypeSelector16: TAdvChartTypeSelector;
    ChartTypeSelector15: TAdvChartTypeSelector;
    GroupBox39: TGroupBox;
    CheckBox14: TCheckBox;
    CheckBox15: TCheckBox;
    TabSheet15: TTabSheet;
    GroupBox40: TGroupBox;
    Label15: TLabel;
    ComboBox23: TComboBox;
    CheckBox16: TCheckBox;
    Label151: TLabel;
    ComboBox24: TComboBox;
    Label152: TLabel;
    CheckBox17: TCheckBox;
    Label153: TLabel;
    Label154: TLabel;
    CheckBox18: TCheckBox;
    AdvChartSpinEdit24: TAdvChartSpinEdit;
    CheckBox19: TCheckBox;
    Label155: TLabel;
    Button18: TButton;
    CheckBox20: TCheckBox;
    Label156: TLabel;
    ComboBox26: TComboBox;
    Label157: TLabel;
    GroupBox41: TGroupBox;
    Label158: TLabel;
    Label159: TLabel;
    Label160: TLabel;
    Label161: TLabel;
    ComboBox27: TComboBox;
    Button19: TButton;
    ComboBox28: TComboBox;
    AdvChartTypeSelector20: TAdvChartTypeSelector;
    GroupBox42: TGroupBox;
    Label19: TLabel;
    Label18: TLabel;
    AdvColorSelector4: TAdvChartColorSelector;
    AdvColorSelector5: TAdvChartColorSelector;
    CheckBox21: TCheckBox;
    AdvChartTypeSelector6: TAdvChartTypeSelector;
    AdvChartTypeSelector21: TAdvChartTypeSelector;
    CheckBox22: TCheckBox;
    AdvChartTypeSelector22: TAdvChartTypeSelector;
    AdvChartTypeSelector23: TAdvChartTypeSelector;
    TabSheet16: TTabSheet;
    SpeedButton6: TSpeedButton;
    SpeedButton5: TSpeedButton;
    ListBox2: TListBox;
    GroupBox43: TGroupBox;
    CheckBox23: TCheckBox;
    GroupBox44: TGroupBox;
    lblLineType: TLabel;
    lblLineColor: TLabel;
    lblStartIndex: TLabel;
    lblEndIndex: TLabel;
    lblCaption: TLabel;
    lblFontPreview: TLabel;
    Label73: TLabel;
    chkVisible: TCheckBox;
    spinStart: TAdvChartSpinEdit;
    spinEnd: TAdvChartSpinEdit;
    csLineColor: TAdvChartColorSelector;
    cboLinetype: TComboBox;
    txtCaption: TEdit;
    Button20: TButton;
    CheckBox24: TCheckBox;
    AdvChartSpinEdit25: TAdvChartSpinEdit;
    Label69: TLabel;
    Label162: TLabel;
    ComboBox29: TComboBox;
    ComboBox30: TComboBox;
    Label163: TLabel;
    GroupBox45: TGroupBox;
    AdvChartTypeSelector24: TAdvChartTypeSelector;
    GroupBox46: TGroupBox;
    Label164: TLabel;
    Label165: TLabel;
    AdvChartSpinEdit26: TAdvChartSpinEdit;
    AdvChartSpinEdit27: TAdvChartSpinEdit;
    TabSheet17: TTabSheet;
    TabSheet18: TTabSheet;
    GroupBox29: TGroupBox;
    Label102: TLabel;
    Label103: TLabel;
    Label104: TLabel;
    Label105: TLabel;
    Label106: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    Label113: TLabel;
    Label114: TLabel;
    Label111: TLabel;
    Label109: TLabel;
    Label115: TLabel;
    Label124: TLabel;
    Label147: TLabel;
    AdvChartColorSelector8: TAdvChartColorSelector;
    AdvChartSpinEdit9: TAdvChartSpinEdit;
    AdvChartColorSelector9: TAdvChartColorSelector;
    AdvChartColorSelector10: TAdvChartColorSelector;
    AdvChartSpinEdit10: TAdvChartSpinEdit;
    Button17: TButton;
    CheckBox9: TCheckBox;
    AdvChartSpinEdit12: TAdvChartSpinEdit;
    AdvChartSpinEdit13: TAdvChartSpinEdit;
    ComboBox14: TComboBox;
    ComboBox12: TComboBox;
    AdvChartSpinEdit11: TAdvChartSpinEdit;
    AdvChartSpinEdit15: TAdvChartSpinEdit;
    GroupBox32: TGroupBox;
    Label117: TLabel;
    Label118: TLabel;
    Label119: TLabel;
    Label121: TLabel;
    Label120: TLabel;
    Label122: TLabel;
    Label123: TLabel;
    CheckBox10: TCheckBox;
    AdvChartColorSelector11: TAdvChartColorSelector;
    AdvChartColorSelector12: TAdvChartColorSelector;
    ComboBox18: TComboBox;
    ComboBox19: TComboBox;
    AdvChartSpinEdit17: TAdvChartSpinEdit;
    AdvChartSpinEdit18: TAdvChartSpinEdit;
    AdvChartSpinEdit19: TAdvChartSpinEdit;
    ComboBox16: TComboBox;
    Label166: TLabel;
    GroupBox47: TGroupBox;
    Label167: TLabel;
    Label168: TLabel;
    Label169: TLabel;
    Label170: TLabel;
    Label171: TLabel;
    Label172: TLabel;
    Label173: TLabel;
    Label174: TLabel;
    Label175: TLabel;
    AdvChartSpinEdit28: TAdvChartSpinEdit;
    AdvChartSpinEdit29: TAdvChartSpinEdit;
    ComboBox31: TComboBox;
    AdvChartSpinEdit30: TAdvChartSpinEdit;
    AdvChartSpinEdit31: TAdvChartSpinEdit;
    ComboBox32: TComboBox;
    ComboBox33: TComboBox;
    ComboBox34: TComboBox;
    AdvChartSpinEdit32: TAdvChartSpinEdit;
    GroupBox48: TGroupBox;
    Label176: TLabel;
    Label177: TLabel;
    Label178: TLabel;
    Button21: TButton;
    CheckBox25: TCheckBox;
    ComboBox35: TComboBox;
    CheckBox26: TCheckBox;
    GroupBox49: TGroupBox;
    AdvChartTypeSelector25: TAdvChartTypeSelector;
    AdvChartTypeSelector26: TAdvChartTypeSelector;
    procedure ComboBox1Change(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure AdvColorSelector1Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvBrushStyleSelector1Click(Sender: TObject);
    procedure ChartTypeSelector1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AdvColorSelector4Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvColorSelector5Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure ComboBox3Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure AdvColorSelector6Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure SpinEdit3Change(Sender: TObject);
    procedure AdvColorSelector7Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure SpinEdit4Change(Sender: TObject);
    procedure AdvPenStyleSelector1Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure ComboBox4Change(Sender: TObject);
    procedure SpinEdit5Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure SpinEdit10Change(Sender: TObject);
    procedure ComboBox5Change(Sender: TObject);
    procedure ComboBox6Change(Sender: TObject);
    procedure ComboBox7Change(Sender: TObject);
    procedure SpinEdit11Change(Sender: TObject);
    procedure AdvColorSelector12Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure SpinEdit12Change(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure SpinEdit13Change(Sender: TObject);
    procedure SpinEdit14Change(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure SpinEdit15Change(Sender: TObject);
    procedure SpinEdit16Change(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure ComboBox8Change(Sender: TObject);
    procedure SpinEdit31Change(Sender: TObject);
    procedure ComboBox9Change(Sender: TObject);
    procedure SpinEdit19Change(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure SpinEdit32Change(Sender: TObject);
    procedure ComboBox10Change(Sender: TObject);
    procedure SpinEdit20Change(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure AdvColorSelector13Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure SpinEdit17Change(Sender: TObject);
    procedure SpinEdit18Change(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure SpinEdit23Change(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure SpinEdit21Change(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure ComboBox13Change(Sender: TObject);
    procedure SpinEdit29Change(Sender: TObject);
    procedure AdvColorSelector15Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure CheckBox6Click(Sender: TObject);
    procedure SpinEdit33Change(Sender: TObject);
    procedure Edit12Change(Sender: TObject);
    procedure ComboBox15Change(Sender: TObject);
    procedure SpinEdit25Change(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure SpinEdit34Change(Sender: TObject);
    procedure Edit13Change(Sender: TObject);
    procedure ComboBox17Change(Sender: TObject);
    procedure SpinEdit26Change(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure AdvColorSelector14Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure SpinEdit28Change(Sender: TObject);
    procedure SpinEdit27Change(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure AdvColorSelector8Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvColorSelector10Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvColorSelector9Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AdvSpinEdit1Change(Sender: TObject);
    procedure AdvSpinEdit2Change(Sender: TObject);
    procedure AdvSpinEdit5Change(Sender: TObject);
    procedure AdvSpinEdit4Change(Sender: TObject);
    procedure AdvSpinEdit3Change(Sender: TObject);
    procedure SpinEdit6Change(Sender: TObject);
    procedure SpinEdit7Change(Sender: TObject);
    procedure ListBox1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ListBox1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AdvChartColorSelector1Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvChartColorSelector2Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure SpinEdit8Change(Sender: TObject);
    procedure SpinEdit9Change(Sender: TObject);
    procedure AdvChartView2SerieMouseDown(Sender: TObject; PaneIndex,
      SerieIndex, Index: Integer; value: Double; X, Y: Integer);
    procedure SpeedButton4Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
    procedure AdvChartColorSelector3Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvChartColorSelector4Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure ComboBox25Change(Sender: TObject);
    procedure AdvChartSpinEdit2Change(Sender: TObject);
    procedure CheckBox29Click(Sender: TObject);
    procedure AdvChartSpinEdit4Change(Sender: TObject);
    procedure AdvChartSpinEdit3Change(Sender: TObject);
    procedure AdvChartColorSelector5Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvChartColorSelector6Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure ComboBox11Change(Sender: TObject);
    procedure AdvChartSpinEdit5Change(Sender: TObject);
    procedure AdvChartSpinEdit1Change(Sender: TObject);
    procedure AdvChartColorSelector7Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvChartSpinEdit6Change(Sender: TObject);
    procedure AdvChartSpinEdit7Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure AdvChartSpinEdit8Change(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure AdvChartColorSelector8Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvChartSpinEdit9Change(Sender: TObject);
    procedure AdvChartColorSelector10Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvChartColorSelector9Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure ComboBox12Change(Sender: TObject);
    procedure ComboBox14Change(Sender: TObject);
    procedure AdvChartSpinEdit10Change(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure CheckBox9Click(Sender: TObject);
    procedure AdvChartSpinEdit11Change(Sender: TObject);
    procedure AdvChartSpinEdit13Change(Sender: TObject);
    procedure AdvChartSpinEdit12Change(Sender: TObject);
    procedure AdvChartSpinEdit14Change(Sender: TObject);
    procedure AdvChartSpinEdit15Change(Sender: TObject);
    procedure AdvChartSpinEdit16Change(Sender: TObject);
    procedure CheckBox10Click(Sender: TObject);
    procedure AdvChartColorSelector12Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvChartColorSelector11Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure ComboBox18Change(Sender: TObject);
    procedure ComboBox19Change(Sender: TObject);
    procedure AdvChartSpinEdit18Change(Sender: TObject);
    procedure AdvChartSpinEdit17Change(Sender: TObject);
    procedure AdvChartSpinEdit19Change(Sender: TObject);
    procedure ComboBox16Change(Sender: TObject);
    procedure ComboBox20Change(Sender: TObject);
    procedure AdvChartSpinEdit20Change(Sender: TObject);
    procedure AdvChartSpinEdit21Change(Sender: TObject);
    procedure AdvChartColorSelector14Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvChartColorSelector13Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvChartSpinEdit22Change(Sender: TObject);
    procedure CheckBox11Click(Sender: TObject);
    procedure CheckBox13Click(Sender: TObject);
    procedure CheckBox12Click(Sender: TObject);
    procedure AdvChartSpinEdit23Change(Sender: TObject);
    procedure ComboBox21Change(Sender: TObject);
    procedure ComboBox22Change(Sender: TObject);
    procedure CheckBox14Click(Sender: TObject);
    procedure CheckBox15Click(Sender: TObject);
    procedure ComboBox23Change(Sender: TObject);
    procedure CheckBox16Click(Sender: TObject);
    procedure ComboBox24Change(Sender: TObject);
    procedure CheckBox17Click(Sender: TObject);
    procedure AdvChartSpinEdit24Change(Sender: TObject);
    procedure CheckBox18Click(Sender: TObject);
    procedure CheckBox19Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure CheckBox20Click(Sender: TObject);
    procedure ComboBox26Change(Sender: TObject);
    procedure ComboBox27Change(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure ComboBox28Change(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CheckBox21Click(Sender: TObject);
    procedure ListBox1ClickCheck(Sender: TObject);
    procedure CheckBox22Click(Sender: TObject);
    procedure CheckBox23Click(Sender: TObject);
    procedure cboLinetypeChange(Sender: TObject);
    procedure csLineColorSelect(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure spinStartChange(Sender: TObject);
    procedure spinEndChange(Sender: TObject);
    procedure chkVisibleClick(Sender: TObject);
    procedure txtCaptionChange(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure CheckBox24Click(Sender: TObject);
    procedure AdvChartSpinEdit25Change(Sender: TObject);
    procedure ComboBox29Change(Sender: TObject);
    procedure ComboBox30Change(Sender: TObject);
    procedure AdvChartSpinEdit27Change(Sender: TObject);
    procedure AdvChartSpinEdit26Change(Sender: TObject);
    procedure AdvChartSpinEdit28Change(Sender: TObject);
    procedure AdvChartSpinEdit29Change(Sender: TObject);
    procedure ComboBox32Change(Sender: TObject);
    procedure ComboBox33Change(Sender: TObject);
    procedure ComboBox31Change(Sender: TObject);
    procedure ComboBox34Change(Sender: TObject);
    procedure AdvChartSpinEdit32Change(Sender: TObject);
    procedure AdvChartSpinEdit30Change(Sender: TObject);
    procedure AdvChartSpinEdit31Change(Sender: TObject);
    procedure CheckBox25Click(Sender: TObject);
    procedure CheckBox26Click(Sender: TObject);
    procedure ComboBox35Change(Sender: TObject);
  private
    { Private declarations }
    FAllowR: Boolean;
    FChartView: TAdvChartView;
    FChartSeries: TAdvGDIPChartSeries;
    Mode: TSaveMode;
    col: TAdvGDIPChartSeries;
    FApply: TNotifyEvent;
    procedure StartAnnotationsEditor;
    procedure CorrectTop(lbl: TLabel);
  protected
    function GetXGroup: TChartSerieXAxisGroup;
  public
    { Public declarations }
    property ChartView: TAdvChartView read FChartView write FChartView;
    property ChartSeries: TAdvGDIPChartSeries read FChartSeries write FChartSeries;
    property AllowEditing: Boolean read FAllowR write FAllowR;
    procedure InitGroups;
    procedure Init;
    procedure InitListBox;
    procedure ClearSelectedChartTypes;
    procedure InitializeCrossHairChart;
    procedure UpdatePreview2;
    procedure UpdatePreview;
    procedure SaveChanges;
    procedure ApplyChanges(Sender: TObject);
    property Apply: TNotifyEvent read FApply write FApply;
  end;

  {$IFDEF DELPHIXE2_LVL}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  {$ENDIF}
  TAdvChartSeriesEditorDialogGDIP = class(TCommonDialog)
  private
    FForm: TAdvChartSeriesEditorFormGDIP;
    FChartView: TAdvGDIPChartView;
    FChartPaneIndex: Integer;
    FCaption: string;
    FAllowAnnotationEditing: Boolean;
    FAllowSerieNameChange: Boolean;
    FAllowSerieReorder: Boolean;
    FAllowSerieAdding: Boolean;
    FAllowSerieRemoving: Boolean;
    procedure SetChartPaneIndex(const Value: integer);
    procedure SetChartView(const Value: TAdvGDIPChartView);
  protected
  public
    constructor Create(AOwner: TComponent); override;
    function Execute: Boolean; override;
    property Form: TAdvChartSeriesEditorFormGDIP read FForm;
  published
    property Caption: string read FCaption write FCaption;
    property ChartPaneIndex: integer read FChartPaneIndex write SetChartPaneIndex;
    property ChartView: TAdvGDIPChartView read FChartView write SetChartView;
    property AllowAnnotationEditing: Boolean read FAllowAnnotationEditing write FAllowAnnotationEditing default true;
    property AllowSerieNameChange: Boolean read FAllowSerieNameChange write FAllowSerieNameChange default true;
    property AllowSerieRemoving: Boolean read FAllowSerieRemoving write FAllowSerieRemoving default true;
    property AllowSerieAdding: Boolean read FAllowSerieAdding write FAllowSerieAdding default true;
    property AllowSerieReorder: Boolean read FAllowSerieReorder write FAllowSerieReorder default true;
  end;

var
  AdvChartSeriesEditorFormGDIP: TAdvChartSeriesEditorFormGDIP;
  cs: TAdvGDIPChartSerie;
  StartingPoint: TPoint;

implementation

{$R *.dfm}

uses
  Types
  {$IFDEF DELPHIXE2_LVL}
  ,UITypes
  {$ENDIF}
  ;

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

procedure TAdvChartSeriesEditorFormGDIP.AdvBrushStyleSelector1Click(
  Sender: TObject);
begin
  cs.BrushStyle := AdvBrushStyleSelector1.SelectedBrushStyle;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartColorSelector10Select(
  Sender: TObject; Index: Integer; Item: TAdvChartSelectorItem);
begin
if Index = 0 then
    advchartcolorselector10.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := advchartcolorselector10.SelectedColor;
    if ColorDialog1.Execute then
    begin
      advchartcolorselector10.SelectedColor := ColorDialog1.Color;
    end;
  end;

  cs.Pie.LegendColor := advchartcolorselector10.SelectedColor;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartColorSelector11Select(
  Sender: TObject; Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advchartcolorselector11.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := advchartcolorselector11.SelectedColor;
    if ColorDialog1.Execute then
    begin
      advchartcolorselector11.SelectedColor := ColorDialog1.Color;
    end;
  end;

  cs.Pie.LegendTitleColorTo := advchartcolorselector11.SelectedColor;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartColorSelector12Select(
  Sender: TObject; Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advchartcolorselector12.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := advchartcolorselector12.SelectedColor;
    if ColorDialog1.Execute then
    begin
      advchartcolorselector12.SelectedColor := ColorDialog1.Color;
    end;
  end;

  cs.Pie.LegendTitleColor := advchartcolorselector12.SelectedColor;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartColorSelector13Select(
  Sender: TObject; Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    AdvChartColorSelector13.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvChartColorSelector13.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvChartColorSelector13.SelectedColor := ColorDialog1.Color;
    end;
  end;

  cs.SelectedMarkBorderColor := AdvChartColorSelector13.SelectedColor;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartColorSelector14Select(
  Sender: TObject; Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    AdvChartColorSelector14.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvChartColorSelector14.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvChartColorSelector14.SelectedColor := ColorDialog1.Color;
    end;
  end;

  cs.SelectedMarkColor := AdvChartColorSelector14.SelectedColor;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartColorSelector1Select(
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

  cs.Marker.SelectedColor := AdvChartColorSelector1.SelectedColor;
  UpdatePreview2;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartColorSelector2Select(
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

  cs.Marker.SelectedLineColor := AdvChartColorSelector2.SelectedColor;
  UpdatePreview2;  
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartColorSelector3Select(
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

  cs.Color := AdvChartColorSelector3.SelectedColor;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartColorSelector4Select(
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

  cs.ColorTo := AdvChartColorSelector4.SelectedColor;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartColorSelector5Select(
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

  cs.Marker.MarkerColor := AdvChartColorSelector5.SelectedColor;

  UpdatePreview2;  
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartColorSelector6Select(
  Sender: TObject; Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    AdvChartColorSelector6.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvChartColorSelector6.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvChartColorSelector6.SelectedColor := ColorDialog1.Color;
    end;
  end;

  cs.Marker.MarkerColorTo := AdvChartColorSelector6.SelectedColor;
  UpdatePreview2;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartColorSelector7Select(
  Sender: TObject; Index: Integer; Item: TAdvChartSelectorItem);
begin
  if index = 0 then
    AdvChartcolorSelector7.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvChartColorSelector7.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvChartColorSelector7.SelectedColor := ColorDialog1.Color;
    end;
  end;
    
  cs.ArrowColor := AdvChartColorSelector7.SelectedColor;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartColorSelector8Select(
  Sender: TObject; Index: Integer; Item: TAdvChartSelectorItem);
begin
if Index = 0 then
    advchartcolorselector8.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := advchartcolorselector8.SelectedColor;
    if ColorDialog1.Execute then
    begin
      advchartcolorselector8.SelectedColor := ColorDialog1.Color;
    end;
  end;

  cs.Pie.LegendBorderColor := advchartcolorselector8.SelectedColor;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartColorSelector9Select(
  Sender: TObject; Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advchartcolorselector9.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := advchartcolorselector9.SelectedColor;
    if ColorDialog1.Execute then
    begin
      advchartcolorselector9.SelectedColor := ColorDialog1.Color;
    end;
  end;

  cs.Pie.LegendColorTo := advchartcolorselector9.SelectedColor;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartSpinEdit10Change(
  Sender: TObject);
begin
  cs.Pie.LegendGradientAngle := AdvChartSpinEdit10.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartSpinEdit11Change(
  Sender: TObject);
begin
  cs.Pie.LegendOffsetLeft := AdvChartSpinEdit11.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartSpinEdit12Change(
  Sender: TObject);
begin
  cs.Pie.LegendOpacityTo := AdvChartSpinEdit12.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartSpinEdit13Change(
  Sender: TObject);
begin
  cs.Pie.LegendOpacity := AdvchartSpinEdit13.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartSpinEdit14Change(
  Sender: TObject);
begin
  cs.Pie.StartOffsetAngle := AdvChartSpinEdit14.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartSpinEdit15Change(
  Sender: TObject);
begin
  cs.Pie.LegendOffsetTop := AdvchartspinEdit15.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartSpinEdit16Change(
  Sender: TObject);
begin
  cs.Pie.InnerSize := AdvChartSpinEdit16.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartSpinEdit17Change(
  Sender: TObject);
begin
  cs.Pie.LegendTitleOpacityTo := AdvChartSpinEdit17.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartSpinEdit18Change(
  Sender: TObject);
begin
  cs.Pie.LegendTitleOpacity := AdvChartSpinEdit18.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartSpinEdit19Change(
  Sender: TObject);
begin
  cs.Pie.LegendTitleGradientAngle := AdvChartSpinEdit19.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartSpinEdit1Change(
  Sender: TObject);
begin
  cs.Marker.OpacityTo := AdvChartSpinEdit1.Value;
  UpdatePreview2;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartSpinEdit20Change(
  Sender: TObject);
begin
  cs.Pie.Left := AdvChartSpinEdit20.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartSpinEdit21Change(
  Sender: TObject);
begin
  cs.Pie.Top := AdvChartSpinEdit21.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartSpinEdit22Change(
  Sender: TObject);
begin
  cs.SelectedMarkSize := AdvChartSpinEdit22.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartSpinEdit23Change(
  Sender: TObject);
begin
  cs.YAxis.TickMarkSizeMinor := AdvchartspinEdit23.value;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartSpinEdit24Change(
  Sender: TObject);
begin
  cs.Offset3D := AdvChartSpinEdit24.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartSpinEdit25Change(
  Sender: TObject);
var
  xGroup: TChartSerieXAxisGroup;
begin
  xGroup := GetXGroup;
  if Assigned(xGroup) then
    xGroup.Level := AdvChartSpinEdit25.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartSpinEdit26Change(
  Sender: TObject);
begin
  cs.ValueOffsetY := AdvChartSpinEdit26.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartSpinEdit27Change(
  Sender: TObject);
begin
  cs.ValueOffsetX := AdvChartSpinEdit27.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartSpinEdit28Change(
  Sender: TObject);
begin
  cs.FunnelWidth := AdvChartSpinEdit28.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartSpinEdit29Change(
  Sender: TObject);
begin
  cs.FunnelHeight := AdvChartSpinEdit29.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartSpinEdit2Change(
  Sender: TObject);
begin
  cs.Angle := AdvchartspinEdit2.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartSpinEdit30Change(
  Sender: TObject);
begin
  AdvChartSpinEdit20.Value := AdvChartSpinEdit30.Value;
  AdvChartSpinEdit20Change(Self);
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartSpinEdit31Change(
  Sender: TObject);
begin
  AdvChartSpinEdit21.Value := AdvChartSpinEdit31.Value;
  AdvChartSpinEdit21Change(Self);
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartSpinEdit32Change(
  Sender: TObject);
begin
  cs.FunnelSpacing := AdvChartSpinEdit32.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartSpinEdit3Change(
  Sender: TObject);
begin
  cs.OpacityTo := AdvChartspinEdit3.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartSpinEdit4Change(
  Sender: TObject);
begin
  cs.Opacity := AdvChartspinEdit4.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartSpinEdit5Change(
  Sender: TObject);
begin
  cs.Marker.Opacity := AdvChartSpinEdit5.Value;
  UpdatePreview2;  
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartSpinEdit6Change(
  Sender: TObject);
begin
  cs.ArrowSize := AdvchartSpinEdit6.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartSpinEdit7Change(
  Sender: TObject);
begin
  cs.ValueAngle := AdvChartSpinEdit7.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartSpinEdit8Change(
  Sender: TObject);
begin
  cs.Pie.Size := AdvChartSpinEdit8.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartSpinEdit9Change(
  Sender: TObject);
begin
  cs.Pie.LegendBorderWidth := AdvChartSpinEdit9.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvChartView2SerieMouseDown(Sender: TObject;
  PaneIndex, SerieIndex, Index: Integer; value: Double; X, Y: Integer);
begin
  AdvGDIPChartView1.Invalidate;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvColorSelector10Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advcolorselector10.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvColorSelector10.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvColorSelector10.SelectedColor := ColorDialog1.Color;
    end;
  end;

  cs.CrossHairYValue.ColorTo := AdvColorSelector10.SelectedColor;
  UpdatePreview;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvColorSelector12Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advcolorselector12.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvColorSelector12.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvColorSelector12.SelectedColor := ColorDialog1.Color;
    end;
  end;

  cs.Marker.MarkerLineColor := AdvcolorSelector12.SelectedColor;
  UpdatePreview2;  
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvColorSelector13Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advcolorselector13.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvColorSelector13.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvColorSelector13.SelectedColor := ColorDialog1.Color;
    end;
  end;

  cs.XAxis.TickMarkColor := AdvcolorSelector13.SelectedColor;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvColorSelector14Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advcolorselector14.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvColorSelector14.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvColorSelector14.SelectedColor := ColorDialog1.Color;
    end;
  end;

  cs.YAxis.TickMarkColor := AdvColorSelector14.SelectedColor;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvColorSelector15Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advcolorselector15.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvColorSelector15.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvColorSelector15.SelectedColor := ColorDialog1.Color;
    end;
  end;

  cs.ZerolineColor := AdvColorSelector15.SelectedColor;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvColorSelector1Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advcolorselector1.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvColorSelector1.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvColorSelector1.SelectedColor := ColorDialog1.Color;
    end;
  end;

  cs.BorderColor := AdvColorSelector1.SelectedColor;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvColorSelector4Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advcolorselector4.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvColorSelector4.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvColorSelector4.SelectedColor := ColorDialog1.Color;
    end;
  end;

  cs.CandleColorIncrease := AdvColorSelector4.SelectedColor;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvColorSelector5Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advcolorselector5.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvColorSelector5.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvColorSelector5.SelectedColor := ColorDialog1.Color;
    end;
  end;

  cs.CandleColorDecrease := AdvColorSelector5.SelectedColor;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvColorSelector6Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advcolorselector6.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvColorSelector6.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvColorSelector6.SelectedColor := ColorDialog1.Color;
    end;
  end;
    
  cs.LineColor := AdvColorSelector6.SelectedColor;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvColorSelector7Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advcolorselector7.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvColorSelector7.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvColorSelector7.SelectedColor := ColorDialog1.Color;
    end;
  end;

  cs.WickColor := AdvColorSelector7.SelectedColor;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvColorSelector8Select(Sender: TObject;
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

  cs.CrossHairYValue.BorderColor := AdvColorSelector8.SelectedColor;
  UpdatePreview;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvColorSelector9Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advcolorselector9.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvColorSelector9.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvColorSelector9.SelectedColor := ColorDialog1.Color;
    end;
  end;

  cs.CrossHairYValue.Color := AdvcolorSelector9.SelectedColor;
  UpdatePreview;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvPenStyleSelector1Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  cs.PenStyle := AdvPenStyleSelector1.SelectedPenStyle;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvSpinEdit1Change(Sender: TObject);
begin
  cs.Maximum := AdvSpinEdit1.FloatValue;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvSpinEdit2Change(Sender: TObject);
begin
  cs.Minimum := AdvSpinEdit2.FloatValue;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvSpinEdit3Change(Sender: TObject);
begin
  cs.ZeroReferencePoint := AdvSpinEdit3.FloatValue;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvSpinEdit4Change(Sender: TObject);
begin
  cs.YAxis.MinorUnit := AdvSpinEdit4.FloatValue;
end;

procedure TAdvChartSeriesEditorFormGDIP.AdvSpinEdit5Change(Sender: TObject);
begin
  cs.YAxis.MajorUnit := AdvSpinEdit5.FloatValue;
end;

procedure TAdvChartSeriesEditorFormGDIP.ApplyChanges(Sender: TObject);
begin
  SaveChanges;
  if Assigned(Apply) then
    Apply(Self);
end;

procedure TAdvChartSeriesEditorFormGDIP.Button10Click(Sender: TObject);
begin
  FontDialog1.Font.Assign(cs.YAxis.MinorFont);
  if FontDialog1.Execute then
  begin
    cs.YAxis.MinorFont.Assign(FontDialog1.Font);
    label143.font.Assign(cs.YAxis.Minorfont);
    CorrectTop(label143);
  end;
end;

procedure TAdvChartSeriesEditorFormGDIP.Button11Click(Sender: TObject);
begin
  FontDialog1.Font.Assign(cs.YAxis.TextLeft.Font);
  if FontDialog1.Execute then
  begin
    cs.YAxis.TextLeft.Font.Assign(FontDialog1.Font);
    label144.font.assign(cs.Yaxis.textleft.font);
    CorrectTop(label144);
  end;
end;

procedure TAdvChartSeriesEditorFormGDIP.Button12Click(Sender: TObject);
begin
  FontDialog1.Font.Assign(cs.YAxis.TextRight.Font);
  if FontDialog1.Execute then
  begin
    cs.YAxis.TextRight.Font.Assign(FontDialog1.Font);
    label145.font.assign(cs.Yaxis.Textright.font);
    CorrectTop(label145);
  end;
end;

procedure TAdvChartSeriesEditorFormGDIP.Button13Click(Sender: TObject);
begin
  if not (Image1.Picture.Graphic = nil) then
  begin
    Image1.Picture.Assign(nil);
    cs.ChartPattern.Assign(nil);
  end;
end;

procedure TAdvChartSeriesEditorFormGDIP.Button14Click(Sender: TObject);
begin
  if not (Image2.Picture.Graphic = nil) then
  begin
    Image2.Picture := nil;
    cs.Marker.MarkerPicture := nil;
  end;
  UpdatePreview2;
end;

procedure TAdvChartSeriesEditorFormGDIP.Button15Click(Sender: TObject);
begin
  Mode := saving;
  SaveChanges;
  Self.Close;
  ModalResult := mrOk;
end;

procedure TAdvChartSeriesEditorFormGDIP.Button16Click(Sender: TObject);
begin
  Mode := cancel;
  Self.Close;
  ModalResult := mrCancel;
end;

procedure TAdvChartSeriesEditorFormGDIP.Button17Click(Sender: TObject);
begin
  FontDialog1.Font.Assign(cs.Pie.LegendFont);
  if FontDialog1.Execute then
  begin
    cs.Pie.LegendFont.Assign(FontDialog1.Font);
    label147.font.assign(cs.pie.Legendfont);
    CorrectTop(Label147);
  end;
end;

procedure TAdvChartSeriesEditorFormGDIP.Button18Click(Sender: TObject);
begin
  SaveChanges;
  if Assigned(Apply) then
    Apply(Self);
end;

procedure TAdvChartSeriesEditorFormGDIP.Button19Click(Sender: TObject);
begin
  FontDialog1.Font.Assign(cs.BarValueTextFont);
  if FontDialog1.Execute then
  begin
    cs.BarValueTextFont.Assign(FontDialog1.Font);
    label160.font.Assign(cs.BarValueTextFont);
    CorrectTop(label160);
  end;
end;

procedure TAdvChartSeriesEditorFormGDIP.Button1Click(Sender: TObject);
begin
  FontDialog1.Font.Assign(cs.ValueFont);
  if FontDialog1.Execute then
  begin
    cs.ValueFont.Assign(FontDialog1.Font);
    label136.font.Assign(cs.Valuefont);
    CorrectTop(label136);
  end;
end;

procedure TAdvChartSeriesEditorFormGDIP.Button20Click(Sender: TObject);
var
  xGroup: TChartSerieXAxisGroup;
begin
  xGroup := GetXGroup;
  if Assigned(xGroup) then
  begin
    FontDialog1.Font.Assign(xGroup.Font);
    if FontDialog1.Execute then
    begin
      xGroup.Font.Assign(FontDialog1.Font);
      lblFontPreview.font.assign(xGroup.Font);
      CorrectTop(lblFontPreview);
    end;
  end;
end;

procedure TAdvChartSeriesEditorFormGDIP.Button2Click(Sender: TObject);
begin
  FontDialog1.Font.Assign(cs.Pie.ValueFont);
  if FontDialog1.Execute then
  begin
    cs.Pie.ValueFont.Assign(FontDialog1.Font);
    Label146.font.assign(cs.pie.valuefont);
    Label177.Font.Assign(cs.Pie.ValueFont);
    CorrectTop(Label146);
    CorrectTop(Label177);
  end;
end;

procedure TAdvChartSeriesEditorFormGDIP.Button3Click(Sender: TObject);
begin
  FontDialog1.Font.Assign(cs.XAxis.DateTimeFont);
  if FontDialog1.Execute then
  begin
    cs.XAxis.DateTimeFont.Assign(FontDialog1.Font);
    Label137.font.assign(cs.Xaxis.datetimefont);
    CorrectTop(label137);
  end;
end;

procedure TAdvChartSeriesEditorFormGDIP.Button4Click(Sender: TObject);
begin
  FontDialog1.Font.Assign(cs.XAxis.MajorFont);
  if FontDialog1.Execute then
  begin
    cs.XAxis.MajorFont.Assign(FontDialog1.Font);
    label138.font.assign(cs.Xaxis.majorfont);
    CorrectTop(label138);
  end;
end;

procedure TAdvChartSeriesEditorFormGDIP.Button5Click(Sender: TObject);
begin
  FontDialog1.Font.Assign(cs.XAxis.MinorFont);
  if FontDialog1.Execute then
  begin
    cs.XAxis.MinorFont.Assign(FontDialog1.Font);
    label139.font.assign(cs.Xaxis.minorfont);
    CorrectTop(label139);
  end;
end;

procedure TAdvChartSeriesEditorFormGDIP.Button6Click(Sender: TObject);
begin
  FontDialog1.Font.Assign(cs.XAxis.TextTop.Font);
  if FontDialog1.Execute then
  begin
    cs.XAxis.TextTop.Font.Assign(FontDialog1.Font);
    Label140.font.assign(cs.Xaxis.Texttop.font);
    CorrectTop(label140);
  end;
end;

procedure TAdvChartSeriesEditorFormGDIP.Button7Click(Sender: TObject);
begin
  FontDialog1.Font.Assign(cs.XAxis.Textbottom.Font);
  if FontDialog1.Execute then
  begin
    cs.XAxis.Textbottom.Font.Assign(FontDialog1.Font);
    Label141.font.assign(cs.Xaxis.TextBottom.font);
    CorrectTop(label141);
  end;
end;

procedure TAdvChartSeriesEditorFormGDIP.Button8Click(Sender: TObject);
begin
  FontDialog1.Font.Assign(cs.CrossHairYValue.Font);
  if FontDialog1.Execute then
  begin
    cs.CrossHairYValue.Font.Assign(FontDialog1.Font);
    Label135.font.assign(cs.CrossHairYValue.font);
    CorrectTop(label135);
  end;
  UpdatePreview;
end;

procedure TAdvChartSeriesEditorFormGDIP.Button9Click(Sender: TObject);
begin
  FontDialog1.Font.Assign(cs.YAxis.MajorFont);
  if FontDialog1.Execute then
  begin
    cs.YAxis.MajorFont.Assign(FontDialog1.Font);
    label142.font.assign(cs.YAxis.majorFont);
    CorrectTop(label142);
  end;
end;

procedure TAdvChartSeriesEditorFormGDIP.cboLinetypeChange(Sender: TObject);
var
  xgroup: TChartSerieXAxisGroup;
begin
  xgroup := GetXGroup;
  if Assigned(xgroup) then
    xgroup.LineType := TChartSerieXAxisGroupLineType(cboLinetype.ItemIndex);
end;

procedure TAdvChartSeriesEditorFormGDIP.ChartTypeSelector1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ClearSelectedChartTypes;
  (Sender as TAdvChartTypeSelector).Selected := true;
  cs.ChartType := (Sender as TAdvChartTypeSelector).ChartType;
end;

procedure TAdvChartSeriesEditorFormGDIP.CheckBox10Click(Sender: TObject);
begin
  cs.Pie.LegendTitleVisible := CheckBox10.Checked;
end;

procedure TAdvChartSeriesEditorFormGDIP.CheckBox11Click(Sender: TObject);
begin
  cs.SelectedMark := CheckBox11.Checked;
end;

procedure TAdvChartSeriesEditorFormGDIP.CheckBox12Click(Sender: TObject);
begin
  cs.YAxis.MinorUnitVisible := CheckBox12.Checked;
end;

procedure TAdvChartSeriesEditorFormGDIP.CheckBox13Click(Sender: TObject);
begin
  cs.YAxis.MajorUnitVisible := CheckBox13.Checked;
end;

procedure TAdvChartSeriesEditorFormGDIP.CheckBox14Click(Sender: TObject);
begin
  cs.Pie.ShowGrid := CheckBox14.Checked;
end;

procedure TAdvChartSeriesEditorFormGDIP.CheckBox15Click(Sender: TObject);
begin
  cs.Pie.ShowGridPieLines := CheckBox15.Checked;
end;

procedure TAdvChartSeriesEditorFormGDIP.CheckBox16Click(Sender: TObject);
begin
  cs.ShowInLegend := CheckBox16.Checked;
end;

procedure TAdvChartSeriesEditorFormGDIP.CheckBox17Click(Sender: TObject);
begin
  cs.Pie.ShowLegendOnSlice := CheckBox17.Checked;
  Checkbox26.Checked := CheckBox17.Checked;
end;

procedure TAdvChartSeriesEditorFormGDIP.CheckBox18Click(Sender: TObject);
begin
  cs.Enable3D := CheckBox18.Checked;
end;

procedure TAdvChartSeriesEditorFormGDIP.CheckBox19Click(Sender: TObject);
begin
  cs.Darken3D := CheckBox19.Checked;
end;

procedure TAdvChartSeriesEditorFormGDIP.CheckBox1Click(Sender: TObject);
begin
  cs.CrossHairYValue.Visible := CheckBox1.Checked;
  UpdatePreview;
end;

procedure TAdvChartSeriesEditorFormGDIP.CheckBox20Click(Sender: TObject);
begin
  cs.Logarithmic := CheckBox20.Checked;
end;

procedure TAdvChartSeriesEditorFormGDIP.CheckBox21Click(Sender: TObject);
begin
  cs.Marker.IncreaseDecreaseMode := CheckBox21.Checked;
end;

procedure TAdvChartSeriesEditorFormGDIP.CheckBox22Click(Sender: TObject);
begin
  cs.XAxis.AutoUnits := CheckBox22.Checked;
end;

procedure TAdvChartSeriesEditorFormGDIP.CheckBox23Click(Sender: TObject);
begin
  cs.XAxisGroupsVisible := CheckBox23.Checked;
end;

procedure TAdvChartSeriesEditorFormGDIP.CheckBox24Click(Sender: TObject);
begin
  cs.YAxis.AutoUnits := CheckBox24.Checked;
end;

procedure TAdvChartSeriesEditorFormGDIP.CheckBox25Click(Sender: TObject);
begin
  CheckBox8.Checked := CheckBox25.Checked;
  CheckBox8Click(Self);
end;

procedure TAdvChartSeriesEditorFormGDIP.CheckBox26Click(Sender: TObject);
begin
  CheckBox17.Checked := CheckBox26.Checked;
  CheckBox17Click(Self);
end;

procedure TAdvChartSeriesEditorFormGDIP.CheckBox29Click(Sender: TObject);
begin
  cs.Shadow := CheckBox29.Checked;
end;

procedure TAdvChartSeriesEditorFormGDIP.CheckBox2Click(Sender: TObject);
begin
  cs.ShowValueInTracker := CheckBox2.Checked;
end;

procedure TAdvChartSeriesEditorFormGDIP.CheckBox3Click(Sender: TObject);
begin
  cs.ShowValue := CheckBox3.Checked;
end;

procedure TAdvChartSeriesEditorFormGDIP.CheckBox4Click(Sender: TObject);
begin
  cs.XAxis.Visible := CheckBox4.Checked;
end;

procedure TAdvChartSeriesEditorFormGDIP.CheckBox5Click(Sender: TObject);
begin
  cs.YAxis.Visible := CheckBox5.Checked;
end;

procedure TAdvChartSeriesEditorFormGDIP.CheckBox6Click(Sender: TObject);
begin
  cs.ZeroLine := CheckBox6.Checked;
end;

procedure TAdvChartSeriesEditorFormGDIP.CheckBox7Click(Sender: TObject);
begin
  cs.ShowAnnotationsOnTop := CheckBox7.Checked;
end;

procedure TAdvChartSeriesEditorFormGDIP.CheckBox8Click(Sender: TObject);
begin
  cs.Pie.ShowValues := CheckBox8.Checked;
  CheckBox25.Checked := CheckBox8.Checked;
end;

procedure TAdvChartSeriesEditorFormGDIP.CheckBox9Click(Sender: TObject);
begin
  cs.Pie.LegendVisible := CheckBox9.Checked;
end;

procedure TAdvChartSeriesEditorFormGDIP.chkVisibleClick(Sender: TObject);
var
  xgroup: TChartSerieXAxisGroup;
begin
  xgroup := GetXGroup;
  if Assigned(xgroup) then
  begin
    xgroup.Visible := chkVisible.Checked;
  end;
end;

procedure TAdvChartSeriesEditorFormGDIP.ClearSelectedChartTypes;
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
              if TGroupBox(Pages[I].Controls[K]).Controls[J] is TAdvChartTypeSelector then
              begin
                TAdvChartTypeSelector(TGroupBox(Pages[I].Controls[K]).Controls[J]).Selected := false;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TAdvChartSeriesEditorFormGDIP.ComboBox10Change(Sender: TObject);
begin
  cs.XAxis.TextBottom.Position := TChartTextPosition(ComboBox10.ItemIndex);
end;

procedure TAdvChartSeriesEditorFormGDIP.ComboBox11Change(Sender: TObject);
begin
  cs.Marker.GradientType := TChartGradientType(ComboBox11.ItemIndex);
  UpdatePreview2;  
end;

procedure TAdvChartSeriesEditorFormGDIP.ComboBox12Change(Sender: TObject);
begin
  cs.Pie.LegendGradientType := TChartGradientType(ComboBox12.ItemIndex);
end;

procedure TAdvChartSeriesEditorFormGDIP.ComboBox13Change(Sender: TObject);
begin
  cs.YAxis.Position := TChartYAxisPosition(ComboBox13.ItemIndex);
end;

procedure TAdvChartSeriesEditorFormGDIP.ComboBox14Change(Sender: TObject);
begin
  cs.Pie.LegendHatchStyle := THatchStyle(ComboBox14.ItemIndex);
end;

procedure TAdvChartSeriesEditorFormGDIP.ComboBox15Change(Sender: TObject);
begin
  cs.YAxis.TextLeft.Position := TChartTextPosition(ComboBox15.ItemIndex);
end;

procedure TAdvChartSeriesEditorFormGDIP.ComboBox16Change(Sender: TObject);
begin
  cs.Pie.LegendPosition := TChartSeriePiePosition(ComboBox16.ItemIndex);
end;

procedure TAdvChartSeriesEditorFormGDIP.ComboBox17Change(Sender: TObject);
begin
  cs.YAxis.TextRight.Position := TChartTextPosition(ComboBox17.ItemIndex);
end;

procedure TAdvChartSeriesEditorFormGDIP.ComboBox18Change(Sender: TObject);
begin
  cs.Pie.LegendTitleGradientType := TChartGradientType(ComboBox18.ItemIndex);
end;

procedure TAdvChartSeriesEditorFormGDIP.ComboBox19Change(Sender: TObject);
begin
  cs.Pie.LegendTitleHatchStyle := THatchStyle(ComboBox19.ItemIndex);
end;

procedure TAdvChartSeriesEditorFormGDIP.ComboBox1Change(Sender: TObject);
begin
  cs.AutoRange := TChartSerieAutoRange(combobox1.ItemIndex);
end;

procedure TAdvChartSeriesEditorFormGDIP.ComboBox20Change(Sender: TObject);
begin
  cs.Pie.Position := TChartSeriePiePosition(ComboBox20.ItemIndex);
  ComboBox31.ItemIndex := ComboBox20.ItemIndex;
end;

procedure TAdvChartSeriesEditorFormGDIP.ComboBox21Change(Sender: TObject);
begin
  TCrackedChartSerie(cs).FieldNameValue := ComboBox21.Text;
end;

procedure TAdvChartSeriesEditorFormGDIP.ComboBox22Change(Sender: TObject);
begin
  TCrackedChartSerie(cs).FieldNameXAxis := ComboBox22.Text;
end;

procedure TAdvChartSeriesEditorFormGDIP.ComboBox23Change(Sender: TObject);
begin
  cs.SerieType := TSerieType(ComboBox23.ItemIndex);
end;

procedure TAdvChartSeriesEditorFormGDIP.ComboBox24Change(Sender: TObject);
begin
  cs.Pie.ValuePosition := TChartSeriePieValuePosition(ComboBox24.ItemIndex);
  ComboBox35.ItemIndex := ComboBox24.ItemIndex;
end;

procedure TAdvChartSeriesEditorFormGDIP.ComboBox25Change(Sender: TObject);
begin
  cs.HatchStyle := ThatchStyle(ComboBox25.ItemIndex);
end;

procedure TAdvChartSeriesEditorFormGDIP.ComboBox26Change(Sender: TObject);
begin
  cs.BarShape := TChartBarShape(ComboBox26.ItemIndex);
end;

procedure TAdvChartSeriesEditorFormGDIP.ComboBox27Change(Sender: TObject);
begin
  cs.BarValueTextType := TChartBarValueTextType(ComboBox27.ItemIndex);
end;

procedure TAdvChartSeriesEditorFormGDIP.ComboBox28Change(Sender: TObject);
begin
  cs.BarValueTextAlignment := TAlignment(ComboBox28.ItemIndex);
end;

procedure TAdvChartSeriesEditorFormGDIP.ComboBox29Change(Sender: TObject);
begin
  cs.ValueFormatType := TChartValueFormatType(ComboBox29.ItemIndex);
end;

procedure TAdvChartSeriesEditorFormGDIP.ComboBox2Change(Sender: TObject);
begin
  cs.ChartPatternPosition := TChartBackgroundPosition(ComboBox2.ItemIndex);
end;

procedure TAdvChartSeriesEditorFormGDIP.ComboBox30Change(Sender: TObject);
begin
  cs.Pie.SizeType := TChartSeriePieSizeType(ComboBox30.ItemIndex);
end;

procedure TAdvChartSeriesEditorFormGDIP.ComboBox31Change(Sender: TObject);
begin
  ComboBox20.ItemIndex := ComboBox31.ItemIndex;
  ComboBox20Change(Self);
end;

procedure TAdvChartSeriesEditorFormGDIP.ComboBox32Change(Sender: TObject);
begin
  cs.FunnelWidthType := TChartSerieFunnelSizeType(ComboBox32.ItemIndex);
end;

procedure TAdvChartSeriesEditorFormGDIP.ComboBox33Change(Sender: TObject);
begin
  cs.FunnelHeightType := TChartSerieFunnelSizeType(ComboBox33.ItemIndex);
end;

procedure TAdvChartSeriesEditorFormGDIP.ComboBox34Change(Sender: TObject);
begin
  cs.FunnelMode := TChartSerieFunnelMode(ComboBox34.ItemIndex);
end;

procedure TAdvChartSeriesEditorFormGDIP.ComboBox35Change(Sender: TObject);
begin
  Combobox24.ItemIndex := ComboBox35.ItemIndex;
  ComboBox24Change(Self);
end;

procedure TAdvChartSeriesEditorFormGDIP.ComboBox3Change(Sender: TObject);
begin
  cs.GradientType := TchartGradientType(ComboBox3.ItemIndex);
end;

procedure TAdvChartSeriesEditorFormGDIP.ComboBox4Change(Sender: TObject);
begin
  cs.CrossHairYValue.GradientDirection := TchartGradientDirection(ComboBox4.ItemIndex);
  UpdatePreview;
end;

procedure TAdvChartSeriesEditorFormGDIP.ComboBox5Change(Sender: TObject);
begin
  cs.ValueType := TchartValueType(ComboBox5.ItemIndex);
end;

procedure TAdvChartSeriesEditorFormGDIP.ComboBox6Change(Sender: TObject);
begin
  cs.ValueWidthType := TChartSerieValueWidthType(ComboBox6.ItemIndex);
end;

procedure TAdvChartSeriesEditorFormGDIP.ComboBox7Change(Sender: TObject);
begin
  cs.Marker.MarkerType := TChartMarkerType(ComboBox7.ItemIndex);
  UpdatePreview2;
end;

procedure TAdvChartSeriesEditorFormGDIP.ComboBox8Change(Sender: TObject);
begin
  cs.XAxis.Position := TChartXAxisPosition(ComboBox8.ItemIndex);
end;

procedure TAdvChartSeriesEditorFormGDIP.ComboBox9Change(Sender: TObject);
begin
  cs.XAxis.TextTop.Position := TChartTextPosition(ComboBox9.ItemIndex);
end;

procedure TAdvChartSeriesEditorFormGDIP.CorrectTop(lbl: TLabel);
begin
  lbl.Top := Round(lbl.Tag - (lbl.Font.Size - 8) / 2);
end;

procedure TAdvChartSeriesEditorFormGDIP.csLineColorSelect(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
var
  xgroup: TChartSerieXAxisGroup;
begin
  xgroup := GetXGroup;
  if Assigned(xgroup) then
  begin
    if Index = 0 then
      csLineColor.SelectedColor := clNone;

    if Index = 41 then
    begin
      ColorDialog1.Color := csLineColor.SelectedColor;
      if ColorDialog1.Execute then
      begin
        csLineColor.SelectedColor := ColorDialog1.Color;
      end;
    end;

    xgroup.LineColor := csLineColor.SelectedColor;
  end;
end;

procedure TAdvChartSeriesEditorFormGDIP.Edit12Change(Sender: TObject);
begin
  cs.YAxis.TextLeft.Text := Edit12.Text;
end;

procedure TAdvChartSeriesEditorFormGDIP.Edit13Change(Sender: TObject);
begin
  cs.YAxis.TextRight.Text := Edit13.Text;
end;

procedure TAdvChartSeriesEditorFormGDIP.Edit1Change(Sender: TObject);
begin
  cs.LegendText := Edit1.Text;
end;

procedure TAdvChartSeriesEditorFormGDIP.Edit3Change(Sender: TObject);
begin
  cs.ValueFormat := Edit3.Text;
end;

procedure TAdvChartSeriesEditorFormGDIP.Edit4Change(Sender: TObject);
begin
  cs.XAxis.DateTimeFormat := Edit4.Text;
end;

procedure TAdvChartSeriesEditorFormGDIP.Edit5Change(Sender: TObject);
begin
  cs.XAxis.MajorUnitTimeFormat := Edit5.Text;
end;

procedure TAdvChartSeriesEditorFormGDIP.Edit6Change(Sender: TObject);
begin
  cs.XAxis.MinorUnitTimeFormat := Edit6.Text;
end;

procedure TAdvChartSeriesEditorFormGDIP.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Mode = notsaving then
  begin
    case MessageDlg('Save Changes ?',mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
      begin
        SaveChanges;
        col.Free;
        ModalResult := mrOk ;
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
    col.Free;
  end;
end;

procedure TAdvChartSeriesEditorFormGDIP.FormCreate(Sender: TObject);
begin
  {$IFDEF DELPHI9_LVL}
  DoubleBuffered := true;
  {$ENDIF}
  DTB.TabVisible := false;
end;

procedure TAdvChartSeriesEditorFormGDIP.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
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

function TAdvChartSeriesEditorFormGDIP.GetXGroup: TChartSerieXAxisGroup;
begin
  Result := nil;
  if (ListBox2.ItemIndex <> -1) and (ListBox2.Items.Count > 0) then
    if (ListBox2.ItemIndex >= 0) and (ListBox2.ItemIndex <= cs.XAxisGroups.Count - 1) then
      Result := cs.XAxisGroups[ListBox2.ItemIndex];
end;

procedure TAdvChartSeriesEditorFormGDIP.Image1Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    cs.ChartPattern.Assign(Image1.Picture);
  end;
end;

procedure TAdvChartSeriesEditorFormGDIP.Image2Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    Image2.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    cs.Marker.MarkerPicture.Assign(Image2.Picture);
    UpdatePreview2;    
  end;
end;

procedure TAdvChartSeriesEditorFormGDIP.InitListBox;
var
  i: integer;
begin
  ListBox1.Items.Clear;
  for i := 0 to Col.Count - 1 do
  begin
    listbox1.Items.Add(Col[i].Name + ' : ' + Col[i].LegendText);
    ListBox1.Checked[i] := Col[i].Visible;
  end;

  InitializeCrossHairChart;
  AdvGDIPChartView1.Panes[0].Series[0].ClearPoints;
  for I := 0 to 10 do
    AdvGDIPChartView1.Panes[0].Series[0].AddSinglePoint(RandomRange(0, 30));
  AdvGDIPChartView1.Panes[0].Series[0].ChartType := ctLine;
  AdvGDIPChartView1.Panes[0].Series[0].AutoRange := arEnabled;

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

procedure TAdvChartSeriesEditorFormGDIP.Init;
var
  i: integer;
  K: integer;

begin
  PageControl1.ActivePageIndex := 0;

//  col := TAdvGDIPChartSeries.Create(TAdvGDIPChart(ChartSeries.Owner));

  col := TAdvGDIPChartSeries(FChartView.GetSeriesClass.Create(TAdvGDIPChart(ChartSeries.Owner)));

  ListBox1.Items.Clear;
  K := 0;
  for i := 0 to ChartSeries.Count - 1 do
  begin
    if not ChartSeries[i].ReadOnly then
    begin
      Col.Add;
      Col[K].Assign(ChartSeries[i]);
      Inc(K);
    end;
  end;

  InitListbox;
end;

procedure TAdvChartSeriesEditorFormGDIP.InitGroups;
var
  g: integer;
begin
  GroupBox44.Enabled := False;
  ListBox2.Items.Clear;
  for G := 0 to cs.XAxisGroups.Count - 1 do
  begin
    ListBox2.Items.Add('Serie : '+ inttostr(cs.Index) + ' Group : '+ inttostr(cs.XAxisGroups[G].Index)
   + ' :' + cs.XAxisGroups[G].Caption);
  end;
end;

procedure TAdvChartSeriesEditorFormGDIP.InitializeCrossHairChart;
var
  I: Integer;
begin

  if AdvChartview1.Panes[0].Series.Count = 0 then  
    AdvChartView1.Panes[0].Series.Add;

  AdvChartView1.Panes[0].Series[0].ClearPoints;
  for I := 0 to 10 do
    AdvChartView1.Panes[0].Series[0].AddSinglePoint(RandomRange(0, 30));

  AdvChartView1.Panes[0].Series[0].ChartType := ctLine;
  AdvChartView1.Panes[0].Series[0].AutoRange := arEnabled;
  AdvChartView1.Panes[0].Series[0].LineColor := clNavy;
  AdvChartView1.Panes[0].Series[0].LineWidth := 2;
  AdvChartView1.Panes[0].Series[0].YAxis.Position := yRight;
  AdvChartView1.Panes[0].Series[0].YAxis.TickMarkSize := 0;

end;

procedure TAdvChartSeriesEditorFormGDIP.ListBox1Click(Sender: TObject);
var
  I, K, J: Integer;
  sl: TStringList;
begin
  if listbox1.ItemIndex >= 0 then
  begin
    cs := Col[listbox1.ItemIndex];

    with TCrackedChartSerie(cs) do
    begin
      if IsDB then
      begin
        DTB.TabVisible := true;
        ComboBox21.Items.Clear;
        sl := GetDSFieldNames;
        if Assigned(sl) then
        begin
          ComboBox21.Items.AddStrings(sl);
          sl.Free;
        end;
        ComboBox22.Items.Assign(ComboBox21.Items);
        ComboBox21.Text := FieldNameValue;
        ComboBox22.Text := FieldNameXAxis;
      end
      else
        DTB.TabVisible := false;
    end;


    PageControl1.Enabled := not (cs = nil);
    PageControl1.Visible := not (cs = nil);
    Panel3.Visible := false;
    //Autorange
    combobox1.ItemIndex := integer(cs.AutoRange);
    //BackGroundposition
    ComboBox2.ItemIndex := integer(cs.ChartPatternPosition);
    //Picture
    Image1.Picture.Assign(cs.ChartPattern);
    //BorderWidth
    SpinEdit1.Value := cs.BorderWidth;
    //BorderColor
    AdvColorSelector1.SelectedColor := cs.BorderColor;
    //BrushStyle
    AdvBrushStyleSelector1.SelectedBrushStyle := cs.BrushStyle;
    //Color
    AdvChartColorSelector3.SelectedColor := cs.Color;
    //ColorTo
    AdvChartColorSelector4.SelectedColor := cs.ColorTo;
    //CandleColorIncrease
    AdvColorSelector4.SelectedColor := cs.CandleColorIncrease;
    //CandleColorDecrease
    AdvColorSelector5.SelectedColor := cs.CandleColorDecrease;
    //GradientDirection
    ComboBox3.ItemIndex := Integer(cs.GradientType);
    //Linecolor
    AdvColorSelector6.SelectedColor := cs.LineColor;
    //LineWidth
    SpinEdit3.Value := cs.LineWidth;
    //WickColor
    AdvColorSelector7.SelectedColor := cs.WickColor;
    //WickWidth
    SpinEdit4.Value := cs.WickWidth;
    //PenStyle
    AdvPenStyleSelector1.SelectedPenStyle := cs.PenStyle;
    //FBorderColor: TColor;
    AdvColorSelector8.SelectedColor := cs.CrossHairYValue.BorderColor;
    //FColor: TColor;
    AdvColorSelector9.SelectedColor := cs.CrossHairYValue.Color;
    //FColorTo: TColor;
    AdvColorSelector10.SelectedColor := cs.CrossHairYValue.ColorTo;
    //FGradientSteps: integer;
    SpinEdit5.Value := cs.CrossHairYValue.GradientSteps;
    //FGradientDirection: TChartGradientDirection;
    ComboBox4.ItemIndex := Integer(cs.CrossHairYValue.GradientDirection);
    //FVisible: Boolean;
    CheckBox1.Checked := cs.CrossHairYValue.Visible;
    //LegendText
    Edit1.Text := cs.LegendText;
    //Valueformat
    Edit3.Text := cs.ValueFormat;
    //Maximum
    AdvSpinEdit1.FloatValue := cs.Maximum;
    AdvSpinEdit2.FloatValue := cs.Minimum;
    //Borderwidth
    SpinEdit6.Value := cs.BorderWidth;
    //opacity
    AdvChartSpinEdit3.Value := cs.OpacityTo;
    //opacityto
    AdvChartSpinEdit4.Value := cs.Opacity;
    ComboBox25.ItemIndex := Integer(cs.HatchStyle);
    CheckBox29.Checked := cs.Shadow;
    AdvChartSpinEdit2.Value := cs.Angle;
    //showvalueintracker
    CheckBox2.Checked := cs.ShowValueInTracker;
    //showvalue
    CheckBox3.Checked := cs.ShowValue;
    //ValueWidth
    SpinEdit10.Value := cs.ValueWidth;
    //valuetype
    ComboBox5.ItemIndex := Integer(cs.ValueType);
    //valuewidthtype
    ComboBox6.ItemIndex := Integer(cs.ValueWidthType);
    //markertype
    ComboBox7.ItemIndex := Integer(cs.Marker.MarkerType);
    //markersize
    SpinEdit11.Value := cs.Marker.MarkerSize;
    AdvChartSpinEdit1.Value := cs.Marker.OpacityTo;
    AdvChartSpinEdit5.Value := cs.Marker.Opacity;
    //markercolor
    AdvChartcolorSelector5.SelectedColor := cs.Marker.Markercolor;
    AdvChartcolorSelector6.SelectedColor := cs.Marker.MarkercolorTo;
    ComboBox11.ItemIndex := Integer(cs.Marker.GradientType);
    //markerlinecolor
    AdvColorselector12.SelectedColor := cs.Marker.MarkerLinecolor;
    //markerlinewidth
    SpinEdit12.Value := cs.Marker.MarkerLineWidth;
    //markerpicture
    Image2.Picture.Assign(cs.Marker.MarkerPicture);
    AdvChartColorSelector1.SelectedColor := cs.Marker.SelectedColor;
    AdvChartColorSelector2.SelectedColor := cs.Marker.SelectedLineColor;
    SpinEdit8.Value := cs.Marker.SelectedLineWidth;
    SpinEdit9.Value := cs.Marker.SelectedSize;
    //XAXIS
    Edit4.Text := cs.XAxis.DateTimeFormat;
    SpinEdit13.Value := Round(cs.XAxis.MajorUnit);
    SpinEdit14.Value := cs.XAxis.MajorUnitSpacing;
    Edit5.TExt := cs.Xaxis.MajorUnitTimeFormat;
    SpinEdit15.Value := Round(cs.Xaxis.MinorUnit);
    SpinEdit16.Value := cs.XAxis.MinorUnitSpacing;
    Edit6.Text := cs.XAxis.MinorUnitTimeFormat;
    CheckBox4.Checked := cs.XAxis.Visible;
    CheckBox22.Checked := cs.XAxis.AutoUnits;
    CheckBox24.Checked := cs.YAxis.AutoUnits;
    ComboBox8.ItemIndex := Integer(cs.XAxis.Position);
    SpinEdit31.Value := cs.XAxis.TextTop.Angle;
    ComboBox9.ItemIndex := Integer(cs.XAxis.TextTop.Position);
    SpinEdit19.Value := cs.XAxis.TextTop.Offset;
    SpinEdit32.Value := cs.XAxis.TextBottom.Angle;
    ComboBox10.ItemIndex := Integer(cs.XAxis.TextBottom.Position);
    SpinEdit20.Value := cs.XAxis.TextBottom.Offset;
    AdvColorSelector13.SelectedColor := cs.XAxis.TickMarkColor;
    SpinEdit17.Value := cs.XAxis.TickMarkSize;
    SpinEdit18.Value := cs.XAxis.TickMarkWidth;
    //Y-AXIS
    AdvSpinEdit5.FloatValue := cs.YAxis.MajorUnit;
    AdvSpinEdit4.FloatValue := cs.YAxis.MinorUnit;
    AdvSpinEdit3.FloatValue := cs.ZeroReferencePoint;
    SpinEdit23.Value := cs.YAxis.MajorUnitSpacing;
    SpinEdit21.Value := cs.YAxis.MinorUnitSpacing;
    CheckBox5.Checked := cs.YAxis.Visible;
    ComboBox13.ItemIndex := Integer(cs.YAxis.Position);
    SpinEdit29.Value := cs.ZeroLineWidth;
    AdvColorSelector15.SelectedColor := cs.ZeroLineColor;
    CheckBox6.Checked := cs.ZeroLine;
    CheckBox13.checked := cs.YAxis.MajorUnitVisible;
    CheckBox12.Checked := cs.YAxis.MinorUnitVisible;
    AdvChartSpinEdit23.value := cs.YAxis.TickMarkSizeMinor;

    SpinEdit33.Value := cs.YAxis.TextLeft.Angle;
    Edit12.TExt := cs.YAxis.TextLeft.Text;
    ComboBox15.ItemIndex := Integer(cs.YAxis.TextLeft.Position);
    SpinEdit25.Value := cs.YAxis.TextLeft.Offset;
    SpinEdit34.Value := cs.YAxis.TextRight.Angle;
    Edit13.TExt := cs.YAxis.TextRight.Text;
    ComboBox17.ItemIndex := Integer(cs.YAxis.TextRight.Position);
    SpinEdit26.Value := cs.YAxis.TextRight.Offset;
    AdvColorSelector14.SelectedColor := cs.YAxis.TickMarkColor;
    SpinEdit28.Value := cs.YAxis.TickMarkSize;
    SpinEdit27.Value := cs.YAxis.TickMarkWidth;
    SpinEdit7.Value := cs.BorderRounding;

    //ANNOTATIONS
    CheckBox7.Checked := cs.ShowAnnotationsOnTop;
    ClearSelectedChartTypes;

    CheckBox23.Checked := cs.XAxisGroupsVisible;
    InitGroups;

    AdvChartSpinEdit6.Value := cs.ArrowSize;
    AdvChartColorSelector7.SelectedColor := cs.ArrowColor;
    AdvChartSpinEdit7.value := cs.ValueAngle;

    //PIE CHART
    AdvChartSpinEdit8.Value := cs.Pie.Size;
    CheckBox8.Checked := cs.Pie.ShowValues;
    AdvChartColorSelector10.selectedColor := cs.Pie.LegendColor;
    AdvChartColorSelector9.selectedColor := cs.Pie.LegendColorTo;
    AdvChartColorSelector8.selectedColor := cs.Pie.LegendBorderColor;
    AdvChartSpinEdit9.Value := cs.Pie.LegendBorderWidth;
    comboBox12.ItemIndex := Integer(cs.Pie.LegendGradientType);
    comboBox14.ItemIndex := Integer(cs.Pie.LegendHatchStyle);
    AdvchartSpinEdit10.Value := cs.Pie.LegendGradientAngle;
    CheckBox9.Checked := cs.Pie.LegendVisible;
    AdvChartspinEdit11.Value := cs.Pie.LegendOffsetLeft;
    AdvchartspinEdit15.Value := cs.Pie.LegendOffsetTop;
    AdvChartspinEdit13.Value := cs.Pie.LegendOpacity;
    AdvChartspinEdit12.Value := cs.Pie.LegendOpacityTo;
    AdvChartSpinEdit14.Value := cs.Pie.StartOffsetAngle;
    AdvChartSpinEdit16.Value := cs.Pie.InnerSize;
    AdvChartSpinEdit19.Value := cs.Pie.LegendTitleGradientAngle;
    AdvChartSpinEdit17.Value := cs.Pie.LegendTitleOpacityTo;
    AdvChartSpinEdit18.Value := cs.Pie.LegendTitleOpacity;
    ComboBox19.ItemIndex := integer(cs.Pie.LegendTitleHatchStyle);
    ComboBox18.ItemIndex := integer(cs.Pie.LegendTitleGradientType);
    AdvChartColorSelector11.SelectedColor := cs.Pie.LegendTitleColorTo;
    AdvChartColorSelector12.SelectedColor := cs.Pie.LegendTitleColor;
    CheckBox10.Checked := cs.Pie.LegendTitleVisible;
    ComboBox16.ItemIndex := Integer(cs.Pie.LegendPosition);
    ComboBox20.ItemIndex := Integer(cs.Pie.Position);
    ComboBox30.ItemIndex := Integer(cs.Pie.SizeType);
    AdvChartSpinEdit20.Value := cs.Pie.Left;
    AdvChartSpinEdit21.Value := cs.Pie.Top;

    AdvChartSpinEdit22.value := cs.SelectedMarkSize;
    AdvChartColorSelector13.SelectedColor := cs.SelectedMarkBorderColor;
    AdvChartColorSelector14.SelectedColor := cs.SelectedMarkColor;
    CheckBox11.Checked := cs.SelectedMark;

    Label135.Font.assign(cs.CrossHairYValue.Font);
    CorrectTop(Label135);
    Label136.font.assign(cs.ValueFont);
    CorrectTop(Label136);
    label137.Font.Assign(cs.Xaxis.DateTimeFont);
    CorrectTop(Label137);
    label138.font.Assign(cs.Xaxis.MajorFont);
    CorrectTop(Label138);
    Label139.font.Assign(cs.Xaxis.MinorFont);
    CorrectTop(Label139);
    label140.font.Assign(cs.Xaxis.TextBottom.font);
    CorrectTop(Label140);
    label141.font.Assign(cs.Xaxis.Texttop.font);
    CorrectTop(Label141);
    label142.font.Assign(cs.Yaxis.MajorFont);
    CorrectTop(Label142);
    Label143.font.Assign(cs.Yaxis.MinorFont);
    CorrectTop(Label143);
    label144.font.Assign(cs.Yaxis.TextLeft.font);
    CorrectTop(Label144);
    label145.font.Assign(cs.Yaxis.TextRight.font);
    CorrectTop(Label145);
    label146.font.assign(cs.Pie.Valuefont);
    label177.Font.Assign(cs.Pie.ValueFont);
    CorrectTop(Label146);
    label147.font.assign(cs.pie.legendfont);
    CorrectTop(Label147);
    CorrectTop(Label177);


    AdvChartSpinEdit28.Value := cs.FunnelWidth;
    AdvChartSpinEdit29.Value := cs.FunnelHeight;
    ComboBox31.ItemIndex := Integer(cs.Pie.Position);
    ComboBox34.ItemIndex := Integer(cs.FunnelMode);
    AdvChartSpinEdit32.Value := cs.FunnelSpacing;
    ComboBox32.ItemIndex := Integer(cs.FunnelWidthType);
    ComboBox33.ItemIndex := Integer(cs.FunnelHeightType);
    AdvChartSpinEdit30.Value := cs.Pie.Left;
    AdvChartSpinEdit31.Value := cs.Pie.Top;

    CheckBox25.Checked := cs.Pie.ShowValues;
    CheckBox26.Checked := cs.Pie.ShowLegendOnSlice;
    Combobox35.ItemIndex := Integer(cs.Pie.ValuePosition);

    CheckBox14.Checked := cs.Pie.ShowGrid;
    CheckBox15.Checked := cs.Pie.ShowGridPieLines;
    CheckBox16.Checked := cs.ShowInLegend;
    ComboBox23.ItemIndex := Integer(cs.SerieType);
    ComboBox24.ItemIndex := Integer(cs.Pie.ValuePosition);
    ComboBox29.ItemIndex := Integer(cs.ValueFormatType);
    CheckBox17.Checked := cs.Pie.ShowLegendOnSlice;
    AdvChartSpinEdit24.Value := cs.Offset3D;
    CheckBox18.Checked := cs.Enable3D;
    CheckBox19.Checked := cs.Darken3D;

    CheckBox20.Checked := cs.Logarithmic;
    CheckBox21.Checked := cs.Marker.IncreaseDecreaseMode;
    ComboBox26.ItemIndex := Integer(cs.BarShape);

    Label160.Font.Assign(cs.BarValueTextFont);
    CorrectTop(Label160);
    ComboBox27.ItemIndex := Integer(cs.BarValueTextType);
    ComboBox28.ItemIndex := Integer(cs.BarValueTextAlignment);

    AdvChartSpinEdit26.Value := cs.ValueOffsetY;
    AdvChartSpinEdit27.Value := cs.ValueOffsetX;

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
                if TGroupBox(Pages[I].Controls[K]).Controls[J] is TAdvChartTypeSelector then
                begin
                  TAdvChartTypeSelector(TGroupBox(Pages[I].Controls[K]).Controls[J]).Selected := (TAdvChartTypeSelector(TGroupBox(Pages[I].Controls[K]).Controls[J]).ChartType = cs.Charttype);
                  if TAdvChartTypeSelector(TGroupBox(Pages[I].Controls[K]).Controls[J]).Selected then
                  begin
                    PageControl2.ActivePageIndex := I;
                    break;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;

    UpdatePreview2;
    UpdatePreview;
  end;
end;

procedure TAdvChartSeriesEditorFormGDIP.ListBox1ClickCheck(Sender: TObject);
begin
  if (ListBox1.ItemIndex >= 0) and (ListBox1.ItemIndex <= ListBox1.Items.Count - 1) then
    Col[ListBox1.ItemIndex].Visible := ListBox1.Checked[ListBox1.ItemIndex];
end;

procedure TAdvChartSeriesEditorFormGDIP.ListBox1DblClick(Sender: TObject);
begin
  if SpeedButton4.Enabled then
    StartAnnotationsEditor;
end;

procedure TAdvChartSeriesEditorFormGDIP.ListBox1DragDrop(Sender, Source: TObject; X,
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

procedure TAdvChartSeriesEditorFormGDIP.ListBox1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := (Source = ListBox1) and FAllowR;
end;

procedure TAdvChartSeriesEditorFormGDIP.ListBox1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  StartingPoint.X := X;
  StartingPoint.Y := Y;
end;

procedure TAdvChartSeriesEditorFormGDIP.ListBox2Click(Sender: TObject);
var
  xgroup: TChartSerieXAxisGroup;
begin
  xgroup := GetXGroup;
  if Assigned(xgroup) then
  begin
    groupbox44.Enabled := True;
    chkVisible.Checked := xgroup.Visible;
    csLineColor.SelectedColor := xgroup.LineColor;
    cboLinetype.ItemIndex := Integer(xgroup.LineType);
    spinEnd.Value := xgroup.EndIndex;
    spinStart.Value := xgroup.StartIndex;
    txtCaption.Text := xgroup.Caption;
    AdvChartSpinEdit25.Value := xgroup.Level;
  end
  else
    groupbox44.Enabled := False;
end;

procedure TAdvChartSeriesEditorFormGDIP.SaveChanges;
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

procedure TAdvChartSeriesEditorFormGDIP.SpeedButton1Click(Sender: TObject);
begin
  if listbox1.ItemIndex >= 0 then
  begin
    Col[Listbox1.ItemIndex].Free;
    InitListbox;
  end;
end;

procedure TAdvChartSeriesEditorFormGDIP.SpeedButton2Click(Sender: TObject);
begin
  Col.Add;
  InitListBox;
end;

procedure TAdvChartSeriesEditorFormGDIP.SpeedButton3Click(Sender: TObject);
var
  s: String;
begin
  if ListBox1.Items.Count <> 0 then
  begin
    InputQuery('Serie name', 'Please enter new name',s);
    if s <> '' then
    begin
      cs.name := s;
      ListBox1.Items[cs.Index] := s;
    end;
  end;
end;

procedure TAdvChartSeriesEditorFormGDIP.SpeedButton4Click(Sender: TObject);
begin
  StartAnnotationsEditor;
end;

procedure TAdvChartSeriesEditorFormGDIP.SpeedButton5Click(Sender: TObject);
var
  xgroup: TChartSerieXAxisGroup;
begin
  xgroup := GetXGroup;
  if Assigned(xgroup) then
  begin
    xgroup.Free;
    InitGroups;
    ListBox2.ItemIndex := -1;
    ListBox2Click(ListBox2);
  end;
end;

procedure TAdvChartSeriesEditorFormGDIP.SpeedButton6Click(Sender: TObject);
begin
  cs.XAxisGroups.Add;
  InitGroups;
  ListBox2.ItemIndex := ListBox2.Items.Count - 1;
  ListBox2Click(ListBox2);
end;

procedure TAdvChartSeriesEditorFormGDIP.SpinEdit10Change(Sender: TObject);
begin
  cs.ValueWidth := SpinEdit10.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.SpinEdit11Change(Sender: TObject);
begin
  cs.Marker.MarkerSize := SpinEdit11.Value;
  UpdatePreview2;  
end;

procedure TAdvChartSeriesEditorFormGDIP.SpinEdit12Change(Sender: TObject);
begin
  cs.Marker.MarkerLineWidth := SpinEdit12.Value;
  UpdatePreview2;
end;

procedure TAdvChartSeriesEditorFormGDIP.SpinEdit13Change(Sender: TObject);
begin
  cs.XAxis.MajorUnit := SpinEdit13.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.SpinEdit14Change(Sender: TObject);
begin
  cs.XAxis.MajorUnitSpacing := SpinEdit14.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.SpinEdit15Change(Sender: TObject);
begin
  cs.XAxis.MinorUnit := SpinEdit15.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.SpinEdit16Change(Sender: TObject);
begin
  cs.Xaxis.MinorUnitSpacing := SpinEdit16.value; 
end;

procedure TAdvChartSeriesEditorFormGDIP.SpinEdit17Change(Sender: TObject);
begin
  cs.XAxis.TickMarkSize := SpinEdit17.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.SpinEdit18Change(Sender: TObject);
begin
  cs.XAxis.TickMarkWidth := SpinEdit18.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.SpinEdit19Change(Sender: TObject);
begin
  cs.Xaxis.TextTop.Offset := SpinEdit19.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.SpinEdit1Change(Sender: TObject);
begin
  cs.BorderWidth := SpinEdit1.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.SpinEdit20Change(Sender: TObject);
begin
  cs.Xaxis.TextBottom.Offset := SpinEdit20.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.SpinEdit21Change(Sender: TObject);
begin
  cs.YAxis.MinorUnitSpacing := Spinedit21.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.SpinEdit23Change(Sender: TObject);
begin
  cs.YAxis.MajorUnitSpacing := SpinEdit23.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.SpinEdit25Change(Sender: TObject);
begin
  cs.YAxis.TextLeft.Offset := SpinEdit25.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.SpinEdit26Change(Sender: TObject);
begin
  cs.YAxis.TextRight.Offset := SpinEdit26.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.SpinEdit27Change(Sender: TObject);
begin
  cs.YAxis.TickMarkWidth := SpinEdit27.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.SpinEdit28Change(Sender: TObject);
begin
  cs.YAxis.TickMarkSize := SpinEdit28.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.SpinEdit29Change(Sender: TObject);
begin
  cs.ZeroLineWidth := SpinEdit29.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.SpinEdit31Change(Sender: TObject);
begin
  cs.XAxis.TextTop.Angle := SpinEdit31.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.SpinEdit32Change(Sender: TObject);
begin
  cs.Xaxis.TextBottom.Angle := SpinEdit32.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.SpinEdit33Change(Sender: TObject);
begin
  cs.YAxis.TextLeft.Angle := SpinEdit33.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.SpinEdit34Change(Sender: TObject);
begin
  cs.YAxis.TextRight.Angle := SpinEdit34.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.SpinEdit3Change(Sender: TObject);
begin
  cs.LineWidth := SpinEdit3.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.SpinEdit4Change(Sender: TObject);
begin
  cs.WickWidth := SpinEdit4.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.SpinEdit5Change(Sender: TObject);
begin
  cs.CrossHairYValue.GradientSteps := SpinEdit5.Value;
  UpdatePreview;  
end;

procedure TAdvChartSeriesEditorFormGDIP.SpinEdit6Change(Sender: TObject);
begin
  cs.CrossHairYValue.BorderWidth := SpinEdit6.Value;
  UpdatePreview;
end;

procedure TAdvChartSeriesEditorFormGDIP.SpinEdit7Change(Sender: TObject);
begin
  cs.BorderRounding := SpinEdit7.Value;
end;

procedure TAdvChartSeriesEditorFormGDIP.SpinEdit8Change(Sender: TObject);
begin
  cs.Marker.SelectedLineWidth := SpinEdit8.Value;
  UpdatePreview2;
end;

procedure TAdvChartSeriesEditorFormGDIP.SpinEdit9Change(Sender: TObject);
begin
  cs.Marker.SelectedSize := SpinEdit9.Value;
  UpdatePreview2;  
end;

procedure TAdvChartSeriesEditorFormGDIP.spinEndChange(Sender: TObject);
var
  xgroup: TChartSerieXAxisGroup;
begin
  xgroup := GetXGroup;
  if Assigned(xgroup) then
  begin
    xgroup.EndIndex := spinEnd.Value;
  end;
end;

procedure TAdvChartSeriesEditorFormGDIP.spinStartChange(Sender: TObject);
var
  xgroup: TChartSerieXAxisGroup;
begin
  xgroup := GetXGroup;
  if Assigned(xgroup) then
  begin
    xgroup.StartIndex := spinStart.Value;
  end;
end;

procedure TAdvChartSeriesEditorFormGDIP.StartAnnotationsEditor;
var
  ac: TAdvChartAnnotationsEditorFormGDIP;
begin
  if ListBox1.Items.Count <> 0 then
  begin
    ac := TAdvChartAnnotationsEditorFormGDIP.Create(Self);
    ac.ChartAnnotations := cs.Annotations;
    ac.Chartview := FChartView;
    ac.Init;
    ac.Apply := ApplyChanges;
    ac.ShowModal;
    ac.Free;
  end;
end;

procedure TAdvChartSeriesEditorFormGDIP.txtCaptionChange(Sender: TObject);
var
  xgroup: TChartSerieXAxisGroup;
begin
  xgroup := GetXGroup;
  if Assigned(xgroup) then
  begin
    xgroup.Caption := txtCaption.Text;
    ListBox2.Items[ListBox2.ItemIndex] := 'Serie : '+ inttostr(cs.Index) + ' Group : '+ inttostr(ListBox2.ItemIndex)
     + ' :' + txtCaption.Text;
  end;
end;

procedure TAdvChartSeriesEditorFormGDIP.UpdatePreview;
begin
  PatBlt(AdvChartView1.GetCanvas.Handle,0,0,AdvChartView1.ClientWidth,AdvChartView1.ClientHeight,WHITENESS);
  AdvChartView1.Panes[0].Series[0].CrossHairYValue.BorderColor := cs.CrossHairYValue.BorderColor;
  AdvChartView1.Panes[0].Series[0].CrossHairYValue.Color := cs.CrossHairYValue.Color;
  AdvChartView1.Panes[0].Series[0].CrossHairYValue.ColorTo := cs.CrossHairYValue.ColorTo;
  AdvChartView1.Panes[0].Series[0].CrossHairYValue.Font.Assign(cs.CrossHairYValue.Font);
  AdvChartView1.Panes[0].Series[0].CrossHairYValue.Visible := cs.CrossHairYValue.Visible;
  AdvChartView1.Panes[0].Series[0].CrossHairYValue.GradientDirection := cs.CrossHairYValue.GradientDirection;
  AdvChartView1.Panes[0].Series[0].CrossHairYValue.GradientSteps := cs.CrossHairYValue.GradientSteps;
  AdvChartView1.Invalidate;
end;

procedure TAdvChartSeriesEditorFormGDIP.UpdatePreview2;
begin
  PatBlt(AdvGDIPChartView1.GetCanvas.Handle,0,0,AdvGDIPChartView1.ClientWidth,AdvGDIPChartView1.ClientHeight,WHITENESS);
  AdvGDIPChartView1.Panes[0].Series[0].ChartType := ctLine;
  AdvGDIPChartView1.Panes[0].Series[0].Marker.MarkerType := cs.Marker.MarkerType;
  AdvGDIPChartView1.Panes[0].Series[0].Marker.Opacity := cs.Marker.Opacity;
  AdvGDIPChartView1.Panes[0].Series[0].Marker.OpacityTo := cs.Marker.OpacityTo;
  AdvGDIPChartView1.Panes[0].Series[0].Marker.GradientType := cs.Marker.GradientType;
  AdvGDIPChartView1.Panes[0].Series[0].Marker.MarkerColorTo := cs.Marker.MarkerColorTo;
  AdvGDIPChartView1.Panes[0].Series[0].Marker.MarkerColor := cs.Marker.Markercolor;
  AdvGDIPChartView1.Panes[0].Series[0].Marker.MarkerSize := cs.Marker.MarkerSize;
  AdvGDIPChartView1.Panes[0].Series[0].Marker.MarkerLineWidth := cs.Marker.MarkerLineWidth;
  AdvGDIPChartView1.Panes[0].Series[0].Marker.MarkerLineColor := cs.Marker.MarkerLineColor;
  AdvGDIPChartView1.Panes[0].Series[0].Marker.MarkerPicture.Assign(cs.Marker.MarkerPicture);
  AdvGDIPChartView1.Panes[0].Series[0].Marker.SelectedColor := cs.Marker.SelectedColor;
  AdvGDIPChartView1.Panes[0].Series[0].Marker.SelectedLineColor := cs.Marker.SelectedLineColor;
  AdvGDIPChartView1.Panes[0].Series[0].Marker.SelectedLineWidth := cs.Marker.SelectedLineWidth;
  AdvGDIPChartView1.Panes[0].Series[0].Marker.IncreaseDecreaseMode := cs.Marker.IncreaseDecreaseMode;

  AdvGDIPChartView1.Panes[0].Series[0].Marker.SelectedSize := cs.Marker.SelectedSize;
  AdvGDIPChartView1.Invalidate;
end;

{ TAdvChartSerieEditorDialog }

constructor TAdvChartSeriesEditorDialogGDIP.Create(AOwner: TComponent);
begin
  inherited;
  FAllowSerieRemoving := true;
  FAllowSerieNameChange := true;
  FAllowSerieReorder := true;
  FAllowSerieAdding := true;
  FAllowAnnotationEditing := true;
end;

function TAdvChartSeriesEditorDialogGDIP.Execute: Boolean;
begin
  if not Assigned(FChartView) then
  begin
    raise Exception.Create('The dialog does not have AdvChartView Component assigned.');
    Result := False;
    Exit;
  end;

  FForm := TAdvChartSeriesEditorFormGDIP.Create(Application);
  FForm.ChartSeries := FChartView.Panes[ChartPaneIndex].Series;
  FForm.ChartView := FChartView;
  FForm.SpeedButton4.Enabled := AllowAnnotationEditing;
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

procedure TAdvChartSeriesEditorDialogGDIP.SetChartPaneIndex(const Value: integer);
begin
  if not Assigned(FChartView)  then
  begin
    FChartPaneIndex := Value;
    Exit;
  end
  else
  begin
    if (Value <= FChartView.Panes.Count - 1) and (Value >= 0) then
      FChartPaneIndex := Value
    else
      FChartPaneIndex := FChartView.Panes.Count - 1;
  end;
end;

procedure TAdvChartSeriesEditorDialogGDIP.SetChartView(const Value: TAdvGDIPChartView);
begin
  FChartView := Value;
end;

end.
