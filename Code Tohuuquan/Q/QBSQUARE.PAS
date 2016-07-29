Program QBSQUARE;
Const maxn = 1000;
Type Arr = array[1..maxn] of byte;
     word = longint;
Var x, y : Arr;
    h : array[0..maxn + 1] of word;
    m, n, res : word;

Procedure Enter;
Begin
    readln(m, n);
End;

Procedure Scan(Var x : Arr);
Var i : word;
Begin
    For i := 1 to n do read(x[i]);
End;

Procedure Solve;
Var i, a, count : word;
Begin
    Scan(x);
    res := 1;
    For i := 1 to n do h[i] := 1;
    While m > 1 do
    Begin
        Scan(y);
        For i := 1 to n do
            If x[i] = y[i] then inc(h[i]) else h[i] := 1;

        count := 0;
        For i := 1 to n do
            If h[i] <= res then count := 0 else
            If y[i] <> y[i - 1] then count := 1 else
            Begin
                inc(count);
                If count > res then
                Begin
                    res := count;
                    break;
                End;
            End;
        x := y;
        dec(m);
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