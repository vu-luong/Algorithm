Program HOUSES;
Const maxn = 20;
      limit = 1000;
Var a, c : array[0..maxn] of byte;
    b : array[0..maxn] of string;
    l, n, m : byte;
    count : word;

Procedure Enter;
Var i : byte;
Begin
    readln(l, n);
    a[0] := l;
    For i := 1 to n do
    Begin
        read(a[i]);
        dec(a[0], a[i]);
    End;
End;

Procedure Init;
Var i, j : byte;
    st : string;
Begin
    For i := 1 to n do
    Begin
        str(i, st);
        b[i] := st;
        For j := 2 to a[i] do b[i] := b[i] + ' ' + st;
    End;
    c[1] := 1;
    b[0] := '0';
    m := n + a[0];
    For i := a[0] + 2 to n + a[0] do c[i] := i - a[0];
End;

Procedure Sort;
Var i, j, k, t : byte;
Begin
    For i := m downto 2 do
        If c[i] > c[i - 1] then break;
    If (i = 2) and (c[i] <= c[i - 1]) then
    Begin
        count := limit + 1;
        exit;
    End;
    For j := m downto i do
        If c[j] > c[i - 1] then break;
    t := c[i - 1];
    c[i - 1] := c[j];
    c[j] := t;
    For k := i to m do
        For j := k + 1 to m do
            If c[j] < c[k] then
            Begin
                t := c[k];
                c[k] := c[j];
                c[j] := t;
            End;
    inc(count);
End;

Procedure Print;
Var i : byte;
Begin
    For i := 1 to m do write(b[c[i]], ' ');
    writeln;
End;

BEGIN
    Enter;
    Init;
    count := 1;
    Repeat
        Print;
        Sort;
    Until count > 1000;
END.