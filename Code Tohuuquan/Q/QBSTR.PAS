Program QBSTR;
Const max = 255;
Var f : array[0..max, 0..max] of byte;
    a, b : string;

Procedure Enter;
Begin
    readln(a);
    readln(b);
End;

Procedure Solve;
Var i, j : byte;

 Function Max(x, y : byte) : byte;
 Begin
     If x > y then exit(x) else exit(y);
 End;

Begin
    fillchar(f, sizeof(f), 0);
    For i := 1 to length(a) do
        For j := 1 to length(b) do
            If a[i] = b[j] then
                f[i, j] := f[i - 1, j - 1] + 1
            else
                f[i, j] := Max(f[i - 1, j], f[i, j - 1]);
End;

Procedure PrintResult;
Begin
    writeln(f[length(a), length(b)]);
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.
