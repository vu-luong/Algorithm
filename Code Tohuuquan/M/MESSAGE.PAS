Program MESSAGE;
Const maxn = 800;
      maxm = (maxn - 1) * (maxn div 2);
Type TEdge = Record x, y : word End;
Var e : array[1..maxm] of TEdge;
    link : array[1..maxm] of longint;
    head : array[1..maxn] of longint;
    low, num, stack, group : array[1..maxn] of word;
    n, last, count, SCC, res : word;
    m : longint;

Procedure Enter;
Var i : longint;
    u, v : word;
Begin
    readln(n, m);
    fillchar(head[1], n * sizeof(head[1]), 0);
    For i := 1 to m do
    Begin
        readln(u, v);
        With e[i] do
        Begin
            x := u;
            y := v;
        End;
        link[i] := head[u];
        head[u] := i;
    End;
End;

Procedure Init;
Begin
    fillchar(num[1], n * sizeof(num[1]), 0);
    fillchar(group[1], n * sizeof(group[1]), 0);
    count := 0;
    SCC := 0;
    last := 0;
End;

Procedure Push(u : word);
Begin
    inc(last);
    stack[last] := u;
End;

Function Pop : word;
Begin
    Pop := stack[last];
    dec(last);
End;

Function Min(x, y : word) : word;
Begin
    If x < y then exit(x) else exit(y);
End;

Procedure DFSVisit(u : word);
Var i : longint;
    v : word;
Begin
    inc(count);
    num[u] := count;
    low[u] := maxn + 1;
    Push(u);
    i := head[u];
    While i <> 0 do
    Begin
        v := e[i].y;
        If group[v] = 0 then
            If num[v] = 0 then
                Begin
                    DFSVisit(v);
                    low[u] := Min(low[u], low[v]);
                End
            Else
                low[u] := Min(low[u], num[v]);
        i := link[i];
    End;
    If low[u] >= num[u] then
    Begin
        inc(SCC);
        Repeat
            v := Pop;
            group[v] := SCC;
        Until v = u;
    End;
End;

Procedure Solve;
Var choose : array[1..maxn] of boolean;
    i : longint;
Begin
    For i := 1 to n do
        If num[i] = 0 then DFSVisit(i);
    fillchar(choose[1], SCC * sizeof(choose[1]), true);
    For i := 1 to m do
        With e[i] do
            If group[x] <> group[y] then choose[group[y]] := false;
    res := 0;
    For i := 1 to SCC do
        If choose[i] then inc(res);
End;

Procedure PrintResult;
Begin
    writeln(res);
End;

BEGIN
    Enter;
    Init;
    Solve;
    PrintResult;
END.