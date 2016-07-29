Program LUCKYNUM;
Const maxl = 200;
Var t, n : word;

Procedure Solve;
Var s, st : string;
    i, j, len : byte;
    cal : word;
Begin
    If n mod 5 = 0 then
    Begin
        writeln(-1);
        exit;
    End;
    st := '';
    For len := 1 to maxl do
    Begin
        st := st + '6';
        s := st;
        For i := 0 to len do
        Begin
            If i > 0 then s[i] := '8';
            cal := 0;
            For j := 1 to len do
                cal := (cal * 10 + ord(s[j]) - 48) mod n;
            If cal = 0 then
            Begin
                writeln(s);
                exit;
            End;
        End;
    End;
    writeln(-1);
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
