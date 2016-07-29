{$MODE OBJFPC}
program PWALK;
const maxN = 1000;
type PNode = ^TNode;
     TNode = record
      Node, Len : integer;
      Link : PNode;
     end;
var a : array[1..maxN] of PNode;
    n, q : integer;

procedure Enter;
var i, u, v, l : integer;

 procedure Add(u, v, l : integer);
 var p : PNode;
 begin
     new(p);
     p^.Node := v;
     p^.Len := l;
     p^.Link := nil;
     if a[u] = nil then a[u]:= p else
     begin
         p^.Link := a[u];
         a[u] := p;
     end;
 end;

begin
    readln(n, q);
    for i := 1 to n do a[i] := nil;
    for i := 1 to n - 1 do
    begin
        readln(u, v, l);
        Add(u, v, l);
        Add(v, u, l);
    end;
end;

function Cal(x, y : integer) : integer;
var free : array[1..maxN] of boolean;
    queue : array[1..maxN, 1..2] of integer;
    u, v, first, last, l : integer;
    t : PNode;
begin
    fillchar(free[1], n * sizeof(free[1]), true);
    first := 1;
    last := 1;
    queue[first, 1] := x;
    queue[first, 2] := 0;
    free[x] := false;
    repeat
        u := queue[first, 1];
        l := queue[first, 2];
        inc(first);
        t := a[u];
        while t <> nil do
        begin
            v := t^.Node;
            if free[v] then
            begin
                inc(last);
                queue[last, 1] := v;
                queue[last, 2] := l + t^.Len;
                free[v] := false;
                if v = y then exit(queue[last, 2]);
            end;
            t := t^.Link;
        end;
    until first > last;
end;

procedure Solve;
var i, u, v : integer;
begin
    for i := 1 to q do
    begin
        readln(u, v);
        writeln(Cal(u, v));
    end;
end;

begin
    Enter;
    Solve;
end.
