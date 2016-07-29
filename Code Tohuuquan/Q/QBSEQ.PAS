Program QBSEQ;
Const maxn = 1000;
      maxk = 50;
Var a : array[1..maxn] of byte;
    f : array[0..maxn, 0..maxk] of byte;
    n, res : word;
    k : byte;

Procedure Enter;
Var i : word;
    x : longint;
Begin
    readln(n, k);
    For i := 1 to n do
    Begin
        read(x);
        a[i] := x mod k;
    End;
End;

Function Min(x, y : byte) : byte;
Begin
    If x < y then exit(x) else exit(y);
End;

Procedure Solve;
Var i, j, s : word;
Begin
    f[0, 0] := 0;
    For j := 1 to k - 1 do f[0, j] := k + 1;
    For i := 1 to n do
        For j := 0 to k - 1 do
            f[i, j] := Min(f[i - 1, j], f[i - 1, (j + k - a[i]) mod k] + 1);
    s := 0;
    For i := 1 to n do inc(s, a[i]);
    res := n - f[n, s mod k];
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