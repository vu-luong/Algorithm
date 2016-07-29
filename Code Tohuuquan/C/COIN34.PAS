{$MODE OBJFPC}
{$INLINE ON}
program COIN34;
uses
  Math;

const
  n = 34;
  n1 = 19;
  n2 = n - n1;
  maxS = 200066;

var
  bit : array[1..n1 + 1] of Integer;
  c : array[1..n] of Integer;
  f : array[0..maxS] of Integer;
  x, res, nTests, t : Integer;


procedure Init;
var
  i, j, sum, count : Integer;
begin
  c[1] := 2; c[2] := 3; c[3] := 5;
  for i := 4 to n do
    c[i] := c[i - 1] + c[i - 2] + c[i - 3];

  bit[1] := 1;
  for i := 2 to n1 + 1 do bit[i] := bit[i - 1] shl 1;

  for i := 1 to maxS do f[i] := -1;
  for i := 1 to bit[n1 + 1] - 1 do
    begin
      sum := 0; count := 0;
      for j := 1 to n1 do
        if i and bit[j] > 0 then
          begin
            Inc(sum, c[j]);
            Inc(count);
          end;
      f[sum] := Max(f[sum], count);
    end;
end;

procedure Solve; inline;
var
  i, j, sum, count : Integer;
  check : Boolean;
begin
  for i := 1 to bit[n2 + 1] - 1 do
    begin
      sum := x; count := 0; check := true;
      for j := 1 to n2 do
        if i and bit[j] > 0 then
          begin
            Dec(sum, c[n1 + j]);
            Inc(count);
            if sum < 0 then
              begin
                check := false;
                Break;
              end;
          end;
      if check and (sum <= maxS) and (f[sum] >= 0) then
        res := Max(res, f[sum] + count);
    end;
end;

begin
  Init;
  ReadLn(nTests);
  for t := 1 to nTests do
    begin
      ReadLn(x);
      if x <= maxS then res := f[x] else
        begin
          res := -1;
          Solve;
        end;
      WriteLn('Case #', t, ': ', res);
    end;
end.