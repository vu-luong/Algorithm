Program LIS;
Const maxn = 30000;
Var a : array[1..maxn] of longint;
    n, res : word;

Procedure Enter;
Var i : word;
Begin
    readln(n);
    For i := 1 to n do read(a[i]);
End;

Procedure Solve;
Var last : array[1..maxn] of word;
    i, x, y, t : word;
Begin
    res := 1;
    last[res] := 1;
    For i := 2 to n do
        If a[i] < a[last[1]] then
            last[1] := i
        Else If a[i] > a[last[res]] then
            Begin
                inc(res);
                last[res] := i;
            End
        Else
            Begin
                x := 1;
                y := res;
                While x < y do
                Begin
                    t := (x + y) shr 1;
                    If a[i] > a[last[t]] then x := t + 1 else y := t;
                End;
                last[x] := i;
            End;
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