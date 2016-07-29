Program NKJUMP;
Const maxn = 1000;
Var a : array[1..maxn] of longint;
    f : array[1..maxn] of word;
    n, res : word;

Procedure Enter;
Var i : word;
Begin
    readln(n);
    For i := 1 to n do read(a[i]);
End;

Procedure QuickSort(l, r : word);
Var i, j : word;
    x, t : longint;
Begin
    If l >= r then exit;
    i := l;
    j := r;
    x := a[l + random(r - l + 1)];
    While i <= j do
    Begin
        While a[i] < x do inc(i);
        While a[j] > x do dec(j);
        If i <= j then
        Begin
            t := a[i];
            a[i] := a[j];
            a[j] := t;
            inc(i);
            dec(j);
        End;
    End;
    QuickSort(l, j);
    QuickSort(i, r);
End;

Function Find(x : longint; i : word) : word;
Var first, last, mid : word;
Begin
    first := 1;
    last := i;
    While first <= last do
    Begin
        mid := (first + last) div 2;
        If a[mid] = x then exit(mid) else
            If x > a[mid] then first := mid + 1 else last := mid - 1;
    End;
    exit(0);
End;

Function Max(x, y, z : word) : word;
Var t : word;
Begin
    t := x;
    If t < y then t := y;
    If t < z then t := z;
    exit(t);
End;

Procedure Solve;
Var i, j, p : word;
Begin
    fillchar(f[1], n * sizeof(f[1]), 0);
    res := 0;
    For i := 1 to n do
    Begin
        For j := i - 1 downto 1 do
            If a[j] < a[i] div 2 then break else
            Begin
                p := Find(a[i] - a[j], j - 1);
                If p > 0 then f[i] := Max(f[i], f[j] + 1, f[p] + 1);
            End;
        If f[i] > res then res := f[i];
    End;
End;

Procedure PrintResult;
Begin
    writeln(res + 1);
End;

BEGIN
    Enter;
    QuickSort(1, n);
    Solve;
    PrintResult;
END.