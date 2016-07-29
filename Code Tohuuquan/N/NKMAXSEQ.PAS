Program NKMAXSEQ;
Const maxn = 50000;
Var s, id : array[0..maxn] of longint;
    n, p : longint;

Procedure Enter;
Var i, t, idmin, min : longint;
Begin
    readln(n, p);
    min := 0;
    idmin := 0;
    For i := 1 to n do
    Begin
        readln(t);
        s[i] := s[i - 1] + t;
        If s[i] < min then
        Begin
            min := s[i];
            idmin := i;
        End;
        id[i] := idmin;
    End;
End;

Procedure Solve;
Var i, j, low, high : longint;
Begin
    low := 0;
    high := 0;
    i := id[n];
    j := n;
    Repeat
        While (i < j) and (j - i > high - low) and (s[j] - p < s[i]) do dec(j);
        If j - i > high - low then
        Begin
            low := i;
            high := j;
        End;
        If i = 0 then break;
        i := id[i - 1];
    Until false;
    If low = high then writeln(-1) else writeln(high - low);
End;

BEGIN
    Enter;
    Solve;
END.