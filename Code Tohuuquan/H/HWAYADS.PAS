{$MODE OBJFPC}
program HWAYADS;
uses
  SysUtils;

const
  maxN = 17032;

type
  PNode = ^TNode;
  TNode = record
    v : Integer;
    st : AnsiString;
    link : PNode;
  end;

var
  c : array[0..maxN] of PNode;
  next : array[1..71] of Integer;
  n, l : Integer;
  ktuan : AnsiString;

procedure Enter;
var
  i, u, v : Integer;
  st : AnsiString;

  procedure Add(u, v : Integer; const st : AnsiString);
  var
    p : PNode;
  begin
    New(p);
    p^.v := v;
    p^.st := st;
    p^.link := c[u];
    c[u] := p;
  end;

begin
  ReadLn(n);
  for i := 0 to n - 2 do
    begin
      ReadLn(u, v, st);
      Add(u, v, TrimLeft(st));
    end;
  ReadLn(ktuan); l := Length(ktuan);
end;

procedure Init;
var
  i, j : Integer;
begin
  next[1] := 0;
  j := 1;
  for i := 2 to l do
    begin
      if ktuan[i] = ktuan[j] then next[i] := next[j] else
        begin
          next[i] := j;
          while (j > 0) and (ktuan[i] <> ktuan[j]) do j := next[j];
        end;
      Inc(j);
    end;
  next[l + 1] := j;
end;

function Count(a : AnsiString) : Int64;
var
  i, j : Integer;
begin
  result := 0;
  i := 1;
  for j := 1 to Length(a) do
    begin
      while (i > 0) and (ktuan[i] <> a[j]) do i := next[i];
      Inc(i);
      if i > l then
        begin
          i := next[i];
          result := result + 1;
        end;
    end;
end;

function DFS(u : Integer; s : AnsiString) : Int64;
var
  p : PNode;
begin
  if Length(s) < l then
    result := 0
  else
    begin
      result := Count(s);
      s := RightStr(s, l - 1);
    end;

  p := c[u];
  while p <> nil do
    begin
      with p^ do
        if Length(st) < l then
          result := result + DFS(v, s + st)
        else
          result := result
                    + Count(st)
                    + Count(s + LeftStr(st, l - 1))
                    + DFS(v, RightStr(st, l - 1));
      p := p^.link;
    end;
end;

procedure Solve;
begin
  Init;
  WriteLn(DFS(0, ''));
end;

begin
  Enter;
  Solve;
end.