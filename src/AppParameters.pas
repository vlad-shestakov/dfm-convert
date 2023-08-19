unit AppParameters;

interface

const
  APP_NAME          = 'DFM Converter';		// Заголовок программы

  iniFileName 			= 'dfmconvert.ini';
  iniSectionName 		= 'MAIN';
  
  EXT_DEF               = 'dfm';
  UNIC_EXT              = '.unic';
  IS_SAVE_DIR_PATH_DEF	= false;
  DIR_PATH_DEF          = '';
  
var
  ProgramDir: 		string; 	// Рабочий каталог программы}

  Ext:            string = EXT_DEF;					// Рабочее расширение
  IsSaveDirPath:  boolean = IS_SAVE_DIR_PATH_DEF;	// Флаг сохранять ли директорию
  DirPath:        string = DIR_PATH_DEF;			// Рабочая директория
  
procedure SaveToINI;
// Сохраняет настройки программы в ини файл

procedure SetExtention(s: string);
procedure SetDirPath(s: string);
procedure LogError(s: string);

implementation

uses SysUtils, IniFiles;

var
  Ini:TIniFile;

procedure LoadFromINI;
// Инициализирует настройки программы из ини файла
  begin
    Ini := TIniFile.Create(ProgramDir + '\' + iniFileName);
	  try
	    try
		    SetExtention(Ini.ReadString(iniSectionName, 'ext', EXT_DEF));
		    IsSaveDirPath := Ini.ReadBool(iniSectionName,'is_save_dir_path',IS_SAVE_DIR_PATH_DEF);
		    if IsSaveDirPath then
		      DirPath := Ini.ReadString(iniSectionName,'dir_path', DIR_PATH_DEF);
		    SetDirPath(DirPath);
	    finally
		    Ini.Destroy;
	    end;
	  except
	    LogError('Error loading INI file');
	  end;


	
  end;

procedure SaveToINI;
// Сохраняет настройки программы в ини файл
  var
    FileName: string;
  begin
	FileName := ProgramDir + '\' + iniFileName;
	Ini := TIniFile.Create(FileName);
	  try
	    try
		  Ini.WriteString(iniSectionName,'ext',Ext);
		  Ini.WriteBool(iniSectionName,'is_save_dir_path',IsSaveDirPath);
		  if IsSaveDirPath then
			  Ini.WriteString(iniSectionName,'dir_path',DirPath);
	    finally
		    Ini.Destroy;
	    end;
	  except
		// on E: Exception do
        // ShowMessage('Error saving INI file ('ProgramDir + '\' + iniFileName') - ' + E.Message'); //todo
	    LogError('Error saving INI file');
	  end;
  end;


procedure SetIsSaveDirPath(s: boolean);
begin
    IsSaveDirPath := s;
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
    s := ProgramDir;
	// s := ExtractFilePath(ProgramDir); -- Резал крайнюю папку
  DirPath := IncludeTrailingPathDelimiter(s);
end;


procedure LogError(s: string);
begin
  s := s; // stub
  //todo
end;

begin
  // инициализация модуля
  GetDir(0,ProgramDir);
  LoadFromINI;
end.
