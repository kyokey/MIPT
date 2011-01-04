(*
	Problem: MIPT 011 Brackets II
	Author: Amber
	Method: Stack
	Date: 2005-11-28
*)
program MIPT_011(Input,Output);
const
	MaxN=100000;
type
	TIndex=Longint;
	TStack=array[1..MaxN]of Char;
var
	Top:TIndex;
	Stack:TStack;
procedure Main;
label 
	Error;
var
	Ch:Char;
begin
	Top:=0;
	while not Eoln do
	begin
		Read(Ch);
		case Ch of
			'(','[','{','<':
			begin
				Inc(Top);
				Stack[Top]:=Ch;
			end;
			')',']','}','>':
			begin
				if Top=0 then goto Error;
				case Ch of
					')':if Stack[Top]<>'(' then goto Error;
					']':if Stack[Top]<>'[' then goto Error;
					'}':if Stack[Top]<>'{' then goto Error;
					'>':if Stack[Top]<>'<' then goto Error;
				end;
				Dec(Top);
			end;
		end;
	end;
	if Top>0 then goto Error;
	Writeln('YES');
	Exit;
	Error:
	Writeln('NO');
end;
begin
	Main;
end.