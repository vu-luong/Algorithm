{$MODE OBJFPC}
{$INLINE ON}
program STABLE;
const maxN = 10000;
      maxM = 50000;
type TEdge = record
      u, v : integer;
     end;
var e : array[0..maxM] of TEdge;
    link : array[1..maxM] of integer;
    head, queue, order, d : array[1..maxN] of integer;
    nWay : array[1..maxN] of qword;
    free : array[1..maxN] of boolean;
    n, m, s, first, last, count : integer;

operator < (const a, b : TEdge) : boolean; inline;
begin
    result := (a.u < b.u) or (a.u = b.u) and (a.v < b.v);
end;

procedure Sort(l, r : integer);
var i, j : integer;
    pivot : TEdge;
begin
    if l >= r then exit;
    i := l + random(r - l + 1);
    pivot := e[i]; e[i] := e[l];
    i := l; j := r;
    repeat
        while (pivot < e[j]) and (i < j) do dec(j);
        if i < j then
            begin e[i] := e[j]; inc(i); end
            else break;
        while (e[i] < pivot) and (i < j) do inc(i);
        if i < j then
            begin e[j] := e[i]; dec(j); end
            else break;
    until i = j;
    e[i] := pivot;
    Sort(l, i - 1);
    Sort(i + 1, r);
end;

procedure Enter;
var i : integer;
begin
    readln(n, m, s);
    for i := 1 to m do
        with e[i] do readln(u, v);
    Sort(1, m);

    i := 0;
    repeat
        repeat
            inc(i);
        until (i > m) or (e[i].u <> e[i - 1].u) or (e[i].v <> e[i - 1].v);
        if i <= m then
            with e[i] do
            begin
                link[i] := head[u];
                head[u] := i;
            end
        else break;
    until false;
end;

procedure Init;
var u, v, p : integer;
begin
    fillchar(free, sizeof(free), true);
    first := 1; last := 1;
    queue[1] := s;
    free[s] := false;
    repeat
        u := queue[first];
        inc(first);
        inc(count);
        order[count] := u;

        p := head[u];
        while p <> 0 do
        begin
            v := e[p].v;
            p := link[p];
            if free[v] then
            begin
                inc(last);
                queue[last] := v;
                d[v] := d[u] + 1;
                free[v] := false;
            end;
        end;
    until first > last;
end;

procedure Solve;
var i, p, u, v : integer;
begin
    nWay[s] := 1;
    for i := 1 to count do
    begin
        u := order[i];
        p := head[u];
        while p <> 0 do
        begin
            v := e[p].v;
            p := link[p];
            if d[v] = d[u] + 1 then inc(nWay[v], nWay[u]);
        end;
    end;
    count := 0;
    for i := 1 to n do
        if nWay[i] > 1 then inc(count);
    writeln(count);
end;

begin
    Enter;
    Init;
    Solve;
end.