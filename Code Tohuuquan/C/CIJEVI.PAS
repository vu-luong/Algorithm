{$MODE OBJFPC}
{$INLINE ON}
program CIJEVI;
const
  maxR = 25;
  maxC = 25;

var
  a : array[1..maxR, 1..maxC] of Char;
  r, c : Integer;

procedure Enter;
var
  i, j : Integer;
begin
  ReadLn(r, c);
  for i := 1 to r do
    begin
      for j := 1 to c do Read(a[i, j]);
      ReadLn;
    end;
end;

function Up(i, j : Integer) : Boolean; inline;
begin
  if (i > 1) and (a[i - 1, j] in ['+', '|', '1', '4'])
    then Exit(true) else Exit(false);
end;

function Down(i, j : Integer) : Boolean; inline;
begin
  if (i < r) and (a[i + 1, j] in ['+', '|', '2', '3'])
    then Exit(true) else Exit(false);
end;

function Left(i, j : Integer) : Boolean; inline;
begin
  if (j > 1) and (a[i, j - 1] in ['+', '-', '1', '2'])
    then Exit(true) else Exit(false);
end;

function Right(i, j : Integer) : Boolean; inline;
begin
  if (j < c) and (a[i, j + 1] in ['+', '-', '3', '4'])
    then Exit(true) else Exit(false);
end;

procedure Print(x, y : Integer; ch : Char); inline;
begin
  WriteLn(x, ' ', y, ' ', ch);
  Halt;
end;

procedure Solve;
var
  i, j : integer;
begin
  for i := 1 to r do
    for j := 1 to c do
      if a[i, j] = '.' then
      begin
        if Up(i, j) and Down(i, j) and Left(i, j) and Right(i, j) then
          Print(i, j, '+')
        else if Left(i, j) and Right(i, j) then
          Print(i, j, '-')
        else if Up(i, j) and Down(i, j) then
          Print(i, j, '|')
        else if Right(i, j) and Down(i, j) then
          Print(i, j, '1')
        else if Right(i, j) and Up(i, j) then
          Print(i, j, '2')
        else if Left(i, j) and Up(i, j) then
          Print(i, j, '3')
        else if Left(i, j) and Down(i, j) then
          Print(i, j, '4');
      end;
end;

begin
  Enter;
  Solve;
end.