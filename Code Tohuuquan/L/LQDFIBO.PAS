{$MODE OBJFPC}
program LQDFIBO;
uses
  Math, SysUtils;

const
  maxD = 1000;
  BASE = Round(1e9);

type
  BigInt = record
    nD : Integer;
    D : array[1..maxD] of Integer;
  end;

  TInfo = record
    pre, suf : AnsiString;
    value : BigInt;
  end;

operator := (const v : Integer) : BigInt;
begin
  with result do
    begin
      nD := 1;
      D[1] := v;
    end;
end;

operator + (const a, b : BigInt) : BigInt;
var
  i, carry : Integer;
begin
  with result do
    begin
      nD := 0;
      carry := 0;
      for i := 1 to Max(a.nD, b.nD) do
        begin
          if i <= a.nD then Inc(carry, a.D[i]);
          if i <= b.nD then Inc(carry, b.D[i]);
          Inc(nD); D[nD] := carry mod BASE;
          carry := carry div BASE;
        end;

      if carry > 0 then
        begin
          Inc(nD);
          D[nD] := carry;
        end;
    end;
end;

procedure Print(const a : BigInt);
var
  i : Integer;
  st : String;
begin
  with a do
    begin
      Write(D[nD]);
      for i := nD - 1 downto 1 do
        begin
          st := IntToStr(D[i]);
          while Length(st) < 9 do st := '0' + st;
          Write(st);
        end;
    end;
end;

var
  s1, s2, s : AnsiString;
  n, l : Integer;

procedure Enter;
begin
  ReadLn(n);
  ReadLn(s1);
  ReadLn(s2);
  ReadLn(s); l := Length(s);
end;

function Count1(p : AnsiString) : Integer;
var
  i : Integer;
begin
  result := 0;
  for i := 1 to Length(p) - l + 1 do
    if Copy(p, i, l) = s then
      result := result + 1;
end;

function Count2(p : AnsiString) : Integer;
var
  i : Integer;
begin
  result := 0;
  for i := 2 to l do
    if Copy(p, i, l) = s then
      result := result + 1;
end;

procedure Init(var a : TInfo; t : AnsiString);
begin
  with a do
    begin
      pre := LeftStr(t, l);
      suf := RightStr(t, l);
      value := Count1(t);
    end;
end;

procedure Solve;
var
  f1, f2, f3 : TInfo;
  s3 : AnsiString;
  i : Integer;
  flag : Boolean;
begin
  flag := false;
  for i := 3 to n do
    if Length(s1) > l * 2 then
      begin
        flag := true;
        Break;
      end
    else
      begin
        s3 := s2 + s1;
        s1 := s2;
        s2 := s3;
      end;

  if flag then
    begin
      Init(f1, s1);
      Init(f2, s2);

      repeat
        with f3 do
          begin
            pre := f2.pre;
            suf := f1.suf;
            value := f2.value + f1.value + Count2(f2.suf + f1.pre);
          end;
        f1 := f2;
        f2 := f3;

        Inc(i);
      until i > n;

      Print(f2.value);
    end
  else
    WriteLn(Count1(s2));
end;

begin
  Enter;
  Solve;
end.