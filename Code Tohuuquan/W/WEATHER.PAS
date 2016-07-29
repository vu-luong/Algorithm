{$MODE OBJFPC}
program WEATHER;
uses
  Math;

const
  maxN = 100;

var
  a : array[1..maxN, 1..maxN] of Boolean;
  parent, num, low : array[1..maxN] of Integer;
  n, m, count, res : Integer;

procedure Enter;
var
  i, u, v : Integer;
begin
  ReadLn(n);
  ReadLn(m);
  for i := 1 to m do
    begin
      ReadLn(u, v);
      a[u, v] := true;
      a[v, u] := true;
    end;
end;

procedure Cal(s, t : Integer);
var
  d : array[1..2] of Integer;
  free : array[1..maxN] of Boolean;
  i, u : Integer;

  procedure DFS(u : Integer);
  var
    v : Integer;
  begin
    Inc(d[i]);
    free[u] := false;
    for v := 1 to n do
      if free[v] and a[u, v] then DFS(v);
  end;

begin
  a[s, t] := false; a[t, s] := false;

  FillChar(free, SizeOf(free), true);
  i := 0;
  for u := 1 to n do
    if free[u] then
      begin
        Inc(i);
        d[i] := 0;
        DFS(u);
      end;
  Inc(res, d[1] * d[2]);

  a[s, t] := true; a[t, s] := true;
end;

procedure Visit(u : Integer);
var
  v : Integer;
begin
  Inc(count);
  num[u] := count;
  low[u] := n + 1;

  for v := 1 to n do
    if a[u, v] then
      if num[v] <> 0 then
        begin
          if v <> parent[u] then
            low[u] := Min(low[u], num[v]);
        end
      else
        begin
          parent[v] := u;
          Visit(v);
          if low[v] > num[u] then Cal(u, v);
          low[u] := Min(low[u], low[v]);
        end;
end;

procedure Solve;
var
  u : Integer;
begin
  for u := 1 to n do
    if num[u] = 0 then Visit(u);
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
