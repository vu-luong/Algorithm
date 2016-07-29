{$MODE OBJFPC}
program ROADS;
uses
  Math;

const
  maxN = 100;
  maxL = maxN * 1000 + 1;
  maxT = maxN * 1000 + 1;

type
  PNode = ^TNode;
  TNode = record
    v, l, t : Integer;
    link : PNode;
  end;

var
  pre, head : array[1..maxN] of PNode;
  f, r, d : array[1..maxN] of Integer;
  free : array[1..maxN] of Boolean;
  n, k, m : Integer;
  nTests : Integer;

procedure Enter;
var
  i, u, v, l, t : Integer;

 procedure Add(var list : PNode; v, l, t : Integer);
 var
   p : PNode;
 begin
   New(p);
   p^.v := v; p^.l := l; p^.t := t;
   p^.link := list; list := p;
 end;

begin
  ReadLn(k); ReadLn(n); ReadLn(m);
  for i := 1 to n do
    begin
      head[i] := nil;
      pre[i] := nil;
    end;
  for i := 1 to m do
    begin
      ReadLn(u, v, l, t);
      Add(head[u], v, l, t);
      Add(pre[v], u, l, t);
    end;
end;

procedure CalF;
var
  u, v, t, minF : Integer;
  p : PNode;
begin
  FillChar(free, SizeOf(free), true);
  for u := 1 to n do f[u] := maxT;
  f[n] := 0;
  repeat
    u := 0; minF := maxT;
    for v := 1 to n do
      if free[v] and (f[v] < minF) then
        begin
          u := v;
          minF := f[v];
        end;
    if u = 0 then Break;
    free[u] := false;

    p := pre[u];
    while p <> nil do
      begin
        v := p^.v; t := p^.t; p := p^.link;
        if free[v] then
          f[v] := Min(f[v], f[u] + t);
      end;
  until false;
end;

procedure CalDV;
var
  u, v, l, t, minD : Integer;
  p : PNode;
begin
  FillChar(free, SizeOf(free), true);
  for u := 1 to n do
    begin d[u] := maxL; r[u] := maxT; end;
  d[1] := 0; r[1] := 0;
  repeat
    u := 0; minD := maxL;
    for v := 1 to n do
      if free[v] and (d[v] < minD) and (r[v] + f[v] <= k) then
        begin
          u := v;
          minD := d[v];
        end;
    if (u = 0) or (u = n) then Break;
    free[u] := false;

    p := head[u];
    while p <> nil do
      begin
        v := p^.v; l := p^.l; t := p^.t; p := p^.link;
        if free[v] and (d[v] > d[u] + l) and (f[v] + r[u] + t <= k) then
          begin
            d[v] := d[u] + l;
            r[v] := r[u] + t;
          end;
      end;
  until false;
end;

procedure Solve;
begin
  CalF;
  CalDV;
end;

procedure Print;
begin
  if d[n] = maxL then WriteLn(-1) else WriteLn(d[n]);
end;

begin
  ReadLn(nTests);
  while nTests > 0 do
    begin
      Dec(nTests);
      Enter;
      Solve;
      Print;
    end;
end.