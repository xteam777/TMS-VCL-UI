{***************************************************************************}
{ TDBAdvChart component                                                     }
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

unit DBAdvChartView;

{$I TMSDEFS.INC}

interface

uses
  AdvChartView, AdvChart, DB, Classes, SysUtils, Windows, Math, Dialogs;

type
  TDBAdvChartView = class;
  TDBChartPane = class;

  TChartPaneDataLink = class(TDataLink)
  private
    FEditChange: boolean;
    FEditUpdate: boolean;
    FPane: TDBChartPane;
  protected
    procedure ActiveChanged; override;
    procedure DataSetChanged; override;
    procedure DataSetScrolled(Distance: Integer); override;
    procedure EditingChanged; override;
    procedure LayoutChanged; override;
    procedure RecordChanged(Field: TField); override;
    procedure UpdateData; override;
  public
    constructor Create(APane: TDBChartPane);
    destructor Destroy; override;
  end;

  TDBChartSerie = class(TChartSerie)
  private
  protected
    procedure SetFieldNameValue(const Value: String); override;
    procedure SetFieldNameXAxis(const Value: String); override;
  public
    function GetDSFieldNames: TStringList; override;
    function IsDB: Boolean; override;
    constructor Create(Collection: TCollection); override;
  published
    property FieldNameValue;
    property FieldNameXAxis;
  end;

  TDBChartSeries = class(TChartSeries)
  private
  protected
    function GetItem(Index: Integer): TDBChartSerie;
    procedure SetItem(Index: Integer; const Value: TDBChartSerie);
  public
    function GetItemClass: TCollectionItemClass; override;
    property Items[Index: Integer]: TDBChartSerie read GetItem write SetItem; default;
  published
  end;

  TDBAdvChart = class(TAdvChart)
  private
    function GetSeries: TDBChartSeries;
    procedure SetSeries(const Value: TDBChartSeries);
  protected
    function CreateSeries: TChartSeries; override;
  public
  published
    property Series: TDBChartSeries read GetSeries write SetSeries;
  end;

  TDBChartPane = class(TChartPane)
  private
    FDataSource: TDataSource;
    FDataLink: TChartPaneDataLink;
    procedure SetDataSource(const Value: TDataSource);
    function GetSeries: TDBChartSeries;
    procedure SetSeries(const Value: TDBChartSeries);
    function GetDataSource: TDataSource;
  protected
    function GetDSNames: TStringList; override;
    function CheckDataSet: Boolean;
    function CreateChart: TAdvChart; override;
    function IsDB: boolean; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure LoadData; override;
  published
    property Series: TDBChartSeries read GetSeries write SetSeries;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  end;

  TDBChartPanes = class(TChartPanes)
  private
  protected
    function GetItem(Index: Integer): TDBChartPane;
    procedure SetItem(Index: Integer; const Value: TDBChartPane);
  public
    function GetItemClass: TCollectionItemClass; override;
    property Items[Index: Integer]: TDBChartPane read GetItem write SetItem; default;
  published
  end;

  {$IFDEF DELPHIXE2_LVL}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  {$ENDIF}
  TDBAdvChartView = class(TAdvChartView)
  private
    procedure SetDBChartPanes(const Value: TDBChartPanes);
    function GetDBChartPanes: TDBChartPanes;
  protected
  public
    procedure LoadData; override;
    function CreatePanes: TChartPanes; override;

    function GetPaneClass: TChartPaneClass; override;
    function GetPanesClass: TChartPanesClass; override;
    function GetSeriesClass: TChartSeriesClass; override;
    function GetSerieClass: TChartSerieClass; override;

  published
    property Panes: TDBChartPanes read GetDBChartPanes write SetDBChartPanes;
  end;

implementation

uses
  Forms
  {$IFDEF DELPHI2006_LVL}
  ,WideStrings
  {$ENDIF}
  ;

{ TDBAdvChartView }

function TDBAdvChartView.CreatePanes: TChartPanes;
begin
  Result := TDBChartPanes.Create(Self);
end;

function TDBAdvChartView.GetDBChartPanes: TDBChartPanes;
begin
  Result := TDBChartPanes(inherited Panes);
end;

function TDBAdvChartView.GetPaneClass: TChartPaneClass;
begin
  Result := TDBChartPane;
end;

function TDBAdvChartView.GetPanesClass: TChartPanesClass;
begin
  Result := TDBChartPanes;
end;

function TDBAdvChartView.GetSerieClass: TChartSerieClass;
begin
  Result := TDBChartSerie;
end;

function TDBAdvChartView.GetSeriesClass: TChartSeriesClass;
begin
  Result := TDBChartSeries;
end;

procedure TDBAdvChartView.LoadData;
var
  I: Integer;
begin
  for I := 0 to Panes.Count - 1 do
  begin
    Panes[I].LoadData;
  end;
