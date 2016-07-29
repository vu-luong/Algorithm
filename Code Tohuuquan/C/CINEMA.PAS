Program CINEMA;
Const max = 1000;
Var a : array[1..max, 1..max] of word;
    m, n : word;
    k : longint;

Procedure Enter;
Begin
    readln(m, n);
End;

Procedure Next(Var u, v : word);
Begin
    If u mod 2 = 1 then
        Begin
            If v < n then inc(v) else inc(u);
        End
    Else
        Begin
            If v > 1 then dec(v) else inc(u);
        End;
End;

Procedure Solve;
Var u, v : word;
    i, s : longint;
Begin
    u := 1;
    v := 1;
    readln(k);
    For i := 1 to k do
    Begin
        read(s);
        While s > 0 do
        Begin
            a[u, v] := i;
            Next(u, v);
            dec(s);
        End;
    End;
End;

Procedure PrintResult;
Var i, j : word;
Begin
    For i := 1 to m do
    Begin
        For j := 1 to n do write(a[i, j], ' ');
        writeln;
    End;
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.