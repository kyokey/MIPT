const
	inf = 'P029.in';
    ouf = 'P029.out';
    maxn = 210;
    head = chr(33);
    tail = chr(255);

type
	integer = longint;

var
	queue		: array[1 .. maxn] of char;
    n, m		: integer;
    g			: array[head .. tail, head .. tail] of boolean;
    map			: array[1 .. maxn] of string;
    dis			: array[head .. tail] of integer;

function min(i, j : integer) : integer;
begin
	if i < j then min := i else min := j;
end;

procedure init;
var
	i	: integer;
begin
	readln(n, m);
    for i := 1 to n do readln(map[i]);
end;

procedure main;
var
	op, cl		: integer;
    u, v		: char;

    procedure push(ch : char; k : integer);
    begin
    	if (ch = 'A') or (dis[ch] >= 0) then exit;
        dis[ch] := k;
        cl := cl + 1; queue[cl] := ch;
    end;

var
	i, j, answer	: integer;
begin
	fillchar(g, sizeof(g), 0);
	for i := 1 to n - 1 do for j := 1 to m do g[map[i][j]][map[i + 1][j]] := true;
	for i := 1 to n do for j := 1 to m - 1 do g[map[i][j]][map[i][j + 1]] := true;

    for u := head to tail do g[u][u] := false;
    for u := head to tail do for v := head to tail do g[u][v] := g[u][v] or g[v][u];

	fillchar(dis, sizeof(dis), $ff);
    op := 0; cl := 0;
    for i := 1 to n do begin push(map[i][1], 1); push(map[i][m], 1); end;
    for i := 1 to m do begin push(map[1][i], 1); push(map[n][i], 1); end;

	while op < cl do begin
    	inc(op); u := queue[op];
        for v := head to tail do if g[u][v] then push(v, dis[u] + 1);
    end;

    answer := 255;
    for u := head to tail do if g['A'][u] then answer := min(answer, dis[u]);
    if answer < 0 then writeln(-1) else begin
    	for u := head to tail do if g['A'][u] then answer := answer + 1;
    	writeln(answer - 1);
    end;
end;

begin
	assign(input, inf); assign(output, ouf);
    reset(input); rewrite(output);
    init;
    main;
    close(input); close(output);
end.
