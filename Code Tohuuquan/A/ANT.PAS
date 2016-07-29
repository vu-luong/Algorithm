Program ANT;
Var n, m, p : qword;

BEGIN
    readln(n);
    readln(m);
    p := n * m;
    While p > n do
        p := p - n + (p - n - 1) div (m - 1);
    write(p);
END.