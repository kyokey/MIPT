{$APPTYPE CONSOLE}
var
	x, y, z		: int64;
    answer		: boolean;

procedure DFS(k, a, b, c : int64);
begin
	if (a * b xor c) mod k <> z mod k then exit;
	if (b * c xor a) mod k <> x mod k then exit;
	if (c * a xor b) mod k <> y mod k then exit;
	if k = 1 shl 24 then begin
    	writeln(a, ' ', b, ' ', c);
        answer := true;
        exit;
    end;  
    DFS(k * 2, a, b, c); if answer then exit;
    DFS(k * 2, a, b, c + k); if answer then exit;
    DFS(k * 2, a, b + k, c); if answer then exit;
    DFS(k * 2, a, b + k, c + k); if answer then exit;
    DFS(k * 2, a + k, b, c); if answer then exit;
    DFS(k * 2, a + k, b, c + k); if answer then exit;
    DFS(k * 2, a + k, b + k, c); if answer then exit;
    DFS(k * 2, a + k, b + k, c + k); if answer then exit;
end;

begin
	readln(x, y, z);
    answer := false;
    DFS(1, 0, 0, 0);
    if not answer then writeln(-1, ' ', -1, ' ', -1);
end.
