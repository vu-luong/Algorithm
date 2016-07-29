{$MODE OBJFPC}
program ROCKS;
const
  maxN = 15;

var
  a : array[0..1 shl maxN] of Integer;
  n : Integer;

procedure Enter;
begin
  ReadLn(n);
end;

procedure Solve;
var
  i, k : Integer;
begin
  for k := 0 to n - 1 do
    for i := 0 to 1 shl k - 1 do
      a[1 shl (k + 1) - i - 1] := a[i] or (1 shl k);
end;

procedure Print;
var
  i, j : Integer;
begin
  for i := 0 to 1 shl n do
    begin
      for j := 0 to n - 1 do
        if a[i] and (1 shl j) > 0 then Write('X')
          else Write('O');
      WriteLn;
    end;
end;

begin
  Enter;
  Solve;
  Print;
end.