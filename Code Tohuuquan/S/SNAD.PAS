{$MODE OBJFPC}
program SNAD;
uses
  Math;

const
  maxN = 19;
  maxT = 19;

type
  BigInt = record
    nDigits : Integer;
    d : array[1..20] of Integer;
  end;

var
  f : array[0..maxN * 9, 0..maxN] of Int64;
  x, y : BigInt;
  res : Int64;
  nTests : Integer;

procedure Init;
var
  i, j, k : Integer;
begin
  for i := 1 to 9 do f[i, 1] := 1;
  for j := 2 to maxT do
    for i := 1 to j * 9 do
      for k := 0 to Min(i, 9) do
        f[i, j] := f[i, j] + f[i - k, j - 1];
  for j := 1 to maxT do
    for i := 1 to maxT * 9 do
      f[i, j] := f[i, j] + f[i, j - 1];
  for i := 0 to maxT do f[0, i] := 1;
end;

procedure Enter;
var
  i : Integer;
  s1, s2 : String;
begin
  ReadLn(s1);
  i := Pos(' ', s1);
  s2 := Copy(s1, i + 1, Length(s1) - i);
  s1 := Copy(s1, 1, i - 1);
  with x do
    begin
      nDigits := Length(s1);
      FillChar(d, SizeOf(d), 0);
      for i := 1 to nDigits do
        d[i] := Ord(s1[nDigits - i + 1]) - 48;
    end;
  with y do
    begin
      nDigits := Length(s2);
      FillChar(d, SizeOf(d), 0);
      for i := 1 to nDigits do
        d[i] := Ord(s2[nDigits - i + 1]) - 48;
    end;
end;

function Cal(a : BigInt; k : Integer) : Int64;
var
  i, j : Integer;
begin
  with a do
    begin
      result := 0;
      if nDigits * 9 < k then Exit;
      for i := nDigits downto 1 do
        begin
          for j := 0 to d[i] - 1 do
            if k >= j then
              result := result + f[k - j, i - 1] else Break;
            Dec(k, d[i]);
            if k < 0 then Break;
        end;
      if k = 0 then result := result + 1;
    end;
end;

procedure Division(b : BigInt; k : Integer; var c : BigInt; t : Integer);
var
  i, carry : Integer;
begin
  with c do
    begin
      if b.nDigits <= 0 then Exit;
      FillChar(d, SizeOf(d), 0);
      carry := 0;
      for i := b.nDigits downto 1 do
        begin
          d[i] := b.d[i] + carry;
          carry := (d[i] mod k) * 10;
          d[i] := d[i] div k;
        end;

      if carry = 0 then
        begin
          i := 1; carry := t;
          while (carry < 0) and (i <= b.nDigits) do
            begin
              d[i] := d[i] + carry;
              if d[i] < 0 then
                begin Inc(d[i], 10); carry := -1; end
                else carry := 0;
              Inc(i);
            end;
        end;

        nDigits := b.nDigits;
        while (d[nDigits] <= 0) and (nDigits > 0) do Dec(nDigits);
    end;
end;

procedure Solve;
var
  i : Integer;
  a1, a2 : BigInt;
begin
  res := 0;
  for i := 1 to y.nDigits * 9 do
    begin
      Division(x, i, a1, -1);
      Division(y, i, a2, 0);
      res := res + Cal(a2, i) - Cal(a1, i);
    end;
  if res < 0 then res := 0;
end;

procedure Print;
begin
  WriteLn(res);
end;

begin
  Init;
  ReadLn(nTests);
  while nTests > 0 do
    begin
      Dec(nTests);
      Enter;
      Solve;
      Print;
    end;
end.