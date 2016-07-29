{$MODE OBJFPC}
{$OPTIMIZATION ON}
program PBCISPIS;
var
  last : packed array['A'..'Z'] of Integer;
  n, res, i : Integer;
  c : Char;

begin
  i := 1;
  while not EoLn do
    begin
      n := n + 1;
      Read(c);
      if i <= last[c] then
        begin
          res := res + 1;
          i := n;
        end;
      last[c] := n;
    end;
  WriteLn(n * 2 - res);
end.