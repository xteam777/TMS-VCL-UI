{********************************************************************}
{                                                                    }
{ written by TMS Software                                            }
{            copyright (c) 2016 - 2022                               }
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

unit AdvChartColorSelector;

{$I TMSDEFS.inc}

{$IFDEF CMNLIB}
{$DEFINE CMNWEBLIB}
{$ENDIF}
{$IFDEF WEBLIB}
{$DEFINE CMNWEBLIB}
{$ENDIF}

interface

uses
  Classes, AdvChartGraphics, AdvChartCustomControl, AdvChartCustomSelector, Controls,
  AdvChartTypes, ExtCtrls, AdvChartGraphicsTypes, StdCtrls
  {$IFDEF FMXLIB}
  ,FMX.Types
  {$ENDIF}
  {$IFNDEF LCLLIB}
  ,Types
  {$ENDIF}
  ;

const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 0; // Minor version nr.
  REL_VER = 0; // Release nr.
  BLD_VER = 1; // Build nr.

  //v1.0.0.0: First release
  //v1.0.0.1 : Improved : Updated initial look

const
  AdvChartColorSelectorColorSetCount = 15;
  AdvChartColorSelectorColorSet: array[0..AdvChartColorSelectorColorSetCount] of TAdvChartGraphicsColor = (gcBlack, gcMaroon, gcGreen, gcOlive,
    gcNavy, gcPurple, gcTeal, gcSilver, gcGray, gcRed,
    gcLime, gcYellow, gcBlue, gcFuchsia, gcAqua, gcWhite);

  {$IFDEF FMXLIB}
  AdvChartColorSelectorExtendedColorSetCount = 39;
  AdvChartColorSelectorExtendedColorSet: array[0..AdvChartColorSelectorExtendedColorSetCount] of TAdvChartGraphicsColor = (gcBlack, $FF003399, $FF003333, $FF003300, $FF663300, gcNavy,
    $FF353333, $FF333333, $FF800000, $FFFF6600, $FF808000, $FF008000, $FF008080, $FF0000FF,
    $FF666699, $FF808080, $FFFF0000, $FFFF9900, $FF99CC00, $FF339966, $FF33CCCC,
    $FF3366FF, $FF800080, $FF999999, $FFFF00FF, $FFFFCC00, $FFFFFF00, $FF00FF00,
    $FF00FFFF, $FF00CCFF, $FF993366, $FFC0C0C0, $FFFF99CC, $FFFFCC99, $FFFFFF99,
    $FFCCFFCC, $FFCCFFFF, $FF99CCFF, $FFCC99FF, $FFFFFFFF);
  {$ENDIF}

  {$IFDEF CMNWEBLIB}
  AdvChartColorSelectorExtendedColorSetCount = 39;
  AdvChartColorSelectorExtendedColorSet: array[0..AdvChartColorSelectorExtendedColorSetCount] of TAdvChartGraphicsColor = (gcBlack, $993300, $333300, $003300, $003366, gcNavy,
    $333335, $333333, $000080, $0066FF, $008080, $008000, $808000, $FF0000,
    $996666, $808080, $0000FF, $0099FF, $00CC99, $669933, $CCCC33,
    $FF6633, $800080, $999999, $FF00FF, $00CCFF, $00FFFF, $00FF00,
    $FFFF00, $FFCC00, $663399, $C0C0C0, $CC99FF, $99CCFF, $99FFFF,
    $CCFFCC, $FFFFCC, $FFCC99, $FF99CC, $FFFFFF);
  {$ENDIF}


