{$MODE OBJFPC}
program IVANA;
uses
  Math;

const
  maxN = 100 shl 1;

var
  f : array[1..maxN, 1..maxN] of Integer;
  n, res : Integer;

procedure Enter;
var
  i : Integer;
begin
  ReadLn(n);
  for i := 1 to n do
    begin
      Read(f[i, i]);
      f[i, i] := f[i, i] mod 2;
      f[i + n, i + n] := f[i, i];
    end;
end;

procedure Init;
var
  i, j, l : Integer;
begin
  for l := 2 to n do
    for i := 1 to n shl 1 do
      begin
        j := i + l - 1;
        if j > n shl 1 then Break;
        f[i, j] := Max(f[i, i] - f[i + 1, j], f[j, j] - f[i, j - 1]);
      end;
end;

procedure Solve;
var
  i : Integer;
begin
  for i := 1 to n do
    if f[i, i] - f[i + 1, i + n - 1] > 0 then Inc(res);
  WriteLn(res);
end;

begin
  Enter;
  Init;
  Solve;
end.