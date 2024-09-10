{***************************************************************************}
{ TAdvChart component demo                                                  }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 2007 - 2008                                        }
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

unit UFinChart;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, AdvChartView, StdCtrls, ExtCtrls, AdvChart, Math, ComCtrls,
  Grids, DateUtils, AdvChartPaneEditor, Printers,
  ExtDlgs, AdvChartViewGDIP, AdvChartGDIP, Menus;

type
  TSettingsMode = (smIntraday, smPeriod);
  TForm1 = class(TForm)
    PopupMenu1: TPopupMenu;
    AdvOfficePager1: TPageControl;
    AdvOfficePage2: TTabSheet;
    AdvChartView2: TAdvChartView;
    AdvOfficePage3: TTabSheet;
    racker1: TMenuItem;
    Visible1: TMenuItem;
    Intraday1: TMenuItem;
    Period1: TMenuItem;
    Properties1: TMenuItem;
    AdvChartPanesEditorDialog1: TAdvChartPanesEditorDialog;
    Save1: TMenuItem;
    Savepanestobitmap1: TMenuItem;
    Printpanes1: TMenuItem;
    OpenDialog1: TOpenDialog;
    SavePictureDialog1: TSavePictureDialog;
    Settings1: TMenuItem;
    Load1: TMenuItem;
    Settings2: TMenuItem;
    SaveDialog1: TSaveDialog;
    TabSheet1: TTabSheet;
    AdvGDIPChartView1: TAdvGDIPChartView;
    StringGrid1: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure LoadIntraDay;
    procedure LoadPeriod;
    procedure FormMove(var Msg: TWMMove); message WM_MOVE;
    procedure Line3Click(Sender: TObject);
    procedure Area3Click(Sender: TObject);
    procedure Histogram3Click(Sender: TObject);
    procedure Candlestick1Click(Sender: TObject);
    procedure Bar1Click(Sender: TObject);
    procedure Line2Click(Sender: TObject);
    procedure Area2Click(Sender: TObject);
    procedure Histogram2Click(Sender: TObject);
    procedure Bar3Click(Sender: TObject);
    procedure Line1Click(Sender: TObject);
    procedure Area1Click(Sender: TObject);
    procedure Histogram1Click(Sender: TObject);
    procedure Bar2Click(Sender: TObject);
    procedure AdvChartView2PaneMoved(Sender: TObject; FromPosition,
      ToPosition: Integer);
    procedure OHLC1Click(Sender: TObject);
    procedure Line5Click(Sender: TObject);
    procedure Area5Click(Sender: TObject);
    procedure Histogram5Click(Sender: TObject);
    procedure Bar5Click(Sender: TObject);
    procedure Line4Click(Sender: TObject);
    procedure Area4Click(Sender: TObject);
    procedure Histogram4Click(Sender: TObject);
    procedure Bar4Click(Sender: TObject);
    procedure AdvChartView2PaneSized(Sender: TObject; CurrentPaneIndex,
      MovingPaneIndex: Integer; var CurrentNewSize, MovingNewSize: Integer;
      var Allow: Boolean);
    procedure AdvChartView2TrackerClose(Sender: TObject; var CanClose: Boolean);
    procedure Visible1Click(Sender: TObject);
    procedure Intraday1Click(Sender: TObject);
    procedure Period1Click(Sender: TObject);
    procedure AdvGlowButton1Click(Sender: TObject);
    procedure Properties1Click(Sender: TObject);
    procedure Properties2Click(Sender: TObject);
    procedure Properties3Click(Sender: TObject);
    procedure Savepanestobitmap1Click(Sender: TObject);
    procedure Printpanes1Click(Sender: TObject);
    procedure Settings1Click(Sender: TObject);
    procedure Settings2Click(Sender: TObject);
    procedure AdvGDIPChartView1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AdvGDIPChartView1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure AdvGDIPChartView1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    lastxval: integer;
    intraday:boolean;
    selectedpaneId: integer;
    FMode: TSettingsMode;
  public
    { Public declarations }
    procedure LoadGrid(filename: string);
    function StrToFloatEx(s: string): double;
  end;

var
  Form1: TForm1;
  MouseDownOnAnnotation, MouseOnAnnotation: Boolean;
  CurrentAnnotationIndex: integer;  

implementation

{$R *.dfm}

procedure TForm1.AdvChartView2PaneMoved(Sender: TObject; FromPosition,
  ToPosition: Integer);
