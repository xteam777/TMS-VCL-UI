{********************************************************************}
{ written by TMS Software                                            }
{            copyright (c) 2016 - 2021                               }
{            Email : info@tmssoftware.com                            }
{            Web : https://www.tmssoftware.com                       }
{                                                                    }
{ The source code is given as is. The author is not responsible      }
{ for any possible damage done due to the use of this code.          }
{ The complete source code remains property of the author and may    }
{ not be distributed, published, given or sold in any form as such.  }
{ No parts of the source code can be included in any other component }
{ or application without written authorization of the author.        }
{********************************************************************}

unit AdvChartEdit;

{$I TMSDEFS.inc}

{$IFDEF CMNLIB}
{$DEFINE CMNWEBLIB}
{$ENDIF}
{$IFDEF WEBLIB}
{$DEFINE CMNWEBLIB}
{$ENDIF}

interface

uses
  Classes, AdvChartToolBar, {%H-}AdvChartToolBarRes, AdvChartCustomControl, AdvChartTypes,
  AdvChartPopup, ExtCtrls, StdCtrls, Graphics, Controls, AdvChartGraphicsTypes,
  AdvChartBitmapContainer
  {$IFDEF FMXLIB}
  ,FMX.ListBox, FMX.Edit, FMX.Types
  {$ENDIF}
  {$IFNDEF WEBLIB}
  {$IFNDEF LCLLIB}
  ,UITypes, Generics.Collections
  {$ENDIF}
  {$ENDIF}
  {$IFDEF LCLLIB}
  ,fgl
  {$ENDIF}
  ;

const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 0; // Minor version nr.
  REL_VER = 3; // Release nr.
  BLD_VER = 0; // Build nr.

  // version history
  // v1.0.0.0 : first release
  // v1.0.0.1 : Fixed: Issue with typing '-' with signedfloat when text is selected
  // v1.0.0.2 : Fixed: Issue with etSignedNumeric handling
  // v1.0.1.0 : New : UseValueList boolean to switch between Value and Display list when using the lookup functionality
  // v1.0.2.0 : New : MinimumWidth and MinimumHeight properties to defined lookup dropdown minimum size
  //          : Fixed : Issue with escape and exiting control closing lookup window
  // v1.0.2.1 : Fixed : Issue with calculating size of lookup items
  // v1.0.2.2 : Fixed : Issue selecting lookup item entry with mouse
  // v1.0.2.3 : Fixed : Issue with lookup on RAD Studio 10.2 Tokyo
  // v1.0.2.4 : Improved : DisplayLookup method to display all values from the displaylist
  // v1.0.2.5 : New : LiveBindings Support
  // v1.0.2.6 : Fixed : Issue with binding only working on Windows
  // v1.0.2.7 : Fixed : Issue with copy & paste actions on VCL
  // v1.0.2.8 : Fixed : Behaviour of closing popup when focusing other control and moving parent form
  // v1.0.2.9 : Fixed : Issue with editing on TMS WEB Core
  // v1.0.2.10: Fixed : Issue with signed / unsigned numeric and thousand separators.
  // v1.0.2.11: Fixed : Issue with float type precision.
  // v1.0.2.12: Fixed : Issue with autocomplete and special characters
  // v1.0.3.0 : New : Support for high dpi

const
  LOOKUPITEMHEIGHT = 18;

type
  TAdvChartEditType = (etString, etNumeric, etSignedNumeric, etFloat, etSignedFloat, etUppercase, etMixedCase, etLowerCase,
    etMoney, etHex, etAlphaNumeric, etValidChars);

  TAdvChartEditPrecisionDisplay = (pdNormal, pdShortest);

  TAdvChartEdit = class;

  TAdvChartEditLookupSettings = class(TPersistent)
  private
    FDisplayList: TStringList;
    FValueList: TStringList;
    FDisplayCount: Integer;
    FColor: TAdvChartGraphicsColor;
    FEnabled: Boolean;
    FNumChars: Integer;
    FCaseSensitive: Boolean;
    FHistory: Boolean;
    FMulti: Boolean;
    FSeparator: char;
    FAcceptOnTab: Boolean;
    FWidth: Integer;
    FHeight: Integer;
    FUseValueList: Boolean;
    FMinimumWidth: Integer;
    FMinimumHeight: Integer;
    procedure SetDisplayList(const Value: TStringList);
    procedure SetValueList(const Value: TStringList);
    procedure SetNumChars(const Value: Integer);
    procedure SetHeight(const Value: Integer);
    procedure SetWidth(const Value: Integer);
    procedure SetMinimumHeight(const Value: Integer);
    procedure SetMinimumWidth(const Value: Integer);
  protected
    property AcceptOnTab: boolean read FAcceptOnTab write FAcceptOnTab default False;
    property Color: TAdvChartGraphicsColor read FColor write FColor default gcWhite;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property CaseSensitive: Boolean read FCaseSensitive write FCaseSensitive default False;
    property DisplayCount: Integer read FDisplayCount write FDisplayCount default 4;
    property DisplayList: TStringList read FDisplayList write SetDisplayList;
    property Enabled: Boolean read FEnabled write FEnabled default False;
    property History: Boolean read FHistory write FHistory default False;
    property NumChars: Integer read FNumChars write SetNumChars default 2;
    property ValueList: TStringList read FValueList write SetValueList;
    property Multi: Boolean read FMulti write FMulti default False;
    property Separator: char read FSeparator write FSeparator;
    property Width: Integer read FWidth write SetWidth default 0;
    property Height: Integer read FHeight write SetHeight default 0;
    property MinimumWidth: Integer read FMinimumWidth write SetMinimumWidth default 0;
    property MinimumHeight: Integer read FMinimumHeight write SetMinimumHeight default 0;
    property UseValueList: Boolean read FUseValueList write FUseValueList default True;
  end;

  TAdvChartEditLookupSelectEvent = procedure(Sender: TObject; var Value: string) of object;
  TAdvChartEditLookupIndexSelectEvent = procedure(Sender: TObject; Index: Integer; var Value: string) of object;
  TAdvChartEditLookupNeedDataEvent = procedure(Sender: TObject; Value: string; List: TStrings; var ItemIndex: integer) of object;

  TAdvChartEditHexCharacterArray = array of char;

  TAdvLookupListBoxItem = class
  private
    FIdx: Integer;
  public
    constructor Create(AIdx: Integer);
    property Idx: Integer read FIdx;
  end;

  {$IFDEF WEBLIB}
  TAdvLookupList = class(TList);
  {$ENDIF}
  {$IFNDEF WEBLIB}
  TAdvLookupList = class(TList<TAdvLookupListBoxItem>);
  {$ENDIF}

  {$IFNDEF LCLLIB}
  [ComponentPlatformsAttribute(TMSPlatformsWeb)]
  {$ENDIF}
  TAdvChartEdit = class(TCustomEdit)
  private
    FLookupListBoxItems: TAdvLookupList;
    {$IFDEF CMNWEBLIB}
    FAllowFocus: Boolean;
    {$ENDIF}
    {$IFDEF FMXLIB}
    FDoneLookupTimer: TTimer;
    {$ENDIF}
    {$IFDEF VCLLIB}
    FInitialize: Boolean;
    {$ENDIF}
    FLookupFormTimer: TTimer;
    FKeyDown: Word;
    FShiftState: TShiftState;
    FEditType: TAdvChartEditType;
    FValidChars: string;
    FLookupList: TAdvChartPopup;
    FLookupListBox: TListBox;
    FLookup: TAdvChartEditLookupSettings;
    FOnLookupSelect: TAdvChartEditLookupSelectEvent;
    FOnLookupIndexSelect: TAdvChartEditLookupIndexSelectEvent;
    FSigned: Boolean;
    FPrefix: string;
    FSuffix: string;
    FIsModified: Boolean;
    FLengthLimit: smallint;
    FFullTextSearch: boolean;
    FAutoThousandSeparator: Boolean;
    FPrecision: smallint;
    FPrecisionDisplay: TAdvChartEditPrecisionDisplay;
    FBlockChange: Boolean;
    FAllowNumericNullValue: Boolean;
    FAutoComplete: Boolean;
    FOnCloseWithEscape: TNotifyEvent;
    FOnLookupNeedData: TAdvChartEditLookupNeedDataEvent;
    FAutoClose: Boolean;
    FOnLookupClose: TNotifyEvent;
    FOnLookupOpen: TNotifyEvent;
    procedure CloseLookup;
    procedure DoneLookup;
    procedure UpdateLookup;
    procedure UpdateAutoComplete;
    procedure SetLookup(const Value: TAdvChartEditLookupSettings);
    function AllowMin(ch: char): boolean;
    function FixedLength(s: string): Integer;
    procedure SetPrefix(const Value: string);
    procedure SetSuffix(const Value: string);
    procedure SetModified(const Value: Boolean);
    function DecimalPos: Integer;
    procedure AutoSeparators;
    function GetFloat: double;
    procedure SetFloat(const Value: double);
    procedure SetAutoThousandSeparator(const Value: Boolean);
    procedure SetPrecision(const Value: smallint);
    procedure SetPrecisionDisplay(const Value: TAdvChartEditPrecisionDisplay);
    function EStrToFloat(s: string): extended;
    function GetInt: Integer;
    procedure SetInt(const Value: Integer);
    procedure SetEditType(const Value: TAdvChartEditType);
    function IsLookupListVisible: Boolean;
    function GetAllowFocus: Boolean;
    procedure SetAllowFocus(const Value: Boolean);
  protected
    {$IFDEF WEBLIB}
    class function GetVersionNumber(AMaj, AMin, ARel, ABld: ShortInt): string;
    function Validate(AValue: string): boolean; override;
    {$ENDIF}
    function GetVersion: String; virtual;
    procedure DoLookupFormTimer(Sender: TObject);
    {$IFDEF FMXLIB}
    procedure DoDoneLookupTimer(Sender: TObject);
    function GetDefaultStyleLookupName: string; override;
    {$ENDIF}
    function GetT: string; virtual;
    function GetCaretPosition: Integer; virtual;
    {$IFDEF FMXLIB}
    procedure Change; virtual;
    {$ENDIF}
    {$IFDEF LCLLIB}
    function ChildClassAllowed(ChildClass: TClass): boolean; override;
    {$ENDIF}
    {$IFDEF VCLLIB}
    {$HINTS OFF}
    {$IF COMPILERVERSION > 30}
    procedure ChangeScale(M, D: Integer; isDpiChange: Boolean); override;
    {$ELSE}
    procedure ChangeScale(M, D: Integer); override;
    {$IFEND}
    {$HINTS ON}
    {$ENDIF}
    procedure CleanupLookupList;
    procedure SetCaretPosition(ACaretPosition: Integer); virtual;
    procedure SetT(const Value: string); virtual;
    procedure InsertText(const AText: string);
    {$IFDEF FMXLIB}
    procedure ListKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure ListMouseUp(Sender: TObject; Button: TAdvMouseButton; Shift: TShiftState; X, Y: Single);
    procedure KeyDown(var Key: Word; var KeyChar: WideChar; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; var KeyChar: WideChar; Shift: TShiftState); override;
    {$ENDIF}
    {$IFDEF CMNWEBLIB}
    procedure ListKeyUp(Sender: TObject; var Key: Word; {%H-}Shift: TShiftState);
    procedure ListMouseUp(Sender: TObject; {%H-}Button: TAdvMouseButton; {%H-}Shift: TShiftState; {%H-}X, {%H-}Y: Integer);
    procedure KeyPress(var Key: Char); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    {$ENDIF}
    procedure DoLookupNeedData(Value: string; List: TStrings; var ItemIndex: integer); virtual;
    procedure DoLookupOpen; virtual;
    procedure DoLookupClose; virtual;
    procedure DoExit; override;
    property OnCloseWithEscape: TNotifyEvent read FOnCloseWithEscape write FOnCloseWithEscape;
    property Signed: Boolean read FSigned write FSigned default False;
    property Prefix: string read FPrefix write SetPrefix;
    property Suffix: string read FSuffix write SetSuffix;
    property AutoClose: Boolean read FAutoClose write FAutoClose default True;
  public
    function LookupListbox: TListBox;
    function LookupList: TAdvChartPopup;
    {$IFDEF CMNWEBLIB}
    function CanFocus: Boolean; override;
    {$ENDIF}
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DisplayLookup;
    property Modified: Boolean read FIsModified write SetModified;
    property FloatValue: double read GetFloat write SetFloat;
    property IntValue: Integer read GetInt write SetInt;
    {$IFNDEF WEBLIB}
    property Action;
    {$ENDIF}
  published
    property AllowFocus: Boolean read GetAllowFocus write SetAllowFocus default True;
    {$IFDEF FMXLIB}
    property Cursor default crIBeam;
    property CanParentFocus;
    property DisableFocusEffect;
    property KeyboardType;
    property ReturnKeyType;
    property Password;
    property ReadOnly;
    property TextSettings;
    property ImeMode;
    property Position;
    property Width;
    property Height;
    property ClipChildren default False;
    property ClipParent default False;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property HitTest default True;
    property Hint;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    {$WARNINGS OFF}
    {$HINTS OFF}
    {$IF COMPILERVERSION > 27}
    property Size;
    {$IFEND}
    {$HINTS ON}
    {$WARNINGS ON}
    property TextPrompt;
    property StyleLookup;
    property StyledSettings;
    property TouchTargetExpansion;
    property Visible default True;
    property Caret;
    property ShowHint;
    property KillFocusByReturn;
    property CheckSpelling;
    property OnChange;
    property OnChangeTracking;
    property OnTyping;
    property OnApplyStyleLookup;
    property OnValidating;
    property OnValidate;
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    property OnKeyDown;
    property OnKeyUp;
    property OnCanFocus;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnPainting;
    property OnPaint;
    property OnResize;
    {$ENDIF}
    {$IFDEF CMNWEBLIB}
    property Align;
    property Alignment;
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property Hint;
    {$IFDEF LCLLIB}
    property BorderSpacing;
    {$ENDIF}
    {$IFDEF WEBLIB}
    property TextHint;
    {$ENDIF}
    {$IFDEF VCLLIB}
    property BevelEdges;
    property BevelInner;
    property BevelKind default bkNone;
    property BevelOuter;
    property BevelWidth;
    property Ctl3D;
    property ImeMode;
    property ImeName;
    property OEMConvert;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property TextHint;
    property Touch;
    {$HINTS OFF}
    {$IF COMPILERVERSION > 23}
    property StyleElements;
    {$IFEND}
    {$HINTS ON}
    property OnGesture;
    property OnMouseActivate;
    {$ENDIF}
    {$IFNDEF WEBLIB}
    property BiDiMode;
    {$ENDIF}
    property BorderStyle;
    property Color;
    {$IFNDEF WEBLIB}
    property Constraints;
    {$ENDIF}
    property DoubleBuffered;
    {$IFNDEF WEBLIB}
    property DragCursor;
    property DragKind;
    property DragMode;
    {$ENDIF}
    property Enabled;
    property Font;
    property HideSelection;
    property MaxLength;
    {$IFNDEF WEBLIB}
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    {$ENDIF}
    property PasswordChar;
    {$IFNDEF WEBLIB}
    property PopupMenu;
    {$ENDIF}
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick;
    {$IFNDEF WEBLIB}
    property OnContextPopup;
    {$ENDIF}
    property OnDblClick;
    {$IFNDEF WEBLIB}
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    {$ENDIF}
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    {$IFNDEF WEBLIB}
    property OnStartDock;
    property OnStartDrag;
    {$ENDIF}
    {$ENDIF}        

    property Text: string read GetT write SetT;
    property Version: String read GetVersion;
    property AutoComplete: Boolean read FAutoComplete write FAutoComplete default False;
    property EditType: TAdvChartEditType read FEditType write SetEditType default etString;
    property Lookup: TAdvChartEditLookupSettings read FLookup write SetLookup;
    property ValidChars: string read FValidChars write FValidChars;
    property AllowNumericNullValue: Boolean read FAllowNumericNullValue write FAllowNumericNullValue default False;
    property AutoThousandSeparator: Boolean read FAutoThousandSeparator write SetAutoThousandSeparator default True;
    property FullTextSearch: boolean read FFullTextSearch write FFullTextSearch default false;
    property LengthLimit: smallint read FLengthLimit write FLengthLimit default 0;
    property Precision: smallint read FPrecision write SetPrecision default 0;
    property PrecisionDisplay: TAdvChartEditPrecisionDisplay read FPrecisionDisplay write SetPrecisionDisplay default pdNormal;
    property OnLookupSelect: TAdvChartEditLookupSelectEvent read FOnLookupSelect write FOnLookupSelect;
    property OnLookupIndexSelect: TAdvChartEditLookupIndexSelectEvent read FOnLookupIndexSelect write FOnLookupIndexSelect;
    property OnLookupNeedData: TAdvChartEditLookupNeedDataEvent read FOnLookupNeedData write FOnLookupNeedData;
    property OnLookupOpen: TNotifyEvent read FOnLookupOpen write FOnLookupOpen;
    property OnLookupClose: TNotifyEvent read FOnLookupClose write FOnLookupClose;
  end;

  {$IFNDEF LCLLIB}
  [ComponentPlatformsAttribute(TMSPlatformsWeb)]
  {$ENDIF}
  TAdvChartEditButton = class(TAdvChartCustomControl, IAdvChartBitmapContainer)
  private
    FBlockDropDown: Boolean;
    FPopup: TAdvChartPopup;
    FEdit: TAdvChartEdit;
    FButton: TAdvChartToolBarDropDownButton;
    FPopupControl: TControl;
    FOnButtonClick: TNotifyEvent;
    FModalPopup: Boolean;
    FBitmap: TAdvChartBitmap;
    FBitmapName: string;
    FButtonSize: Integer;
    FBitmapContainer: TAdvChartBitmapContainer;
    procedure SetPopupControl(const Value: TControl);
    function GetText: string;
    procedure SetText(const Value: string);
    function GetBitmapContainer: TAdvChartBitmapContainer;
    procedure SetBitmap(const Value: TAdvChartBitmap);
    procedure SetBitmapContainer(const Value: TAdvChartBitmapContainer);
    procedure SetBitmapName(const Value: String);
    procedure SetButtonSize(const Value: Integer);
  protected
    procedure ChangeDPIScale(M, D: Integer); override;
    procedure SetAdaptToStyle(const Value: Boolean); override;
    procedure BeforeDropDown; virtual;
    procedure Loaded; override;
    {$IFDEF FMXLIB}
    procedure KeyDown(var Key: Word; var KeyChar: WideChar; Shift: TShiftState); override;
    procedure PopupKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    {$ENDIF}
    {$IFDEF CMNWEBLIB}
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure PopupKeyDown(Sender: TObject; var Key: Word; {%H-}Shift: TShiftState);
    {$ENDIF}
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ButtonClick(Sender: TObject);
    procedure ButtonDblClick(Sender: TObject);
    procedure BitmapChanged(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DropDown; virtual;
    property Popup: TAdvChartPopup read FPopup write FPopup;
    property Button: TAdvChartToolBarDropDownButton read FButton;
    property Edit: TAdvChartEdit read FEdit;
    property ModalPopup: Boolean read FModalPopup write FModalPopup default False;
  published
    property BitmapContainer: TAdvChartBitmapContainer read GetBitmapContainer write SetBitmapContainer;
    property Bitmap: TAdvChartBitmap read FBitmap write SetBitmap;
    property BitmapName: String read FBitmapName write SetBitmapName;
    property ButtonSize: Integer read FButtonSize write SetButtonSize default 18;
    property PopupControl: TControl read FPopupControl write SetPopupControl;
    property OnButtonClick: TNotifyEvent read FOnButtonClick write FOnButtonClick;
  published
    property Text: string read GetText write SetText;
  end;

implementation

uses
  SysUtils, Types, AdvChartUtils, Math
  {$IFNDEF LCLLIB}
  {$IFNDEF WEBLIB}
  ,Data.Bind.Components
  {$ENDIF}
  {$ENDIF}
  ;

type
  TAdvChartEditAutoType = (atNumeric, atFloat, atString, atDate, atTime, atHex);
  TAdvChartPopupOpen = class(TAdvChartPopup);

function CheckTerminator(ch: char): boolean;
begin
  Result := CharInArray(ch, [' ', ',', '.', '/', '\', ':', '*', '$', '-', '(', ')', '[', ']', '"','''','&']);
end;

function ShiftCase(AName: string): string;
var
  I, L: Integer;
  NewName: string;
  First: Boolean;
begin
  First := true;
  NewName := AName;
  L := Length(AName);

  {$IFDEF ZEROSTRINGINDEX}
  for I := 0 to L - 1 do
  {$ELSE}
  for I := 1 to L do
  {$ENDIF}
  begin
    if CheckTerminator(NewName[I]) then
      First := true
    else
      if First then
      begin
        NewName[I] := AnsiUpperCase(AName)[I];
        First := false;
      end
      else
        NewName[I] := AnsiLowerCase(AName)[I];

    if (Copy(NewName, 1, I) = 'Mc') or (Copy(NewName, 1, I) = 'Mac') or
      ((Pos(' Mc', NewName) = I - 2) and (I > 2)) or
      ((I > L - 3) and ((Copy(NewName, I - 1, 2) = ' I') or
      (Copy(NewName, I - 2, 3) = ' II'))) then
      First := true;
  end;
  Result := NewName;
end;

function IsType(s: string): TAdvChartEditAutoType;
var
  i: Integer;
  isI, isF, isH: Boolean;
  th, de, mi: Integer;
begin
  Result := atString;

  isI := true;
  isF := true;
  isH := true;

  if s = '' then
  begin
    isI := false;
    isF := false;
    isH := false;
  end;

  th := -1; de := 0; mi := 0;

  {$IFDEF ZEROSTRINGINDEX}
  for i := 0 to Length(s) - 1 do
  {$ELSE}
  for i := 1 to Length(s) do
  {$ENDIF}
  begin

    if not CharIsNumber(s[i]) then
      isI := False;
    if not CharIsNumber(s[i]) and not CharInArray(s[i], ['.',',']) then
      isF := False;
    if not CharIsNumber(s[i]) and not CharIsLetter(s[i]) then
      isH := False;

    {$IFDEF WEBLIB}
    if (s[i] = ThousandSeparator) and (i - th < 3) then isF := false;
    if s[i] = ThousandSeparator then th := i;
    if s[i] = DecimalSeparator then inc(de);
    {$ENDIF}
    {$IFNDEF WEBLIB}
    if (s[i] = FormatSettings.ThousandSeparator) and (i - th < 3) then isF := false;
    if s[i] = FormatSettings.ThousandSeparator then th := i;
    if s[i] = FormatSettings.DecimalSeparator then inc(de);
    {$ENDIF}
    if s[i] = '-' then inc(mi);
  end;

  if isH and not isI then
    Result := atHex;

  if isI then
    Result := atNumeric
  else
  begin
    if isF then
      Result := atFloat;
  end;

  if (mi > 1) or (de > 1) then
    Result := atString;
end;

function HexToInt(s: string): Integer;
var
  i: Integer;
  r, m: Integer;

  function CharVal(c: char): Integer;
  begin
    Result := 0;
    if ((c >= '0') and (c <= '9')) then Result := ord(c) - ord('0');
    if ((c >= 'A') and (c <= 'F')) then Result := ord(c) - ord('A') + 10;
    if ((c >= 'a') and (c <= 'f')) then Result := ord(c) - ord('a') + 10;
  end;

begin
  r := 0;
  m := 1;
  {$IFDEF FMXMOBILE}
  for i := Length(s) - 1 downto 0 do
  {$ELSE}
  for i := Length(s) downto 1 do
  {$ENDIF}
  begin
    r := r + m * CharVal(s[i]);
    m := m shl 4;
  end;
  Result := r;
end;

function ValStr(s: string): Integer;
var
  {%H-}err: Integer;
begin
  val(s, result, err);
end;

function CleanString(s: string): string;
var
  i: Integer;
begin
  i := pos(#13, s);
  if i > 0 then
    delete(s, i, 1);
  i := pos(#10, s);
  if i > 0 then
    delete(s, i, 1);
  i := pos(#11, s);
  if i > 0 then
    delete(s, i, 1);

  Result := s;
end;

{ TAdvChartEdit }

{$IFDEF WEBLIB}
function TAdvChartEdit.Validate(AValue: string): boolean;
var
  i: integer;
  kch: char;
  isValid: boolean;
begin
  inherited;
  Result := true;

  for i := 1 to Length(AValue) do
  begin
    kch := AValue[i];
    isValid := True;

    case FEditType of
      etNumeric:
        begin
          if not CharIsNumber(kch) then
            isValid := False;
        end;
      etFloat:
        begin
          if not (CharIsNumber(kch) or (kch = FormatSettings.DecimalSeparator)) then
            isValid := False;
        end;
      etSignedFloat, etSignedNumeric:
        begin
          if not (CharInArray(kch, ['-']) or CharIsNumber(kch) or (kch = FormatSettings.DecimalSeparator)) then
            isValid := False;
        end;
      etMoney:
        begin
          if not (CharIsNumber(kch) or (kch = FormatSettings.DecimalSeparator) or (kch = FormatSettings.ThousandSeparator)) then
            isValid := False;
        end;
      etHex:
        begin
          if not CharIsHex(kch) then
            isValid := False;
        end;
      etAlphaNumeric:
        begin
          if not CharIsLetterOrNumber(kch) then
            isValid := False;
        end;
    end;

    if not isValid then
    begin
      Result := false;
      break;
    end;
  end;
end;

class function TAdvChartEdit.GetVersionNumber(AMaj, AMin, ARel, ABld: ShortInt): string;
begin
  Result := '';
end;
{$ENDIF}

function TAdvChartEdit.GetVersion: String;
begin
  Result := GetVersionNumber(MAJ_VER, MIN_VER, REL_VER, BLD_VER);
end;

{$IFDEF CMNWEBLIB}
function TAdvChartEdit.CanFocus: Boolean;
begin
  Result := inherited CanFocus;
  Result := Result and AllowFocus;
end;
{$ENDIF}

function TAdvChartEdit.GetAllowFocus: Boolean;
begin
  {$IFDEF FMXLIB}
  Result := CanFocus;
  {$ENDIF}
  {$IFDEF CMNWEBLIB}
  Result := FAllowFocus;
  {$ENDIF}
end;

procedure TAdvChartEdit.SetAllowFocus(const Value: Boolean);
begin
  {$IFDEF FMXLIB}
  CanFocus := Value;
  {$ENDIF}
  {$IFDEF CMNWEBLIB}
  FAllowFocus := Value;
  {$ENDIF}
end;

constructor TAdvChartEdit.Create(AOwner: TComponent);
begin
  inherited;
  FAutoClose := True;
  {$IFDEF CMNWEBLIB}
  FAllowFocus := True;
  {$ENDIF}
  {$IFDEF WEBLIB}
  AutoCompletion := acNone;
  {$ENDIF}
  {$IFDEF FMXLIB}
  FDoneLookupTimer := TTimer.Create(Self);
  FDoneLookupTimer.OnTimer := DoDoneLookupTimer;
  FDoneLookupTimer.Enabled := False;
  FDoneLookupTimer.Interval := 1;
  {$ENDIF}
  FLookupFormTimer := TTimer.Create(Self);
  FLookupFormTimer.OnTimer := DoLookupFormTimer;
  FLookupFormTimer.Enabled := False;
  FLookupFormTimer.Interval := 1;
  FAutoThousandSeparator := True;
  FLengthLimit := 0;
  FAutoComplete := False;
  FLookup := TAdvChartEditLookupSettings.Create;

  FLookupListBoxItems := TAdvLookupList.Create;

  FLookupList := TAdvChartPopup.Create(Self);
  FLookupList.StaysOpen := True;

  FLookupListBox := TListBox.Create(Self);
  {$IFDEF LCLLIB}
  FLookupListBox.ClickOnSelChange := False;
  {$ENDIF}
  FLookupListBox.ItemHeight := LOOKUPITEMHEIGHT;
  FLookupListBox.OnKeyUp := ListKeyUp;
  FLookupListBox.OnMouseUp := ListMouseUp;
  {$IFDEF FMXLIB}
  FLookupListBox.Align := TAlignLayout.Client;
  {$ENDIF}
  {$IFDEF CMNWEBLIB}
  FLookupListBox.Visible := False;
  FLookupListBox.Align := alClient;
  {$IFDEF VCLLIB}
  FInitialize := True;
  {$ELSE}
  AutoSize := False;
  {$ENDIF}
  {$ENDIF}

  FLookupList.ContentControl := FLookupListBox;
  FLookupList.FocusedControl := Self;
end;

destructor TAdvChartEdit.Destroy;
begin
  {$IFDEF FMXLIB}
  FDoneLookupTimer.Free;
  {$ENDIF}
  FLookupFormTimer.Free;
  FLookup.Free;
  CleanupLookupList;

  if Assigned(FLookupListBox) then
  begin
    FLookupListBox.Free;
    FLookupListBox := nil;
  end;

  FLookupListBoxItems.Free;

  if Assigned(FLookupList) then
  begin
    FLookupList.Free;
    FLookupList := nil;
  end;
  inherited;
end;

procedure TAdvChartEdit.DisplayLookup;
var
  i, cnt: Integer;
  mw, mh, tw: Integer;
  LookupText: string;
  idx: Integer;
  obj: TAdvLookupListBoxItem;
begin
  if not FLookup.Enabled or not Assigned(FLookupListBox) then
    Exit;

  mh := (LOOKUPITEMHEIGHT * FLookup.DisplayCount) + 4;
  FLookupListBox.Parent := Self;
  CleanupLookupList;
  FLookupListBox.Items.Clear;
  {$IFDEF FMXLIB}
  FLookupListBox.NeedStyleLookup;
  FLookupListBox.ApplyStyleLookup;
  FLookupListBox.BeginUpdate;
  {$ENDIF}

  for i := 1 to FLookup.DisplayList.Count do
  begin
    obj := TAdvLookupListBoxItem.Create(i - 1);
    FLookupListbox.Items.AddObject(CleanString(FLookup.FDisplayList.Strings[i - 1]), obj);
    FLookupListBoxItems.Add(obj);
  end;

  idx := 0;
  DoLookupNeedData(LookupText, FLookupListBox.Items, idx);
  cnt := FLookupListBox.Items.Count;

  {$IFDEF FMXLIB}
  FLookupListBox.EndUpdate;
  {$ENDIF}

  if (FLookup.FDisplayList.Count > 0) and (FLookupListBox.Items.Count > 0) then
    FLookupListBox.ItemIndex := idx;

  if cnt < FLookup.DisplayCount then
    mh := (cnt * LOOKUPITEMHEIGHT) + 4;

  FLookupListBox.Sorted := True;
  mw := 50;
  FLookupList.DropDownWidth := 0;

  if cnt > 0 then
  begin
    for i := 1 to cnt do
    begin
      tw := 0;
      if Assigned(FLookupListBox.Canvas) then
        tw := Round(FLookupListBox.Canvas.TextWidth(FLookupListBox.Items[i - 1]));

      if tw > mw then
        mw := tw;
    end;

    mw := mw + 26;
  end;

  if (FLookup.Width > 0) then
    mw := FLookup.Width;

  if (FLookup.Height > 0) then
    mh := FLookup.Height;

  FLookupList.PlacementControl := Self;

  if (cnt > 0) then
  begin
    FLookupList.DropDownWidth := Max(Lookup.MinimumWidth, mw);
    FLookupList.DropDownHeight := Max(Lookup.MinimumHeight, mh);
    if FLookupList.HasPopupForm then
    begin
      FLookupListBox.Parent := FLookupList.PopupForm;
      FLookupList.PopupForm.Width := Round(FLookupList.DropDownWidth);
      FLookupList.PopupForm.Height := Round(FLookupList.DropDownHeight);
    end;
    if not FLookupList.IsOpen then
      DoLookupOpen;
    FLookupList.IsOpen := True;
    FLookupFormTimer.Enabled := AutoClose;
  end
  else
  begin
    if FLookupList.IsOpen then
      DoLookupClose;
    FLookupList.IsOpen := False;
  end;
end;

procedure TAdvChartEdit.DoExit;
var
  TT: string;
  OldModified: Boolean;
begin
  inherited;
  if (csLoading in ComponentState) then
    Exit;

  if (FPrecision >= 0) and (EditType in [etFloat, etSignedFloat, etMoney]) then
  begin
    if (self.Text <> '') or not FAllowNumericNullValue then
    begin
      OldModified := Modified;
      Floatvalue := self.Floatvalue;
      Modified := OldModified;
    end;
  end;

  if (EditType in [etNumeric, etSignedNumeric]) and (Self.Text = '') and not FAllowNumericNullValue then
    Text := '0';

  if (EditType in [etFloat, etSignedFloat, etMoney]) and (Self.Text = '') and not FAllowNumericNullValue  then
    Floatvalue := 0.0;

  TT := Trim(Text);
  if FLookup.Enabled and FLookup.History and (TT <> '') then
  begin
    if FLookup.DisplayList.IndexOf(TT) = -1 then
      FLookup.DisplayList.Add(TT);
  end;
end;

procedure TAdvChartEdit.InsertText(const AText: string);
var
  TmpS: string;
begin
  if ReadOnly then
    Exit;

  TmpS := Text;
  System.Delete(TmpS, SelStart + 1, SelLength);
  System.Insert(AText, TmpS, SelStart + 1);
  if (MaxLength <= 0) or (Length(TmpS) <= MaxLength) then
  begin
    Text := TmpS;
    SetCaretPosition(SelStart + Length(AText));
  end;
  SelLength := 0;
end;

function TAdvChartEdit.IsLookupListVisible: Boolean;
begin
  Result := Assigned(FLookupList) and FLookupList.IsOpen;
end;

procedure TAdvChartEdit.SetT(const Value: string);
var
  fmt: string;
  f: extended;
  v: string;
begin
  v := Value;
  if not ((v = '') and AllowNumericNullValue) then
  begin
    case FEditType of
      etFloat: if not (IsType(v) in [atFloat, atNumeric]) then v := '0';
      etMoney: if not (IsType(v) in [atFloat, atNumeric]) then v := '0';
      etHex: if not (IsType(v) in [atHex, atNumeric]) then v := '0';
      etNumeric: if not (IsType(v) in [atNumeric]) then v := '0';
    end;

    if (PrecisionDisplay = pdNormal) then
    begin
      if ((FPrecision >= 0) or (FEditType = etMoney)) and (v <> '') then
      begin
        if (FEditType in [etMoney]) and (FPrecision >= 0) then
        begin
          fmt := '%.' + IntToStr(FPrecision) + 'n';
          v := Format(fmt, [EStrToFloat(v)]);
        end;

        if (FEditType in [etFloat, etSignedFloat]) then
        begin
          fmt := '%.' + inttostr(FPrecision) + 'f';
          f := EStrToFloat(v);
          v := Format(fmt, [f]);
        end;
      end;
    end
    else
    begin
      if (FEditType in [etFloat, etMoney, etSignedFloat]) then
      begin
        f := EStrToFloat(v);
        v := Format('%g', [f]);
      end;
    end;
  end;

  if (FEditType in [etHex, etUppercase]) then
    v := AnsiUpperCase(v)
  else if FEditType in [etLowerCase] then
    v := AnsiLowerCase(v);

  {$IFDEF WEBLIB}
  inherited SetText(FPrefix + v + FSuffix);
  {$ENDIF}
  {$IFNDEF WEBLIB}
  inherited Text := FPrefix + v + FSuffix;
  {$ENDIF}

  SetModified(False);
end;

{$IFDEF FMXLIB}
procedure TAdvChartEdit.DoDoneLookupTimer(Sender: TObject);
begin
  DoneLookup;
  FDoneLookupTimer.Enabled := False;
end;

function TAdvChartEdit.GetDefaultStyleLookupName: string;
begin
  Result := 'editstyle';
end;
{$ENDIF}

function TAdvChartEdit.FixedLength(s: string): Integer;
var
  i: Integer;
begin
  s := TAdvChartUtils.StripThousandSep(s);
  i := Pos(FormatSettings.decimalseparator, s);
  if (i > 0) then Result := i else Result := Length(s) + 1;

  if Signed and (EditType in [etFloat, etSignedFloat, etNumeric, etSignedNumeric, etMoney]) and (pos('-',s) > 0) then
    Result := Result - 1;
end;

function TAdvChartEdit.AllowMin(ch: char): boolean;
begin
  Result := Signed and (EditType in [etFloat, etSignedFloat, etNumeric, etSignedNumeric, etMoney]) and (ch = '-');
end;

{$IFDEF FMXLIB}
procedure TAdvChartEdit.KeyDown(var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
{$ENDIF}
{$IFDEF CMNWEBLIB}
procedure TAdvChartEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  FKeyDown := Key;
  FShiftState := Shift;
end;

procedure TAdvChartEdit.KeyPress(var Key: Char);
{$ENDIF}
var
  s, cl, st, stmin: string;
  allowclip: boolean;
  at: TAdvChartEditAutoType;
  ismod: Boolean;
  d: Integer;
  kch: Char;

  procedure EatKey;
  begin
    {$IFDEF FMXLIB}
    KeyChar := #0;
    if not (Key in [KEY_UP, KEY_DOWN]) then
      Key := 0;
    {$ENDIF}
    {$IFDEF CMNWEBLIB}
    if not (FKeyDown in [KEY_UP, KEY_DOWN]) then
      Key := #0;
    {$ENDIF}
  end;

begin
  if not Assigned(FLookupListBox) then
  begin
    inherited;
    Exit;
  end;

  {$IFDEF FMXLIB}
  s := KeyChar;
  kch := KeyChar;
  FKeyDown := Key;
  {$ELSE}
  s := Key;
  kch := Key;
  {$ENDIF}

  if (FKeyDown = KEY_MENU) or (FKeyDown = KEY_ESCAPE) then
  begin
    CloseLookup;
  end;

  if (FKeyDown = KEY_BACK) and (FPrefix <> '') then
    if (SelStart <= Length(FPrefix)) and (SelLength = 0) then Exit;

  if (FLengthLimit > 0) and (FixedLength(self.Text) > FLengthLimit) and
    (SelLength = 0) and (SelStart < DecimalPos) and (FKeyDown <> KEY_BACK) and (FKeyDown <> ord(FormatSettings.decimalseparator{$IFDEF WEBLIB}[0]{$ENDIF})) and not AllowMin(kch) then
    begin
      EatKey;
      Exit;
    end;

  if (FKeyDown in [KEY_HOME, KEY_END, KEY_TAB, KEY_LEFT, KEY_RIGHT, KEY_PRIOR, KEY_NEXT, KEY_DELETE, KEY_BACK]) then
  begin
    if (FKeyDown = KEY_BACK) then
    begin
      s := self.Text;

      if SelLength = 0 then
        delete(s, SelStart - Length(fprefix), 1)
      else
        delete(s, Max(1, SelStart - Length(fprefix)), SelLength);

      ismod := (s <> Text) or Modified;
      Modified := ismod;

      inherited;

      if (EditType = etMoney) then
        AutoSeparators;

      if (Text = '') and ((s <> '') or ismod) then
      begin
        Change;
      end;

      Modified := ismod;

      UpdateLookup;
      Exit;
    end
    else
    begin
      if (FKeyDown in [KEY_HOME, KEY_END, KEY_TAB, KEY_LEFT, KEY_RIGHT, KEY_PRIOR, KEY_NEXT]) then
      begin
        if AutoComplete and (SelLength > 0) and IsLookupListVisible then
          CloseLookup;
      end;

      st := Self.Text;
      inherited;
      if Self.Text <> st then
        Modified := True;
    end;

    Exit;
  end;

  if (FKeyDown = KEY_RETURN) and IsLookupListVisible then
  begin
    DoneLookup;
    Exit;
  end;

  if (FKeyDown in [KEY_TAB, KEY_RETURN, KEY_ESCAPE]) {and IsCtrl} then
  begin
    inherited;
    Exit;
  end;

  if (FKeyDown = KEY_HOME) and IsLookupListVisible then
  begin
    if FLookupListBox.Items.Count > 0 then
      FLookupListBox.ItemIndex := 0
    else
      FLookupListBox.ItemIndex := -1;
    Exit;
  end;

  if (FKeyDown = KEY_END) and IsLookupListVisible then
  begin
    if FLookupListBox.Items.Count > 0 then
      FLookupListBox.ItemIndex := FLookupListBox.Items.Count - 1
    else
      FLookupListBox.ItemIndex := -1;
    Exit;
  end;

  if (FKeyDown = KEY_NEXT) and IsLookupListVisible then
  begin
    if FLookupListBox.Items.Count > 0 then
    begin
      if FLookupListBox.ItemIndex + FLookup.DisplayCount < FLookupListBox.Items.Count then
        FLookupListBox.ItemIndex := FLookupListBox.ItemIndex + FLookup.DisplayCount
      else
        FLookupListBox.ItemIndex := FLookupListBox.Items.Count - 1;
    end
    else
      FLookupListBox.ItemIndex := -1;
    Exit;
  end;

  if (FKeyDown = KEY_PRIOR) and IsLookupListVisible then
  begin
    if FLookupListBox.Items.Count > 0 then
    begin
      if FLookupListBox.ItemIndex > FLookup.DisplayCount then
        FLookupListBox.ItemIndex := FLookupListBox.ItemIndex - FLookup.DisplayCount
      else
        FLookupListBox.ItemIndex := 0;
    end
    else
      FLookupListBox.ItemIndex := -1;
    Exit;
  end;

  if (FKeyDown = KEY_UP) and IsLookupListVisible then
  begin
    if FLookupListBox.Items.Count > 0 then
    begin
      if FLookupListBox.ItemIndex > 0 then
        FLookupListBox.ItemIndex := FLookupListBox.ItemIndex - 1;
    end
    else
      FLookupListBox.ItemIndex := -1;
    Exit;
  end;

  if (FKeyDown = KEY_DOWN) and IsLookupListVisible then
  begin
    if FLookupListBox.Items.Count > 0 then
    begin
      if FLookupListBox.ItemIndex + 1 < FLookupListBox.Items.Count then
        FLookupListBox.ItemIndex := FLookupListBox.ItemIndex + 1;
    end
    else
      FLookupListBox.ItemIndex := -1;
    Exit;
  end;

  if (FKeyDown = KEY_ESCAPE) and IsLookupListVisible then
  begin
    CloseLookup;
    Exit;
  end;

  if (FKeyDown = KEY_DELETE) and (SelStart >= Length(FPrefix)) then
  begin
    s := self.text;
    if SelLength = 0 then
      Delete(s, SelStart - Length(fprefix) + 1, 1)
    else
      Delete(s, SelStart - Length(fprefix) + 1, SelLength);

    if (lengthlimit > 0) and (fixedLength(s) - 1 > lengthlimit) then
    begin
      EatKey;
      exit;
    end;
    SetModified(true);
  end;

  if (MaxLength > 0) and (SelLength = 0) and (Length(Text) >= MaxLength) then
    Exit;

  if (fPrefix <> '') and (SelStart < Length(fPrefix)) then
    SelStart := Length(fPrefix);

  if (FShiftState = [ssCtrl]) and (kch = ^V) then
  begin
    cl := TAdvClipBoard.GetText;
    at := IsType(cl);

    allowclip := true;

    case FEditType of
      etNumeric: allowclip := at = atNumeric;
      etSignedNumeric: allowclip := at = atNumeric;
      etFloat, etSignedFloat: allowclip := at = atFloat;
      etUppercase: cl := AnsiUppercase(cl);
      etMixedCase: cl := Shiftcase(cl);
      etLowerCase: cl := AnsiLowercase(cl);
      etMoney: allowclip := at = atFloat;
      etHex: allowclip := at in [atHex, atNumeric];
    end;

    if Allowclip then
      InsertText(cl);

    EatKey;
    Exit;
  end;

  case FEditType of
    etString:
      begin
      end;
    etNumeric:
      begin
        if not CharIsNumber(kch) then
          EatKey;
      end;
    etFloat:
      begin
        if not (CharIsNumber(kch) or (kch = FormatSettings.DecimalSeparator)) then
          EatKey;

        {$IFDEF FMXLIB}
        if (Pos(FormatSettings.DecimalSeparator, Text) > 0) and (KeyChar = FormatSettings.DecimalSeparator) then
        {$ENDIF}
        {$IFDEF CMNWEBLIB}
        if (Pos(FormatSettings.DecimalSeparator, Text) > 0) and (Key = FormatSettings.DecimalSeparator) then
        {$ENDIF}
          EatKey;
      end;
    etSignedFloat, etSignedNumeric:
      begin
        if not (CharInArray(kch, ['-']) or CharIsNumber(kch) or (kch = FormatSettings.DecimalSeparator)) then
          EatKey;

        {$IFDEF FMXLIB}
        if (Pos(FormatSettings.DecimalSeparator, Text) > 0) and (KeyChar = FormatSettings.DecimalSeparator) then
        {$ENDIF}
        {$IFDEF CMNWEBLIB}
        if (Pos(FormatSettings.DecimalSeparator, Text) > 0) and (Key = FormatSettings.DecimalSeparator) then
        {$ENDIF}
          EatKey;

        {$IFDEF FMXLIB}
        if (Pos('-', Text) > 0) and (KeyChar = '-') and not (SelLength = Length(Text)) then
        {$ENDIF}
        {$IFDEF CMNWEBLIB}
        if (Pos('-', Text) > 0) and (Key = '-') and not (SelLength = Length(Text)) then
        {$ENDIF}
          EatKey;
      end;
    etUppercase:
      begin
        s := AnsiUppercase(s);
        {$IFDEF ZEROSTRINGINDEX}
        kch := s[0];
        {$ELSE}
        kch := s[1];
        {$ENDIF}

        {$IFDEF FMXLIB}
        Key := ord(kch);
        KeyChar := kch;
        {$ENDIF}
        {$IFDEF CMNWEBLIB}
        Key := kch;
        {$ENDIF}
      end;
    etLowerCase:
      begin
        s := AnsiLowerCase(s);
        {$IFDEF ZEROSTRINGINDEX}
        kch := s[0];
        {$ELSE}
        kch := s[1];
        {$ENDIF}

        {$IFDEF FMXLIB}
        Key := ord(kch);
        KeyChar := kch;
        {$ENDIF}
        {$IFDEF CMNWEBLIB}
        Key := kch;
        {$ENDIF}
      end;
    etMoney:
      begin
        if not (CharIsNumber(kch) or (kch = FormatSettings.DecimalSeparator) or (kch = FormatSettings.ThousandSeparator)) then
          EatKey;
      end;
    etHex:
      begin
        if not CharIsHex(kch) then
          EatKey;
      end;
    etAlphaNumeric:
      begin
        if not CharIsLetterOrNumber(kch) then
          EatKey;
      end;
    etValidChars:
      begin
        if (FValidChars <> '') then
          if Pos(AnsiUpperCase(s), AnsiUppercase(FValidChars)) = 0 then
            EatKey;
      end;
  end;

  s := self.Text;
  inherited;
  if self.Text <> s then
    Modified := True;

  if (EditType in [etMoney, etSignedFloat, etSignedNumeric]) then
  begin
    stmin := Text;
    if pos('-', stmin) > 1 then
    begin
      delete(stmin,Pos('-', stmin),1);
      Text := '-' + stmin;
    end;
  end;


  if (EditType = etMoney) then
    AutoSeparators;

  if (FEditType in [etFloat, etSignedFloat, etMoney]) then
  begin
    d := Length(Text) - Length(s);
    if (d > 1) then
      SetCaretPosition(GetCaretPosition + d);
  end;

  if FShiftState = [] then
    UpdateLookup;
end;

{$IFDEF FMXLIB}
procedure TAdvChartEdit.KeyUp(var Key: Word; var KeyChar: Char; Shift: TShiftState);
{$ENDIF}
{$IFDEF CMNWEBLIB}
procedure TAdvChartEdit.KeyUp(var Key: Word; Shift: TShiftState);
{$ENDIF}
var
  oldSelStart: integer;
  kch: Char;
begin
  inherited;

  {$IFDEF FMXLIB}
  kch := KeyChar;
  {$ENDIF}
  {$IFDEF CMNWEBLIB}
  kch := Chr(Key);
  {$ENDIF}

  if (Key = KEY_TAB) and IsLookupListVisible and (Lookup.AcceptOnTab) then
    DoneLookup;

  if EditType = etMixedCase then
  begin
    oldSelStart := SelStart;
    Text := ShiftCase(Text);
    SelStart := oldSelStart;
  end;

  if (kch <> '') and (kch <> #8) then
    UpdateAutoComplete;
end;

{$IFDEF FMXLIB}
procedure TAdvChartEdit.ListKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
{$ENDIF}
{$IFDEF CMNWEBLIB}
procedure TAdvChartEdit.ListKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
{$ENDIF}
begin
  if Key = KEY_RETURN then
    DoneLookup;

  if (Key = KEY_TAB) and (Lookup.AcceptOnTab) then
    DoneLookup;
end;

{$IFDEF FMXLIB}
procedure TAdvChartEdit.ListMouseUp(Sender: TObject; Button: TAdvMouseButton; Shift: TShiftState; X, Y: Single);
begin
  FDoneLookupTimer.Enabled := True;
{$ENDIF}
{$IFDEF CMNWEBLIB}
procedure TAdvChartEdit.ListMouseUp(Sender: TObject; Button: TAdvMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DoneLookup;
{$ENDIF}
end;

function TAdvChartEdit.LookupList: TAdvChartPopup;
begin
  Result := FLookupList;
end;

function TAdvChartEdit.LookupListbox: TListBox;
begin
  Result := FLookupListBox;
end;

procedure TAdvChartEdit.SetEditType(const Value: TAdvChartEditType);
var
  at: TAdvChartEditAutoType;
begin
  if FEditType <> Value then
  begin
    FEditType := Value;

    if (csLoading in ComponentState) then
      Exit;

    if (Text <> '') or (not AllowNumericNullValue) then
    begin
      at := IsType(self.Text);
      case FEditType of
        etHex: if not (at in [atNumeric, atHex]) then self.IntValue := 0;
        etNumeric, etSignedNumeric: if (at <> atNumeric) then self.IntValue := 0;
        etFloat, etSignedFloat, etMoney: if not (at in [atFloat, atNumeric]) then self.FloatValue := 0.0;
      end;
    end;

    if (csDesigning in ComponentState) and not(csLoading in ComponentState) and ((FEditType = etFloat) or (FEditType = etSignedFloat)) and (Precision = 0) then
      Precision := 2;
  end;

  {$IFDEF WEBLIB}
  CharCase := wecNormal;
  case EditType of
    etUppercase: CharCase := wecUpperCase;
    etMixedCase: CharCase := wecMixedCase;
    etLowerCase: CharCase := wecLowerCase;
  end;
  {$ENDIF}
end;

{$IFDEF VCLLIB}
{$HINTS OFF}
{$IF COMPILERVERSION > 30}
procedure TAdvChartEdit.ChangeScale(M, D: Integer; isDpiChange: Boolean);
{$ELSE}
procedure TAdvChartEdit.ChangeScale(M, D: Integer);
{$IFEND}
begin
  inherited;
  if FInitialize then
  begin
    AutoSize := False;
    FInitialize := False;
  end;
end;
{$HINTS ON}
{$ENDIF}

{$IFDEF LCLLIB}
function TAdvChartEdit.ChildClassAllowed(ChildClass: TClass): Boolean;
begin
  if ChildClass = TListBox then
    Result := True
  else
    inherited;
end;
{$ENDIF}

{$IFDEF FMXLIB}
procedure TAdvChartEdit.Change;
begin
  if Assigned(OnChange) then
    OnChange(Self);
end;
{$ENDIF}

procedure TAdvChartEdit.CleanupLookupList;
var
  I: Integer;
  obj: TObject;
begin
  if not Assigned(FLookupListBoxItems) then
   Exit;

  for I := 0 to FLookupListBoxItems.Count - 1 do
  begin
    obj := TObject(FLookupListBoxItems[I]);
    if Assigned(obj) then
      obj.Free;
  end;

  FLookupListBoxItems.Clear;
end;

procedure TAdvChartEdit.CloseLookup;
begin
  if CanFocus then
    SetFocus;

  if Assigned(FLookupList) then
  begin
    if FLookupList.IsOpen then
      DoLookupClose;
    FLookupList.IsOpen := False;
  end;
end;

procedure TAdvChartEdit.DoneLookup;
var
  idx, vp: Integer;
  NewValue: string;
  LookupText, NewText: string;
  obj: TObject;
begin
  if not Assigned(FLookupListBox) then
    Exit;

  if (FlookupListBox.ItemIndex <> -1) then
  begin
    idx := -1;
    obj := FLookupListBox.Items.Objects[FlookupListBox.ItemIndex];
    if Assigned(obj) then
      idx := TAdvLookupListBoxItem(obj).Idx;

    if ((idx >= 0) and (idx < FLookup.ValueList.Count)) and Lookup.UseValueList then
      NewValue := FLookup.ValueList.Strings[idx]
    else
      NewValue := FLookupListbox.Items[FLookupListBox.ItemIndex];

    if Assigned(FOnLookupSelect) then
      FOnLookupSelect(Self, NewValue);

    if Assigned(FOnlookupIndexSelect) then
      FOnLookupIndexSelect(Self, idx, NewValue);

    if FLookup.Multi then
    begin
      NewValue := NewValue + FLookup.Separator;
      LookupText := Text;
      NewText := '';
      vp := -1;
      while TAdvChartUtils.VarPos(FLookup.Separator, LookupText, vp) > 0 do
      begin
        NewText := NewText + Copy(LookupText, 1, vp);
        Delete(LookupText, 1, vp);
      end;
      Text := NewText + NewValue;

    end
    else
      Text := NewValue;

    if FLookup.Multi then
      SelStart := length(Text)
    else
      SelectAll;


    CloseLookup;
  end;
end;

procedure TAdvChartEdit.SetLookup(const Value: TAdvChartEditLookupSettings);
begin
  FLookup.Assign(Value);
end;

procedure TAdvChartEdit.DoLookupFormTimer(Sender: TObject);
begin
  if not Assigned(FLookupList) or not Assigned(FLookupListBox) then
  begin
    FLookupFormTimer.Enabled := False;
    Exit;
  end;

  if Assigned(TAdvChartPopupOpen(FLookupList).PopupForm) then
    TAdvChartPopupOpen(FLookupList).PopupForm.ApplyPlacement;

  if not FLookupList.IsOpen or (not Focused and not (FLookupList.Focused) and not {$IFDEF FMXLIB}FLookupListBox.Focused{$ELSE}FLookupListBox.Focused{$ENDIF}) then
  begin
    if LookupList.IsOpen then
      DoLookupClose;
    FLookupList.IsOpen := False;
    FLookupFormTimer.Enabled := False;
  end;
end;

procedure TAdvChartEdit.DoLookupNeedData(Value: string; List: TStrings; var ItemIndex: integer);
begin
  if Assigned(OnLookupNeedData) then
    OnLookupNeedData(Self, Value, List, ItemIndex);
end;

procedure TAdvChartEdit.DoLookupOpen;
begin
  if Assigned(OnLookupOpen) then
    OnLookupOpen(Self);
end;

procedure TAdvChartEdit.DoLookupClose;
begin
  if Assigned(OnLookupClose) then
    OnLookupClose(Self);
end;

procedure TAdvChartEdit.UpdateLookup;
var
  i, cnt: Integer;
  mw, mh, tw, vp: Integer;
  LookupText: string;
  ismatch: Boolean;
  idx: Integer;
  obj: TAdvLookupListBoxItem;
begin
  if not FLookup.Enabled or not Assigned(FLookupListBox) then
    Exit;

  if FLookup.Multi then
  begin
    LookupText := Text;
    vp := -1;
    while TAdvChartUtils.VarPos(FLookup.Separator, LookupText, vp) > 0 do
      Delete(LookupText, 1, vp);
  end
  else
    LookupText := Text;

  if Length(LookupText) >= FLookup.NumChars then
  begin
    mh := (LOOKUPITEMHEIGHT * FLookup.DisplayCount) + 4;
    FLookupListBox.Parent := Self;
    CleanupLookupList;
    FLookupListBox.Items.Clear;
    {$IFDEF FMXLIB}
    FLookupListBox.NeedStyleLookup;
    FLookupListBox.ApplyStyleLookup;
    FLookupListBox.BeginUpdate;
    {$ENDIF}

    for i := 1 to FLookup.DisplayList.Count do
    begin
      if FLookup.CaseSensitive then
      begin
        if Pos(LookupText, FLookup.FDisplayList.Strings[i - 1]) = 1 then
        begin
          obj := TAdvLookupListBoxItem.Create(i - 1);
          FLookupListbox.Items.AddObject(CleanString(FLookup.FDisplayList.Strings[i - 1]), obj);
          FLookupListBoxItems.Add(obj);
        end;
      end
      else
      begin
        vp := Pos(AnsiUppercase(LookupText), AnsiUppercase(FLookup.FDisplayList.Strings[i - 1]));

        if FullTextSearch then
          ismatch := vp > 0
        else
          ismatch := vp = 1;

        if ismatch then
        begin
          obj := TAdvLookupListBoxItem.Create(i - 1);
          FLookupListbox.Items.AddObject(CleanString(FLookup.FDisplayList.Strings[i - 1]), obj);
          FLookupListBoxItems.Add(obj);
        end;
      end;
    end;

    idx := 0;
    DoLookupNeedData(LookupText, FLookupListBox.Items, idx);
    cnt := FLookupListBox.Items.Count;

    {$IFDEF FMXLIB}
    FLookupListBox.EndUpdate;
    {$ENDIF}

    if (FLookup.FDisplayList.Count > 0) and (FLookupListBox.Items.Count > 0) then
      FLookupListBox.ItemIndex := idx;

    if cnt < FLookup.DisplayCount then
      mh := (cnt * LOOKUPITEMHEIGHT) + 4;

    FLookupListBox.Sorted := True;
    mw := 50;
    FLookupList.DropDownWidth := 0;

    if cnt > 0 then
    begin
      for i := 1 to cnt do
      begin
        tw := 0;
        if Assigned(FLookupListBox.Canvas) then
          tw := Round(FLookupListBox.Canvas.TextWidth(FLookupListBox.Items[i - 1]));

        if tw > mw then
          mw := tw;
      end;

      mw := mw + 26;
    end;

    if (FLookup.Width > 0) then
      mw := FLookup.Width;

    if (FLookup.Height > 0) then
      mh := FLookup.Height;

    FLookupList.PlacementControl := Self;

    if (cnt > 0) then
    begin
      FLookupList.DropDownWidth := Max(Lookup.MinimumWidth, mw);
      FLookupList.DropDownHeight := Max(Lookup.MinimumHeight, mh);
      if FLookupList.HasPopupForm then
      begin
        FLookupListBox.Parent := FLookupList.PopupForm;
        FLookupList.PopupForm.Width := Round(FLookupList.DropDownWidth);
        FLookupList.PopupForm.Height := Round(FLookupList.DropDownHeight);
      end;
      if not FLookupList.IsOpen then
        DoLookupOpen;
      FLookupList.IsOpen := True;
      FLookupFormTimer.Enabled := AutoClose;
    end
    else
    begin
      if FLookupList.IsOpen then
        DoLookupClose;
      FLookupList.IsOpen := False;
    end;
  end
  else
  begin
    if FLookupList.IsOpen then
      DoLookupClose;
    FLookupList.IsOpen := False;
  end;
end;

procedure TAdvChartEdit.UpdateAutoComplete;
var
  s, ms: string;
  i, vp: Integer;
begin
  if not AutoComplete then
    Exit;

  s := Text;
  ms := '';
  if Length(s) >= 1 then
  begin
    for i := 1 to FLookup.DisplayList.Count do
    begin
      if FLookup.CaseSensitive then
      begin
        if Pos(s, FLookup.FDisplayList.Strings[i - 1]) = 1 then
        begin
          ms := FLookup.FDisplayList.Strings[i - 1];
          Break;
        end;
      end
      else
      begin
        vp := Pos(AnsiUpperCase(s), AnsiUppercase(FLookup.FDisplayList.Strings[i - 1]));
        if (vp = 1) then
        begin
          ms := FLookup.FDisplayList.Strings[i - 1];
          Break;
        end;
      end;
    end;

    if (ms <> '') then
    begin
      Text := CleanString(ms);
      SelStart := Length(s);
      SelLength := Length(Text) - SelStart;
    end;
  end;
end;

procedure TAdvChartEdit.SetPrefix(const Value: string);
begin
  FPrefix := Value;
end;

procedure TAdvChartEdit.SetSuffix(const Value: string);
begin
  FSuffix := Value;
end;

procedure TAdvChartEdit.SetModified(const Value: Boolean);
begin
  if csLoading in ComponentState then
    Exit;

  if ReadOnly then
    Exit;

  FIsModified := value;
end;

function TAdvChartEdit.DecimalPos: Integer;
var
  i: Integer;
begin
  i := Pos(FormatSettings.decimalseparator, self.text);
  if (i = 0) then Result := Length(fprefix) + Length(self.text) + Length(fSuffix) + 1
  else Result := Length(fPrefix) + i;
end;

procedure TAdvChartEdit.AutoSeparators;
var
  s, si, neg: string;
  d: Double;
  Diffl, OldSelStart, OldPrec: Integer;
  {$IFNDEF WEBLIB}
  cp: Boolean;
  {$ENDIF}
begin
  {$IFNDEF WEBLIB}
  cp := False;
  if not Assigned(Parent) then
  begin
    cp := True;
    Parent := TAdvChartUtils.GetOwnerForm(Self);
  end;
  {$ENDIF}

  s := self.Text;
  Diffl := Length(s);

  OldSelStart := SelStart;

  if (s = '') then
    Exit;

  if (Pos('-', s) = 1) then
  begin
    Delete(s, 1, 1);
    neg := '-';
  end
  else
    neg := '';

  if (Pos(FormatSettings.DecimalSeparator, s) > 0) then
    s := Copy(s, Pos(FormatSettings.DecimalSeparator, s), 255)
  else
    s := '';

  d := Trunc(Abs(self.FloatValue));

  if FAutoThousandSeparator then
    si := Format('%n', [d])
  else
    si := Format('%f', [d]);

  si := Copy(si, 1, Pos(FormatSettings.decimalseparator, si) - 1);

  OldPrec := FPrecision;
  FPrecision := 0;

  FBlockChange := (Text <> FPrefix + neg + si + s + FSuffix);

  if FBlockChange then
  begin
    {$IFDEF WEBLIB}
    inherited SetText(FPrefix + neg + si + s + fSuffix);
    {$ENDIF}
    {$IFNDEF WEBLIB}
    inherited Text := FPrefix + neg + si + s + fSuffix;
    {$ENDIF}
  end;

  FBlockChange := false;

  FPrecision := OldPrec;

  Diffl := Length(self.Text) - Diffl;

  SelStart := OldSelStart + Diffl;
  SelLength := 0;

  {$IFNDEF WEBLIB}
  if cp then
    Parent := nil;
  {$ENDIF}
end;

procedure TAdvChartEdit.SetAutoThousandSeparator(const Value: Boolean);
begin
  FAutoThousandSeparator := Value;
  if FEditType in [etNumeric, etSignedNumeric, etMoney, etFloat, etSignedFloat] then AutoSeparators;
end;

procedure TAdvChartEdit.SetCaretPosition(ACaretPosition: Integer);
begin
  {$IFDEF FMXLIB}
  CaretPosition := ACaretPosition;
  {$ENDIF}
  {$IFDEF CMNWEBLIB}
  SelStart := ACaretPosition;
  SelLength := 0;
  {$ENDIF}
end;

procedure TAdvChartEdit.SetFloat(const Value: double);
var
  s:string;
begin
  case FEditType of
    etHex: self.Text := IntToHex(trunc(value), 0);
    etNumeric, etSignedNumeric:
      if (FPrecision >= 0) then
        self.Text := Format('%.' + inttostr(FPrecision) + 'n', [value])
      else
        self.Text := Format('%g', [Value]);
    etFloat, etSignedFloat, etString:
      if (FPrecision >= 0) then
      begin
        s := Format('%.' + inttostr(FPrecision) + 'f', [value]);
        self.Text := s;
      end
      else
        self.Text := Format('%g', [Value]);
    etMoney:
      begin
        if (FPrecision >= 0) then
          self.Text := Format('%.' + inttostr(FPrecision) + 'f', [value]) else self.Text := Format('%g', [Value]);
        AutoSeparators;
      end;
  end;
  SetModified(True);
end;

function TAdvChartEdit.GetCaretPosition: Integer;
begin
  {$IFDEF FMXLIB}
  Result := CaretPosition;
  {$ENDIF}
  {$IFDEF CMNWEBLIB}
  Result := SelStart;
  {$ENDIF}
end;

function TAdvChartEdit.GetFloat: double;
var
  s: string;
  d: double;
  {%H-}e: integer;
begin
  Result := 0;
  case FEditType of
    etHex: if self.Text <> '' then Result := HexToInt(self.Text);
    etString:
      begin
        s := Self.Text;
        if FormatSettings.DecimalSeparator = ',' then
          s := StringReplace(s,',','.',[rfReplaceAll]);

        Val(s, d, e);
        Result := d;
      end;
    etNumeric, etSignedNumeric, etFloat, etSignedFloat:
      if (self.Text <> '') then
      begin
        s := self.Text;
        if (s = '-') then
          Result := 0
        else
          Result := EStrToFloat(s);
      end;
    etMoney:
      if self.Text <> '' then
      begin
        s := TAdvChartUtils.StripThousandSep(self.Text);
        if (Pos(FormatSettings.Decimalseparator, s) = Length(s)) then Delete(s, Pos(FormatSettings.DecimalSeparator, s), 1);
        if (s = '') or (s = '-') then Result := 0 else
          Result := EStrToFloat(s);
      end;
  end;
end;

procedure TAdvChartEdit.SetPrecision(const Value: smallint);
var
  at: TAdvChartEditAutoType;
begin
  if (FPrecision <> value) and (editType in [etFloat, etSignedFloat, etMoney, etString]) then
  begin
    FPrecision := Value;
    if (Text <> '') or (not AllowNumericNullValue) then
    begin
      at := IsType(self.text);
      if (at in [atFloat, atNumeric]) then
        FloatValue := FloatValue
      else
        FloatValue := 0.0;
    end;
  end;
end;

procedure TAdvChartEdit.SetPrecisionDisplay(const Value: TAdvChartEditPrecisionDisplay);
begin
  if (FPrecisionDisplay <> Value) then
  begin
    FPrecisionDisplay := Value;
    FloatValue := FloatValue;
  end;
end;

function TAdvChartEdit.EStrToFloat(s: string): extended;
begin
  Result := 0;

  if Pos(FormatSettings.ThousandSeparator, s) > 0 then
    s := TAdvChartUtils.StripThousandSep(s);

  if (FPrecision > 0) and (Length(s) > FPrecision) then
    if s[Length(s){$IFDEF ZEROSTRINGINDEX}-1{$ENDIF} - FPrecision] = FormatSettings.Thousandseparator{$IFDEF WEBLIB}[0]{$ENDIF} then
      s[Length(s){$IFDEF ZEROSTRINGINDEX}-1{$ENDIF} - FPrecision] := FormatSettings.Decimalseparator{$IFDEF WEBLIB}[0]{$ENDIF};
  try
    TryStrToFloat(s, Result);
  except
    Result := 0;
  end;
end;

function TAdvChartEdit.GetInt: Integer;
begin
  Result := 0;
  case FEditType of
    etHex: if (self.Text <> '') then Result := HexToInt(self.Text);
    etSignedNumeric, etNumeric, etSignedFloat, etFloat: Result := ValStr(self.Text);
    etMoney: Result := ValStr(TAdvChartUtils.StripThousandSep(self.Text));
  end;
end;

function TAdvChartEdit.GetT: string;
var
  s: string;
begin
  {$IFDEF WEBLIB}
  s := inherited GetText;
  {$ENDIF}
  {$IFNDEF WEBLIB}
  s := inherited Text;
  {$ENDIF}
  if (fPrefix <> '') and (Pos(AnsiUppercase(fPrefix), AnsiUppercase(s)) = 1) then delete(s, 1, Length(fPrefix));
  if (fSuffix <> '') then delete(s, Length(s) - Length(fSuffix) + 1, Length(fSuffix));
  Result := s;
end;

procedure TAdvChartEdit.SetInt(const Value: Integer);
begin
  case FEditType of
    etHex: self.Text := IntToHex(value, 0);
    etSignedNumeric, etNumeric, etSignedFloat, etFloat: self.Text := Inttostr(value);
    etMoney:
      begin
        self.Text := IntToStr(value);
        AutoSeparators;
      end;
  end;
  SetModified(True);
end;

{ TAdvChartEditLookupSettings }

procedure TAdvChartEditLookupSettings.Assign(Source: TPersistent);
begin
  if (Source is TAdvChartEditLookupSettings) then
  begin
    FAcceptOnTab := (Source as TAdvChartEditLookupSettings).AcceptOnTab;
    FCaseSensitive := (Source as TAdvChartEditLookupSettings).CaseSensitive;
    FColor := (Source as TAdvChartEditLookupSettings).Color;
    FDisplayCount := (Source as TAdvChartEditLookupSettings).DisplayCount;
    FDisplayList.Assign((Source as TAdvChartEditLookupSettings).DisplayList);
    FEnabled := (Source as TAdvChartEditLookupSettings).Enabled;
    FHistory := (Source as TAdvChartEditLookupSettings).History;
    FNumChars := (Source as TAdvChartEditLookupSettings).NumChars;
    FValueList.Assign((Source as TAdvChartEditLookupSettings).ValueList);
    FMulti := (Source as TAdvChartEditLookupSettings).Multi;
    FSeparator := (Source as TAdvChartEditLookupSettings).Separator;
    FWidth := (Source as TAdvChartEditLookupSettings).Width;
    FHeight := (Source as TAdvChartEditLookupSettings).Height;
    FMinimumWidth := (Source as TAdvChartEditLookupSettings).MinimumWidth;
    FMinimumHeight := (Source as TAdvChartEditLookupSettings).MinimumHeight;
    FUseValueList  := (Source as TAdvChartEditLookupSettings).UseValueList;
  end;
end;

constructor TAdvChartEditLookupSettings.Create;
begin
  inherited Create;
  FUseValueList := True;
  FWidth := 0;
  FMinimumWidth := 0;
  FHeight := 0;
  FMinimumHeight := 0;
  FDisplayList := TStringList.Create;
  FDisplayList.Sorted := true;
  FDisplayList.Duplicates :=  dupIgnore;
  FValueList := TStringList.Create;
  FColor := gcWhite;
  FDisplayCount := 4;
  FNumChars := 2;
  FEnabled := False;
  FSeparator := ';';
end;

destructor TAdvChartEditLookupSettings.Destroy;
begin
  FValueList.Free;
  FDisplayList.Free;
  inherited;
end;

procedure TAdvChartEditLookupSettings.SetDisplayList(const Value: TStringList);
begin
  FDisplayList.Assign(Value);
end;

procedure TAdvChartEditLookupSettings.SetHeight(const Value: Integer);
begin
  FHeight := Value;
end;

procedure TAdvChartEditLookupSettings.SetMinimumHeight(const Value: Integer);
begin
  FMinimumHeight := Value;
end;

procedure TAdvChartEditLookupSettings.SetMinimumWidth(const Value: Integer);
begin
  FMinimumWidth := Value;
end;

procedure TAdvChartEditLookupSettings.SetNumChars(const Value: Integer);
begin
  if Value > 0 then
    FNumChars := Value
end;

procedure TAdvChartEditLookupSettings.SetValueList(const Value: TStringList);
begin
  FValueList.Assign(Value);
end;

procedure TAdvChartEditLookupSettings.SetWidth(const Value: Integer);
begin
  FWidth := Value;
end;

{ TAdvChartEditButton }

{$IFDEF FMXLIB}
procedure TAdvChartEditButton.KeyDown(var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
{$ENDIF}
{$IFDEF CMNWEBLIB}
procedure TAdvChartEditButton.KeyDown(var Key: Word; Shift: TShiftState);
{$ENDIF}
begin
  inherited;
  if Key = KEY_F4 then
  begin
    DropDown;
    Exit;
  end;
end;

procedure TAdvChartEditButton.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = FPopupControl) then
    FPopupControl := nil;

  if (Operation = opRemove) and (AComponent = FBitmapContainer) then
    FBitmapContainer := nil;
  inherited;
end;

{$IFDEF FMXLIB}
procedure TAdvChartEditButton.PopupKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
{$ENDIF}
{$IFDEF CMNWEBLIB}
procedure TAdvChartEditButton.PopupKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
{$ENDIF}
begin
  case Key of
    KEY_RETURN:
    begin
      DropDown;
    end;
  end;
end;

procedure TAdvChartEditButton.SetAdaptToStyle(const Value: Boolean);
begin
  inherited;
  if Assigned(FButton) then
    FButton.AdaptToStyle := AdaptToStyle;
end;

procedure TAdvChartEditButton.SetBitmap(const Value: TAdvChartBitmap);
begin
  FBitmap := Value;
  if Assigned(FButton) then
  begin
    FButton.Bitmaps.Clear;
    FButton.Bitmaps.AddBitmap(Value);
  end;
end;

procedure TAdvChartEditButton.SetBitmapContainer(
  const Value: TAdvChartBitmapContainer);
begin
  FBitmapContainer := Value;
  if Assigned(FButton) then
    FButton.BitmapContainer := Value;
end;

procedure TAdvChartEditButton.SetBitmapName(const Value: String);
begin
  FBitmapName := Value;
  if Assigned(FButton) then
  begin
    FButton.Bitmaps.Clear;
    FButton.Bitmaps.AddBitmapName(Value);
  end;
end;

procedure TAdvChartEditButton.SetButtonSize(const Value: Integer);
begin
  FButtonSize := Value;
  if Assigned(FButton) then
    FButton.Width := Value;
end;

procedure TAdvChartEditButton.SetPopupControl(const Value: TControl);
begin
  FPopupControl := Value;
  FPopup.ContentControl := FPopupControl;
end;

procedure TAdvChartEditButton.SetText(const Value: string);
begin
  FEdit.Text := Value;
end;

procedure TAdvChartEditButton.BeforeDropDown;
begin

end;

procedure TAdvChartEditButton.BitmapChanged(Sender: TObject);
begin
  if Assigned(FButton) then
  begin
    FButton.Bitmaps.Clear;
    FButton.Bitmaps.AddBitmap(Bitmap);
  end;
end;

procedure TAdvChartEditButton.ButtonClick(Sender: TObject);
begin
  if not FBlockDropDown then
    DropDown;

  FBlockDropDown := False;

  if Assigned(OnButtonClick) then
    OnButtonClick(Self);
end;

procedure TAdvChartEditButton.ButtonDblClick(Sender: TObject);
begin
  FBlockDropDown := True;
end;

procedure TAdvChartEditButton.ChangeDPISCale(M, D: Integer);
begin
  inherited;
  ButtonSize := TAdvChartUtils.MulDivInt(FButtonSize, M, D);
end;

constructor TAdvChartEditButton.Create(AOwner: TComponent);
begin
  inherited;
  FModalPopup := False;
  FButton := TAdvChartToolBarDropDownButton.Create(Self);
  FButton.TabStop := False;
  FButton.AllowFocus := False;
  FButton.Stored := False;
  FButton.Width := 18;
  FButton.Appearance.Rounding := 0;
  {$IFDEF CMNWEBLIB}
  FButton.Align := alRight;
  {$ENDIF}
  {$IFDEF FMXLIB}
  FButton.Align := TAlignLayout.Right;
  {$ENDIF}
  FButton.Parent := Self;
  FButton.OnClick := ButtonClick;
  FButton.OnDblClick := ButtonDblClick;

  FButton.Bitmaps.AddBitmapFromResource('ADVCHARTTOOLBAREXPAND', HInstance, 1.0);
  FButton.Bitmaps.AddBitmapFromResource('ADVCHARTTOOLBAREXPANDLARGE', HInstance, 1.5);
  FButton.DisabledBitmaps.AddBitmapFromResource('ADVCHARTTOOLBAREXPAND', HInstance, 1.0);
  FButton.DisabledBitmaps.AddBitmapFromResource('ADVCHARTTOOLBAREXPANDLARGE', HInstance, 1.5);

  FEdit := TAdvChartEdit.Create(Self);
  {$IFDEF FMXLIB}
  FEdit.Stored := False;
  {$ENDIF}
  FEdit.Parent := Self;
  {$IFDEF CMNWEBLIB}
  FEdit.Align := alClient;
  {$ENDIF}
  {$IFDEF FMXLIB}
  FEdit.Align := TAlignLayout.Client;
  {$ENDIF}
  FPopup := TAdvChartPopup.Create(Self);
  FPopup.Placement := ppBottom;
  FPopup.Stored := False;
  FPopup.DragWithParent := True;
  FPopup.Width := 240;
  FPopup.Height := 160;

  FButtonSize := 18;
  FBitmap := TAdvChartBitmap.Create;
  FBitmap.OnChange := BitmapChanged;
  Width := 118;
  Height := 22;
end;

destructor TAdvChartEditButton.Destroy;
begin
  FButton.Free;
  FPopup.Free;
  FBitmap.Free;
  inherited;
end;

procedure TAdvChartEditButton.DropDown;
begin
  if Assigned(PopupControl) then
  begin
    FPopup.PlacementControl := Self;

    if not FPopup.IsOpen then
    begin
      BeforeDropDown;
      FPopup.Popup(ModalPopup)
    end
    else
      FPopup.IsOpen := False;
  end;
end;

function TAdvChartEditButton.GetBitmapContainer: TAdvChartBitmapContainer;
begin
  Result := FBitmapContainer;
end;

function TAdvChartEditButton.GetText: string;
begin
  Result := FEdit.Text;
end;

type
  TAdvControlOpen = class(TControl);
  TAdvChartToolBarDropDownButtonOpen = class(TAdvChartToolBarDropDownButton);

procedure TAdvChartEditButton.Loaded;
begin
  inherited;

  {$IFDEF VCLLIB}
  {$HINTS OFF}
  {$IF COMPILERVERSION >= 33}
  if Assigned(FButton) then
  begin
    TAdvChartToolBarDropDownButtonOpen(FButton).ChangeDPIScale(96, DesigntimeFormPixelsPerInch);
//    TAdvControlOpen(FButton).ScaleForPPI(CurrentPPI);
  end;

  if Assigned(FPopupControl) then
  begin
    TAdvControlOpen(FPopupControl).ChangeScale(96, DesigntimeFormPixelsPerInch);
    TAdvControlOpen(FPopupControl).ScaleForPPI(CurrentPPI);
  end;
  {$IFEND}
  {$HINTS ON}
  {$ENDIF}

  if Assigned(FButton) and Assigned(FBitmapContainer) and (FBitmapName <> '') then
  begin
    FButton.Bitmaps.Clear;
    FButton.Bitmaps.AddBitmapName(FBitmapName);
  end;
end;

{ TAdvLookupListBoxItem }

constructor TAdvLookupListBoxItem.Create(AIdx: Integer);
begin
  FIdx := AIdx;
end;

initialization
begin
  RegisterClass(TAdvChartEditButton);
  {$IFNDEF WEBLIB}
  {$IFNDEF LCLLIB}
  RegisterClass(TAdvChartEdit);
  {$WARNINGS OFF}
  {$HINTS OFF}
  {$IF COMPILERVERSION > 23}
  RegisterObservableMember(
    TArray<TClass>.Create(
    TAdvChartEdit
  {$IFDEF FMXLIB}
    ), 'Text', 'FMX');
  {$ENDIF}
  {$IFDEF VCLLIB}
    ), 'Text', 'VCL');
  {$ENDIF}
  {$IFEND}
  {$HINTS ON}
  {$WARNINGS ON}
  {$ENDIF}
  {$ENDIF}
end;

{$IFNDEF WEBLIB}
finalization
begin
  {$IFNDEF LCLLIB}
  {$WARNINGS OFF}
  {$HINTS OFF}
  {$IF COMPILERVERSION > 23}
  UnRegisterObservableMember(
    TArray<TClass>.Create(
    TAdvChartEdit
    ));
  {$IFEND}
  {$HINTS ON}
  {$WARNINGS ON}
  {$ENDIF}
end;
{$ENDIF}

end.
