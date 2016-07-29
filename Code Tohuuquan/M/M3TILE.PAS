Program M3TILE;
Var res : array[0..30] of int64;
    n : shortint;

Procedure Init;
Var i, j : byte;
Begin
    res[0] := 1;
    res[1] := 0;
    res[2] := 3;
    res[4] := 11;
    For i := 6 to 30 do
        If i mod 2 = 0 then
        Begin
            res[i] := res[i] + 3 * res[i - 2];
            For j := i - 4 downto 0 do
                If j mod 2 = 0 then
                    res[i] := res[i] + res[j] shl 1;
        End;
End;

BEGIN
    Init;
    Repeat
        readln(n);
        If n >= 0 then
            If odd(n) then writeln(0)
            else writeln(res[n]);
    Until n = -1;
END.