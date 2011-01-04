{$APPTYPE CONSOLE}

const
	maxn = 500;
    maxm = 100000;
    infinite = maxlongint shr 1;

type
	integer = longint;

var
	queue, e, g, x, y, z, pre	: array[0 .. maxn] of integer;
	tow, next, flow, limit	: array[1 .. maxm] of integer;
    n, tot	: integer;

procedure swap(var i, j	: integer);
var
	temp	: integer;
begin
	temp := i; i := j; j := temp;
end;

procedure add(u, v, f, l : integer);
begin
	tot := tot + 1;
    tow[tot] := v; next[tot] := g[u]; g[u] := tot;
    flow[tot] := f; limit[tot] := l;
end;

function maxFlow(s, t : integer) : integer;
var
	op, cl, u, v, sum, tmp	: integer;
begin
	sum := 0;
    repeat
    	fillchar(pre, sizeof(pre), 0);
        pre[s] := s; queue[1] := s;
        op := 0; cl := 1;
        while (pre[t] = 0) and (op < cl) do begin
        	inc(op); u := queue[op]; tmp := g[u];
            
            while tmp <> 0 do begin
            	v := tow[tmp];
                if (pre[v] = 0) and (flow[tmp] < limit[tmp]) then begin
                	pre[v] := u; e[v] := tmp;
                    inc(cl); queue[cl] := v;
                end;
                tmp := next[tmp];
            end;
        end;

		if pre[t] = 0 then break;

        inc(sum); u := t;
        while pre[u] <> u do begin
        	inc(flow[e[u]]); dec(flow[e[u] xor 1]);
            u := pre[u];
        end;
    until false;
    maxFlow := sum;
end;

var
	i, j, s, t	: integer;

begin
	readln(n);
    for i := 1 to n do begin
    	readln(x[i], y[i], z[i]);
        if x[i] > y[i] then swap(x[i], y[i]);
        if x[i] > z[i] then swap(x[i], z[i]);
        if y[i] > z[i] then swap(y[i], z[i]);
    end;

    fillchar(g, sizeof(g), 0);
    s := 2 * n + 1; t := s + 1; tot := 1;

    for i := 1 to n do begin
    	add(s, i, 1, infinite); add(i, s, infinite - 1, infinite);
        add(i + n, t, 1, infinite); add(t, i + n, infinite - 1, infinite);
        add(i, i + n, 0, infinite); add(i + n, i, infinite, infinite);
    end;

    for i := 1 to n do for j := 1 to n do
    	if (x[i] < x[j]) and (y[i] < y[j]) and (z[i] < z[j]) then begin
        	add(i, j + n, infinite, infinite);
            add(j + n, i, 0, infinite); 
        end;
    writeln(n - maxFlow(t, s));
end.
