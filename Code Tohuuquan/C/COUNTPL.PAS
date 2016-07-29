Program COUNTPL;
Const maxn = 255;
Var f : array[1..maxn] of byte;
    dx : array[1..maxn, 1..maxn] of boolean;
    s : string;
    n : byte;

Procedure Enter;
Begin
    readln(s);
    n := length(s);
End;

Procedure Init;
Var i, j : byte;
Begin
    For i := 1 to n - 1 do
    Begin
        dx[i + 1, i] := true;
        dx[i, i] := true;
    End;
End;

Procedure Solve;
Var i, j : byte;
Begin
    f[1] := 1;
    For j := 2 to n do
    Begin
        f[j] := f[j - 1] + 1;
        For i := j - 1 downto 1 do
            If (s[i] = s[j]) and (dx[i + 1, j - 1]) then
            Begin
                dx[i, j] := true;
                If f[j] > f[i - 1] + 1 then
                    f[j] := f[i - 1] + 1;
            End;
    End;
End;

Procedure PrintResult;
Begin
    writeln(f[n]);
End;

BEGIN
    Enter;
    Init;
    Solve;
    PrintResult;
END.