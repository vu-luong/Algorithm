{$MODE OBJFPC}
{$INLINE ON}
program MAXARR2;
const
  maxC = Round(1e18);
  maxH = 1500;

type
  THeap = record
   nItems : Integer;
   item : array[1..maxH] of int64;
  end;

var
  heap : THeap;
  id, value : array[1..maxH] of int64;
  count, nTest : Integer;
  n, max : Int64;


function GetValue(x : Int64) : Int64; inline;
var
  x1, x2 : Int64;
begin
  if x < 2 then Exit(x);
  while x and 1 = 0 do x := x shr 1;
  if x < 3 then Exit(1);
  x := x shr 1;
  x1 := 1; x2 := 1;
  while x >= 2 do
    begin
      if x and 1 = 0 then Inc(x1, x2) else Inc(x2, x1);
      x := x shr 1;
    end;
  Exit(x1 + x2);
end;

procedure Insert(v : Int64); inline;
var
  p, c : Integer;
begin
  if v > maxC then Exit;
  with heap do
    begin
      Inc(nItems);
      c := nItems;
      repeat
        p := c shr 1;
        if (p = 0) or (item[p] <= v) then Break;
        item[c] := item[p];
        c := p;
      until false;
      item[c] := v;
    end;
end;

function Extract : Int64; inline;
var
  p, c : Integer;
  v : Int64;
begin
  with heap do
    begin
      result := item[1];
      v := item[nItems];
      Dec(nItems);
      p := 1;
      repeat
        c := p shl 1;
        if (c < nItems) and (item[c + 1] < item[c]) then Inc(c);
        if (c > nItems) or (v <= item[c]) then Break;
        item[p] := item[c];
        p := c;
      until false;
      item[p] := v;
    end;
end;

procedure Init;
var
  u, v : Int64;
begin
  max := -1;
  Insert(1);
  while heap.nItems > 0 do
    begin
      u := Extract;
      v := GetValue(u);
      with heap do
        while (item[1] = u) and (nItems > 0) do u := Extract;
      if v > max then
        begin
          Inc(count);
          id[count] := u;
          value[count] := v;
          max := v;

          Insert(u shl 1 - 1);
          Insert(u shl 1 + 1);
          Insert(u shl 2 - 1);
          Insert(u shl 2 + 1);
        end;
    end;
end;

procedure Solve;
var
  i, low, high, mid : Integer;
  res : Int64;
begin
  ReadLn(nTest);
  for i := 1 to nTest do
    begin
      ReadLn(n);
      low := 1; high := count;
      repeat
        mid := (low + high) shr 1;
        if id[mid] <= n then low := mid + 1
        else high := mid - 1;
      until low > high;
      WriteLn(value[high]);
    end;
end;

begin
  Init;
  Solve;
end.
