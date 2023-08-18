unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, KOL;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    OpenDialog1: TOpenDialog;
    bGoClick: TButton;
    procedure Button1Click(Sender: TObject);
    procedure bGoClickClick(Sender: TObject);
  private
    { Private declarations }      
    DirPath: string;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

//====================
//== ВЫБОР КАТАЛОГА ==
//====================
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
  //if not DirectoryExists(OpenDialog1.FileName) then
  if not DirectoryExists(Edit1.Text) then
  begin
    MessageBox(0, PChar('Не могу открыть каталог' + #13 + #10 +
      //OpenDirDialog1.Path), PChar(Form.Caption), MB_ICONSTOP);
      Edit1.Text), PChar(Form1.Caption), MB_ICONSTOP);
    Exit;
  end;

  //Form.StatusText[0] := '';
  //Form.StatusText[1] := '';
  //ProgressBar1.Progress := 0;
  //DirPath := IncludeTrailingPathDelimiter(OpenDirDialog1.Path);
  DirPath := IncludeTrailingPathDelimiter(Edit1.Text);
  //lDir.Caption := DirPath; //MinimizeName(DirPath, lDir.Canvas.Handle, 256);
  // OpenDirDialog1.InitialPath := DirPath;
  OpenDialog1.InitialDir := DirPath;

end;

//===================================
//== ПЕРЕВОД DFM ИЗ UNICODE В ANSI ==
//===================================
procedure TForm1.bGoClickClick(Sender: TObject);
const
  DFM = '*.dfm';
  UNIC = '.unic';
var
  DL: PDirList;
  Flag, UnFlag: Boolean; // Есть Unicode строка
  Idx, x: Integer;
  st : string;
  //FR, FW: Text;
  FR, FW: TextFile;
  
	//=============================
	procedure InitSBMsg(pc: PChar);
	var
	  Idx :Integer;
	begin
		ShowMessage('Привет');
		{
	  Form.StatusText[0] := pc;
	  x := 0;
	  ProgressBar1.Progress := 0;
	  ProgressBar1.MaxProgress := 0;
	  for Idx := 0 to DL.Count - 1 do
		ProgressBar1.MaxProgress := ProgressBar1.MaxProgress + DLFileSize(DL, Idx);
		}
	end;
	//=============================

begin
           
    ShowMessage('Привет');
	{

  DL := NewDirListEx(DirPath, DFM, 0);
  DL.Sort([sdrByExt]);

  if (DL.Count = 0) then
  begin
    Form.StatusText[0] := 'В каталоге нет dfm-файлов.';
    DL.Free;
    Exit; // Выход, если dfm в каталоге нет.
  end;

  InitSBMsg('Идет поиск...');

  //== Анализ файлов ==//

  UnFlag := FALSE;
  for Idx := 0 to DL.Count - 1 do
  begin
    Flag := FALSE;
    Form.StatusText[1] := PChar(DL.Names[Idx]);
    AssignFile(FR, DirPath + DL.Names[Idx]);
    Reset(FR);
    while not Eof(FR) do
    begin
      ReadLn(FR, st);
      x := x + Length(st) + 2;
      ProgressBar1.Progress := ProgressBar1.Progress + x;
      Flag := isStrUnic(st);
      if Flag then
      begin
        CloseFile(FR);
        UnFlag := TRUE;
        ProgressBar1.Progress := // Размер файла минус считанные байты
          ProgressBar1.Progress + (DLFileSize(DL, Idx) - x);
        MoveFileEx(PChar(DirPath + DL.Names[Idx]),
          PChar(DirPath + DL.Names[Idx] + UNIC), MOVEFILE_REPLACE_EXISTING);
        break; // Выход из чтения файла
      end;
    end; // while

    if not Flag then
      CloseFile(FR);
  end; // for

  if not UnFlag then
  begin
    Form.StatusText[0] := 'Unicode в dfm-файлах отсутствует.';
    DL.Free;
    Exit;
  end;

  DL.ScanDirectory(DirPath, DFM + UNIC, 0);

  if DL.Count = 0 then
  begin
    Form.StatusText[0] := 'Не могу найти файлы *.dfm.unic...';
    Form.StatusText[1] := 'ВНИМАНИЕ.';
    DL.Free;
    Exit;
  end;

  InitSBMsg('Идет замена...');

  //== Замена Unicode в Ansi в *.dfm_unic-файлах ==//

  for Idx := 0 to DL.Count - 1 do
  begin
    Form.StatusText[1] := PChar(DL.Names[Idx]);
    st := DirPath + DL.Names[Idx];
    AssignFile(FR, st);
    Reset(FR); // Чтение
    SetLength(st, Length(st) - 5);
    AssignFile(FW, st);
    Rewrite(FW); // Запись

    while not Eof(FR) do
    begin
      ReadLn(FR, st);
      ProgressBar1.Progress := ProgressBar1.Progress + Length(st) + 2;
      if isStrUnic(st) then
      begin
        //== Находим первый символ переводимой строки
        x := Pos('=', st) + 1;
        while (st[x] = #32) or (st[x] = '(') do
          Inc(x);
        st := StrUnic2Ansi(st);

        //== Расставляем <'>
        Insert(#39, st, x);
        x := Pos(')', st);
        if x = 0 then
          st := st + #39
        else
          Insert(#39, st, x);
      end;
      WriteLn(FW, st);
    end; // while

    CloseFile(FR);
    CloseFile(FW);
  end;   // for
  DL.Free;
  Form.StatusText[0] := 'Готово.';
	}
end;

end.


