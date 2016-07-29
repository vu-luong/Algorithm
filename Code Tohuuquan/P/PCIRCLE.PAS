Program PCIRCLE;
Const maxn = 18;
      maxs = maxn shl 1 - 1;
      limit = 10000;
      res : array[2..9] of longint =
       (2, 2, 4, 96, 1024, 2880, 81024, 770144);
Var a : array[1..maxn] of byte;
    avail : array[1..maxn] of boolean;
    prime : array[3..maxs] of boolean;
    n : byte;
    count : longint;

Procedure Enter;
Begin
    readln(n);
    writeln(res[n]);
End;

Procedure Init;
Var i, j : byte;
Begin
    n := n shl 1;
    a[1] := 1;
    fillchar(avail, sizeof(avail), true);
    avail[1] := false;
    count := 0;

    fillchar(prime, sizeof(prime), true);
    For i := 3 to maxs do
        If prime[i] then
        Begin
            j := i shl 1;
            While j <= maxs do
            Begin
                prime[j] := false;
                inc(j, i);
            End;
        End;
End;

Procedure PrintResult;
Var i : byte;
Begin
    If prime[a[1] + a[n]] then
    Begin
        inc(count);
        For i := 1 to n do write(a[i], ' ');
        writeln;
        If count = limit then halt;
    End;
End;

Procedure Find(x : byte);
Var i : byte;
Begin
    If x > n then PrintResult else
    For i := 1 to n do
        If avail[i] and prime[a[x - 1] + i] then
        Begin
            a[x] := i;
            avail[i] := false;
            Find(x + 1);
            avail[i] := true;
        End;
End;

BEGIN
    Enter;
    Init;
    Find(2);
END.