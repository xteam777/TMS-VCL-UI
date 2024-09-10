{***************************************************************************}
{ TAdvChartPaneEditor component                                             }
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

unit AdvChartPaneEditor;

{$I TMSDEFS.INC}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, AdvChartView,
  Dialogs, StdCtrls, ExtDlgs, ComCtrls, ExtCtrls, AdvChart, AdvChartSelectors, AdvChartSpin, Buttons, AdvChartSerieEditor,
  Mask;

type
  TCrackedChartPane = class(TChartPane)
  end;

  TSaveMode = (notsaving, saving, cancel);

  TAdvChartPanesEditorForm = class(TForm)
    ListBox1: TListBox;
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
    ComboBox1: TComboBox;
    Label20: TLabel;
    Label21: TLabel;
    SpinEdit4: TAdvChartSpinEdit;
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
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    FontDialog1: TFontDialog;
    Label41: TLabel;
    Label42: TLabel;
    CheckBox15: TCheckBox;
    AdvColorSelector9: TAdvChartColorSelector;
    AdvColorSelector10: TAdvChartColorSelector;
    AdvColorSelector11: TAdvChartColorSelector;
    ComboBox7: TComboBox;
    SpinEdit15: TAdvChartSpinEdit;
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
    GroupBox10: TGroupBox;
    PaintBox1: TPaintBox;
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
    TabSheet6: TTabSheet;
    GroupBox23: TGroupBox;
    CheckBox29: TCheckBox;
    ColorDialog1: TColorDialog;
    Label135: TLabel;
    Label130: TLabel;
    ComboBox24: TComboBox;
    Label137: TLabel;
    AdvChartSpinEdit5: TAdvChartSpinEdit;
    ComboBox25: TComboBox;
    Label132: TLabel;
    Label131: TLabel;
    AdvChartSpinEdit1: TAdvChartSpinEdit;
    Label133: TLabel;
    Label134: TLabel;
    Label136: TLabel;
    Label138: TLabel;
    Label139: TLabel;
    Label140: TLabel;
    AdvChartSpinEdit8: TAdvChartSpinEdit;
    AdvChartSpinEdit7: TAdvChartSpinEdit;
    Label147: TLabel;
    Label146: TLabel;
    DTB: TTabSheet;
    GroupBox35: TGroupBox;
    Label149: TLabel;
    ComboBox26: TComboBox;
    Button17: TButton;
    Label141: TLabel;
    CheckBox30: TCheckBox;
    CheckBox36: TCheckBox;
    Label173: TLabel;
    Label172: TLabel;
    CheckBox35: TCheckBox;
    AdvChartSpinEdit24: TAdvChartSpinEdit;
    Label142: TLabel;
    CheckBox31: TCheckBox;
    Label143: TLabel;
    Label144: TLabel;
    CheckBox32: TCheckBox;
    AdvChartSpinEdit2: TAdvChartSpinEdit;
    Label145: TLabel;
    CheckBox33: TCheckBox;
    CheckBox34: TCheckBox;
    ComboBox27: TComboBox;
    Label148: TLabel;
    GroupBox24: TGroupBox;
    CheckBox37: TCheckBox;
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
    procedure ComboBox1Change(Sender: TObject);
    procedure SpinEdit4Change(Sender: TObject);
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
    procedure AdvColorSelector10Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure AdvColorSelector11Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
    procedure SpinEdit15Change(Sender: TObject);
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
    procedure CheckBox29Click(Sender: TObject);
    procedure ComboBox24Change(Sender: TObject);
    procedure AdvChartSpinEdit5Change(Sender: TObject);
    procedure ComboBox25Change(Sender: TObject);
    procedure AdvChartSpinEdit1Change(Sender: TObject);
    procedure AdvChartSpinEdit8Change(Sender: TObject);
    procedure AdvChartSpinEdit7Change(Sender: TObject);
    procedure ComboBox26Change(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure CheckBox30Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AdvChartSpinEdit24Change(Sender: TObject);
    procedure CheckBox35Click(Sender: TObject);
    procedure CheckBox36Click(Sender: TObject);
    procedure AdvChartSpinEdit2Change(Sender: TObject);
    procedure CheckBox32Click(Sender: TObject);
    procedure CheckBox31Click(Sender: TObject);
    procedure CheckBox33Click(Sender: TObject);
    procedure CheckBox34Click(Sender: TObject);
    procedure ComboBox27Change(Sender: TObject);
    procedure CheckBox37Click(Sender: TObject);
  private
    FAllowR: Boolean;
    { Private declarations }
    FChartPanes: TChartPanes;
    FChartView: TAdvChartView;
    col: TChartPanes;
    Mode: TSaveMode;
    selpane: integer;
    procedure StartSerieEditor;
    procedure CorrectTop(lbl: TLabel);
    procedure ApplyChanges(Sender: TObject);
  public
    { Public declarations }
    property ChartView: TAdvChartView read FChartview write FChartview;
    property ChartPanes: TChartPanes read FChartPanes write FChartPanes;
    procedure Init;
    procedure InitListBox;
    procedure UpdatePreviewLegend;
    procedure UpdatePreviewNavigator;
    procedure UpdatePreviewBands;
    procedure SaveChanges;
  end;

  {$IFDEF DELPHIXE2_LVL}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  {$ENDIF}
  TAdvChartPanesEditorDialog = class(TCommonDialog)
  private
    FForm: TAdvChartPanesEditorForm;
    FChartView: TAdvChartview;
    FCaption: string;
    FAllowPaneRemoving: Boolean;
    FAllowNameChange: Boolean;
    FAllowPaneReorder: Boolean;
    FAllowPaneAdding: Boolean;
    FAllowSerieEditing: Boolean;
    procedure SetChartView(const Value: TAdvChartView);
  protected
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;  
  public
    constructor Create(AOwner: TComponent); override;
    function Execute: Boolean; override;
    property Form: TAdvChartPanesEditorForm read FForm;
  published
    property Caption: string read FCaption write FCaption;
    property ChartView: TAdvChartView read FChartView write SetChartView;
    property AllowSerieEditing: Boolean read FAllowSerieEditing write FAllowSerieEditing default true;
    property AllowPaneNameChange: Boolean read FAllowNameChange write FAllowNameChange default true;
    property AllowPaneRemoving: Boolean read FAllowPaneRemoving write FAllowPaneRemoving default true;
    property AllowPaneAdding: Boolean read FAllowPaneAdding write FAllowPaneAdding default true;
    property AllowPaneReorder: Boolean read FAllowPaneReorder write FAllowPaneReorder default true;
  end;

var
  AdvChartPanesEditorForm: TAdvChartPanesEditorForm;
  pn: TChartPane;
  StartingPoint : TPoint;

implementation

{$R *.dfm}

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

procedure TAdvChartPanesEditorForm.AdvChartColorSelector1Select(Sender: TObject;
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

procedure TAdvChartPanesEditorForm.AdvChartColorSelector2Select(Sender: TObject;
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

procedure TAdvChartPanesEditorForm.AdvChartSpinEdit1Change(Sender: TObject);
begin
  pn.Series.BarChartSpacing := AdvChartSpinEdit1.Value;
end;

procedure TAdvChartPanesEditorForm.AdvChartSpinEdit24Change(Sender: TObject);
begin
  pn.YAxis.Offset3D := AdvChartSpinEdit24.Value;
end;

procedure TAdvChartPanesEditorForm.AdvChartSpinEdit2Change(Sender: TObject);
begin
  pn.XAxis.Offset3D := AdvChartSpinEdit2.Value;
end;

procedure TAdvChartPanesEditorForm.AdvChartSpinEdit5Change(Sender: TObject);
begin
  pn.Navigator.ScrollStep := AdvChartSpinEdit5.Value;
end;

procedure TAdvChartPanesEditorForm.AdvChartSpinEdit7Change(Sender: TObject);
begin
  pn.Range.MinimumScrollRange := AdvChartSpinEdit7.Value;
end;

procedure TAdvChartPanesEditorForm.AdvChartSpinEdit8Change(Sender: TObject);
begin
  pn.Range.MaximumScrollRange := AdvChartSpinEdit8.Value;
end;

procedure TAdvChartPanesEditorForm.AdvColorSelector10Select(Sender: TObject;
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

  pn.Legend.Color := AdvColorSelector10.SelectedColor;
  UpdatePreviewLegend;
end;

procedure TAdvChartPanesEditorForm.AdvColorSelector11Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  if Index = 0 then
    advcolorselector11.SelectedColor := clNone;

  if Index = 41 then
  begin
    ColorDialog1.Color := AdvColorSelector11.SelectedColor;
    if ColorDialog1.Execute then
    begin
      AdvColorSelector11.SelectedColor := ColorDialog1.Color;
    end;
  end;

  pn.Legend.ColorTo := AdvColorSelector11.SelectedColor;
  UpdatePreviewLegend;
end;

procedure TAdvChartPanesEditorForm.AdvColorSelector12Select(Sender: TObject;
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

procedure TAdvChartPanesEditorForm.AdvColorSelector13Select(Sender: TObject;
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

procedure TAdvChartPanesEditorForm.AdvColorSelector14Select(Sender: TObject;
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

procedure TAdvChartPanesEditorForm.AdvColorSelector15Select(Sender: TObject;
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

procedure TAdvChartPanesEditorForm.AdvColorSelector16Select(Sender: TObject;
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

procedure TAdvChartPanesEditorForm.AdvColorSelector17Select(Sender: TObject;
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

procedure TAdvChartPanesEditorForm.AdvColorSelector18Select(Sender: TObject;
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

procedure TAdvChartPanesEditorForm.AdvColorSelector19Select(Sender: TObject;
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

procedure TAdvChartPanesEditorForm.AdvColorSelector1Select(Sender: TObject;
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

procedure TAdvChartPanesEditorForm.AdvColorSelector20Select(Sender: TObject;
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

procedure TAdvChartPanesEditorForm.AdvColorSelector21Select(Sender: TObject;
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

procedure TAdvChartPanesEditorForm.AdvColorSelector22Select(Sender: TObject;
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

procedure TAdvChartPanesEditorForm.AdvColorSelector23Select(Sender: TObject;
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

procedure TAdvChartPanesEditorForm.AdvColorSelector24Select(Sender: TObject;
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

procedure TAdvChartPanesEditorForm.AdvColorSelector25Select(Sender: TObject;
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

procedure TAdvChartPanesEditorForm.AdvColorSelector26Select(Sender: TObject;
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

procedure TAdvChartPanesEditorForm.AdvColorSelector27Select(Sender: TObject;
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

procedure TAdvChartPanesEditorForm.AdvColorSelector28Select(Sender: TObject;
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

procedure TAdvChartPanesEditorForm.AdvColorSelector29Select(Sender: TObject;
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

procedure TAdvChartPanesEditorForm.AdvColorSelector2Select(Sender: TObject;
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

procedure TAdvChartPanesEditorForm.AdvColorSelector30Select(Sender: TObject;
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

procedure TAdvChartPanesEditorForm.AdvColorSelector31Select(Sender: TObject;
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

procedure TAdvChartPanesEditorForm.AdvColorSelector32Select(Sender: TObject;
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

procedure TAdvChartPanesEditorForm.AdvColorSelector33Select(Sender: TObject;
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

procedure TAdvChartPanesEditorForm.AdvColorSelector34Select(Sender: TObject;
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

procedure TAdvChartPanesEditorForm.AdvColorSelector3Select(Sender: TObject;
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

procedure TAdvChartPanesEditorForm.AdvColorSelector4Select(Sender: TObject;
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

procedure TAdvChartPanesEditorForm.AdvColorSelector5Select(Sender: TObject;
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
end;

procedure TAdvChartPanesEditorForm.AdvColorSelector6Select(Sender: TObject;
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
end;

procedure TAdvChartPanesEditorForm.AdvColorSelector7Select(Sender: TObject;
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

procedure TAdvChartPanesEditorForm.AdvColorSelector8Select(Sender: TObject;
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

procedure TAdvChartPanesEditorForm.AdvColorSelector9Select(Sender: TObject;
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
  UpdatePreviewLegend;
end;

procedure TAdvChartPanesEditorForm.AdvPenStyleSelector1Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  pn.XGrid.MinorLineStyle := AdvPenStyleSelector1.SelectedPenStyle;
end;

procedure TAdvChartPanesEditorForm.AdvPenStyleSelector2Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  pn.XGrid.MajorLineStyle := AdvPenStyleSelector2.SelectedPenStyle;
end;

procedure TAdvChartPanesEditorForm.AdvPenStyleSelector3Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  pn.YGrid.MinorLineStyle := AdvPenStyleSelector3.SelectedPenStyle;
end;

procedure TAdvChartPanesEditorForm.AdvPenStyleSelector4Select(Sender: TObject;
  Index: Integer; Item: TAdvChartSelectorItem);
begin
  pn.YGrid.MajorLineStyle := AdvPenStyleSelector4.SelectedPenStyle;
end;

procedure TAdvChartPanesEditorForm.AdvSpinEdit1Change(Sender: TObject);
begin
  pn.YGrid.MinorDistance := AdvSpinEdit1.FloatValue;
end;

procedure TAdvChartPanesEditorForm.AdvSpinEdit2Change(Sender: TObject);
begin
  pn.Ygrid.MajorDistance := AdvSpinEdit2.FloatValue;
end;

procedure TAdvChartPanesEditorForm.Button10Click(Sender: TObject);
begin
  if not (Image3.Picture.Graphic = nil) then
  begin
    Image3.Picture := nil;
    pn.Navigator.ScrollButtonLeftHot := nil;
  end;
end;

procedure TAdvChartPanesEditorForm.Button11Click(Sender: TObject);
begin
  if not (Image4.Picture.Graphic = nil) then
  begin
    Image4.Picture := nil;
    pn.Navigator.ScrollButtonLeftDown := nil;
  end;
end;

procedure TAdvChartPanesEditorForm.Button12Click(Sender: TObject);
begin
  if not (Image5.Picture.Graphic = nil) then
  begin
    Image5.Picture := nil;
    pn.Navigator.ScrollButtonRightDown := nil;
  end;
end;

procedure TAdvChartPanesEditorForm.Button13Click(Sender: TObject);
begin
  if not (Image1.Picture.Graphic = nil) then
  begin
    Image1.Picture := nil;
    pn.BackGround.Picture := nil;
  end;
end;

procedure TAdvChartPanesEditorForm.Button14Click(Sender: TObject);
begin
  if not (Image6.Picture.Graphic = nil) then
  begin
    Image6.Picture := nil;
    pn.Navigator.ScrollButtonRightHot := nil;
  end;
end;

procedure TAdvChartPanesEditorForm.Button15Click(Sender: TObject);
begin
  if not (Image7.Picture.Graphic = nil) then
  begin
    Image7.Picture := nil;
    pn.Navigator.ScrollButtonRight := nil;
  end;
end;

procedure TAdvChartPanesEditorForm.Button16Click(Sender: TObject);
begin
  if not (Image8.Picture.Graphic = nil) then
  begin
    Image8.Picture := nil;
    pn.Legend.Picture := nil;
  end;
end;

procedure TAdvChartPanesEditorForm.Button17Click(Sender: TObject);
begin
  SaveChanges;
end;

procedure TAdvChartPanesEditorForm.Button1Click(Sender: TObject);
begin
  FontDialog1.Font.Assign(pn.XGrid.Majorfont);
  if FontDialog1.Execute then
  begin
    pn.XGrid.Majorfont.Assign(FontDialog1.Font);
    Label140.Font.Assign(pn.Xgrid.Majorfont);
    CorrectTop(label140);
  end;
end;

procedure TAdvChartPanesEditorForm.Button2Click(Sender: TObject);
begin
  FontDialog1.Font.Assign(pn.XGrid.MinorFont);
  if FontDialog1.Execute then
  begin
    pn.XGrid.MinorFont.Assign(FontDialog1.Font);
    Label139.Font.Assign(pn.Xgrid.minorfont);
    CorrectTop(label139);
  end;
end;

procedure TAdvChartPanesEditorForm.Button3Click(Sender: TObject);
begin
  Mode := cancel;
  Self.Close;
  ModalResult := mrCancel;
end;

procedure TAdvChartPanesEditorForm.Button4Click(Sender: TObject);
begin
  SaveChanges;
  Mode := saving;
  Self.Close;
  ModalResult := mrOk;
end;

procedure TAdvChartPanesEditorForm.Button5Click(Sender: TObject);
begin
  if not (Image2.Picture.Graphic = nil) then
  begin
    Image2.Picture := nil;
    pn.Navigator.ScrollButtonLeft := nil;
  end;
end;

procedure TAdvChartPanesEditorForm.Button6Click(Sender: TObject);
begin
  FontDialog1.Font.Assign(pn.Title.Font);
  if FontDialog1.Execute then
  begin
    pn.Title.Font.Assign(FontDialog1.Font);
    Label134.Font.Assign(pn.title.font);
    CorrectTop(label134);
  end;
end;

procedure TAdvChartPanesEditorForm.Button7Click(Sender: TObject);
begin
  FontDialog1.Font.Assign(pn.XAxis.Font);
  if FontDialog1.Execute then
  begin
    pn.XAxis.Font.Assign(FontDialog1.Font);
    Label136.Font.Assign(pn.Xaxis.font);
    CorrectTop(label136);
  end;
end;

procedure TAdvChartPanesEditorForm.Button8Click(Sender: TObject);
begin
  FontDialog1.Font.Assign(pn.Legend.Font);
  if FontDialog1.Execute then
  begin
    pn.Legend.Font.Assign(FontDialog1.Font);
    Label133.Font.Assign(pn.Legend.font);
    CorrectTop(label133);
  end;

  UpdatePreviewLegend;
end;

procedure TAdvChartPanesEditorForm.Button9Click(Sender: TObject);
begin
  FontDialog1.Font.Assign(pn.YAxis.Font);
  if FontDialog1.Execute then
  begin
    pn.YAxis.Font.Assign(FontDialog1.Font);
    Label138.Font.Assign(pn.YAxis.Font);
    CorrectTop(label138);
  end;
end;

procedure TAdvChartPanesEditorForm.CheckBox10Click(Sender: TObject);
begin
  pn.CrossHair.CrossHairYValues.ShowSerieValues := CheckBox10.Checked;
end;

procedure TAdvChartPanesEditorForm.CheckBox11Click(Sender: TObject);
begin
   pn.CrossHair.CrossHairYValues.ShowYPosValue := CheckBox11.Checked;
end;

procedure TAdvChartPanesEditorForm.CheckBox12Click(Sender: TObject);
begin
  case CheckBox12.Checked of
    true: pn.CrossHair.CrossHairYValues.Position := pn.CrossHair.CrossHairYValues.Position + [chYAxis];
    false: pn.CrossHair.CrossHairYValues.Position := pn.CrossHair.CrossHairYValues.Position - [chYAxis];
  end;
end;

procedure TAdvChartPanesEditorForm.CheckBox13Click(Sender: TObject);
begin
  case CheckBox13.Checked of
    true: pn.CrossHair.CrossHairYValues.Position := pn.CrossHair.CrossHairYValues.Position + [chValueTracker];
    false: pn.CrossHair.CrossHairYValues.Position := pn.CrossHair.CrossHairYValues.Position - [chValueTracker];
  end;
end;

procedure TAdvChartPanesEditorForm.CheckBox14Click(Sender: TObject);
begin
  case CheckBox14.Checked of
    true: pn.CrossHair.CrossHairYValues.Position := pn.CrossHair.CrossHairYValues.Position + [chAtCursor];
    false: pn.CrossHair.CrossHairYValues.Position := pn.CrossHair.CrossHairYValues.Position - [chAtCursor];
  end;
end;

procedure TAdvChartPanesEditorForm.CheckBox15Click(Sender: TObject);
begin
  pn.Legend.Visible := CheckBox15.Checked;
  UpdatePreviewLegend;
end;

procedure TAdvChartPanesEditorForm.CheckBox16Click(Sender: TObject);
begin
  pn.Navigator.AlphaBlend := CheckBox16.Checked;
  UpdatePreviewNavigator;
end;

procedure TAdvChartPanesEditorForm.CheckBox17Click(Sender: TObject);
begin
  pn.Navigator.ScrollButtons := CheckBox17.Checked;
  UpdatePreviewNavigator;
end;

procedure TAdvChartPanesEditorForm.CheckBox18Click(Sender: TObject);
begin
  pn.Navigator.Visible := CheckBox18.Checked;
  UpdatePreviewNavigator;
end;

procedure TAdvChartPanesEditorForm.CheckBox19Click(Sender: TObject);
begin
  pn.Splitter.Visible := CheckBox19.Checked;
end;

procedure TAdvChartPanesEditorForm.CheckBox1Click(Sender: TObject);
begin
  pn.Bands.Visible := CheckBox1.Checked;
  UpdatePreviewBands;  
end;

procedure TAdvChartPanesEditorForm.CheckBox20Click(Sender: TObject);
begin
  pn.XAxis.Line := CheckBox20.Checked;
end;

procedure TAdvChartPanesEditorForm.CheckBox21Click(Sender: TObject);
begin
  pn.YAxis.Line := CheckBox21.Checked;
end;

procedure TAdvChartPanesEditorForm.CheckBox22Click(Sender: TObject);
begin
  pn.YAxis.AutoUnits := CheckBox22.Checked;
end;

procedure TAdvChartPanesEditorForm.CheckBox23Click(Sender: TObject);
begin
  pn.XGrid.Visible := CheckBox23.Checked;
end;

procedure TAdvChartPanesEditorForm.CheckBox24Click(Sender: TObject);
begin
  pn.Xgrid.OnTop := CheckBox24.Checked;
end;

procedure TAdvChartPanesEditorForm.CheckBox25Click(Sender: TObject);
begin
  pn.YGrid.Visible := CheckBox25.Checked;
end;

procedure TAdvChartPanesEditorForm.CheckBox26Click(Sender: TObject);
begin
  pn.YGrid.OnTop := CheckBox26.Checked;
end;

procedure TAdvChartPanesEditorForm.CheckBox27Click(Sender: TObject);
begin
  pn.YGrid.AutoUnits :=  CheckBox27.checked;
end;

procedure TAdvChartPanesEditorForm.CheckBox28Click(Sender: TObject);
begin
  pn.YGrid.ShowBorder := CheckBox28.Checked;
end;

procedure TAdvChartPanesEditorForm.CheckBox29Click(Sender: TObject);
begin
  pn.Chart.Series.SerieValueTotals := CheckBox29.Checked;
end;

procedure TAdvChartPanesEditorForm.CheckBox2Click(Sender: TObject);
begin
  pn.BackGround.PictureVisible := CheckBox2.Checked;
end;

procedure TAdvChartPanesEditorForm.CheckBox30Click(Sender: TObject);
begin
  if CheckBox30.Checked then
    pn.Series.ChartMode := dmHorizontal
  else
    pn.Series.ChartMode := dmVertical;
end;

procedure TAdvChartPanesEditorForm.CheckBox31Click(Sender: TObject);
begin
  pn.XAxis.Darken3D := CheckBox31.Checked;
end;

procedure TAdvChartPanesEditorForm.CheckBox32Click(Sender: TObject);
begin
  pn.XAxis.Enable3D := CheckBox32.Checked;
end;

procedure TAdvChartPanesEditorForm.CheckBox33Click(Sender: TObject);
begin
  pn.XAxis.AutoSize := CheckBox33.Checked;
end;

procedure TAdvChartPanesEditorForm.CheckBox34Click(Sender: TObject);
begin
  pn.YAxis.AutoSize := CheckBox34.Checked;
end;

procedure TAdvChartPanesEditorForm.CheckBox35Click(Sender: TObject);
begin
  pn.YAxis.Enable3D := CheckBox35.Checked;
end;

procedure TAdvChartPanesEditorForm.CheckBox36Click(Sender: TObject);
begin
  pn.YAxis.Darken3D := CheckBox36.Checked;
end;

procedure TAdvChartPanesEditorForm.CheckBox37Click(Sender: TObject);
begin
  pn.Chart.XScaleOffset := CheckBox37.Checked;
end;

procedure TAdvChartPanesEditorForm.CheckBox3Click(Sender: TObject);
begin
  case CheckBox3.Checked of
    true:  pn.Options := pn.Options + [poMoving];
    false:  pn.Options := pn.Options - [poMoving];
  end;
end;

procedure TAdvChartPanesEditorForm.CheckBox4Click(Sender: TObject);
begin
  case CheckBox4.Checked of
    true:  pn.Options := pn.Options + [poHorzScroll];
    false:  pn.Options := pn.Options - [poHorzScroll];
  end;
end;

procedure TAdvChartPanesEditorForm.CheckBox5Click(Sender: TObject);
begin
  case CheckBox5.Checked of
    true:  pn.Options := pn.Options + [poVertScroll];
    false:  pn.Options := pn.Options - [poVertScroll];
  end;
end;

procedure TAdvChartPanesEditorForm.CheckBox6Click(Sender: TObject);
begin
  case CheckBox6.Checked of
    true:  pn.Options := pn.Options + [poHorzScale];
    false:  pn.Options := pn.Options - [poHorzScale];
  end;
end;

procedure TAdvChartPanesEditorForm.CheckBox7Click(Sender: TObject);
begin
  case CheckBox7.Checked of
    true:  pn.Options := pn.Options + [poVertScale];
    false:  pn.Options := pn.Options - [poVertScale];
  end;
end;

procedure TAdvChartPanesEditorForm.CheckBox8Click(Sender: TObject);
begin
  pn.Visible := CheckBox8.Checked;
end;

procedure TAdvChartPanesEditorForm.CheckBox9Click(Sender: TObject);
begin
  pn.CrossHair.Visible := CheckBox9.Checked;
end;

procedure TAdvChartPanesEditorForm.ComboBox10Change(Sender: TObject);
begin
  pn.Title.Alignment := TAlignment(ComboBox10.ItemIndex);
end;

procedure TAdvChartPanesEditorForm.ComboBox11Change(Sender: TObject);
begin
  pn.Title.Position := TTitlePosition(ComboBox11.ItemIndex);
end;

procedure TAdvChartPanesEditorForm.ComboBox12Change(Sender: TObject);
begin
  pn.XAxis.Alignment := TAlignment(ComboBox12.ItemIndex);
end;

procedure TAdvChartPanesEditorForm.ComboBox13Change(Sender: TObject);
begin
  pn.XAxis.GradientDirection := TChartGradientDirection(ComboBox13.ItemIndex);
end;

procedure TAdvChartPanesEditorForm.ComboBox14Change(Sender: TObject);
begin
  pn.XAxis.Position := TChartXAxisPosition(ComboBox14.ItemIndex);
end;

procedure TAdvChartPanesEditorForm.ComboBox15Change(Sender: TObject);
begin
  pn.XAxis.UnitType := TChartUnitType(ComboBox15.ItemIndex);
end;

procedure TAdvChartPanesEditorForm.ComboBox16Change(Sender: TObject);
begin
  pn.YAxis.Alignment := TAlignment(ComboBox16.ItemIndex);
end;

procedure TAdvChartPanesEditorForm.ComboBox17Change(Sender: TObject);
begin
  pn.YAxis.GradientDirection := TChartGradientDirection(ComboBox17.ItemIndex);
end;

procedure TAdvChartPanesEditorForm.ComboBox18Change(Sender: TObject);
begin
  pn.YAxis.Position := TChartYAxisPosition(ComboBox18.ItemIndex);
end;

procedure TAdvChartPanesEditorForm.ComboBox19Change(Sender: TObject);
begin
  pn.Bands.SerieIndex := ComboBox19.ItemIndex;
  UpdatePreviewBands;  
end;

procedure TAdvChartPanesEditorForm.ComboBox1Change(Sender: TObject);
begin
  pn.BackGround.GradientDirection := TChartGradientDirection(ComboBox1.ItemIndex);
end;

procedure TAdvChartPanesEditorForm.ComboBox20Change(Sender: TObject);
begin
  pn.YGrid.SerieIndex := ComboBox20.ItemIndex;
end;

procedure TAdvChartPanesEditorForm.ComboBox21Change(Sender: TObject);
begin
  pn.Title.GradientDirection := TChartGradientDirection(ComboBox21.ItemIndex);
end;

procedure TAdvChartPanesEditorForm.ComboBox22Change(Sender: TObject);
begin
  pn.Legend.BackGroundPosition := TChartBackgroundPosition(ComboBox22.ItemIndex);
end;

procedure TAdvChartPanesEditorForm.ComboBox23Change(Sender: TObject);
begin
  pn.AxisMode := TchartAxisMode(ComboBox23.ItemIndex);
end;

procedure TAdvChartPanesEditorForm.ComboBox24Change(Sender: TObject);
begin
  pn.Series.DonutMode := TChartSeriesDonutMode(ComboBox24.ItemIndex);
end;

procedure TAdvChartPanesEditorForm.ComboBox25Change(Sender: TObject);
begin
  pn.Series.BarChartSpacingType := TChartSerieValueWidthType(ComboBox25.ItemIndex);
end;

procedure TAdvChartPanesEditorForm.ComboBox26Change(Sender: TObject);
begin
  TCrackedChartPane(pn).DS := TComponent(ComboBox26.Items.Objects[ComboBox26.ItemIndex]);
end;

procedure TAdvChartPanesEditorForm.ComboBox27Change(Sender: TObject);
begin
  pn.Legend.Alignment := TChartLegendAlignment(ComboBox27.ItemIndex);
end;

procedure TAdvChartPanesEditorForm.ComboBox2Change(Sender: TObject);
begin
  pn.BackGround.BackGroundPosition := TChartBackgroundPosition(ComboBox2.ItemIndex);
end;

procedure TAdvChartPanesEditorForm.ComboBox3Change(Sender: TObject);
begin
  pn.Bands.GradientDirection := TChartGradientDirection(ComboBox3.ItemIndex);
  UpdatePreviewBands;  
end;

procedure TAdvChartPanesEditorForm.ComboBox4Change(Sender: TObject);
begin
  pn.BorderStyle := TBorderStyle(ComboBox4.ItemIndex);
end;

procedure TAdvChartPanesEditorForm.ComboBox5Change(Sender: TObject);
begin
  pn.HeightType := TPaneHeightType(ComboBox5.ItemIndex);
end;

procedure TAdvChartPanesEditorForm.ComboBox6Change(Sender: TObject);
begin
  pn.CrossHair.CrossHairType := TChartCrossHairType(ComboBox6.ItemIndex);
end;

procedure TAdvChartPanesEditorForm.ComboBox7Change(Sender: TObject);
begin
  pn.Legend.GradientDirection := TChartGradientDirection(ComboBox7.ItemIndex);
  UpdatePreviewLegend;
end;

procedure TAdvChartPanesEditorForm.ComboBox8Change(Sender: TObject);
begin
  pn.Navigator.GradientDirection := TChartGradientDirection(ComboBox8.ItemIndex);
  UpdatePreviewNavigator;
end;

procedure TAdvChartPanesEditorForm.ComboBox9Change(Sender: TObject);
begin
  pn.Splitter.GradientDirection := TChartGradientDirection(ComboBox9.ItemIndex);
end;

procedure TAdvChartPanesEditorForm.CorrectTop(lbl: TLabel);
begin
  lbl.Top := Round(lbl.Tag - (lbl.Font.Size - 8) / 2);
end;

procedure TAdvChartPanesEditorForm.ApplyChanges(Sender: TObject);
begin
  SaveChanges;
end;

procedure TAdvChartPanesEditorForm.Edit2Change(Sender: TObject);
begin
  pn.Title.Text := Edit2.Text;
end;

procedure TAdvChartPanesEditorForm.Edit3Change(Sender: TObject);
begin
  pn.XAxis.Text := edit3.Text;
end;

procedure TAdvChartPanesEditorForm.Edit4Change(Sender: TObject);
begin
  pn.YAxis.Text := edit4.Text;
end;

procedure TAdvChartPanesEditorForm.FormClose(Sender: TObject;
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
    col.free;
  end;
end;

procedure TAdvChartPanesEditorForm.FormCreate(Sender: TObject);
begin
  {$IFDEF DELPHI9_LVL}
  DoubleBuffered := true;
  {$ENDIF}
  DTB.Visible := false;
  selpane := -1;
end;

procedure TAdvChartPanesEditorForm.FormKeyUp(Sender: TObject; var Key: Word;
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

procedure TAdvChartPanesEditorForm.Image1Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    pn.BackGround.Picture.Assign(Image1.Picture);
    TAdvChartView((pn.Collection as TChartPanes).Owner).Invalidate;
  end;
end;

procedure TAdvChartPanesEditorForm.Image2Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    Image2.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    pn.Navigator.ScrollButtonLeft.Assign(Image2.Picture);
  end;
  UpdatePreviewNavigator;
end;

procedure TAdvChartPanesEditorForm.Image3Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    Image3.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    pn.Navigator.ScrollButtonLeftHot.Assign(Image3.Picture);
  end;
  UpdatePreviewNavigator;
end;

procedure TAdvChartPanesEditorForm.Image4Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    Image4.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    pn.Navigator.ScrollButtonLeftDown.Assign(Image4.Picture);
  end;
  UpdatePreviewNavigator;
end;

procedure TAdvChartPanesEditorForm.Image5Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    Image5.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    pn.Navigator.ScrollButtonRightDown.Assign(Image5.Picture);
  end;
  UpdatePreviewNavigator;
end;

procedure TAdvChartPanesEditorForm.Image6Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    Image6.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    pn.Navigator.ScrollButtonRightHot.Assign(Image6.Picture);
  end;
  UpdatePreviewNavigator;
end;

procedure TAdvChartPanesEditorForm.Image7Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    Image7.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    pn.Navigator.ScrollButtonRight.Assign(Image7.Picture);
  end;
  UpdatePreviewNavigator;
end;

procedure TAdvChartPanesEditorForm.Image8Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    Image8.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    pn.Legend.Picture.Assign(Image8.Picture);
  end;
  UpdatePreviewLegend;
end;

procedure TAdvChartPanesEditorForm.InitListBox;
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
procedure TAdvChartPanesEditorForm.Init;
var
  I: Integer;
//  view: TAdvChartView;
begin
  PageControl1.ActivePageIndex := 0;
//  view := TAdvChartView.Create(Self);

  //showmessage(FChartView.ClassName);

  col := FChartview.GetPanesClass.Create(FChartView);
  
//  col := TChartPanes.Create(FChartView);
  ListBox1.Items.Clear;
  for i := 0 to ChartPanes.Count - 1 do
  begin
    col.Add;
    col[i].Assign(ChartPanes[i]);
  end;

  InitListBox;
end;

procedure TAdvChartPanesEditorForm.ListBox1Click(Sender: TObject);
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
          ComboBox26.Items.Clear;
          sl := TCrackedChartPane(pn).GetDSNames;
          ComboBox26.Items.Assign(sl);
          sl.Free;
        end
        else
          DTB.TabVisible := false;
      end;
    end;

    selpane := listbox1.ItemIndex;

    if Assigned(TCrackedChartPane(pn).DS) then
      ComboBox26.Text := TCrackedChartPane(pn).DS.Name;

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
    ComboBox1.ItemIndex := Integer(pn.BackGround.GradientDirection);
    SpinEdit4.Value := pn.BackGround.GradientSteps;
    Image1.Picture.Assign(pn.BackGround.Picture);
    ComboBox2.ItemIndex := Integer(pn.BackGround.BackGroundPosition);
    CheckBox2.Checked := pn.BackGround.PictureVisible;
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
    AdvColorSelector10.SelectedColor := pn.Legend.Color;
    AdvColorSelector11.SelectedColor := pn.Legend.Colorto;
    SpinEdit15.Value := pn.Legend.GradientSteps;
    ComboBox7.ItemIndex := Integer(pn.Legend.GradientDirection);
    SpinEdit17.Value := pn.Legend.RectangleSize;
    SpinEdit18.Value := pn.Legend.RectangleSpacing;
    SpinEdit19.Value := pn.Legend.Left;
    SpinEdit20.Value := pn.Legend.Top;
    CheckBox15.Checked := pn.Legend.Visible;
    //NAVIGATOR
    CheckBox16.Checked := pn.Navigator.AlphaBlend;
    SpinEdit21.Value := pn.Navigator.AlphaBlendValue;
    Advcolorselector12.SelectedColor := pn.Navigator.Color;
    Advcolorselector13.SelectedColor := pn.Navigator.ColorTo;
    AdvChartSpinEdit5.Value := pn.Navigator.ScrollStep;
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
    CheckBox34.Checked := pn.YAxis.AutoSize;
    CheckBox33.Checked := pn.XAxis.AutoSize;
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

    CheckBox29.Checked := pn.Chart.Series.SerieValueTotals;
    ComboBox24.ItemIndex := Integer(pn.Chart.Series.DonutMode);
    ComboBox27.ItemIndex := Integer(pn.Legend.Alignment);
    AdvChartSpinEdit1.Value := pn.Chart.Series.BarChartSpacing;
    ComboBox25.ItemIndex := Integer(pn.Chart.Series.BarChartSpacingType);
    CheckBox30.Checked := pn.Series.ChartMode = dmHorizontal;


    AdvChartSpinEdit2.Value := pn.XAxis.Offset3D;
    CheckBox32.Checked := pn.XAxis.Enable3D;
    CheckBox31.Checked := pn.XAxis.Darken3D;

    AdvChartSpinEdit24.Value := pn.YAxis.Offset3D;
    CheckBox35.Checked := pn.YAxis.Enable3D;
    CheckBox36.Checked := pn.YAxis.Darken3D;
    CheckBox37.Checked := pn.Chart.XScaleOffset;

    Label133.font.Assign(pn.legend.Font);
    Label134.font.Assign(pn.Title.font);
    label136.font.assign(pn.Xaxis.font);
    label138.font.assign(pn.YAxis.font);
    label139.font.assign(pn.XGrid.MinorFont);
    label140.font.assign(pn.XGrid.MajorFont);
    CorrectTop(label133);
    CorrectTop(label134);
    CorrectTop(label136);
    CorrectTop(label138);
    CorrectTop(label139);
    CorrectTop(label140);


    UpdatePreviewNavigator;
    UpdatePreviewLegend;
    UpdatePreviewBands;

  end;

end;

procedure TAdvChartPanesEditorForm.ListBox1DblClick(Sender: TObject);
begin
  if SpeedButton4.Enabled then
    StartSerieEditor;
end;

procedure TAdvChartPanesEditorForm.ListBox1DragDrop(Sender, Source: TObject; X,
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

procedure TAdvChartPanesEditorForm.ListBox1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := (Source = ListBox1) and FAllowR;
end;

procedure TAdvChartPanesEditorForm.ListBox1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   StartingPoint.X := X;
   StartingPoint.Y := Y;
end;

procedure TAdvChartPanesEditorForm.PageControl1Change(Sender: TObject);
begin
  if (Sender as TPageControl).ActivePageIndex = TabSheet5.PageIndex then
    UpdatePreviewNavigator;

  if (Sender as TPageControl).ActivePageIndex = TabSheet4.PageIndex then
    UpdatePreviewLegend;

  if (Sender as TPageControl).ActivePageIndex = TabSheet7.PageIndex then
    UpdatePreviewBands;
  
end;

procedure TAdvChartPanesEditorForm.SaveChanges;
var
  i: integer;
begin
  (ChartPanes.Owner as TAdvChartView).BeginUpdate;

  ChartPanes.Clear;
  for I := 0 to col.Count - 1 do
  begin
    ChartPanes.Add;
    ChartPanes[I].Assign(col[I]);
  end;

  (ChartPanes.Owner as TAdvChartView).EndUpdate;
end;

procedure TAdvChartPanesEditorForm.SpeedButton1Click(Sender: TObject);
begin
  if listbox1.ItemIndex >= 0 then
  begin
    Col[ListBox1.ItemIndex].Free;
    InitListBox;
  end;
end;

procedure TAdvChartPanesEditorForm.SpeedButton2Click(Sender: TObject);
begin
  Col.Add;
  InitListBox;
end;

procedure TAdvChartPanesEditorForm.SpeedButton3Click(Sender: TObject);
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

procedure TAdvChartPanesEditorForm.SpeedButton4Click(Sender: TObject);
begin
  StartSerieEditor;
end;

procedure TAdvChartPanesEditorForm.SpinEdit10Change(Sender: TObject);
begin
  pn.Range.RangeTo := SpinEdit10.Value;
end;

procedure TAdvChartPanesEditorForm.SpinEdit11Change(Sender: TObject);
begin
  pn.Margin.LeftMargin := SpinEdit11.Value;
end;

procedure TAdvChartPanesEditorForm.SpinEdit12Change(Sender: TObject);
begin
  pn.Margin.TopMargin := SpinEdit12.Value;
end;

procedure TAdvChartPanesEditorForm.SpinEdit13Change(Sender: TObject);
begin
  pn.Margin.RightMargin := spinEdit13.Value;
end;

procedure TAdvChartPanesEditorForm.SpinEdit14Change(Sender: TObject);
begin
  pn.Margin.BottomMargin := SpinEdit14.Value;
end;

procedure TAdvChartPanesEditorForm.SpinEdit15Change(Sender: TObject);
begin
  pn.Legend.GradientSteps := SpinEdit15.Value;
  UpdatePreviewLegend;
end;

procedure TAdvChartPanesEditorForm.SpinEdit16Change(Sender: TObject);
begin
  pn.Legend.BorderWidth := SpinEdit16.Value;
  UpdatePreviewLegend;
end;

procedure TAdvChartPanesEditorForm.SpinEdit17Change(Sender: TObject);
begin
  pn.Legend.RectangleSize := SpinEdit17.Value;
  UpdatePreviewLegend;
end;

procedure TAdvChartPanesEditorForm.SpinEdit18Change(Sender: TObject);
begin
  pn.Legend.RectangleSpacing := SpinEdit18.value;
  UpdatePreviewLegend;
end;

procedure TAdvChartPanesEditorForm.SpinEdit19Change(Sender: TObject);
begin
  pn.Legend.Left := SpinEdit19.Value;
  UpdatePreviewLegend;
end;

procedure TAdvChartPanesEditorForm.SpinEdit1Change(Sender: TObject);
begin
  pn.Bands.Distance := SpinEdit1.Value;
  UpdatePreviewBands;
end;

procedure TAdvChartPanesEditorForm.SpinEdit20Change(Sender: TObject);
begin
  pn.Legend.Top := SpinEdit20.Value;
  UpdatePreviewLegend;
end;

procedure TAdvChartPanesEditorForm.SpinEdit21Change(Sender: TObject);
begin
  pn.Navigator.AlphaBlendValue := SpinEdit21.Value;
  UpdatePreviewNavigator;  
end;

procedure TAdvChartPanesEditorForm.SpinEdit22Change(Sender: TObject);
begin
  pn.Navigator.GradientSteps := SpinEdit22.Value;
  UpdatePreviewNavigator;
end;

procedure TAdvChartPanesEditorForm.SpinEdit23Change(Sender: TObject);
begin
  pn.Navigator.ScrollButtonsSize := SpinEdit23.Value;
  UpdatePreviewNavigator;
end;

procedure TAdvChartPanesEditorForm.SpinEdit24Change(Sender: TObject);
begin
  pn.Navigator.Size := SpinEdit24.Value;
  UpdatePreviewNavigator;
end;

procedure TAdvChartPanesEditorForm.SpinEdit25Change(Sender: TObject);
begin
  pn.Splitter.GradientSteps := SpinEdit25.Value;
end;

procedure TAdvChartPanesEditorForm.SpinEdit26Change(Sender: TObject);
begin
  pn.Splitter.LineWidth := SpinEdit26.Value;
end;

procedure TAdvChartPanesEditorForm.SpinEdit27Change(Sender: TObject);
begin
  pn.Splitter.Height := SPinEdit27.Value;
end;

procedure TAdvChartPanesEditorForm.SpinEdit28Change(Sender: TObject);
begin
  pn.Title.Size := SpinEdit28.Value;
end;

procedure TAdvChartPanesEditorForm.SpinEdit29Change(Sender: TObject);
begin
  pn.XAxis.GradientSteps := SpinEdit29.Value;
end;

procedure TAdvChartPanesEditorForm.SpinEdit2Change(Sender: TObject);
begin
  pn.Bands.GradientSteps := SpinEdit2.Value;
  UpdatePreviewBands;
end;

procedure TAdvChartPanesEditorForm.SpinEdit30Change(Sender: TObject);
begin
  pn.XAxis.LineWidth := SpinEdit30.Value;
end;

procedure TAdvChartPanesEditorForm.SpinEdit31Change(Sender: TObject);
begin
  pn.XAxis.Size := spinEdit31.Value;
end;

procedure TAdvChartPanesEditorForm.SpinEdit32Change(Sender: TObject);
begin
  pn.YAxis.GradientSteps := SpinEdit32.Value;
end;

procedure TAdvChartPanesEditorForm.SpinEdit33Change(Sender: TObject);
begin
  pn.YAxis.LineWidth := SpinEdit33.Value;
end;

procedure TAdvChartPanesEditorForm.SpinEdit34Change(Sender: TObject);
begin
  pn.YAxis.Size := spinEdit34.Value;
end;

procedure TAdvChartPanesEditorForm.SpinEdit35Change(Sender: TObject);
begin
  pn.XGrid.MinorDistance := SpinEdit35.Value;
end;

procedure TAdvChartPanesEditorForm.SpinEdit36Change(Sender: TObject);
begin
  pn.XGrid.MajorDistance := SpinEdit36.Value;
end;

procedure TAdvChartPanesEditorForm.SpinEdit37Change(Sender: TObject);
begin
  pn.Xgrid.MinorLineWidth := SpinEdit37.Value;
end;

procedure TAdvChartPanesEditorForm.SpinEdit38Change(Sender: TObject);
begin
  pn.XGrid.MajorLineWidth := SpinEdit38.Value;
end;

procedure TAdvChartPanesEditorForm.SpinEdit39Change(Sender: TObject);
begin
  pn.Title.BorderWidth := SpinEdit39.Value;
end;

procedure TAdvChartPanesEditorForm.SpinEdit3Change(Sender: TObject);
begin
  pn.Title.GradientSteps := SpinEdit3.Value;
end;

procedure TAdvChartPanesEditorForm.SpinEdit40Change(Sender: TObject);
begin
  pn.Legend.BorderRounding := SpinEdit40.Value;
  UpdatePreviewLegend;
end;

procedure TAdvChartPanesEditorForm.SpinEdit41Change(Sender: TObject);
begin
  pn.YGrid.MinorLineWidth := SpinEdit41.Value;
end;

procedure TAdvChartPanesEditorForm.SpinEdit42Change(Sender: TObject);
begin
  pn.YGrid.MajorLineWidth := SpinEdit42.Value;
end;

procedure TAdvChartPanesEditorForm.SpinEdit4Change(Sender: TObject);
begin
  pn.BackGround.GradientSteps := SpinEdit4.Value;
end;

procedure TAdvChartPanesEditorForm.SpinEdit5Change(Sender: TObject);
begin
  pn.BorderWidth := SpinEdit5.Value;
end;

procedure TAdvChartPanesEditorForm.SpinEdit6Change(Sender: TObject);
begin
  pn.Height := SpinEdit6.Value;
end;

procedure TAdvChartPanesEditorForm.SpinEdit7Change(Sender: TObject);
begin
  pn.CrossHair.Distance := SpinEdit7.Value;
end;

procedure TAdvChartPanesEditorForm.SpinEdit8Change(Sender: TObject);
begin
  pn.CrossHair.LineWidth := SpinEdit8.Value;
end;

procedure TAdvChartPanesEditorForm.SpinEdit9Change(Sender: TObject);
begin
  pn.Range.RangeFrom := SpinEdit9.Value;
end;

procedure TAdvChartPanesEditorForm.UpdatePreviewBands;
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

procedure TAdvChartPanesEditorForm.UpdatePreviewLegend;
begin
  PatBlt(PaintBox1.Canvas.Handle,0,0,PaintBox1.ClientWidth,PaintBox1.ClientHeight,WHITENESS);
  pn.Legend.Draw(PaintBox1.Canvas, PaintBox1.ClientRect, 1, 1);
end;

procedure TAdvChartPanesEditorForm.UpdatePreviewNavigator;
begin
  PatBlt(PaintBox2.Canvas.Handle,0,0,PaintBox2.ClientWidth,PaintBox2.ClientHeight,WHITENESS);
  pn.Navigator.Draw(PaintBox2.Canvas, PaintBox2.ClientRect, 1, 1);
end;

{ TAdvChartPaneEditorDialog }

constructor TAdvChartPanesEditorDialog.Create(AOwner: TComponent);
begin
  inherited;
  FAllowPaneRemoving := true;
  FAllowNameChange := true;
  FAllowPaneReorder := true;
  FAllowPaneAdding := true;
  FAllowSerieEditing := true;
end;

function TAdvChartPanesEditorDialog.Execute: Boolean;
begin
  FForm := TAdvChartPanesEditorForm.Create(Application);

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
end;

procedure TAdvChartPanesEditorDialog.Notification(AComponent: TComponent;
  AOperation: TOperation);
begin
  inherited;
  if (AComponent = FChartView) and (AOperation = opRemove) then
    FChartView := nil;
end;

procedure TAdvChartPanesEditorDialog.SetChartView(const Value: TAdvChartView);
begin
  FChartView := Value;
end;

procedure TAdvChartPanesEditorForm.StartSerieEditor;
var
  ac: TAdvChartSeriesEditorForm;
begin
  if ListBox1.Items.Count <> 0 then
  begin
    ac := TAdvChartSeriesEditorForm.Create(Self);
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
