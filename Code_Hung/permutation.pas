program Hoan_vi;
var
    a: array[1..200] of integer;
    b: array[1..200] of integer;
    n, i: integer;
    j: integer;
    t: integer;
    k: boolean;


{

    Neu a_i > 0 -> ok;
    Neu a_i <= 0 -> wrong.

}

begin
    k:= true;
    write('Nhap vao so phan tu: ');
    readln(n);
    for i:= 1 to n do
    begin
        write('Nhap so a[', i, ']: ');
        readln(a[i]);
    end;
    writeln('Day so ban dau la: ');

    b[1]:= 1;
    writeln('So thu 1 la: 1');


    for i:= 2 to n do
    begin

        b[i]:= b[i-1]+1;
        writeln('So thu ', i, ' la: ', b[i]);
    end;
    readln;

    i:= 1;
    for j:= (i+1) to n do
    begin
        if a[j]=a[i] then
        begin
            writeln ('Day khong la hoan vi cua day nhap vao. + 1');
            k:= false;
            break;
        end
        else
            i:= i+1;
    end;
    readln;

    if k = true then
    begin
        for i:= 1 to n do
        begin
            for j:= 1 to n do
            begin
                if a[j]=b[i] then
                begin
                    a[j]:= 0;
                    b[i]:= 0;
                end;


            end;
        end;


        t:= 0;
        for i:= 1 to n do
        begin
            t:= t+a[i];
        end;


        if t= 0 then 
            writeln('Day la day hoan vi cua day nhap vao')
        else
            writeln('Day khong la hoan vi cua day nhap vao');
    end;
    readln;

end.


