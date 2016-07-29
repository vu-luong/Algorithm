Program MMASS;
Const max = 100;
Var stack, value : array[0..max] of integer;
    top : byte;
    st : string;

Procedure Enter;
Begin
    readln(st);
    top := 0;
End;

Procedure Solve;
Var i, x, err : integer;
    num : char;
Begin
    num := '1';
    value[0] := 1;
    x := 0;
    For i := length(st) downto 1 do
        If ('2' <= st[i]) and (st[i] <= '9') then num := st[i] else
        Begin
            If st[i] = ')' then
            Begin
                inc(top);
                value[top] := ord(num) - 48;
            End Else
            If st[i] = '(' then
            Begin
                stack[top] := stack[top] * value[top];
                inc(stack[top - 1], stack[top]);
                stack[top] := 0;
                dec(top);
            End Else
            Begin
                x := ord(num) - 48;
                Case st[i] of
                 'C' : inc(stack[top], 12 * x);
                 'O' : inc(stack[top], 16 * x);
                 'H' : inc(stack[top], x);
                End;
            End;
            num := '1';
        End;
End;

Procedure PrintResult;
Begin
    writeln(stack[0]);
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.
