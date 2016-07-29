{$MODE OBJFPC}
program PAGAIN;
const
  k = 10;

var
  n : QWord;
  nTests : Integer;

function Power(a, d : QWord) : QWord;
begin
  if d = 0 then Exit(1);
  result := Power(a, d shr 1);
  result := (result * result) mod n;
  if Odd(d) then
    result := (a * result) mod n;
end;

function RabinMiller : Boolean;
var
  d, a, x : QWord;
  s, i, r : Integer;
begin
  if n = 2 then Exit(true);
  d := n - 1;
  s := 0;
  while d mod 2 = 0 do
    begin
      s := s + 1;
      d := d shr 1;
    end;
  for i := 1 to k do
    begin
      a := Random(Int64(n) - 2) + 2;
      x := Power(a, d);
      if (x = 1) or (x = n - 1) then Continue;
      for r := 1 to s - 1 do
        begin
          x := (x * x) mod n;
          if x = 1 then Exit(false);
          if x = n - 1 then Break;
        end;
      if x <> n - 1 then Exit(false);
    end;
  Exit(true);
end;

begin
  ReadLn(nTests);
  while nTests > 0 do
    begin
      nTests := nTests - 1;
      ReadLn(n);
      repeat n := n - 1 until RabinMiller;
      WriteLn(n);
    end;
end.