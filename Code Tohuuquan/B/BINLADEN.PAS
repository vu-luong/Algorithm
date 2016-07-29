{$MODE OBJFPC}
{$INLINE ON}
program BINLADEN;
const maxN = 10 * 2222 + 1;
      maxD = maxlongint shr 1;
type PNode = ^TNode;
     TNode = record
      v, w : integer;
      Link : PNode;
     end;
     THeap = record
      nItems : integer;
      item, pos : array[1..maxN] of integer;
     end;
var head : array[1..maxN] of PNode;
    d : array[1..maxN] of integer;
    heap : THeap;
    n, m, start : integer;

procedure Enter;
var i, j, x : integer;

 procedure Add(u, v, l : integer);
 var p : PNode;
 begin
     new(p);
     p^.v := v;
     p^.w := l;
     p^.Link := nil;
     if head[u] = nil then head[u] := p else
     begin
         p^.Link := head[u];
         head[u] := p;
     end;
 end;

 function F(x, y : integer) : integer; inline;
 begin
     result := (x - 1) * n + y;
 end;

begin
    readln(m, n);
    for i := 1 to m * n + 1 do head[i] := nil;
    start := m * n + 1;
    for i := 1 to n do
    begin
        read(x);
        Add(start, i, x);
        Add(i, start, x);
    end;
    for i := 1 to n - 1 do
    begin
        read(x);
        Add(i, i + 1, x);
        Add(i + 1, i, x);
    end;
    for i := 2 to m do
    begin
        for j := 1 to n do
        begin
            read(x);
            Add(F(i, j), F(i - 1, j), x);
            Add(F(i - 1, j), F(i, j), x);
        end;
        for j := 1 to n - 1 do
        begin
            read(x);
            Add(F(i, j), F(i, j + 1), x);
            Add(F(i, j + 1), F(i, j), x);
        end;
    end;
end;

function Extract : integer;
var p, c, v : integer;
begin
    with heap do
    begin
        result := item[1];
        v := item[nItems];
        dec(nItems);
        p := 1;
        repeat
            c := p shl 1;
            if (c < nItems) and (d[item[c + 1]] <= d[item[c]]) then inc(c);
            if (c > nItems) or (d[v] <= d[item[c]]) then break;
            item[p] := item[c];
            pos[item[p]] := p;
            p := c;
        until false;
        item[p] := v;
        pos[v] := p;
    end;
end;

procedure Update(v : integer);
var p, c : integer;
begin
    with heap do
    begin
        c := pos[v];
        if c = 0 then
        begin
            inc(nItems);
            c := nItems;
        end;
        repeat
            p := c shr 1;
            if (p = 0) or (d[item[p]] <= d[v]) then break;
            item[c] := item[p];
            pos[item[c]] := c;
            c := p;
        until false;
        item[c] := v;
        pos[v] := c;
    end;
end;

function Relax(u, v, w : integer) : boolean;
begin
    result := d[v] > d[u] + w;
    if result then d[v] := d[u] + w;
end;

procedure Dijkstra;
var u : integer;
    p : PNode;
begin
    n := n * m;
    for u := 1 to n do d[u] := maxD;
    with heap do
    begin
        nItems := 1;
        item[1] := start;
        pos[start] := 1;
    end;
    repeat
        u := Extract;
        if (u = 0) or (u = n) then break;

        p := head[u];
        while p <> nil do
        begin
            if Relax(u, p^.v, p^.w) then Update(p^.v);
            p := p^.Link;
        end;
    until heap.nItems = 0;
    write(d[n]);
end;

begin
    Enter;
    Dijkstra;
end.