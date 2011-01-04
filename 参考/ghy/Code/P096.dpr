program P096;

const
	inf		= 'P096.in';
    ouf		= 'P096.out';
    maxn	= 71000;
    maxm	= 71000;
	Letters	= ['A' .. 'Z'] + ['a' .. 'z'] + ['0' .. '9'];

type
	integer	= longint;
    TName	= string[11];

var
	head_, tail_, names		: array[1 .. maxm] of TName;
	stack, 
    head, tail,
	Lson, Rson,
    tow, next,
    solPre, solSuf			: array[1 .. maxm] of integer;
    used, expanded			: array[1 .. maxm] of boolean;
    g, degree  				: array[1 .. maxn] of integer;

    n, m, nE, root			: integer;
    answer					: boolean;

procedure link(u, v : integer);
begin
	inc(nE); tow[nE] := v; next[nE] := g[u]; g[u] := nE;
end;

procedure swap(var i, j : TName); overload;
var
	temp	: TName;
begin
	temp := i; i := j; j := temp;
end;

procedure swap(var i, j : integer); overload;
var
	temp	: integer;
begin
	temp := i; i := j; j := temp;
end;

function compare(p, q : integer) : integer; overload;
begin
	if head[p] < head[q] then result := -1 else
	if head[p] > head[q] then result := 1 else
	if tail[p] < tail[q] then result := -1 else
	if tail[p] > tail[q] then result := 1 else result := 0;
end;

function compare(p, u, v : integer) : integer; overload;
begin
	if u > v then swap(u, v);
	if head[p] < u then result := -1 else
	if head[p] > u then result := 1 else
	if tail[p] < v then result := -1 else
	if tail[p] > v then result := 1 else result := 0;
end;

procedure add(var p : integer; q : integer);
begin
	if p = 0 then begin p := q; exit; end;
    
	case compare(p, q) of
    0 :
    	begin
			m := m + 1;
            head[m] := head[p]; solPre[m] := p; dec(degree[head[m]]);
            tail[m] := tail[q]; solSuf[m] := q; dec(degree[tail[m]]);
            Lson[m] := Lson[p]; Rson[m] := Rson[p];
            p := m;
        end;

    -1 :
    	begin
        	add(Rson[p], q);
        end;

    1 :
    	begin
        	add(Lson[p], q);
        end;
    end;
end;

function merge(p, q : integer) : integer;
begin
	if p = 0 then result := q else
    if q = 0 then result := p else 
	if random(2) = 0 then begin
    	result := p;
        Rson[p] := merge(Rson[p], q);
    end else begin
    	result := q;
        Lson[q] := merge(p, Lson[q]);
    end;
end;

function del(var p : integer; u, v : integer) : integer;
begin
	result := -1;
	case compare(p, u, v) of
    0 :
    	begin
            result := p;
        	p := merge(Lson[p], Rson[p]);
        end;

	1 : result := del(Lson[p], u, v);
    -1 : result := del(Rson[p], u, v);
    end;    	
end;

procedure readStr(var st : TName);
var
	ch		: char; 
begin
	repeat read(ch); until ch in Letters;
	st := '';
    repeat
    	st := st + ch;
        read(ch);
    until not (ch in Letters); 
end;

procedure sortNames(l, r : integer);
var
	i, j		: integer;
    mid			: TName;
begin
	i := l; j := r; mid := names[(l + r) shr 1];
    while i <= j do begin
    	while names[i] < mid do i := i + 1;
        while names[j] > mid do j := j - 1;
        if i <= j then begin
        	swap(names[i], names[j]);
            i := i + 1; j := j - 1;
        end;
    end;
    if i < r then sortNames(i, r);
    if l < j then sortNames(l, j);
end;

function findIdx(var st : TName) : integer;
var
	l, r, mid	: integer;
begin
	l := 1; r := n;
    repeat
    	mid := (l + r) shr 1;
        if names[mid] = st then begin result := mid; exit; end;
        if names[mid] < st then l := mid + 1 else r := mid - 1;
    until false;
