{$MODE OBJFPC}
Program NKBM;
Const maxn = 1000;
      maxm = maxn * maxn;
Var adj, link : array[1..maxm] of integer;
    head : array[1..maxn + 1] of integer;
    match, list : array[1..maxn] of integer;
    avail : array[1..maxn] of boolean;
    p, q, m, nList : integer;

Procedure Enter;
Var i, x, y : integer;
Begin
    readln(p, q, m);
    fillchar(head, sizeof(head), 0);
    For i := 1 to m do
    Begin
        readln(x, y);
        adj[i] := y;
        link[i] := head[x];
        head[x] := i;
    End;
End;

Procedure Init;
Var i : integer;
Begin
    fillchar(match, sizeof(match), 0);
    For i := 1 to p do list[i] := i;
    nList := p;
End;

Procedure Solve;
Var found : boolean;
    old, i : integer;

 Procedure Visit(x : integer);
 Var i, y : integer;
 Begin
     i := head[x];
     While i <> 0 do
     Begin
         y := adj[i];
         If avail[y] then
         Begin
             avail[y] := false;
             If match[y] = 0 then found := true else Visit(match[y]);
             If found then
             Begin
                 match[y] := x;
                 exit;
             End;
         End;
         i := link[i];
     End;
 End;

Begin
    Repeat
        old := nList;
        fillchar(avail, sizeof(avail), true);
        For i := nList downto 1 do
        Begin
            found := false;
            Visit(list[i]);
            If found then
            Begin
                list[i] := list[nList];
                dec(nList);
            End;
        End;
    Until old = nList;
End;

Procedure PrintResult;
Var j, k : integer;
Begin
    k := 0;
    For j := 1 to q do
        If match[j] <> 0 then inc(k);
    writeln(k);
End;

BEGIN
    Enter;
    Init;
    Solve;
    PrintResult;
END.
