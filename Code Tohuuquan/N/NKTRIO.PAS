Program NKTRIO;
Const maxn = 1000;
Var a : array[1..maxn, 1..maxn] of boolean;
    f : array[1..maxn] of word;
    n : word;

Procedure Enter;
Var i, j : word;
    x : byte;
Begin
    readln(n);
    For i := 1 to n do
        For j := 1 to n do
        Begin
            read(x);
            a[i, j] := (x = 1);
        End;
End;

Procedure Solve;
Var i, j, k : word;
Begin
    f[1] := 1;
    For i := 2 to n do
    Begin
        j := 1;
        While (j < i) and a[i, f[j]] do inc(j);
        For k := i - 1 downto j + 1 do
            If a[f[k], i] then f[k + 1] := f[k] else
            Begin
                write(f[k], ' ', f[j], ' ', i);
                halt;
            End;
        f[j + 1] := f[j];
        f[j] := i;
    End;
    write('-1 -1 -1');
End;

BEGIN
    Enter;
    Solve;
END.