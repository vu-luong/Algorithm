Program ROTATION;
Var n : word;
    res : byte;

Procedure Enter;
Var i, s, d : word;
    c : byte;
Begin
    readln(n);
    res := 0;
    For i := 2 to n do
    Begin
        readln(s, d, c);
        If c = 1 then res := 1 - res;
    End;
End;

Procedure PrintResult;
Begin
    writeln(res);
End;

BEGIN
    Enter;
    PrintResult;
END.
