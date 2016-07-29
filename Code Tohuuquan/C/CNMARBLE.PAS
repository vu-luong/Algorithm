{$MODE OBJFPC}
program CNMARBLE;
const maxN = round(1e5);
var a : array[1..maxN, 1..2] of integer;
    n, m, s, box : integer;

procedure Enter;
var i : integer;
begin
    readln(n, m);
    for i := 1 to n do
    begin
        read(a[i, 1]);
        a[i, 2] := i;
        inc(s, a[i, 1]);
    end;
    box := s div m;
end;

procedure Sort(l, r : integer);
var i, j : integer;
    pivot : array[1..2] of integer;
begin
    if l >= r then exit;
    i := l + random(r - l + 1);
    pivot := a[i]; a[i] := a[l];
    i := l; j := r;
    repeat
        while (pivot[1] < a[j, 1]) and (i < j) do dec(j);
        if i < j then
            begin a[i] := a[j]; inc(i); end
            else break;
        while (a[i, 1] < pivot[1]) and (i < j) do inc(i);
        if i < j then
            begin a[j] := a[i]; dec(j); end
            else break;
    until i = j;
    a[i] := pivot;
    Sort(l, i - 1);
    Sort(i + 1, r);
end;

procedure Solve;
var count, i, j : integer;
begin
    for count := 1 to box do
    begin
        Sort(1, n);
        i := n;
        while a[i, 1] = 0 do inc(i);
        for j := 1 to m do
        begin
            write(a[i, 2], ' ');
            dec(a[i, 1]);
            dec(i);
        end;
        writeln;
    end;
end;

begin
    Enter;
    Solve;
end.
