Program MDIGITS2;
Const maxn = 100000;
Var s, n : ansistring;

Procedure Init;
Var i : longint;
    st : ansistring;
Begin
    s := '';
    For i := 1 to maxn do
    Begin
        str(i, st);
        s := s + st;
    End;
End;

BEGIN
    Init;
    readln(n);
    writeln(Pos(n, s));
END.
