(*
	Problem: MIPT 093 What is the number (Part II)?
	Author: Amber
	Method: Filter + Count
	Date: 2006-9-22
*)
program MIPT_093(Input, Output);
const
	MaxN = 2000000;
type
	TIndex = Longint;
	TData = Int64;
	TIsPrime = array [1..MaxN] of Boolean;
	TPhi = array [1..MaxN] of TIndex;
var
	N: TIndex;
	IsPrime: TIsPrime;
	Phi: TPhi;
	Count: TData;

function Log2(X: TData): TData;
begin
	Result := 0;
	while X > TData(1) shl Result do Inc(Result);
end;
procedure Main;
var
	i, j: TIndex;
begin
	Readln(N);
	for i := 1 to N do
	begin
		Phi[i] := i;
		IsPrime[i] := true;
	end;
	for i := 2 to N do
		if IsPrime[i] then
			for j := 1 to N div i do
			begin
				IsPrime[i * j] := false;
				Phi[i * j] := TIndex(TData(Phi[i * j]) * (i - 1) div i);
			end;
	Count := 0;
	for i := 2 to N do
		Inc(Count, Phi[i]);
	Writeln(Log2(Count));
end;
begin
	Main;
end.