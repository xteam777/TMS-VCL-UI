program AdvChartGDIPPieDemo;

uses
  Forms,
  GDIPPieDemo in 'GDIPPieDemo.pas' {Form19};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm19, Form19);
  Application.Run;
end.
