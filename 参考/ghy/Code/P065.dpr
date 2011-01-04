{$APPTYPE CONSOLE}
var
	i, n	: longint;
    f, a, b, c	: array[0 .. 6000] of longint;

begin
	readln(n); f[0] := 0;
    for i := 1 to n do readln(a[i], b[i], c[i]);
    for i := 1 to n do begin
    	f[i] := f[i - 1] + a[i];
        if (i > 1) and (f[i - 2] + b[i - 1] < f[i]) then f[i] := f[i - 2] + b[i - 1];  
        if (i > 2) and (f[i - 3] + c[i - 2] < f[i]) then f[i] := f[i - 3] + c[i - 2];  
    end;
    writeln(f[n]);
end.
