var
    m, n: integer;
    a: array[1..100, 1..100] of integer;

procedure NhapDL;
var
    i, j: integer;
begin
    writeln('Nhap vao so hang va so cot');
    readln(m, n);
    writeln('Nhap mang:');

    for i:= 1 to m do
        for j:=1 to n do
        begin
            write('Nhap a[', i, ', ', j, ']: ');
            readln(a[i, j]);
        end;
end;

procedure Tinh_tich_am_hang_chan;
var 
    kq, i, j: integer;
begin
    kq := 1;
    for i := 1 to m do 
        for j := 1 to n do
            if (i mod 2 = 0) and (a[i, j] < 0) then
                kq := kq * a[i, j];

    writeln('Tich cac phan tu am thuoc hang chan: ', kq);

end;

procedure Tinh_tong_duong_cot_le;
var
    kq, i, j: integer;
begin
    kq := 0;
    for i := 1 to m do 
        for j := 1 to n do
            if (j mod 2 = 1) and (a[i, j] > 0) then
                kq := kq + a[i, j];
    writeln('Tong cac phan tu duong thuoc cot le: ', kq);
end;

procedure Dem_0_khong_thuoc_le_chan;
var
    kq, i, j: integer;
begin
    kq := 0;
    for i := 1 to m do
        for j := 1 to n do
            if (i mod 2 <> 1) and (j mod 2 <> 0) and (a[i, j] = 0) then
                kq := kq + 1;

    writeln('So luong phan tu co gia tri bang 0 khong thuoc hang le va cot chan: ', kq);
end;

procedure So_sanh_tich_tong;
var
    tich, tong, i, j: integer;
begin
    tich := 1;
    tong := 0;

    for i := 1 to m do 
        for j := 1 to n do
        begin
            tich := tich * a[i, j];
            tong := tong + a[i, j];
        end;

    if (tich > tong) then writeln('Tich lon hon tong');
    if (tich = tong) then writeln('Tich bang tong');
    if (tich < tong) then writeln('Tich be hon tong');

end;

begin
    NhapDL;
    Tinh_tich_am_hang_chan;
    Tinh_tong_duong_cot_le;
    Dem_0_khong_thuoc_le_chan;
    So_sanh_tich_tong;
end.
