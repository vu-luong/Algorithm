program permutation;

var
    n, i: integer;
    a: array[1..1000] of integer;
    b: array[1..1000] of boolean;
    {b[i] = true neu gia tri i xuat hien trong mang a}
    
begin

    readln(n);
    for i := 1 to n do
        read(a[i]);

    for i := 1 to n do
        b[i] := false;
    
    for i := 1 to n do
        b[a[i]] := true;
    
    for i := 1 to n do
        if (b[i] = false) then
        begin
            writeln('Khong phai hoan vi');
            exit;
        end;

    writeln('la hoan vi');

end.    
