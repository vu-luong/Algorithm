program Loc_so_nguyen_to;
var
    a: array [1..200] of integer;
    i, x: integer;
    b: boolean;

function isPrimes(s: integer):boolean;
var i: integer;
begin
    b := true;
    if s <= 1 then b := false;
    for i := 2 to (s - 1) do
        if s mod i = 0 then b := false;

    isPrimes := b;
end;

begin
    writeln('Nhap so phan tu: ');
    readln(x);

    for i:= 1 to x do
    begin
        writeln('Nhap a[', i, ']= ');
        readln(a[i]);
    end;

    for i := 1 to x do
    begin
    b := isPrimes(a[i]);
        if b then
        begin
            writeln(a[i]);
        end;
    end;
end.








