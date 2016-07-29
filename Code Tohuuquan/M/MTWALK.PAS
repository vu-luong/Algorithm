{$MODE OBJFPC}
{$INLINE ON}
program MTWALK;
const
  maxN = 100;
  maxA = 110;
  dx : array[1..4] of Integer = ( 0, -1, 0, 1 );
  dy : array[1..4] of Integer = ( -1, 0, 1, 0 );

var
  a : array[1..maxN, 1..maxN] of Integer;
  free : array[0..maxN + 1, 0..maxN + 1] of Boolean;
  queue : array[1..sqr(maxN), 1..2] of Integer;
  n, low, res, first, last : Integer;

procedure Enter;
var
  i, j : Integer;
begin
  ReadLn(n);
  low := maxA;
  for i := 1 to n do
    for j := 1 to n do
      begin
        Read(a[i, j]);
        if a[i, j] < low then low := a[i, j];
      end;
end;

procedure Init; inline;
var
  i : Integer;
begin
  FillChar(free, SizeOf(free), true);
  for i := 0 to n + 1 do
    begin
      free[i, 0] := false;
      free[i, n + 1] := false;
      free[0, i] := false;
      free[n + 1, i] := false;
    end;
  first := 1;
  last := 0;
end;

procedure Push(const u, v : Integer); inline;
begin
  Inc(last);
  queue[last, 1] := u;
  queue[last, 2] := v;
  free[u, v] := false;
end;

procedure Pop(var u, v : Integer); inline;
begin
  u := queue[first, 1];
  v := queue[first, 2];
  Inc(first);
end;

function BFS(const limit, delta : Integer) : Boolean; inline;
var
  vx, vy, ux, uy, i : Integer;
begin
  Init;
  Push(1, 1);
  repeat
    Pop(ux, uy);
    for i := 1 to 4 do
      begin
        vx := ux + dx[i];
        vy := uy + dy[i];
        if free[vx, vy] then
          if (a[vx, vy] >= limit) and (a[vx, vy] - limit <= delta) then
            begin
              Push(vx, vy);
              if (vx = n) and (vy = n) then exit(true);
            end;
      end;
  until first > last;
  exit(false);
end;

procedure Solve;
var
  i, l, h, m : Integer;
begin
  res := maxA;
  for i := low to a[1, 1] do
    begin
      l := 0; h := maxA;
      repeat
        m := (l + h) shr 1;
        if BFS(i, m) then h := m - 1 else l := m + 1;
      until l > h;
      if l < res then res := l;
    end;
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