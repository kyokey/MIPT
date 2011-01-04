(*
	Problem: MIPT 013 Boxes
	Author: Amber
	Method: Max Match
	Detail: Minimum Path Covering on DAG
	Date: 2006-9-19
*)
program MIPT_013(Input, Output);
const
	MaxN = 500;
type
	TIndex = Longint;
	TPoint = record
		x, y, z: TIndex;
	end;
	TPointSet = array [1..MaxN] of TPoint;
	TGraph = array [1..MaxN, 1..MaxN] of Boolean;
	TUsed = array [1..MaxN] of Boolean;
	TLink = array [1..MaxN] of TIndex;
var
	N: TIndex;
	P: TPointSet;
	Graph: TGraph;
	Used: TUsed;
	Link: TLink;

function FindPath(i: TIndex): Boolean;
var
	j, k: TIndex;
begin
	Result := true;
	for k := 0 to 1 do
		for j := 1 to N do
			if Graph[i, j] and not Used[j] and ((Link[j] = 0) xor (k = 1)) then
			begin
				Used[j] := true;
				if (Link[j] = 0) or FindPath(Link[j]) then
				begin
					Link[j] := i;
					Exit;
				end;
			end;
	Result := false;
end;
procedure Swap(var A, B: TIndex);
var
	T: TIndex;
begin
	T := A;
	A := B;
	B := T;
end;
procedure Main;
var
	i, j: TIndex;
	Count: TIndex;
begin
	Readln(N);
	for i := 1 to N do
		with P[i] do
		begin
			Readln(x, y, z);
			if x < y then Swap(x, y);
			if x < z then Swap(x, z);
			if y < z then Swap(y, z);
		end;
	for i := 1 to N do
		for j := 1 to N do
			Graph[i, j] := (P[i].x < P[j].x) and (P[i].y < P[j].y) and (P[i].z < P[j].z);

	FillChar(Link, SizeOf(Link), 0);
	Count := 0;
	for i := 1 to N do
	begin
		FillChar(Used, Sizeof(Used), 0);
		if FindPath(i) then Inc(Count);
	end;
	Writeln(N - Count);
end;
begin
	Main;
end.