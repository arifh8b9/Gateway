program Gateway_PDAM_JEMBER_NEW;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  //UnitSetting in 'UnitSetting.pas' {frmSetting},
  UnitUtil in 'UnitUtil.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  //Application.CreateForm(TfrmSetting, frmSetting);
  Application.Run;
end.
