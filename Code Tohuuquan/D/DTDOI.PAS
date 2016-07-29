Program DTDOI;
Uses Math;
Const maxn = 100;
      maxs = 1000;
Var a : array[1..maxn] of byte;
    n : byte;
    s, res : longint;

Procedure Enter;
Var i : byte;
Begin
    readln(n, s);
    For i := 1 to n do read(a[i]);
End;

Procedure Sort(l, r : byte);
Var i, j, x, t : byte;
Begin
    If l >= r then exit;
    i := l;
    j := r;
    x := a[l + random(r - l + 1)];
    Repeat
        While a[i] < x do inc(i);
        While a[j] > x do dec(j);
        If i <= j then
        Begin
            t := a[i];
            a[i] := a[j];
            a[j] := t;
            inc(i);
            dec(j);
        End;
    Until i > j;
    Sort(l, j);
    Sort(i, r);
End;

Procedure Solve;
Var f : array[0..maxs] of word;
    i : word;
    j : byte;
Begin
    If s > maxs then
    Begin
        res := s div a[n];
        s := s mod a[n];
        While s + a[n] <= 1000 do
        Begin
            dec(res);
            inc(s, a[n]);
        End;
    End;
    fillchar(f, sizeof(f), 0);
    For i := 1 to s do
        For j := 1 to n do
            If i >= a[j] then
                If f[i] = 0 then f[i] := f[i - a[j]] + 1
                else f[i] := Min(f[i], f[i - a[j]] + 1);
    write(res + f[s]);
End;

BEGIN
    Enter;
    Sort(1, n);
    Solve;
END.
