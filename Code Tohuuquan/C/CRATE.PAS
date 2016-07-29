{$MODE OBJFPC}
program CRATE;
const
  maxN = Round(3e5);

type
  TInfo = record
    x, y, id : Integer;
  end;

var
  a : array[1..maxN] of TInfo;
  b, id, node, res : array[1..maxN] of Integer;
  n : Integer;

procedure Enter;
var
  i : Integer;
begin
  ReadLn(n);
  for i := 1 to n do
    with a[i] do
      begin
        ReadLn(x, y);
        id := i;
      end;
end;

function Cmp1(const u, v : TInfo) : Boolean;
begin
  result := (u.x < v.x) or (u.x = v.x) and (u.y < v.y);
end;

procedure SortA(l, r : Integer);
var
  i, j : Integer;
  pivot : TInfo;
begin
  if l >= r then Exit;
  i := l + Random(r - l + 1);
  pivot := a[i]; a[i] := a[l];
  i := l; j := r;
  repeat
    while Cmp1(pivot, a[j]) and (i < j) do Dec(j);
    if i < j then
      begin a[i] := a[j]; Inc(i); end
      else Break;
    while Cmp1(a[i], pivot) and (i < j) do Inc(i);
    if i < j then
      begin a[j] := a[i]; Dec(j); end
      else Break;
  until i = j;
  a[i] := pivot;
  SortA(l, i - 1);
  SortA(i + 1, r);
end;

function Cmp2(const u, v : TInfo) : Boolean;
begin
  result := (u.y < v.y) or (u.y = v.y) and (u.x < v.x);
end;

procedure SortID(l, r : Integer);
var
  i, j, pivot : Integer;
begin
  if l >= r then Exit;
  i := l + Random(r - l + 1);
  pivot := id[i]; id[i] := id[l];
  i := l; j := r;
  repeat
    while Cmp2(a[pivot], a[id[j]]) and (i < j) do Dec(j);
    if i < j then
      begin id[i] := id[j]; Inc(i); end
      else Break;
    while Cmp2(a[id[i]], a[pivot]) and (i < j) do Inc(i);
    if i < j then
      begin id[j] := id[i]; Dec(j); end
      else Break;
  until i = j;
  id[i] := pivot;
  SortID(l, i - 1);
  SortID(i + 1, r);
end;

operator = (const u, v : TInfo) : Boolean;
begin
  result := (u.x = v.x) and (u.y = v.y);
end;

procedure Init;
var
  i, j : Integer;
begin
  SortA(1, n);
  for i := 1 to n do id[i] := i;
  SortID(1, n);
  j := 1; b[id[1]] := 1;
  for i := 2 to n do
    if a[id[i]] = a[id[i - 1]] then
      b[id[i]] := j
    else
      begin
        Inc(j);
        b[id[i]] := j;
      end;
end;

function Find(x : Integer) : Integer;
begin
  result := 0;
  while x > 0 do
    begin
      Inc(result, node[x]);
      Dec(x, x and -x);
    end;
end;

procedure Update(x : Integer);
begin
  while x <= n do
   begin
     Inc(node[x]);
     Inc(x, x and -x);
   end;
end;

procedure Solve;
var
  i : Integer;
begin
  for i := 1 to n do
    begin
      res[a[i].id] := Find(b[i] - 1);
      Update(b[i]);
    end;
end;

procedure Print;
var
  i : Integer;
begin
  for i := 1 to n do WriteLn(res[i]);
end;

begin
  Enter;
  Init;
  Solve;
  Print;
end.