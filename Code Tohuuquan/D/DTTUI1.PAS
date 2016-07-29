{$MODE OBJFPC}
{$INLINE ON}
program DTTUI1;
uses Math;
const maxN = 40;
type Arr = array[1..2] of int64;
var w, v : array[1..maxN] of int64;
    f : array[0..1 shl 11] of Arr;
    bit : array[1..14] of integer;
    n, m, d, n1, n2 : integer;
    res, bonus : int64;

procedure Enter;
var i, j : integer;
    t : int64;
begin
    readln(n, m);
    for i := 1 to n do readln(w[i], v[i]);
    for i := 1 to n - 1 do
        for j := i + 1 to n do
            if v[i] * w[j] > v[j] * w[i] then
            begin
                t := v[i]; v[i] := v[j]; v[j] := t;
                t := w[i]; w[i] := w[j]; w[j] := t;
            end;

    while n > 22 do
    begin
        inc(bonus, v[n]);
        dec(m, w[n]);
        dec(n);
    end;
end;

operator < (const a, b : Arr) : boolean; inline;
begin
    result := (a[1] < b[1]) or ((a[1] = b[1]) and (a[2] < b[2]));
end;

procedure Sort(l, r : integer);
var i, j : integer;
    pivot : Arr;
begin
    if l >= r then exit;
    i := l + random(r - l + 1);
    pivot := f[i]; f[i] := f[l];
    i := l; j := r;
    repeat
        while (pivot < f[j]) and (i < j) do dec(j);
        if i < j then
            begin f[i] := f[j]; inc(i); end
            else break;
        while (f[i] < pivot) and (i < j) do inc(i);
        if i < j then
            begin f[j] := f[i]; dec(j); end
            else break;
    until l = r;
    f[i] := pivot;
    Sort(l, i - 1);
    Sort(i + 1, r);
end;

procedure Init;
var i, j : integer;
begin
    bit[1] := 1;
    for i := 2 to ((n + 1) shr 1) + 3 do bit[i] := bit[i - 1] shl 1;
    n1 := n shr 1;
    n2 := (n + 1) shr 1;
    d := 1;
    for i := 1 to bit[n1 + 1] - 1 do
    begin
        f[d, 1] := 0;
        f[d, 2] := 0;
        for j := 1 to n1 do
            if i and bit[j] > 0 then
            begin
                inc(f[d, 1], w[j]);
                inc(f[d, 2], v[j]);
            end;
        if f[d, 1] <= m then inc(d);
    end;
    dec(d);
    Sort(0, d);
end;

procedure Solve;
var i, j, low, high, mid : integer;
    sumw, sumv : int64;
begin
    for i := 0 to bit[n2 + 1] - 1 do
    begin
        sumw := m;
        sumv := 0;
        for j := 1 to n2 do
            if i and bit[j] > 0 then
            begin
                dec(sumw, w[n1 + j]);
                inc(sumv, v[n1 + j]);
            end;
        if sumw < 0 then continue;
        if sumw = 0 then
        begin
            res := max(res, sumv);
            continue;
        end;

        low := 1;
        high := d;
        repeat
            mid := (low + high) shr 1;
            if sumw < f[mid, 1] then high := mid - 1
            else low := mid + 1;
        until low > high;
        j := high;
        while (j < d) and (f[j + 1, 1] = sumw) do inc(j);
        res := max(res, sumv + f[j, 2]);
    end;
    write(res + bonus);
end;

begin
    Enter;
    Init;
    Solve;
end.