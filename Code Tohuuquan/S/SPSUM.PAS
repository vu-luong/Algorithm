{$MODE OBJFPC}
Program SPSUM;
Const maxn = 101;
      BASE = Round(1e15);
      Digit = 15;
      maxd = 7;
Type TNumber = array[0..maxd - 1] of int64;
Var f, g, h : array[0..maxn] of TNumber;
    s : array[0..9] of integer;
    x : array[0..maxn] of integer;
    n : integer;
    res : TNumber;

Procedure Enter;
Var s : ansistring;
    i : integer;
Begin
    readln(s);
    n := length(s);
    For i := 0 to n - 1 do
        x[i] := ord(s[n - i]) - 48;
End;

Operator := (c : int64) : TNumber;
Begin
    fillchar(result, sizeof(result), 0);
    result[0] := c;
End;

Operator + (a, b : TNumber) : TNumber;
Var i : integer;
    temp : int64;
Begin
    temp := 0;
    For i := 0 to maxd - 1 do
    Begin
        temp := a[i] + b[i] + temp;
        result[i] := temp mod BASE;
        temp := temp div BASE;
    End;
End;

Operator * (a : TNumber; c : int64) : TNumber;
Var i : integer;
    temp : int64;
Begin
    temp := 0;
    For i := 0 to maxd - 1 do
    Begin
        temp := a[i] * c + temp;
        result[i] := temp mod BASE;
        temp := temp div BASE;
    End;
End;

Function toString(a : TNumber) : ansistring;
Var s : ansistring;
    i : integer;
Begin
    result := '';
    For i := 0 to maxd - 1 do
    Begin
        str(a[i] : Digit, s);
        result := s + result;
    End;
    For i := 1 to length(result) do
        If not (Result[i] in ['0'..'9']) then
            result[i] := '0';
    i := 1;
    While (i < length(result)) and (result[i] = '0') do inc(i);
    delete(result, 1, i - 1);
End;

Procedure Init;
Var i : integer;
    p10 : TNumber;
Begin
    f[0] := 1;
    g[0] := 0;
    For i := 1 to n do
    Begin
        f[i] := f[i - 1] * 10;
        g[i] := f[i - 1] * 45 * i;
    End;
    p10 := 1;
    h[0] := 0;
    For i := 1 to n - 1 do
    Begin
        h[i] := h[i - 1] + p10 * x[i - 1];
        p10 := p10 * 10;
    End;
    s[0] := 0;
    For i := 1 to 9 do
        s[i] := s[i - 1] + i;
End;

Procedure Solve;
Var i, j : integer;
Begin
    res := 0;
    For i := 0 to n - 1 do
        res := res + x[i];
    For i := n - 1 downto 0 do
    Begin
        j := x[i] - 1;
        If j >= 0 then
            res := res + f[i] * s[j] + g[i] * (j + 1);
        res := res + h[i] * x[i];
    End;
    write(toString(res));
End;

BEGIN
    Enter;
    Init;
    Solve;
END.