const
	ope = ['+', '-', '*'];

type
	integer = longint;
    sizeType = record
    	x, y	: integer;
    end;

function max(i, j : integer) : integer;
begin
	if i > j then max := i else max := j;
end;

function findEnd(var st : string; l : integer) : integer;
var
	s, r	: integer;
begin
	s := 1; r := l;
    repeat
    	r := r + 1;
    	if st[r] = '{' then s := s + 1;
        if st[r] = '}' then s := s - 1;
    until s = 0;
    findEnd := r;
end;

function process(st : string) : sizeType;
var
	i, j, x, lower, upper	: integer;
    p, q					: sizeType;
begin
	x := 0; i := 1; lower := 0; upper := 0;
    while i <= length(st) do begin
    	if st[i] = '{' then begin
        	j := findEnd(st, i);
			p := process(copy(st, i + 1, j - i - 1));
            i := j + 2; j := findEnd(st, i);
			q := process(copy(st, i + 1, j - i - 1));
            i := j + 1;
            upper := max(upper, p.y);
            lower := max(lower, q.y);
            x := x + max(p.x, q.x) + 2;
        end;
        while (i <= length(st)) and not (st[i] in ope) do begin
        	x := x + 1; i := i + 1; 
        end;
        if (i <= length(st)) and (st[i] in ope) then inc(x);
        i := i + 1;
    end;
    process.x := x;
    process.y := 1 + lower + upper;
end;

var
	answer	: sizeType;
    st		: string;

begin
	readln(st);
    answer := process(st);
    writeln(answer.x, ' ', answer.y);
end.
