Program VBOARD;
Const maxn = 500;
Var a : array[1..maxn, 1..maxn] of word;
    s : array[0..maxn + 1, 0..maxn + 1] of longint;
    n, q : word;

Procedure Enter;
Var i, j : word;
Begin
    readln(n);
    For i := 1 to n do
        For j := 1 to n do read(a[i, j]);
End;

Procedure Init;
Var i, j : word;
Begin
    For i := 1 to n do
        For j := 1 to n do
        If (i mod 2) = (j mod 2) then
            s[i, j] := s[i - 1, j] + s[i, j - 1] - s[i - 1, j - 1] + a[i, j]
        else
            s[i, j] := s[i - 1, j] + s[i, j - 1] - s[i - 1, j - 1] - a[i, j];
End;

Procedure Solve;
Var i1, j1, i2, j2 : word;
Begin
    readln(q);
    While q > 0 do
    Begin
        readln(i1, j1, i2, j2);
        writeln(abs(s[i2, j2] - s[i1 - 1, j2] - s[i2, j1 - 1] + s[i1 - 1, j1 - 1]));
        dec(q);
    End;
End;

BEGIN
    Enter;
    Init;
    Solve;
END.