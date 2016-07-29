Program V8SCORE;
Const maxk = 20;
      maxn = 20;
Var a : array[1..maxn, 1..maxk] of byte;
    t : array[0..maxk] of byte;
    s, k, n, r : byte;

Procedure Enter;
Var i, j : byte;
Begin
    readln(s, k, n);
    For i := 1 to n do
        For j := 1 to k do read(a[i, j]);
    r := s;
End;

Procedure PrintResult;
Var i, j : byte;
Begin
    For i := 1 to n do
        If a[i, k] = r then
        Begin
            writeln('YES');
            t[k] := r;
            For j := 1 to k do write(t[j], ' ');
            halt;
        End;
End;

Procedure Find(x : byte);
Var i : byte;
Begin
    For i := 1 to n do
        If (a[i, x] >= t[x - 1]) and (a[i, x] <= (r div (k - x + 1))) then
        Begin
            t[x] := a[i, x];
            dec(r, t[x]);
            If x = k - 1 then PrintResult else Find(x + 1);
            inc(r, t[x]);
        End;
End;

BEGIN
    Enter;
    Find(1);
    writeln('NO');
END.