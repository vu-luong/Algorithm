Program CRUELL2;
Const maxd = 11;
      max = 1000000;
      delta = 0.0001;
Var a : array[0..maxd] of real;
    d : byte;

Procedure Enter;
Var i : byte;
Begin
    readln(d);
    For i := 0 to d do readln(a[i]);
End;

Function F(x : real) : real;
Var s, t : real;
    i : byte;
Begin
    s := a[0];
    t := 1;
    For i := 1 to d do
    Begin
        t := t * x;
        s := s + a[i] * t;
    End;
    exit(s);
End;

Procedure Solve;
Var low, high, mid, res : real;
    check : boolean;
Begin
    low := -max;
    high := max;
    check := F(low) > F(high);
    While low + delta < high do
    Begin
        mid := (low + high) / 2;
        res := F(mid);
        If Check then
            Begin
                If res < 0 then high := mid
                else low := mid;
            End
        Else
            Begin
                If res > 0 then high := mid
                else low := mid;
            End;
    End;
    writeln(trunc(mid * 1000));
End;

BEGIN
    Enter;
    Solve;
END.