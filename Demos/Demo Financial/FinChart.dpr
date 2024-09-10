program FinChart;

uses
  Forms,
  UFinChart in 'UFinChart.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
