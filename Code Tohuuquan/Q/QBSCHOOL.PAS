{$MODE OBJFPC}
program QBSCHOOL;
const maxN = 5000;
      maxD = maxN * 32000 + 1;
type PNode = ^TNode;
     TNode = record
      v, w : integer;
      Link : PNode;
     end;
     THeap = record
      nItems : integer;
      item, pos : array[1..maxN] of integer;
     end;
var a : array[1..maxN] of PNode;
    d, order : array[1..maxN] of integer;
    nWays : array[1..maxN] of int64;
    heap : THeap;
    n : integer;

procedure Enter;
var i, m, u, v, k, l : integer;

 procedure Add(u, v, l : integer);
 var p : PNode;
 begin
     new(p);
     p^.v := v;
     p^.w := l;
     p^.Link := nil;
     if a[u] = nil then a[u] := p else
     begin
         p^.Link := a[u];
         a[u] := p;
     end;
 end;

begin
    readln(n, m);
    for i := 1 to n do a[i] := nil;
    for i := 1 to m do
    begin
        readln(k, u, v, l);
        Add(u, v, l);
        if k = 2 then Add(v, u, l);
    end;
end;

function Extract : integer;
var v, p, c : integer;
begin
    with heap do
    begin
        result := item[1];
        v := item[nItems];
        dec(nItems);
        p := 1;
        repeat
            c := p shl 1;
            if (c < nItems) and (d[item[c]] > d[item[c + 1]]) then inc(c);
            if (c > nItems) or (d[item[c]] >= d[v]) then break;
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
var u, count : integer;
    p : PNode;
begin
    for u := 1 to n do d[u] := maxD;
    d[1] := 0;
    with heap do
    begin
        fillchar(pos, sizeof(pos), 0);
        nItems := 1;
        item[1] := 1;
        pos[1] := 1;
    end;
    count := 0;
    repeat
        u := Extract;
        if (u = 0) or (u = n) then break;
        inc(count);
        order[count] := u;
        p := a[u];
        while p <> nil do
        begin
            if Relax(u, p^.v, p^.w) then
                Update(p^.v);
            p := p^.Link;
        end;
    until heap.nItems = 0;
end;

procedure Solve;
var i, u : integer;
    p : PNode;
begin
    nWays[1] := 1;
    for i := 1 to n do
    begin
        u := order[i];
        p := a[u];
        while p <> nil do
        begin
            if (d[p^.v] = d[u] + p^.w) then
                inc(nWays[p^.v], nWays[u]);
            p := p^.Link;
        end;
    end;
end;

procedure Print;
begin
    write(d[n], ' ', nWays[n]);
end;

begin
    Enter;
    Dijkstra;
    Solve;
    Print;
end.