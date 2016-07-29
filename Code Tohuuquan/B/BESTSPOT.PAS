{$MODE OBJFPC}
program BESTSPOT;
const maxP = 500;
      maxF = maxP;
      maxD = maxP * 892 + 1;
type PNode = ^TNode;
     TNode = record
      v, w : integer;
      Link : PNode;
     end;
     THeap = record
      nItems : integer;
      item, pos : array[1..maxP] of integer;
     end;
var d : array[1..maxP] of integer;
    f : array[1..maxF] of integer;
    head : array[1..maxP] of PNode;
    heap : THeap;
    nP, nF, res : integer;

procedure Enter;
var i, u, v, l, nC : integer;

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

begin
    readln(nP, nF, nC);
    for i := 1 to nP do head[i] := nil;
    for i := 1 to nF do read(f[i]);
    for i := 1 to nC do
    begin
        readln(u, v, l);
        Add(u, v, l);
        Add(v, u, l);
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
            c := p
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

function Dijkstra(start : integer) : integer;
var u : integer;
    p : PNode;
begin
    for u := 1 to nP do d[u] := maxD;
    d[start] := 0;
    with heap do
    begin
        fillchar(pos[1], nP * sizeof(pos[1]), 0);
        nItems := 1;
        item[1] := start;
        pos[start] := 1;
    end;
    repeat
        u := Extract;
        p := head[u];
        while p <> nil do
        begin
            if Relax(u, p^.v, p^.w) then Update(p^.v);
            p := p^.Link;
        end;
    until heap.nItems = 0;
    result := 0;
    for u := 1 to nF do inc(result, d[f[u]]);
end;

procedure Solve;
var i, sum, sum_res : integer;
begin
    sum_res := maxlongint;
    for i := 1 to nP do
    begin
        sum := Dijkstra(i);
        if sum < sum_res then
        begin
            res := i;
            sum_res := sum;
        end;
    end;
    write(res);
end;

begin
    Enter;
    Solve;
end.