begin
  // set X-axis visible on bottom pane only
  AdvChartView2.Panes[0].XAxis.Size := 0;
  AdvChartView2.Panes[1].XAxis.Size := 0;
  AdvChartView2.Panes[2].XAxis.Size := 50;
end;

procedure TForm1.AdvChartView2PaneSized(Sender: TObject; CurrentPaneIndex,
  MovingPaneIndex: Integer; var CurrentNewSize, MovingNewSize: Integer;
  var Allow: Boolean);
var
  th: integer;
begin
  // prevent that pane is sized smaller than X-axis size
  with AdvChartView2.Panes[CurrentPaneIndex] do
  begin
    if XAxis.BottomSize <> 0 then
    begin
      th := CurrentNewSize + MovingNewSize;
      if (CurrentNewSize < xaxis.bottomSize + 3) then
      begin
        CurrentNewSize := xaxis.bottomSize + 3;
        MovingNewSize := th - CurrentNewSize;
      end;
    end;
  end;
end;

procedure TForm1.AdvChartView2TrackerClose(Sender: TObject;
  var CanClose: Boolean);
begin
  // hide tracker form instead of closing
  CanClose := false;
  AdvChartView2.Tracker.Visible := false;
  Visible1.Checked := false;
end;

procedure TForm1.AdvGDIPChartView1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  MouseDownOnAnnotation := MouseOnAnnotation;
end;

procedure TForm1.AdvGDIPChartView1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  i: integer;
  CurrentPointIndex: integer;
begin
  with AdvGDIPChartView1.Panes[0] do
  begin
    with Series[2] do
    begin
      if not MouseDownOnAnnotation then
      begin
        for I := 0 to Annotations.Count - 1 do
        begin
          with Annotations[I] do
          begin
            if (X > GetDrawPoint(DisplayIndex).X - 5) and (X < GetDrawPoint(DisplayIndex).X + 5) then
            begin
              Screen.Cursor := crHandPoint;
              MouseOnAnnotation := true;
              CurrentAnnotationIndex := I;
            end
            else
            begin
              Screen.Cursor := crArrow;
              MouseOnAnnotation := false;
              CurrentAnnotationIndex := -1;
            end;
          end;
        end;
      end
      else
      begin
        AdvGDIPChartView1.BeginUpdate;
        if CurrentAnnotationIndex <> - 1 then
        begin
          CurrentPointIndex := Min(Range.RangeTo, Max(0, Range.RangeFrom + Round((X - Chart.Series.SeriesRectangle.Left)/ Chart.XScale)));
          Annotations[CurrentAnnotationIndex].PointIndex := CurrentPointIndex;
          Annotations[CurrentAnnotationIndex].Text := 'Value on point ' + inttostr(CurrentPointIndex) +' : ' + floattostr(Series[2].GetChartPoint(CurrentPointIndex).SingleValue);
        end;
        AdvGDIPChartView1.EndUpdate;
      end;
    end;
  end;
end;

procedure TForm1.AdvGDIPChartView1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Screen.Cursor := crArrow;
  MouseDownOnAnnotation := false;
  MouseOnAnnotation := false;
end;

procedure TForm1.AdvGlowButton1Click(Sender: TObject);
begin
//
end;

procedure TForm1.Area1Click(Sender: TObject);
begin
  TChartPane(AdvChartView2.Panes.FindItemID(2)).Series[0].ChartType := ctArea;
  AdvChartView2.Invalidate;
end;

procedure TForm1.Area2Click(Sender: TObject);
begin
  TChartPane(AdvChartView2.Panes.FindItemID(1)).Series[2].ChartType := ctArea;
  AdvChartView2.Invalidate;
end;

procedure TForm1.Area3Click(Sender: TObject);
begin
  TChartPane(AdvChartView2.Panes.FindItemID(0)).Series[0].ChartType := ctArea;
  AdvChartView2.Invalidate;
end;

procedure TForm1.Area4Click(Sender: TObject);
begin
  TChartPane(AdvChartView2.Panes.FindItemID(1)).Series[1].ChartType := ctArea;
  AdvChartView2.Invalidate;
end;

procedure TForm1.Area5Click(Sender: TObject);
begin
  TChartPane(AdvChartView2.Panes.FindItemID(1)).Series[0].ChartType := ctArea;
  AdvChartView2.Invalidate;
end;


