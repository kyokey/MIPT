program P034;

const
	inf = 'P034.in';
    ouf = 'P034.out';
    maxn = 1001000;
    eps = 1e-7;
    infinite = 1e10;

type
	integer = longint;

var
	x, y, f, g, s, rainfall	: array[0 .. maxn] of extended;
    l, r, Lson, Rson		: array[0 .. maxn] of integer;
    n						: integer;
    H						: extended;

function min(i, j : extended) : extended;
begin
	if i < j then min := i else min := j;
end;

function max(i, j : extended) : extended;
begin
	if i > j then max := i else max := j;
end;

procedure inc(var i : extended; j : extended);
begin
	i := i + j;
end;

procedure init;
var
	i	: integer;
begin
	readln(n, H); n := n + 2;
    for i := 1 to n - 1 do readln(x[i], y[i]);
    x[0] := x[1]; y[0] := infinite;
    x[n] := x[n - 1]; y[n] := infinite;
end;

procedure prepare;
var
	i	: integer;
begin
    for i := 1 to n - 1 do begin
    	l[i] := i - 1; Lson[i] := 0; f[i] := y[i];
        while y[l[i]] < y[i] + eps do begin
        	Lson[i] := l[i];
            f[i] := min(f[i], f[l[i]]);
            l[i] := l[l[i]];
        end;
    end;

    for i := n - 1 downto 1 do begin
    	r[i] := i + 1; Rson[i] := 0; g[i] := y[i];
        while y[r[i]] < y[i] + eps do begin
        	Rson[i] := r[i];
            g[i] := min(g[i], g[r[i]]);
            r[i] := r[r[i]];
        end;
    end;

    s[1] := 0;
    for i := 2 to n - 1 do s[i] := s[i - 1] + x[i] * y[i - 1] - x[i - 1] * y[i];
end;

function exist(k : integer; var dep : extended) : boolean;
var
	p, q	: integer;
    a, b	: extended;
    tgL, tgR, area	: extended;
begin
	p := l[k] + 1; q := r[k] - 1;
    area := y[k] * (x[q] - x[p]) - (x[q] * y[q] - x[p] * y[p] + s[q] - s[p]) / 2;
    tgL := (x[p] - x[l[k]]) / (y[l[k]] - y[p]);
    tgR := (x[r[k]] - x[q]) / (y[r[k]] - y[q]);
    inc(area, (tgL * sqr(y[k] - y[p]) + tgR * sqr(y[k] - y[q])) / 2);
	exist := area < rainfall[k] - eps;

    if area < rainfall[k] - eps then begin
    	a := (tgL + tgR) / 2;
        b := x[q] - x[p] + tgL * (y[k] - y[p]) + tgR * (y[k] - y[q]);
        area := rainfall[k] - area;
        if abs(a) < eps then dep := area / b
        	else dep := (- b + sqrt(b * b + 4 * a * area)) / a / 2;
        dep := min(dep, min(y[l[k]], y[r[k]]) - y[k]);
        dep := dep + y[k] - min(f[k], g[k]);
    end; 
end;

procedure analyse(k : integer; LX, RX : extended; var rest : extended; more : extended);
var
	p, q	: integer;
    tgL, tgR, area, lower	: extended;
begin
	if k = 0 then begin rest := (RX - LX) * H + more; exit; end;

	p := l[k] + 1; q := r[k] - 1; lower := min(y[l[k]], y[r[k]]);
    area := lower * (x[q] - x[p]) - (x[q] * y[q] - x[p] * y[p] + s[q] - s[p]) / 2;
    tgL := (x[p] - x[l[k]]) / (y[l[k]] - y[p]);
    tgR := (x[r[k]] - x[q]) / (y[r[k]] - y[q]);
    inc(area, (tgL * sqr(lower - y[p]) + tgR * sqr(lower - y[q])) / 2);
    rest := rainfall[k] - area;
    if rest < 0 then rest := 0;
end;

function DFS(k : integer; L_Flow, R_Flow : extended) : extended;
var

	dep, Lrest, Rrest	: extended;
begin
	DFS := 0;
	if k = 0 then exit;
    inc(rainfall[k], L_Flow + R_Flow);
	if exist(k, dep) then begin DFS := dep; exit; end;

    inc(rainfall[Lson[k]], L_Flow);
    inc(rainfall[Rson[k]], R_Flow);
	analyse(Lson[k], x[l[k]], x[k], Lrest, L_Flow);
	analyse(Rson[k], x[k], x[r[k]], Rrest, R_Flow);
    inc(rainfall[Lson[k]], - L_Flow);
    inc(rainfall[Rson[k]], - R_Flow);

    DFS := max(DFS(Lson[k], L_Flow, Rrest - Lrest), DFS(Rson[k], Lrest - Rrest, R_Flow));
end;

procedure main;
var
	i, root	: integer;
begin
	prepare;

    for i := 1 to n - 1 do rainfall[i] := H * (x[r[i]] - x[l[i]]);
	root := 1;
    for i := 2 to n - 1 do if y[i] > y[root] then root := i;

    writeln(DFS(root, 0, 0) : 0 : 4);
end;

begin
	assign(input, inf); assign(output, ouf);
    reset(input); rewrite(output);
    init;
    main;
    close(input); close(output);
end.
