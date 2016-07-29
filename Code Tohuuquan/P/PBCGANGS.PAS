{$MODE OBJFPC}
program PBCGANGS;
const
  maxN = 1000;

type
  PNode = ^TNode;
  TNode = record
    v : Integer;
    link : PNode;
  end;

var
  head : array[1..maxN] of PNode;
  e : array[1..maxN] of Integer;
  n, m, res : Integer;

procedure Enter;
var
  i, u, v : Integer;
  c : Char;

  procedure Add(u, v : Integer);
  var
    p : PNode;
  begin
    New(p);
    p^.v := v;
    p^.link := head[u];
    head[u] := p;
  end;

begin
  ReadLn(n);
  ReadLn(m);
  for i := 1 to m do
    begin
      ReadLn(c, u, v);
      if c = 'F' then
        begin Add(u, v); Add(v, u); end
      else
        begin
          if e[v] > 0 then
            begin Add(u, e[v]); Add(e[v], u); end;
          if e[u] > 0 then
            begin Add(v, e[u]); Add(e[u], v); end;
          e[u] := v;
          e[v] := u;
        end;
    end;
end;

procedure DFS(u : Integer);
var
  v : Integer;
  p : PNode;
begin
  e[u] := 1;
  p := head[u];
  while p <> nil do
    begin
      v := p^.v; p := p^.link;
      if e[v] = 0 then DFS(v);
    end;
end;

procedure Solve;
var
  u : Integer;
begin
  FillChar(e, SizeOf(e), 0);
  for u := 1 to n do
    if e[u] = 0 then
      begin
        Inc(res);
        DFS(u);
      end;
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