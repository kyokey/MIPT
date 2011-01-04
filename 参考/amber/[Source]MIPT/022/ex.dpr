(*
	Problem: MIPT 022 Regular expression
	Author: Amber
	Method: DP
	Complexity: O(NM)
	Date: 2006-9-30
*)
program MIPT_022(Input, Output);
const
	MaxSize = 1000;
type
	TIndex = Longint;
	TString = AnsiString;
	TDP = array [Boolean, 0..MaxSize] of TIndex;
var
	N, M: TIndex;
	A, B: TString;
	F: TDP;

procedure Main;
var
	i, j: TIndex;
	Cur: Boolean;
begin
	Readln(A);
	Readln(B);
	N := Length(A);
	M := Length(B);

	Cur := false;
	FillChar(F[Cur], SizeOf(F[Cur]), 0);
	F[Cur, 0] := 1;
	for i := 1 to M do
		if B[i] = '*' then
			F[Cur, i] := 1
		else
			Break;

	for i := 1 to N do
	begin
		Cur := not Cur;
		FillChar(F[Cur], SizeOf(F[Cur]), 0);
		F[Cur, 0] := 0;
		for j := 1 to M do
			if B[j] = '*' then
				F[Cur, j] := F[not Cur, j] + F[Cur, j - 1]
			else if A[i] = B[j] then
				F[Cur, j] := F[not Cur, j - 1];
	end;

	Writeln(F[Cur, M]);
end;
begin
	Main;
end.