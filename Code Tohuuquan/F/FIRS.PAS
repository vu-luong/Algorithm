Program FIRS;
Const maxn = 100000;
Type Arr = array[1..2] of longint;
Var a : array[1..maxn] of Arr;
    free : array[0..maxn + 1] of boolean;
    n, count : longint;

Procedure Enter;
Var i : longint;
Begin
    readln(n);
    For i := 1 to n do
    Begin
        read(a[i, 1]);
        a[i, 2] := i;
    End;
End;

Procedure Swap(Var x, y : Arr);
Var t : Arr;
Begin
    t := x;
    x := y;
    y := t;
End;

Procedure QuickSort(l, r : longint);
Var i, j, x1, x2 : longint;
Begin
    If l >= r then exit;
    i := l;
    j := r;
    x1 := a[l + random(r - l + 1), 1];
    x2 := a[l + random(r - l + 1), 2];
    Repeat
        While (a[i, 1] < x1) or ((a[i, 1] = x1) and (a[i, 2] < x2)) do inc(i);
        While (a[j, 1] > x1) or ((a[j, 1] = x1) and (a[j, 2] > x2)) do dec(j);
        If i <= j then
        Begin
            If i < j then Swap(a[i], a[j]);
            inc(i);
            dec(j);
        End;
    Until i > j;
    QuickSort(l, j);
    QuickSort(i, r);
End;


Procedure Solve;
Var i : longint;
Begin
    fillchar(free, sizeof(free), true);
    For i := 1 to n do
        If free[a[i, 2]] then
        Begin
            inc(count);
            free[a[i, 2] - 1] := false;
            free[a[i, 2]] := false;
            free[a[i, 2] + 1] := false;
        End;
    writeln(count);
End;

BEGIN
    Enter;
    QuickSort(1, n);
    Solve;
END.