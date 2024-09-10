{***************************************************************************}
{ TAdvChartLink component                                                   }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 2007 - 2015                                        }
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

{$I TMSDEFS.INC}

unit AdvChartLink;

interface

uses
  Classes, AdvChart, AdvChartView, AdvGrid, Graphics, Windows, Grids, SysUtils;

const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 1; // Minor version nr.
  REL_VER = 0; // Release nr.
  BLD_VER = 0; // Build nr.

  // version history
  // v1.0.0.0 : First release
  // v1.1.0.0 : New : support for XY scatter charts added
  //          : New : AutoXRange, XRangeFrom, XRangeTo properties added

type
  TGridDataType = (dtCellRange, dtFullRow, dtFullColumn, dtNormalRow, dtNormalColumn, dtNode, dtNone);

  TLegendTextType = (ltFirstFixedCell, ltFirstCell, ltCustom, ltNone);

  TGridData = class(TPersistent)
  private
    FLeft: Integer;
    FTop: Integer;
    FRight: Integer;
    FBottom: Integer;
    FDataType: TGridDataType;
    FColumn: Integer;
    FRow: Integer;
    FNodeLevel: Integer;
    FOnChange: TNotifyEvent;
    FLegendTextType: TLegendTextType;
    FLegendText: string;
    FXAxisType: TGridDataType;
    FXAxisRow: Integer;
    FXAxisColumn: Integer;
    procedure SetBottom(const Value: Integer);
    procedure SetColumn(const Value: Integer);
    procedure SetDataType(const Value: TGridDataType);
    procedure SetLeft(const Value: Integer);
    procedure SetNodeLevel(const Value: Integer);
    procedure SetRight(const Value: Integer);
    procedure SetRow(const Value: Integer);
    procedure SetTop(const Value: Integer);
    procedure SetLegendText(const Value: string);
    procedure SetLegendTextType(const Value: TLegendTextType);
    procedure SetXAxisColumn(const Value: Integer);
    procedure SetXAxisRow(const Value: Integer);
    procedure SetXAxisType(const Value: TGridDataType);
  protected
    procedure Changed;
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
  published
    property Left: Integer read FLeft write SetLeft default 0;
    property Top: Integer read FTop write SetTop default 0;
    property Right: Integer read FRight write SetRight default 0;
    property Bottom: Integer read FBottom write SetBottom default 0;
    property Column: Integer read FColumn write SetColumn default 0;
    property LegendTextType: TLegendTextType read FLegendTextType write SetLegendTextType;
    property LegendText: string read FLegendText write SetLegendText;
    property Row: Integer read FRow write SetRow default 0;
    property NodeLevel: Integer read FNodeLevel write SetNodeLevel default 0;
    property DataType: TGridDataType read FDataType write SetDataType default dtNormalColumn;
    property XAxisType: TGridDataType read FXAxisType write SetXAxisType default dtNone;
    property XAxisColumn: Integer read FXAxisColumn write SetXAxisColumn default 0;
    property XAxisRow: Integer read FXAxisRow write SetXAxisRow default 0;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TAdvChartLink = class(TGridChangeNotifier)
  private
    FChartView: TAdvChartview;
    FGrid: TAdvStringGrid;
    FGridValues: TGridData;
    FGridLegends: TGridData;
    FActive: Boolean;
    FPaneIndex: integer;
    FSerieIndex: integer;
    FAutoRange: TChartSerieAutoRange;
    FChartType: TChartType;
    FXRangeTo: integer;
    FAutoXRange: boolean;
    FXRangeFrom: integer;
    FOnChange: TNotifyEvent;
    procedure SetGrid(const Value: TAdvStringGrid);
    procedure SetGridLegends(const Value: TGridData);
    procedure SetGridValues(const Value: TGridData);
    procedure SetActive(const Value: Boolean);
    function GetVersionEx: string;
    procedure SetVersion(const Value: string);
    procedure SetPaneIndex(const Value: integer);
    procedure SetSerieIndex(const Value: integer);
    procedure SetAutoRange(const Value: TChartSerieAutoRange);
    procedure SetChartType(const Value: TChartType);
  protected
    function GetVersionNr: Integer; virtual;
    procedure CellsChanged(R:TRect); override;
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    property GridLegends: TGridData read FGridLegends write SetGridLegends;
    procedure Loaded; override;
    procedure DataChanged(Sender: TObject);     
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Synchronize;
  published
    property Active: Boolean read FActive write SetActive;
    property AutoRange: TChartSerieAutoRange read FAutoRange write SetAutoRange default arEnabled;
    property AutoXRange: boolean read FAutoXRange write FAutoXRange default true;
    property ChartType: TChartType read FChartType write SetChartType default ctBar;
    property Grid: TAdvStringGrid read FGrid write SetGrid;
    property GridValues: TGridData read FGridValues write SetGridValues;
    property ChartView: TAdvChartView read FChartView write FChartView;
    property Version: string read GetVersionEx write SetVersion;
    property PaneIndex: integer read FPaneIndex write SetPaneIndex default 0;
    property SerieIndex: integer read FSerieIndex write SetSerieIndex default 0;
    property XRangeFrom: integer read FXRangeFrom write FXRangeFrom default 0;
    property XRangeTo: integer read FXRangeTo write FXRangeTo default 100;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

