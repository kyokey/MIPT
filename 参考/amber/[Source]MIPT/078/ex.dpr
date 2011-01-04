(*
	Problem: MIPT 078 Next word
	Author: Amber
	Method: Trivial
	Detail: Find Next permutation: find the non-decreasing sequence from last digit.
	Date: 2005-11-28
*)
program MIPT_078(Input,Output);
type
	TIndex=Longint;
procedure Swap(var A,B:Char);
var
	T:Char;
begin
	T:=A;
	A:=B;
	B:=T;
end;
procedure Main;
var
	p,q,i,j:TIndex;
	N:TIndex;
	St:String;
begin
	Readln(St);
	N:=Length(St);
	p:=N;
	if N=1 then 
	begin
		Writeln('no word');
		Exit;
	end;
	while St[p-1]>=St[p] do
	begin
		Dec(p);
		if p=1 then 
		begin
			Writeln('no word');
			Exit;
		end;
	end;
	q:=p;
	for j:=N downto p do
		if St[p-1]<St[j] then
		begin
			q:=j;
			Break;
		end;
	Swap(St[p-1],St[q]);
	for i:=p to N do 
		for j:=i+1 to N do
			if St[i]>St[j] then
				Swap(St[i],St[j]);
	Writeln(St);
end;
begin
	Main;
end.