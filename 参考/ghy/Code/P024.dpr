type
	integer = longint;

var
	st	: array[1 .. 2000] of char;
    n	: integer;

function compute(l, r : integer) : integer;
var
	i, j, s, ope, tot	: integer;
    digit				: string;
begin
	i := l; tot := 0;
    ope := 1;
    while i <= r do begin
    	if st[i] in ['+', '-', '*'] then begin
        	if st[i] = '+' then ope := 1;
            if st[i] = '-' then ope := 2;
            if st[i] = '*' then ope := 3;
            i := i + 1;
            continue;
        end;
    	if st[i] = '(' then begin
        	s := 1; j := i;
            repeat
            	j := j + 1;
                if st[j] = '(' then inc(s);
                if st[j] = ')' then dec(s);
            until s = 0;
            s := compute(i + 1, j - 1);
            i := j + 1;
        end else begin
            digit := '';
            repeat
                if (st[i] < '0') or (st[i] > '9') then break;
                digit := digit + st[i]; i := i + 1;
            until false;
            val(digit, s, j);
        end;
        if ope = 1 then tot := tot + s;
        if ope = 2 then tot := tot - s;
        if ope = 3 then tot := tot * s;
    end;
    compute := tot;
end;

begin
	n := 0;
	while not seekeoln do begin
    	n := n + 1;
        read(st[n]);
    end; readln;
    writeln(compute(1, n));
end.
