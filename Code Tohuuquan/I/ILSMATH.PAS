{$MODE OBJFPC}
{$N+}
var
  n : Extended;

procedure Enter;
begin
  Read(n);
end;

procedure Solve;
var
  low, high, r : Extended;
  i, left, right : Integer;
begin
  low := (n - 1) * ln(10);
  high := n * ln(10);
  i := 1; r := 0;
  while r < low do
    begin
      Inc(i);
      r := r + ln(i);
    end;
  if r >= high then Write('NO') else
    begin
      left := i;
      while r < high do
        begin
          Inc(i);
          r := r + ln(i);
        end;
      right := i - 1;
      WriteLn(right - left + 1);
      for i := left to right do WriteLn(i);
    end;
end;

begin
  Enter;
  Solve;
end.