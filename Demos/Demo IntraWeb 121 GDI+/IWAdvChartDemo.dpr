program IWAdvChartDemo;

uses
  Forms,
  IWStart,
  IWAdvChartDemoUnit in 'IWAdvChartDemoUnit.pas' {IWForm35: TIWAppForm},
  ServerController in 'ServerController.pas' {IWServerController: TIWServerControllerBase},
  UserSessionUnit in 'UserSessionUnit.pas' {IWUserSession: TIWUserSessionBase};

{$R *.res}

begin
  TIWStart.Execute(True);
end.
