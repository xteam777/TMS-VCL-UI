{********************************************************************}
{                                                                    }
{ written by TMS Software                                            }
{            copyright (c) 2017 - 2021                               }
{            Email : info@tmssoftware.com                            }
{            Web : http://www.tmssoftware.com                        }
{                                                                    }
{ The source code is given as is. The author is not responsible      }
{ for any possible damage done due to the use of this code.          }
{ The complete source code remains property of the author and may    }
{ not be distributed, published, given or sold in any form as such.  }
{ No parts of the source code can be included in any other component }
{ or application without written authorization of the author.        }
{********************************************************************}

unit AdvChartPersistence;

{$I TMSDEFS.inc}

{$IFDEF WEBLIB}
{$DEFINE CMNWEBLIB}
{$DEFINE LCLWEBLIB}
{$ENDIF}
{$IFDEF CMNLIB}
{$DEFINE CMNWEBLIB}
{$ENDIF}
{$IFDEF LCLLIB}
{$DEFINE LCLWEBLIB}
{$ENDIF}

interface

uses
  {$IFDEF MSWINDOWS}
  Windows,
  {$ENDIF}
  {$IFDEF LCLLIB}
  fgl,
  {$IFNDEF MSWINDOWS}
  LCLIntF,
  {$ENDIF}
  {$ENDIF}
  {$IFNDEF LCLLIB}
  Generics.Collections,
  {$ENDIF}
  Classes, TypInfo, Variants, SysUtils,
  AdvChartTypes,
  AdvChartJSONReader,
  AdvChartJSONWriter;

type
  TStreamEx = TStream;

  IAdvChartPersistence = interface
  ['{363F04AF-B8A7-4C47-A2D6-8ED9C44CEFF6}']
    procedure SaveSettingsToFile(AFileName: string; AAppearanceOnly: Boolean = False);
    procedure LoadSettingsFromFile(AFileName: string);
    procedure SaveSettingsToStream(AStream: TStreamEx; AAppearanceOnly: Boolean = False);
    procedure LoadSettingsFromStream(AStream: TStreamEx);
    function CanSaveProperty(AObject: TObject; APropertyName: string; APropertyType: TTypeKind): Boolean;
    function CanLoadProperty(AObject: TObject; APropertyName: string; APropertyType: TTypeKind): Boolean;
  end;

  IAdvBaseListIO = interface
  ['{FAB1D21E-D798-4CE0-B17B-9D75E4456AB4}']
    function GetItemClass: TClass;
  end;

  IAdvBasePersistenceIO = interface
    ['{91DEAFC3-8932-45F4-A3ED-5AAA0C0E9250}']
    function CreateObject(const AClassName: string; const ABaseClass: TClass): TObject;
  end;

  IAdvBaseCollectionIO = interface
  ['{90FDF257-7362-411D-B7F6-E2BEE2265016}']
    function AddItem(const AObject: TObject): TCollectionItem;
  end;

  IAdvChartPersistenceIO = interface(IAdvBasePersistenceIO)
  ['{11B625F8-447A-4AE5-BB88-5ECDEA979AF7}']
    function NeedsObjectReference(const AClass: TClass): Boolean;
    function GetObjectReference(const AObject: TObject): string;
    function FindObject(const AReference: string): TObject;
    procedure FixOwners(const AObject: TObject; const AObjectList: TObject);
  end;

  EAdvChartReaderException = class(Exception)
  end;

  {$IFDEF WEBLIB}
  TAdvPropertyInfo = TTypeMemberProperty;
  {$ENDIF}
  {$IFNDEF WEBLIB}
  TAdvPropertyInfo = PPropInfo;
  {$ENDIF}

  TAdvChartObjectDictionary = class(TDictionary<string, TObject>);
  TAdvChartObjectList = class(TObjectList<TObject>);
  TAdvStringList = class(TList<string>);
  TAdvIntegerList = class(TList<Integer>);
  TAdvDoubleList = class(TList<Double>);

  TAdvChartObjectArray = array of TObject;

  TAdvChartWriterCustomWritePropertyEvent = procedure(AObject: TObject; APropertyName: string; APropertyKind: TTypeKind; AWriter: TAdvChartJSONWriter; var ACanWrite: Boolean) of object;
  TAdvChartWriterCustomIsAssignablePropertyEvent = procedure(AObject: TObject; APropertyName: string; var AIsAssignable: Boolean) of object;

  TAdvExcludePropertyListArray = array of string;

  TAdvChartWriter = class
  private
    FWriter: TAdvChartJSONWriter;
    FIOReference: TObject;
    FOnCustomWriteProperty: TAdvChartWriterCustomWritePropertyEvent;
    FRootObject: TObject;
    FExcludeProperties: TAdvExcludePropertyListArray;
    FOnCustomIsAssignableProperty: TAdvChartWriterCustomIsAssignablePropertyEvent;
    procedure SetRootObject(const Value: TObject);
    procedure SetExcludeProperties(
      const Value: TAdvExcludePropertyListArray);
    procedure SetIOReference(const Value: TObject);
    property Writer: TAdvChartJSONWriter read FWriter;
    procedure WritePropInfoValue(AInstance: TObject; const APropInfo: TAdvPropertyInfo);
    procedure WriteProperties(AObject: TObject);
    procedure WriteProperty(AObject: TObject; AProp: TAdvPropertyInfo);
    procedure WriteGenericObjectList(AList: TAdvChartObjectList);
    procedure WriteGenericStringList(AList: TAdvStringList);
    procedure WriteGenericIntegerList(AList: TAdvIntegerList);
    procedure WriteGenericDoubleList(AList: TAdvDoubleList);
    procedure WriteStrings(AList: TStrings);
    procedure WriteGenericDictionary(ADictionary: TAdvChartObjectDictionary);
    procedure WriteCollection(ACollection: TCollection);
    procedure WriteList(AList: TList);
    procedure WriteBitmap(ABitmap: TAdvChartBitmap);
    procedure WriteSingleObject(AObject: TObject);
    procedure WriteObject(AObject: TObject);
  public
    constructor Create(AStream: TStreamEx);
    destructor Destroy; override;
    procedure Write(AObject: TObject);
    procedure WriteArray(AName: string; AArray: TAdvChartObjectArray);
    property JSONWriter: TAdvChartJSONWriter read FWriter;
    property IOReference: TObject read FIOReference write SetIOReference;
    property RootObject: TObject read FRootObject write SetRootObject;
    property ExcludeProperties: TAdvExcludePropertyListArray read FExcludeProperties write SetExcludeProperties;
    property OnCustomWriteProperty: TAdvChartWriterCustomWritePropertyEvent read FOnCustomWriteProperty write FOnCustomWriteProperty;
    property OnCustomIsAssignableProperty: TAdvChartWriterCustomIsAssignablePropertyEvent read FOnCustomIsAssignableProperty write FOnCustomIsAssignableProperty;
  end;

  TAdvChartReaderCustomReadPropertyEvent = procedure(AObject: TObject; APropertyName: string; APropertyKind: TTypeKind; AReader: TAdvChartJSONReader; var ACanRead: Boolean) of object;

  TAdvChartObjectReference = class
  public
    Instance: TObject;
    Prop: TAdvPropertyInfo;
    Id: string;
    constructor Create(AInstance: TObject; AProp: TAdvPropertyInfo; const AId: string);
  end;

  TAdvChartObjectReferences = TObjectList<TAdvChartObjectReference>;

  TAdvChartReader = class
  private
    FReferences: TAdvChartObjectReferences;
    FReader: TAdvChartJSONReader;
    FIOReference: TObject;
    FOnCustomReadProperty: TAdvChartReaderCustomReadPropertyEvent;
    FRootObject: TObject;
    FExcludeProperties: TAdvExcludePropertyListArray;
    FOnCustomIsAssignableProperty: TAdvChartWriterCustomIsAssignablePropertyEvent;
    function ReadSingleObject(ABaseClass: TClass): TObject; overload;
    procedure SetRootObject(const Value: TObject);
    procedure SetExcludeProperties(
      const Value: TAdvExcludePropertyListArray);
    procedure SetIOReference(const Value: TObject);
    property Reader: TAdvChartJSONReader read FReader;
    procedure ReadSingleObject(AObject: TObject); overload;
    procedure ReadProperties(AObject: TObject);
    procedure ReadProperty(AObject: TObject; AProp: TAdvPropertyInfo);
    procedure ReadPropInfoValue(AInstance: TObject; const APropInfo: TAdvPropertyInfo);
    procedure ReadExistingObject(AObject: TObject);
    procedure ReadGenericStringList(AList: TAdvStringList);
    procedure ReadGenericDoubleList(AList: TAdvDoubleList);
    procedure ReadGenericIntegerList(AList: TAdvIntegerList);
    procedure ReadStrings(AList: TStrings);
    procedure ReadGenericObjectList(AList: TAdvChartObjectList);    
    procedure ReadGenericDictionary(ADictionary: TAdvChartObjectDictionary);
    procedure ReadCollection(ACollection: TCollection);
    procedure ReadList(AList: TList);
    procedure ReadBitmap(ABitmap: TAdvChartBitmap);
    procedure ReadObject(AObject: TObject);
  public
    constructor Create(AStream: TStreamEx);
    destructor Destroy; override;
    function Read(AClass: TClass): TObject; overload;
    procedure Read(AObject: TObject); overload;
    function ReadArray(AName: string): TAdvChartObjectArray; overload;
    property JSONReader: TAdvChartJSONReader read FReader;
    property IOReference: TObject read FIOReference write SetIOReference;
    property RootObject: TObject read FRootObject write SetRootObject;
    property ExcludeProperties: TAdvExcludePropertyListArray read FExcludeProperties write SetExcludeProperties;
    property OnCustomReadProperty: TAdvChartReaderCustomReadPropertyEvent read FOnCustomReadProperty write FOnCustomReadProperty;
    property OnCustomIsAssignableProperty: TAdvChartWriterCustomIsAssignablePropertyEvent read FOnCustomIsAssignableProperty write FOnCustomIsAssignableProperty;
    procedure SolveReferences;
  end;

  {$IFDEF WEBLIB}
  PTypeInfo = TypInfo.TTypeInfo;
  {$ELSE}
  PTypeInfo = TypInfo.PTypeInfo;
  {$ENDIF}

  TAdvChartObjectPersistence = class
  public
    class function SaveObjectToString(AObject: TObject): string;
    class procedure LoadObjectFromString(AObject: TObject; AString: string);
  end;

  TAdvChartPersistence = class
  public class var
    ClassTypeVariable: string;
  private
    class var FOnCustomReadProperty: TAdvChartReaderCustomReadPropertyEvent;
    class var FOnCustomWriteProperty: TAdvChartWriterCustomWritePropertyEvent;
    class var FRootObject: TObject;
    class var FExcludeProperties: TAdvExcludePropertyListArray;
    class var FIOReference: TObject;
    class procedure DoCustomReadProperty(AObject: TObject; APropertyName: string; APropertyKind: TTypeKind; AReader: TAdvChartJSONReader; var ACanRead: Boolean);
    class procedure DoCustomWriteProperty(AObject: TObject; APropertyName: string; APropertyKind: TTypeKind; AWriter: TAdvChartJSONWriter; var ACanWrite: Boolean);
  public
    class procedure SaveSettingsToFile(AObject: TObject; AFileName: string);
    class procedure LoadSettingsFromFile(AObject: TObject; AFileName: string);
    class procedure SaveSettingsToStream(AObject: TObject; AStream: TStreamEx);
    class procedure LoadSettingsFromStream(AObject: TObject; AStream: TStreamEx);
    class procedure GetEnumValues(AValues: TStrings; APropInfo: TAdvPropertyInfo);
    class function CreateObject(const AClassName: string; BaseClass: TClass): TObject;
    class function GetPropInfoDataTypeInfo(APropInfo: TAdvPropertyInfo): PTypeInfo;
    class function GetPropInfoDataTypeInfoClassType(APropInfo: TAdvPropertyInfo): TClass;
    class function GetPropInfoType(APropInfo: TAdvPropertyInfo): TTypeKind; virtual;
    class function GetPropInfoName(APropInfo: TAdvPropertyInfo): string; virtual;
    class function GetPropInfoTypeName(APropInfo: TAdvPropertyInfo): string;
    class function GetEnumName(ATypeInfo: PTypeInfo; AValue: Integer): string;
    class function IsWriteOnly(APropInfo: TAdvPropertyInfo): Boolean; virtual;
    class function IsReadOnly(APropInfo: TAdvPropertyInfo): Boolean; virtual;
    class function IsAssignableProperty(AObject: TObject; APropInfo: TAdvPropertyInfo): Boolean; virtual;
    class function IsColor(APropertyName: string): Boolean; virtual;
    class function IsStrokeKind(APropertyName: string): Boolean; virtual;
    class function IsFillKind(APropertyName: string): Boolean; virtual;
    class function IsDate(APropertyName: string): Boolean; virtual;
    class function IsDateTime(APropertyName: string): Boolean; virtual;
    class function IsTime(APropertyName: string): Boolean; virtual;
    class function IsGenericList(AClass: TClass; AType: string = ''): Boolean; virtual;
    class function IsGenericDictionary(AClass: TClass): Boolean; virtual;
    class function IsCollection(AClass: TClass): Boolean; virtual;
    class function IsComponent(AClass: TClass): Boolean; virtual;
    class function IsControl(AClass: TClass): Boolean; virtual;
    class function IsList(AClass: TClass): Boolean; virtual;
    class function IsDescendingClass(AClass: TClass; AClassParentList: array of string): Boolean; virtual;
    class function IsBitmap(AClass: TClass): Boolean; virtual;
    class function IsStrings(AClass: TClass): Boolean; virtual;
    class property OnCustomWriteProperty: TAdvChartWriterCustomWritePropertyEvent read FOnCustomWriteProperty write FOnCustomWriteProperty;
    class property OnCustomReadProperty: TAdvChartReaderCustomReadPropertyEvent read FOnCustomReadProperty write FOnCustomReadProperty;
    class property RootObject: TObject read FRootObject write FRootObject;
    class property ExcludeProperties: TAdvExcludePropertyListArray read FExcludeProperties write FExcludeProperties;
    class property IOReference: TObject read FIOReference write FIOReference;
  end;

var
  ExcludePropertyList: array[0..52] of string = (
     'Align',
     'AllowFocus',
     'Anchors',
     'BevelEdges',
     'BevelInner',
     'BevelKind',
     'BevelOuter',
     'BevelWidth',
     'BiDiMode',
     'BitmapContainer',
     'BorderSpacing',
     'CanParentFocus',
     'ClipChildren',
     'ClipParent',
     'Constraints',
     'Ctl3D',
     'DisableFocusEffect',
     'DoubleBuffered',
     'DragCursor',
     'DragKind',
     'DragMode',
     'Enabled',
     'EnableDragHighLight',
     'Height',
     'Hint',
     'HitTest',
     'Locked',
     'Margins',
     'Name',
     'Opacity',
     'Padding',
     'ParentBiDiMode',
     'ParentColor',
     'ParentCtl3D',
     'ParentDoubleBuffered',
     'ParentFont',
     'ParentShowHint',
     'PopupMenu',
     'Position',
     'RotationAngle',
     'RotationCenter',
     'Scale',
     'ShowHint',
     'Size',
     'StyleElements',
     'StyleName',
     'TabOrder',
     'TabStop',
     'Tag',
     'Touch',
     'TouchTargetExpansion',
     'Visible',
     'Width');

implementation

uses
  {$IFDEF FMXLIB}
  UITypes,
  {$ENDIF}
  StrUtils,
  Controls,
  Graphics,
  AdvChartUtils;

const
  {$IFDEF FMXLIB}
  gcNull = $00000000;
  {$ENDIF}
  {$IFDEF CMNWEBLIB}
  gcNull = -1;
  {$ENDIF}

type
  {$IFDEF FMXLIB}
  TAdvChartPersistenceColor = TAlphaColor;
  {$ENDIF}
  {$IFDEF CMNWEBLIB}
  TAdvChartPersistenceColor = TColor;
  {$ENDIF}

type
{$IFDEF FMXLIB}
  TControlClass = class of TControl;
{$ENDIF}
{$IFDEF CMNWEBLIB}
  TCustomControlClass = class of TCustomControl;
{$ENDIF}

{$IFNDEF WEBLIB}
{$IFNDEF FMXMOBILE}
{$IFNDEF LCLLIB}
type
  {$HINTS OFF}
  {$IF COMPILERVERSION < 26}
  TSymbolNameBase = string[255];
  TSymbolName = type TSymbolNameBase;
  {$IFEND}
  {$HINTS ON}
  PSymbolName = ^TSymbolName;
{$ENDIF}
{$IFDEF LCLLIB}
type
  PSymbolName = ^ShortString;
{$ENDIF}

function GetShortStringString(const ShortStringPointer: PSymbolName): string;
begin
  Result := string(ShortStringPointer^);
end;
{$ENDIF}
{$IFDEF FMXMOBILE}
function GetShortStringString(const ShortStringPointer: PByte): string;
var
  ShortStringLength: Byte;
  FirstShortStringCharacter: MarshaledAString;
  ConvertedLength: Cardinal;
  UnicodeCharacters: array[Byte] of Char;
begin
  if not Assigned(ShortStringPointer) then
    Result := ''
  else
  begin
    ShortStringLength := ShortStringPointer^;
    if ShortStringLength = 0 then
      Result := ''
    else
    begin
      FirstShortStringCharacter := MarshaledAString(ShortStringPointer+1);
      ConvertedLength := UTF8ToUnicode(
          UnicodeCharacters,
          Length(UnicodeCharacters),
          FirstShortStringCharacter,
          ShortStringLength
        );

      ConvertedLength := ConvertedLength-1;
      SetString(Result, UnicodeCharacters, ConvertedLength);
    end;
  end;
end;
{$ENDIF}
{$ENDIF}

function GetTypeInfoEx(APropInfo: TAdvPropertyInfo): PTypeInfo;
begin
  {$IFNDEF WEBLIB}
  Result := APropInfo^.PropType{$IFNDEF LCLLIB}^{$ENDIF};
  {$ENDIF}
  {$IFDEF WEBLIB}
  Result := APropInfo.typeinfo;
  {$ENDIF}
end;

function GetColorRed(AColor: TAdvChartPersistenceColor): Byte;
begin
  {$IFDEF FMXLIB}
  Result := TAlphaColorRec(AColor).R;
  {$ENDIF}
  {$IFDEF CMNWEBLIB}
  AColor := ColorToRGB(AColor);
  Result := GetRValue(AColor);
  {$ENDIF}
end;

function GetColorGreen(AColor: TAdvChartPersistenceColor): Byte;
begin
  {$IFDEF FMXLIB}
  Result := TAlphaColorRec(AColor).G;
  {$ENDIF}
  {$IFDEF CMNWEBLIB}
  AColor := ColorToRGB(AColor);
  Result := GetGValue(AColor);
  {$ENDIF}
end;

function GetColorBlue(AColor: TAdvChartPersistenceColor): Byte;
begin
  {$IFDEF FMXLIB}
  Result := TAlphaColorRec(AColor).B;
  {$ENDIF}
  {$IFDEF CMNWEBLIB}
  AColor := ColorToRGB(AColor);
  Result := GetBValue(AColor);
  {$ENDIF}
end;

function HTMLToColorEx(AHTML: string): TAdvChartPersistenceColor;

function HexVal(s:string): Integer;
var
  i,j: Integer;
  i1, i2: Integer;
begin
  if Length(s) < 2 then
  begin
    Result := 0;
    Exit;
  end;

  {$IFDEF ZEROSTRINGINDEX}
  i1 := 0;
  i2 := 1;
  {$ELSE}
  i1 := 1;
  i2 := 2;
  {$ENDIF}

  if s[i1] >= 'A' then
    i := ord(s[i1]) - ord('A') + 10
  else
    i := ord(s[i1]) - ord('0');

  if s[i2] >= 'A' then
    j := ord(s[i2]) - ord('A') + 10
  else
    j := ord(s[i2]) - ord('0');

  Result := i shl 4 + j;
end;

{$IFDEF CMNWEBLIB}
var
  r,g,b: Integer;
begin
  r := Hexval(Copy(AHTML,2,2));
  g := Hexval(Copy(AHTML,4,2)) shl 8;
  b := Hexval(Copy(AHTML,6,2)) shl 16;
  Result :=  b + g + r;
{$ENDIF}

{$IFDEF FMXLIB}
const
  Alpha = TAdvChartPersistenceColor($FF000000);
var
  r,g,b: Integer;
begin
  r := Hexval(Copy(AHTML,2,2)) shl 16;
  g := Hexval(Copy(AHTML,4,2)) shl 8;
  b := Hexval(Copy(AHTML,6,2));
  Result := Alpha or TAdvChartPersistenceColor(b + g + r);
{$ENDIF}
end;

function ColorToHTMLEx(AColor: TAdvChartPersistenceColor): string;
const
  HTMLHexColor = '#RRGGBB';
  HexDigit: array[0..$F] of Char = '0123456789ABCDEF';
var
  c: TAdvChartPersistenceColor;
  i: Integer;
begin
  {$IFDEF ZEROSTRINGINDEX}
  i := 0;
  {$ELSE}
  i := 1;
  {$ENDIF}

  {$IFDEF FMXLIB}
  c := AColor;
  {$ENDIF}
  {$IFNDEF FMXLIB}
  c := ColorToRGB(AColor);
  {$ENDIF}
  Result := HtmlHexColor;
  Result[1 + i] := HexDigit[GetColorRed(c) shr 4];
  Result[2 + i] := HexDigit[GetColorRed(c) and $F];
  Result[3 + i] := HexDigit[GetColorGreen(c) shr 4];
  Result[4 + i] := HexDigit[GetColorGreen(c) and $F];
  Result[5 + i] := HexDigit[GetColorBlue(c) shr 4];
  Result[6 + i] := HexDigit[GetColorBlue(c) and $F];
end;

{ TAdvChartWriter }

constructor TAdvChartWriter.Create(AStream: TStreamEx);
begin
  FWriter := TAdvChartJSONWriter.Create(AStream);
end;

destructor TAdvChartWriter.Destroy;
begin
  FWriter.Free;
  inherited;
end;

procedure TAdvChartWriter.SetExcludeProperties(
  const Value: TAdvExcludePropertyListArray);
begin
  FExcludeProperties := Value;
  TAdvChartPersistence.ExcludeProperties := FExcludeProperties;
end;

procedure TAdvChartWriter.SetIOReference(const Value: TObject);
begin
  FIOReference := Value;
  TAdvChartPersistence.IOReference := FIOReference;
end;

procedure TAdvChartWriter.SetRootObject(const Value: TObject);
begin
  FRootObject := Value;
  TAdvChartPersistence.RootObject := FRootObject;
end;

procedure TAdvChartWriter.WriteGenericDictionary(
  ADictionary: TAdvChartObjectDictionary);
var
  {$IFDEF LCLLIB}
  k: Integer;
  key: string;
  {$ENDIF}
  {$IFNDEF LCLLIB}
  key: string;
  {$ENDIF}
begin
  Writer.WriteBeginArray;
  {$IFDEF LCLLIB}
  for k := 0 to ADictionary.Count - 1 do
  begin
    key := ADictionary.Keys[k];
  {$ENDIF}
  {$IFNDEF LCLLIB}
  for key in ADictionary.Keys do
  begin
  {$ENDIF}
    Writer.WriteBeginObject;
    Writer.WriteName(key);
    WriteSingleObject(ADictionary[key]);
    Writer.WriteEndObject;
  end;
  Writer.WriteEndArray;
end;

procedure TAdvChartWriter.WriteGenericDoubleList(AList: TAdvDoubleList);
var
  I: Integer;
begin
  Writer.WriteBeginArray;
  for I := 0 to AList.Count - 1 do
    Writer.WriteDouble(AList[I]);
  Writer.WriteEndArray;
end;

procedure TAdvChartWriter.WriteGenericIntegerList(AList: TAdvIntegerList);
var
  I: Integer;
begin
  Writer.WriteBeginArray;
  for I := 0 to AList.Count - 1 do
    Writer.WriteInteger(AList[I]);
  Writer.WriteEndArray;
end;

procedure TAdvChartWriter.WriteGenericObjectList(AList: TAdvChartObjectList);
var
  I: Integer;
begin
  Writer.WriteBeginArray;
  for I := 0 to AList.Count - 1 do
    WriteSingleObject(AList[I]);
  Writer.WriteEndArray;
end;

procedure TAdvChartWriter.WriteGenericStringList(AList: TAdvStringList);
var
  I: Integer;
begin
  Writer.WriteBeginArray;
  for I := 0 to AList.Count - 1 do
    Writer.WriteString(AList[I]);
  Writer.WriteEndArray;
end;

procedure TAdvChartWriter.Write(AObject: TObject);
begin
  WriteObject(AObject);
end;

procedure TAdvChartWriter.WriteArray(AName: string; AArray: TAdvChartObjectArray);
var
  I: Integer;
begin
  Writer.WriteBeginObject;
  Writer.WriteName(AName);
  Writer.WriteBeginArray;
  for I := 0 to Length(AArray) - 1 do
    WriteSingleObject(AArray[I]);
  Writer.WriteEndArray;
  Writer.WriteEndObject;
end;

procedure TAdvChartWriter.WriteBitmap(ABitmap: TAdvChartBitmap);
var
  ms: TMemoryStream;
begin
  if IsBitmapEmpty(ABitmap) then
  begin
    FWriter.WriteString('');
    Exit;
  end;

 {$IFNDEF WEBLIB}
  ms := TMemoryStream.Create;
  try
    ABitmap.SaveToStream(ms);
    ms.Position := 0;
    FWriter.WriteString(TAdvChartUtils.SaveStreamToHexStr(ms));
  finally
    ms.Free;
  end;
  {$ENDIF}
  {$IFDEF WEBLIB}
  FWriter.WriteString(ABitmap.Data);
  {$ENDIF}
end;

procedure TAdvChartWriter.WriteCollection(ACollection: TCollection);
var
  I: Integer;
begin
  Writer.WriteBeginArray;
  for I := 0 to ACollection.Count - 1 do
    WriteSingleObject(ACollection.Items[I]);
  Writer.WriteEndArray;
end;

procedure TAdvChartWriter.WriteList(AList: TList);
var
  I: Integer;
begin
  Writer.WriteBeginArray;
  for I := 0 to AList.Count - 1 do
    WriteSingleObject(TObject(AList[I]));
  Writer.WriteEndArray;
end;

procedure TAdvChartWriter.WriteObject(AObject: TObject);
var
  b: IAdvChartPersistenceIO;
begin
  if AObject = nil then
    Writer.WriteNull
  else
  begin
    if TAdvChartPersistence.IsGenericList(AObject.ClassType, 'String') then
      WriteGenericStringList(TAdvStringList(AObject))
    else if TAdvChartPersistence.IsGenericList(AObject.ClassType, 'Integer') then
      WriteGenericIntegerList(TAdvIntegerList(AObject))
    else if TAdvChartPersistence.IsGenericList(AObject.ClassType, 'Double') then
      WriteGenericDoubleList(TAdvDoubleList(AObject))
    else if TAdvChartPersistence.IsGenericList(AObject.ClassType) then
      WriteGenericObjectList(TAdvChartObjectList(AObject))
    else if TAdvChartPersistence.IsGenericDictionary(AObject.ClassType) then
      WriteGenericDictionary(TAdvChartObjectDictionary(AObject))
    else if TAdvChartPersistence.IsList(AObject.ClassType) then
      WriteList(TList(AObject))
    else if TAdvChartPersistence.IsCollection(AObject.ClassType) then
      WriteCollection(TCollection(AObject))
    else if TAdvChartPersistence.IsBitmap(AObject.ClassType) then
      WriteBitmap(TAdvChartBitmap(AObject))
    else if TAdvChartPersistence.IsDescendingClass(AObject.ClassType, ['TStrings']) then
      WriteStrings(TStrings(AObject))
    else
    begin
      if Assigned(IOReference) and Supports(IOReference, IAdvChartPersistenceIO, b) then
      begin
        if b.NeedsObjectReference(AObject.ClassType) then
          Writer.WriteString(b.GetObjectReference(AObject))
        else
          WriteSingleObject(AObject);
      end
      else
        WriteSingleObject(AObject);
    end;
  end;
end;

procedure TAdvChartWriter.WriteSingleObject(AObject: TObject);
begin
  Writer.WriteBeginObject;
  if TAdvChartPersistence.ClassTypeVariable <> '' then
  begin
    Writer.WriteName(TAdvChartPersistence.ClassTypeVariable);
    Writer.WriteString(AObject.ClassName);
  end;
  WriteProperties(AObject);
  Writer.WriteEndObject;
end;

procedure TAdvChartWriter.WriteStrings(AList: TStrings);
var
  I: Integer;
begin
  Writer.WriteBeginArray;
  for I := 0 to AList.Count - 1 do
    Writer.WriteString(AList[I]);
  Writer.WriteEndArray;
end;

procedure TAdvChartWriter.WritePropInfoValue(AInstance: TObject; const APropInfo: TAdvPropertyInfo);
var
  cn: string;
  pName: string;
  en: string;
  k: TTypeKind;
  p: TAdvPropertyInfo;
  o: TObject;
  v: TMethod;
  c: TAdvChartPersistenceColor;
begin
  if TAdvChartPersistence.IsWriteOnly(APropInfo) then
  begin
    Writer.WriteNull;
    Exit;
  end;

  o := AInstance;
  p := APropInfo;
  k := TAdvChartPersistence.GetPropInfoType(p);
  pName := TAdvChartPersistence.GetPropInfoName(p);

  case k of
    tkInteger:
    begin
      cn := TAdvChartPersistence.GetPropInfoTypeName(p);
      if (cn = 'TAlphaColor') or (cn = 'TColor') or (cn = 'TGraphicsColor') then
      begin
        if GetOrdProp(o, p) = gcNull then
          Writer.WriteString('gcNull')
        else
        begin
          c := TAdvChartPersistenceColor(GetOrdProp(o, p));
          Writer.WriteString(ColorToHTMLEx(c))
        end;
      end
      else
        Writer.WriteInteger(GetOrdProp(o, p));
    end;
    {$IFNDEF WEBLIB}tkWChar, tkLString, tkUString,{$ENDIF}tkChar, tkString{$IFDEF LCLLIB},tkAString{$ENDIF}: Writer.WriteString(GetStrProp(o, p));
    tkEnumeration:
      if TAdvChartPersistence.GetPropInfoDataTypeInfo(p) = TypeInfo(Boolean) then
        Writer.WriteBoolean(Boolean(GetOrdProp(o, p)))
      else
        Writer.WriteInteger(GetOrdProp(o, p));
    {$IFDEF LCLWEBLIB}
    tkBool: Writer.WriteBoolean(Boolean(GetOrdProp(o, p)));
    {$ENDIF}
    tkFloat: Writer.WriteDouble(GetFloatProp(o, p));
    {$IFNDEF WEBLIB}
    tkInt64: Writer.WriteInteger(GetInt64Prop(o, p));
    {$ENDIF}
    tkSet: Writer.WriteInteger(GetOrdProp(o, p));
    tkMethod:
    begin
      v := GetMethodProp(o, p);
      if v.Code = nil then
        Writer.WriteNull
      else
      begin
        if Assigned(TAdvChartPersistence.RootObject) then
          Writer.WriteString(TAdvChartPersistence.RootObject.MethodName(v.Code))
        else
          Writer.WriteNull;
      end;
    end
    else
    begin
      en := TAdvChartPersistence.GetEnumName(TypeInfo(TTypeKind), Integer(k));
      Writer.WriteNull;
      //raise EAdvChartReaderException.CreateFmt('Cannot write property %s with type %s', [pName, en]);
    end;
  end;

  if (o is TFont) and (pName = 'Size') then
  begin
    Writer.WriteName('IsFMX');
    Writer.WriteBoolean({$IFDEF FMXLIB}True{$ELSE}False{$ENDIF});
  end;
end;

procedure TAdvChartWriter.WriteProperties(AObject: TObject);
var
  {$IFNDEF WEBLIB}
  ci: Pointer;
  c: Integer;
  pl: PPropList;
  {$ENDIF}
  {$IFDEF WEBLIB}
  ci: TTypeInfoClass;
  p: TAdvPropertyInfo;
  a: TTypeMemberPropertyDynArray;
  {$ENDIF}
  I: Integer;
begin
  if Assigned(AObject) then
  begin
    {$IFNDEF WEBLIB}
    ci := AObject.ClassInfo;
    c := GetPropList(ci, tkAny, nil);
    GetMem(pl, c * SizeOf(TAdvPropertyInfo));
    {$ENDIF}
    {$IFDEF WEBLIB}
    ci := TypeInfo(AObject);
    {$ENDIF}
    try
      {$IFNDEF WEBLIB}
      GetPropList(ci, tkAny, pl);
      for I := 0 to c - 1 do
        WriteProperty(AObject, pl^[i]);
      {$ENDIF}
      {$IFDEF WEBLIB}
      a := GetPropList(ci, tkAny);
      for I := 0 to Length(a) - 1 do
        WriteProperty(AObject, a[I]);
      {$ENDIF}
    finally
      {$IFNDEF WEBLIB}
      FreeMem(pl);
      {$ENDIF}
    end;
  end;
end;

procedure TAdvChartWriter.WriteProperty(AObject: TObject; AProp: TAdvPropertyInfo);
var
  pName: string;
  k: TTypeKind;
  b, a, ap: Boolean;
  p: IAdvChartPersistence;
  o: TObject;
begin
  if not Assigned(AProp) then
    Exit;

  pName := TAdvChartPersistence.GetPropInfoName(AProp);
  k := TAdvChartPersistence.GetPropInfoType(AProp);

  b := TAdvChartUtils.IndexOfTextInArray(pName, TAdvChartPersistence.ExcludeProperties) = -1;
  if Supports(AObject, IAdvChartPersistence, p) then
    b := p.CanSaveProperty(AObject, pName, k);

  if b then
  begin
    a := True;
    if Assigned(OnCustomWriteProperty) then
      OnCustomWriteProperty(AObject, pName, k, Writer, a);

    if a then
    begin
      Writer.WriteName(pName);

      if k in [tkClass] then
      begin
        o := GetObjectProp(AObject, pName);

        ap := TAdvChartPersistence.IsAssignableProperty(AObject, AProp);

        if Assigned(OnCustomIsAssignableProperty) then
          OnCustomIsAssignableProperty(AObject, pName, ap);

        if ap then
        begin
          if o is TComponent then
            Writer.WriteString((o as TComponent).Name)
          else
            Writer.WriteString('');
        end
        else
          WriteObject(o);
      end
      else
        WritePropInfoValue(AObject, AProp);
    end;
  end;
end;

{ TAdvChartReader }

constructor TAdvChartReader.Create(AStream: TStreamEx);
begin
  FReader := TAdvChartJSONReader.Create(AStream);
  FReferences := TAdvChartObjectReferences.Create(true);
end;

destructor TAdvChartReader.Destroy;
begin
  FReader.Free;
  FReferences.Free;
  inherited;
end;

function TAdvChartReader.ReadSingleObject(ABaseClass: TClass): TObject;
var
  cn: string;
  b: IAdvBasePersistenceIO;
  p: IAdvChartPersistenceIO;
begin
  Reader.ReadBeginObject;
  if TAdvChartPersistence.ClassTypeVariable <> '' then
  begin
    if not Reader.HasNext or (Reader.ReadName <> TAdvChartPersistence.ClassTypeVariable) then
      raise EAdvChartReaderException.Create('"'+TAdvChartPersistence.ClassTypeVariable+'" property not found in Object descriptor.');
    cn := Reader.ReadString;
  end;

  if cn = '' then
    cn := ABaseClass.ClassName;

  if Assigned(FIOReference) then
  begin
    Result := nil;
    if Supports(FIOReference, IAdvBasePersistenceIO, b) then
      Result := b.CreateObject(cn, ABaseClass)
    else if Supports(FIOReference, IAdvChartPersistenceIO, p) then
      Result := p.CreateObject(cn, ABaseClass);
  end
  else
    Result := TAdvChartPersistence.CreateObject(cn, ABaseClass);
    
  try
    ReadProperties(Result);
    Reader.ReadEndObject;
  except
    Result.Free;
    raise;
  end;
end;

procedure TAdvChartReader.ReadExistingObject(AObject: TObject);
begin
  if Assigned(AObject) then
  begin
    Reader.ReadBeginObject;
    if TAdvChartPersistence.ClassTypeVariable <> '' then
    begin
      if not Reader.HasNext or (Reader.ReadName <> TAdvChartPersistence.ClassTypeVariable) then
        raise EAdvChartReaderException.Create('"'+TAdvChartPersistence.ClassTypeVariable+'" property not found in Object descriptor.');

      Reader.ReadString;
    end;

    ReadProperties(AObject);
    Reader.ReadEndObject;
  end
  else
    Reader.ReadNull;
end;

procedure TAdvChartReader.ReadGenericDictionary(ADictionary: TAdvChartObjectDictionary);
var
  obj: TObject;
  k: string;
  c: TClass;
  i: IAdvBaseListIO;
begin
  c := TObject;
  if Supports(ADictionary, IAdvBaseListIO, i) then
    c := i.GetItemClass;

  ADictionary.Clear;
  Reader.ReadBeginArray;
  while Reader.HasNext do
  begin
    if not Reader.IsNull then
    begin
      Reader.ReadBeginObject;
      k := Reader.ReadName;
      obj := ReadSingleObject(c);
      ADictionary.Add(k, obj);
      Reader.ReadEndObject;
    end
    else
      Reader.SkipValue;
  end;
  Reader.ReadEndArray;
end;

procedure TAdvChartReader.ReadGenericStringList(AList: TAdvStringList);
var
  obj: string;
begin
  AList.Clear;
  Reader.ReadBeginArray;
  while Reader.HasNext do
  begin
    if not Reader.IsNull then
    begin
      obj := Reader.ReadString;
      AList.Add(obj);
    end
    else
      Reader.SkipValue;
  end;
  Reader.ReadEndArray;
end;

procedure TAdvChartReader.ReadGenericIntegerList(AList: TAdvIntegerList);
var
  obj: Integer;
begin
  AList.Clear;
  Reader.ReadBeginArray;
  while Reader.HasNext do
  begin
    if not Reader.IsNull then
    begin
      obj := Reader.ReadInteger;
      AList.Add(obj);
    end
    else
      Reader.SkipValue;
  end;
  Reader.ReadEndArray;
end;

procedure TAdvChartReader.ReadGenericDoubleList(AList: TAdvDoubleList);
var
  obj: Double;
begin
  AList.Clear;
  Reader.ReadBeginArray;
  while Reader.HasNext do
  begin
    if not Reader.IsNull then
    begin
      obj := Reader.ReadDouble;
      AList.Add(obj);
    end
    else
      Reader.SkipValue;
  end;
  Reader.ReadEndArray;
end;

procedure TAdvChartReader.ReadGenericObjectList(AList: TAdvChartObjectList);
var
  obj: TObject;
  b: IAdvChartPersistenceIO;
  c: TClass;
  i: IAdvBaseListIO;
begin
  c := TObject;
  if Supports(AList, IAdvBaseListIO, i) then
    c := i.GetItemClass;

  AList.Clear;
  Reader.ReadBeginArray;
  while Reader.HasNext do
  begin
    if not Reader.IsNull then
    begin
      obj := ReadSingleObject(c);
      if Assigned(IOReference) and Supports(IOReference, IAdvChartPersistenceIO, b) then
        b.FixOwners(obj, AList);
      AList.Add(obj);
    end
    else
      Reader.SkipValue;
  end;
  Reader.ReadEndArray;
end;

function TAdvChartReader.Read(AClass: TClass): TObject;
begin
  Result := ReadSingleObject(AClass);
end;

procedure TAdvChartReader.Read(AObject: TObject);
begin
  ReadObject(AObject);
end;

procedure TAdvChartReader.ReadBitmap(ABitmap: TAdvChartBitmap);
var
  s: string;
  ms: TMemoryStream;
begin
  if Reader.IsNull then
    Exit;

  s := Reader.ReadString;
  if s <> '' then
  begin
    {$IFNDEF WEBLIB}
    ms := TMemoryStream.Create;
    try
      TAdvChartUtils.LoadStreamFromHexStr(s, ms);
      ms.Position := 0;
      ABitmap.LoadFromStream(ms);
    finally
      ms.Free;
    end;
    {$ELSE}
    ABitmap.Data := s;
    {$ENDIF}
  end;
end;

procedure TAdvChartReader.ReadCollection(ACollection: TCollection);
var
  obj: TObject;
  c: TClass;
  i: IAdvBaseListIO;
  ii: IAdvBaseCollectionIO;
begin
  c := TObject;
  if Supports(ACollection, IAdvBaseListIO, i) then
    c := i.GetItemClass;

  Supports(ACollection, IAdvBaseCollectionIO, ii);

  ACollection.Clear;
  Reader.ReadBeginArray;
  while Reader.HasNext do
  begin
    if not Reader.IsNull then
    begin
      obj := ReadSingleObject(c);
      if Assigned(obj) then
      begin
        try
          if obj is TPersistent then
          begin
            if Assigned(ii) then
              ii.AddItem(obj).Assign(obj as TPersistent)
            else
              ACollection.Add.Assign(obj as TPersistent);
          end;
        finally
          obj.Free;
        end;
      end;
    end
    else
      Reader.SkipValue;
  end;
  Reader.ReadEndArray;
end;

function TAdvChartReader.ReadArray(AName: string): TAdvChartObjectArray;
var
  Name: string;
begin
  Reader.ReadBeginObject;
  while Reader.HasNext do
  begin
    if not Reader.IsNull then
    begin
      Name := Reader.ReadName;
      if Name = AName then
      begin
        Reader.ReadBeginArray;
        while Reader.HasNext do
        begin
          SetLength(Result, Length(Result) + 1);
          Result[Length(Result) - 1] := ReadSingleObject(TObject);
        end;
        Reader.ReadEndArray;
      end
      else
        Reader.SkipValue;
    end
    else
      Reader.SkipValue;
  end;
end;

procedure TAdvChartReader.ReadList(AList: TList);
var
  obj: TObject;
  b: IAdvChartPersistenceIO;
  c: TClass;
  i: IAdvBaseListIO;
begin
  c := TObject;
  if Supports(AList, IAdvBaseListIO, i) then
    c := i.GetItemClass;

  AList.Clear;
  Reader.ReadBeginArray;
  while Reader.HasNext do
  begin
    if not Reader.IsNull then
    begin
      obj := ReadSingleObject(c);
      if Assigned(IOReference) and Supports(IOReference, IAdvChartPersistenceIO, b) then
        b.FixOwners(obj, AList);
      AList.Add(obj);
    end
    else
      Reader.SkipValue;
  end;
  Reader.ReadEndArray;
end;

procedure TAdvChartReader.ReadObject(AObject: TObject);
begin
  if AObject = nil then
    Reader.ReadNull
  else
  begin
    if TAdvChartPersistence.IsGenericList(AObject.ClassType, 'String') then
      ReadGenericStringList(TAdvStringList(AObject))
    else if TAdvChartPersistence.IsGenericList(AObject.ClassType, 'Double') then
      ReadGenericDoubleList(TAdvDoubleList(AObject))
    else if TAdvChartPersistence.IsGenericList(AObject.ClassType, 'Integer') then
      ReadGenericIntegerList(TAdvIntegerList(AObject))
    else if TAdvChartPersistence.IsGenericList(AObject.ClassType) then
      ReadGenericObjectList(TAdvChartObjectList(AObject))
    else if TAdvChartPersistence.IsGenericDictionary(AObject.ClassType) then
      ReadGenericDictionary(TAdvChartObjectDictionary(AObject))
    else if TAdvChartPersistence.IsList(AObject.ClassType) then
      ReadList(TList(AObject))
    else if TAdvChartPersistence.IsCollection(AObject.ClassType) then
      ReadCollection(TCollection(AObject))
    else if TAdvChartPersistence.IsBitmap(AObject.ClassType) then
      ReadBitmap(TAdvChartBitmap(AObject))
    else if TAdvChartPersistence.IsDescendingClass(AObject.ClassType, ['TStrings']) then
      ReadStrings(TStrings(AObject))
    else
      ReadSingleObject(AObject);
  end;
end;

procedure TAdvChartReader.ReadProperties(AObject: TObject);
var
  Prop: TAdvPropertyInfo;
begin
  while Reader.HasNext do
  begin
    if not Reader.IsNull then
    begin
      Prop := nil;
      if Assigned(AObject) then
        Prop := GetPropInfo(AObject, Reader.ReadName);
      if Assigned(Prop) then
        ReadProperty(AObject, Prop)
      else
        Reader.SkipValue;
    end
    else
      Reader.SkipValue;
  end;
end;

procedure TAdvChartReader.ReadProperty(AObject: TObject; AProp: TAdvPropertyInfo);
var
  pName: string;
  ct: TClass;
  b: Boolean;
  p: IAdvChartPersistence;
  pio: IAdvChartPersistenceIO;
  k: TTypeKind;
  a, ap: Boolean;
  o: TObject;
  n: string;
begin
  if not Assigned(AProp) then
    Exit;

  k := TAdvChartPersistence.GetPropInfoType(AProp);
  pName := TAdvChartPersistence.GetPropInfoName(AProp);

  b := TAdvChartUtils.IndexOfTextInArray(pName, TAdvChartPersistence.ExcludeProperties) = -1;
  if Supports(AObject, IAdvChartPersistence, p) then
    b := p.CanLoadProperty(AObject, pName, k);

  if b then
  begin
    a := True;
    if Assigned(OnCustomReadProperty) then
      OnCustomReadProperty(AObject, pName, k, Reader, a);

    if a then
    begin
      if k in [tkClass] then
      begin
        ct := TAdvChartPersistence.GetPropInfoDataTypeInfoClassType(AProp);
        if TAdvChartPersistence.IsGenericList(ct, 'String') then
          ReadGenericStringList(TAdvStringList(GetObjectProp(AObject, pName)))
        else if TAdvChartPersistence.IsGenericList(ct) then
          ReadGenericObjectList(TAdvChartObjectList(GetObjectProp(AObject, pName)))
        else if TAdvChartPersistence.IsGenericDictionary(ct) then
          ReadGenericDictionary(TAdvChartObjectDictionary(GetObjectProp(AObject, pName)))
        else if TAdvChartPersistence.IsList(ct) then
          ReadList(TList(GetObjectProp(AObject, pName)))
        else if TAdvChartPersistence.IsCollection(ct) then
          ReadCollection(TCollection(GetObjectProp(AObject, pName)))
        else if TAdvChartPersistence.IsBitmap(ct) then
          ReadBitmap(TAdvChartBitmap(GetObjectProp(AObject, pName)))
        else if TAdvChartPersistence.IsDescendingClass(ct, ['TStrings']) then
          ReadStrings(TStrings(GetObjectProp(AObject, pName)))
        else
        begin
          a := False;
          if Assigned(IOReference) and Supports(IOReference, IAdvChartPersistenceIO, pio) then
            a := pio.NeedsObjectReference(ct);

          if a then
          begin
            if Reader.IsNull then
            begin
              Reader.ReadNull;
              SetObjectProp(AObject, pName, nil);
            end
            else
              FReferences.Add(TAdvChartObjectReference.Create(AObject, AProp, Reader.ReadString));
          end
          else
          begin
            o := GetObjectProp(AObject, pName);

            ap := TAdvChartPersistence.IsAssignableProperty(AObject, AProp);
            if Assigned(OnCustomIsAssignableProperty) then
              OnCustomIsAssignableProperty(AObject, pName, ap);

            if ap then
            begin
              n := Reader.ReadString;
              if Assigned(FRootObject) and (FRootObject is TComponent) then
                SetObjectProp(AObject, pName, (FRootObject as TComponent).FindComponent(n));
            end
            else
              ReadExistingObject(o);
          end;
        end;
      end
      else
        ReadPropInfoValue(AObject, AProp);
    end;
  end
  else
    Reader.SkipValue;
end;

procedure TAdvChartReader.ReadPropInfoValue(AInstance: TObject; const APropInfo: TAdvPropertyInfo);
var
  pName, cn, cnv, en: string;
  k: TTypeKind;
  p: TAdvPropertyInfo;
  o: TObject;
  i: Integer;
  s: string;
  b: Boolean;
  d: Double;
  ii: Int64;
  v: string;
  m: TMethod;
  bsz: Boolean;
begin
  if TAdvChartPersistence.IsWriteOnly(APropInfo) or Reader.IsNull then
  begin
    Reader.ReadNull;        
    Exit;
  end;
 
  o := AInstance;
  p := APropInfo;
  pName := TAdvChartPersistence.GetPropInfoName(p);
  k := TAdvChartPersistence.GetPropInfoType(p);

  case k of
    tkInteger:
    begin
      cn := TAdvChartPersistence.GetPropInfoTypeName(p);
      if (cn = 'TAlphaColor') or (cn = 'TColor') or (cn = 'TGraphicsColor') then
      begin
        cnv := Reader.ReadString;
        if not TAdvChartPersistence.IsReadOnly(p) then
        begin
          if cnv = 'gcNull' then
            SetOrdProp(o, pName, gcNull)
          else
          begin
            {$RANGECHECKS OFF}
            SetOrdProp(o, pName, HTMLToColorEx(cnv));
            {$RANGECHECKS ON}
          end;
        end;
      end
      else
      begin
        i := Reader.ReadInteger;
        if not TAdvChartPersistence.IsReadOnly(p) then
          SetOrdProp(o, p, i);
      end;
    end;
    {$IFNDEF WEBLIB}tkWChar, tkLString, tkUString,{$ENDIF}tkChar, tkString{$IFDEF LCLLIB},tkAString{$ENDIF}: 
    begin
      s := Reader.ReadString;
      if not TAdvChartPersistence.IsReadOnly(p) then
        SetStrProp(o, p, s);
    end;
    tkEnumeration:
      if TAdvChartPersistence.GetPropInfoDataTypeInfo(p) = TypeInfo(Boolean) then
      begin
        b := Reader.ReadBoolean;
        if not TAdvChartPersistence.IsReadOnly(p) then        
          SetOrdProp(o, p, Integer(b))
      end
      else
      begin
        i := Reader.ReadInteger;
        if not TAdvChartPersistence.IsReadOnly(p) then        
          SetOrdProp(o, p, i);
      end;
    {$IFDEF LCLWEBLIB}
    tkBool:
    begin
      b := Reader.ReadBoolean;
      if not TAdvChartPersistence.IsReadOnly(p) then
        SetOrdProp(o, p, Integer(b))
    end;
    {$ENDIF}
    tkFloat:
    begin
      d := Reader.ReadDouble;
      if not TAdvChartPersistence.IsReadOnly(p) then
        SetFloatProp(o, p, d)
    end;
    {$IFNDEF WEBLIB}
    tkInt64:
    begin
      ii := Reader.ReadInt64;
      if not TAdvChartPersistence.IsReadOnly(p) then
        SetOrdProp(o, p, ii)
    end;
    {$ENDIF}
    tkSet:
    begin
      i := Reader.ReadInteger;
      if not TAdvChartPersistence.IsReadOnly(p) then
        SetOrdProp(o, p, i);
    end;
    tkMethod:
    begin
      m.Data := nil;
      m.Code := nil;
      if Reader.IsNull then
        Reader.ReadNull
      else
      begin
        if Assigned(TAdvChartPersistence.RootObject) then
        begin
          v := Reader.ReadString;
          m.Code := TAdvChartPersistence.RootObject.MethodAddress(v);
          if m.Code <> nil then
            m.Data := TAdvChartPersistence.RootObject;
        end
        else
          Reader.ReadNull;
      end;

      SetMethodProp(o, p, m);
    end
    else
    begin
      en := TAdvChartPersistence.GetEnumName(TypeInfo(TTypeKind), Integer(k));
      Reader.ReadNull;
      //raise EAdvChartReaderException.CreateFmt('Cannot read property %s with type %s', [pName, en]);
    end;
  end;

  if (o is TFont) and (pName = 'Size') then
  begin
    if Reader.HasNext then
    begin
      s := Reader.PeekName;
      if s = 'IsFMX' then
      begin
        Reader.ReadName;
        bsz := Reader.ReadBoolean;
        if bsz then
        begin
          {$IFNDEF FMXLIB}
          (o as TFont).Size := Round(((o as TFont).Size / 96) * 72);
          {$ENDIF}
        end
        else
        begin
          {$IFDEF FMXLIB}
          (o as TFont).Size := ((o as TFont).Size / 72) * 96;
          {$ENDIF}
        end;
      end;
    end;
  end;
end;

procedure TAdvChartReader.ReadSingleObject(AObject: TObject);
begin
  Reader.ReadBeginObject;
  if TAdvChartPersistence.ClassTypeVariable <> '' then
  begin
    if not Reader.HasNext or (Reader.ReadName <> TAdvChartPersistence.ClassTypeVariable) then
      raise EAdvChartReaderException.Create('"'+TAdvChartPersistence.ClassTypeVariable+'" property not found in Object descriptor.');
    Reader.ReadString;
  end;

  try
    ReadProperties(AObject);
    Reader.ReadEndObject;
  except
    raise;
  end;
end;

procedure TAdvChartReader.ReadStrings(AList: TStrings);
var
  obj: string;
begin
  AList.Clear;
  Reader.ReadBeginArray;
  while Reader.HasNext do
  begin
    if not Reader.IsNull then
    begin
      obj := Reader.ReadString;
      AList.Add(obj);
    end
    else
      Reader.SkipValue;
  end;
  Reader.ReadEndArray;
end;

procedure TAdvChartReader.SetExcludeProperties(
  const Value: TAdvExcludePropertyListArray);
begin
  FExcludeProperties := Value;
  TAdvChartPersistence.ExcludeProperties := FExcludeProperties;
end;

procedure TAdvChartReader.SetIOReference(const Value: TObject);
begin
  FIOReference := Value;
  TAdvChartPersistence.IOReference := FIOReference;
end;

procedure TAdvChartReader.SetRootObject(const Value: TObject);
begin
  FRootObject := Value;
  TAdvChartPersistence.RootObject := FRootObject;
end;

procedure TAdvChartReader.SolveReferences;
var
  b: IAdvChartPersistenceIO;
  r: Integer;
  rf: TAdvChartObjectReference;
  o: TObject;
begin
  if Assigned(IOReference) and Supports(IOReference, IAdvChartPersistenceIO, b) then
  begin
    for r := 0 to FReferences.Count - 1 do
    begin
      rf := FReferences[r];
      o := b.FindObject(rf.Id);
      SetObjectProp(rf.Instance, rf.Prop, o);
    end;
  end;
end;

{ TAdvChartObjectReference }

constructor TAdvChartObjectReference.Create(AInstance: TObject;
  AProp: TAdvPropertyInfo; const AId: string);
begin
  Instance := AInstance;
  Prop := AProp;
  Id := AId;
end;

{ TAdvChartPersistence }

class procedure TAdvChartPersistence.LoadSettingsFromFile(AObject: TObject; AFileName: string);
var
  ms: TMemoryStream;
begin
  ms := TMemoryStream.Create;
  try
    {$IFNDEF WEBLIB}
    ms.LoadFromFile(AFileName);
    {$ENDIF}
    LoadSettingsFromStream(AObject, ms);
  finally
    ms.Free;
  end;
end;

class procedure TAdvChartPersistence.LoadSettingsFromStream(AObject: TObject; AStream: TStreamEx);
var
  Reader: TAdvChartReader;
  {$IFDEF WEBLIB}
  d, t: string;
  {$ENDIF}
  {$IFNDEF WEBLIB}
  d, t: Char;
  {$ENDIF}
begin
  AStream.Position := 0;
  Reader := TAdvChartReader.Create(AStream);
  t := FormatSettings.ThousandSeparator;
  d := FormatSettings.DecimalSeparator;
  try
    Reader.IOReference := TAdvChartPersistence.IOReference;
    Reader.RootObject := TAdvChartPersistence.RootObject;
    Reader.OnCustomReadProperty := DoCustomReadProperty;
    FormatSettings.DecimalSeparator := '.';
    FormatSettings.ThousandSeparator := ',';
    Reader.Read(AObject);
  finally
    FormatSettings.DecimalSeparator := d;
    FormatSettings.ThousandSeparator := t;
    Reader.Free;
  end;
end;

class procedure TAdvChartPersistence.SaveSettingsToFile(AObject: TObject;
  AFileName: string);
var
  ms: TMemoryStream;
begin
  ms := TMemoryStream.Create;
  try
    SaveSettingsToStream(AObject, ms);
    ms.SaveToFile(AFileName);
  finally
    ms.Free;
  end;
end;

class procedure TAdvChartPersistence.SaveSettingsToStream(AObject: TObject;
  AStream: TStreamEx);
var
  Writer: TAdvChartWriter;
  {$IFDEF WEBLIB}
  d, t: string;
  {$ENDIF}
  {$IFNDEF WEBLIB}
  d, t: Char;
  {$ENDIF}
begin
  Writer := TAdvChartWriter.Create(AStream);
  t := FormatSettings.ThousandSeparator;
  d := FormatSettings.DecimalSeparator;
  try
    Writer.IOReference := TAdvChartPersistence.IOReference;
    Writer.RootObject := TAdvChartPersistence.RootObject;
    Writer.OnCustomWriteProperty := DoCustomWriteProperty;
    FormatSettings.DecimalSeparator := '.';
    FormatSettings.ThousandSeparator := ',';
    Writer.Write(AObject);
  finally
    FormatSettings.DecimalSeparator := d;
    FormatSettings.ThousandSeparator := t;
    Writer.Free;
  end;
end;

class procedure TAdvChartPersistence.GetEnumValues(AValues: TStrings; APropInfo: TAdvPropertyInfo);
var
  p: PTypeInfo;
  {$IFNDEF WEBLIB}
  su: PTypeData;
  {$IFNDEF LCLLIB}
  ct: PPTypeInfo;
  {$ENDIF}
  {$IFDEF LCLLIB}
  ct: PTypeInfo;
  {$ENDIF}
  {$ENDIF}
  {$IFDEF WEBLIB}
  pi: TTypeInfoInteger;
  ps: PTypeInfo;
  {$ENDIF}
  I: Integer;
  k: TTypeKind;
begin
  p := GetTypeInfoEx(APropInfo);
  {$IFNDEF WEBLIB}
  su := GetTypeData(p);
  if Assigned(su) then
  begin
    if p{$IFDEF LCLLIB}^{$ENDIF}.Kind = tkSet then
    begin
      ct := su^.CompType;
      if Assigned(ct) then
      begin
        k := ct^.Kind;
        case k of
          tkEnumeration:
          begin
            su := GetTypeData(ct{$IFNDEF LCLLIB}^{$ENDIF});
            for i := su^.MinValue to su^.MaxValue do
              AValues.Add(TAdvChartPersistence.GetEnumName(ct{$IFNDEF LCLLIB}^{$ENDIF},i));
          end;
        end;
      end;
    end
    else
    begin
      for i := su^.MinValue to su^.MaxValue do
        AValues.Add(TAdvChartPersistence.GetEnumName(p,i));
    end;
  end;
  {$ENDIF}
  {$IFDEF WEBLIB}
  if Assigned(p) and (p is TTypeInfoSet) then
    p := TTypeInfoSet(p).comptype;

  if Assigned(p) and (p is TTypeInfoInteger) then
  begin
   pi := TTypeInfoInteger(p);
   for i := pi.MinValue to pi.MaxValue do
     AValues.Add(TAdvChartPersistence.GetEnumName(p, i));
  end;
  {$ENDIF}
end;

class function TAdvChartPersistence.GetPropInfoDataTypeInfoClassType(APropInfo: TAdvPropertyInfo): TClass;
{$IFDEF WEBLIB}
var
  t: PTypeInfo;
{$ENDIF}
begin
  {$IFNDEF WEBLIB}
  Result := GetTypeData(APropInfo^.PropType{$IFNDEF LCLLIB}^{$ENDIF})^.ClassType
  {$ENDIF}
  {$IFDEF WEBLIB}
  Result := nil;
  if Assigned(APropInfo) and Assigned(APropInfo.typeinfo) then
  begin
    t := APropInfo.typeinfo;
    asm
      if (t.class){
        return t.class.ClassType();
      }
    end;
  end;
  {$ENDIF}
end;

class function TAdvChartPersistence.GetPropInfoDataTypeInfo(
  APropInfo: TAdvPropertyInfo): PTypeInfo;
begin
  {$IFNDEF WEBLIB}
  Result := GetTypeData(APropInfo^.PropType{$IFNDEF LCLLIB}^{$ENDIF})^.BaseType{$IFNDEF LCLLIB}^{$ENDIF}
  {$ENDIF}
  {$IFDEF WEBLIB}
  Result := nil;
  if Assigned(APropInfo) then
    Result := APropInfo.typeinfo;
  {$ENDIF}
end;

class function TAdvChartPersistence.GetPropInfoName(APropInfo: TAdvPropertyInfo): string;
begin
  {$IFNDEF WEBLIB}
  Result := GetShortStringString(@APropInfo{$IFDEF LCLLIB}^{$ENDIF}.Name);
  {$ENDIF}
  {$IFDEF WEBLIB}
  Result := APropInfo.name;
  {$ENDIF}
end;

class function TAdvChartPersistence.GetPropInfoType(APropInfo: TAdvPropertyInfo): TTypeKind;
begin
  {$IFNDEF WEBLIB}
  Result := APropInfo^.PropType^{$IFNDEF LCLLIB}^{$ENDIF}.Kind;
  {$ENDIF}
  {$IFDEF WEBLIB}
  if Assigned(APropInfo.typeinfo) then
    Result := APropInfo.typeinfo.kind
  else
    Result := tkUnknown;
  {$ENDIF}
end;

class procedure TAdvChartPersistence.DoCustomReadProperty(AObject: TObject;
  APropertyName: string; APropertyKind: TTypeKind; AReader: TAdvChartJSONReader;
  var ACanRead: Boolean);
begin
  if Assigned(OnCustomReadProperty) then
    OnCustomReadProperty(AObject, APropertyName, APropertyKind, AReader, ACanRead);
end;

class procedure TAdvChartPersistence.DoCustomWriteProperty(AObject: TObject;
  APropertyName: string; APropertyKind: TTypeKind; AWriter: TAdvChartJSONWriter;
  var ACanWrite: Boolean);
begin
  if Assigned(OnCustomWriteProperty) then
    OnCustomWriteProperty(AObject, APropertyName, APropertyKind, AWriter, ACanWrite);
end;

class function TAdvChartPersistence.GetEnumName(ATypeInfo: PTypeInfo; AValue: Integer): string;
begin
  {$IFNDEF WEBLIB}
  Result := TypInfo.GetEnumName(ATypeInfo, AValue);
  {$ENDIF}
  {$IFDEF WEBLIB}
  Result := TTypeInfoEnum(ATypeInfo).EnumType.IntToName[AValue];
  {$ENDIF}
end;

class function TAdvChartPersistence.GetPropInfoTypeName(APropInfo: TAdvPropertyInfo): string;
begin
  {$IFNDEF WEBLIB}
  Result := GetShortStringString(@APropInfo{$IFDEF LCLLIB}^{$ENDIF}.PropType^.Name);
  {$ENDIF}
  {$IFDEF WEBLIB}
  Result := '';
  if Assigned(APropInfo.typeinfo) then
    Result := APropInfo.typeinfo.name;
  {$ENDIF}
end;

class function TAdvChartPersistence.IsList(AClass: TClass): boolean;
begin
  Result := IsDescendingClass(AClass, ['TList']);
end;

class function TAdvChartPersistence.IsAssignableProperty(AObject: TObject;
  APropInfo: TAdvPropertyInfo): Boolean;
var
  oProp: TObject;
  k: TTypeKind;
  pName: string;
begin
  Result := False;
  k := GetPropInfoType(APropInfo);
  if k in [tkClass] then
  begin
    pName := GetPropInfoName(APropInfo);
    oProp := GetObjectProp(AObject, pName);
    Result := (Assigned(oProp) and IsComponent(oProp.ClassType)) or not Assigned(oProp);
  end;
end;

class function TAdvChartPersistence.IsBitmap(AClass: TClass): Boolean;
begin
  Result := IsDescendingClass(AClass, ['TBitmap', 'TPicture', 'TAdvChartBitmap'{$IFDEF WEBLIB}, 'TGraphic'{$ENDIF}]);
end;

class function TAdvChartPersistence.IsReadOnly(
  APropInfo: TAdvPropertyInfo): Boolean;
begin
  {$IFNDEF WEBLIB}
  Result := APropInfo^.SetProc = nil;
  {$ENDIF}
  {$IFDEF WEBLIB}
  Result := APropInfo.setter = '';
  {$ENDIF}
end;

class function TAdvChartPersistence.IsStrings(AClass: TClass): Boolean;
begin
  Result := IsDescendingClass(AClass, ['TStrings']);
end;

class function TAdvChartPersistence.IsStrokeKind(APropertyName: string): Boolean;
begin
  Result := (APropertyName = 'TAdvChartGraphicsStrokeKind');
end;

class function TAdvChartPersistence.IsTime(APropertyName: string): Boolean;
begin
  Result := (APropertyName = 'TTime');
end;

class function TAdvChartPersistence.IsWriteOnly(APropInfo: TAdvPropertyInfo): Boolean;
begin
  {$IFNDEF WEBLIB}
  Result := APropInfo^.GetProc = nil;
  {$ENDIF}
  {$IFDEF WEBLIB}
  Result := APropInfo.getter = '';
  {$ENDIF}
end;

class function TAdvChartPersistence.IsCollection(AClass: TClass): Boolean;
begin
  Result := IsDescendingClass(AClass, ['TCollection']);
end;

class function TAdvChartPersistence.IsColor(APropertyName: string): Boolean;
begin
  Result := (APropertyName = 'TAlphaColor') or (APropertyName = 'TColor') or (APropertyName = 'TGraphicsColor');
end;

class function TAdvChartPersistence.IsComponent(AClass: TClass): Boolean;
begin
  Result := IsDescendingClass(AClass, ['TComponent', 'TAdvChartCustomComponent']);
end;

class function TAdvChartPersistence.IsControl(AClass: TClass): Boolean;
begin
  Result := IsDescendingClass(AClass, ['TControl']);
end;

class function TAdvChartPersistence.IsDate(APropertyName: string): Boolean;
begin
  Result := (APropertyName = 'TDate');
end;

class function TAdvChartPersistence.IsDateTime(APropertyName: string): Boolean;
begin
  Result := (APropertyName = 'TDateTime');
end;

class function TAdvChartPersistence.IsDescendingClass(AClass: TClass;
  AClassParentList: array of string): Boolean;
var
  cn: string;
  I: Integer;
begin
  if not Assigned(AClass) then
    Exit(False);
  repeat
    cn := AClass.ClassName;
    for I := 0 to Length(AClassParentList) - 1 do
    begin
      if (cn = AClassParentList[I]) then
        Exit(True);
    end;
    AClass := AClass.ClassParent;
  until not Assigned(AClass);
  Result := False;
end;

class function TAdvChartPersistence.IsFillKind(APropertyName: string): Boolean;
begin
  Result := (APropertyName = 'TAdvChartGraphicsFillKind');
end;

class function TAdvChartPersistence.IsGenericDictionary(AClass: TClass): Boolean;
var
  cn: string;
begin
  if not Assigned(AClass) then
    Exit(False);
  repeat
    cn := AClass.ClassName;
    if AnsiStartsStr('TDictionary<', cn) or AnsiStartsStr('TObjectDictionary<', cn) then
      Exit(True);
    AClass := AClass.ClassParent;
  until not Assigned(AClass);
  Result := False;
end;

class function TAdvChartPersistence.IsGenericList(AClass: TClass; AType: string = ''): Boolean;
var
  cn: string;
begin
  if not Assigned(AClass) then
    Exit(False);
  repeat
    cn := AClass.ClassName;
    if AnsiStartsStr('TList<', cn) or AnsiStartsStr('TObjectList<', cn) then
    begin
      if (AType = '') or ((AType <> '') and (Pos(LowerCase(AType), LowerCase(cn)) > 0) or (Pos(LowerCase(AType), LowerCase(cn)) > 0)) then
        Exit(True);
    end;
    AClass := AClass.ClassParent;
  until not Assigned(AClass);
  Result := False;
end;

class function TAdvChartPersistence.CreateObject(const AClassName: string;
  BaseClass: TClass): TObject;
var
  ObjType: TPersistentClass;
begin
  ObjType := GetClass(AClassName);
  if ObjType = nil then
    raise EAdvChartReaderException.CreateFmt('Type "%s" not found', [AClassName]);
  if not ObjType.InheritsFrom(TObject) then
    raise EAdvChartReaderException.Create('Type "%s" is not an class type');
  if BaseClass <> nil then
    if not ObjType.InheritsFrom(BaseClass) then
      raise EAdvChartReaderException.CreateFmt('Type "%s" does not inherit from %s',
        [AClassName, BaseClass.ClassName]);

  {$IFDEF CMNWEBLIB}
  if ObjType.InheritsFrom(TCustomControl) then
    Result := TCustomControlClass(ObjType).Create(nil)
  {$ENDIF}
  {$IFDEF FMXLIB}
  if ObjType.InheritsFrom(TControl) then
    Result := TControlClass(ObjType).Create(nil)
  {$ENDIF}
  else if ObjType.InheritsFrom(TComponent) then
    Result := TComponentClass(ObjType).Create(nil)
  else if ObjType.InheritsFrom(TCollectionItem) then
    Result := TCollectionItemClass(ObjType).Create(nil)
  else if ObjType.InheritsFrom(TPersistent) then
    Result := TPersistentClass(ObjType).Create
  else
    raise EAdvChartReaderException.CreateFmt('Type "%s" not supported', [AClassName]);
end;

{ TAdvChartObjectPersistence }

class procedure TAdvChartObjectPersistence.LoadObjectFromString(AObject: TObject; AString: string);
var
  ms: TStringStream;
begin
  ms := TStringStream.Create(AString);
  try
    TAdvChartPersistence.LoadSettingsFromStream(AObject, ms);
  finally
    ms.Free;
  end;
end;

class function TAdvChartObjectPersistence.SaveObjectToString(
  AObject: TObject): string;
var
  ss: TStringStream;
begin
  ss := TStringStream.Create('');
  try
    TAdvChartPersistence.SaveSettingsToStream(AObject, ss);
    ss.Position := 0;
    Result := ss.DataString;
  finally
    ss.Free;
  end;
end;

initialization
  TAdvChartPersistence.ClassTypeVariable := '$type';

end.


