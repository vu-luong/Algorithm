Program MATCH2;
Const max = 200;
      maxc = 40001;
Var c : array[1..max, 1..max] of longint;
    fx, fy, d : array[1..max] of longint;
    mx, my, t, arg, q : array[1..max] of byte;
    n, start, finish, first, last : byte;

Procedure Enter;
Var i, j : byte;
Begin
    readln(n);
    For i := 1 to n do
        For j := 1 to n do c[i, j] := maxc;
    While not eof do readln(i, j, c[i, j]);
End;

Procedure Init;
Var i, j : byte;
Begin
    fillchar(mx, sizeof(mx), 0);
    fillchar(my, sizeof(my), 0);
    For i := 1 to n do
    Begin
        fx[i] := maxc;
        For j := 1 to n do
            If c[i, j] < fx[i] then fx[i] := c[i, j];
    End;
    For j := 1 to n do
    Begin
        fy[j] := maxc;
        For i := 1 to n do
            If c[i, j] - fx[i] < fy[j] then fy[j] := c[i, j] - fx[i];
    End;
End;

Function GetC(i, j : byte) : longint;
Begin
    exit(c[i, j] - fx[i] - fy[j]);
End;

Procedure InitBFS;
Var y : byte;
Begin
    first := 1;
    last := 1;
    q[1] := start;
    fillchar(t, sizeof(t), 0);
    For y := 1 to n do
    Begin
        d[y] := GetC(start, y);
        arg[y] := start;
    End;
    finish := 0;
End;

Procedure Push(v : byte);
Begin
    inc(last);
    q[last] := v;
End;

Function Pop : byte;
Begin
    Pop := q[first];
    inc(first);
End;

Procedure FindPath;
Var w : longint;
    i, j : byte;
Begin
    Repeat
        i := Pop;
        For j := 1 to n do
            If t[j] = 0 then
            Begin
                w := GetC(i, j);
                If w = 0 then
                Begin
                    t[j] := i;
                    If my[j] = 0 then
                    Begin
                        finish := j;
                        exit;
                    End;
                    Push(my[j]);
                End;
                If d[j] > w then
                Begin
                    d[j] := w;
                    arg[j] := i;
                End;
            End;
    Until first > last;
End;

Procedure AddX_SubY;
Var delta : longint;
    x, y : byte;
Begin
    delta := maxc;
    For y := 1 to n do
        If (t[y] = 0) and (d[y] < delta) then delta := d[y];
    inc(fx[start], delta);
    For y := 1 to n do
        If t[y] <> 0 then
            Begin
                x := my[y];
                inc(fx[x], delta);
                dec(fy[y], delta);
            End
        Else
            dec(d[y], delta);
    For y := 1 to n do
        If (t[y] = 0) and (d[y] = 0) then
        Begin
            t[y] := arg[y];
            If my[y] = 0 then
            Begin
                finish := y;
                exit;
            End;
            Push(my[y]);
        End;
End;

Procedure Enlarge;
Var x, next : byte;
Begin
    Repeat
        x := t[finish];
        next := mx[x];
        mx[x] := finish;
        my[finish] := x;
        finish := next;
    Until finish = 0;
End;

Procedure Solve;
Var x, y : byte;
Begin
    For x := 1 to n do
    Begin
        start := x;
        InitBFS;
        Repeat
            FindPath;
            If finish = 0 then AddX_SubY;
        Until finish <> 0;
        Enlarge;
    End;
End;

Procedure PrintResult;
Var x, y : byte;
    w : longint;
Begin
    w := 0;
    For x := 1 to n do
    Begin
        y := mx[x];
        If c[x, y] < maxc then inc(w, c[x, y]);
    End;
    writeln(w);
    For x := 1 to n do
    Begin
        y := mx[x];
        If c[x, y] < maxc then writeln(x, ' ', y);
    End;
End;

BEGIN
    Enter;
    Init;
    Solve;
    PrintResult;
END.
