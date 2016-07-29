{$MODE OBJFPC}
Program QBRECT;
Const maxn = 1000;
Var h, left, right, s, p : array[0..maxn + 1] of integer;
    x : array[1..maxn] of byte;
    m, n, i : word;
    wmax : longint;
    t : byte;

Procedure Solve;
Var i, top, bot : word;
Begin
    top := 1; bot := 1;
    s[top] := -1; p[top] := 0;
    For i := 1 to n do
    Begin
        While h[i] <= s[top] do dec(top);
        left[i] := p[top] + 1;
        inc(top);
        s[top] := h[i];
        p[top] := i;
    End;

    top := 1; bot := 1;
    s[top] := -1; p[top] := n + 1;
    For i := n downto 1 do
    Begin
        While h[i] <= s[top] do dec(top);
        right[i] := p[top] - 1;
        inc(top);
        s[top] := h[i];
        p[top] := i;
    End;

    For i := 1 to n do
        If (h[i] * (right[i] - left[i] + 1) > wmax) then
            wmax := h[i] * (right[i] - left[i] + 1);
End;

BEGIN
    readln(m, n);
    While m > 0 do
    Begin
        For i := 1 to n do
        Begin
            read(t);
            If x[i] = t then inc(h[i]) else h[i] := 1;
            If t = 0 then h[i] := 0;
            x[i] := t;
        End;
        Solve;
        dec(m);
    End;
    writeln(wmax);
END.
