program Ice_is_awesome;
var
    max, min: integer;
    n, i: integer;
    a: array[1..200] of integer;
    tang, giam: integer;
begin
    write('Nhap so km: ');
    readln(n);
    for i:= 1 to n do
    begin
        write('Do cao cua km ', i, ' la: ');
        readln(a[i]);
    end;

    max:= -10000;
    for i:= 1 to n do
    begin
        if a[i]>max then max:= a[i];
    end;
    writeln('Chieu cao lon nhat la: ', max);

    min:= 10000;
    for i:= 1 to n do
    begin
        if a[i]<min then min:= a[i];
    end;
    writeln('Chieu cao nho nhat la: ', min);

    tang:= 0;
    giam:= 0;

    for i:= 1 to n do
    begin
        if (i mod 2 = 1) then
        begin
            tang:= tang+(max- a[i]);
            a[i]:= max;
        end
        else
        begin
            giam:= giam+(a[i]-min);
            a[i]:= min;
        end;
    end;

    writeln ('Do cao can tang len la: ', tang);
    write('Do cao can giam la: ', giam);
    readln;
    readln;
end.

