{$MODE OBJFPC}
program SEC;
type
  PNode = ^TNode;
  TNode = record
    count, tail : Integer;
    link : array[0..1] of PNode;
  end;

var
  Trie : PNode;
  n, m : Integer;

procedure Enter;
var
  i : Integer;

  procedure NewNode(var root : PNode);
  begin
    New(root);
    root^.count := 0;
    root^.tail := 0;
    root^.link[0] := nil;
    root^.link[1] := nil;
  end;

  procedure AddWord;
  var
    i, l, x : Integer;
    p : PNode;
  begin
    p := Trie;
    Read(l);
    for i := 1 to l do
      begin
        Read(x);
        if p^.link[x] = nil then NewNode(p^.link[x]);
        p := p^.link[x];
        Inc(p^.count);
      end;
    Inc(p^.tail);
  end;

begin
  ReadLn(m, n);
  NewNode(Trie);
  for i := 1 to m do AddWord;
end;

procedure Solve;
var
  i, j, l, x, res : Integer;
  p : PNode;
begin
  for i := 1 to n do
    begin
      p := Trie;
      res := 0;
      Read(l);
      for j := 1 to l do
        begin
          Read(x);
          if p = nil then Continue;
          Inc(res, p^.tail);
          p := p^.link[x];
        end;
      if p <> nil then Inc(res, p^.count);
      WriteLn(res);
    end;
end;

begin
  Enter;
  Solve;
end.