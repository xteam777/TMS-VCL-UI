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

unit AdvCToolBarPopup;

{$I TMSDEFS.inc}

{$IFDEF CMNLIB}
{$DEFINE CMNWEBLIB}
{$ENDIF}
{$IFDEF WEBLIB}
{$DEFINE CMNWEBLIB}
{$ENDIF}

interface

uses
  Classes, AdvChartPopup, AdvChartToolBar, AdvChartTypes
  {$IFDEF FMXLIB}
  ,FMX.Types
  {$ENDIF}
  ;

const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 0; // Minor version nr.
  REL_VER = 0; // Release nr.
  BLD_VER = 0; // Build nr.

  // version history
  // v1.0.0.0 : first release

type
  TAdvChartCustomToolBarPopup = class;

  TAdvCToolBarPopupButton = class(TCollectionItem)
  private
    FOwner: TAdvChartCustomToolBarPopup;
    FButton: TAdvChartToolBarButton;
    FText: String;
    FDataBoolean: Boolean;
    FTag: Integer;
    FDataString: String;
    FDataObject: TObject;
    FDataInteger: NativeInt;
    FWidth: Single;
    FHeight: Single;
    FEnabled: Boolean;
    FVisible: Boolean;
    FTop: Single;
    FLeft: Single;
    FLastElement: Boolean;
    FBitmap: TAdvChartBitmap;
    FDataPointer: Pointer;
    procedure SetText(const Value: string);
    procedure SetHeight(const Value: Single);
    procedure SetWidth(const Value: Single);
    function IsHeightStored: Boolean;
    function IsWidthStored: Boolean;
    procedure SetEnabled(const Value: Boolean);
    procedure SetVisible(const Value: Boolean);
    function IsLeftStored: Boolean;
    function IsTopStored: Boolean;
    procedure SetLeft(const Value: Single);
    procedure SetTop(const Value: Single);
    procedure SetLastElement(const Value: Boolean);
    procedure SetBitmap(const Value: TAdvChartBitmap);
  protected
    procedure BitmapChanged(Sender: TObject);
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
    destructor Destroy; override;
    property Button: TAdvChartToolBarButton read FButton;
    property DataPointer: Pointer read FDataPointer write FDataPointer;
    property DataBoolean: Boolean read FDataBoolean write FDataBoolean;
    property DataObject: TObject read FDataObject write FDataObject;
    property DataString: String read FDataString write FDataString;
    property DataInteger: NativeInt read FDataInteger write FDataInteger;
  published
    property Text: String read FText write SetText;
    property Tag: Integer read FTag write FTag;
    property Left: Single read FLeft write SetLeft stored IsLeftStored nodefault;
    property Top: Single read FTop write SetTop stored IsTopStored nodefault;
    property Width: Single read FWidth write SetWidth stored IsWidthStored nodefault;
    property Height: Single read FHeight write SetHeight stored IsHeightStored nodefault;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property Visible: Boolean read FVisible write SetVisible default True;
    property LastElement: Boolean read FLastElement write SetLastElement default False;
    property Bitmap: TAdvChartBitmap read FBitmap write SetBitmap;
  end;

  {$IFDEF WEBLIB}
  TAdvCToolBarPopupButtons = class(TAdvOwnedCollection)
  {$ENDIF}
  {$IFNDEF WEBLIB}
  TAdvCToolBarPopupButtons = class({$IFDEF LCLLIB}specialize {$ENDIF}TAdvOwnedCollection<TAdvCToolBarPopupButton>)
  {$ENDIF}
  private
    FOwner: TAdvChartCustomToolBarPopup;
    function GetItem(Index: Integer): TAdvCToolBarPopupButton;
    procedure SetItem(Index: Integer; const Value: TAdvCToolBarPopupButton);
  protected
    function CreateItemClass: TCollectionItemClass; virtual;
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TAdvChartCustomToolBarPopup); virtual;
    property Items[Index: Integer]: TAdvCToolBarPopupButton read GetItem write SetItem; default;
    function Add: TAdvCToolBarPopupButton;
    function Insert(Index: Integer): TAdvCToolBarPopupButton;
  end;

  TAdvCToolBarPopupButtonClickEvent = procedure(Sender: TObject; AButton: TAdvCToolBarPopupButton) of object;

  TAdvChartCustomToolBarPopup = class(TAdvChartCustomNonFocusablePopup)
  private
    FActivate: Boolean;
    FToolBar: TAdvChartToolBar;
    FButtons: TAdvCToolBarPopupButtons;
    FButtonClick: TAdvCToolBarPopupButtonClickEvent;
    FOnDeactivate: TNotifyEvent;
    FOnActivate: TNotifyEvent;
    procedure SetButtons(const Value: TAdvCToolBarPopupButtons);
    function GetAutoAlign: Boolean;
    procedure SetAutoAlign(const Value: Boolean);
    function GetDragGrip: Boolean;
    procedure SetDragGrip(const Value: Boolean);
  protected
    function GetVersion: String; override;
    function CreateToolBar: TAdvChartToolBar; virtual;
    function FindPopupButton(AButton: TAdvChartToolBarButton): TAdvCToolBarPopupButton; virtual;
    function GetInstance: NativeUInt; override;
    procedure SetAdaptToStyle(const Value: Boolean); override;
    procedure UpdateControls(Sender: TObject);
    procedure UpdateToolBar; virtual;
    procedure PrepareToolBar; virtual;
    procedure ActivatePopup;
    procedure DeactivatePopup;
    procedure DoClosePopup; override;
    procedure ToolBarClick(Sender: TObject);
    procedure ToolBarButtonClick(Sender: TObject);
    procedure DoDragGripMoving(Sender: TObject; ADeltaX: Double; ADeltaY: Double); virtual;
    property Buttons: TAdvCToolBarPopupButtons read FButtons write SetButtons;
    property OnButtonClick: TAdvCToolBarPopupButtonClickEvent read FButtonClick write FButtonClick;
    property AutoAlign: Boolean read GetAutoAlign write SetAutoAlign default True;
    property OnActivate: TNotifyEvent read FOnActivate write FOnActivate;
    property OnDeactivate: TNotifyEvent read FOnDeactivate write FOnDeactivate;
    property DragGrip: Boolean read GetDragGrip write SetDragGrip default False;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override;
    destructor Destroy; override;
    procedure Activate; virtual;
    procedure Deactivate; virtual;
    function DropDownActive: Boolean; virtual;
    function Activated: Boolean;
    property ToolBar: TAdvChartToolBar read FToolBar;
  end;

  {$IFNDEF LCLLIB}
  [ComponentPlatformsAttribute(TMSPlatforms)]
  {$ENDIF}
  TAdvCToolBarPopup = class(TAdvChartCustomToolBarPopup)
  protected
    procedure RegisterRuntimeClasses; override;
  published
    property AdaptToStyle;
    property OnButtonClick;
    property AutoAlign;
    property Buttons;
    property Placement;
    property PlacementRectangle;
    property PlacementControl;
    property OnActivate;
    property OnDeactivate;
    property Version;
    property DragGrip;
  end;

