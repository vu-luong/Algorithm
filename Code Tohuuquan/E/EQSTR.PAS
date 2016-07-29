{$MODE OBJFPC}
program EQSTR;
uses Math;
var a, b, t : string;

procedure Enter;
begin
    readln(a);
    readln(b);
end;

function Dist(a, b : char) : integer;
var t : char;
begin
    if a < b then
    begin
        t := a;
        a := b;
        b := t;
    end;
    result := min(ord(a) - ord(b), ord(b) - ord(a) + 26);
end;

procedure Solve;
var res : string;
    i, m : integer;
    j : char;
begin
    res := a;
    for i := 1 to length(res) do
    begin
        m := Dist(a[i], b[i]);
        for j := 'a' to 'z' do
            if Dist(j, a[i]) + Dist(j, b[i]) = m then
            begin
                res[i] := j;
                break;
            end;
    end;
    writeln(res);
end;

begin
    repeat
        repeat readln(t) until (t = '[CASE]') or (t = '[END]');
        if t = '[END]' then exit;
        Enter;
        Solve;
    until false;
end.