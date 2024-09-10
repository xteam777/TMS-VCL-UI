program Demo;

uses
  Forms,
  UDemo in 'UDemo.pas' {Form825};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm825, Form825);
  Application.Run;
end.
