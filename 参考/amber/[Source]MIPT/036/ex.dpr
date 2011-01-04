(*
	Problem: MIPT 036 Two cubes
	Author: Amber
	Method: Enumerate
	Date: 2006-9-30
*)
program MIPT_036(Input, Output);
type
	TIndex = Longint;
	TCube = array [1..6] of TIndex;
const
	Forward = 1;
	Backward = 2;
	Left = 3;
	Right = 4;
	Top = 5;
	Bottom = 6;

	CubeTypeNum = 24;
	CubeType: array [1..CubeTypeNum] of TCube =
	(
		(1, 2, 3, 4, 5, 6),
		(1, 2, 5, 6, 4, 3),
		(1, 2, 4, 3, 6, 5),
		(1, 2, 6, 5, 3, 4),

		(2, 1, 4, 3, 5, 6),
		(2, 1, 5, 6, 3, 4),
		(2, 1, 3, 4, 6, 5),
		(2, 1, 6, 5, 4, 3),

		(3, 4, 2, 1, 5, 6),
		(3, 4, 5, 6, 1, 2),
		(3, 4, 1, 2, 6, 5),
		(3, 4, 6, 5, 2, 1),

		(4, 3, 1, 2, 5, 6),
		(4, 3, 5, 6, 2, 1),
		(4, 3, 2, 1, 6, 5),
		(4, 3, 6, 5, 1, 2),

		(5, 6, 1, 2, 3, 4),
		(5, 6, 3, 4, 2, 1),
		(5, 6, 2, 1, 4, 3),
		(5, 6, 4, 3, 1, 2),

		(6, 5, 2, 1, 3, 4),
		(6, 5, 3, 4, 1, 2),
		(6, 5, 1, 2, 4, 3),
		(6, 5, 4, 3, 2, 1)
	);
var
	A, B: TCube;
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
	i, j, k: TIndex;
	IsEqual: Boolean;
begin
	Read(A[Backward], A[Left], A[Top], A[Right], A[Forward], A[Bottom]);
	Read(B[Backward], B[Left], B[Top], B[Right], B[Forward], B[Bottom]);
	for k := 1 to 2 do
	begin
		for i := 1 to CubeTypeNum do
		begin
			IsEqual := true;
			for j := 1 to 6 do
				if A[CubeType[i][j]] <> B[j] then
				begin
					IsEqual := false;
					Break;
				end;
			if IsEqual then
			begin
				Writeln(k);
				Exit;
			end;
		end;
		Swap(A[Left], A[Right]);
	end;
	Writeln(0);
end;
begin
	Main;
end.
