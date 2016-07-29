Program SUBSTR;
Const maxm = 1000000;
Var next : array[1..maxm + 1] of longint;
    a, b : ansistring;

Procedure Enter;
Begin
    readln(b);
    readln(a);
End;

Procedure Init;
Var i, j : longint;
Begin
    j := 0;
    next[1] := 0;
    For i := 1 to length(a) do
    Begin
        While (j > 0) and (a[i] <> a[j]) do j := next[j];
        inc(j);
        If a[i + 1] = a[j] then next[i + 1] := next[j] else next[i + 1] := j;
    End;
End;

Procedure KMP;
Var i, j : longint;
Begin
    i := 1;
    For j := 1 to length(b) do
    Begin
        While (i > 0) and (a[i] <> b[j]) do i := next[i];
        inc(i);
        If i > length(a) then
        Begin
            writeln(j - i + 2);
            i := next[i];
        End;
    End;
End;

BEGIN
    Enter;
    Init;
    KMP;
END.
