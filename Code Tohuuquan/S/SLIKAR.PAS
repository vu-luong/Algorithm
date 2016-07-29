{$MODE OBJFPC}
program SLIKAR;
const
  maxN = 512;
  oo = Round(1e9);

type
  Data = record
    all0, all1, res : Integer;
  end;

var
  a, b : array[0..maxN, 0..maxN] of Char;
  n, i, j : Integer;

function NextPermutation(var a : array of Integer) : Boolean;
var
  n, i, j, k, t : Integer;
begin
  result := false;
  n := Length(a);
  for i := n - 2 downto 0 do
    if a[i] < a[i + 1] then
      begin
        k := i + 1;
        for j := i + 2 to n - 1 do
          if (a[j] > a[i]) and (a[j] < a[k]) then k := j;
        t := a[i]; a[i] := a[k]; a[k] := t;
        for j := i + 1 to n - 1 do
          begin
            k := n - j + i;
            if j > k then Break;
            t := a[j]; a[j] := a[k]; a[k] := t;
          end;
        result := true;
        Break;
      end;
end;

function Rec(rL, cL, rH, cH : Integer) : Data;
var
  f : array[0..1, 0..1] of Data;
  best, p : array[0..3] of Integer;
  size, rM, cM, i, j, val, r, c : Integer;
begin
  if rL + 1 = rH then
    begin
      if a[rL, cL] = '1' then
        begin result.all0 := 1; result.all1 := 0; end
      else
        begin result.all0 := 0; result.all1 := 1; end;
      result.res := 0;
      b[rL, cL] := a[rL, cL];
    end
  else
    begin
      size := (rH - rL) div 2;
      rM := rL + size;
      cM := cL + size;

      f[0, 0] := Rec(rL, cL, rM, cM);
      f[1, 0] := Rec(rM, cL, rH, cM);
      f[0, 1] := Rec(rL, cM, rM, cH);
      f[1, 1] := Rec(rM, cM, rH, cH);

      result.res := oo;
      result.all0 := 0;
      result.all1 := 0;

      for i := 0 to 1 do
        for j := 0 to 1 do
          begin
            Inc(result.all0, f[i, j].all0);
            Inc(result.all1, f[i, j].all1);
          end;

      for i := 0 to 3 do p[i] := i;
      repeat
        val :=
          f[p[0] div 2, p[0] mod 2].all0 +
          f[p[1] div 2, p[1] mod 2].all1 +
          f[p[2] div 2, p[2] mod 2].res +
          f[p[3] div 2, p[3] mod 2].res;

        if val < result.res then
          begin
            result.res := val;
            best := p;
          end;
      until not NextPermutation(p);

      for r := 0 to size - 1 do
        for c := 0 to size - 1 do
          begin
            b[rL + (best[0] div 2) * size + r, cL + (best[0] mod 2) * size + c] := '0';
            b[rL + (best[1] div 2) * size + r, cL + (best[1] mod 2) * size + c] := '1';
          end;
    end;
end;

procedure Enter;
var
  i, j : Integer;
begin
  ReadLn(n);
  for i := 0 to n - 1 do
    begin
      for j := 0 to n - 1 do Read(a[i, j]);
      ReadLn;
    end;
end;

procedure Solve;
var
  i, j : Integer;
begin
  WriteLn(Rec(0, 0, n, n).res);
  for i := 0 to n - 1 do
    begin
      for j := 0 to n - 1 do Write(b[i, j]);
      WriteLn;
    end;
end;

begin
  Enter;
  Solve;
end.
