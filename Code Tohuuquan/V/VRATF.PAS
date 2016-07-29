Program VRATF;
Var n, group : longint;
    k : word;

Procedure Enter;
Begin
    readln(n, k);
    group := 1;
End;

Procedure Cal(n : longint);
Begin
    If (n - k < 2) or ((n - k) mod 2 = 1) then exit;
    inc(group);
    Cal((n - k) div 2);
    Cal((n + k) div 2);
End;

Procedure PrintResult;
Begin
    writeln(group);
End;

BEGIN
    Enter;
    Cal(n);
    PrintResult;
END.
