(*
	Problem: MIPT 028 Circle Game
	Author: Amber
	Method: Const
	Date: 2006-11-28
*)
program MIPT_028(Input,Output);
const
	Answer:array[1..13]of Longint=(2,7,5,30,169,441,1872,7632,1740,93313,459901,1358657,2504881);
procedure Main;
var
	N:Longint;
begin
	Readln(N);
	Writeln(Answer[N]);
end;
begin
	Main;
end.