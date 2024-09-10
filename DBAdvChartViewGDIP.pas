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

unit DBAdvChartViewGDIP;

{$I TMSDEFS.INC}

interface

uses
  AdvChartViewGDIP, AdvChartGDIP, AdvChartView, AdvChart, DB, Classes, SysUtils, Windows, Math, Dialogs;

type
  TDBAdvGDIPChartView = class;
  TDBAdvGDIPChartPane = class;

  TGDIPChartPaneDataLink = class(TDataLink)
  private
    FEditChange: boolean;
    FEditUpdate: boolean;
    FPane: TDBAdvGDIPChartPane;
  protected
    procedure ActiveChanged; override;
    procedure DataSetChanged; override;
    procedure DataSetScrolled(Distance: Integer); override;
    procedure EditingChanged; override;
    procedure LayoutChanged; override;
    procedure RecordChanged(Field: TField); override;
    procedure UpdateData; override;
  public
    constructor Create(APane: TDBAdvGDIPChartPane);
    destructor Destroy; override;
  end;

  TDBAdvGDIPChartSerie = class(TAdvGDIPChartSerie)
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

  TDBAdvGDIPChartSeries = class(TAdvGDIPChartSeries)
  private
  protected
    function GetItem(Index: Integer): TDBAdvGDIPChartSerie;
    procedure SetItem(Index: Integer; const Value: TDBAdvGDIPChartSerie);
  public
    function GetItemClass: TCollectionItemClass; override;
    property Items[Index: Integer]: TDBAdvGDIPChartSerie read GetItem write SetItem; default;
  published
  end;

  TDBAdvGDIPChart = class(TAdvGDIPChart)
  private
    function GetSeries: TDBAdvGDIPChartSeries;
    procedure SetSeries(const Value: TDBAdvGDIPChartSeries);
  protected
    function CreateSeries: TChartSeries; override;
  public
  published
    property Series: TDBAdvGDIPChartSeries read GetSeries write SetSeries;
  end;

  TDBAdvGDIPChartPane = class(TAdvGDIPChartPane)
  private
    FDataSource: TDataSource;
    FDataLink: TGDIPChartPaneDataLink;
    procedure SetDataSource(const Value: TDataSource);
    function GetSeries: TDBAdvGDIPChartSeries;
    procedure SetSeries(const Value: TDBAdvGDIPChartSeries);
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
    property Series: TDBAdvGDIPChartSeries read GetSeries write SetSeries;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  end;

  TDBAdvGDIPChartPanes = class(TAdvGDIPChartPanes)
  private
  protected
    function GetItem(Index: Integer): TDBAdvGDIPChartPane;
    procedure SetItem(Index: Integer; const Value: TDBAdvGDIPChartPane);
  public
    function GetItemClass: TCollectionItemClass; override;
    property Items[Index: Integer]: TDBAdvGDIPChartPane read GetItem write SetItem; default;
  published
  end;

  {$IFDEF DELPHIXE2_LVL}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  {$ENDIF}
  TDBAdvGDIPChartView = class(TAdvGDIPChartView)
  private
    procedure SetDBChartPanes(const Value: TDBAdvGDIPChartPanes);
    function GetDBChartPanes: TDBAdvGDIPChartPanes;
  protected
  public
    procedure LoadData; override;
    function CreatePanes: TChartPanes; override;

    function GetPaneClass: TChartPaneClass; override;
    function GetPanesClass: TChartPanesClass; override;
    function GetSeriesClass: TChartSeriesClass; override;
    function GetSerieClass: TChartSerieClass; override;

  published
    property Panes: TDBAdvGDIPChartPanes read GetDBChartPanes write SetDBChartPanes;
  end;

implementation

uses
  {$IFDEF DELPHI2006_LVL}
  WideStrings,
  {$ENDIF}
  Forms
  ;

{ TDBAdvGDIPChartView }

function TDBAdvGDIPChartView.CreatePanes: TChartPanes;
begin
  Result := TDBAdvGDIPChartPanes.Create(Self);
end;

function TDBAdvGDIPChartView.GetDBChartPanes: TDBAdvGDIPChartPanes;
begin
  Result := TDBAdvGDIPChartPanes(inherited Panes);
end;

function TDBAdvGDIPChartView.GetPaneClass: TChartPaneClass;
begin
  Result := TDBAdvGDIPChartPane;
end;

function TDBAdvGDIPChartView.GetPanesClass: TChartPanesClass;
begin
  Result := TDBAdvGDIPChartPanes;
end;

function TDBAdvGDIPChartView.GetSerieClass: TChartSerieClass;
begin
  Result := TDBAdvGDIPChartSerie;
end;

function TDBAdvGDIPChartView.GetSeriesClass: TChartSeriesClass;
begin
  Result := TDBAdvGDIPChartSeries;
end;

procedure TDBAdvGDIPChartView.LoadData;
var
  I: Integer;
begin
  for I := 0 to Panes.Count - 1 do
  begin
    Panes[I].LoadData;
  end;
end;

procedure TDBAdvGDIPChartView.SetDBChartPanes(const Value: TDBAdvGDIPChartPanes);
begin
  Panes := Value;
end;

{ TDBAdvGDIPChartSeries }

function TDBAdvGDIPChartSeries.GetItem(Index: Integer): TDBAdvGDIPChartSerie;
begin
  Result := TDBAdvGDIPChartSerie(inherited GetItem(Index));
end;

function TDBAdvGDIPChartSeries.GetItemClass: TCollectionItemClass;
begin
  Result := TDBAdvGDIPChartSerie;
end;