procedure TForm1.Bar1Click(Sender: TObject);
begin
  TChartPane(AdvChartView2.Panes.FindItemID(0)).Series[0].ChartType := ctBar;
  AdvChartView2.Invalidate;
end;

procedure TForm1.Bar2Click(Sender: TObject);
begin
  TChartPane(AdvChartView2.Panes.FindItemID(2)).Series[0].ChartType := ctBar;
  AdvChartView2.Invalidate;
end;

procedure TForm1.Bar3Click(Sender: TObject);
begin
  TChartPane(AdvChartView2.Panes.FindItemID(1)).Series[2].ChartType := ctBar;
  AdvChartView2.Invalidate;
end;

procedure TForm1.Bar4Click(Sender: TObject);
begin
  TChartPane(AdvChartView2.Panes.FindItemID(1)).Series[1].ChartType := ctBar;
  AdvChartView2.Invalidate;
end;

procedure TForm1.Bar5Click(Sender: TObject);
begin
  TChartPane(AdvChartView2.Panes.FindItemID(1)).Series[0].ChartType := ctBar;
  AdvChartView2.Invalidate;
end;

procedure Split(const Delimiter: Char;
    Input: string;
    const Strings: TStrings) ;
begin
  Assert(Assigned(Strings)) ;
  Strings.Clear;
  Strings.Delimiter := Delimiter;
  Strings.DelimitedText := Input;
end;

procedure TForm1.LoadPeriod;
var
  I: Integer;
  A: TStringList;
  Year, Month, Day: Word;
  ts: TDateTime;
