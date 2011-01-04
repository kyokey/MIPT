{$APPTYPE CONSOLE}
{$I+,S+,Q+,R+}
uses math;

const
	eps = 1e-6;

type
	rootType	= record
    	x, y	: extended;
    end;
    realArray	= array[0 .. 4] of extended;
    rootArray	= array[0 .. 4] of rootType;

procedure inc(var i : extended; j : extended);
begin
	i := i + j;
end;

function modulus(var a : rootType) : extended;
begin
	modulus := sqrt(a.x * a.x + a.y * a.y);
end;

function power(i, j : extended) : extended;
begin
	power := exp(ln(i) / j);
end;

procedure process(var coe : realArray; var root : rootArray; dim : integer);
var
	k, d, p, t, y, y1, y2, a, b, c	: extended;
    i		: integer;
    ncoe	: realArray;
    nroot	: rootArray;
begin
	fillchar(root, sizeof(root), 0);
    
	if dim = 1 then root[1].x := - coe[0] / coe[1] else
    if dim = 2 then begin
    	root[1].x := - coe[1] / coe[2] / 2;
        root[2].x := - coe[1] / coe[2] / 2;
        d := coe[1] * coe[1] - 4 * coe[0] * coe[2];
        if d < 0 then begin
        	root[1].y := + sqrt(-d) / coe[2] / 2;
            root[2].y := - sqrt(-d) / coe[2] / 2;
        end else begin
        	inc(root[1].x, + sqrt(d) / coe[2] / 2);
            inc(root[2].x, - sqrt(d) / coe[2] / 2);
        end;
    end else
    if dim = 3 then begin
		a := coe[2] * coe[2] - 3 * coe[3] * coe[1];
        b := coe[2] * coe[1] - 9 * coe[3] * coe[0];
        c := coe[1] * coe[1] - 3 * coe[2] * coe[0];
        if (abs(a) < eps) and (abs(b) < eps) then begin
        	root[1].x := - coe[2] / coe[3] / 3;
            root[2] := root[1];
            root[3] := root[1];
        end else
        if b * b - 4 * a * c > eps then begin
			y1 := a * coe[2] + 3 * coe[3] * (-b + sqrt(b * b - 4 * a * c)) / 2;        	
			y2 := a * coe[2] + 3 * coe[3] * (-b - sqrt(b * b - 4 * a * c)) / 2;
            y1 := power(y1, 1 / 3); y2 := power(y2, 1 / 3);
            root[1].x := (- coe[2] - (y1 + y2)) / 3 / coe[3];
            root[2].x := (- 2 * coe[2] + y1 + y2) / 6 / coe[3];
            root[2].y := sqrt(3) * (y1 - y2) / 6 / coe[3];
            root[3].x := root[2].x;
            root[3].y := -root[2].y;
        end else
        if b * b - 4 * a * c > -eps then begin
        	k := b / a;
        	root[1].x := - coe[2] / coe[3] + k;
            root[2].x := - k / 2;
            root[3].x := - k / 2;
        end else begin
        	t := (2 * a * coe[2] - 3 * coe[3] * b) / 2 / a / sqrt(a);
            p := arccos(t) / 3;
            root[1].x := (- coe[2] - 2 * sqrt(a) * cos(p)) / 3 / coe[3];
            root[2].x := (- coe[2] + sqrt(a) * (cos(p) + sqrt(3) * sin(p))) / 3 / coe[3];
            root[3].x := (- coe[2] + sqrt(a) * (cos(p) - sqrt(3) * sin(p))) / 3 / coe[3];
        end;
    end else begin
    	for i := 0 to 4 do coe[i] := coe[i] / coe[4];
        ncoe[3] := 8;
        ncoe[2] := - 4 * coe[2];
        ncoe[1] := 2 * coe[3] * coe[1] - 8 * coe[0];
        ncoe[0] := coe[0] * (4 * coe[2] - coe[3] * coe[3]) - coe[1] * coe[1];
        process(ncoe, nroot, 3);
        y := nroot[1].x;

        ncoe[2] := 1;
        ncoe[1] := (coe[3] + sqrt(8 * y + coe[3] * coe[3] - 4 * coe[2])) / 2;
        ncoe[0] := y + (coe[3] * y - coe[1]) / sqrt(8 * y + coe[3] * coe[3] - 4 * coe[2]);
        process(ncoe, nroot, 2);
        root[1] := nroot[1]; root[2] := nroot[2];

        ncoe[2] := 1;
        ncoe[1] := (coe[3] - sqrt(8 * y + coe[3] * coe[3] - 4 * coe[2])) / 2;
        ncoe[0] := y - (coe[3] * y - coe[1]) / sqrt(8 * y + coe[3] * coe[3] - 4 * coe[2]);
        process(ncoe, nroot, 2);
        root[3] := nroot[1]; root[4] := nroot[2];
    end;
end;

var
	i, n	: integer;
    bool	: boolean;
    root	: rootArray;
    source	: realArray;

begin
	for i := 4 downto 0 do read(source[i]);

    n := 4;
    while (n > 0) and (abs(source[n]) < eps) do n := n - 1;

    if n = 0 then writeln('NO') else begin
        process(source, root, n);
        bool := true;
        for i := 1 to n do if modulus(root[i]) > 1 then bool := false;
        if bool then writeln('YES') else writeln('NO');
    end;
    readln;
end.

