{$MODE OBJFPC}
program CVJETICI;
const
  maxX = Round(1e5);
  k = 256;

var
  a : array[1..maxX] of Integer;
  b : array[0..maxX div k + 1] of Integer;
  n, l, r, i, x : Integer;

begin
  ReadLn(n);
  for i := 1 to n do
    begin
      ReadLn(l, r);
      WriteLn(a[l] + b[l div k] + a[r] + b[r div k]);

      a[l] := -b[l div k];
      a[r] := -b[r div k];

      x := l + 1;
      while (x < r) and (x mod k <> 0) do
        begin
          a[x] := a[x] + 1;
          x := x + 1;
        end;

      while x + k <= r do
        begin
          b[x div k] := b[x div k] + 1;
          x := x + k;
        end;

      while x < r do
        begin
          a[x] := a[x] + 1;
          x := x + 1;
        end;
    end;
end.