(*
	Problem: MIPT 101 Stone Game -- who is the winner?
	Author: Amber
	Method: Game Theory
	Detail: Extension of Nim Problem
	Date: 2006-5-31
*)
program MIPT_101(Input, Output);
type
	TIndex = Longint;
var
	N: TIndex;
	State: TIndex;

function ReadNumber: TIndex;
var
	Ch: Char;
	IsNumber: Boolean;
begin
	IsNumber := false;
	Result := 0;
	while not Eof do
	begin
		Read(Ch);
		if Ch in ['0'..'9'] then
		begin
			IsNumber := true;
			Result := (Result + Ord(Ch) - Ord('0')) mod 3;
		end
		else if IsNumber then
			Exit;
	end;
end;
procedure Main;
var
	i: TIndex;
begin
	Readln(N);
	State := 0;
	for i := 1 to N do
		State := State xor (ReadNumber mod 3);
	if State = 0 then
		Writeln('Second wins.')
	else
		Writeln('First wins.');
end;
begin
	Main;
end.