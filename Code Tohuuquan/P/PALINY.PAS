Program PALINY;
Var a : ansistring;
    n, res : word;

Procedure Enter;
Begin
    readln(n);
    readln(a);
End;

Function Max(x, y : word) : word;
Begin
    If x > y then exit(x) else exit(y);
End;

Procedure Solve;
Var mid, left, right : word;
Begin
    mid := 1;
    Repeat
        left := mid;
        right := mid;
        While left > 1 do
            If a[left - 1] = a[mid] then dec(left) else break;
        While right < n do
            If a[right + 1] = a[mid] then inc(right) else break;
        While (left > 1) and (right < n) do
            If a[left - 1] = a[right + 1] then
            Begin
                dec(left);
                inc(right);
            End Else break;
        res := Max(res, right - left + 1);
        mid := right + 1;
    Until mid > n;
End;

Procedure PrintResult;
Begin
    writeln(res);
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.