Program BONES;
Const maxs = 80;
Var a : array[3..maxs] of word;
    s1, s2, s3 : byte;

Procedure Enter;
Begin
    readln(s1, s2, s3);
End;

Procedure Solve;
Var i, j, k : byte;
Begin
    fillchar(a, sizeof(a), 0);
    For i := 1 to s1 do
        For j := 1 to s2 do
            For k := 1 to s3 do inc(a[i + j + k]);
End;

Procedure PrintResult;
Var res, i : byte;
Begin
    res := 3;
    For i := 4 to s1 + s2 + s3 do
        If a[i] > a[res] then res := i;
    writeln(res);
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.
