unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, KOL, ComCtrls, ExtCtrls, AppEvnts;

type
  TfromMain = class(TForm)
    Button1: TButton;
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
    procedure Button1Click(Sender: TObject);
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

uses FormatUtils, DfmConverting, AppParameters;

{$R *.dfm}

//====================
//== ВЫБОР КАТАЛОГА ==
//====================
procedure TfromMain.Button1Click(Sender: TObject);
begin
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
  if not DirectoryExists(edDir.Text) then
  begin
    MessageBox(0, PChar('Can''t open Dir' + #13#10 +
		  //OpenDirDialog1.Path), PChar(Form.Caption), MB_ICONSTOP);
		  edDir.Text), PChar(fromMain.Caption), MB_ICONSTOP);
    Exit;
  end;

  //Form.StatusText[0] := '';
  //Form.StatusText[1] := '';
  ChangeStatus('Selected catalog - ' + edDir.Text);
  AddToLog('Selected catalog - ' + edDir.Text);
  AddToLog('');
  //ProgressBar1.Progress := 0;
  ProgressBar1.Position := 0;
  //DirPath := IncludeTrailingPathDelimiter(OpenDirDialog1.Path);
  //DirPath := IncludeTrailingPathDelimiter(edDir.Text);
  SetDirPath(edDir.Text);
  //lDir.Caption := DirPath; //MinimizeName(DirPath, lDir.Canvas.Handle, 256);
  // OpenDirDialog1.InitialPath := DirPath;
  // OpenDialog1.InitialDir := DirPath;

end;

//===================================
//== ПЕРЕВОД DFM ИЗ UNICODE В ANSI ==
//===================================
procedure TfromMain.bGoClickClick(Sender: TObject);
const
  UNIC = '.unic';
var
  DFM: string;
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
		//Form.StatusText[0] := pc;
		ChangeStatus(pc);
		AddToLog(pc);

		x := 0;
		  //ProgressBar1.Progress := 0;
		ProgressBar1.Position := 0;
		ProgressBar1.Max := 0;

		for Idx := 0 to DL.Count - 1 do
		begin
			  //ProgressBar1.MaxProgress := ProgressBar1.MaxProgress + DLFileSize(DL, Idx);
			  ProgressBar1.Max := ProgressBar1.Max + DLFileSize(DL, Idx);
		end;
	end;
	//=============================

begin
  DFM := '*.' + Ext;   // *.dfm
  DL := NewDirListEx(DirPath, DFM, 0);
  DL.Sort([sdrByExt]);
  ClearLog;          
  AddToLog('DFM - ' + DFM);

  if (DL.Count = 0) then
  begin
    //Form.StatusText[0] := 'В каталоге нет dfm-�
    ChangeStatus(Ext + '-files not found.');
    AddToLog('');
    AddToLog(Ext + '-files not found.');
    AddToLog('');
    DL.Free;
    Exit; // Выход, если dfm в каталоге нет.
  end;

  //InitSBMsg('Идет поиск...');
  InitSBMsg('Searching...');


  //== Анализ файлов ==//

  UnFlag := FALSE;
  for Idx := 0 to DL.Count - 1 do
  begin
    Application.ProcessMessages();
    Flag := FALSE;
    //Form.StatusText[1] := PChar(DL.Names[Idx]);
    ChangeStatus('Searching... ' + PChar(DL.Names[Idx]));
    AddToLog('  ' + PChar(DL.Names[Idx]));

    AssignFile(FR, DirPath + DL.Names[Idx]);
    Reset(FR);
    while not Eof(FR) do
    begin
      Application.ProcessMessages();
      ReadLn(FR, st);
      x := x + Length(st) + 2;
      //ProgressBar1.Progress := ProgressBar1.Progress + x;
      ProgressBar1.Position := ProgressBar1.Position + x;
      Flag := isStrUnic(st);
      if Flag then
      begin
        CloseFile(FR);
        UnFlag := TRUE;
        //Размер файла минус считанные байты
        //ProgressBar1.Progress := ProgressBar1.Progress + (DLFileSize(DL, Idx) - x);
        ProgressBar1.Position := ProgressBar1.Position + (DLFileSize(DL, Idx) - x);
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
    //Form.StatusText[0] := 'Unicode в dfm-файлах отсутствует.';
    ChangeStatus(Ext + '-files do not contain Unicode.');
    AddToLog('');
    AddToLog('Done. ' + Ext + '-files do not contain Unicode.');
    AddToLog('');
    DL.Free;
    Exit;
  end;

  DL.ScanDirectory(DirPath, DFM + UNIC, 0);

  if DL.Count = 0 then
  begin
    //Form.StatusText[0] := 'Не могу найти файлы *.dfm.unic...';
    //Form.StatusText[1] := 'ВНИМАНИЕ.';
    ChangeStatus('Files *.' + Ext + '.unic not found');
    AddToLog('');
	  AddToLog('Files *.' + Ext + '.unic not found');
	  AddToLog('');
	
    DL.Free;
    Exit;
  end;

  //InitSBMsg('Идет замена...');
  InitSBMsg('Converting...');

  //== Замена Unicode в Ansi в *.dfm_unic-файлах ==//

  for Idx := 0 to DL.Count - 1 do
  begin
    Application.ProcessMessages();
    //Form.StatusText[1] := PChar(DL.Names[Idx]);
    // ChangeStatus('Converting... ' + PChar(DL.Names[Idx]));
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
  fromMain.Caption := APP_NAME;
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
  // if dlgProperties.ModalResult=mrOk then
  // begin
  // dbPath := deDBPath.Text;
  // TelefCod1 := edTelefCod1.Text;
  // TelefCod1Check := cbTelefCod1Check.Checked;
  // TelefCod2 := edTelefCod2.Text;
  // TelefCod2Check := cbTelefCod2Check.Checked;
  // TimeCor := edTimeCor.Value;
  SaveToINI;
  // end;
end;


end.

