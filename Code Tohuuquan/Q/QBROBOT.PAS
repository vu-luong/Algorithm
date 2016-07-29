{$MODE OBJFPC}
program QBROBOT;
const
  maxN = 500;
  maxM = 30000;
  maxT = 10000;
  maxD = maxM * maxT + 1;

type
  TEdge = record
    x, y, t, c : Integer;
  end;
  THeap = record
    nItems : Integer;
    item, pos : array[1..maxN] of Integer;
  end;

var
  e : array[1..maxM * 2] of TEdge;
  link : array[1..maxM * 2] of Integer;
  head, d : array[1..maxN] of Integer;
  a : array[1..maxN] of Boolean;
  heap : THeap;
  n, m : Integer;

procedure Enter;
var
  i, j, u, v, _t, _c : Integer;
begin
  ReadLn(n);
  for i := 1 to n do
    begin
      Read(u);
      a[i] := (u = 1);
    end;
  ReadLn(m);
  j := m * 2;
  for i := 1 to m do
    begin
      ReadLn(u, v, _t, _c);
      with e[i] do
        begin x := u; y := v; t := _t; c := _c; end;
      with e[j] do
        begin x := v; y := u; t := _t; c := _c; end;
      Dec(j);
    end;
  for i := 1 to m * 2 do
    with e[i] do
      begin
        link[i] := head[x];
        head[x] := i;
      end;
end;

function Extract : Integer;
var
  p, c, v : Integer;
begin
  with heap do
    begin
      result := item[1];
      v := item[nItems]; Dec(nItems);
      p := 1;
      repeat
        c := p shl 1;
        if (c < nItems) and (d[item[c + 1]] < d[item[c]]) then Inc(c);
        if (c > nItems) or (d[v] <= d[item[c]]) then Break;
        item[p] := item[c]; pos[item[p]] := p; p := c;
      until false;
      item[p] := v; pos[v] := p;
    end;
end;

procedure Update(v : Integer);
var
  p, c : Integer;
begin
  with heap do
    begin
      c := pos[v];
      if c = 0 then
        begin Inc(nItems); c := nItems; end;
      repeat
        p := c shr 1;
        if (p = 0) or (d[item[p]] <= d[v]) then Break;
        item[c] := item[p]; pos[item[c]] := c; c := p;
      until false;
      item[c] := v; pos[v] := c;
    end;
end;

procedure Dijkstra;
var
  i, u, v : Integer;
begin
  for u := 1 to n do d[u] := maxD;
  d[n] := 0;
  with heap do
    begin
      nItems := 1;
      item[1] := n;
      pos[n] := 1;
    end;
  repeat
    u := Extract;
    i := head[u];
    while i > 0 do
      begin
        v := e[i].y;
        if d[v] > d[u] + e[i].t then
          begin
            d[v] := d[u] + e[i].t;
            Update(v);
          end;
        i := link[i];
      end;
  until heap.nItems = 0;
end;

function Check(u, t, w : Integer; const limit : Integer) : Boolean;
var
  i, v : Integer;
begin
  i := head[u];
  while i > 0 do
    begin
      v := e[i].y;
      if (t + e[i].t + d[v] = d[1]) and (w >= e[i].c) then
        if a[v] then
          begin
            if (v = n) or Check(v, t + e[i].t, limit, limit)
              then Exit(true);
          end
        else
          begin
            if (v = n) or Check(v, t + e[i].t, w - e[i].c, limit)
              then Exit(true);
          end;
      i := link[i];
    end;
  Exit(false);
end;

procedure Solve;
var
  low, high, mid : Integer;
begin
  Dijkstra;
  low := 0; high := maxInt;
  repeat
    mid := (low + high) shr 1;
    if Check(1, 0, mid, mid) then
      high := mid - 1
    else
      low := mid + 1;
  until low > high;
  WriteLn(low);
end;

begin
  Enter;
  Solve;
end.