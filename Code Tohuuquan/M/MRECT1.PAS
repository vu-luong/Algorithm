{$MODE OBJFPC}
program MRECT1;
const
  maxN = Round(3e5);

type
  TCoord = record
    x, y : Integer;
  end;

function Coord(x, y : Integer) : TCoord;
begin
  result.x := x;
  result.y := y;
end;

function XLower(const u, v : TCoord) : Boolean;
begin
  result := (u.x < v.x) or (u.x = v.x) and (u.y < v.y);
end;

function YLower(const u, v : TCoord) : Boolean;
begin
  result := (u.y < v.y) or (u.y = v.y) and (u.x < v.x);
end;

function Equal(const u, v : TCoord) : Boolean;
begin
  result := (u.x = v.x) and (u.y = v.y);
end;

var
  aX, aY : array[1..maxN] of TCoord;
  n, p : Integer;

procedure Enter;
var
  i : Integer;
begin
  ReadLn(n);
  for i := 1 to n do
    begin
      with aX[i] do ReadLn(x, y);
      aY[i] := aX[i];
    end;
end;

procedure SortX(l, r : Integer);
var
  i, j : Integer;
  pivot : TCoord;
begin
  if l >= r then Exit;
  i := l + Random(r - l + 1);
  pivot := aX[i]; aX[i] := aX[l];
  i := l; j := r;
  repeat
    while XLower(pivot, aX[j]) and (i < j) do Dec(j);
    if i < j then
      begin aX[i] := aX[j]; Inc(i); end
      else Break;
    while XLower(aX[i], pivot) and (i < j) do Inc(i);
    if i < j then
      begin aX[j] := aX[i]; Dec(j); end
      else Break;
  until false;
  aX[i] := pivot;
  SortX(l, i - 1);
  SortX(i + 1, r);
end;

procedure SortY(l, r : Integer);
var
  i, j : Integer;
  pivot : TCoord;
begin
  if l >= r then Exit;
  i := l + Random(r - l + 1);
  pivot := aY[i]; aY[i] := aY[l];
  i := l; j := r;
  repeat
    while YLower(pivot, aY[j]) and (i < j) do Dec(j);
    if i < j then
      begin aY[i] := aY[j]; Inc(i); end
      else Break;
    while YLower(aY[i], pivot) and (i < j) do Inc(i);
    if i < j then
      begin aY[j] := aY[i]; Dec(j); end
      else Break;
  until false;
  aY[i] := pivot;
  SortY(l, i - 1);
  SortY(i + 1, r);
end;

procedure Init;
begin
  SortX(1, n);
  SortY(1, n);
end;

function SegmentX(const a, b : TCoord) : Integer;
var
  low, high, mid : Integer;
begin
  low := 1; high := n;
  repeat
    mid := (low + high) shr 1;
    if XLower(b, aX[mid]) then
      high := mid - 1
    else
      low := mid + 1;
  until low > high;
  result := low;

  low := 1; high := n;
  repeat
    mid := (low + high) shr 1;
    if XLower(a, aX[mid]) then
      high := mid - 1
    else
      low := mid + 1;
  until low > high;
  if (low > 1) and Equal(aX[low - 1], a) then Dec(low);
  Dec(result, low);
end;

function SegmentY(const a, b : TCoord) : Integer;
var
  s1, s2, low, high, mid : Integer;
begin
  low := 1; high := n;
  repeat
    mid := (low + high) shr 1;
    if YLower(b, aY[mid]) then
      high := mid - 1
    else
      low := mid + 1;
  until low > high;
  result := low;

  low := 1; high := n;
  repeat
    mid := (low + high) shr 1;
    if YLower(a, aY[mid]) then
      high := mid - 1
    else
      low := mid + 1;
  until low > high;
  if (low > 1) and Equal(aY[low - 1], a) then Dec(low);
  Dec(result, low);
end;

procedure Solve;
var
  i, x1, y1, x2, y2, res : Integer;
begin
  ReadLn(p);
  for i := 1 to p do
    begin
      ReadLn(x1, y1, x2, y2);

      res :=
        SegmentX(Coord(x1, y1), Coord(x1, y2)) +
        SegmentX(Coord(x2, y1), Coord(x2, y2)) +
        SegmentY(Coord(x1 + 1, y1), Coord(x2 - 1, y1)) +
        SegmentY(Coord(x1 + 1, y2), Coord(x2 - 1, y2));

      WriteLn(res);
    end;
end;

begin
  Enter;
  Init;
  Solve;
end.