{$MODE OBJFPC}
program KBUILD;
uses
  Math;
const
  maxN = 200000;

type
  PNode = ^TNode;
  TNode = record
    v : Integer;
    link : PNode;
  end;

var
  adj : array[1..maxN] of PNode;
  num, low, par : array[1..maxN] of Integer;
  N, M, res, count : Integer;

procedure Enter;
var
  i, u, v : Integer;

  procedure Add(u, v : Integer);
  var
    p : PNode;
  begin
    New(p);
    p^.v := v;
    p^.link := adj[u];
    adj[u] := p;
  end;

begin
  ReadLn(N);
  for i := 1 to N - 1 do
    begin
      ReadLn(u, v);
      Add(u, v);
      Add(v, u);
    end;

  ReadLn(M);
  for i := 1 to M do
    begin
      ReadLn(u, v);
      Add(u, v);
      Add(v, u);
    end;
end;

procedure Visit(u : Integer);
var
  v : Integer;
  p : PNode;
begin
  Inc(count);
  num[u] := count;
  low[u] := N + 1;

  p := adj[u];
  while p <> nil do
    begin
      v := p^.v;
      p := p^.link;

      if num[v] <> 0 then
        begin
          if v <> par[u] then
            low[u] := Min(low[u], num[v]);
        end
      else
        begin
          par[v] := u;

          Visit(v);

          if low[v] > num[u] then Inc(res);
          low[u] := Min(low[u], low[v]);
        end;
    end;
end;

procedure Solve;
var
  u : Integer;
begin
  for u := 1 to N do
    if num[u] = 0 then
      Visit(u);

  WriteLn(res);
end;

begin
  Enter;
  Solve;
end.