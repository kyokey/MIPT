{$I+,Q+,R+,S+}
const
	inf = 'P041.in';
    ouf = 'P041.out';
    maxn = 300000;
    modes = 1000003;

type
	integer = longint;
    TCube	= array[1 .. 24] of integer;
    TPermu	= array[1 .. 12] of integer;
    TQueue	= array[1 .. maxn] of TCube;

var
	idx		: array[1 .. 6] of TPermu = (
    		(1, 5, 9, 13, 3, 7, 11, 15, 17, 18, 19, 20),
            (17, 5, 21, 16, 18, 6, 22, 15, 1, 3, 4, 2),
            (3, 21, 10, 20, 4, 23, 9, 18, 5, 6, 8, 7),
            (2, 6, 10, 14, 4, 8, 12, 16, 22, 21, 23, 24),
            (19, 7, 23, 14, 20, 8, 24, 13, 11, 9, 10, 12),
            (1, 22, 12, 19, 2, 24, 11, 17, 15, 16, 14, 13));

    target	: TCube = (1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 6, 6, 6, 6);

var
	hash	: array[0 .. modes] of integer;
    a, b, c	: TQueue;
    data	: array[1 .. maxn] of TCube;
    cost	: array[1 .. maxn] of integer; 
    next	: array[1 .. maxn] of integer;
    ndata	: integer;

function compare(var a, b : TCube) : integer;
var
	i	: integer;
begin
	for i := 1 to 24 do begin
    	if a[i] < b[i] then begin compare := -1; exit; end;
    	if a[i] > b[i] then begin compare := +1; exit; end;
    end;
    compare := 0;
end;

function ELFhash(var a : TCube) : integer;
var
	i, now, tmp	: integer;
begin
	now := 0;
    for i := 1 to 24 do begin
    	now := now shl 4 + a[i];
        tmp := now and $f0000000;
        if tmp > 0 then now := now xor (tmp shr 24);
        now := now xor tmp;
    end;
    ELFhash := now;
end;

procedure unique(var a : TCube);
var
	per		: TPermu;
    i, m	: integer;
begin
	fillchar(per, sizeof(per), 0);
    m := 0;
    for i := 1 to 24 do begin
    	if per[a[i]] = 0 then begin inc(m); per[a[i]] := m; end;
		a[i] := per[a[i]];
    end;
end;

function rotate(var source : TCube; var idx : TPermu) : TCube;
var
	p	: integer;
    a	: TCube;
begin
	a := source;
	p := a[idx[1]]; a[idx[1]] := a[idx[2]]; a[idx[2]] := a[idx[3]]; a[idx[3]] := a[idx[4]]; a[idx[4]] := p;
	p := a[idx[5]]; a[idx[5]] := a[idx[6]]; a[idx[6]] := a[idx[7]]; a[idx[7]] := a[idx[8]]; a[idx[8]] := p;
	p := a[idx[9]]; a[idx[9]] := a[idx[10]]; a[idx[10]] := a[idx[11]]; a[idx[11]] := a[idx[12]]; a[idx[12]] := p;
    unique(a);
    rotate := a;
end;

procedure init(var a : TCube);
var
    i, j, m	: integer;
	x		: array[1 .. 24] of boolean;
begin
	fillchar(x, sizeof(x), 0);
    m := 0;
    for i := 1 to 24 do if not x[i] then begin
    	m := m + 1;
        for j := 24 downto i do if (a[i] = a[j]) and not x[j] then begin
        	a[j] := m;
            x[j] := true;
        end;
    end;
    unique(a);
end;

function findData(var a : TCube; pos : integer) : integer; overload;
var
	k	: integer;
begin
	k := hash[pos];
    while (k > 0) and (compare(a, data[k]) <> 0) do k := next[k];
    findData := k;
end;

function findData(var a : TCube) : integer; overload;
var
	pos, k	: integer;
begin
	pos := ELFhash(a) mod modes; k := hash[pos]; 
    while (k > 0) and (compare(a, data[k]) <> 0) do k := next[k];
    findData := k;
end;

procedure addData(var a : TCube; dep : integer);
var
	pos	: integer;
begin
	pos := ELFhash(a) mod modes;
    if findData(a, pos) > 0 then exit;
    inc(ndata); data[ndata] := a; cost[ndata] := dep;
    next[ndata] := hash[pos]; hash[pos] := ndata;
end;

function expand(var a : TQueue; var n : integer; d : integer) : boolean;
var
	i, k, p, m, h	: integer;	
begin
	m := 0; h := cost[findData(a[1])];
    expand := true;
    for i := 1 to n do
    	for k := 1 to 6 do begin
        	c[m + 1] := rotate(a[i], idx[k]);
            p := findData(c[m + 1]);
            if p <> 0 then begin
            	if cost[p] * d < 0 then begin
                	writeln(abs(cost[p] - h) - 1);
                    exit;
                end;
                continue;
            end;
            m := m + 1; addData(c[m], h + d); 
        end;
    n := m;
    for i := 1 to n do a[i] := c[i];
    expand := false;
end;

var
	source		: TCube;
    i, s, t		: integer;

begin
	assign(input, inf); assign(output, ouf);
    reset(input); rewrite(output);


	for i := 1 to 24 do read(source[i]); init(source);

    if compare(source, target) = 0 then writeln(0) else begin
        ndata := 0; fillchar(hash, sizeof(hash), 0);
        s := 1; a[1] := source; addData(source, +1);
        t := 1; b[1] := target; addData(target, -1);

        repeat
            if expand(a, s, +1) then break;
            if expand(b, t, -1) then break;
        until false;
    end;

    close(input); close(output);
end.

