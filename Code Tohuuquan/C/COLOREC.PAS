{$MODE OBJFPC}
program COLOREC;
const
  max = 250;
  bit : array[0..4] of Integer = ( 0, 1, 2, 4, 8 );
  state : array[1..3] of Integer = ( 3, 5, 9 );
  all = 15;

var
  a : array[-max..max, -max..max] of Integer;
  markX, markY : array[-max..max] of Boolean;
  vX, vY : array[1..max * 2] of Integer;
  count : array[0..17] of Int64;
  N, nX, nY : Integer;
  res : Int64;

procedure Enter;
var
  i, x, y, c : Integer;
begin
  ReadLn(N);
  for i := 1 to N do
    begin
      ReadLn(x, y, c);
      a[x, y] := c;

      markX[x] := true;
      markY[y] := true;
    end;

  for i := -max to max do
    begin
      if markX[i] then
        begin
          Inc(nX);
          vX[nX] := i;
        end;
      if markY[i] then
        begin
          Inc(nY);
          vY[nY] := i;
        end;
    end;
end;

procedure Solve;
var
  L, R, i, s : Integer;
begin
  for L := 1 to nX - 1 do
    for R := L + 1 to nX do
      begin
        FillChar(count, SizeOf(count), 0);
        for i := 1 to nY do
          begin
            s := bit[ a[vX[L], vY[i]] ] + bit[ a[vX[R], vY[i]] ];
            count[s] := count[s] + 1;
          end;

        for i := 1 to 3 do
          res := res + count[state[i]] * count[all - state[i]];
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