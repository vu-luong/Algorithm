Program CTNBULLS;
Const maxn = 100000;
      BASE = 2111992;
Var f : array[0..maxn] of longint;
    n, k : longint;

Procedure Enter;
Begin
    readln(n, k);
End;

Procedure Solve;
Var i : longint;
Begin
    For i := 0 to n do
        If i <= k then f[i] := i + 1
        else f[i] := (f[i - 1] + f[i - k - 1]) mod BASE;
    writeln(f[n]);
End;

BEGIN
    Enter;
    Solve;
END.