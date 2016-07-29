{$MODE OBJFPC}
program MREPLBRC;
const
  maxN = 200;
  openBrac = '([{';
  closeBrac = ')]}';
  radix = Round(1e5);

var
  f : array[1..maxN, 1..maxN] of Int64;
  n : Integer;
  s : String;
  res : Int64;

procedure Enter;
begin
  ReadLn(n);
  ReadLn(s);
end;

procedure Cal(low, high : Integer);
var
  i, j : Integer;
begin
  if low > high then f[low, high] := 1 else
  if f[low, high] >= 0 then Exit else
    begin
      f[low, high] := 0;
      for i := low + 1 to high do
        if (i - low) mod 2 = 1 then
          for j := 1 to 3 do
            if (s[low] = openBrac[j]) or (s[low] = '?') then
              if (s[i] = closeBrac[j]) or (s[i] = '?') then
                begin
                  Cal(low + 1, i - 1);
                  Cal(i + 1, high);
                  f[low, high] := f[low, high] + f[low + 1, i - 1] * f[i + 1, high];
                  if f[low, high] > radix then
                    f[low, high] := radix + f[low, high] mod radix;
                end;
    end;
end;

procedure Solve;
var
  i, j : Integer;
begin
  for i := 1 to n do
    for j := 1 to n do f[i, j] := -1;
  Cal(1, n);
  res := f[1, n];
end;

procedure Print;
var
  st : String;
begin
  if res < radix then WriteLn(res) else
    begin
      Str(res - radix, st);
      while Length(st) < 5 do st := '0' + st;
      WriteLn(st);
    end;
end;

begin
  Enter;
  Solve;
  Print;
end.