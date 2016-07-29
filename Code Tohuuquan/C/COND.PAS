Program COND;
Const f : array[2..10] of longint =
       (3, 13, 75, 541, 4683, 47293, 545835, 7087261, 102247563);
Var n : shortint;

BEGIN
    Repeat
        readln(n);
        If n <> -1 then writeln(f[n]);
    Until n = -1;
END.