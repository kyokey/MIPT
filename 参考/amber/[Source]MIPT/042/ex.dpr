(*
	Problem: MIPT 042 LCS problem
	Author: Amber
	Method: DP(LCS)
	Date: 2005-11-28
*)
program MIPT_042(Input,Output);
const
	MaxLen=1000;
type
	TIndex=Longint;
	TString=array[1..MaxLen]of Char;
	TDP=array[1..MaxLen,1..MaxLen]of Word;
	TPath=array[1..MaxLen,1..MaxLen]of Byte;
var
	N,M:TIndex;
	A,B:TString;
	F:TDP;
	D:TPath;

procedure Print(i,j:TIndex);
begin
	if (i<1) or (j<1) then Exit;
	case D[i,j] of
		0:
		Print(i-1,j);
		1:
		Print(i,j-1);
		2:
		begin
			Print(i-1,j-1);
			Write(A[i]);
		end;
	end;
end;
procedure Main;
var
	i,j:TIndex;
begin
	N:=0;
	while not Eoln do
	begin
		Inc(N);
		Read(A[N])
	end;
	Readln;
	M:=0;
	while not Eoln do
	begin
		Inc(M);
		Read(B[M])
	end;
	FillChar(F,SizeOf(F),0);
	FillChar(D,SizeOf(D),0);
	for i:=1 to M do
		if A[1]=B[i] then 
		begin
			F[1,i]:=1;
			D[1,i]:=2;
		end;
	for i:=1 to N do
		if A[i]=B[1] then
		begin
			F[i,1]:=1;
			D[i,1]:=2;
		end;
	for i:=2 to N do
		for j:=2 to M do
		begin
			if F[i-1,j]>F[i,j-1] then 
			begin
				F[i,j]:=F[i-1,j];
				D[i,j]:=0;
			end
			else 
			begin
				F[i,j]:=F[i,j-1];
				D[i,j]:=1;
			end;
			if (A[i]=B[j]) and (F[i-1,j-1]+1>F[i,j]) then
			begin
				F[i,j]:=F[i-1,j-1]+1;
				D[i,j]:=2;
			end;
		end;
	if F[N,M]=0 then
		Write('Empty')
	else
		Print(N,M);
	Writeln;
end;
begin
	Main;
end.