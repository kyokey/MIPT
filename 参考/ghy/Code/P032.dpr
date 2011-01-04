program P032;

const
	inf = 'P032.in';
    ouf = 'P032.out';
    maxn = 210;
    eps = 1e-6;

type
	integer = longint;
	TCircle = record
    	x, y, r	: double;
    end;
    circleArray	= array[1 .. maxn] of TCircle;

var
	circle		: circleArray;
    n, answer	: integer;

procedure init;
var
	i	: integer;
begin
	readln(n);
    for i := 1 to n do readln(circle[i].x, circle[i].y, circle[i].r);
end;

function getAngle(x, y : double) : double;
begin
    if abs(x) < eps then getAngle := pi / 2 + pi * ord(y < 0)
    	else getAngle := arctan(y / x) + pi * ord(x < 0);
end;

function inside(p, q : TCircle) : boolean;
var
	d	: double;
begin
	d := sqrt(sqr(p.x - q.x) + sqr(p.y - q.y));
    inside := p.r + d < q.r + eps;
end;

procedure rotate(var x, y : double; alpha : double);
var
	u, v	: double;
begin
	u := x; v := y;
    x := u * cos(alpha) - v * sin(alpha);
    y := u * sin(alpha) + v * cos(alpha);
end;

procedure process(p, q : TCircle);
var
	i, cnt			: integer;
    d, r, l, alpha	: double;
    angle			: double;
begin
	if inside(p, q) or inside(q, p) then exit;
    p.x := p.x - q.x;
    p.y := p.y - q.y;

    alpha := getAngle(p.x, p.y); angle := -alpha;

    rotate(p.x, p.y, - alpha);
	d := sqrt(p.x * p.x + p.y * p.y); r := abs(p.r - q.r);
    l := sqrt(d * d - r * r);
    alpha := getAngle(l, r);
    if q.r > p.r then alpha := - alpha;
    angle := angle + alpha;
    cnt := 0;
    for i := 1 to n do begin
    	d := (circle[i].x - q.x) * sin(angle) + (circle[i].y - q.y) * cos(angle);
        d := abs(d + q.r);
        inc(cnt, ord(circle[i].r + eps > d)); 
    end;
    if cnt > answer then answer := cnt;
end;

procedure main;
var
	i, j, cnt	: integer;
begin
	answer := 0;
	for i := 1 to n do
    	for j := 1 to n do if i <> j then
        	process(circle[i], circle[j]);

    for i := 1 to n do begin
    	cnt := 0;
        for j := 1 to n do if inside(circle[i], circle[j]) then inc(cnt);
        if cnt > answer then answer := cnt;
    end;
    writeln(answer); 
end;

begin
	assign(input, inf); assign(output, ouf);
    reset(input); rewrite(output);
    init;
    main;
    close(input); close(output);
end.