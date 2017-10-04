const
    fi = 'SPIRAL.INP';
    fo = 'SPIRAL.OUT';
    MAXN = 105;


var
    n: integer;
    a: array[1..MAXN, 1..MAXN] of integer;

procedure read_input;
begin
    readln(n);
end;

procedure main;
var
    start, count: integer;
    i, j: integer;
begin   
    start := 1; {-> loop}
    count := 0; {-> keep track the value of each cell}
    while (count < n*n) do
    begin
        {Duyet theo chieu ngang phia tren} 
        for i := start to n - start + 1 do
        begin
            count := count + 1;
            a[start, i] := count;
        end;
        {Duyet theo chieu doc ben phai}
        for i := start + 1 to n - start + 1 do
        begin
            count := count + 1;
            a[i, n - start + 1] := count;
        end;

        {Duyet theo chieu ngang phia duoi}
        for i := n - start downto start do
        begin
            count := count + 1;
            a[n - start + 1, i] := count;
        end;

        {Duyet theo chieu doc ben trai}
        for i := n - start downto start + 1 do
        begin
            count := count + 1;
            a[i, start] := count;
        end;
        start := start + 1;
    end;


    for i := 1 to n do 
    begin
        for j := 1 to n do
            write(a[i, j]:4);
        writeln;
    end;
    
end;


begin
    assign(input, fi); reset(input);
    assign(output, fo); rewrite(output);
    read_input;
    main;
    close(input);
    close(output);
end.    
