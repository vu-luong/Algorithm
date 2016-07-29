{$MODE OBJFPC}
program KDEL;
uses
  SysUtils;

var
  stack, s : AnsiString;
  n, k, top : Integer;

procedure Enter;
begin
  ReadLn(n, k);
end;

procedure Init;
const
  k = 3;
var
  i, t : Integer;

  function Power(a, d, n : Integer) : Integer;
  begin
    if d = 0 then Exit(1);
    result := Power(a, d shr 1, n);
    result := (Int64(result) * result) mod n;
    if Odd(d) then
      result := (Int64(a) * result) mod n;
  end;

  function RabinMiller(n : Integer) : Boolean;
  var
    d, a, x : Integer;
    s, i, r : Integer;
  begin
    if n = 2 then Exit(true);
    d := n - 1; s := 0;
    while d mod 2 = 0 do
      begin s := s + 1; d := d shr 1; end;
    for i := 1 to k do
      begin
        a := Random(n - 2) + 2; x := Power(a, d, n);
        if (x = 1) or (x = n - 1) then Continue;
        for r := 1 to s - 1 do
          begin
            x := (Int64(x) * x) mod n;
            if x = 1 then Exit(false);
            if x = n - 1 then Break;
          end;
        if x <> n - 1 then Exit(false);
      end;
    Exit(true);
  end;

begin
  if n = 1 then s := '2' else
  if n = 2 then s := '3' else
    begin
      t := -1;
      s := '23';
      i := 2;
      repeat
        t := t + 6;
        if RabinMiller(t) then
          begin
            s := s + IntToStr(t);
            i := i + 1;
          end;
        if i = n then Break;

        if RabinMiller(t + 2) then
          begin
            s := s + IntToStr(t + 2);
            i := i + 1;
          end;
        if i = n then Break;
      until false;
    end;
end;

procedure Solve;
var
  i : Integer;
begin
  for i := 1 to Length(s) do
    begin
      while (top > 0) and (k > 0) and (stack[top] < s[i]) do
        begin
          Delete(stack, top, 1);
          top := top - 1;
          k := k - 1;
        end;
      top := top + 1;
      stack := stack + s[i];
    end;
end;

procedure Print;
begin
  WriteLn(Copy(stack, 1, top - k));
end;

begin
  Enter;
  Init;
  Solve;
  Print;
end.
