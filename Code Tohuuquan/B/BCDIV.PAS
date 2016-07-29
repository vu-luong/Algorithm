Program BCDIV;
Const maxn = 25;
      maxk = 25;
      BASE = 1000000000;
      DIGIT = 9;
      MAXD = 10;
Type Bigint = array[1..MAXD] of int64;
Var a : array[0..maxn + 1, 0..maxk + 1] of Bigint;
    n, k : byte;
    t : longint;

Operator + (a, b : Bigint) c : Bigint;
Var i : byte;
    cr : int64;
Begin
    fillchar(c, sizeof(c), 0);
    cr := 0;
    For i := MAXD downto 1 do
    Begin
        c[i] := a[i] + b[i] + cr;
        If c[i] >= BASE then
        Begin
            c[i] := c[i] - BASE;
            cr := 1;
        End Else cr := 0;
    End;
End;

Operator * (a : longint; b : bigint) c : bigint;
Var i, j : byte;
    k, cr : int64;
Begin
    fillchar(c,sizeof(c),0);
    cr := 0;
    For i := MAXD downto 1 do
    Begin
        c[i] := a * b[i] + cr;
        cr := c[i] div BASE;
        c[i] := c[i] mod BASE;
    End;
End;

Function toString(a : bigint): string;
Var i: byte;
    s, q : string;
Begin
    For i := 1 to MAXD do
        If a[i] <> 0 then break;
    If a[i] = 0 then exit('0');
    str(a[i], q);
    s := q;
    For i := i + 1 to MAXD do
    Begin
        str(a[i], q);
        While (length(q) < DIGIT) do q := '0' + q;
        s := s + q;
    End;
    exit(s);
End;

Procedure Init;
Var i, j : byte;
Begin
    a[1, 1][MAXD] := 1;
    For i := 2 to maxn do
        For j := 1 to i do
            a[i, j] := a[i - 1, j - 1] + j * a[i - 1, j];
End;

BEGIN
    Init;
    readln(t);
    While t > 0 do
    Begin
        readln(n, k);
        writeln(toString(a[n, k]));
        dec(t);
    End;
END.