Program PTRANG;
Const maxn = 6000;
Var w, g : array[0..maxn] of longint;
    n, l, i, j : word;

Function Min(x, y : longint) : longint;
Begin
    If x < y then exit(x) else exit(y);
End;

Function Max(x, y : longint) : longint;
Begin
    If x > y then exit(x) else exit(y);
End;

BEGIN
    readln(n, l);
    For i := 1 to n do
    Begin
        readln(w[i]);
        inc(w[i], w[i - 1]);
        g[i] := maxlongint;
        For j := i - 1 downto 0 do
            If w[i] - w[j] > l then break else
                g[i] := Min(g[i], Max(g[j], l - (w[i] - w[j])));
    End;
    writeln(g[n]);
END.