Program LIQ;
Const maxn = 1000;
Var a : array[1..maxn] of word;
    n, res : word;

Procedure Enter;
Var i : word;
Begin
    readln(n);
    For i := 1 to n do read(a[i]);
End;

Procedure Solve;
Var f : array[1..maxn] of word;
    i, j : word;

 Function Max(x, y : word) : word;
 Begin
     If x > y then exit(x) else exit(y);
 End;

Begin
    res := 0;
    For i := 1 to n do
    Begin
        f[i] := 1;
        For j := 1 to i - 1 do
            If a[j] < a[i] then
                f[i] := Max(f[i], f[j] + 1);
        res := Max(res, f[i]);
    End;
End;

Procedure PrintResult;
Begin
    writeln(res);
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.
