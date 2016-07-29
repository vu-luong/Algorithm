Program KMIN;
Const maxm = 50000;
      maxn = 50000;
Var a : array[1..maxm] of longint;
    b : array[1..maxn] of longint;
    v, heap : array[1..maxm] of word;
    m, n, k, last : word;

Procedure Enter;
Var i : word;
Begin
    readln(m, n, k);
    For i := 1 to m do readln(a[i]);
    For i := 1 to n do readln(b[i]);
End;

Procedure QuickSort(l, r : word);
Var i, j : word;
    x, t : longint;
Begin
    i := l;
    j := r;
    x := b[(l + r) shr 1];
    Repeat
        While b[i] < x do inc(i);
        While b[j] > x do dec(j);
        If i <= j then
        Begin
            t := b[i]; b[i] := b[j]; b[j] := t;
            inc(i);
            dec(j);
        End;
    Until i > j;
    If l < j then QuickSort(l, j);
    If i < r then QuickSort(i, r);
End;

Function Value(x : word) : longint;
Begin
    exit(a[x] + b[v[x]]);
End;

Procedure Insert(x : word);
Var node, parent : word;
Begin
    inc(last);
    heap[last] := x;
    node := last;
    Repeat
        parent := node shr 1;
        If (parent = 0) or (Value(heap[parent]) <= Value(x)) then break;
        heap[node] := heap[parent];
        node := parent;
    Until false;
    heap[node] := x;
End;

Function Extract : word;
Var root, child, temp : word;
Begin
    temp := heap[1];
    heap[1] := heap[last];
    heap[last] := temp;
    dec(last);
    root := 1;
    temp := heap[root];
    While root shl 1 <= last do
    Begin
        child := root shl 1;
        If (child < last) and (Value(heap[child + 1]) < Value(heap[child])) then inc(child);
        If Value(temp) <= Value(heap[child]) then break;
        heap[root] := heap[child];
        root := child;
    End;
    heap[root] := temp;
    exit(heap[last + 1]);
End;

Procedure Init;
Var i : word;
Begin
    last := 0;
    For i := 1 to m do
    Begin
        v[i] := 1;
        Insert(i);
    End;
End;

Procedure Solve;
Var i : word;
Begin
    While k > 0 do
    Begin
        i := Extract;
        writeln(Value(i));
        inc(v[i]);
        Insert(i);
        dec(k);
    End;
End;

BEGIN
    Enter;
    QuickSort(1, n);
    Init;
    Solve;
END.