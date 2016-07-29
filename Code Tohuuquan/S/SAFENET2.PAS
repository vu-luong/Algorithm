{$MODE OBJFPC}
program SAFENET2;
uses
  Math;

const
  maxN = Round(3e4);
  maxM = Round(1e5);

type
  TEdge = record
    u, v : Integer;
  end;
  TStack = record
    top : Integer;
    x, y : array[1..maxN] of Integer;
  end;

var
  e : array[-maxM..maxM] of TEdge;
  link : array[-maxM..maxM] of Integer;
  head, num, low, parent : array[1..maxN] of Integer;
  stack : TStack;
  n, m, count, res, tmp : Integer;

procedure Enter;
var
  i, x, y : Integer;
begin
  ReadLn(n, m);
  for i := 1 to m do
    begin
      ReadLn(x, y);
      with e[i] do
        begin
          u := x; v := y;
          link[i] := head[u];
          head[u] := i;
        end;
      with e[-i] do
        begin
          u := y; v := x;
          link[-i] := head[u];
          head[u] := -i;
        end;
    end;
end;

procedure Push(u, v : Integer);
begin
  with stack do
    begin
      Inc(top);
      x[top] := u;
      y[top] := v;
    end;
end;

procedure Pop(var u, v : Integer);
begin
  with stack do
    begin
      u := x[top];
      v := y[top];
      Dec(top);
    end;
end;

procedure DFSVisit(u : Integer);
var
  i, x, y, v : Integer;
begin
  Inc(count);
  num[u] := count;
  low[u] := n + 1;

  i := head[u];
  while i <> 0 do
    begin
      v := e[i].v; i := link[i];
      if num[v] <> 0 then
        begin
          if v <> parent[u] then
            low[u] := Min(low[u], num[v]);
        end
      else
        begin
          parent[v] := u;
          Push(u, v);
          DFSVisit(v);
          low[u] := Min(low[u], low[v]);
          if low[v] >= num[u] then
            begin
              tmp := 1;
              repeat
                Pop(x, y);
                Inc(tmp);
              until (x = u) and (y = v);
              res := Max(res, tmp);
            end;
        end;
    end;
end;

procedure Solve;
var
  u : Integer;
begin
  res := 1;
  for u := 1 to n do
    if num[u] = 0 then DFSVisit(u);
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