procedure TDBAdvGDIPChartSeries.SetItem(Index: Integer; const Value: TDBAdvGDIPChartSerie);
begin
  inherited SetItem(Index, Value);
end;

{ TDBAdvGDIPChartSerie }

constructor TDBAdvGDIPChartSerie.Create(Collection: TCollection);
begin
  inherited;
end;

function TDBAdvGDIPChartSerie.GetDSFieldNames: TStringList;
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
  if Chart.Owner is TDBAdvGDIPChartPane then
  begin
    if (Chart.Owner as TDBAdvGDIPChartPane).IsDB then
    begin
      if (Chart.Owner as TDBAdvGDIPChartPane).CheckDataSet then
      begin
        ds := TDataSource((Chart.Owner as TDBAdvGDIPChartPane).DS).DataSet;
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

function TDBAdvGDIPChartSerie.IsDB: Boolean;
begin
  Result := true;
end;

procedure TDBAdvGDIPChartSerie.SetFieldNameValue(const Value: String);
begin
  inherited;
  (Chart.Owner as TDBAdvGDIPChartPane).LoadData;
end;

procedure TDBAdvGDIPChartSerie.SetFieldNameXAxis(const Value: String);
begin
  inherited;
  (Chart.Owner as TDBAdvGDIPChartPane).LoadData;
end;


{ TDBAdvGDIPChartPanes }

function TDBAdvGDIPChartPanes.GetItem(Index: Integer): TDBAdvGDIPChartPane;
begin
  Result := TDBAdvGDIPChartPane(inherited GetItem(Index));
end;

function TDBAdvGDIPChartPanes.GetItemClass: TCollectionItemClass;
begin
  Result := TDBAdvGDIPChartPane;
end;

procedure TDBAdvGDIPChartPanes.SetItem(Index: Integer; const Value: TDBAdvGDIPChartPane);
begin
  inherited SetItem(Index, Value);
end;

{ TDBAdvGDIPChartPane }

procedure TDBAdvGDIPChartPane.Assign(Source: TPersistent);
begin
  inherited;
  FDataSource := (Source as TDBAdvGDIPChartPane).DataSource;
end;

function TDBAdvGDIPChartPane.CheckDataSet: Boolean;
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

constructor TDBAdvGDIPChartPane.Create(Collection: TCollection);
begin
  inherited;
  FDataLink := TGDIPChartPaneDataLink.Create(Self);
end;

function TDBAdvGDIPChartPane.CreateChart: TAdvChart;
begin
  Result := TDBAdvGDIPChart.Create(Self);
  if (csDesigning in ChartView.ComponentState) and not (csLoading in ChartView.componentstate) then
    Result.Range.StartDate := Now;
  Result.GetPaneRectangle := DoGetPaneRectangle;
  Result.OnSerieXAxisGroup := DoSerieXAxisGroup;
  Result.OnGetCountChartType := DoGetCountChartType;
  Result.OnGetCountGroupedChartType := DoGetCountGroupedChartType;
  Result.OnDrawGridPieLineValue := DoDrawGridPieLineValue;
  Result.OnGetGridPieLineValue := DoGetGridPieLineValue;
end;

destructor TDBAdvGDIPChartPane.Destroy;
begin
  FDatalink.Free;
  inherited;
end;

function TDBAdvGDIPChartPane.GetDataSource: TDataSource;
begin
  Result := TDataSource(DS);
end;

function TDBAdvGDIPChartPane.GetDSNames: TStringList;
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

function TDBAdvGDIPChartPane.GetSeries: TDBAdvGDIPChartSeries;
begin
  Result := TDBAdvGDIPChartSeries(inherited Series);
end;

function TDBAdvGDIPChartPane.IsDB: boolean;
begin
  Result := true;
end;

procedure TDBAdvGDIPChartPane.LoadData;
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

procedure TDBAdvGDIPChartPane.SetDataSource(const Value: TDataSource);
begin
  FDataSource := Value;
  DS := Value;
  FDataLink.DataSource := Value;
end;

procedure TDBAdvGDIPChartPane.SetSeries(const Value: TDBAdvGDIPChartSeries);
begin
  Series := Value;
end;

{ TDBAdvGDIPChart }

function TDBAdvGDIPChart.CreateSeries: TChartSeries;
begin
  Result := TDBAdvGDIPChartSeries.Create(Self);
end;

function TDBAdvGDIPChart.GetSeries: TDBAdvGDIPChartSeries;
begin
  Result := TDBAdvGDIPChartSeries(inherited Series);
end;

procedure TDBAdvGDIPChart.SetSeries(const Value: TDBAdvGDIPChartSeries);
begin
  Series := Value;
end;

{ TChartPaneDataLink }

procedure TGDIPChartPaneDataLink.ActiveChanged;
begin
  inherited;
  FPane.LoadData;
end;

constructor TGDIPChartPaneDataLink.Create(APane: TDBAdvGDIPChartPane);
begin
  inherited Create;
  FPane := APane;
end;

procedure TGDIPChartPaneDataLink.DataSetChanged;
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

procedure TGDIPChartPaneDataLink.DataSetScrolled(Distance: Integer);
begin
  inherited;
end;

destructor TGDIPChartPaneDataLink.Destroy;
begin
  inherited;
end;

procedure TGDIPChartPaneDataLink.EditingChanged;
begin
  FEditChange := true;
  inherited;
end;

procedure TGDIPChartPaneDataLink.LayoutChanged;
begin
  inherited;
end;

procedure TGDIPChartPaneDataLink.RecordChanged(Field: TField);
begin
  inherited;
end;

procedure TGDIPChartPaneDataLink.UpdateData;
begin
  FEditUpdate := true;
  inherited;
end;

end.
