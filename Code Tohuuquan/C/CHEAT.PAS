Program CHEAT;
Const maxn = 100000;
Var prev, next : array[0..maxn + 1] of longint;
    n, last : longint;
    res : boolean;

Procedure Enter;
Var i : longint;
Begin
    readln(n);
    last := 0;
    res := true;
    For i := 1 to n do
    Begin
        prev[i] := i - 1;
        next[i] := i + 1;
    End;
End;

Procedure Solve;
Var i, x : longint;
Begin
    For i := 1 to n do
    Begin
        readln(x);
        If (x <> prev[last]) and (x < last) then
        Begin
            res := false;
            break;
        End;
        next[prev[x]] := next[x];
        prev[next[x]] := prev[x];
        last := x;
    End;
End;

Procedure PrintResult;
Begin
    If res then writeln('NO') else writeln('YES');
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.