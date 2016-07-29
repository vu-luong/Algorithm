Program NKPALIN;
Const max = 2000;
Var f : array[0..max, 0..max] of word;
    s1, s2 : ansistring;
    n : word;

Procedure Enter;
Var i : word;
Begin
    readln(s1);
    n := length(s1);
    s2 := '';
    For i := 1 to n do s2 := s1[i] + s2;
End;

Procedure Solve;
Var i, j : word;

 Function Max(x, y : word) : word;
 Begin
     If x > y then exit(x) else exit(y);
 End;

Begin
    fillchar(f, sizeof(f), 0);
    For i := 1 to n do
        For j := 1 to n do
            If s1[i] = s2[j] then f[i, j] := f[i - 1, j - 1] + 1 else
                f[i, j] := Max(f[i - 1, j], f[i, j - 1]);
End;

Procedure PrintResult;
Var i, j : word;
    res : ansistring;
Begin
    i := n;
    j := n;
    res := '';
    While (i > 0) and (j > 0)  do
        If s1[i] = s2[j] then
            Begin
                res := s1[i] + res;
                dec(i);
                dec(j);
            End
        Else If f[i, j] = f[i - 1, j] then dec(i) else dec(j);
    writeln(res);
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.
