Program PYRAMID2;
Var n, max : longint;
    s : ansistring;

Procedure Enter;
Begin
    readln(n);
    readln(s);
    s := s + ' ';
End;

Procedure Solve;
Var i, right, left : longint;
Begin
    max := 0;
    right := 0;
    left := 0;
    i := 1;
    While s[i] = '<' do inc(i);
    While i < length(s) do
    Begin
        If s[i] = '>' then
            Begin
                inc(right);
                If left >= 0 then dec(left);
            End
        Else
            Begin
                inc(left);
                If max < right + left then max := right + left;
            End;
        inc(i);
    End;
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