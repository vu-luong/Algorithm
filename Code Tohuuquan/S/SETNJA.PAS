{$MODE OBJFPC}
{$INLINE ON}
program SETNJA;
const
  radix = Round(1e9);

type
  BigInt = record
    n : Integer;
    digit : array[1..800] of Integer;
  end;

procedure Init(var a : BigInt; x : Integer); inline;
begin
  with a do
    begin
      n := 1;
      digit[1] := x;
    end;
end;

procedure Increase(var a : Bigint; const b : BigInt); inline;
var
  i, cr, x : Integer;
begin
  i := 1; cr := 0;
  while (i <= a.n) or (i <= b.n) or (cr > 0) do
    begin
      x := cr;
      if i <= a.n then Inc(x, a.digit[i]);
      if i <= b.n then Inc(x, b.digit[i]);

      if x >= radix then
        begin
          a.digit[i] := x - radix;
          cr := 1;
        end
      else
        begin
          a.digit[i] := x;
          cr := 0;
        end;
      Inc(i);
    end;
  a.n := i - 1;
end;

procedure Print(const a : BigInt); inline;
var
  i : Integer;
  st : String;
begin
  with a do
    begin
      Write(digit[n]);
      for i := n - 1 downto 1 do
        begin
          Str(digit[i], st);
          while Length(st) < 9 do st := '0' + st;
          Write(st);
        end;
    end;
end;

var
  s : AnsiString;
  nextA, nextB, nowA, nowB : BigInt;

procedure Enter;
begin
  ReadLn(s);
  Init(nowA, 1);
  Init(nowB, 0);
end;

procedure Solve;
var
  i : Integer;
begin
  for i := Length(s) downto 1 do
    begin
      Init(nextA, 0); Init(nextB, 0);

      if (s[i] = '*') or (s[i] = 'P') then
        begin
          Increase(nextA, nowA);
          Increase(nextB, nowB);
        end;

      if (s[i] = '*') or (s[i] = 'L') then
        begin
          Increase(nextA, nowA);
          Increase(nextA, nowA);
          Increase(nextB, nowB);
        end;

      if (s[i] = '*') or (s[i] = 'R') then
        begin
          Increase(nextA, nowA);
          Increase(nextA, nowA);
          Increase(nextB, nowA);
          Increase(nextB, nowB);
        end;

      nowA := nextA; nowB := nextB;
    end;
  Increase(nowA, nowB);
end;

begin
  Enter;
  Solve;
  Print(nowA);
end.