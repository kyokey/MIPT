program _P003;

const
	maxn = 200;

var
	n, m, i, j, last	: longint;
    a					: array[1 .. maxn, 1 .. maxn] of boolean;
    b					: array[1 .. maxn] of longint;
    used				: array[1 .. maxn] of boolean;
    ch					: char; 

begin
	readln(n);
    for i := 1 to n do begin
    	for j := 1 to i - 1 do begin
        	read(ch);
            a[i][j] := ch = '+';
            a[j][i] := not a[i][j];
        end;
        readln;
    end;

    fillchar(used, sizeof(used), 0);
    m := 1; b[1] := 1; used[1] := true;
    while m < n do begin
    	last := m;
    	for i := 1 to n do if not used[i] and a[b[m]][i] then begin
        	used[i] := true;
            inc(m); b[m] := i;
        end;
        
        for i := 1 to n do if not used[i] and a[i][b[1]] then begin
        	used[i] := true;
        	move(b[1], b[2], m * 4); b[1] := i; m := m + 1;
        end;
        
        if last = m then
        	for i := 1 to n do if not used[i] then begin
            	used[i] := true;
            	for j := 1 to m - 1 do if a[b[j]][i] and a[i][b[j + 1]] then begin
                	move(b[j + 1], b[j + 2], (m - j) * 4);
                    b[j + 1] := i; m := m + 1;
                    break;
                end;
            end;
    end;
    for i := 1 to n do write(b[i], ' '); writeln;
end.
