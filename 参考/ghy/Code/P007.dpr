type
	integer = longint;

var
	a	: array[0 .. 20, 0 .. 20, 0 .. 20] of integer;
    n, m, p	: integer;
    i, j, k	: integer;
    li, lj, lk, ri, rj, rk	: integer;
    s,	answer	: integer;

begin
	fillchar(a, sizeof(a), 0);
	readln(n, m, p);
    for k := 1 to p do for i := 1 to n do for j := 1 to m do begin
    	read(a[i][j][k]);
        a[i][j][k] := a[i - 1][j][k] + a[i][j - 1][k] + a[i][j][k - 1]
        			- a[i - 1][j - 1][k] - a[i - 1][j][k - 1] - a[i][j - 1][k - 1]
                    + a[i - 1][j - 1][k - 1] + a[i][j][k];
	end;

    answer := - maxlongint;
	for li := 0 to n - 1 do for ri := li + 1 to n do
    	for lj := 0 to m - 1 do for rj := lj + 1 to m do
        	for lk := 0 to p - 1 do for rk := lk + 1 to p do begin
            	s := a[ri][rj][rk] - a[ri][rj][lk] - a[ri][lj][rk] - a[li][rj][rk]
                   + a[ri][lj][lk] + a[li][rj][lk] + a[li][lj][rk] - a[li][lj][lk];
                if s > answer then answer := s;
            end;
    writeln(answer);
    readln(k);
end.
