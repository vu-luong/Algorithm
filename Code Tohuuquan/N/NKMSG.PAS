Program NKMSG;
Const maxn = 1500;
Var a : array[1..maxn, 1..maxn] of boolean;
    num, low, group, stack : array[1..maxn] of word;
    n, last, count, SCC : word;

Procedure Enter;
Var u, v : word;
    ch : char;
Begin
    readln(n);
    fillchar(a, sizeof(a), false);
    For u := 1 to n do
    Begin
        For v := 1 to n do
        Begin
            read(ch);
            If ch = '1' then a[u, v] := true;
        End;
        readln;
    End;
End;

Procedure Init;
Begin
    fillchar(num, sizeof(num), 0);
    fillchar(group, sizeof(group), 0);
    last := 0;
    count := 0;
    SCC := 0;
End;

Procedure Push(u : word);
Begin
    inc(last);
    stack[last] := u;
End;

Function Pop : word;
Begin
    Pop := stack[last];
    dec(last);
End;

Function Min(x, y : word) : word;
Begin
    If x < y then exit(x) else exit(y);
End;

Procedure DFSVisit(u : word);
Var v : word;
Begin
    inc(count);
    num[u] := count;
    low[u] := maxn + 1;
    Push(u);
    For v := 1 to n do
        If a[u, v] and (group[v] = 0) then
            If num[v] = 0 then
                Begin
                    DFSVisit(v);
                    low[u] := Min(low[u], low[v]);
                End
            Else low[u] := Min(low[u], num[v]);

    If low[u] >= num[u] then
    Begin
        inc(SCC);
        Repeat
            v := Pop;
            group[v] := SCC;
        Until v = u;
    End;
End;

Procedure Solve;
Var choose : array[1..maxn] of boolean;
    u, v : word;
Begin
    For u := 1 to n do
        If num[u] = 0 then DFSVisit(u);
    fillchar(choose, sizeof(choose), true);
    For u := 1 to n do
        For v := 1 to n do
            If a[u, v] and (group[u] <> group[v]) then
                choose[group[v]] := false;
    count := 0;
    For u := 1 to SCC do
        If choose[u] then inc(count);
    writeln(count);
End;

BEGIN
    Enter;
    Init;
    Solve;
END.
