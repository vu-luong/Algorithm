Program POTATO;
Const max = 19;
Var res : array[0..max] of boolean;
    st : string;
    s : longint;

Procedure Init;
Var i : byte;
Begin
    For i := 0 to max do
        If (i mod 5 = 0) or (i mod 5 = 2) then res[i] := true;
End;

Procedure Solve;
Begin
    s := s mod 20;
    If res[s] then writeln('Hanako')
    else writeln('Taro');
End;

BEGIN
    Init;
    While not eof do
    Begin
        st := '';
        Repeat readln(st) Until st <> '';
        If st = '[CASE]' then
        Begin
            readln(s);
            Solve;
        End Else
        If st = '[END]' then break;
    End;
END.