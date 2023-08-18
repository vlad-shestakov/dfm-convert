unit FormatUtils;

interface
uses KOL;

implementation


//======================================
//== ПЕРЕВОД СТРОКИ ИЗ UNICODE В ANSI ==
//======================================
function StrUnic2Ansi(Str: string): string;
var
  x: Integer;
  Num: string;
begin
  //== Удаляем из строки символы <'> - #39
  x := Pos(#39, Str);
  repeat
    Delete(Str, x, 1);
    x := Pos(#39, Str);
  until x = 0;

  for x := Pos('#', Str) to Length(Str) - 4 do
    if (Str[x + 1] in ['0'..'9']) and (Str[x + 2] in ['0'..'9']) and
       (Str[x + 3] in ['0'..'9']) and (Str[x + 4] in ['0'..'9']) then
    begin
      Num := Str[x + 1] + Str[x + 2] + Str[x + 3] + Str[x + 4];
      Delete(Str, x, 5);
      Insert(WideChar(Str2Int(Num)), Str, x);
    end;

  //== Переводим '#39' в <'>
  x := Pos('#39', Str);
  if x = 0 then
  begin
    Result := Str;
    Exit;
  end;

  repeat
    Delete(Str, x, 3);
    Insert(#39, Str, x); // '#39' -> <'>
    x := Pos('#39', Str);
  until x = 0;
  Result := Str;
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