implementation

uses
  Forms, AdvChartUtils
  {$IFNDEF LCLLIB}
  ,Types
  {$ENDIF}
  ;

{$R 'AdvCToolBarPopup.res'}

type
  TAdvChartToolBarOpen = class(TAdvChartToolBar);

{ TAdvChartCustomToolBarPopup }

constructor TAdvChartCustomToolBarPopup.Create(AOwner: TComponent);
begin
  inherited;
  Placement := ppMouse;
  FButtons := TAdvCToolBarPopupButtons.Create(Self);
  FToolBar := CreateToolBar;
  if not (csDesigning in ComponentState) then
    FToolBar.Parent := Self;
  FToolBar.AutoAlign := True;
  FToolBar.OnClick := ToolBarClick;
  FToolBar.TabStop := False;
  FToolBar.AllowFocus := False;
  FToolBar.OptionsMenu.ShowButton := False;
  FToolBar.Appearance.DragGrip := False;
  FToolBar.OnDragGripMoving := DoDragGripMoving;
  FToolBar.AutoMoveToolBar := False;
  TAdvChartToolBarOpen(FToolBar).OnUpdateControls := UpdateControls;
  ContentControl := FToolBar;
end;

function TAdvChartCustomToolBarPopup.CreateToolBar: TAdvChartToolBar;
begin
  Result := TAdvChartToolBar.Create(Self)
end;

destructor TAdvChartCustomToolBarPopup.Destroy;
begin
  FButtons.Free;
  inherited;
end;

