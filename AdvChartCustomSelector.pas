{********************************************************************}
{                                                                    }
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

unit AdvChartCustomSelector;

{$I TMSDEFS.inc}

interface

uses
  Classes, AdvChartTypes, AdvChartGraphics, AdvChartGraphicsTypes,
  AdvChartCustomControl, Controls
  {$IFNDEF WEBLIB}
  {$IFNDEF LCLLIB}
  ,UITypes, Generics.Collections, Types
  {$ENDIF}
  {$ENDIF}
  {$IFDEF LCLLIB}
  ,fgl
  {$ENDIF}
  ;

const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 0; // Minor version nr.
  REL_VER = 1; // Release nr.
  BLD_VER = 0; // Build nr.

  //Version history
  //v1.0.0.0 : First Release
  //v1.0.1.0 : New : High DPI support for TAdvChartCustomSelector

type
  TAdvChartCustomSelector = class;

  TAdvChartCustomSelectorItemState = (isNormal, isHover, isDown, isSelected, isDisabled);

  TAdvChartCustomSelectorItem = class(TCollectionItem)
  private
    FOwner: TAdvChartCustomSelector;
    FRowSpan: Integer;
    FColumnSpan: Integer;
    FVisible: Boolean;
    FText: String;
    FEnabled: Boolean;
    FSeparator: Boolean;
    FSeparatorHeight: Single;
    FMargins: TAdvMargins;
    FCanDeselect: Boolean;
    FCanSelect: Boolean;
    FVerticalTextAlign: TAdvChartGraphicsTextAlign;
    FHorizontalTextAlign: TAdvChartGraphicsTextAlign;
    FHint: string;
    FDataBoolean: Boolean;
    FDataString: String;
    FDataObject: TObject;
    FDataInteger: NativeInt;
    FDataPointer: Pointer;
    procedure SetColumnSpan(const Value: Integer);
    procedure SetRowSpan(const Value: Integer);
    procedure SetVisible(const Value: Boolean);
    procedure SetText(const Value: String);
    procedure SetEnabled(const Value: Boolean);
    procedure SetSeparator(const Value: Boolean);
    procedure SetSeparatorHeight(const Value: Single);
    procedure SetMargins(const Value: TAdvMargins);
    procedure SetCanDeselect(const Value: Boolean);
    procedure SetCanSelect(const Value: Boolean);
    procedure SetHorizontalTextAlign(const Value: TAdvChartGraphicsTextAlign);
    procedure SetVerticalTextAlign(const Value: TAdvChartGraphicsTextAlign);
    function IsSeparatorHeightStored: Boolean;
  protected
    procedure MarginsChanged(Sender: TObject);
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
    function State: TAdvChartCustomSelectorItemState;
    destructor Destroy; override;
    property DataPointer: Pointer read FDataPointer write FDataPointer;
    property DataBoolean: Boolean read FDataBoolean write FDataBoolean;
    property DataObject: TObject read FDataObject write FDataObject;
    property DataString: String read FDataString write FDataString;
    property DataInteger: NativeInt read FDataInteger write FDataInteger;
  published
    property CanSelect: Boolean read FCanSelect write SetCanSelect default True;
    property CanDeselect: Boolean read FCanDeselect write SetCanDeselect default True;
    property ColumnSpan: Integer read FColumnSpan write SetColumnSpan default 1;
    property RowSpan: Integer read FRowSpan write SetRowSpan default 1;
    property Visible: Boolean read FVisible write SetVisible default True;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property Separator: Boolean read FSeparator write SetSeparator default False;
    property SeparatorHeight: Single read FSeparatorHeight write SetSeparatorHeight stored IsSeparatorHeightStored nodefault;
    property Margins: TAdvMargins read FMargins write SetMargins;
    property Text: String read FText write SetText;
    property HorizontalTextAlign: TAdvChartGraphicsTextAlign read FHorizontalTextAlign write SetHorizontalTextAlign default gtaCenter;
    property VerticalTextAlign: TAdvChartGraphicsTextAlign read FVerticalTextAlign write SetVerticalTextAlign default gtaCenter;
    property Hint: string read FHint write FHint;
  end;

  {$IFDEF WEBLIB}
  TAdvChartCustomSelectorItems = class(TAdvOwnedCollection)
  {$ENDIF}
  {$IFNDEF WEBLIB}
  TAdvChartCustomSelectorItems = class({$IFDEF LCLLIB}specialize {$ENDIF}TAdvOwnedCollection<TAdvChartCustomSelectorItem>)
  {$ENDIF}
  private
    FOwner: TAdvChartCustomSelector;
    function GetItem(Index: Integer): TAdvChartCustomSelectorItem;
    procedure SetItem(Index: Integer; const Value: TAdvChartCustomSelectorItem);
  protected
    function CreateItemClass: TCollectionItemClass; virtual;
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TAdvChartCustomSelector); virtual;
    property Items[Index: Integer]: TAdvChartCustomSelectorItem read GetItem write SetItem; default;
    function Add: TAdvChartCustomSelectorItem;
    function Insert(Index: Integer): TAdvChartCustomSelectorItem;
  end;

  TAdvChartCustomSelectorAppearance = class(TPersistent)
  private
    FOwner: TAdvChartCustomSelector;
    FStrokeHover: TAdvChartGraphicsStroke;
    FFillDown: TAdvChartGraphicsFill;
    FVerticalSpacing: Single;
    FStrokeDown: TAdvChartGraphicsStroke;
    FFillSelected: TAdvChartGraphicsFill;
    FHorizontalSpacing: Single;
    FStrokeSelected: TAdvChartGraphicsStroke;
    FFill: TAdvChartGraphicsFill;
    FFillHover: TAdvChartGraphicsFill;
    FStroke: TAdvChartGraphicsStroke;
    FFillDisabled: TAdvChartGraphicsFill;
    FStrokeDisabled: TAdvChartGraphicsStroke;
    FSeparatorStroke: TAdvChartGraphicsStroke;
    FFont: TAdvChartGraphicsFont;
    procedure SetFill(const Value: TAdvChartGraphicsFill);
    procedure SetFillDown(const Value: TAdvChartGraphicsFill);
    procedure SetFillHover(const Value: TAdvChartGraphicsFill);
    procedure SetFillSelected(const Value: TAdvChartGraphicsFill);
    procedure SetHorizontalSpacing(const Value: Single);
    procedure SetStroke(const Value: TAdvChartGraphicsStroke);
    procedure SetStrokeDown(const Value: TAdvChartGraphicsStroke);
    procedure SetStrokeHover(const Value: TAdvChartGraphicsStroke);
    procedure SetStrokeSelected(const Value: TAdvChartGraphicsStroke);
    procedure SetVerticalSpacing(const Value: Single);
    procedure SetFillDisabled(const Value: TAdvChartGraphicsFill);
    procedure SetStrokeDisabled(const Value: TAdvChartGraphicsStroke);
    procedure SetSeparatorStroke(const Value: TAdvChartGraphicsStroke);
    procedure SetFont(const Value: TAdvChartGraphicsFont);
    function IsHorizontalSpacingStored: Boolean;
    function IsVerticalSpacingStored: Boolean;
  protected
    procedure Changed;
    procedure FontChanged(Sender: TObject);
    procedure FillChanged(Sender: TObject);
    procedure StrokeChanged(Sender: TObject);
  public
    constructor Create(AOwner: TAdvChartCustomSelector);
    procedure Assign(Source: TPersistent); override;
    destructor Destroy; override;
  published
    property Stroke: TAdvChartGraphicsStroke read FStroke write SetStroke;
    property Fill: TAdvChartGraphicsFill read FFill write SetFill;
    property StrokeHover: TAdvChartGraphicsStroke read FStrokeHover write SetStrokeHover;
    property FillHover: TAdvChartGraphicsFill read FFillHover write SetFillHover;
    property StrokeDown: TAdvChartGraphicsStroke read FStrokeDown write SetStrokeDown;
    property FillDown: TAdvChartGraphicsFill read FFillDown write SetFillDown;
    property StrokeSelected: TAdvChartGraphicsStroke read FStrokeSelected write SetStrokeSelected;
    property FillSelected: TAdvChartGraphicsFill read FFillSelected write SetFillSelected;
    property StrokeDisabled: TAdvChartGraphicsStroke read FStrokeDisabled write SetStrokeDisabled;
    property FillDisabled: TAdvChartGraphicsFill read FFillDisabled write SetFillDisabled;
    property VerticalSpacing: Single read FVerticalSpacing write SetVerticalSpacing stored IsVerticalSpacingStored nodefault;
    property HorizontalSpacing: Single read FHorizontalSpacing write SetHorizontalSpacing stored IsHorizontalSpacingStored nodefault;
    property SeparatorStroke: TAdvChartGraphicsStroke read FSeparatorStroke write SetSeparatorStroke;
    property Font: TAdvChartGraphicsFont read FFont write SetFont;
  end;

  TAdvChartCustomSelectorPositionItem = record
    TileSet: Boolean;
    {$IFDEF LCLLIB}
    class operator = (z1, z2 : TAdvChartCustomSelectorPositionItem) b : Boolean;
    {$ENDIF}
  end;

  TAdvChartCustomSelectorDisplayItem = record
    Rect: TRectF;
    Item: TAdvChartCustomSelectorItem;
    PageIndex: Integer;
    Column, Row, ColumnSpan, RowSpan: Integer;
    {$IFDEF LCLLIB}
    class operator = (z1, z2 : TAdvChartCustomSelectorDisplayItem) b : Boolean;
    {$ENDIF}
  end;

  TAdvChartCustomSelectorItemPosArray = array of array of TAdvChartCustomSelectorPositionItem;

  TAdvChartCustomSelectorItemSelected = procedure(Sender: TObject; AItemIndex: Integer) of object;
  TAdvChartCustomSelectorItemDeselected = procedure(Sender: TObject; AItemIndex: Integer) of object;
  TAdvChartCustomSelectorItemClick = procedure(Sender: TObject; AItemIndex: Integer) of object;
  TAdvChartCustomSelectorItemBeforeDrawBackground = procedure(Sender: TObject; AGraphics: TAdvChartGraphics; ARect: TRectF; AItemIndex: Integer; var ADefaultDraw: Boolean) of object;
  TAdvChartCustomSelectorItemAfterDrawBackground = procedure(Sender: TObject; AGraphics: TAdvChartGraphics; ARect: TRectF; AItemIndex: Integer) of object;
  TAdvChartCustomSelectorItemBeforeDrawContent = procedure(Sender: TObject; AGraphics: TAdvChartGraphics; ARect: TRectF; AItemIndex: Integer; var ADefaultDraw: Boolean) of object;
  TAdvChartCustomSelectorItemAfterDrawContent = procedure(Sender: TObject; AGraphics: TAdvChartGraphics; ARect: TRectF; AItemIndex: Integer) of object;
  TAdvChartCustomSelectorItemBeforeDrawText = procedure(Sender: TObject; AGraphics: TAdvChartGraphics; ARect: TRectF; AItemIndex: Integer; var AText: String; var ADefaultDraw: Boolean) of object;
  TAdvChartCustomSelectorItemAfterDrawText = procedure(Sender: TObject; AGraphics: TAdvChartGraphics; ARect: TRectF; AItemIndex: Integer; AText: String) of object;
  TAdvChartCustomSelectorBeforeDraw = procedure(Sender: TObject; AGraphics: TAdvChartGraphics; ARect: TRectF; var ADefaultDraw: Boolean) of object;
  TAdvChartCustomSelectorAfterDraw = procedure(Sender: TObject; AGraphics: TAdvChartGraphics; ARect: TRectF) of object;

  {$IFDEF WEBLIB}
  TAdvChartCustomSelectorDisplayList = class(TList)
  private
    function GetItem(Index: Integer): TAdvChartCustomSelectorDisplayItem;
    procedure SetItem(Index: Integer; const Value: TAdvChartCustomSelectorDisplayItem);
  public
    property Items[Index: Integer]: TAdvChartCustomSelectorDisplayItem read GetItem write SetItem; default;
  end;
  {$ENDIF}
  {$IFNDEF WEBLIB}
  TAdvChartCustomSelectorDisplayList = class(TList<TAdvChartCustomSelectorDisplayItem>);
  {$ENDIF}

  TAdvChartCustomSelector = class(TAdvChartCustomControl)
  private
    FDisplayList: TAdvChartCustomSelectorDisplayList;
    FUpdateCount: Integer;
    FItems: TAdvChartCustomSelectorItems;
    FRows: Integer;
    FColumns: Integer;
    FPageCount: Integer;
    FAppearance: TAdvChartCustomSelectorAppearance;
    FSelectedItemIndex, FFocusedItemIndex, FHoveredItemIndex, FDownItemIndex: Integer;
    FOnItemBeforeDrawText: TAdvChartCustomSelectorItemBeforeDrawText;
    FOnAfterDraw: TAdvChartCustomSelectorAfterDraw;
    FOnItemAfterDrawBackground: TAdvChartCustomSelectorItemAfterDrawBackground;
    FOnItemSelected: TAdvChartCustomSelectorItemSelected;
    FOnItemAfterDrawText: TAdvChartCustomSelectorItemAfterDrawText;
    FOnBeforeDraw: TAdvChartCustomSelectorBeforeDraw;
    FOnItemBeforeDrawBackground: TAdvChartCustomSelectorItemBeforeDrawBackground;
    FOnItemDeselected: TAdvChartCustomSelectorItemDeselected;
    FOnItemClick: TAdvChartCustomSelectorItemClick;
    FOnItemBeforeDrawContent: TAdvChartCustomSelectorItemBeforeDrawContent;
    FOnItemAfterDrawContent: TAdvChartCustomSelectorItemAfterDrawContent;
    FBlockChange: Boolean;
    FClosedRemotely: Boolean;
    procedure SetItems(const Value: TAdvChartCustomSelectorItems);
    procedure SetColumns(const Value: Integer);
    procedure SetRows(const Value: Integer);
    procedure SetAppearance(const Value: TAdvChartCustomSelectorAppearance);
    procedure SetSelectedItemIndex(const Value: Integer);
  protected
    procedure ChangeDPIScale(M, D: Integer); override;
    procedure RegisterRuntimeClasses; override;
    function GetDocURL: string; override;
    function GetHintString: string; override;
    function HasHint: Boolean; override;
    function GetVersion: String; override;
    function GetDisplayItem(AItemIndex: Integer): TAdvChartCustomSelectorDisplayItem; virtual;
    function GetNextSelectableItem: Integer; virtual;
    function GetPreviousSelectableItem: Integer; virtual;
    function GetNextSelectableRowItem: Integer; virtual;
    function GetPreviousSelectableRowItem: Integer; virtual;
    function GetFirstSelectableItem: Integer; virtual;
    function GetLastSelectableItem: Integer; virtual;
    function CreateItemsCollection: TAdvChartCustomSelectorItems; virtual;
    procedure CalculateItems; virtual;
    procedure UpdateCalculations; virtual;
    procedure ApplyStyle; override;
    procedure ResetToDefaultStyle; override;
    function GetTopOffset: Single; virtual;
    function GetCalculationWidth: Single; virtual;
    function GetCalculationHeight: Single; virtual;
    function GetTotalSeparatorHeight: Single;
    function GetTotalSeparatorCount: Integer;
    procedure DoItemSelected(AItemIndex: Integer); virtual;
    procedure DoItemClick(AItemIndex: Integer); virtual;
    procedure DoItemDeselected(AItemIndex: Integer); virtual;
    procedure DoItemBeforeDrawBackground(AGraphics: TAdvChartGraphics; ARect: TRectF; AItemIndex: Integer; var ADefaultDraw: Boolean); virtual;
    procedure DoItemAfterDrawBackground(AGraphics: TAdvChartGraphics; ARect: TRectF; AItemIndex: Integer); virtual;
    procedure DoItemBeforeDrawContent(AGraphics: TAdvChartGraphics; ARect: TRectF; AItemIndex: Integer; var ADefaultDraw: Boolean); virtual;
    procedure DoItemAfterDrawContent(AGraphics: TAdvChartGraphics; ARect: TRectF; AItemIndex: Integer); virtual;
    procedure DoItemBeforeDrawText(AGraphics: TAdvChartGraphics; ARect: TRectF; AItemIndex: Integer; var AText: String; var ADefaultDraw: Boolean); virtual;
    procedure DoItemAfterDrawText(AGraphics: TAdvChartGraphics; ARect: TRectF; AItemIndex: Integer; AText: String); virtual;
    procedure DoBeforeDraw(AGraphics: TAdvChartGraphics; ARect: TRectF; var ADefaultDraw: Boolean); reintroduce; virtual;
    procedure DoAfterDraw(AGraphics: TAdvChartGraphics; ARect: TRectF); reintroduce; virtual;
    procedure DrawItems(AGraphics: TAdvChartGraphics); virtual;
    procedure Draw(AGraphics: TAdvChartGraphics; ARect: TRectF); override;

    procedure DrawItem(AGraphics: TAdvChartGraphics; ADisplayItem: TAdvChartCustomSelectorDisplayItem); virtual;
    procedure DrawItemBackGround(AGraphics: TAdvChartGraphics; ADisplayItem: TAdvChartCustomSelectorDisplayItem); virtual;
    procedure DrawItemContent(AGraphics: TAdvChartGraphics; ADisplayItem: TAdvChartCustomSelectorDisplayItem); virtual;
    procedure DrawItemText(AGraphics: TAdvChartGraphics; ADisplayItem: TAdvChartCustomSelectorDisplayItem); virtual;

    procedure HandleMouseDown(Button: TAdvMouseButton; Shift: TShiftState; X: Single; Y: Single); override;
    procedure HandleMouseUp(Button: TAdvMouseButton; Shift: TShiftState; X: Single; Y: Single); override;
    procedure HandleMouseMove(Shift: TShiftState; X: Single; Y: Single); override;
    procedure HandleKeyDown(var Key: Word; Shift: TShiftState); override;
    procedure HandleKeyUp(var Key: Word; Shift: TShiftState); override;
    procedure HandleMouseLeave; override;
    procedure ProcessSelection(AItemIndex: Integer);
    property SelectedItemIndex: Integer read FSelectedItemIndex write SetSelectedItemIndex default -1;
    property Rows: Integer read FRows write SetRows default 4;
    property Columns: Integer read FColumns write SetColumns default 4;
    property Version: String read GetVersion;
    property Items: TAdvChartCustomSelectorItems read FItems write SetItems;
    property Appearance: TAdvChartCustomSelectorAppearance read FAppearance write SetAppearance;
    property OnItemSelected: TAdvChartCustomSelectorItemSelected read FOnItemSelected write FOnItemSelected;
    property OnItemDeselected: TAdvChartCustomSelectorItemDeselected read FOnItemDeselected write FOnItemDeselected;
    property OnItemClick: TAdvChartCustomSelectorItemClick read FOnItemClick write FOnItemClick;
    property OnItemBeforeDrawBackground: TAdvChartCustomSelectorItemBeforeDrawBackground read FOnItemBeforeDrawBackground write FOnItemBeforeDrawBackground;
    property OnItemAfterDrawBackground: TAdvChartCustomSelectorItemAfterDrawBackground read FOnItemAfterDrawBackground write FOnItemAfterDrawBackground;
    property OnItemBeforeDrawContent: TAdvChartCustomSelectorItemBeforeDrawContent read FOnItemBeforeDrawContent write FOnItemBeforeDrawContent;
    property OnItemAfterDrawContent: TAdvChartCustomSelectorItemAfterDrawContent read FOnItemAfterDrawContent write FOnItemAfterDrawContent;
    property OnBeforeDraw: TAdvChartCustomSelectorBeforeDraw read FOnBeforeDraw write FOnBeforeDraw;
    property OnAfterDraw: TAdvChartCustomSelectorAfterDraw read FOnAfterDraw write FOnAfterDraw;
    property OnItemBeforeDrawText: TAdvChartCustomSelectorItemBeforeDrawText read FOnItemBeforeDrawText write FOnItemBeforeDrawText;
    property OnItemAfterDrawText: TAdvChartCustomSelectorItemAfterDrawText read FOnItemAfterDrawText write FOnItemAfterDrawText;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure BeginUpdate; override;
    procedure EndUpdate; override;
    procedure InvalidateItems;
    property BlockChange: Boolean read FBlockChange write FBlockChange;
    procedure UpdateControlAfterResize; override;
    procedure InitializeDefault; virtual;
    function XYToItem(X, Y: Single): Integer;
    property ClosedRemotely: Boolean read FClosedRemotely write FClosedRemotely;
  end;

  TAdvChartDefaultSelector = class(TAdvChartCustomSelector)
  published
    property Fill;
    property Stroke;
    property Version;
  end;

