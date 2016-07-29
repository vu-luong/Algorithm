Program DMAYA;
Var a, b : array['A'..'z'] of word;
    g, s : ansistring;
    n : integer;
    m, res : longint;

Procedure Enter;
Var i : integer;
Begin
    readln(n, m);
    readln(g);
    readln(s);

    For i := 1 to n do inc(a[g[i]]);
End;

Function Check : boolean;
Var c : char;
Begin
    For c := 'A' to 'z' do
        If a[c] <> b[c] then exit(false);
    exit(true);
End;

Procedure Solve;
Var i : longint;
Begin
    For i := n downto 1 do inc(b[s[i]]);
    If Check then res := 1 else res := 0;
    For i := n + 1 to m do
    Begin
        inc(b[s[i]]);
        dec(b[s[i - n]]);
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