procedure Register;

implementation

{ TChartLink }

procedure TAdvChartLink.Assign(Source: TPersistent);
begin
  if (Source is TAdvChartLink) then
  begin
    GridValues.Assign((Source as TAdvChartLink).GridValues);
  end;

end;

procedure TAdvChartLink.CellsChanged(R: TRect);
begin
  inherited;
  {Enhance to only synchronize when related cells changed}
  Synchronize;

  if Assigned(OnChange) then
    OnChange(Self);
end;

constructor TAdvChartLink.Create(AOwner: TComponent);
begin
  inherited;
  FGridValues := TGridData.Create;
  FGridValues.OnChange := DataChanged;
  FGridLegends := TGridData.Create;
  FAutoRange := arEnabled;
  FChartType := ctBar;
  FXRangeFrom := 0;
  FXRangeTo := 100;
  FAutoXRange := true;
end;

procedure TAdvChartLink.DataChanged(Sender: TObject);
begin
  if not (csLoading in ComponentState) then
    Synchronize;
end;

destructor TAdvChartLink.Destroy;
begin
  FGridValues.Free;
  FGridLegends.Free;
  inherited;
end;

function TAdvChartLink.GetVersionEx: string;
var
  vn: Integer;
begin
  vn := GetVersionNr;
  Result := IntToStr(Hi(Hiword(vn)))+'.'+IntToStr(Lo(Hiword(vn)))+'.'+IntToStr(Hi(Loword(vn)))+'.'+IntToStr(Lo(Loword(vn)));
end;

function TAdvChartLink.GetVersionNr: Integer;
begin
  Result := MakeLong(MakeWord(BLD_VER,REL_VER),MakeWord(MIN_VER,MAJ_VER));
end;

procedure TAdvChartLink.Loaded;
begin
  inherited;
  if Active then
    Synchronize;
end;

procedure TAdvChartLink.Notification(AComponent: TComponent;
  AOperation: TOperation);
begin
  if (AOperation = opRemove) and (AComponent = FGrid) then
   FGrid := nil;

  if (AOperation = opRemove) and (AComponent = FChartView) then
   FChartView := nil;

  inherited;
end;

procedure TAdvChartLink.SetActive(const Value: Boolean);
begin
  if FActive <> Value then
  begin
    FActive := Value;
    if FActive then Synchronize;
  end;
end;

procedure TAdvChartLink.SetAutoRange(const Value: TChartSerieAutoRange);
begin
  if (FAutoRange <> Value) then
  begin
    FAutoRange := Value;
    Synchronize;
  end;
end;

procedure TAdvChartLink.SetChartType(const Value: TChartType);
begin
  if (FChartType <> Value) then
  begin
    FChartType := Value;
    Synchronize;
  end;
end;

procedure TAdvChartLink.SetGrid(const Value: TAdvStringGrid);
begin
  if FGrid <> Value then
  begin
    if not Assigned(Value) and Assigned(FGrid) then
      FGrid.UnRegisterNotifier(Self);

    if Assigned(Value) and not Assigned(FGrid) then
      Value.RegisterNotifier(Self);

    FGrid := Value;
  end;
end;

procedure TAdvChartLink.SetGridLegends(const Value: TGridData);
begin
  FGridLegends := Value;
end;

