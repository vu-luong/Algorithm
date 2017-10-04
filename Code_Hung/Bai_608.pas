program Beautiful_matrix;
var
        a: array[1..200, 1..200] of integer;
        i, j, k, g, x, s: integer;
        n, res: integer;
begin
        s:= 0;
        readln(n);
        for j:= 1 to n do
                for i:= 1 to n do
                        read(a[i,j]);
        for j:= 1 to n do
        begin
                for i:= 1 to n do
                begin
                        if a[i,j] = 1 then
                        begin
                                k:= i;
                                g:= i;
                        end;
                end;
        end;
        x:= trunc(n div 2)+1;
        s:= s+ abs(k-x) + abs(g-x)- 1;
        writeln(s);
        readln;
        readln;
end.

