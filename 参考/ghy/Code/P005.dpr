{$APPTYPE CONSOLE}
var
	m, num, err	: integer;
    st			: string;
    ch			: char;
    s			: array[0 .. 1000] of integer;
    answer		: extended;

begin
	fillchar(s, sizeof(s), 0);
    m := 0;
	while not seekeoln do begin
    	read(ch);
        if ch = ' ' then continue;
        if ch = '(' then m := m + 1 else
        if ch = ')' then m := m - 1 else begin
        	st := '';
        	repeat
            	st := st + ch;
                read(ch);
            until (ch > '9') or (ch < '0');
            val(st, num, err);
            s[m] := s[m] + num;

            if ch = ')' then dec(m); 
        end;
    end;
    answer := 0;
    for num := 1000 downto 0 do answer := answer / 2 + s[num];
    writeln(answer : 0 : 2);
end.
