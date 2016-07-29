{$MODE OBJFPC}
program QBBUILD;
uses
  Math;

const
  maxN = 100;
  maxC = maxN * 5000 + 1;

var
  c : array[1..maxN, 1..maxN] of Integer;
  t, p : array[1..4] of Integer;
  n, res : Integer;

procedure Enter;
var
  u, v : Integer;
begin
  ReadLn(n);
  for u := 1 to 4 do Read(p[u]);
  for u := 1 to n do
    for v := 1 to n do
      if u <> v then c[u, v] := maxC;
  while not EoF do
    begin
      ReadLn(u, v, c[u, v]);
      c[v, u] := c[u, v];
    end;
end;

procedure Init;
var
  k, u, v : Integer;
begin
  for k := 1 to n do
    for u := 1 to n do
      for v := 1 to n do
        c[u, v] := Min(c[u, v], c[u, k] + c[k, v]);
  res := maxC;
end;

procedure Update;
var
  u, v : Integer;
begin
  for u := 1 to n do
    for v := u to n do
      res := Min(res, c[t[1], u] + c[t[2], u] + c[t[3], v] + c[t[4], v] + c[u, v]);
end;

procedure Find(x : Integer);
var
  i : Integer;
begin
  if x > 4 then Update else
  for i := 1 to 4 do
    if p[i] > 0 then
      begin
        t[x] := p[i];
        p[i] := -p[i];
        Find(x + 1);
        p[i] := -p[i];
      end;
end;

procedure Print;
begin
  Write(res);
end;

begin
  Enter;
  Init;
  Find(1);
  Print;
end.