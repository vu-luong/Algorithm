Program SUPERSUM;
Const BASE = 1000000007;
Var n : int64;
    k : byte;
    st : string;

Function modPow(a, x, p : int64) : int64;
Var res : int64;
Begin
    res := 1;
    While x > 0 do
    Begin
        If x mod 2 <> 0 then res := (res * a) mod p;
        a := (a * a) mod p;
        x := x div 2;
    End;
    exit(res);
End;

Function modInverse(a, p : int64) : int64;
Begin
    exit(modPow(a, p - 2, p));
End;

Function modBinomial(n, k, p : int64) : int64;
Var numerator, denominator : int64;
    i : byte;
Begin
    numerator := 1;
    For i := 0 to k - 1 do
        numerator := (numerator * (n - i)) mod p;
    denominator := 1;
    For i := 1 to k do
        denominator := (denominator * i) mod p;
    exit((numerator * modInverse(denominator, p)) mod p);
End;

BEGIN
    While not eof do
    Begin
        Repeat readln(st) Until (st = '[CASE]') or (st = '[END]');
        If st = '[END]' then break;
        readln(k);
        readln(n);
        writeln(modBinomial(n + k, k + 1, BASE));
    End;
END.