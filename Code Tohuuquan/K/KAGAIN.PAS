{$MODE OBJFPC}
Program KAGAIN;
Const maxn = 30001;
Var a, left, right, s, p : array[0..maxn] of integer;
    t, n, top, bot : integer;

Procedure Enter;
Var i : integer;
Begin
    readln(n);
    For i := 1 to n do read(a[i]);
End;

Procedure Init;
Var i : integer;
Begin
    top := 1; bot := 1;
    s[top] := 0; p[top] := 0;
    For i := 1 to n do
    Begin
        While a[i] <= s[top] do dec(top);
        left[i] := p[top] + 1;
        inc(top);
        s[top] := a[i];
        p[top] := i;
    End;

    top := 1; bot := 1;
    s[top] := 0; p[top] := n + 1;
    For i := n downto 1 do
    Begin
        While a[i] <= s[top] do dec(top);
        right[i] := p[top] - 1;
        inc(top);
        s[top] := a[i];
        p[top] := i;
    End;
End;

Procedure Solve;
Var i, max, temp : integer;
Begin
    max := 0;
    For i := 1 to n do
        If (a[i] * (right[i] - left[i] + 1) > max)
           or ((a[i] * (right[i] - left[i] + 1) = max)
              and (left[temp] > left[i]))
        then
            Begin
                max := a[i] * (right[i] - left[i] + 1);
                temp := i;
            End;
    writeln(max, ' ', left[temp], ' ', right[temp]);
End;

BEGIN
    readln(t);
    While t > 0 do
    Begin
        Enter;
        Init;
        Solve;
        dec(t);
    End;
END.