Program V8ORG;
Const maxn = 10000;
Var nChild, parent : array[1..maxn] of word;
    k, n, res : word;

Procedure Enter;
Var i : word;
Begin
    readln(k);
    readln(n);
    nChild[1] := 1;
    parent[1] := 1;
    For i := 2 to n do
    Begin
        read(parent[i]);
        nChild[i] := 1;
    End;
End;

Procedure Solve;
Var i : word;
Begin
    res := 0;
    For i := n downto 1 do
    Begin
        If nChild[i] >= k then
        Begin
            nChild[i] := 0;
            inc(res);
        End;
        inc(nChild[parent[i]], nChild[i]);
    End;
    writeln(res);
End;

BEGIN
    Enter;
    Solve;
END.