(*
	Problem: MIPT 001 Max of Integers
	Author: Amber
	Method: Trivial
	Notice: WA: Eof -> SeekEof
	Date: 2005-11-28
*)
program MIPT_001(Input,Output);
type
	TData=Longint;

procedure Main;
var
	Key,Max:TData;
begin
	Read(Max);
	while not SeekEof do 
	begin
		Read(Key);
		if Key>Max then Max:=Key;
	end;
	Writeln(Max);
end;
begin
	Main;
end.