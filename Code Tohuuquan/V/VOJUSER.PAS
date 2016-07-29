{$B-}var a:array[1..100]of string;i,j,k,l:byte;s,t:string;
begin
l:=0;while not eof do
begin
readln(s);repeat
i:=pos('{#',s);if i=0 then break else
begin
j:=i;while(j<=length(s))and(s[j]<>'}')do inc(j);t:=copy(s,i+2,j-i-2);delete(s,i,j-i+1);if(pos('#',t)>0)then continue;k:=0;for i:=1to l do if a[i]=t then begin k:=1;break;end;if k=0 then begin inc(l); a[l]:=t;end;end;until false;end;write(l);end.
