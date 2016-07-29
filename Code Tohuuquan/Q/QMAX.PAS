Program QMAX;
Const maxn = 50000;
Var a : array[0..maxn + 1] of longint;
    IT : array[1..maxn * 3] of longint;
    n, m, q, qleft, qright : word;
    res : longint;

Procedure Enter;
Var i, u, v : word;
    k : longint;
Begin
    readln(n, m);
    fillchar(a, sizeof(a), 0);
    For i := 1 to m do
    Begin
        readln(u, v, k);
        inc(a[u], k);
        dec(a[v + 1], k);
    End;
    For i := 1 to n do a[i] := a[i - 1] + a[i];
End;

Function Max(x, y : longint) : longint;
Begin
    If x > y then exit(x) else exit(y);
End;

Procedure Modify(i : longint; left, right : word);
Var mid : word;
Begin
    If left = right then
        IT[i] := a[left]
    Else
        Begin
            mid := (left + right) div 2;
            Modify(i shl 1, left, mid);
            Modify(i shl 1 + 1, mid + 1, right);
            IT[i] := Max(IT[i shl 1], IT[i shl 1 + 1]);
        End;
End;

Procedure Find(i : longint; left, right : word);
Var mid : word;
Begin
    If (qleft <= left) and (right <= qright) then
        res := Max(res, IT[i])
    Else
        If (left > qright) or (right < qleft) then exit
    Else
        Begin
            mid := (left + right) div 2;
            Find(i shl 1, left, mid);
            Find(i shl 1 + 1, mid + 1, right);
        End;
End;

Procedure Solve;
Begin
    readln(q);
    While q > 0 do
    Begin
        res := 0;
        readln(qleft, qright);
        If qleft = qright then writeln(a[qleft]) else
        Begin
            Find(1, 1, n);
            writeln(res);
        End;
        dec(q);
    End;
End;

BEGIN
    Enter;
    Modify(1, 1, n);
    Solve;
END.