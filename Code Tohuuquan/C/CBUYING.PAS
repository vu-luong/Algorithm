Program CBUYING;
Const maxn = 100000;
Var p, c : array[1..maxn] of qword;
    n : longint;
    b, res : qword;

Procedure Enter;
Var i : longint;
Begin
    readln(n, b);
    For i := 1 to n do readln(p[i], c[i]);
End;

Procedure Sort(l, r : longint);
Var i, j : longint;
    x, t : qword;
Begin
    If l >= r then exit;
    i := l;
    j := r;
    x := p[l + random(r - l + 1)];
    Repeat
        While p[i] < x do inc(i);
        While p[j] > x do dec(j);
        If i <= j then
        Begin
            t := p[i]; p[i] := p[j]; p[j] := t;
            t := c[i]; c[i] := c[j]; c[j] := t;
            inc(i);
            dec(j);
        End;
    Until i > j;
    Sort(l, j);
    Sort(i, r);
End;

Procedure Solve;
Var i : longint;
    t : qword;
Begin
    For i := 1 to n do
    Begin
        t := b div p[i];
        If t >= c[i] then
        Begin
            dec(b, p[i] * c[i]);
            inc(res, c[i]);
        End Else
        Begin
            dec(b, t * p[i]);
            inc(res, t);
        End;
    End;
    write(res);
End;

BEGIN
    Enter;
    Sort(1, n);
    Solve;
END.