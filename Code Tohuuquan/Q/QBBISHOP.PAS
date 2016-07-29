Program QBBISHOP;
Const maxn = 200;
      dx : array[1..4] of -1..1 = (-1, -1, 1, 1);
      dy : array[1..4] of -1..1 = (-1, 1, 1, -1);
Var a : array[0..maxn + 1, 0..maxn + 1] of byte;
    h : array[0..maxn + 1, 0..maxn + 1] of word;
    qX, qY : array[1..maxn * maxn] of byte;
    n, m, p, q, s, t : byte;
    first, last : longint;

Procedure Enter;
Var i, x, y : byte;
Begin
    readln(n, m, p, q, s, t);
    For i := 1 to m do
    Begin
        readln(x, y);
        a[x, y] := 2;
    End;
End;

Procedure Init;
Var i : byte;
Begin
    For i := 0 to n + 1 do
    Begin
        a[0, i] := 3;
        a[i, 0] := 3;
        a[n + 1, i] := 3;
        a[i, n + 1] := 3;
    End;
    first := 1;
    last := 0;
End;

Procedure PrintResult;
Var i, j : byte;
Begin
    writeln(h[s, t]);
    halt;
End;

Procedure Push(x, y : byte);
Begin
    inc(last);
    qX[last] := x;
    qY[last] := y;
End;

Procedure Pop(Var x, y : byte);
Begin
    x := qX[first];
    y := qY[first];
    inc(first);
End;

Procedure Go(u, v, k : byte);
Var x, y : byte;
Begin
    x := u;
    y := v;
    a[x, y] := 1;
    While a[x, y] <> 3 do
    Begin
        If (h[x, y] = 0) and (a[x, y] = 0) then
        Begin
            h[x, y] := h[u, v] + 1;
            a[x, y] := 1;
            Push(x, y);
        End;
        If a[x, y] = 2 then exit;
        If (x = s) and (y = t) then PrintResult;
        x := x + dx[k];
        y := y + dy[k];
    End;
End;

Procedure Solve;
Var i : byte;
Begin
    Push(p, q);
    While first <= last do
    Begin
        Pop(p, q);
        For i := 1 to 4 do Go(p, q, i);
    End;
    If h[s, t] = 0 then writeln(-1);
End;

BEGIN
    Enter;
    Init;
    Solve;
END.
