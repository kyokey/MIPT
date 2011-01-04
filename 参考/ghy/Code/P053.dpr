{$APPTYPE CONSOLE}
const
	maxn = 1000;
    maxm = 1000;

type
	integer = longint;

var
	x, h, g		: array[1 .. maxn] of integer;
    names		: array[1 .. maxn] of string;
    tail, used	: array[1 .. maxn] of boolean;
    answer		: integer;
    n, m		: integer;
    tow, next	: array[1 .. maxm] of integer;

procedure DFS(dep, u : integer);

	procedure add(tmp, d : integer);
    begin
    	while tmp <> 0 do begin
        	inc(x[tow[tmp]], d);
            tmp := next[tmp];
        end;
    end;

var
	v, tmp	: integer;
begin
	if tail[u] then begin
    	if dep + 1 > answer then answer := dep + 1;
        exit;
    end;
    
	add(g[u], 1); add(h[u], 1);

	tmp := g[u]; used[u] := true;
    while tmp <> 0 do begin
    	v := tow[tmp];
        if not used[v] and (x[v] = 1 + ord(tail[v])) then DFS(dep + 1, v);
        tmp := next[tmp];  
    end;

	used[u] := false;    
	add(g[u], -1); add(h[u], -1);
end;

function readStr : integer;
var
	ch	: char;
    st	: string;
    i	: integer;
begin
	repeat read(ch); until (ch >= 'a') and (ch <= 'z') or (ch >= 'A') and (ch <= 'Z');
    st := '';
    while (ch >= 'a') and (ch <= 'z') or (ch >= 'A') and (ch <= 'Z') do begin
    	st := st + ch;
        read(ch);
    end;
    for i := 1 to n do if names[i] = st then begin
    	readStr := i;
        exit;
    end;
    n := n + 1; names[n] := st; readStr := n;
end;

var
	i, u, v, tmp	: integer;

begin
	fillchar(g, sizeof(g), 0);
	fillchar(h, sizeof(h), 0);
    fillchar(used, sizeof(used), 0);

	readln(m); n := 0;
    for i := 1 to m do begin
    	u := readStr; v := readStr;  
        if u = v then used[u] := true;
        tow[i] := v; next[i] := g[u]; g[u] := i;
        tow[i + m] := u; next[i + m] := h[v]; h[v] := i + m;
    end; 

    answer := 0;
    for i := 1 to n do if not used[i] then begin
        fillchar(tail, sizeof(tail), 0);
        fillchar(x, sizeof(x), 0);
        tmp := h[i];
        while tmp <> 0 do begin
        	tail[tow[tmp]] := true;
            tmp := next[tmp];
        end;
        DFS(0, i);
    end;

    if answer < 3 then answer := 0;
    writeln(answer);
end.
