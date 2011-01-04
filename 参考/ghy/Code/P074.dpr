program P074;

const
	inf		= 'P074.in';
    ouf		= 'P074.out';
    maxn 	= 40;
    eps		= 1e-7;

type
	integer	= longint;
    vector	= record
    	x, y, z	: double;
    end;

var
	_ball, ball		: array[1 .. maxn] of vector;
    r				: array[1 .. maxn] of double;
	n				: integer;

function len(p, q : double) : double;
begin
	if p < q then len := 0 else len := sqrt(p * p - q * q); 
end;

function minus(p, q : vector) : vector;
var
	t				: vector;
begin
	t.x := p.x - q.x; t.y := p.y - q.y; t.z := p.z - q.z;
    minus := t;
end;

function modulus(h : vector) : double;
begin
	modulus := sqrt(h.x * h.x + h.y * h.y + h.z * h.z);
end;

function getAngle(x, y : double) : double;
begin
	if abs(x) < eps
    	then getAngle := pi / 2 + ord(y < 0) * pi
        else getAngle := arctan(y / x) + ord(x < 0) * pi; 
end;

procedure rotate(var x, y : double; A : double);
var
	p, q		: double;
begin
	p := x; q := y;
    x := p * cos(A) - q * sin(A);
    y := p * sin(A) + q * cos(A);
end;

function compute(r1, r2, h : double) : double;
var
	t	: double;
begin
	if abs(h) < eps then begin compute := 0; exit; end;
	t := (r1 * r1 - r2 * r2) / h;
    compute := (t + h) / 2;
end;

function inBalls(h : vector) : boolean;
var
    i	: integer;
begin
    inBalls := false;
    for i := 1 to n do if modulus(minus(ball[i], h)) > r[i] + eps then exit;
    inBalls := true;
end;

function check(p, q : integer) : boolean;
var
	A1, A2, d, nR, tR, temp	: double;
    i						: integer;
    h, sol 					: vector;
    dx, dy					: double;

begin
	ball := _ball;
	check := false;
	h := minus(ball[q], ball[p]);
    if modulus(h) > r[p] + r[q] + eps then exit;
    if modulus(h) < abs(r[p] - r[q]) - eps then exit;
    if modulus(h) < eps then exit;
//    if n = 2 then begin check := true; exit; end;

	A1 := getAngle(h.x, h.y); rotate(h.x, h.y, -A1 + pi / 2);
    A2 := getAngle(h.y, h.z); rotate(h.y, h.z, -A2 + pi / 2);

    for i := 1 to n do begin
    	rotate(ball[i].x, ball[i].y, -A1 + pi / 2);
    	rotate(ball[i].y, ball[i].z, -A2 + pi / 2);
    end;

    dx := ball[p].x; dy := ball[p].y;
    for i := 1 to n do begin
    	ball[i].x := ball[i].x - dx;
    	ball[i].y := ball[i].y - dy;
    end;
    
    temp := ball[p].z + compute(r[p], r[q], modulus(h));
    for i := 1 to n do ball[i].z := ball[i].z - temp;

    nR := len(r[p], ball[p].z);
    for i := 1 to n do begin
    	if abs(ball[i].z) > r[i] + eps then exit;
    	tR := len(r[i], ball[i].z);

        d := sqrt(sqr(ball[i].x) + sqr(ball[i].y));
        if d > tR + nR + eps then exit;
        if d < abs(tR - nR) - eps then continue;

        temp := compute(nR, tR, d);
		A1 := getAngle(ball[i].x, ball[i].y);
		A2 := getAngle(temp, len(nR, temp));

        sol.x := cos(A1 + A2) * nR;		
        sol.y := sin(A1 + A2) * nR;
        sol.z := 0;

        if inBalls(sol) then begin check := true; exit end; 

        sol.x := cos(A1 - A2) * nR;		
        sol.y := sin(A1 - A2) * nR;
        sol.z := 0;

        if inBalls(sol) then begin check := true; exit end; 
    end;

    sol.x := 0; sol.y := 0; sol.z := 0;
    if inBalls(sol) then check := true;
end;

var
	i, j		: integer;
    answer		: boolean;

begin
	assign(input, inf); assign(output, ouf);
    reset(input); rewrite(output);

	readln(n);
    for i := 1 to n do readln(ball[i].x, ball[i].y, ball[i].z, r[i]);

    answer := false;
    for i := 1 to n do if inBalls(ball[i]) then answer := true;

	_ball := ball;
    for i := 1 to n do
    	for j := i + 1 to n do
        	if check(i, j) then answer := true;

    if answer then writeln('YES') else writeln('NO');
    
    close(input); close(output);
end.
