{********************************************************************}
{                                                                    }
{ written by TMS Software                                            }
{            copyright (c) 2016                                      }
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

unit AdvChartBitmapSelector;

{$I TMSDEFS.inc}

interface

uses
  Classes, AdvChartCustomSelector, AdvChartTypes,
  AdvChartBitmapContainer, AdvChartGraphics;

const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 0; // Minor version nr.
  REL_VER = 0; // Release nr.
  BLD_VER = 0; // Build nr.

type
  TAdvChartCustomBitmapSelector = class;

  TAdvChartBitmapSelectorBitmapAlign = (baLeft, baCenter, baRight);

  TAdvChartBitmapSelectorItem = class(TAdvChartCustomSelectorItem)
  private
    FOwner: TAdvChartCustomBitmapSelector;
    FBitmap: TAdvChartBitmap;
    FBitmapAlign: TAdvChartBitmapSelectorBitmapAlign;
    FBitmapName: String;
    FBitmapSize: Single;
    procedure SetBitmap(const Value: TAdvChartBitmap);
    procedure SetBitmapAlign(const Value: TAdvChartBitmapSelectorBitmapAlign);
    procedure SetBitmapName(const Value: String);
    procedure SetBitmapSize(const Value: Single);
    function GetBitmapContainer: TAdvChartBitmapContainer;
    function IsBitmapSizeStored: Boolean;
  protected
    function GetDisplayBitmap: TAdvChartBitmap;
    procedure BitmapChanged(Sender: TObject);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property BitmapContainer: TAdvChartBitmapContainer read GetBitmapContainer;
  published
    property Bitmap: TAdvChartBitmap read FBitmap write SetBitmap;
    property BitmapName: String read FBitmapName write SetBitmapName;
    property BitmapAlign: TAdvChartBitmapSelectorBitmapAlign read FBitmapAlign write SetBitmapAlign default TAdvChartBitmapSelectorBitmapAlign.baCenter;
    property BitmapSize: Single read FBitmapSize write SetBitmapSize stored IsBitmapSizeStored nodefault;
  end;

  TAdvChartBitmapSelectorItems = class(TAdvChartCustomSelectorItems)
  private
    FOwner: TAdvChartCustomBitmapSelector;
    function GetItem(Index: integer): TAdvChartBitmapSelectorItem;
    procedure SetItem(Index: integer; const Value: TAdvChartBitmapSelectorItem);
  protected
    function CreateItemClass: TCollectionItemClass; override;
  public
    constructor Create(AOwner: TAdvChartCustomSelector); override;
    property Items[Index: integer]: TAdvChartBitmapSelectorItem read GetItem write SetItem; default;
    function Add: TAdvChartBitmapSelectorItem;
    function Insert(Index: integer): TAdvChartBitmapSelectorItem;
  end;

  TAdvChartCustomSelectorBitmapSelected = procedure(Sender: TObject; ABitmap: TAdvChartBitmap) of object;
  TAdvChartCustomSelectorBitmapDeselected = procedure(Sender: TObject; ABitmap: TAdvChartBitmap) of object;

  {$IFDEF FNCLIB}
  TAdvChartCustomBitmapSelector = class(TAdvChartDefaultSelector, IAdvChartBitmapContainer)
  {$ENDIF}
  {$IFNDEF FNCLIB}
  TAdvChartCustomBitmapSelector = class(TAdvChartDefaultSelector)
  {$ENDIF}
  private
    FOnBitmapSelected: TAdvChartCustomSelectorBitmapSelected;
    FOnBitmapDeselected: TAdvChartCustomSelectorBitmapDeselected;
    FBitmapContainer: TAdvChartBitmapContainer;
    function GetSelectedBitmap: TAdvChartBitmap;
    procedure SetBitmapContainer(const Value: TAdvChartBitmapContainer);
    function GetItems: TAdvChartBitmapSelectorItems;
    procedure SetItems(const Value: TAdvChartBitmapSelectorItems);
    function GetBitmapContainer: TAdvChartBitmapContainer;
  protected
    function GetVersion: String; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DoItemSelected(AItemIndex: Integer); override;
    procedure DoItemDeselected(AItemIndex: Integer); override;
    function CreateItemsCollection: TAdvChartCustomSelectorItems; override;
    procedure DrawItemContent(AGraphics: TAdvChartGraphics; ADisplayItem: TAdvChartCustomSelectorDisplayItem); override;
    procedure DrawItemText(AGraphics: TAdvChartGraphics; ADisplayItem: TAdvChartCustomSelectorDisplayItem); override;
    property OnBitmapSelected: TAdvChartCustomSelectorBitmapSelected read FOnBitmapSelected write FOnBitmapSelected;
    property OnBitmapDeselected: TAdvChartCustomSelectorBitmapDeselected read FOnBitmapDeselected write FOnBitmapDeselected;
    property SelectedBitmap: TAdvChartBitmap read GetSelectedBitmap;
    property BitmapContainer: TAdvChartBitmapContainer read GetBitmapContainer write SetBitmapContainer;
    property Items: TAdvChartBitmapSelectorItems read GetItems write SetItems;
  public
    constructor Create(AOwner: TComponent); override;
    procedure LoadFromBitmapContainer; virtual;
    function FindItemByBitmap(ABitmap: TAdvChartBitmap): Integer;
    function FindBitmapByItem(AItem: Integer): TAdvChartBitmap;
  end;

  {$IFNDEF LCLLIB}
  [ComponentPlatformsAttribute(TMSPlatformsWeb)]
  {$ENDIF}
  TAdvChartBitmapSelector = class(TAdvChartCustomBitmapSelector)
  protected
    procedure RegisterRuntimeClasses; override;
  public
    property SelectedBitmap;
  published
    property Appearance;
    property Rows;
    property Columns;
    property Items;
    property OnBitmapSelected;
    property OnBitmapDeselected;
    property BitmapContainer;
    property OnItemSelected;
    property SelectedItemIndex;
    property OnItemBeforeDrawBackground;
    property OnItemAfterDrawBackground;
    property OnItemBeforeDrawContent;
    property OnItemAfterDrawContent;
    property OnBeforeDraw;
    property OnAfterDraw;
    property OnItemBeforeDrawText;
    property OnItemAfterDrawText;
  end;

