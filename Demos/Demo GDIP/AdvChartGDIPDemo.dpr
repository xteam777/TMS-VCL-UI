program AdvChartGDIPDemo;

uses
  Forms,
  FinChartGDIP in 'FinChartGDIP.pas' {Form10};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm10, Form10);
  Application.Run;
end.
