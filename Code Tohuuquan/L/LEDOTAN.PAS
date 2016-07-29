Program LEDOTAN;
Const maxn = 100000;
Var a : array[0..maxn] of longint;
    n, m, max : longint;

Procedure Enter;
Var i : longint;
Begin
    readln(n, m);
    For i := 1 to n do
    Begin
        read(a[i]);
        If a[i] > max then max := a[i];
        inc(a[i], a[i - 1]);
    End;
End;

Function Cal(k : longint) : longint;
Var t, u, v : longint;
Begin
    If k < max then exit(m + 1);
    t := 0;
    u := 0;
    For v := 1 to n do
        If a[v] - a[u] > k then
        Begin
            inc(t);
            u := v - 1;
        End;
    exit(t + 1);
End;

Procedure Solve;
Var first, last, mid : longint;
Begin
    If Cal(1) <= m then write(1) else
    Begin
        last := 1;
        Repeat
            first := last;
            last := last shl 1;
        Until Cal(last) <= m;
        Repeat
            mid := (first + last) shr 1;
            If Cal(mid) <= m then last := mid
            else first := mid;
        Until last - first = 1;
        writeln(last);
    End;
End;

BEGIN
    Enter;
    Solve;
END.

