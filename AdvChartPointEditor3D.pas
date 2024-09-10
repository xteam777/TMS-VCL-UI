{***************************************************************************}
{ TAdvChartPointEditor component                                            }
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

unit AdvChartPointEditor3D;

{$I TMSDEFS.INC}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdvChartView3D, StdCtrls, Mask, AdvChartSpin,
  AdvChartSelectors, ExtCtrls, ComCtrls, Buttons, ExtDlgs, CheckLst
  {$IFDEF DELPHIXE3_LVL}
  , UITypes
  {$ENDIF}
  ;


type
  TSaveMode = (notsaving, saving, cancel);

  TAdvChartPointEditorForm3D = class(TForm)
    Panel5: TPanel;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    Panel3: TPanel;
    Panel4: TPanel;
    Button15: TButton;
    Button16: TButton;
    SpeedButton3: TSpeedButton;
    Button2: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    AdvChartSpinEdit1: TAdvChartSpinEdit;
    AdvChartSpinEdit10: TAdvChartSpinEdit;
    Label13: TLabel;
    Label10: TLabel;
    AdvChartSpinEdit11: TAdvChartSpinEdit;
    Label2: TLabel;
    AdvChartSpinEdit2: TAdvChartSpinEdit;
    ListBox1: TCheckListBox;
    GroupBox3: TGroupBox;
    Panel1: TPanel;
    Image1: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
    Button13: TButton;
    Label3: TLabel;
    AdvChartSpinEdit3: TAdvChartSpinEdit;
    AdvColorSelector8: TAdvChartColorSelector;
    Label32: TLabel;
    ColorDialog1: TColorDialog;
    procedure ListBox1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AdvChartSpinEdit1Change(Sender: TObject);
    procedure AdvChartSpinEdit11Change(Sender: TObject);
    procedure AdvChartSpinEdit2Change(Sender: TObject);
    procedure AdvChartSpinEdit10Change(Sender: TObject);
    procedure ListBox1ClickCheck(Sender: TObject);
    procedure ListBox1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ListBox1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure AdvChartSpinEdit3Change(Sender: TObject);
    procedure AdvColorSelector8Select(Sender: TObject; Index: Integer;
      Item: TAdvChartSelectorItem);
  private
    FChartView: TAdvChartView3D;
    FChartItems: TChartItems3D;
    Mode: TSaveMode;
    FApply: TNotifyEvent;
    FAllowR: Boolean;
    { Private declarations }
  public
    property Chartview: TAdvChartView3D read FChartview write FChartView;
    property ChartItems: TChartItems3D read FChartItems write FChartItems;
    procedure Init;
    procedure InitListBox;
    procedure SaveChanges;
    property Apply: TNotifyEvent read FApply write FApply;
    { Public declarations }
  end;

  {$IFDEF DELPHIXE2_LVL}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  {$ENDIF}
  TAdvChartPointEditorDialog3D = class(TCommonDialog)
  private
    FForm: TAdvChartPointEditorForm3D;
    FChartView: TAdvChartview3D;
    FChartSerieIndex: integer;
    FCaption: string;
    FAllowPointNameChange: Boolean;
    FAllowPointAdding: Boolean;
    FAllowPointRemoving: Boolean;
    FAllowPointReorder: Boolean;
    procedure SetChartView(const Value: TAdvChartView3D);
    procedure SetSerieIndex(const Value: integer);
  protected
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;  
  public
    constructor Create(AOwner: TComponent); override;
    function Execute: Boolean; override;
    property Form: TAdvChartPointEditorForm3D read FForm;
  published
    property Caption: string read FCaption write FCaption;
    property SerieIndex: integer read FChartSerieIndex write SetSerieIndex;
    property ChartView: TAdvChartView3D read FChartView write SetChartView;
    property AllowPointReorder: Boolean read FAllowPointReorder write FAllowPointReorder default true;
    property AllowPointNameChange: Boolean read FAllowPointNameChange write FAllowPointNameChange default true;
    property AllowPointRemoving: Boolean read FAllowPointRemoving write FAllowPointRemoving default true;
    property AllowPointAdding: Boolean read FAllowPointAdding write FAllowPointAdding default true;
  end;

