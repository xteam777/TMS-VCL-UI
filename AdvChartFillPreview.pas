{***************************************************************************}
{ TAdvChartFillPreview component                                            }
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

unit AdvChartFillPreview;

interface

uses
  AdvChart, AdvChartGDIP, Classes, Graphics, Controls, Windows;

type
  {$IFDEF DELPHIXE2_LVL}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  {$ENDIF}
  TAdvChartFillPreview = class(TCustomControl)
  private
    FBorderColor: TColor;
    FGradientType: TChartGradientType;
    FOpacityTo: integer;
    FHatchStyle: THatchStyle;
    FChartGDIPicture: TChartGDIPPicture;
    FAngle: integer;
    FOpacityFrom: integer;
    FColorTo: TColor;
    FBorderStyle: TDashStyle;
    FBorderWidth: integer;
    FColorFrom: TColor;
    FText: string;
    procedure SetAngle(const Value: integer);
    procedure SetBorderColor(const Value: TColor);
    procedure SetBorderStyle(const Value: TDashStyle);
    procedure SetBorderWidth(const Value: integer);
    procedure SetChartGDIPicture(const Value: TChartGDIPPicture);
    procedure SetColorFrom(const Value: TColor);
    procedure SetColorTo(const Value: TColor);
    procedure SetHatchStyle(const Value: THatchStyle);
    procedure SetOpacityFrom(const Value: integer);
    procedure SetOpacityTo(const Value: integer);
    procedure SetGradientType(const Value: TChartGradientType);
    procedure SetText(const Value: string);
    function IsTextStored: Boolean;
  protected
    procedure Paint; override;
    procedure FontChanged(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Align;
    property GradientType: TChartGradientType read FGradientType write SetGradientType default gtSolid;
    property ColorFrom: TColor read FColorFrom write SetColorFrom default clWhite;
    property ColorTo: TColor read FColorTo write SetColorTo default clNone;
    property OpacityFrom: integer read FOpacityFrom write SetOpacityFrom default 255;
    property OpacityTo: integer read FOpacityTo write SetOpacityTo default 255;
    property Font;
    property ParentFont;
    property HatchStyle: THatchStyle read FHatchStyle write SetHatchStyle default HatchStyleHorizontal;
    property Angle: integer read FAngle write SetAngle default 0;
    property Image: TChartGDIPPicture read FChartGDIPicture write SetChartGDIPicture;
    property BorderColor: TColor read FBorderColor write SetBorderColor default clBlack;
    property BorderWidth: integer read FBorderWidth write SetBorderWidth default 1;
    property BorderStyle: TDashStyle read FBorderStyle write SetBorderStyle default DashStyleSolid;
    property Text: string read FText write SetText stored IsTextStored;
  end;

implementation

{ TAdvChartFillPreview }

constructor TAdvChartFillPreview.Create(AOwner: TComponent);
begin
  inherited;
  FGradientType := gtSolid;
  FColorFrom := clWhite;
  FColorTo := clNone;
  FOpacityFrom := 255;
  FOpacityTo := 255;
  FHatchStyle := HatchStyleHorizontal;
  FChartGDIPicture := TChartGDIPPicture.Create;
  FAngle := 0;
  FBorderWidth := 1;
  FBorderColor := clBlack;
  FBorderStyle := DashStyleSolid;
  Width := 100;
  Height := 100;
  Font.OnChange := FontChanged;
  FText := 'Preview';
end;

destructor TAdvChartFillPreview.Destroy;
begin

  FChartGDIPicture.Free;
  inherited;
end;

procedure TAdvChartFillPreview.FontChanged(Sender: TObject);
begin
  Repaint;
end;

function TAdvChartFillPreview.IsTextStored: Boolean;
begin
  Result := FText <> 'Preview';
end;

procedure TAdvChartFillPreview.Paint;
var
  fp: TGDIPFillParameters;
  graphics: TGPGraphics;
  r: TRect;
  DTSTYLE: DWORD;
begin
  inherited;

  r := ClientRect;
  DTSTYLE := DT_SINGLELINE or DT_VCENTER or DT_CENTER;
  Canvas.Brush.Style := bsClear;
  Canvas.Font.Assign(Font);


  DrawText(Canvas.Handle, pchar(FText), Length(FText), r, DTSTYLE);

  Canvas.Brush.Style := bsSolid;
    
  graphics := TGPGraphics.Create(Canvas.Handle);
  graphics.SetSmoothingMode(SmoothingModeAntiAlias);

  fp.GT := GradientType;
  fp.Graphics := graphics;
  fp.R := MakeRect(0,0,Width-1, Height-1);
  fp.ColorFrom := ColorToRGB(ColorFrom);
  fp.ColorTo := ColorToRGB(ColorTo);
  fp.OpacityFrom := OpacityFrom;
  fp.OpacityTo := OpacityTo;
  fp.BorderColor := BorderColor;
  fp.BorderWidth := BorderWidth;
  fp.BorderStyle := BorderStyle;
  fp.HatchStyle := HatchStyle;
  fp.Image := FChartGDIPicture;
  fp.Fillpath := false;
  fp.Angle := Angle;
  FillGDIP(fp);
  graphics.Free;

end;

procedure TAdvChartFillPreview.SetAngle(const Value: integer);
begin
  FAngle := Value;
  Repaint;
end;

procedure TAdvChartFillPreview.SetBorderColor(const Value: TColor);
begin
  FBorderColor := Value;
  Repaint;
end;

procedure TAdvChartFillPreview.SetBorderStyle(const Value: TDashStyle);
begin
  FBorderStyle := Value;
  Repaint;
end;

procedure TAdvChartFillPreview.SetBorderWidth(const Value: integer);
begin
  FBorderWidth := Value;
  Repaint;
end;

procedure TAdvChartFillPreview.SetChartGDIPicture(
  const Value: TChartGDIPPicture);
begin
  FChartGDIPicture.Assign(Value);
end;

procedure TAdvChartFillPreview.SetColorFrom(const Value: TColor);
begin
  FColorFrom := Value;
  Repaint;
end;

procedure TAdvChartFillPreview.SetColorTo(const Value: TColor);
begin
  FColorTo := Value;
  Repaint;
end;


procedure TAdvChartFillPreview.SetGradientType(const Value: TChartGradientType);
begin
  FGradientType := Value;
  Repaint;
end;

procedure TAdvChartFillPreview.SetHatchStyle(const Value: THatchStyle);
begin
  FHatchStyle := Value;
  Repaint;
end;

procedure TAdvChartFillPreview.SetOpacityFrom(const Value: integer);
begin
  FOpacityFrom := Value;
  Repaint;
end;

procedure TAdvChartFillPreview.SetOpacityTo(const Value: integer);
begin
  FOpacityTo := Value;
  Repaint;
end;

procedure TAdvChartFillPreview.SetText(const Value: string);
begin
  FText := Value;
  Repaint;
end;

end.
