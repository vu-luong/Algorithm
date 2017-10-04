program HelloWord;     

type point = record
    x, y: integer;
end;

type student = record
    name: string;
    dob: string;
    gender: boolean;
    informatic_point: integer;
end;

var 
    s: point;
    a: array[1..100] of point;
    st1 : student;
    st2 : student;

begin

    writeln('Nhap toa do');
    readln(s.x, s.y);

    writeln('(', s.x, ', ' , s.y, ')');

end.
