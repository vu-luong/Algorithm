Program NKREZ;
Const maxn = 10000;
Var k, p : array[1..maxn] of word;
    f : array[0..maxn] of longint;
    n : word;

Procedure Enter;
Var i : word;
Begin
    readln(n);
    For i := 1 to n do readln(p[i], k[i]);
End;

Procedure QuickSort(l, r : word);
Var i, j, x, t : word;
Begin
    If l >= r then exit;
    i := l;
    j := r;
    x := k[l + random(r - l + 1)];
    While i <= j do
    Begin
        While k[i] < x do inc(i);
        While k[j] > x do dec(j);
        If i <= j then
        Begin
            t := k[i]; k[i] := k[j]; k[j] := t;
            t := p[i]; p[i] := p[j]; p[j] := t;
            inc(i); dec(j);
        End;
    End;
    QuickSort(l, j);
    QuickSort(i, r);
End;

Function Max(x, y : longint) : longint;
Begin
    If x > y then exit(x) else exit(y);
End;

Procedure Solve;
Var i, j, pos : word;
Begin
    f[1] := k[1] - p[1];
    For i := 2 to n do
    Begin
        pos := 0;
        For j := 1 to i - 1 do
            If k[j] <= p[i] then pos := j else break;
        f[i] := Max(f[i - 1], f[pos] + k[i] - p[i]);
    End;
End;

Procedure PrintResult;
Begin
    writeln(f[n]);
End;

BEGIN
    Enter;
    QuickSort(1, n);
    Solve;
    PrintResult;
END.
