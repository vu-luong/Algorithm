{$MODE OBJFPC}
{$OPTIMIZATION ON}
program BALLGAME;
const
  maxN = Round(1e5);
  maxM = Round(1e5);

type
  THeap = record
    nItems : Integer;
    item, pos : array[1..maxN] of Integer;
  end;
  TInfo = record
    c : Char;
    u, v : Integer;
  end;
  TRec = record
    p : Char;
    hole, time : Integer;
  end;

var
  a : array[1..maxM] of TInfo;
  time : array[1..maxN] of Integer;
  res : array[1..maxM] of TRec;
  heapMin, heapMax, heapID : THeap;
  n, m, countA, countB, loop : Integer;

procedure Enter;
begin
  ReadLn(n, m);
  for loop := 1 to m do
    with a[loop] do ReadLn(c, u, v);
end;

procedure PushMin(v : Integer);
var
  p, c : Integer;
begin
  with heapMin do
    begin
      nItems := nItems + 1;
      c := nItems;
      repeat
        p := c shr 1;
        if (p = 0) or (item[p] < v) then Break;
        item[c] := item[p]; pos[item[c]] := c; c := p;
      until false;
      item[c] := v; pos[v] := c;
    end;
end;

procedure ExtractMin(v : Integer);
var
  p, c : Integer;
begin
  with heapMin do
    begin
      c := pos[v]; pos[v] := 0;
      v := item[nItems]; nItems := nItems - 1;
      repeat
        p := c shr 1;
        if (p = 0) or (item[p] < v) then Break;
        item[c] := item[p]; pos[item[c]] := c; c := p;
      until false;
      item[c] := v; pos[v] := c;

      p := c;
      repeat
        c := p shl 1;
        if (c < nItems) and (item[c + 1] < item[c]) then c := c + 1;
        if (c > nItems) or (v < item[c]) then Break;
        item[p] := item[c]; pos[item[p]] := p; p := c;
      until false;
      item[p] := v; pos[v] := p;
    end;
end;

procedure PushMax(v : Integer);
var
  p, c : Integer;
begin
  with heapMax do
    begin
      nItems := nItems + 1;
      c := nItems;
      repeat
        p := c shr 1;
        if (p = 0) or (item[p] > v) then Break;
        item[c] := item[p]; pos[item[c]] := c; c := p;
      until false;
      item[c] := v; pos[v] := c;
    end;
end;

procedure ExtractMax(v : Integer);
var
  p, c : Integer;
begin
  with heapMax do
    begin
      c := pos[v]; pos[v] := 0;
      v := item[nItems]; nItems := nItems - 1;
      repeat
        p := c shr 1;
        if (p = 0) or (item[p] > v) then Break;
        item[c] := item[p]; pos[item[c]] := c; c := p;
      until false;
      item[c] := v; pos[v] := c;

      p := c;
      repeat
        c := p shl 1;
        if (c < nItems) and (item[c + 1] > item[c]) then c := c + 1;
        if (c > nItems) or (v > item[c]) then Break;
        item[p] := item[c]; pos[item[p]] := p; p := c;
      until false;
      item[p] := v; pos[v] := p;
    end;
end;

procedure PushID(v : Integer);
var
  p, c : Integer;
begin
  with heapID do
    begin
      nItems := nItems + 1;
      c := nItems;
      repeat
        p := c shr 1;
        if (p = 0) or (time[item[p]] <= time[v]) then Break;
        item[c] := item[p]; pos[item[c]] := c; c := p;
      until false;
      item[c] := v; pos[v] := c;
    end;
end;

procedure ExtractID(v : Integer);
var
  p, c : Integer;
begin
  with heapID do
    begin
      c := pos[v]; pos[v] := 0;
      v := item[nItems]; nItems := nItems - 1;
      repeat
        p := c shr 1;
        if (p = 0) or (time[item[p]] <= time[v]) then Break;
        item[c] := item[p]; pos[item[c]] := c; c := p;
      until false;
      item[c] := v; pos[v] := c;

      p := c;
      repeat
        c := p shl 1;
        if (c < nItems) and (time[item[c + 1]] < time[item[c]]) then
          c := c + 1;
        if (c > nItems) or (time[v] <= time[item[c]]) then Break;
        item[p] := item[c]; pos[item[p]] := p; p := c;
      until false;
      item[p] := v; pos[v] := p;
    end;
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
    while (pivot.u < a[j].u) and (i < j) do Dec(j);
    if i < j then
      begin a[i] := a[j]; Inc(i); end
      else Break;
    while (a[i].u < pivot.u) and (i < j) do Inc(i);
    if i < j then
      begin a[j] := a[i]; Dec(j); end
      else Break;
  until i = j;
  a[i] := pivot;
  SortA(l, i - 1);
  SortA(i + 1, r);
end;

procedure Init;
var
  i : Integer;
begin
  for i := 1 to n do
    begin
      PushMin(i);
      PushMax(i);
    end;
  SortA(1, m);
end;

procedure PrintLost(c : Char; num, time : Integer);
begin
  if c = 'A' then
    WriteLn('Alice loses at her turn: ', num)
  else
    WriteLn('Bob loses at his turn: ', num);
  WriteLn('Game lasts: ', time, ' minute(s)');

  Halt;
end;

procedure AddRes(p : Char; hole, time : Integer);
begin
  res[loop].p := p;
  res[loop].hole := hole;
  res[loop].time := time;
end;

procedure SolveA(u, v : Integer);
var
  tmp : Integer;
begin
  countA := countA + 1;
  while (heapID.nItems > 0) and (time[heapID.item[1]] <= u) do
    begin
      tmp := heapID.item[1];
      ExtractID(tmp);
      PushMin(tmp);
      PushMax(tmp);
    end;
  if heapMin.nItems = 0 then
    PrintLost('A', countA, u)
  else
    begin
      tmp := heapMin.item[1];
      ExtractMin(tmp);
      ExtractMax(tmp);
      time[tmp] := u + v;
      PushID(tmp);
      AddRes('A', tmp, time[tmp]);
    end;
end;

procedure SolveB(u, v : Integer);
var
  tmp : Integer;
begin
  countB := countB + 1;
  while (heapID.nItems > 0) and (time[heapID.item[1]] <= u) do
    begin
      tmp := heapID.item[1];
      ExtractID(tmp);
      PushMin(tmp);
      PushMax(tmp);
    end;
  if heapMax.nItems = 0 then
    PrintLost('B', countB, u)
  else
    begin
      tmp := heapMax.item[1];
      ExtractMin(tmp);
      ExtractMax(tmp);
      time[tmp] := u + v;
      PushID(tmp);
      AddRes('B', tmp, time[tmp]);
    end;
end;

procedure Print;
var
  i : Integer;
begin
  WriteLn('DRAW');
  while heapID.nItems > 1 do ExtractID(heapID.item[1]);
  WriteLn('Game lasts: ', time[heapID.item[1]], ' minute(s)');

  for i := 1 to m do
    with res[i] do
      if p = 'A' then
        WriteLn('Alice takes the hole: ', hole)
      else
        WriteLn('Bob takes the hole: ', hole);
end;

begin
  Enter;
  Init;
  for loop := 1 to m do
    with a[loop] do
      if c = 'A' then
        SolveA(u, v)
      else
        SolveB(u, v);
  Print;
end.