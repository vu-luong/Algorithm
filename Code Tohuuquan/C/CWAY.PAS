Program CWAY;
Const BASE = 1000000000000000;
      DIGIT = 15;
      MAXD = 171;
Var num : array[1..MAXD] of int64;
    n : word;
    top : byte;

Procedure Mul(x : word);
Var i : byte;
    carry : int64;
Begin
    carry := 0;
    For i := 1 to top do
    Begin
        num[i] := num[i] * x + carry;
        carry := num[i] div BASE;
        num[i] := num[i] mod BASE;
    End;
    If carry > 0 then
    Begin
        inc(top);
        num[top] := carry;
    End;
End;

Procedure Add;
Var i : byte;
    carry : int64;
Begin
    carry := 1;
    For i := 1 to top do
    Begin
        num[i] := num[i] + carry;
        carry := num[i] div BASE;
        num[i] := num[i] mod BASE;
        If carry = 0 then exit;
    End;
    If carry > 0 then
    Begin
        inc(top);
        num[top] := carry;
    End;
End;

Procedure Enter;
Begin
    readln(n);
End;

Procedure Solve;
Var i : word;
Begin
    top := 1;
    num[top] := 1;
    For i := 1 to n - 2 do
    Begin
        Mul(i);
        Add;
    End;
End;

Procedure PrintResult;
Var s : string;
Begin
    str(num[top], s);
    dec(top);
    write(s);
    While top > 0 do
    Begin
        str(num[top], s);
        While length(s) < DIGIT do s := '0' + s;
        write(s);
        dec(top);
    End;
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.