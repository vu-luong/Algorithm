{$MODE OBJFPC}
program MTOTALF;
uses
  Math;

const
  N = 52;
  maxM = 700 * 2;
  maxC = 1000;

type
  TEdge = record
    x, y, f, c : Integer;
  end;
  TQueue = record
    front, rear : Integer;
    item : array[1..N] of Integer;
  end;

var
  e : array[-maxM..maxM] of TEdge;
  link : array[-maxM..maxM] of Integer;
  head, trace : array[1..N] of Integer;
  queue : TQueue;
  m, s, t, res : Integer;

procedure Enter;
var
  i, u, v, capacity : Integer;
  sCode : String;
  st : String[3];
  c : Char;
begin
  sCode := '';
  for c := 'a' to 'z' do
    sCode := sCode + c + Upcase(c);
  s := Pos('A', sCode);
  t := Pos('Z', sCode);

  ReadLn(m);
  for i := 1 to m do
    begin
      ReadLn(st, capacity);
      u := Pos(st[1], sCode);
      v := Pos(st[3], sCode);

      with e[i] do
        begin
          x := u; y := v; c := capacity;
          link[i] := head[x];
          head[x] := i;
        end;
      with e[-i] do
        begin
          x := v; y := u;
          link[-i] := head[x];
          head[x] := -i;
        end;
    end;
end;

function FindPath : Boolean;
var
  i, u, v : Integer;
begin
  FillChar(trace, SizeOf(trace), 0);
  with queue do
    begin
      trace[s] := 1;
      front := 1; rear := 1;
      item[1] := s;
      repeat
        u := item[front]; Inc(front);
        i := head[u];
        while i <> 0 do
          begin
            v := e[i].y;
            if (trace[v] = 0) and (e[i].c > e[i].f) then
              begin
                trace[v] := i;
                if v = t then Exit(true);
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
  v := t;
  repeat
    i := trace[v];
    delta := Min(delta, e[i].c - e[i].f);
    v := e[i].x;
  until v = s;
  v := t;
  repeat
    i := trace[v];
    Inc(e[i].f, delta);
    Dec(e[-i].f, delta);
    v := e[i].x;
  until v = s;
  Inc(res, delta);
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