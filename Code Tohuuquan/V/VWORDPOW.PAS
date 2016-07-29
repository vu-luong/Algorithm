Program VWORDPOW;
Const maxn = 1000;
      maxm = 100;
Var a : array[1..maxn] of ansistring;
    b : array[1..maxm] of string;
    n, res : word;
    m : byte;

Procedure Enter;
Var i : word;
Begin
    readln(n, m);
    For i := 1 to n do
    Begin
        readln(a[i]);
        a[i] := Upcase(a[i]);
    End;
    For i := 1 to m do
    Begin
        readln(b[i]);
        b[i] := Upcase(b[i]);
    End;
End;

Function SubString(x : ansistring; y : string) : boolean;
Var i : word;
    j : byte;
Begin
    j := 1;
    For i := 1 to length(x) do
        If x[i] = y[j] then
        Begin
            inc(j);
            If j > length(y) then exit(true);
        End;
    exit(false);
End;

Procedure Solve;
Var i : word;
    j : byte;
Begin
    For i := 1 to n do
    Begin
        res := 0;
        For j := 1 to m do
            If SubString(a[i], b[j]) then inc(res);
        writeln(res);
    End;
End;

BEGIN
    Enter;
    Solve;
END.