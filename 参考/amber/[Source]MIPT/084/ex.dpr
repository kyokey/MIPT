(*
	Problem: MIPT 084 Farthest points
	Author: Amber
	Method: Geometry
	Detail: Graham + Scan
	Complexity: O(NlogN)
	Date: 2006-9-19
*)
program MIPT_084(Input, Output);
const
	MaxN = 50000;
type
	TIndex = Longint;
	TData = Extended;
	TPoint = record
		x, y: TData;
	end;
	TPointSet = array [1..MaxN + 1] of TPoint;
	TStack = array [1..MaxN + 1] of TIndex;
var
	N: TIndex;
	P, Q: TPointSet;
	Limit, Top: TIndex;
	Stack: TStack;

function GetDistance(const A, B: TPoint): TData;
begin
	Result := Sqrt(Sqr(A.x - B.x) + Sqr(A.y - B.y));
end;
function Det(const A, B, C: TPoint): TData;
begin
	Result := (B.x - A.x) * (C.y - A.y) - (B.y - A.y) * (C.x - A.x);
end;
function Compare(const A, B: TPoint): TData;
begin
	Result := A.y - B.y;
	if Result = 0 then Result := A.x - B.x;
end;
procedure QuickSort(l, r: TIndex);
var
	i, j: TIndex;
	Mid, Tmp: TPoint;
begin
	i := l;
	j := r;
	Mid := P[(i + j) shr 1];
	repeat
		while Compare(P[i], Mid) < 0 do Inc(i);
		while Compare(P[j], Mid) > 0 do Dec(j);
		if i <= j then
		begin
			Tmp := P[i];
			P[i] := P[j];
			P[j] := Tmp;
			Inc(i);
			Dec(j);
		end;
	until i > j;
	if l < j then QuickSort(l, j);
	if i < r then QuickSort(i, r);
end;
procedure Scan(i: TIndex);
begin
	while (Top > Limit) and (Det(P[Stack[Top - 1]], P[Stack[Top]], P[i]) <= 0) do
		Dec(Top);
	Inc(Top);
	Stack[Top] := i;
end;
procedure Graham;
var
	i: TIndex;
begin
	QuickSort(1, N);
	Top := 0;
	Limit := 1;
	for i := 1 to N do
		Scan(i);
	Limit := Top;
	for i := N - 1 downto 1 do
		Scan(i);
	for i := 1 to Top do
		Q[i] := P[Stack[i]];
	P := Q;
	N := Top - 1;
end;
procedure Main;
var
	i, j: TIndex;
	Max: TData;
begin
	Readln(N);
	for i := 1 to N do
		Readln(P[i].x, P[i].y);
	Graham;

	Max := 0;
	j := 2;
	for i := 1 to N do
	begin
		while GetDistance(P[i], P[j]) <= GetDistance(P[i], P[j + 1]) do
		begin
			Inc(j);
			if j = N + 1 then j := 1;
		end;
		if Max < GetDistance(P[i], P[j]) then Max := GetDistance(P[i], P[j]);
	end;
	Writeln(Max: 0: 7);
end;
begin
	Main;
end.