type
	integer = longint;

var
	n, m, i, k, u, v		: integer;
    g, tx, ty				: array[0 .. 1000] of integer;
    tow, next				: array[0 .. 100000] of integer;
    ny						: array[0 .. 1000] of boolean;

function DFS(u : integer) : boolean;
var
	v, tmp	: integer;
begin
	tmp := g[u]; DFS := true;
    while tmp <> 0 do begin
    	v := tow[tmp];
        if not ny[v] then begin
        	ny[v] := true;
            if (ty[v] = 0) or DFS(ty[v]) then begin
            	tx[u] := v;
                ty[v] := u;
                exit;
            end;
        end;
        tmp := next[tmp];
    end;
    DFS := false;
end;

begin
	fillchar(g, sizeof(g), 0);
	readln(n, m, k);
    for i := 1 to k do begin
    	readln(u, v);
        tow[i] := v; next[i] := g[u]; g[u] := i;
    end;

    fillchar(tx, sizeof(tx), 0);
    fillchar(ty, sizeof(ty), 0);
    k := 0;
    for i := 1 to n do begin
    	fillchar(ny, sizeof(ny), 0);
        k := k + ord(DFS(i));
    end;
    writeln(k);
    for i := 1 to n do if tx[i] > 0 then writeln(i, ' ', tx[i]);
end.
