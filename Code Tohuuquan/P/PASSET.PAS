{$MODE OBJFPC}
program PASSET;
type
  PNode = ^TNode;
  TNode = record
    key, priority : Integer;
    parent, left, right : PNode;
  end;

var
  sentinel : TNode;
  root, nilT : PNode;
  count : Integer;

function RP : Integer;
begin
  result := 1 + Random(maxInt - 1);
end;

procedure Init;
begin
  sentinel.priority := 0;
  nilT := @sentinel;
  root := nilT;
end;

function Minimum(x : PNode) : PNode;
begin
  while x^.left <> nilT do x := x^.left;
  result := x;
end;

function Maximum(x : PNode) : PNode;
begin
  while x^.right <> nilT do x := x^.right;
  result := x;
end;

function Predecessor(x : PNode) : PNode;
begin
  if x^.left <> nilT then
    result := Maximum(x^.left)
  else
    repeat
      result := x^.parent;
      if (result = nilT) or (x = result^.right) then Break;
      x := result;
    until false;
end;

function Successor(x : PNode) : PNode;
begin
  if x^.right <> nilT then
    result := Minimum(x^.right)
  else
    repeat
      result := x^.parent;
      if (result = nilT) or (x = result^.left) then Break;
      x := result;
    until false;
end;

function Search(x : PNode; const k : Integer) : PNode;
begin
  while (x <> nilT) and (x^.key <> k) do
    if k < x^.key then
      x := x^.left
    else
      x := x^.right;
  result := x;
end;

procedure SetLink(ParentNode, ChildNode : PNode; InLeft : Boolean);
begin
  ChildNode^.parent := ParentNode;
  if InLeft then
    ParentNode^.left := ChildNode
  else
    ParentNode^.right := ChildNode;
end;

procedure UpTree(x : PNode);
var
  y, z, branch : PNode;
begin
  y := x^.parent;
  z := y^.parent;
  if x = y^.left then
    begin
      branch := x^.right;
      SetLink(y, branch, true);
      SetLink(x, y, false);
    end
  else
    begin
      branch := x^.left;
      SetLink(y, branch, false);
      SetLink(x, y, true);
    end;
  SetLink(z, x, z^.left = y);
  if root = y then root := x;
end;

procedure Insert(const k : Integer);
var
  x, y : PNode;
begin
  Inc(count);
  y := nilT;
  x := root;
  while x <> nilT do
    begin
      y := x;
      if k < x^.key then
        x := x^.left
      else
        x := x^.right;
    end;

  New(x);
  x^.key := k;
  x^.left := nilT;
  x^.right := nilT;
  SetLink(y, x, k < y^.key);
  if root = nilT then root := x;

  x^.priority := RP;
  repeat
    y := x^.parent;
    if (y <> nilT) and (x^.priority > y^.priority) then UpTree(x)
    else Break;
  until false;
end;

procedure Delete(x : PNode);
var
  y, z : PNode;
begin
  Dec(count);
  while (x^.left <> nilT) and (x^.right <> nilT) do
    begin
      y := x^.left;
      if y^.priority < x^.right^.priority then
        y := x^.right;
      UpTree(y);
    end;

  if x^.left <> nilT then
    y := x^.left
  else
    y := x^.right;
  z := x^.parent;

  SetLink(z, y, z^.left = x);
  if x = root then root := y;
  Dispose(x);
end;

function Bigger(x : PNode; const k : Integer) : PNode;
begin
  if x^.key = k then Exit(Successor(x));
  if x^.key < k then
    begin
      if x^.right <> nilT then
        begin
          result := Bigger(x^.right, k);
          if result^.key <= k then result := x;
        end
      else
        Exit(x);
    end;
  if x^.key > k then
    begin
      if x^.left <> nilT then
        begin
          result := Bigger(x^.left, k);
          if result^.key <= k then result := x;
        end
      else
        Exit(x);
    end;
end;

function Smaller(x : PNode; const k : Integer) : PNode;
begin
  if x^.key = k then Exit(Predecessor(x));
  if x^.key < k then
    begin
      if x^.right <> nilT then
        begin
          result := Smaller(x^.right, k);
          if result^.key >= k then result := x;
        end
      else
        Exit(x);
    end;
  if x^.key > k then
    begin
      if x^.left <> nilT then
        begin
          result := Smaller(x^.left, k);
          if result^.key >= k then result := x;
        end
      else
        Exit(x);
    end;
end;

var
  x, n : Integer;
  p : PNode;

begin
  Init;

  repeat
    Read(x);
    if x = 0 then Break;

    case x of
      1 :
        begin
          Read(n);
          if Search(root, n) = nilT then Insert(n);
        end;

      2 :
        begin
          Read(n);
          p := Search(root, n);
          if p <> nilT then Delete(p);
        end;

      3 :
        if count = 0 then WriteLn('empty')
        else WriteLn(Minimum(root)^.key);

      4 :
        if count = 0 then WriteLn('empty')
        else WriteLn(Maximum(root)^.key);

      5 :
        begin
          Read(n);
          if count = 0 then WriteLn('empty') else
          if Maximum(root)^.key <= n then WriteLn('no')
          else WriteLn(Bigger(root, n)^.key);
        end;

      6 :
        begin
          Read(n);
          if count = 0 then WriteLn('empty') else
          if Maximum(root)^.key < n then WriteLn('no') else
          if Search(root, n) <> nilT then WriteLn(n) else
            WriteLn(Bigger(root, n)^.key);
        end;

      7 :
        begin
          Read(n);
          if count = 0 then WriteLn('empty') else
          if Minimum(root)^.key >= n then WriteLn('no')
          else WriteLn(Smaller(root, n)^.key);
        end;

      8 :
        begin
          Read(n);
          if count = 0 then WriteLn('empty') else
          if Minimum(root)^.key > n then WriteLn('no') else
          if Search(root, n) <> nilT then WriteLn(n) else
            WriteLn(Smaller(root, n)^.key);
        end;
    end;
  until false;
end.