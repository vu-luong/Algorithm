{$MODE OBJFPC}
program VNEMPIRE;
uses Math;
const maxN = 100000;
type TEmpire = record
      cord : array[1..3] of integer;
      id : integer;
     end;
     TEdge = record
      x, y, dist : integer;
     end;
var emp : array[1..maxN] of TEmpire;
    edge : array[1..maxN * 3] of TEdge;
    lab : array[1..maxN] of integer;
    n, m, res : integer;

procedure Enter;
var i, j : integer;
begin
    readln(n);
    for i := 1 to n do
        with emp[i] do
        begin
            for j := 1 to 3 do read(cord[j]);
            id := i;
        end;
end;

procedure Sort(const l, r, k : integer);
var i, j : integer;
    pivot : TEmpire;
begin
    if l >= r then exit;
    i := l + random(r - l + 1);
    pivot := emp[i]; emp[i] := emp[l];
    i := l; j := r;
    repeat
        while (emp[j].cord[k] > pivot.cord[k]) and (i < j) do dec(j);
        if i < j then
            begin emp[i] := emp[j]; inc(i); end
            else break;
        while (emp[i].cord[k] < pivot.cord[k]) and (i < j) do inc(i);
        if i < j then
            begin emp[j] := emp[i]; dec(j); end
            else break;
    until i = j;
    emp[i] := pivot;
    Sort(l, i - 1, k);
    Sort(i + 1, r, k);
end;

function CalDist(const x, y : TEmpire) : integer;
var i : integer;
begin
    result := maxlongint;
    for i := 1 to 3 do
        result := min(result, abs(x.cord[i] - y.cord[i]));
end;

procedure Init;
var i, j : integer;
begin
    for i := 1 to 3 do
    begin
        Sort(1, n, i);
        for j := 2 to n do
        begin
            inc(m);
            with edge[m] do
            begin
                x := emp[j - 1].id;
                y := emp[j].id;
                dist := CalDist(emp[j - 1], emp[j]);
            end;
        end;
    end;
    inc(m);
    edge[m].dist := maxlongint;
end;

procedure AdjHeap(root, last : integer);
var k : TEdge;
    c : integer;
begin
    k := edge[root];
    while root shl 1 <= last do
    begin
        c := root shl 1;
        if (c < last) and (edge[c].dist > edge[c + 1].dist) then inc(c);
        if edge[c].dist >= k.dist then break;
        edge[root] := edge[c];
        root := c;
    end;
    edge[root] := k;
end;

function FindRoot(const x : integer) : integer;
begin
    if lab[x] <= 0 then result := x else
    begin
        result := FindRoot(lab[x]);
        lab[x] := result;
    end;
end;

procedure Union(const r1, r2 : integer);
begin
    if lab[r1] < lab[r2] then lab[r2] := r1 else
    begin
        if lab[r1] = lab[r2] then dec(lab[r2]);
        lab[r1] := r2;
    end;
end;

procedure Solve;
var i, r1, r2, count : integer;
    t : TEdge;
begin
    count := 0;
    for i := m shr 1 downto 1 do AdjHeap(i, m);
    for i := m downto 2 do
    begin
        t := edge[1];
        edge[1] := edge[i];
        edge[i] := t;
        AdjHeap(1, i - 1);

        with edge[i] do
        begin
            r1 := FindRoot(x);
            r2 := FindRoot(y);
            if r1 <> r2 then
            begin
                inc(res, dist);
                Union(r1, r2);
                inc(count);
                if count = n - 1 then exit;
            end;
        end;
    end;
end;

procedure Print;
begin
    write(res);
end;

begin
    Enter;
    Init;
    Solve;
    Print;
end.