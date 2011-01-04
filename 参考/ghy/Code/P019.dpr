const
	maxn = 1000;
    dirx : array[1 .. 4] of integer = (0, 0, 1, -1);
    diry : array[1 .. 4] of integer = (1, -1, 0, 0);

type
	integer = longint;

var
	map	: array[1 .. maxn, 1 .. maxn] of char;
	x	: array[1 .. maxn, 1 .. maxn] of integer;
    queue	: array[1 .. maxn * maxn] of integer;
    n	: integer;

function count(ch : char) : integer;
var
	op, cl, i, j, k, u, v, s, t, p, q	: integer;
begin
	fillchar(x, sizeof(x), 0);
	op := 0; cl := 0;
	for i := 1 to n do begin
    	if ch = 'R' then begin
        	if map[i][1] = 'R' then begin
            	cl := cl + 1; queue[cl] := i * (n + 1) + 1;
                x[i][1] := 1;
            end;
            if map[i][n] = 'R' then begin
            	cl := cl + 1; queue[cl] := i * (n + 1) + n;
                x[i][n] := 2;
            end;
        end else begin
        	if map[1][i] = 'B' then begin
            	cl := cl + 1; queue[cl] := n + 1 + i;
                x[1][i] := 1;
            end;
            if map[n][i] = 'B' then begin
            	cl := cl + 1; queue[cl] := n * (n + 1) + i;
                x[n][i] := 2;
            end;
        end;
    end;

    while op < cl do begin
    	inc(op); u := queue[op] div (n + 1); v := queue[op] mod (n + 1);
        for i := 1 to 4 do begin
        	p := u + dirx[i]; q := v + diry[i];
            if (p > 0) and (p <= n) and (q > 0) and (q <= n) and (x[p][q] = 0) and (map[p][q] = map[u][v]) then begin
				x[p][q] := x[u][v];
                cl := cl + 1; queue[cl] := p * (n + 1) + q;
            end;
        end;
    end;
    s := 0;
    for i := 1 to n do
    	for j := 1 to n do if (map[i][j] = '.') then begin
			t := 0;
            for k := 1 to 4 do begin
            	p := i + dirx[k]; q := j + diry[k];
                if (p > 0) and (p <= n) and (q > 0) and (q <= n) then t := t or x[p][q];
                if (ch = 'R') and (q < 1) then t := t or 1;
                if (ch = 'R') and (q > n) then t := t or 2;
                if (ch = 'B') and (p < 1) then t := t or 1;
                if (ch = 'B') and (p > n) then t := t or 2;
            end;
            if t = 3 then inc(s);
        end;
    count := s;
end;

var
	a, b, i, j	: integer;

begin
	readln(n);
    a := (n * n - 1) shr 2; b := a;
    for i := 1 to n do begin
    	for j := 1 to n do begin
        	read(map[i][j]);
            if map[i][j] = 'R' then dec(a);
            if map[i][j] = 'B' then dec(b);
        end;
        readln;
    end;
    if a = b then
    	if count('R') > 0 then writeln(1) else
        if count('B') > 1 then writeln(2) else writeln(0)
    else
    	if count('B') > 0 then writeln(1) else
        if count('R') > 1 then writeln(2) else writeln(0);
end.
