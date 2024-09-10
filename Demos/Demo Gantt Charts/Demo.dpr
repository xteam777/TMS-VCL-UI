program Demo;

uses
  Forms,
  UDemo in 'UDemo.pas' {Form303};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm303, Form303);
  Application.Run;
end.
