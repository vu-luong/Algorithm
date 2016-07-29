{$MODE OBJFPC}
program KINV;
const
  maxN = 10000;
  maxK = 10;
  radix = Round(1e9);

var
  a, b, id, node : array[1..maxN] of Integer;
  f : array[1..maxK, 1..maxN] of Integer;
  n, k, res : Integer;

procedure Enter;
var
  i : Integer;
begin
  ReadLn(n, k);
  for i := 1 to n do Read(a[i]);
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
    while (a[pivot] < a[id[j]]) and (i < j) do Dec(j);
    if i < j then
      begin id[i] := id[j]; Inc(i); end
      else Break;
    while (a[id[i]] < a[pivot]) and (i < j) do Inc(i);
    if i < j then
      begin id[j] := id[i]; Dec(j); end
      else Break;
  until i = j;
  id[i] := pivot;
  Sort(l, i - 1);
  Sort(i + 1, r);
end;

procedure Init;
var
  i : Integer;
begin
  for i := 1 to n do id[i] := i;
  Sort(1, n);
  b[id[1]] := 1;
  for i := 2 to n do
    if a[id[i]] = a[id[i - 1]] then
      b[id[i]] := b[id[i - 1]]
    else
      b[id[i]] := b[id[i - 1]] + 1;
end;

function Find(x : Integer) : Integer;
begin
  result := 0;
  while x <= n do
    begin
      result := (result + node[x]) mod radix;
      Inc(x, x and -x);
    end;
end;

procedure Update(x, value : Integer);
begin
  while x > 0 do
    begin
      node[x] := (node[x] + value) mod radix;
      Dec(x, x and -x);
    end;
end;

procedure Solve;
var
  i, j : Integer;
begin
  for j := 1 to n do f[1, j] := 1;
  for i := 2 to k do
    begin
      FillChar(node, n * SizeOf(node[1]), 0);
      for j := 1 to n do
        begin
          f[i, j] := (f[i, j] + Find(b[j] + 1)) mod radix;
          Update(b[j], f[i - 1, j]);
        end;
    end;
  for i := 1 to n do
    res := (res + f[k, i]) mod radix;
end;

procedure Print;
begin
  WriteLn(res);
end;

begin
  Enter;
  Init;
  Solve;
  Print;
end.