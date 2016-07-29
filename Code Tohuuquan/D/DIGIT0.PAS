Program DIGIT0;
Const maxn = 10000;
Var count : array['a'..'z'] of word;
    d2, d5 : array[1..maxn] of longint;
    s : ansistring;
    n : word;

Procedure Enter;
Var i : word;
Begin
    readln(s);
    n := length(s);
    fillchar(count, sizeof(count), 0);
    For i := 1 to n do inc(count[s[i]]);
End;

Procedure Solve;
Var sum : longint;
    i, temp : word;
Begin
    sum := 0;
    For i := 1 to n do
    Begin
        temp := i;
        While temp mod 2 = 0 do
        Begin
            temp := temp div 2;
            inc(sum);
        End;
        d2[i] := sum;
    End;
    sum := 0;
    For i := 1 to n do
    Begin
        temp := i;
        While temp mod 5 = 0 do
        Begin
            temp := temp div 5;
            inc(sum);
        End;
        d5[i] := sum;
    End;
End;

Procedure PrintResult;
Var s2, s5 : longint;
    i : char;
Begin
    s2 := d2[n];
    s5 := d5[n];
    For i := 'a' to 'z' do
        If count[i] > 0 then
        Begin
            dec(s2, d2[count[i]]);
            dec(s5, d5[count[i]]);
        End;
    If s2 < s5 then write(s2) else write(s5);
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.
