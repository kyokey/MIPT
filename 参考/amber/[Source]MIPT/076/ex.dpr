(*
	Problem: MIPT 076 Bracket structure correction
	Author: Amber
	Method: DP
	Date: 2005-11-28
*)
program MIPT_076(Input,Output);
const
	MaxN=1000;
type
	TIndex=Longint;
	TData=array[1..MaxN]of Char;
	TDP=array[1..MaxN,1..MaxN]of TIndex;
var
	N:TIndex;
	D:TData;
	F:TDP;
procedure Main;
var
	i,j,k,l:TIndex;
begin
	N:=0;
	while not Eoln do
	begin
		Inc(N);
		Read(D[N]);
	end;
	if Odd(N) then 
	begin
		Writeln('NO');
		Exit;
	end;
	for i:=1 to N-1 do
		F[i,i+1]:=Ord(D[i]<>'(')+Ord(D[i+1]<>')');
	for l:=2 to N div 2 do
		for i:=1 to N-2*l+1 do
		begin
			j:=i+l*2-1;
			F[i,j]:=Ord(D[i]<>'(')+F[i+1,j-1]+Ord(D[j]<>')');
			for k:=1 to l-1 do
				if F[i,i+k*2-1]+F[i+k*2,j]<F[i,j] then
					F[i,j]:=F[i,i+k*2-1]+F[i+k*2,j];
		end;
	Writeln(F[1,N]);
end;
begin
	Main;
end.