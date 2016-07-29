Program QBTICKET;
Const maxn = 100000;
      maxc = high(qword);
Var d, res : array[1..maxn] of qword;
    l, c : array[1..3] of qword;
    n, s, f : longint;

Procedure Enter;
Var i : longint;
Begin
    For i := 1 to 3 do read(l[i]);
    For i := 1 to 3 do read(c[i]);
    read(n);
    read(s, f);
    For i := 2 to n do read(d[i]);
End;

Function Min(x, y : qword) : qword;
Begin
    If x < y then exit(x) else exit(y);
End;

Function Cal(x : qword) : qword;
Var i : byte;
Begin
    For i := 1 to 3 do
        If x <= l[i] then exit(c[i]);
End;

Procedure Solve;
Var i, j : longint;
Begin
    For i := s + 1 to f do
    Begin
        res[i] := maxc;
        For j := i - 1 downto s do
            If d[i] - d[j] > l[3] then break
            else res[i] := Min(res[i], res[j] + Cal(d[i] - d[j]));
    End;
End;

Procedure PrintResult;
Begin
    write(res[f]);
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.
