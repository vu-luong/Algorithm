{$MODE OBJFPC}
{$INLINE ON}
program ALADDIN;
const
  maxN = 200;

var
  a, res : array[1..maxN, 1..maxN] of Integer;
  n : Integer;

procedure Enter;
var
  i, j : Integer;
begin
  ReadLn(n);
  for i := 1 to n - 1 do
    for j := 1 to n - 1 do Read(a[i, j]);
end;

procedure Print;
var
  i, j : Integer;
begin
  for i := 1 to n do
    begin
      for j := 1 to n do Write(res[i, j], ' ');
      WriteLn;
    end;
  Halt;
end;

function Sum(x, y : Integer) : Integer; inline;
begin
  result := res[x - 1, y - 1] + res[x - 1, y] + res[x, y - 1];
end;

function Check(x : Integer) : Boolean; inline;
begin
  result := (0 <= x) and (x <= 1);
end;

procedure Find(x : Integer);
var
  i, j, y : Integer;
  ok : Boolean;
begin
  if x > n then Print;
  for i := 0 to 1 do
    for j := 0 to 1 do
      begin
        res[1, x] := i;
        res[x, 1] := j;
        ok := true;
        for y := 2 to x do
          begin
            res[x, y] := a[x - 1, y - 1] - Sum(x, y);
            ok := ok and Check(res[x, y]);

            res[y, x] := a[y - 1, x - 1] - Sum(y, x);
            ok := ok and Check(res[y, x]);
          end;
        if ok then Find(x + 1);
      end;
end;

procedure Solve;
begin
  res[1, 1] := 0;
  Find(2);

  res[1, 1] := 1;
  Find(2);

  WriteLn('No solution');
end;

begin
  Enter;
  Solve;
end.
