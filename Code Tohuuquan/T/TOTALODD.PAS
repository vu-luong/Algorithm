Program TOTALODD;
Const maxn = 488281;
      max = 100000000;
      p : array[1..8] of longint = (5, 30, 155, 780, 3905, 19530, 97655, 488280);
      oddnum : array[1..5] of byte = (1, 3, 5, 7, 9);
Var a : array[0..maxn] of longint;
    n, x : longint;
    st : string;

Procedure Init;
Var tail, nw : longint;
    i : byte;
Begin
    n := 1;
    tail := 0;
    a[0] := 0;
    While n < maxn do
    Begin
        For i := 1 to 5 do
        Begin
            nw := a[tail] * 10 + oddnum[i];
            a[n] := nw;
            inc(n);
        End;
        inc(tail);
    End;
End;

Function Min(x, y : longint) : longint;
Begin
    If x < y then exit(x) else exit(y);
End;

Procedure Find(x : longint);
Var i, j, res, t, top : longint;
Begin
    i := 0;
    t := 1;
    Repeat
        inc(i);
        t := t * 10;
    Until x <= t;
    top := p[i];
    i := 1;
    j := top;
    res := max;
    While (i <= top) and (j >= 1) do
        If a[i] + a[j] >= x then
        Begin
            res := Min(res, a[i] + a[j]);
            dec(j);
        End Else inc(i);
    writeln(res);
End;

BEGIN
    Init;
    While not eof do
    Begin
        Repeat readln(st) Until (st = '[CASE]') or (st = '[END]');
        If st = '[END]' then break;
        If st = '[CASE]' then
        Begin
            readln(x);
            Find(x);
        End;
    End;
END.
