(*
	Problem: MIPT 202 Pete in love
	Author: Amber
	Method: DP
	Detail:
		Generating function:
		F(x)=Product[1+x^(i)+x^(2*i)+x^(3*i)+...|1<=i<=n]
	Date: 2005-11-28
*)
program MIPT_202(Input,Output);
const
	MaxN=100;
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
	F[0]:=1;
	for i:=1 to N do
		for j:=i to N do
			Inc(F[j],F[j-i]);
	Writeln(F[N]);
end;
begin
	Main;
end.