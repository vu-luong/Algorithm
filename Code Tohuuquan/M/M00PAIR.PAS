Program M00PAIR;
Const maxn = 1000;
Var a : array[1..maxn] of ansistring;
    n : word;

Function Add(a, b : ansistring) : ansistring;
Var i, s, cr : integer;
    res : ansistring;
Begin
    While length(a) < length(b) do a := '0' + a;
    While length(a) > length(b) do b := '0' + b;
    res := '';
    cr := 0;
    For i := length(a) downto 1 do
    Begin
        s := ord(a[i]) + ord(b[i]) + cr - 96;
        cr := s div 10;
        res := chr(s mod 10 + 48) + res;
    End;
    If cr > 0 then res := '1' + res;
    exit(res);
End;

Procedure Init;
Var i : word;
Begin
    a[1] := '0';
    a[2] := '1';
    For i := 3 to maxn do a[i] := Add(Add(a[i - 2], a[i - 2]), a[i - 1]);
End;

BEGIN
    Init;
    While not eof do
    Begin
        readln(n);
        writeln(a[n]);
    End;
END.