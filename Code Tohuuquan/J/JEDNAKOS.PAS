{$MODE OBJFPC}
program JEDNAKOS;
uses
  Math;

const
  maxN = 1000;
  maxS = 5000;
  oo = Round(1e9);

var
  a, first : packed array[1..maxN] of Integer;
  f : packed array[1..maxN, 0..maxS] of Integer;
  n, s, res : Integer;

procedure Enter;
var
  c : Char;
begin
  repeat
    Read(c);
    if c = '=' then Break;
    Inc(n);
    a[n] := Ord(c) - 48;
  until false;
  ReadLn(s);
end;

function Cal(i, sum : Integer) : Integer;
var
  j, num : Integer;
begin
  if i > n then
    if sum = 0 then Exit(0) else Exit(oo);

  if f[i, sum] < 0 then
    begin
      f[i, sum] := oo;
      num := 0;
      for j := first[i] to n do
        begin
          num := num * 10 + a[j];
          if num > sum then Break;
          f[i, sum] := Min(f[i, sum], 1 + Cal(j + 1, sum - num));
        end;
    end;
  Exit(f[i, sum]);
end;

procedure Solve(i, sum : Integer);
var
  j, num : Integer;
begin
  if i > n then Exit;

  if i > 1 then Inc(res);
  num := 0;
  for j := i to n do
    begin
      num := num * 10 + a[j];
      if Cal(i, sum) = Cal(j + 1, sum - num) + 1 then
        begin
          Solve(j + 1, sum - num);
          Break;
        end;
    end;
end;

procedure Init;
var
  i, j : Integer;
begin
  first[n] := n;
  for i := n - 1 downto 1 do
    if a[i] = 0 then
      first[i] := first[i + 1]
    else
      first[i] := i;

  FillChar(f, SizeOf(f), 255);
end;

procedure Print;
begin
  WriteLn(res);
end;

begin
  Enter;
  Init;
  Solve(1, s);
  Print;
end.
