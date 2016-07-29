{$MODE OBJFPC}
Program NKFLOW;
Const maxn = 1000;
      maxm = (maxn - 1) * (maxn div 2);
      maxc = 1000000;
Type TEdge = Record
      x, y : longint;
      c, f : longint;
     End;
     TQueue = Record
      items : array[0..maxn - 1] of longint;
      front, rear, nItems : longint;
     End;
Var e : array[-maxm..maxm] of TEdge;
    link : array[-maxm..maxm] of longint;
    head, current, excess, h : array[1..maxn] of longint;
    count : array[0..2 * maxn - 1] of longint;
    queue : TQueue;
    n, m, s, t, FlowValue : longint;

Procedure Enter;
Var i, u, v, capacity : longint;
Begin
    readln(n, m, s, t);
    fillchar(head, sizeof(head), 0);
    For i := 1 to m do
    Begin
        readln(u, v, capacity);
        With e[i] do
        Begin
            x := u;
            y := v;
            c := capacity;
            link[i] := head[u];
            head[u] := i;
        End;
        With e[-i] do
        Begin
            x := v;
            y := u;
            c := 0;
            link[-i] := head[v];
            head[v] := -i;
        End;
    End;
    For v := 1 to n do current[v] := head[v];
End;

Procedure PushToQueue(v : longint);
Begin
    With Queue do
    Begin
        rear := (rear + 1) mod maxn;
        items[rear] := v;
        inc(nItems);
    End;
End;

Function PopFromQueue : longint;
Begin
    With Queue do
    Begin
        Result := items[front];
        front := (front + 1) mod maxn;
        dec(nItems);
    End;
End;

Procedure Init;
Var v, sf, i : longint;
Begin
    For i := -m to m do e[i].f := 0;
    fillchar(excess, sizeof(excess), 0);
    i := head[s];
    While i <> 0 do
    Begin
        sf := e[i].c;
        e[i].f := sf;
        e[-i].f := -sf;
        inc(excess[e[i].y], sf);
        dec(excess[s], sf);
        i := link[i];
    End;

    For v := 1 to n do h[v] := 1;
    h[s] := n;
    h[t] := 0;

    fillchar(count, sizeof(count), 0);
    count[n] := 1;
    count[0] := 1;
    count[1] := n - 2;

    queue.front := 0;
    queue.rear := -1;
    queue.nItems := 0;
    For v := 1 to n do
        If (v <> s) and (v <> t) and (excess[v] > 0) then PushToQueue(v);
End;

Procedure Push(i : longint);
Var delta : longint;
Begin
    With e[i] do
        If excess[x] < c - f then delta := excess[x] else delta := c - f;
    inc(e[i].f, delta);
    dec(e[-i].f, delta);
    With e[i] do
    Begin
        dec(excess[x], delta);
        inc(excess[y], delta);
    End;
End;

Procedure SetH(u, NewH : longint);
Begin
    dec(count[h[u]]);
    h[u] := NewH;
    inc(count[NewH]);
End;

Procedure PerformGapHeuristic(gap : longint);
Var v : longint;
Begin
    If (0 < gap) and (gap < n) and (count[gap] = 0) then
        For v := 1 to n do
            If (v <> s) and (gap < h[v]) and (h[v] <= n) then
            Begin
                SetH(v, n + 1);
                current[v] := head[v];
            End;
End;

Procedure Lift(u : longint);
Var minH, oldH, i : longint;
Begin
    minH := 2 * maxn;
    i := head[u];
    While i <> 0 do
    Begin
        With e[i] do
            If (c > f) and (h[y] < minH) then minH := h[y];
        i := link[i];
    End;
    oldH := h[u];
    SetH(u, minH + 1);
    PerformGapHeuristic(oldH);
End;

Procedure FIFOPreflowPush;
Var needqueue : boolean;
    z : longint;
Begin
    While queue.nItems > 0 do
    Begin
        z := PopFromQueue;
        While current[z] <> 0 do
        Begin
            With e[current[z]] do
            Begin
                If (c > f) and (h[x] > h[y]) then
                Begin
                    needqueue := (y <> s) and (y <> t) and (excess[y] = 0);
                    Push(current[z]);
                    If needqueue then PushToQueue(y);
                    If excess[z] = 0 then break;
                End;
            End;
            current[z] := link[current[z]];
        End;
        If excess[z] > 0 then
        Begin
            Lift(z);
            current[z] := head[z];
            PushToQueue(z);
        End;
    End;
    FlowValue := excess[t];
End;

Procedure PrintResult;
Begin
    writeln(FlowValue);
End;

BEGIN
    Enter;
    Init;
    FIFOPreflowPush;
    PrintResult;
END.
