Program POWER;
Const max = 39;
Var n : longint;
    left, right : int64;

Function Power(x, k : longint) : int64;
Var u : longint;
Begin
    If k = 0 then exit(1) else
    Begin
        u := k shr 1;
        If k mod 2 = 1 then exit(sqr(Power(x, u)) * x)
        else exit(sqr(Power(x, u)));
    End;
End;

Procedure Solve;
Var p, i : longint;
    x : int64;
Begin
    For i := max downto 2 do
    Begin
        p := trunc(exp(ln(right) / i));
        x := Power(p, i);
        If left <= x then
        Begin
            writeln(i);
            exit;
        End;
    End;
    writeln(1);
End;

BEGIN
    readln(n);
    n := 0;
    While not eof do
    Begin
        inc(n);
        readln(left, right);
        write('Case #', n, ': ');
        Solve;
    End;
END.