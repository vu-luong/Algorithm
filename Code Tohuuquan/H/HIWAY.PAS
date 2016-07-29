{$MODE OBJFPC}
Program HIWAY;
Const maxn = 100;
      maxc = maxlongint;
Var c : array[1..maxn, 1..maxn] of integer;
    d, trace : array[1..maxn] of integer;
    n, m, s, f, res : integer;

Procedure Enter;
Var i, u, v : integer;
Begin
    readln(n, m);
    readln(s, f);
    For u := 1 to n do
        For v := 1 to n do
        If u = v then c[u, v] := 0 else c[u, v] := maxc;
    For i := 1 to m do
    Begin
        readln(u, v, c[u, v]);
        c[v, u] := c[u, v];
    End;
End;

Procedure Init;
Var i : integer;
Begin
    For i := 1 to n do d[i] := maxc;
    d[s] := 0;
End;

Procedure Dijkstra;
Var free : array[1..maxn] of boolean;
    u, v, min : integer;
Begin
    Init;
    fillchar(free, sizeof(free), true);
    Repeat
        u := 0;
        min := maxc;
        For v := 1 to n do
            If free[v] and (d[v] < min) then
            Begin
                u := v;
                min := d[v];
            End;
        If (u = 0) or (u = f) then break;
        free[u] := false;
        For v := 1 to n do
            If free[v] and (d[v] - c[u, v] > d[u]) then
            Begin
                d[v] := d[u] + c[u, v];
                trace[v] := u;
            End;
    Until false;

    If d[f] = maxc then
    Begin
        write(-1);
        halt;
    End;

    res := d[f];
    u := f;
    While u <> s do
    Begin
        v := trace[u];
        c[v, u] := maxc;
        c[u, v] := - c[u, v];
        u := v;
    End;
End;

Procedure FolkBellman;
Var counter, u, v : integer;
    stop : boolean;
Begin
    Init;
    For counter := 1 to n - 1 do
    Begin
        stop := true;
        For u := 1 to n do
            For v := 1 to n do
                If d[v] - c[u, v] > d[u] then
                Begin
                    d[v] := d[u] + c[u, v];
                    trace[v] := u;
                    stop := false;
                End;
        If stop then break;
    End;

    If d[f] = maxc then
    Begin
        write(-1);
        halt;
    End;

    inc(res, d[f]);
    u := f;
    While u <> s do
    Begin
        v := trace[u];
        c[v, u] := maxc;
        u := v;
    End;
End;

Procedure PrintResult;
Var i, u, v, count : integer;
Begin
    For u := 1 to n do
        For v := 1 to n do
            If (c[u, v] > 0) and (c[u, v] = c[v, u]) then
            Begin
                c[u, v] := maxc;
                c[v, u] := maxc;
            End;

    writeln(res);
    For u := 1 to n do
        If (u <> s) and (c[u, s] <> maxc) then
        Begin
            v := u;
            count := 2;
            d[1] := s;
            d[2] := v;
            While v <> f do
                For i := 1 to n do
                    If (i <> v) and (c[i, v] <> maxc) then
                    Begin
                        inc(count);
                        d[count] := i;
                        v := i;
                        break;
                    End;
            write(count, ' ');
            For i := 1 to count do write(d[i], ' ');
            writeln;
        End;
End;

BEGIN
    Enter;
    Dijkstra;
    FolkBellman;
    PrintResult;
END.
