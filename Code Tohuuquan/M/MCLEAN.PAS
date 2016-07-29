{$MODE OBJFPC}
{$INLINE ON}
program MCLEAN;
uses
  Math;

const
  maxH = 20;
  maxW = 20;
  maxR = 10;
  maxC = 10000;
  dx : array[1..4] of Integer = ( 0, -1, 0, 1 );
  dy : array[1..4] of Integer = ( -1, 0, 1, 0 );
  bit : array[1..11] of Integer =
    (1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024);

type
  TPoint = record
    x, y : Integer;
  end;

var
  a : array[1..maxH, 1..maxW + 1] of Char;
  r : array[1..maxR] of TPoint;
  d : array[1..maxR, 1..maxR] of Integer;
  w, h, n, res, first, last : Integer;

procedure Enter; inline;
var
  i, j : Integer;
begin
  n := 1;
  for i := 1 to h do
    begin
      ReadLn(a[i]);
      for j := 1 to w do
        case a[i, j] of
          'o' :
            begin r[1].x := i; r[1].y := j; end;
          '*' :
            begin
              Inc(n);
              r[n].x := i; r[n].y := j;
            end;
        end;
    end;
end;

function Check(u : TPoint) : Boolean; inline;
begin
  with u do
    result := (1 <= x) and (x <= h) and (1 <= y) and (y <= w);
end;

procedure Init; inline;
var
  c : array[1..maxH, 1..maxW] of Integer;
  queue : array[1..maxH * maxW] of TPoint;
  free : array[1..maxH, 1..maxW] of Boolean;
  s, i : Integer;
  u, v : TPoint;
begin
  for s := 1 to n do
    begin
      FillChar(free, SizeOf(free), true);
      FillChar(c, SizeOf(c), 0);
      first := 1; last := 1;
      queue[1] := r[s];
      free[r[s].x, r[s].y] := false;

      repeat
        u := queue[first]; Inc(first);
        for i := 1 to 4 do
          begin
            v.x := u.x + dx[i];
            v.y := u.y + dy[i];
            if Check(v) and free[v.x, v.y] and (a[v.x, v.y] <> 'x') then
              begin
                c[v.x, v.y] := c[u.x, u.y] + 1;
                free[v.x, v.y] := false;
                Inc(last);
                queue[last] := v;
              end;
          end;
      until first > last;

      for i := 1 to n do
        begin
          d[s, i] := c[r[i].x, r[i].y];
          if (i <> s) and (d[s, i] = 0) then d[s, i] := maxC;
        end;
    end;
end;

procedure Solve; inline;
var
  f : array[1..maxR, 0..1 shl (maxR + 1)] of Integer;
  i, j, x, y : Integer;
begin
  for j := 1 to bit[n + 1] - 1 do
    for i := 1 to n do
      begin
        f[i, j] := maxC;
        if j and bit[i] > 0 then
          begin
            y := j - bit[i];
            if y = 0 then f[i, j] := 0 else
              for x := 1 to n do
                if y and bit[x] > 0 then
                  f[i, j] := Min(f[i, j], f[x, y] + d[x, i]);
          end;
      end;

  res := f[1, bit[n + 1] - 1];
  if res = maxC then res := -1;
end;

procedure Print; inline;
begin
  WriteLn(res);
end;

begin
  repeat
    ReadLn(w, h);
    if w * h = 0 then Break;

    Enter;
    Init;
    Solve;
    Print;
  until false;
end.
