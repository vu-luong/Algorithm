Program CLOCK;
Const n = 9;
      change : array[1..n, 1..n] of byte =
       ((1, 1, 0, 1, 1, 0, 0, 0, 0),
        (1, 1, 1, 0, 0, 0, 0, 0, 0),
        (0, 1, 1, 0, 1, 1, 0, 0, 0),
        (1, 0, 0, 1, 0, 0, 1, 0, 0),
        (0, 1, 0, 1, 1, 1, 0, 1, 0),
        (0, 0, 1, 0, 0, 1, 0, 0, 1),
        (0, 0, 0, 1, 1, 0, 1, 1, 0),
        (0, 0, 0, 0, 0, 0, 1, 1, 1),
        (0, 0, 0, 0, 1, 1, 0, 1, 1));
Type TClock = array[1..n] of byte;
Var a, count : TClock;

Procedure Enter;
Var i : byte;
    t : char;
Begin
    For i := 1 to 9 do
    Begin
        read(t);
        a[i] := ord(t) - 48;
        If i mod 3 = 0 then readln;
    End;
End;

Procedure PrintResult;
Var sum, i : byte;
Begin
    sum := 0;
    For i := 1 to n do inc(sum, count[i]);
    writeln(sum);
End;

Function Check(a : TClock) : boolean;
Var i, j : byte;
Begin
    For i := 1 to n do
        If count[i] <> 0 then
            For j := 1 to n do
                If change[i, j] <> 0 then a[j] := (a[j] + count[i]) mod 4;
    For i := 1 to n do
        If a[i] <> 0 then exit(false);
    exit(true);
End;

Procedure Find(x : byte);
Var i : byte;
Begin
    For i := 0 to 3 do
    Begin
        count[x] := i;
        If x < n then Find(x + 1) else
            If Check(a) then
            Begin
                PrintResult;
                halt;
            End;
    End;
End;

BEGIN
    Enter;
    Find(1);
END.