{$MODE OBJFPC}
program NKTEAM;
const
  maxN = Round(1e5);

type
  TInfo = record
    a, b, c : Integer;
  end;

var
  f : array[1..maxN] of TInfo;
  node : array[1..maxN] of Integer;
  n, res : Integer;

procedure Enter;
var
  i, x : Integer;
begin
  ReadLn(n);
  for i := 1 to n do
    begin Read(x); f[x].a := i; end;
  for i := 1 to n do
    begin Read(x); f[x].b := i; end;
  for i := 1 to n do
    begin Read(x); f[x].c := i; end;
end;

procedure Sort(l, r : Integer);
var
  i, j : Integer;
  pivot : TInfo;
begin
  if l >= r then Exit;
  i := l + Random(r - l + 1);
  pivot := f[i]; f[i] := f[l];
  i := l; j := r;
  repeat
    while (pivot.a < f[j].a) and (i < j) do Dec(j);
    if i < j then
      begin f[i] := f[j]; Inc(i); end
      else Break;
    while (f[i].a < pivot.a) and (i < j) do Inc(i);
    if i < j then
      begin f[j] := f[i]; Dec(j); end
      else Break;
  until i = j;
  f[i] := pivot;
  Sort(l, i - 1);
  Sort(i + 1, r);
end;

function Find(x, v : Integer) : Boolean;
begin
  while x > 0 do
    begin
      if node[x] < v then Exit(false);
      Dec(x, x and -x);
    end;
  Exit(true);
end;

procedure Update(x, v : Integer);
begin
  while x <= n do
    begin
      if node[x] > v then node[x] := v;
      Inc(x, x and -x);
    end;
end;

procedure Solve;
var
  i : Integer;
begin
  Sort(1, n);
  for i := 1 to n do node[i] := n + 1;
  for i := 1 to n do
    with f[i] do
      begin
        if Find(c, b) then Inc(res);
        Update(c, b);
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
