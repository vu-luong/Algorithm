Program LQDGONME;
Uses Math;
Const maxn = 1000;
      maxm = 10;
Var a, pos : array[1..maxm, 1..maxn] of word;
    f : array[1..maxn] of word;
    n, m : word;

Procedure Enter;
Var i, j : word;
Begin
    readln(n, m);
    For i := 1 to m do
        For j := 1 to n do
        Begin
            read(a[i, j]);
            pos[i, a[i, j]] := j;
        End;
End;

Function Check(x, y : word) : boolean;
Var i : word;
Begin
    For i := 1 to m do
        If pos[i, x] > pos[i, y] then exit(false);
    exit(true);
End;

Procedure Solve;
Var i, j, res : word;
Begin
    For i := 1 to n do f[i] := 1;
    For i := 1 to n do
        For j := 1 to i - 1 do
            If Check(a[1, j], a[1, i]) then
                f[i] := Max(f[i], f[j] + 1);
    res := 1;
    For i := 1 to n do res := Max(res, f[i]);
    writeln(res);
End;

BEGIN
    Enter;
    Solve;
END.
