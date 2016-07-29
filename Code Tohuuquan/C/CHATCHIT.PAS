Program CHATCHIT;
Var s : ansistring;
    ok : boolean;

Procedure Enter;
Begin
    readln(s);
End;

Procedure Ins(Var s : ansistring; w : string; n : word);
Var s1, s2 : ansistring;
    i : word;
Begin
    s1 := '';
    For i := 1 to n - 1 do s1 := s1 + s[i];
    s2 := '';
    For i := n to length(s) do s2 := s2 + s[i];
    s := s1 + w + s2;
End;

Procedure R(w : string);
Var n : word;
Begin
    Repeat
        n := pos(w, s);
        If n <> 0 then
        Begin
            delete(s, n, length(w));
            If w = 'j' then ins(s, 'gi', n) else
            If w = 'w' then ins(s, 'qu', n) else
            If w = 'f' then ins(s, 'ph', n) else
            If (w = 'dz') or (w = 'z') then ins(s, 'd', n) else
            If (w = ' k ') or (w = ' ko ') or (w = ' hok ') then ins(s, ' khong ', n) else
            If w = ' ng ' then ins(s, ' nguoi ', n) else
            If w = ' n ' then ins(s, ' nhieu ', n) else
            If w = ' dc ' then ins(s, ' duoc ', n) else
            If w = ' ntn ' then ins(s, ' nhu the nao ', n) else
            If w = ' kq ' then ins(s, ' ket qua ', n);
        End;
    Until n = 0;
End;

Procedure PrintResult;
Var i : byte;
Begin
    s := ' ' + s + ' ';
    R('j'); R('w'); R('f'); R('dz'); R('z');
    R(' k '); R(' ko '); R(' ng '); R(' n '); R(' dc '); R(' hok '); R(' ntn '); R(' kq ');
    delete(s, 1, 1);
    delete(s, length(s), 1);
    writeln(s);
End;

BEGIN
    Enter;
    PrintResult;
END.