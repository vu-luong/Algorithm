Program QBPAL;
Const max = 120;
Var l : array[1..max, 1..max] of string;
    s : string[max];
    n : integer;

Function Add(a, b : string) : string;
Var i, s, cr : integer;
    res : string;
Begin
    While length(a) < length(b) do a := '0' + a;
    While length(a) > length(b) do b := '0' + b;
    res := '';
    cr := 0;
    For i := length(a) downto 1 do
    Begin
        s := ord(a[i]) + ord(b[i]) + cr - 96;
        cr := s div 10;
        res := chr(s mod 10 + 48) + res;
    End;
    If cr > 0 then res := '1' + res;
    exit(res);
End;

Function Sub(a, b : string) : string;
Var i, s, cr : integer;
    res : string;
Begin
    While length(a) < length(b) do a := '0' + a;
    While length(a) > length(b) do b := '0' + b;
    res := '';
    cr := 0;
    For i := length(a) downto 1 do
    Begin
        s := ord(a[i]) - ord(b[i]) - cr;
        If s < 0 then
        Begin
            inc(s, 10);
            cr := 1;
        End Else cr := 0;
        res := chr(s + 48) + res;
    End;
    While (res[1] = '0') and (length(res) > 1) do delete(res, 1, 1);
    exit(res);
End;

Procedure Enter;
Begin
    readln(s);
    n := length(s);
End;

Procedure Solve;
Var i, j, k : integer;
Begin
    For i := 1 to n do l[i, i] := '1';
    For k := 1 to n - 1 do
        For i := 1 to n - k do
        Begin
            j := i + k;
            l[i, j] := Add(l[i + 1, j], l[i, j - 1]);
            If s[i] = s[j] then l[i, j] := Add(l[i, j], '1')
            else l[i, j] := Sub(l[i, j], l[i + 1, j - 1]);
        End;
End;

Procedure PrintResult;
Begin
    writeln(l[1, n]);
End;

BEGIN
    Enter;
    Solve;
    PrintResult;
END.