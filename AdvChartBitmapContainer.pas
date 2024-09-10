{********************************************************************}
{                                                                    }
{ written by TMS Software                                            }
{            copyright (c) 2016 - 2022                               }
{            Email : info@tmssoftware.com                            }
{            Web : https//www.tmssoftware.com                        }
{                                                                    }
{ The source code is given as is. The author is not responsible      }
{ for any possible damage done due to the use of this code.          }
{ The complete source code remains property of the author and may    }
{ not be distributed, published, given or sold in any form as such.  }
{ No parts of the source code can be included in any other component }
{ or application without written authorization of the author.        }
{********************************************************************}

unit AdvChartBitmapContainer;

{$I TMSDEFS.inc}

interface

uses
  Classes, AdvChartTypes, AdvChartCustomComponent, Controls
  {$IFNDEF WEBLIB}
  {$IFNDEF LCLLIB}
  , Generics.Collections
  {$ENDIF}
  {$IFDEF LCLLIB}
  , fgl
  {$ENDIF}
  {$ENDIF}
  ;

const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 0; // Minor version nr.
  REL_VER = 0; // Release nr.
  BLD_VER = 0; // Build nr.

  // version history
  // v1.0.0.0 : First Release

type
  TAdvChartBitmapContainer = class;

  TAdvChartBitmapItem = class;

  IAdvChartBitmapContainer = interface
    ['{ED26710D-395F-4971-8AC9-A31083BF2A3C}']
    procedure SetBitmapContainer(const Value: TAdvChartBitmapContainer);
    function GetBitmapContainer: TAdvChartBitmapContainer;
    property BitmapContainer: TAdvChartBitmapContainer read GetBitmapContainer write SetBitmapContainer;
  end;

  IAdvChartBitmapContainerGetItem = interface
    ['{98F65D59-B40C-4574-AF9C-3CA68E86AE10}']
    function ItemCount: Integer;
    function GetItem(AIndex: Integer): TAdvChartBitmapItem;
  end;

  TAdvChartBitmapItem = class(TCollectionItem)
  private
    FBitmap: TAdvChartBitmap;
    FTag: NativeInt;
    FName: string;
    procedure SetBitmap(const Value: TAdvChartBitmap);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure DoBitmapChanged(Sender: TObject); virtual;
    procedure Assign(Source: TPersistent); override;
    function GetDisplayName: string; override;
  published
    property Bitmap: TAdvChartBitmap read FBitmap write SetBitmap;
    property Name: string read FName write FName;
    property Tag: NativeInt read FTag write FTag;
  end;

  TAdvChartBitmapCollection = class(TOwnedCollection)
  private
    FOwner: TAdvChartBitmapContainer;
    function GetItemEx(Index: Integer): TAdvChartBitmapItem;
    procedure SetItemEx(Index: Integer; const Value: TAdvChartBitmapItem);
  protected
    function GetBitmapItemClass: TCollectionItemClass; virtual;
  public
    constructor Create(AOwner: TAdvChartBitmapContainer);
    function Add: TAdvChartBitmapItem;
    function Insert(index: Integer): TAdvChartBitmapItem;
    property Items[Index: Integer]: TAdvChartBitmapItem read GetItemEx write SetItemEx; default;
  end;

  {$IFDEF WEBLIB}
  TControlList = class(TList);
  {$ENDIF}
  {$IFNDEF WEBLIB}
  TControlList = class(TList<TControl>);
  {$ENDIF}

  {$IFDEF FMXLIB}
  TWinControl = TControl;
  {$ENDIF}

  {$IFNDEF LCLLIB}
  [ComponentPlatformsAttribute(TMSPlatformsWeb)]
  {$ENDIF}
  TAdvChartBitmapContainer = class(TAdvChartCustomComponent, IAdvChartBitmapContainerGetItem)
  private
    FControls: TControlList;
    FItems: TAdvChartBitmapCollection;
    FOnBitmapChanged: TNotifyEvent;
    procedure SetItems(const Value: TAdvChartBitmapCollection);
    function GetBitmapName(AIndex: Integer): String;
    function GetBitmap(AIndex: Integer): TAdvChartBitmap;
    function GetItems: TAdvChartBitmapCollection;
  protected
    function GetInstance: NativeUInt; override;
    function GetVersion: string; override;
    function CreateItems: TAdvChartBitmapCollection; virtual;
    procedure RegisterRuntimeClasses; override;
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    procedure DoBitmapChanged(Sender: TObject);
    procedure InvalidateMembers(AControl: TWinControl); virtual;
  public
    constructor Create; reintroduce; overload; virtual;
    constructor Create(AOwner: TComponent); overload; override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Changed; virtual;
    procedure RegisterControl(AControl: TControl);
    procedure FindBitmap(i: Integer; ABitmap: TAdvChartBitmap); overload; virtual;
    function GetItem(AIndex: Integer): TAdvChartBitmapItem; virtual;
    function FindBitmap(s: string): TAdvChartBitmap; overload; virtual;
    function ItemCount: Integer;
    function RandomBitmapName: string;
    function RandomBitmap: TAdvChartBitmap;
    procedure AddFromURL({%H-}URL, {%H-}BitmapName: string); virtual;
    procedure AddFromResource(ResourceName, BitmapName: string; AInstance: NativeUInt); overload;
    procedure AddFromResource(ResourceName, BitmapName: string); overload;
    procedure AddFromFile(FileName, BitmapName: String);
    {$IFNDEF WEBLIB}
    procedure AddFromFolder(AFolder: string);
    {$ENDIF}
    property BitmapNames[AIndex: Integer]: String read GetBitmapName;
    property Bitmaps[AIndex: Integer]: TAdvChartBitmap read GetBitmap;
  published
    property Items: TAdvChartBitmapCollection read GetItems write SetItems;
    property Version: string read GetVersion;
    property OnBitmapChanged: TNotifyEvent read FOnBitmapChanged write FOnBitmapChanged;
  end;

implementation

uses
  TypInfo, Forms, SysUtils, AdvChartUtils
  {$IFDEF FMXLIB}
  ,FMX.Types
  {$ENDIF}
  ;

{$R 'AdvChartBitmapContainer.res'}

{$IFDEF FMXLIB}
type
  TCustomFormHelper = class helper for TCustomForm
  private
    function GetControlCount: Integer;
    function GetControls(AIndex: Integer): TWinControl;
  public
    property ControlCount: Integer read GetControlCount;
    property Controls[Index: Integer]: TWinControl read GetControls;
  end;
  {$ENDIF}

{ TAdvChartBitmapItem }

procedure TAdvChartBitmapItem.Assign(Source: TPersistent);
begin
  Name := (Source as TAdvChartBitmapItem).Name;
  Tag := (Source as TAdvChartBitmapItem).Tag;
  Bitmap.Assign((Source as TAdvChartBitmapItem).Bitmap)
end;

constructor TAdvChartBitmapItem.Create(Collection: TCollection);
begin
  inherited;
  FBitmap := TAdvChartBitmap.Create;
  FBitmap.OnChange := DoBitmapChanged;
  FName := 'Item' + IntToStr(Collection.Count);
end;

destructor TAdvChartBitmapItem.Destroy;
begin
  FBitmap.Free;
  inherited;
end;

procedure TAdvChartBitmapItem.DoBitmapChanged(Sender: TObject);
begin
  if (Collection is TAdvChartBitmapCollection) then
  begin
    if Assigned((Collection as TAdvChartBitmapCollection).FOwner) then
      (Collection as TAdvChartBitmapCollection).FOwner.DoBitmapChanged(Self);
  end;
end;

function TAdvChartBitmapItem.GetDisplayName: string;
begin
  if FName <> '' then
    Result := FName
  {$IFDEF WEBLIB}
  else
    Result := '';
  {$ENDIF}
  {$IFNDEF WEBLIB}
  else
    Result := inherited;
  {$ENDIF}
end;

procedure TAdvChartBitmapItem.SetBitmap(const Value: TAdvChartBitmap);
begin
  FBitmap.Assign(Value);
end;

{ TAdvChartBitmapCollection }

function TAdvChartBitmapCollection.Add: TAdvChartBitmapItem;
begin
  Result := TAdvChartBitmapItem(inherited Add);
end;

constructor TAdvChartBitmapCollection.Create(AOwner: TAdvChartBitmapContainer);
begin
  inherited Create(AOwner, GetBitmapItemClass);
  FOwner := AOwner;
end;

function TAdvChartBitmapCollection.GetBitmapItemClass: TCollectionItemClass;
begin
  Result := TAdvChartBitmapItem;
end;

function TAdvChartBitmapCollection.GetItemEx(Index: Integer): TAdvChartBitmapItem;
begin
  Result := TAdvChartBitmapItem(inherited Items[Index]);
end;

function TAdvChartBitmapCollection.Insert(index: Integer): TAdvChartBitmapItem;
begin
  Result := TAdvChartBitmapItem(inherited Insert(Index));
end;

procedure TAdvChartBitmapCollection.SetItemEx(Index: Integer; const Value: TAdvChartBitmapItem);
begin
  inherited SetItem(Index, Value);
end;

{ TAdvChartBitmapContainer }

procedure TAdvChartBitmapContainer.AddFromFile(FileName, BitmapName: string);
var
  bmpi: TAdvChartBitmapItem;
begin
  bmpi := Items.Add;
  bmpi.Bitmap.LoadFromFile(FileName);
  bmpi.Name := BitmapName;
end;

{$IFNDEF WEBLIB}
procedure TAdvChartBitmapContainer.AddFromFolder(AFolder: string);
var
  SR: TSearchRec;

  procedure AddToList(s: string);
  begin
    with Items.Add do
    begin
      try
        Bitmap.LoadFromFile(s);
        Name := ExtractFileName(s);
      except
        Bitmap.Assign(nil);
      end;
    end;
  end;

begin
  if FindFirst(AFolder,faAnyFile and not faDirectory,SR) = 0 then
  begin
    AddToList(ExtractFilePath(AFolder) + SR.Name);
    while FindNext(SR) = 0 do
      AddToList(ExtractFilePath(AFolder) + SR.Name);
  end;
  FindClose(SR);
end;
{$ENDIF}

procedure TAdvChartBitmapContainer.AddFromURL(URL, BitmapName: string);
{$IFDEF WEBLIB}
var
  bmpi: TAdvChartBitmapItem;
{$ENDIF}
begin
  {$IFDEF WEBLIB}
  bmpi := Self.Items.Add;
  bmpi.Bitmap.LoadFromURL(URL);
  bmpi.Name := BitmapName;
  {$ENDIF}
end;

procedure TAdvChartBitmapContainer.Assign(Source: TPersistent);
begin
  if (Source is TAdvChartBitmapContainer) then
  begin
    FItems.Assign((Source as TAdvChartBitmapContainer).Items);
  end
  else
    inherited;
end;

procedure TAdvChartBitmapContainer.AddFromResource(ResourceName, BitmapName: string; AInstance: NativeUInt);
var
  bmpi: TAdvChartBitmapItem;
begin
  bmpi := Items.Add;
  bmpi.Bitmap.LoadFromResource(ResourceName, AInstance);
  bmpi.Name := BitmapName;
end;

procedure TAdvChartBitmapContainer.AddFromResource(ResourceName, BitmapName: string);
begin
  AddFromResource(ResourceName, BitmapName, GetInstance);
end;

procedure TAdvChartBitmapContainer.Changed;
var
  i: integer;
begin
  for i := 0 to FControls.Count - 1 do
  {$IFDEF FMXLIB}
    FControls.Items[i].Invalidate;
  {$ENDIF}
  {$IFDEF CMNLIB}
    FControls.Items[i].Invalidate;
  {$ENDIF}
end;

constructor TAdvChartBitmapContainer.Create(AOwner: TComponent);
begin
  inherited;
  FItems := CreateItems;
  FControls := TControlList.Create;
end;

constructor TAdvChartBitmapContainer.Create;
begin
  Create(nil);
end;

function TAdvChartBitmapContainer.CreateItems: TAdvChartBitmapCollection;
begin
  Result := TAdvChartBitmapCollection.Create(Self);
end;

destructor TAdvChartBitmapContainer.Destroy;
begin
  FreeAndNil(FControls);
  FItems.Free;
  inherited;
end;

procedure TAdvChartBitmapContainer.DoBitmapChanged(Sender: TObject);
var
  f: TCustomForm;
  I: Integer;
begin
  f := TAdvChartUtils.GetParentForm(Self);
  if Assigned(f) then
  begin
    for I := 0 to f.ControlCount - 1 do
      if f.Controls[I] is TWinControl then
        InvalidateMembers(f.Controls[I] as TWinControl);
  end;

  if Assigned(OnBitmapChanged) then
    OnBitmapChanged(Self);
end;

procedure TAdvChartBitmapContainer.FindBitmap(i: Integer; ABitmap: TAdvChartBitmap);
begin
  if (i >= 0) and (i <= Items.Count - 1) then
    ABitmap.Assign(Items[I].Bitmap);
end;

function TAdvChartBitmapContainer.FindBitmap(s: string): TAdvChartBitmap;
var
  i: Integer;
begin
  Result := nil;
  s := Uppercase(s);
  i := 1;
  while i <= Items.Count do
  begin
    if Uppercase(Items[i - 1].Name) = s then
    begin
      Result := Items[i - 1].Bitmap;
      Break;
    end;
    Inc(i);
  end;
end;

procedure TAdvChartBitmapContainer.SetItems(const Value: TAdvChartBitmapCollection);
begin
  FItems.Assign(Value);
end;

function TAdvChartBitmapContainer.GetBitmap(AIndex: Integer): TAdvChartBitmap;
begin
  Result := nil;
  if (AIndex >= 0) and (AIndex <= Items.Count - 1) then
    Result := Items[AIndex].Bitmap;
end;

function TAdvChartBitmapContainer.GetBitmapName(AIndex: Integer): String;
begin
  Result := '';
  if (AIndex >= 0) and (AIndex <= Items.Count - 1) then
    Result := Items[AIndex].Name;
end;

function TAdvChartBitmapContainer.GetInstance: NativeUInt;
begin
  Result := HInstance;
end;

function TAdvChartBitmapContainer.GetItem(AIndex: Integer): TAdvChartBitmapItem;
begin
  Result := nil;
  if (AIndex >= 0) and (AIndex <= ItemCount - 1) then
    Result := Items[AIndex];
end;

function TAdvChartBitmapContainer.GetItems: TAdvChartBitmapCollection;
begin
  Result := FItems;
end;

function TAdvChartBitmapContainer.GetVersion: string;
begin
  Result := GetVersionNumber(MAJ_VER, MIN_VER, REL_VER, BLD_VER);
end;

procedure TAdvChartBitmapContainer.InvalidateMembers(AControl: TWinControl);
var
  I: Integer;
begin
  if not Assigned(AControl) then
    Exit;

  if Assigned(GetPropInfo(AControl, 'BitmapContainer')) then
    AControl.Invalidate;

  for I := 0 to AControl.ControlCount - 1 do
  begin
    if AControl.Controls[I] is TWinControl then
      InvalidateMembers(AControl.Controls[I] as TWinControl);
  end;
end;

function TAdvChartBitmapContainer.ItemCount: Integer;
begin
  Result := Items.Count;
end;

procedure TAdvChartBitmapContainer.Notification(AComponent: TComponent;
  AOperation: TOperation);
var
  i: integer;
begin
  inherited;
  if (AOperation = opRemove) and Assigned(FControls) then
  begin
    for i := FControls.Count - 1 downto 0 do
    begin
      if (FControls.Items[i] = AComponent) then
        FControls.Delete(i);
    end;
  end;
end;

function TAdvChartBitmapContainer.RandomBitmap: TAdvChartBitmap;
begin
  Result := Bitmaps[Random(ItemCount)];
end;

function TAdvChartBitmapContainer.RandomBitmapName: string;
begin
  Result := BitmapNames[Random(ItemCount)];
end;

procedure TAdvChartBitmapContainer.RegisterControl(
  AControl: TControl);
begin
  FControls.Add(AControl);
end;

procedure TAdvChartBitmapContainer.RegisterRuntimeClasses;
begin
  RegisterClass(TAdvChartBitmapContainer);
end;

{$IFDEF FMXLIB}

{ TCustomFormHelper }

function TCustomFormHelper.GetControls(AIndex: Integer): TWinControl;
var
  c: TFmxObject;
begin
  Result := nil;
  c := Children[AIndex];
  if c is TWinControl then
    Result := c as TWinControl;
end;

function TCustomFormHelper.GetControlCount: Integer;
begin
  Result := ChildrenCount;
end;

{$ENDIF}

end.
