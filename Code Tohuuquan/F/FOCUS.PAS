{$MODE OBJFPC}
program FOCUS;
const
  maxN = 200000;

type
  TInfo = record
    q : Char;
    x : Integer;
  end;

var
  a : array[1..maxN * 2] of TInfo;
  b : array[1..maxN] of Integer;
  f, c : array[1..maxN * 2] of Integer;
  n, m, lim : Integer;

procedure Enter;
var
  i, nLines, k, x, y : Integer;
  ch : Char;
begin
  ReadLn(nLines);
  for i := 1 to nLines do
    begin
      Read(ch);
      case ch of
        '+', '-' :
          begin
            ReadLn(x);
            Inc(n); a[n].q := ch; a[n].x := x;
          end;

        '?' :
          begin
            ReadLn(k, x, y);
            Inc(n); a[n].q := ch; a[n].x := x;
            Inc(m); b[m] := k;
            Inc(n); a[n].x := y;
          end;
      end;
    end;
end;

procedure Sort(L, R : Integer);
var
  pivot, i, j : Integer;
begin
  if L >= R then Exit;
  i := L + Random(R - L + 1);
  pivot := f[i]; f[i] := f[L];
  i := L; j := R;
  repeat
    while (a[pivot].x < a[f[j]].x) and (i < j) do Dec(j);
    if i < j then
      begin f[i] := f[j]; Inc(i); end
      else Break;
    while (a[f[i]].x < a[pivot].x) and (i < j) do Inc(i);
    if i < j then
      begin f[j] := f[i]; Dec(j); end
      else Break;
  until i = j;
  f[i] := pivot;
  Sort(L, i - 1);
  Sort(i + 1, R);
end;

procedure Init;
var
  i, j, value, num : Integer;
begin
  for i := 1 to n do f[i] := i;
  Sort(1, n);

  value := a[f[1]].x;
  num := 1;
  a[f[1]].x := 1;
  c[1] := value;

  for i := 2 to n do
    begin
      j := f[i];
      if a[j].x = value then
        a[j].x := num
      else
        begin
          value := a[j].x;
          Inc(num);
          a[j].x := num;
          c[num] := value;
        end;
    end;
  lim := num;
end;

procedure Update(x, value : Integer);
begin
  while x <= lim do
    begin
      Inc(f[x], value);
      Inc(x, x and -x);
    end;
end;

function Sum(x : Integer) : Integer;
begin
  result := 0;
  while x > 0 do
    begin
      Inc(result, f[x]);
      Dec(x, x and -x);
    end;
end;

function Find(k, x, y : Integer) : Integer;
var
  mid : Integer;
begin
  Inc(k, Sum(x - 1));
  if k > Sum(y) then Exit(0);

  repeat
    mid := (x + y) shr 1;
    if Sum(mid) < k then
      x := mid + 1
    else
      y := mid - 1;
  until x > y;
  Exit(c[x]);
end;

procedure Solve;
var
  i, j : Integer;
begin
  FillChar(f, SizeOf(f), 0);
  i := 1; j := 1;
  repeat
    case a[i].q of
      '+' :
        begin
          Update(a[i].x, 1);
          Inc(i);
        end;

      '-' :
        begin
          Update(a[i].x, -1);
          Inc(i);
        end;

      '?' :
        begin
          WriteLn(Find(b[j], a[i].x, a[i + 1].x));
          Inc(i, 2);
          Inc(j);
        end;
    end;
  until i > n;
end;

begin
  Enter;
  Init;
  Solve;
end.