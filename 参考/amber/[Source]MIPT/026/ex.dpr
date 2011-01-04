(*
	Problem: MIPT 026 Operations
	Author: Amber
	Method: BFS
	Date: 2005-11-28
*)
program MIPT_026(Input,Output);
const
	MaxQueueSize=1000;
	MaxHashSize=997;
type
	TIndex=Longint;
	TQueue=array[0..MaxQueueSize-1]of record
		Number,Times:TIndex;
	end;
	THash=array[0..MaxHashSize-1]of TIndex;
var
	Queue:TQueue;
	Hash:THash;
function FindHash(X:TIndex;Overwrite:Boolean):Boolean;
var
	i:TIndex;
begin
	i:=X mod MaxHashSize;
	while (Hash[i]>-1) and (Hash[i]<>X) do
	begin
		Inc(i);
		if i=MaxHashSize then i:=0;
	end;
	Result:=(Hash[i]=X);
	if Overwrite then Hash[i]:=X;
end;
procedure BFS(X:TIndex);
var
	Pop,Push:TIndex;
	i:TIndex;
	Tmp:TIndex;
begin
	Pop:=1;
	Push:=2;
	FillChar(Hash,SizeOf(Hash),255);
	FindHash(X,true);
	Queue[1].Number:=X;
	Queue[1].Times:=0;
	while Pop<Push do
	begin
		for i:=1 to 3 do
		begin
			if (i=3) and Odd(Queue[Pop].Number) then Continue;
			case i of 
				1:Tmp:=Queue[Pop].Number-1;
				2:Tmp:=Queue[Pop].Number+1;
				3:Tmp:=Queue[Pop].Number div 2;
			end;
			if not FindHash(Tmp,true) then
			begin
				if Tmp=0 then 
				begin
					Writeln(Queue[Pop].Times+1);
					Exit;
				end;
				Queue[Push].Number:=Tmp;
				Queue[Push].Times:=Queue[Pop].Times+1;
				Inc(Push);
				if Push=MaxQueueSize then Push:=0;
			end;
		end;
		Inc(Pop);
		if Pop=MaxQueueSize then Pop:=0;
	end;
end;
procedure Main;
var
	N:TIndex;
begin
	Readln(N);
	if N=0 then 
	begin
		Writeln(0);
		Exit;
	end;
	BFS(N);
end;
begin
	Main;
end.