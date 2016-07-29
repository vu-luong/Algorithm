Program COUNTCBG;
Var n : longint;

Procedure Solve;
Var i, s, count : longint;
Begin
    count := 0;
    i := 0;
    s := 0;
    While s <= n do
    Begin
        inc(i);
        inc(s, i);
        If ((n - s) mod (i + 1) = 0) and (n - s <> i + 1) then inc(count);
    End;
    writeln(count);
End;

BEGIN
    While not eof do
    Begin
        readln(n);
        Solve;
    End;
END.
