Program GPT;
Const max = 30;
Var t : byte;
    n : longint;

Function Prime(x : longint) : boolean;
Var i, sqrt_x : longint;
Begin
    If (x = 2) or (x = 3) then exit(true);
    If (x mod 2 = 0) or (x mod 3 = 0) then exit(false);
    sqrt_x := trunc(sqrt(x));
    i := -1;
    Repeat
        inc(i, 6);
        If (x mod i = 0) or (x mod (i + 2) = 0) then break;
    Until i > sqrt_x;
    exit(i > sqrt_x);
End;

Function Pow(a : integer; x : byte) : longint;
Var u : byte;
Begin
    If x = 1 then exit(a);
    u := x shr 1;
    If x mod 2 = 0 then exit(sqr(Pow(a, u)))
    else exit(sqr(Pow(a, u)) * a);
End;

Procedure Solve;
Var p, x : longint;
    i : byte;
Begin
    If Prime(n) then
    Begin
        writeln(n);
        exit;
    End;
    For i := max downto 2 do
    Begin
        p := trunc(exp(ln(n) / i));
        x := Pow(p, i);
        If (x = n) and Prime(p) then
        Begin
            writeln(p);
            exit;
        End;
    End;
    writeln(1);
End;

BEGIN
    readln(t);
    While t > 0 do
    Begin
        readln(n);
        Solve;
        dec(t);
    End;
END.