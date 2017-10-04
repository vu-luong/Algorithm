var
        a, b, i, c, n: integer;

begin
        writeln('nhap n:');
        readln(n);

        a := 1;
        b := 1;
        c := 1;
        for i := 3 to n do
        begin
                c := a + b;
                a := b;
                b := c;
        end;

        writeln(c);
        readln;

end.