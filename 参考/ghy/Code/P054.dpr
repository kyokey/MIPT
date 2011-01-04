program P054;

const
	inf = 'P054.in';
    ouf = 'P054.out';
    maxn = 500;
    maxm = maxn * maxn;
    eps = 1e-6;

type
	integer	= longint;

    TPoint	= record
    	x, y	: double;
    end;

    TLine	= record
    	head, tail	: TPoint;
    end;

    TPSet = array[1 .. maxm] of TPoint;

var
	s, t 	: TPoint;
    n 		: integer;
    value	: array[1 .. maxm * 2] of integer;
    pnt		: TPSet;
    alpha	: double;

procedure swap(var i, j : TPoint);
var
	temp	: TPoint;
begin
	temp := i; i := j; j := temp;
end;

function dis(p, q : TPoint) : double;
begin
	dis := sqrt(sqr(p.x - q.x) + sqr(p.y - q.y));
end;

procedure rotate(var x, y, alpha : double);
var
	p, q	: double;
begin
	p := x; q := y;
    x := p * cos(alpha) - q * sin(alpha);
    y := p * sin(alpha) + q * cos(alpha);
end;

procedure init;
var
	i	: integer;
begin
	alpha := random * 2 * pi;
	readln(s.x, s.y); readln(t.x, t.y);
    readln(n);
    for i := 1 to n do readln(pnt[i].x, pnt[i].y);
end;

function uppon(p, q, s : TPoint) : boolean;
var
	w	: double;
begin
	rotate(p.x, p.y, alpha);
	rotate(q.x, q.y, alpha);
	rotate(s.x, s.y, alpha);
    
	uppon := false;
	if p.x > q.x then swap(p, q);
    if (s.x < p.x) or (s.x > q.x) then exit;
    w := (q.y - p.y) * (s.x - p.x) / (q.x - p.x) + p.y;
    uppon := w < s.y;
end;

function connect(R : double) : boolean;

    function DFS(u, kind : integer) : boolean;
    var
        v, k	: integer;
    begin
        if value[u] >= 0 then begin
            DFS := value[u] <> kind;
            exit;
        end;
        value[u] := kind; DFS := true;
        for v := 1 to n do if (u <> v) and (dis(pnt[u], pnt[v]) < 2 * R) then begin
            if uppon(pnt[u], pnt[v], s) xor uppon(pnt[u], pnt[v], t) then k := 1 - kind else k := kind;
            if DFS(v, k) then exit;
        end;
        DFS := false;
    end;

var
	i	: integer;
    
begin
	connect := false;
    for i := 1 to n do if dis(s, pnt[i]) < R + eps then exit;
    for i := 1 to n do if dis(t, pnt[i]) < R + eps then exit;

	fillchar(value, sizeof(value), $ff);
    for i := 1 to n do if (value[i] < 0) and DFS(i, 0) then exit;
    connect := true;
end;

procedure main;
var
    mid, lower, upper	: integer;
begin
	lower := 0; upper := 1000000000;
    while lower < upper do begin
    	mid := (lower + upper + 1) shr 1;
        if connect(mid / 10000) then lower := mid else upper := mid - 1;
    end;
    writeln(lower / 10000 : 0 : 2);
end;

begin
	assign(input, inf); assign(output, ouf);
    reset(input); rewrite(output);
    init;
    main;
    close(input); close(output);
end.