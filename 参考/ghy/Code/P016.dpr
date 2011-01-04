type
	integer = longint;
    double = extended;

var
	n	: integer;
    l, r, a, x, y	: array[1 .. 1000] of double;

function max(i, j : double) : double;
begin
	if i > j then max := i else max := j;
end;

procedure swap(var i, j : double);
var
	temp	: double;
begin
	temp := i; i := j; j := temp;
end;

function process(Xsize, Ysize : double) : double;
var
	i, j, k	: integer;
    s, lower	: double;
begin
	for i := 1 to n + 2 do begin l[i] := 0; r[i] := 0; end;
    
	for i := 1 to n do a[i] := x[i]; a[n + 1] := 0; a[n + 2] := Xsize;

    for i := 1 to n + 2 do
    	for j := i + 1 to n + 2 do
        	if a[j] < a[i] then swap(a[i], a[j]);

    for i := 1 to n do
    	for j := i + 1 to n do
        	if y[j] < y[i] then begin
            	swap(x[i], x[j]); swap(y[i], y[j]);
            end;

    for i := 1 to n + 1 do
    	for k := i + 1 to n + 2 do if a[i] < a[k] then begin
            lower := 0;
            for j := 1 to n do if (x[j] < a[k]) and (x[j] > a[i]) and (y[j] > lower) then begin
                s := (a[k] - a[i]) * (y[j] - lower);
                l[i] := max(l[i], s);
                r[k] := max(r[k], s);
                lower := y[j];
            end;
            s := (a[k] - a[i]) * (Ysize - lower);
            l[i] := max(l[i], s);
            r[k] := max(r[k], s);
        end;
    for i := 1 to n + 1 do r[i + 1] := max(r[i + 1], r[i]);
    for i := n + 1 downto 1 do l[i] := max(l[i], l[i + 1]);

    s := 0;
    for i := 1 to n + 2 do s := max(s, l[i] + r[i]);
    process := s;
end;

var
	maxX, maxY, s1, s2	: double;
    i	: integer;

begin
	readln(maxX, maxY, n);
    for i := 1 to n do readln(x[i], y[i]);
    s1 := process(maxX, maxY);
	for i := 1 to n do swap(x[i], y[i]);
    s2 := process(maxY, maxX);
    if s1 > s2 then writeln(s1 : 0 : 2) else writeln(s2 : 0 : 2);
end.

