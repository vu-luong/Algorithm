Program SPSEQ;
Const maxn = 100000;
Type Arr = array[1..maxn] of longint;
Var a, f1, f2 : Arr;
    n, res : longint;

Procedure Enter;
Var i : longint;
Begin
    readln(n);
    For i := 1 to n do read(a[i]);
End;

Procedure Init;
Var l : Arr;
    i, d, x, y, t : longint;
Begin
    d := 1; l[d] := 1; f1[1] := 1;
    For i := 2 to n do
        If a[i] < a[l[1]] then
            Begin l[1] := i; f1[i] := 1; End
        Else If a[i] > a[l[d]] then
            Begin inc(d); l[d] := i; f1[i] := d; End
        Else
            Begin
                x := 1; y := d;
                While x < y do
                Begin
                    t := (x + y) shr 1;
                    If a[i] > a[l[t]] then x := t + 1 else y := t;
                End;
                l[x] := i; f1[i] := x;
            End;

    d := 1; l[d] := n; f2[n] := 1;
    For i := n - 1 downto 1 do
        If a[i] < a[l[1]] then
            Begin l[1] := i; f2[i] := 1; End
        Else If a[i] > a[l[d]] then
            Begin inc(d); l[d] := i; f2[i] := d; End
        Else
            Begin
                x := 1; y := d;
                While x < y do
                Begin
                    t := (x + y) shr 1;
                    If a[i] > a[l[t]] then x := t + 1 else y := t;
                End;
                l[x] := i; f2[i] := x;
            End;
End;

Procedure Solve;
Var i, t : longint;
Begin
    For i := 1 to n do
    Begin
        If f1[i] < f2[i] then t := f1[i] else t := f2[i];
        If res < t then res := t;
    End;
    writeln((res - 1) shl 1 + 1);
End;

BEGIN
    Enter;
    Init;
    Solve;
END.