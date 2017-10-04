program phan_tich_so_nguyen_to;
var
    n: integer;
    n1: integer;
    t: integer;
    i: integer;
    
function Nguyen_to(var a: integer): boolean;
var b: integer;
x: boolean;
begin
    x:= true;
    for b:= 2 to (a-1) do
        if (a mod b= 0) then x:= false;
    Nguyen_to:= x;
end;


begin
    t:= 0;
    write('Nhap so: ');
    readln(n);
    while n>= 1000 do
    begin

        writeln('Nhap lai so: ');
        readln(n);
    end;
    //cau a//
    if Nguyen_to(n) then
    begin
        writeln('Day la so nguyen to. ');
        write('Cac uoc la: ', '1, ', n);
    end
    else
    begin
        write('n= ');
        i:= 2;
        n1:=n-1;
        while (i<= n1) do
        begin
            if Nguyen_to(i) then
            begin

                while (n mod i= 0) do
                begin
                    n:= n div i;
                    if (n=1) then write(i) else
                        write(i,'*');
                    t:= t+1;
                end;

            end;
            i:=i+1;
        end;
    end;

    writeln;
    writeln('t= ', t);
    readln;
end.
