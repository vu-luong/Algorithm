Program MLASERP;
Const maxh = 100;
      maxw = 100;
      dx : array[1..4] of -1..1 = (0, -1, 0, 1);
      dy : array[1..4] of -1..1 = (-1, 0, 1, 0);
Var a : array[0..maxh + 1, 0..maxw + 1] of byte;
    num : array[1..maxh, 1..maxw] of byte;
    queue : array[1..maxh * maxw, 1..2] of byte;
    h, w : byte;
    sX, sY, fX, fY : byte;
    first, last : word;

Procedure Enter;
Var i, j : byte;
    c : char;
Begin
    readln(w, h);
    For i := 1 to h do
    Begin
        For j := 1 to w do
        Begin
            read(c);
            Case c of
             'C' : If (sX = 0) and (sY = 0) then
                       Begin sX := i; sY := j; End
                   Else
                       Begin fX := i; fY := j; End;
             '*' : a[i, j] := 2;
            End;
        End;
        readln;
    End;
End;

Procedure Init;
Var i : byte;
Begin
    For i := 0 to h + 1 do
    Begin
        a[i, 0] := 3;
        a[i, w + 1] := 3;
    End;
    For i := 0 to w + 1 do
    Begin
        a[0, i] := 3;
        a[h + 1, i] := 3;
    End;
    first := 1;
    last := 0;
End;

Procedure Push(u, v : byte);
Begin
    inc(last);
    queue[last, 1] := u;
    queue[last, 2] := v;
End;

Procedure Pop(Var u, v : byte);
Begin
    u := queue[first, 1];
    v := queue[first, 2];
    inc(first);
End;

Procedure PrintResult;
Begin
    write(num[fX, fY] - 1);
    halt;
End;

Procedure Go(u, v, k : byte);
Var x, y : byte;
Begin
    x := u;
    y := v;
    a[x, y] := 1;
    While a[x, y] <> 3 do
    Begin
        If (num[x, y] = 0) and (a[x, y] = 0) then
        Begin
            num[x, y] := num[u, v] + 1;
            a[x, y] := 1;
            Push(x, y);
        End;
        If a[x, y] = 2 then exit;
        If (x = fX) and (y = fY) then PrintResult;
        x := x + dx[k];
        y := y + dy[k];
    End;
End;

Procedure Solve;
Var u, v, i : byte;
Begin
    Push(sX, sY);
    While first <= last do
    Begin
        Pop(u, v);
        For i := 1 to 4 do Go(u, v, i);
    End;
End;

BEGIN
    Enter;
    Init;
    Solve;
END.