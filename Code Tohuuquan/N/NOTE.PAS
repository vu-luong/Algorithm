Program NOTE;
Var c, f : longint;

Function Cal(f, c : longint) : char;
Begin
    If f = 1 then exit('D');
    If c mod 4 = 1 then exit('U') else
        If c mod 4 = 3 then exit('D') else
            exit(Cal(f - 1, c shr 1));
End;

BEGIN
    Repeat
        readln(f, c);
        If f + c = 0 then break;
        writeln(Cal(f, c));
    Until false;
END.