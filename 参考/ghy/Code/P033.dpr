{$APPTYPE CONSOLE}
const
	maxn = 2500;

type
	integer = longint;

var
	n, m, i, j, u, v, op, cl	: integer;
    g	: array[1 .. maxn, 1 .. maxn] of shortint;
    f, ind, queue	: array[1 .. maxn] of integer;
    ch	: char;

begin
	readln(n);
	fillchar(g, sizeof(g), $ff);

    for i := 1 to n do begin

    	if i > 1 then begin
            for j := 1 to i * 2 - 2 do begin
                read(ch);
                u := (i - 1) * (i - 1) + j;
                v := u + 1;
                g[u][v] := ord(ch = '>'); g[v][u] := 1 - g[u][v];
            end; readln;
        end;

        if i = n then break;

    	for j := 1 to i do begin
        	read(ch);
            u := (i - 1) * (i - 1) + 2 * j - 1;
            v := i * i + 2 * j;
            g[u][v] := ord(ch = '>');
            g[v][u] := 1 - g[u][v];
        end; readln;
    end;

    fillchar(ind, sizeof(ind), 0);
    op := 0; cl := 0; m := n * n;
    for i := 1 to n * n do for j := 1 to n * n do if g[i][j] = 1 then inc(ind[j]);
    for i := 1 to n * n do if ind[i] = 0 then begin
    	inc(cl);
        queue[cl] := i;
    end;
    
    while op < cl do begin
    	inc(op); u := queue[op];
        f[u] := m; m := m - 1;
        for v := 1 to n * n do if g[u][v] = 1 then begin
        	dec(ind[v]);
            if ind[v] = 0 then begin
            	inc(cl);
                queue[cl] := v;
            end;
        end;
    end;

    if cl < n * n then begin
    	writeln(0);
        halt;
    end;

    writeln(1);
    for i := 1 to n do begin
    	for j := 1 to 2 * i - 1 do write(f[(i - 1) * (i - 1) + j], ' ');
        writeln;
    end;
    readln;
end.
