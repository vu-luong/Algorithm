Program BIGNUM;
Const DIGIT = 4;
      BASE = 10000;
      MAXD = 600;
Type bigint = array[1..MAXD] of longint;
Var a, b : bigint;
    x, y, t : ansistring;
    plus : boolean;

Operator := (s : ansistring) a : bigint;
Var i, t : longint;
Begin
    fillchar(a, sizeof(a), 0);
    While length(s) mod 4 <> 0 do s := '0' + s;
    For i := MAXD downto 1 do
    Begin
        Val(copy(s, length(s) - 3, 4), a[i], t);
        delete(s, length(s) - 3, 4);
    End;
End;

Operator + (Var a, b : bigint) c : bigint;
Var i , cr : longint;
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

Operator - (Var a, b : bigint) c : bigint;
Var i, cr : longint;
Begin
    fillchar(c, sizeof(c), 0);
    cr := 0;
    For i := MAXD downto 1 do
    Begin
        c[i] := a[i] - b[i] - cr;
        If c[i] < 0 then
        Begin
            c[i] := c[i] + BASE;
            cr := 1;
        End Else cr := 0;
    End;
End;


Operator * (Var a, b : bigint) c : bigint;
Var i, j, k, cr : longint;
Begin
    fillchar(c, sizeof(c), 0);
    For i := MAXD downto 1 do
    Begin
        cr := 0;
        For j := MAXD downto 1 do
        If i + j > MAXD then
        Begin
            k := i + j - MAXD;
            c[k] := c[k] + a[i] * b[j] + cr;
            cr := c[k] div BASE;
            c[k] := c[k] mod BASE;
        End;
    End;
End;

Function toString(a : bigint): ansistring;
Var i: longint;
    s, q : ansistring;
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

Procedure Enter;
Begin
    readln(x);
    readln(y);
    While length(x) < length(y) do x := '0' + x;
    While length(x) > length(y) do y := '0' + y;
    If x >= y then plus := true else plus := false;
    a := x;
    b := y;
End;

Procedure PrintResult;
Begin
    writeln(toString(a + b));
    if plus then writeln(toString(a - b)) else writeln('-', toString(b - a));
    writeln(toString(a * b));
End;

BEGIN
    Enter;
    PrintResult;
END.
