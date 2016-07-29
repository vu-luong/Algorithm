Program MMAXPER;
Uses Math;
Const maxn = 1000;
Var a : array[1..maxn, 1..2] of word;
    f : array[0..1, 1..2] of cardinal;
    n : word;

Procedure Enter;
Var i : word;
Begin
    readln(n);
    For i := 1 to n do readln(a[i, 1], a[i, 2]);
End;

Procedure Solve;
Var i : word;
Begin
    f[1, 1] := a[1, 1];
    f[1, 2] := a[1, 2];
    For i := 2 to n do
    Begin
        f[i mod 2, 1] := a[i, 1] + Max( f[(i - 1) mod 2, 1] + abs(a[i, 2] - a[i - 1, 2]),
                                        f[(i - 1) mod 2, 2] + abs(a[i, 2] - a[i - 1, 1]) );
        f[i mod 2, 2] := a[i, 2] + Max( f[(i - 1) mod 2, 1] + abs(a[i, 1] - a[i - 1, 2]),
                                        f[(i - 1) mod 2, 2] + abs(a[i, 1] - a[i - 1, 1]) );
    End;
    writeln(Max(f[n mod 2, 1], f[n mod 2, 2]));
End;

BEGIN
    Enter;
    Solve;
END.