procedure TAdvChartLink.SetGridValues(const Value: TGridData);
begin
  FGridValues := Value;
end;

procedure TAdvChartLink.SetPaneIndex(const Value: integer);
begin
  if Assigned(ChartView) then
  begin
    if (Value >= 0) and (Value < ChartView.Panes.Count) then
    begin
      FPaneIndex := Value;
      Synchronize;
    end;
  end
  else
    FPaneIndex := Value;
end;

procedure TAdvChartLink.SetSerieIndex(const Value: integer);
begin
  if Assigned(ChartView) then
  begin
    if (Value >= 0) and (Value < ChartView.Panes[FPaneIndex].Series.Count) then
    begin
      FSerieIndex := Value;
      Synchronize;
    end;
  end
  else
    FSerieIndex := Value;
end;

procedure TAdvChartLink.SetVersion(const Value: string);
begin

end;

procedure TAdvChartLink.Synchronize;
var
  Col,Row: integer;// Idx: Integer;
  SyncRect: TRect;
  CValue, XValue, MinX, MaxX: Double;
  cg: TCellGraphic;
  addcell: Boolean;
  legendtxt: string;
  xaxistxt: string;
  idx: integer;
begin
  if not Assigned(FGrid) then
    Exit;
  if not Assigned(FChartView) then
    Exit;
  if not Active then
    Exit;
  if csDesigning in ComponentState then
    Exit;

  if (FPaneIndex >= ChartView.Panes.Count) or (FPaneIndex < 0) then
    Exit;

  if (FSerieIndex >= ChartView.Panes[FPaneIndex].Series.Count) or (FSerieIndex < 0) then
    Exit;

  FChartView.BeginUpdate;

