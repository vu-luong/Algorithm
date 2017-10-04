const
    fi = 'interval.inp';
    fo = 'interval.out';


var
    n: integer;
    a: array[1..1000] of integer;

procedure Read_input;
var
    i : integer;
begin
    readln(n);
    for i := 1 to n do
        read(a[i]);
end;

function sum(l, r: integer): integer;
var
    i, s: integer;
begin
    s := 0;
    for i := l to r do
        s := s + a[i];
    sum := s;
end;

procedure Main;
var
    max, s, i, j: integer;
begin

    max := -10000;
    for i := 1 to n do
        for j := i to n do
        begin
            s := sum(i, j);
            if (s > max) then max := s;
        end;

    writeln(max);

end;

begin
    assign(input, fi); reset(input);
    assign(output, fo); rewrite(output);
    Read_input;
    Main;
    close(input);
    close(output);
end.