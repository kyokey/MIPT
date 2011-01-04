type
	integer = longint;
	cube = array[1 .. 6] of integer;

var
	a, b		: cube;
    i, level	: integer;

procedure down(var a : cube);
var
	p	: integer;
begin
	p := a[1]; a[1] := a[3]; a[3] := a[5]; a[5] := a[6]; a[6] := p;
end;

procedure rotate(var a : cube);
var
	p	: integer;
begin
	p := a[2]; a[2] := a[3]; a[3] := a[4]; a[4] := a[6]; a[6] := p;
end;

function compare : boolean;
var
	i		: integer;
begin
	compare := false;
	for i := 1 to 6 do if a[i] <> b[i] then exit;
    compare := true;
end;

begin
	assign(input, 'P036.in'); assign(output, 'P036.out');
    reset(input); rewrite(output);
	for i := 1 to 6 do read(a[i]);
    for i := 1 to 6 do read(b[i]);

    level := 0;
	for i := 1 to 1000 do begin
    	case random(2) of
			0 : rotate(a);
        	1 : down(a);
        end;
        if compare then level := 1;
    end;

    i := a[2]; a[2] := a[4]; a[4] := i;
	for i := 1 to 1000 do begin
    	case random(2) of
			0 : rotate(a);
        	1 : down(a);
        end;
        if compare and (level = 0) then level := 2;
    end;

    writeln(level);
    close(input); close(output);
end.

