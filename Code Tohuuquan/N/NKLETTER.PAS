Program NKLETTER;
Var a, b : string;
    res : byte;

Procedure Enter;
Begin
    readln(a);
    readln(b);
End;

Procedure Solve;
Var i, n : byte;
Begin
    If length(a) < length(b) then n := length(a) else n := length(b);
    res := 0;
    For i := 1 to n do
        If copy(a, length(a) - i + 1, i) = copy(b, 1, i) then res := i;
End;

Procedure PrintResult;
Begin
    writeln(length(a) + length(b) - res);
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.
