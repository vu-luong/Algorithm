program Insert_number;

var
    s: string;
    j: integer;
    a: integer;
begin
    write('Nhap cum tu: ');
    readln(s);
    for j:= 1 to length(s) do
        if (s[j] < '0') or (s[j] > '9')  then 
            write (s[j]);

    readln;
end.
