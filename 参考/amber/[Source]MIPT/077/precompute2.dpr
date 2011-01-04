(*
	Problem: MIPT 077 Queens
	Author: Amber
	Method: DFS with bitwise operator
	Date: 2006-9-20
*)
program MIPT_077(Input, Output);
type
	TIndex = Longint;
var
	N: TIndex;
	Count: TIndex;
procedure DFS(Depth: TIndex; Unused, Left, Right: TIndex);
var
	Can, Cur: TIndex;
begin
	if Depth = N + 1 then
	begin
		Inc(Count);
		Exit;
	end;
	Can := Unused and not Left and not Right;
	while Can > 0 do
	begin
		Cur := Can and (-Can);
		DFS(Depth + 1, Unused xor Cur, (Left xor Cur) shl 1, (Right xor Cur) shr 1);
		Can := Can xor Cur;
	end;
end;
procedure Main;
begin
	Readln(N);
	Count := 0;
	DFS(1, 1 shl N - 1, 0, 0);
	Writeln(Count);
end;
begin
	Main;
end.