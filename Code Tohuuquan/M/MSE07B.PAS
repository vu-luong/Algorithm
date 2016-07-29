{$MODE OBJFPC}
program MSE07B;
const maxN = round(1e6);
type THeap = record
      nItems : integer;
      item, pos : array[1..maxN] of integer;
     end;
var pri : array[1..maxN] of integer;
    heapMin, heapMax : THeap;
    k : integer;

procedure InsertMax(v : integer);
var c, p : integer;
begin
    with heapMax do
    begin
        inc(nItems);
        c := nItems;
        repeat
            p := c shr 1;
            if (p = 0) or (pri[item[p]] >= pri[v]) then break;
            item[c] := item[p];
            pos[item[c]] := c;
            c := p;
        until false;
        item[c] := v;
        pos[v] := c;
    end;
end;

procedure InsertMin(v : integer);
var c, p : integer;
begin
    with heapMin do
    begin
        inc(nItems);
        c := nItems;
        repeat
            p := c shr 1;
            if (p = 0) or (pri[item[p]] <= pri[v]) then break;
            item[c] := item[p];
            pos[item[c]] := c;
            c := p;
        until false;
        item[c] := v;
        pos[v] := c;
    end;
end;

function GetMax : integer;
begin
    with heapMax do
        if nItems = 0 then exit(0)
        else exit(item[1]);
end;

function GetMin : integer;
begin
    with heapMin do
        if nItems = 0 then exit(0)
        else exit(item[1]);
end;

procedure ExtractMax(v : integer);
var p, c : integer;
begin
    if v = 0 then exit;
    with heapMax do
    begin
        c := pos[v]; pos[v] := 0;
        v := item[nItems];
        dec(nItems);

        // Up Heap
        repeat
            p := c shr 1;
            if (p = 0) or (pri[item[p]] >= pri[v]) then break;
            item[c] := item[p];
            pos[item[c]] := c;
            c := p;
        until false;
        item[c] := v;
        pos[v] := c;

        // Down Heap
        p := c;
        repeat
            c := p shl 1;
            if (c < nItems) and (pri[item[c + 1]] >= pri[item[c]]) then inc(c);
            if (c > nItems) or (pri[v] >= pri[item[c]]) then break;
            item[p] := item[c];
            pos[item[p]] := p;
            p := c;
        until false;
        item[p] := v;
        pos[v] := p;
    end;
end;

procedure ExtractMin(v : integer);
var p, c : integer;
begin
    if v = 0 then exit;
    with heapMin do
    begin
        c := pos[v]; pos[v] := 0;
        v := item[nItems];
        dec(nItems);

        // Up Heap
        repeat
            p := c shr 1;
            if (p = 0) or (pri[item[p]] <= pri[v]) then break;
            item[c] := item[p];
            pos[item[c]] := c;
            c := p;
        until false;
        item[c] := v;
        pos[v] := c;

        // Down Heap
        p := c;
        repeat
            c := p shl 1;
            if (c < nItems) and (pri[item[c + 1]] <= pri[item[c]]) then inc(c);
            if (c > nItems) or (pri[v] <= pri[item[c]]) then break;
            item[p] := item[c];
            pos[item[p]] := p;
            p := c;
        until false;
        item[p] := v;
        pos[v] := p;
    end;
end;

procedure Solve_1;
begin
    readln(k, pri[k]);
    InsertMax(k);
    InsertMin(k);
end;

procedure Solve_2;
var v : integer;
begin
    v := GetMax;
    ExtractMax(v);
    ExtractMin(v);
    writeln(v);
end;

procedure Solve_3;
var v : integer;
begin
    v := GetMin;
    ExtractMax(v);
    ExtractMin(v);
    writeln(v);
end;

begin
    while not eof do
    begin
        read(k);
        case k of
            1 : Solve_1;
            2 : Solve_2;
            3 : Solve_3;
        end;
    end;
end.