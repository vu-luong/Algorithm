{$MODE OBJFPC}
program NKBUS;
const
  maxN = Round(2e5);

type
  THeap = record
    nItems : Integer;
    item : array[1..maxN] of Integer;
  end;

var
  heap : ^THeap;
  n, time, m, bus : Integer;

procedure Insert(v : Integer);
var
  p, c : Integer;
begin
  with heap^ do
    begin
      nItems := nItems + 1;
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

function Extract : Integer;
var
  p, c, v : Integer;
begin
  with heap^ do
    begin
      result := item[1];
      v := item[nItems];
      nItems := nItems - 1;
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

procedure Solve;
var
  i, j, t, x, num : Integer;
begin
  New(heap);
  heap^.nItems := 0;

  ReadLn(n, m);
  for i := 1 to n do
    begin
      Read(t, num);
      for j := 1 to num do
        begin
          Read(x);
          if bus < m then
            if x <= time then
              bus := bus + 1
            else
              Insert(x - time);
        end;
      time := time + t;
    end;
  for i := 1 to m - bus do x := Extract;
  time := time + x;

  Dispose(heap);
end;

procedure Print;
begin
  WriteLn(time);
end;

begin
  Solve;
  Print;
end.