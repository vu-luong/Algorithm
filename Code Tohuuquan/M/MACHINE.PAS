Program MACHINE;
Const maxn = 10000;
Type Arr = array[1..7] of integer;
Var f : array[1..maxn] of Arr;
    n, m : word;

Procedure Enter;
Var i : word;
    j : byte;
Begin
    readln(n);
    For j := 1 to 3 do
        For i := 1 to n do read(f[i, j]);
    For i := 1 to n do
    Begin
        f[i, 4] := i;
        f[i, 5] := f[i, 1] + f[i, 2];
        f[i, 6] := f[i, 2] + f[i, 3];
        f[i, 7] := f[i, 5] - f[i, 6];
    End;
End;

Procedure QuickSortInc(l, r : word; k : byte);
Var i, j : word;
    x : integer;
    t : Arr;
Begin
    If l >= r then exit;
    i := l;
    j := r;
    x := f[l + random(r - l + 1), k];
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
    x := f[l + random(r - l + 1), k];
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
    QuickSortInc(1, n, 7);
    For m := 1 to n do
        If f[m, 5] > f[m, 6] then break;
    QuickSortInc(1, m - 1, 5);
    QuickSortDec(m, n, 6);
End;

Procedure PrintResult;
Var i : word;
    tA, tB, tC : longint;
Begin
    tA := 0;
    tB := 0;
    tC := 0;
    For i := 1 to n do
    Begin
        inc(tA, f[i, 1]);
        If tA >= tB then tB := tA + f[i, 2]
        else inc(tB, f[i, 2]);
        If tB >= tC then tC := tB + f[i, 3]
        else inc(tC, f[i, 3]);
    End;

    writeln(tC);
    For i := 1 to n do write(f[i, 4], ' ');
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.