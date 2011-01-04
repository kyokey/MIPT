(*
	Problem: MIPT 056 Best segmentation
	Author: Amber
	Method: Set-DP
	Complexity: O(2^N * N)
	Date: 2006-9-18
*)
program MIPT_056(Input, Output);
const
	MaxN = 20;
	Infinity = 10000000;
type
	TIndex = Longint;
	TData = Extended;
	TPoint = record
		x, y: TData;
	end;
	TPointSet = array [1..MaxN] of TPoint;
	TDP = array [0..1 shl MaxN - 1] of TData;
var
	N: TIndex;
	P: TPointSet;
	F: TDP;

function GetDistance(const A, B: TPoint): TData;
begin
	Result := Sqrt(Sqr(A.x - B.x) + Sqr(A.y - B.y));
end;
procedure Update(var A: TData; const B: TData);
begin
	if A > B then A := B;
end;
procedure Main;
var
	i, j, k: TIndex;
	Parity: Boolean;
begin
	Readln(N);
	for i := 1 to N do
		with P[i] do
			Readln(x, y);
	F[0] := 0;
	for i := 1 to 1 shl N - 1 do
	begin
		F[i] := Infinity;
		Parity := false;
		j := 0;
		for k := 1 to N do
			if i and (1 shl (k - 1)) > 0 then
			begin
				Parity := not Parity;
				j := k;
			end;
		if Parity then Continue;
		for k := 1 to j - 1 do
			if i and (1 shl (k - 1)) > 0 then
				Update(F[i], F[i xor (1 shl (k - 1)) xor (1 shl (j - 1))] + GetDistance(P[j], P[k]));
	end;
	Writeln(F[1 shl N - 1]: 0: 3);
end;
begin
	Main;
end.