begin
  FMode := smPeriod;
  intraday := false;

  AdvChartView2.BeginUpdate;

  {$IF COMPILERVERSION > 21}
  FormatSettings.DecimalSeparator := '.';
  FormatSettings.ThousandSeparator := ',';
  FormatSettings.DateSeparator := '/';
  FormatSettings.ShortDateFormat := 'mm/dd/yy';
  {$ELSE}
  DecimalSeparator := '.';
  ThousandSeparator := ',';
  DateSeparator := '/';
  ShortDateFormat := 'mm/dd/yy';
  {$ENDIF}

  // if only 2 series in 2nd pane, add one
  if AdvChartview2.PaneByID[1].Series.Count = 2 then
  begin
    with AdvChartView2.PaneByID[1].Series[0] do
    begin
      ValueWidthType := wtPercentage;
      ChartType := ctStackedBar;
    end;
    with AdvChartView2.PaneByID[1].Series[1] do
    begin
      ValueWidthType := wtPercentage;
      ChartType := ctStackedBar;
    end;

    AdvChartview2.PaneByID[1].Series.Add;

    with AdvChartView2.PaneByID[1].Series[2] do
    begin
      LineColor := clPurple;
      BorderColor := clPurple;
      Color := clPurple;
      ColorTo := clPurple;
      GradientDirection := cgdHorizontal;
      GradientSteps := 100;
      ChartType := ctStackedBar;
      ValueWidthType := wtPercentage;
      ValueWidth := 50;
      XAxis.Visible := false;
    end;
  end;

  // set autorange type for series
  AdvChartview2.PaneByID[0].Series[0].AutoRange := arEnabled;

  AdvChartview2.PaneByID[1].Series[0].AutoRange := arCommon;
  AdvChartview2.PaneByID[1].Series[1].AutoRange := arCommon;
  AdvChartview2.PaneByID[1].Series[2].AutoRange := arCommon;

  AdvChartview2.PaneByID[2].Series[0].AutoRange := arEnabled;

  // set serie legend text
  AdvChartview2.PaneByID[0].Series[0].LegendText := 'Price';
  AdvChartview2.PaneByID[1].Series[0].LegendText := 'ADX';
  AdvChartview2.PaneByID[1].Series[1].LegendText := '+DI';
  AdvChartview2.PaneByID[1].Series[2].LegendText := '-DI';
  AdvChartview2.PaneByID[2].Series[0].LegendText := 'Volume';

  // set x-axis type for series & formatting
  AdvChartview2.PaneByID[0].XAxis.UnitType := utDay;
  AdvChartview2.PaneByID[0].Series[0].XAxis.MajorUnitTimeFormat := 'd';
  AdvChartview2.PaneByID[0].Series[0].XAxis.DateTimeFormat := 'mmm';
  AdvChartview2.PaneByID[1].XAxis.UnitType := utDay;
  AdvChartview2.PaneByID[1].Series[0].XAxis.MajorUnitTimeFormat := 'd';
  AdvChartview2.PaneByID[1].Series[0].XAxis.DateTimeFormat := 'mmm';
  AdvChartview2.PaneByID[1].Series[1].XAxis.DateTimeFormat := 'mmm';
  AdvChartview2.PaneByID[1].Series[2].XAxis.DateTimeFormat := 'mmm';
  AdvChartview2.PaneByID[1].Series[1].XAxis.MajorUnitTimeFormat := 'd';
  AdvChartview2.PaneByID[1].Series[2].XAxis.MajorUnitTimeFormat := 'd';
  AdvChartview2.PaneByID[2].XAxis.UnitType := utDay;
  AdvChartview2.PaneByID[2].Series[0].XAxis.DateTimeFormat := 'mmm';
  AdvChartview2.PaneByID[2].Series[0].XAxis.MajorUnitTimeFormat := 'd';

  AdvChartview2.PaneByID[2].Series[0].ChartType := ctHistogram;

  // clear previous serie data
  AdvChartView2.ClearPaneSeries;

  // load series in chart panes
  A := TStringList.Create;
  for I := 1 to StringGrid1.RowCount - 1 do
  begin
    decodedate(strtodate(stringgrid1.Cells[1,I]), year,month,day);

    ts := EncodeDate(Year,Month,Day);

    AdvChartview2.PaneByID[0].Series[0].AddMultiPoints(StrToFloatEx(StringGrid1.Cells[4,I]),
                                     StrToFloatEx(StringGrid1.Cells[5,I]),
                                     StrToFloatEx(StringGrid1.Cells[3,I]),
                                     StrToFloatEx(StringGrid1.Cells[6,I]),
                                     ts);

    AdvChartview2.PaneByID[1].Series[0].AddSinglePoint(StrToFloatEx(StringGrid1.Cells[8,I]),
                                      ts, StringGrid1.Cells[8,I] <> '');

    AdvChartview2.PaneByID[1].Series[1].AddSinglePoint(StrToFloatEx(StringGrid1.Cells[9,I]),
      ts, StringGrid1.Cells[9,I] <> '');

    AdvChartview2.PaneByID[1].Series[2].AddSinglePoint(StrToFloatEx(StringGrid1.Cells[10, I]),
      ts, StringGrid1.Cells[10,I] <> '');

    if StrToFloatEx(StringGrid1.Cells[3,I]) > StrToFloatEx(StringGrid1.Cells[6,I]) then
      AdvChartview2.PaneByID[2].Series[0].AddSinglePoint(StrToFloatEx(StringGrid1.Cells[7,I]), ts, clRed)
    else
      AdvChartview2.PaneByID[2].Series[0].AddSinglePoint(StrToFloatEx(StringGrid1.Cells[7,I]), ts, clBlue);
  end;
  A.Free;

  // set range to display initially
  AdvChartView2.SetPanesRange(300,550);

  AdvChartView2.EndUpdate;
end;

procedure TForm1.LoadIntraDay;
var
  I: Integer;
  A: TStringList;
  Year, Month, Day: Word;
  Hour, Minute: Word;
  ts: TDateTime;

