{$APPTYPE CONSOLE}
var
	s, n, k	: longint;

begin
	readln(n);
    k := 0; s := 0; 
    repeat
    	k := k + 1;
        if k * k >= n then writeln(s + (n - 1) div k + 1, ' ', (n - 1) mod k + 1);
        n := n - k * k; s := s + k;
    until n <= 0;
    readln;
end.