implementation

uses
  Math, SysUtils, AdvChartUtils, AdvChartStyles
  {$IFDEF VCLLIB}
  , Graphics
  {$ENDIF}
  ;

{ TAdvChartCustomSelector }

procedure TAdvChartCustomSelector.ApplyStyle;
var
  c: TAdvChartGraphicsColor;
begin
  inherited;

  c := gcNull;
  if TAdvChartStyles.GetStyleBackgroundFillColor(c) then
    Fill.Color := c;

  c := gcNull;
  if TAdvChartStyles.GetStyleBackgroundStrokeColor(c) then
    Stroke.Color := c;

  c := gcNull;
  if TAdvChartStyles.GetStyleDefaultButtonFillColor(c) then
    Appearance.Fill.Color := c;

  c := gcNull;
  if TAdvChartStyles.GetStyleSelectionFillColor(c) then
  begin
    Appearance.FillSelected.Color := c;
    Appearance.FillDown.Color := c;
    Appearance.FillHover.Color := Blend(c, Appearance.Fill.Color, 25);
  end;

  c := gcNull;
  if TAdvChartStyles.GetStyleDefaultButtonStrokeColor(c) then
  begin
    Appearance.Stroke.Color := c;
    Appearance.StrokeSelected.Color := c;
    Appearance.StrokeDown.Color := c;
    Appearance.StrokeHover.Color := c;
  end;

  c := gcNull;
  if TAdvChartStyles.GetStyleTextFontColor(c) then
    Appearance.Font.Color := c;
