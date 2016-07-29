Program LNACS;
Const maxm = 1000;
      maxn = 1000;
Var a : array[1..maxm] of word;
    b : array[1..maxn] of word;
    f : array[-1..maxm, -1..maxn] of word;
    m, n : word;

Procedure Enter;
Var i : word;
Begin
    readln(m, n);
    For i := 1 to m do readln(a[i]);
    For i := 1 to n do readln(b[i]);
End;

Function Max(x, y : word) : word;
Begin
    If x > y then exit(x) else exit(y);
End;

Procedure Solve;
Var i, j : word;
Begin
    For i := 1 to m do
        For j := 1 to n do
            If a[i] = b[j] then
                f[i, j] := f[i - 2, j - 2] + 1
            else
                f[i, j] := Max(f[i - 1, j], f[i, j - 1]);
End;

Procedure PrintResult;
Begin
    writeln(f[m, n]);
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.
