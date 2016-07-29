{$MODE OBJFPC}
program NETACCEL;
const
  maxN = Round(1e3);
  maxM = Round(1e5);
  maxK = 10;
  maxD = maxM * Round(1e6) * 1024;

type
  PNode = ^TNode;
  TNode = record
    v, w : Integer;
    link : PNode;
  end;
  TInfo = record
    u, count : Integer;
  end;
  THeap = record
    nItems : Integer;
    pos : array[1..maxN, 0..maxK] of Integer;
    item : array[1..maxN * maxK] of TInfo;
  end;

var
  head : array[1..maxN] of PNode;
  d : array[1..maxN, 0..maxK] of Int64;
  heap : THeap;
  n, m, k : Integer;
  res : Int64;

procedure Enter;
var
  i, u, v, w : Integer;

  procedure Add(u, v, w : Integer);
  var
    p : PNode;
  begin
    New(p);
    p^.v := v; p^.w := w shl 10;
    p^.link := head[u]; head[u] := p;
  end;

begin
  ReadLn(n, m, k);
  for i := 1 to m do
    begin
      ReadLn(u, v, w);
      Add(u, v, w);
      Add(v, u, w);
    end;
end;

operator < (const a, b : TInfo) : Boolean;
begin
  result := d[a.u, a.count] < d[b.u, b.count];
end;

procedure Extract(var xu, xcount : Integer);
var
  p, c : Integer;
  v : TInfo;
begin
  with heap do
    begin
      xu := item[1].u;
      xcount := item[1].count;

      v := item[nItems];
      Dec(nItems);

      p := 1;
      repeat
        c := p shl 1;
        if (c < nItems) and (item[c + 1] < item[c]) then Inc(c);
        if (c > nItems) or (v < item[c]) then Break;
        item[p] := item[c];
        pos[item[p].u, item[p].count] := p;
        p := c;
      until false;
      item[p] := v;
      pos[v.u, v.count] := p;
    end;
end;

procedure Update(xu, xcount : Integer);
var
  p, c : Integer;
  v : TInfo;
begin
  with heap do
    begin
      c := pos[xu, xcount];
      if c = 0 then
        begin
          Inc(nItems);
          c := nItems;
        end;
      v.u := xu;
      v.count := xcount;
      repeat
        p := c shr 1;
        if (p = 0) or (item[p] < v) then Break;
        item[c] := item[p];
        pos[item[c].u, item[c].count] := c;
        c := p;
      until false;
      item[c] := v;
      pos[v.u, v.count] := c;
    end;
end;

procedure Solve;
var
  u, v, w, i, count : Integer;
  p : PNode;
begin
  for u := 1 to n do
    for v := 0 to k do d[u, v] := maxD;
  d[1, 0] := 0;
  with heap do
    begin
      nItems := 1;
      item[1].u := 1;
      item[1].count := 0;
      pos[1, 0] := 1;
    end;

  repeat
    Extract(u, count);
    if u = n then
      begin
        res := d[u, count];
        Exit;
      end;

    p := head[u];
    while p <> nil do
      begin
        v := p^.v; w := p^.w; p := p^.link;
        for i := count to k do
          begin
            if d[v, i] > d[u, count] + w then
              begin
                d[v, i] := d[u, count] + w;
                Update(v, i);
              end;
            w := w shr 1;
          end;
      end;
  until heap.nItems = 0;
end;

procedure Print;
begin
  WriteLn((res / 1024) : 0 : 2);
end;

begin
  Enter;
  Solve;
  Print;
end.