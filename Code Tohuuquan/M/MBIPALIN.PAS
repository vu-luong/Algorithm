{$MODE OBJFPC}
program MBIPALIN;
const
  maxN = 20 div 2;
  maxM = Round(1e6);

var
  f : array[0..maxM - 1] of Int64;
  t : array[1..maxN] of Integer;
  n, m : Integer;
  res : Int64;

procedure Enter;
begin
  ReadLn(n, m);
  n := n div 2;
end;

procedure Part1;
var
  i, l : Integer;
  ex : Int64;

  procedure Save;
  var
    i, r : Integer;
  begin
    for i := 1 to l do
      t[n - i + 1] := t[i];
    r := 0;
    for i := 1 to n do
      r := (r * 10 + t[i]) mod m;
    r := (ex * r) mod m;

    f[r] := f[r] + 1;
  end;

  procedure Find(x : Integer);
  var
    i : Integer;
  begin
    if x > l then
      begin Save; Exit; end;
    for i := 0 to 9 do
      begin
        t[x] := i;
        Find(x + 1);
      end;
  end;

begin
  ex := 1;
  for i := 1 to n do
    ex := ex * 10;

  l := (n + 1) shr 1;
  for i := 1 to 9 do
    begin
      t[1] := i;
      Find(2);
    end;
end;

procedure Part2;
var
  l : Integer;

  procedure Save;
  var
    i, r : Integer;
  begin
    for i := 1 to l do
      t[n - i + 1] := t[i];
    r := 0;
    for i := 1 to n do
      r := (r * 10 + t[i]) mod m;

    res := res + f[(m - r) mod m];
  end;

  procedure Find(x : Integer);
  var
    i : Integer;
  begin
    if x > l then
      begin Save; Exit; end;
    for i := 0 to 9 do
      begin
        t[x] := i;
        Find(x + 1);
      end;
  end;

begin
  l := (n + 1) shr 1;
  Find(1);
end;


procedure Solve;
begin
  Part1;
  Part2;
  WriteLn(res);
end;

begin
  Enter;
  Solve;
end.