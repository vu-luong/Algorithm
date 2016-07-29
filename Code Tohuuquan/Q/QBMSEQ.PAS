Program QBMSEQ;
Const maxn = 10000;
Var a : array[0..maxn] of longint;
    f : array[0..maxn] of integer;
    n, max : integer;

Procedure Enter;
Var i : word;
Begin
    readln(n);
    For i := 1 to n do readln(a[i]);
End;

Function Check(s : longint) : boolean;
Var x : longint;
Begin
    s := s shl 1;
    x := trunc(sqrt(s));
    exit(x * (x + 1) = s);
End;

Procedure Solve;
Var i : integer;
Begin
    max := 0;
    a[0] := -1;
    f[0] := -1;
    For i := 1 to n do
        If Check(a[i]) then
        Begin
            If ((a[i] >= a[i - 1]) and (f[i - 1] > -1)) then
                f[i] := f[i - 1] + 1
            else
                f[i] := 1;
            If f[i] > max then max := f[i];
        End Else f[i] := -1;
End;

Procedure PrintResult;
Begin
    writeln(max);
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.
