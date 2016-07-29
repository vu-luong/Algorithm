Program GOLD;
Const maxn = 15000;
      maxk = 32765;
Type Point = Record
      x, y : longint;
      sign : shortint;
     End;
Var a : array[1..maxn * 2] of Point;
    b : array[1..maxn] of integer;
    cover, max : array[1..maxk] of integer;
    n, w, s, pt : integer;

Procedure Enter;
Var i, j, x, y : longint;
Begin
    readln(s, w);
    readln(n);
    j := 0;
    For i := 1 to n do
    Begin
        readln(x, y);
        inc(j); a[j].x := x; a[j].y := y; a[j].sign := 1;
        inc(j); a[j].x := x; a[j].y := y + w; a[j].sign := -1;
        b[i] := x;
    End;
End;

Procedure Refine;
Var i, j : integer;

 Procedure Swap(i, j : integer);
 Var t : integer;
 Begin
     t := b[i];
     b[i] := b[j];
     b[j] := t;
 End;

 Procedure QuickSort(l, r : integer);
 Var i, j, x : integer;
 Begin
     If l >= r then exit;
     x := b[l + random(r - l + 1)];
     i := l;
     j := r;
     Repeat
         While b[i] < x do inc(i);
         While b[j] > x do dec(j);
         If i <= j then
         Begin
             Swap(i, j);
             inc(i);
             dec(j);
         End;
     Until i > j;
     QuickSort(l, j);
     QuickSort(i, r);
 End;

Begin
    QuickSort(1, n);
    j := 1;
    For i := 2 to n do
        If b[i] > b[j] then
        Begin
            inc(j);
            b[j] := b[i];
        End;
    pt := j;
End;

Function Smaller(p, q : Point) : boolean;
Begin
    If p.y = q.y then exit(p.sign > q.sign)
    else exit(p.y < q.y);
End;

Procedure Swap(i, j : integer);
Var t : Point;
Begin
    t := a[i];
    a[i] := a[j];
    a[j] := t;
End;

Procedure QuickSort(l, r : integer);
Var i, j : integer;
    x : Point;
Begin
    If l >= r then exit;
    x := a[l + random(r - l + 1)];
    i := l;
    j := r;
    Repeat
        While Smaller(a[i], x) do inc(i);
        While Smaller(x, a[j]) do dec(j);
        If i <= j then
        Begin
            Swap(i, j);
            inc(i);
            dec(j);
        End;
    Until i > j;
    QuickSort(l, j);
    QuickSort(i, r);
End;

Procedure Init;
Begin
    Refine;
    QuickSort(1, n * 2);
End;

Procedure Update(x, y, val : longint);

 Procedure Visit(k, l, r : longint);
 Var mid : longint;
 Begin
     If (b[l] > y) or (b[r] < x) then exit;
     If (x <= b[l]) and (b[r] <= y) then
     Begin
         inc(cover[k], val);
         inc(max[k], val);
         exit;
     End;
     mid := (l + r) shr 1;
     Visit(k shl 1, l, mid);
     Visit(k shl 1 + 1, mid + 1, r);
     If max[k shl 1] > max[k shl 1 + 1] then max[k] := max[k shl 1]
     else max[k] := max[k shl 1 + 1];
     inc(max[k], cover[k]);
 End;

Begin
    Visit(1, 1, pt);
End;

Procedure Solve;
Var res, i, j : integer;
Begin
    res := 0;
    For i := 1 to n * 2 do
        With a[i] do
        Begin
            Update(x, x + s, sign);
            If max[1] > res then res := max[1];
        End;
    writeln(res);
End;

Begin
    Enter;
    Init;
    Solve;
End.
