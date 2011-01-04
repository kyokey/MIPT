program P095;

const
	inf		= 'P095.in';
    ouf		= 'P095.out';
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
    solPre, solSuf			: array[1 .. maxm] of integer;
    used					: array[1 .. maxm] of boolean;
    ind, oud,
    pre, suf				: array[1 .. maxn] of integer;

    n, m, root				: integer;
    answer					: boolean;

function compare(p, q : integer) : integer; overload;
begin
	if head[p] < head[q] then result := -1 else
	if head[p] > head[q] then result := 1 else
	if tail[p] < tail[q] then result := -1 else
	if tail[p] > tail[q] then result := 1 else result := 0;
end;

function compare(p, u, v : integer) : integer; overload;
begin
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
            head[m] := head[p]; solPre[m] := p; dec(oud[head[m]]);
            tail[m] := tail[q]; solSuf[m] := q; dec(ind[tail[m]]);
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
    mid, temp	: TName;
begin
	i := l; j := r; mid := names[(l + r) shr 1];
    while i <= j do begin
    	while names[i] < mid do i := i + 1;
        while names[j] > mid do j := j - 1;
        if i <= j then begin
        	temp := names[i]; names[i] := names[j]; names[j] := temp;
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
    	if (ind[u] = 1) and (oud[u] = 1) and not used[u] then begin
        	inc(top); stack[top] := u;
            used[u] := true;
        end;
    end;

var
	u, p, q, i	: integer;
    oldM		: integer;

begin
    answer := false;

	fillchar(ind, sizeof(ind), 0); fillchar(Lson, sizeof(Lson), 0);
    fillchar(oud, sizeof(oud), 0); fillchar(Rson, sizeof(Rson), 0);
    fillchar(solPre, sizeof(solPre), 0);
    fillchar(solSuf, sizeof(solSuf), 0);
    fillchar(used, sizeof(used), 0);

    root := 0; oldM := m;
    for i := 1 to oldM do begin
    	head[i] := findIdx(head_[i]); inc(oud[head[i]]);
        tail[i] := findIdx(tail_[i]); inc(ind[tail[i]]);

        pre[tail[i]] := head[i]; suf[head[i]] := tail[i];
        add(root, i);
    end;

    top := 0;
    for i := 1 to n do push(i);

    while top > 0 do begin
    	u := stack[top]; top := top - 1;
        if (pre[u] = u) or (suf[u] = u) or (pre[u] = suf[u]) then exit;

		p := del(root, pre[u], u);
        q := del(root, u, suf[u]); 

		m := m + 1; head[m] := pre[u]; tail[m] := suf[u];
        solPre[m] := p; suf[pre[u]] := suf[u];
        solSuf[m] := q; pre[suf[u]] := pre[u];
        add(root, m);
        push(pre[u]); push(suf[u]);          
    end;

    if (root = 0) or (Lson[root] > 0) or (Rson[root] > 0) or (head[root] = tail[root]) then exit;
    answer := true;
end;

procedure DFS(u : integer);
begin
	if solPre[u] = 0 then write(names[head[u]], '-', names[tail[u]]) else
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