procedure TAdvChartCustomToolBarPopup.DoClosePopup;
begin
  inherited;
  {$IFDEF FNCLIB}
  {$IFNDEF LCLLIB}
  if Assigned(PopupForm) then
    PopupForm.DisposeOf;
  {$ENDIF}
  {$IFDEF LCLLIB}
  if Assigned(PopupForm) then
    PopupForm.Free;
  {$ENDIF}
  {$ELSE}
  if Assigned(PopupForm) then
    PopupForm.Free;
  {$ENDIF}
end;

procedure TAdvChartCustomToolBarPopup.DoDragGripMoving(Sender: TObject; ADeltaX,
  ADeltaY: Double);
begin
  if Assigned(PopupForm) then
  begin
    PopupForm.Left := PopupForm.Left - Round(ADeltaX);
    PopupForm.Top := PopupForm.Top - Round(ADeltaY);
  end;
end;

function TAdvChartCustomToolBarPopup.DropDownActive: Boolean;
begin
  Result := False;
  if Assigned(ToolBar) then
    Result := ToolBar.DropDownActive;
end;

function TAdvChartCustomToolBarPopup.FindPopupButton(
  AButton: TAdvChartToolBarButton): TAdvCToolBarPopupButton;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to FButtons.Count - 1 do
  begin
    if AButton = FButtons[I].FButton then
    begin
      Result := FButtons[I];
      Break;
    end;
  end;
end;

function TAdvChartCustomToolBarPopup.GetAutoAlign: Boolean;
begin
  Result := TAdvChartToolBarOpen(FToolBar).AutoAlign;
end;

function TAdvChartCustomToolBarPopup.GetDragGrip: Boolean;
begin
  Result := TAdvChartToolBarOpen(FToolBar).Appearance.DragGrip;
end;

function TAdvChartCustomToolBarPopup.GetInstance: NativeUInt;
begin
  Result := HInstance;
end;

function TAdvChartCustomToolBarPopup.GetVersion: String;
begin
  Result := GetVersionNumber(MAJ_VER, MIN_VER, REL_VER, BLD_VER);
end;

procedure TAdvChartCustomToolBarPopup.PrepareToolBar;
begin
  if Assigned(FToolBar) then
    FToolBar.AdaptToStyle := AdaptToStyle;
end;

procedure TAdvChartCustomToolBarPopup.SetAdaptToStyle(const Value: Boolean);
begin
  inherited;
  if Assigned(FToolBar) then
    FToolBar.AdaptToStyle := AdaptToStyle;
end;

procedure TAdvChartCustomToolBarPopup.SetAutoAlign(const Value: Boolean);
begin
  TAdvChartToolBarOpen(FToolBar).AutoAlign := Value;
end;

procedure TAdvChartCustomToolBarPopup.SetButtons(
  const Value: TAdvCToolBarPopupButtons);
begin
  FButtons.Assign(Value);
end;

procedure TAdvChartCustomToolBarPopup.SetDragGrip(const Value: Boolean);
begin
  TAdvChartToolBarOpen(FToolBar).Appearance.DragGrip := Value;
end;

procedure TAdvChartCustomToolBarPopup.ActivatePopup;
begin
  DoCreatePopup(False);
end;

procedure TAdvChartCustomToolBarPopup.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TAdvChartCustomToolBarPopup then
  begin
    FButtons.Assign((Source as TAdvChartCustomToolBarPopup).Buttons);
    AutoAlign := (Source as TAdvChartCustomToolBarPopup).AutoAlign;
    DragGrip := (Source as TAdvChartCustomToolBarPopup).DragGrip;
  end;
end;

procedure TAdvChartCustomToolBarPopup.ToolBarButtonClick(Sender: TObject);
begin
  if Assigned(OnButtonClick) then
    OnButtonClick(Self, FindPopupButton((Sender as TAdvChartToolBarButton)));
  ActivatePreviousWindow;
end;

procedure TAdvChartCustomToolBarPopup.ToolBarClick(Sender: TObject);
begin
  ActivatePreviousWindow;
end;

procedure TAdvChartCustomToolBarPopup.UpdateControls(Sender: TObject);
begin
  UpdateToolBar;
end;

procedure TAdvChartCustomToolBarPopup.UpdateToolBar;
begin
  if (csLoading in ComponentState) or (csDestroying in ComponentState) then
    Exit;

  DropDownWidth := FToolBar.Width;
  DropDownHeight := FToolBar.Height;
  {$IFDEF FMXLIB}
  if Assigned(PopupForm) then
    PopupForm.ApplyPlacement;
  {$ENDIF}