//  Idx := 0;

  case FGridValues.DataType of
  dtCellRange:SyncRect := Rect(FGridValues.Left,FGridValues.Top,FGridValues.Right,FGridValues.Bottom);
  dtFullRow:
    begin
      SyncRect.Top := FGridValues.Row;
      SyncRect.Left := 0;
      SyncRect.Bottom := FGridValues.Row;
      SyncRect.Right := FGrid.ColCount - 1;
    end;
  dtFullColumn:
    begin
      SyncRect.Top := 0;
      SyncRect.Left := FGridValues.Column;
      SyncRect.Bottom := FGrid.RowCount - 1;
      SyncRect.Right := FGridValues.Column;
    end;
  dtNormalRow:
    begin
      SyncRect.Top := FGridValues.Row;
      SyncRect.Left := FGrid.FixedCols;
      SyncRect.Bottom := FGridValues.Row;
      SyncRect.Right := FGrid.ColCount - 1 - FGrid.FixedRightCols;
    end;
  dtNormalColumn:
    begin
      SyncRect.Top := FGrid.FixedRows;
      SyncRect.Left := FGridValues.Column;
      SyncRect.Bottom := FGrid.RowCount - 1 - FGrid.FixedFooters;
      SyncRect.Right := FGridValues.Column;
    end;
  dtNode:
    begin
      {
        dtNode is same as dtNormalColumn. The difference is in the action below
        after the 'case'
      }
      SyncRect.Top := FGrid.FixedRows;
      SyncRect.Left := FGridValues.Column;
      SyncRect.Bottom := FGrid.RowCount - 1 - FGrid.FixedFooters;
      SyncRect.Right := FGridValues.Column;
    end;
  end;

  FChartView.Panes[FPaneIndex].Series[FSerieIndex].ClearPoints;
  FChartView.Panes[FPaneIndex].Series[FSerieIndex].AutoRange := AutoRange;
  FChartView.Panes[FPaneIndex].Series[FSerieIndex].ChartType := ChartType;

  if FGridValues.FLegendTextType <> ltNone then
  begin
    case FGridValues.FLegendTextType of
    ltFirstFixedCell:
      begin
        case FGridValues.FDataType of
        dtNone, dtCellRange: legendtxt := FGrid.Cells[0,0];
        dtNormalColumn, dtFullColumn: legendtxt := FGrid.Cells[FGridValues.Column,0];
        dtNormalRow, dtFullRow: legendtxt := FGrid.Cells[0, FGridValues.Row];
        end;
      end;
    ltFirstCell:
      begin
        case FGridValues.FDataType of
        dtNone: legendtxt := FGrid.Cells[0,0];
        dtCellRange:
          begin
            legendtxt := FGrid.Cells[FGridValues.Left,FGridValues.Top];
            SyncRect.Top := SyncRect.Top + 1;
          end;
        dtNormalColumn:
          begin
            legendtxt := FGrid.Cells[FGridValues.Column, FGrid.FixedRows];
            SyncRect.Top := FGrid.FixedRows + 1;
          end;
        dtFullColumn:
          begin
            legendtxt := FGrid.Cells[FGridValues.Column,0];
            SyncRect.Top := SyncRect.Top + 1;
          end;
        dtNormalRow:
          begin
            legendtxt := FGrid.Cells[FGrid.FixedCols, FGridValues.Row];
            SyncRect.Left := FGrid.FixedCols + 1;
          end;
        dtFullRow:
          begin
            legendtxt := FGrid.Cells[0, FGridValues.Row];
            SyncRect.Left := FGrid.FixedCols;
          end;
        end;
      end;
    ltCustom: legendtxt := FGridValues.LegendText;
    end;


    FChartView.Panes[FPaneIndex].Series[FSerieIndex].LegendText := legendtxt;
  end;

  MinX := +MaxLongint;
  MaxX := -MaxLongint;

  if FGridValues.FDataType <> dtNone then
  begin
    FGrid.ExportNotification(esExportStart,-1);

    idx := 0;
    for Col := SyncRect.Left to SyncRect.Right do
      for Row := SyncRect.Top to SyncRect.Bottom do
        begin
          FGrid.ExportNotification(esExportNewRow,Row);
          addcell := true;

          if (FGridValues.FDataType = dtNode) then
          begin
            if FGrid.IsNode(Row) then
            begin
              if (FGrid.GetNodeLevel(Row) = FGridValues.FNodeLevel) then
              begin
                addcell := True;
              end;
            end
            else
              addcell := False;
          end;

          if addcell then
          begin
            if Pos('=',FGrid.Cells[Col,Row]) = 1 then
            begin
              cg := FGrid.Objects[Col,Row] as TCellGraphic;
              if Assigned(cg) then
                CValue := cg.CellValue
              else
                CValue := 0;
            end
            else
            begin
              try
                CValue := FGrid.Floats[Col,Row];
              except
                CValue := 0;
              end;
            end;


            if ChartType in [ctXYLine, ctXYMarkers] then
            begin
              XValue := 0;
              case FGridValues.XAxisType of
              dtNormalColumn: XValue := FGrid.Floats[FGridValues.XAxisColumn, FGrid.FixedRows + idx];
              dtFullColumn: XValue := FGrid.Floats[FGridValues.XAxisColumn, idx];
              dtNormalRow: XValue := FGrid.Floats[FGrid.FixedCols + idx, FGridValues.XAxisRow];
              dtFullRow: XValue := FGrid.Floats[idx, FGridValues.XAxisRow];
              end;

              if XValue > MaxX then
                MaxX := XValue;

              if XValue < MinX then
                MinX := XValue;

              FChartView.Panes[FPaneIndex].Series[FSerieIndex].AddSingleXYPoint(XValue, CValue);
            end
            else
            begin
              xaxistxt := '';

              case FGridValues.XAxisType of
              dtNormalColumn: xaxistxt := FGrid.Cells[FGridValues.XAxisColumn, FGrid.FixedRows + idx];
              dtFullColumn: xaxistxt := FGrid.Cells[FGridValues.XAxisColumn, idx];
              dtNormalRow: xaxistxt := FGrid.Cells[FGrid.FixedCols + idx, FGridValues.XAxisRow];
              dtFullRow: xaxistxt := FGrid.Cells[idx, FGridValues.XAxisRow];
              dtCellRange: xaxistxt := FGrid.Cells[FGridValues.XAxisColumn, FGridValues.XAxisRow + idx];
              end;

              if (xaxistxt <> '') then
                FChartView.Panes[FPaneIndex].Series[FSerieIndex].AddSinglePoint(CValue, xaxistxt)
              else
                FChartView.Panes[FPaneIndex].Series[FSerieIndex].AddSinglePoint(CValue);
            end;
          end;

          inc(idx);
        end;

    if ChartType in [ctXYLine, ctXYMarkers] then
    begin
      if FAutoXRange then
      begin
        FChartview.Panes[FPaneIndex].Range.RangeFrom := round(MinX * 0.9);
        FChartview.Panes[FPaneIndex].Range.RangeTo := round(MaxX * 1.10);
      end
      else
      begin
        FChartview.Panes[FPaneIndex].Range.RangeFrom := round(FXRangeFrom);
        FChartview.Panes[FPaneIndex].Range.RangeTo := round(FXRangeTo);
      end;
    end
    else
      FChartview.Panes[FPaneIndex].Range.RangeTo := FChartView.Panes[FPaneIndex].Series[FSerieIndex].GetArraySize;

    FGrid.ExportNotification(esExportDone,-1);
  end;

  FChartView.EndUpdate;
