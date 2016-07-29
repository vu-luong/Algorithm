Program FWATER;
Const maxn = 301;
      maxp = 100001;
Var p : array[1..maxn, 1..maxn] of longint;
    d : array[1..maxn] of longint;
    trace : array[1..maxn] of word;
    free : array[1..maxn] of boolean;
    n : word;

Procedure Enter;
Var u, v : word;
Begin
    readln(n);
    inc(n);
    For v := 1 to n - 1 do
    Begin
        readln(p[n, v]);
        p[v, n] := p[n, v];
    End;
    For u := 1 to n - 1 do
        For v := 1 to n - 1 do read(p[u, v]);
End;

Procedure Init;
Var v : word;
Begin
    d[1] := 0;
    For v := 2 to n do d[v] := maxp;
    fillchar(free, sizeof(free), true);
End;

Procedure Solve;
Var i, k, u, v : word;
    min : longint;
Begin
    For k := 1 to n do
    Begin
        u := 0;
        min := maxp;
        For i := 1 to n do
            If free[i] and (d[i] < min) then
            Begin
                min := d[i];
                u := i;
            End;
        If u = 0 then exit;
        free[u] := false;
        For v := 1 to n do
            If free[v] and (d[v] > p[u, v]) then
            Begin
                d[v] := p[u, v];
                trace[v] := u;
            End;
    End;
End;

Procedure PrintResult;
Var v : word;
    res : longint;
Begin
    res := 0;
    For v := 2 to n do inc(res, p[trace[v], v]);
    writeln(res);
End;

BEGIN
    Enter;
    Init;
    Solve;
    PrintResult;
END.