program tinh_tong;

var
    a : Integer;
    s : real; 
    i: integer;
    factor: real;
begin
    writeln('Nhap a');
    readln(a);

    S := 0;
    
    i := -1;
    while (i < 100) do
    begin
        i := i + 1;
        S := S + 1 / (a + i);
    end;
    
    writeln('S = ', S);
end.

