{$MODE OBJFPC}
{$INLINE ON}
program BARICAVN;
uses
  Math;

const
  maxN = Round(3e5);
  limit = Round(1e5);

type
  TCord = record
    x, y, w : Integer;
  end;

var
  p : array[1..maxN] of TCord;
  id : array[1..maxN] of Integer;
  f : array[0..maxN] of Integer;
  maxX, maxY : array[0..limit] of Integer;
  n, k : Integer;

procedure Enter;
var
  i : Integer;
begin
  ReadLn(n, k);
  for i := 1 to n do
    begin
      with p[i] do ReadLn(x, y, w);
      id[i] := i;
    end;
end;

operator < (const u, v : TCord) : Boolean; inline;
begin
  result := (u.x < v.x) or (u.x = v.x) and (u.y < v.y);
end;

procedure Sort(l, r : Integer);
var
  i, j, pivot : Integer;
begin
  if l >= r then Exit;
  i := l + Random(r - l + 1);
  pivot := id[i]; id[i] := id[l];
  i := l; j := r;
  repeat
    while (p[pivot] < p[id[j]]) and (i < j) do Dec(j);
    if i < j then
      begin id[i] := id[j]; Inc(i); end
      else Break;
    while (p[id[i]] < p[pivot]) and (i < j) do Inc(i);
    if i < j then
      begin id[j] := id[i]; Dec(j); end
      else Break;
  until i = j;
  id[i] := pivot;
  Sort(l, i - 1);
  Sort(i + 1, r);
end;

procedure Solve;
var
  i, j, mX, mY : Integer;
begin
  for j := 1 to n do
    begin
      i := id[j];
      with p[i] do
        begin
          if i = 1 then f[i] := w;

          mX := maxX[x];
          mY := maxY[y];

          if f[mX] >= k then
            f[i] := Max(f[i], f[mX] - k + w);
          if f[mY] >= k then
            f[i] := Max(f[i], f[mY] - k + w);

          if f[i] > f[mX] then maxX[x] := i;
          if f[i] > f[mY] then maxY[y] := i;
        end;
    end;
end;

procedure Print;
begin
  WriteLn(f[n]);
end;

begin
  Enter;
  Sort(1, n);
  Solve;
  Print;
end.