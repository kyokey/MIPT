(*
	Problem: MIPT 051 Strange Tower
	Author: Amber
	Method: Maths
	Date: 2005-11-28
*)
program MIPT_051(Input,Output);
type
	TData=Int64;
procedure Main;
var
	i,S,N:TData;
begin
	Readln(N);
	S:=0;
	i:=0;
	while S+Sqr(i+1)<N do
	begin
		Inc(i);
		Inc(S,Sqr(i));
	end;
	Writeln((1+i)*i div 2+(N-S-1) div (i+1)+1,' ',(N-S-1) mod (i+1)+1);
end;
begin
	Main;
end.