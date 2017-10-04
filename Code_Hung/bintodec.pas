const
    fi = 'base.inp';
    fo = 'base.out';

var
    s: string;

procedure Read_File;
begin
    readln(s);
end;


function ham_mu(n: integer): integer;
var
    res, i: integer;
begin
    res := 1;
    for i := 1 to n do
    begin
        res := res * 2;
    end;
    ham_mu := res;

end;

procedure Main;
var
    num, res, i: integer;
    mu: integer;
begin

    res := 0;
    for i := 1 to length(s) do
    begin
        num := integer(s[i]) - 48;
        mu := ham_mu(length(s) - i);
        res := res + num * mu;
    end;
    writeln(res);

end;

begin
    assign(input, fi); reset(input);
    assign(output, fo); rewrite(output);
    Read_File;
    Main;
    close(input);
    close(output);
end.