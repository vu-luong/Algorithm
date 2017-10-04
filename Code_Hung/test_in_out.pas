var
    s1, s2: string;

begin

    assign(input, 'input.txt');
    reset(input);
    assign(output, 'output.txt');
    rewrite(output);

    writeln(power(1, 5));

    readln;

    close(input);
    close(output);
end.
