const
	maxn = 200000;

type
	integer = longint;

var
	n, m, lower	: integer;
    f, g		: array[1 .. maxn] of integer;
    a, b, c		: array[1 .. maxn] of integer;

procedure swap(var i, j : integer);
var
	temp	: integer;
begin
	temp := i; i := j; j := temp;
end;

procedure sort(l, r : integer);
var
	i, j, mid	: integer;
begin
	i := l; j := r; mid := c[(l + r) shr 1];
    while i <= j do begin
    	while c[i] < mid do i := i + 1;
        while c[j] > mid do j := j - 1;
        if i <= j then begin
        	swap(c[i], c[j]);
            i := i + 1; j := j - 1;
        end;
    end;
    if i < r then sort(i, r);
    if l < j then sort(l, j);
end;

procedure sort_R(l, r : integer);
var
	i, j, mid	: integer;
begin
	i := l; j := r; mid := b[(l + r) shr 1];
    while i <= j do begin
    	while b[i] < mid do i := i + 1;
        while b[j] > mid do j := j - 1;
        if i <= j then begin
        	swap(a[i], a[j]); swap(b[i], b[j]);
            i := i + 1; j := j - 1;
        end;
    end;
    if i < r then sort_R(i, r);
    if l < j then sort_R(l, j);
end;

function bi_find(k : integer) : integer;
var
	l, r, mid	: integer;
begin
	l := 1; r := m;
    while l < r do begin
    	mid := (l + r + 1) shr 1;
        if c[mid] <= k then l := mid else r := mid - 1;
    end;
	bi_find := l;
end;

function max(i, j : integer) : integer;
begin
	if i > j then max := i else max := j;
end;

var
	i	: integer;

begin
	readln(n);
    for i := 1 to n do readln(a[i], b[i]);
    for i := 1 to n do begin c[i] := a[i]; c[i + n] := b[i]; end;
    
    sort(1, 2 * n); m := 1;
    for i := 2 to 2 * n do if c[i] > c[m] then begin
    	m := m + 1;
        c[m] := c[i];
    end;

	for i := 1 to n do a[i] := bi_find(a[i]);
	for i := 1 to n do b[i] := bi_find(b[i]);

    sort_R(1, n);
    fillchar(f, sizeof(f), 0);
    lower := 1;
    for i := 1 to n do begin
		while lower < b[i] do begin
        	inc(lower);
            f[lower] := f[lower - 1];
        end;
        f[b[i]] := max(f[b[i]], f[a[i]] + 1);
    end;
    for i := lower + 1 to m do f[i] := f[i - 1];

    fillchar(g, sizeof(g), 0);
    for i := 1 to m do if f[i] = 0 then g[i] := 1;

    lower := 1;
    for i := 1 to n do begin
		while lower < b[i] do begin
        	inc(lower);
            if f[lower - 1] = f[lower] then g[lower] := g[lower - 1];
        end;
        if f[b[i]] = f[a[i]] + 1 then inc(g[b[i]], g[a[i]]);
    end;

    writeln(g[lower]);
end.
