Program MBLAST;
Uses Math;
Const maxl = 2000;
Var f : array[0..maxl, 0..maxl] of longint;
    a, b : ansistring;
    k : byte;
    res : word;

Procedure Enter;
Begin
    readln(a);
    readln(b);
    readln(k);
End;

Function Minimum(x, y, z, t : longint) : longint;
Begin
    exit(Min(Min(x, y), Min(z, t)));
End;

Procedure Solve;
Var i, j : word;
Begin
    For i := 0 to length(a) do f[i, 0] := i * k;
    For j := 0 to length(b) do f[0, j] := j * k;
    For i := 1 to length(a) do
        For j := 1 to length(b) do
            f[i, j] := Minimum(f[i - 1, j - 1] + abs(ord(a[i]) - ord(b[j])),
                               f[i - 1, j - 1] + 2 * k,
                               f[i - 1, j] + k,
                               f[i, j - 1] + k);
    write(f[length(a), length(b)]);
End;

BEGIN
    Enter;
    Solve;
END.
