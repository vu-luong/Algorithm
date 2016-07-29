{$MODE OBJFPC}
program LQDHAUNT;
uses
  Math;

const
  maxW = 30;
  maxH = 30;
  maxN = maxW * maxH;
  maxM = maxN * 4;
  maxD = maxM * Round(1e5);
  dx : array[1..4] of Integer = ( 0, -1, 0, 1 );
  dy : array[1..4] of Integer = ( -1, 0, 1, 0 );

type
  THole = record
    x, y, t : Integer;
  end;
  TEdge = record
    x, y, l : Integer;
  end;

var
  lab : array[0..maxW, 0..maxH] of Integer;
  hole : array[1..maxN] of THole;
  e : array[1..maxM] of TEdge;
  link : array[1..maxM] of Integer;
  head, d : array[1..maxN] of Integer;
  w, h, m, n : Integer;

procedure Enter;
var
  i, u, v : Integer;
begin
  ReadLn(w, h);
  if (w = 0) and (h = 0) then Halt;

  FillChar(lab, SizeOf(lab), 0);
  ReadLn(m);
  for i := 1 to m do
    begin
      ReadLn(u, v);
      lab[u, v] := -1;
    end;
  ReadLn(m);
  for i := 1 to m do
    with hole[i] do
      begin
        ReadLn(u, v, x, y, t);
        lab[u, v] := i;
      end;
end;

function Check(x, y : Integer) : Boolean;
begin
  result := (0 <= x) and (x < w) and (0 <= y) and (y < h);
end;

function ID(x, y : Integer) : Integer;
begin
  result := x * h + y + 1;
end;

procedure MakeEdge(u, v, t : Integer);
begin
  if u = n then Exit;
  Inc(m);
  with e[m] do
    begin
      x := u; y := v; l := t;
      link[m] := head[x];
      head[x] := m;
    end;
end;

procedure Init;
var
  i, j, k, u, v : Integer;
begin
  m := 0;
  n := ID(w - 1, h - 1);
  FillChar(head, SizeOf(head), 0);
  for i := 0 to w - 1 do
    for j := 0 to h - 1 do
      if lab[i, j] = 0 then
        for k := 1 to 4 do
          begin
            u := i + dx[k];
            v := j + dy[k];
            if Check(u, v) and (lab[u, v] >= 0) then
              MakeEdge(ID(i, j), ID(u, v), 1);
          end
      else if lab[i, j] > 0 then
        with hole[lab[i, j]] do
          MakeEdge(ID(i, j), ID(x, y), t);
end;

procedure BFS;
var
  queue : array[1..maxN] of Integer;
  free : array[1..maxN] of Boolean;
  i, u, v, first, last : Integer;
begin
  FillChar(free, SizeOf(free), true);
  for u := 1 to n do d[u] := maxD;
  first := 1; last := 1;

  queue[1] := 1;
  d[1] := 0;
  free[1] := false;

  repeat
    u := queue[first]; Inc(first);
    i := head[u];
    while i > 0 do
      begin
        v := e[i].y;
        if free[v] then
          begin
            d[v] := Min(d[v], d[u] + e[i].l);
            free[v] := false;
            Inc(last); queue[last] := v;
          end;
        i := link[i];
      end;
  until first > last;
end;

function Relax(u, v, l : Integer) : Boolean;
begin
  result := d[v] > d[u] + l;
  if result then
    d[v] := d[u] + l;
end;

function Never : Boolean;
var
  i, j : Integer;
  stop : Boolean;
begin
  BFS;
  for i := 1 to n do
    begin
      stop := true;
      for j := 1 to m do
        with e[j] do
          if (d[x] < maxD) and (d[y] < maxD) and Relax(x, y, l)
            then stop := false;
      if stop then Exit(false);
    end;
  Exit(true);
end;

procedure Solve;
begin
  if Never then
    WriteLn('Never')
  else if d[n] = maxD then
    WriteLn('Impossible')
  else
    WriteLn(d[n]);
end;

begin
  repeat
    Enter;
    Init;
    Solve;
  until false;
end.