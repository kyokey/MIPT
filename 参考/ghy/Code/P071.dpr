{$APPTYPE CONSOLE}
var
	a			: array[1 .. 10000] of longint;
    i, n, m, s	: longint;
    l, r, mid	: longint;

begin
	readln(n, m);
    for i := 1 to n do read(a[i]); readln;

    l := 0; r := 10000000;
    while l < r do begin
    	mid := (l + r + 1) shr 1; s := 0;
        for i := 1 to n do begin
        	inc(s, a[i] div mid);
            if s >= m then break;
        end;
        if s >= m then l := mid else r := mid - 1;
    end;
    writeln(l);
end.
