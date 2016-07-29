Program MULONE;
Var s1, s2, s3 : string;
    s : array[1..9] of string;
    n : longint;

Procedure Init;
Begin
    s1 := '123456790';
    s2 := '987654320';
    s3 := '987654321';
    s[1] := '0';
    s[2] := '120';
    s[3] := '12320';
    s[4] := '1234320';
    s[5] := '123454320';
    s[6] := '12345654320';
    s[7] := '1234567654320';
    s[8] := '123456787654320';
    s[9] := '12345678987654320';
End;

Procedure Solve;
Var j, k, l : longint;
Begin
    If n < 10 then
    Begin
        For j := 1 to n do write(j);
        For j := n - 1 downto 1 do write(j);
        writeln;
        exit;
    End;
    j := n div 9;
    l := n mod 9;
    If l <> 0 then
        Begin
            For k := 1 to j do write(s1);
            write(s[l]);
            For k := 1 to j - 1 do write(s2);
            writeln(s3);
        End
    Else
        Begin
            For k := 1 to j - 1 do write(s1);
            write(s[9]);
            For k := 1 to j - 2 do write(s2);
            writeln(s3);
        End;
End;

BEGIN
    Init;
    readln(n);
    While not eof do
    Begin
        readln(n);
        Solve;
    End;
END.
