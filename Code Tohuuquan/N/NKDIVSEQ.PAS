Program NKDIVSEQ;
Var n, res : longint;

Procedure Enter;
Begin
    readln(n);
End;

Procedure Solve;
Var count, i, j : longint;
Begin
    count := 0;
    i := 0;
    res := 0;
    Repeat
        inc(i);
        inc(count);
        Repeat inc(res) Until res mod i = 0;
        If count = n then exit;
        For j := 1 to i - 1 do
        Begin
            inc(count);
            inc(res, i);
            If count = n then exit;
        End;
    Until false;
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
