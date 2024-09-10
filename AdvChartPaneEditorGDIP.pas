{***************************************************************************}
{ TAdvGDIPhartPaneEditor component                                          }
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

Unit AdvChartPaneEditorGDIP;

{$I TMSDEFS.INC}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, AdvChartViewGDIP,
  Dialogs, StdCtrls, ExtDlgs, ComCtrls, ExtCtrls, AdvChartGDIP, AdvChartSelectors, AdvChartSpin,
  Buttons, AdvChartSerieEditorGDIP, Mask, AdvChart, AdvChartView,
  AdvChartFillPreview, Math, CheckLst;

type
  TCrackedChartPane = class(TAdvGDIPChartPane)
  end;

  TSaveMode = (notsaving, saving, cancel);

  TAdvChartPanesEditorFormGDIP = class(TForm)
    ListBox1: TCheckListBox;
    PageControl1: TPageControl;
    TabSheet7: TTabSheet;
    OpenPictureDialog1: TOpenPictureDialog;
    Panel1: TPanel;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    GroupBox1: TGroupBox;
    SpinEdit9: TAdvChartSpinEdit;
    SpinEdit10: TAdvChartSpinEdit;
    Label32: TLabel;
    Label31: TLabel;
    GroupBox2: TGroupBox;
    Label14: TLabel;
    AdvColorSelector7: TAdvChartColorSelector;
    SpinEdit5: TAdvChartSpinEdit;
    Label13: TLabel;
    ComboBox4: TComboBox;
    Label12: TLabel;
    GroupBox3: TGroupBox;
    SpinEdit12: TAdvChartSpinEdit;
    Label35: TLabel;
    Label34: TLabel;
    Label36: TLabel;
    SpinEdit13: TAdvChartSpinEdit;
    SpinEdit14: TAdvChartSpinEdit;
    Label37: TLabel;
    SpinEdit11: TAdvChartSpinEdit;
    GroupBox4: TGroupBox;
    CheckBox7: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox3: TCheckBox;
    GroupBox5: TGroupBox;
    AdvColorSelector5: TAdvChartColorSelector;
    Label16: TLabel;
    Label17: TLabel;
    AdvColorSelector6: TAdvChartColorSelector;
    Label20: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    CheckBox2: TCheckBox;
    Panel2: TPanel;
    Image1: TImage;
    Label10: TLabel;
    ComboBox2: TComboBox;
    Button13: TButton;
    GroupBox6: TGroupBox;
    CheckBox1: TCheckBox;
    Label8: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    AdvColorSelector4: TAdvChartColorSelector;
    AdvColorSelector2: TAdvChartColorSelector;
    Label4: TLabel;
    AdvColorSelector1: TAdvChartColorSelector;
    Label2: TLabel;
    ComboBox3: TComboBox;
    Label22: TLabel;
    SpinEdit2: TAdvChartSpinEdit;
    Label3: TLabel;
    SpinEdit1: TAdvChartSpinEdit;
    Label1: TLabel;
    GroupBox7: TGroupBox;
    ComboBox6: TComboBox;
    Label30: TLabel;
    Label29: TLabel;
    CheckBox9: TCheckBox;
    Label27: TLabel;
    SpinEdit8: TAdvChartSpinEdit;
    AdvColorSelector8: TAdvChartColorSelector;
    Label26: TLabel;
    Label25: TLabel;
    SpinEdit7: TAdvChartSpinEdit;
    Label28: TLabel;
    GroupBox8: TGroupBox;
    CheckBox11: TCheckBox;
    CheckBox10: TCheckBox;
    TabSheet4: TTabSheet;
    GroupBox9: TGroupBox;
    Label23: TLabel;
    Label33: TLabel;
    Label40: TLabel;
    FontDialog1: TFontDialog;
    CheckBox15: TCheckBox;
    AdvColorSelector9: TAdvChartColorSelector;
    SpinEdit16: TAdvChartSpinEdit;
    Label46: TLabel;
    Label43: TLabel;
    Label45: TLabel;
    Label44: TLabel;
    Button8: TButton;
    SpinEdit17: TAdvChartSpinEdit;
    SpinEdit18: TAdvChartSpinEdit;
    SpinEdit19: TAdvChartSpinEdit;
    SpinEdit20: TAdvChartSpinEdit;
    Panel3: TPanel;
    Button3: TButton;
    Button4: TButton;
    TabSheet5: TTabSheet;
    GroupBox11: TGroupBox;
    PaintBox2: TPaintBox;
    GroupBox12: TGroupBox;
    AdvColorSelector12: TAdvChartColorSelector;
    AdvColorSelector13: TAdvChartColorSelector;
    Label48: TLabel;
    Label50: TLabel;
    SpinEdit22: TAdvChartSpinEdit;
    ComboBox8: TComboBox;
    Label51: TLabel;
    Label49: TLabel;
    GroupBox13: TGroupBox;
    GroupBox14: TGroupBox;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    AdvColorSelector14: TAdvChartColorSelector;
    AdvColorSelector15: TAdvChartColorSelector;
    AdvColorSelector16: TAdvChartColorSelector;
    AdvColorSelector17: TAdvChartColorSelector;
    Label58: TLabel;
    AdvColorSelector18: TAdvChartColorSelector;
    Label59: TLabel;
    AdvColorSelector19: TAdvChartColorSelector;
    Label60: TLabel;
    Panel4: TPanel;
    Image2: TImage;
    Panel5: TPanel;
    Image3: TImage;
    Panel6: TPanel;
    Image4: TImage;
    Panel7: TPanel;
    Image5: TImage;
    Label61: TLabel;
    Panel8: TPanel;
    Image6: TImage;
    Label62: TLabel;
    Panel9: TPanel;
    Image7: TImage;
    Label63: TLabel;
    CheckBox17: TCheckBox;
    Label64: TLabel;
    SpinEdit23: TAdvChartSpinEdit;
    Label65: TLabel;
    SpinEdit24: TAdvChartSpinEdit;
    CheckBox18: TCheckBox;
    TabSheet8: TTabSheet;
    GroupBox15: TGroupBox;
    Label66: TLabel;
    AdvColorSelector20: TAdvChartColorSelector;
    AdvColorSelector21: TAdvChartColorSelector;
    Label67: TLabel;
    Label68: TLabel;
    SpinEdit25: TAdvChartSpinEdit;
    ComboBox9: TComboBox;
    Label69: TLabel;
    CheckBox19: TCheckBox;
    Label70: TLabel;
    AdvColorSelector22: TAdvChartColorSelector;
    SpinEdit26: TAdvChartSpinEdit;
    Label71: TLabel;
    SpinEdit27: TAdvChartSpinEdit;
    Label72: TLabel;
    TabSheet9: TTabSheet;
    GroupBox16: TGroupBox;
    Label73: TLabel;
    ComboBox10: TComboBox;
    Label74: TLabel;
    AdvColorSelector23: TAdvChartColorSelector;
    Button6: TButton;
    Label75: TLabel;
    Label77: TLabel;
    SpinEdit28: TAdvChartSpinEdit;
    Edit2: TEdit;
    Label78: TLabel;
    TabSheet10: TTabSheet;
    TabSheet11: TTabSheet;
    TabSheet12: TTabSheet;
    TabSheet13: TTabSheet;
    GroupBox17: TGroupBox;
    Label79: TLabel;
    ComboBox12: TComboBox;
    AdvColorSelector24: TAdvChartColorSelector;
    Label80: TLabel;
    AdvColorSelector25: TAdvChartColorSelector;
    Label81: TLabel;
    Label82: TLabel;
    Button7: TButton;
    Label83: TLabel;
    SpinEdit29: TAdvChartSpinEdit;
    ComboBox13: TComboBox;
    Label84: TLabel;
    CheckBox20: TCheckBox;
    Label85: TLabel;
    AdvColorSelector26: TAdvChartColorSelector;
    SpinEdit30: TAdvChartSpinEdit;
    Label86: TLabel;
    Edit3: TEdit;
    Label89: TLabel;
    ComboBox15: TComboBox;
    Label90: TLabel;
    GroupBox18: TGroupBox;
    Label91: TLabel;
    Label92: TLabel;
    Label93: TLabel;
    Label94: TLabel;
    Label95: TLabel;
    Label96: TLabel;
    Label97: TLabel;
    Label98: TLabel;
    Label101: TLabel;
    ComboBox16: TComboBox;
    AdvColorSelector27: TAdvChartColorSelector;
    AdvColorSelector28: TAdvChartColorSelector;
    Button9: TButton;
    SpinEdit32: TAdvChartSpinEdit;
    ComboBox17: TComboBox;
    CheckBox21: TCheckBox;
    AdvColorSelector29: TAdvChartColorSelector;
    SpinEdit33: TAdvChartSpinEdit;
    Edit4: TEdit;
    CheckBox22: TCheckBox;
    GroupBox19: TGroupBox;
    Label102: TLabel;
    SpinEdit35: TAdvChartSpinEdit;
    AdvColorSelector30: TAdvChartColorSelector;
    Label104: TLabel;
    Label103: TLabel;
    AdvPenStyleSelector1: TAdvChartPenStyleSelector;
    AdvPenStyleSelector2: TAdvChartPenStyleSelector;
    Label105: TLabel;
    Label106: TLabel;
    AdvColorSelector31: TAdvChartColorSelector;
    SpinEdit36: TAdvChartSpinEdit;
    Label107: TLabel;
    Label108: TLabel;
    SpinEdit37: TAdvChartSpinEdit;
    Label109: TLabel;
    SpinEdit38: TAdvChartSpinEdit;
    Button1: TButton;
    Label110: TLabel;
    Label111: TLabel;
    Button2: TButton;
    CheckBox23: TCheckBox;
    CheckBox24: TCheckBox;
    GroupBox20: TGroupBox;
    Label112: TLabel;
    Label113: TLabel;
    Label114: TLabel;
    Label115: TLabel;
    Label116: TLabel;
    Label117: TLabel;
    Label118: TLabel;
    Label119: TLabel;
    AdvColorSelector32: TAdvChartColorSelector;
    AdvPenStyleSelector3: TAdvChartPenStyleSelector;
    AdvPenStyleSelector4: TAdvChartPenStyleSelector;
    AdvColorSelector33: TAdvChartColorSelector;
    SpinEdit41: TAdvChartSpinEdit;
    SpinEdit42: TAdvChartSpinEdit;
    CheckBox25: TCheckBox;
    CheckBox26: TCheckBox;
    CheckBox27: TCheckBox;
    Label120: TLabel;
    AdvColorSelector34: TAdvChartColorSelector;
    Label121: TLabel;
    CheckBox28: TCheckBox;
    AdvSpinEdit1: TAdvChartSpinEdit;
    AdvSpinEdit2: TAdvChartSpinEdit;
    Panel10: TPanel;
    SpeedButton4: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    Button5: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button14: TButton;
    Button15: TButton;
    Label5: TLabel;
    AdvColorSelector3: TAdvChartColorSelector;
    ComboBox19: TComboBox;
    GroupBox21: TGroupBox;
    PaintBox3: TPaintBox;
    ComboBox5: TComboBox;
    Label18: TLabel;
    Label24: TLabel;
    CheckBox8: TCheckBox;
    SpinEdit6: TAdvChartSpinEdit;
    Label15: TLabel;
    GroupBox22: TGroupBox;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    CheckBox14: TCheckBox;
    Label47: TLabel;
    SpinEdit21: TAdvChartSpinEdit;
    CheckBox16: TCheckBox;
    ComboBox11: TComboBox;
    Label19: TLabel;
    ComboBox14: TComboBox;
    SpinEdit31: TAdvChartSpinEdit;
    Label88: TLabel;
    Label87: TLabel;
    ComboBox18: TComboBox;
    Label99: TLabel;
    Label100: TLabel;
    SpinEdit34: TAdvChartSpinEdit;
    ComboBox20: TComboBox;
    Label76: TLabel;
    AdvChartColorSelector1: TAdvChartColorSelector;
    Label122: TLabel;
    SpinEdit3: TAdvChartSpinEdit;
    ComboBox21: TComboBox;
    Label123: TLabel;
    Label124: TLabel;
    SpinEdit39: TAdvChartSpinEdit;
    AdvChartColorSelector2: TAdvChartColorSelector;
    Label125: TLabel;
    Label126: TLabel;
    SpinEdit40: TAdvChartSpinEdit;
    Button16: TButton;
    Panel11: TPanel;
    Image8: TImage;
    Label127: TLabel;
    Label128: TLabel;
    ComboBox22: TComboBox;
    ComboBox23: TComboBox;
    Label129: TLabel;
    ComboBox1: TComboBox;
    Label21: TLabel;
    ComboBox24: TComboBox;
    GroupBox23: TGroupBox;
    AdvChartFillPreview1: TAdvChartFillPreview;
    AdvChartSpinEdit1: TAdvChartSpinEdit;
    Label130: TLabel;
    Label38: TLabel;
    AdvChartColorSelector3: TAdvChartColorSelector;
    AdvChartColorSelector4: TAdvChartColorSelector;
    Label39: TLabel;
    Label41: TLabel;
    ComboBox7: TComboBox;
    ComboBox25: TComboBox;
    Label42: TLabel;
    Label131: TLabel;
    AdvChartSpinEdit2: TAdvChartSpinEdit;
    Label133: TLabel;
    Label134: TLabel;
    AdvChartSpinEdit3: TAdvChartSpinEdit;
    AdvChartSpinEdit4: TAdvChartSpinEdit;
    CheckBox29: TCheckBox;
    GroupBox10: TGroupBox;
    CheckBox30: TCheckBox;
    TabSheet6: TTabSheet;
    GroupBox24: TGroupBox;
    Label135: TLabel;
    CheckBox31: TCheckBox;
    ColorDialog1: TColorDialog;
    Label136: TLabel;
    ComboBox26: TComboBox;
    Label137: TLabel;
    AdvChartSpinEdit5: TAdvChartSpinEdit;
    AdvChartSpinEdit6: TAdvChartSpinEdit;
    ComboBox27: TComboBox;
    Label138: TLabel;
    Label139: TLabel;
    Label140: TLabel;
    Label141: TLabel;
    Label142: TLabel;
    Label143: TLabel;
    Label144: TLabel;
    Label145: TLabel;
    Label146: TLabel;
    Label147: TLabel;
    AdvChartSpinEdit7: TAdvChartSpinEdit;
    AdvChartSpinEdit8: TAdvChartSpinEdit;
    DTB: TTabSheet;
    GroupBox35: TGroupBox;
    Label149: TLabel;
    ComboBox28: TComboBox;
    TabSheet14: TTabSheet;
    GroupBox25: TGroupBox;
    GroupBox26: TGroupBox;
    CheckBox32: TCheckBox;
    ComboBox29: TComboBox;
    Label148: TLabel;
    Label150: TLabel;
    Label151: TLabel;
    AdvChartSpinEdit9: TAdvChartSpinEdit;
    AdvChartSpinEdit10: TAdvChartSpinEdit;
    AdvChartSpinEdit11: TAdvChartSpinEdit;
    Label152: TLabel;
    Label153: TLabel;
    AdvChartSpinEdit12: TAdvChartSpinEdit;
    Label154: TLabel;
    CheckBox33: TCheckBox;
    Label155: TLabel;
    AdvChartSpinEdit13: TAdvChartSpinEdit;
    AdvChartSpinEdit14: TAdvChartSpinEdit;
    Label156: TLabel;
    Label157: TLabel;
    AdvChartSpinEdit15: TAdvChartSpinEdit;
    AdvChartSpinEdit16: TAdvChartSpinEdit;
    Label158: TLabel;
    AdvChartColorSelector5: TAdvChartColorSelector;
    AdvChartColorSelector6: TAdvChartColorSelector;
    Label159: TLabel;
    AdvChartColorSelector7: TAdvChartColorSelector;
    Label160: TLabel;
    Label161: TLabel;
    Label162: TLabel;
    Label163: TLabel;
    AdvChartSpinEdit17: TAdvChartSpinEdit;
    AdvChartSpinEdit18: TAdvChartSpinEdit;
    AdvChartSpinEdit19: TAdvChartSpinEdit;
    Label164: TLabel;
    Label165: TLabel;
    AdvChartColorSelector8: TAdvChartColorSelector;
    AdvChartSpinEdit20: TAdvChartSpinEdit;
    ComboBox30: TComboBox;
    Label166: TLabel;
    ComboBox31: TComboBox;
    Label167: TLabel;
    Panel12: TPanel;
    Image9: TImage;
    Button17: TButton;
    Label168: TLabel;
    Button18: TButton;
    Label169: TLabel;
    Panel13: TPanel;
    Image10: TImage;
    AdvChartSpinEdit21: TAdvChartSpinEdit;
    Label170: TLabel;
    Button19: TButton;
    CheckBox34: TCheckBox;
    Label171: TLabel;
    Label132: TLabel;
    AdvChartSpinEdit24: TAdvChartSpinEdit;
    CheckBox35: TCheckBox;
    Label172: TLabel;
    Label173: TLabel;
    CheckBox36: TCheckBox;
    Label174: TLabel;
    Label175: TLabel;
    Label176: TLabel;
    CheckBox37: TCheckBox;
    CheckBox38: TCheckBox;
    AdvChartSpinEdit22: TAdvChartSpinEdit;
    CheckBox39: TCheckBox;
    CheckBox40: TCheckBox;
    ComboBox32: TComboBox;
    Label177: TLabel;
    GroupBox27: TGroupBox;
    CheckBox41: TCheckBox;
    Label178: TLabel;
    Label179: TLabel;
    procedure ListBox1Click(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure AdvColorSelector1Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvColorSelector2Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvColorSelector3Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvColorSelector4Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure CheckBox1Click(Sender: TObject);
    procedure AdvColorSelector5Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvColorSelector6Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure Image1Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
    procedure SpinEdit6Change(Sender: TObject);
    procedure ComboBox5Change(Sender: TObject);
    procedure ComboBox4Change(Sender: TObject);
    procedure AdvColorSelector7Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure SpinEdit5Change(Sender: TObject);
    procedure CheckBox14Click(Sender: TObject);
    procedure CheckBox10Click(Sender: TObject);
    procedure CheckBox11Click(Sender: TObject);
    procedure CheckBox12Click(Sender: TObject);
    procedure CheckBox13Click(Sender: TObject);
    procedure CheckBox9Click(Sender: TObject);
    procedure SpinEdit7Change(Sender: TObject);
    procedure AdvColorSelector8Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure SpinEdit8Change(Sender: TObject);
    procedure ComboBox6Change(Sender: TObject);
    procedure SpinEdit9Change(Sender: TObject);
    procedure SpinEdit10Change(Sender: TObject);
    procedure SpinEdit11Change(Sender: TObject);
    procedure SpinEdit12Change(Sender: TObject);
    procedure SpinEdit13Change(Sender: TObject);
    procedure SpinEdit14Change(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure AdvColorSelector9Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure SpinEdit16Change(Sender: TObject);
    procedure ComboBox7Change(Sender: TObject);
    procedure CheckBox15Click(Sender: TObject);
    procedure SpinEdit17Change(Sender: TObject);
    procedure SpinEdit18Change(Sender: TObject);
    procedure SpinEdit19Change(Sender: TObject);
    procedure SpinEdit20Change(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure CheckBox16Click(Sender: TObject);
    procedure SpinEdit21Change(Sender: TObject);
    procedure AdvColorSelector12Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvColorSelector13Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure SpinEdit22Change(Sender: TObject);
    procedure ComboBox8Change(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure AdvColorSelector14Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvColorSelector15Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvColorSelector16Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvColorSelector19Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvColorSelector18Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvColorSelector17Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure SpinEdit24Change(Sender: TObject);
    procedure CheckBox17Click(Sender: TObject);
    procedure SpinEdit23Change(Sender: TObject);
    procedure CheckBox18Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure AdvColorSelector20Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvColorSelector21Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure SpinEdit25Change(Sender: TObject);
    procedure ComboBox9Change(Sender: TObject);
    procedure AdvColorSelector22Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure SpinEdit26Change(Sender: TObject);
    procedure SpinEdit27Change(Sender: TObject);
    procedure CheckBox19Click(Sender: TObject);
    procedure ComboBox10Change(Sender: TObject);
    procedure AdvColorSelector23Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure Button6Click(Sender: TObject);
    procedure ComboBox11Change(Sender: TObject);
    procedure SpinEdit28Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure ComboBox12Change(Sender: TObject);
    procedure AdvColorSelector24Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvColorSelector25Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure SpinEdit29Change(Sender: TObject);
    procedure ComboBox13Change(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure CheckBox20Click(Sender: TObject);
    procedure AdvColorSelector26Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure SpinEdit30Change(Sender: TObject);
    procedure ComboBox14Change(Sender: TObject);
    procedure SpinEdit31Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure ComboBox15Change(Sender: TObject);
    procedure CheckBox22Click(Sender: TObject);
    procedure ComboBox16Change(Sender: TObject);
    procedure AdvColorSelector27Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvColorSelector28Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure SpinEdit32Change(Sender: TObject);
    procedure ComboBox17Change(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure CheckBox21Click(Sender: TObject);
    procedure AdvColorSelector29Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure SpinEdit33Change(Sender: TObject);
    procedure ComboBox18Change(Sender: TObject);
    procedure SpinEdit34Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpinEdit35Change(Sender: TObject);
    procedure AdvColorSelector30Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvPenStyleSelector1Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure SpinEdit37Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure SpinEdit36Change(Sender: TObject);
    procedure AdvColorSelector31Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvPenStyleSelector2Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure SpinEdit38Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox24Click(Sender: TObject);
    procedure CheckBox23Click(Sender: TObject);
    procedure CheckBox27Click(Sender: TObject);
    procedure AdvColorSelector34Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvSpinEdit1Change(Sender: TObject);
    procedure AdvColorSelector32Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvPenStyleSelector3Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure SpinEdit41Change(Sender: TObject);
    procedure AdvSpinEdit2Change(Sender: TObject);
    procedure AdvColorSelector33Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvPenStyleSelector4Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure SpinEdit42Change(Sender: TObject);
    procedure CheckBox26Click(Sender: TObject);
    procedure CheckBox25Click(Sender: TObject);
    procedure CheckBox28Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure ComboBox19Change(Sender: TObject);
    procedure ComboBox20Change(Sender: TObject);
    procedure AdvChartColorSelector2Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure SpinEdit39Change(Sender: TObject);
    procedure AdvChartColorSelector1Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure SpinEdit3Change(Sender: TObject);
    procedure ComboBox21Change(Sender: TObject);
    procedure SpinEdit40Change(Sender: TObject);
    procedure Image8Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure ComboBox22Change(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure ListBox1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ListBox1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ComboBox23Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox24Change(Sender: TObject);
    procedure AdvChartSpinEdit1Change(Sender: TObject);
    procedure AdvChartColorSelector3Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvChartColorSelector4Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure ComboBox25Change(Sender: TObject);
    procedure AdvChartSpinEdit2Change(Sender: TObject);
    procedure CheckBox29Click(Sender: TObject);
    procedure AdvChartSpinEdit4Change(Sender: TObject);
    procedure AdvChartSpinEdit3Change(Sender: TObject);
    procedure CheckBox30Click(Sender: TObject);
    procedure CheckBox31Click(Sender: TObject);
    procedure ComboBox26Change(Sender: TObject);
    procedure AdvChartSpinEdit5Change(Sender: TObject);
    procedure ComboBox27Change(Sender: TObject);
    procedure AdvChartSpinEdit6Change(Sender: TObject);
    procedure AdvChartSpinEdit8Change(Sender: TObject);
    procedure AdvChartSpinEdit7Change(Sender: TObject);
    procedure ComboBox28Change(Sender: TObject);
    procedure CheckBox32Click(Sender: TObject);
    procedure ComboBox29Change(Sender: TObject);
    procedure AdvChartSpinEdit9Change(Sender: TObject);
    procedure AdvChartSpinEdit10Change(Sender: TObject);
    procedure AdvChartSpinEdit11Change(Sender: TObject);
    procedure AdvChartSpinEdit12Change(Sender: TObject);
    procedure CheckBox33Click(Sender: TObject);
    procedure AdvChartSpinEdit14Change(Sender: TObject);
    procedure AdvChartSpinEdit13Change(Sender: TObject);
    procedure AdvChartSpinEdit15Change(Sender: TObject);
    procedure AdvChartSpinEdit16Change(Sender: TObject);
    procedure AdvChartColorSelector5Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvChartColorSelector6Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvChartColorSelector7Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvChartSpinEdit17Change(Sender: TObject);
    procedure AdvChartSpinEdit18Change(Sender: TObject);
    procedure AdvChartSpinEdit19Change(Sender: TObject);
    procedure AdvChartColorSelector8Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvChartSpinEdit20Change(Sender: TObject);
    procedure ComboBox30Change(Sender: TObject);
    procedure ComboBox31Change(Sender: TObject);
    procedure Image9Click(Sender: TObject);
    procedure Image10Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure AdvChartSpinEdit21Change(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure CheckBox34Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AdvChartSpinEdit24Change(Sender: TObject);
    procedure CheckBox35Click(Sender: TObject);
    procedure CheckBox36Click(Sender: TObject);
    procedure AdvChartSpinEdit22Change(Sender: TObject);
    procedure CheckBox38Click(Sender: TObject);
    procedure CheckBox37Click(Sender: TObject);
    procedure CheckBox39Click(Sender: TObject);
    procedure CheckBox40Click(Sender: TObject);
    procedure ComboBox32Change(Sender: TObject);
    procedure CheckBox41Click(Sender: TObject);
  private
    FAllowR: Boolean;
    { Private declarations }
    FChartPanes: TAdvGDIPChartPanes;
    FChartView: TAdvGDIPChartView;    
    col: TAdvGDIPChartPanes;
    Mode: TSaveMode;
    selpane: integer;   
    procedure StartSerieEditor;
    procedure CorrectTop(lbl: TLabel);
    procedure ApplyChanges(Sender: TObject);
  public
    { Public declarations }
    property ChartView: TAdvGDIPChartView read FChartview write FChartview;   
    property ChartPanes: TAdvGDIPChartPanes read FChartPanes write FChartPanes;
    procedure Init;
    procedure InitListBox;
    procedure UpdatePreviewNavigator;
    procedure UpdatePreviewBands;
    procedure UpdatePreviewBackGround;
    procedure SaveChanges;
  end;

  {$IFDEF DELPHIXE2_LVL}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  {$ENDIF}
  TAdvChartPanesEditorDialogGDIP = class(TCommonDialog)
  private
    FForm: TAdvChartPanesEditorFormGDIP;
    FChartView: TAdvGDIPChartView;
    FCaption: string;
    FAllowPaneRemoving: Boolean;
    FAllowSerieEditing: Boolean;
    FAllowNameChange: Boolean;
    FAllowPaneReorder: Boolean;
    FAllowPaneAdding: Boolean;
    procedure SetChartView(const Value: TAdvGDIPChartView);
  protected
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;  
  public
    constructor Create(AOwner: TComponent); override;  
    function Execute: Boolean; override;
    property Form: TAdvChartPanesEditorFormGDIP read FForm;
  published
    property Caption: string read FCaption write FCaption;
    property ChartView: TAdvGDIPChartview read FChartView write SetChartView;
    property AllowSerieEditing: Boolean read FAllowSerieEditing write FAllowSerieEditing default true;
    property AllowPaneNameChange: Boolean read FAllowNameChange write FAllowNameChange default true;
    property AllowPaneRemoving: Boolean read FAllowPaneRemoving write FAllowPaneRemoving default true;
    property AllowPaneAdding: Boolean read FAllowPaneAdding write FAllowPaneAdding default true;
    property AllowPaneReorder: Boolean read FAllowPaneReorder write FAllowPaneReorder default true;    
  end;

var
  AdvChartPanesEditorForm: TAdvChartPanesEditorFormGDIP;
  pn: TAdvGDIPChartPane;
  StartingPoint : TPoint;

implementation

{$R *.dfm}

uses
  Types
  {$IFDEF DELPHIXE2_LVL}
  ,UITypes
  {$ENDIF}
  ;

{ TAdvChartPaneEditorForm }

procedure DrawGradient(Canvas: TCanvas; FromColor, ToColor: TColor; Steps: Integer; R: TRect; Direction: TChartGradientDirection);
var
  diffr, startr, endr: Integer;
  diffg, startg, endg: Integer;
  diffb, startb, endb: Integer;
  rstepr, rstepg, rstepb, rstepw: Real;
  i, stepw: Word;
begin
  if Steps = 0 then
    Steps := 1;

  FromColor := ColorToRGB(FromColor);
  ToColor := ColorToRGB(ToColor);

  if R.Right < R.Left then
  begin
    startr := R.Right;
    R.Right := R.Left;
    R.Left := startr;
  end;

  if R.Top > R.Bottom then
  begin
    startr := r.Top;
    r.Top := r.Bottom;
    r.Bottom := startr;
  end;

  startr := (FromColor and $0000FF);
  startg := (FromColor and $00FF00) shr 8;
  startb := (FromColor and $FF0000) shr 16;
  endr := (ToColor and $0000FF);
  endg := (ToColor and $00FF00) shr 8;
  endb := (ToColor and $FF0000) shr 16;

  diffr := endr - startr;
  diffg := endg - startg;
  diffb := endb - startb;

  rstepr := diffr / steps;
  rstepg := diffg / steps;
  rstepb := diffb / steps;

  if Direction = cgdHorizontal then
    rstepw := (R.Right - R.Left) / Steps
  else
    rstepw := (R.Bottom - R.Top) / Steps;

  with Canvas do
  begin
    for i := 0 to steps - 1 do
    begin
      endr := startr + Round(rstepr * i);
      endg := startg + Round(rstepg * i);
      endb := startb + Round(rstepb * i);
      stepw := Round(i * rstepw);
      Pen.Color := endr + (endg shl 8) + (endb shl 16);
      Brush.Color := Pen.Color;

      if Direction = cgdHorizontal then
        Rectangle(R.Left + stepw, R.Top, R.Left + stepw + Round(rstepw) + 1, R.Bottom)
      else
        Rectangle(R.Left, R.Top + stepw, R.Right, R.Top + stepw + Round(rstepw) + 1);
    end;
  end;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvChartColorSelector1Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
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

  pn.Title.ColorTo := AdvChartColorSelector1.SelectedColor;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvChartColorSelector2Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
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

  pn.Title.BorderColor := AdvChartColorSelector2.SelectedColor;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvChartColorSelector3Select(
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

  pn.Legend.Color := AdvChartColorSelector3.SelectedColor;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvChartColorSelector4Select(
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

  pn.Legend.ColorTo := AdvChartColorSelector4.SelectedColor;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvChartColorSelector5Select(
  Sender: TObject; Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advchartcolorselector5.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := advchartcolorselector5.SelectedColor;
    if ColorDialog1.Execute then
    begin
      advchartcolorselector5.SelectedColor := ColorDialog1.Color;
    end;
  end;

  pn.ZoomControl.Color := advchartcolorselector5.SelectedColor;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvChartColorSelector6Select(
  Sender: TObject; Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advchartcolorselector6.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := advchartcolorselector6.SelectedColor;
    if ColorDialog1.Execute then
    begin
      advchartcolorselector6.SelectedColor := ColorDialog1.Color;
    end;
  end;

  pn.ZoomControl.BorderColor := advchartcolorselector6.SelectedColor;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvChartColorSelector7Select(
  Sender: TObject; Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advchartcolorselector7.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := advchartcolorselector7.SelectedColor;
    if ColorDialog1.Execute then
    begin
      advchartcolorselector7.SelectedColor := ColorDialog1.Color;
    end;
  end;

  pn.ZoomControl.SelectionColor := advchartcolorselector7.SelectedColor;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvChartColorSelector8Select(
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

  pn.ZoomControl.SliderColor := advchartcolorselector8.SelectedColor;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvChartSpinEdit10Change(
  Sender: TObject);
begin
  pn.ZoomControl.Top := AdvChartSpinEdit10.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvChartSpinEdit11Change(
  Sender: TObject);
begin
  pn.ZoomControl.Width := AdvChartSpinEdit11.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvChartSpinEdit12Change(
  Sender: TObject);
begin
  pn.ZoomControl.Height := AdvChartSpinEdit12.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvChartSpinEdit13Change(
  Sender: TObject);
begin
  pn.ZoomControl.SlideRangeTo := AdvChartSpinEdit13.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvChartSpinEdit14Change(
  Sender: TObject);
begin
  pn.ZoomControl.SlideRangeFrom := AdvChartSpinEdit14.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvChartSpinEdit15Change(
  Sender: TObject);
begin
  pn.ZoomControl.SlideMaximumRange := AdvChartSpinEdit15.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvChartSpinEdit16Change(
  Sender: TObject);
begin
  pn.ZoomControl.SlideMinimumRange := AdvChartSpinEdit16.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvChartSpinEdit17Change(
  Sender: TObject);
begin
  pn.ZoomControl.Opacity := AdvchartSpinEdit17.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvChartSpinEdit18Change(
  Sender: TObject);
begin
  pn.ZoomControl.BorderOpacity := AdvChartSpinEdit18.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvChartSpinEdit19Change(
  Sender: TObject);
begin
  pn.ZoomControl.SelectionOpacity := AdvChartSpinEdit19.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvChartSpinEdit1Change(Sender: TObject);
begin
  pn.Background.Angle := AdvChartSpinEdit1.Value;
  UpdatePreviewBackGround;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvChartSpinEdit20Change(
  Sender: TObject);
begin
  pn.ZoomControl.SliderOpacity := AdvChartSpinEdit20.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvChartSpinEdit21Change(
  Sender: TObject);
begin
  pn.ZoomControl.SliderSize := AdvChartSpinEdit21.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvChartSpinEdit22Change(
  Sender: TObject);
begin
  pn.YAxis.Offset3D := AdvChartSpinEdit22.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvChartSpinEdit24Change(
  Sender: TObject);
begin
  pn.Xaxis.Offset3D := AdvChartSpinEdit24.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvChartSpinEdit2Change(Sender: TObject);
begin
  pn.Legend.Angle := AdvChartSpinEdit2.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvChartSpinEdit3Change(Sender: TObject);
begin
  pn.Legend.OpacityTo := AdvChartSpinEdit3.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvChartSpinEdit4Change(Sender: TObject);
begin
  pn.Legend.Opacity := AdvChartSpinEdit4.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvChartSpinEdit5Change(Sender: TObject);
begin
  pn.Navigator.ScrollStep := AdvChartSpinEdit5.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvChartSpinEdit6Change(Sender: TObject);
begin
  pn.Series.BarChartSpacing := AdvChartSpinEdit6.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvChartSpinEdit7Change(Sender: TObject);
begin
  pn.Range.MinimumScrollRange := AdvChartSpinEdit7.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvChartSpinEdit8Change(Sender: TObject);
begin
  pn.Range.MaximumScrollRange := AdvChartSpinEdit8.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvChartSpinEdit9Change(Sender: TObject);
begin
  pn.ZoomControl.Left := AdvChartSpinEdit9.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvColorSelector12Select(Sender: TObject;
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

  pn.Navigator.Color := AdvcolorSelector12.SelectedColor;
  UpdatePreviewNavigator;  
end;

procedure TAdvChartPanesEditorFormGDIP.AdvColorSelector13Select(Sender: TObject;
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

  pn.Navigator.ColorTo := AdvColorSelector13.SelectedColor;
  UpdatePreviewNavigator;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvColorSelector14Select(Sender: TObject;
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

  pn.Navigator.ScrollButtonLeftColor := AdvColorSelector14.SelectedColor;
  UpdatePreviewNavigator;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvColorSelector15Select(Sender: TObject;
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

  pn.Navigator.ScrollButtonLeftHotColor := advColorSelector15.SelectedColor;
  UpdatePreviewNavigator;  
end;

procedure TAdvChartPanesEditorFormGDIP.AdvColorSelector16Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advcolorselector16.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvColorSelector16.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvColorSelector16.SelectedColor := ColorDialog1.Color;
    end;
  end;

  pn.Navigator.ScrollButtonLeftDownColor := AdvColorSelector16.SelectedColor;
  UpdatePreviewNavigator;  
end;

procedure TAdvChartPanesEditorFormGDIP.AdvColorSelector17Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advcolorselector17.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvColorSelector17.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvColorSelector17.SelectedColor := ColorDialog1.Color;
    end;
  end;

  pn.Navigator.ScrollButtonRightDownColor := AdvColorSelector17.SelectedColor;
  UpdatePreviewNavigator;  
end;

procedure TAdvChartPanesEditorFormGDIP.AdvColorSelector18Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advcolorselector18.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvColorSelector18.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvColorSelector18.SelectedColor := ColorDialog1.Color;
    end;
  end;

  pn.Navigator.ScrollButtonRightHotColor := AdvColorSelector18.SelectedColor;
  UpdatePreviewNavigator;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvColorSelector19Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advcolorselector19.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvColorSelector19.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvColorSelector19.SelectedColor := ColorDialog1.Color;
    end;
  end;

  pn.Navigator.ScrollButtonRightColor := AdvColorSelector19.SelectedColor;
  UpdatePreviewNavigator;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvColorSelector1Select(Sender: TObject;
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

  pn.Bands.PrimaryColor := AdvcolorSelector1.SelectedColor;
  UpdatePreviewBands;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvColorSelector20Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advcolorselector20.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvColorSelector20.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvColorSelector20.SelectedColor := ColorDialog1.Color;
    end;
  end;

  pn.Splitter.Color := AdvColorSelector20.SelectedColor;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvColorSelector21Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advcolorselector21.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvColorSelector21.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvColorSelector21.SelectedColor := ColorDialog1.Color;
    end;
  end;

  pn.Splitter.ColorTo := AdvColorSelector21.SelectedColor;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvColorSelector22Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advcolorselector22.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvColorSelector22.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvColorSelector22.SelectedColor := ColorDialog1.Color;
    end;
  end;

  pn.Splitter.LineColor := AdvColorSelector22.SelectedColor;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvColorSelector23Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advcolorselector23.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvColorSelector23.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvColorSelector23.SelectedColor := ColorDialog1.Color;
    end;
  end;

  pn.Title.Color := AdvColorSelector23.SelectedColor;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvColorSelector24Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advcolorselector24.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvColorSelector24.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvColorSelector24.SelectedColor := ColorDialog1.Color;
    end;
  end;

  pn.XAxis.Color := AdvColorSelector24.SelectedColor;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvColorSelector25Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advcolorselector25.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvColorSelector25.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvColorSelector25.SelectedColor := ColorDialog1.Color;
    end;
  end;

  pn.XAxis.ColorTo := AdvColorSelector25.SelectedColor;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvColorSelector26Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advcolorselector26.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvColorSelector26.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvColorSelector26.SelectedColor := ColorDialog1.Color;
    end;
  end;

  pn.XAxis.Linecolor := AdvColorSelector26.SelectedColor;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvColorSelector27Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advcolorselector27.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvColorSelector27.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvColorSelector27.SelectedColor := ColorDialog1.Color;
    end;
  end;

  pn.YAxis.Color := AdvColorSelector27.SelectedColor;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvColorSelector28Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advcolorselector28.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvColorSelector28.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvColorSelector28.SelectedColor := ColorDialog1.Color;
    end;
  end;

  pn.YAxis.ColorTo := AdvColorSelector28.SelectedColor;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvColorSelector29Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advcolorselector29.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvColorSelector29.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvColorSelector29.SelectedColor := ColorDialog1.Color;
    end;
  end;

  pn.YAxis.Linecolor := AdvColorSelector29.SelectedColor;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvColorSelector2Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advcolorselector2.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvColorSelector2.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvColorSelector2.SelectedColor := ColorDialog1.Color;
    end;
  end;

  pn.Bands.SecondaryColor := AdvColorSelector2.SelectedColor;
  UpdatePreviewBands;  
end;

procedure TAdvChartPanesEditorFormGDIP.AdvColorSelector30Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advcolorselector30.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvColorSelector30.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvColorSelector30.SelectedColor := ColorDialog1.Color;
    end;
  end;

  pn.XGrid.MinorLineColor := AdvColorSelector30.SelectedColor;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvColorSelector31Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advcolorselector31.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvColorSelector31.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvColorSelector31.SelectedColor := ColorDialog1.Color;
    end;
  end;

  pn.Xgrid.MajorLineColor := AdvColorSelector31.SelectedColor;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvColorSelector32Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advcolorselector32.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvColorSelector32.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvColorSelector32.SelectedColor := ColorDialog1.Color;
    end;
  end;

  pn.YGrid.MinorLineColor := AdvColorSelector32.SelectedColor;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvColorSelector33Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advcolorselector33.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvColorSelector33.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvColorSelector33.SelectedColor := ColorDialog1.Color;
    end;
  end;

  pn.YGrid.MajorLinecolor := AdvcolorSelector33.SelectedColor;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvColorSelector34Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advcolorselector34.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvColorSelector34.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvColorSelector34.SelectedColor := ColorDialog1.Color;
    end;
  end;

  pn.Ygrid.BorderColor := AdvColorSelector34.SelectedColor;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvColorSelector3Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advcolorselector3.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvColorSelector3.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvColorSelector3.SelectedColor := ColorDialog1.Color;
    end;
  end;

  pn.Bands.PrimaryColorTo := AdvColorSelector3.SelectedColor;
  UpdatePreviewBands;  
end;

procedure TAdvChartPanesEditorFormGDIP.AdvColorSelector4Select(Sender: TObject;
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

  pn.Bands.SecondaryColorTo := AdvColorSelector4.SelectedColor;
  UpdatePreviewBands;  
end;

procedure TAdvChartPanesEditorFormGDIP.AdvColorSelector5Select(Sender: TObject;
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

  pn.BackGround.Color := AdvColorSelector5.SelectedColor;

  UpdatePreviewBackGround;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvColorSelector6Select(Sender: TObject;
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

  pn.BackGround.ColorTo := AdvColorSelector6.SelectedColor;

  UpdatePreviewBackGround;  
end;

procedure TAdvChartPanesEditorFormGDIP.AdvColorSelector7Select(Sender: TObject;
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

  pn.BorderColor := AdvColorSelector7.SelectedColor;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvColorSelector8Select(Sender: TObject;
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

  pn.CrossHair.LineColor := AdvColorSelector8.SelectedColor;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvColorSelector9Select(Sender: TObject;
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

  pn.Legend.BorderColor := AdvColorSelector9.SelectedColor;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvPenStyleSelector1Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  pn.XGrid.MinorLineStyle := AdvPenStyleSelector1.SelectedPenStyle;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvPenStyleSelector2Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  pn.XGrid.MajorLineStyle := AdvPenStyleSelector2.SelectedPenStyle;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvPenStyleSelector3Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  pn.YGrid.MinorLineStyle := AdvPenStyleSelector3.SelectedPenStyle;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvPenStyleSelector4Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  pn.YGrid.MajorLineStyle := AdvPenStyleSelector4.SelectedPenStyle;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvSpinEdit1Change(Sender: TObject);
begin
  pn.YGrid.MinorDistance := AdvSpinEdit1.FloatValue;
end;

procedure TAdvChartPanesEditorFormGDIP.AdvSpinEdit2Change(Sender: TObject);
begin
  pn.Ygrid.MajorDistance := AdvSpinEdit2.FloatValue;
end;

procedure TAdvChartPanesEditorFormGDIP.ApplyChanges(Sender: TObject);
begin
  SaveChanges;
end;

procedure TAdvChartPanesEditorFormGDIP.Button10Click(Sender: TObject);
begin
  if not (Image3.Picture.Graphic = nil) then
  begin
    Image3.Picture := nil;
    pn.Navigator.ScrollButtonLeftHot := nil;
  end;
end;

procedure TAdvChartPanesEditorFormGDIP.Button11Click(Sender: TObject);
begin
  if not (Image4.Picture.Graphic = nil) then
  begin
    Image4.Picture := nil;
    pn.Navigator.ScrollButtonLeftDown := nil;
  end;
end;

procedure TAdvChartPanesEditorFormGDIP.Button12Click(Sender: TObject);
begin
  if not (Image5.Picture.Graphic = nil) then
  begin
    Image5.Picture := nil;
    pn.Navigator.ScrollButtonRightDown := nil;
  end;
end;

procedure TAdvChartPanesEditorFormGDIP.Button13Click(Sender: TObject);
begin
  if not (Image1.Picture.Graphic = nil) then
  begin
    Image1.Picture := nil;
    pn.BackGround.Picture := nil;
    UpdatePreviewBackGround;
  end;
end;

procedure TAdvChartPanesEditorFormGDIP.Button14Click(Sender: TObject);
begin
  if not (Image6.Picture.Graphic = nil) then
  begin
    Image6.Picture := nil;
    pn.Navigator.ScrollButtonRightHot := nil;
  end;
end;

procedure TAdvChartPanesEditorFormGDIP.Button15Click(Sender: TObject);
begin
  if not (Image7.Picture.Graphic = nil) then
  begin
    Image7.Picture := nil;
    pn.Navigator.ScrollButtonRight := nil;
  end;
end;

procedure TAdvChartPanesEditorFormGDIP.Button16Click(Sender: TObject);
begin
  if not (Image8.Picture.Graphic = nil) then
  begin
    Image8.Picture := nil;
    pn.Legend.Picture := nil;
  end;
end;

procedure TAdvChartPanesEditorFormGDIP.Button17Click(Sender: TObject);
begin
  if not (Image9.Picture.Graphic = nil) then
  begin
    Image9.Picture := nil;
    pn.ZoomControl.SliderLeftPicture := nil;
  end;
end;

procedure TAdvChartPanesEditorFormGDIP.Button18Click(Sender: TObject);
begin
  if not (Image10.Picture.Graphic = nil) then
  begin
    Image10.Picture := nil;
    pn.ZoomControl.SliderRightPicture := nil;
  end;
end;

procedure TAdvChartPanesEditorFormGDIP.Button19Click(Sender: TObject);
begin
  SaveChanges;
end;

procedure TAdvChartPanesEditorFormGDIP.Button1Click(Sender: TObject);
begin
  FontDialog1.Font.Assign(pn.XGrid.Majorfont);
  if FontDialog1.Execute then
  begin
    pn.XGrid.Majorfont.Assign(FontDialog1.Font);
    Label145.font.assign(pn.Xgrid.Majorfont);
    CorrectTop(label145);
  end;
end;

procedure TAdvChartPanesEditorFormGDIP.Button2Click(Sender: TObject);
begin
  FontDialog1.Font.Assign(pn.XGrid.MinorFont);
  if FontDialog1.Execute then
  begin
    pn.XGrid.MinorFont.Assign(FontDialog1.Font);
    Label144.font.assign(pn.Xgrid.minorfont);
    CorrectTop(label144);
  end;
end;

procedure TAdvChartPanesEditorFormGDIP.Button3Click(Sender: TObject);
begin
  Mode := cancel;
  Self.Close;
  ModalResult := mrCancel;
end;

procedure TAdvChartPanesEditorFormGDIP.Button4Click(Sender: TObject);
begin
  SaveChanges;
  Mode := saving;
  Self.Close;
  ModalResult := mrOk;
end;

procedure TAdvChartPanesEditorFormGDIP.Button5Click(Sender: TObject);
begin
  if not (Image2.Picture.Graphic = nil) then
  begin
    Image2.Picture := nil;
    pn.Navigator.ScrollButtonLeft := nil;
  end;
end;

procedure TAdvChartPanesEditorFormGDIP.Button6Click(Sender: TObject);
begin
  FontDialog1.Font.Assign(pn.Title.Font);
  if FontDialog1.Execute then
  begin
    pn.Title.Font.Assign(FontDialog1.Font);
    Label141.Font.Assign(pn.title.Font);
    CorrectTop(label141);
  end;
end;

procedure TAdvChartPanesEditorFormGDIP.Button7Click(Sender: TObject);
begin
  FontDialog1.Font.Assign(pn.XAxis.Font);
  if FontDialog1.Execute then
  begin
    pn.XAxis.Font.Assign(FontDialog1.Font);
    Label142.Font.Assign(pn.XAxis.Font);
    CorrectTop(label142);
  end;
end;

procedure TAdvChartPanesEditorFormGDIP.Button8Click(Sender: TObject);
begin
  FontDialog1.Font.Assign(pn.Legend.Font);
  if FontDialog1.Execute then
  begin
    pn.Legend.Font.Assign(FontDialog1.Font);
    Label140.font.assign(pn.legend.font);
    CorrectTop(label140);
  end;
end;

procedure TAdvChartPanesEditorFormGDIP.Button9Click(Sender: TObject);
begin
  FontDialog1.Font.Assign(pn.YAxis.Font);
  if FontDialog1.Execute then
  begin
    pn.YAxis.Font.Assign(FontDialog1.Font);
    Label143.Font.Assign(pn.Yaxis.Font);
    CorrectTop(label143);
  end;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox10Click(Sender: TObject);
begin
  pn.CrossHair.CrossHairYValues.ShowSerieValues := CheckBox10.Checked;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox11Click(Sender: TObject);
begin
   pn.CrossHair.CrossHairYValues.ShowYPosValue := CheckBox11.Checked;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox12Click(Sender: TObject);
begin
  case CheckBox12.Checked of
    true: pn.CrossHair.CrossHairYValues.Position := pn.CrossHair.CrossHairYValues.Position + [chYAxis];
    false: pn.CrossHair.CrossHairYValues.Position := pn.CrossHair.CrossHairYValues.Position - [chYAxis];
  end;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox13Click(Sender: TObject);
begin
  case CheckBox13.Checked of
    true: pn.CrossHair.CrossHairYValues.Position := pn.CrossHair.CrossHairYValues.Position + [chValueTracker];
    false: pn.CrossHair.CrossHairYValues.Position := pn.CrossHair.CrossHairYValues.Position - [chValueTracker];
  end;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox14Click(Sender: TObject);
begin
  case CheckBox14.Checked of
    true: pn.CrossHair.CrossHairYValues.Position := pn.CrossHair.CrossHairYValues.Position + [chAtCursor];
    false: pn.CrossHair.CrossHairYValues.Position := pn.CrossHair.CrossHairYValues.Position - [chAtCursor];
  end;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox15Click(Sender: TObject);
begin
  pn.Legend.Visible := CheckBox15.Checked;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox16Click(Sender: TObject);
begin
  pn.Navigator.AlphaBlend := CheckBox16.Checked;
  UpdatePreviewNavigator;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox17Click(Sender: TObject);
begin
  pn.Navigator.ScrollButtons := CheckBox17.Checked;
  UpdatePreviewNavigator;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox18Click(Sender: TObject);
begin
  pn.Navigator.Visible := CheckBox18.Checked;
  UpdatePreviewNavigator;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox19Click(Sender: TObject);
begin
  pn.Splitter.Visible := CheckBox19.Checked;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox1Click(Sender: TObject);
begin
  pn.Bands.Visible := CheckBox1.Checked;
  UpdatePreviewBands;  
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox20Click(Sender: TObject);
begin
  pn.XAxis.Line := CheckBox20.Checked;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox21Click(Sender: TObject);
begin
  pn.YAxis.Line := CheckBox21.Checked;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox22Click(Sender: TObject);
begin
  pn.YAxis.AutoUnits := CheckBox22.Checked;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox23Click(Sender: TObject);
begin
  pn.XGrid.Visible := CheckBox23.Checked;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox24Click(Sender: TObject);
begin
  pn.Xgrid.OnTop := CheckBox24.Checked;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox25Click(Sender: TObject);
begin
  pn.YGrid.Visible := CheckBox25.Checked;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox26Click(Sender: TObject);
begin
  pn.YGrid.OnTop := CheckBox26.Checked;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox27Click(Sender: TObject);
begin
  pn.YGrid.AutoUnits :=  CheckBox27.checked;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox28Click(Sender: TObject);
begin
  pn.YGrid.ShowBorder := CheckBox28.Checked;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox29Click(Sender: TObject);
begin
  pn.Legend.Shadow := CheckBox29.Checked;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox2Click(Sender: TObject);
begin
  pn.BackGround.PictureVisible := CheckBox2.Checked;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox30Click(Sender: TObject);
begin
  pn.Chart.Mirror := CheckBox30.Checked;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox31Click(Sender: TObject);
begin
  pn.Chart.Series.SerieValueTotals := CheckBox31.Checked;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox32Click(Sender: TObject);
begin
  pn.ZoomControl.Visible := CheckBox32.Checked;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox33Click(Sender: TObject);
begin
  pn.ZoomControl.SlideAutoRange := CheckBox33.Checked;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox34Click(Sender: TObject);
begin
  if CheckBox34.Checked then
    pn.Series.ChartMode := dmHorizontal
  else
    pn.Series.ChartMode := dmVertical;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox35Click(Sender: TObject);
begin
  pn.XAxis.Enable3D := CheckBox35.Checked;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox36Click(Sender: TObject);
begin
  pn.XAxis.Darken3D := CheckBox36.Checked;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox37Click(Sender: TObject);
begin
  pn.YAxis.Darken3D :=  CheckBox37.Checked;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox38Click(Sender: TObject);
begin
  pn.YAxis.Enable3D := CheckBox38.Checked;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox39Click(Sender: TObject);
begin
  pn.YAxis.AutoSize := CheckBox39.Checked;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox3Click(Sender: TObject);
begin
  case CheckBox3.Checked of
    true:  pn.Options := pn.Options + [poMoving];
    false:  pn.Options := pn.Options - [poMoving];
  end;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox40Click(Sender: TObject);
begin
  pn.XAxis.AutoSize := CheckBox40.Checked;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox41Click(Sender: TObject);
begin
  pn.Chart.XScaleOffset := CheckBox41.Checked;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox4Click(Sender: TObject);
begin
  case CheckBox4.Checked of
    true:  pn.Options := pn.Options + [poHorzScroll];
    false:  pn.Options := pn.Options - [poHorzScroll];
  end;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox5Click(Sender: TObject);
begin
  case CheckBox5.Checked of
    true:  pn.Options := pn.Options + [poVertScroll];
    false:  pn.Options := pn.Options - [poVertScroll];
  end;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox6Click(Sender: TObject);
begin
  case CheckBox6.Checked of
    true:  pn.Options := pn.Options + [poHorzScale];
    false:  pn.Options := pn.Options - [poHorzScale];
  end;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox7Click(Sender: TObject);
begin
  case CheckBox7.Checked of
    true:  pn.Options := pn.Options + [poVertScale];
    false:  pn.Options := pn.Options - [poVertScale];
  end;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox8Click(Sender: TObject);
begin
  pn.Visible := CheckBox8.Checked;
end;

procedure TAdvChartPanesEditorFormGDIP.CheckBox9Click(Sender: TObject);
begin
  pn.CrossHair.Visible := CheckBox9.Checked;
end;

procedure TAdvChartPanesEditorFormGDIP.ComboBox10Change(Sender: TObject);
begin
  pn.Title.Alignment := TAlignment(ComboBox10.ItemIndex);
end;

procedure TAdvChartPanesEditorFormGDIP.ComboBox11Change(Sender: TObject);
begin
  pn.Title.Position := TTitlePosition(ComboBox11.ItemIndex);
end;

procedure TAdvChartPanesEditorFormGDIP.ComboBox12Change(Sender: TObject);
begin
  pn.XAxis.Alignment := TAlignment(ComboBox12.ItemIndex);
end;

procedure TAdvChartPanesEditorFormGDIP.ComboBox13Change(Sender: TObject);
begin
  pn.XAxis.GradientDirection := TChartGradientDirection(ComboBox13.ItemIndex);
end;

procedure TAdvChartPanesEditorFormGDIP.ComboBox14Change(Sender: TObject);
begin
  pn.XAxis.Position := TChartXAxisPosition(ComboBox14.ItemIndex);
end;

procedure TAdvChartPanesEditorFormGDIP.ComboBox15Change(Sender: TObject);
begin
  pn.XAxis.UnitType := TChartUnitType(ComboBox15.ItemIndex);
end;

procedure TAdvChartPanesEditorFormGDIP.ComboBox16Change(Sender: TObject);
begin
  pn.YAxis.Alignment := TAlignment(ComboBox16.ItemIndex);
end;

procedure TAdvChartPanesEditorFormGDIP.ComboBox17Change(Sender: TObject);
begin
  pn.YAxis.GradientDirection := TChartGradientDirection(ComboBox17.ItemIndex);
end;

procedure TAdvChartPanesEditorFormGDIP.ComboBox18Change(Sender: TObject);
begin
  pn.YAxis.Position := TChartYAxisPosition(ComboBox18.ItemIndex);
end;

procedure TAdvChartPanesEditorFormGDIP.ComboBox19Change(Sender: TObject);
begin
  pn.Bands.SerieIndex := ComboBox19.ItemIndex;
  UpdatePreviewBands;  
end;

procedure TAdvChartPanesEditorFormGDIP.ComboBox1Change(Sender: TObject);
begin
  pn.Background.GradientType := TChartGradientType(ComboBox1.ItemIndex);
  UpdatePreviewBackGround;  
end;

procedure TAdvChartPanesEditorFormGDIP.ComboBox20Change(Sender: TObject);
begin
  pn.YGrid.SerieIndex := ComboBox20.ItemIndex;
end;

procedure TAdvChartPanesEditorFormGDIP.ComboBox21Change(Sender: TObject);
begin
  pn.Title.GradientDirection := TChartGradientDirection(ComboBox21.ItemIndex);
end;

procedure TAdvChartPanesEditorFormGDIP.ComboBox22Change(Sender: TObject);
begin
  pn.Legend.BackGroundPosition := TChartBackgroundPosition(ComboBox22.ItemIndex);
end;

procedure TAdvChartPanesEditorFormGDIP.ComboBox23Change(Sender: TObject);
begin
  pn.AxisMode := TchartAxisMode(ComboBox23.ItemIndex);
end;

procedure TAdvChartPanesEditorFormGDIP.ComboBox24Change(Sender: TObject);
begin
  pn.Background.HatchStyle := THatchStyle(ComboBox24.ItemIndex);
  UpdatePreviewBackGround;  
end;

procedure TAdvChartPanesEditorFormGDIP.ComboBox25Change(Sender: TObject);
begin
  pn.Legend.HatchStyle := THatchStyle(comboBox25.ItemIndex);
end;

procedure TAdvChartPanesEditorFormGDIP.ComboBox26Change(Sender: TObject);
begin
  pn.Series.DonutMode := TChartSeriesDonutMode(ComboBox26.ItemIndex);
end;

procedure TAdvChartPanesEditorFormGDIP.ComboBox27Change(Sender: TObject);
begin
  pn.Series.BarChartSpacingType := TChartSerieValueWidthType(ComboBox27.ItemIndex);
end;

procedure TAdvChartPanesEditorFormGDIP.ComboBox28Change(Sender: TObject);
begin
  //TCrackedChartPane(pn).DS := //??
  TCrackedChartPane(pn).DS := TComponent(ComboBox28.Items.Objects[ComboBox28.ItemIndex]);
end;

procedure TAdvChartPanesEditorFormGDIP.ComboBox29Change(Sender: TObject);
begin
  pn.ZoomControl.Position := TZoomControlPosition(ComboBox29.ItemIndex);
end;

procedure TAdvChartPanesEditorFormGDIP.ComboBox2Change(Sender: TObject);
begin
  pn.BackGround.BackGroundPosition := TChartBackgroundPosition(ComboBox2.ItemIndex);
end;

procedure TAdvChartPanesEditorFormGDIP.ComboBox30Change(Sender: TObject);
begin
  pn.ZoomControl.AutoUpdate := TZoomControlAutoUpdate(ComboBox30.ItemIndex);
end;

procedure TAdvChartPanesEditorFormGDIP.ComboBox31Change(Sender: TObject);
begin
  pn.ZoomControl.SliderType := TZoomControlSliderType(ComboBox31.ItemIndex);
end;

procedure TAdvChartPanesEditorFormGDIP.ComboBox32Change(Sender: TObject);
begin
  pn.Legend.Alignment := TChartLegendAlignment(ComboBox32.ItemIndex);
end;

procedure TAdvChartPanesEditorFormGDIP.ComboBox3Change(Sender: TObject);
begin
  pn.Bands.GradientDirection := TChartGradientDirection(ComboBox3.ItemIndex);
  UpdatePreviewBands;  
end;

procedure TAdvChartPanesEditorFormGDIP.ComboBox4Change(Sender: TObject);
begin
  pn.BorderStyle := TBorderStyle(ComboBox4.ItemIndex);
end;

procedure TAdvChartPanesEditorFormGDIP.ComboBox5Change(Sender: TObject);
begin
  pn.HeightType := TPaneHeightType(ComboBox5.ItemIndex);
end;

procedure TAdvChartPanesEditorFormGDIP.ComboBox6Change(Sender: TObject);
begin
  pn.CrossHair.CrossHairType := TChartCrossHairType(ComboBox6.ItemIndex);
end;

procedure TAdvChartPanesEditorFormGDIP.ComboBox7Change(Sender: TObject);
begin
  pn.Legend.GradientType := TChartGradientType(ComboBox7.ItemIndex);
end;

procedure TAdvChartPanesEditorFormGDIP.ComboBox8Change(Sender: TObject);
begin
  pn.Navigator.GradientDirection := TChartGradientDirection(ComboBox8.ItemIndex);
  UpdatePreviewNavigator;
end;

procedure TAdvChartPanesEditorFormGDIP.ComboBox9Change(Sender: TObject);
begin
  pn.Splitter.GradientDirection := TChartGradientDirection(ComboBox9.ItemIndex);
end;

procedure TAdvChartPanesEditorFormGDIP.CorrectTop(lbl: TLabel);
begin
  lbl.Top := Round(lbl.Tag - (lbl.Font.Size - 8) / 2);
end;

procedure TAdvChartPanesEditorFormGDIP.Edit2Change(Sender: TObject);
begin
  pn.Title.Text := Edit2.Text;
end;

procedure TAdvChartPanesEditorFormGDIP.Edit3Change(Sender: TObject);
begin
  pn.XAxis.Text := edit3.Text;
end;

procedure TAdvChartPanesEditorFormGDIP.Edit4Change(Sender: TObject);
begin
  pn.YAxis.Text := edit4.Text;
end;

procedure TAdvChartPanesEditorFormGDIP.FormClose(Sender: TObject;
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
    col.Free;
  end;
end;

procedure TAdvChartPanesEditorFormGDIP.FormCreate(Sender: TObject);
begin
  {$IFDEF DELPHI9_LVL}
  DoubleBuffered := true;
  {$ENDIF}
  DTB.TabVisible := false;
  SelPane := -1;
end;

procedure TAdvChartPanesEditorFormGDIP.FormKeyUp(Sender: TObject; var Key: Word;
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
      if MessageDlg('Do you want to remove the selected pane?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        col[Listbox1.ItemIndex].Free;
        InitListBox;
      end;
    end;
  end;
end;

procedure TAdvChartPanesEditorFormGDIP.Image10Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    Image10.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    pn.ZoomControl.SliderRightPicture.Assign(image10.Picture);
  end;
end;

procedure TAdvChartPanesEditorFormGDIP.Image1Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    pn.BackGround.Picture.Assign(Image1.Picture);
    TAdvChartView((pn.Collection as TChartPanes).Owner).Invalidate;
    UpdatePreviewBackGround;
  end;
end;

procedure TAdvChartPanesEditorFormGDIP.Image2Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    Image2.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    pn.Navigator.ScrollButtonLeft.Assign(Image2.Picture);
  end;
  UpdatePreviewNavigator;
end;

procedure TAdvChartPanesEditorFormGDIP.Image3Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    Image3.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    pn.Navigator.ScrollButtonLeftHot.Assign(Image3.Picture);
  end;
  UpdatePreviewNavigator;
end;

procedure TAdvChartPanesEditorFormGDIP.Image4Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    Image4.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    pn.Navigator.ScrollButtonLeftDown.Assign(Image4.Picture);
  end;
  UpdatePreviewNavigator;
end;

procedure TAdvChartPanesEditorFormGDIP.Image5Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    Image5.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    pn.Navigator.ScrollButtonRightDown.Assign(Image5.Picture);
  end;
  UpdatePreviewNavigator;
end;

procedure TAdvChartPanesEditorFormGDIP.Image6Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    Image6.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    pn.Navigator.ScrollButtonRightHot.Assign(Image6.Picture);
  end;
  UpdatePreviewNavigator;
end;

procedure TAdvChartPanesEditorFormGDIP.Image7Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    Image7.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    pn.Navigator.ScrollButtonRight.Assign(Image7.Picture);
  end;
  UpdatePreviewNavigator;
end;

procedure TAdvChartPanesEditorFormGDIP.Image8Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    Image8.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    pn.Legend.Picture.Assign(Image8.Picture);
  end;
end;

procedure TAdvChartPanesEditorFormGDIP.Image9Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    Image9.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    pn.ZoomControl.SliderLeftPicture.Assign(image9.Picture);
  end;
end;

procedure TAdvChartPanesEditorFormGDIP.Init;
var
  I: Integer;
  //view: TAdvGDIPChartView;
begin
  PageControl1.ActivePageIndex := 0;

  //view := TAdvGDIPChartView.Create(Self);

  //col := TAdvGDIPChartPanes.Create(view);

  col := TAdvGDIPChartPanes(FChartview.GetPanesClass.Create(FChartView));

  ListBox1.Items.Clear;
  col.Clear;
  for i := 0 to ChartPanes.Count - 1 do
  begin
    col.Add;
    col[i].Assign(ChartPanes[i]);
  end;

  InitListBox;
end;

procedure TAdvChartPanesEditorFormGDIP.InitListBox;
var
  I: Integer;
begin
  ListBox1.Items.Clear;
  for i := 0 to Col.Count - 1 do
  begin
    listbox1.Items.Add(Col[i].Name);
  end;

  if Listbox1.Items.Count = 0 then
  begin
    PageControl1.Enabled := false;
    PageControl1.Visible := false;
    Panel1.Visible := true;
  end
  else
  begin
    ListBox1.ItemIndex := 0;
    ListBox1Click(ListBox1);
  end;
end;

procedure TAdvChartPanesEditorFormGDIP.ListBox1Click(Sender: TObject);
var
  I: Integer;
  sl: TStringList;
begin
  if listbox1.ItemIndex >= 0 then
  begin
    pn := col[ListBox1.ItemIndex];

    if listbox1.ItemIndex <> selpane then
    begin
      with TCrackedChartPane(pn) do
      begin
        if IsDB then
        begin
          DTB.TabVisible := true;
          ComboBox28.Items.Clear;
          sl := TCrackedChartPane(pn).GetDSNames;
          ComboBox28.Items.Assign(sl);
          sl.Free;
        end
        else
          DTB.TabVisible := false;
      end;
    end;

    selpane := listbox1.ItemIndex;

    if Assigned(TCrackedChartPane(pn).DS) then
      ComboBox28.Text := TCrackedChartPane(pn).DS.Name;

    PageControl1.Enabled := not (pn = nil);
    PageControl1.Visible := not (pn = nil);
    Panel1.Visible := false;
    ComboBox19.Items.Clear;
    ComboBox20.Items.Clear;
    for I := 0 to pn.Series.Count - 1 do
    begin
      ComboBox19.Items.Add(pn.Series[I].Name);
      ComboBox20.Items.Add(pn.Series[I].Name);
    end;

    //BANDS
    SpinEdit1.Value := Round(pn.Bands.Distance);
    SpinEdit2.Value := pn.Bands.GradientSteps;
    ComboBox3.ItemIndex := Integer(pn.Bands.GradientDirection);
    AdvColorSelector1.SelectedColor := pn.Bands.PrimaryColor;
    AdvColorSelector2.SelectedColor := pn.Bands.SecondaryColor;
    AdvColorSelector3.SelectedColor := pn.Bands.PrimarycolorTo;
    AdvColorSelector4.SelectedColor := pn.Bands.SecondaryColorTo;
    ComboBox19.ItemIndex := pn.Bands.SerieIndex;
    CheckBox1.Checked := pn.Bands.Visible;
    //BACKGROUND
    AdvColorSelector5.SelectedColor := pn.BackGround.Color;
    AdvColorSelector6.SelectedColor := pn.BackGround.ColorTo;
    ComboBox1.ItemIndex := Integer(pn.BackGround.GradientType);
    ComboBox24.ItemIndex := Integer(pn.Background.HatchStyle);
    ComboBox32.ItemIndex := Integer(pn.Legend.Alignment);
    Image1.Picture.Assign(pn.BackGround.Picture);
    ComboBox2.ItemIndex := Integer(pn.BackGround.BackGroundPosition);
    CheckBox2.Checked := pn.BackGround.PictureVisible;
    AdvChartSpinEdit1.Value := pn.Background.Angle;
    //GLOBAL
    ComboBox4.ItemIndex := Integer(pn.BorderStyle);
    AdvColorSelector7.SelectedColor := pn.BorderColor;
    SpinEdit5.Value := pn.BorderWidth;
    SpinEdit6.Value := Round(pn.Height);
    ComboBox5.ItemIndex := Integer(pn.HeightType);
    CheckBox3.Checked := (poMoving in pn.Options);
    CheckBox4.Checked := (poHorzScroll in pn.Options);
    CheckBox5.Checked := (poVertScroll in pn.Options);
    CheckBox6.Checked := (poHorzScale in pn.Options);
    CheckBox7.Checked := (poVertScale in pn.Options);
    CheckBox8.Checked := pn.Visible;
    //CrossHair
    SpinEdit7.Value := pn.CrossHair.Distance;
    AdvColorSelector8.SelectedColor := pn.CrossHair.LineColor;
    SpinEdit8.Value := pn.CrossHair.LineWidth;
    CheckBox10.Checked := pn.CrossHair.CrossHairYValues.ShowSerieValues;
    CheckBox11.Checked := pn.CrossHair.CrossHairYValues.ShowYPosValue;
    CheckBox12.Checked := (chYAxis in pn.CrossHair.CrossHairYValues.Position);
    CheckBox13.Checked := (chValueTracker in pn.CrossHair.CrossHairYValues.Position);
    CheckBox14.Checked := (chAtCursor in pn.CrossHair.CrossHairYValues.Position);
    ComboBox6.ItemIndex := Integer(pn.CrossHair.CrossHairType);
    CheckBox9.Checked := pn.CrossHair.Visible;
    //Title
    AdvChartColorSelector2.SelectedColor := pn.Title.BorderColor;
    SpinEdit39.Value := pn.Title.Borderwidth;
    ComboBox11.ItemIndex := Integer(pn.Title.Position);
    ComboBox10.ItemIndex := Integer(pn.Title.Alignment);
    advcolorselector23.SelectedColor := pn.Title.color;
    advChartcolorselector1.SelectedColor := pn.Title.colorTo;
    SpinEdit3.Value := pn.Title.GradientSteps;
    ComboBox21.ItemIndex := Integer(pn.Title.GradientDirection);
    SpinEdit28.Value := pn.Title.Size;
    Edit2.Text := pn.Title.Text;
    //Range
    SpinEdit9.Value := pn.Range.RangeFrom;
    SpinEdit10.Value := pn.Range.RangeTo;
    AdvChartSpinEdit7.value := pn.Range.MinimumScrollRange;
    AdvChartSpinEdit8.value := pn.Range.MaximumScrollRange;    
    //margin
    SpinEdit11.Value := pn.Margin.Leftmargin;
    SpinEdit12.Value := pn.Margin.TopMargin;
    SpinEdit13.Value := pn.Margin.RightMargin;
    SpinEdit14.Value := pn.Margin.BottomMargin;
    //LEGEND
    AdvColorSelector9.SelectedColor := pn.Legend.BorderColor;
    SpinEdit40.Value := pn.Legend.BorderRounding;
    ComboBox22.ItemIndex := Integer(pn.Legend.BackGroundPosition);
    Image8.picture.Assign(pn.Legend.Picture);
    SpinEdit16.Value := pn.Legend.BorderWidth;
    AdvChartColorSelector3.SelectedColor := pn.Legend.Color;
    AdvChartColorSelector4.SelectedColor := pn.Legend.Colorto;
    ComboBox7.ItemIndex := Integer(pn.Legend.GradientType);
    CheckBox29.Checked := pn.Legend.Shadow;
    AdvChartSpinEdit3.Value := pn.Legend.Opacity;
    AdvChartSpinEdit4.Value := pn.Legend.OpacityTo;
    AdvChartSpinEdit5.Value := pn.Navigator.ScrollStep;    
    SpinEdit17.Value := pn.Legend.RectangleSize;
    SpinEdit18.Value := pn.Legend.RectangleSpacing;
    SpinEdit19.Value := pn.Legend.Left;
    SpinEdit20.Value := pn.Legend.Top;
    CheckBox15.Checked := pn.Legend.Visible;
    ComboBox25.ItemIndex := Integer(pn.Legend.HatchStyle);
    //NAVIGATOR
    CheckBox16.Checked := pn.Navigator.AlphaBlend;
    SpinEdit21.Value := pn.Navigator.AlphaBlendValue;
    Advcolorselector12.SelectedColor := pn.Navigator.Color;
    Advcolorselector13.SelectedColor := pn.Navigator.ColorTo;
    SpinEdit22.Value := pn.Navigator.GradientSteps;
    ComboBox8.ItemIndex := Integer(pn.Navigator.GradientDirection);
    SpinEdit24.Value := pn.Navigator.Size;
    CheckBox17.Checked := pn.Navigator.ScrollButtons;
    SpinEdit23.Value := pn.Navigator.ScrollButtonsSize;
    CheckBox18.Checked := pn.Navigator.Visible;
    Image2.Picture.Assign(pn.Navigator.ScrollButtonLeft);
    Image3.Picture.Assign(pn.Navigator.ScrollButtonLeftHot);
    Image4.Picture.Assign(pn.Navigator.ScrollButtonLeftDown);
    Image7.Picture.Assign(pn.Navigator.ScrollButtonRight);
    Image6.Picture.Assign(pn.Navigator.ScrollButtonRightHot);
    Image5.Picture.Assign(pn.Navigator.ScrollButtonRightDown);
    AdvColorSelector14.SelectedColor := pn.Navigator.ScrollButtonLeftColor;
    AdvColorSelector15.SelectedColor := pn.Navigator.ScrollButtonLeftHotColor;
    AdvColorSelector16.SelectedColor := pn.Navigator.ScrollButtonLeftDownColor;
    AdvColorSelector19.SelectedColor := pn.Navigator.ScrollButtonLeftColor;
    AdvColorSelector18.SelectedColor := pn.Navigator.ScrollButtonRightHotColor;
    AdvColorSelector17.SelectedColor := pn.Navigator.ScrollButtonRightDownColor;
    //Splitter
    AdvColorSelector20.SelectedColor := pn.Splitter.Color;
    AdvColorSelector21.SelectedColor := pn.Splitter.Colorto;
    SpinEdit25.Value := pn.Splitter.Gradientsteps;
    ComboBox9.ItemIndex := Integer(pn.Splitter.GradientDirection);
    AdvColorSelector22.SelectedColor := pn.Splitter.LineColor;
    SpinEdit26.Value := pn.Splitter.LineWidth;
    SpinEdit27.Value := pn.Splitter.Height;
    CheckBox19.Checked := pn.Splitter.Visible;
    //XAXIS
    ComboBox12.ItemIndex := Integer(pn.XAxis.Alignment);
    AdvColorSelector24.SelectedColor := pn.XAxis.Color;
    AdvColorSelector25.SelectedColor := pn.XAxis.ColorTo;
    SpinEdit29.Value := pn.Xaxis.GradientSteps;
    ComboBox13.ItemIndex := Integer(pn.Xaxis.GradientDirection);
    CheckBox20.Checked := pn.Xaxis.Line;
    AdvColorSelector26.SelectedColor := pn.XAxis.LineColor;
    SpinEdit30.Value := pn.XAxis.LineWidth;
    ComboBox14.ItemIndex := Integer(pn.XAxis.Position);
    SpinEdit31.Value := pn.XAxis.Size;
    Edit3.Text := pn.Xaxis.Text;
    ComboBox15.ItemIndex := Integer(pn.XAxis.UnitType);
    //YAXIS
    CheckBox22.Checked := pn.YAxis.AutoUnits;
    CheckBox40.Checked := pn.XAxis.AutoSize;
    CheckBox39.Checked := pn.YAxis.AutoSize;
    ComboBox16.ItemIndex := Integer(pn.YAxis.Alignment);
    AdvColorSelector27.SelectedColor := pn.YAxis.Color;
    AdvColorSelector28.SelectedColor := pn.YAxis.ColorTo;
    SpinEdit32.Value := pn.Yaxis.GradientSteps;
    ComboBox17.ItemIndex := Integer(pn.Yaxis.GradientDirection);
    CheckBox21.Checked := pn.Yaxis.Line;
    AdvColorSelector29.SelectedColor := pn.YAxis.LineColor;
    SpinEdit33.Value := pn.YAxis.LineWidth;
    ComboBox18.ItemIndex := Integer(pn.YAxis.Position);
    SpinEdit34.Value := pn.YAxis.Size;
    Edit4.Text := pn.Yaxis.Text;
    //XGRID
    SpinEdit35.Value := pn.XGrid.MinorDistance;
    AdvcolorSelector30.SelectedColor := pn.Xgrid.MinorLinecolor;
    AdvPenStyleSelector1.SelectedPenStyle := pn.Xgrid.MinorLineStyle;
    spinEdit37.Value := pn.Xgrid.MinorLineWidth;
    SpinEdit36.Value := pn.Xgrid.MajorDistance;
    AdvColorSelector31.SelectedColor := pn.Xgrid.MajorLinecolor;
    AdvpenStyleSelector2.SelectedPenStyle := pn.Xgrid.MajorLineStyle;
    SpinEdit38.Value := pn.Xgrid.MajorLineWidth;
    CheckBox24.Checked := pn.Xgrid.OnTop;
    CheckBox23.Checked := pn.Xgrid.Visible;
    //YGRID
    CheckBox27.Checked := pn.YGrid.AutoUnits;
    ADvcolorselector34.SelectedColor := pn.YGrid.BorderColor;
    AdvSpinEdit1.FloatValue := pn.YGrid.MinorDistance;
    AdvcolorSelector32.SelectedColor := pn.YGrid.MinorLineColor;
    AdvPenStyleSelector3.SelectedPenStyle := pn.YGrid.MinorLineStyle;
    SpinEdit41.Value := pn.YGrid.MinorLineWidth;
    AdvSpinEdit2.FloatValue := pn.YGrid.MajorDistance;
    AdvcolorSelector33.SelectedColor := pn.YGrid.MajorLineColor;
    AdvPenStyleSelector4.SelectedPenStyle := pn.YGrid.MajorLineStyle;
    SpinEdit42.Value := pn.Ygrid.MajorLineWidth;
    CheckBox26.Checked := pn.Ygrid.OnTop;
    CheckBox25.Checked := pn.YGrid.Visible;
    ComboBox20.ItemIndex := pn.YGrid.SerieIndex;
    CheckBox28.Checked := pn.YGrid.ShowBorder;

    ComboBox23.ItemIndex := Integer(pn.AxisMode);

    CheckBox30.Checked := pn.Chart.Mirror;

    CheckBox31.Checked := pn.Series.SerieValueTotals;
    ComboBox26.ItemIndex := Integer(pn.Series.DonutMode);
    AdvChartSpinEdit6.Value := pn.Series.BarChartSpacing;
    ComboBox27.ItemIndex := Integer(pn.Series.BarChartSpacingType);

    Label140.Font.Assign(pn.Legend.font);
    Label141.Font.Assign(pn.Title.font);
    Label142.Font.Assign(pn.Xaxis.font);
    Label143.Font.Assign(pn.Yaxis.font);
    Label144.Font.Assign(pn.XGrid.MinorFont);
    Label145.Font.Assign(pn.XGrid.MajorFont);
    CorrectTop(label140);
    CorrectTop(label141);
    CorrectTop(label142);
    CorrectTop(label143);
    CorrectTop(label144);
    CorrectTop(label144);


    CheckBox32.Checked := pn.ZoomControl.Visible;
    ComboBox29.ItemIndex := integer(pn.ZoomControl.Position);
    ComboBox30.ItemIndex := integer(pn.ZoomControl.AutoUpdate);
    AdvChartSpinEdit9.Value := pn.ZoomControl.Left;
    AdvChartSpinEdit10.Value := pn.ZoomControl.Top;
    AdvChartSpinEdit11.Value := pn.ZoomControl.Width;
    AdvChartSpinEdit12.Value := pn.ZoomControl.Height;
    AdvChartColorSelector5.SelectedColor := pn.ZoomControl.Color;
    AdvChartColorSelector6.SelectedColor := pn.ZoomControl.BorderColor;
    AdvChartColorSelector7.SelectedColor := pn.ZoomControl.SelectionColor;
    AdvChartSpinEdit17.Value := pn.ZoomControl.Opacity;
    AdvChartSpinEdit18.Value := pn.ZoomControl.BorderOpacity;
    AdvChartSpinEdit19.Value := pn.ZoomControl.SelectionOpacity;
    CheckBox33.Checked := pn.ZoomControl.SlideAutoRange;
    AdvChartSpinEdit14.Value := pn.ZoomControl.SlideRangeFrom;
    AdvChartSpinEdit13.Value := pn.ZoomControl.SlideRangeTo;
    AdvChartSpinEdit15.Value := pn.ZoomControl.SlideMaximumRange;
    AdvChartSpinEdit16.Value := pn.ZoomControl.SlideMinimumRange;
    AdvChartColorSelector8.SelectedColor := pn.ZoomControl.SliderColor;
    AdvChartSpinEdit20.Value := pn.ZoomControl.SliderOpacity;
    AdvChartSpinEdit21.Value := pn.ZoomControl.SliderSize;
    Image9.Picture.Assign(pn.ZoomControl.SliderLeftPicture);
    Image10.Picture.Assign(pn.ZoomControl.SliderRightPicture);
    ComboBox31.ItemIndex := Integer(pn.ZoomControl.SliderType);

    AdvChartSpinEdit24.Value := pn.XAxis.Offset3D;
    CheckBox35.Checked := pn.XAxis.Enable3D;
    CheckBox36.Checked := pn.XAxis.Darken3D;

    AdvChartSpinEdit22.Value := pn.YAxis.Offset3D;
    CheckBox38.Checked := pn.YAxis.Enable3D;
    CheckBox37.Checked := pn.YAxis.Darken3D;
    CheckBox41.Checked := pn.Chart.XScaleOffset;

    CheckBox34.Checked := pn.Series.ChartMode = dmHorizontal;

    UpdatePreviewNavigator;
    UpdatePreviewBands;
    UpdatePreviewBackGround;

  end;

end;

procedure TAdvChartPanesEditorFormGDIP.ListBox1DblClick(Sender: TObject);
begin
  if SpeedButton4.Enabled then
    StartSerieEditor;
end;

procedure TAdvChartPanesEditorFormGDIP.ListBox1DragDrop(Sender, Source: TObject; X,
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

procedure TAdvChartPanesEditorFormGDIP.ListBox1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := (Source = ListBox1) and FAllowR;
end;

procedure TAdvChartPanesEditorFormGDIP.ListBox1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   StartingPoint.X := X;
   StartingPoint.Y := Y;
end;

procedure TAdvChartPanesEditorFormGDIP.PageControl1Change(Sender: TObject);
begin
  if (Sender as TPageControl).ActivePageIndex = TabSheet5.PageIndex then
    UpdatePreviewNavigator;

  if (Sender as TPageControl).ActivePageIndex = TabSheet7.PageIndex then
    UpdatePreviewBands;
  
end;

procedure TAdvChartPanesEditorFormGDIP.SaveChanges;
var
  i: integer;
begin
  (ChartPanes.Owner as TAdvGDIPChartView).BeginUpdate;

  ChartPanes.Clear;
  for I := 0 to col.Count - 1 do
  begin
    ChartPanes.Add;
    ChartPanes[I].Assign(col[I]);
  end;

  (ChartPanes.Owner as TAdvGDIPChartView).EndUpdate;  
end;

procedure TAdvChartPanesEditorFormGDIP.SpeedButton1Click(Sender: TObject);
begin
  if listbox1.ItemIndex >= 0 then
  begin
    Col[ListBox1.ItemIndex].Free;
    InitListBox;
  end;
end;

procedure TAdvChartPanesEditorFormGDIP.SpeedButton2Click(Sender: TObject);
begin
  Col.Add;
  InitListBox;
end;

procedure TAdvChartPanesEditorFormGDIP.SpeedButton3Click(Sender: TObject);
var
  s: String;
begin
  if ListBox1.Items.Count <> 0 then
  begin
    InputQuery('Pane name', 'Please enter new name',s);
    if s <> '' then
    begin
      pn.name := s;
      ListBox1.Items[pn.Index] := s;
    end;
  end;
end;

procedure TAdvChartPanesEditorFormGDIP.SpeedButton4Click(Sender: TObject);
begin
  StartSerieEditor;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit10Change(Sender: TObject);
begin
  pn.Range.RangeTo := SpinEdit10.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit11Change(Sender: TObject);
begin
  pn.Margin.LeftMargin := SpinEdit11.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit12Change(Sender: TObject);
begin
  pn.Margin.TopMargin := SpinEdit12.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit13Change(Sender: TObject);
begin
  pn.Margin.RightMargin := spinEdit13.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit14Change(Sender: TObject);
begin
  pn.Margin.BottomMargin := SpinEdit14.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit16Change(Sender: TObject);
begin
  pn.Legend.BorderWidth := SpinEdit16.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit17Change(Sender: TObject);
begin
  pn.Legend.RectangleSize := SpinEdit17.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit18Change(Sender: TObject);
begin
  pn.Legend.RectangleSpacing := SpinEdit18.value;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit19Change(Sender: TObject);
begin
  pn.Legend.Left := SpinEdit19.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit1Change(Sender: TObject);
begin
  pn.Bands.Distance := SpinEdit1.Value;
  UpdatePreviewBands;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit20Change(Sender: TObject);
begin
  pn.Legend.Top := SpinEdit20.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit21Change(Sender: TObject);
begin
  pn.Navigator.AlphaBlendValue := SpinEdit21.Value;
  UpdatePreviewNavigator;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit22Change(Sender: TObject);
begin
  pn.Navigator.GradientSteps := SpinEdit22.Value;
  UpdatePreviewNavigator;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit23Change(Sender: TObject);
begin
  pn.Navigator.ScrollButtonsSize := SpinEdit23.Value;
  UpdatePreviewNavigator;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit24Change(Sender: TObject);
begin
  pn.Navigator.Size := SpinEdit24.Value;
  UpdatePreviewNavigator;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit25Change(Sender: TObject);
begin
  pn.Splitter.GradientSteps := SpinEdit25.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit26Change(Sender: TObject);
begin
  pn.Splitter.LineWidth := SpinEdit26.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit27Change(Sender: TObject);
begin
  pn.Splitter.Height := SPinEdit27.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit28Change(Sender: TObject);
begin
  pn.Title.Size := SpinEdit28.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit29Change(Sender: TObject);
begin
  pn.XAxis.GradientSteps := SpinEdit29.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit2Change(Sender: TObject);
begin
  pn.Bands.GradientSteps := SpinEdit2.Value;
  UpdatePreviewBands;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit30Change(Sender: TObject);
begin
  pn.XAxis.LineWidth := SpinEdit30.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit31Change(Sender: TObject);
begin
  pn.XAxis.Size := spinEdit31.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit32Change(Sender: TObject);
begin
  pn.YAxis.GradientSteps := SpinEdit32.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit33Change(Sender: TObject);
begin
  pn.YAxis.LineWidth := SpinEdit33.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit34Change(Sender: TObject);
begin
  pn.YAxis.Size := spinEdit34.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit35Change(Sender: TObject);
begin
  pn.XGrid.MinorDistance := SpinEdit35.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit36Change(Sender: TObject);
begin
  pn.XGrid.MajorDistance := SpinEdit36.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit37Change(Sender: TObject);
begin
  pn.Xgrid.MinorLineWidth := SpinEdit37.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit38Change(Sender: TObject);
begin
  pn.XGrid.MajorLineWidth := SpinEdit38.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit39Change(Sender: TObject);
begin
  pn.Title.BorderWidth := SpinEdit39.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit3Change(Sender: TObject);
begin
  pn.Title.GradientSteps := SpinEdit3.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit40Change(Sender: TObject);
begin
  pn.Legend.BorderRounding := SpinEdit40.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit41Change(Sender: TObject);
begin
  pn.YGrid.MinorLineWidth := SpinEdit41.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit42Change(Sender: TObject);
begin
  pn.YGrid.MajorLineWidth := SpinEdit42.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit5Change(Sender: TObject);
begin
  pn.BorderWidth := SpinEdit5.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit6Change(Sender: TObject);
begin
  pn.Height := SpinEdit6.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit7Change(Sender: TObject);
begin
  pn.CrossHair.Distance := SpinEdit7.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit8Change(Sender: TObject);
begin
  pn.CrossHair.LineWidth := SpinEdit8.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.SpinEdit9Change(Sender: TObject);
begin
  pn.Range.RangeFrom := SpinEdit9.Value;
end;

procedure TAdvChartPanesEditorFormGDIP.UpdatePreviewBackGround;
begin
  AdvChartFillPreview1.ColorFrom := pn.Background.Color;
  AdvChartFillPreview1.ColorTo := pn.Background.ColorTo;
  AdvChartFillPreview1.HatchStyle := pn.Background.HatchStyle;
  AdvChartFillPreview1.GradientType := pn.Background.GradientType;
  AdvChartFillPreview1.Angle := pn.BackGround.Angle;
  AdvChartFillPreview1.Image.Assign(pn.Background.Picture);
end;

procedure TAdvChartPanesEditorFormGDIP.UpdatePreviewBands;
var
  I: Integer;
  DR: TRect;
  t, b: integer;
begin
   PatBlt(PaintBox3.Canvas.Handle,0,0,PaintBox3.ClientWidth,PaintBox3.ClientHeight,WHITENESS);
   with pn.Bands do
   begin
     if Visible then
     begin
       for I := 0 to 6 do
       begin
         t := Round(((PaintBox3.ClientRect.Bottom - PaintBox3.ClientRect.Top) / 7) * (I));
         b := Round(((PaintBox3.ClientRect.Bottom - PaintBox3.ClientRect.Top) / 7) * (I + 1));
         DR := Rect(PaintBox3.ClientRect.Left, t, PaintBox3.ClientRect.Right,b);
         if not Odd(I) then
           DrawGradient(PaintBox3.Canvas, PrimaryColor, PrimaryColorTo, GradientSteps, DR, GradientDirection)
         else
           DrawGradient(PaintBox3.Canvas, SecondaryColor, SecondaryColorTo, GradientSteps, DR, GradientDirection);
       end;
     end;
   end;

end;

procedure TAdvChartPanesEditorFormGDIP.UpdatePreviewNavigator;
begin
  PatBlt(PaintBox2.Canvas.Handle,0,0,PaintBox2.ClientWidth,PaintBox2.ClientHeight,WHITENESS);
  pn.Navigator.Draw(PaintBox2.Canvas, PaintBox2.ClientRect, 1, 1);
end;

{ TAdvChartPaneEditorDialog }

constructor TAdvChartPanesEditorDialogGDIP.Create(AOwner: TComponent);
begin
  inherited;
  FAllowPaneRemoving := true;
  FAllowNameChange := true;
  FAllowPaneReorder := true;
  FAllowPaneAdding := true;
  FAllowSerieEditing := true;
end;

function TAdvChartPanesEditorDialogGDIP.Execute: Boolean;
begin
//  FChartView.BeginUpdate;
  FForm := TAdvChartPanesEditorFormGDIP.Create(Application);

  if not Assigned(FChartView) then
  begin
    raise Exception.Create('The dialog does not have AdvChartView Component assigned.');
    Result := False;
    Exit;
  end;

  FForm.FChartView := FChartView;
  FForm.ChartPanes := FChartView.Panes;
  FForm.SpeedButton4.Enabled := AllowSerieEditing;
  FForm.SpeedButton3.Enabled := AllowPaneNameChange;
  FForm.SpeedButton2.Enabled := AllowPaneAdding;
  FForm.SpeedButton1.Enabled := AllowPaneRemoving;
  FForm.FAllowR := AllowPaneReorder;  
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

//  FChartView.EndUpdate;
end;

procedure TAdvChartPanesEditorDialogGDIP.Notification(AComponent: TComponent;
  AOperation: TOperation);
begin
  inherited;
  if (AComponent = FChartView) and (AOperation = opRemove) then
    FChartView := nil;
end;

procedure TAdvChartPanesEditorDialogGDIP.SetChartView(const Value: TAdvGDIPChartView);
begin
  FChartView := Value;
end;

procedure TAdvChartPanesEditorFormGDIP.StartSerieEditor;
var
  ac: TAdvChartSeriesEditorFormGDIP;
begin
  if ListBox1.Items.Count <> 0 then
  begin
    ac := TAdvChartSeriesEditorFormGDIP.Create(Self);
    ac.AllowEditing := true;
    ac.ChartSeries := pn.Series;
    ac.ChartView := (FChartPanes.Owner as TAdvChartView);
    ac.Init;
    ac.Apply := ApplyChanges;
    ac.ShowModal;
    ac.Free;
  end;
end;

end.
