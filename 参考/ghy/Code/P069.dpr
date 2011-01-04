{$APPTYPE CONSOLE}
const
	maxn = 101;

type
	integer = longint;

var
	x, z		: array[1 .. maxn] of boolean;
    d, y, idx	: array[1 .. maxn] of integer;
	g			: array[1 .. maxn, 1 .. maxn] of boolean;
    n, m		: integer;
    answer		: integer;

procedure swap(var i, j : integer);
var
	temp		: integer;
begin
	temp := i; i := j; j := temp;
end;

procedure DFS(k, used : integer);
var
	i, j		: integer;
begin
	if used > answer then begin
    	answer := used;
        z := x;
    end;

    j := 0;
    for i := k to n do if y[idx[i]] = 0 then inc(j);
    if used + j <= answer then exit; 

    for i := k to n do if y[idx[i]] = 0 then begin
    	x[idx[i]] := true;
        for j := i + 1 to n do if g[idx[i]][idx[j]] then inc(y[idx[j]]);
        DFS(i + 1, used + 1);
        for j := i + 1 to n do if g[idx[i]][idx[j]] then dec(y[idx[j]]);
        x[idx[i]] := false;
    end; 
end;

var
	i, j, u, v	: integer;

begin
	while not seekeof do begin
        fillchar(g, sizeof(g), 0);
        readln(n, m);
        for i := 1 to m do begin
            readln(u, v);
            g[u][v] := true;
            g[v][u] := true;
        end;

        fillchar(d, sizeof(d), 0);
        for i := 1 to n do for j := 1 to n do inc(d[i], ord(g[i][j]));

        for i := 1 to n do begin
            idx[i] := i; j := i;
            while (j > 1) and (d[idx[j]] < d[idx[j - 1]]) do begin
                swap(idx[j], idx[j - 1]);
                j := j - 1;
            end;
        end;

        fillchar(x, sizeof(x), 0);
        fillchar(y, sizeof(y), 0);
        answer := 0;
        DFS(1, 0);

        writeln(answer);
        for i := 1 to n do if z[i] then write(i, ' '); writeln;
    end;
end.
