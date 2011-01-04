var
	a, b	: longint;

begin
	a := -maxlongint;
	while not seekeof do begin
    	read(b);
        if b > a then a := b;
    end;
    writeln(a); 
end.
