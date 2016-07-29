{$MODE OBJFPC}
program MFISH;
uses
  Math;

const
  maxN = Round(1e5);
  maxM = Round(1e5);

type
  TShip = record
    b, d : Integer;
  end;

var
  ship : array[0..maxM + 1] of TShip;
  river : array[1..maxN] of Integer;
  sum, catch, new : array[0..maxN] of Integer;
  n, m : Integer;

procedure Enter;
var
  i : Integer;
begin
  Read(n);
  for i := 1 to n do Read(river[i]);
  Read(m);
  for i := 1 to m do
    with ship[i] do Read(b, d);
end;

procedure Sort(l, r : Integer);
var
  i, j : Integer;
  pivot : TShip;
begin
  if l >= r then Exit;
  i := l + Random(r - l + 1);
  pivot := ship[i]; ship[i] := ship[l];
  i := l; j := r;
  repeat
    while (pivot.b < ship[j].b) and (i < j) do Dec(j);
    if i < j then
      begin ship[i] := ship[j]; Inc(i); end
      else Break;
    while (ship[i].b < pivot.b) and (i < j) do Inc(i);
    if i < j then
      begin ship[j] := ship[i]; Dec(j); end
      else Break;
  until i = j;
  ship[i] := pivot;
  Sort(l, i - 1);
  Sort(i + 1, r);
end;

procedure Init;
var
  i : Integer;
begin
  Sort(1, m);
  with ship[0] do
    begin b := 0; d := 1; end;
  with ship[m + 1] do
    begin b := n + 1; d := 1; end;

  sum[0] := 0;
  for i := 1 to n do
    sum[i] := sum[i - 1] + river[i];

  for i := 0 to n do catch[i] := 0;
end;

procedure Solve;
var
  i, j, last : Integer;
begin
  for i := 1 to m do
    with ship[i] do
      begin
        new[Max(b, ship[i - 1].b + d) - 1] := 0;

        for j := Max(b, ship[i - 1].b + d) to ship[i + 1].b - 1 do
          begin
            last := Min(b + d - 1, j);
            new[j] := sum[last] - sum[last - d] + catch[last - d];
            new[j] := Max(new[j], new[j - 1]);
          end;

        for j := Max(b, ship[i - 1].b + d) to ship[i + 1].b - 1 do
          catch[j] := new[j];
      end;
end;

procedure Print;
begin
  WriteLn(catch[n]);
end;

begin
  Enter;
  Init;
  Solve;
  Print;
end.