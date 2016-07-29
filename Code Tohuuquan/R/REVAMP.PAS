{$MODE OBJFPC}
program REVAMP;
const
  maxN = Round(1e4);
  maxM = Round(1e5);
  maxT = Round(1e6);
  maxD = maxM * maxT + 1;
  maxK = 20;

type
  TEdge = record
    x, y, w : Integer;
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
  e : array[-maxM..maxM] of TEdge;
  link : array[-maxM..maxM] of Integer;
  head : array[1..maxN] of Integer;
  d : array[1..maxN, 0..maxK] of Int64;
  heap : THeap;
  n, m, k : Integer;
  res : Int64;

procedure Enter;
var
  i, u, v, l : Integer;
begin
  ReadLn(n, m, k);
  for i := 1 to m do
    begin
      ReadLn(u, v, l);
      with e[i] do
        begin
          x := u; y := v; w := l;
          link[i] := head[x];
          head[x] := i;
        end;
      with e[-i] do
        begin
          x := v; y := u; w := l;
          link[-i] := head[x];
          head[x] := -i;
        end;
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
  i, u, v, count : Integer;
begin
  for u := 1 to n do
    for i := 0 to k do d[u, i] := maxD;
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

    i := head[u];
    while i <> 0 do
      begin
        v := e[i].y;
        if d[v, count] > d[u, count] + e[i].w then
          begin
            d[v, count] := d[u, count] + e[i].w;
            Update(v, count);
          end;
        if count < k then
          if d[v, count + 1] > d[u, count] then
            begin
              d[v, count + 1] := d[u, count];
              Update(v, count + 1);
            end;
        i := link[i];
      end;
  until heap.nItems = 0;
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