Program VBGRASS;
Const maxr = 100;
      maxc = 100;
      dx : array[1..4] of -1..1 = (0, -1, 0, 1);
      dy : array[1..4] of -1..1 = (-1, 0, 1, 0);
Var a : array[0..maxr + 1, 0..maxc + 1] of boolean;
    r, c : byte;
    count : word;

Procedure Enter;
Var i, j : byte;
    t : char;
Begin
    fillchar(a, sizeof(a), false);
    readln(r, c);
    For i := 1 to r do
    Begin
        For j := 1 to c do
        Begin
            read(t);
            If t = '#' then a[i, j] := true;
        End;
        readln;
    End;
End;

Procedure Solve;
Var i, j : byte;
    s : word;

 Procedure DFS(x, y : byte);
 Var i, u, v : byte;
 Begin
     inc(s);
     a[x, y] := false;
     For i := 1 to 4 do
     Begin
         u := x + dx[i];
         v := y + dy[i];
         If a[u, v] then DFS(u, v);
     End;
 End;

Begin
    count := 0;
    For i := 1 to r do
        For j := 1 to c do
            If a[i, j] then
            Begin
                s := 0;
                DFS(i, j);
                inc(count, s div 2 + s mod 2);
            End;
End;

Procedure PrintResult;
Begin
    writeln(count);
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.