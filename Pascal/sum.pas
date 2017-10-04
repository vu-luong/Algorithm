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
    for i := 0 to 100 do
    begin
        factor := 1 / (a + i);
        S := S + factor;
    end;

    writeln('S = ', S);
end.

