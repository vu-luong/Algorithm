Program IOIBIN;
Const n = 10000;
Var root : array[1..n] of integer;
    p, x, y : word;
    z : byte;

Procedure Init;
Var i : word;
Begin
    For i := 1 to n do root[i] := -1;
End;

Function GetRoot(x : word) : word;
Begin
    While root[x] > 0 do x := root[x];
    exit(x);
End;

Procedure Union(x, y : word);
Var temp : integer;
Begin
    If x = y then exit;
    temp := root[x] + root[y];
    If root[x] < root[y] then
        Begin
            root[x] := temp;
            root[y] := x;
        End
    Else
        Begin
            root[x] := y;
            root[y] := temp;
        End;
End;

BEGIN
    Init;
    readln(p);
    While p > 0 do
    Begin
        readln(x, y, z);
        If z = 1 then Union(GetRoot(x), GetRoot(y)) else
        If GetRoot(x) = GetRoot(y) then writeln(1) else writeln(0);
        dec(p);
    End;
END.