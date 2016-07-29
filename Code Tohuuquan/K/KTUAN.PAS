{$MODE OBJFPC}
{$INLINE ON}
program KTUAN;
const
  maxN = Round(1e5);
  radix = Round(1e9);
  limit = 259;

var
  l : array[0..maxN] of Integer;
  p : array[-limit..limit] of Integer;
  n : Integer;

procedure Enter;
begin
  Read(n);
end;

procedure Cal(i : Integer); inline;
var
  j, k, r : Integer;
begin
  j := 1; r := 0; k := i - p[j];
  while k >= 0 do
    begin
      Inc(r, l[k]);
      if r >= radix then Dec(r, radix);
      k := i - p[-j];
      if k < 0 then Break;

      Inc(r, l[k]);
      if r >= radix then Dec(r, radix);
      Inc(j);
      k := i - p[j];
      if k < 0 then Break;

      Dec(r, l[k]);
      if r < 0 then Inc(r, radix);
      k := i - p[-j];
      if k < 0 then Break;

      Dec(r, l[k]);
      if r < 0 then Inc(r, radix);
      Inc(j);
      k := i - p[j];
    end;
  l[i] := r;
end;

procedure Solve;
var
  i : Integer;
begin
  for i := -limit to limit do
    p[i] := ((3 * sqr(i)) - i) shr 1;
  l[0] := 1; l[1] := 1;
  for i := 2 to n do Cal(i);
  l[0] := 0;
end;

procedure Print;
begin
  Write(l[n]);
end;

begin
  Enter;
  Solve;
  Print;
end.