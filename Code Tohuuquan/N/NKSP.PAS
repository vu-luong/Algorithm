Program NKSP;
Const maxn = 1000;
Var f : array[1..maxn, 1..maxn] of boolean;
    s : ansistring;
    n : word;

Procedure Enter;
Begin
    readln(s);
    n := length(s);
End;

Procedure Solve;
Var i, j, k, t : word;
    res : longint;
Begin
    res := 0;
    For i := 1 to n do f[i, i] := true;
    For i := 1 to n - 1 do
    Begin
        f[i, i + 1] := (s[i] = s[i + 1]);
        If f[i, i + 1] then inc(res);
    End;
    For k := 2 to n - 1 do
        For i := 1 to n - k do
        Begin
            j := i + k;
            f[i, j] := (s[i] = s[j]) and f[i + 1, j - 1];
        End;
    For k := 2 to n - 1 do
        For i := 1 to n - k do
        Begin
            j := i + k;
            If f[i, j] then inc(res) else
                For t := i + 1 to j - 2 do
                    If f[i, t] and f[t + 1, j] then
                    Begin
                        inc(res);
                        f[i, j] := true;
                        break;
                    End;
        End;
    writeln(res);
End;

BEGIN
    Enter;
    Solve;
END.