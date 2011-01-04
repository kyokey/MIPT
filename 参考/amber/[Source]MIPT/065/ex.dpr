(*
	Problem: MIPT 065 Queue for tickets
	Author: Amber
	Method: DP
	Date: 2005-12-14
*)
program MIPT_065(Input,Output);
const
	MaxN=5000;
	MaxValue=MaxLongint div 16;
type
	TIndex=Longint;
	TDP=array[1..MaxN+1]of TIndex;
var
	N:TIndex;
	F:TDP;
procedure Update(var X:TIndex;Y:TIndex);
begin
	if X>Y then X:=Y;
end;
procedure Main;
var
	i:TIndex;
	A,B,C:TIndex;
begin
	Read(N);
	F[1]:=0;
	for i:=2 to N+1 do
		F[i]:=MaxValue;
	for i:=1 to N do
	begin
		Read(A,B,C);
		if i+1<=N+1 then Update(F[i+1],F[i]+A);
		if i+2<=N+1 then Update(F[i+2],F[i]+B);
		if i+3<=N+1 then Update(F[i+3],F[i]+C);
	end;
	Writeln(F[N+1]);
end;
begin
	Main;
end.