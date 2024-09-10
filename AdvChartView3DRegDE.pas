{***************************************************************************}
{ TAdvChartView3D component                                                 }
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

unit AdvChartView3DRegDE;

interface

{$I TMSDEFS.INC}

uses
  Classes, SysUtils, AdvChartView3D, AdvChartSerieEditor3D, AdvChartPointEditor3D
  {$IFDEF DELPHI6_LVL}
  , DesignIntf, DesignEditors
  {$ELSE}
  , DsgnIntf
  {$ENDIF}
  ;


type
  TAdvChartView3DEditor = class(TDefaultEditor)
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
procedure TAdvChartView3DEditor.EditProperty(PropertyEditor: TPropertyEditor;
                                      var Continue, FreeEditor: Boolean);
{$ELSE}
procedure TAdvChartView3DEditor.EditProperty(const PropertyEditor:IProperty;
                                      var Continue:Boolean);
{$ENDIF}
var
  PropName: string;
begin
  PropName := PropertyEditor.GetName;
  if (CompareText(PropName, 'SERIES') = 0) or (CompareText(PropName, 'ITEMS') = 0) then
  begin
    PropertyEditor.Edit;
    Continue := False;
  end;
end;


procedure Register;
begin
  RegisterComponentEditor(TAdvChartView3D, TAdvChartView3DEditor);
  RegisterComponents('TMS Charts',[TAdvChartSeriesEditorDialog3D]);
  RegisterComponents('TMS Charts',[TAdvChartPointEditorDialog3D]);
end;


end.

