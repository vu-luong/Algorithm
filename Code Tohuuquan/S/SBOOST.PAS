Program SBOOST;
Const maxn = 10000;
Type TComp = Record
      f, m : longint;
      value : real;
      id : word;
     End;
Var a : array[1..maxn] of TComp;
    res : array[1..maxn] of boolean;
    f, m : longint;
    n : word;
    none : boolean;

Procedure Enter;
Var i : word;
Begin
    readln(f, m, n);
    For i := 1 to n do
    Begin
        readln(a[i].f, a[i].m);
        a[i].value := a[i].f / a[i].m;
        a[i].id := i;
    End;
End;

Procedure Swap(Var x, y : TComp);
Var t : TComp;
Begin
    t := x;
    x := y;
    y := t;
End;

Procedure QuickSort(l, r : word);
Var i, j : word;
    x : real;
Begin
    If l >= r then exit;
    i := l;
    j := r;
    x := a[l + random(r - l + 1)].value;
    While i < j do
    Begin
        While a[i].value > x do inc(i);
        While a[j].value < x do dec(j);
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
Var i : word;
Begin
    none := true;
    For i := 1 to n do
        If (f / m) < (f + a[i].f) / (m + a[i].m) then
        Begin
            inc(f, a[i].f);
            inc(m, a[i].m);
            res[a[i].id] := true;
            none := false;
        End Else break;
End;

Procedure PrintResult;
Var i : word;
Begin
    If none then write('NONE') else
    For i := 1 to n do
        If res[i] then writeln(i);
End;

BEGIN
    Enter;
    QuickSort(1, n);
    Solve;
    PrintResult;
END.