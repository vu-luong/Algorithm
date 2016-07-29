{$MODE OBJFPC}
{$INLINE ON}
program MCLONUM;
var
  s : array['0'..'9'] of Integer;
  a, b, upper, lower : String;
  n : Integer;

procedure Enter;
var
  i : integer;
begin
  ReadLn(a);
  ReadLn(b);
  n := Length(a);
  for i := 1 to n do Inc(s[b[i]]);
end;

function CheckUpper(x : Integer) : Boolean; inline;
var
  i : Integer;
begin
  for i := 1 to x do
    if a[i] < b[i] then Exit(true) else
    if a[i] > b[i] then Exit(false);
  Exit(true);
end;

procedure FindUpper(x : Integer);
var
  i : Char;
begin
  if x > n then upper := b;
  if Length(upper) > 1 then Exit;
  for i := '0' to '9' do
    if s[i] > 0 then
      begin
        b[x] := i;
        if CheckUpper(x) then
          begin
            Dec(s[i]);
            FindUpper(x + 1);
            Inc(s[i]);
          end;
      end;
end;

function CheckLower(x : Integer) : Boolean; inline;
var
  i : Integer;
begin
  for i := 1 to x do
    if a[i] > b[i] then Exit(true) else
    if a[i] < b[i] then Exit(false);
  Exit(True);
end;

procedure FindLower(x : Integer);
var
  i : Char;
begin
  if x > n then
    begin
      if a <> b then lower := b;
      Exit;
    end;
  if Length(lower) > 1 then Exit;
  for i := '9' downto '0' do
    if s[i] > 0 then
      begin
        b[x] := i;
        if CheckLower(x) then
          begin
            Dec(s[i]);
            FindLower(x + 1);
            Inc(s[i]);
          end;
      end;
end;

procedure Solve;
var
  i : Char;
begin
  upper := '0';
  lower := '0';

  for i := '1' to '9' do
    if (i >= a[1]) and (s[i] > 0) then
      begin
        b[1] := i;
        Dec(s[i]);
        FindUpper(2);
        Inc(s[i]);
      end;

  for i := '9' downto '1' do
    if (i <= a[1]) and (s[i] > 0) then
      begin
        b[1] := i;
        Dec(s[i]);
        FindLower(2);
        Inc(s[i]);
      end;
end;

procedure Print;
begin
  WriteLn(upper);
  WriteLn(lower);
end;

begin
  Enter;
  Solve;
  Print;
end.