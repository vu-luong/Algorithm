Program MATCH1;
Const max = 100;
Var a : array[1..max, 1..max] of boolean;
    mx, my, trace : array[1..max] of byte;
    m, n : byte;

Procedure Enter;
Var u, v : byte;
Begin
    readln(m, n);
    fillchar(a, sizeof(a), false);
    While not eof do
    Begin
        readln(u, v);
        a[u, v] := true;
    End;
End;

Procedure Init;
Begin
    fillchar(mx, sizeof(mx), 0);
    fillchar(my, sizeof(my), 0);
End;

Function FindPath : byte;
Var queue : array[1..max] of byte;
    i, j, first, last : byte;
Begin
    fillchar(trace, sizeof(trace), 0);
    first := 1;
    last := 0;
    For i := 1 to m do
        If mx[i] = 0 then
        Begin
            inc(last);
            queue[last] := i;
        End;
    While first <= last do
    Begin
        i := queue[first];
        inc(first);
        For j := 1 to n do
            If (trace[j] = 0) and a[i, j] and (mx[i] <> j) then
            Begin
                trace[j] := i;
                If my[j] = 0 then exit(j);
                inc(last);
                queue[last] := my[j];
            End;
    End;
    exit(0);
End;

Procedure Enlarge(finish : byte);
Var x, next : byte;
Begin
    Repeat
        x := trace[finish];
        next := mx[x];
        mx[x] := finish;
        my[finish] := x;
        finish := next;
    Until finish = 0;
End;

Procedure Solve;
Var f : byte;
Begin
    Repeat
        f := FindPath;
        If f <> 0 then Enlarge(f);
    Until f = 0;
End;

Procedure PrintResult;
Var x, count : byte;
Begin
    count := 0;
    For x := 1 to m do
        If mx[x] <> 0 then inc(count);
    writeln(count);
    For x := 1 to m do
        If mx[x] <> 0 then writeln(x, ' ', mx[x]);
End;

BEGIN
    Enter;
    Init;
    Solve;
    PrintResult;
END.