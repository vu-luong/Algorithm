{$MODE OBJFPC}
{$INLINE ON}
program DTTUI2;
uses Math;
const maxN = 100;
type TJewel = record
      w, v, a : integer;
     end;
var f : array[1..maxN] of TJewel;
    n, m : integer;
    res, res_, t : integer;

procedure Enter;
var i : integer;
begin
    readln(n, m);
    for i := 1 to n do
        with f[i] do readln(w, v, a);
end;

operator < (const a, b : TJewel) : boolean; inline;
begin
    result := a.v * b.w > b.v * a.w;
end;

procedure Sort(l, r : integer);
var i, j : integer;
    pivot : TJewel;
begin
    if l >= r then exit;
    i := l + random(r - l + 1);
    pivot := f[i]; f[i] := f[l];
    i := l; j := r;
    repeat
        while (pivot < f[j]) and (i < j) do dec(j);
        if i < j then
            begin f[i] := f[j]; inc(i); end
            else break;
        while (f[i] < pivot) and (i < j) do inc(i);
        if i < j then
            begin f[j] := f[i]; dec(j); end
            else break;
    until i = j;
    f[i] := pivot;
    Sort(l, i - 1);
    Sort(i + 1, r);
end;

function Check(x : integer) : boolean; inline;
begin
    with f[x] do
        result := ((trunc((m - t) / w) < a) and (res_ + (v / w) * (m - t) > res))
               or ((trunc((m - t) / w) >= a) and (res_ + a * v > res));
end;

procedure Visit(x : integer);
var i : integer;
begin
    for i := min(f[x].a, (m - t) div f[x].w) downto 0 do
    begin
        inc(t, f[x].w * i);
        inc(res_, f[x].v * i);

        if x = n then res := max(res, res_) else
        if Check(x + 1) then Visit(x + 1);

        dec(t, f[x].w * i);
        dec(res_, f[x].v * i);
    end;
end;

procedure Print;
begin
    writeln(res);
end;

begin
    Enter;
    Sort(1, n);
    Visit(1);
    Print;
end.