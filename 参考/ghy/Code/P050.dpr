type
	integer = longint;

var
	a, b	: ansistring;
    n, m, i, j	: integer;
    f		: array[1 .. 1000, 1 .. 1000] of integer;

function min(i, j : integer) : integer;
begin
	if i < j then min := i else min := j;
end;

procedure print(ch : char);
begin
	if (ch = '?') or (ch = '*') then write('A') else write(ch);
end;

begin
	readln(a); n := length(a);
    readln(b); m := length(b);
    
    for i := 1 to n + 1 do for j := 1 to m + 1 do f[i][j] := 10000;
	f[n + 1][m + 1] := 0;
    if a[n] = '*' then for i := 1 to m + 1 do f[n][i] := 0;
    if b[m] = '*' then for i := 1 to n + 1 do f[i][m] := 0;
    
    for i := n downto 1 do
    	for j := m downto 1 do
        	if (a[i] = '*') and (b[j] = '*') then f[i][j] := min(f[i + 1][j], f[i][j + 1]) else
        	if a[i] = '*' then f[i][j] := min(f[i + 1][j], f[i][j + 1] + 1) else
            if b[j] = '*' then f[i][j] := min(f[i + 1][j] + 1, f[i][j + 1]) else
            if (a[i] = '?') or (b[j] = '?') then f[i][j] := f[i + 1][j + 1] + 1 else
            if (a[i] = b[j]) then f[i][j] := f[i + 1][j + 1] + 1;

    if f[1][1] >= 10000 then writeln('#') else begin
    	i := 1; j := 1;
        while (i <= n) and (j <= m) do begin
        	if (a[i] = '*') and (b[j] = '*') then
            	if f[i][j] = f[i + 1][j] then inc(i)
                	else inc(j)
            else
        	if a[i] = '*' then
            	if f[i][j] = f[i + 1][j] then inc(i)
                	else begin print(b[j]); inc(j); end
            else
            if b[j] = '*' then 
            	if f[i][j] = f[i][j + 1] then inc(j)
                	else begin print(a[i]); inc(i); end
            else
            if (a[i] = '?') then begin print(b[j]); inc(i); inc(j); end else
            if (b[j] = '?') then begin print(a[i]); inc(i); inc(j); end else
            begin
            	print(a[i]);
                inc(i); inc(j);
            end;
        end;
        writeln;
    end;
end.
