{$MODE OBJFPC}
{$OPTIMIZATION ON}
program NKINV;
const
  max = Round(6e4);

var
  node : packed array[1..max] of Integer;
  n, x, res, i : Integer;

procedure Update(x : Integer);
begin
  while x > 0 do
    begin
      node[x] := node[x] + 1;
      x := x - (x and -x);
    end;
end;

function Find(x : Integer) : Integer;
begin
  result := 0;
  while x <= max do
    begin
      result := result + node[x];
      x := x + (x and -x);
    end;
end;

begin
  ReadLn(n);
  for i := 1 to n do
    begin
      ReadLn(x);
      res := res + Find(x + 1);
      Update(x);
    end;
  WriteLn(res);
end.