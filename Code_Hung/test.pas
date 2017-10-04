var
    a, b: string;
    nho, num, num1, num2: integer;
    i : integer;
    res: string;

function cong(s1, s2: string): string;
begin
    while (length(s1) < length(s2)) do s1 := '0' + s1;
    while (length(s2) < length(s1)) do s2 := '0' + s2;

    nho := 0;
    res := '';
    for i := length(s1) downto 1 do
    begin
        num1 := ord(s1[i]) - 48;
        num2 := ord(s2[i]) - 48;
        num := num1 + num2 + nho;

        nho := num div 10;
        num := num mod 10;

        res := char(num + 48) + res;
    end;

    if (nho > 0) then res := '1' + res;

    cong := res;
end;

//function tru(s1, s2: string): string;
//begin
//end;

begin
    readln(a);
    readln(b);
    a[1] := '';

    writeln(a);

//    writeln(cong(a, b));
//    writeln(tru(a, b));
end.
