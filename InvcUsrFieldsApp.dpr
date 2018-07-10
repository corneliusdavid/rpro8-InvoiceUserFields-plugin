program InvcUsrFieldsApp;

uses
  Forms,
  ufrmInvcUsrFieldsAppMain in 'ufrmInvcUsrFieldsAppMain.pas' {frmInvcUsrFieldsAppMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmInvcUsrFieldsAppMain, frmInvcUsrFieldsAppMain);
  Application.Run;
end.
