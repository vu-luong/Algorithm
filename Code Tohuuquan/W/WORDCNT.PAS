Program WORDCNT;
Var n : byte;
    s : ansistring;

Procedure Solve;
Var i, count, max, l : word;
    t : ansistring;
Begin
    i := 1;
    While i < length(s) do
        If (s[i] = ' ') and (s[i + 1] = ' ') then delete(s, i, 1) else inc(i);
    If s[1] = ' ' then delete(s, 1, 1);
    If s[length(s)] <> ' ' then s := s + ' ';

    count := 0;
    max := 0;
    t := '';
    l := 0;
    For i := 1 to length(s) do
        If s[i] <> ' ' then t := t + s[i] else
        Begin
            If length(t) = l then inc(count) else
            Begin
                count := 1;
                l := length(t);
            End;
            If count > max then max := count;
            t := '';
        End;
    writeln(max);
End;

BEGIN
    readln(n);
    While n > 0 do
    Begin
        readln(s);
        Solve;
        dec(n);
    End;
END.
