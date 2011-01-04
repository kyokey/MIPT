var
	a	: array[-1 .. 1000000] of byte;
    i, p, cnt	: longint;

begin
	fillchar(a, sizeof(a), 0);
    repeat read(p); a[p] := a[p] or 1; until p < 0;
    repeat read(p); a[p] := a[p] or 2; until p < 0;
    cnt := 0;
    for i := 1 to 1000000 do if a[i] = 3 then begin write(i, ' '); inc(cnt); end;
    if cnt = 0 then write('empty');
    writeln;
end.