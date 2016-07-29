{$MODE OBJFPC}
program NKPOS;
const
  maxN = 200;
  maxM = maxN * (maxN - 1) div 2;

type
  TArc = record
    x, y, edge : Integer;
  end;

var
  a : array[1..maxM * 2] of TArc;
  link, res : array[1..maxM * 2] of Integer;
  head : array[1..maxN] of Integer;
  deleted : array[1..maxM] of Boolean;
  stack : array[1..maxM + 1] of Integer;
  n, m, top, count : Integer;

procedure Enter;
var
  i, j, u, v : Integer;
begin
  ReadLn(n, m);
  for i := 1 to n do Read(u);
  j := m * 2;
  for i := 1 to m do
    begin
      ReadLn(u, v);
      with a[i] do
        begin x := u; y := v; edge := i; end;
      with a[j] do
        begin x := v; y := u; edge := i; end;
      Dec(j);
    end;
  for i := 1 to m * 2 do
    with a[i] do
      begin
        link[i] := head[y];
        head[y] := i;
      end;
end;

procedure Solve;
var
  i, u : Integer;
begin
  top := 1;
  stack[1] := 1;
  repeat
    u := stack[top];
    i := head[u];
    while (i > 0) and (deleted[a[i].edge]) do i := link[i];
    head[u] := i;
    if i > 0 then
      begin
        Inc(top);
        stack[top] := a[i].x;
        deleted[a[i].edge] := true;
      end
    else
      begin
        Inc(count);
        res[count] := u;
        Dec(top);
      end;
  until top = 0;
end;

procedure Print;
var
  i : Integer;
begin
  WriteLn(count - 1);
  for i := count downto 1 do Write(res[i], ' ');
end;

begin
  Enter;
  Solve;
  Print;
end.