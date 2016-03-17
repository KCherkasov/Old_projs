program gr_contr;

uses
  Forms,
  grcontr in 'grcontr.pas' {frmGrContr};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmGrContr, frmGrContr);
  Application.Run;
end.
