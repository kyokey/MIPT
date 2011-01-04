(*
	Problem: MIPT 102 Stone Game II -- who is the winner? 
	Author: Amber
	Method: Game Theory
	Detail: Extension of Nim Problem
		From brute force program, we find the value of SG function: 
		0 0 1 0 2 1 3 0 4 2 5 1 6 3 7 0 ...
		Rewrite in list format by the power of two.
		[0]
		[0] 1
		[0] 2 [1] 3
		[0] 4 [2] 5 [1] 6 [3] 7 0
		...
		We find that the odd items of the next row are the numbers of current row,
		and the even items are the numbers from 2^n to 2^(n+1)-1.
	Date: 2006-6-1
*)
program MIPT_102(Input, Output);
const
	MaxTimes = 15;
	MaxValue = 100000;
type
	TIndex = Longint;
	TSG = array [0..MaxValue] of TIndex;
var
	N: TIndex;
	State: TIndex;
	SG: TSG;

procedure PrecalculateSG;
var
	i, j: TIndex;
begin
	SG[0] := 0;
	for i := 0 to MaxTimes do
		for j := 0 to 1 shl i - 1 do
		begin
			if 1 shl (i + 1) - 1 + j shl 1 > MaxValue then Exit;
			SG[1 shl (i + 1) - 1 + j shl 1] := SG[1 shl i - 1 + j];
			if 1 shl (i + 1) + j shl 1 > MaxValue then Exit;
			SG[1 shl (i + 1) + j shl 1] := 1 shl i + j;
		end;
end;
procedure Main;
var
	i: TIndex;
	Cur: TIndex;
begin
	PrecalculateSG;
	Readln(N);
	State := 0;
	for i := 1 to N do
	begin
		Read(Cur);
		State := State xor SG[Cur];
	end;
	if State = 0 then 
		Writeln('Second wins.')
	else
		Writeln('First wins.');
end;
begin
	Main;
end.