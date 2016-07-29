Program NKABD;
Const max = 100000;
Var a : array[1..max] of longint;
    l, r : longint;

Procedure Enter;
Begin
    readln(l, r);
End;

Procedure Solve;
Var i, j : longint;
Begin
    For i := 1 to r do a[i] := 1;
    For i := 2 to r do
    Begin
        j := i shl 1;
        While j <= r do
        Begin
            inc(a[j], i);
            inc(j, i);
        End;
    End;
End;

Procedure PrintResult;
Var count, i : longint;
Begin
    count := 0;
    For i := l to r do
        If a[i] > i then inc(count);
    writeln(count);
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.
