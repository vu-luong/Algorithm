Program MATMA;
Var t : word;
    st : string;
    x : longint;

Procedure Solve;
Var m, i : integer;
    flag : boolean;
Begin
    If st = '0' then x := 0 else
    Begin
        x := 1 shl (length(st) - 1);
        m := length(st) - 2;
        flag := true;
        For i := 2 to length(st) do
        Begin
            If st[i] = '1' then flag := not flag;
            If flag then inc(x, 1 shl m);
            dec(m);
        End;
    End;
    writeln(x);
End;

BEGIN
    readln(t);
    While t > 0 do
    Begin
        readln(st);
        Solve;
        dec(t);
    End;
END.