Program NOIXICH;
Const maxn = 20000;
Var a : array[1..maxn] of word;
    n : word;
    res : longint;

Procedure Enter;
Var i : word;
Begin
    readln(n);
    For i := 1 to n do read(a[i]);
End;

Procedure QuickSort(l, r : word);
Var i, j, x, t : word;
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

Procedure Solve;
Var i, j : word;
    t : longint;
Begin
    t := 0;
    For i := 1 to n do
    Begin
        For j := 1 to a[i] - 1 do
        Begin
            inc(t);
            If t = n - i then
            Begin
                res := t;
                exit;
            End;
        End;
        inc(t);
        If t >= n - i - 1 then
        Begin
            res := t;
            exit;
        End;
    End;
End;

Procedure PrintResult;
Begin
    writeln(res);
End;

BEGIN
    Enter;
    QuickSort(1, n);
    Solve;
    PrintResult;
END.
