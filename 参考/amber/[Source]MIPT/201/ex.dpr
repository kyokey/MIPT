(*
	Problem: MIPT 201 Number of solutions
	Author: Amber
	Method: DP
	Detail:
		Generating function:
		F(x)=(1+x+x^2+x^3+...)*(1+x^2+x^4+x^6+...)
		*(1+x^3+x^6+x^9+...)*(1+x^4+x^8+x^12+...)
	Date: 2005-11-28
*)
program MIPT_201(Input,Output);
const
	MaxN=1000;
type
	TIndex=Longint;
	TDP=array[0..MaxN]of TIndex;
var
	N:TIndex;
	F:TDP;
procedure Main;
var
	i,j:TIndex;
begin
	Readln(N);
	FillChar(F,SizeOf(F),0);
	F[0]:=1;
	for i:=1 to 4 do
		for j:=i to N do
			Inc(F[j],F[j-i]);
	Writeln(F[N]);
end;
begin
	Main;
end.