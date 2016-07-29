Program NKEDIT;
Const max = 50;
Var s, p : string[max];
    k, count : byte;

Procedure Enter;
Begin
    readln(k);
    readln(s);
    readln(p);
End;

Procedure Solve;
Var i, j, l : byte;
    st : string;
    stop : boolean;
Begin
    Repeat
        stop := true;
        For i := length(s) downto k do
        If i > length(p) then continue else
        Begin
            For j := 1 to length(s) - i + 1 do
            Begin
                st := copy(s, j, i);
                l := pos(st, p);
                If l > 0 then
                Begin
                    inc(count);
                    delete(s, j, i);
                    delete(p, l, i);
                    stop := false;
                    break;
                End;
            End;
            If not stop then break;
        End;
    Until stop;
End;

Procedure PrintResult;
Begin
    writeln(count);
    writeln(s);
    writeln(p);
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.