end;

procedure TAdvChartCustomSelector.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TAdvChartCustomSelector then
  begin
    FItems.Assign((Source as TAdvChartCustomSelector).Items);
    FAppearance.Assign((Source as TAdvChartCustomSelector).Appearance);
    FRows := (Source as TAdvChartCustomSelector).Rows;
    FColumns := (Source as TAdvChartCustomSelector).Columns;
  end;
end;

procedure TAdvChartCustomSelector.BeginUpdate;
begin
  inherited;
  Inc(FUpdateCount);
end;

procedure TAdvChartCustomSelector.CalculateItems;
var
  itposarr: TAdvChartCustomSelectorItemPosArray;
  r, newr, c, newc: Integer;
  AItemIndex: Integer;
  AItem: TAdvChartCustomSelectorItem;
  cspan, rspan, newcspan, newrspan: Integer;
  I: Integer;
  K: Integer;
  sepc: Integer;
  f: Boolean;
  APageIndex: Integer;
  hs, vs: Single;
  iw, ih: Single;
  w, h: Single;
  exw, exh: Single;
  tx, ty: Single;
  pw, ph: Single;
  offs: Single;
  itd: TAdvChartCustomSelectorDisplayItem;

  procedure FindNewPos(AItem: TAdvChartCustomSelectorItem; var ANewR: Integer; var ANewC: Integer; var AFound: Boolean; ARows , {%H-}ACurRow, AColumns, {%H-}ACurCol: Integer; PosArr: TAdvChartCustomSelectorItemPosArray);
  var
    i, k: integer;
    cspan, rspan: Integer;
    J, L: Integer;
  begin
    AFound := False;
    for I := ANewr to ARows - 1 do
    begin
      for K := ANewC to AColumns - 1 do
      begin
        cspan := AItem.ColumnSpan;
        cspan := Min(cspan, Columns - ANewC);
        rspan := AItem.RowSpan;
        rspan := Min(rspan, Rows - ANewR);

        AFound := true;
        for J := 0 to rspan - 1 do
        begin
          for L := 0 to cspan - 1 do
          begin
            if PosArr[I + J, K + L].TileSet then
              AFound := False;
          end;
        end;

        if AFound then
          Break;
        Inc(ANewC);
      end;
      if AFound then
        Break;

      ANewC := 0;
      Inc(ANewr);
    end;
  end;
