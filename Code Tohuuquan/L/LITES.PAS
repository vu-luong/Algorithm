Program LITES;
Const maxn = 100000;
Var IT : array[1..maxn * 8] of longint;
    S : array[1..maxn * 8] of boolean;
    n, m, x, y, res : longint;

Procedure Update(i, left, right : longint);
Var mid : longint;
Begin
    If left > right then exit;
    If (left > y) or (right < x) then exit;
    If (x <= left) and (right <= y) then
    Begin
        If not S[i] then IT[i] := (right - left + 1) - IT[i]
        else S[i] := true;
        S[i shl 1] := not S[i shl 1];
        S[i shl 1 + 1] := not S[i shl 1 + 1];
        exit;
    End;
    mid := (left + right) shr 1;
    If S[i shl 1] then
    Begin
        IT[i shl 1] := (mid - left + 1) - IT[i shl 1];
        S[i shl 1] := false;
        S[(i shl 1) shl 1] := not S[(i shl 1) shl 1];
        S[(i shl 1) shl 1 + 1] := not S[(i shl 1) shl 1 + 1];
    End;
    If S[i shl 1 + 1] then
    Begin
        IT[i shl 1 + 1] := (right - mid) - IT[i shl 1 + 1];
        S[i shl 1 + 1] := false;
        S[(i shl 1 + 1) shl 1] := not S[(i shl 1 + 1) shl 1];
        S[(i shl 1 + 1) shl 1 + 1] := not S[(i shl 1 + 1) shl 1 + 1];
    End;
    Update(i shl 1, left, mid);
    Update(i shl 1 + 1, mid + 1, right);
    IT[i] := IT[i shl 1] + IT[i shl 1 + 1];
End;

Procedure Find(i, left, right : longint);
Var mid : longint;
Begin
    If left > right then exit;
    If (left > y) or (right < x) then exit;
    If (x <= left) and (right <= y) then
    Begin
        If S[i] then
        Begin
            S[i] := false;
            IT[i] := (right - left + 1) - IT[i];
            S[i shl 1] := not S[i shl 1];
            S[i shl 1 + 1] := not S[i shl 1 + 1];
        End;
        inc(res, IT[i]);
        exit;
    End;
    If S[i] then
    Begin
        S[i] := false;
        IT[i] := (right - left + 1) - IT[i];
        S[i shl 1] := not S[i shl 1];
        S[i shl 1 + 1] := not S[i shl 1 + 1];
    End;
    mid := (left + right) shr 1;
    Find(i shl 1, left, mid);
    Find(i shl 1 + 1, mid + 1, right);
End;

BEGIN
    readln(n, m);
    While m > 0 do
    Begin
        dec(m);
        read(x);
        If x = 0 then
            Begin
                readln(x, y);
                Update(1, 1, n);
            End
        Else
            Begin
                readln(x, y);
                res := 0;
                Find(1, 1, n);
                writeln(res);
            End;
    End;
END.
