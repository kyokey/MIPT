const
	maxn = 10000;
    maxm = 1000000;

type
	integer = longint;

var
	tow, next	: array[1 .. maxm] of integer;
    g, h		: array[1 .. maxn] of integer;
    visit		: array[1 .. maxn] of boolean;
    n, m, root	: integer;
    answer		: boolean;

procedure add(u, v : integer);
begin
	inc(m);
    tow[m] := v; next[m] := g[u]; g[u] := m;
end;

procedure init;
var
	u, v	: integer;
begin
	fillchar(g, sizeof(g), 0);
    m := 0; readln(n);
    repeat
    	readln(u, v);
        if (u = 0) and (v = 0) then break;
        if u <> v then begin
        	add(u, v);
        	add(v, u);
        end;
    until false;
end;

function DFS(u, f : integer) : boolean;
var
	s, v, tmp	: integer;
begin
	DFS := false;
	tmp := g[u]; visit[u] := true;
    h[u] := 0; s := 0;
    while tmp <> 0 do begin
    	v := tow[tmp];
        if v <> f then begin
        	if visit[v] or not DFS(v, u) then exit;
            if h[v] > h[u] then h[u] := h[v];
            if h[v] > 2 then inc(s);
        end;
        tmp := next[tmp];
    end;
    if s > 1 + ord(u = root) then exit;
    inc(h[u]);
    DFS := true;
end;

procedure main;
var
	i	: integer;
begin
	answer := false;
    fillchar(visit, sizeof(visit), 0);
    for i := 1 to n do if not visit[i] then begin
    	root := i; 
    	if not DFS(i, 0) then exit;
    end;
    answer := true;
end;

begin
	init;
    main;
    if answer then writeln('KILLED') else writeln('ESCAPED');
end.

