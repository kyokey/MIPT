program P023;

const
	inf = 'P023.in';
    ouf = 'P023.out';
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
	s, t : TPoint;
    n, m, tot : integer;
    line : array[1 .. maxn] of TLine;
    lower, upper : array[1 .. maxn] of integer;
    value, g, tow, next : array[1 .. maxm * 2] of integer;
    pnt, pnt_ : TPSet;

procedure swap(var i, j : TPoint);
var
	temp : TPoint;
begin
	temp := i; i := j; j := temp;
end;

procedure rotate(var x, y, alpha : double);
var
	p, q	: double;
begin
	p := x; q := y;
    x := p * cos(alpha) - q * sin(alpha);
    y := p * sin(alpha) + q * cos(alpha);
end;

function compare(var a, b : TPoint) : boolean;
begin
	compare := (a.x < b.x - eps) or (a.x < b.x + eps) and (a.y < b.y - eps);
end;

function findIdx(p : TPoint) : integer;
var
	l, r, mid	: integer;
begin
	l := 1; r := m;
    while l < r do begin
    	mid := (l + r) shr 1;
    	if compare(pnt[mid], p) then l := mid + 1 else r := mid;
    end;
    findIdx := l;
end;

procedure addEdge(p, q : TPoint);
var
	u, v : integer;
begin
	u := findIdx(p); v := findIdx(q);
	tot := tot + 1;
    tow[tot] := v; next[tot] := g[u]; g[u] := tot;
end;

procedure sort(var A : TPSet; l, r : integer);
var
	i, j	: integer;
    mid		: TPoint;
begin
	i := l; j := r; mid := A[(l * 2 + r) div 3];
    while i <= j do begin
    	while compare(A[i], mid) do i := i + 1;
        while compare(mid, A[j]) do j := j - 1;
        if i <= j then begin
        	swap(A[i], A[j]);
            i := i + 1; j := j - 1;
        end;
    end;
    if i < r then sort(A, i, r);
    if l < j then sort(A, l, j);
end;

procedure init;
var
	i		: integer;
    alpha	: double;
begin
	alpha := random * 2 * pi;
	readln(s.x, s.y); readln(t.x, t.y);
    rotate(s.x, s.y, alpha);
    rotate(t.x, t.y, alpha);
    readln(n);
    for i := 1 to n do with line[i] do begin
    	readln(head.x, head.y, tail.x, tail.y);
        rotate(head.x, head.y, alpha);
        rotate(tail.x, tail.y, alpha);
    end;
end;

function area(var i, j, k : TPoint) : double;
begin
	area := (j.x - i.x) * (k.y - i.y) - (j.y - i.y) * (k.x - i.x);
end;

function gdn(k : double) : integer;
begin
	if abs(k) < eps then gdn := 0 else
    if k < 0 then gdn := -1 else gdn := 1;
end;

function getCommon(var a, b : TLine; var p : TPoint) : boolean;
var
	p1, p2, p3, p4	: double;
begin
	p1 := area(a.head, a.tail, b.head);
	p2 := area(a.head, a.tail, b.tail);
	p3 := area(b.head, b.tail, a.head);
	p4 := area(b.head, b.tail, a.tail);   

    if (gdn(p1) * gdn(p2) <= 0) and (gdn(p3) * gdn(p4) < 0) then begin
    	getCommon := true;
        with a do begin
        	p.x := (head.x * p4 - tail.x * p3) / (p4 - p3);
        	p.y := (head.y * p4 - tail.y * p3) / (p4 - p3);
        end;
    end else getCommon := false;
end;

procedure buildGraph;
var
	i, j, k	: integer;
    p		: TPoint;
begin
	m := 0;

    for i := 1 to n do begin
    	lower[i] := m + 1;
        m := m + 1; pnt[m] := line[i].head;
        m := m + 1; pnt[m] := line[i].tail;
    	for j := 1 to n do if i <> j then 
        	if getCommon(line[i], line[j], p) then begin
            	m := m + 1;
                pnt[m] := p;
            end;
        upper[i] := m;
    end;

    for i := 1 to m do pnt_[i] := pnt[i];

    sort(pnt, 1, m); j := 1;
    for i := 2 to m do if compare(pnt[j], pnt[i]) then begin
    	j := j + 1;
        pnt[j] := pnt[i];
    end; m := j;

    fillchar(g, sizeof(g), 0); tot := 0;
    for i := 1 to n do begin
    	sort(pnt_, lower[i], upper[i]);
        k := lower[i];
        for j := lower[i] + 1 to upper[i] do if compare(pnt_[k], pnt_[j]) then begin
			addEdge(pnt_[k], pnt_[j]);        	
			addEdge(pnt_[j], pnt_[k]);
            k := j;        	
        end;
    end;
end;

function uppon(p, q, s : TPoint) : boolean;
var
	w	: double;
begin
	uppon := false;
	if p.x > q.x then swap(p, q);
    if (s.x < p.x) or (s.x > q.x) then exit;
    w := (q.y - p.y) * (s.x - p.x) / (q.x - p.x) + p.y;
    uppon := w < s.y;
end;

function DFS(u, kind : integer) : boolean;
var
	v, k, tmp	: integer;
begin
	if value[u] >= 0 then begin
    	DFS := value[u] <> kind;
        exit;
    end;
    value[u] := kind; 
	DFS := true; tmp := g[u];
    while tmp <> 0 do begin
    	v := tow[tmp];
        if uppon(pnt[u], pnt[v], s) xor uppon(pnt[u], pnt[v], t) then k := 1 - kind else k := kind;
        if DFS(v, k) then exit;
        tmp := next[tmp];
    end;
    DFS := false;
end;

procedure main;
var
	i	: integer;
begin
	buildGraph;

    fillchar(value, sizeof(value), $ff);
    for i := 1 to m do if (value[i] < 0) and DFS(i, 0) then begin
    	writeln('NO');
        exit;
    end;
    writeln('YES');
end;

begin
	assign(input, inf); assign(output, ouf);
    reset(input); rewrite(output);
    init;
    main;
    close(input); close(output);
end.