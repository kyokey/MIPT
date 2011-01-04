const
	maxn = 300;
    eps = 1e-7;
    infinite = 1e10;

type
	integer = longint;
    TPoint = record
    	x, y	: double;
    end;

var
	name	: array[1 .. maxn] of string;
    cost	: array[1 .. maxn, 1 .. maxn] of double;
    dis		: array[1 .. maxn] of double;
    pre		: array[1 .. maxn] of integer;
    town, Lend, Rend	: array[1 .. maxn] of TPoint;
    n, m	: integer;
    tot		: double;

function area(i, j, k : TPoint) : integer;
var
	s	: double;
begin         
	s := (j.x - i.x) * (k.y - i.y) - (j.y - i.y) * (k.x - i.x);
    if s < - eps then area := -1 else
    if s > eps then area := 1 else area := 0;
end;

var
	i, j, k, u	: integer;
    ch			: char;

begin
	readln(n, m);

    for i := 1 to n do begin
    	name[i] := ''; read(ch);
        while ch <> ' ' do begin
        	name[i] := name[i] + ch;
            read(ch);
        end;
        readln(town[i].x, town[i].y);
    end;

    for i := 1 to m do readln(Lend[i].x, Lend[i].y, Rend[i].x, Rend[i].y);

    for i := 1 to n do
    	for j := i + 1 to n do begin
        	cost[i][j] := sqrt(sqr(town[i].x - town[j].x) + sqr(town[i].y - town[j].y));
            for k := 1 to m do begin
            	if (area(town[i], town[j], Lend[k]) * area(town[i], town[j], Rend[k]) < 0) and
                   (area(Lend[k], Rend[k], town[i]) * area(Lend[k], Rend[k], town[j]) < 0) then begin
                    cost[i][j] := infinite;
                    break;
                end;
            end;
            cost[j][i] := cost[i][j];
        end;

    for i := 1 to n do begin dis[i] := infinite; cost[i][i] := infinite; end;

    dis[1] := 0; pre[1] := 0; tot := 0;
    for k := 1 to n do begin
    	u := 0;
    	for i := 1 to n do if (dis[i] >= 0) and ((u = 0) or (dis[i] < dis[u])) then u := i;
        tot := tot + dis[u];
        for i := 1 to n do if cost[u][i] < dis[i] then begin
        	dis[i] := cost[u][i];
			pre[i] := u;
        end;
        dis[u] := -1;
    end;
    if tot >= infinite then writeln('NO') else begin
    	writeln('YES');
        writeln(n - 1);
        for i := 2 to n do writeln(name[pre[i]], ' ' ,name[i]);
    end;
end.
