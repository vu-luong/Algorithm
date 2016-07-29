{$MODE OBJFPC}
program LSPALIN;
uses
  SysUtils;

const
  maxP = 8;

var
  a : array[0..maxP] of Integer;
  mul : array[1..7] of Integer;
  n, p, k : Integer;
  res : String;

procedure Enter;
begin
  ReadLn(n, p, k);
end;

function KToStr(n, k : Integer) : String;
var
  i : Integer;
  j : Char;
begin
  result := '';
  for i := n downto 1 do
    begin
      for j := 'a' to 'z' do
        if k > mul[i] then k := k - mul[i] else Break;
      result := result + j;
    end;
end;

function StrToK(s : String) : Integer;
var
  i, n : Integer;
begin
  result := 1;
  n := Length(s);
  for i := 1 to Length(s) do
    result := result + mul[n - i + 1] * (Ord(s[i]) - 97);
end;

function Reverse(s : String) : String;
var
  i : Integer;
begin
  result := '';
  for i := Length(s) downto 1 do
    result := result + s[i];
end;

function Cal(s : String) : Integer;
var
  s1, s2 : String;
begin
  s1 := LeftStr(s, (Length(s) + 1) div 2);
  s2 := RightStr(s, (Length(s) + 1) div 2);

  result := StrToK(s1);
  if Reverse(s1) > s2 then result := result - 1;
end;

function FindShort(n, k : Integer) : String;
var
  pre, now, delta : Integer;
begin
  result := KToStr(n, k);
  if n = 1 then Exit;

  pre := 0;
  repeat
    now := Cal(result);
    delta := now - pre;
    if delta = 0 then Break;

    k := k + delta;
    result := KToStr(n, k);
    pre := now;
  until false;
end;

function FindLong(n, k : Integer) : String;
var
  pre, now, delta, l : Integer;
begin
  if n >= 14 then
    Exit(StringOfChar('a', n - 7) + KToStr(7, k + 1));

  result := KToStr(7, k);
  l := 14 - n;
  pre := 0;
  repeat
    now := Cal(LeftStr(result, l));
    delta := now - pre;
    if delta = 0 then Break;

    k := k + delta;
    result := KToStr(7, k);
    pre := now;
  until false;
  result := StringOfChar('a', n - 7) + result;
end;

procedure Flip(var s : String; len : Integer);
var
  i : Integer;
begin
  if Length(s) * 2 = len then
    for i := Length(s) downto 1 do s := s + s[i]
  else
    for i := Length(s) - 1 downto 1 do s := s + s[i];
end;

procedure Solve;
var
  i : Integer;
begin
  mul[1] := 1;
  for i := 2 to 7 do mul[i] := mul[i - 1] * 26;

  for i := p downto 0 do
    begin
      a[i] := n;
      n := (n + 1) div 2;
    end;

  if a[0] <= 7 then
    res := FindShort(a[0], k)
  else
    res := FindLong(a[0], k);

  for i := 1 to p do Flip(res, a[i]);
end;

procedure Print;
begin
  WriteLn(res);
end;

begin
  Enter;
  Solve;
  Print;
end.
