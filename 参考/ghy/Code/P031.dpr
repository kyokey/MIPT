const
	inf = 'P031.in';
    ouf = 'P031.out';
    z = 700;

type
	integer = longint;
    TPoint 	= record
    	x, y	: double;
    end;

var
	pnt			: array[1 .. 100] of TPoint;
    f			: array[1 .. 100] of integer;
    n, i, j, k	: integer;
    s, t		: double;
    p, q		: TPoint;
	

begin
    readln(n);
    for i := 1 to n do readln(pnt[i].x, pnt[i].y, f[i]);
    s := 10e10;
    for i := -z to z do
    	for j := -z to z do begin
        	t := 0; q.x := i * 1500 / z / 100; q.y := j * 1500 / z / 100;
            for k := 1 to n do begin
            	t := t + f[k] * sqrt(sqr(q.x - pnt[k].x) + sqr(q.y - pnt[k].y));
                if t > s then break;
            end;
            if t < s then begin
            	s := t;
                p := q;
            end;
        end;
    writeln(p.x : 0 : 2, ' ', p.y : 0 : 2);
end.
