Program QBDIVSEQ;
Const maxn = 100000;
Var a : array[1..maxn] of longint;
    n, res : longint;

Procedure Enter;
Var i : longint;
Begin
    readln(n);
    For i := 1 to n do readln(a[i]);
End;

Procedure Solve;
Var last : array[1..maxn] of longint;
    i, x, y, t : longint;
Begin
    res := 1;
    last[res] := 1;
    For i := 2 to n do
        If a[i] > a[last[1]] then
            last[1] := i
        Else If a[i] < a[last[res]] then
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
                    If a[i] < a[last[t]] then x := t + 1 else y := t;
                End;
                last[x] := i;
            End;
    writeln(res);
End;

BEGIN
    Enter;
    Solve;
END.
