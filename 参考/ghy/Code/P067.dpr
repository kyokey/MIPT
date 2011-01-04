{$APPTYPE CONSOLE}
var
	i, n, m	: integer;
    a		: array[1 .. 2000] of integer;
    x		: array[1 .. 2000] of integer;

procedure print(m : integer);
var
	i	: integer;
begin
	if m = 1 then begin
    	for i := 1 to n do write(a[i], ' '); writeln;
        exit;
    end;
    for i := 1 to m - 1 do if x[m] mod x[i] = 0 then begin
    	a[x[i]] := x[m];
        print(i);
		a[x[i]] := x[i];        
    end; 
end;

begin
	readln(n); m := 0;
    for i := 1 to n do a[i] := i;
    for i := 1 to n do if (n + 1) mod i = 0 then begin
    	m := m + 1;
        x[m] := i;
    end;
    m := m + 1; x[m] := n + 1;
    print(m);
end.
