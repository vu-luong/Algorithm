program Loc_so_nguyen_to;
var
    a: array [1..200] of integer;
    i, x, s, z: integer;
    b: boolean;




function isPrimes(s: integer): boolean;
var i: integer;

begin

        b:= true;
                if a[i] <= 1 then b:= false;
                for z:= 2 to (s-1) do

                        if a[i] mod z= 0 then b:= false;
        isPrimes:= b;
end;


begin
        s:= 0;
        writeln('Nhap so phan tu: ');
        readln(x);

        for i:= 1 to x do
        begin
                writeln('Nhap a[', i, ']= ');
                readln(a[i]);
        end;

        for i:= 1 to x do
        if isPrimes(a[i]) then

        begin

                writeln(a[i]);

        end;


        writeln('hung');

        readln;
end.









