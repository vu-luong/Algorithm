Program SNSEQ;
Var n, m : word;
    b, c, s, t : real;

BEGIN
    readln(n, c);
    dec(n);
    m := trunc(sqrt(c));
    If m >= n then
    Begin
        writeln('0.00');
        halt;
    End;
    If c / m <= m + 1 then
    Begin
        b := m + c / m;
        s := n * n - b * n + c;
    End Else s := 1e100;
    inc(m);
    If c / m >= m - 1 then
    Begin
        b := m + c / m;
        t := n * n - b * n + c;
    End Else t := 1e100;
    If s < t then writeln(s : 0 : 2)
    else writeln(t : 0 : 2);
END.