end;

procedure TDBAdvChartView.SetDBChartPanes(const Value: TDBChartPanes);
begin
  Panes := Value;
end;

{ TDBChartSeries }

function TDBChartSeries.GetItem(Index: Integer): TDBChartSerie;
begin
  Result := TDBChartSerie(inherited GetItem(Index));
end;

function TDBChartSeries.GetItemClass: TCollectionItemClass;
begin
  Result := TDBChartSerie;
end;

procedure TDBChartSeries.SetItem(Index: Integer; const Value: TDBChartSerie);
begin
  inherited SetItem(Index, Value);
end;

{ TDBChartSerie }

constructor TDBChartSerie.Create(Collection: TCollection);
begin
  inherited;
end;

function TDBChartSerie.GetDSFieldNames: TStringList;
var
  ds: TDataSet;
  {$IFNDEF DELPHIXE3_LVL}
  {$IFDEF DELPHI2006_LVL}
  sl: TWideStringList;
  {$ELSE}
  sl: TStringList;
  {$ENDIF}
  {$ELSE}
  sl: TStringList;
  {$ENDIF}
  s: string;
  i: integer;
begin
  Result := nil;
  if Chart.Owner is TDBChartPane then
  begin
    if (Chart.Owner as TDBChartPane).IsDB then
    begin
      if (Chart.Owner as TDBChartPane).CheckDataSet then
      begin
        ds := TDataSource((Chart.Owner as TDBChartPane).DS).DataSet;
        {$IFNDEF DELPHIXE3_LVL}
        {$IFDEF DELPHI2006_LVL}
        sl := TWideStringList.Create;
        {$ELSE}
        sl := TStringList.Create;
        {$ENDIF}
        {$ELSE}
        sl := TStringList.Create;
        {$ENDIF}

        ds.GetFieldNames(sl);
        Result := TStringList.Create;

        for i := 0 to sl.Count - 1 do
        begin
          s := sl.Strings[i];
          Result.Add(s);
        end;
        
        sl.Free;
      end;
    end;
  end;
end;

function TDBChartSerie.IsDB: Boolean;
begin
  Result := true;
end;

procedure TDBChartSerie.SetFieldNameValue(const Value: String);
begin
  inherited;
  (Chart.Owner as TDBChartPane).LoadData;
end;

procedure TDBChartSerie.SetFieldNameXAxis(const Value: String);
begin
  inherited;
  (Chart.Owner as TDBChartPane).LoadData;
end;


{ TDBChartPanes }

function TDBChartPanes.GetItem(Index: Integer): TDBChartPane;
begin
  Result := TDBChartPane(inherited GetItem(Index));
end;

function TDBChartPanes.GetItemClass: TCollectionItemClass;
begin
  Result := TDBChartPane;
end;

procedure TDBChartPanes.SetItem(Index: Integer; const Value: TDBChartPane);
begin
  inherited SetItem(Index, Value);
end;

{ TDBChartPane }

procedure TDBChartPane.Assign(Source: TPersistent);
begin
  inherited;
  FDataSource := (Source as TDBChartPane).DataSource;
end;

function TDBChartPane.CheckDataSet: Boolean;
begin
//  Result := Assigned(FDataLink) and Assigned(FDataLink.DataSet) and FDataLink.DataSet.Active;
  Result := false;
  if Assigned(DS) then
  begin
    if (DS is TDataSource) then
    begin
      Result := Assigned((DS as TDataSource).DataSet) and (DS as TDataSource).DataSet.Active;
    end;
  end;
//  Result := Assigned(DS) and Assigned(FDataLink.DataSet) and FDataLink.DataSet.Active;
end;

constructor TDBChartPane.Create(Collection: TCollection);
begin
  inherited;
  FDataLink := TChartPaneDataLink.Create(Self);
end;

function TDBChartPane.CreateChart: TAdvChart;
begin
  Result := TDBAdvChart.Create(Self);
  if (csDesigning in ChartView.ComponentState) and not (csLoading in ChartView.componentstate) then
    Result.Range.StartDate := Now;
  Result.GetPaneRectangle := DoGetPaneRectangle;
  Result.OnSerieXAxisGroup := DoSerieXAxisGroup;
  Result.OnGetCountChartType := DoGetCountChartType;
  Result.OnGetCountGroupedChartType := DoGetCountGroupedChartType;
  Result.OnDrawGridPieLineValue := DoDrawGridPieLineValue;
  Result.OnGetGridPieLineValue := DoGetGridPieLineValue;
end;

destructor TDBChartPane.Destroy;
begin
  FDatalink.Free;
  inherited;
end;

function TDBChartPane.GetDataSource: TDataSource;
begin
  Result := TDataSource(DS);
end;

function TDBChartPane.GetDSNames: TStringList;
var
  f: TComponent;
  i: integer;
  K: Integer;
