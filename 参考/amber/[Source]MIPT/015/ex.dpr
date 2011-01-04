(*
	Problem: MIPT 015 One rectangle
	Author: Amber
	Method: Sort + Scan
	Complexity: O(NlogN + N)
	Date: 2006-9-30
*)
program MIPT_015(Input, Output);
const
	MaxN = 100;
	W = 100;
	H = 100;
type
	TIndex = Longint;
	TPoint = record
		x, y: TIndex;
	end;
	TPointSet = array [1..MaxN] of TPoint;
	FCompare = function (const A, B: TPoint): TIndex;
var
	N: TIndex;
	P: TPointSet;

function XComparer(const A, B: TPoint): TIndex;
begin
	Result := A.x - B.x;
end;
function YComparer(const A, B: TPoint): TIndex;
begin
	Result := A.y - B.y;
end;
procedure QuickSort(const l, r: TIndex; const Compare: FCompare);
var
	i, j: TIndex;
	Mid, Tmp: TPoint;
begin
	i := l;
	j := r;
	Mid := P[(i + j) div 2];
	repeat
		while Compare(P[i], Mid) < 0 do Inc(i);
		while Compare(Mid, P[j]) < 0 do Dec(j);
		if i <= j then
		begin
			Tmp := P[i];
			P[i] := P[j];
			P[j] := Tmp;
			Inc(i);
			Dec(j);
		end;
	until i > j;
	if l < j then QuickSort(l, j, Compare);
	if i < r then QuickSort(i, r, Compare);
end;
procedure Update(var A: TIndex; B: TIndex);
begin
	if A < B then A := B;
end;
procedure Main;
var
	i, j: TIndex;
	Left, Right: TIndex;
	Max: TIndex;
begin
	Readln(N);
	for i := 1 to N do
		Readln(P[i].x, P[i].y);
	QuickSort(1, N, XComparer);
	Max := 0;
	for i := 1 to N - 1 do
		Update(Max, (P[i + 1].x - P[i].x) * H);
	Update(Max, P[1].x * H);
	Update(Max, (W - P[N].x) * H);
	QuickSort(1, N, YComparer);
	for i := 1 to N do
	begin
		Left := 0;
		Right := W;
		for j := i + 1 to N do
		begin
			if P[j].y = P[i].y then Continue;
			Update(Max, (P[j].y - P[i].y) * (Right - Left));
			if (P[j].x <= P[i].x) and (Left < P[j].x) then Left := P[j].x;
			if (P[j].x >= P[i].x) and (Right > P[j].x) then Right := P[j].x;
		end;
		Update(Max, (H - P[i].y) * (Right - Left));
		Left := 0;
		Right := W;
		for j := i - 1 downto 1 do
		begin
			if P[j].y = P[i].y then Continue;
			Update(Max, (P[i].y - P[j].y) * (Right - Left));
			if (P[j].x <= P[i].x) and (Left < P[j].x) then Left := P[j].x;
			if (P[j].x >= P[i].x) and (Right > P[j].x) then Right := P[j].x;
		end;
		Update(Max, P[i].y * (Right - Left));
	end;
	Writeln(Max);
end;
begin
	Main;
end.