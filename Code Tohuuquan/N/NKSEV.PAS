{$MODE OBJFPC}
program NKSEV;
const
  maxL = Round(3e5);
  radix = 1337377;

type
  PNode = ^TNode;
  TNode = record
    exist : Boolean;
    link : array['a'..'z'] of PNode;
  end;

var
  f : array[0..maxL] of Integer;
  Trie : PNode;
  sCode : AnsiString;
  n, l : Integer;

procedure Enter;
var
  i : Integer;
  st : String;

  procedure NewNode(var root : PNode);
  var
    i : Char;
  begin
    New(root);
    root^.exist := false;
    for i := 'a' to 'z' do
      root^.link[i] := nil;
  end;

  procedure AddWord(var root : PNode; s : String);
  var
    i : Integer;
    p : PNode;
  begin
    p := root;
    for i := Length(s) downto 1 do
      begin
        if p^.link[s[i]] = nil then NewNode(p^.link[s[i]]);
        p := p^.link[s[i]];
      end;
    p^.exist := true;
  end;

begin
  ReadLn(sCode);
  l := Length(sCode);
  NewNode(Trie);
  ReadLn(n);
  for i := 1 to n do
    begin
      ReadLn(st);
      AddWord(Trie, st);
    end;
end;

procedure Solve;
var
  i, j : Integer;
  p : PNode;
begin
  f[0] := 1;
  for i := 1 to l do
    begin
      p := Trie;
      for j := i downto 1 do
        begin
          p := p^.link[sCode[j]];
          if p = nil then Break;
          if p^.exist and (f[j - 1] > 0) then
            f[i] := (f[i] + f[j - 1]) mod radix;
        end;
    end;
end;

procedure Print;
begin
  WriteLn(f[l]);
end;

begin
  Enter;
  Solve;
  Print;
end.