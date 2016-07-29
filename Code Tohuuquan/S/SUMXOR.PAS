var n,s:longint;begin read(n);s:=n;repeat dec(n);s:=s xor n;until n=1;write(s);end.
