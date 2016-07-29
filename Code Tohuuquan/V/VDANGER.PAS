Program VDANGER;
Const maxn = 100;
      maxm = 10000;
Var c : array[1..maxn, 1..maxn] of longint;
    a : array[1..maxm] of byte;
    n : byte;
    m : word;
    res : longint;

Procedure Enter;
Var i : word;
    u, v : byte;
Begin
    readln(n, m);
    For i := 1 to m do readln(a[i]);
    For u := 1 to n do
        For v := 1 to n do read(c[u, v]);
End;

Procedure Floyd;
Var k, u, v : byte;
Begin
    For k := 1 to n do
        For u := 1 to n do
            For v := 1 to n do
                If c[u, v] > c[u, k] + c[k, v] then
                Begin
                    c[u, v] := c[u, k] + c[k, v];
                End;
End;

Procedure Solve;
Var i : word;
Begin
    res := 0;
    For i := 1 to m - 1 do inc(res, c[a[i], a[i + 1]]);
End;

Procedure PrintResult;
Begin
    writeln(res);
End;

BEGIN
    Enter;
    Floyd;
    Solve;
    PrintResult;
END.
