(*
	Problem: MIPT 059 CD
	Author: Amber
	Method: DFS for 01 knapsack
	Detail: DP isn't used cuz the max weight isn't known.
	Date: 2005-11-28
*)
program MIPT_059(Input,Output);
const
	MaxN=20;
type
	TIndex=Longint;
	TData=array[1..MaxN]of TIndex;
var
	N,M:TIndex;
	D:TData;
	Max:TIndex;
procedure DFS(Depth,Sum:TIndex);
begin
	if Sum>M then Exit;
	if Depth=N+1 then
	begin
		if Sum>Max then Max:=Sum;
		Exit;
	end;
	DFS(Depth+1,Sum+D[Depth]);
	DFS(Depth+1,Sum);
end;
procedure Main;
var
	i:TIndex;
begin
	Read(M);
	Read(N);
	for i:=1 to N do
		Read(D[i]);
	Max:=0;
	DFS(1,0);
	Writeln(Max);
end;
begin
	Main;
end.