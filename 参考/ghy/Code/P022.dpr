const
	maxn = 1000;

type
	integer = longint;

var
	n, m, i, j	: integer;
    f			: array[0 .. maxn, 0 .. maxn] of integer;
    a, b		: array[0 .. maxn] of char;

begin
	n := 0; m := 0;
	while not seekeoln do begin n := n + 1; read(a[n]); end; readln;
	while not seekeoln do begin m := m + 1; read(b[m]); end; readln;

    fillchar(f, sizeof(f), 0);
    f[0][0] := 1;
    if b[1] = '*' then f[0][1] := 1;  
    for i := 1 to n do
    	for j := 1 to m do
        	if a[i] = b[j] then f[i][j] := f[i - 1][j - 1] else
        	if b[j] = '*' then f[i][j] := f[i - 1][j] + f[i][j - 1];
	writeln(f[n][m]);
end.