begin
  FMode := smIntraday;
  intraday := true;
  {$IF COMPILERVERSION > 21}
  FormatSettings.DecimalSeparator := '.';
  FormatSettings.ThousandSeparator := ',';
  FormatSettings.DateSeparator := '/';
  {$ELSE}
  DecimalSeparator := '.';
  ThousandSeparator := ',';
  DateSeparator := '/';
  {$ENDIF}
  AdvChartView2.BeginUpdate;

  // set autorange type for series
  AdvChartview2.PaneByID[0].Series[0].AutoRange := arEnabled;
  AdvChartview2.PaneByID[1].Series[0].AutoRange := arCommon;
  AdvChartview2.PaneByID[1].Series[1].AutoRange := arCommon;
  AdvChartview2.PaneByID[2].Series[0].AutoRange := arEnabled;

  // set serie legend text
  AdvChartview2.PaneByID[0].Series[0].LegendText := 'Price';
  AdvChartview2.PaneByID[1].Series[0].LegendText := '%K(141)';
  AdvChartview2.PaneByID[1].Series[1].LegendText := '%D(3)';
  AdvChartview2.PaneByID[2].Series[0].LegendText := 'CCI(20C)';

  // clear previous serie data
  AdvChartView2.ClearPaneSeries;

  // if serie left from Period display, remove it
  if AdvChartview2.PaneByID[1].Series.Count = 3 then
    AdvChartview2.PaneByID[1].Series[2].Free;

  // set x-axis type for series & formatting
  AdvChartview2.PaneByID[0].Series[0].XAxis.DateTimeFormat := 'dd/mm';
  AdvChartview2.PaneByID[0].XAxis.UnitType := utMinute;
  AdvChartview2.PaneByID[0].Series[0].XAxis.MajorUnitTimeFormat := 'hh:nn';
  AdvChartview2.PaneByID[1].XAxis.UnitType := utMinute;
  AdvChartview2.PaneByID[1].Series[0].XAxis.MajorUnitTimeFormat := 'hh:nn';
  AdvChartview2.PaneByID[1].Series[1].XAxis.MajorUnitTimeFormat := 'hh:nn';
  AdvChartview2.PaneByID[1].Series[0].XAxis.DateTimeFormat := 'dd/mm';
  AdvChartview2.PaneByID[1].Series[1].XAxis.DateTimeFormat := 'dd/mm';
  AdvChartview2.PaneByID[2].XAxis.UnitType := utMinute;
  AdvChartview2.PaneByID[2].Series[0].XAxis.MajorUnitTimeFormat := 'hh:nn';
  AdvChartview2.PaneByID[2].Series[0].XAxis.DateTimeFormat := 'dd/mm';

  AdvChartview2.PaneByID[2].Series[0].ChartType := ctLine;

  // load series in chart panes
  A := TStringList.Create;
  for I := 1 to StringGrid1.RowCount - 1 do
  begin
    with AdvChartView2 do
    begin
     Split('/', StringGrid1.Rows[I].Strings[1], A) ;
     Year := strtoint(A[2]);
     Month := strtoint(A[0]);
     Day := strtoint(A[1]);
     Split(':', StringGrid1.Rows[I].Strings[2], A) ;
     Hour := strtoint(A[0]);
     Minute := strtoint(A[1]);

     ts := EncodeDateTime(Year, Month, Day, Hour, Minute, 0, 0);

     AdvChartview2.PaneByID[0].Series[0].AddMultiPoints(StrToFloatEx(StringGrid1.Cells[4,I]),
                                       StrToFloatEx(StringGrid1.Cells[5,I]),
                                       StrToFloatEx(StringGrid1.Cells[3,I]),
                                       StrToFloatEx(StringGrid1.Cells[6,I]),
                                       ts);

     AdvChartview2.PaneByID[1].Series[0].AddSinglePoint(StrToFloatEx(StringGrid1.Cells[8,I]),
       ts, StringGrid1.Cells[8,I] <> '');

     AdvChartview2.PaneByID[1].Series[1].AddSinglePoint(StrToFloatEx(StringGrid1.Cells[9,I]),
       ts, StringGrid1.Cells[9,I] <> '');

     AdvChartview2.PaneByID[2].Series[0].AddSinglePoint(StrToFloatEx(StringGrid1.Cells[7,I]),
       ts, StringGrid1.Cells[7,I] <> '')
    end;
  end;

  A.Free;

  // set range to display initially
  AdvChartView2.SetPanesRange(1200,1600);
  AdvChartView2.EndUpdate;
end;

procedure TForm1.OHLC1Click(Sender: TObject);
begin
  TChartPane(AdvChartView2.Panes.FindItemID(0)).Series[0].ChartType := ctOHLC;
  AdvChartView2.Invalidate;
end;

function TForm1.StrToFloatEx(s: string): double;
begin
  if s = '' then
    Result := 0
  else
    Result := StrToFloat(s);

end;

procedure TForm1.LoadGrid(filename: string);
var
  sl: tstringlist;
  tf: textfile;
  s:string;
  i: integer;
begin
  assignfile(tf,filename);
  {$i-}
  reset(tf);
  {$i+}
  if ioresult <> 0 then
    raise Exception.Create('Could not open file '+ filename);

  sl := tstringlist.Create;

  i := 0;
  stringgrid1.RowCount := 2;

  while not eof(tf) do
  begin
    readln(tf,s);
    sl.Delimiter := ',';
    sl.CommaText := s;
    stringgrid1.ColCount := sl.Count;

    if i >= stringgrid1.Rowcount then
      stringgrid1.RowCount := stringgrid1.RowCount + 1;
      
    stringgrid1.Rows[i].Assign(sl);
    inc(i);
  end;

  closefile(tf);
  sl.Free;
