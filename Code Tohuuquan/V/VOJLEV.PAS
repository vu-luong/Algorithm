var l,n:byte;r,d,t:real;begin
read(d);t:=0;n:=1;r:=1;repeat inc(n);r:=r*1.07;t:=t+0.5*r;until t>d;write(n);end.
