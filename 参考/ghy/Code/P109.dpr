const
	inf		= 1e10;
	eps		= 1e-7;

type
	vector	= record
    	x, y		: extended;
    end;

    plainType	= record
    	head, tail	: vector;
    end;

var
	n		: integer;
    plain	: array[1 .. 111] of plainType;
    O		: vector;

function area(i, j, k : vector) : extended;
begin
	result := (j.x - i.x) * (k.y - i.y) - (k.x - i.x) * (j.y - i.y);
end;

function gdn(k : extended) : integer;
begin
	if abs(k) < eps then result := 0 else
    if k < 0 then result := -1 else result := 1;
end;

function isZero(k : extended) : boolean;
begin
	result := abs(k) < eps;
end;

function minus(p, q : vector) : vector;
begin
	result.x := p.x - q.x;
	result.y := p.y - q.y;
end;

function intersec(a, b : plainType; var h : vector) : boolean;
var
	p, q        : vector;
    k1, k2, k3, k4	: extended;
begin
	p := minus(a.tail, a.head);
    q := minus(b.tail, b.head);

	k1 := area(a.head, a.tail, b.head);
	k2 := area(a.head, a.tail, b.tail);
	k3 := area(b.head, b.tail, a.head);
	k4 := area(b.head, b.tail, a.tail);

	if isZero(p.x * q.y - p.y * q.x) then result := false else begin
    	result := true;
        if not isZero(k4 - k3)

        	then with a do begin
        		h.x := (head.x * k4 - tail.x * k3) / (k4 - k3);
        		h.y := (head.y * k4 - tail.y * k3) / (k4 - k3);
        	end

            else with b do begin
        		h.x := (head.x * k2 - tail.x * k1) / (k2 - k1);
        		h.y := (head.y * k2 - tail.y * k1) / (k2 - k1);
            end;
    end;
end;

function noSolution(a, b : plainType) : boolean; overload;
var
	p, q	: vector;
begin
	p := minus(a.tail, a.head);
    q := minus(b.tail, b.head);
    result := isZero(p.x * q.y - p.y * q.x) and
    		((p.x * q.x < - eps) or (p.y * q.y < - eps)) and
    		(gdn(area(a.head, a.tail, b.head)) >= 0) and
    		(gdn(area(b.head, b.tail, a.head)) >= 0);
end;

function noSolution(a, b, c : plainType) : boolean; overload;

	function compare(p, q : vector) : boolean;
    begin
    	result := isZero(p.x - q.x) and isZero(p.y - q.y);
    end;

var
	p, q, h	: vector;
    f, g, t	: vector;
begin
	result := false;
    p := minus(a.tail, a.head);
    q := minus(b.tail, b.head);
    h := minus(c.tail, c.head);
    if isZero(p.x * q.y - p.y * q.x) or isZero(p.x * h.y - p.y * h.x)
    	or isZero(h.x * q.y - h.y * q.x) then exit;

	if intersec(a, b, f) and (gdn(area(c.head, c.tail, f)) < 0) then exit;
	if intersec(b, c, g) and (gdn(area(a.head, a.tail, g)) < 0) then exit;
	if intersec(c, a, t) and (gdn(area(b.head, b.tail, t)) < 0) then exit;

    if (compare(f, g)) and (compare(g, t)) and
       ((area(O, p, q) * area(O, p, h) > 0)
       or (area(O, q, p) * area(O, q, h) > 0)
       or (area(O, h, p) * area(O, h, q) > 0)) then exit; 

    result := true;
end;

function available(p : vector) : boolean;
var
	i		: integer;
begin
	result := false;
	for i := 1 to n do if gdn(area(plain[i].head, plain[i].tail, p)) > 0 then exit;
    result := true;  
end;

var
	i, j, k, m	: integer;
    p, q		: vector;

begin
	assign(input, 'P109.in'); reset(input);
    assign(output, 'P109.out'); rewrite(output);
	readln(n); O.x := 0; O.y := 0;
    for i := 1 to n do with plain[i] do
    	readln(head.x, head.y, tail.x, tail.y);

    with plain[n + 1] do begin head.x := -inf; head.y := -inf; end;
    with plain[n + 2] do begin head.x := -inf; head.y := +inf; end;
    with plain[n + 3] do begin head.x := +inf; head.y := +inf; end;
    with plain[n + 4] do begin head.x := +inf; head.y := -inf; end;

    plain[n + 1].tail := plain[n + 2].head; plain[n + 2].tail := plain[n + 3].head;
    plain[n + 3].tail := plain[n + 4].head; plain[n + 4].tail := plain[n + 1].head;
    n := n + 4;

    for i := 1 to n do
    	for j := i + 1 to n do
        	if noSolution(plain[i], plain[j]) then begin
            	writeln(2);
                writeln(i, ' ', j);
                halt;
            end;

    for i := 1 to n do
    	for j := i + 1 to n do
        	for k := j + 1 to n do
            	if noSolution(plain[i], plain[j], plain[k]) then begin
                	writeln(3);
                    writeln(i, ' ', j, ' ', k);
                    halt;
                end;

	writeln(-1);
    q.x := 0; q.y := 0; m := 0;
	for i := 1 to n do
    	for j := i + 1 to n do
        	if intersec(plain[i], plain[j], p) and available(p) then begin
            	inc(m);
            	q.x := q.x + p.x;
                q.y := q.y + p.y; 
            end;

    writeln(q.x / m : 0 : 8, ' ', q.y / m : 0 : 8);
    close(input); close(output);
end.
