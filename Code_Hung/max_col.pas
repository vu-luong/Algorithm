program Cot_max;

var
    a: array [1..15, 1..15] of integer;
    i: integer;
    j: integer;
    m, n: integer;
    s: array [1..15] of integer;
    max: integer;
    cs: integer;
begin
    write('Nhap so hang: ');
    readln(n);
    write('Nhap so cot: ');
    readln(m);
    for i:= 1 to n do
    begin
        for j:= 1 to m do
        begin
            write('a[', i,',', j, ']= ');
            read(a[i,j]);
        end;
        readln;
    end;
    for i:=1 to n do
    begin
        for j:=1 to m do
        begin
            write(a[i,j],'   ');
        end;
        writeln;
    end;

    for j:= 1 to m do
    begin
        s[j]:= 0;
        for i:= 1 to n do
            s[j]:= s[j] + a[i,j];
        writeln ('s[', j, ']:= ', s[j], '  ');
    end;
    max:= s[1];
    cs := 1;
    for j:= 1 to m do
    begin
        if s[j] > max then 
        begin
            max:= s[j];
            cs := j;
        end;
    end;
    writeln('Max la:= ', max);

    writeln('Cot co gia tri lon nha la: ', cs);
    readln;
end.