type
  TAdvChartCustomColorSelector = class;

  TAdvChartColorSelectorItem = class(TAdvChartCustomSelectorItem)
  private
    FOwner: TAdvChartCustomColorSelector;
    FColor: TAdvChartGraphicsColor;
    procedure SetColor(const Value: TAdvChartGraphicsColor);
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
  published
    property Color: TAdvChartGraphicsColor read FColor write SetColor default gcNull;
  end;

  TAdvChartColorSelectorItems = class(TAdvChartCustomSelectorItems)
  private
    FOwner: TAdvChartCustomColorSelector;
    function GetItem(Index: integer): TAdvChartColorSelectorItem;
    procedure SetItem(Index: integer; const Value: TAdvChartColorSelectorItem);
  protected
    function CreateItemClass: TCollectionItemClass; override;
  public
    constructor Create(AOwner: TAdvChartCustomSelector); override;
    property Items[Index: integer]:TAdvChartColorSelectorItem read GetItem write SetItem; default;
    function Add: TAdvChartColorSelectorItem;
    function Insert(Index: integer): TAdvChartColorSelectorItem;
  end;

  TAdvChartCustomSelectorColorSelected = procedure(Sender: TObject; AColor: TAdvChartGraphicsColor) of object;
  TAdvChartCustomSelectorColorDeselected = procedure(Sender: TObject; AColor: TAdvChartGraphicsColor) of object;
  TAdvChartCustomSelectorColorClick = procedure(Sender: TObject; AColor: TAdvChartGraphicsColor) of object;

  TAdvChartCustomColorSelectorMode = (csmSimple, csmExtended, csmExtendedMore);

  TAdvChartCustomColorSelector = class(TAdvChartDefaultSelector)
  private
    w, h: Single;
    FColorWheel: TAdvChartCustomControl;
    FPanel: TAdvChartCustomControl;
    FBackButton: TButton;
    FOnColorSelected: TAdvChartCustomSelectorColorSelected;
    FOnColorDeselected: TAdvChartCustomSelectorColorDeselected;
    FMode: TAdvChartCustomColorSelectorMode;
    procedure SetSelectedColor(const Value: TAdvChartGraphicsColor);
    function GetSelectedColor: TAdvChartGraphicsColor;
    function GetItems: TAdvChartColorSelectorItems;
    procedure SetItems(const Value: TAdvChartColorSelectorItems);
    procedure SetMode(const Value: TAdvChartCustomColorSelectorMode);
  protected
    function GetVersion: String; override;
    procedure BackButtonClicked(Sender: TObject);
    procedure ColorWheelChange(Sender: TObject; AColor: TAdvChartGraphicsColor);
    procedure DoItemClick(AItemIndex: Integer); override;
    procedure WrapperSizeChanged(AWidth, AHeight: Single); virtual;
    procedure DoItemSelected(AItemIndex: Integer); override;
    procedure DoItemDeselected(AItemIndex: Integer); override;
    function CreateItemsCollection: TAdvChartCustomSelectorItems; override;
    procedure DoItemBeforeDrawContent(AGraphics: TAdvChartGraphics; ARect: TRectF; AItemIndex: Integer; var ADefaultDraw: Boolean); override;
    procedure DrawItemContent(AGraphics: TAdvChartGraphics; ADisplayItem: TAdvChartCustomSelectorDisplayItem); override;
    property OnColorSelected: TAdvChartCustomSelectorColorSelected read FOnColorSelected write FOnColorSelected;
    property OnColorDeselected: TAdvChartCustomSelectorColorDeselected read FOnColorDeselected write FOnColorDeselected;
    property SelectedColor: TAdvChartGraphicsColor read GetSelectedColor write SetSelectedColor default gcNull;
    property Items: TAdvChartColorSelectorItems read GetItems write SetItems;
    property Mode: TAdvChartCustomColorSelectorMode read FMode write SetMode default csmSimple;
    procedure AddColors;
    procedure ResetToDefaultStyle; override;
  public
    constructor Create(AOwner: TComponent); override;
    function FindItemByColor(AColor: TAdvChartGraphicsColor): Integer;
    function FindColorByItem(AItem: Integer): TAdvChartGraphicsColor;
    function ColorWheelActive: Boolean;
    procedure InitializeDefault; override;
    procedure InitSample; virtual;
  end;

  {$IFNDEF LCLLIB}
  [ComponentPlatformsAttribute(TMSPlatformsWeb)]
  {$ENDIF}
  TAdvChartColorSelector = class(TAdvChartCustomColorSelector)
  protected
    procedure RegisterRuntimeClasses; override;
  published
    property Appearance;
    property Rows;
    property Columns;
    property Items;
    property Mode;
    property OnColorSelected;
    property OnColorDeselected;
    property SelectedColor;
    property OnItemSelected;
    property OnItemDeselected;
    property OnItemClick;
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

