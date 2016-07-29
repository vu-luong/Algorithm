{$MODE OBJFPC}
program LIGHT;
uses
  Math;

const
  maxN = 202;
  oo = Round(1e9);

var
  a, f : array[1..maxN, 1..maxN] of Integer;
  delta, trace : array[1..maxN] of Integer;
  n, r, c, k : Integer;

procedure Enter;
var
  i, u, v : Integer;
begin
  ReadLn(r, c, k);
  n := r + c + 2;
  for i := 1 to r do Read(a[1, i + 1]);
  for i := 1 to c do Read(a[r + i + 1, n]);
  for i := 1 to k do
    begin
      ReadLn(u, v);
      a[u + 1, v + r + 1] := oo;
    end;
end;

function FindPath : Boolean;
var
  queue : array[1..maxN] of Integer;
  first, last, u, v : Integer;
begin
  FillChar(trace[1], n * SizeOf(trace[1]), 0);
  queue[1] := 1; first := 1; last := 1;
  delta[1] := oo;
  repeat
    u := queue[first]; Inc(first);
    for v := 1 to n do
      if trace[v] = 0 then
        begin
          if f[u, v] < a[u, v] then
            begin
              trace[v] := u;
              delta[v] := Min(delta[u], a[u, v] - f[u, v]);
            end;
          if f[v, u] > 0 then
            begin
              trace[v] := -u;
              delta[v] := Min(delta[u], f[v, u]);
            end;
          if trace[v] <> 0 then
            begin
              if v = n then Exit(true);
              Inc(last); queue[last] := v;
            end;
        end;
  until first > last;
  Exit(false);
end;

procedure IncFlow;
var
  u, v : Integer;
begin
  v := n;
  while v <> 1 do
    begin
      u := trace[v];
      if u > 0 then Inc(f[u, v], delta[n]) else
        begin
          u := -u;
          Dec(f[v, u], delta[n]);
        end;
      v := u;
    end;
end;

procedure Solve;
begin
  while FindPath do IncFlow;
end;

procedure Print;
var
  i, w : Integer;
begin
  w := 0;
  for i := 1 to n do
    if a[1, i] > 0 then Inc(w, f[1, i]);
  Write(w);
end;

begin
  Enter;
  Solve;
  Print;
end.