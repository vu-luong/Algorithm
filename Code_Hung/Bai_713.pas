program arrayconchoxu;
var
        a: array[1..200] of integer;
        b: array[1..200] of integer;
        i, n, m, j, k:integer;
begin
        readln(m, n);
        for i:= 1 to m do
                read(a[i]);
        for j:= 1 to n do
                readln(b[j]);
        for k:= 1 to n do
        begin
                a[b[k]]:= 0;
                for i:= 1 to m do
                        if a[i]<> 30001 then write (a[i], ' ');
                writeln;
        end;
        readln;
        readln;
end.
