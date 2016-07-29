{$MODE OBJFPC}
program GRAPH;
uses Math;
const maxN = 10000;
type PNode = ^TNode;
     TNode = record
      Info : integer;
      Link : PNode;
     end;
var a : array[1..maxN] of PNode;
    parent, num, lowk, lowc, c : array[1..maxN] of integer;
    mark : array[1..maxN] of boolean;
    n, m, count, khop, cau : integer;

procedure Enter;
var i, u, v : integer;

 procedure Add(p, c : integer);
 var t : PNode;
 begin
     New(t);
     t^.Info := c;
     t^.Link := Nil;
     if a[p] = Nil then a[p] := t else
     begin
         t^.Link := a[p];
         a[p] := t;
     end;
 end;

begin
    readln(n, m);
    for i := 1 to n do a[i] := Nil;
    for i := 1 to m do
    begin
        readln(u, v);
        Add(u, v);
        Add(v, u);
    end;
end;

procedure Visit(u : integer);
var t : PNode;
    v : integer;
begin
    inc(count);
    num[u] := count;
    lowk[u] := n + 1;
    lowc[u] := n + 1;

    t := a[u];
    while t <> Nil do
    begin
        v := t^.Info;
        t := t^.Link;

        if num[v] <> 0 then
            begin
                lowk[u] := min(lowk[u], num[v]);
                if v <> parent[u] then
                    lowc[u] := min(lowc[u], num[v]);
            end
        else
            begin
                parent[v] := u;
                inc(c[u]);

                Visit(v);

                mark[u] := mark[u] or (lowk[v] >= num[u]);
                lowk[u] := min(lowk[u], lowk[v]);
                if lowc[v] > num[u] then inc(cau);
                lowc[u] := min(lowc[u], lowc[v]);
            end;
    end;
end;

procedure Solve;
var u : integer;
begin
    for u := 1 to n do
        if num[u] = 0 then
        begin
            Visit(u);
            if c[u] < 2 then mark[u] := false;
        end;
    for u := 1 to n do
        if mark[u] then inc(khop);
end;

procedure Print;
begin
    write(khop, ' ', cau);
end;

begin
    Enter;
    Solve;
    Print;
end.
