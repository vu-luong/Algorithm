Program LASCALE;
Const max = 18;
Var pow : array[1..max] of longint;
    bA, bB : array[1..max] of boolean;
    a : array[1..max] of byte;
    m : longint;
    n, nA, nB : byte;

Procedure Enter;
Var i : byte;
Begin
    readln(m);
    n := 0;
    While m > 0 do
    Begin
        inc(n);
        a[n] := m mod 3;
        m := m div 3;
    End;
    pow[1] := 1;
    For i := 2 to n + 1 do pow[i] := pow[i - 1] * 3;
End;

Procedure Solve;
Var i, j : byte;
Begin
    For i := 1 to n + 1 do
        If a[i] = 1 then
            Begin
                inc(nB);
                bB[i] := true;
            End Else
        If a[i] = 2 then
            Begin
                inc(nA);
                bA[i] := true;
                j := i;
                Repeat
                    inc(j);
                    a[j] := (a[j] + 1) mod 3;
                Until a[j] <> 0;
            End;
End;

Procedure PrintResult;
Var i : byte;
Begin
    write(nA, ' ');
    For i := 1 to n + 1 do
        If bA[i] then write(pow[i], ' ');
    writeln;
    write(nB, ' ');
    For i := 1 to n + 1 do
        If bB[i] then write(pow[i], ' ');
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.