procedure GetAspectSize(var w, h: Single; ow, oh, nw, nh, crw, crh: Single; asp, st, cr: Boolean);

implementation

uses
  AdvChartUtils
  {$IFNDEF LCLLIB}
  ,Types
  {$ENDIF}
  ;

procedure GetAspectSize(var w, h: Single; ow, oh, nw, nh, crw, crh: Single; asp, st, cr: Boolean);
var
  arc, ar: Single;
begin
  if asp then
  begin
    if (ow > 0) and (oh > 0) and (nw > 0) and (nh > 0) then
    begin
      if (ow < nw) and (oh < nh) and (not st) then
      begin
        w := ow;
        h := oh;
      end
      else
      begin
        if ow / oh < nw / nh then
        begin
          h := nh;
          w := nh * ow / oh;
        end
        else
        begin
          w := nw;
          h := nw * oh / ow;
        end;
      end;
    end
    else
    begin
      w := 0;
      h := 0;
    end;
  end
  else
  begin
    if st then
    begin
      w := nw;
      h := nh;
    end
    else
    begin
      w := ow;
      h := oh;

      if cr then
      begin
        if (w >= h) and (w > 0) then
        begin
          h := crw / w * h;
          w := crw;
        end
        else
        if (h >= w) and (h > 0) then
        begin
          w := crh / h * w;
          h := crh;
        end;

        if h = 0 then
          ar := 1
        else
          ar := w / h;

        if crh = 0 then
          arc := 1
        else
          arc := crw / crh;

        if (ar < 1) or (arc > ar) then
        begin
          h := crw / ar;
          w := crw;
        end
        else
        begin
          w := ar * crh;
          h := crh;
        end;
      end;
    end;
  end;
end;

{ TAdvChartCustomBitmapSelector }

