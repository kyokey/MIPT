const
	maxn = 1010;

type
	integer = longint;

var
    n, m, i, j	: integer;
	a, b		: ansistring;
    f			: array[1 .. maxn, 1 .. maxn] of integer;

function max(i, j : integer) : integer;
begin
	if i > j then max := i else max := j;
end;

begin
	readln(a); n := length(a);
    readln(b); m := length(b);
    fillchar(f, sizeof(f), 0);
    for i := n downto 1 do
    	for j := m downto 1 do
        if a[i] = b[j] then f[i][j] := f[i + 1][j + 1] + 1
        	else f[i][j] := max(f[i + 1][j], f[i][j + 1]);
    if f[1][1] = 0 then writeln('Empty') else begin
    	i := 1; j := 1;
        while (i <= n) and (j <= m) do
        	if a[i] = b[j] then begin write(a[i]); inc(i); inc(j); end
            else if f[i + 1][j] > f[i][j + 1] then inc(i) else inc(j);
        writeln;
    end;
end.
