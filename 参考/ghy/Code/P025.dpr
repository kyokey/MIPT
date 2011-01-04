const
	eps = 1e-8;

type
	integer = longint;
    TPoint = record
    	x, y	: extended;
    end;

procedure rotate(var x, y : extended; alpha : extended);
var
	u, v	: extended;
begin
	u := x; v := y;
    x := u * cos(alpha) - v * sin(alpha);
	y := u * sin(alpha) + v * cos(alpha);     
end;

function minus(a, b : TPoint) : TPoint;
var
	c	: TPoint;
begin
	c.x := a.x - b.x; c.y := a.y - b.y;
    minus := c;
end;

var
	A, B, C, D	: TPoint;
    p, q, s1, s2, alpha	: extended;

begin
	readln(A.x, A.y, B.x, B.y);
    readln(C.x, C.y, D.x, D.y);
    A := minus(A, D); B := minus(B, D); C := minus(C, D);
    
    if abs(C.x) < eps then
    	if C.y > 0 then alpha := pi / 2
        	else alpha := pi * 3 / 2
    else alpha := arctan(C.y / C.x) + ord(C.x < 0) * pi;

    rotate(A.x, A.y, -alpha); rotate(B.x, B.y, -alpha);    
    if A.x > B.x then begin D := A; A := B; B := D; end;
	p := A.x + abs(A.y);
    q := B.x - abs(B.y);

    s1 := sqrt(sqr(A.x - B.x) + sqr(A.y - B.y)) / 5;
    if p <= q then begin
		s2 := sqrt(sqr(A.x - p) + A.y * A.y) / 5 + sqrt(sqr(B.x - q) + B.y * B.y) / 5;
        s2 := s2 + (q - p) / 5 / sqrt(2);
        if s2 < s1 then s1 := s2; 
    end;
    writeln(s1 : 0 : 5);
end.

