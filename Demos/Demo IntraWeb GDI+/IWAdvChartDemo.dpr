program IWAdvChartDemo;

uses
  Forms,
  IWMain,
  IWAdvChartDemoUnit in 'IWAdvChartDemoUnit.pas' {IWForm35: TIWAppForm},
  ServerController in 'ServerController.pas' {IWServerController: TIWServerControllerBase},
  UserSessionUnit in 'UserSessionUnit.pas' {IWUserSession: TIWUserSessionBase};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TformIWMain, formIWMain);
  Application.Run;
end.
