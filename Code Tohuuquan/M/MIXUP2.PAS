{$MODE OBJFPC}
program MIXUP2;
uses
  Math;

const
  maxN = 16;

var
  s : array[1..maxN] of Integer;
  bit : array[1..maxN + 1] of Integer;
  f : array[1..maxN, word] of Int64;
  n, k : Integer;
  res : Int64;

procedure Enter;
var
  i : Integer;
begin
  ReadLn(n, k);
  for i := 1 to n do ReadLn(s[i]);
  bit[1] := 1;
  for i := 2 to n + 1 do bit[i] := bit[i - 1] shl 1;
end;

procedure Solve;
var
  i, j, x, y : Integer;
begin
  for j := 1 to bit[n + 1] - 1 do
    for i := 1 to n do
      if j and bit[i] > 0 then
        begin
          y := j - bit[i];
          if y = 0 then f[i, j] := 1 else
            for x := 1 to n do
              if (y and bit[x] > 0) and (abs(s[x] - s[i]) > k) then
                f[i, j] := f[i, j] + f[x, y];
        end;

  for i := 1 to n do res := res + f[i, bit[n + 1] - 1];
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