end;

procedure TAdvChartCustomToolBarPopup.Activate;
var
  {$IFDEF FMXLIB}
  frm: TCommonCustomForm;
  {$ENDIF}
  {$IFDEF CMNWEBLIB}
  frm: TForm;
  {$ENDIF}
begin
  if Activated then
    Deactivate;

  {$IFNDEF WEBLIB}
  frm := Screen.ActiveForm;
  if not Assigned(frm) then
    frm := Application.MainForm;
  {$ENDIF}

  if Assigned(ToolBar) then
  begin
    ToolBar.Parent := frm;
    ToolBar.Visible := False;
  end;

  PrepareToolBar;
  ActivatePopup;
  UpdateToolBar;
  FActivate := True;
  if Assigned(OnActivate) then
    OnActivate(Self);
end;

function TAdvChartCustomToolBarPopup.Activated: Boolean;
begin
  Result := HasPopupForm;
end;

procedure TAdvChartCustomToolBarPopup.Deactivate;
begin
  DeactivatePopup;
  FActivate := False;
  if Assigned(OnDeactivate) then
    OnDeactivate(Self);
end;

procedure TAdvChartCustomToolBarPopup.DeactivatePopup;
begin
  ClosePopup;
end;

{ TAdvCToolBarPopupButton }

procedure TAdvCToolBarPopupButton.Assign(Source: TPersistent);
begin
  if Source is TAdvCToolBarPopupButton then
  begin
    FText := (Source as TAdvCToolBarPopupButton).Text;
    FWidth := (Source as TAdvCToolBarPopupButton).Width;
    FHeight := (Source as TAdvCToolBarPopupButton).Height;
    FLeft := (Source as TAdvCToolBarPopupButton).Left;
    FTop := (Source as TAdvCToolBarPopupButton).Top;
    FEnabled := (Source as TAdvCToolBarPopupButton).Enabled;
    FVisible := (Source as TAdvCToolBarPopupButton).Visible;
    FBitmap.Assign((Source as TAdvCToolBarPopupButton).Bitmap);
    FLastElement := (Source as TAdvCToolBarPopupButton).LastElement;
  end;
end;

procedure TAdvCToolBarPopupButton.BitmapChanged(Sender: TObject);
begin
  if Assigned(FButton) and not IsBitmapEmpty(FBitmap) then
  begin
    FButton.Bitmaps.Clear;
    FButton.Bitmaps.AddBitmap(FBitmap);
  end;

  if Assigned(FOwner) then
    FOwner.UpdateToolBar;
end;

constructor TAdvCToolBarPopupButton.Create(Collection: TCollection);
begin
  inherited;
  if Assigned(Collection) then
    FOwner := (Collection as TAdvCToolBarPopupButtons).FOwner;

  FBitmap := TAdvChartBitmap.Create;
  FBitmap.OnChange := BitmapChanged;
  FWidth := -1;
  FHeight := -1;
  FTop := -1;
  FLeft := -1;
  FVisible := True;
  FEnabled := True;
  FLastElement := False;

  if Assigned(FOwner) and Assigned(FOwner.FToolBar) then
  begin
    FButton := TAdvChartToolBarButton.Create(FOwner.FToolBar);
    FButton.TabStop := False;
    FButton.AllowFocus := False;
    FButton.Parent := FOwner.FToolBar;
    FButton.OnClick := FOwner.ToolBarButtonClick;
  end;

  if Assigned(FOwner) then
  begin
    if Assigned(FOwner.FToolBar) then
      FOwner.FToolBar.AddCustomControl(FButton, Index);
    FOwner.UpdateToolBar;
  end;
end;

destructor TAdvCToolBarPopupButton.Destroy;
begin
  FBitmap.Free;
  inherited;
  if Assigned(FOwner) then
    FOwner.UpdateToolBar;
end;

function TAdvCToolBarPopupButton.IsHeightStored: Boolean;
begin
  Result := Height <> -1;
end;

function TAdvCToolBarPopupButton.IsLeftStored: Boolean;
begin
  Result := Left <> -1;
end;

function TAdvCToolBarPopupButton.IsTopStored: Boolean;
begin
  Result := Top <> -1;
end;

function TAdvCToolBarPopupButton.IsWidthStored: Boolean;
begin
  Result := Width <> -1;
