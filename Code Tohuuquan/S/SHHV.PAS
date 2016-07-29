Program SHHV;
Const maxn = 12;
Var a, b : array[1..maxn] of byte;
    f : array[0..maxn] of longint;
    avail : array[1..maxn] of boolean;
    n, m : byte;
    p : longint;

Procedure Enter;
Begin
    n := 0;
    fillchar(a, sizeof(a), 0);
    While not seekeoln do
    Begin
        inc(n);
        read(a[n]);
    End;
    readln(p);
End;

Procedure Init;
Var i, j : byte;
    t : longint;
Begin
    t := 1;
    j := 0;
    fillchar(f, sizeof(f), 0);
    For i := 2 to m - 1 do t := t * i;
    For i := 1 to n do
        If avail[i] then
        Begin
            inc(j);
            f[i] := t * j;
        End Else f[i] := f[i - 1];
End;

Procedure PartA;
Var i, j : byte;
    q : longint;
Begin
    q := 0;
    m := n;
    fillchar(avail, sizeof(avail), true);
    For i := 1 to n do
    Begin
        Init;
        inc(q, f[a[i] - 1]);
        avail[a[i]] := false;
        dec(m);
    End;
    writeln(q + 1);
End;

Procedure PartB;
Var i, j : byte;
Begin
    m := n;
    dec(p);
    fillchar(avail, sizeof(avail), true);
    For i := 1 to n do
    Begin
        Init;
        j := 0;
        While f[j] <= p do inc(j);
        dec(j);
        dec(p, f[j]);
        b[i] := j + 1;
        avail[j + 1] := false;
        dec(m);
    End;
    For i := 1 to n do write(b[i],' ');
End;

BEGIN
    Enter;
    PartA;
    PartB;
END.