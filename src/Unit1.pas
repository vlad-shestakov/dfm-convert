unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, mirror, mckCtrls, mckObjs, KOL;

type
  TForm1 = class(TForm)
    OpenDirDialog1: TKOLOpenDirDialog;
    bOpenDir: TKOLButton;
    ProgressBar1: TKOLProgressBar;
    OpenDialog1: TOpenDialog;
    Button1: TButton;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure bOpenDirClick(Sender: PObj);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  //ShowMessage('Привет');
  //if not OpenDirDialog1.Execute then
  {if not OpenDialog1.Execute then
  begin
    Exit;
    //ShowMessage('Привет');
  end;
  {}

  //ShowMessage(OpenDialog1.FileName);
  //if not DirectoryExists(OpenDirDialog1.Path) then
  if not DirectoryExists(OpenDialog1.FileName) then
  if not DirectoryExists(Edit1.Text) then
  begin
    MessageBox(0, PChar('Не могу открыть каталог' + #13 + #10 +
      //OpenDirDialog1.Path), PChar(Form.Caption), MB_ICONSTOP);
      Edit1.Text), PChar(Form1.Caption), MB_ICONSTOP);
    Exit;
  end;


end;

//====================
//== ВЫБОР КАТАЛОГА ==
//====================
procedure TForm1.bOpenDirClick(Sender: PObj);
begin

  ShowMessage('Привет');
  //if not OpenDirDialog1.Execute then
  if not OpenDialog1.Execute then
  begin
    //Exit;
    ShowMessage('Привет');
  end;

  {

  if not DirectoryExists(OpenDirDialog1.Path) then
  begin
    MessageBox(0, PChar('Не могу открыть каталог' + #13 + #10 +
      OpenDirDialog1.Path), PChar(Form.Caption), MB_ICONSTOP);
    Exit;
  end;

  Form.StatusText[0] := '';
  Form.StatusText[1] := '';
  ProgressBar1.Progress := 0;
  DirPath := IncludeTrailingPathDelimiter(OpenDirDialog1.Path);
  lDir.Caption := MinimizeName(DirPath, lDir.Canvas.Handle, 256);
  OpenDirDialog1.InitialPath := DirPath;
  }
end;

end.


