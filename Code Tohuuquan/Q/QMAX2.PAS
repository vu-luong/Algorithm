Program QMAX2;
Uses Math;
Const maxn = 50000;
Var IT, s : array[1..maxn * 8] of longint;
    n, x, y : word;
    m, value : longint;

Procedure Update(i : longint; left, right : word);
Var mid : word;
Begin
    If (right < x) or (left > y) then exit;
    If (x <= left) and (right <= y) then
        inc(s[i], value)
    Else
        Begin
            inc(s[i shl 1], s[i]);
            inc(s[i shl 1 + 1], s[i]);
            s[i] := 0;
            mid := (left + right) shr 1;
            Update(i shl 1, left, mid);
            Update(i shl 1 + 1, mid + 1, right);
            IT[i] := Max(IT[i shl 1] + s[i shl 1], IT[i shl 1 + 1] + s[i shl 1 + 1]);
        End;
End;

Function Find(i : longint; left, right : word) : longint;
Var mid : word;
Begin
    If (right < x) or (left > y) then exit(0);
    inc(s[i shl 1], s[i]);
    inc(s[i shl 1 + 1], s[i]);
    s[i] := 0;
    If (x <= left) and (right <= y) then
        Begin
            IT[i] := Max(IT[i shl 1] + s[i shl 1], IT[i shl 1 + 1] + s[i shl 1 + 1]);
            exit(IT[i]);
        End
    Else
        Begin
            mid := (left + right) shr 1;
            Find := Max(Find(i shl 1, left, mid), Find(i shl 1 + 1, mid + 1, right));
            IT[i] := Max(IT[i shl 1] + s[i shl 1], IT[i shl 1 + 1] + s[i shl 1 + 1]);
        End;
End;

BEGIN
    readln(n, m);
    While m > 0 do
    Begin
        dec(m);
        read(x);
        If x = 0 then
            Begin
                readln(x, y, value);
                Update(1, 1, n);
            End
        Else
            Begin
                readln(x, y);
                writeln(Find(1, 1, n));
            End;
    End;
END.