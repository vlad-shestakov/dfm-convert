unit FormatUtils;

interface
uses KOL;

function StrUnic2Ansi(Str: string): string;
function isStrUnic(Str: string): Boolean;
function DLFileSize(DL: PDirList; Idx: Integer): Integer;


implementation


//======================================
//== ПЕРЕВОД СТРОКИ ИЗ UNICODE В ANSI ==
//======================================
function StrUnic2Ansi(Str: string): string;
var
  x: Integer;
  Num: string;
begin
  //== Удаляем из строки все простые кавычки ( <'> - #39 )
  x := Pos(#39, Str);
  repeat
    Delete(Str, x, 1);
    x := Pos(#39, Str);
  until x = 0;

  for x := Pos('#', Str) to Length(Str) - 4 do
    if (Str[x + 1] in ['0'..'9']) and (Str[x + 2] in ['0'..'9']) and
       (Str[x + 3] in ['0'..'9']) and (Str[x + 4] in ['0'..'9']) then
    begin
      Num := Str[x + 1] + Str[x + 2] + Str[x + 3] + Str[x + 4]; // Собрали в число
      Delete(Str, x, 5); // Удалили #nnnn
      Insert(WideChar(Str2Int(Num)), Str, x); // Вставили символ
    end;

  //== Переводим '#39' в <'>
  x := Pos('#39', Str);
  if x > 0 then
  begin
	  // Заменяем везде #39 на простую кавычку
	  repeat
		Delete(Str, x, 3);
		Insert(#39, Str, x); // '#39' -> <'>
		x := Pos('#39', Str);
	  until x = 0;
  end;
  
  //== Переводим '#13' и '#10' на соотвествующий символ (возврат каретки)
  x := Pos('#13', Str);
  if x > 0 then
  begin
	  repeat
		Delete(Str, x, 3);
		Insert(#13, Str, x); // '#13' -> ?
		x := Pos('#13', Str);
	  until x = 0;
  end;
  x := Pos('#10', Str);
  if x > 0 then
  begin
	  repeat
		Delete(Str, x, 3);
		Insert(#10, Str, x); // '#10' -> ?
		x := Pos('#10', Str);
	  until x = 0;
  end;

  Result := Str;
end;


//=============================
//== ПОИСК UNICODE В СТРОКЕ  ==
//=============================
function isStrUnic(Str: string): Boolean;
var
  x: Integer;
begin
  Result := FALSE;
  
  // Если строка короткая, или не нашли # - не найдено
  if (Length(Str) < 5) or (Pos('#', Str) = 0) then
    Exit;

  // Если нашли <'> - #39 - найдено
  if Pos('#39', Str) <> 0 then
  begin
    Result := TRUE;
    Exit;
  end;

  // Если в строке найдена #nnnn, то - найдено
  for x := Pos('#', Str) to Length(Str) - 4 do
    if (x + 4) <= Length(Str) then
      if (Str[x + 1] in ['0'..'9']) and (Str[x + 2] in ['0'..'9']) and
         (Str[x + 3] in ['0'..'9']) and (Str[x + 4] in ['0'..'9']) then
      begin
        Result := TRUE;
        Break;
      end;
end;


//===========================
//== РАЗМЕР ФАЙЛА В БАЙТАХ ==
//===========================
function DLFileSize(DL: PDirList; Idx: Integer): Integer;
var
  st: string;
begin
  st := Int64_2Str(MakeInt64(DL.Items[Idx].nFileSizeLow,
    DL.Items[Idx].nFileSizeHigh));
  Result := Str2Int(st);
end;

end.
