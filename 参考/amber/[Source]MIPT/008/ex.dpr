(*
	Problem: MIPT 008 Brackets
	Author: Amber
	Method: Stack
	Date: 2005-11-28
*)
program MIPT_008(Input, Output);
type
	TIndex = Longint;

procedure Main;
var
	Stack: TIndex;
	Ch: Char;
begin
	Stack := 0;
	while not Eoln do
	begin
		Read(Ch);
		if Ch = '(' then
			Inc(Stack)
		else if Ch = ')' then
		begin
			Dec(Stack);
			if Stack < 0 then
			begin
				Writeln('NO');
				Exit;
			end;
		end;
	end;
	if Stack <> 0 then
	begin
		Writeln('NO');
		Exit;
	end;
	Writeln('YES');
end;
begin
	Main;
end.
