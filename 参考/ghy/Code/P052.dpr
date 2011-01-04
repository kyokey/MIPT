{$APPTYPE CONSOLE}

type
	integer = longint;
    Arr		= array[1 .. 11] of integer;

var
	n			: integer;
    a			: Arr;
    g			: array[0 .. 10 ] of integer;
    f, queue	: array[1 .. 3628800] of integer;
    target		: integer;

function get(var a : Arr) : integer;
var
	i, j, k, cnt	: integer;
begin
	cnt := 0;
	for i := 1 to n do begin
    	k := 0;
    	for j := 1 to i - 1 do if a[j] < a[i] then inc(k);
        inc(cnt, k * g[a[i] - 1]); 
    end;
    get := cnt;
end;

procedure release(var a : Arr; s : integer);
var
	i, j	: integer;
begin
	fillchar(a, sizeof(a), 0);
	for i := n downto 1 do
    	for j := 1 to n do if a[j] = 0 then
        	if s < g[i - 1] then begin
            	a[j] := i;
                break;
            end else s := s - g[i - 1];
end;

procedure swap(var i, j : integer);
var
	temp	: integer;
begin
	temp := i; i := j; j := temp;
end;

var
	i, k, op, cl	: integer;

begin
	readln(n);
	g[0] := 1;
    for i := 1 to n do g[i] := g[i - 1] * i;
    for i := 1 to n do read(a[i]); readln;
    target := get(a);
    for i := 1 to n do a[i] := i;
    for i := 0 to g[n] - 1 do f[i] := 1000;

    op := 0; cl := 0;
    for i := 1 to n do begin
    	f[get(a)] := 0;
        inc(cl); queue[cl] := get(a);
        move(a[1], a[2], sizeof(a[1]) * n);
        a[1] := a[n + 1];
    end;

	while f[target] = 1000 do begin
    	inc(op); release(a, queue[op]);
        for i := 1 to n do begin
        	if i < n then swap(a[i], a[i + 1]) else swap(a[1], a[n]);
            k := get(a);
            if f[k] = 1000 then begin
            	f[k] := f[queue[op]] + 1;
                inc(cl); queue[cl] := k;
            end;
        	if i < n then swap(a[i], a[i + 1]) else swap(a[1], a[n]);
        end;
    end;
    writeln(f[target]);
    readln;
end.

