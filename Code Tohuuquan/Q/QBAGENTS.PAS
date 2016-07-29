{$MODE OBJFPC}
program QBAGENTS;
const
  maxN = 250;
  maxM = maxN * maxN;

type
  TEdge = record
    x, y : Integer;
  end;
  TInfo = record
    p1, p2, code : Integer;
  end;
  TQueue = record
    front, rear : Integer;
    item : array[1..maxN * maxN * 2] of TInfo;
  end;

var
  e : array[1..maxM] of TEdge;
  link : array[1..maxM] of Integer;
  head : array[1..maxN] of Integer;
  time : array[1..maxN, 1..maxN, 0..1] of Integer;
  queue : TQueue;
  n, m, s, t, res : Integer;

procedure Enter;
var
  i : Integer;
begin
  ReadLn(n, m);
  ReadLn(s, t);
  FillChar(head, n * SizeOf(head[1]), 0);
  for i := 1 to m do
    with e[i] do
      begin
        ReadLn(x, y);
        link[i] := head[x];
        head[x] := i;
      end;
end;

procedure Push(q1, q2, c : Integer);
begin
  with queue do
    begin
      Inc(rear);
      with item[rear] do
        begin p1 := q1; p2 := q2; code := c; end;
    end;
end;

procedure Pop(var q1, q2, c : Integer);
begin
  with queue do
    begin
      with item[front] do
        begin q1 := p1; q2 := p2; c := code; end;
      Inc(front);
    end;
end;

procedure Init;
begin
  FillChar(time, SizeOf(time), 0);
  with queue do
    begin
      front := 1; rear := 1;
      with item[1] do
        begin
          p1 := s;
          p2 := t;
          code := 0;
          time[p1, p2, code] := 1;
        end;
    end;
  res := 0;
end;

procedure Solve;
var
  p1, p2, code : Integer;

  procedure Go1;
  var
    i, v : Integer;
  begin
    i := head[p1];
    while i <> 0 do
      begin
        v := e[i].y; i := link[i];
        if time[v, p2, 1] = 0 then
          begin
            time[v, p2, 1] := time[p1, p2, 0] + 1;
            Push(v, p2, 1);
          end;
      end;
  end;

  procedure Go2;
  var
    i, v : Integer;
  begin
    i := head[p2];
    while i <> 0 do
      begin
        v := e[i].y; i := link[i];
        if time[p1, v, 0] = 0 then
          begin
            time[p1, v, 0] := time[p1, p2, 1];
            if p1 = v then
              begin
                res := time[p1, v, 0];
                Exit;
              end;
            Push(p1, v, 0);
          end;
      end;
  end;

begin
  repeat
    Pop(p1, p2, code);
    if code = 0 then Go1;
    if code = 1 then Go2;
  until (queue.front > queue.rear) or (res > 0);
  Dec(res);
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
