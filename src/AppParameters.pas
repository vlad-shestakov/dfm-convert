unit AppParameters;

interface

// uses Classes, Messages, Dialogs;
const
  APP_NAME 			= 'DFM Converter'; {Заголовок программы}
  APP_VERSION		= '1.0.0';  {версия программы}
  EXT_DEF			= 'dfm';
  DIR_PATH_DEF		= '';
  //DIR_PATH_DEF: string = 'c:\'; // old
  
  
  // ProgramName = 'DFM Converter';; {Заголовок программы}
  // ProgramVersion = '1.0.0';  {версия программы}
  // ProgramDate = '20.01.2004'; {дата компиляции версии}
  // TelefCod1CheckDefault=True; {Умолчание: Есть фильтр по первому коду}
  // TelefCod1Default='822';     {Умолчание: Значение фильтра по первому коду}
  // TelefCod2CheckDefault=True; {Умолчание: Есть фильтр по второму коду}
  // TelefCod2Default='83432';   {Умолчание: Значение фильтра по второму коду}
  // TimeCorDefault=2;           {Умолчание: Значение сдвига часового пояса}
  // UnitedBaseName = 'UnitedBase.dbf'; {имя файла объединенной базы}
  // LogFileName = 'WorkLog.txt'; {имя файла журнала отчета}
  // ErrorBaseName ='ErrorBase.dbf'; {имя файла базы ошибочных записей}
var
  dbPath: String; {Путь к импортируемым базам данных}
  // TelefCod1,TelefCod2: String; {Телефонные коды}
  // TelefCod1Check,TelefCod2Check: Boolean; {Наличие проверки по телефонным кодам}
  // TimeCor: Integer; {Сдвиг часового пояса}
  ProgramDir: String; {Рабочий каталог программы}
  // FileNamesList: TStrings; {Массив списка файлов}
  // ErrorLog: TStringList; {Массив № ошибочных записей в объединенной базе}
  DirPath: string;
  Ext: string;

procedure SaveToINI;
// Сохраняет настройки программы в ини файл

procedure SetExtention(s: string);
procedure SetDirPath(s: string);

implementation

uses SysUtils, IniFiles

  //,Windows, Messages, Variants, Classes, Graphics, Controls, Forms,
  //Dialogs, StdCtrls, KOL, ComCtrls, ExtCtrls, AppEvnts
  ;

const
  iniFileName = 'dfmconvert.ini';
  iniSectionName = 'MAIN';
var
  Ini:TIniFile;
  
procedure LoadFromINI;
// Инициализирует настройки программы из ини файла
  begin
    Ini := TIniFile.Create(ProgramDir + '\' + iniFileName);         
    dbPath := Ini.ReadString(iniSectionName,'db_path',ProgramDir);
    Ext := Ini.ReadString(iniSectionName,'ext',ProgramDir);
    DirPath := Ini.ReadString(iniSectionName,'dir_path',ProgramDir);
    // TelefCod1Check := Ini.ReadBool(iniSectionName,'tel_cod1check',TelefCod1CheckDefault);
    // TimeCor := Ini.ReadInteger(iniSectionName,'time_cor',TimeCorDefault);
    Ini.Destroy;
	
	 
    if Ext = '' then 
      SetExtention(EXT_DEF);
	  
    if DirPath = '' then 
      //SetDirPath(ExtractFilePath(Application.ExeName));
      SetDirPath(ProgramDir);
    // else SetDirPath(DIR_PATH_DEF)
   	
  end;

procedure SaveToINI;
// Сохраняет настройки программы в ини файл
  var
    FileName:String;
  begin
    FileName := ProgramDir + '\' + iniFileName;
    Ini := TIniFile.Create(FileName);
    Ini.WriteString(iniSectionName,'ext',Ext);
    Ini.WriteString(iniSectionName,'dir_path',DirPath);
    Ini.WriteString(iniSectionName,'db_path',dbPath);
	
    // Ini.WriteBool(iniSectionName,'tel_cod1check',TelefCod1Check);
    // Ini.WriteString(iniSectionName,'tel_cod1',TelefCod1);
    // Ini.WriteBool(iniSectionName,'tel_cod2check',TelefCod2Check);
    // Ini.WriteString(iniSectionName,'tel_cod2',TelefCod2);
    // Ini.WriteInteger(iniSectionName,'time_cor',TimeCor);
    Ini.Destroy;
  end;


procedure SetExtention(s: string);
begin
  if s = '' then
    s := EXT_DEF;

  Ext := UpperCase(s);
end;

procedure SetDirPath(s: string);
begin       
  if s = '' then
    s := ExtractFilePath(ProgramDir);
	  //s := SetDirPath(ExtractFilePath(ParamStr(0))));
  DirPath := IncludeTrailingPathDelimiter(s);
end;

begin
  // инициализация модуля
  GetDir(0,ProgramDir);
  LoadFromINI;
  //FileNamesList := TStringList.Create;
  //ErrorLog := TStringList.Create;
  //ErrorLog.Sorted := True;
  //ErrorLog.Duplicates := dupIgnore;
  
end.
