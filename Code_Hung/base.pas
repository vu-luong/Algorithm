const 
    fi = 'base.inp';
    fo = 'base.out';

var
    n: integer;

procedure Read_Input;
begin
    readln(n);
end;

procedure Main;
var
    r: integer;
    s: string;
begin
    s := '';
    while (n <> 0) do
    begin
        r := n mod 2;
        n := n div 2;
        s := char(r + 48) + s;
    end;
    writeln(s);

end;

begin
    assign(input, fi); reset(input);
    assign(output, fo); rewrite(output);
    Read_Input;
    Main;
    close(input);
    close(output);

end.

