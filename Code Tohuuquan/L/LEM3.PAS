Program LEM3;
Uses Math;
Const maxn = 15;
      bit : array[1..16] of word =
       (1, 2, 4, 8, 16, 32, 64, 128, 256, 512,
        1024, 2048, 4096, 8192, 16384, 32768);
Var c : array[1..maxn, 1..maxn] of word;
    f : array[0..maxn, 0..maxint] of longint;
    n : byte;

Procedure Enter;
Var i, j : byte;
Begin
    readln(n);
    For i := 1 to n do
        For j := 1 to n do read(c[i, j]);
End;

Procedure Solve;
Var i, x : byte;
    j, y : word;
Begin
    For j := 1 to bit[n + 1] - 1 do
        For i := 1 to n do
            If j and bit[i] <> 0 then
            Begin
                f[i, j] := maxlongint;
                y := j - bit[i];
                If y = 0 then f[i, j] := 0 else
                For x := 1 to n do
                    If y and bit[x] <> 0 then
                    f[i, j] := Min(f[i, j], f[x, y] + c[x, i]);
            End;
End;

Procedure PrintResult;
Var i : byte;
    res : longint;
Begin
    res := maxlongint;
    For i := 1 to n do
        res := Min(res, f[i, bit[n + 1] - 1]);
    writeln(res);
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.