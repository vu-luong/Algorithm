{$MODE OBJFPC}
{$INLINE ON}
program PBCDIV;
var
  nTests : Integer;
  a, b : Int64;

function Count(x, a, b : Int64) : Int64;
begin
  b := b - b mod x;
  if a mod x <> 0 then
    a := a - a mod x
  else
    a := a - x;

  if a >= b then Exit(0);
  Exit((b - a) div x);
end;

function Cal(a, b : Int64) : Int64; inline;
begin
  result := Count(12, a, b) + Count(30, a, b)
          - 2 * Count(60, a, b);
end;

begin
  ReadLn(nTests);
  while nTests > 0 do
    begin
      Dec(nTests);

      ReadLn(a, b);
      WriteLn(Cal(a, b));
    end;
end.