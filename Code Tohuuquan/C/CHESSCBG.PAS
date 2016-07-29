Program CHESSCBG;
Var pow : array[1..16] of word;
    t : array[word] of word;
    free : array[word] of boolean;
    queue : array[1..12870] of word;
    start, finish, first, last : word;

Procedure Enter;
Var i, j : byte;
    c : char;
Begin
    pow[16] := 1;
    For i := 15 downto 1 do pow[i] := pow[i + 1] shl 1;

    start := 0;
    For i := 0 to 3 do
    Begin
        For j := 1 to 4 do
        Begin
            read(c);
            If c = '1' then inc(start, pow[i shl 2 + j]);
        End;
        readln;
    End;
    finish := 0;
    For i := 0 to 3 do
    Begin
        For j := 1 to 4 do
        Begin
            read(c);
            If c = '1' then inc(finish, pow[i shl 2 + j]);
        End;
        readln;
    End;
    first := 1;
    last := 0;
    fillchar(free, sizeof(free), true);
End;

Procedure Push(x : word);
Var i : byte;
Begin
    If not free[x] then exit;
    inc(last);
    queue[last] := x;
    free[x] := false;
    If x = finish then
    Begin
        writeln(t[x]);
        halt;
    End;
End;

Function Pop : word;
Begin
    Pop := queue[first];
    inc(first);
End;

Procedure TryLeft(u : word; i : byte);
Var v : word;
Begin
    v := u - pow[i] + pow[i - 1];
    t[v] := t[u] + 1;
    Push(v);
End;

Procedure TryRight(u : word; i : byte);
Var v : word;
Begin
    v := u - pow[i] + pow[i + 1];
    t[v] := t[u] + 1;
    Push(v);
End;

Procedure TryUp(u : word; i : byte);
Var v : word;
Begin
    v := u - pow[i] + pow[i - 4];
    t[v] := t[u] + 1;
    Push(v);
End;

Procedure TryDown(u : word; i : byte);
Var v : word;
Begin
    v := u - pow[i] + pow[i + 4];
    t[v] := t[u] + 1;
    Push(v);
End;

Procedure BFS;
Var u : word;
    i : byte;
Begin
    Push(start);
    While first <= last do
    Begin
        u := Pop;
        For i := 1 to 16 do
            If u and pow[i] <> 0 then
            Begin
                If (i mod 4 <> 1) and (u and pow[i - 1] = 0) then TryLeft(u, i);
                If (i mod 4 <> 0) and (u and pow[i + 1] = 0) then TryRight(u, i);
                If (i > 4) and (u and pow[i - 4] = 0) then TryUp(u, i);
                If (i < 13) and (u and pow[i + 4] = 0) then TryDown(u, i);
            End;
    End;
End;

BEGIN
    Enter;
    BFS;
END.