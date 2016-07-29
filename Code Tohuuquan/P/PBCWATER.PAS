{$MODE OBJFPC}
program PBCWATER;
uses
  Math;

const
  maxM = 100;
  maxN = 100;
  maxH = 1000;
  dx : array[1..4] of Integer = ( 0, -1, 0, 1 );
  dy : array[1..4] of Integer = ( -1, 0, 1, 0 );

var
  h : array[1..maxM, 1..maxN] of Integer;
  free, lifted : array[1..maxM, 1..maxN] of Boolean;
  m, n, count, mind, res : Integer;
  isBot : Boolean;

procedure Enter;
var
  i, j : Integer;
begin
  ReadLn(m, n);
  for i := 1 to m do
    for j := 1 to n do Read(h[i, j]);
end;

function Check(x, y : Integer) : Boolean;
begin
  result := (1 < x) and (x < m) and (1 < y) and (y < n);
end;

procedure DFS(x, y : Integer);
var
  i, u, v : Integer;
begin
  free[x, y] := false;
  Inc(count);
  for i := 1 to 4 do
    begin
      u := x + dx[i];
      v := y + dy[i];
      if h[u, v] > h[x, y] then
        mind := Min(mind, h[u, v] - h[x, y]);
      if (h[u, v] < h[x, y]) or
         (h[u, v] = h[x, y]) and (not Check(u, v))
      then
        isBot := false;
      if (h[u, v] = h[x, y]) and free[u, v] then DFS(u, v);
    end;
end;

procedure Lift(x, y, delta : Integer);
var
  i, u, v : Integer;
begin
  lifted[x, y] := true;
  free[x, y] := true;
  for i := 1 to 4 do
    begin
      u := x + dx[i];
      v := y + dy[i];
      if Check(u, v) and (not lifted[u, v]) then
        if h[u, v] = h[x, y] then Lift(u, v, delta) else
          if h[u, v] = h[x, y] + delta then Lift(u, v, 0);
    end;
  Inc(h[x, y], delta);
end;

procedure Solve;
var
  i, j : Integer;
  stop : Boolean;
begin
  FillChar(free, SizeOf(free), true);
  for j := 1 to n do
    begin
     free[1, j] := false;
     free[m, j] := false;
    end;
  for i := 1 to m do
    begin
      free[i, 1] := false;
      free[i, n] := false;
    end;

  repeat
    stop := true;
    for i := 2 to m - 1 do
      for j := 2 to n - 1 do
        begin
          if not free[i, j] then Continue;
          count := 0; isBot := true; mind := maxH;
          DFS(i, j);
          if isBot then
            begin
              stop := false;
              Inc(res, count * mind);
              FillChar(lifted, SizeOf(lifted), false);
              Lift(i, j, mind);
              Break;
            end;
        end;
  until stop;
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