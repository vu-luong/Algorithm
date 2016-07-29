Program CRUELL;
Const DIGIT = 9;
      BASE = 1000000000;
      MAXD = 1710;
Type Bigint = Record
      num : array[1..MAXD] of int64;
      top : word;
     End;
Var a : bigint;
    n, p : longint;

Operator := (s : longint) b : bigint;
Begin
    With b do
    Begin
        fillchar(num, sizeof(num), 0);
        top := MAXD + 1;
        While s > 0 do
        Begin
            dec(top);
            num[top] := s mod BASE;
            s := s div BASE;
        End;
    End;
End;

Operator * (Var a, b : bigint) c : bigint;
Var i, j, x, y, k : longint;
    cr : int64;
Begin
    fillchar(c, sizeof(c), 0);
    For i := MAXD downto a.top - 1 do
    Begin
        cr := 0;
        For j := MAXD downto b.top - 1 do
        Begin
            k := i + j - MAXD;
            c.num[k] := c.num[k] + a.num[i] * b.num[j] + cr;
            cr := c.num[k] div BASE;
            c.num[k] := c.num[k] mod BASE;
        End;
    End;
    c.top := a.top + b.top - MAXD - 2;
    While c.num[c.top] = 0 do inc(c.top);
End;

Procedure Enter;
Begin
    readln(n, p);
End;

Function Pow(b : Bigint; p : longint) : Bigint;
Var t : Bigint;
Begin
    If p = 1 then exit(b);
    t := Pow(b, p shr 1);
    t := t * t;
    If p mod 2 = 0 then exit(t) else exit(t * b);
End;

Procedure Solve;
Begin
    a := n;
    a := Pow(a, p);
End;

Procedure PrintResult;
Var q : string;
    i, count : integer;
Begin
    str(a.num[a.top], q);
    write(q);
    count := length(q);
    For i := a.top + 1 to MAXD do
    Begin
        str(a.num[i], q);
        While (length(q) < DIGIT) do q := '0' + q;
        inc(count, DIGIT);
        If count < 70 then write(q) else
        Begin
            dec(count, 70);
            writeln(copy(q, 1, DIGIT - count));
            write(copy(q, DIGIT - count + 1, count));
        End;
    End;
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.