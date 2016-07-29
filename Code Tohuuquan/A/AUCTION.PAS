Program AUCTION;
Const maxm = 1000;
Var p : array[1..maxm] of longint;
    n, m : word;
    cost, money : longint;

Procedure Enter;
Var i : word;
Begin
    readln(n, m);
    For i := 1 to m do read(p[i]);
End;

Procedure QuickSort(l, r : word);
Var i, j : word;
    x, t : longint;
Begin
    If l >= r then exit;
    i := l;
    j := r;
    x := p[l + random(r - l + 1)];
    While i <= j do
    Begin
        While p[i] > x do inc(i);
        While p[j] < x do dec(j);
        If i <= j then
        Begin
            t := p[i];
            p[i] := p[j];
            p[j] := t;
            inc(i);
            dec(j);
        End;
    End;
    QuickSort(l, j);
    QuickSort(i, r);
End;

Procedure Solve;
Var i, k : word;
    s : longint;
Begin
    If n < m then k := n else k := m;
    money := 0;
    For i := 1 to k do
    Begin
        s := p[i] * i;
        If s > money then
        Begin
            money := s;
            cost := p[i];
        End;
    End;
End;

Procedure PrintResult;
Begin
    writeln(cost, ' ', money);
End;

BEGIN
    Enter;
    QuickSort(1, m);
    Solve;
    PrintResult;
END.