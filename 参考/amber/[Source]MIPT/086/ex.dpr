(*
	Problem: MIPT 086 Anti-factorial
	Author: Amber
	Method: Maths with discussion
	Date: 2005-12-14
*)
program MIPT_086(Input,Output);
const
	MaxLen=255;
type
	TIndex=Longint;
	TData=Extended;
procedure Main;
var
	N,L:TIndex;
	S:TData;
	St:String[MaxLen];
begin
	Readln(St);
	L:=Length(St);
	if L=1 then
		if St='1' then N:=1
		else if St='2' then N:=2
		else N:=3 //now St='6'
	else if L=2 then N:=4 //now St='24'
	else if L=3 then
		if St='120' then N:=5
		else N:=6 //now St='720'
	else
	begin
		N:=1;
		S:=1;
		repeat
			Inc(N);
			S:=S*N;
		until Trunc(Ln(S)/Ln(10))+1>=L;
	end;
	Writeln(N);
end;
begin
	Main;
end.