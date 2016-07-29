program NKH;
const maxN = 200;
var res : array[1..maxN] of byte;
    s : array[1..2] of string;
    i : array[1..2] of byte;
    st : string;
    n : byte;

procedure Enter;
begin
    readln(s[1]); s[1] := s[1] + '*';
    readln(s[2]); s[2] := s[2] + '*';
    readln(st);
    n := length(st);
    i[1] := 1;
    i[2] := 1;
end;

procedure Print;
var i : byte;
begin
    for i := 1 to n do write(res[i]);
    halt;
end;

procedure Find(x : byte);
var j : byte;
begin
    if x > n then Print;
    for j := 1 to 2 do
        if st[x] = s[j, i[j]] then
        begin
            res[x] := j;
            inc(i[j]);
            Find(x + 1);
            dec(i[j]);
        end;
end;

begin
    Enter;
    Find(1);
end.