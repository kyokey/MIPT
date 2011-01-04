var
	n, m : longint;

begin
	readln(n); m := 0;
    while n > 0 do begin
    	m := m + 1;
        if n mod 2 = 0 then n := n shr 1 else
        if n mod 4 = 1 then n := n - 1 else
        if n > 3 then n := n + 1 else n := n - 1;
    end;
    writeln(m);
end.
