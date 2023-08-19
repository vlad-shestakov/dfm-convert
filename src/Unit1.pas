unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, KOL, ComCtrls, ExtCtrls, AppEvnts;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    OpenDialog1: TOpenDialog;
    bGoClick: TButton;
    lbStatusText: TLabel;
    lbProgressBar1: TLabel;
    lbMaxProgress: TLabel;
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
  private
    { Private declarations }      
    DirPath: string;
    Ext: string;
    EXT_DEF: string;
    procedure AddToLog(s: string);
    procedure ClearLog;
    procedure ChangeStatus(s: string);
    procedure SetExtention(s: string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses FormatUtils;

{$R *.dfm}

//====================
//== ВЫБОР КАТАЛОГА ==
//====================
procedure TForm1.Button1Click(Sender: TObject);
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
  if not DirectoryExists(Edit1.Text) then
  begin
    MessageBox(0, PChar('Can''t open Dir' + #13#10 +
      //OpenDirDialog1.Path), PChar(Form.Caption), MB_ICONSTOP);
      Edit1.Text), PChar(Form1.Caption), MB_ICONSTOP);
    Exit;
  end;

  //Form.StatusText[0] := '';
  //Form.StatusText[1] := '';
  //lbStatusText.Caption := '';
  ChangeStatus('Selected catalog - ' + Edit1.Text);
  AddToLog('Selected catalog - ' + Edit1.Text);
  AddToLog('');
  //ProgressBar1.Progress := 0;
  ProgressBar1.Position := 0;
  lbProgressBar1.Caption := '0';
  //DirPath := IncludeTrailingPathDelimiter(OpenDirDialog1.Path);
  DirPath := IncludeTrailingPathDelimiter(Edit1.Text);
  //lDir.Caption := DirPath; //MinimizeName(DirPath, lDir.Canvas.Handle, 256);
  // OpenDirDialog1.InitialPath := DirPath;
  // OpenDialog1.InitialDir := DirPath;

end;

//===================================
//== ПЕРЕВОД DFM ИЗ UNICODE В ANSI ==
//===================================
procedure TForm1.bGoClickClick(Sender: TObject);
const
  UNIC = '.unic';
var
  DFM: string;
  DL: PDirList;
  Flag, UnFlag: Boolean; // Есть Unicode строка
  Idx, x, MaxProgress: Integer;
  st : string;
  //FR, FW: Text;
  FR, FW: TextFile;
  
	//=============================
	procedure InitSBMsg(pc: PChar);
	var
	  Idx :Integer;
	begin
		//Form.StatusText[0] := pc;
    //lbStatusText.Caption := pc;
    ChangeStatus(pc);
    AddToLog(pc);

    x := 0;
	  //ProgressBar1.Progress := 0;
    ProgressBar1.Position := 0;
	  lbProgressBar1.Caption := '0';
	  //ProgressBar1.MaxProgress := 0;   
    ProgressBar1.Max := 0;
	  MaxProgress := 0;

    for Idx := 0 to DL.Count - 1 do
   	begin
		  //ProgressBar1.MaxProgress := ProgressBar1.MaxProgress + DLFileSize(DL, Idx);
		  ProgressBar1.Max := ProgressBar1.Max + DLFileSize(DL, Idx);
      MaxProgress := MaxProgress + DLFileSize(DL, Idx);
	  end;

    lbMaxProgress.Caption := IntToStr(MaxProgress);
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
    //Form.StatusText[0] := 'В каталоге нет dfm-файлов.';
    //lbStatusText.Caption := 'В каталоге нет dfm-файлов.';
    //lbStatusText.Caption := Ext + '-files not found.';
    ChangeStatus('DFM-files not found.');
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
    //lbStatusText.Caption := PChar(DL.Names[Idx]);
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
      lbProgressBar1.Caption := IntToStr(StrToInt(lbProgressBar1.Caption) + x);
      Flag := isStrUnic(st);
      if Flag then
      begin
        CloseFile(FR);
        UnFlag := TRUE;
        //Размер файла минус считанные байты
        //ProgressBar1.Progress := ProgressBar1.Progress + (DLFileSize(DL, Idx) - x);
        ProgressBar1.Position := ProgressBar1.Position + (DLFileSize(DL, Idx) - x);
        lbProgressBar1.Caption := IntToStr(StrToInt(lbProgressBar1.Caption) + (DLFileSize(DL, Idx) - x));
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
    //lbStatusText.Caption := 'Unicode в dfm-файлах отсутствует.';
    //lbStatusText.Caption := 'DFM-files do not contain Unicode.';
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
    //lbStatusText.Caption := 'Не могу найти файлы *.dfm.unic...';
    //lbStatusText.Caption := 'Files *.dfm.unic not found';
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
    //lbStatusText.Caption := PChar(DL.Names[Idx]);
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
      //ProgressBar1.Progress := ProgressBar1.Progress + Length(st) + 2;
      ProgressBar1.Position := ProgressBar1.Position + Length(st) + 2;
      lbProgressBar1.Caption := IntToStr(StrToInt(lbProgressBar1.Caption) +  Length(st) + 2);
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
  //Form.StatusText[0] := 'Готово.';
  //lbStatusText.Caption := 'Готово.';
  //lbStatusText.Caption := 'Done.';
  ChangeStatus('Done.');
  AddToLog('');
  AddToLog('Done.');
  AddToLog('');

end;

procedure TForm1.AddToLog(s :string);
begin
  mmLog.Lines.Add(s);
end;

procedure TForm1.ClearLog;
begin
  mmLog.Lines.Clear;
end;

procedure TForm1.ChangeStatus(s: string);
begin
  //lbStatusText.Caption := s;
  StatusBar1.Panels[0].Text := s;
end;

procedure TForm1.SetExtention(s: string);
begin
  if s = '' then
    s := EXT_DEF;

  Ext := UpperCase(s);
  edExt.Text := Ext;
end;



procedure TForm1.FormShow(Sender: TObject);
begin
  //lbStatusText.Caption := '';
  ChangeStatus('');
  SetExtention(EXT_DEF);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  EXT_DEF := 'dfm';
end;

procedure TForm1.edExtExit(Sender: TObject);
begin

  SetExtention(edExt.Text);
end;

end.

