(*
	Problem: MIPT 027 Odd number
	Author: Amber
	Method: Hash and Count
	Detail: Store all the possible numbers
	Date: 2005-11-28
*)
program MIPT_027(Input,Output);
const
	MaxRange=1000000;
type
	TIndex=Longint;
	TState=array[1..MaxRange]of Boolean;
var
	N:TIndex;
	State:TState;
procedure Main;
var
	i:TIndex;
begin
	Read(N);
	while N>0 do
	begin
		Dec(N);
		Read(i);
		State[i]:=not State[i];
	end;
	for i:=1 to MaxRange do
		if State[i] then 
		begin
			Writeln(i);
			Break;
		end;
end;
begin
	Main;
end.