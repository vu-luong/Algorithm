{$MODE OBJFPC}
{$INLINE ON}
program TWINSNOWS;
const
  maxN = Round(1e5);

type
  Arr = array[1..6] of Integer;

var
  a : array[1..maxN] of Arr;
  n : Integer;

operator < (const x, y : Arr) : Boolean; inline;
var
  i : Integer;
begin
  for i := 1 to 6 do
    if x[i] > y[i] then
      Exit(false)
    else if x[i] < y[i] then
      Exit(true)
    else
      result := false;
end;

procedure Enter;
var
  m, m2 : Arr;
  i, j, z, s : Integer;
begin
  ReadLn(n);
  for i := 1 to n do
    begin
      for j := 1 to 6 do Read(a[i, j]);
      m2 := a[i];
      for j := 2 to 6 do
        begin
          s := 0;
          for z := j to 6 do
            begin
              Inc(s);
              m[s] := a[i, z];
            end;
          for z := 1 to j - 1 do m[s + z] := a[i, z];
          if m < m2 then m2 := m;
        end;
      for j := 6 downto 1 do
        begin
          s := 0;
          for z := j downto 1 do
            begin
              Inc(s);
              m[s] := a[i, z];
            end;
          for z := 6 downto j + 1 do m[s + 6 - z + 1] := a[i, z];
          if m < m2 then m2 := m;
        end;
      a[i] := m2;
    end;
end;

procedure Sort(l, r : Integer);
var
  i, j : Integer;
  pivot : Arr;
begin
  if l >= r then Exit;
  i := l + Random(r - l + 1);
  pivot := a[i]; a[i] := a[l];
  i := l; j := r;
  repeat
    while (pivot < a[j]) and (i < j) do Dec(j);
    if i < j then
      begin a[i] := a[j]; Inc(i); end
      else Break;
    while (a[i] < pivot) and (i < j) do Inc(i);
    if i < j then
      begin a[j] := a[i]; Dec(j); end
      else Break;
  until i = j;
  a[i] := pivot;
  Sort(l, i - 1);
  Sort(i + 1, r);
end;

procedure Print;
var
  i, j : Integer;
  ok : Boolean;
begin
  for i := 2 to n do
    begin
      ok := true;
      for j := 1 to 6 do
        if a[i, j] <> a[i - 1, j] then
          begin
            ok := false;
            Break;
          end;
      if ok then
        begin
          WriteLn('Twin snowflakes found.');
          Exit;
        end;
    end;
  WriteLn('No two snowflakes are alike.');
end;

begin
  Enter;
  Sort(1, n);
  Print;
end.