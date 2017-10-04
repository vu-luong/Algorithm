program Tim_uoc_chung;
var
    a: integer;
    b: integer;
    t, i: integer;
    BCNN, UCLN: integer;


begin
    write('Nhap a: ');
    readln(a);
    writeln;
    write('Nhap b: ');
    readln(b);
    BCNN:= a*b;
    i:= b mod a;
    while i <> 0 do
    begin
        i:= a mod b;
        a:= b;
        b:= i;
    end;
    UCLN:= a;
    BCNN:= BCNN div UCLN;
    writeln('BCNN la: ', BCNN);
    write('UCLN la: ', UCLN);
    readln;
end.



