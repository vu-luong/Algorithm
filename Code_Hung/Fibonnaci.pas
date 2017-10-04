program Day_Fibonacci;
var
    n, i: longint;
    a, b, c: longint;


begin
    write('Nhap so thu tu cua so n cua day Fibonacci: ');
    readln(n);
    a := 1;
    b := 1;
    for i:= 3 to n do
    begin
        c := a + b;
        a := b;
        b := c;
    end;
    write('So can tim la: ', b);
    readln;
end.



