{$MODE OBJFPC}
program TRAFFICN;
uses
  Math;

const
  maxN = Round(1e4);
  maxM = Round(1e5);
  maxD = maxM * 1000 + 1;

type
  Arr = array[1..maxN] of Integer;
  PNode = ^TNode;
  TNode = record
    v, w : Integer;
    link : PNode;
  end;
  THeap = record
    nItems : Integer;
    item, pos : Arr;
  end;

var
  head1, head2 : array[1..maxN] of PNode;
  d1, d2 : Arr;
  heap : THeap;
  n, m, k, s, t, res : Integer;
  nTests : Integer;

procedure Enter;
var
  i, u, v, w : Integer;

  procedure Add(var list : PNode; v, w : Integer);
  var
    p : PNode;
  begin
    New(p);
    p^.v := v; p^.w := w;
    p^.link := list; list := p;
  end;

  procedure Clear(var list : PNode);
  var
    p : PNode;
  begin
    while list <> nil do
      begin
        p := list;
        list := list^.link;
        Dispose(p);
      end;
  end;

begin
  ReadLn(n, m, k, s, t);
  for i := 1 to n do
    begin
      Clear(head1[i]);
      Clear(head2[i]);
    end;
  for i := 1 to m do
    begin
      ReadLn(u, v, w);
      Add(head1[u], v, w);
      Add(head2[v], u, w);
    end;
end;

procedure Dijkstra(start : Integer; var d : Arr; flag : Integer);
var
  u : Integer;
  p : PNode;

  function Extract : Integer;
  var
    p, c, v : Integer;
  begin
    with heap do
      begin
        result := item[1];
        v := item[nItems];
        Dec(nItems);
        p := 1;
        repeat
          c := p shl 1;
          if (c < nItems) and (d[item[c + 1]] < d[item[c]]) then Inc(c);
          if (c > nItems) or (d[v] <= d[item[c]]) then Break;
          item[p] := item[c];
          pos[item[p]] := c;
          p := c;
        until false;
        item[p] := v;
        pos[v] := p;
      end;
  end;

  procedure Update(v : Integer);
  var
    p, c : Integer;
  begin
    with heap do
      begin
        c := pos[v];
        if c = 0 then
          begin
            Inc(nItems);
            c := nItems;
          end;
        repeat
          p := c shr 1;
          if (p = 0) or (d[item[p]] <= d[v]) then Break;
          item[c] := item[p];
          pos[item[c]] := c;
          c := p;
        until false;
        item[c] := v;
        pos[v] := c;
      end;
  end;

  function Relax(u, v, w : Integer) : Boolean;
  begin
    result := d[v] > d[u] + w;
    if result then
      d[v] := d[u] + w;
  end;

begin
  for u := 1 to n do d[u] := maxD;
  d[start] := 0;
  with heap do
    begin
      FillChar(pos, SizeOf(pos), 0);
      nItems := 1;
      item[1] := start;
      pos[start] := 1;
    end;

  if flag = 1 then
    repeat
      u := Extract;
      if u = 0 then Break;

      p := head1[u];
      while p <> nil do
        begin
          if Relax(u, p^.v, p^.w) then Update(p^.v);
          p := p^.link;
        end;
    until heap.nItems = 0
  else
    repeat
      u := Extract;
      if u = 0 then Break;

      p := head2[u];
      while p <> nil do
        begin
          if Relax(u, p^.v, p^.w) then Update(p^.v);
          p := p^.link;
        end;
    until heap.nItems = 0
end;

procedure Init;
begin
  Dijkstra(s, d1, 1);
  Dijkstra(t, d2, 2);
end;

procedure Solve;
var
  i, u, v, w : Integer;
begin
  res := d1[t];
  for i := 1 to k do
    begin
      ReadLn(u, v, w);
      res := Min(res, d1[u] + w + d2[v]);
      res := Min(res, d1[v] + w + d2[u]);
    end;
  if res = maxD then res := -1;
end;

procedure Print;
begin
  WriteLn(res);
end;

begin
  ReadLn(nTests);
  while nTests > 0 do
    begin
      Dec(nTests);
      Enter;
      Init;
      Solve;
      Print;
    end;
end.