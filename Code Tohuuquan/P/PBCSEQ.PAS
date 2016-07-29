Program PBCSEQ;
Const maxn = 100000;
Type Arr = array[1..2] of longint;
Var a : array[1..maxn] of Arr;
    n : longint;

Procedure Enter;
Var i : longint;
Begin
    readln(n);
    For i := 1 to n do readln(a[i, 1], a[i, 2]);
End;

Procedure Swap(Var x, y : Arr);
Var t : Arr;
Begin
    t := x;
    x := y;
    y := t;
End;

Operator < (x, y : Arr) c : boolean;
Begin
    c := (x[1] < y[1]) or ((x[1] = y[1]) and (x[2] > y[2]));
End;

Procedure QuickSort(l, r : longint);
Var i, j : longint;
    x : Arr;
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
Var last : array[1..maxn] of longint;
    res, x, y, t, i : longint;
Begin
    res := 1;
    last[res] := 1;
    For i := 2 to n do
        If a[i, 2] > a[last[1], 2] then
            last[1] := i
        Else If a[i, 2] <= a[last[res], 2] then
            Begin
                inc(res);
                last[res] := i
            End
        Else
            Begin
                x := 1;
                y := res;
                While x < y do
                Begin
                    t := (x + y) div 2;
                    If a[i, 2] <= a[last[t], 2] then x := t + 1
                    else y := t;
                End;
                last[x] := i;
            End;
    writeln(res);
End;

BEGIN
    Enter;
    QuickSort(1, n);
    Solve;
END.