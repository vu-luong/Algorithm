{$MODE OBJFPC}
program KSPREE;
uses
  Math;

const
  maxN = 20;
  maxF = 100 * maxN + 1;

var
  a, mark : array[1..maxN] of Integer;
  n, res, res_, sum, count : Integer;

procedure Enter;
var
  i : Integer;
begin
  ReadLn(n);
  for i := 1 to n do
    begin
      Read(a[i]);
      Inc(sum, a[i]);
    end;
  count := n;
  res := maxF;
end;

procedure Find;
var
  i, l, r, s, c : Integer;
begin
  if count = 0 then res := Min(res, res_) else
  for i := 1 to n do
    if mark[i] = 0 then
      begin
        if i > 1 then l := i - 1 else l := n;
        if i < n then r := i + 1 else r := 1;
        s := a[i]; c := 1;
        if mark[l] = 0 then
          begin Inc(s, a[l]); Inc(c); end;
        if mark[r] = 0 then
          begin Inc(s, a[r]); Inc(c); end;

        Inc(mark[i]); Inc(mark[l]); Inc(mark[r]);
        Dec(count, c);
        Dec(sum, s);
        Inc(res_, sum);

        if res_ < res then Find;

        Dec(mark[i]); Dec(mark[l]); Dec(mark[r]);
        Inc(count, c);
        Dec(res_, sum);
        Inc(sum, s);
      end;
end;

procedure Print;
begin
  Write(res);
end;

begin
  Enter;
  Find;
  Print;
end.