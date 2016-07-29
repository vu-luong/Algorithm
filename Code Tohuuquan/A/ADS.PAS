Program ADS;
Const maxn = 2000;
Var a : array[1..maxn, 1..maxn] of boolean;
    free : array[1..maxn] of boolean;
    n, m, k : word;

Procedure Enter;
Var i, u, v : word;
Begin
    fillchar(a, sizeof(a), false);
    readln(n, m);
    For i := 1 to m do
    Begin
        readln(u, v);
        a[u, v] := true;
        a[v, u] := true;
    End;
End;

Procedure Solve;
Var i : word;

 Procedure DFSVisit(u : word);
 Var v : word;
 Begin
     free[u] := false;
     For v := 1 to n do
         If a[u, v] and free[v] then DFSVisit(v);
 End;

Begin
    fillchar(free, sizeof(free), true);
    k := 0;
    For i := 1 to n do
        If free[i] then
        Begin
            inc(k);
            DFSVisit(i);
        End;
End;

Procedure PrintResult;
Begin
    writeln(m - n + k);
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.