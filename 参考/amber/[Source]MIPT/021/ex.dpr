(*
	Problem: MIPT 021 Fraction
	Author: Amber
	Method: Simulate
	Date: 2006-9-28
*)
program MIPT_021(Input, Output);
const
	MaxLen = 50;
type
	TIndex = Longint;
	TStack = array [1..MaxLen] of TIndex;
	TMatchedBracket = array [1..MaxLen] of TIndex;
	TSize = record
		Width, Height: TIndex;
	end;
var
	Expr: String;
	Next: TMatchedBracket;
	Top: TIndex;
	Stack: TStack;

function Max(const A, B: TIndex): TIndex;
begin
	if A > B then
		Result := A
	else
		Result := B;
end;
function GetSize(Left, Right: TIndex): TSize;
var
	i: TIndex;
	UpSize, DownSize: TSize;
	Up, Down, Len: TIndex;
begin
	Up := 0;
	Down := 0;
	Len := 0;
	i := Left;
	while i <= Right do
	begin
		if Expr[i] = '{' then
		begin
			UpSize := GetSize(i + 1, Next[i] - 1);
			i := Next[i] + 2;
			DownSize := GetSize(i + 1, Next[i] - 1);
			i := Next[i];
			Inc(Len, Max(UpSize.Width, DownSize.Width) + 2);
			Up := Max(Up, UpSize.Height);
			Down := Max(Down, DownSize.Height);
		end
		else
			Inc(Len);
		Inc(i);
	end;
	Result.Width := Len;
	Result.Height := Up + Down + 1;
end;
procedure Main;
var
	i: TIndex;
	Cur: TSize;
begin
	Readln(Expr);
	Top := 0;
	for i := 1 to Length(Expr) do
		if Expr[i] = '{' then
		begin
			Inc(Top);
			Stack[Top] := i;
		end
		else if Expr[i] = '}' then
		begin
			Next[Stack[Top]] := i;
			Dec(Top);
		end;
	Cur := GetSize(1, Length(Expr));
	Writeln(Cur.Width, ' ', Cur.Height);
end;
begin
	Main;
end.