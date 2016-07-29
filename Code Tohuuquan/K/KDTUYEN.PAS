Program KDTUYEN;
Var i, s, x : longint;

BEGIN
    readln(x);
    If x = 0 then write(1) else
    If x < 6 then
    Begin
        s := 1;
        For i := 1 to x do s := (s * i) mod 9;
        write(s);
    End Else write(9);
END.