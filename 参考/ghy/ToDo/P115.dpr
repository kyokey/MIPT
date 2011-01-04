{$APPTYPE CONSOLE}
const
	maxn = 11000;
    Limit = 100;

type
	integer		= longint;
	boolArray	= array[0 .. maxn] of boolean;

var
	a, b, c				: array[0 .. maxn] of char;
    f					: array[0 .. maxn] of ^boolArray;
    n, m				: integer;

procedure init;
begin
	n := 0; 
	while not seekeoln do begin
    	n := n + 1;
        read(a[n]);
    end; readln;
end;

function main : boolean;
var
    size				: integer;

	procedure process(k : integer);
    var
    	i		: integer;
    begin
    	getMem(f[k], size);
        for i := 0 to m do
        	if (a[k] <> b[i]) and (a[k] <> '0') then f[k][i] := false else
			if b[i] = '-'
            then
            	if i = 0
                	then continue
                	else f[k][i] := f[k - 1][i - 1]
            else
            	if i = 0
                	then f[k][i] := f[k - 1][i]
                    else f[k][i] := f[k - 1][i] or f[k - 1][i - 1];
    end;

var
	i, k, s				: integer;

begin
	result := false;
	n := n + 1; a[n] := '.'; m := 0;
    while not seekeof do begin
    	read(k);
        if m + k + 1 > n then exit;
        while k > 0 do begin
        	k := k - 1; m := m + 1;
            b[m] := '-';
        end;
        m := m + 1; b[m] := '.';
    end; readln;

    size := sizeof(boolean) * (m + 10);
    getmem(f[0], size);
    fillchar(f[0]^, sizeof(f[0]^), 0);
    f[0][0] := true; a[0] := '.'; b[0] := '.';

    for k := 1 to n do begin
    	process(k);
        if k mod Limit = 0 then
        	for i := k - Limit + 1 to k - 1 do begin
            	dispose(f[i]);
                f[i] := nil;
            end;
    end;

	if not f[n][m] then exit;
    for i := 0 to m - 1 do f[n][i] := false;
     
    result := true;
    for k := n - 1 downto 1 do begin
        if (k + 1) mod Limit = 0 then
        	for i := k - Limit + 2 to k do process(i);

        for i := 0 to m do if f[k][i] then
        	if i < m
            	then f[k][i] := f[k + 1][i + 1] or (b[i] = '.') and f[k + 1][i]
                else f[k][i] := f[k + 1][i];
        s := 0;
        for i := 0 to m do begin
        	if f[k][i] and (b[i] = '-') then s := s or 1;
            if f[k][i] and (b[i] = '.') then s := s or 2;
        end;
        if s = 1 then c[k] := '-' else
        if s = 2 then c[k] := '.' else c[k] := '0';

        if k mod Limit = 0 then
        	for i := k + 1 to k + Limit - 1 do if i <= n then dispose(f[i]);
    end;
    for i := 1 to n - 1 do write(c[i]); writeln;
end;

begin
	init;
    if not main then writeln('BEAVERROR');
end.

