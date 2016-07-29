Program MMOD29;
Var x, x1, x2, x3, i, delta : longint;

Function Cal(x, y : longint) : longint;
Var t : longint;
Begin
    If y = 1 then exit(x mod 29);
    t := Cal(x, y shr 1);
    If y mod 2 = 0 then exit(sqr(t) mod 29)
    else exit((x * sqr(t)) mod 29);
End;

BEGIN
    Repeat
        readln(x);
        If x = 0 then break;

        x1 := Cal(2, 2 * x + 1);
        If x1 = 0 then x1 := 28 else dec(x1);
        x2 := Cal(3, x + 1);
        If x2 = 0 then x2 := 28 else dec(x2);
        x3 := Cal(167, x + 1);
        If x3 = 0 then x3 := 28 else dec(x3);
        delta := (x1 * x2 * x3) mod 29;

        For i := 0 to 28 do
            If (i * 13) mod 29 = delta then
            Begin
                writeln(i);
                break;
            End;
    Until false;
END.
