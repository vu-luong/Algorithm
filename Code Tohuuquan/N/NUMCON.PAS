Program NUMCON;
Const maxn = 100;
Var s : array[1..maxn] of string[maxn];
    n : byte;

Procedure Enter;
Begin
    While not eof do
    Begin
        inc(n);
        readln(s[n]);
    End;
End;

Procedure Solve;
Var i, j : byte;
    t : string[maxn];
Begin
    For i := 1 to n - 1 do
        For j := i + 1 to n do
            If s[i] + s[j] < s[j] + s[i] then
            Begin
                t := s[i];
                s[i] := s[j];
                s[j] := t;
            End;
    For i := 1 to n do write(s[i]);
End;

BEGIN
    Enter;
    Solve;
END.