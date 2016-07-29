Program NKROBOT;
Const n = 9;
Type Arr = array[1..n] of byte;
Var change : array[1..n, 1..n] of boolean;
    count, res : array[1..n] of byte;
    start : Arr;
    mincost, temp : byte;

Procedure Enter;
Var i, j : byte;
    c : char;
Begin
    fillchar(change, sizeof(change), false);
    For i := 1 to n do
    Begin
        While not eoln do
        Begin
            read(c);
            change[i, ord(c) - 48] := true
        End;
        readln;
    End;
    For i := 1 to 9 do
    Begin
        read(c);
        Case c of
         'T' : start[i] := 0;
         'X' : start[i] := 1;
         'V' : start[i] := 2;
        End;
    End;
    mincost := n * 3 + 1;
End;

Function Check(a : Arr) : boolean;
Var i, j : byte;
Begin
    For i := 1 to n do
        If count[i] <> 0 then
            For j := 1 to n do
                If change[i, j] then a[j] := (a[j] + count[i]) mod 3;
    For i := 1 to n do
        If a[i] <> 0 then exit(false);
    exit(true);
End;

Procedure Find(x : byte);
Var i : byte;
Begin
    For i := 0 to 2 do
    Begin
        count[x] := i;
        inc(temp, i);
        If temp <= mincost then
        Begin
            If x < n then Find(x + 1) else
                If Check(start) then
                Begin
                    mincost := temp;
                    res := count;
                End;
        End;
        dec(temp, i);
    End;
End;

Procedure PrintResult;
Var i, j : byte;
Begin
    If mincost > n * 3 then write(0) else
        For i := 1 to n do
            For j := 1 to res[i] do write(i);
End;

BEGIN
    Enter;
    Find(1);
    PrintResult;
END.