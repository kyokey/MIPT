const
	maxn = 1001;

type
	integer = longint;

var
	a, b	: string;
    n, m	: integer;
	f		: array[0 .. maxn, 0 .. maxn] of boolean;
    L, s	: array[1 .. maxn] of integer;
    i, j, k	: integer;

begin
	readln(a); n := length(a);
    readln(b); m := length(b);

    k := 0;
    for i := 1 to n do begin
    	if a[i] = '[' then begin k := k + 1; s[k] := i; end;
        if a[i] = ']' then begin L[i] := s[k]; k := k - 1; end;
    end;

    fillchar(f, sizeof(f), 0); f[0][0] := true;
    for i := 1 to n do begin
    	if a[i] = '[' then f[i] := f[i - 1] else
        if a[i] = ']' then begin
        	f[i] := f[i - 1];
            for j := 0 to m do f[i][j] := f[i][j] or f[L[i]][j];
        end else
        	for j := 1 to m do if a[i] = b[j] then f[i][j] := f[i - 1][j - 1];
    end;
    if f[n][m] then writeln('YES') else writeln('NO');
end.
