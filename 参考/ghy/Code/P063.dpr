uses math;

const
	inf	 = 'P063.in';
    ouf  = 'P063.out';
	maxm = 110;
    maxn = 12000;

type
	integer = longint;

var
	s, map		: array[0 .. maxm, 0 .. maxm] of integer;
    apply		: array[0 .. maxm, 0 .. maxm] of boolean;
    stack		: array[0 .. maxn, 1 .. 2] of integer;
    cnt, used	: array[0 .. 3, 0 .. 8] of integer;
    from		: array[0 .. 3, 0 .. 8, 0 .. 8] of integer;
    need		: array[0 .. 3] of integer;
    x, y		: array[1 .. maxn] of integer;
    n, _X, _Y	: integer;
    mx, my, top	: integer;
    cost, left, k, take	: integer;

function place(k : integer; t : integer) : boolean;
var
	x, y	: integer;
begin
	place := true;
	x := mx - stack[t][1]; y := my - stack[t][2];
    if map[x][y] = 0 then begin map[x][y] := k; writeln(k, ' ', x, ' ', y); exit; end;
	x := mx - stack[t][1]; y := my + stack[t][2];
    if map[x][y] = 0 then begin map[x][y] := k; writeln(k, ' ', x, ' ', y); exit; end;
	x := mx + stack[t][1]; y := my - stack[t][2];
    if map[x][y] = 0 then begin map[x][y] := k; writeln(k, ' ', x, ' ', y); exit; end;
	x := mx + stack[t][1]; y := my + stack[t][2];
    if map[x][y] = 0 then begin map[x][y] := k; writeln(k, ' ', x, ' ', y); exit; end;
    place := false;
end;

var
	i, j	: integer;

begin
	assign(input, inf); assign(output, ouf);
    reset(input); rewrite(output);
	readln(_X, _Y);
	readln(n);
    for i := 1 to n do begin
    	readln(j, x[j], y[j]);
        map[x[j]][y[j]] := j;
    end;

    mx := _X shr 1; my := _Y shr 1;
	fillchar(s, sizeof(s), 0);

	for i := 1 to n do inc(s[abs(x[i] - mx)][abs(y[i] - my)]);

    fillchar(cnt, sizeof(cnt), 0);
    for i := 0 to mx do for j := 0 to my do
    	inc(cnt[ord(i > 0) + ord(j > 0)][s[i][j]]);

    fillchar(used, sizeof(used), 0);
    cost := 0;
    need[0] := ord(n and 1 > 0);
    need[1] := ord(n and 2 > 0);
    need[2] := n div 4;

	for k := 0 to 2 do begin
    	for i := 1 shl k downto 0 do begin
			take := min(cnt[k][i], need[k]);
			cost := cost + take * (1 shl k - i);
            used[k][i] := take;
            dec(cnt[k][i], take);
            dec(need[k], take);
            if need[k] = 0 then break;
        end;

        left := 0;
        for i := 1 shl k downto 0 do if cnt[k][i] > 0 then begin
			if left > 0 then begin
            	inc(cnt[k + 1][i + left]);
                inc(from[k + 1][i + left][i]);
                inc(from[k + 1][i + left][left]);
                dec(cnt[k][i]);
            end;
            inc(cnt[k + 1][i * 2], cnt[k][i] shr 1);
            inc(from[k + 1][i * 2][i], cnt[k][i] shr 1 shl 1);
            if odd(cnt[k][i]) then left := i else left := 0;
        end;
    end;

    fillchar(cnt, sizeof(cnt), 0);
    for i := 0 to mx do for j := 0 to my do
    	inc(cnt[ord(i > 0) + ord(j > 0)][s[i][j]]);

    for k := 2 downto 0 do
    	for i := 1 shl k downto 0 do
        	if used[k][i] > cnt[k][i] then begin
            	left := (used[k][i] - cnt[k][i]) * 2;
            	for j := 4 downto 0 do begin
                	take := min(left, from[k][i][j]);
                    inc(used[k - 1][j], take);
                    dec(left, take);
                end;
                used[k][i] := cnt[k][i];
            end;

	fillchar(apply, sizeof(apply), 0);
    top := 0;  
    for i := 0 to mx do for j := 0 to my do begin
    	k := ord(i > 0) + ord(j > 0);
        if used[k][s[i][j]] > 0 then begin
        	dec(used[k][s[i][j]]);
            inc(top);
            stack[top][1] := i; stack[top][2] := j;
            apply[i][j] := true;
        end;
    end;

    writeln(cost);
    
    for i := 1 to n do
    	if not apply[abs(x[i] - mx)][abs(y[i] - my)] then
			while not place(i, top) do dec(top);

    close(input); close(output);
end.