begin
  if (csDestroying in ComponentState) or (FUpdateCount > 0) then
    Exit;

  FDisplayList.Clear;

  if Items.Count = 0 then
    Exit;

  pw := GetCalculationWidth;
  ph := GetCalculationHeight;
  hs := Appearance.HorizontalSpacing;
  vs := Appearance.VerticalSpacing;
  w := pw - vs;
  iw := w;
  if Columns > 0 then
    iw := (w - (Columns * hs)) / Columns;

  h := ph - vs - GetTotalSeparatorHeight;
  sepc := GetTotalSeparatorCount;
  ih := h;
  if (Rows - sepc) > 0 then
    ih := (h - ((Rows - sepc) * vs)) / (Rows - sepc);

  AItemIndex := 0;
  APageIndex := 0;
  offs := 0;
  while AItemIndex <= Items.Count - 1 do
  begin
    c := 0;
    r := 0;
    SetLength(itposarr, 0, 0);
    SetLength(itposarr, Rows, Columns);

    while r < Rows do
    begin
      while (c < Columns) do
      begin
        if (AItemIndex >= 0) and (AItemIndex <= Items.Count - 1) and (APageIndex = 0) then
        begin
          AItem := Items[AItemIndex];
          if not AItem.Visible then
          begin
            Inc(AItemIndex);
            Continue;
          end;

          if AItem.Separator then
          begin
            cspan := Columns;
            rspan := 1;
          end
          else
          begin
            cspan := AItem.ColumnSpan;
            rspan := AItem.RowSpan;
          end;

          cspan := Min(cspan, Columns - c);
          rspan := Min(rspan, Rows - r);

          exw := iw * cspan + (hs * (cspan - 1));
          if AItem.Separator then
            exh := AItem.SeparatorHeight
          else
            exh := ih * rspan + (vs * (rspan - 1));

          tx := (pw * APageIndex) + hs + iw * c + (hs * c);
          ty := offs + vs + ih * r + (vs * r) + GetTopOffset;

          itd.Rect := RectF(tx + AItem.Margins.Left, ty + AItem.Margins.Top,
            tx + exw - AItem.Margins.Right, ty + exh - AItem.Margins.Bottom);
          itd.Item := AItem;
          itd.PageIndex := APageIndex;
          itd.Column := c;
          itd.Row := r;
          itd.ColumnSpan := cspan;
          itd.RowSpan := rspan;
          FDisplayList.Add(itd);

          newcspan := c;
          newrspan := r;
          newcspan := newcspan + cspan - 1;
          newrspan := newrspan + rspan - 1;

          for I := r to newrspan do
            for K := c to newcspan do
              itposarr[I, K].TileSet := True;

          if AItem.Separator then
            offs := offs + AItem.SeparatorHeight - ih * rspan + (vs * (rspan - 1));
        end;
        Inc(AItemIndex);
        Inc(c);
        newc := c;
        newr := r;
        f := False;
        if (AItemIndex >= 0) and (AItemIndex <= Items.Count - 1) then
          FindNewPos(Items[AItemIndex], newr, newc, f, Rows, newr, Columns, newc, itposarr);
        c := newc;
        r := newr;

        if (c >= Columns) or (r >= Rows) then
          Break;
      end;
      c := 0;
      Inc(r);
      newc := c;
      newr := r;
      f := False;
      if (AItemIndex >= 0) and (AItemIndex <= Items.Count - 1) then
        FindNewPos(Items[AItemIndex], newr, newc, f, Rows, newr, Columns, newc, itposarr);
      c := newc;
      r := newr;
      if r >= Rows then
        Break;
    end;
    Inc(APageIndex);
  end;

  FPageCount := APageIndex;
  InvalidateItems;
end;

procedure TAdvChartCustomSelector.ChangeDPIScale(M, D: Integer);
begin
  inherited;
  BeginUpdate;
  FAppearance.FVerticalSpacing := TAdvChartUtils.MulDivSingle(FAppearance.FVerticalSpacing, M, D);
  FAppearance.FHorizontalSpacing := TAdvChartUtils.MulDivSingle(FAppearance.FHorizontalSpacing, M, D);
  FAppearance.Font.Height := TAdvChartUtils.MulDivInt(FAppearance.Font.Height, M, D);
  EndUpdate;
end;

constructor TAdvChartCustomSelector.Create(AOwner: TComponent);
begin
  inherited;
  FColumns := 4;
  FRows := 4;
  FItems := CreateItemsCollection;
  FDisplayList := TAdvChartCustomSelectorDisplayList.Create;
  FAppearance := TAdvChartCustomSelectorAppearance.Create(Self);
  FSelectedItemIndex := -1;
  FFocusedItemIndex := -1;
  FHoveredItemIndex := -1;
  FDownItemIndex := -1;

  if IsDesignTime then
    InitializeDefault;
end;

procedure TAdvChartCustomSelector.InitializeDefault;
begin

end;

function TAdvChartCustomSelector.CreateItemsCollection: TAdvChartCustomSelectorItems;
begin
  Result := TAdvChartCustomSelectorItems.Create(Self);
end;

destructor TAdvChartCustomSelector.Destroy;
begin
  FAppearance.Free;
  FDisplayList.Free;
  FItems.Free;
  inherited;
end;

procedure TAdvChartCustomSelector.DoAfterDraw(AGraphics: TAdvChartGraphics; ARect: TRectF);
begin
  if Assigned(OnAfterDraw) then
    OnAfterDraw(Self, AGraphics, ARect);
end;

procedure TAdvChartCustomSelector.DoBeforeDraw(AGraphics: TAdvChartGraphics; ARect: TRectF;
  var ADefaultDraw: Boolean);
begin
  if Assigned(OnBeforeDraw) then
    OnBeforeDraw(Self, AGraphics, ARect, ADefaultDraw);
end;

procedure TAdvChartCustomSelector.DoItemAfterDrawBackground(AGraphics: TAdvChartGraphics;
  ARect: TRectF; AItemIndex: Integer);
begin
  if Assigned(OnItemAfterDrawBackground) then
    OnItemAfterDrawBackground(Self, AGraphics, ARect, AItemIndex);
end;

procedure TAdvChartCustomSelector.DoItemAfterDrawContent(AGraphics: TAdvChartGraphics;
  ARect: TRectF; AItemIndex: Integer);
begin
  if Assigned(OnItemAfterDrawContent) then
    OnItemAfterDrawContent(Self, AGraphics, ARect, AItemIndex);
end;

procedure TAdvChartCustomSelector.DoItemAfterDrawText(AGraphics: TAdvChartGraphics;
  ARect: TRectF; AItemIndex: Integer; AText: String);
begin
  if Assigned(OnItemAfterDrawText) then
    OnItemAfterDrawText(Self, AGraphics, ARect, AItemIndex, AText);
end;

procedure TAdvChartCustomSelector.DoItemBeforeDrawBackground(AGraphics: TAdvChartGraphics;
  ARect: TRectF; AItemIndex: Integer; var ADefaultDraw: Boolean);
begin
  if Assigned(OnItemBeforeDrawBackground) then
    OnItemBeforeDrawBackground(Self, AGraphics, ARect, AItemIndex, ADefaultDraw);
end;

procedure TAdvChartCustomSelector.DoItemBeforeDrawContent(AGraphics: TAdvChartGraphics;
  ARect: TRectF; AItemIndex: Integer; var ADefaultDraw: Boolean);
begin
  if Assigned(OnItemBeforeDrawContent) then
    OnItemBeforeDrawContent(Self, AGraphics, ARect, AItemIndex, ADefaultDraw);
end;

procedure TAdvChartCustomSelector.DoItemBeforeDrawText(AGraphics: TAdvChartGraphics;
  ARect: TRectF; AItemIndex: Integer; var AText: String;
  var ADefaultDraw: Boolean);
begin
  if Assigned(OnItemBeforeDrawText) then
    OnItemBeforeDrawText(Self, AGraphics, ARect, AItemIndex, AText, ADefaultDraw);
end;

procedure TAdvChartCustomSelector.DoItemSelected(AItemIndex: Integer);
begin
  if Assigned(OnItemSelected) then
    OnItemSelected(Self, AItemIndex);
end;

procedure TAdvChartCustomSelector.DoItemClick(AItemIndex: Integer);
begin
  if Assigned(OnItemClick) then
    OnItemClick(Self, AItemIndex);
end;

procedure TAdvChartCustomSelector.DoItemDeselected(AItemIndex: Integer);
begin
  if Assigned(OnItemDeselected) then
    OnItemDeselected(Self, AItemIndex);
end;

procedure TAdvChartCustomSelector.HandleMouseLeave;
begin
  inherited;
  FHoveredItemIndex := -1;
  InvalidateItems;
