(*
	Problem: MIPT 000 Sum of two integers
	Author: Amber
	Method: Trivial
	Date: 2005-11-28
*)
program MIPT_000(Input,Output);
type
	TData=Longint;
var
	A,B:TData;
procedure Main;
begin
	Readln(A,B);
	Writeln(A+B);
end;
begin
	Main;
end.