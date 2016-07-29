Program ELEVATOR;
Const maxk = 400;
      maxa = maxk * 100;
Type TElv = Record
      h, c : byte;
      a : word;
     End;
Var e : array[1..maxk] of TElv;
    height, num : array[0..maxa] of word;
    k : word;

Procedure Enter;
Var i : word;
Begin
    readln(k);
    For i := 1 to k do
        With e[i] do readln(h, a, c);
End;

Procedure QuickSort(l, r : word);
Var i, j, x : word;
    t : TElv;
Begin
    If l >= r then exit;
    i := l;
    j := r;
    x := e[l + random(r - l + 1)].a;
    Repeat
        While e[i].a < x do inc(i);
        While e[j].a > x do dec(j);
        If i <= j then
        Begin
            t := e[i]; e[i] := e[j]; e[j] := t;
            inc(i);
            dec(j);
        End;
    Until i > j;
    QuickSort(l, j);
    QuickSort(i, r);
End;

Procedure Solve;
Var i, j, s : word;
Begin
    For i := 1 to k do
    Begin
        fillchar(num, sizeof(num), 0);
        For j := e[i].h to e[i].a do
        Begin
            s := height[j - e[i].h] + e[i].h;
            If (s > height[j]) and (num[j - e[i].h] < e[i].c) then
            Begin
                height[j] := s;
                num[j] := num[j - e[i].h] + 1;
            End;
        End;
    End;
End;

Procedure PrintResult;
Var i, res : word;
Begin
    res := 0;
    For i := 1 to e[k].a do
        If height[i] > res then res := height[i];
    writeln(res);
End;

BEGIN
    Enter;
    QuickSort(1, k);
    Solve;
    PrintResult;
END.
