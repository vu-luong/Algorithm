const 
    fi = 'input.txt';
    fo = 'output.txt';


var 
    x, y: integer;

begin
    assign(input, fi); reset(input);
    assign(output, fo); rewrite(output);

    read(x);
    read(y);
    writeln(x, ', ', y);


    close(input);
    close(output);
end.
    
