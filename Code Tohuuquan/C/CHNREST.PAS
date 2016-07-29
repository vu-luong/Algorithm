program CHNREST;
uses Math;
const maxN = 10;
      maxM = 30;
      max = 1 shl (maxM shr 1);
type TInfo = record
      value : int64;
      code : word;
     end;
var p : array[1..maxM] of int64;
    a : array[1..maxN, 1..maxM] of boolean;
    bit : array[1..maxM shr 1] of word;
    f : array[1..max + 1] of TInfo;
    m, n, m1, m2 : byte;
    res : int64;
    top : word;

procedure Enter;
var i, j : byte;
begin
    readln(m, n);
    for i := 1 to m - 1 do read(p[i]);
    readln(p[m]);
    for i := 1 to n do
    begin
        while not seekeoln do
        begin
            read(j);
            a[i, j] := true;
        end;
        readln;
    end;

    bit[1] := 1;
    for i := 2 to (m + 1) shr 1 do
        bit[i] := bit[i - 1] shl 1;
end;

operator < (const x, y : TInfo) z : boolean;
begin
    z := (x.code < y.code) or ((x.code = y.code) and (x.value < y.value));
end;

procedure Sort(l, r : word);
var i, j : word;
    pivot : TInfo;
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
    until i = j;
    f[i] := pivot;
    Sort(l, i - 1);
    Sort(i + 1, r);
end;

procedure Solve;
var num : array[1..maxn] of byte;
    i, j, k, SCode, left, right, mid, key : word;
    sum : int64;

 procedure Init;
 begin
     sum := 0;
     fillchar(num[1], n * sizeof(num[1]), 0);
 end;

 function Cal : word;
 var i : byte;
     res, temp : word;
 begin
     res := 0;
     temp := 1;
     for i := 1 to n do
     begin
         inc(res, temp * num[i]);
         temp := temp * 3;
     end;
     exit(res);
 end;

 function Check : boolean;
 var k : byte;
 begin
     for k := 1 to n do
         if num[k] > 2 then exit(false);
     exit(true);
 end;

begin
    for j := 1 to n do num[j] := 2;
    SCode := Cal;

    m1 := (m + 1) shr 1;
    for i := 0 to (1 shl m1 - 1) do
    begin
        Init;
        for j := 1 to m1 do
            if i and bit[j] > 0 then
            begin
                inc(sum, p[j]);
                for k := 1 to n do
                    if a[k, j] then inc(num[k]);
            end;
        if Check then
        begin
            inc(top);
            f[top].value := sum;
            f[top].code := Cal;
        end;
    end;

    Sort(1, top);

    res := high(int64);
    m2 := m shr 1;
    for i := 0 to (1 shl m2 - 1) do
    begin
        Init;
        for j := 1 to m2 do
            if i and bit[j] > 0 then
            begin
                inc(sum, p[m1 + j]);
                for k := 1 to n do
                    if a[k, m1 + j] then inc(num[k]);
            end;
        if Check then
        begin
            key := SCode - Cal;
            left := 1;
            right := top;
            repeat
                mid := (left + right) shr 1;
                if key = f[mid].code then break;
                if key < f[mid].code then right := mid - 1
                else left := mid + 1;
            until left > right;
            if key = f[mid].code then
            begin
                k := mid;
                while (k > 1) and (f[k - 1].code = key) do dec(k);
                res := min(res, f[k].value + sum);
            end;
        end;
    end;
end;

procedure Print;
begin
    if res = high(int64) then write(-1)
    else write(res);
end;

begin
    Enter;
    Solve;
    Print;
end.
