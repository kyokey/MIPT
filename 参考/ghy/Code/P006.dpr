var
	i, j, k, n	: integer;
    x			: array[0 .. 10000] of boolean;

begin
	fillchar(x, sizeof(x), 0);
	readln(n);
    for i := 0 to trunc(sqrt(n / 3)) do
    	for j := 0 to trunc(sqrt((n - i * i) / 2)) do
        	for k := 0 to trunc(sqrt(n - i * i - j * j)) do
            	x[i * i + j * j + k * k] := true;
    k := 0;
    for i := 0 to n do if not x[i] then k := k + 1;
    writeln(k);
end.
