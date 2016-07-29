{$MODE OBJFPC}
{$INLINE ON}
program STNODE;
const
  maxN = 10000 * 2 + 1;

type
  PNode = ^TNode;
  TNode = record
   v : Integer;
   link : PNode;
  end;

var
  head : array[0..maxN] of PNode;
  pre, f : array[0..maxN] of Integer;
  queue : array[1..maxN] of Integer;
  n, m, s, t, count, first, last, res : Integer;

procedure Enter;
var
  i, u, v : Integer;

 procedure Add(u, v : Integer); inline;
 var
   p : PNode;
 begin
   New(p);
   p^.v := v;
   p^.link := nil;
   if head[u] = nil then head[u] := p else
     begin
       p^.link := head[u];
       head[u] := p;
     end;
 end;

begin
  ReadLn(n, m, s, t);
  for i := 0 to n shl 1 + 1 do head[i] := nil;
  for i := 1 to m do
    begin
      ReadLn(u, v);
      Add(u shl 1 + 1, v shl 1);
    end;
  for i := 1 to n do Add(i shl 1, i shl 1 + 1);
  s := s shl 1 + 1;
  t := t shl 1 + 1;
end;

procedure BFS(s : Integer); inline;
var
  u, v : Integer;
  p : PNode;
begin
  first := 1; last := 1;
  queue[1] := s;
  pre[s] := n + 1; pre[0] := n + 1;
  repeat
    u := queue[first];
    Inc(first);

    p := head[u];
    while p <> nil do
      begin
        v := p^.v;
        p := p^.link;
        if pre[v] = 0 then
          begin
            pre[v] := u;
            Inc(last);
            queue[last] := v;
          end;
      end;
  until first > last;
end;

procedure Trace(u : Integer);
begin
  if u <> s then Trace(pre[u]);
  Inc(count);
  f[count] := u;
end;

procedure Solve;
var
  u : Integer;
  p : PNode;
begin
  FillChar(pre, SizeOf(pre), 0);
  BFS(s);
  Trace(t);

  for u := 1 to count - 1 do
    begin
      p := head[f[u]];
      while p <> nil do
        begin
          if p^.v = f[u + 1] then
            begin
              p^.v := f[u - 1];
              Break;
            end;
          p := p^.link;
        end;
    end;

  FillChar(pre, SizeOf(pre), 0);
  BFS(s);
  for u := 2 to count - 2 do
    if pre[f[u]] = 0 then
      begin
        Inc(res);
        BFS(f[u + 1]);
      end;

  Write(res);
end;

begin
  Enter;
  Solve;
end.