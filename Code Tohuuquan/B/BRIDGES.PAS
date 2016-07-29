{$MODE OBJFPC}
program BRIDGES;
const maxN = 10000 + 1;
type TEdge = record
      u, v, l : integer;
     end;
var e : array[1..maxN] of TEdge;
    parent, h, d, id : array[1..maxN] of integer;
    time : array[1..maxN] of real;
    free : array[1..maxN] of boolean;
    a, c : array[1..maxN shl 1] of integer;
    n, k, vp, vc : integer;

procedure Enter;
var i : integer;
begin
    readln(n, k, vp, vc);
    for i := 1 to n - 1 do
        with e[i] do
        begin
            readln(u, v, l);
            inc(h[u]);
            inc(h[v]);
        end;
    for i := 2 to n do inc(h[i], h[i - 1]);
    h[n + 1] := h[n];
    for i := 1 to n - 1 do
        with e[i] do
        begin
            a[h[u]] := v; c[h[u]] := l; dec(h[u]);
            a[h[v]] := u; c[h[v]] := l; dec(h[v]);
        end;
end;

procedure DFS(u : integer);
var i : integer;
begin
    free[u] := false;
    d[u] := 1;
    for i := h[u] + 1 to h[u + 1] do
        if free[a[i]] then
        begin
            parent[a[i]] := u;
            DFS(a[i]);
            d[u] := d[u] + d[a[i]];
        end;
end;

procedure Sort(l, r : integer);
var i, j, p, t : integer;
begin
    if l >= r then exit;
    i := l; j := r;
    p := id[l + random(r - l + 1)];
    repeat
        while time[id[i]] > time[p] do inc(i);
        while time[id[j]] < time[p] do dec(j);
        if i <= j then
        begin
            t := id[i]; id[i] := id[j]; id[j] := t;
            inc(i); dec(j);
        end;
    until i > j;
    Sort(l, j);
    Sort(i, r);
end;

procedure Solve;
var i, x : integer;
begin
    fillchar(free, sizeof(free), true);
    DFS(1);
    for i := 1 to n - 1 do
    begin
        id[i] := i;
        with e[i] do
        begin
            if parent[u] = v then x := u else x := v;
            time[i] := (int64(l) * (n - d[x]) * d[x]) / vp -
                       (int64(l) * (n - d[x]) * d[x]) / vc;
        end;
    end;
    Sort(1, n - 1);
end;

procedure Print;
var i : integer;
begin
    for i := 1 to k do write(id[i], ' ');
end;

begin
    Enter;
    Solve;
    Print;
end.