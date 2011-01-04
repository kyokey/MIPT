(*
	Problem: MIPT 203 Lucky tickets
	Author: Amber
	Method: Maths (Principles for including or excluding)
	Complexity: O(N^2B)
	Date: 2006-9-29
*)
program MIPT_203(Input, Output);
const
	UnitDigit = 4;
	UnitSize = 10000;
	MaxLen = 500 div UnitDigit;
type
	TIndex = Longint;
	TData = Longint;
	THP = record
		Len: TIndex;
		D: array [1..MaxLen] of TData;
	end;

procedure PrintHP(const A: THP);
var
	i, j: TIndex;
	St: String[UnitDigit];
begin
	Write(A.D[A.Len]);
	for i := A.Len - 1 downto 1 do
	begin
		Str(A.D[i]: UnitDigit, St);
		for j := 1 to UnitDigit do
			if St[j] = ' ' then
				Write('0')
			else
				Write(St[j]);
	end;
	Writeln;
end;
procedure AssignValue(var A: THP; const B: TData; Offset: TIndex = 1); //B < UnitSize
begin
	FillChar(A, SizeOf(A), 0);
	A.Len := Offset;
	A.D[Offset] := B;
end;
procedure Trim(var A: THP);
begin
	while (A.Len > 1) and (A.D[A.Len] = 0) do Dec(A.Len);
end;
procedure AssignAdd(var A: THP; const B: THP); overload;
var
	i: TIndex;
	Overflow: TData;
begin
	Overflow := 0;
	i := 1;
	while (i <= B.Len) or (Overflow > 0) do
	begin
		if i <= A.Len then Inc(Overflow, A.D[i]);
		if i <= B.Len then Inc(Overflow, B.D[i]);
		if Overflow >= UnitSize then
		begin
			A.D[i] := Overflow - UnitSize;
			Overflow := 1;
		end
		else
		begin
			A.D[i] := Overflow;
			Overflow := 0;
		end;
		Inc(i);
	end;
	if A.Len < i - 1 then A.Len := i - 1;
	Trim(A);
end;
procedure AssignSubtract(var A: THP; const B: THP); overload;
var
	i: TIndex;
	Overflow: TData;
begin
	Overflow := 0;
	i := 1;
	while (i <= B.Len) or (Overflow < 0) do
	begin
		if i <= A.Len then Inc(Overflow, A.D[i]);
		if i <= B.Len then Dec(Overflow, B.D[i]);
		if Overflow < 0 then
		begin
			A.D[i] := Overflow + UnitSize;
			Overflow := -1;
		end
		else
		begin
			A.D[i] := Overflow;
			Overflow := 0;
		end;
		Inc(i);
	end;
	Trim(A);
end;
procedure AssignMultiply(var A: THP; const B: TData); overload;
var
	i: TIndex;
	Overflow: TData;
begin
	Overflow := 0;
	i := 1;
	while (i <= A.Len) or (Overflow > 0) do
	begin
		if i <= A.Len then Inc(Overflow, A.D[i] * B);
		A.D[i] := Overflow mod UnitSize;
		Overflow := Overflow div UnitSize;
		Inc(i);
	end;
	A.Len := i - 1;
	Trim(A);
end;
function Multiply(const A: THP; const B: THP): THP; overload;
var
	i, j: TIndex;
begin
	FillChar(Result, SizeOf(Result), 0);
	for i := 1 to A.Len do
		for j := 1 to B.Len do
		begin
			Inc(Result.D[i + j - 1], A.D[i] * B.D[j]);
			Inc(Result.D[i + j], Result.D[i + j - 1] div UnitSize);
			Result.D[i + j - 1] := Result.D[i + j - 1] mod UnitSize;
		end;
	Result.Len := A.Len + B.Len;
	Trim(Result);
end;
procedure AssignDivide(var A: THP; const B: TData); overload;
var
	i: TIndex;
	Remain: TData;
begin
	Remain := 0;
	for i := A.Len downto 1 do
	begin
		Remain := Remain * UnitSize + A.D[i];
		A.D[i] := Remain div B;
		Remain := Remain mod B;
	end;
	Trim(A);
end;

const
	MaxN = 200;
type
	TMemoried = array [0..MaxN] of THP;
var
	N, B: TIndex;
	Coeff, Binomial: TMemoried;
	Cur, Ans: THP;
procedure Main;
var
	S, R: TIndex;
begin
	Readln(N, B);
	AssignValue(Binomial[0], 1);
	for R := 1 to N do
	begin
		Binomial[R] := Binomial[R - 1];
		AssignMultiply(Binomial[R], N - R + 1);
		AssignDivide(Binomial[R], R);
	end;

	AssignValue(Ans, 0);
	for S := 0 to N * (B - 1) do
	begin
		AssignValue(Cur, 0);
		for R := 0 to N do
		begin
			if S - B * R < 0 then Break;
			if S - B * R = 0 then
				Coeff[R] := Binomial[R]
			else
			begin
				AssignMultiply(Coeff[R], S + N - 1 - B * R);
				AssignDivide(Coeff[R], S - B * R);
			end;
		end;
		AssignValue(Cur, 0);
		for R := 0 to N do
		begin
			if S - B * R < 0 then Break;
			if not Odd(R) then AssignAdd(Cur, Coeff[R]);
		end;
		for R := 0 to N do
		begin
			if S - B * R < 0 then Break;
			if Odd(R) then AssignSubtract(Cur, Coeff[R]);
		end;
		AssignAdd(Ans, Multiply(Cur, Cur));
	end;
	PrintHP(Ans);
end;
begin
	Main;
end.