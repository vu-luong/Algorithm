Program NKLEAGUE;
Const maxn = 1000;
Type PNode = ^TNode;
     TNode = Record
      Info : word;
      Link : PNode;
     End;
Var a : array[1..maxn, 1..maxn] of boolean;
    free : array[1..maxn] of boolean;
    first, last : PNode;
    n : word;

Procedure Enter;
Var i, j : word;
    c : char;
Begin
    readln(n);
    For i := 1 to n do
    Begin
        For j := 1 to n do
        Begin
            read(c);
            a[i, j] := (c = '1');
        End;
        readln;
    End;
End;

Procedure Init;
Var i : word;
    p : PNode;
    stop : boolean;
Begin
    fillchar(free, sizeof(free), true);
    New(first);
    first^.Info := 1;
    first^.Link := Nil;
    free[1] := false;
    last := first;
    Repeat
        stop := true;
        For i := 1 to n do
            If free[i] and a[last^.Info, i] then
            Begin
                stop := false;
                free[i] := false;
                New(p);
                p^.Info := i;
                p^.Link := Nil;
                last^.Link := p;
                last := p;
                break;
            End;
    Until stop;
End;

Procedure Solve;
Var i : word;
    p, q : PNode;
Begin
    For i := 2 to n do
    If free[i] then
    Begin
        New(p);
        p^.Info := i;
        If a[i, first^.Info] then
        Begin
            p^.Link := first;
            first := p;
        End Else
        If a[last^.Info, i] then
        Begin
            last^.Link := p;
            last := p;
        End Else
        Begin
            q := first;
            While true do
                If a[q^.Info, i] and a[i, q^.Link^.Info] then
                Begin
                    p^.Link := q^.Link;
                    q^.Link := p;
                    break;
                End Else q := q^.Link;
        End;
    End;
End;

Procedure PrintResult;
Begin
    While first <> Nil do
    Begin
        write(first^.Info, ' ');
        first := first^.Link;
    End;
End;

BEGIN
    Enter;
    Init;
    Solve;
    PrintResult;
END.