end;

procedure TForm1.Period1Click(Sender: TObject);
begin
  LoadGrid('IBM_DATA.csv');
  LoadPeriod;
end;

procedure TForm1.Printpanes1Click(Sender: TObject);
begin
  with printer do
  begin
    BeginDoc;
    AdvChartView2.PrintAllPanes(Printer.Canvas,Rect(0, 0, printer.PageWidth, printer.PageHeight));
    EndDoc;
  end;
end;

procedure TForm1.Properties1Click(Sender: TObject);
begin
  AdvChartPanesEditorDialog1.Execute;
end;

procedure TForm1.Properties2Click(Sender: TObject);
begin
  selectedpaneId := 1;
end;

procedure TForm1.Properties3Click(Sender: TObject);
begin
  selectedpaneId := 2;
end;

procedure TForm1.Savepanestobitmap1Click(Sender: TObject);
begin
  if SavePictureDialog1.Execute then
  begin
    AdvChartView2.SaveAllPanesToBitmap(SavePictureDialog1.FileName,1280,1024);
    showMessage('Saved');
  end;
end;

procedure TForm1.Settings1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    AdvChartView2.SaveToFile(SaveDialog1.FileName);
    showMessage('Saved');
  end;
end;

procedure TForm1.Settings2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Advchartview2.Beginupdate;
    AdvChartView2.LoadFromFile(OpenDialog1.FileName);
    if FMode = smIntraday then
    begin
      LoadGrid('ES#F_Data_Intraday.csv');
      LoadIntraDay;
    end
    else
    begin
      LoadGrid('IBM_DATA.csv');
      LoadPeriod;
    end;
  end;
  AdvChartView2.EndUpdate;
end;

procedure TForm1.Visible1Click(Sender: TObject);
begin
  AdvChartView2.Tracker.Visible := not Visible1.Checked;
  Visible1.Checked := not Visible1.Checked;
end;

procedure TForm1.Candlestick1Click(Sender: TObject);
begin
  TChartPane(AdvChartView2.Panes.FindItemID(0)).Series[0].ChartType := ctCandleStick;
  AdvChartView2.Invalidate;
end;

