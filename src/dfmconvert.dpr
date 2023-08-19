program dfmconvert;

uses
  Forms,
  MainForm in 'MainForm.pas' {fromMain},
  FormatUtils in 'FormatUtils.pas',
  DfmConverting in 'DfmConverting.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'DFM Converter';
  Application.CreateForm(TfromMain, fromMain);
  Application.Run;
end.
