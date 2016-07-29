Program VCOLDWAT;
Const maxn = 99999;
Var e : array[1..maxn, 1..3] of longint;
    n, c : longint;

Procedure Enter;
Var i, x : longint;
Begin
    readln(n, c);
    fillchar(e, sizeof(e), 0);
    For i := 1 to c do
    Begin
        read(x);
        readln(e[x, 1], e[x, 2]);
    End;
End;

Procedure DFSVisit(x : longint);
Var i : byte;
Begin
    For i := 1 to 2 do
        If e[x, i] <> 0 then
        Begin
            e[e[x, i], 3] := e[x, 3] + 1;
            DFSVisit(e[x, i]);
        End;
End;

Procedure Solve;
Begin
    e[1, 3] := 1;
    DFSVisit(1);
End;

Procedure PrintResult;
Var i : longint;
Begin
    For i := 1 to n do writeln(e[i, 3]);
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.
