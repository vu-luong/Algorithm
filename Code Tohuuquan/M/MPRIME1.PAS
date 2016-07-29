Program MPRIME1;
Const max = 1336;
Var s : array[-1..max] of longint;
    n : word;

Function Prime(x : word) : boolean;
Var k, sqrt_x : word;
Begin
    If (x = 2) or (x = 3) then exit(true);
    If (x mod 2 = 0) or (x mod 3 = 0) then exit(false);
    sqrt_x := trunc(sqrt(x));
    k := 0;
    Repeat
        inc(k, 6);
        If (x mod (k - 1) = 0) or (x mod (k + 1) = 0) then break;
    Until k - 1 > sqrt_x;
    exit(k - 1 > sqrt_x);
End;

Procedure Init;
Var i, x : word;
Begin
    x := 1;
    For i := 1 to max do
    Begin
        Repeat inc(x) Until Prime(x);
        s[i] := s[i - 1] + x;
    End;
End;

Procedure Solve;
Var i, res, left, right, mid : word;
    key : longint;
Begin
    res := 0;
    For i := 0 to max do
        If s[i] - s[i - 1] > n then break
    Else
        Begin
            key := s[i] + n;
            left := 0;
            right := max;
            While left <= right do
            Begin
                mid := (left + right) shr 1;
                If key = s[mid] then break;
                If key < s[mid] then right := mid - 1
                    else left := mid + 1;
            End;
            If key = s[mid] then inc(res);
        End;
    writeln(res);
End;

BEGIN
    Init;
    While not eof do
    Begin
        readln(n);
        If n <> 0 then Solve else break;
    End;
END.