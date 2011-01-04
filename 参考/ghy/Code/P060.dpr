const
	maxn = 20000;

type
	integer = longint;

var
	tow, pre	: array[1 .. maxn] of integer;
    x			: array[1 .. maxn] of boolean;
    n, m, s, t	: integer;
    i, j, k, p	: integer;

begin
    fillchar(tow, sizeof(tow), 0);
	fillchar(x, sizeof(x), 0);

	readln(n, m); s := 0; t := 0;
    
    for i := 1 to m do begin
		read(k);
        for j := 1 to k do begin
        	inc(s); read(p); x[p] := true;
            if p <> s then begin
            	tow[p] := s;
                pre[s] := p;
            end;
        end;
        readln;
    end;

    for i := 1 to n do if (pre[i] > 0) and (tow[i] = 0) then begin
    	k := i; inc(t);
        while pre[k] > 0 do begin
        	j := pre[k];
            writeln(j, ' ', k);
            x[k] := true; x[j] := false;
            tow[j] := 0; pre[k] := 0; k := j;
        end;
    end;

    p := 0;
    for i := 1 to n do if not x[i] then p := i;
    
    for i := 1 to n do if tow[i] > 0 then begin
    	writeln(i, ' ', p); inc(t);
        pre[tow[i]] := 0; tow[i] := 0; k := i;
        while pre[k] > 0 do begin
			j := pre[k];
            writeln(j, ' ', k);
            tow[j] := 0; pre[k] := 0; k := j;        	
        end;
        writeln(p, ' ', k);
    end;

    if t = 0 then writeln('No optimization needed');
end.
