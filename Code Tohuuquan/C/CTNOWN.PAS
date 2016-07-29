{$MODE OBJFPC}
program CTNOWN;
const maxN = 350;
      maxM = 70;
var p : array[1..maxM] of integer;
    f : array[0..maxN, 0..maxM] of qword;
    n, m, t : integer;

function Prime(x : integer) : boolean;
var sqrt_x, k : integer;
begin
    if (x = 2) or (x = 3) then exit(true);
    if (x mod 2 = 0) or (x mod 3 = 0) then exit(false);
    sqrt_x := trunc(sqrt(x));
    k := -1;
    repeat
        inc(k, 6);
        if (x mod k = 0) or (x mod (k + 2) = 0) then break;
    until k > sqrt_x;
    exit(k > sqrt_x);
end;

function Max(x, y : qword) : qword;
begin
    if x > y then exit(x) else exit(y);
end;

procedure Init;
var i, j, k : integer;
begin
    for i := 2 to maxN do
        if Prime(i) then
        begin
            inc(m);
            p[m] := i;
        end;

    f[0, 0] := 1;
    f[0, 1] := 1;
    for i := 1 to maxN do
        for j := 1 to m do
            begin
                f[i, j] := Max(f[i - 1, j], f[i, j - 1]);
                k := p[j];
                while k <= i do
                begin
                    f[i, j] := Max(f[i, j], f[i - k, j - 1] * qword(k));
                    k := k * p[j];
                end;
            end;
end;

begin
    Init;
    readln(t);
    while t > 0 do
    begin
        dec(t);
        readln(n);
        writeln(f[n, m]);
    end;
end.
