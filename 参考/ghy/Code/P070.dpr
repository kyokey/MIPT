{$APPTYPE CONSOLE}
const
	maxn = 2000;

type
	integer = longint;
    Arr		= array[1 .. maxn] of integer;

var
	a, b, c, d, f	: Arr;
    x				: array[1 .. maxn] of boolean;
    n				: integer; 

procedure find(k : integer; var b : Arr);
var
	i, L 	: integer;
begin
	i := k; L := 0;
    repeat
    	L := L + 1;
        b[L] := k;
        k := a[k]; 
    until k = i;
end;

var
	i, j, k, L		: integer;

begin
	readln(n);
    for i := 1 to n do read(a[i]); readln;

    fillchar(x, sizeof(x), 0);
    for i := 1 to n do if not x[i] then begin
    	k := i; L := 0;
        repeat
        	x[k] := true;
            k := a[k];
            L := L + 1;
        until k = i;
        b[i] := L;
    end;

    fillchar(f, sizeof(f), 0);
    for i := 1 to n do if b[i] > 0 then begin
    	find(i, c);
        if odd(b[i]) then begin
        	L := b[i] div 2;
        	for j := 1 to b[i] do f[c[j]] := c[(j + L) mod b[i] + 1];
            b[i] := 0;
        end else begin
        	k := 0;
        	for j := i + 1 to n do if b[j] = b[i] then begin
            	k := j;
                break;
            end;
            if k = 0 then begin
            	writeln(0);
                halt;
            end;
            find(k, d); L := b[i]; c[L + 1] := c[1];
            for j := 1 to L do begin
            	f[c[j]] := d[j];
                f[d[j]] := c[j + 1];
            end;
            b[i] := 0; b[k] := 0;
        end;
    end;
    for i := 1 to n do write(f[i], ' '); writeln;
    readln;
end.
