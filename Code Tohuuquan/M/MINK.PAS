Program MINK;
Const maxn = 17000;
Var a, s : array[1..maxn] of longint;
    p : array[1..maxn] of word;
    n, k, t : word;

Procedure Enter;
Var i : word;
Begin
    readln(n, k);
    For i := 1 to n do read(a[i]);
End;

Procedure Solve;
Var i, bot, top : word;
Begin
    bot := 1;
    top := 0;
    For i := 1 to k - 1 do
    Begin
        While (top >= bot) and (a[i] < s[top]) do dec(top);
        inc(top);
        s[top] := a[i];
        p[top] := i;
    End;
    For i := 1 to n - k + 1 do
    Begin
        While (top >= bot) and (a[i + k - 1] < s[top]) do dec(top);
        inc(top);
        s[top] := a[i + k - 1];
        p[top] := i + k - 1;
        write(s[bot], ' ');
        While (top >= bot) and (p[bot] <= i) do inc(bot);
    End;
    writeln;
End;

BEGIN
    readln(t);
    While t > 0 do
    Begin
        dec(t);
        Enter;
        Solve;
    End;
END.