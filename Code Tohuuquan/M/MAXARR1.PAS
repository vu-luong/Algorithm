Program MAXARR1;
Const maxn = 100000;
Var a, b : array[0..maxn] of word;
    t, n : longint;

Procedure Init;
Var i : longint;
Begin
    a[0] := 0;
    a[1] := 1;
    b[0] := 0;
    b[1] := 1;
    For i := 2 to maxn do
        If i mod 2 = 0 then
            Begin
                a[i] := a[i div 2];
                b[i] := b[i - 1];
            End
        Else
            Begin
                a[i] := a[i div 2] + a[(i div 2) + 1];
                b[i] := b[i - 1];
                If a[i] > b[i] then b[i] := a[i];
            End;
End;

BEGIN
    Init;
    readln(t);
    While t > 0 do
    Begin
        readln(n);
        writeln(b[n]);
        dec(t);
    End;
END.
