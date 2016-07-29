{$MODE OBJFPC}
program MCHAOS;
const
  maxN = Round(1e5);

var
  s : array[1..maxN] of String[10];
  node, a : array[1..maxN] of Integer;
  n : Integer;
  res : Int64;

procedure Enter;
var
  i : Integer;
begin
  ReadLn(n);
  for i := 1 to n do ReadLn(s[i]);
end;

procedure Sort1(L, R : Integer);
var
  pivot : String[10];
  i, j : Integer;
begin
  if L >= R then Exit;
  i := L + Random(R - L + 1);
  pivot := s[i]; s[i] := s[L];
  i := L; j := R;
  repeat
    while (i < j) and (s[j] > pivot) do Dec(j);
    if i < j then
      begin s[i] := s[j]; Inc(i); end
      else Break;
    while (i < j) and (s[i] < pivot) do Inc(i);
    if i < j then
      begin s[j] := s[i]; Dec(j); end
      else Break;
  until i = j;
  s[i] := pivot;
  Sort1(L, i - 1);
  Sort1(i + 1, R);
end;

procedure Sort2(L, R : Integer);
var
  pivot, i, j : Integer;
begin
  if L >= R then Exit;
  i := L + Random(R - L + 1);
  pivot := a[i]; a[i] := a[L];
  i := L; j := R;
  repeat
    while (i < j) and (s[a[j]] > s[pivot]) do Dec(j);
    if i < j then
      begin a[i] := a[j]; Inc(i); end
      else Break;
    while (i < j) and (s[a[i]] < s[pivot]) do Inc(i);
    if i < j then
      begin a[j] := a[i]; Dec(j); end
      else Break;
  until i = j;
  a[i] := pivot;
  Sort2(L, i - 1);
  Sort2(i + 1, R);
end;

procedure Init;
var
  i, j : Integer;
  c : Char;
begin
  Sort1(1, n);
  for i := 1 to n do
    begin
      for j := 1 to Length(s[i]) div 2 do
        begin
          c := s[i, j];
          s[i, j] := s[i, Length(s[i]) - j + 1];
          s[i, Length(s[i]) - j + 1] := c;
        end;
      a[i] := i;
    end;
  Sort2(1, n);
end;

function Get(x : Integer) : Int64;
begin
  result := 0;
  while x <= n do
    begin
      result := result + node[x];
      x := x + x and -x;
    end;
end;

procedure Update(x : Integer);
begin
  while x > 0 do
    begin
      node[x] := node[x] + 1;
      x := x - x and -x;
    end;
end;

procedure Solve;
var
  i : Integer;
begin
  for i := 1 to n do
    begin
      res := res + Get(a[i] + 1);
      Update(a[i]);
    end;
end;

procedure Print;
begin
  WriteLn(res);
end;

begin
  Enter;
  Init;
  Solve;
  Print;
end.