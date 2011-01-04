(*
	Problem: MIPT 005 Random descending a tree
	Author: Amber
	Method: Stack and Count
	Date: 2005-11-28
*)
program MIPT_005(Input,Output);
type
	TIndex=Longint;
	TData=Extended;
var
	Stack:TIndex;
	Answer:TData;
procedure Main;
var
	Ch:Char;
	X:TIndex;
	Code:Integer;
	St:String;
begin
	Stack:=0;
	St:='';
	Answer:=0;
	while not Eoln do
	begin
		Read(Ch);
		if Ch in ['0'..'9','-'] then
			St:=St+Ch
		else 
		begin
			if St<>'' then
			begin
				Val(St,X,Code);
				Answer:=Answer+X/(1 shl Stack);
				St:='';
			end;
			if Ch='(' then Inc(Stack)
			else if Ch=')' then Dec(Stack);
		end;
	end;
	Writeln(Answer:0:2);
end;
begin
	Main;
end.
