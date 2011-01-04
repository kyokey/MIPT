{$APPTYPE CONSOLE}
const
	maxn = 500;
	maxl = 7;
    modes = 10000000;

type
	integer = longint;
    TDigit	= array[0 .. 200] of integer;

var
	n, i, j, k, m	: integer;
    c, power		: array[0 .. 500] of TDigit;
    bit, sum		: TDigit;

procedure init(var a : TDigit; k : integer);
begin
	fillchar(a, sizeof(a), 0);
    if k > 0 then begin
    	a[0] := 1; a[1] := k;
    end;
end;

procedure add(var a, b : TDigit);
var
	i	: integer;
begin
	if b[0] > a[0] then a[0] := b[0];
    for i := 1 to a[0] do begin
    	inc(a[i], b[i]);
        if a[i] >= modes then begin
        	dec(a[i], modes);
            inc(a[i + 1]);
        end;
    end;
    if a[a[0] + 1] > 0 then inc(a[0]);
end;

procedure mult(var a : TDigit; k : integer);
var
	i, temp	: integer;
begin
	temp := 0;
	for i := 1 to a[0] do begin
    	a[i] := a[i] * k + temp;
        temp := a[i] div modes;
        a[i] := a[i] - temp * modes; 
    end;
    if temp > 0 then begin inc(a[0]); a[a[0]] := temp; end;
end;

function compare(var a, b : TDigit) : boolean;
var
	i	: integer;
begin
	if a[0] < b[0] then begin compare := true; exit; end else
    if a[0] > b[0] then begin compare := false; exit; end else
    for i := a[0] downto 1 do begin
    	if a[i] < b[i] then begin compare := true; exit; end;
    	if a[i] > b[i] then begin compare := false; exit; end;
    end;
    compare := false;
end;

begin
	readln(n);

    fillchar(c, sizeof(c), 0); init(c[0], 1);
    for i := 1 to n do
        for j := i downto 1 do
        	add(c[j], c[j - 1]);
    init(power[0], 1);
    for i := 1 to n do begin
    	power[i] := power[i - 1];
        mult(power[i], 3);
    end;
	m := 0; init(bit, 1);
    repeat
    	m := m + 1; init(sum, 0); mult(bit, 2);
        for k := n downto 0 do if compare(bit, power[k]) then add(sum, c[k]);
    until compare(sum, bit);
	writeln(m - 1);
end.
