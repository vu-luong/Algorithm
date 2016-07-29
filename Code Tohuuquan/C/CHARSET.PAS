Const x='FAILED';y='SUCCESS';Var a,b:set of char;s:string;BEGIN a:=[];b:=[];While not eof do
Begin readln(s);Case s[1]of'A':If s[2]in a then write(x) else
Begin a:=a+[s[2]];write(y);End;'B':If s[2]in b then write(x) else
Begin b:=b+[s[2]];write(y);End;'C':If not(s[2]in a)then write(x) else
Begin a:=a-[s[2]];write(y);End;'D':If not(s[2]in b)then write(x) else
Begin b:=b-[s[2]];write(y);End;'S':Case s[2]of'A':write(a<=b);'B':write(b<=a);End;'E':write(a=b);End;writeln;End;END.
