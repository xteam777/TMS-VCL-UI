{*************************************************************************}
{ TAdvChartTypeSelector component                                         }
{ for Delphi & C++Builder                                                 }
{                                                                         }
{ written by TMS Software                                                 }
{           copyright © 2013                                              }
{           Email : info@tmssoftware.com                                  }
{           Web : http://www.tmssoftware.com                              }
{                                                                         }
{ The source code is given as is. The author is not responsible           }
{ for any possible damage done due to the use of this code.               }
{ The component can be freely used in any application. The complete       }
{ source code remains property of the author and may not be distributed,  }
{ published, given or sold in any form as such. No parts of the source    }
{ code can be included in any other component or application without      }
{ written authorization of the author.                                    }
{*************************************************************************}

unit AdvChartTypeSelector;

{$I TMSDEFS.INC}

interface

uses
  Math, SysUtils, Classes, Graphics, Windows, Dialogs, StdCtrls, Controls, AdvChart, Messages;

type
  {$IFDEF DELPHIXE2_LVL}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  {$ENDIF}
  TAdvChartTypeSelector = class(TCustomControl)
  private
    FColorDown: TColor;
    FColorHot: TColor;
    FColor: TColor;
    FColorToDown: TColor;
    FColorToHot: TColor;
    FColorTo: TColor;
    FGradientSteps: integer;
    FGradientDirection: TChartGradientDirection;
    FChartType: TChartType;
    FChart: TAdvChart;
    FSelected: Boolean;
    procedure SetChartType(const Value: TChartType);
    procedure SetColor(const Value: TColor);
    procedure SetColorDown(const Value: TColor);
    procedure SetColorHot(const Value: TColor);
    procedure SetSelected(const Value: Boolean);
    procedure SetColorTo(const Value: TColor);
    procedure SetColorToDown(const Value: TColor);
    procedure SetColorToHot(const Value: TColor);
    procedure SetGradientdirection(const Value: TChartGradientDirection);
    procedure SetGradientSteps(const Value: integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure ClearChartSerie;
    procedure AddSinglePoints;
    procedure AddChartSerie;
    procedure AddMultiPoints;
    procedure AddPiePoints;
    procedure AddPointsWith2Series;
    procedure AddPoints;
    procedure Changed;
    procedure Paint; override;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    property Selected: Boolean read FSelected write SetSelected;
    procedure Resize; override;
  published
    property ChartType: TChartType read FChartType write SetChartType;
    property ColorDown: TColor read FColorDown write SetColorDown;
    property ColorHot: TColor read FColorHot write SetColorHot;
    property Color: TColor read FColor write SetColor;
    property ColorToDown: TColor read FColorToDown write SetColorToDown;
    property ColorToHot: TColor read FColorToHot write SetColorToHot;
    property ColorTo: TColor read FColorTo write SetColorTo;
    property GradientDirection: TChartGradientDirection read FGradientDirection write SetGradientdirection;
    property GradientSteps: integer read FGradientSteps write SetGradientSteps;
    property OnMouseDown;
    {$IFDEF DELPHI9_LVL}
    property OnMouseEnter;
    property OnMouseLeave;
    {$ENDIF}
    property Tag;
    property ShowHint;
  end;

implementation


{ TAdvChartTypeSelector }

procedure TAdvChartTypeSelector.AddChartSerie;
begin
  if FChart.Series.Count = 1 then
    Fchart.Series.Add;
end;

procedure TAdvChartTypeSelector.AddMultiPoints;
var
  I: integer;
begin
  Fchart.Series[0].ClearPoints;
  for I := 0 to 6 do
  begin
    if ChartType = ctBoxPlot then
      FChart.Series[0].AddMultiPoints(RandomRange(0, 3), RandomRange(4, 7), RandomRange(10, 15),  RandomRange(17, 23), RandomRange(23, 26), '')
    else
      FChart.Series[0].AddMultiPoints(RandomRange(20, 30), RandomRange(0, 10), RandomRange(10, 20), RandomRange(10, 20));
  end;
end;

procedure TAdvChartTypeSelector.AddPiePoints;
const
  colors1: array[0..6] of TColor = (clRed, clBlue, clGreen, clPurple, clMaroon, clLime, clOlive);
  colors2: array[0..6] of TColor = (clDkGray, clLtGray, clLime, clOlive, clLime, clRed, clAqua);
  colors3: array[0..6] of TColor = (clBlue, clLime, clFuchsia, clAqua, clRed, clGreen, clPurple);
var
  I: integer;
begin
  Fchart.Series[0].ClearPoints;
  for I := 0 to 6 do
  begin
    FChart.Series[0].AddPiePoints(RandomRange(20, 30), RandomRange(20, 30), '',colors1[I], colors2[I], 0, true);
  end;
end;

procedure TAdvChartTypeSelector.AddPoints;
var
  I: integer;
begin
  FChart.Series[0].ClearPoints;
  for I := 0 to 6 do
  begin
    case ChartType of
      ctError, ctBubble, ctScaledBubble: FChart.Series[0].AddPoints(RandomRange(10, 30), RandomRange(-5, -7), RandomRange(5, 7));
      ctArrow, ctScaledArrow: FChart.Series[0].AddPoints(RandomRange(10, 30), RandomRange(-10, -15), RandomRange(10, 15));
    end;
  end;
end;

procedure TAdvChartTypeSelector.AddPointsWith2Series;
var
  I: Integer;
begin
  FChart.Series[0].AutoRange := arDisabled;
  Fchart.Series[0].Color := RGB(128, 160, 186);
  Fchart.Series[1].Color := RGB(237, 237, 237);
  FChart.Series[1].AutoRange := arDisabled;
  case ChartType of
    ctStackedBar, ctStackedArea:
    begin
      FChart.Series[1].Maximum := 60;
      FChart.Series[0].Maximum := 60;
    end;
    ctStackedPercArea, ctStackedPercBar:
    begin
      FChart.Series[1].Maximum := 120;
      FChart.Series[0].Maximum := 120;
    end;
  end;
  FChart.Series[1].Minimum := -10;
  FChart.Series[0].Minimum := -10;
  FChart.Series[1].ClearPoints;
  FChart.Series[1].ValueWidth := 70;
  FChart.Series[1].ValueWidthType := wtPercentage;
  for I := 0 to 6 do
  begin
    Randomize;
    FChart.Series[1].AddSingleXYPoint((I * 1.5), RandomRange(10, 30), TColor(RGB(Random(255), Random(255), Random(255))));
  end;
end;

procedure TAdvChartTypeSelector.AddSinglePoints;
var
  I: integer;
begin
  FChart.Series[0].Minimum := -20;
  FChart.Series[0].Maximum := 20;
  Fchart.Series[0].ClearPoints;
  for I := 0 to 6 do
    FChart.Series[0].AddSingleXYPoint((I * 1.5), RandomRange(-20, 20));
end;

procedure TAdvChartTypeSelector.Assign(Source: TPersistent);
begin
  inherited;
  FColorDown := (Source as TAdvChartTypeSelector).ColorDown;
  FColorHot := (Source as TAdvChartTypeSelector).ColorHot;
  FColor := (Source as TAdvChartTypeSelector).Color;
  FColorToDown := (Source as TAdvChartTypeSelector).ColorToDown;
  FColorToHot := (Source as TAdvChartTypeSelector).ColorToHot;
  FColorTo := (Source as TAdvChartTypeSelector).ColorTo;
  FChartType := (Source as TAdvChartTypeSelector).ChartType;
  FSelected := (Source as TAdvChartTypeSelector).Selected;
  FGradientSteps := (Source as TAdvChartTypeSelector).GradientSteps;
  FGradientDirection := (source as TAdvChartTypeSelector).GradientDirection;
end;

procedure TAdvChartTypeSelector.Changed;
begin
  Invalidate;
end;

procedure TAdvChartTypeSelector.ClearChartSerie;
begin
 if FChart.Series.Count = 2 then
   FChart.Series.Items[1].Free;

 FChart.Series.Items[0].Maximum := 30;
end;

procedure TAdvChartTypeSelector.CMMouseEnter(var Message: TMessage);
begin
  if not Selected then
  begin
    FChart.BackGround.Color := ColorHot;
    FChart.BackGround.ColorTo := ColorToHot;
    Changed;
  end;
end;

procedure TAdvChartTypeSelector.CMMouseLeave(var Message: TMessage);
begin
  if not Selected then
  begin
    FChart.BackGround.Color := Color;
    FChart.BackGround.ColorTo := ColorTo;    
    Changed;
  end;
end;

constructor TAdvChartTypeSelector.Create(AOwner: TComponent);
var
  I: Integer;
begin
  inherited;
  FChartType := ctLine;
  FColorDown := clNone;
  FColorHot := clNone;
  FColor := clNone;
  FColorToDown := clNone;
  FColortohot := clNone;
  FColorTo := clNone;
  FGradientSteps := 32;
  FGradientDirection := cgdVertical;

  FChart := TAdvChart.Create(nil);
  FChart.Series.Add.ChartType := FChartType;
  Fchart.BackGround.Color := clNone;
  Fchart.BackGround.ColorTo := clNone;
  FChart.BackGround.GradientDirection := cgdVertical;
  FChart.XAxis.Position := xNone;
  FChart.YAxis.Position := yNone;
  FChart.Legend.Visible := false;
  for I := 0 to 6 do
  begin
    Randomize;
    FChart.Series[0].AddSingleXYPoint((I * 1.5), RandomRange(10, 30), TColor(RGB(Random(255), Random(255), Random(255))));
  end;

  FChart.Series[0].ArrowColor := clWhite;

  FChart.Series[0].Pie.Size := Self.Width - 10;
  FChart.Series[0].Pie.LegendVisible := false;

  FChart.Series[0].WickColor := clBlack;
  FChart.Series[0].LineWidth := 0;
  FChart.Series[0].Marker.MarkerType := mNone;
  FChart.Series[0].Marker.MarkerSize := 7;
  FChart.Series[0].Marker.MarkerColor := clWhite;  

  FChart.Series[0].LineColor := clWhite;
  FChart.Series[0].BorderColor := clWhite;
  FChart.Series[0].Color := clWhite;

  FChart.Series[0].AutoRange := arDisabled;
  FChart.Series[0].Minimum := -10;
  FChart.Series[0].Maximum := 35;

  FChart.Range.RangeFrom := -1;
  FChart.Range.RangeTo := 7;

  FChart.Series[0].ValueWidth := 70;
  FChart.Series[0].ValueWidthType := wtPercentage;
  FChart.Series[0].Pie.ShowGrid := false;
  FChart.Series[0].YAxis.Visible := false;
end;

destructor TAdvChartTypeSelector.Destroy;
begin
  FChart.Free;
  inherited;
end;

procedure TAdvChartTypeSelector.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  FChart.BackGround.Color := ColorDown;
  FChart.BackGround.ColorTo := ColorToDown;
  Changed;
end;

procedure TAdvChartTypeSelector.Paint;
begin
  inherited;
  FChart.Draw(Canvas,ClientRect,1,1);
end;

procedure TAdvChartTypeSelector.Resize;
begin
  SetChartType(ChartType);
end;

procedure TAdvChartTypeSelector.SetChartType(const Value: TChartType);
var
  i: integer;
begin
  if FChartType <> value then
  begin
    FChart.Series.ChartMode := dmVertical;
    FChartType := Value;
    FChart.Series[0].ChartType := Value;
    FChart.Series[0].Marker.MarkerType := mNone;
    FChart.Series[0].LineWidth := 1;
    case Value of
      ctLine, ctXYLine:
      begin
        ClearChartSerie;
        FChart.Series.Items[0].LineWidth := 2;
      end;
      ctPie, ctDonut, ctHalfPie, ctHalfDonut, ctSizedPie, ctSizedHalfPie, ctSizedDonut, ctSizedHalfDonut,
      ctVarRadiusPie, ctVarRadiusHalfPie, ctVarRadiusDonut, ctVarRadiusHalfDonut, ctSpider, ctHalfSpider:
      begin
        ClearChartSerie;
        FChart.Series.Items[0].Pie.InnerSize := Self.Width div 3;
        FChart.Series.Items[0].Pie.Size := Self.Width - 5;
        AddPiePoints;
        FChart.Series.Items[0].Pie.ShowGrid := (ChartType = ctSpider) or (ChartType = ctHalfSpider);
        if FChart.Series.Items[0].Pie.ShowGrid then
        begin
          FChart.Series.Items[0].Marker.MarkerType := mCircle;
          FChart.Series.Items[0].Marker.MarkerColor := clRed;
          FChart.Series.Items[0].Marker.MarkerSize := 4;
        end
        else
          FChart.Series.Items[0].Marker.MarkerType := mNone;
      end;
      ctBand:
      begin
        ClearChartSerie;
        FChart.Series[0].ClearPoints;
        for I := 0 to 6 do
        begin
          Randomize;
          FChart.Series[0].AddDoublePoint(RandomRange(5, 10), RandomRange(15, 20));
        end;
      end;
      ctArea:
      begin
        ClearChartSerie;
      end;
      ctBar:
      begin
        ClearChartSerie;
      end;
      ctLineBar:
      begin
        ClearChartSerie;
      end;
      ctHistogram:
      begin
        ClearChartSerie;
      end;
      ctLineHistogram:
      begin
        ClearChartSerie;
      end;
      ctBoxPlot:
      begin
        FChart.Series.ChartMode := dmHorizontal;
        ClearChartSerie;
        AddMultiPoints;
      end;
      ctCandleStick:
      begin
        ClearChartSerie;
        AddMultiPoints;
      end;
      ctLineCandleStick:
      begin
        ClearChartSerie;
        AddMultiPoints;
      end;
      ctOHLC:
      begin
        ClearChartSerie;
        AddMultiPoints;
      end;
      ctMarkers, ctRenko, ctXYMarkers:
      begin
        FChart.Series[0].Marker.MarkerType := mSquare;
        ClearChartSerie;
      end;
      ctStackedBar:
      begin
        AddChartSerie;
        FChart.Series[1].ChartType := ctStackedBar;
        AddPointsWith2Series;
      end;
      ctStackedArea:
      begin
        AddChartserie;
        FChart.Series[1].ChartType := ctStackedArea;
        AddPointsWith2Series;
      end;
      ctStackedPercArea:
      begin
        AddChartserie;
        Fchart.Series[1].ChartType := ctStackedPercArea;
        AddPointsWith2Series;
      end;
      ctStackedPercBar:
      begin
        AddChartSerie;
        Fchart.Series[1].ChartType := ctStackedPercBar;
        AddPointsWith2Series;
      end;
      ctError:
      begin
        ClearChartSerie;
        AddPoints;
      end;
      ctArrow:
      begin
        ClearChartSerie;
        AddPoints;
      end;
      ctScaledArrow:
      begin
        ClearChartSerie;
        AddPoints;
      end;
      ctBubble:
      begin
        ClearChartSerie;
        AddPoints;
      end;
      ctScaledBubble:
      begin
        ClearChartSerie;
        AddPoints;
      end;
    end;
    Changed;
  end;

  FChart.InitializeChart(Canvas, ClientRect, 1, 1);
end;

procedure TAdvChartTypeSelector.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    FChart.BackGround.Color := Value;
    Changed;
  end;
end;

procedure TAdvChartTypeSelector.SetColorDown(const Value: TColor);
begin
  if FColorDown <> Value then
  begin
    FColorDown := Value;
    FChart.BackGround.Color := Value;
    Changed;
  end;
end;

procedure TAdvChartTypeSelector.SetColorHot(const Value: TColor);
begin
  if FColorHot <> Value then
  begin
    FColorHot := Value;
    FChart.BackGround.Color := Value;
    Changed;
  end;
end;

procedure TAdvChartTypeSelector.SetColorTo(const Value: TColor);
begin
  if FColorTo <> value then
  begin
    FColorTo := Value;
    FChart.BackGround.ColorTo := Value;
    Changed;
  end;
end;

procedure TAdvChartTypeSelector.SetColorToDown(const Value: TColor);
begin
  if FcolorToDown <> value then
  begin
    FColorToDown := Value;
    FChart.BackGround.ColorTo := Value;
    Changed;
  end;
end;

procedure TAdvChartTypeSelector.SetColorToHot(const Value: TColor);
begin
  if FcolorToHot <> Value then
  begin
    FColorToHot := Value;
    FChart.BackGround.ColorTo := Value;
    Changed;
  end;
end;

procedure TAdvChartTypeSelector.SetGradientdirection(
  const Value: TChartGradientDirection);
begin
  if FGradientDirection <> value then
  begin
    FGradientDirection := Value;
    FChart.BackGround.GradientDirection := value;
    Changed;
  end;
end;

procedure TAdvChartTypeSelector.SetGradientSteps(const Value: integer);
begin
  if FGradientSteps <> value then
  begin
    FGradientSteps := Value;
    FChart.BackGround.GradientSteps := value;
    Changed;
  end;
end;

procedure TAdvChartTypeSelector.SetSelected(const Value: Boolean);
begin
  if FSelected <> Value then
  begin
    FSelected := Value;

    case FSelected of
      true:
      begin
        FChart.BackGround.Color := FColorDown;
        FChart.BackGround.ColorTo := FColorToDown;
      end;
      false:
      begin
        FChart.BackGround.Color := FColor;
        FChart.BackGround.ColorTo := FColorTo;
      end;
    end;

    Changed;
  end;
end;

end.

