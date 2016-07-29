{$MODE OBJFPC}
program NKMOBILE;
const
  maxN = 1024;

var
  node : array[1..maxN, 1..maxN] of Integer;
  n, d, x1, y1, x2, y2, a : Integer;

procedure UpdateY(x, y, a : Integer);
begin
  while y <= n do
    begin
      Inc(Node[x, y], a);
      Inc(y, y and -y);
    end;
end;

procedure Update(x, y, a : Integer);
begin
  while x <= n do
    begin
      UpdateY(x, y, a);
      Inc(x, x and -x);
    end;
end;

function GetY(x, y : Integer) : Integer;
begin
  result := 0;
  while y > 0 do
    begin
      Inc(result, node[x, y]);
      Dec(y, y and -y);
    end;
end;

function Get(x, y : Integer) : Integer;
begin
  result := 0;
  while x > 0 do
    begin
      Inc(result, GetY(x, y));
      Dec(x, x and -x);
    end;
end;

function Sum(x1, y1, x2, y2 : Integer) : Integer;
begin
  result := Get(x2, y2) - Get(x1 - 1, y2) - Get(x2, y1 - 1) + Get(x1 - 1, y1 - 1);
end;

begin
  repeat
    Read(d);
    case d of
      0 :
        ReadLn(n);
      1 :
        begin
          ReadLn(x1, y1, a);
          Update(x1 + 1, y1 + 1, a);
        end;
      2 :
        begin
          ReadLn(x1, y1, x2, y2);
          WriteLn(Sum(x1 + 1, y1 + 1, x2 + 1, y2 + 1));
        end;
      3 :
        Break;
    end;
  until false;
end.