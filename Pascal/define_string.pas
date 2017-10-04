program khai_bao_xau;

var 
    s: string;
    i: integer;
    res: string;
begin

    writeln('Nhap s = ');
    readln(s);

    res := '';
    for i := 1 to length(s) do
        if (s[i] <> ' ') then
            res := res + s[i];

    writeln(res);
end.
