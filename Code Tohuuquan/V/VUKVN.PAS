{$MODE OBJFPC}
{$INLINE ON}
program VUKVN;
uses
  Math;

const
  maxN = 500;
  maxM = 500;
  maxF = maxN + maxM + 1;
  dx : array[1..4] of Integer = ( 0, -1, 0, 1 );
  dy : array[1..4] of Integer = ( -1, 0, 1, 0 );

type
  TCord = record
   x, y : Integer;
  end;

var
  a : array[1..maxN, 1..maxM + 1] of Char;
  c : array[1..maxN, 1..maxM] of Integer;
  queue : array[1..maxN * maxM] of TCord;
  free : array[1..maxN, 1..maxM] of Boolean;
  n, m, count, res, first, last : Integer;
  s, f : TCord;

function Check(u : TCord) : Boolean; inline;
begin
  with u do
    result := (1 <= x) and (x <= n) and (1 <= y) and (y <= m);
end;

procedure Enter;
var
  i, j, k : Integer;
  u, v : TCord;
begin
  first := 1; last := 0;
  FillChar(free, SizeOf(free), true);

  ReadLn(n, m);
  for i := 1 to n do
    begin
      ReadLn(a[i]);
      for j := 1 to m do
        case a[i, j] of
         'V':
           begin s.x := i; s.y := j; end;
         'J':
           begin f.x := i; f.y := j; end;
         '+':
           begin
             Inc(last);
             queue[last].x := i;
             queue[last].y := j;
             free[i, j] := false;
           end;
        end;
    end;

  repeat
    u := queue[first]; Inc(first);
    for i := 1 to 4 do
      begin
        v.x := u.x + dx[i];
        v.y := u.y + dy[i];
        if Check(v) and free[v.x, v.y] then
          begin
            c[v.x, v.y] := c[u.x, u.y] + 1;
            free[v.x, v.y] := false;
            Inc(last);
            queue[last] := v;
          end;
      end;
  until first > last;
end;

function BFS(dist : Integer) : Boolean; inline;
var
  u, v : TCord;
  i : Integer;
begin
  FillChar(free, SizeOf(free), true);
  free[s.x, s.y] := false;
  first := 1; last := 1;
  queue[1] := s;
  repeat
    u := queue[first]; Inc(first);
    for i := 1 to 4 do
      begin
        v.x := u.x + dx[i];
        v.y := u.y + dy[i];
        if Check(v) and free[v.x, v.y] and (c[v.x, v.y] >= dist) then
          begin
            if (v.x = f.x) and (v.y = f.y) then Exit(true);
            Inc(last); queue[last] := v;
            free[v.x, v.y] := false;
          end;
      end;
  until first > last;
  Exit(false);
end;

procedure Solve;
var
  low, high, mid : Integer;
begin
  low := 1; high := c[s.x, s.y];
  repeat
    mid := (low + high) shr 1;
    if BFS(mid) then low := mid + 1
    else high := mid - 1;
  until low > high;
  WriteLn(high);
end;


begin
  Enter;
  Solve;
end.