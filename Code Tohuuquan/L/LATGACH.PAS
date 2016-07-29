Program LATGACH;
Const maxn = 100;
Var f : array[1..maxn] of string;
    n : byte;

Function Add(a, b : string) : string;
Var res : string;
    i, s, carry : byte;
Begin
    While length(a) < length(b) do a := '0' + a;
    While length(a) > length(b) do b := '0' + b;
    res := '';
    carry := 0;
    For i := length(a) downto 1 do
    Begin
        s := ord(a[i]) + ord(b[i]) + carry - 96;
        carry := s div 10;
        res := chr(s mod 10 + 48) + res;
    End;
    If carry > 0 then res := '1' + res;
    exit(res);
End;

Procedure Init;
Var i : byte;
Begin
    f[1] := '1';
    f[2] := '2';
    For i := 3 to maxn do
        f[i] := Add(f[i - 1], f[i - 2]);
End;

BEGIN
    Init;
    readln(n);
    While not eof do
    Begin
        readln(n);
        writeln(f[n]);
    End;
END.
