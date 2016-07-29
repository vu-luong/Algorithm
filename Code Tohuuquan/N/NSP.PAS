Program NSP;
Var a : array[1..1000, 1..1000] of longint;
    i, j, n, k, x : longint;

BEGIN
    readln(n, k);
    For i := 1 to n do
        For j := 1 to n do read(a[i, j]);
    While k > 0 do
    Begin
        dec(k);
        readln(x);
        i := 1;
        j := n;
        While a[i, j] <> x do
            If a[i, j] > x then dec(j) else inc(i);
        writeln(i, ' ', j);
    End;
END.