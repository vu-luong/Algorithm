Program NKPATH;
Const maxm = 100;
      maxn = 100;
      BASE = 1000000000;
Var a, f : array[1..maxm, 1..maxn] of cardinal;
    m, n : byte;

Procedure Enter;
Var i, j : byte;
Begin
    readln(m, n);
    For i := 1 to m do
        For j := 1 to n do read(a[i, j]);
End;

Function GCD(u, v : cardinal) : cardinal;
Var i, t : cardinal;
Begin
    If (u = 0) or (v = 0) then exit(u or v);
    i := 0;
    While (u or v) and 1 = 0 do
    Begin
        u := u shr 1;
        v := v shr 1;
        inc(i);
    End;
    While (u and 1) = 0 do u := u shr 1;
    Repeat
        While (v and 1) = 0 do v := v shr 1;
        If u < v then v := v - u else
        Begin
            t := u - v;
            u := v;
            v := t;
        End;
    Until v = 0;
    exit(u shl i);
End;

Procedure Solve;
Var i, j, x, y : byte;
    res : cardinal;
Begin
    fillchar(f, sizeof(f), 0);
    For i := 1 to m do f[i, 1] := 1;
    For i := 1 to m do
        For j := 1 to n - 1 do
        Begin
            For x := 1 to i do
                For y := 1 to j - 1 do
                    If GCD(a[i, j], a[x, y]) > 1 then
                        f[i, j] := (f[i, j] + f[x, y]) mod BASE;
            For x := 1 to i - 1 do
                If GCD(a[i, j], a[x, j]) > 1 then
                    f[i, j] := (f[i, j] + f[x, j]) mod BASE;
        End;

    For i := 1 to m do
        For x := 1 to i do
            For y := 1 to n - 1 do
                If GCD(a[i, n], a[x, y]) > 1 then
                    f[i, n] := (f[i, n] + f[x, y]) mod BASE;
End;

Procedure PrintResult;
Var i : byte;
    res : cardinal;
Begin
    res := 0;
    For i := 1 to m do
        res := (res + f[i, n]) mod BASE;
    write(res);
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.