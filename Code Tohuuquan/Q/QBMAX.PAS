Program QBMAX;
Const maxm = 100;
      maxn = 100;
Var a : array[1..maxm, 1..maxn] of shortint;
    f : array[1..maxm, 1..maxn] of integer;
    m, n : byte;
    res : integer;

Procedure Enter;
Var i, j : byte;
Begin
    readln(m, n);
    For i := 1 to m do
        For j := 1 to n do read(a[i, j]);
End;

Procedure Solve;
Var i, j : byte;

 Function Max(x, y : integer) : integer;
 Begin
     If x > y then exit(x) else exit(y);
 End;

Begin
    For i := 1 to m do f[i, 1] := a[i, 1];
    For j := 2 to n do
        For i := 1 to m do
        Begin
            res := f[i, j - 1];
            If i <> 1 then res := Max(res, f[i - 1, j - 1]);
            If i <> m then res := Max(res, f[i + 1, j - 1]);
            f[i, j] := a[i, j] + res;
        End;
    res := f[1, n];
    For i := 2 to m do
        If f[i, n] > res then res := f[i, n];
End;

Procedure PrintResult;
Begin
    writeln(res);
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.
