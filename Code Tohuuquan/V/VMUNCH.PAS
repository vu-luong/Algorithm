Program VMUNCH;
Const maxr = 100;
      maxc = 100;
      dx : array[1..4] of -1..1 = (0, -1, 0, 1);
      dy : array[1..4] of -1..1 = (-1, 0, 1, 0);
Var a : array[1..maxr, 1..maxc] of char;
    free : array[0..maxr + 1, 0..maxc + 1] of boolean;
    trace : array[1..maxr, 1..maxc, 1..2] of byte;
    r, c : byte;
    sx, sy, fx, fy : byte;

Procedure Enter;
Var i, j : byte;
Begin
    readln(r, c);
    fillchar(free, sizeof(free), false);
    For i := 1 to r do
    Begin
        For j := 1 to c do
        Begin
            read(a[i, j]);
            If a[i, j] = 'B' then
                Begin fx := i; fy := j; free[i, j] := true; End Else
            If a[i, j] = 'C' then
                Begin sx := i; sy := j; End Else
            If a[i, j] = '.' then free[i, j] := true;
        End;
        readln;
    End;
End;

Procedure Solve;
Var q : array[1..maxr * maxc, 1..2] of byte;
    first, last : word;
    ix, iy, u, v, i : byte;

 Procedure Push(i, j : byte);
 Begin
     inc(last);
     q[last, 1] := i;
     q[last, 2] := j;
 End;

 Procedure Pop(Var i, j : byte);
 Begin
     i := q[first, 1];
     j := q[first, 2];
     inc(first);
 End;

Begin
    first := 1;
    last := 0;
    Push(sx, sy);
    While first <= last do
    Begin
        Pop(ix, iy);
        For i := 1 to 4 do
        Begin
            u := ix + dx[i];
            v := iy + dy[i];
            If free[u, v] then
            Begin
                free[u, v] := false;
                trace[u, v, 1] := ix;
                trace[u, v, 2] := iy;
                If (u = fx) and (v = fy) then exit;
                Push(u, v);
            End;
        End;
    End;
End;

Procedure PrintResult;
Var count : word;
    u, v : byte;
Begin
    count := 0;
    Repeat
        inc(count);
        u := trace[fx, fy, 1];
        v := trace[fx, fy, 2];
        fx := u;
        fy := v;
    Until (fx = sx) and (fy = sy);
    writeln(count);
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.