implementation

uses
  SysUtils, AdvChartUtils, AdvChartColorWheel;

function AsColorWheel(AColorWheel: TAdvChartCustomControl): TAdvChartColorWheel;
begin
  Result := (AColorWheel as TAdvChartColorWheel);
end;

{ TAdvChartCustomColorSelector }

procedure TAdvChartCustomColorSelector.AddColors;
var
  I: Integer;
  it: TAdvChartCustomSelectorItem;
begin
  BeginUpdate;
  Items.Clear;
  case Mode of
    csmSimple:
    begin
      Columns := 4;
      Rows := 4;
      for I := 0 to AdvChartColorSelectorColorSetCount do
        TAdvChartColorSelectorItem(Items.Add).Color := AdvChartColorSelectorColorSet[I];
    end;
    csmExtended:
    begin
      Columns := 8;
      Rows := 5;
      for I := 0 to AdvChartColorSelectorExtendedColorSetCount do
        TAdvChartColorSelectorItem(Items.Add).Color := AdvChartColorSelectorExtendedColorSet[I];
    end;
    csmExtendedMore:
    begin
      Columns := 8;
      Rows := 7;
      for I := 0 to AdvChartColorSelectorExtendedColorSetCount do
        TAdvChartColorSelectorItem(Items.Add).Color := AdvChartColorSelectorExtendedColorSet[I];

      it := Items.Insert(0);
      TAdvChartColorSelectorItem(it).Color := gcBlack;
      it.ColumnSpan := 8;
      it.Text := 'Automatic';
      it.DataBoolean := True;

      it := Items.Add;
      it.ColumnSpan := 8;
      it.Text := 'More Colors...';
      it.CanSelect := False;
      it.DataBoolean := True;

      Items.Add.Visible := False;
    end;
  end;
  EndUpdate;
end;

procedure TAdvChartCustomColorSelector.BackButtonClicked(Sender: TObject);
begin
  if Assigned(FPanel) then
  begin
    FPanel.Visible := False;
    FPanel.Parent := nil;
    Width := Round(w);
    Height := Round(h);
    WrapperSizeChanged(w, h);
    Invalidate;
  end;
end;

procedure TAdvChartCustomColorSelector.WrapperSizeChanged(AWidth, AHeight: Single);
begin

end;

function TAdvChartCustomColorSelector.ColorWheelActive: Boolean;
begin
  Result := Assigned(FPanel) and Assigned(FPanel.Parent) and FPanel.Visible
    and Assigned(FColorWheel) and Assigned(FColorWheel.Parent) and FColorWheel.Visible
end;

procedure TAdvChartCustomColorSelector.ColorWheelChange(Sender: TObject; AColor: TAdvChartGraphicsColor);
begin
  if BlockChange then
    Exit;

  BlockChange := True;
  SelectedItemIndex := -1;
  Items[Items.Count - 1].Color := AsColorWheel(FColorWheel).SelectedColor;
  SelectedColor := AsColorWheel(FColorWheel).SelectedColor;
  DoItemSelected(SelectedItemIndex);
  Invalidate;
  BlockChange := False;
end;

