(*
	Problem: MIPT 033 Triangles
	Author: Amber
	Method: Topological Sort
	Date: 2006-9-21
*)
program MIPT_033(Input, Output);
const
	MaxN = 50;
type
	TIndex = Longint;
	TGraph = array [1..MaxN * MaxN, 1..MaxN * MaxN] of Boolean;
	TQueue = array [1..MaxN * MaxN] of TIndex;
	TDegree = array [1..MaxN * MaxN] of TIndex;
	TSolution = array [1..MaxN * MaxN] of TIndex;
var
	N: TIndex;
	Graph: TGraph;
	Pop, Push: TIndex;
	Queue: TQueue;
	Degree: TDegree;
	Solution: TSolution;

procedure AddEdge(i, j: TIndex; Ch: Char);
begin
	if Ch = '<' then
	begin
		Graph[i, j] := true;
		Inc(Degree[j]);
	end
	else
	begin
		Graph[j, i] := true;
		Inc(Degree[i]);
	end;
end;
procedure Main;
var
	i, j: TIndex;
	Ch: Char;
begin
	FillChar(Degree, SizeOf(Degree), 0);
	FillChar(Graph, SizeOf(Graph), 0);
	Readln(N);
	for i := 1 to N - 1 do
	begin
		for j := 1 to i do
		begin
			Read(Ch);
			AddEdge(Sqr(i - 1) + j * 2 - 1, Sqr(i) + j * 2, Ch);
		end;
		Readln;
		for j := 1 to i * 2 do
		begin
			Read(Ch);
			AddEdge(Sqr(i) + j, Sqr(i) + j + 1, Ch);
		end;
		Readln;
	end;
	
	Pop := 1;
	Push := 1;
	for i := 1 to Sqr(N) do
		if Degree[i] = 0 then
		begin
			Queue[Push] := i;
			Inc(Push);
		end;
	while Pop < Push do
	begin
		i := Queue[Pop];
		Solution[i] := Pop;
		for j := 1 to Sqr(N) do
			if Graph[i, j] then
			begin
				Dec(Degree[j]);
				if Degree[j] =0 then
				begin
					Queue[Push] := j;
					Inc(Push);
				end;
			end;
		Inc(Pop);
	end;
	if Pop - 1 <> Sqr(N) then
	begin
		Writeln(0);
		Exit;
	end;
	Writeln(1);
	for i := 1 to N do
	begin
		for j := 1 to i * 2 - 1 do
			Write(Solution[Sqr(i - 1) + j], ' ');
		Writeln;
	end;
end;
begin
	Main;
end.