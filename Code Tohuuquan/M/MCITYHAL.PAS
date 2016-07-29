Program MCITYHAL;
Const maxm = 200;
      maxn = 200;
Var a : array[1..maxm, 1..maxn] of char;
    k : array[1..maxm] of word;
    m, n : byte;

Procedure Enter;
Var i, j : byte;
Begin
    readln(m, n);
    For i := 1 to m do
    Begin
        For j := 1 to n do read(a[i, j]);
        readln;
    End;
End;

Procedure Solve;
Var i, j : byte;
    count : word;
Begin
    fillchar(k, sizeof(k), 0);
    For j := 1 to n do
    Begin
        count := 0;
        For i := 1 to m do
            If a[i, j] = '0' then inc(count) else
            Begin
                If count > 0 then inc(k[count]);
                count := 0;
            End;
        If count > 0 then inc(k[count]);
    End;
End;

Procedure PrintResult;
Var i : byte;
Begin
    For i := 1 to maxm do
        If k[i] > 0 then writeln(i, ' ', k[i]);
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.