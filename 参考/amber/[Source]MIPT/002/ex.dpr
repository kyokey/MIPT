(*
	Problem: MIPT 002 Set intersection
	Author: Amber
	Method: Sort two sequences and merge them.
	Notice: WA: Eof -> SeekEof
	Date: 2005-11-28
*)
program MIPT_002(Input,Output);
const
	MaxSize=1000;
type
	TIndex=Longint;
	TData=array[1..MaxSize]of TIndex;
procedure ReadData(var D:TData;var N:TIndex);
begin
	N:=0;
	while true do
	begin
		Inc(N);
		Read(D[N]);
		if D[N]=-1 then Break;
	end;
	Dec(N);
end;
procedure QuickSort(var D:TData;l,r:TIndex);
var
	i,j:TIndex;
	X,Tmp:TIndex;
begin
	i:=l;
	j:=r;
	X:=D[(i+j) div 2];
	repeat
		while D[i]<X do Inc(i);
		while X<D[j] do Dec(j);
		if i<=j then
		begin
			Tmp:=D[i];
			D[i]:=D[j];
			D[j]:=Tmp;
			Inc(i);
			Dec(j);
		end;
	until i>j;
	if l<j then QuickSort(D,l,j);
	if i<r then QuickSort(D,i,r);
end;
procedure MakeUnique(var D:TData;var N:TIndex);
var
	i,j,N_:TIndex;
begin
	N_:=0;
	i:=1;
	while i<=N do
	begin
		j:=i+1;
		while (j<=N) and (D[i]=D[j]) do Inc(j);
		Inc(N_);
		D[N_]:=D[i];
		i:=j;
	end;
	N:=N_;
end;

procedure Main;
var
	i:TIndex;
	PA,PB,NA,NB,NC:TIndex;
	A,B,C:TData;
begin
	ReadData(A,NA);
	ReadData(B,NB);
	QuickSort(A,1,NA);
	MakeUnique(A,NA);
	QuickSort(B,1,NB);
	MakeUnique(B,NB);
	PA:=1;
	PB:=1;
	NC:=0;
	while (PA<=NA) and (PB<=NB) do
		if A[PA]<B[PB] then
			Inc(PA)
		else if A[PA]>B[PB] then
			Inc(PB)
		else 
		begin
			Inc(NC);
			C[NC]:=A[PA];
			Inc(PA);
			Inc(PB);
		end;
	if NC=0 then
		Writeln('empty')
	else
	begin
		Write(C[1]);
		for i:=2 to NC do
			Write(' ',C[i]);
		Writeln;
	end;
end;
begin
	Main;
end.