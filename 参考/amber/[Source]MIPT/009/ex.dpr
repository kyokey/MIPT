(*
	Problem: MIPT 009 Fibonacci numbers
	Author: Amber
	Method: Simulate + HP
	Date: 2005-11-28
*)
program MIPT_009(Input, Output);
const
	MaxLen = 250;
type
	TIndex = Longint;
	THP = record
		Len: TIndex;
		D: array [1..MaxLen] of TIndex;
	end;
var
	N: TIndex;

function Add(const A, B: THP): THP;
var
	i: TIndex;
begin
	FillChar(Result, SizeOf(Result), 0);
	if A.Len > B.Len then
		Result.Len := A.Len
	else
		Result.Len := B.Len;
	for i := 1 to Result.Len do
	begin
		Inc(Result.D[i], A.D[i] + B.D[i]);
		Inc(Result.D[i + 1], Result.D[i] div 10);
		Result.D[i] := Result.D[i] mod 10;
	end;
	Inc(Result.Len);
	while (Result.D[Result.Len] = 0) and (Result.Len > 1) do
		Dec(Result.Len);
end;

procedure SetNumber(var A: THP; B: TIndex);
begin
	FillChar(A, SizeOf(A), 0);
	A.Len := 1;
	A.D[1] := B;
end;

procedure Main;
var
	i: TIndex;
	F1, F2, F3: THP;
begin
	Readln(N);
	if N = 0 then
	begin
		Writeln(0);
		Exit;
	end;
	SetNumber(F1, 1);
	SetNumber(F2, 1);
	for i := 2 to N do
	begin
		F3 := Add(F1, F2);
		F1 := F2;
		F2 := F3;
	end;
	for i := F2.Len downto 1 do
		Write(F2.D[i]);
	Writeln;
end;
begin
	Main;
end.
