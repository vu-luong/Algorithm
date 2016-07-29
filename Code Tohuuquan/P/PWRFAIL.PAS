{$MODE OBJFPC}
program PWRFAIL;
const
  maxN = 1000;
  maxM = maxN * (maxN - 1) div 2;
  maxD = maxM * Round(2e5) + 1;

type
  TEdge = record
    x, y : Integer;
    w : Double;
  end;
  TCoord = record
    x, y : Integer;
  end;
  THeap = record
    nItems : Integer;
    item, pos : array[1..maxN] of Integer;
  end;

var
  e : array[-maxM..maxM] of TEdge;
  link : array[-maxM..maxM] of Integer;
  head : array[1..maxN] of Integer;
  p : array[1..maxN] of TCoord;
  d : array[1..maxN] of Double;
  heap : THeap;
  n, m : Integer;
  dmax : Real;

procedure MakeEdge(id, u, v : Integer; dist : Double = 0);
begin
  with e[id] do
    begin
      x := u; y := v; w := dist;
      link[id] := head[x];
      head[x] := id;
    end;
  with e[-id] do
    begin
      x := v; y := u; w := dist;
      link[-id] := head[x];
      head[x] := -id;
    end;
end;

procedure Enter;
var
  i, u, v : Integer;
begin
  ReadLn(n, m);
  ReadLn(dmax);
  for i := 1 to n do
    with p[i] do ReadLn(x, y);
  for i := 1 to m do
    begin
      ReadLn(u, v);
      MakeEdge(i, u, v);
    end;
end;

function CalDist(u, v : Integer) : Double;
var
  dx, dy : Int64;
begin
  dx := p[u].x - p[v].x;
  dy := p[u].y - p[v].y;
  result := Sqrt(Sqr(dx) + Sqr(dy));
end;

procedure Init;
var
  i, j : Integer;
  dist : Double;
begin
  for i := 1 to n - 1 do
    for j := i + 1 to n do
      begin
        dist := CalDist(i, j);
        if dist <= dmax then
          begin
            Inc(m);
            MakeEdge(m, i, j, dist);
          end;
      end;
end;

function Extract : Integer;
var
  p, c, v : Integer;
begin
  with heap do
    begin
      result := item[1];
      v := item[nItems];
      Dec(nItems);
      p := 1;
      repeat
        c := p shl 1;
        if (c < nItems) and (d[item[c + 1]] < d[item[c]]) then Inc(c);
        if (c > nItems) or (d[v] <= d[item[c]]) then Break;
        item[p] := item[c];
        pos[item[p]] := p;
        p := c;
      until false;
      item[p] := v;
      pos[v] := p;
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
        begin
          Inc(nItems);
          c := nItems;
        end;
      repeat
        p := c shr 1;
        if (p = 0) or (d[item[p]] <= d[v]) then Break;
        item[c] := item[p];
        pos[item[c]] := c;
        c := p;
      until false;
      item[c] := v;
      pos[v] := c;
    end;
end;

function Relax(u, v : Integer; w : Double) : Boolean;
begin
  result := d[v] > d[u] + w;
  if result then
    d[v] := d[u] + w;
end;

procedure Solve;
var
  i, u, v : Integer;
begin
  for u := 2 to n do d[u] := maxD;

  with heap do
    begin
      nItems := 1;
      item[1] := 1;
      pos[1] := 1;
    end;

  repeat
    u := Extract;
    if u = n then Break;
    i := head[u];
    while i <> 0 do
      begin
        v := e[i].y;
        if Relax(u, v, e[i].w) then Update(v);
        i := link[i];
      end;
  until heap.nItems = 0;
end;

procedure Print;
begin
  if d[n] = maxD then WriteLn(-1)
    else WriteLn(Trunc(d[n] * 1000));
end;

begin
  Enter;
  Init;
  Solve;
  Print;
end.