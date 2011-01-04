(*
	Problem: MIPT 071 Cables
	Author: Amber
	Method: Binary Search
	Date: 2006-9-29
	Notice: If no solution, we should print 0.
*)
program MIPT_071(Input, Output);
const
	MaxN = 10000;
type
	TIndex = Longint;
	TCable = array [1..MaxN] of TIndex;
var
	N, K: TIndex;
	C: TCable;

function Calculate(Len: TIndex): TIndex;
var
	i: TIndex;
begin
	Result := 0;
	for i := 1 to N do
	begin
		Inc(Result, C[i] div Len);
		if Result >= K then Break;
	end;
end;
procedure Main;
var
	i: TIndex;
	Left, Right, Mid: TIndex;
begin
	Read(N, K);
	Left := 1;
	Right := 0;
	for i := 1 to N do
	begin
		Read(C[i]);
		if Right < C[i] then Right := C[i];
	end;
	while Left < Right do
	begin
		Mid := (Left + Right + 1) div 2;
		if Calculate(Mid) >= K then
			Left := Mid
		else
			Right := Mid - 1;
	end;
	if Calculate(Left) >= K then
		Writeln(Left)
	else
		Writeln(0);
end;
begin
	Main;
end.