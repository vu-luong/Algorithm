Program COWGIRL;
Var f : array[1..32, 0..32] of longint;
    t, m, n, num : byte;
    res : longint;

Function Getbit(x, i : byte) : byte;
Begin
    exit((x shr (i - 1)) and 1);
End;

Function Check(a, b : byte) : boolean;
Var i : byte;
Begin
    For i := 2 to num do
        If ((Getbit(a, i) = 0) and (Getbit(b, i) = 0) and (Getbit(a, i - 1) = 0) and (Getbit(b, i - 1) = 0))
        or ((Getbit(a, i) = 1) and (Getbit(b, i) = 1) and (Getbit(a, i - 1) = 1) and (Getbit(b, i - 1) = 1))
        then exit(false);
    exit(true);
End;

Procedure Enter;
Begin
    readln(m, n);
End;

Procedure Solve;
Var i, j, k, min, max, temp : byte;
Begin
    fillchar(f, sizeof(f), 0);
    If m < n then min := m else min := n;
    If m > n then max := m else max := n;
    temp := 1;
    num := min;
    For i := 1 to min do temp := temp * 2;
    min := temp - 1;
    For i := 0 to min do f[1, i] := 1;
    For i := 2 to max do
        For j := 0 to min do
            For k := 0 to min do
                If Check(j, k) then inc(f[i, j], f[i - 1, k]);
    res := 0;
    For i := 0 to min do inc(res, f[max, i]);
    writeln(res);
End;

BEGIN
    readln(t);
    While t > 0 do
    Begin
        Enter;
        Solve;
        dec(t);
    End;
END.