end;

procedure TAdvChartCustomSelector.DrawItem(AGraphics: TAdvChartGraphics;
  ADisplayItem: TAdvChartCustomSelectorDisplayItem);
begin
  DrawItemBackGround(AGraphics, ADisplayItem);
  DrawItemContent(AGraphics, ADisplayItem);
  DrawItemText(AGraphics, ADisplayItem);
end;

procedure TAdvChartCustomSelector.DrawItemBackGround(AGraphics: TAdvChartGraphics; ADisplayItem: TAdvChartCustomSelectorDisplayItem);
var
  r: TRectF;
  it: TAdvChartCustomSelectorItem;
  a: Boolean;
  fr: TRectF;
begin
  it := ADisplayItem.Item;
  if Assigned(it) then
  begin
    if not it.Separator then
    begin
      AGraphics.Fill.Assign(Appearance.Fill);
      AGraphics.Stroke.Assign(Appearance.Stroke);
      if it.Enabled then
      begin
        if it.Index = FDownItemIndex then
        begin
          AGraphics.Fill.Assign(Appearance.FillDown);
          AGraphics.Stroke.Assign(Appearance.StrokeDown);
        end
        else if it.Index = FHoveredItemIndex then
        begin
          AGraphics.Fill.Assign(Appearance.FillHover);
          AGraphics.Stroke.Assign(Appearance.StrokeHover);
        end
        else if it.Index = FSelectedItemIndex then
        begin
          AGraphics.Fill.Assign(Appearance.FillSelected);
          AGraphics.Stroke.Assign(Appearance.StrokeSelected);
        end;
      end
      else
      begin
        AGraphics.Fill.Assign(Appearance.FillDisabled);
        AGraphics.Stroke.Assign(Appearance.StrokeDisabled);
      end;
    end
    else
      AGraphics.Stroke.Assign(Appearance.SeparatorStroke);

    r := ADisplayItem.Rect;
    a := True;
    DoItemBeforeDrawBackground(AGraphics, ADisplayItem.Rect, it.Index, a);
    if a then
    begin
      if it.Separator then
        AGraphics.DrawLine(PointF(r.Left, CenterPointEx(r).Y), PointF(r.Right, CenterPointEx(r).Y))
      else
      begin
        AGraphics.DrawRectangle(r);
        if Focused and (FFocusedItemIndex = it.Index) then
        begin
          fr := r;
          InflateRectEx(fr, ScalePaintValue(-2), ScalePaintValue(-2));
          AGraphics.DrawFocusRectangle(fr);
        end;
      end;

      DoItemAfterDrawBackground(AGraphics, ADisplayItem.Rect, it.Index);
    end;
  end;
end;

procedure TAdvChartCustomSelector.DrawItemContent(AGraphics: TAdvChartGraphics;
  ADisplayItem: TAdvChartCustomSelectorDisplayItem);
var
  it: TAdvChartCustomSelectorItem;
  a: Boolean;
begin
  it := ADisplayItem.Item;
  if Assigned(it) then
  begin
    a := True;
    DoItemBeforeDrawContent(AGraphics, ADisplayItem.Rect, it.Index, a);
    if a then
      DoItemAfterDrawContent(AGraphics, ADisplayItem.Rect, it.Index);
  end;
end;

procedure TAdvChartCustomSelector.DrawItems(AGraphics: TAdvChartGraphics);
var
  I: Integer;
begin
  for I := 0 to FDisplayList.Count - 1 do
    DrawItem(AGraphics, FDisplayList[I]);
end;

procedure TAdvChartCustomSelector.DrawItemText(AGraphics: TAdvChartGraphics;
  ADisplayItem: TAdvChartCustomSelectorDisplayItem);
var
  r: TRectF;
  it: TAdvChartCustomSelectorItem;
  str: String;
  a: Boolean;
begin
  it := ADisplayItem.Item;
  if Assigned(it) and (it.Text <> '') then
  begin
    r := ADisplayItem.Rect;
    str := it.Text;
    a := True;
    InflateRectEx(r, -2, -2);
    AGraphics.Font.AssignSource(Appearance.Font);
    DoItemBeforeDrawText(AGraphics, ADisplayItem.Rect, it.Index, str, a);
    if a then
    begin
      AGraphics.DrawText(r, str, False, it.HorizontalTextAlign, it.VerticalTextAlign);
      DoItemAfterDrawText(AGraphics, ADisplayItem.Rect, it.Index, str);
    end;
  end;
end;

procedure TAdvChartCustomSelector.EndUpdate;
begin
  inherited;
  Dec(FUpdateCount);
  if FUpdateCount = 0 then
    CalculateItems;
end;

function TAdvChartCustomSelector.GetFirstSelectableItem: Integer;
var
  I: Integer;
  it: TAdvChartCustomSelectorItem;
begin
  Result := FFocusedItemIndex;
  for I := 0 to FDisplayList.Count - 1 do
  begin
    it := FDisplayList[I].Item;
    if Assigned(it) and it.Enabled and not it.Separator then
    begin
      Result := it.Index;
      Break;
    end;
  end;
end;

function TAdvChartCustomSelector.GetCalculationHeight: Single;
begin
  Result := Height - GetTopOffset;
end;

function TAdvChartCustomSelector.GetHintString: string;
var
  it: TAdvChartCustomSelectorItem;
begin
  Result := inherited GetHintString;
  if (FHoveredItemIndex >= 0) and (FHoveredItemIndex <= FItems.Count - 1) then
  begin
    it := FItems[FHoveredItemIndex];
    Result := it.Hint;
  end;
end;

function TAdvChartCustomSelector.GetLastSelectableItem: Integer;
var
  I: Integer;
  it: TAdvChartCustomSelectorItem;
begin
  Result := FFocusedItemIndex;
  for I := FDisplayList.Count - 1 downto 0 do
  begin
    it := FDisplayList[I].Item;
    if Assigned(it) and it.Enabled and not it.Separator then
    begin
      Result := it.Index;
      Break;
    end;
  end;
end;

function TAdvChartCustomSelector.GetNextSelectableItem: Integer;
var
  I: Integer;
  it: TAdvChartCustomSelectorItem;
begin
  Result := FFocusedItemIndex;
  for I := 0 to FDisplayList.Count - 1 do
  begin
    it := FDisplayList[I].Item;
    if Assigned(it) and it.Enabled and not it.Separator and (it.Index > FFocusedItemIndex) then
    begin
      Result := it.Index;
      Break;
    end;
  end;
end;

function TAdvChartCustomSelector.GetNextSelectableRowItem: Integer;
var
  I: Integer;
  it: TAdvChartCustomSelectorItem;
  disp: TAdvChartCustomSelectorDisplayItem;
begin
  Result := FFocusedItemIndex;
  if Result = -1 then
  begin
    Result := GetNextSelectableItem;
    Exit;
  end;

  disp := GetDisplayItem(FFocusedItemIndex);
  for I := 0 to FDisplayList.Count - 1 do
  begin
    it := FDisplayList[I].Item;
    if Assigned(it) and it.Enabled and not it.Separator and (it.Index > FFocusedItemIndex) and (disp.Column >= FDisplayList[I].Column) and
      (disp.Column <= FDisplayList[I].Column + (FDisplayList[I].ColumnSpan - 1))
      and (FDisplayList[I].Row > disp.Row) then
    begin
      Result := it.Index;
      Break;
    end;
  end;
end;

function TAdvChartCustomSelector.GetPreviousSelectableItem: Integer;
var
  I: Integer;
  it: TAdvChartCustomSelectorItem;
begin
  Result := FFocusedItemIndex;
  for I := FDisplayList.Count - 1 downto 0 do
  begin
    it := FDisplayList[I].Item;
    if Assigned(it) and it.Enabled and not it.Separator and (it.Index < FFocusedItemIndex) then
    begin
      Result := it.Index;
      Break;
    end;
  end;
end;

function TAdvChartCustomSelector.GetPreviousSelectableRowItem: Integer;
var
  I: Integer;
  it: TAdvChartCustomSelectorItem;
  disp: TAdvChartCustomSelectorDisplayItem;
