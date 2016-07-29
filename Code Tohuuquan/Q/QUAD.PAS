Program QUAD;
Const max = 2500;
Var a : array[1..max] of int64;
    n : word;

Procedure Enter;
Begin
    readln(n);
End;

Procedure Solve;
Var i : word;
Begin
    a[4] := 1;
    a[5] := 4;
    For i := 7 to n do
        If odd(i) then a[i] := a[i - 2] * (i + 1) div (i - 5);
    For i := 6 to n do
        If i mod 2 = 0 then a[i] := a[i - 1] + (i - 1) shr 1;
    writeln(a[n]);
End;

BEGIN
    Enter;
    Solve;
END.