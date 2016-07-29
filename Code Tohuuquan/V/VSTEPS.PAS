Program VSTEPS;
Const maxn = 100000;
      BASE = 14062008;
Var avail : array[1..maxn] of boolean;
    f : array[0..maxn] of longint;
    n, k : longint;

Procedure Enter;
Var i, x : longint;
Begin
    readln(n, k);
    fillchar(avail, sizeof(avail), true);
    For i := 1 to k do
    Begin
        read(x);
        avail[x] := false;
    End;
End;

Procedure Solve;
Var i : longint;
Begin
    f[0] := 0;
    f[1] := 1;
    For i := 2 to n do
        If avail[i] then
            Begin
                f[i] := f[i - 1] + f[i - 2];
                If f[i] > BASE then dec(f[i], BASE);
            End
        Else f[i] := 0;
End;

Procedure PrintResult;
Begin
    writeln(f[n]);
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.
