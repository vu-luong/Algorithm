{$MODE OBJFPC}
program CENTER28;
const
  maxN = Round(3e4);
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
  head : array[1..maxN] of PNode;
  res, d1, d2, f1, f2 : Arr;
  n, m, count : Integer;

procedure Enter;
var
  i, u, v, w : Integer;

  procedure Add(u, v, w : Integer);
  var
    p : PNode;
  begin
    New(p);
    p^.v := v; p^.w := w;
    p^.link := head[u]; head[u] := p;
  end;

begin
  ReadLn(n, m);
  for i := 1 to m do
    begin
      ReadLn(u, v, w);
      Add(u, v, w);
      Add(v, u, w);
    end;
end;

procedure Dijkstra(start : Integer; var d, f : Arr);
var
  heap : THeap;
  u, v, w : Integer;
  p : PNode;

  function Extract : Integer;
  var
    p, c, v : Integer;
  begin
    with heap do
      begin
        result := item[1];
        v := item[nItems];
        nItems := nItems - 1;
        p := 1;
        repeat
          c := p shl 1;
          if (c < nItems) and (d[item[c + 1]] < d[item[c]]) then Inc(c);
          if (c > nItems) or (d[v] <= d[item[c]]) then Break;
          item[p] := item[c];
          pos[item[p]] := p;
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
            nItems := nItems + 1;
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
  f[start] := 1;
  with heap do
    begin
      FillChar(pos[1], n * SizeOf(pos[1]), 0);
      nItems := 1;
      item[1] := start;
      pos[start] := 1;
    end;

  repeat
    u := Extract;
    if u = 0 then Break;
    p := head[u];
    while p <> nil do
      begin
        v := p^.v ; w := p^.w; p := p^.link;
        if Relax(u, v, w) then
          begin
            Update(v);
            f[v] := f[u];
          end
        else
          if d[v] = d[u] + w then
            f[v] := f[v] + f[u];
      end;
  until heap.nItems = 0;
end;

procedure Init;
begin
  Dijkstra(1, d1, f1);
  Dijkstra(n, d2, f2);
end;

procedure Solve;
var
  u : Integer;
begin
  for u := 1 to n do
    if not ((d1[u] + d2[u] = d1[n]) and (f1[u] * f2[u] = f1[n])) then
      begin
        Inc(count);
        res[count] := u;
      end;
end;

procedure Print;
var
  i : Integer;
begin
  WriteLn(count);
  for i := 1 to count do WriteLn(res[i]);
end;

begin
  Enter;
  Init;
  Solve;
  Print;
end.