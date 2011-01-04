var
	m	: integer;
    ch	: char;
    bool	: boolean;

begin
	m := 0; bool := true;
	while not seekeoln do begin
    	read(ch);
        if ch = '(' then m := m + 1 else
        if m > 0 then m := m - 1 else bool := false;
    end;
    if m > 0 then bool := false;
    if bool then writeln('YES') else writeln('NO');
end.