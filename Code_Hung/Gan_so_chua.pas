program Gan_so;

var
    a: array[1..20] of integer;
    b: array[1..20] of integer;
    c: array[1..20] of integer;
    i,n: integer;
begin
    write ('Nhap n:= ');
    readln(n);
    for i:=1 to n do
    begin
        write('Nhap a[',i,']: ');
        read(a[i]);
    end;

    for i:= 1 to n do
    begin
        write('b[', i, ']:= ');
        read(b[i]);
    end;

    for i := 1 to 2*n do
    begin
        if (i mod 2 = 1) then
        begin
            c[i]:= a[(i + 1) div 2];
        end
        else c[i]:= b[i div 2];

        write(c[i], ' ');

    end;


end.
