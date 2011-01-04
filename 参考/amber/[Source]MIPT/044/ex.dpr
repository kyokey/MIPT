(*
	Problem: MIPT 044 Frame paving
	Author: Amber
	Method: Maths
	Date: 2006-11-28
*)
program MIPT_044(Input,Output);
type
	TIndex=Longint;
procedure Main;
var
	N,X,Y,M:TIndex;
begin
	Readln(X,Y);
	Readln(N);
	while N>0 do
	begin
		Dec(N);
		Read(M);
		if M<=2 then 
			Writeln('YES')
		else if (X mod M<=2) and (Y mod M<=2) and ((X+Y) mod M=2) then 
			Writeln('YES')
		else 
			Writeln('NO');
	end;
end;
begin
	Main;
end.