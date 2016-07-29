Program HELPPM;
Const maxm = 500;
      maxn = 500;
Var a : array[1..maxm, 1..maxn] of word;
    s : array[1..maxm] of cardinal;
    m, n : word;
    k, min : cardinal;
    x1, y1, x2, y2 : word;

Procedure Enter;
Var i, j : word;
Begin
    readln(m, n, k);
    For i := 1 to m do
        For j := 1 to n do read(a[i, j]);
End;

Procedure Solve;
Var i, j, l, r, delta : word;
    sum : cardinal;
Begin
    min := high(cardinal);
    For l := 1 to n do
    Begin
        fillchar(s[1], m * sizeof(s[1]), 0);
        For r := l to n do
        Begin
            delta := r - l + 1;
            For i := 1 to m do inc(s[i], a[i, r]);
            i := 1;
            j := 1;
            sum := s[1];
            While (i <= j) and (j <= m) do
                If sum < k then
                    Begin
                        inc(j);
                        inc(sum, s[j]);
                    End
                Else
                    Begin
                        If min > (j - i + 1) * delta then
                        Begin
                            min := (j - i + 1) * delta;
                            x1 := i; y1 := l;
                            x2 := j; y2 := r;
                        End;
                        dec(sum, s[i]);
                        inc(i);
                    End;
        End;
    End;
End;

Procedure PrintResult;
Begin
    If min = high(cardinal) then write(-1) else
    Begin
        writeln(min);
        writeln(x1, ' ', y1, ' ', x2, ' ', y2);
    End;
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.