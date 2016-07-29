Program QBHEAP;
Const maxn = 15000;
Var a : array[1..maxn] of longint;
    i, n : word;
    v : longint;
    ch : char;

Procedure UpHeap(node : word);
Var key : longint;
    parent : word;
Begin
    key := a[node];
    Repeat
        parent := node shr 1;
        If (parent = 0) or (a[parent] > key) then break;
        a[node] := a[parent];
        node := parent;
    Until false;
    a[node] := key;
End;

Procedure Insert(v : longint);
Begin
    If n = maxn then exit;
    inc(n);
    a[n] := v;
    UpHeap(n);
End;

Procedure DownHeap(root, last : word);
Var key : longint;
    child : word;
Begin
    key := a[root];
    While root shl 1 <= last do
    Begin
        child := root shl 1;
        If (child < last) and (a[child] < a[child + 1]) then inc(child);
        If a[child] <= key then break;
        a[root] := a[child];
        root := child;
    End;
    a[root] := key;
End;

Function Get : longint;
Begin
    If n > 0 then exit(a[1]) else exit(-1);
End;

Procedure Extract;
Begin
    If n = 0 then exit;
    v := Get;
    a[1] := a[n];
    dec(n);
    DownHeap(1, n);
    If v = Get then Extract;
End;

Procedure PrintResult;
Var res : array[1..maxn] of longint;
    i, count : word;
Begin
    count := 0;
    While n > 0 do
    Begin
        inc(count);
        res[count] := Get;
        Extract;
    End;

    writeln(count);
    For i := 1 to count do writeln(res[i]);
End;

BEGIN
    n := 0;
    While not eof do
    Begin
        read(ch);
        If ch = '+' then
            Begin
                read(v);
                Insert(v);
            End
        Else Extract;
        readln;
    End;
    PrintResult;
END.