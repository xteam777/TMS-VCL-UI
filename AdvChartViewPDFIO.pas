{***************************************************************************}
{ TAdvChartView PDF IO component                                            }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 2016                                               }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of TMS software.                                    }
{***************************************************************************}

unit AdvChartViewPDFIO;

{$I TMSDEFS.INC}

interface

uses
  Classes, AdvChartView, AdvChartViewPDFLib, AdvChartViewCustomPDFIO;

const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 0; // Minor version nr.
  REL_VER = 0; // Release nr.
  BLD_VER = 0; // Build nr.

  // Version history
  // v1.0.0.0 : First release

type
  {$IFDEF DELPHIXE2_LVL}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  {$ENDIF}
  TAdvChartViewPDFIO = class(TAdvChartViewCustomPDFIOComponent)
  private
    FChart: TAdvChartView;
  protected
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    function GetVersionNr: Integer; override;
    procedure GeneratePDF(AFileName: string); override;
  published
    property Chart: TAdvChartView read FChart write FChart;
  end;


implementation

uses
  Windows, SysUtils, Graphics, JPEG;

procedure GetAspectSize(var AWidth: Single; var AHeight: Single; AOriginalWidth: Single; AOriginalHeight: Single; ANewWidth: Single; ANewHeight: Single;
  AAspectRatio: Boolean = True; AStretch: Boolean = False; ACropping: Boolean = False);
var
  arc, ar: Single;
begin
  if AAspectRatio then
  begin
    if (AOriginalWidth > 0) and (AOriginalHeight > 0) and (ANewWidth > 0) and (ANewHeight > 0) then
    begin
      if (AOriginalWidth < ANewWidth) and (AOriginalHeight < ANewHeight) and (not AStretch) then
      begin
        AWidth := AOriginalWidth;
        AHeight := AOriginalHeight;
      end
      else
      begin
        if AOriginalWidth / AOriginalHeight < ANewWidth / ANewHeight then
        begin
          AHeight := ANewHeight;
          AWidth := ANewHeight * AOriginalWidth / AOriginalHeight;
        end
        else
        begin
          AWidth := ANewWidth;
          AHeight := ANewWidth * AOriginalHeight / AOriginalWidth;
        end;
      end;
    end
    else
    begin
      AWidth := 0;
      AHeight := 0;
    end;
  end
  else
  begin
    if AStretch then
    begin
      AWidth := ANewWidth;
      AHeight := ANewHeight;
    end
    else
    begin
      AWidth := AOriginalWidth;
      AHeight := AOriginalHeight;

      if ACropping then
      begin
        if (AWidth >= AHeight) and (AWidth > 0) then
        begin
          AHeight := AOriginalWidth / AWidth * AHeight;
          AWidth := AOriginalWidth;
        end
        else
        if (AHeight >= AWidth) and (AHeight > 0) then
        begin
          AWidth := AOriginalHeight / AHeight * AWidth;
          AHeight := AOriginalHeight;
        end;

        if AHeight = 0 then
          ar := 1
        else
          ar := AWidth / AHeight;

        if AOriginalHeight = 0 then
          arc := 1
        else
          arc := AOriginalWidth / AOriginalHeight;

        if (ar < 1) or (arc > ar) then
        begin
          AHeight := AOriginalWidth / ar;
          AWidth := AOriginalWidth;
        end
        else
        begin
          AWidth := ar * AOriginalHeight;
          AHeight := AOriginalHeight;
        end;
      end;
    end;
  end;
end;

{ TAdvChartViewPDFIO }

function TAdvChartViewPDFIO.GetVersionNr: Integer;
begin
  Result := MakeLong(MakeWord(BLD_VER, REL_VER), MakeWord(MIN_VER, MAJ_VER));
end;

procedure TAdvChartViewPDFIO.Notification(AComponent: TComponent;
  AOperation: TOperation);
begin
  inherited;
  if (AComponent = FChart) and (AOperation = opRemove) then
    FChart := nil;
end;

procedure TAdvChartViewPDFIO.GeneratePDF(AFileName: string);
var
  pdf: TPDFDocument;
  m: TPdfMarges;
  bmp: TBitmap;
  img: TJPEGImage;
  ms: TMemoryStream;
  ir: TImageRef;
  w, h: Single;
begin
  if not Assigned(Fchart) then
    raise Exception.Create('No Chart assigned');

  bmp := Chart.GenerateBitmap(Chart.Width, Chart.Height);
  img := TJPEGImage.Create;
  try
    img.Assign(bmp);
  finally
    bmp.Free;
  end;

  w := img.Width;
  h := img.Height;

  ms := TMemoryStream.Create;
  try
    img.SaveToStream(ms);
    ms.Position := 0;
  finally
    img.Free;
  end;

  pdf := TPDFDocument.Create(Self);
  try
    if PageLayout = plLandscape then
    begin
      pdf.Width := PageSize.Height;
      pdf.Height := PageSize.Width;
    end
    else
    begin
      pdf.Width := PageSize.Width;
      pdf.Height := PageSize.Height;
    end;

    // Set Marges
    m.Top := 15;
    m.Bottom:= 15;
    m.Left:= 15;
    m.Right:= 15;

    pdf.CurrentPage.Marges := m;

    pdf.Header := (Header);
    if Assigned(OnSetHeader) then
      OnSetHeader(pdf.CurrentPage, pdf.Pages.Count - 1);

    pdf.Footer := (Footer);
    if Assigned(OnSetFooter) then
      OnSetFooter(pdf.CurrentPage, pdf.Pages.Count - 1);

    pdf.MetaData := MetaData;

    GetAspectSize(w, h, w, h, pdf.Width - m.Right - m.Left, pdf.Height - m.Bottom - m.Top);

    pdf.CurrentPage.AddJpeg(Round((pdf.Width - w) / 2), Round((pdf.Height - h) / 2), Round(w), Round(h), ms);
    ir.Image := ms;
    pdf.CurrentPage.ImagesList.Add(ir);

    pdf.GeneratePDF(AFileName);
  finally
    pdf.Free;
  end;
end;

end.
