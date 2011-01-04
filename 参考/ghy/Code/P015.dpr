type
	integer = longint;

var
    n, i, j, k, lower	: integer;
    s, answer, temp		: integer;
    x, y				: array[1 .. 100] of integer;
	
begin
	readln(n);
    for i := 1 to n do begin
    	readln(x[i], y[i]);
        j := i;
        while (j > 1) and (x[j] < x[j - 1]) do begin
        	temp := x[j]; x[j] := x[j - 1]; x[j - 1] := temp;
        	temp := y[j]; y[j] := y[j - 1]; y[j - 1] := temp;
            j := j - 1;
        end;
    end;

    answer := 0;
    for i := 0 to 99 do
    	for j := i + 1 to 100 do begin
        	lower := 0;
            for k := 1 to n do if (x[k] > lower) and (y[k] < j) and (y[k] > i) then begin
            	s := (j - i) * (x[k] - lower);
                if s > answer then answer := s;
                lower := x[k];
            end; 
            s := (j - i) * (100 - lower);
            if s > answer then answer := s;
        end;
    writeln(answer);
end.
