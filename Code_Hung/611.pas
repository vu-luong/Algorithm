program Dao_thu_tu;
var
    n, i, k, c: integer;
    j: integer;
    t: integer;
    m: integer;
    a: array [1..200] of integer;
begin
    write('Nhap so so hang: ');
    readln(n);
    for i:= 1 to n do
    begin
        write('Nhap a[', i, ']:= ');
        readln(a[i]);
    end;

    for i:= 1 to n do
    begin
        write(a[i], ' ');
    end;

    writeln;

    write('Nhap so thu tuc: ');
    readln(k);

    for j:= 1 to k do
    begin
        c:=a[n];
        for i:= n - 1 downto 1 do
        begin

            a[i+1]:= a[i];


        end;
        a[1]:=c;
    end;

    write('Day moi la: ');

    for i:= 1 to n do
        write ( a[i], ' ');
    readln;
end.



