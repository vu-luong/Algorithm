Program TJALG;
Const maxn = 10000;
      maxm = 100000;
Type TStack = record
      items : array[1..maxn] of word;
      top : word;
     End;
     TEdge = record
      x, y : word;
     End;
Var e : array[1..maxm] of TEdge;
    link : array[1..maxm] of longint;
    head : array[1..maxn] of longint;
    avail : array[1..maxn] of boolean;
    number, low : array[1..maxn] of word;
    stack : TStack;
    n, count, SCC : word;

Procedure Enter;
Var i, m : longint;
    x, y : word;
Begin
    readln(n, m);
    For i := 1 to m do
        With e[i] do readln(x, y);
    fillchar(head[1], n * sizeof(head[1]), 0);
    For i := m downto 1 do
        With e[i] do
        Begin
            link[i] := head[x];
            head[x] := i;
        End;
End;

Procedure Init;
Begin
    fillchar(number, n * sizeof(number[1]), 0);
    fillchar(avail, n * sizeof(avail[1]), true);
    stack.top := 0;
    count := 0;
    SCC := 0;
End;

Procedure Push(v : word);
Begin
    With stack do
    Begin
        inc(top);
        items[top] := v;
    End;
End;

Function Pop : word;
Begin
    With stack do
    Begin
        Pop := items[top];
        dec(top);
    End;
End;

Procedure Minimize(Var target : word; value : word);
Begin
    If value < target then target := value;
End;

Procedure DFSVisit(u : word);
Var i : longint;
    v : word;
Begin
    inc(count);
    number[u] := count;
    low[u] := maxn + 1;
    Push(u);
    i := head[u];
    While i <> 0 do
    Begin
        v := e[i].y;
        If avail[v] then
            If number[v] <> 0 then
                Minimize(low[u], number[v])
            Else
                Begin
                    DFSVisit(v);
                    Minimize(low[u], low[v]);
                End;
        i := link[i];
    End;
    If low[u] >= number[u] then
    Begin
        inc(SCC);
        Repeat
            v := Pop;
            avail[v] := false;
        Until v = u;
    End;
End;

Procedure Tarjan;
Var v : word;
Begin
    For v := 1 to n do
        If avail[v] then DFSVisit(v);
End;

Procedure PrintResult;
Begin
    writeln(SCC);
End;

BEGIN
    Enter;
    Init;
    Tarjan;
    PrintResult;
END.