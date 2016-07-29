{$MODE OBJFPC}
{$INLINE ON}
program LABUDOVI;
const
  maxR = 1500;
  maxC = 1500;
  dx : array[1..4] of Integer = ( 0, -1, 0, 1 );
  dy : array[1..4] of Integer = ( -1, 0, 1, 0 );

type
  TCord = record
    x, y : Integer;
  end;
  TQueue = record
    first, last : Integer;
    item : array[1..maxR * maxC] of TCord;
  end;

procedure Init(var q : TQueue); inline;
begin
  with q do
    begin
      first := 1;
      last := 0;
    end;
end;

procedure Push(var q : TQueue; x : TCord); inline;
begin
  with q do
    begin
      Inc(last);
      item[last] := x;
    end;
end;

function Pop(var q : TQueue) : TCord; inline;
begin
  with q do
    begin
      result := item[first];
      Inc(first);
    end;
end;

function Empty(const q : TQueue) : Boolean; inline;
begin
  with q do
    Exit(first > last);
end;

var
  a : array[1..maxR, 1..maxC + 1] of Char;
  freeL, freeR : array[1..maxR, 1..maxC] of Boolean;
  preL, preR, nowL, nowR : TQueue;
  r, c, res : Integer;
  L1, L2 : TCord;

procedure Enter;
var
  i, j : Integer;
  u : TCord;
begin
  Init(preL); Init(preR); Init(nowL); Init(nowR);
  FillChar(freeL, SizeOf(freeL), true);
  FillChar(freeR, SizeOf(freeR), true);

  ReadLn(r, c);
  for i := 1 to r do
    begin
      ReadLn(a[i]);
      for j := 1 to c do
        begin
          if a[i, j] = 'L' then
            begin
              if L1.x = 0 then
                begin
                  L1.x := i; L1.y := j;
                  freeL[i, j] := false;
                  Push(preL, L1);
                end
              else
                begin L2.x := i; L2.y := j; end;
              a[i, j] := '.';
            end;

          if a[i, j] = '.' then
            begin
              freeR[i, j] := false;
              u.x := i; u.y := j;
              Push(preR, u);
            end;
        end;
    end;
end;

function Check(u : TCord) : Boolean; inline;
begin
  with u do
    result := (1 <= x) and (x <= r) and (1 <= y) and (y <= c);
end;

procedure Solve;
var
  u, v : TCord;
  i : Integer;
begin
  res := -1;
  while freeL[L2.x, L2.y] do
    begin
      Inc(res);
      while not Empty(preL) do Push(nowL, Pop(preL));
      while not Empty(preR) do Push(nowR, Pop(preR));

      while not Empty(nowR) do
        begin
          u := Pop(nowR);
          a[u.x, u.y] := '.';
          for i := 1 to 4 do
            begin
              v.x := u.x + dx[i];
              v.y := u.y + dy[i];
              if Check(v) and freeR[v.x, v.y] then
                begin
                  freeR[v.x, v.y] := false;
                  Push(preR, v);
                end;
            end;
        end;

      while not Empty(nowL) do
        begin
          u := Pop(nowL);
          for i := 1 to 4 do
            begin
              v.x := u.x + dx[i];
              v.y := u.y + dy[i];
              if Check(v) and freeL[v.x, v.y] then
                begin
                  freeL[v.x, v.y] := false;
                  if a[v.x, v.y] = '.' then Push(nowL, v) else
                  if a[v.x, v.y] = 'X' then Push(preL, v);
                end;
            end;
        end;
    end;
end;

procedure Print;
begin
  WriteLn(res);
end;

begin
  Enter;
  Solve;
  Print;
end.
