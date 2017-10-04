var
    m, n: integer;
    i, j: integer;
    max, id, s:integer;
    a: array[1..100, 1..100] of integer;

begin
    read(n, m);

    for i := 1 to n do
        for j := 1 to m do
            read(a[i, j]);


    max := -5000;
    id := 0;

    for j := 1 to m do
    begin
         s := 0;
        for i := 1 to n do
            s := s + a[i, j];

        if (s > max) then
        begin
            max := s;
            id := j;
        end;
    end;

    writeln(s, ' ', id);
       
end.
