var
	n, cnt	: integer;
    map, st	: ansistring;
    ty		: array[1 .. 500] of integer;
    ny		: array[1 .. 500] of boolean;

function DFS(u : integer) : boolean;
var
	v 		: array[1 .. 4] of integer;
    i, k	: integer;

	procedure add(p : integer);
    begin
    	if map[p] <> '.' then exit;
    	inc(k); v[k] := p;
    end;

begin
	k := 0; DFS := true;
	if u mod n <> 0 then add(u + 1);
    if u mod n <> 1 then add(u - 1);
    if u + n <= n * n then add(u + n);
    if u - n > 0 then add(u - n);
    for i := 1 to k do if not ny[v[i]] then begin
    	ny[v[i]] := true;
        if (ty[v[i]] = 0) or DFS(ty[v[i]]) then begin
        	ty[v[i]] := u;
            exit;
        end;
    end;
    DFS := false;
end;

var
	i, j	: integer;

begin
	readln(n); map := '';
    
    for i := 1 to n do begin
    	readln(st);
        map := map + st;
    end;

    cnt := 0;
    fillchar(ty, sizeof(ty), 0);

    for i := 0 to n - 1 do
    	for j := 1 to n do if (map[i * n + j] = '.') and odd(i + j) then begin
        	fillchar(ny, sizeof(ny), 0);
            if DFS(i * n + j) then inc(cnt);
        end;
    writeln(cnt);
end.
