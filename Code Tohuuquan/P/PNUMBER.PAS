Program PNUMBER;
Const max = 200000;
Var prime : array[1..max] of boolean;
    a, b : longint;

Procedure Enter;
Begin
    readln(a, b);
End;

Procedure Init;
Var i, j : longint;
Begin
    fillchar(prime, sizeof(prime), true);
    prime[1] := false;
    For i := 2 to b do
        If prime[i] then
        Begin
            j := i shl 1;
            While j <= b do
            Begin
                prime[j] := false;
                inc(j, i);
            End;
        End;
End;

Procedure PrintResult;
Var i : longint;
Begin
    For i := a to b do
        If prime[i] then writeln(i);
End;

BEGIN
    Enter;
    Init;
    PrintResult;
END.