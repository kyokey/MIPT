var
	i, k, n	: longint;
    a		: array[2 .. 2000000] of longint;
    s		: int64;

begin
	readln(n);
    for i := 2 to n do a[i] := i;
    for i := 2 to n do if a[i] = i then begin
    	k := i;
        while k <= n do begin
        	a[k] := a[k] div i * (i - 1);
            k := k + i;
        end;
    end;
    s := 0;
    for i := 2 to n do s := s + a[i];
    k := 0;
    while s > 1 do begin
    	k := k + 1;
        s := (s + 1) shr 1;
    end;
    writeln(k);
end.
