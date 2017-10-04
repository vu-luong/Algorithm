const
    fi= 'SQUARE3.inp';
    fo= 'SQUARE3.out';
var
    P: integer;
    a: array[1..300, 1..300] of integer;
    m,n, max: integer;
    
procedure Read_file;
var
    i,k: integer;

begin

    read(m);
    readln(n);
    for i:=1 to m do
        for k:=1 to n do
            read (a[i,k]);
        for i:=1 to m do
        begin
            for k:=1 to n do
                write(a[i,k], ' ');
            writeln;
        end;

    end;


function Tong(c, d: integer): integer;
var
    i, S, j: integer;
begin
    S:= 0;
    for i:= c to c+2 do
        for j:=d to d+2 do
        begin
            S:= S+a[i,j];
        end;
        Tong:= S;
    end;




procedure Main;
var
    i,k: integer;
begin
    max:= -2000;
    for i:=1 to (m-2) do
        for k:=1 to (n-2) do
        begin
            P:= Tong(i,k);
            if P>max then max:=P;

        end;
        writeln('Max la: ', max);
    end;

begin
    assign(input, fi); reset(input);
    assign(output, fo); rewrite(output);
    Read_file;
    Main;
    close(input);
    close(output);
end.

