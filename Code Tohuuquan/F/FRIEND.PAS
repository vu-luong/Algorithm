Program FRIEND;
Const maxn = 100000;
Type Arr = array[1..2] of longint;
Var a : array[1..maxn] of Arr;
    n, b, res : longint;

Procedure Enter;
Var i : longint;
Begin
    readln(n, b);
    For i := 1 to n do
    Begin
        readln(a[i, 1]);
        a[i, 2] := i;
    End;
End;

Procedure Swap(Var x, y : Arr);
Var t : Arr;
Begin
    t := x;
    x := y;
    y := t;
End;

Procedure QuickSort(l, r : longint);
Var i, j, x : longint;
Begin
    If l >= r then exit;
    i := l;
    j := r;
    x := a[l + random(r - l + 1), 1];
    While i < j do
    Begin
        While a[i, 1] < x do inc(i);
        While a[j, 1] > x do dec(j);
        If i <= j then
        Begin
            If i < j then Swap(a[i], a[j]);
            inc(i);
            dec(j);
        End;
    End;
    QuickSort(l, j);
    QuickSort(i, r);
End;

Procedure Solve;
Var i, left, right, mid, key : longint;
    flag : boolean;
Begin
    mid := 1;
    For i := 1 to n do
    Begin
        key := b - a[i, 1];
        left := 1;
        right := n;
        flag := false;
        While left <= right do
        Begin
            mid := (left + right) shr 1;
            If a[mid, 1] = key then
            Begin
                flag := true;
                break;
            End;
            If key < a[mid, 1] then right := mid - 1 else left := mid + 1;
        End;
        If flag then
        Begin
            For left := mid downto 1 do
                If a[left, 1] <> a[mid, 1] then break else
                    If a[left, 2] > a[i, 2] then inc(res);
            For right := mid + 1 to n do
                If a[right, 1] <> a[mid, 1] then break else
                    If a[right, 2] > a[i, 2] then inc(res);
        End;
    End;
End;

Procedure PrintResult;
Begin
    writeln(res);
End;

BEGIN
    Enter;
    QuickSort(1, n);
    Solve;
    PrintResult;
END.