{
procedure TForm1.CheckBox10Click(Sender: TObject);
begin
  //AdvChartView1.Panes[1].Splitter.Visible := CheckBox10.Checked;
end;

procedure TForm1.CheckBox11Click(Sender: TObject);
begin
  //AdvChartView1.Panes[0].Navigator.Visible := CheckBox11.Checked;
end;

procedure TForm1.CheckBox12Click(Sender: TObject);
begin
//  AdvChartView1.Panes[1].Legend.visible := CheckBox12.Checked;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  AdvChartView1.PanesSynched := CheckBox1.Checked;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
  AdvChartView1.VerticalCrossHairsSynched := CheckBox2.Checked;
end;

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
  AdvChartView1.Panes[0].AllowMoving := CheckBox3.Checked;
end;

procedure TForm1.CheckBox4Click(Sender: TObject);
begin
  AdvChartView1.Panes[1].AllowMoving := CheckBox4.Checked;
end;

procedure TForm1.CheckBox5Click(Sender: TObject);
begin
  AdvChartView1.Panes[0].VerticalCrossHair := CheckBox5.Checked;
end;

procedure TForm1.CheckBox6Click(Sender: TObject);
begin
  AdvChartView1.Panes[1].VerticalCrossHair := CheckBox6.Checked;
end;

procedure TForm1.CheckBox7Click(Sender: TObject);
begin
  AdvChartView1.Panes[0].Legend.visible := CheckBox7.Checked;
end;

procedure TForm1.CheckBox8Click(Sender: TObject);
begin
  AdvChartView1.Panes[1].Navigator.Visible := CheckBox8.Checked;
end;

procedure TForm1.CheckBox9Click(Sender: TObject);
begin
  AdvChartView1.Panes[0].Splitter.Visible := CheckBox9.Checked;
end;

procedure TForm1.ColorBox1Change(Sender: TObject);
begin
  AdvChartView1.ZoomColor := ColorBox1.Selected;
end;
}
{
procedure TForm1.ComboBox1Change(Sender: TObject);
var
  I: integer;
begin
 for I := 0 to AdvChartView1.Panes[1].Series.Count - 1 do
  begin
    case ComboBox1.ItemIndex of
    0: AdvChartView1.Panes[1].Series.Items[I].ChartType := ctLine;
    1: AdvChartView1.Panes[1].Series.Items[I].ChartType := ctArea;
    2: AdvChartView1.Panes[1].Series.Items[I].ChartType := ctBar;
    3: AdvChartView1.Panes[1].Series.Items[I].ChartType := ctLineBar;
    4: AdvChartView1.Panes[1].Series.Items[I].ChartType := ctHistogram;
    5: AdvChartView1.Panes[1].Series.Items[I].ChartType := ctLineHistogram;
    6: AdvChartView1.Panes[1].Series.Items[I].ChartType := ctCandleStick;
    7: AdvChartView1.Panes[1].Series.Items[I].ChartType := ctLineCandleStick
    end;
  end;
  AdvChartView1.Invalidate;
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to AdvChartView1.Panes[0].Series.Count - 1 do
  begin
    case ComboBox2.ItemIndex of
    0: AdvChartView1.Panes[0].Series.Items[I].ChartType := ctLine;
    1: AdvChartView1.Panes[0].Series.Items[I].ChartType := ctArea;
    2: AdvChartView1.Panes[0].Series.Items[I].ChartType := ctBar;
    3: AdvChartView1.Panes[0].Series.Items[I].ChartType := ctLineBar;
    4: AdvChartView1.Panes[0].Series.Items[I].ChartType := ctHistogram;
    5: AdvChartView1.Panes[0].Series.Items[I].ChartType := ctLineHistogram;
    6: AdvChartView1.Panes[0].Series.Items[I].ChartType := ctCandleStick;
    7: AdvChartView1.Panes[0].Series.Items[I].ChartType := ctLineCandleStick
    end;
  end;
  AdvChartView1.Invalidate;
end;

procedure TForm1.ComboBox3Change(Sender: TObject);
begin
  case ComboBox3.ItemIndex of
  0: advChartView1.Panes[0].XAxis.UnitType := utNumber;
  1: advChartView1.Panes[0].XAxis.UnitType := utMonth;
  2: advChartView1.Panes[0].XAxis.UnitType := utDay;
  3: advChartView1.Panes[0].XAxis.UnitType := utYear;
  4: advChartView1.Panes[0].XAxis.UnitType := utMinute;
  5: advChartView1.Panes[0].XAxis.UnitType := utHour;
  end;
end;
 }

procedure TForm1.FormCreate(Sender: TObject);
var
  I: Integer;
  K: Double;
//var
//  I: integer;
begin
  AdvGDIPChartView1.ForceCursor := true;
  lastxval := 0;

  AdvChartView2.Tracker.Left := Self.Width - AdvChartView2.Tracker.Width * 2;

  {
  AdvStringGrid1.LoadFromCSV('IBM_DATA.csv');
  LoadPeriod;
  }

  FMode := smIntraday;

  LoadGrid('ES#F_Data_Intraday.csv');
  LoadIntraDay;

  AdvChartView2.Tracker.Left := 5;
  AdvChartView2.Tracker.Top := 30;

  //GDI+ Charttype band

    with AdvGDIPChartView1.Panes[0] do
    begin
      Range.RangeTo := 250;

      YGrid.SerieIndex := 0;
      YGrid.Visible := true;

      with Series.Add do
      begin
        ChartType := ctBand;
        Opacity := 150;
        OpacityTo := 150;
        GradientType := gtHatch;
        HatchStyle := HatchStyleForwardDiagonal;
        LineColor := clBlack;
        LineOpacity := 150;
        Color := clBlack;
        LegendText := 'a * sin(x) + delta [- delta]';
        ColorTo := clGreen;
        LineWidth := 1;
        AutoRange := arDisabled;
        Minimum := -40;
        Maximum := 40;
        K := 0;
        for I := 0 to 500 - 1 do
        begin
          AddDoublePoint(10 * sin(K) + 3, 10 * sin(K) - 3);
          K := K + 0.1;
        end;
      end;

      with Series.Add do
      begin
        ChartType := ctLine;
        LineColor := clWhite;
        LineWidth := 2;
        AutoRange := arDisabled;
        Minimum := -40;
        Maximum := 40;
        XAxis.Visible := false;
        YAxis.Visible := false;
        LegendText := 'a * sin(x) + b * sin(x)';
        K := 0;
        for I := 0 to 500 - 1 do
        begin
          AddSinglePoint(10 * sin(K) + 2 * sin(I));
          K := K + 0.1;
        end;
      end;

      with Series.Add do
      begin
        ChartType := ctLine;
        LineOpacity := 100;
        LineColor := clYellow;
        LineWidth := 2;
        AutoRange := arDisabled;
        Minimum := -40;
        Maximum := 40;
        XAxis.Visible := false;
        YAxis.Visible := false;
        LegendText := 'a * sin(x)';
        K := 0;
        for I := 0 to 500 - 1 do
        begin
          AddSinglePoint(10 * sin(K));
          K := K + 0.1;
        end;

        with Annotations.Add do
        begin
          Shape := asLine;
          PointIndex := 50;
          LineWidth := 2;
          LineColor := RGB(245,165,35);
          Arrow := arDoubleArrow;
          ArrowColor := RGB(245,165,35);
          Font.Size := 13;
          Font.Color := clBlack;
          Text := 'Value on point ' + inttostr(PointIndex) +' : ' + floattostr(Series[2].GetChartPoint(PointIndex).SingleValue);
        end;
      end;      
    end;

    AdvGDIPChartView1.PaneByName['ChartPane 0'].Background.GradientType := gtHatch;

