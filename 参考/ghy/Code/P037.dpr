const
	infinite = maxlongint shr 2;

type
	integer = longint;

var
	f, g	: array[0 .. 100, 0 .. 10000] of integer;
    w, queue	: array[0 .. 10000] of integer;
    n, m, p, q, lower, upper	: integer;
    i, j, t, k, op, cl			: integer;

begin
	readln(n, lower, upper);
    for i := 1 to upper do f[0][i] := - infinite; f[0][0] := 0;
    for i := 1 to n do begin
    	readln(p, m, q); w[i] := m;
        for k := 0 to m - 1 do begin
        	op := 1; cl := 0; j := 0;
            while j * m + k <= upper do begin
            	t := j * m + k;
            	if (op <= cl) and (j - queue[op] > q) then inc(op);
                while (op <= cl) and (f[i - 1][t] - j * p >= f[i - 1][m * queue[cl] + k] - queue[cl] * p) do
                	dec(cl);
                cl := cl + 1; queue[cl] := j;
                f[i][t] := f[i - 1][queue[op] * m + k] + (j - queue[op]) * p;
                g[i][t] := (j - queue[op]);
                j := j + 1;
            end;
        end;
    end;
    k := lower;
    for i := lower to upper do if f[n][i] > f[n][k] then k := i;
    if f[n][k] < 0 then writeln(-1) else begin
    	writeln(f[n][k]);
		for i := n downto 1 do begin
        	queue[i] := g[i][k];
            k := k - g[i][k] * w[i];
        end;
        for i := 1 to n do writeln(queue[i]);
    end;
end.
