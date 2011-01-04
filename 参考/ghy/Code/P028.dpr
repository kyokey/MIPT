var
	i, j, k, p, q, m	: longint;
    next				: array[1 .. 100] of longint;
    bool				: boolean;

begin
    readln(k);
    for m := k + 1 to maxlongint do begin
        for i := 1 to 2 * k do next[i] := i + 1; next[2 * k] := 1;
        p := 1; q := 2 * k;
        bool := true;
        for i := 1 to k do begin
            for j := 1 to (m - 1) mod (2 * k - i + 1) do begin
                q := p; p := next[p];
            end;
            if p <= k then begin bool := false; break; end;
            next[q] := next[p]; p := next[p];
        end;
        if bool then break;
    end;
    writeln(m);
end.
