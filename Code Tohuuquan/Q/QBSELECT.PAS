Program QBSELECT;
Uses Math;
Const maxn = 10000;
      m = 4;
      bit : array[1..5] of byte =
       (1, 2, 4, 8, 16);
Var a : array[1..m, 1..maxn] of integer;
    b : array[1..8] of byte;
    check : array[1..8, 1..8] of boolean;
    f : array[0..maxn, 1..8] of int64;
    n : word;
    d : byte;
    res : int64;

Procedure Enter;
Var i : byte;
    j : word;
    temp : integer;
Begin
    readln(n);
    temp := low(integer);
    For i := 1 to m do
        For j := 1 to n do
        Begin
            read(a[i, j]);
            temp := Max(temp, a[i, j]);
        End;
    If temp <= 0 then
    Begin
        write(temp);
        halt;
    End;
End;

Procedure Init;
Var s : array[1..m] of boolean;
    i, j, k : byte;
    ok : boolean;
Begin
    For i := 0 to bit[m + 1] - 1 do
    Begin
        For j := 1 to m do s[j] := (i and bit[j]) > 0;
        ok := true;
        For j := 1 to m - 1 do
            If s[j] and s[j + 1] then
            Begin
                ok := false;
                break;
            End;
        If ok then
        Begin
            inc(d);
            b[d] := i;
        End;
    End;
    fillchar(check, sizeof(check), true);
    For i := 1 to d do
        For j := 1 to d do
            For k := 1 to m do
            If ((b[i] and bit[k]) > 0) and ((b[j] and bit[k]) > 0) then
            Begin
                check[i, j] := false;
                break;
            End;
End;

Procedure Solve;
Var i : word;
    j, k : byte;
    sum : int64;
Begin
    For i := 1 to n do
        For j := 1 to d do
        Begin
            sum := 0;
            For k := 1 to m do
                If (b[j] and bit[k]) > 0 then inc(sum, a[k, i]);
            For k := 1 to d do
                If check[j, k] then
                    f[i, j] := Max(f[i, j], f[i - 1, k] + sum);
            res := Max(res, f[i, j]);
        End;
    write(res);
End;

BEGIN
    Enter;
    Init;
    Solve;
END.