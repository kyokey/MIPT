{$APPTYPE CONSOLE}
const
	maxn = 20;

type
	integer = longint;

var
	n, i, j, s	: integer;
    t			: extended;
    f			: array[0 .. 1 shl maxn] of extended;
    x, y		: array[1 .. maxn] of extended;
    bit			: array[1 .. maxn] of integer;
    dis			: array[1 .. maxn, 1 .. maxn] of extended;

begin
	readln(n);
    for i := 1 to n do readln(x[i], y[i]);
    for i := 1 to n do for j := 1 to n do dis[i][j] := sqrt(sqr(x[i] - x[j]) + sqr(y[i] - y[j]));

    for i := 1 to n do bit[i] := 1 shl (i - 1); f[0] := 0;
    for s := 1 to 1 shl n - 1 do begin
    	f[s] := 1e20; j := n + 1;
        for i := 1 to n do if s and bit[i] > 0 then begin j := i; break; end;

        for i := j + 1 to n do if s and bit[i] > 0 then begin
        	t := f[s - bit[i] - bit[j]] + dis[i][j];
            if t < f[s] then f[s] := t;
        end;
    end;
    writeln(f[1 shl n - 1] : 0 : 8);
end.
