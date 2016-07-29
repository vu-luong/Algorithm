Program NKTHEME;
Const maxn = 5000;
Var a : array[1..maxn] of integer;
    l : array[1..maxn, 1..maxn] of word;
    n, res : word;

Procedure Enter;
Var i : word;
Begin
    readln(n);
    For i := 1 to n do read(a[i]);
    For i := n downto 2 do dec(a[i], a[i - 1]);
End;

Procedure Solve;
Var i, j : word;
Begin
    res := 0;
    For i := 2 to n do
        For j := i + 5 to n do
            If a[i] = a[j] then
            Begin
                If j - l[i - 1, j - 1] > i + 1 then
                    l[i, j] := l[i - 1, j - 1] + 1
                else
                    l[i, j] := 1;
                If l[i, j] > res then res := l[i, j];
            End;
End;

Procedure PrintResult;
Begin
    If res >= 4 then inc(res) else res := 0;
    writeln(res);
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.