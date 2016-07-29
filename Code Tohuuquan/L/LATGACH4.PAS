{$MODE OBJFPC}
Program LATGACH4;
Const max = 1000000;
      BASE = 111539786;
Var f : array[1..max] of int64;
    t : byte;
    x : integer;

Procedure Init;
Var i : integer;
Begin
    f[1] := 1;
    f[2] := 1;
    For i := 3 to max do f[i] := (f[i - 1] + f[i - 2]) mod BASE;
End;

Function Cal(x : integer) : int64;
Var n : integer;
Begin
    If x <= max then exit(f[x]);
    If odd(x) then
        Begin
            n := (x + 1) shr 1;
            Cal := ((sqr(Cal(n)) mod BASE) + (sqr(Cal(n - 1)) mod BASE)) mod BASE;
        End
    Else
        Begin
            n := x shr 1;
            Cal := (((Cal(n - 1) shl 1 + Cal(n)) mod BASE) * Cal(n)) mod BASE;
        End;
End;

BEGIN
    Init;
    readln(t);
    While t > 0 do
    Begin
        readln(x);
        writeln(Cal(x + 1));
        dec(t);
    End;
END.