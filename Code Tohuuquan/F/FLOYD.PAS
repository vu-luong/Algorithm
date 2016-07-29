Program FLOYD;
Const maxn = 100;
      maxm = (maxn - 1) * (maxn div 2);
      maxc = 10000 * maxm + 1;
Var a : array[1..maxn, 1..maxn] of longint;
    trace : array[1..maxn, 1..maxn] of byte;
    n : byte;
    m, k : word;

Procedure Enter;
Var i : word;
    u, v : byte;
Begin
    readln(n, m, k);
    For u := 1 to n do
        For v := 1 to n do
            If u = v then a[u, v] := 0 else a[u, v] := maxc;
    For i := 1 to m do
    Begin
        readln(u, v, a[u, v]);
        a[v, u] := a[u, v];
    End;
End;

Procedure Floyd;
Var u, v, k : byte;
Begin
    For u := 1 to n do
        For v := 1 to n do trace[u, v] := v;
    For k := 1 to n do
        For u := 1 to n do
            For v := 1 to n do
                If a[u, v] > a[u, k] + a[k, v] then
                Begin
                    a[u, v] := a[u, k] + a[k, v];
                    trace[u, v] := trace[u, k];
                End;
End;

Procedure PrintResult;
Var res : array[1..maxn] of byte;
    count : byte;
    i : word;
    x, u, v : byte;
Begin
    For i := 1 to k do
    Begin
        readln(x, u, v);
        If x = 0 then writeln(a[u, v]) else
        Begin
            count := 1;
            res[count] := u;
            While u <> v do
            Begin
                u := trace[u, v];
                inc(count);
                res[count] := u;
            End;
            write(count, ' ');
            For u := 1 to count do write(res[u], ' ');
            writeln;
        End;
    End;
End;


BEGIN
    Enter;
    Floyd;
    PrintResult;
END.
