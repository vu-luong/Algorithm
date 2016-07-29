Program NKCITY;
Const maxn = 1000;
      maxm = 10001;
Type TEdge = record
      u, v, c : word;
      mark : boolean;
     End;
Var e : array[1..maxm] of TEdge;
    lab : array[1..maxn] of integer;
    n, m : word;

Procedure Enter;
Var i : word;
Begin
    readln(n, m);
    For i := 1 to m do
        With e[i] do readln(u, v, c);
    inc(m);
    With e[m] do
    Begin
        u := 0;
        v := 0;
        c := maxint;
    End;

    For i := 1 to n do lab[i] := -1;
    For i := 1 to m do e[i].mark := false;
End;

Function GetRoot(v : word) : word;
Begin
    While lab[v] > 0 do v := lab[v];
    exit(v);
End;

Procedure Union(r1, r2 : word);
Var x : integer;
Begin
    x := lab[r1] + lab[r2];
    If lab[r1] < lab[r2] then
        Begin
            lab[r1] := x;
            lab[r2] := r1;
        End
    Else
        Begin
            lab[r1] := r2;
            lab[r2] := x;
        End;
End;

Procedure AdjHeap(root, last : word);
Var key : TEdge;
    child : word;
Begin
    key := e[root];
    While root shl 1 <= last do
    Begin
        child := root shl 1;
        If (child < last) and (e[child + 1].c < e[child].c) then inc(child);
        If key.c <= e[child].c then break;
        e[root] := e[child];
        root := child;
    End;
    e[root] := key;
End;

Procedure Swap(Var x, y : TEdge);
Var t : TEdge;
Begin
    t := x;
    x := y;
    y := t;
End;

Procedure Solve;
Var i, r1, r2, count : word;
Begin
    count := 0;
    For i := m shr 1 downto 1 do AdjHeap(i, m);
    For i := m downto 2 do
    Begin
        Swap(e[1], e[i]);
        AdjHeap(1, i - 1);
        r1 := GetRoot(e[i].u);
        r2 := GetRoot(e[i].v);
        If r1 <> r2 then
        Begin
            e[i].mark := true;
            inc(count);
            If count = n - 1 then exit;
            Union(r1, r2);
        End;
    End;
End;

Procedure PrintResult;
Var i, w : word;
Begin
    w := 0;
    For i := 1 to m do
        If (e[i].mark) and (e[i].c > w) then w := e[i].c;
    writeln(w);
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.