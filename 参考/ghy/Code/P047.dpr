const
	maxm = 1000000;

var
	i, n, s, k, j	: longint;
    f				: array[1 .. maxm] of longint;

begin
	readln(n);
    if n = 1 then begin writeln(1); halt; end;
    f[1] := 1; f[2] := 2; k := 1; s := 1;
	for i := 2 to maxm do begin
    	s := s + f[i];
        if s >= n then begin writeln(i); break; end;
        if k < maxm then
            for j := 1 to f[i] do begin
                k := k + 1;
                f[k] := i;
                if k = maxm then break;
            end;
    end;
end.
