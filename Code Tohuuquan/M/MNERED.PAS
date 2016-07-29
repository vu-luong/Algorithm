{$MODE OBJFPC}
{$INLINE ON}
program MNERED;
uses
  Math;

const
  maxN = 100;

var
  a : array[1..maxN, 1..maxN] of Integer;
  n, k, res : Integer;

procedure Enter;
var
  i, u, v : Integer;
begin
  ReadLn(n, k);
  for i := 1 to k do
    begin
      ReadLn(u, v);
      a[u, v] := 1;
    end;
end;

function Cal(low, high, col : Integer) : Integer; inline;
var
  i : Integer;
begin
  result := 0;
  if col = 0 then Exit;
  for i := low to high do
    Inc(result, a[i, col]);
end;

procedure Solve;
var
  low, high, h, w, sum, col : Integer;
begin
  res := Sqr(n);
  for low := 1 to n do
    for high := low to n do
      begin
        h := high - low + 1;
        if k mod h > 0 then Continue;
        w := k div h;
        if w > n then Continue;

        sum := 0;
        for col := 1 to w - 1 do
          Inc(sum, Cal(low, high, col));
        for col := w to n do
          begin
            sum := sum - Cal(low, high, col - w) + Cal(low, high, col);
            res := Min(res, k - sum);
          end;
      end;
end;

procedure Print;
begin
  WriteLn(res);
end;

begin
  Enter;
  Solve;
  Print;
end.