var
  AdvChartPointEditorForm3D: TAdvChartPointEditorForm3D;
  col: TChartItems3D;
  it: TChartItem3D;
  StartingPoint: TPoint;

implementation

{$R *.dfm}

{ TAdvChartPointEditorDialog3D }

constructor TAdvChartPointEditorDialog3D.Create(AOwner: TComponent);
begin
  inherited;
  FAllowPointReorder := True;
  FAllowPointRemoving := true;
  FAllowPointNameChange := true;
  FAllowPointAdding := true;
end;

function TAdvChartPointEditorDialog3D.Execute: Boolean;
begin
  if not Assigned(FChartView) then
  begin
    raise Exception.Create('The dialog does not have AdvChartView3D Component assigned.');
    Result := False;
    Exit;
  end;

  FForm := TAdvChartPointEditorForm3D.Create(Application);
  FForm.Chartview := FChartView;
  FForm.ChartItems := FChartView.Series[SerieIndex].Items;
  FForm.FAllowR := AllowPointReorder;
  FForm.SpeedButton3.Enabled := AllowPointNameChange;
  FForm.SpeedButton2.Enabled := AllowPointAdding;
  FForm.SpeedButton1.Enabled := AllowPointRemoving;
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

procedure TAdvChartPointEditorDialog3D.Notification(AComponent: TComponent;
  AOperation: TOperation);
begin
  inherited;
  if (AComponent = FChartView) and (AOperation = opRemove) then
    FChartView := nil;
end;

procedure TAdvChartPointEditorDialog3D.SetChartView(
  const Value: TAdvChartView3D);
begin
  FChartView := Value;
end;

procedure TAdvChartPointEditorDialog3D.SetSerieIndex(const Value: integer);
begin
  if not Assigned(FChartView)  then
  begin
    FChartSerieIndex := Value;
    Exit;
  end
  else
  begin
    if (Value <= FChartView.Series.Count - 1) and (value >= 0) then
      FChartSerieIndex := Value
    else
      FChartSerieIndex := FChartView.Series.Count - 1;
  end;
end;

procedure TAdvChartPointEditorForm3D.AdvChartSpinEdit10Change(Sender: TObject);
begin
  it.Extraction := AdvChartSpinEdit10.FloatValue;
end;

procedure TAdvChartPointEditorForm3D.AdvChartSpinEdit11Change(Sender: TObject);
begin
  it.Transparency := AdvChartSpinEdit11.Value;
end;

procedure TAdvChartPointEditorForm3D.AdvChartSpinEdit1Change(Sender: TObject);
begin
  it.Value := AdvChartSpinEdit1.FloatValue;
end;

procedure TAdvChartPointEditorForm3D.AdvChartSpinEdit2Change(Sender: TObject);
begin
  it.Elevation := AdvChartSpinEdit2.FloatValue;
end;

procedure TAdvChartPointEditorForm3D.AdvChartSpinEdit3Change(Sender: TObject);
begin
  it.Expansion := AdvChartSpinEdit3.FloatValue;
end;

