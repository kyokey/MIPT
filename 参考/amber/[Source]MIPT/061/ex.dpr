(*
	Problem: MIPT 061 Reconstructing permutation
	Author: Amber
	Method: Construct
	Date: 2005-11-28
*)
program MIPT_061(Input,Output);
const
	MaxN=10000;
type
	TIndex=Longint;
	TUsed=array[1..MaxN]of Boolean;
	TPermutation=array[1..MaxN]of TIndex;
var
	N:TIndex;
	P:TPermutation;
	Used:TUsed;
procedure Main;
var
	i,j:TIndex;
	L:TIndex;
begin
	Read(N);
	FillChar(Used,SizeOf(Used),0);
	for i:=1 to N do
	begin
		Read(L);
		j:=N;
		while (L>0)and(j>0) do
		begin
			if not Used[j] then Dec(L);
			Dec(j);
		end;
		while j>0 do
		begin
			if not Used[j] then Break;
			Dec(j);
		end;
		if j=0 then 
		begin
			Writeln(-1);
			Exit;
		end;
		P[i]:=j;
		Used[j]:=true;
	end;
	Write(P[1]);
	for i:=2 to N do
		Write(' ',P[i]);
	Writeln;
end;
begin
	Main;
end.