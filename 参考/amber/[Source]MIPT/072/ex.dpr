(*
	Problem: MIPT 072 Chess Cube
	Author: Amber
	Method: Dijkstra
	Complexity: O((24N^2)^2), Here N = 8
	Date: 2006-9-30
*)
program MIPT_072(Input, Output);
const
	N = 8;
	Infinity = MaxLongint div 2;
	CubeTypeNum = 24;
type
	TIndex = Longint;
	TPoint = record
		X, Y, T: TIndex;
	end;
	TDist = array [1..N, 1..N, 1..CubeTypeNum] of TIndex;
	TUsed = array [1..N, 1..N, 1..CubeTypeNum] of Boolean;
	TCube = array [1..6] of TIndex;
const
	//Chessboard at first quadrant
	//Up,Down,Left,Right
	Direct: array [1..4] of TCube =
	(
		(6, 5, 3, 4, 1, 2),
		(5, 6, 3, 4, 2, 1),
		(1, 2, 5, 6, 4, 3),
		(1, 2, 6, 5, 3, 4)
	);
	DirectX: array [1..4] of ShortInt = (0, 0, -1, 1);
	DirectY: array [1..4] of ShortInt = (1, -1, 0, 0);
	//forward, backward, left, right, top, bottom
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
	S, T: TPoint;
	Dist: TDist;
	Used: TUsed;
	Cube: TCube;

function Change(i: TIndex; const Cur: TPoint; var Next: TPoint): Boolean;
var
	NewCube: TCube;
	j, k: TIndex;
	Valid: Boolean;
begin
	Result := false;
	if (Cur.X + DirectX[i] < 1) or (Cur.X + DirectX[i] > N) or 
	   (Cur.Y + DirectY[i] < 1) or (Cur.Y + DirectY[i] > N) then
		Exit;
	Result := true;
	Next.X := Cur.X + DirectX[i];
	Next.Y := Cur.Y + DirectY[i];
	for j := 1 to 6 do
		NewCube[j] := CubeType[Cur.T][Direct[i][j]];
	for j := 1 to CubeTypeNum do
	begin
		Valid := true;
		for k := 1 to 6 do
			Valid := Valid and (CubeType[j][k] = NewCube[k]);
		if Valid then
		begin
			Next.T := j;
			Exit;
		end;
	end;
end;
function GetBottomValue(Cur: TPoint): TIndex;
begin
	GetBottomValue := Cube[CubeType[Cur.T][6]];
end;
procedure Dijkstra;
var
	Cur, Next: TPoint;
	i, j, k: TIndex;
	Min: TIndex;
begin
	FillChar(Used, SizeOf(Used), 0);
	for i := 1 to N do
		for j := 1 to N do
			for k := 1 to CubeTypeNum do
				Dist[i, j, k] := Infinity;
	Dist[S.X, S.Y, S.T] := GetBottomValue(S);
	while true do
	begin
		FillChar(Cur, SizeOf(Cur), 0);
		Min := Infinity;
		for i := 1 to N do
			for j := 1 to N do
				for k := 1 to CubeTypeNum do
					if not Used[i, j, k] and (Dist[i, j, k] < Min) then
						begin
							Min := Dist[i, j, k];
							Cur.X := i;
							Cur.Y := j;
							Cur.T := k;
						end;
		if (Cur.X = 0) and (Cur.Y = 0) and (Cur.T = 0) then Break;
		Used[Cur.X, Cur.Y, Cur.T] := true;
		for i := 1 to 4 do
			if Change(i, Cur, Next) then
				if not Used[Next.X, Next.Y, Next.T] then
					if Min + GetBottomValue(Next) < Dist[Next.X, Next.Y, Next.T] then
						Dist[Next.X, Next.Y, Next.T] := Min + GetBottomValue(Next);
	end;
	Min := Infinity;
	for k := 1 to CubeTypeNum do
		if Used[T.X, T.Y, k] and (Dist[T.X, T.Y, k] < Min) then
				Min := Dist[T.X, T.Y, k];
	Writeln(Min);
end;
procedure Init;
var
	Ch: Char;
begin
	repeat
		Read(Ch);
	until Ch in ['a'..'h'];
	S.X := Ord(Ch) - Ord('a') + 1;
	repeat
		Read(Ch);
	until Ch in ['1'..'8'];
	S.Y := Ord(Ch) - Ord('0');
	S.T := 1;

	repeat
		Read(Ch);
	until Ch in ['a'..'h'];
	T.X := Ord(Ch) - Ord('a') + 1;
	repeat
		Read(Ch);
	until Ch in ['1'..'8'];
	T.Y := Ord(Ch) - Ord('0');

	Readln(Cube[1], Cube[2], Cube[5], Cube[4], Cube[6], Cube[3]);
end;
procedure Main;
begin
	Init;
	Dijkstra;
end;
begin
	Main;
end.