end;

procedure TForm1.FormMove(var Msg: TWMMove);
begin
  inherited;

  if Assigned(AdvChartView2.Tracker.TrackerForm) then
  begin
    AdvChartView2.Tracker.BeginUpdate;
    AdvChartView2.Tracker.TrackerForm.Left := AdvChartView2.Tracker.Left + Msg.XPos - 2;
    AdvChartView2.Tracker.TrackerForm.Top := AdvChartView2.Tracker.Top + Msg.YPos + 4;
    AdvChartView2.Tracker.EndUpdate;
  end;
end;


procedure TForm1.Histogram1Click(Sender: TObject);
begin
  TChartPane(AdvChartView2.Panes.FindItemID(2)).Series[0].ChartType := ctHistogram;
  AdvChartView2.Invalidate;
end;

procedure TForm1.Histogram2Click(Sender: TObject);
begin
  TChartPane(AdvChartView2.Panes.FindItemID(1)).Series[2].ChartType := ctHistogram;
  AdvChartView2.Invalidate;
end;

procedure TForm1.Histogram3Click(Sender: TObject);
begin
  TChartPane(AdvChartView2.Panes.FindItemID(0)).Series[0].ChartType := ctHistogram;
  AdvChartView2.Invalidate;
end;

procedure TForm1.Histogram4Click(Sender: TObject);
begin
  TChartPane(AdvChartView2.Panes.FindItemID(1)).Series[1].ChartType := ctHistogram;
  AdvChartView2.Invalidate;
end;

procedure TForm1.Histogram5Click(Sender: TObject);
begin
  TChartPane(AdvChartView2.Panes.FindItemID(1)).Series[0].ChartType := ctHistogram;
  AdvChartView2.Invalidate;
end;

procedure TForm1.Intraday1Click(Sender: TObject);
begin
  LoadGrid('ES#F_Data_Intraday.csv');
  LoadIntraDay;
end;

procedure TForm1.Line1Click(Sender: TObject);
begin
  TChartPane(AdvChartView2.Panes.FindItemID(2)).Series[0].ChartType := ctLine;
  AdvChartView2.Invalidate;
end;

procedure TForm1.Line2Click(Sender: TObject);
begin
  TChartPane(AdvChartView2.Panes.FindItemID(1)).Series[2].ChartType := ctLine;
  AdvChartView2.Invalidate;
end;

procedure TForm1.Line3Click(Sender: TObject);
begin
  TChartPane(AdvChartView2.Panes.FindItemID(0)).Series[0].ChartType := ctLine;
  AdvChartView2.Invalidate;
end;
  procedure TForm1.Line4Click(Sender: TObject);
begin
  TChartPane(AdvChartView2.Panes.FindItemID(1)).Series[1].ChartType := ctLine;
  AdvChartView2.Invalidate;
end;

procedure TForm1.Line5Click(Sender: TObject);
begin
  TChartPane(AdvChartView2.Panes.FindItemID(1)).Series[0].ChartType := ctLine;
  AdvChartView2.Invalidate;
end;

end.