begin
  Result := TStringList.Create;

  f := GetParentForm(ChartView);
  if Assigned(f) then
  begin
    for i := 0 to f.ComponentCount - 1 do
    begin
      if f.Components[i] is TFrame then
      begin
        for K := 0 to (f.Components[i] as TFrame).ComponentCount - 1 do
        begin
          if ((f.Components[i] as TFrame).Components[K] is TDataSource) then
          begin
            Result.AddObject((f.Components[i] as TFrame).Components[K].Name, (f.Components[i] as TFrame).Components[K]);
          end;
        end;
      end
      else
      begin
        if (f.Components[i] is TDataSource) then
        begin
          Result.AddObject(f.Components[i].Name, f.Components[i]);
        end;
      end;
    end;
  end;

  //Showmessage('got datasources: '+inttostr(Result.Count));
end;

function TDBChartPane.GetSeries: TDBChartSeries;
begin
  Result := TDBChartSeries(inherited Series);
end;

function TDBChartPane.IsDB: boolean;
begin
  Result := true;
end;

procedure TDBChartPane.LoadData;
var
  K, J: Integer;
  c: Double;
  cb: TBookmark;
  s: string;
  def: Boolean;
begin
  if CheckDataSet then
  begin
    J := 0;

    ChartView.BeginUpdate;

    cb := DataSource.DataSet.GetBookMark;
    DataSource.DataSet.First;
    DataSource.DataSet.DisableControls;

    // clear series points first
    for K := 0 to Series.Count - 1 do
    begin
      Series[K].ClearPoints;
    end;

    // loop dataset and add series points first
    while not DataSource.DataSet.Eof do
    begin
      for K := 0 to Series.Count - 1 do
      begin
        with Series[K] do
        begin
          if FieldNameValue <> '' then
          begin
            def := true;
            c := 0;
            if DataSource.DataSet.FieldByName(FieldNameValue).AsString <> '' then
              c := DataSource.DataSet.FieldByName(FieldNameValue).AsFloat
            else
              def := false;

            if FieldNameXAxis <> '' then
            begin
              s := DataSource.DataSet.FieldByName(FieldNameXAxis).Text;
              AddSinglePoint(c, def, s);
            end
            else
              AddSinglePoint(c, def);
          end;
        end;
      end;
      DataSource.DataSet.Next;
      inc(J);
    end;

    DataSource.DataSet.GotoBookMark(cb);
    DataSource.DataSet.FreeBookMark(cb);
    DataSource.DataSet.EnableControls;

    Range.RangeFrom := 0;
    Range.RangeTo := J - 1;

    ChartView.EndUpdate;
  end
  else
  begin
    ChartView.BeginUpdate;
    for K := 0 to Series.Count - 1 do
      Series[K].ClearPoints;
    ChartView.EndUpdate;
  end;
end;

procedure TDBChartPane.SetDataSource(const Value: TDataSource);
begin
  FDataSource := Value;
  DS := Value;
  FDataLink.DataSource := Value;
end;

procedure TDBChartPane.SetSeries(const Value: TDBChartSeries);
begin
  Series := Value;
end;

{ TDBAdvChart }

function TDBAdvChart.CreateSeries: TChartSeries;
begin
  Result := TDBChartSeries.Create(Self);
end;

function TDBAdvChart.GetSeries: TDBChartSeries;
begin
  Result := TDBChartSeries(inherited Series);
end;

procedure TDBAdvChart.SetSeries(const Value: TDBChartSeries);
begin
  Series := Value;
end;

{ TChartPaneDataLink }

procedure TChartPaneDataLink.ActiveChanged;
begin
  inherited;
  FPane.LoadData;
end;

constructor TChartPaneDataLink.Create(APane: TDBChartPane);
begin
  inherited Create;
  FPane := APane;
end;

procedure TChartPaneDataLink.DataSetChanged;
begin
  inherited;

  if (DataSet.State = dsBrowse) and FEditChange then
  begin
    FEditChange := false;
  end;

  if (DataSet.State = dsBrowse) and FEditUpdate then
  begin
    FEditUpdate := false;
    // reload here after editing was done...
    FPane.LoadData;
  end;
end;

procedure TChartPaneDataLink.DataSetScrolled(Distance: Integer);
begin
  inherited;
end;

destructor TChartPaneDataLink.Destroy;
begin
  inherited;
end;

procedure TChartPaneDataLink.EditingChanged;
begin
  FEditChange := true;
  inherited;
end;

procedure TChartPaneDataLink.LayoutChanged;
begin
  inherited;
end;

procedure TChartPaneDataLink.RecordChanged(Field: TField);
begin
  inherited;
end;

procedure TChartPaneDataLink.UpdateData;
begin
  FEditUpdate := true;
  inherited;
end;

end.