constructor TAdvChartCustomColorSelector.Create(AOwner: TComponent);
begin
  inherited;
  Width := 135;
  Height := 135;
  FMode := csmSimple;

  FPanel := TAdvChartCustomControl.Create(Self);
  FPanel.Visible := False;
  FPanel.Stored := False;
  FPanel.ControlAlignment := caClient;

  FBackButton := TButton.Create(FPanel);
  {$IFDEF CMNWEBLIB}
  {$IFNDEF LCLLIB}
  FBackButton.AlignWithMargins := True;
  {$ENDIF}
  {$ENDIF}
  {$IFDEF LCLLIB}
  FBackButton.BorderSpacing.Top := 3;
  FBackButton.BorderSpacing.Left := 3;
  FBackButton.BorderSpacing.Bottom := 3;
  FBackButton.BorderSpacing.Right := 3;
  {$ENDIF}
  {$IFNDEF LCLLIB}
  FBackButton.Margins.Top := 3;
  FBackButton.Margins.Left := 3;
  FBackButton.Margins.Bottom := 3;
  FBackButton.Margins.Right := 3;
  {$ENDIF}
  {$IFDEF FMXLIB}
  FBackButton.Text := 'Back';
  FBackButton.Align := TAlignLayout.Top;
  {$ENDIF}
  {$IFNDEF FMXLIB}
  FBackButton.Caption := 'Back';
  FBackButton.Align := alTop;
  {$ENDIF}
  FBackButton.Parent := FPanel;
  FBackButton.OnClick := BackButtonClicked;

  FColorWheel := TAdvChartColorWheel.Create(FPanel);
  AsColorWheel(FColorWheel).ControlAlignment := caClient;
  AsColorWheel(FColorWheel).SetControlMargins(3, 0, 3, 3);
  AsColorWheel(FColorWheel).Parent := FPanel;
  AsColorWheel(FColorWheel).OnSelectedColorChanged := ColorWheelChange;

  if IsDesignTime then
    InitSample;
end;

function TAdvChartCustomColorSelector.CreateItemsCollection: TAdvChartCustomSelectorItems;
begin
  Result := TAdvChartColorSelectorItems.Create(Self);
end;

procedure TAdvChartCustomColorSelector.DoItemBeforeDrawContent(AGraphics: TAdvChartGraphics;
  ARect: TRectF; AItemIndex: Integer; var ADefaultDraw: Boolean);
begin
  if Mode = csmExtendedMore then
  begin
    if (AItemIndex >= 0) and (AItemIndex <= Items.Count - 1) then
      ADefaultDraw := not Items[AItemIndex].DataBoolean;
  end;

  inherited;
end;

procedure TAdvChartCustomColorSelector.DoItemClick(AItemIndex: Integer);
var
  l, t, r, b, nw, nh: Single;
begin
  if ClosedRemotely then
  begin
    ClosedRemotely := False;
    inherited;
    Exit;
  end;

  if (Mode = csmExtendedMore) and Assigned(FPanel) and (AItemIndex = Items.Count - 2) then
  begin
    w := Width;
    h := Height;
    l := 0;
    t := 0;
    r := 0;
    b := 0;
    FColorWheel.GetControlMargins(l, t, r, b);
    nh := ScalePaintValue(205) + FBackButton.Height + t + b;
    Height := Round(nh);
    nw := ScalePaintValue(350);
    Width := Round(nw);
    WrapperSizeChanged(nw, nh);
    BlockChange := True;
    AsColorWheel(FColorWheel).SelectedColor := FindColorByItem(AItemIndex + 1);
    BlockChange := False;
    FPanel.Visible := True;
    FPanel.Parent := Self;
  end;

  inherited;
end;

procedure TAdvChartCustomColorSelector.DoItemDeselected(AItemIndex: Integer);
begin
  inherited;
  if Assigned(OnColorDeselected) then
    OnColorDeselected(Self, FindColorByItem(AItemIndex));
end;

procedure TAdvChartCustomColorSelector.DoItemSelected(AItemIndex: Integer);
var
  c: TAdvChartGraphicsColor;
begin
  inherited;
  c := FindColorByItem(AItemIndex);
  if Assigned(FColorWheel) and not BlockChange then
  begin
    BlockChange := True;
    AsColorWheel(FColorWheel).SelectedColor := c;
    if (Mode = csmExtendedMore) and (Items.Count > 0) then
      Items[Items.Count - 1].Color := c;
    BlockChange := False;
  end;

  if Assigned(OnColorSelected) then
    OnColorSelected(Self, c);
