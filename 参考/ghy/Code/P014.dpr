{$APPTYPE CONSOLE}
const
	maxn = 100;
	maxt = 10000;

type
	integer = longint;

var
	son	: array[1 .. maxt, 'a' .. 'z'] of integer;
    value, preNode, queue	: array[1 .. maxt] of integer;
    g, f	: array[1 .. maxt, 0 .. maxn] of integer;
    h		: array[1 .. maxt, 0 .. maxn] of char;
    alpha	: array[1 .. 26] of char;
    n, m, t, root	: integer;

function find(u : integer; ch: char) : integer;
begin
	while (u > 1) and (son[u][ch] = 0) do u := preNode[u];
    if son[u][ch] > 0 then find := son[u][ch] else find := u;
end;

procedure process(var p : integer);
var
	ch	: char;
    s	: integer;
begin
	read(ch);
    if p = 0 then begin
    	t := t + 1; p := t;
    	fillchar(son[p], sizeof(son[p]), 0);
        value[p] := 0;
    end;

    if ch = ' ' then begin
		readln(s);
        inc(value[p], s);
    end else process(son[p][ch]);
end;

procedure init;
var
	i, k	: integer;
begin
	readln(n, m, k);
    for i := 1 to m do read(alpha[i]); readln;
    root := 0; t := 0;
    for i := 1 to k do process(root);
end;

procedure buildPrefix;
var
	op, cl, u, v	: integer;
    ch				: char;
begin
	op := 0; cl := 1; queue[1] := 1; preNode[1] := 1;
    while op < cl do begin
    	op := op + 1; u := queue[op];
        for ch := 'a' to 'z' do if son[u][ch] > 0 then begin
        	v := son[u][ch];
            if u = 1 then preNode[v] := 1 else preNode[v] := find(preNode[u], ch);
            
            inc(value[v], value[preNode[v]]);
            inc(cl); queue[cl] := v;
        end;
    end;
end;

procedure getAnswer;
var
	i, u, v, p	: integer;
    st			: string;
begin
	fillchar(f, sizeof(f), $ff);
	f[1][0] := 0; 
    for p := 0 to n do begin
    	for i := 1 to t do if f[i][p] >= 0 then inc(f[i][p], value[i]);
        if p = n then break;
        
    	for u := 1 to t do if f[u][p] >= 0 then
        	for i := 1 to m do begin
            	v := find(u, alpha[i]);
                if f[u][p] >= f[v][p + 1] then begin
                	f[v][p + 1] := f[u][p];
                    g[v][p + 1] := u;
                    h[v][p + 1] := alpha[i];
                end;
            end;
    end;
    p := 1;
    for i := 1 to t do if f[i][n] > f[p][n] then p := i;
    writeln(f[p][n]);
    st := '';
    i := p; p := n;
    while p > 0 do begin
    	st := h[i][p] + st;
        i := g[i][p]; p := p - 1;
    end;
    writeln(st);
end;

begin
	init;
    buildPrefix;
    getAnswer;
end.
