{***************************************************************************}
{ TAdvChartView component                                                   }
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

unit AdvChartViewRegDE;

interface

{$I TMSDEFS.INC}

uses
  Classes, SysUtils, AdvChart, AdvChartView,
  AdvChartTypeSelector, AdvChartPaneEditor, AdvChartViewDE,
  AdvChartSerieEditor, AdvChartSpin, AdvChartSelectors, AdvChartAnnotationEditor,
  AdvChartFillPreview, AdvChartPaneEditorGDIP, AdvChartSerieEditorGDIP,
  AdvChartAnnotationEditorGDIP
  {$IFDEF DELPHI6_LVL}
  , DesignIntf, DesignEditors
  {$ELSE}
  , DsgnIntf
  {$ENDIF}
  ;


type
  {$IFDEF DELPHIXE2_LVL}
  TAdvChartViewEditor = class(TChartDefaultEditor)
  {$ELSE}
  TAdvChartViewEditor = class(TDefaultEditor)
  {$ENDIF}
  protected
  {$IFNDEF DELPHI6_LVL}
    procedure EditProperty(PropertyEditor: TPropertyEditor;
                           var Continue, FreeEditor: Boolean); override;
  {$ELSE}
    procedure EditProperty(const PropertyEditor:IProperty; var Continue:Boolean); override;
  {$ENDIF}
  end;


procedure Register;

implementation

{$IFNDEF DELPHI6_LVL}
procedure TAdvChartViewEditor.EditProperty(PropertyEditor: TPropertyEditor;
                                      var Continue, FreeEditor: Boolean);
{$ELSE}
procedure TAdvChartViewEditor.EditProperty(const PropertyEditor:IProperty;
                                      var Continue:Boolean);
{$ENDIF}
var
  PropName: string;
begin
  PropName := PropertyEditor.GetName;
  if (CompareText(PropName, 'PANES') = 0) then
  begin
    PropertyEditor.Edit;
    Continue := False;
  end;
end;


procedure Register;
begin
  RegisterComponentEditor(TAdvChartView, TAdvChartViewEditor);
  RegisterComponents('TMS Charts',[TAdvChartTypeSelector]);
  RegisterComponents('TMS Charts',[TAdvChartPanesEditorDialog]);
  RegisterComponents('TMS Charts',[TAdvChartSeriesEditorDialog]);
  RegisterComponents('TMS Charts',[TAdvChartAnnotationsEditorDialog]);
  RegisterComponents('TMS Charts',[TAdvChartPanesEditorDialogGDIP]);
  RegisterComponents('TMS Charts',[TAdvChartSeriesEditorDialogGDIP]);
  RegisterComponents('TMS Charts',[TAdvChartAnnotationsEditorDialogGDIP]);
  RegisterClass(TAdvChartSpinEdit);
  RegisterClass(TAdvChartFillPreview);
  RegisterComponents('TMS Charts', [TAdvChartPenStyleSelector,
                                      TAdvChartBrushStyleSelector,
                                      TAdvChartShadowSelector,
                                      TAdvChartTableBorderSelector,
                                      TAdvChartGradientDirectionSelector,
                                      TAdvChartPenWidthSelector,
                                      TAdvChartColorSelector,
                                      TAdvChartTextColorSelector,
                                      TAdvChartToolSelector,
                                      TAdvChartTableSelector,
                                      TAdvChartCharacterSelector]);
end;


end.

