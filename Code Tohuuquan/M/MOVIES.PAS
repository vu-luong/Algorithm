{$MODE OBJFPC}
program MOVIES;
uses
  SysUtils;

const
  maxS = 47;

type
  TSeat = record
    row, id : Integer;
  end;

var
  s : array[0..maxS] of TSeat;
  n, m, nS : Integer;
  st : String;
  res : Int64;

procedure Enter;
begin
  ReadLn(n);
  ReadLn(m);
  s[0].row := 0;
  s[0].id := m;

  nS := 0;
  repeat ReadLn(st) until st = '<<';
  repeat
    ReadLn(st);
    if st <> '>>' then
      begin
        Inc(nS);
        s[nS].row := StrToInt(st);
      end;
  until st = '>>';

  nS := 0;
  repeat ReadLn(st) until st = '<<';
  repeat
    ReadLn(st);
    if st <> '>>' then
      begin
        Inc(nS);
        s[nS].id := StrToInt(st);
      end;
  until st = '>>';
end;

operator < (const u, v : TSeat) : Boolean;
begin
  result := (u.row < v.row) or (u.row = v.row) and (u.id < v.id);
end;

procedure Sort(l, r : Integer);
var
  i, j : Integer;
  pivot : TSeat;
begin
  if l >= r then Exit;
  i := l + Random(r - l + 1);
  pivot := s[i]; s[i] := s[l];
  i := l; j := r;
  repeat
    while (pivot < s[j]) and (i < j) do Dec(j);
    if i < j then
      begin s[i] := s[j]; Inc(i); end
      else Break;
    while (s[i] < pivot) and (i < j) do Inc(i);
    if i < j then
      begin s[j] := s[i]; Dec(j); end
      else Break;
  until i = j;
  s[i] := pivot;
  Sort(l, i - 1);
  Sort(i + 1, r);
end;

procedure Solve;
var
  i : Integer;
  tmp : Int64;
begin
  res := 0;
  for i := 1 to nS do
    if s[i].row > s[i - 1].row then
      begin
        res := res + Int64(s[i].row - s[i - 1].row - 1) * Int64(m - 1);
        if s[i - 1].id <= m - 2 then
          res := res + m - s[i - 1].id - 1;
        if s[i].id >= 3 then
          res := res + s[i].id - 2;
      end
    else
      begin
        tmp := s[i].id - s[i - 1].id - 1;
        if tmp >= 2 then
          res := res + tmp - 1;
      end;
  if s[nS].id <= m - 2 then
    res := res + m - s[nS].id - 1;
  res := res + Int64(n - s[nS].row) * Int64(m - 1);
end;

procedure Print;
begin
  WriteLn(res);
end;

begin
  repeat
    repeat Readln(st) until (st = '[CASE]') or (st = '[END]');
    if st = '[END]' then Break;

    Enter;
    Sort(0, nS);
    Solve;
    Print;
  until false;
end.