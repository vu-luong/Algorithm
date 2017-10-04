program HelloWord;     

var
    a: array[1..15, 1..15] of integer;
    n: integer;
    S: integer;
    i, j : integer;
begin

    write('n = ');
    readln(n);
    
    S := 0;

    for i := 1 to n do 
        for j := 1 to n do
        begin
            writeln('Nhap a[', i, ',', j, ']');
            readln(a[i, j]);
        end;


    for i := 1 to n do
    begin
        for j := 1 to n do 
        begin
            write(a[i, j], ' ');
        end;
        writeln;
    end;


    writeln('S = ', S);

end.
