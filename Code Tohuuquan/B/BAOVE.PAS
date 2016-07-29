{$MODE OBJFPC}
program BAOVE;
uses
  Math;

const
  maxN = 5000;
  maxM = 10000;
  maxC = 65000;

type
  TEdge = record
    x, y, c, f : Integer;
  end;
  TQueue = record
    front, rear : Integer;
    item : array[1..maxN] of Integer;
  end;

var
  e : array[-maxM..maxM] of TEdge;
  link : array[-maxM..maxM] of Integer;
  head, trace : array[1..maxN] of Integer;
  queue : TQueue;
  n, m : Integer;
  res : Int64;

procedure Enter;
var
  u, v, capacity : Integer;
begin
  ReadLn(n);
  while not Eof do
    begin
      Inc(m);
      ReadLn(u, v, capacity);
      with e[m] do
        begin
          x := u; y := v; c := capacity;
          link[m] := head[x];
          head[x] := m;
        end;
      with e[-m] do
        begin
          x := v; y := u;
          link[-m] := head[x];
          head[x] := -m;
        end;
    end;
end;

function FindPath : Boolean;
var
  i, u, v : Integer;
begin
  FillChar(trace, n * SizeOf(trace[1]), 0);
  with queue do
    begin
      front := 1; rear := 1;
      item[1] := n;
      trace[n] := 1;
      repeat
        u := item[front]; Inc(front);
        i := head[u];
        while i <> 0 do
          begin
            v := e[i].y;
            if (trace[v] = 0) and (e[i].c > e[i].f) then
              begin
                trace[v] := i;
                if v = 1 then Exit(true);
                Inc(rear); item[rear] := v;
              end;
            i := link[i];
          end;
      until front > rear;
      Exit(false);
    end;
end;

procedure AugmentFlow;
var
  i, v, delta : Integer;
begin
  delta := maxC;
  v := 1;
  repeat
    i := trace[v];
    delta := Min(delta, e[i].c - e[i].f);
    v := e[i].x;
  until v = n;
  v := 1;
  repeat
    i := trace[v];
    Inc(e[i].f, delta);
    Dec(e[-i].f, delta);
    v := e[i].x;
  until v = n;
  res := res + delta;
end;

procedure Print;
begin
  WriteLn(res);
end;

begin
  Enter;
  while FindPath do AugmentFlow;
  Print;
end.