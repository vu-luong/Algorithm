{$MODE OBJFPC}
{$INLINE ON}
program NKMINES;
uses
  Math;

const
  maxK = 200;
  dx : array[1..7] of Integer = ( -1, -1, -1, 0, 1, 1, 0 );
  dy : array[1..7] of Integer = ( -1, 0, 1, 1, 0, -1, -1 );

var
  a, res : array[0..maxK + 1, 0..maxK + 1] of Integer;
  m, n, k : Integer;

procedure Enter;
var
  i, j : Integer;
begin
  ReadLn(m, n);
  for i := 1 to m do
    for j := 1 to n do Read(a[i, j]);
  k := Max(m, n);
end;

function Sum(x, y : Integer) : Integer; inline;
var
  i : Integer;
begin
  result := 0;
  for i := 1 to 7 do
    Inc(result, res[x + dx[i], y + dy[i]]);
end;

function Check(x : Integer) : Boolean; inline;
begin
  result := (0 <= x) and (x <= 1);
end;

procedure Print;
var
  i, j : Integer;
begin
  for i := m downto 1 do
    for j := n downto 1 do
      if a[i, j] <> Sum(i, j) + res[i + 1, j + 1] then Exit;

  for i := 1 to m do
    begin
      For j := 1 to n do Write(res[i, j], ' ');
      WriteLn;
    end;
  Halt;
end;

procedure Find(x : Integer);
var
  i, j, y : Integer;
  ok : Boolean;
begin
  if x > k then Print else
  for i := 0 to 1 do
    for j := 0 to 1 do
      begin
        if x <= n then res[1, x] := i;
        if x <= m then res[x, 1] := j;

        ok := true;
        for y := 2 to x do
          begin
            if (x <= m) and (y <= n) then
              begin
                res[x, y] := a[x - 1, y - 1] - Sum(x - 1, y - 1);
                if not Check(res[x, y]) then
                  begin ok := false; Break; end;
              end;
            if (y <= m) and (x <= n) then
              begin
                res[y, x] := a[y - 1, x - 1] - Sum(y - 1, x - 1);
                if not Check(res[y, x]) then
                  begin ok := false; Break; end;
              end;
          end;
        if ok then Find(x + 1);
      end;
end;

procedure Solve;
begin
  res[1, 1] := 0;
  Find(2);
  res[1, 1] := 1;
  Find(2);
end;

begin
  Enter;
  Solve;
end.