end;

procedure init;
var
	i, k		: integer;
begin
	m := 0;
    while not seekeof do begin
    	m := m + 1;
    	readStr(head_[m]); readStr(tail_[m]);
        if head_[m] > tail_[m] then swap(head_[m], tail_[m]);
    end;

    n := 2 * m;
    for i := 1 to m do begin
    	names[i] := head_[i];
		names[i + m] := tail_[i];
    end;

    sortNames(1, n); k := 1;
    for i := 2 to n do if names[i] > names[k] then begin
    	k := k + 1;
        names[k] := names[i];
    end; n := k;
end;

procedure main;
var
    top			: integer;

	procedure push(u : integer);
    begin
    	if (degree[u] = 2) and not used[u] then begin
        	inc(top); stack[top] := u;
            used[u] := true;
        end;
    end;

var
	u, p, q, i	: integer;
    oldM		: integer;
    x, y, tmp	: integer;

begin
    answer := false;

	fillchar(Lson, sizeof(Lson), 0); fillchar(solPre, sizeof(solPre), 0);
    fillchar(Rson, sizeof(Rson), 0); fillchar(solSuf, sizeof(solSuf), 0);
    fillchar(used, sizeof(used), 0); fillchar(degree, sizeof(degree), 0);
    fillchar(next, sizeof(next), 0);
    fillchar(expanded, sizeof(expanded), 0);

    root := 0; oldM := m; nE := 0;
    for i := 1 to oldM do begin
    	head[i] := findIdx(head_[i]); inc(degree[head[i]]);
        tail[i] := findIdx(tail_[i]); inc(degree[tail[i]]);

        add(root, i);

        link(head[i], tail[i]); link(tail[i], head[i]);
    end;

    top := 0;
    for i := 1 to n do push(i);

    while top > 0 do begin
    	u := stack[top]; top := top - 1;
        if degree[u] < 2 then continue;
        expanded[u] := true;

        x := 0; y := 0; tmp := g[u];
        while tmp <> 0 do begin
        	if not expanded[tow[tmp]] then
            	if x = 0 then x := tow[tmp] else
                if x <> tow[tmp] then y := tow[tmp];
            tmp := next[tmp];
        end;

        if (y = 0) or (x = u) or (y = u) or (x = y) then exit;

        p := del(root, u, x);
        q := del(root, u, y);

		m := m + 1; head[m] := x; tail[m] := y;
        if head[m] > tail[m] then swap(head[m], tail[m]);
        
        solPre[m] := p; link(x, y); link(y, x);
        solSuf[m] := q;
        add(root, m);
        push(x); push(y);
    end;

    if (root = 0) or (Lson[root] > 0) or (Rson[root] > 0) or (head[root] = tail[root]) then exit;
    answer := true;
end;

procedure DFS(u : integer);
begin
	if solPre[u] = 0 then write(names[head[u]], '-', names[tail[u]]) else begin
    
    	if (head[solPre[u]] <> head[u]) and (tail[solPre[u]] <> head[u]) then swap(solPre[u], solSuf[u]);
		if head[solPre[u]] <> head[u] then swap(head[solPre[u]], tail[solPre[u]]);
		if tail[solSuf[u]] <> tail[u] then swap(head[solSuf[u]], tail[solSuf[u]]);
        
    	if compare(solPre[u], solSuf[u]) = 0 then begin
        	write('[');
            DFS(solPre[u]);
            write(' ');
            DFS(solSuf[u]);
            write(']');
        end else begin
        	write('(');
            DFS(solPre[u]);
            write(' ');
            DFS(solSuf[u]);
            write(')');
        end;
    end;
end;

procedure print;
begin
	writeln('YES');
    DFS(root); writeln;
end;

begin
	assign(input, inf); assign(output, ouf);
    reset(input); rewrite(output);
    init;
    main;
    if answer then print else writeln('NO');
    close(input); close(output);
end.
