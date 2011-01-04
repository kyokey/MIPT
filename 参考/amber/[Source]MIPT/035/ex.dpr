(*
	Problem: MIPT 035 Camelot
	Author: Amber
	Method: BFS + SPFA + Enumerate
	Complexity: O(M * N^2)
	Notice: WA 1 times cuz of M = 0.
	Date: 2006-10-5
*)
program MIPT_035(Input, Output);
const
	MaxN = 50;
	MaxM = 100;
	QueueSize = MaxN * MaxN * 2;
type
	TIndex = Longint;
	TPoint = record
		x, y: TIndex;
	end;
	TUsed = array [1..MaxN, 1..MaxN] of Boolean;
	TDist = array [1..MaxN, 1..MaxN] of TIndex;
	TQueue = array [1..QueueSize] of TPoint;
const
	Step: array [1..8] of TPoint = ((x: -2; y: -1), (x: -2; y: 1), (x: 2; y: -1), (x: 2; y: 1), 
	                                (x: -1; y: -2), (x: -1; y: 2), (x: 1; y: -2), (x: 1; y: 2));
var
	N, M: TIndex;
	Knight, King: TPoint;
	Used: TUsed;
	Dist: TDist;
	Queue: TQueue;
	CurDist, SumDist, MinDist: TDist;
	
function Update(var A: TIndex; const B: TIndex): Boolean;
begin
	Result := false;
	if (A = -1) or (A > B) then
	begin
		A := B;
		Result := true;
	end;
end;
function CreatePoint(const x, y: TIndex): TPoint;
begin
	Result.x := x;
	Result.y := y;
end;
function Max(const A, B: TIndex): TIndex;
begin
	if A > B then
		Result := A
	else
		Result := B;
end;
function GetKingDist(const Start, Target: TPoint): TIndex;
begin
	Result := Max(Abs(Start.x - Target.x), Abs(Start.y - Target.y));
end;
function Transfer(const Start: TPoint; var Target: TPoint; Direction: TIndex): Boolean;
begin
	Target.x := Start.x + Step[Direction].x;
	Target.y := Start.y + Step[Direction].y;
	Result := (1 <= Target.x) and (Target.x <= N) and (1 <= Target.y) and (Target.y <= N);
end;
procedure BFS;
var
	Pop, Push: TIndex;
	Direction: TIndex;
	Start, Target: TPoint;
begin
	FillChar(Dist, SizeOf(Dist), 255);
	Start := Knight;
	Pop := 1;
	Push := 2;
	Queue[1] := Start;
	Dist[Start.x, Start.y] := 0;
	while Pop < Push do
	begin
		Start := Queue[Pop];
		Inc(Pop);
		for Direction := 1 to 8 do
			if Transfer(Start, Target, Direction) and Update(Dist[Target.x, Target.y], Dist[Start.x, Start.y] + 1) then
			begin
				Queue[Push] := Target;
				Inc(Push);
			end;
	end;
end;
procedure SPFA;
var
	i, j: TIndex;
	Pop, Push: TIndex;
	Direction: TIndex;
	Start, Target: TPoint;
begin
	FillChar(Used, SizeOf(Used), true);
	Pop := 1;
	Push := 1;
	for i := 1 to N do
		for j := 1 to N do
		begin
			Queue[Push] := CreatePoint(i, j);
			Inc(Push);
		end;
	while Pop <> Push do
	begin
		Start := Queue[Pop];
		Inc(Pop);
		if Pop = QueueSize + 1 then Pop := 1;
		for Direction := 1 to 8 do
			if Transfer(Start, Target, Direction) and Update(Dist[Target.x, Target.y], Dist[Start.x, Start.y] + 1) then
				if not Used[Target.x, Target.y] then
				begin
					Used[Target.x, Target.y] := true;
					Queue[Push] := Target;
					Inc(Push);
					if Push = QueueSize + 1 then Push := 1;
				end;
		Used[Start.x, Start.y] := false;
	end;
end;
procedure Main;
var
	i, j: TIndex;
	Answer: TIndex;
begin
	FillChar(MinDist, SizeOf(MinDist), 255);
	FillChar(SumDist, SizeOf(SumDist), 0);
	Readln(N, M);
	if M = 0 then
	begin
		Writeln(0);
		Exit;
	end;
	Readln(King.x, King.y);
	while M > 0 do
	begin
		Dec(M);
		Readln(Knight.x, Knight.y);
		BFS;
		CurDist := Dist;
		for i := 1 to N do
			for j := 1 to N do
				Inc(Dist[i, j], GetKingDist(King, CreatePoint(i, j)));
		SPFA;
		for i := 1 to N do
			for j := 1 to N do
			begin
				Inc(SumDist[i, j], CurDist[i, j]);
				Update(MinDist[i, j], Dist[i, j] - CurDist[i, j]);
			end;
	end;
	Answer := -1;
	for i := 1 to N do
		for j := 1 to N do
			Update(Answer, SumDist[i, j] + MinDist[i, j]);
	Writeln(Answer);
end;
begin
	Main;
end.