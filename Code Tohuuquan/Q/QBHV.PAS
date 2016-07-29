Program QBHV;
Const fact : array[1..9] of longint
       = (1, 2, 6, 24, 120, 720, 5040, 40320, 362880);
Var count : array['A'..'Z'] of byte;
    s : string;
    n : byte;

Procedure Enter;
Var i : byte;
Begin
    readln(s);
    n := length(s);
    fillchar(count, sizeof(count), 0);
    For i := 1 to n do inc(count[s[i]]);
End;

Procedure Find(x : byte);
Var i : char;
Begin
    If x > n then writeln(s) else
    For i := 'A' to 'Z' do
        If count[i] > 0 then
        Begin
            s[x] := i;
            dec(count[i]);
            Find(x + 1);
            inc(count[i]);
        End;
End;

Procedure Solve;
Var res : longint;
    i : char;
Begin
    res := fact[n];
    For i := 'A' to 'Z' do
        If count[i] > 0 then res := res div fact[count[i]];
    writeln(res);
    Find(1);
End;

BEGIN
    Enter;
    Solve;
END.