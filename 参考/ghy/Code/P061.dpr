var
	n, i, j		: longint;
    a, b		: array[1 .. 10100] of longint;
    x			: array[1 .. 10100] of boolean;

begin
	read(n);
    for i := 1 to n do read(a[i]); readln;

    fillchar(b, sizeof(b), 0);
    fillchar(x, sizeof(x), 0);
    for i := 1 to n do begin
    	if (a[i] < 0) or (a[i] > n - i) then begin
        	writeln(-1);
            halt;
        end;

        for j := n downto 1 do if not x[j] then begin
        	if a[i] = 0 then begin
            	b[i] := j;
                x[j] := true;
                break;
            end;
            dec(a[i]);
        end;
    end;

    write(b[1]);
    for i := 2 to n do write(' ', b[i]); writeln;
    readln;
end.
