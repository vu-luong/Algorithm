Program VECTOR;
Const maxn = 30;
      bit : array[1..(maxn shr 1) + 1] of word =
       (1, 2, 4, 8, 16, 32, 64, 128, 256, 512,
        1024, 2048, 4096, 8192, 16384, 32768);
Type Vt1 = array[1..2] of shortint;
     Vt2 = array[1..2] of longint;
Var vt : array[1..maxn] of Vt1;
    a : array[0..1 shl 16 - 1] of Vt2;
    n : byte;
    m1, m2 : word;
    u, v, res : longint;

Procedure Enter;
Var i : byte;
Begin
    readln(n);
    For i := 1 to n do readln(vt[i, 1], vt[i, 2]);
    readln(u, v);
End;

Procedure Init;
Var i : word;
    j : byte;
Begin
    m1 := n shr 1;
    For i := 0 to bit[m1 + 1] - 1 do
        For j := 1 to m1 do
            If i and bit[j] <> 0 then
            Begin
                inc(a[i, 1], vt[j, 1]);
                inc(a[i, 2], vt[j, 2]);
            End;
End;

Procedure Swap(Var x, y : Vt2);
Var t : Vt2;
Begin
    t := x;
    x := y;
    y := t;
End;

Operator < (x, y : Vt2) z : boolean;
Begin
    If x[1] <> y[1] then z := x[1] < y[1]
    else z := x[2] < y[2];
End;

Operator = (x, y : Vt2) z : boolean;
Begin
    z := (x[1] = y[1]) and (x[2] = y[2]);
End;

Procedure QuickSort(l, r : word);
Var i, j : word;
    x : Vt2;
Begin
    If l >= r then exit;
    i := l;
    j := r;
    x := a[l + random(r - l + 1)];
    Repeat
        While a[i] < x do inc(i);
        While x < a[j] do dec(j);
        If i <= j then
        Begin
            Swap(a[i], a[j]);
            inc(i);
            dec(j);
        End;
    Until i > j;
    QuickSort(l, j);
    QuickSort(i, r);
End;

Procedure Solve;
Var i, k : word;
    low, high, mid : longint;
    j : byte;
    key : Vt2;
Begin
    m2 := (n + 1) shr 1;
    For i := 0 to bit[m2 + 1] - 1 do
    Begin
        key[1] := 0;
        key[2] := 0;
        For j := 1 to m2 do
            If i and bit[j] <> 0 then
            Begin
                inc(key[1], vt[j + m1, 1]);
                inc(key[2], vt[j + m1, 2]);
            End;

        key[1] := u - key[1];
        key[2] := v - key[2];
        low := 0;
        high := bit[m1 + 1] - 1;
        While low <= high do
        Begin
            mid := (low + high) shr 1;
            If key = a[mid] then break;
            If key < a[mid] then high := mid - 1
            else low := mid + 1;
        End;
        If key = a[mid] then
        Begin
            For k := mid downto 0 do
                If key = a[k] then inc(res) else break;
            For k := mid + 1 to bit[m1 + 1] - 1 do
                If key = a[k] then inc(res) else break;
        End;
    End;
End;

Procedure PrintResult;
Begin
    write(res);
End;

BEGIN
    Enter;
    Init;
    QuickSort(0, bit[m1 + 1] - 1);
    Solve;
    PrintResult;
END.