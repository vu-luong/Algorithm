Program PBCFIBO;
Const maxm = 15002;
      maxk = 10000;
Var f : array[1..maxm] of word;
    h : array[0..maxk - 1] of qword;
    n, s : qword;
    k, m : word;

Procedure Enter;
Begin
    readln(n, k, s);
End;

Procedure Solve;
Var i, y : word;
    x : qword;
Begin
    f[1] := 1 mod k;
    f[2] := 2 mod k;
    For i := 3 to maxm do
    Begin
        f[i] := (f[i - 1] + f[i - 2]) mod k;
        If (f[i] = f[2]) and (f[i - 1] = f[1]) then break;
    End;
    m := i - 2;
    x := n div m;
    y := n mod m;
    For i := 1 to m do h[f[i]] := h[f[i]] + x;
    For i := 1 to y do h[f[i]] := h[f[i]] + 1;
End;

Procedure PrintResult;
Var i : word;
Begin
    For i := 0 to k - 1 do
        If s <= h[i] then break
        else s := s - h[i];
    write(i);
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.