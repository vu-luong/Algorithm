Program LOTT;
Const max = 500;
Var c : array[0..max, 0..max] of double;
    n : integer;
    st : string;

Procedure Init;
Var i, j : integer;
Begin
    For i := 0 to max do
    Begin
        c[i, i] := 1;
        c[i, 0] := 1;
    End;
    For i := 0 to max do
        For j := 1 to i - 1 do
            c[i, j] := c[i - 1, j] + c[i - 1, j - 1];
End;

Function Cal(n : word) : double;
Begin
    If n = 1 then exit(1);
    exit(n * (c[5, 3] * c[5 * (n - 1), 2]
              + c[5, 4] * C[5 * (n - 1), 1]
              + c[5, 5] * c[5 * (n - 1), 0]) / c[5 * n, 5]);
End;

BEGIN
    Init;
    While not eof do
    Begin
        Repeat readln(st) Until (st = '[CASE]') or (st = '[END]');
        If st = '[END]' then break else
        Begin
            readln(n);
            writeln(Cal(n));
        End;
    End;
END.
