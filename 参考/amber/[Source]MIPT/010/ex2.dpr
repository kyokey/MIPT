(*
	Problem: MIPT 010 New Year congratulations
	Author: Amber
	Method:
		Forward Star(Radix Sort)
		+Hungary-DFS
		+Unmatch First optimization
	Date: 2005-12-13
*)
program MIPT_010(Input,Output);
const
	MaxN=32000;
	MaxM=32000;
	MaxE=32000;
type
	TIndex=Longint;
	TEdge=record
		u,v:TIndex;
	end;
	TLink=array[1..MaxM]of TIndex;
	TCover=array[1..MaxM]of Boolean;
	TEdgeSet=array[1..MaxE]of TEdge;
	TEdgeFlag=array[0..MaxN]of TIndex;
	TCount=array[1..MaxN]of TIndex;
var
	N,M,E:TIndex;
	Link:TLink;
	Cover:TCover;
	Edge,TmpEdge:TEdgeSet;
	H:TEdgeFlag;
	Count:TCount;

function FindPath(u:TIndex):Boolean;
var
	i,p:TIndex;
	v,w:TIndex;
begin
	FindPath:=true;
	for p:=0 to 1 do
		for i:=H[u-1]+1 to H[u] do
		begin
			v:=Edge[i].v;
			if ((Link[v]+p=0) xor (Link[v]*p>0)) and not Cover[v] then 
			//Unmatch First optimization
			begin
				w:=Link[v];
				Link[v]:=u;
				Cover[v]:=true;
				if (w=0) or FindPath(w) then Exit;
				Link[v]:=w;
			end;
		end;
	FindPath:=false;
end;

procedure Main;
var
	i:TIndex;
	Total:TIndex;
begin
	Readln(N,M,E);
	FillChar(Count,SizeOf(Count),0);
	for i:=1 to E do
	begin
		Readln(TmpEdge[i].u,TmpEdge[i].v);
		Inc(Count[TmpEdge[i].u]);
	end;
	H[0]:=0;
	for i:=1 to N do
	begin
		H[i]:=Count[i];
		Inc(H[i],H[i-1]);
	end;
	FillChar(Count,SizeOf(Count),0);
	for i:=1 to E do
	begin
		Edge[H[TmpEdge[i].u-1]+Count[TmpEdge[i].u]+1]:=TmpEdge[i];
		Inc(Count[TmpEdge[i].u]);
	end;
	FillChar(Link,SizeOf(Link),0);
	Total:=0;
	for i:=1 to N do
	begin
		FillChar(Cover,SizeOf(Cover),0);
		if FindPath(i) then Inc(Total);
	end;
	Writeln(Total);
	for i:=1 to M do
		if Link[i]>0 then
			Writeln(Link[i],' ',i);
end;
begin
	Main;
end.