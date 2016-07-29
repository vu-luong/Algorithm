Program BASEH;
Var k : longint;
    h : word;

Procedure Enter;
Begin
    readln(k, h);
End;

Procedure PrintResult;
Var s : string;
Begin
    s := '';
    While k > 0 do
    Begin
        s := chr(k mod 2 + 48) + s;
        k := k shr 1;
    End;
    writeln(s);
End;

BEGIN
    Enter;
    PrintResult;
END.
