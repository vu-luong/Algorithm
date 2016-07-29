Program NKSEQ;
Uses Math;
Const maxn = 100000;
Var a, f : array[0..maxn] of longint;
    n, res : longint;

Procedure Enter;
Var i, sum : longint;
Begin
    readln(n);
    sum := 0;
    For i := 1 to n do
    Begin
        read(a[i]);
        inc(sum, a[i]);
    End;
    If sum <= 0 then
    Begin
        write(0);
        halt;
    End;
End;

Procedure Solve;
Var i, sum : longint;
Begin
    f[n] := a[n];
    sum := a[n];
    For i := 1 to n - 1 do
    Begin
        inc(sum, a[i]);
        f[n] := Min(f[n], sum);
    End;
    For i := n - 1 downto 1 do f[i] := Min(a[i] + f[i + 1], a[i]);
    For i := 1 to n do
        If f[i] > 0 then inc(res);
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
