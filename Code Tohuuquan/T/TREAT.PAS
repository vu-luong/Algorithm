Program TREAT;
Const maxn = 100000;
Var next, mark, res : array[1..maxn] of longint;
    n, comp : longint;

Procedure Enter;
Var i : longint;
Begin
    readln(n);
    For i := 1 to n do readln(next[i]);
End;

Procedure Solve;
Var i, j, k, start, count, temp : longint;
Begin
    For i := 1 to n do
        If mark[i] = 0 then
        Begin
            inc(comp);
            j := i;
            count := 0;
            While mark[j] = 0 do
            Begin
                mark[j] := comp;
                j := next[j];
                inc(count);
            End;
            start := j;
            If mark[start] = comp then
            Begin
                k := i;
                temp := count;
                While k <> start do
                Begin
                    dec(temp);
                    k := next[k];
                End;
                res[start] := temp;
                k := next[start];
                While k <> start do
                Begin
                    res[k] := temp;
                    k := next[k];
                End;
            End;
            If mark[start] <> comp then inc(count, res[j]);
            j := i;
            While j <> start do
            Begin
                res[j] := count;
                dec(count);
                j := next[j];
            End;
        End;
End;

Procedure PrintResult;
Var i : longint;
Begin
    For i := 1 to n do writeln(res[i]);
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.