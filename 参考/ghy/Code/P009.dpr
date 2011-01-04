const
	modes = 100000000;
    maxl = 8;

type
	integer = longint;
    TDigit = array[0 .. 1000] of integer;

procedure add(var a, b : TDigit);
var
	i	: integer;
begin
	if b[0] > a[0] then a[0] := b[0];
    for i := 1 to a[0] do begin
    	a[i] := a[i] + b[i];
        if a[i] >= modes then begin
        	dec(a[i], modes);
            inc(a[i + 1]);
        end;
    end;
    if a[a[0] + 1] > 0 then inc(a[0]);
end;

procedure print(var a : TDigit);
var
	i	: integer;
    st	: string;
begin
	write(a[a[0]]);
    for i := a[0] - 1 downto 1 do begin
    	str(a[i], st);
        while length(st) < maxl do st := '0' + st;
        write(st);
    end; writeln;
end;

var
	i, n	: integer;
	f, g	: TDigit;    

begin
	readln(n);
    f[0] := 1; f[1] := 1; g[0] := 1; g[1] := 1;
    if n < 2 then writeln(1) else begin
    	for i := 2 to n do
			if odd(i) then add(f, g) else add(g, f);
        if odd(n) then print(f) else print(g);
    end;
end.