constructor TAdvChartCustomBitmapSelector.Create(AOwner: TComponent);
begin
  inherited;
  Width := 135;
  Height := 135;
end;

function TAdvChartCustomBitmapSelector.CreateItemsCollection: TAdvChartCustomSelectorItems;
begin
  Result := TAdvChartBitmapSelectorItems.Create(Self);
end;

procedure TAdvChartCustomBitmapSelector.DoItemDeselected(AItemIndex: Integer);
begin
  inherited;
  if Assigned(OnBitmapDeselected) then
    OnBitmapDeselected(Self, FindBitmapByItem(AItemIndex));
end;

procedure TAdvChartCustomBitmapSelector.DoItemSelected(AItemIndex: Integer);
begin
  inherited;
  if Assigned(OnBitmapSelected) then
    OnBitmapSelected(Self, FindBitmapByItem(AItemIndex));
end;

procedure TAdvChartCustomBitmapSelector.DrawItemContent(AGraphics: TAdvChartGraphics;
  ADisplayItem: TAdvChartCustomSelectorDisplayItem);
var
  r: TRectF;
  it: TAdvChartCustomSelectorItem;
  itbmp: TAdvChartBitmapSelectorItem;
  a: Boolean;
  sz: Single;
  bmp: TAdvChartBitmap;
  bmpr: TRectF;
  w, h: Single;
  bmpdr: TRectF;
begin
  it := ADisplayItem.Item;
  if Assigned(it) and (it is TAdvChartBitmapSelectorItem) then
  begin
    r := ADisplayItem.Rect;
    a := True;
    DoItemBeforeDrawContent(AGraphics, r, it.Index, a);
    if a then
    begin
      itbmp := (it as TAdvChartBitmapSelectorItem);
      bmp := itbmp.GetDisplayBitmap;
      if Assigned(bmp) then
      begin
        InflateRectEx(r, -2, -2);
        sz := r.Bottom - r.Top;
        if itbmp.BitmapSize > 0 then
          sz := itbmp.BitmapSize;

        case itbmp.BitmapAlign of
          baLeft: bmpr := RectF(r.Left, r.Top, r.Left + sz, r.Bottom);
          baCenter: bmpr := RectF(r.Left + ((r.Right - r.Left) - sz) / 2, r.Top, r.Left + ((r.Right - r.Left) - sz) / 2 + sz, r.Bottom);
          baRight: bmpr := RectF(r.Right - sz, r.Top, r.Right, r.Bottom);
        end;

        w := 0;
        h := 0;
        GetAspectSize(w, h, bmp.Width, bmp.Height, (bmpr.Right - bmpr.Left), (bmpr.Bottom - bmpr.Top), (bmpr.Right - bmpr.Left), (bmpr.Bottom - bmpr.Top), True, False, False);
        bmpdr := RectF(bmpr.Left + ((bmpr.Right - bmpr.Left) - w) / 2, bmpr.Top + ((bmpr.Bottom - bmpr.Top) - h) / 2, bmpr.Left + ((bmpr.Right - bmpr.Left) - w) / 2 + w, bmpr.Top + ((bmpr.Bottom - bmpr.Top) - h) / 2 + h);
        bmpdr := RectF(Round(bmpdr.Left), Round(bmpdr.Top), Round(bmpdr.Right), Round(bmpdr.Bottom));
//      if it.Enabled then
          AGraphics.DrawBitmap(bmpdr, bmp);
//        else
//          AGraphics.DrawBitmap(bmp, RectF(0, 0, bmp.Width, bmp.Height), bmpdr, 0.25);
      end;

      DoItemAfterDrawContent(AGraphics, r, it.Index);
    end;
  end;
end;

procedure TAdvChartCustomBitmapSelector.DrawItemText(AGraphics: TAdvChartGraphics;
  ADisplayItem: TAdvChartCustomSelectorDisplayItem);
var
  it: TAdvChartBitmapSelectorItem;
  bmp: TAdvChartBitmap;
  dps: TAdvChartCustomSelectorDisplayItem;
  sz: Single;
