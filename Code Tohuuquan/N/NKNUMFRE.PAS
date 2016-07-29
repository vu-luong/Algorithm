Program NKNUMFRE;
Const maxn = 30000;
Var a, b, count : word;

Procedure Enter;
Begin
    readln(a, b);
End;

Function UCLN(x, y : longint) : longint;
Var r : word;
Begin
    While y <> 0 do
    Begin
        r := x mod y;
        x := y;
        y := r;
    End;
    exit(x);
End;

Function Cal(x : word) : longint;
Var res : longint;
Begin
    res := 0;
    While x <> 0 do
    Begin
        res := res * 10 + x mod 10;
        x := x div 10;
    End;
    exit(res);
End;

Procedure Solve;
Var i : word;
Begin
    count := 0;
    For i := a to b do
        If UCLN(i, Cal(i)) = 1 then inc(count);
End;

Procedure PrintResult;
Begin
    writeln(count);
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.
