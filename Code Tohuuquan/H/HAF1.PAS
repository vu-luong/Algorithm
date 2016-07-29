Program HAF1;
Const maxm = 1000;
      maxn = 1000;
      max = maxlongint shr 1;
Var a, f : array[0..maxm + 1, 0..maxn + 1] of longint;
    n, m : word;

Procedure Enter;
Var i, j : word;
Begin
    readln(n, m);
    For i := 1 to m do
    Begin
        For j := 1 to n do read(a[i, j]);
        f[i, 0] := max;
        f[i, n + 1] := max;
    End;
End;

Function Min(x, y : longint) : longint;
Begin
    If x < y then exit(x) else exit(y);
End;

Procedure Solve;
Var i, j : word;
Begin
    For i := 1 to m do
    Begin
        For j := 1 to n do
            f[i, j] := Min(f[i - 1, j], f[i, j - 1]) + a[i, j];
        For j := n downto 1 do
            f[i, j] := Min(f[i, j], f[i, j + 1] + a[i, j]);
    End;
End;

Procedure PrintResult;
Var i : word;
    res : longint;
Begin
    res := max;
    For i := 1 to n do
        If f[m, i] < res then res := f[m, i];
    writeln(res);
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.