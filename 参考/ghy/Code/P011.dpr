type
	integer = longint;

var
	ch	: char;
	n	: integer;
    s	: array[1 .. 100000] of char;
    bool	: boolean;

begin
	n := 0; bool := true;
	while not seekeof do begin
    	read(ch);
        if ch in ['<', '(', '[', '{'] then begin
    		n := n + 1;
            s[n] := ch;
        end else
        if ch in ['>', ')', ']', '}'] then 
        	if n = 0 then bool := false else
        	if (ch = ')') and (s[n] <> '(') or
               (ch = ']') and (s[n] <> '[') or
               (ch = '>') and (s[n] <> '<') or
               (ch = '}') and (s[n] <> '{') then bool := false
            else n := n - 1;
    end;
    if n > 0 then bool := false;
    if bool then writeln('YES') else writeln('NO');
end.
