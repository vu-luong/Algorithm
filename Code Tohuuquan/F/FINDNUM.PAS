Program FINDNUM;
Const Prime : array[0..9] of byte =
       (2, 3, 5, 7, 11, 13, 17, 19, 23, 29);
Var a : array[0..10] of cardinal;
    n : cardinal;
    res : qword;

Function Power(a, n : cardinal) : qword;
Var p, t : qword;
Begin
    t := a; p := 1;
    While n > 0 do
    Begin
        If n mod 2 = 1 then p := p * t;
        t := t * t;
        n := n div 2;
    End;
    exit(p);
End;

Procedure Check(m : cardinal);
Var i : cardinal;
    k : qword;
Begin
    k := 1;
    For i := m downto 1 do
    Begin
        If a[i] > trunc(ln(1e18) / ln(prime[m - i])) then exit;
        k := k * Power(prime[m - i], a[i] - 1);
    End;
    If k < res then res := k;
End;

Procedure Solve(n, i : cardinal);
Var j : cardinal;
Begin
    For j := a[i - 1] to n do
        If n mod j = 0 then
        Begin
            a[i] := j;
            If j = n then Check(i)
            else Solve(n div j, i + 1);
        End;
End;

BEGIN
    read(n);
    res := 100000000000000000;
    a[0] := 2;
    If n > 1 then Solve(n, 1) else res := 1;
    write(res);
END.
