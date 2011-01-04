const
	inf = 'P035.in';
    ouf = 'P035.out';
	maxn = 50;
    maxm = 100;
    infinite = maxlongint shr 2;
    dirx : array[1 .. 8] of integer = (1, 1, -1, -1, 2, 2, -2, -2);
    diry : array[1 .. 8] of integer = (2, -2, 2, -2, 1, -1, -1, 1);

type
	integer = longint;
    disType	= array[1 .. maxn, 1 .. maxn] of integer;

var
	dis		: array[1 .. maxn, 1 .. maxn] of disType;
    x, y	: array[1 .. maxm] of integer;
    a, b	: array[1 .. maxn * maxn] of integer;
    value	: disType;
    n, m	: integer;
    s, t	: integer;

function max(i, j : integer) : integer;
begin
	if i > j then max := i else max := j;
end;

procedure min(var i : integer; j : integer);
begin
	if j < i then i := j;
end;

procedure BFS(var dis : disType; p, q : integer);
var
	i, j, u, v, op, cl	: integer;
begin
    for i := 1 to n do for j := 1 to n do dis[i][j] := infinite;
    
	op := 0; cl := 1; a[1] := p; b[1] := q;
    dis[p][q] := 0;
    
    while op < cl do begin
    	op := op + 1; p := a[op]; q := b[op];
        for i := 1 to 8 do begin
        	u := p + dirx[i]; v := q + diry[i];
            if (u > 0) and (v > 0) and (u <= n) and (v <= n) and (dis[u][v] = infinite) then begin
				dis[u][v] := dis[p][q] + 1;
                inc(cl); a[cl] := u; b[cl] := v;            	
            end;
        end;
    end;
end;

procedure sort(l, r : integer);
var
	i, j, mid, temp	: integer;
begin
	i := l; j := r; mid := (l * 2 + r) div 3;
    mid := value[a[mid]][b[mid]];
    while i <= j do begin
    	while value[a[i]][b[i]] < mid do i := i + 1;
        while value[a[j]][b[j]] > mid do j := j - 1;
        if i <= j then begin
        	temp := a[i]; a[i] := a[j]; a[j] := temp;
        	temp := b[i]; b[i] := b[j]; b[j] := temp;
            i := i + 1; j := j - 1;
        end;
    end;
    if i < r then sort(i, r);
    if l < j then sort(l, j);
end;

var
	i, j, p, u, v, k, nc, cost, answer	: integer;
    cnt : integer;

begin
	assign(input, inf); assign(output, ouf);
    reset(input); rewrite(output);

    readln(n, m); readln(s, t);
    answer := infinite;
    if m = 0 then answer := 0;

    for i := 1 to m do readln(x[i], y[i]);
    for i := 1 to n do for j := 1 to n do BFS(dis[i][j], i, j);

    fillchar(value, sizeof(value), 0);
    for u := 1 to n do for v := 1 to n do for k := 1 to m do
    	inc(value[u][v], dis[x[k]][y[k]][u][v]);

    for i := 1 to n do for j := 1 to n do begin
    	a[(i - 1) * n + j] := i;
        b[(i - 1) * n + j] := j;
    end;

    sort(1, n * n);
    
    cnt := 0;
    for p := 1 to n * n do begin
    	u := a[p]; v := b[p];
        if value[u][v] > answer + 2 * n then continue;
        for i := 1 to n do
        	for j := 1 to n do if abs(abs(i - s) - abs(j - t)) <= 2 then begin
            	nc := infinite;
                for k := 1 to m do min(nc, dis[x[k]][y[k]][i][j] - dis[x[k]][y[k]][u][v]);
                cost := value[u][v] + nc + dis[i][j][u][v] + max(abs(i - s), abs(j - t));
                min(answer, cost);
            end;
    end;

    writeln(answer);
end.
