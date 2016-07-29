{$MODE OBJFPC}
program CNTEWS;
const maxN = 25000;
type Arr = array[1..maxN] of integer;
var a, b : Arr;
    n, x, y, res : integer;

procedure Sort(var p : Arr);

 procedure Partition(l, r : integer);
 var i, j, pivot : integer;
 begin
     if l >= r then exit;
     i := l + random(r - l + 1);
     pivot := p[i]; p[i] := p[l];
     i := l; j := r;
     repeat
         while (pivot < p[j]) and (i < j) do dec(j);
         if i < j then
             begin p[i] := p[j]; inc(i); end
             else break;
         while (p[i] < pivot) and (i < j) do inc(i);
         if i < j then
             begin p[j] := p[i]; dec(j); end
             else break;
     until i = j;
     p[i] := pivot;
     Partition(l, i - 1);
     Partition(i + 1, r);
 end;

begin
    Partition(1, n);
end;

procedure Enter;
var i : integer;
begin
    readln(n, x, y);
    for i := 1 to n do readln(a[i], b[i]);
    Sort(a);
    Sort(b);
end;

procedure Solve;
var i, j : integer;
begin
    j := 0;
    for i := 1 to n do
    begin
        inc(j);
        if a[i] < b[j] then inc(res, (b[j] - a[i]) * x)
        else inc(res, (a[i] - b[j]) * y);
    end;
    write(res);
end;

begin
    Enter;
    Solve;
end.