end;

{ TGridData }

procedure TGridData.Assign(Source: TPersistent);
begin
  if (Source is TGridData) then
  begin
    FLeft := (Source as TGridData).Left;
    FTop := (Source as TGridData).Top;
    FRight := (Source as TGridData).Right;
    FBottom := (Source as TGridData).Bottom;
    FColumn := (Source as TGridData).Column;
    FRow := (Source as TGridData).Row;
    FNodeLevel := (Source as TGridData).NodeLevel;
    FDataType := (Source as TGridData).DataType;
    FXAxisColumn := (Source as TGridData).XAxisColumn;
    FXAxisRow := (Source as TGridData).XAxisRow;
    FXAxisType := (Source as TGridData).XAxisType;
    FLegendText := (Source as TGridData).LegendText;
    FLegendTextType := (Source as TGridData).LegendTextType;
  end;
end;

procedure TGridData.Changed;
begin
  if Assigned(OnChange) then
    OnChange(Self);
end;

constructor TGridData.Create;
begin
  inherited;
  DataType := dtNormalColumn;
  XAxisType := dtNone;
end;

procedure TGridData.SetBottom(const Value: Integer);
begin
  if (FBottom <> Value) then
  begin
    FBottom := Value;
    Changed;
  end;
end;

procedure TGridData.SetColumn(const Value: Integer);
begin
  if (FColumn <> Value) then
  begin
    FColumn := Value;
    Changed;
  end;
end;

procedure TGridData.SetDataType(const Value: TGridDataType);
begin
  if (FDataType <> Value) then
  begin
    FDataType := Value;
    Changed;
  end;
end;

procedure TGridData.SetLeft(const Value: Integer);
begin
  if (FLeft <> Value) then
  begin
    FLeft := Value;
    Changed;
  end;
end;

procedure TGridData.SetLegendText(const Value: string);
begin
  if (FLegendText <> Value) then
  begin
    FLegendText := Value;
    Changed;
  end;
end;

procedure TGridData.SetLegendTextType(const Value: TLegendTextType);
begin
  if (FLegendTextType <> Value) then
  begin
    FLegendTextType := Value;
    Changed;
  end;
end;

procedure TGridData.SetNodeLevel(const Value: Integer);
begin
  if (FNodeLevel <> Value) then
  begin
    FNodeLevel := Value;
    Changed;
  end;
end;

procedure TGridData.SetRight(const Value: Integer);
begin
  if (FRight <> Value) then
  begin
    FRight := Value;
    Changed;
  end;
end;

procedure TGridData.SetRow(const Value: Integer);
begin
  if (FRow <> Value) then
  begin
    FRow := Value;
    Changed;
  end;
end;

procedure TGridData.SetTop(const Value: Integer);
begin
  if (FTop <> Value) then
  begin
    FTop := Value;
    Changed;
  end;
end;


procedure TGridData.SetXAxisColumn(const Value: Integer);
begin
  if (FXAxisColumn <> Value) then
  begin
    FXAxisColumn := Value;
    Changed;
  end;
end;

procedure TGridData.SetXAxisRow(const Value: Integer);
begin
  if (FXAxisRow <> Value) then
  begin
    FXAxisRow := Value;
    Changed;
  end;
end;

procedure TGridData.SetXAxisType(const Value: TGridDataType);
begin
  if (FXAxisType <> Value) then
  begin
    FXAxisType := Value;
    Changed;
  end;
end;

procedure Register;
begin
  RegisterComponents('TMS Charts',[TAdvChartLink]);
end;  


end.

