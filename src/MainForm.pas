unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, KOL, ComCtrls, ExtCtrls, AppEvnts;

type
  TfromMain = class(TForm)
    edDir: TEdit;
    OpenDialog1: TOpenDialog;
    bGoClick: TButton;
    ProgressBar1: TProgressBar;
    mmLog: TMemo;
    pnTop: TPanel;
    ApplicationEvents1: TApplicationEvents;
    Label1: TLabel;
    StatusBar1: TStatusBar;
    Label2: TLabel;
    edExt: TEdit;
    Label3: TLabel;
    procedure bGoClickClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edExtExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edDirExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }       
    procedure AddToLog(s: string);
    procedure ClearLog;
    procedure ChangeStatus(s: string);
  end;

var
  fromMain: TfromMain;

implementation

uses DfmConverting, AppParameters;

{$R *.dfm}

function GetFileVersion(filename: string = ''; const Fmt: string = '%d.%d.%d.%d'): string;
var
  iBufferSize: DWORD;
  iDummy: DWORD;
  pBuffer: Pointer;
  pFileInfo: Pointer;
  iVer: array[1..4] of word;
begin
  // set default value
  if filename = '' then
    FileName := Application.ExeName;
  Result := '';
  // get size of version info (0 if no version info exists)
  iBufferSize := GetFileVersionInfoSize(PChar(filename), iDummy);
  if (iBufferSize > 0) then
  begin
    Getmem(pBuffer, iBufferSize);
    try
    // get fixed file info
      GetFileVersionInfo(PChar(filename), 0, iBufferSize, pBuffer);
      VerQueryValue(pBuffer, '\', pFileInfo, iDummy);
    // read version blocks
      iVer[1] := HiWord(PVSFixedFileInfo(pFileInfo)^.dwFileVersionMS);
      iVer[2] := LoWord(PVSFixedFileInfo(pFileInfo)^.dwFileVersionMS);
      iVer[3] := HiWord(PVSFixedFileInfo(pFileInfo)^.dwFileVersionLS);
      iVer[4] := LoWord(PVSFixedFileInfo(pFileInfo)^.dwFileVersionLS);
    finally
      Freemem(pBuffer);
    end;
    // format result string
    Result := Format(Fmt, [iVer[1], iVer[2], iVer[3], iVer[4]]);
  end;
end;

//===================================
//== ПЕРЕВОД DFM ИЗ UNICODE В ANSI ==
//===================================
procedure TfromMain.bGoClickClick(Sender: TObject);
var
  DFM: string;
  DL: PDirList;
  Flag, UnFlag: Boolean; // Есть Unicode строка
  Idx, x: Integer;
  st : string;
  FR, FW: TextFile;
  
	//=============================
	procedure InitSBMsg(pc: PChar);
	var
	  Idx :Integer;
	begin
		ChangeStatus(pc);
		AddToLog(pc);

		x := 0;
		ProgressBar1.Position := 0;
		ProgressBar1.Max := 0;

		for Idx := 0 to DL.Count - 1 do
			ProgressBar1.Max := ProgressBar1.Max + DLFileSize(DL, Idx);
	end;
	//=============================

begin
  DFM := '*.' + Ext;   // *.dfm
  DL := NewDirListEx(DirPath, DFM, 0);
  DL.Sort([sdrByExt]);
  
  ClearLog;          
  ChangeStatus('Selected catalog - ' + edDir.Text);
  AddToLog('Selected catalog - ' + edDir.Text);
  AddToLog('File extention - ' + DFM);
  AddToLog('');

  if (DL.Count = 0) then
  begin
    ChangeStatus(Ext + '-files not found.');
    AddToLog('');
    AddToLog(Ext + '-files not found.');
    AddToLog('');
    DL.Free;
    Exit; // Выход, если dfm в каталоге нет.
  end;

  InitSBMsg('Searching...');

  //== Анализ файлов ==//

  UnFlag := FALSE;
  for Idx := 0 to DL.Count - 1 do
  begin
    Application.ProcessMessages();
    Flag := FALSE;
    ChangeStatus('Searching... ' + PChar(DL.Names[Idx]));
    AddToLog('  ' + PChar(DL.Names[Idx]));

    AssignFile(FR, DirPath + DL.Names[Idx]);
    Reset(FR);
    while not Eof(FR) do
    begin
      Application.ProcessMessages();
      ReadLn(FR, st);
      x := x + Length(st) + 2;
      ProgressBar1.Position := ProgressBar1.Position + x;
      Flag := isStrUnic(st);
      if Flag then
      begin
        CloseFile(FR);
        UnFlag := TRUE;
        //Размер файла минус считанные байты
        ProgressBar1.Position := ProgressBar1.Position + (DLFileSize(DL, Idx) - x);
        MoveFileEx(PChar(DirPath + DL.Names[Idx]),
          PChar(DirPath + DL.Names[Idx] + UNIC_EXT), MOVEFILE_REPLACE_EXISTING);
        break; // Выход из чтения файла
      end;
    end; // while

    if not Flag then
      CloseFile(FR);
  end; // for

  if not UnFlag then
  begin
    ChangeStatus(Ext + '-files do not contain Unicode.');
    AddToLog('');
    AddToLog('Done. ' + Ext + '-files do not contain Unicode.');
    AddToLog('');
    DL.Free;
    Exit;
  end;

  DL.ScanDirectory(DirPath, DFM + UNIC_EXT, 0);

  if DL.Count = 0 then
  begin
    ChangeStatus('Files *.' + Ext + '.unic not found');
    AddToLog('');
	  AddToLog('Files *.' + Ext + '.unic not found');
	  AddToLog('');
	
    DL.Free;
    Exit;
  end;


  InitSBMsg('Converting...');

  //== Замена Unicode в Ansi в *.dfm_unic-файлах ==//

  for Idx := 0 to DL.Count - 1 do
  begin
    Application.ProcessMessages();
    ChangeStatus(PChar(DL.Names[Idx]));
    AddToLog('  ' + PChar(DL.Names[Idx]));
    st := DirPath + DL.Names[Idx];
    AssignFile(FR, st);
    Reset(FR); // Чтение
    SetLength(st, Length(st) - 5);
    AssignFile(FW, st);
    Rewrite(FW); // Запись

    while not Eof(FR) do
    begin
      Application.ProcessMessages();
      ReadLn(FR, st);
      ProgressBar1.Position := ProgressBar1.Position + Length(st) + 2;
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
  ChangeStatus('Done.');
  AddToLog('');
  AddToLog('Done.');
  AddToLog('');

end;

procedure TfromMain.AddToLog(s :string);
begin
  mmLog.Lines.Add(s);
end;

procedure TfromMain.ClearLog;
begin
  mmLog.Lines.Clear;
end;

procedure TfromMain.ChangeStatus(s: string);
begin
  StatusBar1.Panels[0].Text := s;
end;


procedure TfromMain.FormShow(Sender: TObject);
begin
  ChangeStatus('');
  edExt.Text := Ext;
  edDir.Text := DirPath;
end;

procedure TfromMain.FormCreate(Sender: TObject);
begin
  fromMain.Caption := APP_NAME + ' (ver.' + GetFileVersion('', '%d.%d.%d') + ')';
end;

procedure TfromMain.edExtExit(Sender: TObject);
begin
  SetExtention(edExt.Text);
  edExt.Text := Ext;
end;

procedure TfromMain.edDirExit(Sender: TObject);
begin
  SetDirPath(edDir.Text);
  edDir.Text := DirPath;
end;

procedure TfromMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveToINI;
end;


end.

