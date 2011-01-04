(*
	Problem: MIPT 100 Nim Game -- Who is the winner?
	Author: Amber
	Method: Game Theory
	Detail: Nim Problem
	Date: 2006-5-31
*)
program MIPT_100(Input, Output);
type
	TIndex = Longint;
var
	N: TIndex;
	State: TIndex;

procedure Main;
var
	i: TIndex;
	Cur: TIndex;
begin
	Readln(N);
	State := 0;
	for i := 1 to N do 
	begin
		Read(Cur);
		State := State xor Cur;
	end;
	if State = 0 then 
		Writeln('Second wins.')
	else
		Writeln('First wins.');
end;
begin
	Main;
end.