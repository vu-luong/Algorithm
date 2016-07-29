Program NKGUARD;
Const maxn = 700;
      maxm = 700;
      dx : array[1..8] of -1..1 = (-1, -1, -1, 0, 0, 1, 1, 1);
      dy : array[1..8] of -1..1 = (-1, 0, 1, -1, 1, -1, 0, 1);
Var a : array[1..maxn, 1..maxm] of word;
    top, free : array[1..maxn, 1..maxm] of boolean;
    n, m, count : word;
    res : boolean;

Procedure Enter;
Var i, j : word;
Begin
    readln(n, m);
    For i := 1 to n do
        For j := 1 to m do read(a[i, j]);
End;

Function Check(x, y : word) : boolean;
Begin
    exit((1 <= x) and (x <= n) and (1 <= y) and (y <= m));
End;

Procedure Init;
Var i, j, u, v : word;
    k : byte;
Begin
    fillchar(top, sizeof(top), true);
    For i := 1 to n do
        For j := 1 to m do
            For k := 1 to 8 do
            Begin
                u := i + dx[k];
                v := j + dy[k];
                If Check(u, v) then
                Begin
                    If a[i, j] > a[u, v] then top[u, v] := false;
                    If a[i, j] < a[u, v] then top[i, j] := false;
                End;
            End;
End;

Procedure DFS(x, y : word);
Var u, v : word;
    i : byte;
Begin
    free[x, y] := false;
    For i := 1 to 8 do
    Begin
        u := x + dx[i];
        v := y + dy[i];
        If Check(u, v) and free[u, v] then
            If a[x, y] = a[u, v] then
            Begin
                res := res and top[u, v];
                DFS(u, v);
            End;
    End;
End;

Procedure Solve;
Var i, j : word;
Begin
    fillchar(free, sizeof(free), true);
    For i := 1 to n do
        For j := 1 to m do
            If top[i, j] and free[i, j] then
            Begin
                res := true;
                DFS(i, j);
                If res then inc(count);
            End;
End;

Procedure PrintResult;
Begin
    writeln(count);
End;

BEGIN
    Enter;
    Init;
    Solve;
    PrintResult;
END.