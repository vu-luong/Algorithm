{$MODE OBJFPC}
program NKGOLF;
const
  max = 1000;

var
  z : array[0..max, 0..max] of Integer;
  p, q, h, k, l, r : array[1..max] of Integer;
  m, n, maxS : Integer;

procedure Enter;
var
 i, j : Integer;
begin
  ReadLn(m, n);
  for i := 1 to m do
    for j := 1 to n do Read(z[i, j]);
end;

procedure Update(s : Integer);
begin
  if s > maxS then maxS := s;
end;

procedure CalP(i : Integer);
var
  j : Integer;
begin
  for j := 1 to n do
    if z[i, j] >= z[i - 1, j] then Inc(p[j]) else p[j] := 1;
end;

procedure SearchRow;
var
  i, j : Integer;
begin
  for i := 1 to m do
    begin
      CalP(i);
      for j := 1 to n do Update(p[j]);
    end;
end;

procedure CalQ(i : Integer);
var
  j : Integer;
begin
  for j := 1 to m do
    if z[j, i] >= z[j, i - 1] then Inc(q[j]) else q[j] :=1 ;
end;

procedure SearchColumn;
var
  i, j : Integer;
begin
  for i := 1 to n do
    begin
      CalQ(i);
      for j := 1 to m do Update(q[j]);
    end;
end;

procedure CalH(i : Integer);
var
  j : Integer;
begin
  for j := 1 to n do
    if z[i, j] >= z[i - 1, j] then Inc(h[j]) else h[j] := 1;
end;

procedure CalK(i : Integer);
var
  j : Integer;
begin
  for j := 1 to n do
    if z[i, j] < z[i, j - 1] then k[j] := 0 else
    if z[i, j] >= z[i - 1, j] then Inc(k[j]) else k[j] := 1;
end;

procedure CalL;
var
  i, j : Integer;
begin
  l[1] := 1;
  for i := 2 to n do
    begin
      l[i] := i;
      j := i - 1;
      while (j >= 1) and (k[j] >= k[i]) do
        begin
          l[i] := l[j];
          j := l[j] - 1;
        end;
    end;
end;

procedure Change;
var
  i : Integer;
begin
  for i := 1 to n do
      if (l[i] > 1) and (h[l[i] - 1] >= k[i]) then Dec(l[i]);
end;

procedure CalR;
var
  i, j : Integer;
begin
  r[n] := n;
  for i := n - 1 downto 1 do
    begin
      r[i] := i;
      j := i + 1;
      while (j <= n) and (k[j] >= k[i]) do
        begin
          r[i] := r[j];
          j := r[j] + 1;
        end;
    end;
end;

procedure Search(i : Integer);
var
  j : Integer;
begin
  for j := 1 to n do
    Update(k[j] * (r[j] - l[j] + 1));
end;

procedure Solve;
var
  i : Integer;
begin
  SearchRow;
  SearchColumn;
  for i := 1 to m do
    begin
      CalH(i);
      CalK(i);
      CalL;
      Change;
      CalR;
      Search(i);
    end;
end;

procedure Print;
begin
  WriteLn(maxS);
end;

begin
  Enter;
  Solve;
  Print;
end.