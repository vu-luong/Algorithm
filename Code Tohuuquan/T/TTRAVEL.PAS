{$MODE OBJFPC}
program TTRAVEL;
const
  maxN = Round(8e4);
  sCheck = 'ast';

var
  p, id : array[0..maxN] of Integer;
  n, i, k : Integer;
  c : Char;

begin
  Read(n);
  p[0] := -1; id[0] := -1;
  for i := 1 to n do
    begin
      repeat
        Read(c);
      until Pos(c, sCheck) > 0;

      case c of
        'a':
          begin
            Read(k);
            p[i] := i - 1;
            id[i] := k;
          end;
        's':
          begin
            p[i] := p[p[i - 1]];
            id[i] := id[p[i - 1]];
          end;
        't':
          begin
            Read(k);
            p[i] := p[k - 1];
            id[i] := id[k - 1];
          end;
      end;
      WriteLn(id[i]);
    end;
end.