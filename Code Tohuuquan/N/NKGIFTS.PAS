Program NKGIFTS;
Const BASE = 1000000000000000;
Type Bigint = array[1..2] of qword;
Var x1, x2, y1, y2 : qword;
    k : byte;
    d1, d2 : Bigint;

Operator + (a, b : Bigint) c : Bigint;
Begin
    c[2] := a[2] + b[2];
    c[1] := (c[2] div BASE) + a[1] + b[1];
    c[2] := c[2] mod BASE;
End;

Operator - (a, b : Bigint) c : Bigint;
Begin
    c[1] := a[1] - b[1];
    If a[2] < b[2] then
    Begin
        c[1] := c[1] - 1;
        a[2] := a[2] + BASE;
    End;
    c[2] := a[2] - b[2];
End;

Procedure Enter;
Begin
    readln(k, x1, y1, x2, y2);
End;

Procedure Solve;
Var n, m : qword;
    h, s : Bigint;
    i : byte;
Begin
    n := 1;
    For i := 1 to k do n := n shl 1;
    n := n - 1;
    d1[2] := 1;
    d2[2] := 1;
    s[1] := 0; s[2] := 1;
    h[1] := 0; h[2] := 1;
    Repeat
        m := n shr 1;
        If x1 > m then
            Begin x1 := n - x1; d1 := h - d1 + s; End
            Else d1 := d1 + h;
        If x2 > m then
            Begin x2 := n - x2; d2 := h - d2 + s; End
            Else d2 := d2 + h;
        h := h + h;
        m := m + 1;
        If y1 < m then
            Begin y1 := n - y1; d1 := h - d1 + s; End
            Else d1 := d1 + h;
        If y2 < m then
            Begin y2 := n - y2; d2 := h - d2 + s; End
            Else d2 := d2 + h;
        y1 := y1 - m;
        y2 := y2 - m;
        n := m - 1;
        h := h + h;
    Until n = 0;
End;

Procedure PrintResult;
Begin
    If d1[1] > 0 then write(d1[1]);
    write(d1[2], ' ');
    If d2[1] > 0 then write(d2[1]);
    write(d2[2]);
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.