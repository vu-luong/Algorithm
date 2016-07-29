{$MODE OBJFPC}
program NKMARS;
const
  maxN = Round(1e4) + 1;

var
  x1, x2, y1, y2 : array[1..maxN] of Integer;
  HCN, Y : array[1..maxN * 2] of Integer;
  node, count : array[1..maxN * 16] of Integer;
  n, n2, res : Integer;

procedure Enter;
var
  i, j : Integer;
begin
  ReadLn(n);
  n2 := n shl 1;
  j := 0;
  for i := 1 to n do
    begin
      ReadLn(x1[i], y1[i], x2[i], y2[i]);
      Inc(j);
      HCN[j] := -i;
      Y[j] := y1[i];

      Inc(j);
      HCN[j] := i;
      Y[j] := y2[i];
    end;
end;

function Lower(a, b : Integer) : Boolean;
begin
  if a < 0 then a := x1[-a] else a := x2[a];
  if b < 0 then b := x1[-b] else b := x2[b];
  Exit(a < b);
end;

procedure SortHCN(l, r : Integer);
var
  i, j, pivot : Integer;
begin
  if l >= r then Exit;
  i := l + Random(r - l + 1);
  pivot := HCN[i]; HCN[i] := HCN[l];
  i := l; j := r;
  repeat
    while Lower(pivot, HCN[j]) and (i < j) do Dec(j);
    if i < j then
      begin HCN[i] := HCN[j]; Inc(i); end
      else Break;
    while Lower(HCN[i], pivot) and (i < j) do Inc(i);
    if i < j then
      begin HCN[j] := HCN[i]; Dec(j); end
      else Break;
  until i = j;
  HCN[i] := pivot;
  SortHCN(l, i - 1);
  SortHCN(i + 1, r);
end;

procedure SortY(l, r : Integer);
var
  i, j, pivot : Integer;
begin
  if l >= r then Exit;
  i := l + Random(r - l + 1);
  pivot := Y[i]; Y[i] := Y[l];
  i := l; j := r;
  repeat
    while (pivot < Y[j]) and (i < j) do Dec(j);
    if i < j then
      begin Y[i] := Y[j]; Inc(i); end
      else Break;
    while (Y[i] < pivot) and (i < j) do Inc(i);
    if i < j then
      begin Y[j] := Y[i]; Dec(j); end
      else Break;
  until i = j;
  Y[i] := pivot;
  SortY(l, i - 1);
  SortY(i + 1, r);
end;

procedure Init;
begin
  SortHCN(1, n2);
  SortY(1, n2);
end;

procedure OpenHCN(i, l, r, s, f : Integer);
var
  m : Integer;
begin
  if s >= f then Exit;
  if (l >= Y[f]) or (r <= Y[s]) then Exit;
  if (l <= Y[s]) and (Y[f] <= r) then
    begin
      Inc(count[i]);
      node[i] := Y[f] - Y[s];
      Exit;
    end;
  m := (s + f) shr 1;
  OpenHCN(i shl 1, l, r, s, m);
  if m > s then OpenHCN(i shl 1 + 1, l, r, m, f);
  if count[i] = 0 then
    node[i] := node[i shl 1] + node[i shl 1 + 1];
end;

procedure CloseHCN(i, l, r, s, f : Integer);
var
  m : Integer;
begin
  if s >= f then Exit;
  if (l >= Y[f]) or (r <= Y[s]) then Exit;
  if (l <= Y[s]) and (Y[f] <= r) then
    begin
      Dec(count[i]);
      if count[i] = 0 then
        node[i] := node[i shl 1] + node[i shl 1 + 1];
      Exit;
    end;
  m := (s + f) shr 1;
  CloseHCN(i shl 1, l, r, s, m);
  if m > s then CloseHCN(i shl 1 + 1, l, r, m, f);
  if count[i] = 0 then
    node[i] := node[i shl 1] + node[i shl 1 + 1];
end;

procedure Solve;
var
  i, j1, j2, ax, bx : Integer;
begin
  i := Abs(HCN[1]);
  OpenHCN(1, y1[i], y2[i], 1, n2);
  for i := 2 to n2 do
    begin
      j1 := HCN[i];
      j2 := HCN[i - 1];
      if j1 < 0 then ax := x1[-j1] else ax := x2[j1];
      if j2 < 0 then bx := x1[-j2] else bx := x2[j2];
      Inc(res, node[1] * (ax - bx));
      if j1 < 0 then
        OpenHCN(1, y1[-j1], y2[-j1], 1, n2)
      else
        CloseHCN(1, y1[j1], y2[j1], 1, n2);
    end;
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