end;

procedure TAdvCToolBarPopupButton.SetBitmap(const Value: TAdvChartBitmap);
begin
  if FBitmap <> Value then
  begin
    FBitmap.Assign(Value);
    if Assigned(FButton) and not IsBitmapEmpty(FBitmap) then
    begin
      FButton.Bitmaps.Clear;
      FButton.Bitmaps.AddBitmap(FBitmap);
    end;

    if Assigned(FOwner) then
      FOwner.UpdateToolBar;
  end;
end;

procedure TAdvCToolBarPopupButton.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    if Assigned(FButton) then
      FButton.Enabled := FEnabled;
    if Assigned(FOwner) then
      FOwner.UpdateToolBar;
  end;
end;

procedure TAdvCToolBarPopupButton.SetHeight(const Value: Single);
begin
  if FHeight <> Value then
  begin
    FHeight := Value;
    if Assigned(FButton) and (FHeight > -1) then
      FButton.Height := Round(FHeight);
    if Assigned(FOwner) then
      FOwner.UpdateToolBar;
  end;
end;

procedure TAdvCToolBarPopupButton.SetLastElement(const Value: Boolean);
begin
  if FLastElement <> Value then
  begin
    FLastElement := Value;
    if Assigned(FButton) then
      FButton.LastElement := FLastElement;
    if Assigned(FOwner) then
      FOwner.UpdateToolBar;
  end;
end;

procedure TAdvCToolBarPopupButton.SetLeft(const Value: Single);
begin
  if FLeft <> Value then
  begin
    FLeft := Value;
    if Assigned(FButton) and (FLeft > -1) then
      FButton.Left := Round(FLeft);
    if Assigned(FOwner) then
      FOwner.UpdateToolBar;
  end;
end;

procedure TAdvCToolBarPopupButton.SetText(const Value: String);
begin
  if FText <> Value then
  begin
    FText := Value;
    if Assigned(FButton) then
      FButton.Text := FText;
    if Assigned(FOwner) then
      FOwner.UpdateToolBar;
  end;
end;

procedure TAdvCToolBarPopupButton.SetTop(const Value: Single);
begin
  if FTop <> Value then
  begin
    FTop := Value;
    if Assigned(FButton) and (FTop > -1) then
      FButton.Top := Round(FTop);
    if Assigned(FOwner) then
      FOwner.UpdateToolBar;
  end;
end;

procedure TAdvCToolBarPopupButton.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    if Assigned(FButton) then
      FButton.Visible := FVisible;
    if Assigned(FOwner) then
      FOwner.UpdateToolBar;
  end;
end;

procedure TAdvCToolBarPopupButton.SetWidth(const Value: Single);
begin
  if FWidth <> Value then
  begin
    FWidth := Value;
    if Assigned(FButton) and (FWidth > -1) then
      FButton.Width := Round(FWidth);
    if Assigned(FOwner) then
      FOwner.UpdateToolBar;
  end;
end;

{ TAdvCToolBarPopupButtons }

function TAdvCToolBarPopupButtons.Add: TAdvCToolBarPopupButton;
begin
  Result := TAdvCToolBarPopupButton(inherited Add);
end;

constructor TAdvCToolBarPopupButtons.Create(AOwner: TAdvChartCustomToolBarPopup);
begin
  inherited Create(AOwner, CreateItemClass);
  FOwner := AOwner;
end;

function TAdvCToolBarPopupButtons.CreateItemClass: TCollectionItemClass;
begin
  Result := TAdvCToolBarPopupButton;
end;

function TAdvCToolBarPopupButtons.GetItem(
  Index: Integer): TAdvCToolBarPopupButton;
begin
  Result := TAdvCToolBarPopupButton(inherited Items[Index]);
end;

function TAdvCToolBarPopupButtons.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TAdvCToolBarPopupButtons.Insert(
  Index: Integer): TAdvCToolBarPopupButton;
begin
  Result := TAdvCToolBarPopupButton(inherited Insert(Index));
end;

procedure TAdvCToolBarPopupButtons.SetItem(Index: Integer;
  const Value: TAdvCToolBarPopupButton);
begin
  inherited Items[Index] := Value;
end;

{ TAdvCToolBarPopup }

procedure TAdvCToolBarPopup.RegisterRuntimeClasses;
begin
  inherited;
  RegisterClass(TAdvCToolBarPopup);
end;

end.
