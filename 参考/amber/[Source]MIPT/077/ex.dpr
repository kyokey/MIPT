(*
	Problem: MIPT 077 Queens
	Author: Amber
	Method: Const(N Queens)
	Date: 2005-11-28
*)
program MIPT_077(Input,Output);
type
	TIndex=Longint;
const
	Solution:array[1..15]of TIndex=(1,0,0,2,10,4,40,92,352,724,2680,14200,73712,365596,2279184);
var
	N:TIndex;
procedure Main;
begin
	Readln(N);
	Writeln(Solution[N]);
end;
begin
	Main;
end.