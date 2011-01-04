program P004;
{$APPTYPE CONSOLE}

type
	integer = longint;

var
	n, i, j, k, sm	: integer;
    m, s			: array[1 .. 1000] of integer;

procedure swap(var i, j : integer);
var
	temp	: integer;
begin
	temp := i; i := j; j := temp;
end;

begin
	readln(n);
    for i := 1 to n do begin
    	readln(m[i], s[i]); j := i;
        while (j > 1) and ((s[j] < s[j - 1]) or (s[j] = s[j - 1]) and (m[j] < m[j - 1])) do begin
        	swap(s[j], s[j - 1]); swap(m[j], m[j - 1]);
            j := j - 1;
        end;
    end;

    sm := 0; k := 0;
    for i := 1 to n do if s[i] >= sm then begin
    	k := k + 1;
        sm := sm + m[i];
    end;
    writeln(k);
end.
