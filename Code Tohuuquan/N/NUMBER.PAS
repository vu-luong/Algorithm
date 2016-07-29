{$MODE OBJFPC}
program NUMBER;
uses
  Math;

const
  maxN = 10000;

type
  PNode = ^TNode;
  TNode = record
    v : Integer;
    link : PNode;
  end;

var
  head : array[1..maxN] of PNode;
  stack, num, low, group : array[1..maxN] of Integer;
  check : array[1..maxN] of Boolean;
  n, m, t, res, count, comp, top : Integer;

procedure Enter;
var
  i, u, v : Integer;

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
  ReadLn(n, m, t);
  for i := 1 to m do
    begin
      ReadLn(u, v);
      Add(u, v);
    end;
end;

procedure DFSVisit(u : Integer);
var
  v : Integer;
  p : PNode;
begin
  Inc(count);
  num[u] := count; low[u] := num[u];
  Inc(top); stack[top] := u;

  p := head[u];
  while p <> nil do
    begin
      v := p^.v; p := p^.link;
      if group[v] = 0 then
        if num[v] = 0 then
          begin
            DFSVisit(v);
            low[u] := Min(low[u], low[v]);
          end
        else
          low[u] := Min(low[u], num[v]);
    end;

  if num[u] = low[u] then
    begin
      Inc(comp);
      repeat
        v := stack[top]; Dec(top);
        group[v] := comp;
      until v = u;
    end;
end;

procedure Init;
var
  u : Integer;
begin
  for u := 1 to n do
    if num[u] = 0 then DFSVisit(u);
end;

procedure Solve;
var
  u, v : Integer;
  p : PNode;
begin
  FillChar(check, SizeOf(check), true);
  for u := 1 to n do
    if group[u] <> group[t] then
      begin
        p := head[u];
        while p <> nil do
          begin
            v := p^.v; p := p^.link;
            if group[u] <> group[v] then
              check[group[u]] := false;
          end;
      end;

  for u := 1 to comp do
    if check[u] then Inc(res);
end;

procedure Print;
begin
  WriteLn(res - 1);
end;

begin
  Enter;
  Init;
  Solve;
  Print;
end.