{$MODE OBJFPC}
program CLEAR;
const
  maxN = 16;

var
  l : array[1..maxN + 1, 0..maxN * Sqr(9), 0..10] of Int64;
  clearNum : array[0..maxN * Sqr(9)] of Integer;
  a, m, count : Int64;
  tmp, res : String;
  nTests : Integer;

procedure Init;
var
  i, j, k, p1, p2 : Integer;
  sp : String;
begin
  clearNum[0] := 2;
  clearNum[1] := 1;
  for i := 2 to maxN * Sqr(9) do
    begin
      p1 := i;
      for j := 1 to maxN * Sqr(9) do
        begin
          Str(p1, sp);
          p2 := 0;
          for k := 1 to Length(sp) do
            p2 := p2 + Sqr(Ord(sp[k]) - 48);
          if clearNum[p2] > 0 then
            begin
              clearNum[i] := clearNum[p2];
              Break;
            end;
          p1 := p2;
        end;
      if clearNum[i] = 0 then clearNum[i] := 2;
    end;
end;

procedure Enter;
begin
  ReadLn(a, m);
  Str(a + 1, tmp);
  while Length(tmp) < maxN do tmp := '0' + tmp;
  Fillchar(l, SizeOf(l), 255);
end;

function Cal(i, s, ok : Integer) : Int64;
var
  j, okT : Integer;
begin
  if l[i, s, ok] = -1 then
    begin
      l[i, s, ok] := 0;
      if i <= maxN then
        for j := (1 - ok) * (Ord(tmp[i]) - 48) to 9 do
          begin
            okT := ok or Ord(j > Ord(tmp[i]) - 48);
            l[i, s, ok] := l[i, s, ok] + Cal(i + 1, s + Sqr(j), okT);
          end
      else
        if clearNum[s] = 1 then l[i, s, ok] := 1;
    end;
  result := l[i, s, ok];
end;

procedure Find(i, s, ok : Integer);
var
  j, okT : Integer;
begin
  for j := (1 - ok) * (Ord(tmp[i]) - 48) to 9 do
    begin
      okT := ok or Ord(j > Ord(tmp[i]) - 48);
      if count + l[i + 1, s + Sqr(j), okT] < m then
        count := count + l[i + 1, s + Sqr(j), okT]
      else
        begin
          res := res + Chr(j + 48);
          if i < maxN then
            Find(i + 1, s + Sqr(j), okT);
          Break;
        end;
    end;
end;

procedure Solve;
begin
  Cal(1, 0, 0);
  count := 0;
  res := '';
  Find(1, 0, 0);
end;

procedure Print;
begin
  while (Length(res) > 0) and (res[1] = '0') do Delete(res, 1, 1);
  WriteLn(res);
end;

begin
  Init;
  ReadLn(nTests);
  while nTests > 0 do
    begin
      Dec(nTests);
      Enter;
      Solve;
      Print;
    end;
end.