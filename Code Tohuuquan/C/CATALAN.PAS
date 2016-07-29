{$MODE OBJFPC}
Program NKCAT;
Const maxn = 16;
Var a : array[0..maxn, 0..maxn] of integer;
    c : array[0..maxn shl 1] of integer;
    n, k : integer;

Procedure Enter;
Var i, j : integer;
Begin
    readln(n);
    For i := 0 to n do a[i, 0] := 1;
    For i := 1 to n do
        For j := 1 to n do
            If j <= i then a[i, j] := a[i - 1, j] + a[i, j - 1];
End;

Procedure ProblemA;
Var i, j, t : integer;
Begin
    For t := 0 to n shl 1 do read(c[t]);
    readln;
    i := n - 1;
    j := n - 1;
    k := 1;
    For t := 2 to n shl 1 do
        If c[t] > c[t - 1] then
            Begin
                inc(k, a[i, j]);
                dec(j);
            End
        Else dec(i);
    writeln(k);
End;

Procedure ProblemB;
Var i, j, t : integer;
Begin
    readln(k);
    fillchar(c, sizeof(c), 0);
    i := n - 1;
    j := n - 1;
    c[1] := 1;
    For t := 2 to n shl 1 do
        If k > a[i, j] then
            Begin
                c[t] := c[t - 1] + 1;
                dec(k, a[i, j]);
                dec(j);
            End
        Else
            Begin
                c[t] := c[t - 1] - 1;
                dec(i);
            End;
    For t := 0 to n shl 1 do write(c[t], ' ');
    writeln;
End;

BEGIN
    Enter;
    ProblemA;
    ProblemB;
END.