end;

procedure TAdvChartCustomColorSelector.DrawItemContent(AGraphics: TAdvChartGraphics;
  ADisplayItem: TAdvChartCustomSelectorDisplayItem);
var
  r: TRectF;
  it: TAdvChartCustomSelectorItem;
  a: Boolean;
begin
  it := ADisplayItem.Item;
  if Assigned(it) and (it is TAdvChartColorSelectorItem) then
  begin
    r := ADisplayItem.Rect;
    a := True;
    DoItemBeforeDrawContent(AGraphics, ADisplayItem.Rect, it.Index, a);
    if a then
    begin
      case Mode of
        csmSimple: InflateRectEx(r, -5, -5);
        csmExtended, csmExtendedMore: InflateRectEx(r, -3, -3);
      end;
      AGraphics.Fill.Kind := gfkSolid;
      AGraphics.Fill.Color := (it as TAdvChartColorSelectorItem).Color;
      AGraphics.Stroke.Color := AGraphics.Fill.Color;
      AGraphics.DrawRectangle(r);
      DoItemAfterDrawContent(AGraphics, ADisplayItem.Rect, it.Index);
    end;
  end;
end;

function TAdvChartCustomColorSelector.FindColorByItem(
  AItem: Integer): TAdvChartGraphicsColor;
var
  I: Integer;
  it: TAdvChartColorSelectorItem;
begin
  Result := gcNull;
  for I := 0 to Items.Count - 1 do
  begin
    it := Items[I] as TAdvChartColorSelectorItem;
    if it.Index = AItem then
    begin
      Result := it.Color;
      Break;
    end;
  end;
end;

function TAdvChartCustomColorSelector.FindItemByColor(
  AColor: TAdvChartGraphicsColor): Integer;
var
  I: Integer;
  it: TAdvChartColorSelectorItem;
begin
  Result := -1;
  for I := 0 to Items.Count - 1 do
  begin
    it := Items[I] as TAdvChartColorSelectorItem;
    if (it.Color = AColor) and it.CanSelect then
    begin
      Result := it.Index;
      Break;
    end;
  end;
end;

function TAdvChartCustomColorSelector.GetItems: TAdvChartColorSelectorItems;
begin
  Result := TAdvChartColorSelectorItems(inherited Items);
end;

function TAdvChartCustomColorSelector.GetSelectedColor: TAdvChartGraphicsColor;
begin
  Result := FindColorByItem(SelectedItemIndex);
end;

function TAdvChartCustomColorSelector.GetVersion: String;
begin
  Result := GetVersionNumber(MAJ_VER, MIN_VER, REL_VER, BLD_VER);
end;

procedure TAdvChartCustomColorSelector.InitializeDefault;
begin
  inherited;
  AddColors;
end;

procedure TAdvChartCustomColorSelector.InitSample;
begin
  ResetToDefaultStyle;
end;

procedure TAdvChartCustomColorSelector.ResetToDefaultStyle;
begin
  inherited;
  BeginUpdate;

  {$IFDEF FMXLIB}
  Appearance.Font.Color := $FF454545;
  Appearance.Fill.Color := $FFEEF2F9;
  Appearance.FillSelected.Color := $FFA8BCF0;
  Appearance.StrokeSelected.Color := $FF2D9BEF;
  Appearance.FillDown.Color := $FF5A81E6;
  Appearance.FillHover.Color := $FFFFFFFE;
  {$ENDIF}
  {$IFNDEF FMXLIB}
  Appearance.Font.Color := $454545;
  Appearance.Fill.Color := $F9F2EE;
  Appearance.FillSelected.Color := $F0BCA8;
  Appearance.StrokeSelected.Color := $EF9B2D;
  Appearance.FillDown.Color := $E6815A;
  {$ENDIF}

  Appearance.FillSelected.Kind := gfkSolid;
  Appearance.Fill.Kind := gfkSolid;
  Appearance.FillDown.Kind := gfkSolid;
  Appearance.FillHover.Kind := gfkSolid;
  Appearance.Stroke.Kind := gskSolid;
  Appearance.StrokeSelected.Kind := gskSolid;
  Appearance.StrokeHover.Kind := gskSolid;

  Appearance.Stroke.Color := gcDarkgray;
  Appearance.StrokeHover.Color := Appearance.FillDown.Color;
  Appearance.StrokeDown.Assign(Appearance.Stroke);

  EndUpdate;
