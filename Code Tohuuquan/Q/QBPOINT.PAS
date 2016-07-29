{$MODE OBJFPC}
program QBPOINT;
const
  maxN = 2010;
  eps : Double = 1e-15;

type
  TCoord = record
    x, y : Integer;
  end;

var
  p : array[1..maxN] of TCoord;
  c : array[1..maxN] of Double;
  n, m : Integer;
  res : Int64;

procedure Enter;
var
  i : Integer;
begin
  ReadLn(n);
  for i := 1 to n do
    with p[i] do ReadLn(x, y);
end;

procedure MakeC(r : Integer);
var
  i, vx, vy : Integer;
begin
  m := 0;
  for i := r + 1 to n do
    begin
      vx := p[r].x - p[i].x;
      vy := p[r].y - p[i].y;
      Inc(m);
      if Abs(vx) <= eps then c[m] := 1e10
      else c[m] := vy / vx;
    end;
end;

procedure Sort(L, R : Integer);
var
  pivot : Double;
  i, j : Integer;
begin
  if L >= R then Exit;
  i := L + Random(R - L + 1);
  pivot := c[i]; c[i] := c[L];
  i := L; j := R;
  repeat
    while (pivot < c[j]) and (i < j) do Dec(j);
    if i < j then
      begin c[i] := c[j]; Inc(i); end
      else Break;
    while (c[i] < pivot) and (i < j) do Inc(i);
    if i < j then
      begin c[j] := c[i]; Dec(j); end
      else Break;
  until i = j;
  c[i] := pivot;
  Sort(L, i - 1);
  Sort(i + 1, R);
end;

procedure Cal;
var
  i, count : Integer;
begin
  count := 0;
  for i := 2 to m do
    if Abs(c[i] - c[i - 1]) <= eps then Inc(count) else
      begin
        res := res + count * (count + 1) div 2;
        count := 0;
      end;
  res := res + count * (count + 1) div 2;
end;

procedure Solve;
var
  i : Integer;
begin
  for i := 1 to n do
    begin
      MakeC(i);
      Sort(1, m);
      Cal;
    end;
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