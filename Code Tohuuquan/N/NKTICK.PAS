Program NKTICK;
Const maxn = 60000;
Var t : array[1..maxn] of word;
    r : array[1..maxn - 1] of word;
    f : array[1..maxn + 1] of longint;
    n : word;

Procedure Enter;
Var i : word;
Begin
    readln(n);
    For i := 1 to n do read(t[i]);
    For i := 1 to n - 1 do read(r[i]);
End;

Procedure Solve;
Var i : word;

 Function Min(x, y : longint) : longint;
 Begin
     If x < y then exit(x) else exit(y);
 End;

Begin
    f[n + 1] := 0;
    f[n] := t[n];
    For i := n - 1 downto 1 do
        f[i] := Min(f[i + 1] + t[i], f[i + 2] + r[i]);
End;

Procedure PrintResult;
Begin
    writeln(f[1]);
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.
