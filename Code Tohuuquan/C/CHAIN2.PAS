{$MODE OBJFPC}
program CHAIN2;
uses
  Math;

type
  PNode = ^TNode;
  TNode = record
    link : array['a'..'z'] of PNode;
    w, value : Integer;
end;

var
  Trie : PNode;
  n : Integer;

procedure Enter;
var
  i : Integer;
  st : String;

  procedure NewNode(var p : PNode);
  var
    c : Char;
  begin
    New(p);
    for c := 'a' to 'z' do p^.link[c] := nil;
    p^.w := 0;
    p^.value := 0;
  end;

  procedure AddWord(var root : PNode; st : String);
  var
    i : Integer;
    p : PNode;
  begin
    p := root;
    for i := 1 to Length(st) do
      begin
        if p^.link[st[i]] = nil then NewNode(p^.link[st[i]]);
        p := p^.link[st[i]];
      end;
    p^.w := 1;
    p^.value := 1;
  end;

begin
  NewNode(Trie);
  ReadLn(n);
  for i := 1 to n do
    begin
      ReadLn(st);
      AddWord(Trie, st);
    end;
end;

procedure DFS(root : PNode);
var
  c : Char;
begin
  with root^ do
    begin
      value := w;
      for c := 'a' to 'z' do
        if link[c] <> nil then
          begin
            DFS(link[c]);
            value := Max(value, link[c]^.value + w);
          end;
    end;
end;

procedure Solve;
begin
  DFS(Trie);
  WriteLn(Trie^.value);
end;

begin
  Enter;
  Solve;
end.