begin
  if Assigned(ADisplayItem.Item) and (ADisplayItem.Item is TAdvChartBitmapSelectorItem) then
  begin
    it := ADisplayItem.Item as TAdvChartBitmapSelectorItem;
    bmp := it.GetDisplayBitmap;
    if Assigned(bmp) then
    begin
      dps := ADisplayItem;
      sz := dps.Rect.Bottom - dps.Rect.Top;
      if it.BitmapSize > 0 then
        sz := it.BitmapSize;

      case it.BitmapAlign of
        baLeft: dps.Rect.Left := dps.Rect.Left + sz + 4;
        baRight: dps.Rect.Right := dps.Rect.Right - sz - 4;
      end;
      inherited DrawItemText(AGraphics, dps);
    end
    else
      inherited;
  end
  else
    inherited;
end;

function TAdvChartCustomBitmapSelector.FindBitmapByItem(
  AItem: Integer): TAdvChartBitmap;
var
  I: Integer;
  it: TAdvChartBitmapSelectorItem;
begin
  Result := nil;
  for I := 0 to Items.Count - 1 do
  begin
    it := Items[I] as TAdvChartBitmapSelectorItem;
    if it.Index = AItem then
    begin
      Result := it.GetDisplayBitmap;
      Break;
    end;
  end;
end;

function TAdvChartCustomBitmapSelector.FindItemByBitmap(
  ABitmap: TAdvChartBitmap): Integer;
var
  I: Integer;
  it: TAdvChartBitmapSelectorItem;
begin
  Result := -1;
  for I := 0 to Items.Count - 1 do
  begin
    it := Items[I] as TAdvChartBitmapSelectorItem;
    if it.GetDisplayBitmap = ABitmap then
    begin
      Result := it.Index;
      Break;
    end;
  end;
end;

procedure TAdvChartCustomBitmapSelector.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FBitmapContainer) then
    FBitmapContainer := nil;
end;


procedure TAdvChartCustomBitmapSelector.SetBitmapContainer(
  const Value: TAdvChartBitmapContainer);
begin
  FBitmapContainer := Value;
  InvalidateItems;
end;

function TAdvChartCustomBitmapSelector.GetBitmapContainer: TAdvChartBitmapContainer;
begin
  Result := FBitmapContainer;
end;

function TAdvChartCustomBitmapSelector.GetItems: TAdvChartBitmapSelectorItems;
begin
  Result := TAdvChartBitmapSelectorItems(inherited Items);
end;

procedure TAdvChartCustomBitmapSelector.SetItems(
  const Value: TAdvChartBitmapSelectorItems);
begin
  Items.Assign(Value);
end;

function TAdvChartCustomBitmapSelector.GetSelectedBitmap: TAdvChartBitmap;
begin
  Result := FindBitmapByItem(SelectedItemIndex);
end;

function TAdvChartCustomBitmapSelector.GetVersion: String;
begin
  Result := GetVersionNumber(MAJ_VER, MIN_VER, REL_VER, BLD_VER);
end;

procedure TAdvChartCustomBitmapSelector.LoadFromBitmapContainer;
var
  I: Integer;
  it: TAdvChartBitmapSelectorItem;
begin
  if not Assigned(BitmapContainer) then
    Exit;

  BeginUpdate;
  Items.Clear;
  for I := 0 to BitmapContainer.Items.Count - 1 do
  begin
    it := Items.Add;
    it.BitmapName := BitmapContainer.Items[I].Name;
  end;
  EndUpdate;
end;

{ TAdvChartBitmapSelectorItems }

function TAdvChartBitmapSelectorItems.Add: TAdvChartBitmapSelectorItem;
begin
  Result := TAdvChartBitmapSelectorItem(inherited Add);
end;

constructor TAdvChartBitmapSelectorItems.Create(AOwner: TAdvChartCustomSelector);
begin
  inherited;
  FOwner := AOwner as TAdvChartCustomBitmapSelector;
end;

