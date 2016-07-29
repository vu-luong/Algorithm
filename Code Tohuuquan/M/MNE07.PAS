{$MODE OBJFPC}
program MNE07;
const
  maxN = 5000;

var
  next : array[1..maxN] of Integer;
  s, t : AnsiString;
  n : Integer;

procedure Enter;
begin
  ReadLn(t);
  ReadLn(s);
  n := Length(s);
end;

procedure Solve;
var
  a : AnsiString;
  i, j, k : Integer;
begin
  s := s + s;
  t := t + t;
  j := 0;
  for i := 1 to n do
    begin
      a := Copy(s, i, n);
      for j := 1 to n do
        if (a[j] = '0') and (s[j] = '0') then a[j] := '0'
        else a[j] := '1';

      k := 0;
      next[1] := 0;
      for j := 2 to n do
        begin
          while (k > 0) and (a[i] <> a[k + 1]) do k := next[k];
          if a[j] = a[k + 1] then Inc(k);
          next[j] := k;
        end;

      k := 0;
      for j := 1 to n * 2 do
        begin
          while (k > 0) and (t[j] <> a[k + 1]) do k := next[k];
          if t[j] = a[k + 1] then Inc(k);
          if k = n then
            begin
              WriteLn('Yes');
              Exit;
            end;
        end;
    end;
  WriteLn('No');
end;

begin
  Enter;
  Solve;
end.
