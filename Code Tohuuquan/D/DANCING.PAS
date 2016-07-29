Program DANCING;
Const maxn = 100000;
Var a : array[1..maxn] of integer;
    s : array[0..maxn] of longint;
    n : longint;

Procedure Enter;
Var i : longint;
Begin
    readln(n);
    For i := 1 to n do
    Begin
        read(a[i]);
        s[i] := s[i - 1] + a[i];
    End;
End;

Procedure Swap(Var x, y : longint);
Var t : longint;
Begin
    t := x;
    x := y;
    y := t;
End;

Procedure QuickSort(l, r : longint);
Var i, j, x : longint;
Begin
    If l >= r then exit;
    i := l;
    j := r;
    x := s[l + random(r - l + 1)];
    While i <= j do
    Begin
        While s[i] < x do inc(i);
        While s[j] > x do dec(j);
        If i <= j then
        Begin
            Swap(s[i], s[j]);
            inc(i);
            dec(j);
        End;
    End;
    QuickSort(l, j);
    QuickSort(i, r);
End;

Procedure PrintResult;
Var i : longint;
Begin
    For i := 1 to n do
    Begin
        a[i] := s[i] - s[i - 1];
        If a[i] <= 0 then
        Begin
            write(-1);
            exit;
        End;
    End;
    For i := 1 to n do write(a[i], ' ');
End;

BEGIN
    Enter;
    QuickSort(1, n - 1);
    PrintResult;
END.