Program HEAP1;
Const maxn = 20000;
Var a : array[1..maxn] of longint;
    n, t, last : word;
    res : int64;

Procedure Insert(x : longint);
Var node, parent : word;
Begin
    inc(last);
    node := last;
    Repeat
        parent := node shr 1;
        If (parent = 0) or (a[parent] <= x) then break;
        a[node] := a[parent];
        node := parent;
    Until false;
    a[node] := x;
End;

Function Extract : longint;
Var root, child : word;
    temp : longint;
Begin
    temp := a[1];
    a[1] := a[last];
    a[last] := temp;
    dec(last);
    root := 1;
    temp := a[root];
    While root shl 1 <= last do
    Begin
        child := root shl 1;
        If (child < last) and (a[child + 1] < a[child]) then inc(child);
        If temp <= a[child] then break;
        a[root] := a[child];
        root := child;
    End;
    a[root] := temp;
    exit(a[last + 1]);
End;

Procedure Enter;
Var i : word;
    x : longint;
Begin
    res := 0;
    last := 0;
    read(n);
    For i := 1 to n do
    Begin
        read(x);
        res := res + x;
        Insert(x);
    End;
End;

Procedure Solve;
Var x, y : longint;
Begin
    Repeat
        x := Extract;
        y := Extract;
        res := res + x + y;
        Insert(x + y);
    Until last = 2;
    writeln(res);
End;

BEGIN
    read(t);
    While t > 0 do
    Begin
        Enter;
        Solve;
        dec(t);
    End;
END.
