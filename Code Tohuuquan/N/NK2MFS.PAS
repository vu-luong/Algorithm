Program NK2MFS;
Const maxn = 10000;
Type Arr = array[1..4] of integer;
Var f : array[1..maxn] of Arr;
    n, m : word;

Procedure Enter;
Var i : word;
    j : byte;
Begin
    readln(n);
    For j := 1 to 2 do
        For i := 1 to n do read(f[i, j]);
    For i := 1 to n do
    Begin
        f[i, 3] := i;
        f[i, 4] := f[i, 1] - f[i, 2];
    End;
End;

Procedure QuickSortInc(l, r : word; k : byte);
Var i, j : word;
    x : integer;
    t : Arr;
Begin
    i := l;
    j := r;
    x := f[(l + r) div 2, k];
    Repeat
        While f[i, k] < x do inc(i);
        While f[j, k] > x do dec(j);
        If i <= j then
        Begin
            t := f[i]; f[i] := f[j]; f[j] := t;
            inc(i);
            dec(j);
        End;
    Until i > j;
    If l < j then QuickSortInc(l, j, k);
    If i < r then QuickSortInc(i, r, k);
End;

Procedure QuickSortDec(l, r : word; k : byte);
Var i, j : word;
    x : integer;
    t : Arr;
Begin
    If l >= r then exit;
    i := l;
    j := r;
    x := f[(l + r) div 2, k];
    Repeat
        While f[i, k] > x do inc(i);
        While f[j, k] < x do dec(j);
        If i <= j then
        Begin
            t := f[i]; f[i] := f[j]; f[j] := t;
            inc(i);
            dec(j);
        End;
    Until i > j;
    If l < j then QuickSortDec(l, j, k);
    If i < r then QuickSortDec(i, r, k);
End;


Procedure Solve;
Begin
    QuickSortInc(1, n, 4);
    For m := 1 to n do
        If f[m, 1] > f[m, 2] then break;
    QuickSortInc(1, m - 1, 1);
    QuickSortDec(m, n, 2);
End;

Procedure PrintResult;
Var i : word;
    tA, tB : longint;
Begin
    tA := f[1, 1];
    tB := f[1, 1] + f[1, 2];
    For i := 2 to n do
    Begin
        inc(tA, f[i, 1]);
        If tA >= tB then tB := tA + f[i, 2]
        else inc(tB, f[i, 2]);
    End;

    writeln(tB);
    For i := 1 to n do write(f[i, 3], ' ');
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.
