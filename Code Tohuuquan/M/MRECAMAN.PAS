Program MRECAMAN;
Const maxn = 3012500;
      maxk = 500000;
Var a : array[0..maxn] of boolean;
    f : array[0..maxk] of longint;
    k : longint;

Procedure Init;
Var m : longint;
Begin
    fillchar(a, sizeof(a), true);
    f[0] := 0;
    a[0] := false;
    For m := 1 to maxk do
    Begin
        f[m] := f[m - 1] - m;
        If f[m] <= 0 then inc(f[m], m shl 1) else
            If not a[f[m]] then inc(f[m], m shl 1);
        a[f[m]] := false;
    End;
End;

BEGIN
    Init;
    While not eof do
    Begin
        readln(k);
        If k <> -1 then writeln(f[k]);
    End;
END.
