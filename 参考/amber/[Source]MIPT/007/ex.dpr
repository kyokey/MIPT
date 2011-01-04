(*
	Problem: MIPT 007 Space zoo
	Author: Amber
	Method: Enumerate + Greedy
	Complexity: O(N^5)
	Date: 2006-9-27
*)
program MIPT_007(Input, Output);
const
	MaxSize = 20;
	Infinity = 20 * 20 * 20 * 500 * 2;
type
	TIndex = Longint;
	TSum = array [0..MaxSize, 0..MaxSize, 0..MaxSize] of TIndex;
var
	N, M, D: TIndex;
	Sum: TSum;
procedure Main;
var
	i, j, k, x, y: TIndex;
	Max, Cur, Best: TIndex;
begin
	FillChar(Sum, SizeOf(Sum), 0);
	Readln(N, M, D);
	for k := 1 to D do
		for i := 1 to N do
			for j := 1 to M do
			begin
				Read(Sum[k, i, j]);
				Inc(Sum[k, i, j], Sum[k, i - 1, j] + Sum[k, i, j - 1] - Sum[k, i - 1, j - 1]);
			end;
	Max := -Infinity;
	for x := 1 to N do
		for i := x to N do
			for y := 1 to M do
				for j := y to M do
				begin
					Best := 0;
					for k := 1 to D do
					begin
						Cur := Sum[k, i, j] - Sum[k, x - 1, j] - Sum[k, i, y - 1] + Sum[k, x - 1, y - 1];
						Inc(Best, Cur);
						if Max < Best then Max := Best;
						if Best < 0 then Best := 0;
					end;
				end;
	Writeln(Max);
end;
begin
	Main;
end.