begin
  Result := FFocusedItemIndex;
  if Result = -1 then
  begin
    Result := GetPreviousSelectableItem;
    Exit;
  end;

  disp := GetDisplayItem(FFocusedItemIndex);
  for I := FDisplayList.Count - 1 downto 0 do
  begin
    it := FDisplayList[I].Item;
    if Assigned(it) and it.Enabled and not (it.Separator) and (it.Index < FFocusedItemIndex) and (disp.Column >= FDisplayList[I].Column) and
      (disp.Column <= FDisplayList[I].Column + (FDisplayList[I].ColumnSpan - 1)) and (FDisplayList[I].Row < disp.Row) then
    begin
      Result := it.Index;
      Break;
    end;
  end;
end;

function TAdvChartCustomSelector.GetTopOffset: Single;
begin
  Result := 0;
end;

function TAdvChartCustomSelector.GetTotalSeparatorCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Items.Count - 1 do
  begin
    if Items[I].Separator then
      Inc(Result);
  end;
end;

function TAdvChartCustomSelector.GetTotalSeparatorHeight: Single;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Items.Count - 1 do
  begin
    if Items[I].Separator then
      Result := Result + Items[I].SeparatorHeight + Appearance.VerticalSpacing;
  end;
end;

function TAdvChartCustomSelector.GetVersion: String;
begin
  Result := GetVersionNumber(MAJ_VER, MIN_VER, REL_VER, BLD_VER);
end;

function TAdvChartCustomSelector.GetCalculationWidth: Single;
begin
  Result := Width;
end;

procedure TAdvChartCustomSelector.HandleKeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    KEY_UP:
    begin
      FFocusedItemIndex := GetPreviousSelectableRowItem;
      InvalidateItems;
    end;
    KEY_LEFT:
    begin
      FFocusedItemIndex := GetPreviousSelectableItem;
      InvalidateItems;
    end;
    KEY_DOWN:
    begin
      FFocusedItemIndex := GetNextSelectableRowItem;
      InvalidateItems;
    end;
    KEY_RIGHT:
    begin
      FFocusedItemIndex := GetNextSelectableItem;
      InvalidateItems;
    end;
    KEY_HOME:
    begin
      FFocusedItemIndex := GetFirstSelectableItem;
      InvalidateItems;
    end;
    KEY_END:
    begin
      FFocusedItemIndex := GetLastSelectableItem;
      InvalidateItems;
    end;
  end;

  if (Key = KEY_RETURN) then
  begin
    FDownItemIndex := FFocusedItemIndex;
    InvalidateItems;
  end;
end;

procedure TAdvChartCustomSelector.HandleKeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = KEY_RETURN) then
  begin
    FDownItemIndex := -1;
    ProcessSelection(FFocusedItemIndex);
    InvalidateItems;
  end;
end;

