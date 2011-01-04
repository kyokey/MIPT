type
	integer = longint;

var
	n, m, t, i	: integer;
    a			: array[1 ..20] of integer;

procedure DFS(k, s : integer);
begin
	if s > n then exit;
    if s > t then t := s;
    if k > m then exit;
    DFS(k + 1, s + a[k]);
    DFS(k + 1, s);
end;

begin
	readln(n, m);
    for i := 1 to m do read(a[i]);
    t := 0;
    DFS(1, 0);
    writeln(t);
end.
