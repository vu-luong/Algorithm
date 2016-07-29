Program CAR;
Const maxn = 10000;
Type Arr = array[1..3] of integer;
Var a : array[1..maxn] of Arr;
    n : word;
    total : double;

Procedure Enter;
Var i : word;
Begin
    readln(n);
    For i := 1 to n do read(a[i, 1]);
    For i := 1 to n do read(a[i, 2]);
End;

Procedure Swap(i, j : word);
Var t : Arr;
Begin
    t := a[i]; a[i] := a[j]; a[j] := t;
End;

Function Value(i : word) : real;
Begin
    exit(a[i, 1] / a[i, 2]);
End;

Procedure QuickSort(l, r : word);
Var i, j : word;
    x : real;
Begin
    If l >= r then exit;
    x := Value(l + random(r - l + 1));
    i := l;
    j := r;
    While i < j do
    Begin
        While Value(i) > x do inc(i);
        While Value(j) < x do dec(j);
        If i <= j then
        Begin
            If i < j then Swap(i, j);
            inc(i);
            dec(j);
        End;
    End;
    QuickSort(l, j);
    QuickSort(i, r);
End;

Procedure Init;
Var i : word;
Begin
    For i := 1 to n do a[i, 3] := i;
    QuickSort(1, n);
End;

Procedure Solve;
Var i : word;
    s : double;
Begin
    s := 0;
    For i := 1 to n do s := s + a[i, 1];
    For i := 1 to n do
    Begin
        total := total + s * a[i, 2];
        s := s - a[i, 1];
    End;
End;

Procedure PrintResult;
Var i : word;
Begin
    writeln(total : 0 : 0);
    For i := 1 to n do write(a[i, 3], ' ');
End;

BEGIN
    Enter;
    Init;
    Solve;
    PrintResult;
END.