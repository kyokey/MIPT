(*
	Problem: MIPT 057 Hacker's attack
	Author: Amber
	Method: Brute Force Search
	Date: 2006-9-29
*)
program MIPT_057(Input, Output);
const
	MaxN = 24;
type
	TIndex = Longint;
	TOverflow = Int64;
var
	Finished: Boolean;
	A, B, C: TIndex;
	A1, B1, C1: TIndex;

procedure DFS(Depth: TIndex);
var
	i, j, k: TIndex;
	Mask: TIndex;
begin
	if Depth = 24 then
	begin
		Finished := true;
		Exit;
	end;
	Mask := 2 shl Depth - 1;
	for i := 1 to 2 do
	begin
		for j := 1 to 2 do
		begin
			for k := 1 to 2 do
			begin
				if ((A1 xor A) and Mask = (TOverflow(B) * C) and Mask) and
				   ((B1 xor B) and Mask = (TOverflow(A) * C) and Mask) and
				   ((C1 xor C) and Mask = (TOverflow(A) * B) and Mask) then
					DFS(Depth + 1);
				if Finished then Exit;
				C := C xor (1 shl Depth);
			end;
			B := B xor (1 shl Depth);
		end;
		A := A xor (1 shl Depth);
	end;
end;
procedure Main;
begin
	Readln(A1, B1, C1);
	Finished := false;
	DFS(0);
	if Finished then
		Writeln(A, ' ',B, ' ',C)
	else
		Writeln(-1, ' ',-1, ' ',-1);
end;
begin
	Main;
end.