procedure TAdvChartPointEditorForm3D.AdvColorSelector8Select(Sender: TObject;
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

  it.Color := AdvColorSelector8.SelectedColor;
end;

procedure TAdvChartPointEditorForm3D.Button13Click(Sender: TObject);
begin
  it.Image.Assign(nil);
  Image1.Picture.Assign(nil);
end;

procedure TAdvChartPointEditorForm3D.Button15Click(Sender: TObject);
begin
  Mode := saving;
  SaveChanges;
  Self.Close;
  ModalResult := mrok;
end;

procedure TAdvChartPointEditorForm3D.Button16Click(Sender: TObject);
begin
  Mode := cancel;
  Self.Close;
  ModalResult := mrCancel;
end;

procedure TAdvChartPointEditorForm3D.Button2Click(Sender: TObject);
begin
  SaveChanges;
  if Assigned(FApply) then
    FApply(Self);
end;

procedure TAdvChartPointEditorForm3D.FormClose(Sender: TObject;
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

procedure TAdvChartPointEditorForm3D.FormKeyUp(Sender: TObject;
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
      if MessageDlg('Do you want to remove the selected annotation?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        col[Listbox1.ItemIndex].Free;
        InitListBox;
      end;
    end;
  end;
end;

procedure TAdvChartPointEditorForm3D.Image1Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    it.Image.Assign(Image1.Picture);
  end;
end;

procedure TAdvChartPointEditorForm3D.Init;
var
  i: integer;
begin
  PageControl1.ActivePageIndex := 0;
  col := TChartItems3D.Create(TChartSerie3D(ChartItems.GetSerie));
  ListBox1.Items.Clear;
  for i := 0 to ChartItems.Count - 1 do
  begin
    col.Add;
    col[i].Assign(ChartItems[i]);
  end;

  InitListBox;
end;

procedure TAdvChartPointEditorForm3D.InitListBox;
var
  i: integer;
begin
  ListBox1.Items.Clear;
  for i := 0 to Col.Count - 1 do
  begin
    listbox1.Items.Add(inttostr(i) + ' : ' + col[i].Caption);
    listbox1.Checked[ListBox1.Items.Count - 1] := col[i].Visible;
  end;

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

procedure TAdvChartPointEditorForm3D.ListBox1Click(Sender: TObject);
begin
  if listbox1.ItemIndex >= 0 then
  begin
    it := Col[listbox1.ItemIndex];
    PageControl1.Enabled := not (it = nil);
    PageControl1.Visible := not (it = nil);
    Panel3.Visible := false;

    AdvChartSpinEdit3.FloatValue := it.Expansion;
    AdvChartSpinEdit1.FloatValue := it.Value;
    AdvChartSpinEdit10.FloatValue := it.Extraction;
    AdvChartSpinEdit2.FloatValue := it.Elevation;
    AdvChartSpinEdit11.Value := it.Transparency;

    AdvColorSelector8.SelectedColor := it.Color;

    Image1.Picture.Assign(it.Image);
  end;
end;

procedure TAdvChartPointEditorForm3D.ListBox1ClickCheck(Sender: TObject);
begin
  if (ListBox1.ItemIndex >= 0) and (ListBox1.ItemIndex <= ListBox1.Items.Count - 1) then
    Col[ListBox1.ItemIndex].Visible := ListBox1.Checked[ListBox1.ItemIndex];
end;

procedure TAdvChartPointEditorForm3D.ListBox1DragDrop(Sender, Source: TObject;
  X, Y: Integer);
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

procedure TAdvChartPointEditorForm3D.ListBox1DragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := (Source = ListBox1) and FAllowR;
end;

procedure TAdvChartPointEditorForm3D.ListBox1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  StartingPoint.X := X;
  StartingPoint.Y := Y;
end;

procedure TAdvChartPointEditorForm3D.SaveChanges;
var
  i: integer;
begin
  Chartview.BeginUpdate;
  ChartItems.Clear;
  for I := 0 to col.Count - 1 do
  begin
    ChartItems.Add;
    ChartItems[I].Assign(col[I]);
  end;
  Chartview.EndUpdate;
end;

procedure TAdvChartPointEditorForm3D.SpeedButton1Click(Sender: TObject);
begin
  if listbox1.ItemIndex >= 0 then
  begin
    col[Listbox1.ItemIndex].Free;
    InitListBox;
  end;
end;

procedure TAdvChartPointEditorForm3D.SpeedButton2Click(Sender: TObject);
begin
  Col.Add;
  InitListBox;
end;

procedure TAdvChartPointEditorForm3D.SpeedButton3Click(Sender: TObject);
var
  s: String;
begin
  if ListBox1.Items.Count <> 0 then
  begin
    InputQuery('Annotation name', 'Please enter new name',s);
    if s <> '' then
    begin
      it.Caption := s;
      ListBox1.Items[it.Index] := s;
    end;
  end;
end;


end.
