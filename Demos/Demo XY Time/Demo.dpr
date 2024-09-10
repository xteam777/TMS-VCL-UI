program Demo;

uses
  Forms,
  UDemo in 'UDemo.pas' {Form10};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm10, Form10);
  Application.Run;
end.
