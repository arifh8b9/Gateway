unit Enkripsi;

interface
      function MakeRNDString(Chars: string; Count: Integer): string;
      function GeneratePWDSecurityString: string;
      function EncodePWDEx(Data, SecurityString: string; MinV: Integer = 0;
      MaxV: Integer = 5): string;
      function DecodePWDEx(Data, SecurityString: string): string;

const  
  Codes64 = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/';

implementation

function GeneratePWDSecurityString: string;
var
  i, x: integer;
  s1, s2: string;
begin
  s1 := Codes64;
  s2 := '';
  for i := 0 to 15 do
  begin
    x  := Random(Length(s1));
    x  := Length(s1) - x;
    s2 := s2 + s1[x];
    s1 := Copy(s1, 1,x - 1) + Copy(s1, x + 1,Length(s1));
  end;
  Result := s2;
end;

function MakeRNDString(Chars: string; Count: Integer): string;
var
  i, x: integer;
begin
  Result := '';
  for i := 0 to Count - 1 do
  begin
    x := Length(chars) - Random(Length(chars));
    Result := Result + chars[x];
    chars := Copy(chars, 1,x - 1) + Copy(chars, x + 1,Length(chars));
  end;
end;

function EncodePWDEx(Data, SecurityString: string; MinV: Integer = 0;
  MaxV: Integer = 5): string;
var
  i, x: integer;
  s1, s2, ss: string;
begin
  if minV > MaxV then
  begin
    i := minv;
    minv := maxv;
    maxv := i;
  end;
  if MinV < 0 then MinV := 0;
  if MaxV > 100 then MaxV := 100;
  Result := '';
  if Length(SecurityString) < 16 then Exit;
  for i := 1 to Length(SecurityString) do
  begin
    s1 := Copy(SecurityString, i + 1,Length(securitystring));
    if Pos(SecurityString[i], s1) > 0 then Exit;
    if Pos(SecurityString[i], Codes64) <= 0 then Exit;
  end;
  s1 := Codes64;
  s2 := '';
  for i := 1 to Length(SecurityString) do
  begin
    x := Pos(SecurityString[i], s1);
    if x > 0 then s1 := Copy(s1, 1,x - 1) + Copy(s1, x + 1,Length(s1));
  end;
  ss := securitystring;
  for i := 1 to Length(Data) do
  begin
    s2 := s2 + ss[Ord(Data[i]) mod 16 + 1];
    ss := Copy(ss, Length(ss), 1) + Copy(ss, 1,Length(ss) - 1);
    s2 := s2 + ss[Ord(Data[i]) div 16 + 1];
    ss := Copy(ss, Length(ss), 1) + Copy(ss, 1,Length(ss) - 1);
  end;
  Result := MakeRNDString(s1, Random(MaxV - MinV) + minV + 1);
  for i := 1 to Length(s2) do Result := Result + s2[i] + MakeRNDString(s1,
      Random(MaxV - MinV) + minV);
end;

function DecodePWDEx(Data, SecurityString: string): string;
var
  i, x, x2: integer;
  s1, s2, ss: string;
begin
  Result := #1;
  if Length(SecurityString) < 16 then Exit;
  for i := 1 to Length(SecurityString) do
  begin
    s1 := Copy(SecurityString, i + 1,Length(securitystring));
    if Pos(SecurityString[i], s1) > 0 then Exit;
    if Pos(SecurityString[i], Codes64) <= 0 then Exit;
  end;
  s1 := Codes64;
  s2 := '';
  ss := securitystring;
  for i := 1 to Length(Data) do if Pos(Data[i], ss) > 0 then s2 := s2 + Data[i];
  Data := s2;
  s2   := '';
  if Length(Data) mod 2 <> 0 then Exit;
  for i := 0 to Length(Data) div 2 - 1 do
  begin
    x := Pos(Data[i * 2 + 1], ss) - 1;
    if x < 0 then Exit;
    ss := Copy(ss, Length(ss), 1) + Copy(ss, 1,Length(ss) - 1);
    x2 := Pos(Data[i * 2 + 2], ss) - 1;
    if x2 < 0 then Exit;
    x  := x + x2 * 16;
    s2 := s2 + chr(x);
    ss := Copy(ss, Length(ss), 1) + Copy(ss, 1,Length(ss) - 1);
  end;
  Result := s2;
end;

end.
