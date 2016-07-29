{$MODE OBJFPC}
program VCRISIS;
uses
  Math;

const
  maxN = 1000;
  maxK = 30 + 1;
  oo = Round(1e9);
  dd : array[1..4] of Char = ( 'E', 'N', 'S', 'W' );
  dx : array[1..4] of Integer = ( 1, 0, 0, -1 );
  dy : array[1..4] of Integer = ( 0, 1, -1, 0 );

var
  x, y : array[1..maxN] of Integer;
  count : array[-maxK..maxK, -maxK..maxK] of Integer;
  f : array[0..maxK, -maxK..maxK, -maxK..maxK] of Integer;
  dir : array[0..maxK, -maxK..maxK, -maxK..maxK] of Char;
  n, m, k, best : Integer;

procedure Enter;
var
  i, j, u, v : Integer;
begin
  ReadLn(n, m, k);
  for i := 1 to n do ReadLn(x[i], y[i]);
  for j := 1 to m do
    begin
      ReadLn(u, v);
      for i := 1 to n do
        if (Abs(u - x[i]) <= k) and (Abs(v - y[i]) <= k) then
          Inc(count[u - x[i], v - y[i]]);
    end;
end;

procedure Solve;
var
  ik, id, i, j, u, v : Integer;
begin
  for ik := 0 to k do
    for i := -k - 1 to k + 1 do
      for j := -k - 1 to k + 1 do
        begin
          f[ik, i, j] := -oo;
          dir[ik, i, j] := 'Z';
        end;

  f[0, 0, 0] := 0;
  for ik := 1 to k do
    for i := -k to k do
      for j := -k to k do
        f[ik, i, j] :=
          count[i, j] + Max( Max(f[ik - 1, i - 1, j], f[ik - 1, i, j - 1]),
                             Max(f[ik - 1, i + 1, j], f[ik - 1, i, j + 1]) );

  for i := -k to k do
    for j := -k to k do
      best := Max(best, f[k, i, j]);

  for i := -k to k do
    for j := -k to k do
      if f[k, i, j] = best then
        dir[k, i, j] := 'Y';

  for ik := k - 1 downto 0 do
    for i := -k to k do
      for j := -k to k do
        for id := 4 downto 1 do
          begin
            u := i + dx[id];
            v := j + dy[id];
            if (dir[ik + 1, u, v] < 'Z') and
               (f[ik + 1, u, v] = count[u, v] + f[ik, i, j]) then
              dir[ik, i, j] := dd[id];
          end;
end;

procedure Print;
var
  ik, i, j : Integer;
begin
  WriteLn(best);

  i := 0; j := 0;
  for ik := 0 to k - 1 do
    begin
      Write(dir[ik, i, j]);
      case dir[ik, i, j] of
        'E' : Inc(i, dx[1]);
        'N' : Inc(j, dy[2]);
        'S' : Inc(j, dy[3]);
        'W' : Inc(i, dx[4]);
      end;
    end;
end;

begin
  Enter;
  Solve;
  Print;
end.