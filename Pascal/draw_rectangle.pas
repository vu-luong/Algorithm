program HelloWord;     

var 
    i, j: Integer;

procedure ve_hcn(m: integer; n: integer);
begin
    for i := 1 to m do 
    begin
        if (i <> 1) and (i <> m) then
        begin
            write('*');
            for j := 1 to n - 2 do
                write(' ');
            writeln('*');
        end
        else
        begin
            for j := 1 to n do 
                write('*');
            writeln;
        end;
    end;
end;

begin
    
    ve_hcn(5,3);
    ve_hcn(10, 15);


end.
