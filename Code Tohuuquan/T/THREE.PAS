Program THREE;
Const maxn = 100;
      maxm = (maxn div 2) * (maxn - 1);
      maxc = 10000 * maxm + 1;
Var c : array[1..maxn, 1..maxn] of longint;
    e : array[1..maxn, 1..maxn] of word;
    t : array[1..maxn, 1..maxn] of byte;
    res : array[1..maxm] of word;
    n : byte;
    m, count : word;
    min : longint;

Procedure Enter;
Var i, j : byte;
    k : word;
    s : longint;
Begin
    readln(n, m);
    For i := 1 to n do
        For j := 1 to n do
            If i = j then c[i, j] := 0 else c[i, j] := maxc;
    For k := 1 to m do
    Begin
        readln(i, j, s);
        If s < c[i, j] then
        Begin
            c[i, j] := s;
            c[j, i] := c[i, j];
            e[i, j] := k;
            e[j, i] := e[i, j];
        End;
    End;
End;

Procedure Floyd;
Var i, j, k : byte;
Begin
    For i := 1 to n do
        For j := 1 to n do t[i, j] := j;
    For k := 1 to n do
        For i := 1 to n do
            For j := 1 to n do
                If c[i, j] > c[i, k] + c[k, j] then
                Begin
                    c[i, j] := c[i, k] + c[k, j];
                    t[i, j] := t[i, k];
                End;
End;

Procedure Trace(x, y : byte);
Begin
    If x = y then exit;
    Repeat
        inc(count);
        res[count] := e[x, t[x, y]];
        x := t[x, y];
    Until x = y;
End;

Procedure Solve;
Var i, x : byte;
    s : longint;
Begin
    min := maxlongint;
    For i := 1 to n do
    Begin
        s := c[1, i] + c[2, i] + c[3, i];
        If s < min then
        Begin
            min := s;
            x := i;
        End;
    End;
    count := 0;
    For i := 1 to 3 do Trace(x, i);
End;

Procedure PrintResult;
Var i : word;
Begin
    writeln(min);
    writeln(count);
    For i := 1 to count do write(res[i], ' ');
End;

BEGIN
    Enter;
    Floyd;
    Solve;
    PrintResult;
END.
