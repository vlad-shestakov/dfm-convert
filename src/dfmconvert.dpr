program dfmconvert;

uses
  Forms,
  MainForm in 'MainForm.pas' {fromMain},
  DfmConverting in 'DfmConverting.pas',
  AppParameters in 'AppParameters.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'DFM Converter';
  Application.CreateForm(TfromMain, fromMain);
  Application.Run;
end.
