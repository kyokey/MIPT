(*
	Problem: MIPT 077 Queens
	Author: Amber
	Method: DFS(N Queens)
	Date: 2005-11-28
*)
program MIPT_077(Input,Output);
const
	MaxN=15;
type
	TIndex=Longint;
var
	N:TIndex;
	FY:array[1..MaxN]of Boolean;
	FD:array[2..MaxN*2]of Boolean;
	FE:array[-MaxN+1..MaxN-1]of Boolean;
	Count:TIndex;

procedure DFS(Depth:TIndex);
var
	i:TIndex;
begin
	if Depth=N+1 then
	begin
		Inc(Count);
		Exit;
	end;
	for i:=1 to N do
		if not FY[i] and not FD[Depth+i] and not FE[Depth-i] then
		begin
			FY[i]:=true;
			FD[Depth+i]:=true;
			FE[Depth-i]:=true;
			DFS(Depth+1);
			FY[i]:=false;
			FD[Depth+i]:=false;
			FE[Depth-i]:=false;
		end;
end;
procedure Main;
begin
	Readln(N);
	FillChar(FY,SizeOf(FY),0);
	FillChar(FD,SizeOf(FD),0);
	FillChar(FE,SizeOf(FE),0);
	Count:=0;
	DFS(1);
	Writeln(Count);
end;
begin
	while not eof do
		Main;
end.