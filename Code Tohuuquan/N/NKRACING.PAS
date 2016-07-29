{$MODE OBJFPC}
program NKRACING;
const
  maxN = Round(1e4);
  maxM = Round(1e5);

type
  TEdge = record
    u, v, w : Integer;
  end;

var
  e : array[1..maxM + 1] of TEdge;
  lab : array[1..maxN] of Integer;
  n, m, sum : Integer;

procedure Enter;
var
  i : Integer;
begin
  ReadLn(n, m);
  for i := 1 to m do
    with e[i] do
      begin
        ReadLn(u, v, w);
        Inc(sum, w);
      end;
  Inc(m);
  e[m].w := 0;
end;

procedure AdjHeap(p, last : Integer);
var
  c : Integer;
  v : TEdge;
begin
  v := e[p];
  repeat
    c := p shl 1;
    if (c < last) and (e[c + 1].w > e[c].w) then Inc(c);
    if (c > last) or (v.w >= e[c].w) then Break;
    e[p] := e[c];
    p := c;
  until false;
  e[p] := v;
end;

function FindRoot(u : Integer) : Integer;
begin
  if lab[u] <= 0 then Exit(u) else
    begin
      result := FindRoot(lab[u]);
      lab[u] := result;
    end;
end;

procedure Union(r1, r2 : Integer);
begin
  if lab[r1] < lab[r2] then lab[r2] := r1 else
    begin
      if lab[r1] = lab[r2] then Dec(lab[r2]);
      lab[r1] := r2;
    end;
end;

procedure Solve;
var
  i, r1, r2, count : Integer;
  t : TEdge;
begin
  for i := m shr 1 downto 1 do AdjHeap(i, m);
  for i := m downto 2 do
    begin
      t := e[1]; e[1] := e[i]; e[i] := t;
      AdjHeap(1, i - 1);

      with e[i] do
        begin
          r1 := FindRoot(u);
          r2 := FindRoot(v);
          if r1 <> r2 then
            begin
              Dec(sum, w);
              Union(r1, r2);
              Inc(count);
              if count = n - 1 then Exit;
            end;
        end;
    end;
end;

procedure Print;
begin
  WriteLn(sum);
end;

begin
  Enter;
  Solve;
  Print;
end.