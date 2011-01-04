(*
	Problem: MIPT 016 Two rectangles
	Author: Amber
	Method: Enumerate + Sort + Scan
	Complexity: O(N(NlogN + N))
	Date: 2006-9-30
*)
program MIPT_015(Input, Output);
const
	MaxN = 100;
type
	TIndex = Longint;
	TData = Extended;
	TPoint = record
		x, y: TData;
	end;
	TPointSet = array [1..MaxN] of TPoint;
	FCompare = function (const A, B: TPoint): TData;
var
	W, H: TData;
	N, M: TIndex;
	P, Q: TPointSet;

function XComparer(const A, B: TPoint): TData;
begin
	Result := A.x - B.x;
end;
function YComparer(const A, B: TPoint): TData;
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
procedure Update(var A: TData; B: TData);
begin
	if A < B then A := B;
end;
function GetMaxArea(W, H: TData): TData;
var
	i, j: TIndex;
	Left, Right: TData;
	Max: TData;
begin
	if N = 0 then
	begin
		Result := W * H;
		Exit;
	end;
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
	Result := Max;
end;
procedure Main;
var
	i, j: TIndex;
	One, Two, Max: TData;
begin
	Readln(W, H, M);
	for i := 1 to M do
		Readln(Q[i].x, Q[i].y);

	Max := 0;
	for i := 1 to M do
	begin
		//X Axis
		N := 0;
		for j := 1 to M do
			if Q[j].x < Q[i].x then
			begin
				Inc(N);
				P[N].x := Q[j].x;
				P[N].y := Q[j].y;
			end;
		One := GetMaxArea(Q[i].x, H);
		N := 0;
		for j := 1 to M do
			if Q[j].x > Q[i].x then
			begin
				Inc(N);
				P[N].x := Q[j].x - Q[i].x;
				P[N].y := Q[j].y;
			end;
		Two := GetMaxArea(W - Q[i].x, H);
		Update(Max, One + Two);

		//Y Axis
		N := 0;
		for j := 1 to M do
			if Q[j].y < Q[i].y then
			begin
				Inc(N);
				P[N].x := Q[j].x;
				P[N].y := Q[j].y;
			end;
		One := GetMaxArea(W, Q[i].y);
		N := 0;
		for j := 1 to M do
			if Q[j].y > Q[i].y then
			begin
				Inc(N);
				P[N].x := Q[j].x;
				P[N].y := Q[j].y - Q[i].y;
			end;
		Two := GetMaxArea(W, H - Q[i].y);
		Update(Max, One + Two);
	end;
	
	Writeln(Max: 0: 2);
end;
begin
	Main;
end.