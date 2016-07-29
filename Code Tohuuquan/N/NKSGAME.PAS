Program NKSGAME;
Const maxn = 100000;
Var b, c : array[1..maxn] of longint;
    n, min : longint;

Procedure Enter;
Var i : longint;
Begin
    readln(n);
    For i := 1 to n do read(b[i]);
    For i := 1 to n do read(c[i]);
End;

Procedure QuickSort;

 Procedure Sort(l, r : longint);
 Var i, j, x, t : longint;
 Begin
     i := l;
     j := r;
     x := b[(l + r) div 2];
     Repeat
         While b[i] < x do inc(i);
         While b[j] > x do dec(j);
         If i <= j then
         Begin
             t := b[i];
             b[i] := b[j];
             b[j] := t;
             inc(i);
             dec(j);
         End;
     Until i > j;
     If l < j then Sort(l, j);
     If i < r then Sort(i, r);
 End;

Begin
    Sort(1, n);
End;

Procedure Solve;
Var x, y, t, s, i, k1, k2 : longint;
Begin
    min := maxlongint;
    For i := 1 to n do
    Begin
        s := -c[i];
        x := 1;
        y := n;
        If s < b[1] then s := b[1] else
        If s > b[n] then s := b[n] else
        Begin
            Repeat
                t := (x + y) div 2;
                If b[t] = s then
                Begin
                    min := 0;
                    exit;
                End;
                If b[t] < s then x := t else y := t;
            Until abs(x - y) = 1;
        End;
        k1 := abs(c[i] + b[x]);
        k2 := abs(c[i] + b[y]);
        If k1 < min then min := k1;
        If k2 < min then min := k2;
    End;
End;

Procedure PrintResult;
Begin
    writeln(min);
End;

BEGIN
    Enter;
    QuickSort;
    Solve;
    PrintResult;
END.
