{$MODE OBJFPC}
Program NKCARD;
Const max = 2000000;
Var a : array[0..max] of integer;
    i, m, k, first, last : integer;
    c : char;

BEGIN
    read(m, k);
    dec(m);
    For i := 0 to m do a[i] := i;
    first := 0;
    last := m;
    Repeat
        read(c);
        If c = 'A' then
        Begin
            inc(last);
            a[last] := a[first];
            inc(first);
        End Else
        If c = 'B' then
        Begin
            inc(last);
            a[last] := a[first + 1];
            a[first + 1] := a[first];
            inc(first);
        End;
    Until c = '.';
    writeln(a[first + k - 1], ' ', a[first + k], ' ', a[first + k + 1]);
END.
