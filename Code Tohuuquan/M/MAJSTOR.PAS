Program MAJSTOR;
Uses Math;
Var a, b : array[1..50, 0..2] of word;
    n, r, res, t, i, j : word;
    c : char;

Function F : word;
Begin
    Case c of
     'S' : F := 0;
     'R' : F := 1;
     'P' : F := 2;
    End;
End;

BEGIN
    readln(r);
    For j := 1 to r do
        Begin read(c); inc(a[j, F]); End;
    readln(n);
    For i := 1 to n do
    Begin
        For j := 1 to r do
            Begin read(c); inc(b[j, F]); End;
        readln;
    End;
    For i := 1 to r do
        For j := 0 to 2 do
            If a[i, j] > 0 then
            Begin
                inc(res, b[i, j] + 2 * b[i, (j + 2) mod 3]);
                break;
            End;
    writeln(res);
    res := 0;
    For i := 1 to r do
    Begin
        t := 0;
        For j := 0 to 2 do
            t := Max(t, b[i, j] + 2 * b[i, (j + 2) mod 3]);
        inc(res, t);
    End;
    writeln(res);
END.