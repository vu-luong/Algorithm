{$MODE OBJFPC}
program LQDCANDY;
var
  nTests : Integer;
  n, res : Int64;
  st : String;
  l, cnt, i : Integer;

begin
  ReadLn(nTests);
  while nTests > 0 do
    begin
      Dec(nTests);

      ReadLn(n);
      st := BinStr(n, 60);
      while st[1] = '0' do Delete(st, 1, 1);
      l := Length(st);

      for i := l downto 1 do
        if st[i] = '1' then Break;

      if i = 1 then
        WriteLn(n, ' 0')
      else
        begin
          cnt := i;
          res := 1;
          for i := 1 to l do res := res * 2;

          WriteLn(res, ' ', cnt);
        end;
    end;
end.
