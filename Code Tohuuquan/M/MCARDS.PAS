Program MCARDS;
Uses Math;
Const maxn = 100;
      maxc = 4;
      maxm = maxn * maxc;
Type Card = array[1..2] of byte;
Var a : array[1..maxm] of Card;
    f, l : array[1..maxm] of word;
    d : array[1..maxc] of byte;
    free : array[1..maxc] of boolean;
    c, n : byte;
    m, res : word;

Procedure Enter;
Var i : word;
Begin
    readln(c, n);
    m := n * c;
    For i := 1 to m do readln(a[i, 1], a[i, 2]);
    fillchar(free, sizeof(free), true);
    res := maxm + 1;
End;

Procedure Init;
Var i : word;
Begin
    For i := 1 to m do
        f[i] := d[a[i, 1]] * 1000 + a[i, 2];
End;

Procedure Solve;
Var i, x, y, t, len : word;
Begin
    Init;
    l[1] := 1;
    len := 1;
    For i := 2 to m do
        If f[i] < f[l[1]] then l[1] := i else
        If f[i] > f[l[len]] then
            Begin
                inc(len);
                l[len] := i;
            End
        Else
            Begin
                x := 1;
                y := len;
                While x < y do
                Begin
                    t := (x + y) shr 1;
                    If f[l[t]] < f[i] then x := t + 1 else y := t;
                End;
                l[x] := i;
            End;
    res := Min(res, n * c - len);
End;

Procedure Find(x : byte);
Var i : byte;
Begin
    If x > c then Solve;
    For i := 1 to c do
        If free[i] then
        Begin
            d[x] := i;
            free[i] := false;
            Find(x + 1);
            free[i] := true;
        End;
End;

Procedure PrintResult;
Begin
    write(res);
End;

BEGIN
    Enter;
    Find(1);
    PrintResult;
END.