procedure TAdvChartCustomSelector.HandleMouseDown(Button: TAdvMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  inherited;
  CaptureEx;
  FDownItemIndex := XYToItem(X, Y);
  InvalidateItems;
end;

procedure TAdvChartCustomSelector.HandleMouseMove(Shift: TShiftState; X, Y: Single);
var
  h: Integer;
begin
  inherited;
  if FDownItemIndex > -1 then
    Exit;

  h := XYToItem(X, Y);
  if h <> FHoveredItemIndex then
  begin
    FHoveredItemIndex := h;
    CancelHint;
    InvalidateItems;
  end;
end;

procedure TAdvChartCustomSelector.HandleMouseUp(Button: TAdvMouseButton; Shift: TShiftState;
  X, Y: Single);
var
  s: Integer;
begin
  inherited;
  ReleaseCaptureEx;
  s := XYToItem(X, Y);
  if (s = FDownItemIndex) and (FDownItemIndex <> -1) then
  begin
    ProcessSelection(s);
    if s <> -1 then
      DoItemClick(s);
  end;
  FDownItemIndex := -1;
  FHoveredItemIndex := -1;
  InvalidateItems;
end;

function TAdvChartCustomSelector.HasHint: Boolean;
var
  it: TAdvChartCustomSelectorItem;
begin
  Result := False;
  if (FHoveredItemIndex >= 0) and (FHoveredItemIndex <= FItems.Count - 1) then
  begin
    it := FItems[FHoveredItemIndex];
    Result := it.Hint <> '';
  end;
end;

procedure TAdvChartCustomSelector.Draw(AGraphics: TAdvChartGraphics; ARect: TRectF);
var
  a: Boolean;
begin
  inherited;
  a := True;
  DoBeforeDraw(AGraphics, ARect, a);
  if a then
  begin
    DrawItems(AGraphics);
    DoAfterDraw(AGraphics, ARect);
  end;
end;

procedure TAdvChartCustomSelector.ProcessSelection(AItemIndex: Integer);
var
  it: TAdvChartCustomSelectorItem;
  prev: Integer;
begin
  if (AItemIndex >= 0) and (AItemIndex <= Items.Count - 1) then
  begin
    it := FItems[AItemIndex];
    if it.CanSelect then
    begin
      prev := FSelectedItemIndex;
      if it.CanDeselect and (it.Index = FSelectedItemIndex) then
        FSelectedItemIndex := -1
      else
        FSelectedItemIndex := it.Index;

      if FSelectedItemIndex <> -1 then
        FFocusedItemIndex := FSelectedItemIndex;

      if it.CanDeselect and (prev <> -1) then
        DoItemDeSelected(prev);

      if FSelectedItemIndex <> -1 then
        DoItemSelected(FSelectedItemIndex);
    end;
  end;
end;

procedure TAdvChartCustomSelector.RegisterRuntimeClasses;
begin
  inherited;
  RegisterClass(TAdvChartCustomSelector);
end;

procedure TAdvChartCustomSelector.InvalidateItems;
begin
  Invalidate;
end;

procedure TAdvChartCustomSelector.ResetToDefaultStyle;
begin
  inherited;
  Fill.Kind := gfkSolid;
  Stroke.Kind := gskSolid;
  Fill.Color := gcWhite;
  Stroke.Color := gcSilver;

  Appearance.Fill.Color := Lighter(gcLightgray, 50);
  Appearance.FillHover.Color := Lighter(gcLightslategray, 50);
  Appearance.FillDown.Color := Lighter(gcSlategray, 50);
  Appearance.FillSelected.Color := Lighter(gcSlategray, 50);
  Appearance.FillDisabled.Color := Lighter(gcGray, 50);

  Appearance.Stroke.Color := gcDarkgray;
  Appearance.StrokeHover.Color := gcLightslategray;
  Appearance.StrokeDown.Color := gcSlategray;
  Appearance.StrokeSelected.Color := gcDarkslategray;
  Appearance.StrokeDisabled.Color := gcDarkgray;

  Appearance.Font.Color := gcBlack;

  Appearance.Fill.Kind := gfkSolid;
  Appearance.FillHover.Kind := gfkSolid;
  Appearance.FillDown.Kind := gfkSolid;
  Appearance.FillSelected.Kind := gfkSolid;
  Appearance.FillDisabled.Kind := gfkSolid;

  Appearance.Stroke.Kind := gskSolid;
  Appearance.StrokeHover.Kind := gskSolid;
  Appearance.StrokeDown.Kind := gskSolid;
  Appearance.StrokeSelected.Kind := gskSolid;
  Appearance.StrokeDisabled.Kind := gskSolid;

  Appearance.SeparatorStroke.Kind := gskSolid;
end;

procedure TAdvChartCustomSelector.UpdateCalculations;
begin

end;

procedure TAdvChartCustomSelector.UpdateControlAfterResize;
begin
  inherited;
  CalculateItems;
end;

function TAdvChartCustomSelector.GetDisplayItem(AItemIndex: Integer): TAdvChartCustomSelectorDisplayItem;
var
  I: Integer;
  it: TAdvChartCustomSelectorItem;
begin
  Result.Rect := RectF(0, 0, 0, 0);
  Result.Item := nil;
  Result.PageIndex := -1;
  Result.Row := -1;
  Result.Column := -1;
  Result.ColumnSpan := -1;
  Result.RowSpan := -1;
  for I := 0 to FDisplayList.Count - 1 do
  begin
    it := FDisplayList[I].Item;
    if Assigned(it) and (it.Index = AItemIndex) then
    begin
      Result := FDisplayList[I];
      Break;
    end;
  end;
end;

function TAdvChartCustomSelector.GetDocURL: string;
begin
  Result := TAdvChartBaseDocURL + 'tmsfncuipack/components/' + LowerCase(ClassName);
end;

procedure TAdvChartCustomSelector.SetAppearance(
  const Value: TAdvChartCustomSelectorAppearance);
begin
  FAppearance.Assign(Value);
end;

procedure TAdvChartCustomSelector.SetColumns(const Value: Integer);
begin
  if FColumns <> Value then
  begin
    FColumns := Value;
    UpdateCalculations;
    CalculateItems;
  end;
end;

procedure TAdvChartCustomSelector.SetItems(const Value: TAdvChartCustomSelectorItems);
begin
  FItems.Assign(Value);
end;

procedure TAdvChartCustomSelector.SetRows(const Value: Integer);
begin
  if FRows <> Value then
  begin
    FRows := Value;
    UpdateCalculations;
    CalculateItems;
  end;
end;

procedure TAdvChartCustomSelector.SetSelectedItemIndex(const Value: Integer);
begin
  if FSelectedItemIndex <> Value then
  begin
    FSelectedItemIndex := Value;
    FFocusedItemIndex := Value;
    InvalidateItems;
  end;
end;

function TAdvChartCustomSelector.XYToItem(X, Y: Single): Integer;
var
  I: Integer;
  it: TAdvChartCustomSelectorItem;
begin
  Result := -1;
  for I := 0 to FDisplayList.Count - 1 do
  begin
    if PtInRectEx(FDisplayList[I].Rect, PointF(X, Y)) then
    begin
      it := FDisplayList[I].Item;
      if Assigned(it) and it.Enabled and not it.Separator then
      begin
        Result := it.Index;
        Break;
      end;
    end;
  end;
end;

{ TAdvChartCustomSelectorItem }

procedure TAdvChartCustomSelectorItem.Assign(Source: TPersistent);
begin
  if Source is TAdvChartCustomSelectorItem then
  begin
    FRowSpan := (Source as TAdvChartCustomSelectorItem).RowSpan;
    FColumnSpan := (Source as TAdvChartCustomSelectorItem).ColumnSpan;
    FVisible := (Source as TAdvChartCustomSelectorItem).Visible;
    FText := (Source as TAdvChartCustomSelectorItem).Text;
    FEnabled := (Source as TAdvChartCustomSelectorItem).Enabled;
    FSeparator := (Source as TAdvChartCustomSelectorItem).Separator;
    FSeparatorHeight := (Source as TAdvChartCustomSelectorItem).SeparatorHeight;
    FMargins.Assign((Source as TAdvChartCustomSelectorItem).Margins);
    FCanDeselect := (Source as TAdvChartCustomSelectorItem).CanDeselect;
    FCanSelect := (Source as TAdvChartCustomSelectorItem).CanSelect;
    FHint := (Source as TAdvChartCustomSelectorItem).Hint;
  end;
end;

constructor TAdvChartCustomSelectorItem.Create(Collection: TCollection);
begin
  inherited;
  if Assigned(Collection) then
    FOwner := (Collection as TAdvChartCustomSelectorItems).FOwner;
  FSeparator := False;
  FColumnSpan := 1;
  FCanDeselect := True;
  FCanSelect := True;
  FRowSpan := 1;
  FMargins := TAdvMargins.Create;
  FMargins.OnChange := MarginsChanged;
  FEnabled := True;
  FSeparatorHeight := 5;
  FVisible := True;
  if Assigned(FOwner) then
    FOwner.CalculateItems;
end;

destructor TAdvChartCustomSelectorItem.Destroy;
begin
  FMargins.Free;
  inherited;
  if Assigned(FOwner) then
    FOwner.CalculateItems;
end;

function TAdvChartCustomSelectorItem.IsSeparatorHeightStored: Boolean;
begin
  Result := SeparatorHeight <> 5;
end;

procedure TAdvChartCustomSelectorItem.MarginsChanged(Sender: TObject);
begin
  FOwner.CalculateItems;
end;

procedure TAdvChartCustomSelectorItem.SetCanDeselect(const Value: Boolean);
begin
  FCanDeselect := Value;
end;

procedure TAdvChartCustomSelectorItem.SetCanSelect(const Value: Boolean);
begin
  FCanSelect := Value;
end;

procedure TAdvChartCustomSelectorItem.SetColumnSpan(const Value: Integer);
begin
  if FColumnSpan <> Value then
  begin
    FColumnSpan := Value;
    FOwner.CalculateItems;
  end;
end;

procedure TAdvChartCustomSelectorItem.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    FOwner.InvalidateItems;
  end;
end;

procedure TAdvChartCustomSelectorItem.SetHorizontalTextAlign(
  const Value: TAdvChartGraphicsTextAlign);
begin
  if FHorizontalTextAlign <> Value then
  begin
    FHorizontalTextAlign := Value;
    FOwner.InvalidateItems;
  end;
end;

procedure TAdvChartCustomSelectorItem.SetMargins(const Value: TAdvMargins);
begin
  FMargins.Assign(Value);
end;

procedure TAdvChartCustomSelectorItem.SetRowSpan(const Value: Integer);
begin
  if FRowSpan <> Value then
  begin
    FRowSpan := Value;
    FOwner.CalculateItems;
  end;
end;

procedure TAdvChartCustomSelectorItem.SetSeparator(const Value: Boolean);
begin
  if FSeparator <> Value then
  begin
    FSeparator := Value;
    FOwner.CalculateItems;
  end;
end;

procedure TAdvChartCustomSelectorItem.SetSeparatorHeight(const Value: Single);
begin
  if FSeparatorHeight <> Value then
  begin
    FSeparatorHeight := Value;
    FOwner.InvalidateItems;
  end;
end;

procedure TAdvChartCustomSelectorItem.SetText(const Value: String);
begin
  if FText <> Value then
  begin
    FText := Value;
    FOwner.InvalidateItems;
  end;
end;

procedure TAdvChartCustomSelectorItem.SetVerticalTextAlign(
  const Value: TAdvChartGraphicsTextAlign);
begin
  if FVerticalTextAlign <> Value then
  begin
    FVerticalTextAlign := Value;
    FOwner.InvalidateItems;
  end;
end;

procedure TAdvChartCustomSelectorItem.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    FOwner.CalculateItems;
  end;
end;

function TAdvChartCustomSelectorItem.State: TAdvChartCustomSelectorItemState;
begin
  Result := isNormal;
  if not Separator then
  begin
    if Enabled then
    begin
      if Index = FOwner.FDownItemIndex then
        Result := isDown
      else if Index = FOwner.FHoveredItemIndex then
        Result := isHover
      else if Index = FOwner.FSelectedItemIndex then
        Result := isSelected
    end
    else
      Result := isDisabled;
  end;
end;

{ TAdvChartCustomSelectorItems }

function TAdvChartCustomSelectorItems.Add: TAdvChartCustomSelectorItem;
begin
  Result := TAdvChartCustomSelectorItem(inherited Add);
end;

constructor TAdvChartCustomSelectorItems.Create(AOwner: TAdvChartCustomSelector);
begin
  inherited Create(AOwner, CreateItemClass);
  FOwner := AOwner;
end;

function TAdvChartCustomSelectorItems.CreateItemClass: TCollectionItemClass;
begin
  Result := TAdvChartCustomSelectorItem;
end;

function TAdvChartCustomSelectorItems.GetItem(
  Index: Integer): TAdvChartCustomSelectorItem;
begin
  Result := TAdvChartCustomSelectorItem(inherited Items[Index]);
end;

function TAdvChartCustomSelectorItems.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TAdvChartCustomSelectorItems.Insert(
  Index: Integer): TAdvChartCustomSelectorItem;
begin
  Result := TAdvChartCustomSelectorItem(inherited Insert(Index));
end;

procedure TAdvChartCustomSelectorItems.SetItem(Index: Integer;
  const Value: TAdvChartCustomSelectorItem);
begin
  inherited Items[Index] := Value;
end;

{ TAdvChartCustomSelectorAppearance }

procedure TAdvChartCustomSelectorAppearance.Assign(Source: TPersistent);
begin
  if Source is TAdvChartCustomSelectorAppearance then
  begin
    FFill.Assign((Source as TAdvChartCustomSelectorAppearance).Fill);
    FFillHover.Assign((Source as TAdvChartCustomSelectorAppearance).FillHover);
    FFillSelected.Assign((Source as TAdvChartCustomSelectorAppearance).FillSelected);
    FFillDisabled.Assign((Source as TAdvChartCustomSelectorAppearance).FillDisabled);
    FFillDown.Assign((Source as TAdvChartCustomSelectorAppearance).FillDown);
    FStroke.Assign((Source as TAdvChartCustomSelectorAppearance).Stroke);
    FStrokeHover.Assign((Source as TAdvChartCustomSelectorAppearance).StrokeHover);
    FStrokeSelected.Assign((Source as TAdvChartCustomSelectorAppearance).StrokeSelected);
    FStrokeDown.Assign((Source as TAdvChartCustomSelectorAppearance).StrokeDown);
    FStrokeDisabled.Assign((Source as TAdvChartCustomSelectorAppearance).StrokeDisabled);
    FVerticalSpacing := (Source as TAdvChartCustomSelectorAppearance).VerticalSpacing;
    FHorizontalSpacing := (Source as TAdvChartCustomSelectorAppearance).HorizontalSpacing;
    FSeparatorStroke.Assign((Source as TAdvChartCustomSelectorAppearance).SeparatorStroke);
    FFont.AssignSource((Source as TAdvChartCustomSelectorAppearance).Font);
  end;
end;

procedure TAdvChartCustomSelectorAppearance.Changed;
begin
  FOwner.CalculateItems;
end;

constructor TAdvChartCustomSelectorAppearance.Create(AOwner: TAdvChartCustomSelector);
begin
  FOwner := AOwner;
  FFill := TAdvChartGraphicsFill.Create;
  FFill.Color := Lighter(gcLightgray, 50);
  FFillHover := TAdvChartGraphicsFill.Create;
  FFillHover.Color := Lighter(gcLightslategray, 50);
  FFillDown := TAdvChartGraphicsFill.Create;
  FFillDown.Color := Lighter(gcSlategray, 50);
  FFillSelected := TAdvChartGraphicsFill.Create;
  FFillSelected.Color := Lighter(gcSlategray, 50);
  FFillDisabled := TAdvChartGraphicsFill.Create;
  FFillDisabled.Color := Lighter(gcGray, 50);

  FStroke := TAdvChartGraphicsStroke.Create;
  FStroke.Color := gcDarkgray;
  FStrokeHover := TAdvChartGraphicsStroke.Create;
  FStrokeHover.Color := gcLightslategray;
  FStrokeDown := TAdvChartGraphicsStroke.Create;
  FStrokeDown.Color := gcSlategray;
  FStrokeSelected := TAdvChartGraphicsStroke.Create;
  FStrokeSelected.Color := gcDarkslategray;
  FStrokeDisabled := TAdvChartGraphicsStroke.Create;
  FStrokeDisabled.Color := gcDarkgray;

  FSeparatorStroke := TAdvChartGraphicsStroke.Create;
  FSeparatorStroke.Color := gcDarkGray;

  FFont := TAdvChartGraphicsFont.Create;
  FFont.OnChanged := FontChanged;

  FSeparatorStroke.OnChanged := StrokeChanged;
  FFont.OnChanged := FontChanged;

  FFill.OnChanged := FillChanged;
  FFillDown.OnChanged := FillChanged;
  FFillHover.OnChanged := FillChanged;
  FFillSelected.OnChanged := FillChanged;
  FFillDisabled.OnChanged := FillChanged;

  FStroke.OnChanged := StrokeChanged;
  FStrokeHover.OnChanged := StrokeChanged;
  FStrokeDown.OnChanged := StrokeChanged;
  FStrokeDisabled.OnChanged := StrokeChanged;
  FStrokeSelected.OnChanged := StrokeChanged;

  FHorizontalSpacing := 4;
  FVerticalSpacing := 4;
end;

destructor TAdvChartCustomSelectorAppearance.Destroy;
begin
  FFont.Free;
  FFill.Free;
  FFillDown.Free;
  FFillSelected.Free;
  FFillHover.Free;
  FFillDisabled.Free;
  FSeparatorStroke.Free;
  FStroke.Free;
  FStrokeDown.Free;
  FStrokeSelected.Free;
  FStrokeHover.Free;
  FStrokeDisabled.Free;
  inherited;
end;

procedure TAdvChartCustomSelectorAppearance.FillChanged(Sender: TObject);
begin
  FOwner.InvalidateItems;
end;

procedure TAdvChartCustomSelectorAppearance.FontChanged(Sender: TObject);
begin
  FOwner.InvalidateItems;
end;

function TAdvChartCustomSelectorAppearance.IsHorizontalSpacingStored: Boolean;
begin
  Result := HorizontalSpacing <> 4;
end;

function TAdvChartCustomSelectorAppearance.IsVerticalSpacingStored: Boolean;
begin
  Result := VerticalSpacing <> 4;
end;

procedure TAdvChartCustomSelectorAppearance.SetFill(const Value: TAdvChartGraphicsFill);
begin
  FFill.Assign(Value);
end;

procedure TAdvChartCustomSelectorAppearance.SetFillDisabled(const Value: TAdvChartGraphicsFill);
begin
  FFillDisabled.Assign(Value);
end;

procedure TAdvChartCustomSelectorAppearance.SetFillDown(const Value: TAdvChartGraphicsFill);
begin
  FFillDown.Assign(Value);
end;

procedure TAdvChartCustomSelectorAppearance.SetFillHover(const Value: TAdvChartGraphicsFill);
begin
  FFillHover.Assign(Value);
end;

procedure TAdvChartCustomSelectorAppearance.SetFillSelected(const Value: TAdvChartGraphicsFill);
begin
  FFillSelected.Assign(Value);
end;

procedure TAdvChartCustomSelectorAppearance.SetFont(const Value: TAdvChartGraphicsFont);
begin
  FFont.AssignSource(Value);
end;

procedure TAdvChartCustomSelectorAppearance.SetHorizontalSpacing(
  const Value: Single);
begin
  if FHorizontalSpacing <> Value then
  begin
    FHorizontalSpacing := Value;
    Changed;
  end;
end;

procedure TAdvChartCustomSelectorAppearance.SetSeparatorStroke(
  const Value: TAdvChartGraphicsStroke);
begin
  FSeparatorStroke.Assign(Value);
end;

procedure TAdvChartCustomSelectorAppearance.SetStroke(const Value: TAdvChartGraphicsStroke);
begin
  FStroke.Assign(Value);
end;

procedure TAdvChartCustomSelectorAppearance.SetStrokeDisabled(
  const Value: TAdvChartGraphicsStroke);
begin
  FStrokeDisabled.Assign(Value);
end;

procedure TAdvChartCustomSelectorAppearance.SetStrokeDown(
  const Value: TAdvChartGraphicsStroke);
begin
  FStrokeDown.Assign(Value);
end;

procedure TAdvChartCustomSelectorAppearance.SetStrokeHover(
  const Value: TAdvChartGraphicsStroke);
begin
  FStrokeHover.Assign(Value);
end;

procedure TAdvChartCustomSelectorAppearance.SetStrokeSelected(
  const Value: TAdvChartGraphicsStroke);
begin
  FStrokeSelected.Assign(Value);
end;

procedure TAdvChartCustomSelectorAppearance.SetVerticalSpacing(const Value: Single);
begin
  if FVerticalSpacing <> Value then
  begin
    FVerticalSpacing := Value;
    Changed;
  end;
end;

procedure TAdvChartCustomSelectorAppearance.StrokeChanged(Sender: TObject);
begin
  FOwner.InvalidateItems;
end;

{ TAdvChartGraphicsPathPoint }

{$IFDEF LCLLIB}
class operator TAdvChartCustomSelectorDisplayItem.=(z1, z2: TAdvChartCustomSelectorDisplayItem)b: boolean;
begin
  Result := z1 = z2;
end;

class operator TAdvChartCustomSelectorPositionItem.=(z1, z2: TAdvChartCustomSelectorPositionItem)b: boolean;
begin
  Result := z1 = z2;
end;
{$ENDIF}

{$IFDEF WEBLIB}
function TAdvChartCustomSelectorDisplayList.GetItem(Index: Integer): TAdvChartCustomSelectorDisplayItem;
begin
  Result := TAdvChartCustomSelectorDisplayItem(inherited Items[Index]);
end;

procedure TAdvChartCustomSelectorDisplayList.SetItem(Index: Integer; const Value: TAdvChartCustomSelectorDisplayItem);
var
  v: TAdvChartCustomSelectorDisplayItem;
begin
  v := Value;
  inherited Items[Index] := v;
end;
{$ENDIF}

initialization
  RegisterClass(TAdvChartCustomSelector);

end.
