Program MSTICK;
Const maxn = 5000;
Type Arr = array[1..2] of word;
Var a : array[1..maxn] of Arr;
    n, res : word;
    t : byte;

Procedure Enter;
Var i : word;
Begin
    readln(n);
    For i := 1 to n do read(a[i, 1], a[i, 2]);
End;

Procedure Swap(Var x, y : Arr);
Var t : Arr;
Begin
    t := x;
    x := y;
    y := t;
End;

Operator < (a, b : Arr) c : boolean;
Begin
    c := (a[1] < b[1]) or ((a[1] = b[1]) and (a[2] < b[2]));
End;

Operator > (a, b : Arr) c : boolean;
Begin
    c := (a[1] > b[1]) or ((a[1] = b[1]) and (a[2] > b[2]));
End;

Procedure QuickSort(l, r : word);
Var i, j : word;
    x : Arr;
Begin
    If l >= r then exit;
    i := l;
    j := r;
    x := a[l + random(r - l + 1)];
    While i <= j do
    Begin
        While a[i] > x do inc(i);
        While a[j] < x do dec(j);
        If i <= j then
        Begin
            Swap(a[i], a[j]);
            inc(i);
            dec(j);
        End;
    End;
    QuickSort(l, j);
    QuickSort(i, r);
End;

Procedure Solve;
Var last : array[1..maxn] of word;
    i, x, y, t : word;
Begin
    res := 1;
    last[res] := 1;
    For i := 2 to n do
        If a[i, 2] < a[last[1], 2] then
            last[1] := i
        Else If a[i, 2] > a[last[res], 2] then
            Begin
                inc(res);
                last[res] := i;
            End
        Else
            Begin
                x := 1;
                y := res;
                While x < y do
                Begin
                    t := (x + y) shr 1;
                    If a[i, 2] > a[last[t], 2] then x := t + 1 else y := t;
                End;
                last[x] := i;
            End;
    writeln(res);
End;

BEGIN
    readln(t);
    While t > 0 do
    Begin
        Enter;
        QuickSort(1, n);
        Solve;
        dec(t);
    End;
END.
