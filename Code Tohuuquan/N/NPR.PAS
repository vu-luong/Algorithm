{$MODE OBJFPC}
program NPR;
const
  maxL = 30;

type
  TString = String[maxL];
  PNode = ^TNode;
  TNode = record
    link : array['a'..'z'] of PNode;
    min1, min2 : TString;
  end;

var
  Trie : PNode;

procedure Enter;
var
  c : Char;
  st : TString;

  procedure NewNode(var p : PNode);
  var
    c : Char;
  begin
    New(p);
    with p^ do
      begin
        min1 := '';
        min2 := '';
        for c := 'a' to 'z' do link[c] := nil;
      end;
  end;

  procedure AddWord(st : String);
  var
    p : PNode;
    i : Integer;
  begin
    p := Trie;
    for i := Length(st) downto 0 do
      begin
        with p^ do
          if min1 = '' then min1 := st else
          if (min2 = '') or (st < min2) then
            if st < min1 then
              begin
                min2 := min1;
                min1 := st;
              end
            else
              min2 := st;

        if i = 0 then Break;
        if p^.link[st[i]] = nil then NewNode(p^.link[st[i]]);
        p := p^.link[st[i]];
      end;
  end;

begin
  NewNode(Trie);
  repeat
    ReadLn(st);
    if st = '' then Break;
    AddWord(st);
  until false;
end;

procedure Solve;
var
  st, res : TString;
  p : PNode;
  i : Integer;
begin
  while not Eof do
    begin
      ReadLn(st);
      if st = '' then Break;

      p := Trie;
      for i := Length(st) downto 0 do
        begin
          with p^ do
            if (min1 <> '') and (st <> min1) then res := min1 else
            if min2 <> '' then res := min2;

          if i = 0 then Break;
          if p^.link[st[i]] = nil then Break;
          p := p^.link[st[i]];
        end;
      WriteLn(res);
    end;
end;

begin
  Enter;
  Solve;
end.