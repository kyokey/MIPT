const
	maxn = 10000;

type
	integer = longint;

var
	expression	: array[1 .. maxn] of ansistring;
    names		: array[1 .. maxn] of ansistring;
    x, state	: array[1 .. maxn] of integer;
    m			: integer;
    digit		: ansistring;

function find(id : ansistring) : integer;
var
	i	: integer;
begin
	for i := 1 to m do if names[i] = id then begin
    	find := i;
        exit;
    end;
    find := 0;
end;

function compute(k : integer) : integer;

	function calc(st : ansistring) : integer;
    var
    	i, ope, j, s, res, multi	: integer;
    begin
    	i := 1; calc := maxlongint;
        res := 0; ope := 0; multi := 1;
        while i <= length(st) do begin
        	if st[i] in ['+', '-', '*'] then begin
            	if ope < 0 then begin
            		if st[i] = '+' then ope := 1;
                	if st[i] = '-' then ope := 2;
                	if st[i] = '*' then ope := 3;
                end else multi := -1;
                i := i + 1;
            	continue;
            end;
            s := 0;
        	if st[i] = '(' then begin
				s := 1; j := i;
                repeat
                	j := j + 1;
                	if st[j] = ')' then s := s - 1;
                    if st[j] = '(' then s := s + 1;
                until s = 0;
                s := calc(copy(st, i + 1, j - i - 1));
                if s = maxlongint then exit;
                i := j + 1;
            end;
            if (st[i] <= '9') and (st[i] >= '0') then begin
            	digit := '';
                while (i <= length(st)) and (st[i] <= '9') and (st[i] >= '0') do begin
                	digit := digit + st[i];
                    i := i + 1;
                end;
                val(digit, s, j);
            end;
            if (st[i] <= 'z') and (st[i] >= 'a') or (st[i] <= 'Z') and (st[i] >= 'A') then begin
            	digit := '';
                while (i <= length(st)) and (st[i] <= 'z') and (st[i] >= 'a') or (st[i] <= 'Z') and (st[i] >= 'A') do begin
                	digit := digit + st[i];
                    i := i + 1;
                end;
                s := compute(find(digit));
            end;
            if s = maxlongint then exit;
            s := s * multi;
            if ope = 0 then res := s;
            if ope = 1 then res := res + s;
            if ope = 2 then res := res - s;
            if ope = 3 then res := res * s;
            ope := -1; multi := 1;
        end;
        calc := res;
    end;

begin
	compute := maxlongint;
    if k = 0 then exit;
	if state[k] = 2 then begin compute := x[k]; exit; end;
    if state[k] = 1 then exit;  
    state[k] := 1;
    x[k] := calc(expression[k]); compute := x[k];
    if x[k] = maxlongint then exit;
    state[k] := 2;
end;

var
	n, k	: integer;
    id		: ansistring;
    ch		: char;

begin
	readln(n); m := 0;
    while n > 0 do begin
    	id := ''; n := n - 1;
    	repeat
			read(ch);
            if ch = ':' then break;
            id := id + ch;
        until seekeoln;

        if seekeoln then begin 
        	k := compute(find(id));
            if k = maxlongint then writeln('error') else writeln(k);
            readln;
        end else begin
 			read(ch); if ch <> '=' then writeln('error');
            m := m + 1; names[m] := id; state[m] := 0;
            readln(expression[m]);
        end;
    end;
end.
