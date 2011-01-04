(*
	Problem: MIPT 003 Contest Table
	Author: Amber
	Method: DFS directly
	Date: 2006-9-27
*)
program MIPT_003(Input, Output);
const
	MaxN = 200;
type
	TIndex = Longint;
	TUsed = array [1..MaxN] of Boolean;
	TGraph = array [1..MaxN, 1..MaxN] of Boolean;
var
	N: TIndex;
	Used: TUsed;
	Graph: TGraph;
	Finished: Boolean;

procedure DFS(i: TIndex; Depth: TIndex);
var
	j: TIndex;
begin
	if Depth = N then
	begin
		Finished := true;
		Write(i, ' ');
		Exit;
	end;
	Used[i] := true;
	for j := 1 to N do
		if not Used[j] and Graph[i, j] then
		begin
			DFS(j, Depth + 1);
			if Finished then
			begin
				Write(i, ' ');
				Exit;
			end;
		end;
	Used[i] := false;
end;
procedure Main;
var
	i, j: TIndex;
	Ch: Char;
begin
	Readln(N);
	for i := 1 to N do
	begin
		for j := 1 to i do
		begin
			Read(Ch);
			Graph[i, j] := (Ch = '-');
			Graph[j, i] := (Ch = '+');
		end;
		Readln;
	end;
	
	Finished := false;
	for i := 1 to N do
	begin
		FillChar(Used, SizeOf(Used), 0);
		DFS(i, 1);
		if Finished then Break;
	end;
end;
begin
	Main;
end.