function TAdvChartBitmapSelectorItems.CreateItemClass: TCollectionItemClass;
begin
  Result := TAdvChartBitmapSelectorItem;
end;

function TAdvChartBitmapSelectorItems.GetItem(
  Index: integer): TAdvChartBitmapSelectorItem;
begin
  Result := TAdvChartBitmapSelectorItem(inherited Items[Index]);
end;

function TAdvChartBitmapSelectorItems.Insert(
  Index: integer): TAdvChartBitmapSelectorItem;
begin
  Result := TAdvChartBitmapSelectorItem(inherited Insert(Index));
end;

procedure TAdvChartBitmapSelectorItems.SetItem(Index: integer;
  const Value: TAdvChartBitmapSelectorItem);
begin
  inherited Items[Index] := Value;
end;

{ TAdvChartBitmapSelectorItem }

procedure TAdvChartBitmapSelectorItem.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TAdvChartBitmapSelectorItem then
  begin
    FBitmap.Assign((Source as TAdvChartBitmapSelectorItem).Bitmap);
    FBitmapName := (Source as TAdvChartBitmapSelectorItem).BitmapName;
    FBitmapSize := (Source as TAdvChartBitmapSelectorItem).BitmapSize;
    FBitmapAlign := (Source as TAdvChartBitmapSelectorItem).BitmapAlign;
  end;
end;

procedure TAdvChartBitmapSelectorItem.BitmapChanged(Sender: TObject);
begin
  FOwner.InvalidateItems;
end;

constructor TAdvChartBitmapSelectorItem.Create(Collection: TCollection);
begin
  inherited;
  if Assigned(Collection) then
    FOwner := (Collection as TAdvChartBitmapSelectorItems).FOwner;
  FBitmapAlign := baCenter;
  FBitmapSize := 0;
  FBitmap := TAdvChartBitmap.Create;
  FBitmap.OnChange := BitmapChanged;
end;

destructor TAdvChartBitmapSelectorItem.Destroy;
begin
  FBitmap.Free;
  inherited;
end;

function TAdvChartBitmapSelectorItem.GetBitmapContainer: TAdvChartBitmapContainer;
begin
  Result := FOwner.BitmapContainer;
end;

function TAdvChartBitmapSelectorItem.GetDisplayBitmap: TAdvChartBitmap;
begin
  Result := nil;
  if Assigned(Bitmap) and not IsBitmapEmpty(Bitmap) then
    Result := Bitmap
  else if Assigned(FOwner) and Assigned(FOwner.BitmapContainer) and (BitmapName <> '') then
    Result := TAdvChartBitmap(FOwner.BitmapContainer.FindBitmap(BitmapName));
end;

function TAdvChartBitmapSelectorItem.IsBitmapSizeStored: Boolean;
begin
  Result := BitmapSize <> 0;
end;

procedure TAdvChartBitmapSelectorItem.SetBitmap(const Value: TAdvChartBitmap);
begin
  if FBitmap <> Value then
  begin
    FBitmap.Assign(Value);
    FOwner.InvalidateItems;
  end;
end;

procedure TAdvChartBitmapSelectorItem.SetBitmapAlign(
  const Value: TAdvChartBitmapSelectorBitmapAlign);
begin
  if FBitmapAlign <> Value then
  begin
    FBitmapAlign := Value;
    FOwner.InvalidateItems;
  end;
end;

procedure TAdvChartBitmapSelectorItem.SetBitmapName(const Value: String);
begin
  if FBitmapName <> Value then
  begin
    FBitmapName := Value;
    FOwner.InvalidateItems;
  end;
end;

procedure TAdvChartBitmapSelectorItem.SetBitmapSize(const Value: Single);
begin
  if FBitmapSize <> Value then
  begin
    FBitmapSize := Value;
    FOwner.InvalidateItems;
  end;
end;

{ TAdvChartBitmapSelector }

procedure TAdvChartBitmapSelector.RegisterRuntimeClasses;
begin
  inherited;
  RegisterClasses([TAdvChartBitmapSelector, TAdvChartBitmapSelectorItem]);
end;

end.
