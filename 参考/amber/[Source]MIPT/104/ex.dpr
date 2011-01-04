(*
	Problem: MIPT 104 Camomile Game -- who is the winner?
	Author: Amber
	Method: Game Theory
	Detail: Extension of Nim Problem
	Date: 2006-5-31
*)
program MIPT_104(Input, Output);
const
	MaxValue = 200;
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
		for j := 1 to i do
			Hash[SG[j - 1] xor SG[i - j]] := true;
		for j := 2 to i do
			Hash[SG[j - 2] xor SG[i - j]] := true;
		j := 0;
		while Hash[j] do Inc(j);
		SG[i] := j;
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