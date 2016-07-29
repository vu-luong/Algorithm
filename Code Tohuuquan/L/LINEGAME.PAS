Program LINEGAME;
Var n, pre, cur : longint;
    res : int64;

BEGIN
    readln(n);
    read(pre);
    res := pre;
    While n > 1 do
    Begin
        read(cur);
        If cur > pre then res := res - pre + cur;
        pre := cur;
        dec(n);
    End;
    writeln(res);
END.