end;

procedure TAdvChartCustomColorSelector.SetItems(
  const Value: TAdvChartColorSelectorItems);
begin
  Items.Assign(Value);
end;

procedure TAdvChartCustomColorSelector.SetMode(const Value: TAdvChartCustomColorSelectorMode);
var
  s: Single;
begin
  {$IFDEF VCLLIB}
  {$HINTS OFF}
  {$IF (COMPILERVERSION >= 33) and (COMPILERVERSION < 35)}
  s := PaintScaleFactor;
  {$ELSE}
  s := TAdvChartUtils.GetDPIScale(Self, 96);
  {$IFEND}
  {$HINTS ON}
  {$ENDIF}
  {$IFNDEF VCLLIB}
  s := 1;
  {$ENDIF}

  if FMode <> Value then
  begin
    FMode := Value;
    case Mode of
      csmSimple:
      begin
        Width := Round(s * 135);
        Height := Round(s * 135);
      end;
      csmExtended:
      begin
        Width := Round(s * 200);
        Height := Round(s * 135);
      end;
      csmExtendedMore:
      begin
        Width := Round(s * 200);
        Height := Round(s * 175);
      end;
    end;
    AddColors;
  end;
end;

procedure TAdvChartCustomColorSelector.SetSelectedColor(const Value: TAdvChartGraphicsColor);
begin
  case Mode of
    csmExtendedMore:
    begin
      if Items.Count > 0 then
        Items[Items.Count - 1].Color := Value;
    end;
  end;
  SelectedItemIndex := FindItemByColor(Value);
end;

{ TAdvChartColorSelectorItems }

constructor TAdvChartColorSelectorItems.Create(AOwner: TAdvChartCustomSelector);
begin
  inherited;
  FOwner := AOwner as TAdvChartCustomColorSelector;
end;

function TAdvChartColorSelectorItems.Add: TAdvChartColorSelectorItem;
begin
  Result := TAdvChartColorSelectorItem(inherited Add);
end;

function TAdvChartColorSelectorItems.Insert(
  Index: integer): TAdvChartColorSelectorItem;
begin
  Result := TAdvChartColorSelectorItem(inherited Insert(Index));
end;

function TAdvChartColorSelectorItems.CreateItemClass: TCollectionItemClass;
begin
  Result := TAdvChartColorSelectorItem;
end;

function TAdvChartColorSelectorItems.GetItem(
  Index: integer): TAdvChartColorSelectorItem;
begin
  Result := TAdvChartColorSelectorItem(inherited Items[Index]);
end;

procedure TAdvChartColorSelectorItems.SetItem(Index: integer;
  const Value: TAdvChartColorSelectorItem);
begin
  inherited Items[Index] := Value;
end;

{ TAdvChartColorSelectorItem }

procedure TAdvChartColorSelectorItem.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TAdvChartColorSelectorItem then
    FColor := (Source as TAdvChartColorSelectorItem).Color;
end;

constructor TAdvChartColorSelectorItem.Create(Collection: TCollection);
begin
  inherited;
  if Assigned(Collection) then
    FOwner := (Collection as TAdvChartColorSelectorItems).FOwner;
end;

procedure TAdvChartColorSelectorItem.SetColor(const Value: TAdvChartGraphicsColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    if Assigned(FOwner) then
      FOwner.InvalidateItems;
  end;
end;

{ TAdvChartColorSelector }

procedure TAdvChartColorSelector.RegisterRuntimeClasses;
begin
  inherited;
  RegisterClasses([TAdvChartColorSelector, TAdvChartColorSelectorItem]);
end;

end.
