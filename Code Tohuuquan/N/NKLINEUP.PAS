Program NKLINEUP;
Const maxn = 50000;
Type IntervalTree = Record min, max : longint End;
Var a : array[1..maxn] of longint;
    IT : array[1..3 * maxn] of IntervalTree;
    q, qleft, qright, maximum, minimum : longint;
    n : word;

Procedure Enter;
Var i : word;
Begin
    readln(n, q);
    For i := 1 to n do readln(a[i]);
End;

Function Max(x, y : longint) : longint;
Begin
    If x > y then exit(x) else exit(y);
End;

Function Min(x, y : longint) : longint;
Begin
    If x < y then exit(x) else exit(y);
End;

Procedure Modify(i : longint; left, right : word);
Var mid : word;
Begin
    If left = right then
        With IT[i] do
        Begin
            min := a[left];
            max := a[left];
        End
    Else
        Begin
            mid := (left + right) div 2;
            Modify(i shl 1, left, mid);
            Modify(i shl 1 + 1, mid + 1, right);
            IT[i].max := Max(IT[i shl 1].max, IT[i shl 1 + 1].max);
            IT[i].min := Min(IT[i shl 1].min, IT[i shl 1 + 1].min);
        End;
End;

Procedure Find(i : longint; left, right : word);
Var mid : word;
Begin
    If (left >= qleft) and (qright >= right) then
        Begin
            maximum := Max(IT[i].max, maximum);
            minimum := Min(IT[i].min, minimum);
        End
    Else
        If (left > qright) or (right < qleft) then exit
    Else
        Begin
            mid := (left + right) div 2;
            Find(i shl 1, left, mid);
            Find(i shl 1 + 1, mid + 1, right);
        End;
End;

Procedure Solve;
Begin
    While q > 0 do
    Begin
        maximum := -maxlongint;
        minimum := maxlongint;
        readln(qleft, qright);
        If qleft = qright then writeln(0) else
        Begin
            Find(1, 1, n);
            writeln(maximum - minimum);
        End;
        dec(q);
    End;
End;

BEGIN
    Enter;
    Modify(1, 1, n);
    Solve;
END.