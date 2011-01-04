{$APPTYPE CONSOLE}
const
	eps = 1e-6;
	maxn = 310;

type
	integer = longint;

var
	n, i, j, k		: integer;
    dis				: array[1 .. maxn, 1 .. maxn] of extended;
    R, answer		: extended;
    x, y			: array[1 .. maxn] of extended;

begin
	readln(n); readln(R);
    for i := 1 to n do readln(x[i], y[i]);
    for i := 1 to n do for j := 1 to n do dis[i][j] := sqrt(sqr(x[i] - x[j]) + sqr(y[i] - y[j]));
    for i := 1 to n do for j := 1 to n do if dis[i][j] > R + eps then dis[i][j] := 1e20;

    for k := 1 to n do
    	for i := 1 to n do
        	for j := 1 to n do
            if dis[i][k] + dis[k][j] < dis[i][j] then
            	dis[i][j] := dis[i][k] + dis[k][j];
                
    answer := 1e20;
    for i := 3 to n do if (x[i] < 0) and (dis[i][1] + dis[i][2] < answer) then
    	answer := dis[i][1] + dis[i][2];
	writeln(answer : 0 : 6);
end.
