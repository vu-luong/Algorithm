Program PTREE;
Const maxn = 200;
      maxc = 1000000000;
Var a : array[1..maxn, 1..maxn] of boolean;
    c : array[1..maxn] of integer;
    d : array[1..maxn, 1..maxn] of longint;
    trace : array[1..maxn, 1..maxn] of byte;
    n, p : byte;

Procedure Enter;
Var i, u, v : byte;
Begin
    readln(n, p);
    For i := 1 to n do read(c[i]);
    fillchar(a, sizeof(a), false);
    For i := 1 to n - 1 do
    Begin
        readln(u, v);
        a[u, v] := true;
        a[v, u] := true;
    End;
End;

Procedure Init;
Var u, k : byte;
Begin
    For u := 1 to n do
        For k := 1 to p do d[u, k] := - maxc;
End;

Procedure Visit(u : byte);
Var v, i, j : byte;
Begin
    d[u, 1] := c[u];
    For v := 1 to n do
        If a[u, v] then
        Begin
            a[v, u] := false;
            Visit(v);
            For i := p downto 1 do
                For j := 1 to i - 1 do
                If d[u, i] < d[u, j] + d[v, i - j] then
                Begin
                    d[u, i] := d[u, j] + d[v, i - j];
                    trace[v, i] := i - j;
                End;
        End;
End;

Procedure Tracing(u, p : byte);
Var v : byte;
Begin
    For v := n downto 1 do
        If a[u, v] and (trace[v, p] > 0) then
        Begin
            tracing(v, trace[v, p]);
            dec(p, trace[v, p]);
        End;
    write(u, ' ');
End;

Procedure Solve;
Var vt, u : byte;
Begin
    Visit(1);
    vt := 1;
    For u := 2 to n do
        If d[u, p] > d[vt, p] then vt := u;
    Tracing(vt, p);
End;

BEGIN
    Enter;
    Init;
    Solve;
END.
