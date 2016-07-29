Program ASSIGN1;
Const maxn = 200;
Var c : array[1..maxn, 1..maxn] of integer;
    n : byte;
    res, max : integer;

Procedure Enter;
Var i, j : byte;
Begin
    readln(n);
    For i := 1 to n do
        For j := 1 to n do
        Begin
            read(c[i, j]);
            If max < c[i, j] then max := c[i, j];
        End;
End;

Function NumMatch(x : integer) : byte;
Var trace, mx, my : array[1..maxn] of byte;
    i, finish, count : byte;

 Procedure IncEdge;
 Var x, next, temp : byte;
 Begin
     temp := finish;
     Repeat
         x := trace[temp];
         next := mx[x];
         mx[x] := temp;
         my[temp] := x;
         temp := next;
     Until temp = 0;
 End;

 Procedure FindPath(i : byte);
 Var j : byte;
 Begin
     For j := 1 to n do
         If (trace[j] = 0) and (c[i, j] <= x) and (c[i, j] > 0) then
         Begin
             trace[j] := i;
             If my[j] = 0 then
             Begin
                 finish := j;
                 exit;
             End;
             FindPath(my[j]);
         End;
 End;

Begin
    fillchar(mx, sizeof(mx), 0);
    fillchar(my, sizeof(my), 0);
    count := 0;
    For i := 1 to n do
        If mx[i] = 0 then
        Begin
            fillchar(trace, sizeof(trace), 0);
            finish := 0;
            FindPath(i);
            If finish <> 0 then
            Begin
                IncEdge;
                inc(count);
            End;
        End;
    exit(count);
End;

Procedure Solve;
Var right, left, mid, s : integer;
Begin
    left := 1;
    right := max;
    Repeat
        mid := (left + right) shr 1;
        s := NumMatch(mid);
        If s = n then
        Begin
            res := mid;
            right := mid;
        End;
        If s < n then left := mid + 1;
    Until left = right;
    writeln(res);
End;

BEGIN
    Enter;
    Solve;
END.