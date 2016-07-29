{$MODE OBJFPC}
program BINARY;
const
  max = 33;

var
  c : array[0..max, 0..max] of Int64;
  n, k, l : Integer;
  s : String;

procedure Init;
var
  i, j : Integer;
begin
  for i := 0 to max do c[i, 0] := 1;
  for i := 0 to max do
    for j := 1 to i do
      c[i, j] := c[i - 1, j] + c[i - 1, j - 1];
end;

function Cal : Int64;
var
  i, n1 : Integer;
begin
  if k = 1 then result := 1 else result := 0;
  if k >= l then Exit;

  n1 := l - 1 - k;
  result := result + c[l - 1, n1];

  for i := 2 to l do
    begin
      if n1 = 0 then Break;
      if s[i] = '0' then
        result := result - c[l - i, n1 - 1]
      else
        Dec(n1);
    end;

  for i := l - 1 downto k + 1 do
    result := result + c[i - 1, i - 1 - k];
end;

begin
  Init;
  while not EoF do
    begin
      ReadLn(n, k);
      s := BinStr(n, max);
      while (Length(s) > 0) and (s[1] = '0') do Delete(s, 1, 1);
      l := Length(s);

      WriteLn(Cal);
    end;
end.