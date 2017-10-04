program Tinh_lai_suat;

var
    x: longint; (*tien gui*)
    k: integer; (*lai suat/thang*)
    c: integer; (*chu ki*)
    t: integer; (*so thang*)
    a: real;
    g: integer; (*so thang t>c*)

function Tinh_so_mu (var m, n: integer): real;
var y: real;
    i: integer;
    h: real;
begin
    h := (100 + n)/100;
    y := 1;
    for i := 1 to m do
        y := y*h;
    Tinh_so_mu:=y;
end;


begin
    write('Nhap vao so tien gui: ');
    readln(x);
    write('Nhap vao phan tram lai suat (%): ');
    readln(k);
    write('Nhap vao chu ki: ');
    readln(c);
    write('Nhap vao so thang gui tien: ');
    readln(t);

    if (t<c) then
    begin
        writeln('So tien nhan duoc la: ', x);
        writeln('Do chua du chu ki nen khong duoc tinh lai');
    end;
    if (t=c) then
    begin

        a:= x * Tinh_so_mu (t,k);
        writeln('So tien nhan sau ', t, ' thang la: ', a);
    end;
    if (t>c) then
    begin
        g:= (trunc(t/c))*c;
        a:= x * Tinh_so_mu(g,k);
        writeln('So tien nhan sau ', t, ' thang la: ', a);
    end;



    readln;
end.



