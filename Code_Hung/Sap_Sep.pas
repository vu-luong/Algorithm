program Sap_xep;
var
    a: array[1..100] of integer;
    i,n: integer;
    max, min: integer;
    x, x1, x2, k: integer;
begin
    write('Nhap n: ');
    readln(n);
    for i:= 1 to n do
    begin
        write('Nhap a[', i, ']: ');
        readln(a[i]);
    end;

    write('Day so la: ');

    for i:= 1 to n do
    begin
        write(a[i]);
        write(' ');

    end;
    writeln;

    max:= -2000;
    for i:= 1 to n do
    begin
        if a[i]>max then max:= a[i];
    end;
    writeln('max: ', max);

    for i:= 1 to n do
    begin
        if a[i] = max then
        begin
            x1:= i;
            break;
        end;
    end;

    readln;

    min:= 2000;
    for i:= 1 to n do
    begin
        if a[i] <= min then min:= a[i];
    end;

    writeln('min: ', min);
    for i:= n downto 1 do
    begin
        if a[i]= min then
        begin
            x2:= i;
            break;
        end;
    end;

    a[x1]:= min;
    a[x2]:= max;

    for i:= 1 to n do
        write (a[i], '  ');

    readln;

end.





end.
