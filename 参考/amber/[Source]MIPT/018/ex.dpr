(*
	Problem: MIPT 018 What is the number?
	Author: Amber
	Method: Maths
	Date: 2005-11-28
*)
program MIPT_018(Input,Output);
type
	TIndex=Longint;
var
	N:TIndex;
function GCD(A,B:TIndex):TIndex;
var
	R:TIndex;
begin
	while B>0 do
	begin
		R:=A mod B;
		A:=B;
		B:=R;
	end;
	Result:=A;
end;
procedure Main;
var
	i,j:TIndex;
	Count:TIndex;
begin
	Readln(N);
	Count:=0;
	for i:=2 to N do
		for j:=1 to i-1 do
			if GCD(i,j)=1 then 
				Inc(Count);
	i:=0;
	while Count>1 shl i do Inc(i);
	Writeln(i);
end;
begin
	Main;
end.