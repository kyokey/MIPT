{$APPTYPE CONSOLE}
uses math;

const
	maxn 		= 64;
	maxm 		= maxn * maxn * 2;
    infinite 	= 100000;
    dirx		: array[1 .. 8] of integer = (0, 0, 1, -1, 1, -1, 1, -1);
    diry		: array[1 .. 8] of integer = (1, -1, 0, 0, 1, -1, -1, 1);

type
	integer = longint;

    posType = record
    	ele		: array[1 .. maxn] of integer;
        size	: integer;
    end;

var
	W, B	: array[0 .. maxn, 0 .. maxn] of integer;
    x, y	: array[0 .. maxm] of integer;
    z		: array[0 .. maxm] of char;
    WQ, BK	: string;
    s		: posType;
    op, cl, p, q, i, j	: integer;

procedure push(p, q : integer; ch : char);
begin
	cl := cl mod maxm + 1;
    x[cl] := p; y[cl] := q; z[cl] := ch;
//    if ch = 'Q' then writeln('B ', B[p][q], ' ', op) else writeln('W ', W[p][q], ' ', op);
end;

procedure walk(p, q : integer; kind : char; var s : posType);
var
	i, j, u, v, x, y	: integer;
begin
	x := p div 8; y := p mod 8;
	with s do begin
    	size := 0;
        if kind = 'K' then
        	for i := 1 to 8 do begin
            	u := x + dirx[i]; v := y + diry[i];
                if (u > 0) and (u < 4) and (v > 0) and (v < 4) then continue;
                if (u >= 0) and (v >= 0) and (u < 8) and (v < 8) then begin
                	inc(size);
                    ele[size] := u * 8 + v;
                end;
            end
        else
        	for i := 1 to 8 do
            	for j := 1 to 8 do begin
                    u := x + j * dirx[i]; v := y + j * diry[i];
                	if u * 8 + v = 18 then break;
                    if (u >= 0) and (v >= 0) and (u < 8) and (v < 8) then begin
                        inc(size);
                        ele[size] := u * 8 + v;
                    end else break;
                    if u * 8 + v = q then break;
                end;
    end;
end;

var
	t	: posType;

function compute(p, q : integer; kind : char) : boolean;
var
	i	: integer;
begin
	compute := kind = 'Q';
	if kind = 'K' then begin
    	if B[p][q] >= 0 then begin compute := false; exit; end;
    	walk(q, p, 'K', t);
    	with t do begin
    		for i := 1 to size do if W[p][ele[i]] < 0 then exit;
            B[p][q] := 0;
            for i := 1 to size do B[p][q] := max(B[p][q], W[p][ele[i]] + 1);
        end;
    end else begin
    	if W[p][q] >= 0 then begin compute := false; exit; end;
    	walk(p, q, 'Q', t);
        w[p][q] := infinite * 2;
    	with t do
			for i := 1 to size do if (B[ele[i]][q] >= 0) and (B[ele[i]][q] < infinite) then
            	W[p][q] := min(W[p][q], B[ele[i]][q] + 1);
        if W[p][q] > infinite then W[p][q] := -1 else exit;
    end;
	compute := kind = 'K';
end;

function value(k : integer) : integer;
begin
	if z[k] = 'Q' then value := B[x[k]][y[k]] else value := W[x[k]][y[k]];
end;

procedure find(p, q : integer; kind : char);
var
	i	: integer;
begin
	if kind = 'K' then begin
    	walk(q, p, 'K', t);
    	with t do begin
            writeln;
            for i := 1 to size do if B[p][q] = W[p][ele[i]] + 1 then writeln(p, ' ', ele[i]);
        end;
    end else begin
    	walk(p, q, 'Q', t);
        writeln;
    	with t do
			for i := 1 to size do if (B[ele[i]][q] >= 0) and (B[ele[i]][q] < infinite) then
            	if W[p][q] = B[ele[i]][q] + 1 then writeln(ele[i], ' ', q);
    end;
end;

begin
//	assign(output, 'output.txt'); rewrite(output);
	readln(WQ); readln(BK);
    fillchar(W, sizeof(W), $ff);
    fillchar(B, sizeof(B), $ff);

    op := 0; cl := 0;
    for i := 0 to 7 do
    	for j := 0 to 7 do if (abs(i - 2) > 1) or (abs(j - 2) > 1) then begin
        	p := i * 8 + j;
        	W[p][p] := infinite;
            B[p][p] := 0;
            push(p, p, 'Q');
            push(p, p, 'K');
        end;

    while op <> cl do begin
    	op := op mod maxm + 1;

        for i := op + 1 to cl do if value(i) < value(op) then begin
        	x[0] := x[i]; x[i] := x[op]; x[op] := x[0];
        	y[0] := y[i]; y[i] := y[op]; y[op] := y[0];
        	z[0] := z[i]; z[i] := z[op]; z[op] := z[0];
        end;
        
        p := x[op]; q := y[op];
        
        if z[op] = 'Q' then walk(p, q, 'Q', s) else walk(q, p, 'K', s);

        with s do 
        for i := 1 to s.size do begin
        	if (z[op] = 'Q') and compute(ele[i], q, 'Q') then push(ele[i], q, 'K');
        	if (z[op] = 'K') and compute(p, ele[i], 'K') then push(p, ele[i], 'Q');
        end;
    end;

    p := (ord(WQ[1]) - ord('a')) * 8 + ord(WQ[2]) - ord('1');
    q := (ord(BK[1]) - ord('a')) * 8 + ord(BK[2]) - ord('1');
    writeln(W[p][q] shr 1);
    find(58, 4, 'Q');
    find(61, 4, 'K');
    find(61, 12, 'Q');
    readln;
//    close(output);
end.

