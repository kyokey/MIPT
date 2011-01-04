(*
	Problem: MIPT 006 Three Squares
	Author: Amber
	Method: Knapsack DP
	Date: 2005-11-28
*)
program MIPT_006(Input, Output);
const
	MaxN = 10000;
type
	TIndex = Longint;
	TDP = array [0..MaxN] of Boolean;
var
	N: TIndex;
	F: TDP;

procedure Main;
var
	i, j, k: TIndex;
	Count: TIndex;
begin
	Readln(N);
	FillChar(F, SizeOf(F), 0);
	F[0] := true;
	for k := 1 to 3 do
		for i := N downto 1 do
			if not F[i] then
				for j := 1 to Trunc(Sqrt(i)) do
					if F[i - Sqr(j)] then
					begin
						F[i] := true;
						Break;
					end;
	Count := 0;
	for i := 1 to N do
		if not F[i] then
			Inc(Count);
	Writeln(Count);
end;
begin
	Main;
end.
