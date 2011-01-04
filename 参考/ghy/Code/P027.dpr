var
	cnt		: array[1 .. 1000000] of longint;
    n, i, k	: longint;
begin
	fillchar(cnt, sizeof(cnt), 0);
    readln(n);
    for i := 1 to n do begin read(k); inc(cnt[k]); end;
    for i := 1 to 1000000 do if odd(cnt[i]) then writeln(i);
end.