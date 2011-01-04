(*
	Problem: MIPT 105 MRQ problem
	Author: Amber
	Method: RMQ Problem
	Complexity: O(NlogN) - O(1) * M
	Date: 2006-9-21
*)
program MIPT_105(Input, Output);
const
	MaxN = 250000;
	MaxLogN = 17;
type
	TIndex = Longint;
	TData = Single;
	TLog = array [1..MaxN] of TIndex;
	TDP = array [0..MaxN - 1, 0..MaxLogN] of TData;
var
	N, M: TIndex;
	Log2: TLog;
	F: TDP;
function Min(const A, B: TData): TData;
begin
	if A < B then
		Result := A
	else
		Result := B;
end;
procedure Main;
var
	i, j, k: TIndex;
begin
	Read(N);
	
	k := 0;
	for i := 1 to N do
	begin
		if 1 shl (k + 1) = i then Inc(k);
		Log2[i] := k;
	end;

	for i := 0 to N - 1 do
		Read(F[i, 0]);
	
	k := Log2[N];
	for j := 1 to k do
		for i := 0 to N - 1 shl j do
			F[i, j] := Min(F[i, j - 1], F[i + 1 shl (j - 1), j - 1]);

	Read(M);
	while M > 0 do
	begin
		Dec(M);
		Read(i, j);
		k := Log2[j - i];
		Writeln(Min(F[i, k], F[j - 1 shl k, k]));
	end;
end;
begin
	Main;
end.
