{$MODE OBJFPC}
program CHEER;
uses
  Math;

const
  maxN = Round(1e4);
  maxM = Round(1e5);

type
  TEdge = record
    x, y, t : Integer;
  end;

var
  e : array[1..maxM] of TEdge;
  lab, c : array[1..maxN] of Integer;
  n, m : Integer;
  res : Int64;

procedure Enter;
var
  i : Integer;
begin
  ReadLn(n, m);
  res := High(Int64);
  for i := 1 to n do
    begin
      ReadLn(c[i]);
      res := Min(res, c[i]);
    end;
  for i := 1 to m do
    with e[i] do
      begin
        ReadLn(x, y, t);
        t := t * 2 + c[x] + c[y];
      end;
end;

procedure Sort(l, r : Integer);
var
  i, j : Integer;
  pivot : TEdge;
begin
  if l >= r then Exit;
  i := l + Random(r - l + 1);
  pivot := e[i]; e[i] := e[l];
  i := l; j := r;
  repeat
    while (pivot.t < e[j].t) and (i < j) do Dec(j);
    if i < j then
      begin e[i] := e[j]; Inc(i); end
      else Break;
    while (e[i].t < pivot.t) and (i < j) do Inc(i);
    if i < j then
      begin e[j] := e[i]; Dec(j); end
      else Break;
  until i = j;
  e[i] := pivot;
  Sort(l, i - 1);
  Sort(i + 1, r);
end;

function GetRoot(u : Integer) : Integer;
begin
  if lab[u] <= 0 then result := u else
    begin
      result := GetRoot(lab[u]);
      lab[u] := result;
    end;
end;

procedure Union(r1, r2 : Integer);
begin
  if lab[r1] < lab[r2] then lab[r2] := r1 else
    begin
      if lab[r1] = lab[r2] then Dec(lab[r2]);
      lab[r1] := r2;
    end;
end;

procedure Solve;
var
  i, r1, r2, count : Integer;
begin
  count := 0;
  for i := 1 to m do
    with e[i] do
      begin
        r1 := GetRoot(x);
        r2 := GetRoot(y);
        if r1 <> r2 then
          begin
            Inc(count);
            res := res + t;
            if count = n - 1 then Exit;
            Union(r1, r2);
          end;
      end;
end;

procedure Print;
begin
  WriteLn(res);
end;

begin
  Enter;
  Sort(1, m);
  Solve;
  Print;
end.