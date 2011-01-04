(*
	Problem: MIPT 102 Stone Game II -- who is the winner? 
	Author: Amber
	Method: Game Theory
	Detail: Extension of Nim Problem
	Version: Brute force for observing the rule of SG.
	Date: 2006-6-1
*)
program MIPT_102(Input, Output);
const
	MaxValue = 1000;
type
	TIndex = Longint;
	TSG = array [0..MaxValue] of TIndex;
	THash = array [0..MaxValue] of Boolean;
var
	N: TIndex;
	State: TIndex;
	SG: TSG;
	Hash: THash;

procedure PrecalculateSG;
var
	i, j: TIndex;
begin
	SG[0] := 0;
	for i := 1 to MaxValue do
	begin
		FillChar(Hash, SizeOf(Hash), 0);
		for j := (i + 1) div 2 to i - 1 do
			Hash[SG[j]] := true;
		j := 0;
		while Hash[j] do Inc(j);
		SG[i] := j;
		Write(j, ' ');
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