(*
	Problem: MIPT 064 Max product
	Author: Amber
	Method: Enumerate in few cases
	Date: 2006-9-20
*)
program MIPT_064(Input, Output);
const
	Infinity = 30001;
type
	TIndex = Longint;
	TData = Int64;
var
	N: TIndex;

procedure Main;
var
	i: TIndex;
	HasZero: Boolean;
	Min1, Min2, Max1, Max2, Max3: TData;
	Cur: TData;
	Plan1, Plan2, Plan3: TData;
begin
	Readln(N);
	HasZero := false;
	Max1 := -Infinity;
	Max2 := -Infinity;
	Max3 := -Infinity;
	Min1 := Infinity;
	Min2 := Infinity;
	for i := 1 to N do
	begin
		Read(Cur);
		if Cur = 0 then HasZero := true;
		if Cur > Max1 then
		begin
			Max3 := Max2;
			Max2 := Max1;
			Max1 := Cur;
		end
		else if Cur > Max2 then
		begin
			Max3 := Max2;
			Max2 := Cur;
		end
		else if Cur > Max3 then
			Max3 := Cur;
		if Cur < Min1 then
		begin
			Min2 := Min1;
			Min1 := Cur;
		end
		else if Cur < Min2 then
			Min2 := Cur;
	end;
	Cur := Min1 * Min2 * Max1;
	Plan1 := Min1;
	Plan2 := Min2;
	Plan3 := Max1;
	if Cur < Max1 * Max2 * Max3 then
	begin
		Cur := Max1 * Max2 * Max3;
		Plan1 := Max1;
		Plan2 := Max2;
		Plan3 := Max3;
	end;
	if HasZero and (Cur < 0) then
	begin
		Cur := 0;
		Plan1 := 0;
		Plan2 := Max1;
		Plan3 := Max2;
	end;
	Writeln(Plan1, ' ', Plan2, ' ', Plan3);
end;
begin
	Main;
end.
