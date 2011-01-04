var
	x, y, n, i, L	: longint;
    bool			: boolean;

begin
	readln(x, y);
    readln(n);
    for i := 1 to n do begin
    	read(L);
        bool := false;
        if (x mod L = 0) and ((y - 2) mod L = 0) then bool := true;
        if (y mod L = 0) and ((x - 2) mod L = 0) then bool := true;
        if ((x - 1) mod L = 0) and ((y - 1) mod L = 0) then bool := true;
        if (L = 2) and (x mod 2 = 0) then bool := true;
        if (L = 2) and (y mod 2 = 0) then bool := true;
        if bool then writeln('YES') else writeln('NO');
    end;
end.
