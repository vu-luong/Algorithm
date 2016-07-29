Program TEST;
Var n : longint;
    flag : boolean;

BEGIN
    flag := true;
    While not eof do
    Begin
        readln(n);
        If flag and (n <> 42) then writeln(n);
        If n = 42 then flag := false;
    End;
END.