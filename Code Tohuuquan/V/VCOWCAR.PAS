{$MODE OBJFPC}
program VCOWCAR;
const
  maxN = Round(5e4);

var
  speed : packed array[1..maxN] of Integer;
  n, m, d, l, res, i : Integer;

procedure Sort(l, r : Integer);
var
  i, j, pivot : Integer;
begin
  if l >= r then Exit;
  i := l + Random(r - l + 1);
  pivot := speed[i]; speed[i] := speed[l];
  i := l; j := r;
  repeat
    while (pivot < speed[j]) and (i < j) do Dec(j);
    if i < j then
      begin speed[i] := speed[j]; Inc(i); end
      else Break;
    while (speed[i] < pivot) and (i < j) do Inc(i);
    if i < j then
      begin speed[j] := speed[i]; Dec(j); end
      else Break;
  until i = j;
  speed[i] := pivot;
  Sort(l, i - 1);
  Sort(i + 1, r);
end;

begin
  ReadLn(n, m, d, l);
  for i := 1 to n do Read(speed[i]);
  Sort(1, n);
  for i := 1 to n do
    if speed[i] - d * (res div m) >= l then Inc(res);
  WriteLn(res);
end.