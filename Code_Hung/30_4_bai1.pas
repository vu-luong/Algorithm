program Tim_so;

var
    a, b, c: byte;
begin
    writeln('Tim so co dang abc= a*a*a + b*b*b + c*c*c');
    for a := 1 to 9 do
        for b := 0 to 9 do
            for c := 0 to 9 do
                if ((100 * a + 10 * b + c)= (a*a*a + b*b*b + c*c*c)) then 
                    writeln('So can tim la: ', a, b, c);


    readln;

end.

