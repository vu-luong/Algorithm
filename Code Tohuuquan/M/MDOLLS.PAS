Program MDOLLS;
Const maxm = 20000;
Type Arr = array[1..2] of word;
Var a : array[1..maxm] of Arr;
    size : array[0..maxm - 1] of word;
    m : word;
    t : byte;

Procedure Enter;
Var i : word;
Begin
    readln(m);
    For i := 1 to m do read(a[i, 1], a[i, 2]);
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
    c := (a[1] < b[1]) or ((a[1] = b[1]) and (a[2] > b[2]));
End;

Operator > (a, b : Arr) c : boolean;
Begin
    c := (a[1] > b[1]) or ((a[1] = b[1]) and (a[2] < b[2]));
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
        While a[i] < x do inc(i);
        While a[j] > x do dec(j);
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
Var res, x, y, t, i : word;
Begin
    res := 0;
    For i := 1 to m do
    Begin
        x := 0;
        y := res;
        While x < y do
        Begin
            t := (x + y) shr 1;
            If size[t] >= a[i, 2] then x := t + 1
            else y := t;
        End;
        size[x] := a[i, 2];
        If x = res then inc(res);
    End;
    writeln(res);
End;

BEGIN
    readln(t);
    While t > 0 do
    Begin
        Enter;
        QuickSort(1, m);
        Solve;
        dec(t);
    End;
END.
