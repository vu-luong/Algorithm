program Trong_am_tu;

var
    s: string;
    j: integer;
    a: char;
begin
    write('Insert word: ');
    readln(s);
    for j:= 1 to length(s) do
    begin
        a:= s[j];
        if s[j] <> upcase(a) then write(s[j]);
    end;
    readln
end.

