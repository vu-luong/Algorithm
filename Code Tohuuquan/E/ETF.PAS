Program ETF;
Uses Math;
Const maxn = 100000;
Var t, n : longint;

Function Pow(a, b : longint) : longint;
Begin
    exit(trunc(Power(a, b)));
End;

Function Cal(a, b : longint) : longint;
Begin
    exit(Pow(a, b - 1) * (a - 1));
End;

Procedure Solve;
Var p, q, m, res : longint;
Begin
    q := 0;
    res := 1;
    m := n;
    While m and 1 = 0 do
    Begin
        inc(q);
        m := m shr 1;
    End;
    If q > 0 then res := res * Cal(2, q);
    p := 3;
    While (m <> 1) and (p <= trunc(sqrt(m))) do
    Begin
        q := 0;
        While m mod p = 0 do
        Begin
            inc(q);
            m := m div p;
        End;
        If q > 0 then res := res * Cal(p, q);
        inc(p, 2);
    End;
    If m <> 1 then res := res * Cal(m, 1);
    writeln(res);
End;

BEGIN
    readln(t);
    While t > 0 do
    Begin
        readln(n);
        Solve;
        dec(t);
    End;
END.
