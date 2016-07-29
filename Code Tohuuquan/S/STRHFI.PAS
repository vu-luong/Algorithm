{$MODE OBJFPC}
program STRHFI;
const
  maxN = 1000;
  maxD = 20;
  maxM = (maxN - maxD + 1) * 2;

type
  TInfo = (Head, Tail);
  TToken = record
    s : String[maxD - 1];
    flag : TInfo;
  end;

var
  token : array[0..maxM] of TToken;
  numHead, numTail, link : array[1..maxM] of Integer;
  n, d, m, count : Integer;
  resHead, resTail : Char;

procedure Enter;
var
  i : Integer;
  st : String;
begin
  ReadLn(n, d);
  for i := 1 to n - d + 1 do
    begin
      ReadLn(st);
      with token[m + 1] do
        begin
          s := Copy(st, 1, d - 1);
          flag := Head;
        end;
      with token[m + 2] do
        begin
          s := Copy(st, 2, d - 1);
          flag := Tail;
        end;
      Inc(m, 2);
    end;
end;

procedure Sort(l, r : Integer);
var
  i, j : Integer;
  pivot : TToken;
begin
  if l >= r then Exit;
  i := l + Random(r - l + 1);
  pivot := token[i]; token[i] := token[l];
  i := l; j := r;
  repeat
    while (pivot.s < token[j].s) and (i < j) do Dec(j);
    if i < j then
      begin token[i] := token[j]; Inc(i); end
      else Break;
    while (token[i].s < pivot.s) and (i < j) do Inc(i);
    if i < j then
      begin token[j] := token[i]; Dec(j); end
      else Break;
  until i = j;
  token[i] := pivot;
  Sort(l, i - 1);
  Sort(i + 1, r);
end;

procedure Init;
var
  i : Integer;
begin
  Sort(1, m);
  for i := 1 to m do
    if token[i].s <> token[i - 1].s then
      begin
        Inc(count);
        link[count] := i;
        if token[i].flag = Head then numHead[count] := 1
          else numTail[count] := 1;
      end
    else
      if token[i].flag = Head then Inc(numHead[count])
        else Inc(numTail[count]);
end;

procedure Solve;
var
  i : Integer;
begin
  resHead := token[1].s[1];
  resTail := token[m].s[d - 1];
  for i := 1 to count do
    begin
      if numHead[i] > numTail[i] then
        resHead := token[link[i]].s[1];
      if numHead[i] < numTail[i] then
        resTail := token[link[i]].s[d - 1];
    end;
end;

procedure Print;
begin
  WriteLn(resHead, resTail);
end;

begin
  Enter;
  Init;
  Solve;
  Print;
end.