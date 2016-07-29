{$MODE OBJFPC}
Program MYSTERY;
Const R = 20122007;
      BASE = 3;
      max = 84420;
Var pow : array[0..max] of integer;
    a : integer;
    res : int64;

Procedure Enter;
Begin
    readln(a);
End;

Procedure Solve;
Var i, t : integer;
Begin
    pow[0] := 1;
    For i := 1 to max do
        pow[i] := (pow[i - 1] * BASE) mod R;

    res := 1;
    For i := 1 to trunc(sqrt(a)) do
        If a mod i = 0 then
        Begin
            res := (res * (pow[i mod max] - 1)) mod R;
            t := a div i;
            If t <> i then
                res := (res * (pow[t mod max] - 1)) mod R;
        End;
    writeln(res);
End;

BEGIN
    Enter;
    Solve;
END.