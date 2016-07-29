{$MODE OBJFPC}
{$INLINE ON}
program TABLIC;
const
  maxK = 1000;

type
  TRec = record
    x, y : Integer;
    fx, fy : Integer;
  end;

var
  a : array[1..maxK] of TRec;
  n, k : Integer;

procedure Enter;
var
  i, t : Integer;
begin
  ReadLn(n, k);
  for i := 1 to k do
    with a[i] do
      begin
        ReadLn(t, fx, fy);
        Dec(t); Dec(fx); Dec(fy);
        x := t div n;
        y := t mod n;
      end;
end;

procedure ChangeRow(x, delta : Integer); inline;
var
  i : Integer;
begin
  for i := 1 to k do
    if a[i].x = x then a[i].y := (a[i].y + delta) mod n;
end;

procedure ChangeColumn(y, delta : Integer); inline;
var
  i : Integer;
begin
  for i := 1 to k do
    if a[i].y = y then a[i].x := (a[i].x + delta) mod n;
end;

procedure Solve;
var
  i, j, dx, dy, tx, ty : Integer;
begin
  for i := 1 to k do
    begin
      dx := (n + a[i].fx - a[i].x) mod n;
      dy := (n + a[i].fy - a[i].y) mod n;
      WriteLn(dx + dy);

      ChangeRow(a[i].x, dy);
      ChangeColumn(a[i].y, dx);
    end;
end;

begin
  Enter;
  Solve;
end.