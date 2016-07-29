Program NKSTEP;
Uses Math;
Var t, n, m, x, y : longint;

Procedure Solve;
Var a, b, s : longint;
Begin
    a := Min(n, m);
    b := Max(n, m);
    s := b - a;
    x := trunc(sqrt(s));
    y := 0;
    While x * x + y <> s do inc(y);
End;

Procedure PrintResult;
Begin
    If y = 0 then writeln(x * 2 - 1) else
        If (y > 0) and (y <= x) then writeln(x * 2) else
            writeln(x * 2 + 1);
End;

BEGIN
    readln(t);
    While t > 0 do
    Begin
        dec(t);
        readln(n, m);
        Solve;
        PrintResult;
    End;
END.