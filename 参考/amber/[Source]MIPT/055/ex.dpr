(*
	Problem: MIPT 055 Trip abroad
	Author: Amber
	Method: Dijkstra + Enumerate
	Date: 2006-9-20
*)
program MIPT_055(Input, Output);
const
	MaxN = 300;
	Infinity = 100000000;
type
	TIndex = Longint;
	TData = Extended;
	TPoint = record
		x, y: TData;
	end;
	TPointSet = array [1..MaxN] of TPoint;
	TUsed = array [1..MaxN] of Boolean;
	TDist = array [1..MaxN] of TData;
	TGraph = array [1..MaxN, 1..MaxN] of TData;
var
	N: TIndex;
	R: TData;
	P: TPointSet;
	Graph: TGraph;
	Used: TUsed;
	Dist: TDist;
	DistA, DistB: TDist;

function GetDistance(const A, B: TPoint): TData;
begin
	Result := Sqrt(Sqr(A.x - B.x) + Sqr(A.y - B.y));
end;
procedure Dijkstra(Start: TIndex);
var
	i, j: TIndex;
	Min: TData;
begin
	FillChar(Used, SizeOf(Used), 0);
	for i := 1 to N do
		Dist[i] := Infinity;
	Dist[Start] := 0;
	while true do
	begin
		Min := Infinity;
		i := 0;
		for j := 1 to N do
			if not Used[j] and (Min > Dist[j]) then
			begin
				Min := Dist[j];
				i := j;
			end;
		if i = 0 then Break;
		Used[i] := true;
		for j := 1 to N do
			if not Used[j] and (Dist[j] > Min + Graph[i, j]) then
				Dist[j] := Min + Graph[i, j];
	end;
end;
procedure Main;
var
	i, j: TIndex;
	Min: TData;
begin
	Readln(N);
	Readln(R);
	for i := 1 to N do
		with P[i] do
			Readln(x, y);
	for i := 1 to N do
		for j := 1 to N do
			if (i <> j) and (GetDistance(P[i], P[j]) <= R) then
				Graph[i, j] := GetDistance(P[i], P[j])
			else
				Graph[i, j] := Infinity;

	Dijkstra(1);
	DistA := Dist;
	Dijkstra(2);
	DistB := Dist;

	Min := Infinity;
	for i := 1 to N do
		if P[i].x < 0 then
			if Min > DistA[i] + DistB[i] then
				Min := DistA[i] + DistB[i];
	Writeln(Min: 0: 3);
end;
begin
	Main;
end.
