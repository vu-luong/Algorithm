{$MODE OBJFPC}
program CTREE;
uses
  Math;

const
  maxN = Round(1e4);
  maxC = 3;
  maxF = maxN * maxC;

type
  PNode = ^TNode;
  TNode = record
    v : Integer;
    link : PNode;
  end;

var
  head : array[1..maxN] of PNode;
  f : array[1..maxN, 1..maxC] of Integer;
  free : array[1..maxN] of Boolean;
  res : array[1..maxN] of Integer;
  n : Integer;

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
  ReadLn(n);
  for i := 1 to n - 1 do
    begin
      ReadLn(u, v);
      Add(u, v);
      Add(v, u);
    end;
end;

procedure Paint(u : Integer);
var
  i, j, t, v : Integer;
  p : PNode;
begin
  free[u] := false;
  for i := 1 to maxC do
    begin
      f[u, i] := i;
      p := head[u];
      while p <> nil do
        begin
          v := p^.v; p := p^.link;
          if free[v] then Paint(v);

          t := maxF;
          for j := 1 to maxC do
            if j <> i then t := Min(t, f[v, j]);
          Inc(f[u, i], t);
        end;
    end;
end;

procedure Find(u : Integer);
var
  i, j, v : Integer;
  p : PNode;
begin
  free[u] := false;
  p := head[u];
  while p <> nil do
    begin
      v := p^.v; p := p^.link;
      if free[v] then
        begin
          res[v] := 1;
          for j := 1 to maxC do
            if j <> res[u] then
              if (res[v] = res[u]) or (f[v, j] < f[v, res[v]])
                then res[v] := j;
          free[v] := false;
          Find(v);
        end;
    end;
end;

procedure Solve;
var
  i : Integer;
begin
  FillChar(free, SizeOf(free), true);
  Paint(1);

  res[1] := 1;
  for i := 2 to maxC do
    if f[1, i] < f[1, res[1]] then res[1] := i;

  FillChar(free, SizeOf(free), true);
  Find(1);
end;

procedure Print;
var
  i : Integer;
begin
  WriteLn(f[1, res[1]]);
  for i := 1 to n do WriteLn(res[i]);
end;

begin
  Enter;
  Solve;
  Print;
end.