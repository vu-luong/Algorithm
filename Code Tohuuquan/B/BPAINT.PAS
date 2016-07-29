{$B-}

Program BPAINT;

Const max = 50;

      maxq = max * max;

      dx : array[1..4] of -1..1 = (0, -1, 0, 1);

      dy : array[1..4] of -1..1 = (-1, 0, 1, 0);


Type Area = Record

      touch : array[1..maxq] of boolean;

      s : word;

      x, y : byte;

      free : boolean;

     End;


Var a : array[1..max, 1..max] of word;

    n, m : byte;

    k, q : word;

    items : array[1..maxq] of Area;



Procedure Enter;

Var i, j : byte;

Begin

    readln(n, m, k);

    For i := 1 to n do

        For j := 1 to m do read(a[i, j]);

End;



Procedure Init;

Var b : array[0..max + 1, 0..max + 1] of boolean;

    f : array[1..max, 1..max] of word;

    i, j : byte;

    t : Area;

    s, l : word;



 Procedure DFS1(x, y : byte);

 Var i, u, v : byte;

 Begin

     inc(s);

     b[x, y] := false;

     f[x, y] := q;

     For i := 1 to 4 do

     Begin

         u := x + dx[i];

         v := y + dy[i];

         If b[u, v] and (a[x, y] = a[u, v]) then DFS1(u, v);

     End;

 End;



 Procedure DFS2(x, y : byte);

 Var i, u, v : byte;

 Begin

     b[x, y] := false;

     For i := 1 to 4 do

     Begin

         u := x + dx[i];

         v := y + dy[i];

         If (1 <= u) and (u <= n) and (1 <= v) and (v <= m) then items[l].touch[f[u, v]] := true;

         If b[u, v] and (a[x, y] = a[u, v]) then DFS2(u, v);

     End;

 End;



Begin

    fillchar(b, sizeof(b), false);

    For i := 1 to n do

        For j := 1 to m do b[i, j] := true;

    q := 0;

    For i := 1 to n do

        For j := 1 to m do

        If b[i, j] then

        Begin

            inc(q);

            s := 0;

            DFS1(i, j);


            fillchar(t.touch, sizeof(t.touch), false);

            t.s := s;

            t.x := i;

            t.y := j;

            t.free := true;

            items[q] := t;

        End;


    fillchar(b, sizeof(b), false);

    For i := 1 to n do

        For j := 1 to m do b[i, j] := true;

    For l := 1 to q do DFS2(items[l].x, items[l].y);

    For l := 1 to q do items[l].touch[l] := false;

End;



Procedure Solve;

Var u, v, i, m : word;



 Procedure Union(u, v : word);

 Var i : word;

 Begin

     inc(items[u].s, items[v].s);

     For i := 1 to q do

         If items[v].touch[i] then items[u].touch[i] := true;

     items[v].free := false;

     dec(q);

     With items[v] do writeln(x, ' ', y, ' ', a[items[u].x, items[u].y]);

 End;



Begin

    u := 1;

    For i := 2 to q do

        If items[i].s > items[u].s then u := i;

    While (q > 1) and (k > 0) do

    Begin

        m := 0;

        v := 0;

        For i := 1 to q do

            If items[i].free and (items[u].touch[i]) and (items[i].s > m) then

            Begin

                m := items[i].s;

                v := i;

            End;

        Union(u, v);

        dec(k);

    End;

    With items[u] do

    Begin

        If a[x, y] = 1 then v := 2 else v := 1;

        For i := 1 to k do

        Begin

            writeln(x, ' ', y, ' ', v);

            v := 3 - v;

        End;

    End;

End;



BEGIN

    Enter;

    Init;

    Solve;

END.

