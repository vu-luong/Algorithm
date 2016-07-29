{$MODE OBJFPC}
Program PBCWRI;
Var x, y : array['A'..'z'] of integer;
    a, b : ansistring;
    n, m, res : integer;

Procedure Enter;
Var i : integer;
Begin
    readln(n, m);
    readln(a);
    readln(b);
    For i := 1 to n do inc(x[a[i]]);
End;

Function Check : boolean;
Var c : char;
Begin
    For c := 'A' to 'z' do
        If x[c] <> y[c] then exit(false);
    exit(true);
End;

Procedure Solve;
Var i : integer;
Begin
    For i := n downto 1 do inc(y[b[i]]);
    If Check then res := 1 else res := 0;
    For i := n + 1 to m do
    Begin
        inc(y[b[i]]);
        dec(y[b[i - n]]);
        If Check then inc(res);
    End;
End;

Procedure PrintResult;
Begin
    writeln(res);
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.