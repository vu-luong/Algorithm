Program VCOWFLIX;
Const maxn = 16;
      maxc = 5000;
Var w : array[1..maxn] of word;
    n : byte;
    c, max : word;

Procedure Enter;
Var i : byte;
Begin
    readln(c, n);
    For i := 1 to n do readln(w[i]);
End;

Procedure Solve;
Var f : array[0..maxc] of byte;
    i : byte;
    j : word;
Begin
    fillchar(f, sizeof(f), 0);
    f[0] := 1;
    max := 0;
    For i := 1 to n do
        For j := max downto 0 do
        Begin
            If j + w[i] > c then continue;
            If (f[j] <> 0) and (f[j + w[i]] = 0) then
            Begin
                f[j + w[i]] := i;
                If max < j + w[i] then max := j + w[i];
                If max = c then exit;
            End;
        End;
End;

Procedure PrintResult;
Begin
    writeln(max);
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.
