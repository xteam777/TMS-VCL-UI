program DBDemo;

uses
  Forms,
  UDBDemo in 'UDBDemo.pas' {Form30};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm30, Form30);
  Application.Run;
end.
