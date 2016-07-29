Program INSUL;
Const maxn = 100000;
Var a : array[1..maxn] of word;
    n, res : longint;

Procedure Enter;
Var i : longint;
Begin
    readln(n);
    For i := 1 to n do
    Begin
        readln(a[i]);
        inc(res, a[i]);
    End;
End;

Procedure QuickSort(l, r : longint);
Var i, j : longint;
    x, t : word;
Begin
    i := l;
    j := r;
    x := a[l + random(r - l + 1)];
    Repeat
        While a[i] < x do inc(i);
        While a[j] > x do dec(j);
        If i <= j then
        Begin
            If i < j then
            Begin
                t := a[i];
                a[i] := a[j];
                a[j] := t;
            End;
            inc(i);
            dec(j);
        End;
    Until i > j;
    If l < j then QuickSort(l, j);
    If i < r then QuickSort(i, r);
End;

Procedure Solve;
Var i : longint;
Begin
    For i := 1 to n shr 1 do
        inc(res, a[n - i + 1] - a[i]);
    writeln(res);
End;

BEGIN
    Enter;
    QuickSort(1, n);
    Solve;
END.