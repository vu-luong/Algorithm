{$MODE OBJFPC}
program NKONEARC;
uses Math;
const maxN = 2000;
      maxM = 30000;
type TEdge = record
      x, y : integer;
     end;
     TStack = record
      top : integer;
      item : array[1..maxN] of integer;
     end;
var e : array[1..maxM] of TEdge;
    link : array[1..maxM] of integer;
    head, num, low, group : array[1..maxN] of integer;
    d : array[1..maxN, 1..2] of integer;
    stack : TStack;
    n, m, comp, count, x, y : integer;

procedure Enter;
var i : integer;
begin
    readln(n, m);
    for i := 1 to m do
        with e[i] do
        begin
            readln(x, y);
            link[i] := head[x];
            head[x] := i;
        end;
end;

procedure Push(u : integer);
begin
    with stack do
    begin
        inc(top);
        item[top] := u;
    end;
end;

function Pop : integer;
begin
    with stack do
    begin
        result := item[top];
        dec(top);
    end;
end;

procedure DFSVisit(u : integer);
var i, v : integer;
begin
    inc(count);
    num[u] := count;
    low[u] := count;
    Push(u);

    i := head[u];
    while i <> 0 do
    begin
        v := e[i].y;
        i := link[i];
        if group[v] = 0 then
            if num[v] = 0 then
                begin
                    DFSVisit(v);
                    low[u] := min(low[u], low[v]);
                end
            else low[u] := min(low[u], num[v]);
    end;

    if num[u] = low[u] then
    begin
        inc(comp);
        repeat
            v := Pop;
            group[v] := comp;
        until v = u;
    end;
end;

procedure Solve;
var i, u : integer;
begin
    stack.top := 0;
    for u := 1 to n do
        if num[u] = 0 then DFSVisit(u);
    for i := 1 to m do
        with e[i] do
        begin
            inc(d[group[x], 1]);
            inc(d[group[y], 2]);
        end;
    for i := 1 to comp do
        if d[i, 1] = 0 then
        begin
            x := i;
            break;
        end;
    if x = 0 then x := 1;
    y := 1;
    if y = x then inc(y);
    for i := 1 to comp do
        if d[i, 2] = 0 then
        begin
            y := i;
            break;
        end;
end;

procedure Print;

 function Find(x : integer) : integer;
 var i : integer;
 begin
     for i := 1 to n do
         if group[i] = x then exit(i);
 end;

begin
    writeln('YES');
    writeln(Find(x), ' ', Find(y));
end;

begin
    Enter;
    Solve;
    Print;
end.