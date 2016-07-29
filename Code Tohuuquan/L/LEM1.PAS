Program LEM1;
Uses Math;
Const maxn = 10000;
      maxr = 10000000;
      epxilon = 0.0000000001;
Var r : array[1..maxn + 1] of double;
    n : word;

Procedure Enter;
Var i : word;
Begin
    readln(n);
    For i := 1 to n do read(r[i]);
    r[n + 1] := r[1];
End;

Function F(a, b, c : double) : double;
Begin
    exit(arccos((sqr(b) + sqr(c) - sqr(a)) / (2 * b * c)));
End;

Procedure Solve;
Var low, high, mid, s : double;
    i : word;
Begin
    low := 0;
    high := maxr;
    While abs(high - low) >= epxilon do
    Begin
        mid := (low + high) / 2;
        s := 0;
        For i := 1 to n do
            s := s + F(r[i] + r[i + 1], mid + r[i], mid + r[i + 1]);
        If abs(s - 2 * PI) <= epxilon then break;
        If s < 2 * PI then high := mid else low := mid;
    End;
    writeln(mid : 0 : 3);
End;

BEGIN
    Enter;
    Solve;
END.