Program INTEGER7;
Var a1, b1, a2, b2, x1, x2 : int64;

Procedure Enter;
Begin
    readln(a1, b1, a2, b2);
End;

Function Euclid(m, n : int64) : int64;
Var r : int64;
Begin
    Repeat
        r := m mod n;
        m := n;
        n := r;
    Until n = 0;
    exit(m);
End;

Procedure Euclid2(m, n : int64; Var u, v : int64);
Var q, r : int64;
    xm, ym, xn, yn, xt, yt : int64;
Begin
    xm := 1; ym := 0;
    xn := 0; yn := 1;
    Repeat
        q := m div n;
        r := m mod n;
        m := n;
        n := r;
        xt := xm; yt := ym;
        xm := xn; ym := yn;
        xn := xt - q * xn;
        yn := yt - q * yn;
    Until n = 0;
    u := xm; v := ym;
End;

Procedure Solve;
Var d, b, y1, y2, k : int64;

 Function CalSum(k : int64) : int64;
 Var res : int64;
 Begin
     res := (y1 - y2) * b;
     res := res + k * (a1 div d);
     res := res + k * (a2 div d);
     exit(res);
 End;

 Function CalX(c : byte; k : int64) : int64;
 Begin
     If c = 1 then exit(y1 * b + k * a2 div d)
     else exit(-y2 * b + k * a1 div d);
 End;

Begin
    d := Euclid(a1, a2);
    b := (b2 - b1) div d;
    Euclid2(a1, a2, y1, y2);

    k := ((y2 - y1) * b * d) div (a1 + a2) - 2;
    While CalSum(k) < 0 do inc(k);
    x1 := CalX(1, k);
    x2 := CalX(2, k);
End;

Procedure PrintResult;
Begin
    writeln(x1, ' ', x2);
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.
