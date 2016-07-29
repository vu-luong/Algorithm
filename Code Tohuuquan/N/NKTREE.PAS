Program NKTREE;
Const maxn = 50000;
Var a : array[1..maxn] of longint;
    n : word;
    res : boolean;

Procedure Enter;
Begin
    n := 0;
    While not seekeoln do
    Begin
        inc(n);
        read(a[n]);
    End;
End;

Procedure Solve;
Var min, max : longint;
    i : word;
Begin
    res := true;
    min := a[n];
    max := a[n];
    For i := n - 1 downto 1 do
    Begin
        If ((a[i] < a[i + 1]) and (min < a[i]))
        or ((a[i] > a[i + 1]) and (max > a[i])) then
        Begin
            res := false;
            break;
        End;
        If min > a[i] then min := a[i];
        If max < a[i] then max := a[i];
    End;
End;

Procedure PrintResult;
Begin
    If res then write('YES') else write('NO');
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.