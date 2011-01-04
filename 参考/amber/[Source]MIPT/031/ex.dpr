(*
	Problem: MIPT 031 Minimal sum of distances
	Author: Amber
	Method: Randomize
	Date: 2006-9-20
*)
program MIPT_031(Input, Output);
const
	MaxN = 100;
	Range = 15;
	Precision = 1E-4;
	TimesLimit = 10;
type
	TIndex = Longint;
	TData = Extended;
	TPoint = record
		x, y, f: TData;
	end;
	TPointSet = array [1..MaxN] of TPoint;
var
	N: TIndex;
	P: TPointSet;
	Q: TPoint;

function GetDistance(const A, B: TPoint): TData;
begin
	Result := Sqrt(Sqr(A.x - B.x) + Sqr(A.y - B.y));
end;
function CreatePoint(x, y: TData): TPoint;
var
	i: TIndex;
begin
	Result.x := x;
	Result.y := y;
	Result.f := 0;
	for i := 1 to N do
		Result.f := Result.f + GetDistance(P[i], Result) * P[i].f;
end;
procedure Main;
var
	i: TIndex;
	T: TPoint;
	Alpha: TData;
	Len: TData;
	Times: TIndex;
begin
	Readln(N);
	for i := 1 to N do
		with P[i] do
			Readln(x, y, f);
	
	Q := CreatePoint(Random * Range * 2 - Range, Random * Range * 2 - Range);
	Len := Range;
	while Len > Precision do
	begin
		Times := 0;
		repeat
			Alpha := Random * Pi * 2;
			T := CreatePoint(Q.x + Cos(Alpha) * Len, Q.y + Sin(Alpha) * Len);
			if T.f < Q.f then
				Q := T
			else
				Inc(Times);
		until Times > TimesLimit;
		Len := Len * 0.5;
	end;
	Writeln(Q.x: 0: 2, ' ', Q.y: 0: 2);
end;
begin
	Main;
end.