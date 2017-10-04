program array_sum;     
var 
    n, i: integer;    
    a: array[1..15] of integer;
    s: integer;

begin    
    writeln('Nhap n: ');
    readln(n);

    for i := 1 to n do
    begin
        writeln('Nhap a[', i, ']');
        readln(a[i]);
    end;

    for i := 1 to n do
    begin
        write(a[i], ' ');
    end;
    writeln;

    S := 0;
    for i := 1 to n do
        S := S + a[i];


    writeln('S = ', S);

end.
