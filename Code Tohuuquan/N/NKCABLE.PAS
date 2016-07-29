Program NKCABLE;
Const maxn = 25000;
Var l : array[1..maxn - 1] of longint;
    f : array[0..2] of longint;
    n : word;

Procedure Enter;
Var i : word;
Begin
    readln(n);
    For i := 1 to n - 1 do readln(l[i]);
End;

Function Min(x, y : longint) : longint;
Begin
    If x < y then exit(x) else exit(y);
End;

Procedure Solve;
Var i : word;
Begin
    f[1] := l[1];
    For i := 2 to n do
        f[i mod 3] := l[i - 1] + Min(f[(i - 1) mod 3], f[(i - 2) mod 3]);
End;

Procedure PrintResult;
Begin
    writeln(f[n mod 3]);
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.
