Program XAYNHA;
Var t : longint;
    n : int64;

Function Value(x : longint) : int64;
Var t : int64;
Begin
    t := (x * (x + 1)) shr 1;
    exit(t * t);
End;

Procedure Solve;
Var i : longint;
    s : int64;
Begin
    If n = 0 then
    Begin
        writeln('0 1 1');
        exit;
    End;
    i := trunc(sqrt(sqrt(n) * 2));
    s := Value(i);
    If s = n then
    Begin
        writeln('1 ', i);
        exit;
    End;
    If n - Value(i - 1) < Value(i) - n then
    Begin
        dec(i);
        s := Value(i);
    End;
    writeln('0 ', s - n, ' ', i);
End;

BEGIN
    readln(t);
    While t > 0 do
    Begin
        readln(n);
        Solve;
        dec(t);
    End;
END.