Program LSTTCD2;
Var L, R : array[1..2] of string[3];
    res : array[1..10000] of string[3];
    n, x, y, t, count : word;

Function Check : boolean;
Begin
    If abs(x - y) <> 1 then exit(true);
    If (x = 1) or (x = n) or (y = 1) or (y = n)
    then exit(true) else exit(false);
End;

Procedure Enter;
Var t : word;
Begin
    readln(n, x, y);
    If x = y then
    Begin
        If n = 1 then write('WIN') else write(-1);
        halt;
    End;
    If not Check then Begin write(-1); halt; End;
    If x < y then
        Begin
            L[1] := 'L 1'; L[2] := 'L 2';
            R[1] := 'R 1'; R[2] := 'R 2';
        End
    Else
        Begin
            L[1] := 'R 1'; L[2] := 'R 2';
            R[1] := 'L 1'; R[2] := 'L 2';
            t := x; x := y; y := t;
        End;
End;

Procedure PrintL(x : byte);
Begin
    inc(count); res[count] := L[x]; dec(t, x);
End;

Procedure PrintR(x : byte);
Begin
    inc(count); res[count] := R[x]; inc(t, x);
End;

Procedure Process1;
Begin
    t := x;
    While t > 2 do PrintL(2);
    If t = 2 then
        Begin PrintL(1); While t <> x - 1 do PrintR(2); End
    Else
        Begin PrintR(1); While t <> x - 1 do PrintR(2); End;
    PrintR(2);
    If t = y then exit;
    While t < y - 1 do PrintR(1);
    If y = n then
        Begin PrintR(1); exit; End;
    While t < n - 1 do PrintR(2);
    If t = n - 1 then
        Begin PrintR(1); While t <> y do PrintL(2); End
    Else
        Begin PrintL(1); While t <> y do PrintL(2); End;
End;

Procedure Process2;
Begin
    t := x;
    While t < y - 1 do PrintR(1);
    If y = n then
        Begin PrintR(1); exit; End;
    While t < n - 1 do PrintR(2);
    If t = n - 1 then
        Begin PrintR(1); While t <> y do PrintL(2); End
    Else
        Begin PrintL(1); While t <> y do PrintL(2); End;
End;

Procedure Solve;
Begin
    If x > 1 then Process1 else Process2;
End;

Procedure PrintResult;
Var i : word;
Begin
    If L[1, 1] = 'L' then
        For i := 1 to count do writeln(res[i])
    Else
        For i := count downto 1 do writeln(res[i]);
    writeln('WIN');
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.